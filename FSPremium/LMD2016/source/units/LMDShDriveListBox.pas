unit LMDShDriveListBox;
{$I LMDCmps.inc}

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

LMDShDriveListBox unit (DS)
------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls, StdCtrls, Graphics,
  LMDShBase, intfLMDBase, LMDTypes;

type
  TLMDShellDriveType = (dtsUnknown, dtsNoRoot, dtsRemovable, dtsFixed, dtsNetwork, dtsCDROM, dtsRAM);
  TLMDShellDriveTypes=set of TLMDShellDriveType;

  { ************************* TLMDShellDriveListBox ****************************** }
  TLMDShellDriveListBox = class(TCustomListBox, ILMDComponent)
  private
    FAbout:TLMDAboutVar;
    FDrive : Char;
    FDriveTypes:TLMDShellDriveTypes;
    CDROMBMP:TBitmap;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetDrive(NewDrive: Char);
    procedure SetDriveTypes(aValue:TLMDShellDriveTypes);
    function GetDriveTypeLMD(Index:Integer):TLMDShellDriveType;
    procedure ReadBitmaps;
    procedure ResetItemHeight;
  protected
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure Click; override;
    procedure BuildList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;
    property Text;
    property Drive: Char read FDrive write SetDrive;
    property DriveType[index:Integer]:TLMDShellDriveType read GetDriveTypeLMD;
  published
    property About:TLMDAboutVar read FAbout write FAbout stored false;
    property ShowDriveType:TLMDShellDriveTypes read FDriveTypes write SetDriveTypes default [dtsRemovable, dtsFixed, dtsNetwork, dtsCDROM, dtsRAM];

    property Align;
    property Anchors;
    property BorderStyle;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property IntegralHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabStop default True;
    property TabOrder;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  ShellApi,  SysUtils,
  LMDShMisc, LMDShPIDL, LMDProcs;

{--------------------------- Public -------------------------------------------}
constructor TLMDShellDriveListBox.Create(AOwner: TComponent);
var
  Temp: AnsiString; // ShortString;
begin
  inherited Create(AOwner);
  Style := lbOwnerDrawFixed;
  FDriveTypes:=[dtsRemovable, dtsFixed, dtsNetwork, dtsCDROM, dtsRAM];
  ReadBitmaps;
  //ResetItemHeight;
  GetDir(0, Temp);
  FDrive := Char(Temp[1]); { make default drive selected }
  if FDrive = '\' then FDrive := #0;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellDriveListBox.Destroy;
begin
  FreeAndNil(CDROMBMP);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.BuildList;
type
  TDriveBits = set of 0..25;
var
  DriveNum: Integer;
  drive: Char;
  sDriveType: TLMDShellDriveType;
  DriveBits: TDriveBits;

  function getVolumeID: string;
  var
    OldErrorMode: Integer;
    NotUsed, VolFlags: Cardinal;

    Buf: array [0..MAX_PATH] of Char;

  begin
    OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    try

      if GetVolumeInformation(PChar(drive + ':\'), Buf, sizeof(Buf),
        nil, NotUsed, VolFlags, nil, 0) then
        SetString(Result, Buf, StrLen(Buf))

      else
        Result := '';
      if drive < 'a' then
        result := AnsiUpperCaseFileName(Result)
      else
        result := AnsiLowerCaseFileName(Result);
      result := Format('[%s]',[Result]);
    finally
      SetErrorMode(OldErrorMode);
    end;
  end;

  function getNetworkVolume: string;
  var
    Buffer    : array [0..MAX_PATH] of Char;
    TestDrive : array [0..3] of Char;
    BufferSize: Cardinal;
  begin
    BufferSize := sizeof(Buffer);
    TestDrive[0] := UpCase(drive);
    TestDrive[1] := ':';
    TestDrive[2] := #0;
    if WNetGetConnection(TestDrive, Buffer, BufferSize) = WN_SUCCESS then
      begin
        SetString(result, Buffer, BufferSize);
        if drive < 'a' then
          result := AnsiUpperCaseFileName(Result)
        else
          result := AnsiLowerCaseFileName(Result);
      end
    else
      result := getVolumeID;
  end;

  procedure AddDrive(const VolName: string; Obj: TObject);
  begin
    Items.AddObject(Format('%s: %s',[drive, VolName]), Obj);
  end;

begin
  { fill list }
  Clear;

  Integer(DriveBits) := GetLogicalDrives;

  for DriveNum := 0 to 25 do
    begin
      if not (DriveNum in DriveBits) then Continue;
      drive := Char(DriveNum + Ord('a'));
      sDriveType := TLMDShellDriveType(GetDriveType(Int_Ref(drive + ':\')));

      case sDriveType of
        dtsRemovable :
          if dtsRemovable in FDriveTypes then
            Items.AddObject(drive + ':', nil);
        dtsFixed     :
          if dtsFixed in FDriveTypes then
            AddDrive(getVolumeID, nil);
        dtsNetwork   :
          if dtsNetWork in FDriveTypes then
            AddDrive(getNetworkVolume, nil);
        dtsCDROM     :
          if dtsCDROM in FDriveTypes then
            AddDrive(getVolumeID, CDROMBMP);
        dtsRAM       :
          if dtsRAM in FDriveTypes then
            AddDrive(getVolumeID, nil);
      else
        if dtsUnknown in FDriveTypes then
          Items.AddObject(drive + ':', nil);
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.SetDrive(NewDrive: Char);
var
  Item: Integer;
  drv: string;

begin
  if (ItemIndex < 0) or (UpCase(NewDrive) <> UpCase(FDrive)) then
    begin
      if NewDrive = #0 then
        begin
          FDrive := NewDrive;
          ItemIndex := -1;
        end
      else
        begin
            FDrive := Chr(ord(UpCase(NewDrive)) + 32);

          { change selected item }
          for Item := 0 to Items.Count - 1 do
            begin
              drv := Items[Item];
              if (UpCase(drv[1]) = UpCase(FDrive)) and (drv[2] = ':') then
                begin
                  ItemIndex := Item;
                  break;
                end;
            end;

        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.SetDriveTypes(aValue:TLMDShellDriveTypes);
begin
  if FDriveTypes<>aValue then
    begin
       FDriveTypes:=aValue;
       RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellDriveListBox.GetDriveTypeLMD(Index:Integer):TLMDShellDriveType;
begin
  result:=dtsUnknown;
  if Index<Items.Count then
    result:=TLMDShellDriveType(GetDriveType(Int_Ref(Items[Index][1] + ':\')));
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.CreateWnd;
begin
  inherited CreateWnd;
  BuildList;
  SetDrive(FDrive);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.ResetItemHeight;
var
  nuHeight: Integer;

  {------------------------------------------------------------------------------}
  function LMDGetFontHeight(aFont:TFont):Integer;
  var
    Extent:TSize;
    old:HFont;
    DC:HDC;
  begin
    result:=0;
    DC:=GetDC(0);
    try
      old:=SelectObject(DC, aFont.Handle);
      if GetTextExtentPoint(DC, 'W', 1, Extent) then result:=Extent.cY;
      SelectObject(DC, old);
    finally
      ReleaseDC(0, DC);
    end;
  end;

begin
  nuHeight:=LMDGetFontHeight(self.Font)+2;
  //if nuHeight>(CDROMBMP.Height) then nuHeight := CDROMBmp.Height;
  ItemHeight := nuHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  bmpWidth: Integer;
  FileInfo: TSHFileInfo;
  F: UINT;
  S: string;
begin
  if  Index < 0 then  exit;

  bmpWidth := ItemHeight;
  S := Items[Index];

  if bmpWidth < GetSystemMetrics(SM_CXICON) then
    F := SHGFI_ICON or SHGFI_SMALLICON
  else
    F := SHGFI_ICON or SHGFI_LARGEICON;

  LMDSHGetFileInfo(Copy(S, 1, 2) + '\', F, FileInfo, 0);

  with Canvas do
    begin
      FillRect(Rect);
      DrawIconEx(Handle, Rect.Left, Rect.Top, FileInfo.hIcon, ItemHeight,
            ItemHeight, 0, 0, DI_NORMAL);
      Rect.Left := Rect.Left + bmpWidth + 6;
      DrawText(Canvas.Handle, Int_Ref(S), -1, Rect,
            DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.Click;
begin
  inherited Click;
  if ItemIndex >= 0 then
    Drive := Items[ItemIndex][1];
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
  RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDriveListBox.ReadBitmaps;
begin
  CDROMBMP := TBitmap.Create;
  CDROMBMP.Handle := LoadBitmap(HInstance, 'LMDSHELLCDDRIVE');
  end;

{------------------------------------------------------------------------------}
function TLMDShellDriveListBox.getLMDPackage: TLMDPackageID;
begin
    result:=pi_LMD_SHELL;
end;

end.
