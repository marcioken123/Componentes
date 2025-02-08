unit JSDualEditDialog;

interface

{$I lmddlgcmps.inc}

uses
  Classes, Controls, Graphics, SysUtils, JSEditDialog, JSDialogs;

type
  TJSDualEditProperties = class(TPersistent)
  private
    FValue1Caption: string;
    FValue2Caption: string;
    FValue2: string;
    FValue1: string;
    FCaptionAlignment: TJSCaptionAlignment;
    procedure SetValue1(const Value: string);
    procedure SetValue2(const Value: string);
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property CaptionAlignment: TJSCaptionAlignment read FCaptionAlignment write FCaptionAlignment default caRight;
    property Value1: string read FValue1 write SetValue1;
    property Value1Caption: string read FValue1Caption write FValue1Caption;
    property Value2: string read FValue2 write SetValue2;
    property Value2Caption: string read FValue2Caption write FValue2Caption;
  end;

  TJSCustomDualEditDialog = class(TJSEditDialog)
  private
    FDualEditProperties: TJSDualEditProperties;
    FEditValue2: string;
    FEditValue1: string;
    procedure SetDualEditProperties(const Value: TJSDualEditProperties);
  protected
    procedure DoGetEditControlClass(var AControlClass: TControlClass); override;
    function DoGetControlHeight: Integer; override;
    procedure DoDialogClose(Sender: TObject); override;
    procedure UpdateEditValues; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DualEditProperties: TJSDualEditProperties read FDualEditProperties write SetDualEditProperties;
    property EditValue1: string read FEditValue1;
    property EditValue2: string read FEditValue2;
  end;

  {$IFDEF DELPHI_XE2}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64{ or pidOSX32})]
  {$ENDIF}
  TJSDualEditDialog = class(TJSCustomDualEditDialog)
  published
    property DualEditProperties;
  end;

implementation

uses
  Forms, Windows, JSDualEditDialogFrame;

{ TJSDualEditProperties }

procedure TJSDualEditProperties.Assign(Source: TPersistent);
var
  LSrc: TJSDualEditProperties;
begin
  if Source is TJSDualEditProperties then
  begin
    LSrc := Source as TJSDualEditProperties;
    FCaptionAlignment := LSrc.CaptionAlignment;
    FValue1 := LSrc.Value1Caption;
    FValue1Caption := LSrc.Value1Caption;
    FValue2 := LSrc.Value2Caption;
    FValue2Caption := LSrc.Value2Caption;
  end
  else
    inherited;
end;

constructor TJSDualEditProperties.Create;
begin
  inherited;
  FCaptionAlignment := caRight;
end;

procedure TJSDualEditProperties.SetValue1(const Value: string);
begin
  FValue1 := Value;
end;

procedure TJSDualEditProperties.SetValue2(const Value: string);
begin
  FValue2 := Value;
end;

{ TJSCustomDualEditDialog }

constructor TJSCustomDualEditDialog.Create(AOwner: TComponent);
begin
  inherited;
  EditProperties.EditType := etCustom;
  FDualEditProperties := TJSDualEditProperties.Create;
end;

destructor TJSCustomDualEditDialog.Destroy;
begin
  FDualEditProperties.Free;
  inherited;
end;

procedure TJSCustomDualEditDialog.DoDialogClose(Sender: TObject);
begin
  UpdateEditValues;
  inherited;
end;

function TJSCustomDualEditDialog.DoGetControlHeight: Integer;
begin
  result := MulDiv(54, Screen.PixelsPerInch, 96);
end;

procedure TJSCustomDualEditDialog.DoGetEditControlClass(var AControlClass: TControlClass);
begin
  AControlClass := TfmDualEditDialog;
end;

procedure TJSCustomDualEditDialog.SetDualEditProperties(const Value: TJSDualEditProperties);
begin
  FDualEditProperties.Assign(Value);
end;

procedure TJSCustomDualEditDialog.UpdateEditValues;
begin
  if EditControls[0] <> nil then
  begin
    if EditControls[0] is TfmDualEditDialog then
    begin
      FEditValue1 := TfmDualEditDialog(EditControls[0]).eValue1.Text;
      FEditValue2 := TfmDualEditDialog(EditControls[0]).eValue2.Text;
    end;
  end;
end;

end.
