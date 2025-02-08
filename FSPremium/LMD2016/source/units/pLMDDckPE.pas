unit pLMDDckPE;
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

pLMDDckPE unit (YB)
-------------------
Unit contains property editors needed in LMD DockingPack.

Changes
-------
Release 4.0 (January 2009)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Types, TypInfo, Graphics, ImgList, Controls,
  Forms, ToolsAPI, DesignIntf {$IFDEF LMDCOMP9}, PaletteAPI,
  ComponentDesigner{$ENDIF}, DesignEditors, DesignMenus, TreeIntf, VCLSprigs,
  VCLEditors, LMDDckCst, LMDDckClass, LMDDckSite, LMDDckStyles, ExtCtrls;

type
  { ************************ TLMDDockSiteCompEditor ************************** }

  TLMDDockSiteCompEditor = class(TDefaultEditor)
  private
    procedure GetParams(out ASite: TLMDDockSite; out AZone: TLMDDockZone);
    function  FindEmptyChild(AZone: TLMDDockZone): TLMDDockZone;
  public
    function  GetVerbCount: Integer; override;
    function  GetVerb(Index: Integer): string; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  {************************ TLMDDockStyleNameProperty *************************}

  TLMDDockStyleNameProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {*********************** TLMDDockImageIndexProperty *************************}

  TLMDDockImageIndexProperty = class(TIntegerProperty, ICustomPropertyListDrawing)
  protected
    function GetImages: TCustomImageList; virtual;
    function GetImagesPropertyName: string; virtual;
  protected
    { ICustomPropertyListDrawing }

    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
                               var AWidth: Integer);
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
                                var AHeight: Integer);
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
                            const ARect: TRect; ASelected: Boolean);
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {******************** TLMDHeaderButtonImageIndexProperty ********************}

  TLMDHeaderButtonImageIndexProperty = class(TLMDDockImageIndexProperty)
  protected
    function GetImagesPropertyName: string; override;
  end;

  {*************************** TLMDDockPanelSprig *****************************}

  TLMDDockPanelSprig = class(TWinControlSprig)
  public
    function DragOverTo(AParent: TSprig): Boolean; override;
    function DragDropTo(AParent: TSprig): Boolean; override;
  end;

  {************************** TLMDNewDockPanelItem ****************************}

  {$IFDEF LMDCOMP9}
  TLMDNewDockPanelItem = class(TInterfacedObject, IOTABasePaletteItem,
                               IOTAPaletteDragDropOp)
  private
    FPalette:      IOTAPaletteServices;
    FHelpName:     string;
    FHintText:     string;
    FName:         string;
    FVisible:      Boolean;
    FEnabled:      Boolean;
    FNewPanel:     TLMDDockPanel;
    FNewPanelName: string;
    FCurSite:      TLMDDockSite;

    procedure CancelDrag;
    function  TryGetSite(X, Y: Integer; out ASite: TLMDDockSite): Boolean;
  protected
    { IOTABasePaletteItem }

    function  GetCanDelete: Boolean;
    function  GetHelpName: string;
    function  GetHintText: string;
    function  GetIDString: string;
    function  GetName: string;
    function  GetVisible: Boolean;
    function  GetEnabled: Boolean;
    procedure SetHelpName(const Value: string);
    procedure SetName(const Value: string);
    procedure SetVisible(const Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetHintText(const Value: string);
    procedure Execute;
    procedure Delete;

    { IOTAPaletteDragDropOp }

    procedure DragOver(Target: IOTAPaletteDragAcceptor; X, Y: Integer;
                       State: TPalDragState; var Accept: Boolean);
    procedure DragDrop(Target: IOTAPaletteDragAcceptor; X, Y: Integer);
  public
    constructor Create(const APalette: IOTAPaletteServices);

    class procedure Register(const APage: string);
    class procedure Unregister;
  end;
  {$ENDIF}

implementation

const
  RESET_SETTINGS = 'Reset current style settings';

{ ******************************** Globals *********************************** }
{ ---------------------------------------------------------------------------- }
procedure GetDesignerSelectionImpl(AComponent: TComponent;
  ASelection: TList);
var
  i:    Integer;
  dsnr: IDesigner;
  seln: IDesignerSelections;
begin
  dsnr := FindRootDesigner(AComponent) as IDesigner;

  if dsnr <> nil then
  begin
    seln := TDesignerSelections.Create;
    dsnr.GetSelections(seln);

    for i := 0 to seln.Count - 1 do
      ASelection.Add(seln[i]);
  end;
end;

procedure SetDesignerSelectionImpl(AComponent: TComponent);
var
  i:        Integer;
  dsnr:     IDesigner;
  src, dst: IDesignerSelections;
  found:    Boolean;
begin
  dsnr := FindRootDesigner(AComponent) as IDesigner;

  if dsnr <> nil then
  begin
    dsnr.CreateCurrentComponent(AComponent, Rect(0, 0, 0, 0));

    if dsnr.GetShiftState = [ssLeft, ssShift] then
    begin
      src   := TDesignerSelections.Create;
      dst   := TDesignerSelections.Create;
      found := False;

      dsnr.GetSelections(src);

      for i := 0 to src.Count - 1 do
      begin
        if src[i] = AComponent then
        begin
          found := True;
          Continue; // for
        end;

        dst.Add(src[i]);
      end;

      if not found then
        dst.Add(AComponent);

      dsnr.SetSelections(dst);
    end
    else
      dsnr.SelectComponent(AComponent);
  end;
end;

function GetDesignerActionImpl(AComponent: TComponent): TLMDDesignerAction;
{$IFDEF LMDCOMP9}
var
  pal:  IOTAPaletteServices;
  tool: IOTABasePaletteItem;
  citm: IOTAComponentPaletteItem;
  dsnr: IDesigner;
{$ENDIF}
begin
  Result := paUnknown;

  {$IFDEF LMDCOMP9}
  pal := BorlandIDEServices as IOTAPaletteServices;

  if pal <> nil then
  begin
    tool := pal.SelectedTool;

    if (tool <> nil) and
       (tool.QueryInterface(IOTAComponentPaletteItem, citm) = S_OK) then
      Result := paInsert
    else
    begin
      dsnr := FindRootDesigner(AComponent) as IDesigner;

      if (dsnr <> nil) and (ssCtrl in dsnr.GetShiftState) then
        Result := paSelectChildren
      else
        Result := paMove;
    end;
  end;
  {$ENDIF}
end;

{ ************************* TLMDDockSiteCompEditor *************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDDockSiteCompEditor.GetParams(out ASite: TLMDDockSite;
  out AZone: TLMDDockZone);
begin
  ASite := nil;
  AZone := nil;

  if Component is TLMDDockSite then
  begin
    ASite := Component as TLMDDockSite;
    AZone := ASite.RootZone;
  end
  else
  begin
    ASite := (Component as TLMDDockPanel).Site;
    AZone := (Component as TLMDDockPanel).Zone;
  end;

  if (AZone.Parent <> nil) and (AZone.Parent.Kind = zkTabs) then
    AZone := AZone.Parent;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSiteCompEditor.FindEmptyChild(
  AZone: TLMDDockZone): TLMDDockZone;
var
  i: Integer;
begin
  Result := nil;
  if AZone.IsEmpty then
    Result := AZone
  else
    for i := 0 to AZone.ZoneCount - 1 do
    begin
      Result := FindEmptyChild(AZone.Zones[i]);
      if Result <> nil then
        Break; // for
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSiteCompEditor.GetVerbCount: Integer;
begin
  Result := 5;
  if Component is TLMDDockPanel then
    Inc(Result, 2);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockSiteCompEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0:  begin
          if Component is TLMDDockPanel then
            Result := SLMDDckNewPanelTabs
          else
            Result := SLMDDckNewPanelCenter;
        end;
    1:  Result := SLMDDckNewPanelLeft;
    2:  Result := SLMDDckNewPanelRight;
    3:  Result := SLMDDckNewPanelTop;
    4:  Result := SLMDDckNewPanelBottom;
    5:  Result := '-';
    6:  Result := SLMDDckSetAsSpace;
  else
    Result := '';
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSiteCompEditor.PrepareItem(Index: Integer;
  const AItem: IMenuItem);
var
  site: TLMDDockSite;
  zone: TLMDDockZone;
begin
  GetParams(site, zone);

  AItem.Visible := (zone <> nil) and not zone.IsAutoHidden;
  if Index = 0 then
  begin
    AItem.Enabled := (zone <> nil) and ((zone.Kind = zkTabs) or
                                        (zone.ZoneCount = 0) or
                                        (FindEmptyChild(zone) <> nil));
  end;

  if (csAncestor in Component.ComponentState) and
     (Index >= 0) and (Index <= 4) then
    AItem.Enabled := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockSiteCompEditor.ExecuteVerb(Index: Integer);
const
  VERB_SIDE: array[0..4] of TAlign = (alClient, alLeft, alRight, alTop,
                                      alBottom);
var
  site: TLMDDockSite;
  pnl:  TLMDDockPanel;
  zone: TLMDDockZone;
begin
  GetParams(site, zone);

  case Index of
    0..4:
    begin
      if (Index = 0) and (zone <> nil) and
         ((zone.Kind <> zkTabs) and (zone.ZoneCount > 0)) then
        zone := FindEmptyChild(zone);

      if (zone <> nil) and not zone.IsAutoHidden then
      begin
        pnl := TLMDDockPanel.Create(site.Owner);
        try
          pnl.Name := Designer.UniqueName(pnl.ClassName);

          site.DockControl(pnl, zone, VERB_SIDE[Index]);
          Designer.SelectComponent(pnl);
          Designer.Modified;
        except
          pnl.Free;
          raise;
        end;
      end;
    end;
    6:
    begin
      if (zone <> nil) and not zone.IsAutoHidden then
        zone.ResizeKind := zrkSpace;
      Designer.Modified;
    end;
  end;
end;

{------------------------- TLMDDockImageIndexProperty -------------------------}
{ ---------------------------------------------------------------------------- }

function TLMDDockImageIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList];
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockImageIndexProperty.GetImages: TCustomImageList;
var
  cmp: TPersistent;
begin
  cmp    := GetComponent(0);
  Result := TCustomImageList(GetObjectProp(cmp, GetImagesPropertyName,
                             TCustomImageList));
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockImageIndexProperty.GetImagesPropertyName: string;
begin
  Result := 'Images';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockImageIndexProperty.GetValues(Proc: TGetStrProc);
var
  i:    Integer;
  imgs: TCustomImageList;
begin
  imgs := GetImages;
  if imgs <> nil then
  begin
    for i := 0 to imgs.Count - 1 do
      Proc(IntToStr(i));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockImageIndexProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  tr: TRect;
  b:  TBitmap;
  imgs: TCustomImageList;
begin
  tr   := ARect;
  imgs := GetImages;

  if imgs <> nil then
  begin
    Inc(tr.Left, 1 + imgs.Width + 1);

    with ARect do
      ACanvas.FillRect(Rect(Left, Top, tr.Left, Bottom));

    b := TBitmap.Create;
    try
      b.Width  := imgs.Width;
      b.Height := imgs.Height;
      if imgs.Height > ARect.Bottom - ARect.Top - 2 then
        b.Height := ARect.Bottom - ARect.Top - 2;

      b.Canvas.Brush.Color := ACanvas.Brush.Color;
      b.Canvas.FillRect(Rect(0, 0, b.Width, b.Height));
      imgs.Draw(b.Canvas, 0, 0, StrToInt(Value));

      ACanvas.Draw(ARect.Left + 1, ARect.Top + 1, b);
    finally
      b.Free;
    end;
  end;
  with tr, ACanvas do
    ACanvas.TextRect(tr, Left + 1, (Top + Bottom - TextHeight(Value)) div 2, Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockImageIndexProperty.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
var
  imgs: TCustomImageList;
begin
  imgs    := GetImages;
  AHeight := ACanvas.TextHeight('Wg');

  if (imgs <> nil) and (AHeight < 1 + imgs.Height + 1) then
    AHeight := 1 + imgs.Height + 1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockImageIndexProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
  imgs: TCustomImageList;
  i:    Char;
  wd:   Integer;
begin
  AWidth := 0;
  for i := '0' to '9' do
  begin
    wd := ACanvas.TextWidth(i);
    if wd > AWidth then
      AWidth := wd;
  end;
  AWidth := ACanvas.TextWidth('-') + (7 * AWidth);

  imgs := GetImages;
  if imgs <> nil then
    Inc(AWidth, 1 + imgs.Width + 1);
end;

{ ******************* TLMDHeaderButtonImageIndexProperty ********************* }
{ ---------------------------------------------------------------------------- }
function TLMDHeaderButtonImageIndexProperty.GetImagesPropertyName: string;
begin
  Result := 'ButtonImages';
end;

{ *************************** TLMDDockPanelSprig ***************************** }
{ ---------------------------------------------------------------------------- }
function TLMDDockPanelSprig.DragDropTo(AParent: TSprig): Boolean;
begin
  Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDockPanelSprig.DragOverTo(AParent: TSprig): Boolean;
begin
  Result := False;
end;

{ ************************* TLMDNewDockPanelItem ***************************** }
{ ---------------------------------------------------------------------------- }
{$IFDEF LMDCOMP9}
procedure TLMDNewDockPanelItem.CancelDrag;
begin
  if (FNewPanel <> nil) and (FCurSite <> nil) then
    FNewPanel.CancelDesignDrag(FCurSite);
  if FNewPanel <> nil then
    FNewPanel.Free;

  FNewPanel := nil;
  FCurSite  := nil;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDNewDockPanelItem.Create(const APalette: IOTAPaletteServices);
begin
  inherited Create;

  FPalette  := APalette;
  FHintText := 'Drag this item onto the TLMDDockSite '#13#10 +
               'instance to create new panel.';
  FName     := '- New dock-panel (drag me on site)';
  FVisible  := True;
  FEnabled  := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.Delete;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.DragDrop(Target: IOTAPaletteDragAcceptor;
  X, Y: Integer);
var
  dsnr: IDesigner;
begin
  if FNewPanel = nil then
    Exit;

  dsnr := FindRootDesigner(FCurSite) as IDesigner;

  if dsnr = nil then
  begin
    CancelDrag;
    Exit;
  end;

  FCurSite.Owner.InsertComponent(FNewPanel);
  FNewPanel.Name := FNewPanelName;  // (Re)Naming should be AFTER owner
                                    // change, otherwise the Delphi's
                                    // designer will not update form's
                                    // published fields.

  FNewPanel.UpdateDesignDrag(FCurSite, False, True, True, False, False,
                             Point(X, Y));

  if FNewPanel.Site = FCurSite then // If has been docked.
  begin
    dsnr.SelectComponent(FNewPanel);
    dsnr.Modified;

    FNewPanel := nil;
    FCurSite  := nil;
  end
  else
    CancelDrag;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.DragOver(Target: IOTAPaletteDragAcceptor;
  X, Y: Integer; State: TPalDragState; var Accept: Boolean);
var
  mrk:      IOTADesignerDragAcceptor;
  site:     TLMDDockSite;
  dsnr:     IDesigner;
  starting: Boolean;
begin
  site   := nil;
  dsnr   := nil;
  Accept := (Target.QueryInterface(IOTADesignerDragAcceptor, mrk) = S_OK) and
            TryGetSite(X, Y, site);

  if Accept then
  begin
    dsnr   := FindRootDesigner(site) as IDesigner;
    Accept := Accept and (dsnr <> nil);
  end;

  if (FCurSite <> site) or not Accept or (State = pdsDragLeave) then
    CancelDrag;

  if Accept and (State <> pdsDragLeave) then
  begin
    if FCurSite <> site then
      CancelDrag;
    starting := (FNewPanel = nil);

    if starting then
    begin
      FCurSite          := site;
      FNewPanelName     := dsnr.UniqueName(TLMDDockPanel.ClassName);
      FNewPanel         := TLMDDockPanel.Create(nil);
      FNewPanel.Caption := FNewPanelName;
      FNewPanel.Width   := 64;
      FNewPanel.Height  := 64;
    end;

    FNewPanel.UpdateDesignDrag(FCurSite, starting, False, True, False, False,
                               Point(X, Y));
  end
  else
    CancelDrag;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.Execute;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }
function TLMDNewDockPanelItem.GetCanDelete: Boolean;
begin
  Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNewDockPanelItem.GetHelpName: string;
begin
  Result := FHelpName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNewDockPanelItem.GetHintText: string;
begin
  Result := FHintText;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNewDockPanelItem.GetIDString: string;
begin
  Result := 'TLMDDockPanel.New';
end;

{ ---------------------------------------------------------------------------- }
function TLMDNewDockPanelItem.GetName: string;
begin
  Result := FName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNewDockPanelItem.GetVisible: Boolean;
var
  root: IRoot;
begin
  Result := FVisible and
            FPalette.ContainsPaletteState(cPSDesignerActive) and
            FPalette.ContainsPaletteState('NativeDesignerActive');

  if Result then
  begin
    // Using ComponentDesigner unit is a hack.

    root   := ComponentDesigner.ActiveRoot;
    Result := (root <> nil) and (root.Root is TWinControl);

    // Another way to impl:
    //    sitm   := FPalette.BaseGroup.FindItemByName(TLMDDockSite.ClassName,
    //                                                True);
    //    Result := (sitm <> nil) and (sitm.Visible);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNewDockPanelItem.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

{ ---------------------------------------------------------------------------- }
class procedure TLMDNewDockPanelItem.Register(const APage: string);
var
  pal: IOTAPaletteServices;
  g:   IOTAPaletteGroup;
  itm: IOTABasePaletteItem;
begin
  pal := BorlandIDEServices as IOTAPaletteServices;

  if pal <> nil then
  begin
    g   := pal.BaseGroup.AddGroup(APage, APage);
    itm := TLMDNewDockPanelItem.Create(pal);

    g.AddItem(itm);
    pal.ItemAdded(g, itm);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.SetHelpName(const Value: string);
begin
  FHelpName := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.SetHintText(const Value: string);
begin
  FHintText := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.SetName(const Value: string);
begin
  FName := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNewDockPanelItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNewDockPanelItem.TryGetSite(X, Y: Integer;
  out ASite: TLMDDockSite): Boolean;
var
  cur: TControl;
begin
  cur := FindDragTarget(Point(X, Y), True);

  while cur <> nil do
  begin
    if cur is TLMDDockSite then
    begin
      ASite  := TLMDDockSite(cur);
      Result := True;
      Exit;
    end;
    cur := cur.Parent;
  end;

  Result := False;
end;

{ ---------------------------------------------------------------------------- }
class procedure TLMDNewDockPanelItem.Unregister;
var
  pal: IOTAPaletteServices;
begin
  pal := BorlandIDEServices as IOTAPaletteServices;
  if pal <> nil then
    pal.BaseGroup.RemoveItem('TLMDDockPanel.New', True);
end;
{$ENDIF} // LMDCOMP9

{ ---------------------------------------------------------------------------- }
function TLMDDockStyleNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDockStyleNameProperty.GetValues(Proc: TGetStrProc);
var
  i:   Integer;
  stl: TLMDDockStyle;
begin
  for i := 0 to DockStyles.Count - 1 do
  begin
    stl := DockStyles[i];
    if stl.Name <> '' then
      Proc(stl.Name);
  end;
end;

{ ---------------------------------------------------------------------------- }
initialization
  LMDGetDesignerSelectionProc := GetDesignerSelectionImpl;
  LMDSetDesignedSelectionProc := SetDesignerSelectionImpl;
  LMDGetDesignerActionProc    := GetDesignerActionImpl;

{ ---------------------------------------------------------------------------- }
finalization
  LMDGetDesignerSelectionProc := nil;
  LMDSetDesignedSelectionProc := nil;
  LMDGetDesignerActionProc    := nil;

end.
