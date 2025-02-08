unit LMDMMButtonFaceController;
{$I lmdcmps.Inc}

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

LMDMMButtonFaceController unit (RM)
----------------------------------
Centralized ButtonFaceSettings

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, ImgList,
  LMDCont, LMDBaseController, LMDButtonBase, LMDCustomImageList;

type

  {******************** TLMDMMButtonFaceController ****************************}
  TLMDMMButtonFaceController=class(TLMDBaseController)
  private
    FButtonFace:TLMDButtonFace;
    FButtonFaceImageList:TCustomImageList;
    FButtonFaceChangeLink: TChangeLink;
    FButtonFaceIndices: TLMDButtonFaceIndices;
    FTransCol: TColor;
    procedure SetButtonFaceImageList(aValue:TCustomImageList);
    procedure SetButtonFaceIndex(Index:TLMDButtonState; aValue:TLMDButtonFaceIndex);
    function GetButtonFaceIndex(Index:TLMDButtonState):TLMDButtonFaceIndex;

    {saving: ButtonFace}
    {----}
    procedure ReadIndexIdent(S: TStream);
    procedure WriteIndexIdent(S: TStream);
    procedure ButtonFaceReadIdent(Reader:TReader);
    procedure ButtonFaceWriteIdent(Writer:TWriter);
    procedure ReadTransColIdent(S: TStream);
    procedure WriteTransColIdent(S: TStream);
    function ButtonFaceCheckCont:Boolean;
    function ButtonFaceHasControl:Boolean;
    {----}
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetButtonFaceIndices(var aValue: TLMDButtonFaceIndices);
    procedure SetButtonFaceIndices(const aValue:TLMDButtonFaceIndices);
    procedure SetTransCol;
    procedure Synchronize(aValue:Boolean=false);
    property ButtonFaceIndex[index:TLMDButtonState]:TLMDButtonFaceIndex read GetButtonFaceIndex write SetButtonFaceIndex;
  published
    property ButtonFace:TLMDButtonFace read  FButtonFace write FButtonFace;
    property ButtonFaceImageList:TCustomImageList read FButtonFaceImageList write SetButtonFaceImageList stored ButtonFaceHasControl;
  end;

implementation
uses
  sysutils;
{********************** TLMDMMButtonFaceController ******************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDMMButtonFaceController.ButtonFaceReadIdent(Reader:TReader);
begin
  SetButtonFaceImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.ButtonFaceWriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FButtonFaceImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.ReadIndexIdent(S: TStream);
var
  i: TLMDButtonState;

begin
  for i := Low (TLMDButtonState) to High (TLMDButtonState) do
    S.ReadBuffer (FButtonFaceIndices[i].ImageIndex, SizeOf (LongInt));
  for i := High (TLMDButtonState) DownTo Low (TLMDButtonState) do
    S.ReadBuffer (FButtonFaceIndices[i].ListIndex, SizeOf (LongInt));
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.WriteIndexIdent(S: TStream);
var
  i: TLMDButtonState;
begin
  for i := Low (TLMDButtonState) to High (TLMDButtonState) do
    S.WriteBuffer (FButtonFaceIndices[i].ImageIndex, SizeOf (LongInt));
  for i := High (TLMDButtonState) downto Low (TLMDButtonState) do
    S.WriteBuffer (FButtonFaceIndices[i].ListIndex, SizeOf (LongInt));
end;

{------------------------------------------------------------------------------}

procedure TLMDMMButtonFaceController.ReadTransColIdent(S: TStream);
begin
  S.ReadBuffer(FTransCol,SizeOf(TColor));
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.WriteTransColIdent(S: TStream);
begin
  S.WriteBuffer(FTransCol,SizeOf(TColor));
end;

{------------------------------------------------------------------------------}
function TLMDMMButtonFaceController.ButtonFaceCheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FButtonFaceImageList);
end;

{------------------------------------------------------------------------------}
function TLMDMMButtonFaceController.ButtonFaceHasControl:Boolean;
begin
  result:=(FButtonFaceImageList<>nil) and (FButtonFaceImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.SetButtonFaceImageList(aValue:TCustomImageList);
begin
  if FButtonFaceImageList<>nil then
    FButtonFaceImageList.UnRegisterChanges(FButtonFaceChangeLink);
  FButtonFaceImageList:=aValue;
  if FButtonFaceImageList<>nil then
    begin
      FButtonFaceImageList.RegisterChanges(FButtonFaceChangeLink);
      FButtonFaceImageList.FreeNotification(Self);
    end;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.SetButtonFaceIndex(Index:TLMDButtonState; aValue:TLMDButtonFaceIndex);
begin
  {FButtonFaceIndices[Index,0]:=aValue.ListIndex;
  FButtonFaceIndices[Index,1]:=aValue.ImageIndex;}
  FButtonFaceIndices[Index]:=aValue;
  Change;
end;

{------------------------------------------------------------------------------}
function TLMDMMButtonFaceController.GetButtonFaceIndex(Index:TLMDButtonState):TLMDButtonFaceIndex;
begin
  result:=FButtonFaceIndices[Index];//LMDMMReturnFaceIndex(FButtonFaceIndices[Index,0], FButtonFaceIndices[Index,1]);
end;

{------------------------ protected -------------------------------------------}
procedure TLMDMMButtonFaceController.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ButtonFace', ButtonFaceReadIdent, ButtonFaceWriteIdent,ButtonFaceCheckCont);
  Filer.DefineBinaryProperty('ButtonFaceIndicesNew2', ReadIndexIdent, WriteIndexIdent, True);
  Filer.DefineBinaryProperty('ButtonFaceTransColNew', ReadTransColIdent, WriteTransColIdent, True);
end;

{------------------------------------------------------------------------------}
{function TLMDMMButtonFaceController.GetEmpty:Boolean;
begin
  result:=(FButtonFaceImageList=nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.Notification(AComponent: TComponent;
 Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FButtonFaceImageList) then SetButtonFaceImageList(nil);
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDMMButtonFaceController.SetTransCol;
begin
  FTransCol:=LMDIMLTransparentColor(FButtonFaceImageList, FButtonFaceIndices[bsUp].ListIndex,
                                    FButtonFaceIndices[bsUp].ImageIndex);
  if FTransCol>=integer($02000000) then
    FTransCol:=FTransCol-integer($02000000);
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.GetButtonFaceIndices(var aValue: TLMDButtonFaceIndices);
begin
  //aValue:=FButtonFaceIndices;
  LMDMMCopyFace(aValue, FButtonFaceIndices);
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.SetButtonFaceIndices(const aValue:TLMDButtonFaceIndices);
begin
  //FButtonFaceIndices:=aValue;
  LMDMMCopyFace(FButtonFaceIndices, aValue);
  if not (csLoading in ComponentState) then Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDMMButtonFaceController.Synchronize(aValue: Boolean=false);
begin
  LMDMMSynchronize(FButtonFaceIndices, aValue);
end;

{------------------------------------------------------------------------------}
constructor TLMDMMButtonFaceController.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  FTransCol:=clWhite;
  FButtonFaceImageList:=nil;
  FButtonFaceChangeLink:=TChangeLink.Create;
  FButtonFaceChangeLink.OnChange:=GetChange;
  LMDMMInitFace(FButtonFaceIndices);
end;

{------------------------------------------------------------------------------}
destructor TLMDMMButtonFaceController.Destroy;
begin
  FButtonFaceChangeLink.OnChange:=nil;
  FreeAndNil(FButtonFaceChangeLink);
  inherited Destroy;
end;

end.
