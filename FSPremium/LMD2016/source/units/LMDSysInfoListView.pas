unit LMDSysInfoListView;
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

LMDRefineUnit unit (RM, AH)
---------------------------
The LMDSysInfoListView unit contains GUI controls class for displaying system info.

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,
  LMDSysBase, LMDSysObject, LMDSysInfoTreeView, LMDSysBaseComponent, LMDTypes,
  LMDControl;

type

  TLMDSysInfoListViewGetPropertyImageIndexEvent = procedure (Sender : TObject;
    aPropertyType : TLMDSysPropertyType; aPropertyValue : variant;
    aPropertyAvailable : boolean; var aImageIndex : integer) of object;

  TLMDSysInfoListViewGetObjectImageIndexEvent = procedure (Sender : TObject;
    aSysInfoObject : TObject; aSysInfoType : TLMDSysInfoType; var aImageIndex : integer) of object;

  { ************************************************************************** }
  TLMDSysInfoListView = class(TLMDBaseListView)
  private
    FShow                       : Boolean;
    FSysInfoObject              : TObject;
    FSysControl                 : TLMDSysBaseComponent;
    FSysInfoTreeView            : TLMDSysInfoTreeView;
    FOnGetPropertyImageIndex    : TLMDSysInfoListViewGetPropertyImageIndexEvent;
    FOnGetObjectImageIndex      : TLMDSysInfoListViewGetObjectImageIndexEvent;
    FList                       : TCollection;
    FImageList                  : TImageList;
    FOnShow                     : TNotifyEvent;
    FShowDescriptionColumn: Boolean;
    procedure SetSysControl(const Value: TLMDSysBaseComponent);
    procedure SetSysInfoObject(const value : TObject);
    procedure SetSysInfoTreeView(const value : TLMDSysInfoTreeView);
    function  CheckFlags: Boolean;
    procedure AddItem(aName, aValue, aDesc : string; aImageIndex : Integer = -1);reintroduce;
    procedure AddProperties(aObject : TObject);
    procedure AddSubItems(aObject : TObject);
    procedure AddColumn(aCaption : string; aWidth : integer);
    procedure Populate(aSystemInfo : TObject);
    procedure LoadImageList;
    procedure SetShowDescriptionColumn(const Value: Boolean);
  protected
    function GetPropertyImageIndex(aSysInfoObject: TObject; index : integer): integer; virtual;
    function GetObjectImageIndex(aSysInfoObject: TObject): integer; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function OwnerDataFetch(Item: TListItem; Request: TItemRequest): Boolean; override;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;
    procedure DblClick; override;
    procedure Loaded; override;
    function getLMDPackage:TLMDPackageID;override;

    property Columns;
    property SysInfoObject:TObject read FSysInfoObject write SetSysInfoObject;
  published
    property SysInfoControl:TLMDSysBaseComponent read FSysControl write SetSysControl;
    property SysInfoTreeView : TLMDSysInfoTreeView read FSysInfoTreeView write SetSysInfoTreeView;
    property ShowStrDlg:Boolean read FShow write FShow default True;
    property OnShowStrDlg:TNotifyEvent read FOnShow write FOnShow;
    property About;

    // 7.01
    property ShowDescriptionColumn:Boolean read FShowDescriptionColumn write SetShowDescriptionColumn default true;
    // ----
    property Align;
    property AllocBy;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property Enabled;
    property Font;
    property FlatScrollBars;
    property GridLines;
    property HideSelection;
    property HotTrack;
    property HotTrackStyles;
    property HoverTime;
    property IconOptions;
    property Items;
    property LargeImages;
    property RowSelect;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SmallImages;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCompare;
    property OnContextPopup;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnInfoTip;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnGetPropertyImageIndex : TLMDSysInfoListViewGetPropertyImageIndexEvent
      read FOnGetPropertyImageIndex write FOnGetPropertyImageIndex;
    property OnGetObjectImageIndex : TLMDSysInfoListViewGetObjectImageIndexEvent
      read FOnGetObjectImageIndex write FOnGetObjectImageIndex;
  end;

implementation
uses
  CommCtrl,
  Imglist,
  LMDSysStrsDlg;

type
  { ************************************************************************** }
  TLMDSysInfoListItem = class (TCollectionItem)
  private
    FName       : string;
    FValue      : string;
    FDesc       : string;
    FImageIndex : integer;
  public
    property Name : string read FName write FName;
    property Value : string read FValue write FValue;
    property Desc : string read FDesc write FDesc;
    property ImageIndex : integer read FImageIndex write FImageIndex;
  end;

  { ************************************************************************** }
  TLMDSysInfoList = class (TCollection)
  private
    function GetItem(index : integer) : TLMDSysInfoListItem;
  public
    constructor Create;
    function Add(aName, aValue, aDesc : string; aImageIndex : integer) : TLMDSysInfoListItem;
    property Items[index : integer] : TLMDSysInfoListItem read GetItem; default;
  end;

{------------------------------------------------------------------------------}
function TLMDSysInfoList.GetItem(index : integer) : TLMDSysInfoListItem;
begin
  result := TLMDSysInfoListItem(inherited GetItem(index));
end;

{------------------------------------------------------------------------------}
constructor TLMDSysInfoList.Create;
begin
  inherited Create(TLMDSysInfoListItem);
end;

{------------------------------------------------------------------------------}
function TLMDSysInfoList.Add(aName, aValue, aDesc : string; aImageIndex : integer) : TLMDSysInfoListItem;
begin
  result := TLMDSysInfoListItem(inherited Add);
  result.Name:=aName;
  result.Value:=aValue;
  result.Desc:=aDesc;
  result.ImageIndex := aImageIndex;
end;

{ ********************************* TLMDSysInfoListView ************************* }
{ --------------------------------- private ---------------------------------- }
procedure TLMDSysInfoListView.SetSysInfoObject(const value : TObject);
var
  Container:ILMDSysContainer;
  tmpObject:TObject;
begin
  tmpObjecT:=Value;
  if Value is TLMDSysBaseComponent then
    if Supports(value, IID_ILMDSysContainer, Container) then
    begin
        tmpObject:=Container.GetElement(0);
        Container := nil;
      end;
   FSysInfoObject:=tmpObject;
   if CheckFlags then Refresh;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.SetSysInfoTreeView(const value : TLMDSysInfoTreeView);
begin
  if FSysInfoTreeView = value then Exit;
  Items.Clear;
  Populate(nil);
  if FSysInfoTreeView <> nil then FSysInfoTreeView.UnRegisterListView(Self);
  FSysInfoTreeView := value;
  if FSysInfoTreeView <> nil then
    begin
      FSysControl:=nil;
      FSysInfoTreeView.RegisterListView(Self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.SetShowDescriptionColumn(const Value: Boolean);
begin
  if FShowDescriptionColumn<>Value then
    begin
      FShowDescriptionColumn := Value;
      If Columns.Count>=3 then
        Columns[2].Width:=Ord(FShowDescriptionColumn)*500;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfoListView.CheckFlags: Boolean;
begin
  result:=not (csLoading in ComponentState);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.AddItem(aName, aValue, aDesc : string; aImageIndex : Integer);
begin
  TLMDSysInfoList(FList).Add(aName, aValue, aDesc, aImageIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.AddProperties(aObject : TObject);
var
  Publisher     : ILMDSysPublisher;
  Descriptor    : ILMDSysDescriptor;
  i             : integer;
begin
  if not assigned(aObject) then Exit;

  if Supports(aObject, IID_ILMDSysPublisher, Publisher) then
    begin
      if Supports(TObject(aObject), IID_ILMDSysDescriptor, Descriptor) then
  begin
          AddItem(Descriptor.GetElementTitle, Descriptor.GetElementDescription,
            '', GetObjectImageIndex(aObject));
          Descriptor := nil;
        end;

      for i := 0 to Publisher.GetPropertiesCount-1 do
        begin
          AddItem(Publisher.GetPropTitle(i),
            Publisher.GetPropText(i),
            Publisher.GetPropDescription(i), GetPropertyImageIndex(aObject, i));
        end;
      Publisher := nil;
      AddItem('', '', '');
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.AddSubItems(aObject : TObject);
var
  Container     : ILMDSysContainer;
  tmpObject     : TObject;
  i             : integer;
begin
  if not Assigned(aObject) then Exit;

  if Supports(aObject, IID_ILMDSysContainer, Container) then
  begin
      for i := 0 to Container.GetElementCount-1 do
        begin
          tmpObject := Container.GetElement(i);
          AddProperties(tmpObject);
          AddSubItems(tmpObject);
        end;
      Container := nil;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.AddColumn(aCaption : string; aWidth : integer);
var
  Col : TListColumn;
begin
  Col := Columns.Add;
    Col.Caption := aCaption;
    Col.Width := aWidth;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.Populate(aSystemInfo : TObject);
begin
  FList.Clear;
  if Assigned(aSystemInfo) then
  begin
    AddProperties(aSystemInfo);
    AddSubItems(aSystemInfo);
  end;

  if HandleAllocated then
    Items.Count := FList.Count;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.LoadImageList;
var
  hImageList    : THandle;
  tmpBitmap     : TBitmap;
begin
  FImageList := TImageList.Create(nil);
  hImageList := ImageList_Create(16, 16, ILC_COLOR24 or ILC_MASK, 0, 1);
  FImageList.Handle := hImageList;

  tmpBitmap := TBitmap.Create;
  tmpBitmap.LoadFromResourceName(HInstance,'LMDSYSINFOLIST');
  FImageList.AddMasked(tmpBitmap, clFuchsia);
  tmpBitmap.Free;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysInfoListView.DblClick;
var
  tmp:TLMDSysStringsDialog;
begin
  if FShow and (Selected<>nil) then
    if (Selected.SubItems.Count>0) and (Selected.SubItems[0]<>'') then
      begin
        tmp:=TLMDSysStringsDialog.Create(nil);
        with tmp do
          try
            Caption:=Selected.Caption+'...';
            Lines.Text:=Selected.SubItems[0];
            if Assigned(FOnShow) then
              FOnShow(tmp);
            ShowModal;
          finally
            Free;
          end;
      end;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDSysInfoListView.GetPropertyImageIndex(aSysInfoObject: TObject; index: integer): integer;
var
  PropType : TLMDSysPropertyType;
  PropVal  : Variant;
  PropAvailable : boolean;
  Publisher     : ILMDSysPublisher;
begin
  result:=-1;
  PropType:=ptUnknown;
  PropVal:=0;
  PropAvailable:=False;

  if not assigned (aSysInfoObject) then Exit;

  if Supports(TObject(aSysInfoObject), IID_ILMDSysPublisher, Publisher) then
  begin
      PropType := Publisher.GetPropType(index);
      PropVal  := Publisher.GetPropValue(index);
      PropAvailable := Publisher.GetPropAvailability(index);
      Publisher := nil;
    end;

  if FImageList = SmallImages then
    if PropAvailable then
      result := 11
    else
      result := 12
  else
    if assigned(FOnGetPropertyImageIndex) then
      FOnGetPropertyImageIndex(self, PropType, PropVal, PropAvailable, result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysInfoListView.GetObjectImageIndex(aSysInfoObject: TObject): integer;
var
  InfoType      : TLMDSysInfoType;
  Descriptor    : ILMDSysDescriptor;
begin
  result := -1;
  InfoType := itUnknown;
  if not assigned (aSysInfoObject) then Exit;

  if Supports(TObject(aSysInfoObject), IID_ILMDSysDescriptor, Descriptor) then
  begin
      InfoType := Descriptor.GetElementType;
      Descriptor := nil;
    end;

  if SmallImages = FImageList then
    case InfoType of
      itUnknown                   : result := -1;
      itSystemInfoGroup           : result := 0;
      itDisplayGroup              : result := 1;
      itDisplayMode               : result := 5;
      itDisplayModes              : result := 5;
      itDisplayPlus               : result := 2;
      itDisplayWallpaper          : result := 4;
      itDisplayScreenSaver        : result := 3;
      itMouse                     : result := 10;
      itDriveGroup                : result := 6;
      itFloppyDrive               : result := 8;
      itFixedDrive                : result := 7;
      itCDROMDrive                : result := 9;
      itPrinterGroup              : result := 14;
      itPrinter                   : result := 15;
      itWindows                   : result := 16;
      itKeyboard                  : result := 17;
      itMemory                    : result := 18;
      itProcessor                 : result := 19;
      itPowerStatus               : result := 20;
      itTimeZone                  : result := 21;
      itLocale                    : result := 22;
      itUninstallGroup            : result := 23;
      itUninstallItem             : result := 23;
      itFontGroup                 : result := 24;
      itFont                      : result := 25;
      itMultimediaGroup           : result := 26;
      itJoystickGroup             : result := 27;
      itJoystick                  : result := 27;
      itMidiOutAudioGroup         : result := 28;
      itMIDIiOutAudio             : result := 28;
      itMidiInAudioGroup          : result := 29;
      itMIDIiInAudio              : result := 29;
      itwaveOutAudioGroup         : result := 28;
      itwaveOutAudio              : result := 28;
      itwaveInAudioGroup          : result := 29;
      itwaveInAudio               : result := 29;
      itDauxAudioGroup            : result := 28;
      itDauxAudio                 : result := 28;
      itMixerGroup                : result := 30;
      itMixer                     : result := 30;
      itFileActionGroup           : result := 32;
      itFileAction                : result := 32;
      itFileAssocGroup            : result := 31;
      itFileAssoc                 : result := 31;
      itInetAdvPropGroup          : result := 33;
      itInetAdvProp               : result := 33;
      itInetZoneGroup             : result := 34;
      itInetZone                  : result := 34;
      itTempInternetFiles         : result := 34;
      itInternet                  : result := 34;
      itModemGroup                : result := 35;
      itModem                     : result := 35;
      itTCPIP                     : result := 36;
      itIPX                       : result := 37;
      itNetBEUI                   : result := 38;
      itNetwork                   : result := 39;
      itNetworkCard               : result := 40;
      itNetworkCardGroup          : result := 40;
    end
  else
    if assigned(FOnGetObjectImageIndex) then
      FOnGetObjectImageIndex(self, aSysInfoObject, InfoType, result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysInfoListView.OwnerDataFetch(Item: TListItem; Request: TItemRequest): Boolean;
var
  InfoItem : TLMDSysInfoListItem;
begin
  InfoItem := TLMDSysInfoList(FList)[Item.Index];
  Item.Caption := InfoItem.Name;
  Item.SubItems.Add(InfoItem.Value);
  Item.SubItems.Add(InfoItem.Desc);
  Item.ImageIndex := InfoItem.ImageIndex;

  result := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.Update;
begin
  Populate(FSysInfoObject);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if AComponent = FSysControl then
    if Operation = opRemove then SysInfoControl:=nil;
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDSysInfoListView.Create(AOwner: TComponent);
begin
  inherited;
  OwnerData := True;
  FShow:=True;
  FOnGetPropertyImageIndex := nil;
  FOnGetObjectImageIndex := nil;

  DragMode := dmManual;
  ReadOnly := True;
  ViewStyle := vsReport;
  ShowColumnHeaders := True;

  AddColumn('Property', 200);
  AddColumn('Value', 150);
  AddColumn('Description', 500);

  FList := TLMDSysInfoList.Create;
  FShowDescriptionColumn:=true;
  FSysInfoObject := nil;
  FSysInfoTreeView := nil;
  FSysControl:=nil;
  LoadImageList;
  SmallImages := FImageList;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysInfoListView.Destroy;
begin
  if Assigned(FList) then
    FreeAndNil(FList);
  if FSysInfoTreeView <> nil then
    FSysInfoTreeView.UnRegisterListView(Self);
  FreeAndNil(FImageList);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysInfoListView.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_SYS;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.Loaded;
begin
  inherited;
  if Assigned(FSysControl) then
    begin
      if FSysControl.AutoRetrieve then FSysControl.Refresh;
      Refresh;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoListView.SetSysControl(const Value: TLMDSysBaseComponent);
begin
  if FSysInfoTreeView<>nil then exit;
  if Value<>FSysControl then
    begin
      FSysControl := Value;
      if FSysControl<>nil then
        FSysControl.FreeNotification(self);
      SysInfoObject:=FSysControl;
    end;
end;

end.
