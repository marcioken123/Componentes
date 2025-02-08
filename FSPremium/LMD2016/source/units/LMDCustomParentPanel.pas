unit LMDCustomParentPanel;
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

LMDCustomParentPanel unit (RM)
------------------------------
Base class for all button group components (CheckGroup, RadioGroup etc.)

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Dialogs, Windows, Messages, Classes, Graphics,
  intfLMDBackGround, LMDBase, LMDClass, LMDCustomBevelPanel;

type
  {--------------------- TLMDCustomParentPanel --------------------------------}
  TLMDCustomParentPanel = class(TLMDCustomBevelPanel)
  private
    FQuickDraw:Boolean;
    FFDSupport: Boolean;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    // this message is used only in FormDisplay Mode!!
    procedure CMLMDBackChanged(var Message: TMessage); message CM_LMDBACKCHANGED;
    // ----
    procedure SetFDSupport(const Value: Boolean);
    //procedure ReadIdent(Reader:TReader);
  protected
    FBack:TBitmap;
    function CheckOptimized:Boolean;override;
    procedure CreateBack(aValue:Boolean);virtual;
    procedure DefineProperties(Filer:TFiler);override;
    procedure DoForwardBackFX; override;
    procedure DrawBack(Canvas:TCanvas; aRect:TRect);
    procedure FillControl; override;
    function FormDispSupport:Boolean;
    procedure GetChange(Sender:TObject);override;
    function GetEmpty:Boolean;override;
    procedure GetIMLChange(Sender:TObject);override;
    function GetPalette:HPalette;override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;Operation:TOperation);override;
    procedure Paint;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    function BackBitmapCheck:Boolean; override;
    function BackBitmap: TBitmap; override;
    function BackMapPoint(const aValue:TPoint):TPoint; override;
    function BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word=0):Boolean;override;
    procedure BackUpdate; override;

    property Empty:Boolean read GetEmpty;
    property QuickDraw:Boolean read FQuickDraw write FQuickDraw default false;

    // FormDisplay Support
    property FDSupport:Boolean read FFDSupport write SetFDSupport default false;
  end;

implementation

uses
  Types, Forms, SysUtils,
  LMDSysIn, LMDUtils, LMDProcs, LMDGraphUtils, LMDFormDisplay, LMDCont;

{************************ Class TLMDCustomParentPanel *********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDCustomParentPanel.SetFDSupport(const Value: Boolean);
begin
  if FFDSupport<>Value then
    begin
      FFDSupport := Value;
      if not (csLoading in ComponentState) and not (csDesigning in ComponentState) then
        BackUpdate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomParentPanel.CMLMDBackChanged(var Message: TMessage);
begin
  if (ComponentState * [csReading, csLoading, csDestroying] = []) and FormDispSupport then
    BackUpdate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomParentPanel.WMSize(var Message: TWMSIZE);
begin
  if not (csLoading in ComponentState) then CreateBack(false);
  inherited;
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomParentPanel.ReadIdent(Reader:TReader);
begin
  Reader.ReadBoolean;
end;

{------------------------ Protected -------------------------------------------}
procedure TLMDCustomParentPanel.CreateBack(aValue:Boolean);
var
  flags:Word;
  b: TBitmap;
  tmpt:Boolean;
begin
  tmpt:=GetTransparent;
  if ((IMLEmpty and not tmpt) or (tmpt and not ((GetBackFX.Enabled) and (BackFXPass)))) then
    begin
      if FBack<>nil then FreeAndNil(FBack);
      NeedInvalidate:=True;
      exit;
    end;

  if FBack=nil then
    FBack:=TBitmap.Create;
  if (not aValue) and LMDRectInRect(ClientRect, Rect(0,0,FBack.Width, FBack.Height)) then exit;

  FBack.Width:=Width;
  FBack.Height:=Height;

  flags:=DSF_TILE;
  if not ((aoAutoRealizePalette in LMDApplication.Options) and (LMDSIColorDepth<9)) then
    flags:=flags or DSF_PALETTEREALIZE;

  if tmpt and BackFXPass then
    begin
      FBack.Free;
      FBack := nil;
      if BackBitmap = nil then begin {NeedInvalidate := true;} exit; end;
      b := TBitmap.Create;
      try
        b.Width := Width+1; b.Height := Height+1;
        //get the background image
        BackDrawArea (b.Canvas, ClientRect, Point (0,0), 0);
        FBack := TBitmap.Create;
        FBack.Assign (b);
      finally
        b.Free;
      end
    end
  else
    LMDIMLClipDraw(FBack.Canvas, Rect(0,0, FBack.Width, FBack.Height), flags, 0, 0, ImageList, ListIndex, ImageIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.DoForwardBackFX;
begin
  GetChange (GetBackFX);
end;

{------------------------------------------------------------------------------}
function TLMDCustomParentPanel.CheckOptimized:Boolean;
begin
  result:=(FBack<>nil) or BackBitmapCheck;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.DrawBack(Canvas:TCanvas; aRect:TRect);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.FillControl;
begin
  if CheckOptimized and BackDrawArea(Canvas, ClientRect, Point(0,0), 0) then exit;
  inherited FillControl;
end;

{------------------------------------------------------------------------------}
function TLMDCustomParentPanel.FormDispSupport: Boolean;
begin
  result:=FFDSupport and Transparent and Assigned(Parent) and
          Assigned(Parent.Parent) and (Parent.Parent is TLMDFormDisplay);
end;

{------------------------------------------------------------------------------}
function TLMDCustomParentPanel.GetEmpty:Boolean;
begin
  result:=inherited GetEmpty and IMLEmpty;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.GetIMLChange(Sender:TObject);
begin
  GetChange(Sender);
  BackUpdate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomParentPanel.GetPalette: HPALETTE;
begin
  Result := 0;
  if not IMLEmpty then result:=LMDIMLPalette(ImageList, ListIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.GetChange(Sender:TObject);
begin
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then exit;
  CreateBack(true);
  if Sender=Bevel then
    Perform(CM_LMDBEVELCHANGED,0,0);
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.Loaded;
begin
  inherited Loaded;
  CreateBack(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (aComponent=ImageList) and (Operation = opRemove) then
    begin
      NeedInvalidate:=True;
      ImageList:=nil;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.Paint;
begin
  if csLoading in ComponentState then exit;

  FillControl;

  if GetEmpty then
    begin
      if csDesigning in ComponentState then DrawDashedFrame;
      exit;
    end;

  Bevel.PaintBevel(Canvas, ClientRect, True)
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomParentPanel.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FBack:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomParentPanel.Destroy;
begin
  if Assigned(FBack) then FBack.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomParentPanel.BackBitmapCheck:Boolean;
begin
  //result:=false;
  if not GetTransparent then
    begin
      result:=(FBack<>nil);
      exit;
    end;

  // -> has highest priority
  if FormDispSupport then
    begin
      result:=LMDBackBitmapCheck(Parent.Parent);
      if result then exit;
    end;

  result := inherited BackBitmapCheck;
end;

{------------------------------------------------------------------------------}
function TLMDCustomParentPanel.BackBitmap:TBitmap;
begin
  if FormDispSupport then
    begin
      result:=LMDBackBitmap(Parent.Parent);
      if result<>nil then exit;
    end;

  if FBack <> nil then
    result := FBack
  else
    result := inherited BackBitmap;
end;

{------------------------------------------------------------------------------}
function TLMDCustomParentPanel.BackMapPoint(const aValue:TPoint):TPoint;
begin
  // ToDo
  if FormDispSupport and LMDBackBitmapCheck(Parent.Parent) then
    begin
      result:=LMDBackMapPoint(Parent, aValue);
      exit;
    end;

  if (FBack <> nil) then
    result := aValue
  else
    result := inherited BackMapPoint(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDCustomParentPanel.BackDrawArea(Canvas:TCanvas; const dest:TRect;
                                            const src:TPoint; flags:Word=0):Boolean;
var
  lsrc:TPoint;
  lDest: TRect;
begin
  result := false;
  if csLoading in ComponentState then exit;

  if FormDispSupport and LMDBackBitmapCheck(Parent.Parent) then
    if TLMDFormDisplay(Parent.Parent).BackDrawArea(Canvas, dest, BackMapPoint(src)) then
      begin
        result:=true;
        exit;
      end;

  if FBack = nil then
    result := inherited BackDrawArea(Canvas, dest, src)
  else
    begin
      {--> FillControl}
      if EqualRect(ClientRect, dest) then
        begin
          GetClipBox(Canvas.Handle, lDest);
          lSrc:=Point(lDest.Left, lDest.Top);
        end
      else
        begin
          lSrc:=Point(dest.Left+src.X{-Left}, dest.Top+src.Y{-Top});
          lDest := Dest;
        end;

      if not QuickDraw then
        begin
          SelectPalette(Canvas.Handle, BackBitmapPalette, false);
          RealizePalette(Canvas.Handle);
        end;

      {Paletterealization}
      Canvas.CopyRect(lDest, BackBitmap.Canvas, Bounds(lSrc.X, lSrc.Y, lDest.Right-lDest.Left,
                      lDest.Bottom-lDest.Top));
      result:=True;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomParentPanel.BackUpdate;
begin
  if BackFXPass then
    CreateBack (true);
  inherited;
end;

end.
