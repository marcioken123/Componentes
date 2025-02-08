unit LMDCustomStatusBar;
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

LMDCustomStatusBar unit (JH)
----------------------------
extended status bar control

Changes
-------
Release 8.10 (June 2008)
* OnMouseDown -> default behaviour restored
* OnPanelClick -> correct index number returned

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, Dialogs, Graphics, Messages,
  LMDTypes, LMDGraph, LMDBevel, LMD3DCaption, LMDCustomPanel, LMDCustomBevelPanel, LMDVldBase;

type
  {------------------ TLMDStatusCustomPanel -----------------------------------}
  TLMDStatusPanelStyle = (spText, spOwnerDraw, spPanel);

  TLMDCustomStatusBar = class;

  TLMDStatusCustomPanel=class(TLMDCustomPanel)
  private
    FId : Integer;
    procedure ReadIdent (Reader : TReader);
    procedure WriteIdent (Writer : TWriter);
  protected
    procedure ReadState (Reader : TReader); override;
    procedure DefineProperties (Filer : TFiler); override;
  public
    property BarPanelId : Integer read FId write FId;
  published
    property Color;
    property ParentColor;
  end;

  TLMDStatusPanel = class (TCollectionItem)
  private
    FAlignment : TLMDAlignment;
    FBevel     : TLMDBevel;
    FStyle     : TLMDStatusPanelStyle;
    FText      : String;
    FBarPanelId,
    FLeft,
    FTag,
    FSize      : Integer;
    FFont      : TFont;
    FFont3D    : TLMD3DCaption;
    FControl   : TLMDStatusCustomPanel;
    procedure SetBevel (aValue : TLMDBevel);
    procedure SetFont (aValue : TFont);
    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetText (aValue : String);
    procedure SetInteger (index : Integer;aValue : Integer);
    procedure SetAlignment (aValue : TLMDAlignment);
    procedure SetStyle (aValue : TLMDStatusPanelStyle);
    procedure ReadIdent (Reader : TReader);
    procedure WriteIdent (Writer : TWriter);
  protected
    procedure DefineProperties (Filer : TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Control : TLMDStatusCustomPanel read FControl write FControl;
    property BarPanelId : Integer read FBarPanelId write FBarPanelId stored true default -1;
  published
    property Alignment : TLMDAlignment read FAlignment write SetAlignment default agTopLeft;
    property Bevel : TLMDBevel read FBevel write SetBevel;
    property Style : TLMDStatusPanelStyle read FStyle write SetStyle;
    property Text : String read FText write SetText;
    property Size : Integer index 0 read FSize write SetInteger default 50;
    property Left : Integer index 1 read FLeft write SetInteger default 3;
    property Font : TFont read FFont write SetFont;
    property Font3D : TLMD3DCaption read FFont3D write SetFont3D;
    property Index;
    property DisplayName;
    property Tag:Integer read FTag write FTag;
  end;

  TLMDStatusPanels = class (TCollection)
  private
    FStatusBar: TLMDCustomStatusBar;
    function GetItem(Index: Integer): TLMDStatusPanel;
    procedure SetItem(Index: Integer; Value: TLMDStatusPanel);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(StatusBar: TLMDCustomStatusBar);
    destructor Destroy ; override;
    function Add: TLMDStatusPanel;
    property Items[Index: Integer]: TLMDStatusPanel read GetItem write SetItem; default;
  end;

  TLMDOwnerDrawPanel = procedure (Sender : TObject;Nr : Integer;aRect : TRect;Canvas : TCanvas) of object;
  TLMDOnPanelClick = procedure (Sender : TObject;Nr : Integer) of object;

  { ----------------------- TLMDCustomStatusBar ------------------------------ }
  TLMDCustomStatusBar = class(TLMDCustomBevelPanel, ILMDValidatingMsgControl)
  private
    FAlignment  : TLMDAlignment;
    FSimpleText : String;
    FAutoSizeLastPanel,
    FOldStyle,
    FSimplePanel: Boolean;
    FFont3D     : TLMD3DCaption;
    FPanels     : TLMDStatusPanels;
    FGap        : Integer;
    FOnOwnerDrawPanel : TLMDOwnerDrawPanel;
    FOnPanelClick : TLMDOnPanelClick;

    procedure SetAlignment (aValue : TLMDAlignment);
    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetSimpleText (aValue : String);
    procedure SetBoolean (index : Integer; aValue : Boolean);
    procedure SetGap(aValue:Integer);
    procedure SetPanels (aValue : TLMDStatusPanels);
    procedure WMLButtonDown (var Msg : TWMLBUTTONDOWN); message WM_LBUTTONDOWN;
    procedure WMSize (var Msg : TWMSIZE); message WM_SIZE;
  protected
    InnerRect : TRect;
    //Validation support, May 2006, RS
    FValidationPanelNumber: integer;

    procedure UpdatePanel (Nr : Integer);
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Resize; override;
    procedure Paint; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    property Alignment  : TLMDAlignment read FAlignment write SetAlignment default agTopLeft;
    property Font3D     : TLMD3DCaption read FFont3D write SetFont3D;
    property SimpleText : String read FSimpleText write SetSimpleText;
    property SimplePanel: Boolean index 0 read FSimplePanel write SetBoolean default false;
    property SizeGrip default true;
    property OldStyle   : Boolean index 2 read FOldStyle write SetBoolean default true;
    property AutoSizeLastPanel : Boolean index 3 read FAutoSizeLastPanel write SetBoolean default true;
    property ControlGap : Integer read FGap write SetGap default 0;
    property Panels     : TLMDStatusPanels read FPanels write SetPanels;

    property OnOwnerDrawPanel : TLMDOwnerDrawPanel read FOnOwnerDrawPanel write FOnOwnerDrawPanel;
    property OnPanelClick : TLMDOnPanelClick read FOnPanelClick write FOnPanelClick;
    //Validation support, May 2006, RS
    property ValidationPanelNumber: integer read FValidationPanelNumber write FValidationPanelNumber;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    function GetControlGap:Integer; virtual;
    //Validation support, May 2006, RS
    procedure SetErrorMessage(val : TLMDString; ErrorLevel: integer);
    function GetLastErrorMessage : TLMDString;
  published
    property About;
  end;

implementation

uses
  Types, ComCtrls, CommCtrl, ShellApi, Forms, Themes,
  LMDClass,  LMDThemes,LMDBaseLabel, LMDUtils, LMDGraphUtils;

var
  Registered:Boolean;

{ ************************ class TLMDStatusCustomPanel *********************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDStatusCustomPanel.ReadState (Reader : TReader);
var
  i : Integer;
begin
  inherited ReadState(Reader);
  i := 0;
  while (i < TLMDCustomStatusBar(Parent).Panels.Count) do
    begin
      if BarPanelId = TLMDCustomStatusBar(Parent).Panels[i].BarPanelId then
        begin
          TLMDCustomStatusBar(Parent).Panels[i].Control.Free;
          TLMDCustomStatusBar(Parent).Panels[i].Control := self;
          Exit;
        end;
      inc(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusCustomPanel.DefineProperties (Filer : TFiler);
begin
  inherited DefineProperties (Filer);
  Filer.DefineProperty ('BarPanelId', ReadIdent, WriteIdent, true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusCustomPanel.ReadIdent (Reader : TReader);
begin
  FId := Reader.ReadInteger;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusCustomPanel.WriteIdent (Writer : TWriter);
begin
  Writer.WriteInteger (FId);
end;

{ ****************************** class TLMDStatusPanel *********************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDStatusPanel.SetBevel (aValue : TLMDBevel);
begin
  FBevel.Assign (aValue);
  Changed(false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.SetFont (aValue : TFont);
begin
  FFont.Assign (aValue);
  Changed(false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.SetFont3D (aValue : TLMD3DCaption);
begin
  FFont3D.Assign (aValue);
  Changed(false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.SetText (aValue : String);
begin
  if FText <> aValue then
    begin
      FText := aValue;
      Changed(false);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.SetInteger (index : Integer;aValue : Integer);
begin
  case index of
    0 : if FSize <> aValue then
          begin
            FSize := aValue;
            Changed(true);
          end;
    1 : if FLeft <> aValue then
          begin
            FLeft := aValue;
            Changed(true);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.SetAlignment (aValue : TLMDAlignment);
begin
  if FAlignment <> aValue then
    begin
      FAlignment := aValue;
      Changed(false);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.SetStyle (aValue : TLMDStatusPanelStyle);
{var
  FControl : TLMDStatusCustomPanel;}
begin
  if FStyle <> aValue then
    begin
      if (aValue <> spPanel) and (FStyle = spPanel) and (FControl <> nil) then
        begin
          //suche control und gebe es frei
          FControl.Free;
        end;
      FStyle := aValue;
      if (FStyle = spPanel) and (FControl = nil) and not (csLoading in (TLMDCustomStatusBar(TLMDStatusPanels(GetOwner).GetOwner).Owner.ComponentState)) then
        begin
          FControl := TLMDStatusCustomPanel.Create (TLMDCustomStatusBar(TLMDStatusPanels(GetOwner).GetOwner).Owner);
          FControl.Parent := TLMDCustomStatusBar(TLMDStatusPanels(GetOwner).GetOwner);
          FControl.BarPanelId := TLMDCustomStatusBar(TLMDStatusPanels(GetOwner).GetOwner).ControlCount + 1;
//          FControl.Name;
          BarPanelId := FControl.BarPanelId;
          FControl.Visible := false;
//          FControl.Name := 'kldjgf';
        end;
      Changed(false);
    end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDStatusPanel.Create (Collection : TCollection);
begin
  FBevel := TLMDBevel.Create;
  FBevel.Mode := bmStandard;
  FFont := TFont.Create;
  FFont3D := TLMD3DCaption.Create;
  FSize := 50;
  FLeft := 3;
  FAlignment := agTopLeft;
  FStyle := spText;
  FControl := nil;
  inherited Create (Collection);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDStatusPanel.Destroy;
begin
  if FControl <> nil then
    begin
      FControl.Free;
      FControl := nil;
    end;
  FFont3D.Free;
  FFont.Free;
  FBevel.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.Assign (Source : TPersistent);
begin
  if Source is TLMDStatusPanel then
    begin
      FBevel.Assign ((Source as TLMDStatusPanel).Bevel);
      FSize := (Source as TLMDStatusPanel).Size;
      FLeft := (Source as TLMDStatusPanel).Left;
      FStyle := (Source as TLMDStatusPanel).Style;
      FText := (Source as TLMDStatusPanel).Text;
      FAlignment := (Source as TLMDStatusPanel).Alignment;
      FFont.Assign ((Source as TLMDStatusPanel).Font);
      FFont3D.Assign ((Source as TLMDStatusPanel).Font3D);
      Changed(true);
      Exit;
    end;
  inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.DefineProperties (Filer : TFiler);
begin
  inherited DefineProperties (Filer);
  Filer.DefineProperty ('BarPanelId', ReadIdent, WriteIdent, true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.ReadIdent (Reader : TReader);
begin
  FBarPanelId := Reader.ReadInteger;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanel.WriteIdent (Writer : TWriter);
begin
  Writer.WriteInteger (FBarPanelId);
end;

{ ****************************** class TLMDStatusPanels ********************** }
constructor TLMDStatusPanels.Create(StatusBar: TLMDCustomStatusBar);
begin
  inherited Create(TLMDStatusPanel);
  FStatusBar := StatusBar;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDStatusPanels.Destroy;
begin
  FStatusBar := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDStatusPanels.Add: TLMDStatusPanel;
begin
  result := TLMDStatusPanel(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
function TLMDStatusPanels.GetItem(Index: Integer): TLMDStatusPanel;
begin
  result := TLMDStatusPanel(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
function TLMDStatusPanels.GetOwner: TPersistent;
begin
  result := FStatusBar;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanels.SetItem(Index: Integer; Value: TLMDStatusPanel);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStatusPanels.Update(Item: TCollectionItem);
begin
  if Item <> nil then
    FStatusBar.UpdatePanel(Item.Index) else
    FStatusBar.RePaint;
{    FStatusBar.UpdatePanels(True, False);}
end;

{ *************************** class TLMDCustomStatusBar ********************** }
{ ---------------------------------- private --------------------------------- }
procedure TLMDCustomStatusBar.SetAlignment (aValue : TLMDAlignment);
begin
  if FAlignment <> aValue then
    begin
      FAlignment := aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.SetBoolean (index : Integer; aValue : Boolean);
begin
  case index of
     0 : if FSimplePanel <> aValue then
           begin
             FSimplePanel := aValue;
             GetChange(nil);
           end;
{     1 : if FSizeGrip <> aValue then
           begin
             FSizeGrip := aValue;
             GetChange(nil);
           end;}
     2 : if FOldStyle <> aValue then
           begin
             if (not FOldStyle) and (csDesigning in ComponentState) then
               ShowMessage ('Switching to OldStyle is not recommended. It''s only implemented for being compatible to our old LMDStatusBar!');
             begin
               FOldStyle := aValue;
               GetChange (nil);
             end;
           end;
     3 : if FAutoSizeLastPanel <> aValue then
           begin
             FAutoSizeLastPanel := aValue;
             GetChange (nil);
           end;
  end; { end of case index }
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.SetGap(aValue:Integer);
var
  i:Integer;
begin
  if FGap <> aValue then
    begin
      FGap := aValue;
      for i:=0 to Pred(ControlCount) do
        if (Controls[i] is TLMDBaseLabel) and TLMDBaseLabel(Controls[i]).StatusBarControl then
         TLMDBaseLabel(Controls[i]).CorrectBounds;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.SetFont3D (aValue : TLMD3DCaption);
begin
  FFont3D.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.SetSimpleText (aValue : String);
begin
  if FSimpleText <> aValue then
    begin
      FSimpleText := aValue;
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.SetPanels (aValue : TLMDStatusPanels);
begin
  FPanels.Assign (aValue);
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.WMLButtonDown (var Msg : TWMLBUTTONDOWN);
var
  i, x : Integer;
begin
  inherited;
  if FOldStyle then exit;
  i := 0;
  x := 0;
  while (x < Msg.XPos) and (i < FPanels.Count) do
    begin
      inc (x, FPanels[i].Size);
      if Msg.XPos > x then
        inc(i);
    end;
  if i < FPanels.Count then
    if Assigned (FOnPanelClick) then FOnPanelClick (self, i);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.WMSize(var msg: TWMSize);
begin
  if not (csLoading in ComponentState) then Resize;
  Repaint;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDCustomStatusBar.UpdatePanel (Nr : Integer);
var
  i : Integer;
  aRect : TRect;
begin
  if FOldStyle then Exit; //no panels visible
  if nr = Panels.Count-1 then
    begin
      Paint;
      exit;
    end;
  aRect := InnerRect;
  for i := 0 to nr-1 do
     aRect.Left := aRect.Left + FPanels[i].Left + FPanels[i].Size;
  aRect.Left := aRect.Left + FPanels[Nr].Left;
  aRect.Right := aRect.Left + FPanels[Nr].Size;
  with FPanels[Nr] do
    try
      aRect := Bevel.PaintBevel(Canvas, aRect, false);
      Canvas.Font := Font;
      case Style of
        spText : begin
                   Canvas.Brush.Style := bsSolid;
                   Canvas.Brush.Color := Color;
                   Canvas.FillRect (aRect);
                   LMDDrawTextExt(Canvas, Text, Font3D, aRect,
                   DT_EXPANDTABS or TLMDAlignFlags[FPanels[Nr].Alignment] or
                   DT_SINGLELINE or DT_NOPREFIX,
                   [TLMDDrawTextStyle(Enabled), dtClip], nil);
                 end;
        spOwnerDraw : if Assigned (FOnOwnerDrawPanel) then FOnOwnerDrawPanel (self, Nr, aRect, Canvas);
        spPanel : begin
                    with aRect do
                      Control.SetBounds (Left, Top, Right - Left, Bottom - Top);
                    Control.Visible:=true;
                  end;
      end;
    finally
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.AlignControls(AControl: TControl; var Rect: TRect);
begin
  if SizeGrip then
    Rect.Right := Rect.Right - 12;
  inherited AlignControls(AControl, Rect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.CreateParams(var Params: TCreateParams);
begin
  InitCommonControl(ICC_BAR_CLASSES);
  inherited CreateParams(Params);
  CreateSubClass(Params, STATUSCLASSNAME);
  with Params do
   if SizeGrip then
     begin
       Style := Style or SBARS_SIZEGRIP;
       WindowClass.style := WindowClass.style and not CS_HREDRAW;
     end
   else
     Style := Style or CCS_TOP;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.Loaded;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.Notification(AComponent: TComponent; Operation: TOperation);
var
  i : Integer;
begin
  inherited Notification (AComponent, Operation);
  if (Operation = opRemove) and (AComponent is TLMDStatusCustomPanel) then
    begin
      for i := 0 To Panels.Count - 1 do
        begin
          if Panels[i].Style = spPanel then
            if Panels[i].Control = AComponent then
              begin
                Panels[i].Control := nil;
                Panels[i].Style := spText;
                Exit;
              end;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.Resize;
begin
  inherited Resize;
  ReAlign;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.Paint;
const
  border   = 1;
  gripsize = 13;
var
  bRect,
  aRect : TRect;
  i, j  : Integer;

  procedure PaintGrip (toC : TCanvas);
  var
    i     : Integer;
    bRect : TRect;
    lThemeMode: TLMDThemeMode;
  begin
    lThemeMode := UseThemeMode;
    if UseThemeMode <> ttmNone then
      begin
        bRect := aRect;
        bRect.Left := bRect.Right - 18 - border;
        dec (bRect.Bottom, border);
        inc(bRect.Top, 1);
        LMDThemeServices.DrawElement(lThemeMode, toC.Handle, tsGripperPane, bRect);        
        LMDThemeServices.DrawElement(lThemeMode, toC.Handle, tsGripper, bRect);
        exit;
      end;

    with toC do
      try
        Pen.Color  := Color;
        Brush.Style := bsSolid;
        Brush.Color := Color;
        { erase corner }
        Rectangle (aRect.Right - gripsize, aRect.Bottom - gripsize,
                   aRect.Right, aRect.Bottom);

        Pen.Color := clBtnShadow;
        Pen.Width := 2;
        for i := 0 to 2 do
          begin
            MoveTo (aRect.Right - border - 1, aRect.Bottom - border - gripsize + i * 4 + 2);
            LineTo (aRect.Right - border - gripsize + i * 4 + 2, aRect.Bottom - border - 1);
          end;

        Pen.Color := clWhite;
        Pen.Width := 1;
        for i := 0 to 2 do
          begin
            MoveTo (aRect.Right - border - 1, aRect.Bottom - border - gripsize + i * 4 + 1);
            LineTo (aRect.Right - border - gripsize + i * 4, aRect.Bottom - border);
          end;

        Pen.Color := Color;
        for i := 0 to 2 do
          begin
            MoveTo (aRect.Right - border, aRect.Bottom - border - gripsize + i * 4 + 3);
            LineTo (aRect.Right - border - gripsize + i * 4 + 3, aRect.Bottom - border);
          end;
        if Bevel.BevelExtend > 0 then
          begin
            Pen.Color := clBtnFace;
            MoveTo (aRect.Right - border, aRect.Bottom - border - gripsize + 1);
            LineTo (aRect.Right - border, aRect.Bottom - border);
            LineTo (aRect.Right - border - gripsize, aRect.Bottom - border);
            Pixels [aRect.Right - border, aRect.Bottom - border] := clBtnFace;
          end;
       finally
       end;
  end;

begin
  FillControl;
  aRect := Bevel.PaintBevel(Canvas, GetClientRect, CheckOptimized);
  with canvas do
    try
      //aRect := ClientRect; remobded Aug 02 JH, aRect now result from painting
      //bevel!!!
      { paint borders }

      if FoldStyle then
        begin
          if SizeGrip then
            begin
              PaintGrip (canvas);
              Dec (aRect.Right, gripsize);
            end;
          Inc (aRect.Left, border);
          Inc (aRect.Top, border);
          Dec (aRect.Right, border{*2});
          Dec (aRect.Bottom, border{*2});
        end;

      InnerRect := aRect;
      if FSimplePanel then
        begin
          Canvas.Font.Assign (self.Font);
          if IsThemed then
            LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, tsPane, aRect);
          LMDDrawTextExt(Canvas, FSimpleText, FFont3D, aRect,
                     DT_EXPANDTABS or TLMDAlignFlags[FAlignment] or
                     DT_SINGLELINE or DT_NOPREFIX,
                     [TLMDDrawTextStyle(Enabled), dtClip], nil);

          Exit;
        end { end of if simplepanel }
      else
        if not FOldStyle then
          begin
            for i := 0 to FPanels.Count - 1 do
               with FPanels[i] do
                 begin
                   inc (aRect.Left, Left);
                   j := aRect.Left + Size;
                   if (FAutoSizeLastPanel) and (i = FPanels.Count - 1) and (j < aRect.Right) then // last panel
                     j := aRect.Right;
                   if IsThemed then
                     LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, tsPane, aRect);
                   bRect := Bevel.PaintBevel(Canvas, Rect (aRect.Left, aRect.Top, j, aRect.Bottom), CheckOptimized);
                   Canvas.Font := Font;
                   case Style of
                     spText : LMDDrawTextExt(Canvas, Text, Font3D, bRect,
                               DT_EXPANDTABS or TLMDAlignFlags[FPanels[i].Alignment] or
                               DT_SINGLELINE or DT_NOPREFIX,
                               [TLMDDrawTextStyle(Enabled), dtClip], nil);
                     spOwnerDraw : if Assigned (FOnOwnerDrawPanel) then FOnOwnerDrawPanel (self, i, bRect, Canvas);
                     spPanel :  if Control <> nil then
                                  begin
                                    if (i = Panels.Count - 1) and SizeGrip then
                                      bRect.Right := bRect.Right - gripsize;
                                    with bRect do
                                      Control.SetBounds (Left, Top, Right - Left, Bottom - Top);
                                    Control.Visible:=true;
                                  end;
                   end;
                   inc (aRect.Left, Size);
                 end;
          end;
     if (not FOldStyle) and SizeGrip and
       ((Owner is TForm) and not IsZoomed(TForm(Owner).Handle)) then
       begin
         PaintGrip (canvas);
         Dec (aRect.Right, gripsize);
       end;

    except
    end; { end of with canvas }
end;

{ ----------------------------------- public --------------------------------- }
constructor TLMDCustomStatusBar.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  //ControlStyle:=  ControlStyle + [csOpaque, csClickEvents, csDoubleClicks, csCaptureMouse]
  //                             - [csParentBackground, csAcceptsControls];

  ControlStyle:=  ControlStyle + [csOpaque]{$IFDEF LMDCOMP7}-[csParentBackground]{$ENDIF} +
                  [csClickEvents, csDoubleClicks, csCaptureMouse] - [csAcceptsControls];
  {$IFNDEF LMDCOMP7}
  BeginUpdate; 
  ParentBackground := false; 
  EndUpdate;{$ENDIF}


  FPanels := TLMDStatusPanels.Create(Self);
  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := GetChange;

  inherited SizeGrip:=true;
  FSimplePanel := false;
  FAutoSizeLastPanel := true;
  FOldStyle := true;
  FAlignment := agTopLeft;
  Align := alBottom;
  FGap:=3;
  Height := 19;

  if not Registered then
    begin
      RegisterClass(TLMDStatusCustomPanel);
      Registered:=True;
    end;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomStatusBar.Destroy;
begin
  FFont3D.OnChange:=nil;
  FFont3D.Free;
  FPanels.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomStatusBar.GetControlGap:Integer;
begin
  result:=FGap;
end;

{ ---------------------------------------------------------------------------- }
//Validation support, May 2006, RS
function TLMDCustomStatusBar.GetLastErrorMessage: TLMDString;
begin
  if Self.SimplePanel then
    Result := Self.SimpleText
  else
    if (Self.ValidationPanelNumber > 0)
        and (Self.ValidationPanelNumber < Self.Panels.Count) then
      Result := Self.Panels[Self.ValidationPanelNumber].Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomStatusBar.SetErrorMessage(val: TLMDString; ErrorLevel: integer);
begin
  //if ErrorLevel = 0 then Exit;
  if Self.SimplePanel then
    Self.SimpleText := val
  else
    if (Self.ValidationPanelNumber >= 0)
        and (Self.ValidationPanelNumber < Self.Panels.Count) then
      Self.Panels[Self.ValidationPanelNumber].Text := val;
end;

initialization
  Registered:=False;
end.
