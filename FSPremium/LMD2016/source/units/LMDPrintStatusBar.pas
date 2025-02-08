unit LMDPrintStatusBar;
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

LMDPrintStatusBar unit (RM)
---------------------------
A predefined statusbar for use with Preview Panel (for printing tasks).

Changes
-------
Release 8.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  LMDCustomStatusBar, LMDPrintPreviewPanel, LMDTypes;

type
  TLMDPrintStatusPanel = (pspPage, pspScale, pspPageSize, pspOrientation);

  TLMDPrintStatusPanels = set of TLMDPrintStatusPanel;

  {Margin
   Left. Top Right, bottom Header Footer}
const
  def_PrintStatusPanels=[pspPage, pspPageSize, pspOrientation, pspScale];

type
  TLMDPrintStatusBar = class(TLMDCustomStatusBar)
  private
    FPreviewPanel: TLMDPrintPreviewPanel;
    FChangeLink: TLMDPrintChangeLink;
    FPanels: TLMDPrintStatusPanels;

    procedure SetPreviewPanel(AValue: TLMDPrintPreviewPanel);
    procedure SetPanels(AValue: TLMDPrintStatusPanels);
    procedure GetUpdateBar(Sender: TObject);
    function GetPanel(AIndex: TLMDPrintStatusPanel): TLMDStatusPanel;
  protected
    procedure InitStatusBar;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateBar;
    property CtlXP;
    property InfoPanel[Index:TLMDPrintStatusPanel]: TLMDStatusPanel read GetPanel;
  published
    property PreviewPanel: TLMDPrintPreviewPanel read FPreviewPanel write SetPreviewPanel;

    property Alignment;
    property Font3D;
    property SizeGrip default true;
    property ControlGap;
    // inherited
    property Bevel;
    property ThemeMode;
    property ThemeGlobalMode;    
    property InfoPanels: TLMDPrintStatusPanels read FPanels write SetPanels default def_PrintStatusPanels;
  end;

implementation

  uses Printers, LMDPrinter, LMDPrintConst;

{*********************** TLMDPrintStatusBar ***********************************}
{---------------------------- private -----------------------------------------}
procedure TLMDPrintStatusBar.SetPreviewPanel(AValue: TLMDPrintPreviewPanel);
begin
  if FPreviewPanel<>nil then
    FPreviewPanel.UnRegisterChanges(FChangeLink);

  FPreviewPanel := AValue;

  if FPreviewPanel<>nil then
  begin
    FPreviewPanel.RegisterChanges(FChangeLink);
    FPreviewPanel.FreeNotification(Self);
  end;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintStatusBar.SetPanels(AValue: TLMDPrintStatusPanels);
begin
  if FPanels<>AValue then
  begin
    FPanels := AValue;

    if not (csLoading in ComponentState) then
      InitStatusBar;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintStatusBar.GetUpdateBar(Sender: TObject);
begin
  if ([csLoading, csReading, csDestroying]*ComponentState<>[]) then
    Exit;
    UpdateBar;
end;

{------------------------------------------------------------------------------}
function TLMDPrintStatusBar.GetPanel(AIndex: TLMDPrintStatusPanel): TLMDStatusPanel;
var
  i: Integer;
begin
  Result := nil;

  for i:=0 to Panels.Count-1 do
    if Panels[i].Tag = Ord(AIndex)+1 then
    begin
      Result := Panels[i];
      Break;
    end;
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDPrintStatusBar.Loaded;
begin
  inherited;

  InitStatusBar;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintStatusBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (Operation=opRemove) and (aComponent is TLMDPrintPreviewPanel) then
    if (aComponent=FPreviewPanel) then
      SetPreviewPanel(nil);
end;

{--------------------------- public -------------------------------------------}
constructor TLMDPrintStatusBar.Create(AOwner: TComponent);
begin
  inherited;

  OldStyle := False;

  FChangeLink := TLMDPrintChangeLink.Create;
  FChangeLink.OnChange := GetUpdateBar;

  FPanels := def_PrintStatusPanels;

  AutoSizeLastPanel := true;

  InitStatusBar;
end;

{------------------------------------------------------------------------------}
destructor TLMDPrintStatusBar.Destroy;
begin
  FChangeLink.OnChange := nil;
  FreeAndNil(FChangeLink);

  inherited;
end;

procedure TLMDPrintStatusBar.InitStatusBar;
var
  i: TLMDPrintStatusPanel;
begin
  Panels.Clear;

  for i:=Low(TLMDPrintStatusPanel) to High(TLMDPrintStatusPanel) do
    if i in FPanels then
    with Panels.Add do
    begin
      Tag  := Ord(i)+1;
      Size := 100;
    end;
end;

procedure TLMDPrintStatusBar.UpdateBar;
var
    Units: TLMDMeasureUnits;
    Pr: TLMDPrinterBase;
    H, W: Double;
begin
  if pspPage in FPanels then
    InfoPanel[pspPage].Text := Format(SLMDPrintSbPage, [FPreviewPanel.CurrentPage+1,
                                                        FPreviewPanel.TotalPages]);

  if pspPageSize in FPanels then
  begin
    if FPreviewPanel.PrinterHelper<>nil then
    begin
      Pr := FPreviewPanel.PrinterHelper.GetPrinter;
      Units := Pr.RealUnits;

      case pr.Orientation of
        poPortrait:
        begin
          W := Pr.PageWidthFullUnits;
          H := Pr.PageHeightFullUnits;
        end;

        poLandscape:
        begin
          H := Pr.PageWidthFullUnits;
          W := Pr.PageHeightFullUnits;
        end;
      else
        H := -1; W := -1;
        Assert(false);
      end;

      if Units = unMillimeters then
        InfoPanel[pspPageSize].Text := Format(SLMDPrintSbPageSizeMm,
                                              [Round(W), Round(H)])
      else if Units = unInches then
        InfoPanel[pspPageSize].Text := Format(SLMDPrintSbPageSizeInch, [W, H])
      else
        Assert(false);
    end
    else
    begin
      InfoPanel[pspPageSize].Text := '';
    end;
  end;

  if pspOrientation in FPanels then
  begin
    if FPreviewPanel.PrinterHelper<>nil then
    begin
      Pr := FPreviewPanel.PrinterHelper.GetPrinter;

      if Pr.Orientation=poPortrait then
        InfoPanel[pspOrientation].Text := SLMDPrintSbPortrait
      else
        InfoPanel[pspOrientation].Text := SLMDPrintSbLandscape;
    end
    else
    begin
      InfoPanel[pspPageSize].Text := '';
    end;
  end;

  if pspScale in FPanels then
    InfoPanel[pspScale].Text := Format(SLMDPrintSbScale,
                                       [FPreviewPanel.RealScale]);

end;

end.
