unit LMDSysInfoTreeView;
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

LMDSysInfoTreeView unit (RM, AH)
--------------------------------
The LMDSysInfoTreeView unit contains GUI controls class for navigating throgh system into

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, LMDSysTreeView, LMDSysBase, LMDSysBaseComponent;

type

  { ************************************************************************** }
  TLMDSysInfoItemSelectedEvent = procedure (Sender : TObject; aSysInfoObject : TObject;
    aSysInfoType : TLMDSysInfoType) of object;

  TLMDSysInfoTreeViewGetImageIdxEvent = procedure (Sender : TObject; aSysInfoObject : TObject;
    aSysInfoType : TLMDSysInfoType; var aImageIndex : integer) of object;

  TLMDSysInfoTreeView = class(TLMDSysTreeView)
  private
    FSysInfo            : TLMDSysBaseComponent;
    FOnItemSelected     : TLMDSysInfoItemSelectedEvent;
    FOnGetImageIdx      : TLMDSysInfoTreeViewGetImageIdxEvent;
    FListViews          : TList;
    FImageList          : TImageList;
    function AddItem(aParent : TTreeNode; aCaption : string; aImageIndex : integer; aData : Pointer; aChildren : boolean = False) : TTreeNode;
    procedure SetSysInfo(value : TLMDSysBaseComponent);
    procedure AddSubNodes(aParentNode : TTreeNode; aParentGroup : TObject);
    procedure LoadImageList;
  protected
    function GetImageIdx(aSysInfoObject: TObject): integer; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change(Node: TTreeNode); override;
    function CanExpand(Node: TTreeNode): Boolean; override;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded;override;
    procedure Populate;
    procedure RegisterListView(aList : TCustomListView);
    procedure UnRegisterListView(aList : TCustomListView);
  published
    property ShowRoot default True;
    property SystemInfo : TLMDSysBaseComponent read FSysInfo write SetSysInfo;
    property OnItemSelected : TLMDSysInfoItemSelectedEvent read FOnItemSelected write FOnItemSelected;
    property OnGetImageIdx : TLMDSysInfoTreeViewGetImageIdxEvent read FOnGetImageIdx write FOnGetImageIdx;
  end;

implementation
uses
  CommCtrl, Imglist,
  LMDSysInfoListView;

{ ********************************* TLMDSysInfoTreeView ********************* }
{ --------------------------------- private ---------------------------------- }

function TLMDSysInfoTreeView.AddItem(aParent : TTreeNode; aCaption : string;
      aImageIndex : integer; aData : Pointer; aChildren : boolean) : TTreeNode;

begin
  result := Items.AddChild(aParent, aCaption);
  if assigned(result) then
    begin
      result.ImageIndex := aImageIndex;
      result.SelectedIndex := aImageIndex;
      result.Data := aData;
      result.HasChildren := aChildren;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysInfoTreeView.SetSysInfo(value : TLMDSysBaseComponent);
begin
  if value = FSysInfo then Exit;
  FSysInfo := value;
  if assigned(FSysInfo) and (csDesigning in FSysInfo.ComponentState) then Exit;
  Populate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoTreeView.AddSubNodes(aParentNode : TTreeNode; aParentGroup : TObject);
var
  i             : integer;
  Container     : ILMDSysContainer;
  tmpContainer  : ILMDSysContainer;
  Publisher     : ILMDSysPublisher;
  Descriptor    : ILMDSysDescriptor;
  tmpObject     : TObject;
  tmpStr        : string;
  Child         : boolean;
begin
  if not assigned (aParentGroup) then Exit;

  if Supports(aParentGroup, IID_ILMDSysContainer, Container) then
  begin
      for i := 0 to Container.GetElementCount-1 do
        begin
          tmpObject := Container.GetElement(i);
          if tmpObject <> nil then
            if Supports(tmpObject, IID_ILMDSysContainer, tmpContainer) then
            begin
               if Supports(tmpObject, IID_ILMDSysDescriptor, Descriptor) then
               tmpStr := Descriptor.GetElementTitle
               else
                 tmpStr := '';
               Child := tmpContainer.GetElementCount > 0;
               tmpContainer := nil;
               Descriptor := nil;
               AddItem(aParentNode, tmpStr, GetImageIdx(tmpObject), pointer(tmpObject), Child);
               //               AddSubNodes(Node, tmpObject);
              end;
        end;

      for i := 0 to Container.GetElementCount-1 do
        begin
          tmpObject := Container.GetElement(i);
          if tmpObject <> nil then
            if Supports(tmpObject, IID_ILMDSysPublisher, Publisher) then
            begin
               if Supports(tmpObject, IID_ILMDSysDescriptor, Descriptor) then
               tmpStr := Descriptor.GetElementTitle
               else
                 tmpStr := '';
               Descriptor := nil;

               if not Supports(tmpObject, IID_ILMDSysContainer, tmpContainer) then
               begin
                   if Publisher.GetPropertiesCount > 0 then
                     AddItem(aParentNode, tmpStr, GetImageIdx(tmpObject), pointer(tmpObject));
                     end;
               Publisher := nil;
               tmpContainer := nil;
              end;
        end;
    end;
    Container := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoTreeView.LoadImageList;
var
  hImageList    : THandle;
  tmpBitmap     : TBitmap;
begin
  FImageList := TImageList.Create(nil);
  hImageList := ImageList_Create(16, 16, ILC_COLOR24 or ILC_MASK, 0, 1);
  FImageList.Handle := hImageList;

  tmpBitmap := TBitmap.Create;
  try
    tmpBitmap.LoadFromResourceName(HInstance,'LMDSYSINFOTREE');
    FImageList.AddMasked(tmpBitmap, clFuchsia);
  finally
    tmpBitmap.Free;
  end;
end;

{ --------------------------------- protected -------------------------------- }
function TLMDSysInfoTreeView.GetImageIdx(aSysInfoObject: TObject): integer;
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

  if Images = FImageList then
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
    if assigned(FOnGetImageIdx) then
      FOnGetImageIdx(self, aSysInfoObject, InfoType, result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoTreeView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if AComponent = FSysInfo then
    if Operation = opRemove then
      SystemInfo := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoTreeView.Change(Node: TTreeNode);
var
  Descriptor    : ILMDSysDescriptor;
  InfoType      : TLMDSysInfoType;
  i             : integer;
begin
  InfoType := itUnknown;

  if Supports(TObject(Selected.Data), IID_ILMDSysDescriptor, Descriptor) then
  begin
      InfoType := Descriptor.GetElementType;
      Descriptor := nil;
    end;

  if assigned (FOnItemSelected) then
    FOnItemSelected(Self, TObject(Selected.Data), InfoType);

  for i := 0 to FListViews.count-1 do
    TLMDSysInfoListView(FListViews[i]).SysInfoObject:=TObject(Selected.Data);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysInfoTreeView.CanExpand(Node: TTreeNode): Boolean;
begin
  result := True;
  if not assigned(TObject(Node.Data)) then Exit;
  if Node.HasChildren and (Node.Count = 0) then
    AddSubNodes(Node, TObject(Node.Data));
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDSysInfoTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FSysInfo := nil;
  FOnItemSelected := nil;
  FOnGetImageIdx := nil;
  DragMode := dmManual;
  ReadOnly := True;
  ShowHint := True;
  FListViews := TList.Create;
  LoadImageList;
  Images := FImageList;
  inherited ShowRoot:=True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysInfoTreeView.Destroy;
begin
  while FListViews.count > 0 do
    TLMDSysInfoListView(FListViews[0]).SysInfoTreeView := nil;

  FreeAndNil(FListViews);
  FreeAndNil(FImageList);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoTreeView.Populate;
var
  Container     : ILMDSysContainer;
  Descriptor    : ILMDSysDescriptor;
  strTitle      : string;
begin
  Items.BeginUpdate;
  try
    Items.Clear;
    if Assigned(FSysInfo) then
      begin
        if Supports(TObject(FSysInfo), IID_ILMDSysDescriptor, Descriptor) then
        strTitle := Descriptor.GetElementTitle
        else
          strTitle := '';

        Descriptor := nil;
        AddItem(nil, strTitle, GetImageIdx(TObject(FSysInfo)), Pointer(FSysInfo));
        if Supports(TObject(FSysInfo), IID_ILMDSysContainer, Container) then
        begin
            Container := nil;
            AddSubNodes(TopItem, TObject(FSysInfo));
          end;
      end;
  finally
    Items.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoTreeView.RegisterListView(aList : TCustomListView);
begin
  if aList = nil then Exit;
  if not (aList is TLMDSysInfoListView) then Exit;
  FListViews.Add(aList);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysInfoTreeView.UnRegisterListView(aList : TCustomListView);
var
  i : integer;
begin
  if aList = nil then Exit;
  for i := 0 to FListViews.count-1 do
    if FListViews[i] = aList then
      begin
        FListViews.Delete(i);
        Break;
      end;
end;

procedure TLMDSysInfoTreeView.Loaded;
begin
  inherited;
  //Refresh;
end;

end.
