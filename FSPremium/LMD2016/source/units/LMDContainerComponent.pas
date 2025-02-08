unit LMDContainerComponent;
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

LMDContainerComponent unit (RM)
-------------------------------
A base class for nonvisual controls which can hold a linked bitmap

Changes
-------
Release 9.0 (June 2008)
 - Introduction of ThemeMode property, CtlXP and ILMDThemes interfaces are
   obsolete now.

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, ImgList, 
  LMDCont, LMDClass, LMDBaseController, LMDCustomImageList, LMDCustomComponent;

type
  {------------------------ Class TLMDContainerComponent  ---------------------}
  TLMDContainerComponent=class(TLMDCustomComponent)
  private
    FImageList:TCustomImageList;
    FIndex,
    FListIndex:Integer;
    FChangeLink:TChangeLink;
    FUserData: TObject;
    FThemeMode: TLMDThemeMode;
    FThemeGlobalMode: Boolean;
    procedure SetCtlXP(const Value: Boolean);
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetIndex(index, aValue:Integer);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetThemeGlobalMode(const Value: Boolean);
    function GetCtlXP: Boolean;
    {saving}
    {----}
    procedure ReadIdent(Reader:TReader);
    procedure ReadCtlXP(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    {----  }
  protected
    procedure DoThemeChange;virtual;
    // UseThemeMode returns active theme, depending on global settings etc.
    function UseThemeMode: TLMDThemeMode;

    procedure DefineProperties(Filer:TFiler);override;
    procedure GetIMLChange(Sender:TObject);virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    {properties}
    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ImageIndex:Integer index 0 read FIndex write SetIndex default 0;
    property ListIndex:Integer index 1 read FListIndex write SetIndex default 0;
    property UserData: TObject read FUserData write FUserData;
    property ThemeMode:TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    // compatibility only
    property CtlXP:Boolean read GetCtlXP write SetCtlXP default True;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;
    function IsThemed: Boolean; // any other than ttmNone
  end;

implementation
uses
  LMDThemes;
{------------------------- Private --------------------------------------------}
procedure TLMDContainerComponent.SetCtlXP(const Value: Boolean);
begin
  if Value <> GetCtlXP then
    ThemeMode := LMDCtlXP[Value];
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.SetImageList(aValue:TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Self);
    end;
  GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.SetIndex(index, aValue:Integer);
begin
  case index of
    0: if (aValue=FIndex) or (aValue<0) then exit else FIndex:=aValue;
    1: if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  end;
  if FImageList<>nil then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      //DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
    begin
      FThemeMode := Value;
      //if not FThemeGlobalMode then       // if we are in GlobalThemeMode, no update required
      //  DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDContainerComponent.GetCtlXP: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.ReadCtlXP(Reader: TReader);
begin
  SetCtlXP(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDContainerComponent.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
{function TLMDContainerComponent.IMLEmpty:Boolean;
begin
  result:=not ((FImageList<>nil) and FImageList.IsValidItem(FListIndex, FIndex));
end;

{------------------------------------------------------------------------------}
function TLMDContainerComponent.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
{function TLMDContainerComponent.HasIML:Boolean;
begin
  result:=not (FImageList<>nil);
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDContainerComponent.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.DoThemeChange;
begin
end;

procedure TLMDContainerComponent.GetIMLChange(Sender:TObject);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDContainerComponent.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FImageList) then SetImageList(nil);
end ;

{------------------------------------------------------------------------------}
function TLMDContainerComponent.UseThemeMode: TLMDThemeMode;
begin
   if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
function TLMDContainerComponent.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------- Public----------------------------------------------}
constructor TLMDContainerComponent.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FThemeMode := ttmPlatForm;
  FListIndex:=0;
  FIndex:=0;
  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetIMLChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDContainerComponent.Destroy;
begin
  FChangeLink.Free;
  inherited Destroy;
end;

end.

