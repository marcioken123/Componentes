unit LMDPopupMenu;
{$I lmdcmps.inc}
interface

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

LMDPopupMenu unit (RM)
---------------------
Simple TPopup descendant which adds various properties to add 'bar' effects
known from Windows StartMenu. Useful e.g. for TrayIcon applications

ToDo
----
* Add more effects for menu background, Menu font etc.
* Check SetImageList method

Note
----
ImageList, ListIndex, ImageIndex or Bitmap property specify LogoBitmap in Bar.
If ImageList<>nil ImageList is used, otherwise Bitmap property

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

uses
  Windows, SysUtils, Classes, Graphics, Menus, Forms, ImgList,
  intfLMDBase, LMDBase, LMDCont, LMDGraph, LMDGraphUtils, LMDCustomImageList,
  LMDFillObject, LMDFXCaption, LMDBevel, LMDGlyphTextLayout, LMDStrings, LMDTypes;

type
  TLMDPopUpOptions=set of (poDisplayBar, poUseAppTitle);
  TLMDOnPopUpEvent = procedure (Sender:TObject; X,Y:Integer; var Cancel:Boolean) of Object;

const
  def_PopUpOptions=[poDisplayBar, poUseAppTitle];

type
  TLMDPopupMenu = class(TPopupMenu, ILMDComponent)
  private
    FAbout         : TLMDAboutVar;
    FBevel         : TLMDBevel;
    FImageList     : TCustomImageList;
    FIndex,
    FListIndex     : Integer;
    FFont          : TFont;
    FFillObject    : TLMDFillObject;
    FFontFx        : TLMDFxCaption;
    FGlyphTextLayout : TLMDGlyphTextLayout;
    FHeight,
    FGap,
    FWidth         : Word;
    FOptions       : TLMDPopupOptions;
    FCaption       : String;
    FDummy,
    FDrawing       :Boolean;
    FBitmap,
    FBack          :TBitmap;
    FOnBeforePopUp :TLMDOnPopUpEvent;
    FOnAfterPopup  :TNotifyEvent;
    procedure SetBitmap(aValue:TBitmap);
    procedure SetDummy(aValue:Boolean);
    procedure SetFont(aValue:TFont);
    procedure SetBevel(aValue:TLMDBevel);
    procedure SetFontFx(aValue:TLMDFxCaption);
    procedure SetFillObject(aValue:TLMDFillObject);
    procedure SetGlyphText (aValue:TLMDGlyphTextLayout);
    procedure SetOptions(aValue:TLMDPopupOptions);
    // ImageList Support
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetIndex(index, aValue:Integer);
    {saving}
    {----}
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function  HasControl:Boolean;
    procedure FakeReadMethod(Reader: TReader);
    {----  }
  protected
    procedure DefineProperties(Filer:TFiler);override;
    function IMLEmpty:Boolean;
    // these two routines perform custom drawing features
    procedure LMDMeasureItem(Sender:TObject;aCanvas:TCanvas; var Width, Height: Integer);
    procedure LMDDrawItem(Sender:TObject;aCanvas: TCanvas; aRect: TRect;State:TOwnerDrawState);
    procedure Notification(AComponent:TComponent; Operation: TOperation); override ;
    // 7.0.61
    procedure DoAfterPopup;virtual;

    //--> Hide
    property OwnerDraw:Boolean read FDummy write SetDummy stored false;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Popup(X, Y: Integer); override;
    //new V8
    function getLMDPackage:TLMDPackageID;virtual;
    // -----
  published
    property About:TLMDAboutVar read FAbout write FAbout;
    property Bitmap:TBitmap read FBitmap write SetBitmap;
    property Layout:TLMDGlyphTextLayout read FGlyphTextLayout write SetGlyphText;
    property BarWidth:Word read FWidth write FWidth default 26;
    property BarGap:Word read FGap write FGap default 1; // Gap between Bar and Drawing of default menu items
    property Bevel:TLMDBevel read FBevel write SetBevel;
    property Caption:String read FCaption write FCaption;
    property FillObject:TLMDFillObject read FFillObject write SetFillObject;
    property Font: TFont read FFont write SetFont;
    property FontFX:TLMDFxCaption read FFontFx write SetFontFx;
    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ImageIndex:Integer index 0 read FIndex write SetIndex default 0;
    property ListIndex:Integer index 1 read FListIndex write SetIndex default 0;
    property Options:TLMDPopUpOptions read FOptions write SetOptions default def_PopUpOptions;
    property OnBeforePopup:TLMDOnPopUpEvent read FOnBeforePopUp write FOnBeforePopUp;
    property OnAfterPopUp:TNotifyEvent read FOnAfterPopup write FOnAfterPopup;
  end;

implementation
uses
  Types,
  {$IFDEF LMDCOMP16}System.UITypes,{$endif}
  LMDProcs, LMDClass;
  {********************** Class TLMDPopupMenu ***********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDPopupMenu.SetBevel(aValue:TLMDBevel);
begin
  FBevel.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.SetBitmap(aValue: TBitmap);
begin
  FBitmap.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.SetDummy(aValue:Boolean);
begin
end;

{------------------------------------------------------------------------------}
Procedure TLMDPopupMenu.SetFillObject(aValue:TLMDFillObject);
begin
  FFillObject.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.SetFontFx(aValue:TLMDFxCaption);
begin
  FFontFx.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.SetFont(aValue:TFont);
begin
  FFont.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.SetGlyphText (aValue : TLMDGlyphTextLayout);
begin
  FGlyphTextLayout.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.SetOptions(aValue:TLMDPopupOptions);
begin
  FOptions:=aValue;
  inherited OwnerDraw:=poDisplayBar in FOptions;
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.SetImageList(aValue:TCustomImageList);
begin
  {if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);}
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      {FImageList.RegisterChanges(FChangeLink);}
      FImageList.FreeNotification(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.SetIndex(index, aValue:Integer);
begin
  case index of
    0: if (aValue=FIndex) or (aValue<0) then exit else FIndex:=aValue;
    1: if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDPopupMenu.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDPopupMenu.IMLEmpty:Boolean;
begin
  result:=not ((FImageList<>nil) and LMDIMLIsValidItem(FImageList, FListIndex, FIndex));
end;

{------------------------------------------------------------------------------}
function TLMDPopupMenu.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------ Protected -------------------------------------}
procedure TLMDPopupMenu.LMDDrawItem(Sender: TObject; aCanvas: TCanvas; aRect: TRect; State: TOwnerDrawState);
var
  MenuItem:TMenuItem;
  FText:string;
  tmp:TRect;
  aBitmap:TBitmap;

  procedure DrawMenu(dRect:TRect);
  var
    OnDraw:TAdvancedMenuDrawItemEvent;
  begin
    OnDraw:=MenuItem.OnAdvancedDrawItem;
    MenuItem.OnAdvancedDrawItem:=nil;
    DrawMenuItem(MenuItem, aCanvas, dRect, State);
    MenuItem.OnAdvancedDrawItem := OnDraw;
  end;

begin
  MenuItem:=TMenuItem(Sender);
  if not (poDisplayBar in FOptions) then
    begin
      DrawMenu(aRect);
      Exit;
    end;

  // at first perform Standard VCL Drawing
  DrawMenu(Rect(aRect.Left+FWidth+FGap,aRect.Top, aRect.Right, aRect.Bottom));

  if FDrawing then
    begin
      tmp:=Rect(0,aRect.Top, FWidth, aRect.Bottom);
      aCanvas.CopyRect(tmp, FBack.Canvas, tmp);
    end
  else
    //if aRect.Bottom>=FHeight then// JH otherwise a popup menu with more items as displayable on the screen (scrolled menu) will not be drawn correctly!!!!!,  20.03.2001
      with FBack do
        begin
          // now we paint our bar
          tmp:=Rect(0,0,FWidth, FHeight);
          FBack.Width:=FWidth;
          FBack.Height:=FHeight;
          FText:=FCaption;
          if LMDAnsiEmpty(FText) and (poUseAppTitle in FOptions) then
            if Application.Handle<>0 then FText:=Application.Title;
          FFillObject.FillCanvas(Canvas, tmp, FFillObject.Brush.Color);
          tmp:=FBevel.PaintBevel(Canvas, tmp, True);

          Canvas.Font:=FFont;
          if not IMLEmpty then
            begin
              aBitmap := TBitmap.Create;
              try
                LMDIMLItemBitmap(FImageList, ListIndex, ImageIndex, aBitmap);
                LMDDrawTextAndGlyph(Canvas, FText, FFontFx, tmp, aBitmap, nil, FGlyphTextLayout,
                                    False, False, True, [TLMDDrawTextStyle(True)], 0);
              finally
                aBitmap.Free;
              end
            end
          else
              LMDDrawTextAndGlyph(Canvas, FText, FFontFx, tmp, FBitmap, nil, FGlyphTextLayout,
                                  False, False, True, [TLMDDrawTextStyle(True)], 0);
          aCanvas.Draw(0,0, FBack);
          FDrawing:=True;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.FakeReadMethod(Reader: TReader);
begin
  Reader.ReadIdent;
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
  Filer.DefineProperty('OwnerDraw', FakeReadMethod, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.DoAfterPopup;
begin
  if Assigned(FOnAfterPopup) then FOnAfterPopup(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.LMDMeasureItem(Sender: TObject; aCanvas: TCanvas; var Width, Height: Integer);
begin
  if not (poDisplayBar in FOptions) then exit;
  Width:=Width+FWidth+FGap;
  if TMenuItem(Sender).Visible then
    FHeight:=FHeight+Height;
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.Popup(X, Y: Integer);
var
  i: Integer;
  DummyList:TCustomImageList;
  c:Boolean;
begin
  c:=false;
  if Assigned(FOnBeforePopUp) then
     FOnBeforePopUp(Self,X,Y,c);
  if c then exit;

  DummyList:=nil;
  FBack:=TBitmap.Create;
  FDrawing:=false;
  try
    // init height of PopupMenu
    FHeight:=0;
    // assign own event handlers
    for i:=0 to Items.Count-1 do
      begin
        Items[i].OnMeasureItem:=LMDMeasureItem;
        Items[i].OnAdvancedDrawItem:=LMDDrawItem;
      end;
    // we have to workaround a problem with DrawItem here, if no bitmap
    // to MenuItem or no ImageList to Popupmenu is assigned, automatic
    // drawing of checked and selected items does not work.
    if Images=nil then
      begin
        DummyList:=TCustomImageList.Create(nil);
        Images:=DummyList;
      end;
    inherited Popup(X, Y);
    DoAfterPopup;
  finally
    if Assigned(DummyList) then
      begin
        Images:=nil;
        DummyList.Free;
      end;
    FBack.Free;
    FBack:=nil;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPopupMenu.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FImageList) then SetImageList(nil);
end ;

{---------------------------- Public ------------------------------------------}
constructor TLMDPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWidth:=26;
  FGap:=1;
  FOptions:=def_PopUpOptions;
  FListIndex:=0;
  FIndex:=0;
  FImageList:=nil;
  FBitmap:=TBitmap.Create;
  //FChangeLink:=TLMDChangeLink.Create;

  FBevel:=TLMDBevel.Create;
  FFont:=TFont.Create;
  with FFont do
    begin
      Color := clWhite;
      Name:='Arial';
      Size:=14;
      Style := [fsBold, fsItalic];
    end;

  FFontFx:=TLMDFxCaption.Create;
  with FFontFx do
    begin
      Angle:=90;
    end;

  FFillObject:=TLMDFillObject.Create;
  with FFillObject do
    begin
      Gradient.ColorCount:=64;
      Gradient.Color:=clBlack;
      Gradient.EndColor:=clBlue;
      Style:=sfGradient;
    end;

  FGlyphTextLayout:=TLMDGlyphTextLayout.Create;
  with FGlyphtextLayout do
    begin
      AlignText2Glyph:=taTop;
      Alignment:=agBottomCenter;
      OffSetY:=-2;
    end;

  inherited OwnerDraw := True;
end;

{------------------------------------------------------------------------------}
destructor TLMDPopupMenu.Destroy;
begin
  If Assigned(FBack) then
    FBack.Free;

  FBitmap.Free;
  FGlyphTextLayout.Free;
  FBevel.Free;
  FFont.Free;
  FFontFx.Free;

  FFillObject.Free;
  //FChangeLink.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDPopupMenu.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

end.
