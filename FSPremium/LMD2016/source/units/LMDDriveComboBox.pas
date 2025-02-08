unit LMDDriveComboBox;
{$I lmdcmps.INC}

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

LMDDriveComboBox unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls, StdCtrls, Graphics,
  LMDCustomComboBox;

type
  TLMDDriveType = (dtUnknown, dtNoRoot, dtRemovable, dtFixed, dtNetwork, dtCDROM, dtRAM);

  { ************************* TLMDDriveComboBox ****************************** }
  TLMDDriveComboBox = class(TLMDCustomComboBox)
  private
    //iml    : TImageList;
    FDrive : Char;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetDrive(NewDrive: Char);
  //  procedure ReadBitmaps;
    procedure ResetItemHeight;

//    procedure WMDEVICECHANGE (var Msg : TMessage); message CM_DEVICECHANGE;
  protected
    //CDROMBMP, RAMBMP: TBitmap;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure Click; override;
    procedure BuildList; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Text;
    property Drive: Char read FDrive write SetDrive;
    property CtlXP; // compatbility
  published
    property About;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Flat;
    property FocusControl;
    property Font;
    property ItemHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    //property Search;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property ThemeMode;
    property ThemeGlobalMode;    
    property UseGlobalTimer;
    property Visible;

   {Events}
   property OnSelect;
   property OnChange;
   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnDropDown;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnKeyDown;
   property OnKeyPress;
   property OnKeyUp;
   property OnStartDrag;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    property OnCloseUp;
  end;

  TLMDLabeledDriveComboBox = class(TLMDDriveComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ItemIndex;
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  ShellApi, SysUtils,
  LMDUtils, LMDProcs, LMDShUtils;

{--------------------------- Public -------------------------------------------}
constructor TLMDDriveComboBox.Create(AOwner: TComponent);
var
  Temp: string;//ShortString;
begin
  inherited Create(AOwner);
  Style := csOwnerDrawFixed;
  //ReadBitmaps;
  GetDir(0, Temp);
  FDrive := Temp[1]; { make default drive selected }
  if FDrive = '\' then FDrive := #0;
  ResetItemHeight;
  //iml := TImageList.Create (self);
end;

{------------------------------------------------------------------------------}
destructor TLMDDriveComboBox.Destroy;
begin
  {iml.Handle := 0;
  FreeAndNil(iml);
//  NetworkBMP.Free;
  FreeAndNil(CDROMBMP);
  FreeAndNil(RAMBMP);}
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDDriveComboBox.BuildList;
type
  TDriveBits = set of 0..25;
var
  DriveNum: Integer;
  drive: Char;
  DriveType: TLMDDriveType;
  DriveBits: TDriveBits;

  function getVolumeID: string;
  var
    OldErrorMode: Integer;
    NotUsed, VolFlags: Cardinal;

    Buf: array [0..MAX_PATH] of Char;

  begin
    OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    try

      if GetVolumeInformation(int_Ref(drive + ':\'), Buf, sizeof(Buf),
        nil, NotUsed, VolFlags, nil, 0) then
        SetString(Result, Buf, StrLen(Buf))

      else
        result := '';
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
      DriveType := TLMDDriveType(GetDriveType(int_Ref(drive + ':\')));
      case DriveType of
        dtRemovable : Items.AddObject(drive + ':', nil{FloppyBMP});
        dtFixed     : AddDrive(getVolumeID, nil{FixedBMP});
        dtNetwork   : AddDrive(getNetworkVolume, nil {NetworkBMP});
        dtCDROM     : AddDrive(getVolumeID, nil {CDROMBMP});
        dtRAM       : AddDrive(getVolumeID, nil{RAMBMP});
      end;
    end;
//  iml.Handle := SHGetFileInfo(#0#0,0 , FileInfo, SizeOf(TSHFileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
end;

{------------------------------------------------------------------------------}
procedure TLMDDriveComboBox.SetDrive(NewDrive: Char);
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
{      if TextCase = tcUpperCase then
        FDrive := UpCase(NewDrive)
      else}
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
//    if FDirList <> nil then FDirList.DriveChange(Drive);
    Change;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDriveComboBox.CreateWnd;
begin
  inherited CreateWnd;
  BuildList;
  SetDrive (FDrive);
end;

{------------------------------------------------------------------------------}
procedure TLMDDriveComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  bmpWidth: Integer;
  FileInfo : TSHFileInfo;
begin

  with Canvas do
    begin
      FillRect(Rect);
      bmpWidth  := ItemHeight;
      if ItemHeight < GetSystemMetrics (SM_CXICON) then
        LMDSHGetFileInfo(Copy(Items[Index],1,2)+'\', 0, FileInfo, SHGFI_ICON or SHGFI_SMALLICON)
      else
        LMDSHGetFileInfo(Copy(Items[Index],1,2)+'\', 0, FileInfo, SHGFI_ICON or SHGFI_LARGEICON);
      DrawIconEx (Handle, Rect.Left, Rect.Top, FileInfo.hIcon, ItemHeight, ItemHeight, 0, 0, DI_NORMAL);

      { uses DrawText instead of TextOut in order to get clipping against the combo box button   }
      Rect.Left := Rect.Left + bmpWidth + 6;
      DrawText(Canvas.Handle, int_Ref(Items[Index]), -1, Rect,
               DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDriveComboBox.Click;
begin
  inherited Click;
  if ItemIndex >= 0 then
    Drive := Items[ItemIndex][1];
end;

{------------------------------------------------------------------------------}
procedure TLMDDriveComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
  RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDDriveComboBox.ResetItemHeight;
var
  nuHeight: Integer;
begin
  nuHeight :=  LMDGetFontHeight(Font);
  ItemHeight := nuHeight;
end;

constructor TLMDLabeledDriveComboBox.Create(AOwner: TComponent);
begin
  inherited;
  HasBoundLabel := True;
end;

end.
