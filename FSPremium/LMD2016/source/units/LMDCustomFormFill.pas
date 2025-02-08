unit LMDCustomFormFill;
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

LMDCustomFormFill unit (RM)
----------------------------


Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Messages, Controls, ImgList,
  intfLMDBackground, LMDBaseController, LMDWndProcComponent, LMDCont,
  LMDCustomImageList;

type
  TLMDPaintMode=(pcNone, pcControl, pcOwnerDraw);
  TLMDPaintEvent=procedure(Sender:TObject; aCanvas:TCanvas; Dest:TRect) of object;

  TLMDCustomFormFill = class(TLMDWndProcComponent, ILMDBackground)
  private
    {imagelist support}
    FImageList  : TCustomImageList;
    FIndex,
    FListIndex  : Integer;
    FChangeLink : TChangeLink;
    FDefaultFill: Boolean;
    FPaintMode  : TLMDPaintMode;
    FOnPaint    : TLMDPaintEvent;
    FBuffered   : Boolean;
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetIndex(index, aValue:Integer);
    {saving}
    {--- }
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    {function HasIML:Boolean;}
    {----  }
    procedure SetPaintMode(aValue:TLMDPaintMode);
  protected
    FFlag,  
    EraseBack   : Boolean;
    FBack       : TBitmap;
    function  IMLEmpty: Boolean;
    procedure GetChange(Sender: TObject); override;
    procedure GetIMLChange(Sender: TObject); virtual;
    procedure Init; override;
    procedure DestroyBuffer;
    procedure Invalidate(flag: Boolean);
    function  PaintClientArea(DC: HDC):Boolean; virtual;
    procedure RestoreState; override;
    procedure WndProc(var Message: TMessage); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property  Buffered: Boolean read FBuffered write FBuffered default false;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function  BackBitmap: TBitmap;
    function  BackBitmapCheck: Boolean;
    function  BackDrawArea(Canvas: TCanvas; const dest: TRect; const src: TPoint; flags:Word): Boolean;
    function  isTransparentSet: Boolean;
    function  BackMapPoint(const aValue: TPoint):TPoint;
    function  BackBitmapPalette: HPalette;
    procedure BackUpdate;
    function BackControl (index: Integer): TControl;
    function BackControlCount: Integer;

  published
    property About;
    property DefaultFill:Boolean read FDefaultFill write FDefaultFill default True;
    property Enabled;
    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ImageIndex:Integer index 0 read FIndex write SetIndex default 0;
    property ListIndex:Integer index 1 read FListIndex write SetIndex default 0;
    property PaintMode:TLMDPaintMode read FPaintMode write SetPaintMode default pcControl;
    property OnPaint:TLMDPaintEvent read FOnPaint write FOnPaint;
  end;

implementation

uses
 Types, SysUtils, LMDClass;

{ --------------------------- Private ---------------------------------------- }
procedure TLMDCustomFormFill.SetImageList(aValue:TCustomImageList);
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

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.SetIndex(index, aValue:Integer);
begin
  case index of
    0: if (aValue=FIndex) or (aValue<0) then exit else FIndex:=aValue;
    1: if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  end;
  if FImageList<>nil then GetIMLChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.SetPaintMode(aValue:TLMDPaintMode);
begin
  if FPaintMode<>aValue then
    begin
      FPaintMode:=aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.GetIMLChange(Sender:TObject);
begin
  Invalidate(True);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.HasControl:Boolean;
begin
  Result := (FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{ ---------------------------------------------------------------------------- }
{function TLMDBack.HasIML:Boolean;
begin
  result:=not (FImageList<>nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) and (aComponent=FImageList) then
    SetImageList(nil);
end;

{ --------------------------- Protected -------------------------------------- }
function TLMDCustomFormFill.IMLEmpty:Boolean;
begin
  result:=not ((FImageList<>nil) and LMDIMLIsValidItem(FImageList, FListIndex, ImageIndex));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.GetChange(Sender:TObject);
begin
  if Enabled and not (csDesigning in ComponentState) then
   begin
     DestroyBuffer;
     FFlag:=True;
     Invalidate(True);
   end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.Init;
begin
  if Enabled then
    begin
      inherited Init;
      if not (csLoading in ComponentState) then Invalidate(True);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.DestroyBuffer;
begin
  if Assigned (FBack) then FreeAndNil(FBack);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.Invalidate;
begin
  // 7.0!!! Prevent any updates when control is currently destroyed
  if (csDestroying in ComponentState) then exit;

  if WndHandle<>0 then
    InvalidateRect(WNDHandle, nil, True);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.PaintClientArea(DC:HDC):Boolean;
var
  aCanvas:TCanvas;
begin
  result:=false;
  if [csLoading, csDestroying]*ComponentState<>[] then exit;
  case FPaintMode of
    pcOwnerDraw:
      if Assigned(FOnPaint) then
        begin
          aCanvas:=TCanvas.Create;
          aCanvas.Handle:=DC;
          try
            if fDefaultFill then
              with aCanvas, WndOWner do
                begin
                  Brush.Color:=Color;
                  FillRect(ClientRect);
                end;
            FOnPaint(Self, aCanvas, Rect(0,0, WndOwner.ClientWidth, WndOwner.ClientHeight));
            result:=true;
          finally
            aCanvas.Handle:=0;
            aCanvas.Free;
          end;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.RestoreState;
begin
  inherited;
  {if not (csDestroying in ComponentState) then}
  Invalidate(True);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.WndProc(var Message: TMessage);
begin

   if not Enabled then
     begin
       inherited WndProc(Message);
       exit;
     end;

   with Message do
     begin
       case msg of
        { -----------Messages for Client Drawing ----------------------------- }
         WM_ERASEBKGND:

          if PaintClientArea(TWMEraseBkGnd(Message).DC) then

             begin
               result:= 1;
               exit;
             end;
         WM_HSCROLL,
         WM_VSCROLL:
           if WndHandle<>0 then
             begin
              InvalidateRect(WNDHandle, nil, False);
              BackUpdate;
             end;
         WM_Size:
           begin
//             DestroyBuffer;
             FFLag:= True;
             if WndHandle<>0 then
               InvalidateRect(WNDHandle, nil, EraseBack);
             BackUpdate;
           end;
         //WM_PAINT:
         WM_PALETTECHANGED:
           begin {DestroyBuffer;}
             Invalidate(True);
             BackUpdate;
           end;
       end;
       inherited WndProc(Message);
     end;
end;

{ --------------------------- Public ----------------------------------------- }
constructor TLMDCustomFormFill.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FPaintMode  := pcControl;
  FDefaultFill:= True;
  FFlag       := False;
  EraseBack   := False;

  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange:= GetIMLChange;
  FImageList  := nil;
  FIndex      := 0;
  FListIndex  := 0;
  FBuffered   := false;

  FBack       := nil;

  {if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      raise LMDEOneInstError.Create(self.ClassName,0);}
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomFormFill.Destroy;
begin
  FChangeLink.OnChange:= nil;
  FreeAndNil(FChangeLink);
  DestroyBuffer;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.BackBitmap: TBitmap;
begin
  result := FBack;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.BackBitmapCheck: Boolean;
begin
  result := Assigned(FBack);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.BackDrawArea(Canvas: TCanvas; const dest: TRect;
                                         const src: TPoint; flags:Word): Boolean;
begin
  result := false;
  if BackBitmapCheck then
    begin
      result := true;
      with BackMapPoint (src) do
        Canvas.CopyRect(dest, FBack.Canvas, Bounds (X, Y,
                                                    dest.Right-dest.Left,
                                                    dest.Bottom-dest.Top));
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.isTransparentSet: Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.BackMapPoint(const aValue: TPoint):TPoint;
begin
  result := aValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.BackBitmapPalette: HPalette;
begin
  result := 0;
  if BackBitmapCheck then
    result := BackBitmap.Palette;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormFill.BackUpdate;
begin
  LMDBackUpdate (self, self.WndOwner);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.BackControl (index: Integer): TControl;
begin
  result := WndOwner.Controls[index];
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormFill.BackControlCount: Integer;
begin
  result := WndOwner.ControlCount;
end;

end.
