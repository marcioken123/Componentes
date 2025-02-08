unit LMDIdeAlignPltte;
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

LMDIdeAlignPltte unit (YB)
------------------------
TLMDAlignPalette unit.

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, intfLMDBase, LMDTypes, LMDSvcPvdr, LMDDsgDesigner, LMDIdeCst;

type
  {**************************** TLMDAlignPalette ******************************}

  TLMDAlignPalette = class;

  TLMDAlignPaletteForm = class(TForm)
    btnHorzCenter: TSpeedButton;
    btnLeft: TSpeedButton;
    btnHorzCenterInWindow: TSpeedButton;
    btnHorzSpaceEqually: TSpeedButton;
    btnRight: TSpeedButton;
    btnVertCenter: TSpeedButton;
    btnTop: TSpeedButton;
    btnVertCenterInWindow: TSpeedButton;
    btnVertSpaceEqually: TSpeedButton;
    btnBottom: TSpeedButton;
    procedure btnsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPalette: TLMDAlignPalette;

    procedure DoAlign(AHorzAlign, AVertAlign: TLMDDesignerAlignType);
    function  GetButtonHint(ATag: Integer): TLMDString;
  public
    constructor Create(APalette: TLMDAlignPalette); reintroduce;
    destructor Destroy; override;
  end;

  TLMDAlignPalette = class(TComponent, ILMDComponent)
  private
    FAbout:           TLMDAboutVar;
    FForm:            TLMDAlignPaletteForm; // Can be nil.
    FFormTop:         Integer;
    FFormLeft:        Integer;
    FVisible:         Boolean;
    FDesigner:        TLMDDesigner;
    FServiceProvider: TLMDServiceProvider;
    FAlwaysOnTop:     Boolean;

    procedure SetDesigner(const Value: TLMDDesigner);
    procedure SetFormLeft(const Value: Integer);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure SetFormTop(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
    function  GetVisible: Boolean;
    function  GetFormLeft: Integer;
    function  GetFormTop: Integer;
    procedure SetAlwaysOnTop(const Value: Boolean);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Show;
    procedure Hide;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Designer: TLMDDesigner read FDesigner write SetDesigner;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property FormLeft: Integer read GetFormLeft write SetFormLeft default 0;
    property FormTop: Integer read GetFormTop write SetFormTop default 0;
    property Visible: Boolean read GetVisible write SetVisible default False;
    property AlwaysOnTop: Boolean read FAlwaysOnTop write SetAlwaysOnTop default False; 
  end;

implementation

{$R *.dfm}

{*************************** TLMDAlignPaletteForm *****************************}
{------------------------------------------------------------------------------}

constructor TLMDAlignPaletteForm.Create(APalette: TLMDAlignPalette);
begin
  inherited Create(nil);
  FPalette := APalette;
end;

{------------------------------------------------------------------------------}

destructor TLMDAlignPaletteForm.Destroy;
begin
  FPalette.FForm := nil;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDAlignPaletteForm.DoAlign(AHorzAlign,
  AVertAlign: TLMDDesignerAlignType);
begin
  if (FPalette.Designer <> nil) and
     (FPalette.Designer.Active) then
    FPalette.Designer.AlignSelected(AHorzAlign, AVertAlign);
end;
              
{------------------------------------------------------------------------------}

procedure TLMDAlignPaletteForm.btnsClick(Sender: TObject);
const
  HTYPE: array[0..9] of TLMDDesignerAlignType = (
    atLeftTop, atCenter, atCenterInWindow, atSpaceEqually, atRightBottom,
    atNoChanges, atNoChanges, atNoChanges, atNoChanges, atNoChanges);
  VTYPE: array[0..9] of TLMDDesignerAlignType = (
    atNoChanges, atNoChanges, atNoChanges, atNoChanges, atNoChanges,
    atLeftTop, atCenter, atCenterInWindow, atSpaceEqually, atRightBottom);
begin
  DoAlign(HTYPE[Integer(TComponent(Sender).Tag)],
          VTYPE[Integer(TComponent(Sender).Tag)]);
end;
     
{------------------------------------------------------------------------------}

procedure TLMDAlignPaletteForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Caption := SLMDAlignPaletteCaption;

  for i := 0 to ControlCount - 1 do
    if Controls[i] is TSpeedButton then
      Controls[i].Hint := GetButtonHint(Integer(Controls[i].Tag));
end;
           
{------------------------------------------------------------------------------}

function TLMDAlignPaletteForm.GetButtonHint(ATag: Integer): TLMDString;
begin
  case ATag of
    0:  Result := SLMDAlignLeftHint;
    1:  Result := SLMDAlignHCenterHint;
    2:  Result := SLMDAlignHCenterInWindowHint;
    3:  Result := SLMDAlignHSpaceEqHint;
    4:  Result := SLMDAlignRightHint;
    5:  Result := SLMDAlignTopHint;
    6:  Result := SLMDAlignVCenterHint;
    7:  Result := SLMDAlignVCenterInWindowHint;
    8:  Result := SLMDAlignVSpaceEqHint;
    9:  Result := SLMDAlignBottomHint;
  else
    Assert(False);
  end;
end;

{****************************** TLMDAlignPalette ******************************}
{------------------------------------------------------------------------------}

constructor TLMDAlignPalette.Create(AOwner: TComponent);
begin
  inherited;
end;
    
{------------------------------------------------------------------------------}

destructor TLMDAlignPalette.Destroy;
begin
  Hide;
  ServiceProvider := nil;
  Designer := nil;

  FForm.Free;
  inherited;
end;
     
{------------------------------------------------------------------------------}

function TLMDAlignPalette.GetFormLeft: Integer;
begin
  if FForm = nil then
    Result := FFormLeft
  else
    Result := FForm.Left;
end;
           
{------------------------------------------------------------------------------}

function TLMDAlignPalette.GetFormTop: Integer;
begin
  if FForm = nil then
    Result := FFormTop
  else
    Result := FForm.Top;
end;
        
{------------------------------------------------------------------------------}

function TLMDAlignPalette.GetVisible: Boolean;
begin
  if FForm = nil then
    Result := FVisible
  else
    Result := FForm.Visible;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.Hide;
begin
  if FForm <> nil then
    FForm.Hide;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.Loaded;
begin
  inherited;
  if FVisible then
    SetVisible(True);
end;
           
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FDesigner then
      Designer := nil;
    if AComponent = FServiceProvider then
      ServiceProvider := nil;
  end;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.SetDesigner(const Value: TLMDDesigner);
begin
  if FDesigner <> Value then
  begin
    if FDesigner <> nil then
      FDesigner.RemoveFreeNotification(Self);
    FDesigner := Value;
    if FDesigner <> nil then
      FDesigner.FreeNotification(Self);
  end;
end;
           
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.SetFormLeft(const Value: Integer);
begin
  FFormLeft := Value;
  if FForm <> nil then
    FForm.Left := Value;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.SetServiceProvider(
  const Value: TLMDServiceProvider);
begin
  if FServiceProvider <> Value then
  begin
    if FServiceProvider <> nil then
    begin
      FServiceProvider.RemoveFreeNotification(Self);
      FServiceProvider.Members.UnregisterMember(Self);
    end;
    FServiceProvider := Value;
    if FServiceProvider <> nil then
    begin
      FServiceProvider.FreeNotification(Self);
      FServiceProvider.Members.RegisterMember(Self);
    end;
  end;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.SetFormTop(const Value: Integer);
begin
  FFormTop := Value;
  if FForm <> nil then
    FForm.Top := Value;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  
  if not (csDesigning in ComponentState) and
     not (csLoading in ComponentState) then
  begin
    if FVisible then
      Show
    else
      Hide;
  end;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.Show;
begin
  if FForm = nil then
  begin
    FForm      := TLMDAlignPaletteForm.Create(Self);
    FForm.Left := FFormLeft;
    FForm.Top  := FFormTop;
    if FAlwaysOnTop then
      FForm.FormStyle := fsStayOnTop
    else
      FForm.FormStyle := fsNormal;
  end;
  
  FForm.Show;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDAlignPalette.SetAlwaysOnTop(const Value: Boolean);
begin
  FAlwaysOnTop := Value;
  if FForm <> nil then
  begin
    if FAlwaysOnTop then
      FForm.FormStyle := fsStayOnTop
    else
      FForm.FormStyle := fsNormal;
  end;
end;
       
{------------------------------------------------------------------------------}

function TLMDAlignPalette.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;
    
{------------------------------------------------------------------------------}

end.
