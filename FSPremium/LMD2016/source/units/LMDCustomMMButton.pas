unit LMDCustomMMButton;
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

LMDCustomMMButton unit (RM)
---------------------------

Changes
-------
Release 8.07 (March 2008)
- Fixed: MouseOver State in TLMDMMButton did no longer work.

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, ImgList, Classes, Graphics,
  LMDBaseController, LMDCont, LMDGraph, LMDButtonBase, LMDCustomImageList,
  LMDBaseGraphicButton, LMDMMButtonFaceController, LMDPNGImageList;

type
  {************************* TLMDCustomMMButton *******************************}
  TLMDCustomMMButton=class(TLMDBaseGraphicButton)
  private
    // 7.0
    FButtonFaceController:TLMDMMButtonFaceController;
    FButtonFaceControllerLink:TLMDChangeLink;
    // ----

    FButtonFace:TLMDButtonFace;
    FButtonFaceImageList:TCustomImageList;
    FButtonFaceChangeLink: TChangeLink;
    FButtonFaceIndices: TLMDButtonFaceIndices;
    FCaptionDown: integer;
    FTransCol: TColor;
    FForceTransparent,
    FQuickDraw:Boolean;
    FStyle:TLMDBitmapStyle;
    FFaceRect:TRect;
    procedure SetButtonFaceController(aValue:TLMDMMButtonFaceController);
    procedure SetButtonFaceImageList(aValue:TCustomImageList);
    procedure SetCaptionDown(aValue:integer);
    procedure SetQuickDraw(aValue:Boolean);
    procedure SetForceTransparent(aValue:Boolean);
    procedure SetStyle(aValue:TLMDBitmapStyle);
    procedure SetButtonFaceIndex(Index:TLMDButtonState; aValue:TLMDButtonFaceIndex);
    function GetButtonFaceIndex(Index:TLMDButtonState):TLMDButtonFaceIndex;

    function ButtonFaceIMLEmpty(aValue: TLMDButtonState):Boolean;
    function HasButtonFaceIML:Boolean;
    {saving: ButtonFace}
    {----}
    procedure OldReadIndexIdent(Reader: TReader);
    procedure OldReadTransColIdent(Reader: TReader);
    procedure ReadIndexIdent_old(S: TStream);
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
    procedure AssignControllerValues;
    function ButtonColorChange: Boolean; override;
    procedure DefineProperties(Filer:TFiler);override;
    procedure GetButtonFaceIMLChange(Sender:TObject);virtual;
    function GetEmpty:Boolean; override;
    function GetPalette: HPALETTE;  override;
    function IsCustom:Boolean; override;
    procedure Loaded;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    procedure Paint;override;
    function VerifyTransparency(X, Y: Integer): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Disposition--
    procedure GetButtonFaceIndices(var aValue: TLMDButtonFaceIndices);
    procedure SetButtonFaceIndices(const aValue:TLMDButtonFaceIndices);
    procedure SetTransCol;
    // --------
    procedure Synchronize(const aValue: Boolean=false);
    property ButtonFaceIndex[index:TLMDButtonState]:TLMDButtonFaceIndex read GetButtonFaceIndex write SetButtonFaceIndex;
  published
    // 7.0  --> ButtonFaceController feature
    property ButtonFaceController:TLMDMMButtonFaceController read FButtonFaceController write SetButtonFaceController;
    // 7.0
    property ButtonLayout;
    property EnterColor;
    property EnterColorChange;
    property Glyph;
    property Font;
    property FontFX;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property NumGlyphs;
    property RepeatedClick;
    property RepeatingInterval;
    property RepeatingDelay;
    property UseCaption;
    property OnDropDown;
    // ---

    property AllowAllUp;
    property AllowMouseOver;
    property AllowTransparency default true;
    property ButtonFace:TLMDButtonFace read  FButtonFace write FButtonFace;
    property ButtonFaceStyle:TLMDBitmapStyle read FStyle write SetStyle default sbNone;
    property ButtonFaceImageList:TCustomImageList read FButtonFaceImageList write SetButtonFaceImageList stored ButtonFaceHasControl;
    property CaptionDown: integer read FCaptionDown write SetCaptionDown default 1;
    property ForceTransparent:Boolean read FForceTransparent write SetForceTransparent default True;
    property GroupIndex;
    property QuickDraw:Boolean read FQuickDraw write SetQuickDraw default false;
    property Pressed;
    property DropDownMenu;
    property DropDownIndent;
    property DropDownRight;
    property Transparent default false;
    property MultiLine;
  end;

implementation

uses
  Types, SysUtils, Controls,
  LMDProcs, LMDGraphUtils, LMDCustomControl;

{************************* TLMDCustomMMButton *********************************}
{------------------------- Private --------------------------------------------}
function TLMDCustomMMButton.ButtonFaceIMLEmpty(aValue: TLMDButtonState):Boolean;
begin
  result:=not ((ButtonFaceImageList<>nil) and
                LMDIMLIsValidItem(ButtonFaceImageList, FButtonFaceIndices[aValue].ListIndex,
                                  FButtonFaceIndices[aValue].ImageIndex));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.ButtonFaceReadIdent(Reader:TReader);
begin
  SetButtonFaceImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.ButtonFaceWriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FButtonFaceImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.OldReadIndexIdent(Reader: TReader);
begin
  Reader.Read(FButtonFaceIndices[TLMDButtonState(0)].ListIndex,
   Ord(High(TLMDButtonState))*SizeOf(LongInt)*2);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.ReadIndexIdent_old(S: TStream);
var
  i: Integer;

begin
  //this needed to be replaced because of dropping a btn states image index
  for i:=0 to (Ord(High(TLMDButtonState))*2)-1 do
    if i>Ord(High(TLMDButtonState))-1 then
      S.ReadBuffer(FButtonFaceIndices[TLMDButtonState(i-Ord(High(TLMDButtonState)))].ImageIndex, SizeOf(LongInt))
    else
      S.ReadBuffer(FButtonFaceIndices[TLMDButtonState(i)].ListIndex, SizeOf(LongInt));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.ReadIndexIdent(S: TStream);
var
  i: TLMDButtonState;

begin
  for i := Low (TLMDButtonState) to High (TLMDButtonState) do
    S.ReadBuffer (FButtonFaceIndices[i].ImageIndex, SizeOf (LongInt));
  for i := High (TLMDButtonState) DownTo Low (TLMDButtonState) do
    S.ReadBuffer (FButtonFaceIndices[i].ListIndex, SizeOf (LongInt));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.WriteIndexIdent(S: TStream);
var
  i: TLMDButtonState;
begin
  for i := Low (TLMDButtonState) to High (TLMDButtonState) do
    S.WriteBuffer (FButtonFaceIndices[i].ImageIndex, SizeOf (LongInt));
  for i := High (TLMDButtonState) DownTo Low (TLMDButtonState) do
    S.WriteBuffer (FButtonFaceIndices[i].ListIndex, SizeOf (LongInt));
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomMMButton.OldReadTransColIdent(Reader: TReader);
begin
  Reader.Read(FTransCol, SizeOf(TColor));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.ReadTransColIdent(S: TStream);
begin
  S.ReadBuffer(FTransCol ,SizeOf(TColor));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.WriteTransColIdent(S: TStream);
begin
  S.WriteBuffer(FTransCol,SizeOf(TColor));
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.ButtonFaceCheckCont:Boolean;
begin
  result:=(FButtonFaceController=nil) and LMDIsGlobalIdent(FButtonFaceImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.ButtonFaceHasControl:Boolean;
begin
  result:=(FButtonFaceImageList<>nil) and
          (FButtonFaceController=nil) and
          (FButtonFaceImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.HasButtonFaceIML:Boolean;
begin
  result:=(ButtonFaceImageList<>nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.SetQuickDraw(aValue:Boolean);
begin
  if aValue<>FQuickDraw then
    begin
      FQuickDraw:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.SetForceTransparent(aValue:Boolean);
begin
  if aValue<>FForceTransparent then
    begin
      FForceTransparent:=aValue;
      Invalidate;
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.SetButtonFaceController(aValue:TLMDMMButtonFaceController);
begin
  if FButtonFaceController<>nil then
    FButtonFaceController.UnRegisterChanges(FButtonFaceControllerLink);
  FButtonFaceController:=aValue;

  if FButtonFaceController<>nil then
    begin
      AssignControllerValues;
      FButtonFaceController.RegisterChanges(FButtonFaceControllerLink);
      FButtonFaceController.FreeNotification(Self);
      if Assigned(FButtonFaceImageList) then
        begin
          SetButtonFaceImageList(nil);
          exit;
        end;
    end
  else
    If Assigned(FButtonFaceImageList) then
      begin
        SetButtonFaceImageList(FButtonFaceImageList);
        exit;
      end;
  GetChange(FButtonFaceController);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.SetButtonFaceImageList(aValue:TCustomImageList);
begin
  if FButtonFaceImageList<>nil then
    FButtonFaceImageList.UnRegisterChanges(FButtonFaceChangeLink);
  FButtonFaceImageList:=aValue;
  if (FButtonFaceImageList<>nil) and (FButtonFaceController=nil) then
    begin
      FButtonFaceImageList.RegisterChanges(FButtonFaceChangeLink);
      FButtonFaceImageList.FreeNotification(Self);
    end;
  GetButtonFaceIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.SetButtonFaceIndex(Index:TLMDButtonState; aValue:TLMDButtonFaceIndex);
begin
  FButtonFaceIndices[Index].ListIndex:=aValue.ListIndex;
  FButtonFaceIndices[Index].ImageIndex:=aValue.ImageIndex;
  if FState=Index then Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.GetButtonFaceIndex(Index:TLMDButtonState):TLMDButtonFaceIndex;
begin
  result:=LMDMMReturnFaceIndex(FButtonFaceIndices[Index].ListIndex, FButtonFaceIndices[Index].ImageIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.SetCaptionDown(aValue:integer);
begin
  if aValue<>FCaptionDown then
    FCaptionDown:=aValue;
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomMMButton.SetStyle(aValue:TLMDBitmapStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.VerifyTransparency(X, Y: Integer): Boolean;
begin
  Result:=False;
  if not HasButtonFaceIML or ButtonFaceIMLEmpty(FState) then exit;
  if not PtInRect(FFaceRect, Point(X,Y)) then exit;
  if LMDIMLGetColorAtPoint(FButtonFaceImageList, Point(X-FFaceRect.Left, Y-FFaceRect.Top),
                           FButtonFaceIndices[FState].ListIndex,
                           FButtonFaceIndices[FState].ImageIndex)<>FTransCol then
    Result:=True;
end;

{------------------------ protected -------------------------------------------}
procedure TLMDCustomMMButton.AssignControllerValues;
begin
  if Assigned(FButtonFaceController) then
    begin
      FButtonFaceImageList:=FButtonFaceController.ButtonFaceImageList;
      FButtonFaceController.GetButtonFaceIndices(FButtonFaceIndices);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.ButtonColorChange: Boolean;
begin
  result := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  // compatibility
  Filer.DefineProperty('ButtonFaceIndices', OldReadIndexIdent, nil, false);
  Filer.DefineBinaryProperty('ButtonFaceIndicesNew', ReadIndexIdent_old, nil, false);
  Filer.DefineProperty('ButtonFaceTransCol', OldReadTransColIdent, nil, false);

  // modified for Version 7 - save only if no ButtonFaceController is attached
  Filer.DefineProperty('ButtonFace', ButtonFaceReadIdent, ButtonFaceWriteIdent,ButtonFaceCheckCont);
  Filer.DefineBinaryProperty('ButtonFaceIndicesNew2', ReadIndexIdent, WriteIndexIdent,FButtonFaceController=nil);
  Filer.DefineBinaryProperty('ButtonFaceTransColNew', ReadTransColIdent, WriteTransColIdent, FButtonFaceController=nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.GetButtonFaceIMLChange(Sender:TObject);
begin
  if (csLoading in ComponentState) or (csDestroying in ComponentState) then exit;
  AssignControllerValues;
  GetChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.GetEmpty:Boolean;
begin
  result:=(FButtonFaceImageList=nil);
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.GetPalette: HPALETTE;
begin
  result:=0;
  if Assigned(FButtonFaceImageList) then
    result:=LMDIMLPalette(FButtonFaceImageList, FButtonFaceIndices[FState].ListIndex);
end;

{------------------------------------------------------------------------------}
function TLMDCustomMMButton.IsCustom:Boolean;
begin
  result:=not HasIML;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.Loaded;
begin
  inherited Loaded;
  if FButtonFaceController<>nil then
    AssignControllerValues;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.Notification(AComponent: TComponent;
 Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    begin
      if (aComponent=FButtonFaceController) then
        SetButtonFaceController(nil);
      if FButtonFaceController<>nil then exit;
      if (aComponent=FButtonFaceImageList) then
        SetButtonFaceImageList(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.Paint;
var
  aRect: TRect;
  TempState: TLMDButtonState;
  TempBmp: TBitmap;
  flag:Word;
  opt:Boolean;
  w, h:Integer;

begin
  if csLoading in ComponentState then exit;

  SetRectEmpty(FFaceRect);
  if GetEmpty then
    begin
      if not Transparent then FillControl;
      if csDesigning in ComponentState then DrawDashedFrame;
      Exit;
    end;

  // AutoSize
  if FStyle=sbAutosize then
    begin
      w:=LMDIMLItemWidth(FButtonFaceImageList, FButtonFaceIndices[FState].ListIndex);
      h:=LMDIMLItemHeight(FButtonFaceImageList, FButtonFaceIndices[FState].ListIndex);
      if w=0 then w:=20;
      if h=0 then h:=20;
      if (w<>Width) or (h<>Height) then
        begin
          SetBounds(Left, Top, w, h);
          exit;
        end;
    end;

  TempBmp:=TBitmap.Create;
  try
    TempBmp.Width:=Width;
    TempBmp.Height:=Height;
    opt:=false;

    if not Transparent then
      begin
        with tempbmp.Canvas do
          begin
            Brush.Color := Color;
            Brush.Style := bsSolid;
            FillRect(GetClientRect);
            opt:=True;
          end
      end
    else
      if CheckOptimized then
        begin
          BackDrawArea(tempbmp.Canvas, ClientRect, Point(0, 0), 0);
          opt:=true;
        end;

    if not Assigned(FButtonFaceImageList) then exit;

    TempState:=FState;
    if (not LMDIMLIsValidItem(FButtonFaceImageList, FButtonFaceIndices[FState].ListIndex, FButtonFaceIndices[FState].ImageIndex)) then
      case TempState of
        bsDisabledUp, bsMouseOver,bsDragOver:
          TempState:=bsUp;
        bsOptionSet, bsDown, bsDropDownOpen, bsDisabledDown:
          TempState:=bsDown
      else
        exit;
      end;
    flag:=0;

    if not FQuickDraw then flag:=DSF_PALETTEREALIZE;

    case FStyle of
      sbCenter:flag:=flag or DSF_CENTER;
      sbStretch:flag:=flag or DSF_STRETCH;
      sbTile:flag:=flag or DSF_TILE;
      sbKeepAspRatio:flag:=flag or DSF_STRETCHKEEPRATIO;
      sbKeepHeight:flag:=flag or DSF_STRETCHKEEPHEIGHT;
      sbKeepWidth:flag:=flag or DSF_STRETCHKEEPWIDTH;
    end;

    if not ButtonFaceIMLEmpty(TempState) then
      begin
        if Transparent then
          begin
            if not opt then
              begin
                tempbmp.Canvas.Brush.Color:=LMDIMLTransparentColor(ButtonFaceImageList, FButtonFaceIndices[TempState].ListIndex, FButtonFaceIndices[TempState].ImageIndex);
                tempbmp.Canvas.FillRect(ClientRect);
              end;
              if (ButtonFaceImageList is TLMDCustomImageList) then
                FFaceRect:=TLMDCustomImageList(ButtonFaceImageList).DrawExt(TempBmp.Canvas, Rect(0,0,Width,Height),
                                             DSF_TRANSPARENCY or flag, FButtonFaceIndices[TempState].ListIndex, FButtonFaceIndices[TempState].ImageIndex)
              else
                if (ButtonFaceImageList is TLMDPNGImageList) then
                FFaceRect := TLMDPNGImageList(ButtonFaceImageList).DrawExt(TempBmp.Canvas, Rect(0,0,Width,Height), flag, FButtonFaceIndices[TempState].ListIndex);
                end
        else
          begin
             if FForceTransparent then flag:=flag or DSF_TRANSPARENCY;
             if (ButtonFaceImageList is TLMDCustomImageList) then
               FFaceRect:=TLMDCustomImageList(ButtonFaceImageList).DrawExt(tempBmp.Canvas, Rect(0,0,Width,Height),
                                            flag, FButtonFaceIndices[TempState].ListIndex, FButtonFaceIndices[TempState].ImageIndex)
             else
               if (ButtonFaceImageList is TLMDPNGImageList) then
                 FFaceRect := TLMDPNGImageList(ButtonFaceImageList).DrawExt(TempBmp.Canvas, Rect(0,0,Width,Height), flag, FButtonFaceIndices[TempState].ListIndex);
          end;
      end;

    aRect:=ClientRect;
    if FState in [bsDown, bsOptionSet, bsDropDownOpen] then
      OffsetRect(aRect,FCaptionDown,FCaptionDown);

    DrawGlyphAndText(TempBmp.Canvas, aRect);
    if opt then
      begin
        if not QuickDraw then
          begin
            SelectPalette(Canvas.Handle, LMDIMLPalette(ButtonFaceImageList, FButtonFaceIndices[TempState].ListIndex), false);
            RealizePalette(Canvas.Handle);
          end;
        Canvas.Draw(0, 0, TempBmp);
       end
    else
      LMDBmpDrawExt(Canvas, ClientRect, tempbmp.Canvas, ClientRect,
                    DSF_TRANSPARENCY or DSF_PALETTEREALIZE,
                    tempBmp.TransparentColor,
                    LMDIMLPalette(ButtonFaceImageList, FButtonFaceIndices[TempState].ListIndex), nil)
  finally
    TempBmp.Free;
  end;
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDCustomMMButton.SetTransCol;
begin
  FTransCol:=LMDIMLTransparentColor(FButtonFaceImageList,FButtonFaceIndices[bsUp].ListIndex,
                                    FButtonFaceIndices[bsUp].ImageIndex);
  if FTransCol>=integer($02000000) then
    FTransCol:=FTransCol-integer($02000000);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.GetButtonFaceIndices(var aValue:TLMDButtonFaceIndices);
begin
  //aValue:=FButtonFaceIndices;
  LMDMMCopyFace(aValue, FButtonFaceIndices);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.SetButtonFaceIndices(const aValue:TLMDButtonFaceIndices);
begin
  LMDMMCopyFace(FButtonFaceIndices, aValue);
  //FButtonFaceIndices:=aValue;
  if not (csLoading in ComponentState) then
    Invalidate;
end;

{------------------------------------------------------------------------------}
constructor TLMDCustomMMButton.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  ControlStyle:=ControlStyle+[csOpaque]-[csClickEvents]+[csReplicatable];
  FForceTransparent:=True;

  FButtonFaceImageList:=nil;
  FButtonFaceChangeLink:=TChangeLink.Create;
  FButtonFaceChangeLink.OnChange:=GetChange;

  FButtonFaceController:=nil;
  FButtonFaceControllerLink:=TLMDChangeLink.Create;
  FButtonFaceControllerLink.OnChange:=GetButtonFaceIMLChange;
  FCaptionDown:=1;
  LMDMMInitFace(FButtonFaceIndices);

  FTransCol:=clWhite;

  // ??
  {AllowMouseOver:=True;}
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomMMButton.Destroy;
begin
  FButtonFaceControllerLink.OnChange:=nil;
  FButtonFaceChangeLink.OnChange:=nil;

  FreeAndNil(FButtonFaceControllerLink);
  FreeAndNil(FButtonFaceChangeLink);
  FQuickDraw:=false;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomMMButton.Synchronize(const aValue: Boolean=false);
begin
  LMDMMSynchronize(FButtonFaceIndices, aValue);
end;

end.
