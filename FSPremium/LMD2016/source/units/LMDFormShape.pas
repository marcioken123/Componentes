unit LMDFormShape;
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

LMDFormShape unit (RM, JH)
-------------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Controls, Forms, Dialogs, SysUtils, Messages, ImgList,
  intfLMDBackground, LMDBase, LMDClass, LMDCont, LMDGraph, LMDCustomImageList,
  LMDBaseController, LMDFillObject, LMDWndProcComponent, LMDRegion;

type

  { -------------------------------------------------------------------------- }
  TLMDFormShape = class(TLMDWndProcComponent, ILMDBackground)
  private
    FRegion       : TLMDBorderRegion;
    FRegionHandle : HRGN;

    FRegioning,
    FUseRgnBitmap,
    FRightMouseBtn,
    FFormDragable,
    FFormCaption  : Boolean; //Form verschieben mit MouseClick mittenrein
    FFillObject   : TLMDFillObject;
    FBack         : TBitmap;
    RegionRect    : TRect;
    FListIndex,
    FImageIndex,
    FCaptionH     : Integer;
    FChangeLink   : TChangeLink;
    FImageList    : TCustomImageList;

    procedure SetBoolean (index : Integer;aValue : Boolean);
    procedure SetRegion (aValue : TLMDBorderRegion);
    procedure SetFillObject (aValue : TLMDFillObject);
    procedure SetInteger (index, aValue : Integer);
    procedure SetImageList (aValue : TCustomImageList);
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    procedure GetIMLChange(Sender:TObject);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure WndProc(var Message: TMessage);override;
    procedure Loaded; override;
    procedure GetChange (Sender : TObject); override;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;

    // 7.0
    function BackBitmap : TBitmap;
    function BackBitmapPalette: HPalette;
    function BackBitmapCheck : Boolean;
    function BackMapPoint (const aValue : TPoint) : TPoint;
    function BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word):Boolean;
    function isTransparentSet: Boolean;
    procedure BackUpdate;
    function BackControl (index: Integer): TControl;
    function BackControlCount: Integer;
    // ---
    procedure SetPolygonShape (const points : array of TPoint);
    procedure SetRegionShape (region : HRGN);
    procedure SetBitmapShape (aBitmap:TBitmap; aTransparentColor:TColor);

    procedure PaintBorder(DC : HDC);
    procedure ReRegion;
  published
    property About;
    property Enabled;
    property Region : TLMDBorderRegion read FRegion write SetRegion;
    property ShowFormCaption : Boolean index 0 read FFormCaption write SetBoolean default true;
    property FormDragable : Boolean index 1 read FFormDragable write SetBoolean default true;
    property UseRgnBitmap : Boolean index 2 read FUseRgnBitmap write SetBoolean default true;
    property FillObject : TLMDFillObject read FFillObject write SetFillObject;
    property ImageList : TCustomImageList read FImageList write SetImageList stored HasControl;
    property ListIndex : Integer index 0 read FListIndex write SetInteger default 0;
    property ImageIndex : Integer index 1 read FImageIndex write SetInteger default 0;
  end;

implementation

uses

  LMDBmp,
  LMDCustomControl;

{ ************************** TLMDFormShape ************************************}
{ ---------------------------  private  -------------------------------------- }
procedure TLMDFormShape.SetPolygonShape (const points : array of TPoint);
begin
  FRegion.SetUserPolygonRgn (points);
  ReRegion;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.SetRegionShape (region : HRGN);
begin
  FRegion.SetUserRgn (region);
  ReRegion;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.SetBoolean (index : Integer;aValue : Boolean);
begin
  case index of
    0 : if aValue <> FFormCaption then
          begin
            FFormCaption := aValue;
            ReRegion;
          end;
    1 : FFormDragable := aValue;
    2 : if aValue <> FUseRgnBitmap then
          begin
            FUseRgnBitmap := aValue;
            GetChange(nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.SetRegion (aValue : TLMDBorderRegion);
begin
  FRegion.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.SetFillObject (aValue : TLMDFillObject);
begin
  FFillObject.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.SetInteger (index, aValue : Integer);
begin
  case index of
    0: FListIndex := aValue;
    1: FImageIndex := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.SetImageList (aValue : TCustomImageList);
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
procedure TLMDFormShape.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShape.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDFormShape.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShape.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
end;

{------------------------------------------------------------------------------}
function TLMDFormShape.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShape.GetIMLChange(Sender:TObject);
begin
  GetChange(sender);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.PaintBorder(DC : HDC);
var
  Canvas : TCanvas;
  aRect : TRect;
  helpRGN : HRGN;
begin
//  if csLoading in ComponentState then exit;

  if DC = 0 then //for component editor
    DC := self.WndOwner.Canvas.Handle;

  Canvas := TCanvas.Create;
  try
    Canvas.Handle := DC;

//    OffsetRgn (FRegion.Handle, 0, - Canvas.ClipRect.Top);
    aRect := RegionRect;
    aRect := Rect(0,0, WndOwner.ClientWidth, WndOwner.ClientHeight);
    //  InflateRect (aRect, -1, -1);
      if (FUseRgnBitmap) and (FRegion.Shape = rsBitmap) then
        begin
          if not (csDesigning in ComponentState) then
            Canvas.Draw (0, 0, FRegion.Mask.BorderBmp)
          else //design time only !!!!!
            if FRegion.Mask.RegionDataSize <> 0 then //if there is a bitmap region
              begin
                //build region

                helpRGN := ExtCreateRegion (nil, FRegion.Mask.RegionDataSize, FRegion.Mask.RegionData^);

                //move region to top of window
                OffsetRgn (helpRGN, 0, - Canvas.ClipRect.Top);
                //paint region frame
                FrameRgn (DC, helpRGN, Canvas.Brush.Handle, 1, 1);
                //destroy created region
                DeleteObject (helpRGN);
              end;
        end
      else
        if FFillObject.Style <> sfNone then
          begin
            FBack.Width := aRect.Right;
            FBack.Height := aRect.Bottom;
            if (FillObject.Style = sfBitmapList) and (FImageList <> nil) and
               LMDIMLIsValidItem(FImageList,FListIndex, FImageIndex) then
              LMDIMLItemBitmap(FImageList, FListIndex, FImageIndex, FFillObject.ListBitmap);
            FFillObject.FillCanvas (FBack.Canvas, aRect, clWhite);
            if not (csDesigning in ComponentState) then
              Canvas.Draw (0, 0, FBack);
          end;
        FRegion.PaintRegionShape (Canvas, aRect);
  finally
    Canvas.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.ReRegion;
var
  tbx, tby,
  th : integer;
  FRegionHandle2,
  fr2 : HRGN;
  p : TRect;
  FMini : boolean;
begin
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then exit;

  if WS_MINIMIZE AND GetWindowLong (WndHandle, GWL_STYLE) = WS_MINIMIZE then
    FMini := true
  else
    FMini := false;

  FRegioning := true;
  case WndOwner.BorderStyle of
    bsSizeable,
    bsSizeToolWin : begin
                      tbx := GetSystemMetrics (SM_CXSIZEFRAME);
                      tby := GetSystemMetrics (SM_CYSIZEFRAME);
                    end;
    else
      begin
        tbx := GetSystemMetrics (SM_CXFIXEDFRAME);
        tby := GetSystemMetrics (SM_CXFIXEDFRAME);
      end;
  end;

  th := 0;
  case WndOwner.BorderStyle of
    bsDialog,
    bsSingle,
    bsSizeable : th := GetSystemMetrics (SM_CYCAPTION);
    bsNone : th := 0;//GetSystemMetrics (SM_CYCAPTION);
    bsToolWindow, bsSizeToolWin : th := GetSystemMetrics (SM_CYSMCAPTION);
  end;
  if (WndOwner.BorderStyle = bsNone) and not (csDesigning in ComponentState) then
     begin
       tby :=0;
       tbx :=0;
     end;

  if not FMini and (FRegion.Shape = rsBitmap) then
    begin
      WndOwner.SetBounds(WndOwner.Left, WndOwner.Top, FRegion.Mask.BorderBmp.Width+FRegion.Shadow.Depth+tbx*2,
                                    FRegion.Mask.BorderBmp.Height+th+tby*2+FRegion.Shadow.Depth);
    end;

  p := Rect (0, 0, WndOwner.Width - tbx * 2, WndOwner.Height - tby *2 - th);
  InflateRect (p, 1, 1);

  FRegionHandle2 := CreateRectRgn (0,0,1,1);
  try
    if not FMini {(WndOwner.WindowState in [wsNormal, wsMaximized])} then
      begin
        RegionRect := p;
        FRegion.CreateRegion (p);

        CombineRgn (FRegionHandle2, FRegion.CreatedHandle, 0, RGN_COPY);

        OffsetRgn (FRegionHandle2, tbx, th + tby);
        if (FRegion.Shadow.Style <> hssNone) then
          begin
  //          sd := FRegion.Shadow.Depth;
            fr2 := CreateRectRgn (0,0,1,1);
            try
              CombineRgn (fr2, FRegionHandle2, 0, RGN_COPY); //duplicate rgn
              OffsetRgn (fr2, FRegion.Shadow.Depth, FRegion.Shadow.Depth); //move duplicted region
              CombineRgn (FRegionHandle2, fr2, FRegionHandle2, RGN_OR); //union between duplicate and original (shadow area now included)
            finally
              DeleteObject (fr2);
            end;
          end;

        Fr2 := CreateRectRgn (0, 0, WndOwner.Width, th + tby);
        try
          if ((FFormCaption) and not (WndOwner.BorderStyle = bsNone)) or (csDesigning in ComponentState) then
            CombineRgn (FRegionHandle2, FRegionHandle2, Fr2, RGN_OR)
          else
            CombineRgn (FRegionHandle2, FRegionHandle2, Fr2, RGN_DIFF); //to remove any existing pieces of the title bar
        finally
          DeleteObject (Fr2);
        end;
      end
    else
      begin
        FRegion.CreateSpecialRectRgn (Rect(0,0, WndOwner.Width, th + tby));
        CombineRgn (FRegionHandle2, FRegion.CreatedHandle, 0, RGN_COPY);
      end;

    if not (csDesigning in ComponentState) then
      begin
        SetWindowRgn (WndOwner.Handle, 0, false);

        // old FRegionHandle needs not to be destroyed, because
        // Windows handles this itself
        FRegionHandle := CreateRectRgn (0,0,1,1);
        CombineRgn (FRegionHandle, FRegionHandle2, 0, RGN_COPY);

        SetWindowRgn (WndOwner.Handle, FRegionHandle, true);
      end;

    FCaptionH := th;
  finally
     // 7.01
    DeleteObject(FRegionHandle2);
     // ----
    FRegioning := false;
  end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.WndProc(var Message: TMessage);
var
  p : TPoint;
begin
  case Message.Msg of
    WM_DESTROY:
         begin
           FDestroying:=True;
           RestoreWndProc
         end;
    WM_ERASEBKGND: begin
{
                         exit;
                       end;}
//                     PaintBorder (WndOwner.Canvas.Handle);
//                     ReRegion;
                     if  ((FFillObject.Style = sfNone) and (FRegion.Shape <> rsBitmap)) then
                       begin
                         inherited WndProc (Message);
//                         exit;
                       end;

                     PaintBorder (TWMEraseBkGnd(Message).DC);

//                     PaintBorder (WndOwner.Canvas.Handle);
//                     ReRegion;
                     Message.Result := 1;
                     exit;
                   end;
         WM_Size:
           begin
//             inherited WndProc (Message);
             ReRegion;
             if WndHandle<>0 then
              InvalidateRect(WNDHandle, nil, true);

              BackUpdate;

              exit;
           end;
    WM_CAPTURECHANGED : begin
                          inherited WndProc(Message);
                          FRightMouseBtn := false;
                        end;
    WM_NCRBUTTONDOWN :
      begin
        inherited WndProc(Message);
        FRightMouseBtn := true;
      end;
    WM_NCRBUTTONUP :
      begin
        inherited WndProc(Message);
        FRightMouseBtn := false;
      end;
    WM_NCHITTEST:
      begin
        inherited WndProc(Message);
        if FFormDragable then
          begin

            p:=SmallPointToPoint (TWMMouse(Message).Pos);

            ScreenToClient (TForm(Owner).Handle,p);
            if (Message.Result in [HTCLIENT]) and (TForm(Owner).ControlAtPos(p, False)= nil) {no TGraphicControl under the mouse :-)}
            and not FRightMouseBtn {we should not prevent every mouse action} then
                Message.Result := HTCAPTION;
          end;
      end;
    WM_SHOWWINDOW{24}:begin
                        inherited WndProc(Message);
                      end;
(*    WM_SIZING{532}:;*)
    WM_STYLECHANGED{125}:begin
                            inherited WndProc(Message);
                          end;
(*    WM_STYLECHANGING{124}:begin
                            inherited WndProc(Message);
                            ReRegion;
                          end;*)
(*    WM_USERCHANGED{84}:;
*)
(*    WM_WINDOWPOSCHANGING{70}:*)
(*    WM_LBUTTONDOWN: begin
                      FLButtonDown := true;
                      ReRegion;
                    end;
(*    WM_LBUTTONUP:FLButtonDown := false;
    WM_NCLBUTTONDOWN : {Message.wParam := HTCAPTION};
    WM_MOUSEMOVE: begin
//                    PostMessage (TForm(Owner).Handle, WM_NCMOUSEMOVE, HTCAPTION, Message.lParam);
{                    Message.Msg := WM_NCMOUSEMOVE;
                    Message.WParam := HTCAPTION;}
                  end;
    //WM_WININICHANGE:;*)
//        WM_NCCALCSIZE :begin inherited WndProc (Message);ReREgion;  end;
    else
      inherited WndProc (Message);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.Loaded;
begin
  inherited Loaded;

  if Enabled then
    ReRegion;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
  ReRegion;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FImageList) then SetImageList(nil);
end ;

{ ---------------------------------------------------------------------------- }
function TLMDFormShape.BackBitmap : TBitmap;
begin
  result := nil;
  if (FUseRgnBitmap) and (FRegion.Shape = rsBitmap) then
    result := FRegion.Mask.BorderBmp
  else
    if (FFillObject.Style <> sfNone) and (FBack <> nil) then
      result := FBack;
    //else result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFormShape.BackBitmapPalette: HPalette;
begin
  if BackBitmapCheck then
    result := BackBitmap.Palette
  else
    Result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFormShape.BackBitmapCheck : Boolean;
begin
  result := false;
  if ((FUseRgnBitmap) and (FRegion.Shape = rsBitmap)) or (FFillObject.Style <> sfNone) and
     not (csDesigning in ComponentState) and not (FBack.Empty){JH Oct 02} then
    result := true;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFormShape.BackMapPoint (const aValue : TPoint) : TPoint;
begin
  result := aValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFormShape.BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word):Boolean;
var
  aRect : TRect;
begin
  result := BackBitmapCheck;
  if result then
    begin
      aRect := dest;
      OffsetRect (aRect, -aRect.Left, -aRect.Top);
      OffSetRect (aRect, src.X, src.Y);
      Canvas.CopyRect (dest, BackBitmap.Canvas, aRect);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFormShape.isTransparentSet: Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.BackUpdate;
begin
  LMDBackUpdate (self, self.WndOwner);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFormShape.BackControl (index: Integer): TControl;
begin
  result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFormShape.BackControlCount: Integer;
begin
  result := 0;
end;

{ ----------------------------------- public --------------------------------- }
constructor TLMDFormShape.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  FRegion := TLMDBorderRegion.Create;
  FRegion.Owner := TWinControl(aOwner);
  FRegion.OnChange := GetChange;

  FRegionHandle := 0;
  FFormCaption := true;

  FRightMouseBtn := false;
  FFormDragable := true;
  FUseRgnBitmap := true;

  FFillObject := TLMDFillObject.Create;
  FFillObject.OnChange := GetChange;
  FBack := TBitmap.Create;

  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetIMLChange;

  RegionRect := Rect (0,0,0,0);

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      raise ELMDOneInstError.Create(self.ClassName,0);
end;

{ --------------------------------------------------------------------------- }
destructor TLMDFormShape.Destroy;
begin
  FChangeLink.OnChange := nil;
  FChangeLink.Free;

  FBack.Free;
  FFillObject.OnChange := nil;
  FFillObject.Free;
  FRegion.OnChange := nil;
  FRegion.Owner := nil;
  FreeAndNil(FRegion);

  // Not required, because Windows deletes Handle itself
  //if FRegionHandle <> 0 then
  //  DeleteObject (FRegionHandle);

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormShape.SetBitmapShape(aBitmap: TBitmap; aTransparentColor: TColor);
var
  tmp1, tmp2, tmpH:HRGN;
begin
  Enabled:=false;
  tmp1:=LMDBmpCreateRgn(aBitmap, aTransparentColor);
  tmp2:=CreateRectRgn (1,1,aBitmap.Width-1,aBitmap.Height-1);
  tmph:=CreateRectRgn(1,1,1,1);
  CombineRgn(tmpH, tmp2, tmp1, RGN_DIFF);
  try
    if Region.Shape<>rsUserRegion then
      Region.Shape:=rsUserRegion;
    SetRegionShape(tmph);
    Enabled:=True;
    if ValidOwner then
      begin
        PaintBorder(WndOwner.Canvas.Handle);
        WndOwner.Invalidate;
      end;
  finally
    DeleteObject(tmp1);
    DeleteObject(tmp2);
    DeleteObject(tmpH);
  end;
end;

end.
