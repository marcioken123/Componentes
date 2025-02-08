unit ElOneInst;

{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

ElOneInst unit
--------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

{
todo:
  CLR:
    - InitializeSecurityDescriptor  for WinNT.
}

{ Application single instance monitor }

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Forms,
  LMDTypes,
  LMDSysIn,
  Types,
  ElBaseComp;

Type

  TInstanceRunEvent = procedure(Sender : TObject; Parameters : TStrings) of object;

  PElMemMapArr = ^TElMemMapArr;
  TElMemMapArr = record
    hPrevInst,
    hPrevAppWin,
    hPrevMainWin,
    hMonWin       : THandle;
  end;

  TExistsEvent = procedure(Sender : TObject;
    hPrevInst : THandle; hPrevAppWin, hPrevMainWin : HWND; var Switch: Boolean) of object;

  TElOneInstance = class(TElBaseComponent)
  private
    FMapHandle,
    FPrevInst,
    FPrevAppWin,
    FPrevMainWin : THandle;
    (* // ??? used in CreateMapping only, moved there
    FView        : PElMemMapArr;
    //*)
    FMapName     : String;
    FNoAutoTerminate : boolean;
    FOnExists : TExistsEvent;
    FOnInstanceRun : TInstanceRunEvent;
    procedure WMCopyData(var Msg : TMessage); message WM_COPYDATA;
  protected
    { Protected declarations }
    procedure TriggerExistsEvent(hPrevInst, hPrevAppWin, hPrevMainWin : THandle; var Switch : boolean); virtual;
    procedure TriggerInstanceRunEvent(Parameters : TStrings); virtual;
    procedure SetEnabled(AEnabled : boolean); override;
    procedure DoSetEnabled(AEnabled : boolean); override;
    procedure CreateMapping;
  public
    { Public declarations }
    destructor Destroy; override;
    property PrevInstance : THandle read FPrevInst;
    property FPrevMainWindow : THandle read FPrevMainWin;
    property FPrevAppWindow : THandle read FPrevAppWin;
  published
    property MapName : string read FMapName write FMapName;
    property NoAutoTerminate : boolean read FNoAutoTerminate write FNoAutoTerminate;
    property OnExists : TExistsEvent read FOnExists write FOnExists;
    property OnInstanceRun : TInstanceRunEvent read FOnInstanceRun write FOnInstanceRun;
    property Enabled;
  end; { TElOneInstance }

var

  rs_OneInstAlreadyExists : string;

implementation

procedure TElOneInstance.TriggerExistsEvent(hPrevInst, hPrevAppWin, hPrevMainWin : THandle; var Switch : boolean);
begin
  if (Assigned(FOnExists)) then
    FOnExists(Self, hPrevInst, hPrevAppWin, hPrevMainWin, Switch);
end; { TriggerExistsEvent }

procedure TElOneInstance.WMCopyData(var Msg: TMessage); { private }
var
  ds : PCOPYDATASTRUCT;
  ParamsList : TStringList;
  Params : string;
begin
  with Msg do
  begin
    ds := PCOPYDATASTRUCT(LParam);
    params := StrPas(PChar(ds.lpData));
    ParamsList := TStringList.Create;
    ParamsList.Text := params;
    TriggerInstanceRunEvent(ParamsList);
    ParamsList.Free;
    Result := 1458;
  end; { with }
end; { WMCopyData }

procedure TElOneInstance.TriggerInstanceRunEvent(Parameters : TStrings);
begin
  if (assigned(FOnInstanceRun)) then
    FOnInstanceRun(Self, Parameters);
end; { TriggerInstanceRunEvent }

procedure TElOneInstance.SetEnabled(AEnabled : boolean);
begin
  if (FMapName = '') and AEnabled then
    raise Exception.Create('Memory mapping name should be specified to enable Instance Counter.');
  inherited;
end;

procedure TElOneInstance.DoSetEnabled(AEnabled : boolean);
begin
  inherited;
  if AEnabled then
    CreateMapping
  else
  if FMapHandle <> INVALID_HANDLE_VALUE then
  begin
    CloseHandle(FMapHandle);
    FMapHandle := INVALID_HANDLE_VALUE;
  end;
end;

procedure TElOneInstance.CreateMapping;

var
  b, s : boolean;
  ds : TCOPYDATASTRUCT;
  ParamsList : TStringList;
  i : integer;
  Params : string;
  ParentForm : TComponent;
  SA : TSECURITYATTRIBUTES;
 pSD : TSECURITYDESCRIPTOR;
 FView: PElMemMapArr;

begin
  //FView := nil;
  if not (csDesigning in ComponentState) then
  begin
    if LMDSIWindowsNT then
    begin
      if not InitializeSecurityDescriptor(@pSD, SECURITY_DESCRIPTOR_REVISION) then
         raise Exception.Create('Failed to initialize ElOneInstance object');
      if not SetSecurityDescriptorDacl(@pSD, true, nil, false) then
         raise Exception.Create('Failed to initialize ElOneInstance object');
      SA.nLength := sizeof(SA);
      SA.lpSecurityDescriptor := @pSD;
      SA.bInheritHandle := true;
      FMapHandle := CreateFileMapping($FFFFFFFF, @SA, PAGE_READWRITE, 0, sizeof(TElMemMapArr), PChar(FMapName));
    end else
    begin
      FMapHandle := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, sizeof(TElMemMapArr), PChar(FMapName));
    end;
    if FMapHandle <> 0 then
    begin
      b := GetLastError = ERROR_ALREADY_EXISTS;
      FView := nil;
      try
        FView := MapViewOfFile(FMapHandle, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(TElMemMapArr));
        if FView = nil then
           raise Exception.Create('Failed to initialize ElOneInstance object');
        if b then
        begin
          s := false;
          TriggerExistsEvent(FView.HPrevInst, FView.hPrevAppWin, FView.hPrevMainWin, s);
          FPrevInst := FView.HPrevInst;
          FPrevMainWin := FView.hPrevMainWin;
          FPrevAppWin := FView.hPrevAppWin;
          if s then
          begin
            ParamsList := TStringList.Create;
            for i := 0 to ParamCount do
              ParamsList.Add(ParamStr(i));
            Params := ParamsList.Text;
            ParamsList.Free;
            ds.dwData := 0;
            ds.cbData := (length(params) + 1) * SizeOf(Char);
            ds.lpData := PChar(Params);
            SendMessage(FView.hMonWin, WM_COPYDATA, Handle, TLMDPtrInt(@ds));
            if not Assigned(FOnInstanceRun) then
              if (FView.hPrevMainWin <> 0) and (IsWindowEnabled(FView.hPrevMainWin)) then
                SetForegroundWindow(FView.hPrevMainWin)
              else
                SetForegroundWindow(FView.hPrevAppWin);
          end;
          if NoAutoTerminate then
          begin
            UnmapViewOfFile(FView);
            FView := nil;
            CloseHandle(FMapHandle);
            FMapHandle := INVALID_HANDLE_VALUE;
            raise EBaseEnabledFailed.Create(rs_OneInstAlreadyExists);
          end
          else
          begin
            Application.Terminate;
          end;
        end
        else
        begin
          FView.hPrevInst := HInstance;
          FView.hPrevAppWin := Application.Handle;
          if Application.MainForm <> nil then
            FView.hPrevMainWin := Application.MainForm.Handle
          else
          begin
            ParentForm := self;
            while not (ParentForm is TCustomForm) and (ParentForm.Owner <> nil) do
              ParentForm := ParentForm.Owner;
            if ParentForm = Self then ParentForm := nil;
            if ParentForm <> nil then
              FView.hPrevMainWin := TCustomForm(ParentForm).Handle
            else
              FView.hPrevMainWin := 0;
          end;
          FView.hMonWin := Handle;
        end;
      finally
        if Assigned(FView) then
           UnmapViewOfFile(FView);
      end;
    end
    else
      raise Exception.Create('Failed to initialize ElOneInstance object');
  end;
end;

destructor TElOneInstance.Destroy;
begin
  if FMapHandle <> INVALID_HANDLE_VALUE then
    CloseHandle(FMapHandle);
  FMapHandle := INVALID_HANDLE_VALUE;
  inherited;
end; { Destroy }

initialization
  rs_OneInstAlreadyExists := 'Another instance of the application is started';
end.
