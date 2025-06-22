unit IWBS4InputCheckbox;

interface
{$Include IWBootstrap4.inc}

uses
  Classes, SysUtils, Controls, IWHTMLTag, IWRenderContext, IWApplication,
  IWAppForm, IWRegion, IWBS4InputTypes, IWBS4CustomControl, IWBS4Region,
  IWBS4CommonInterfaces, IWBS4Moab;

type
  {$include IWPlatformAttrib.inc}
  TIWBS4CheckboxExp = class(TIWBS4CustomControl)
  private
    FChecked: Boolean;
    FValueChecked: string;
    FValueUnchecked: string;
    FInlineCheck: Boolean;
    FLabelText: string;
    FDescribeText: string;
    FDisabled: Boolean;
    FReadOnly: Boolean;
    FAutoFocus: Boolean;
    FFormInclude: string;
    FCustom: Boolean;
    FDataTarget: TIWCustomRegion;  // do not use interfaces here!!!
    FDataTargetRegion: TIWBS4Region;
    FDataTargetMoab: TIWBS4Moab;
    FCss: string;
    procedure SetDataTarget(const Value: TIWCustomRegion);
    procedure SetDataTargetRegion(const Value: TIWBS4Region);
    procedure SetDataTargetMoab(const Value: TIWBS4Moab);
    procedure SetChecked(const Value: Boolean);
  protected
    FFormCheckTag: TIWHTMLTag;
    FText: TCaption;
    FOldText: string;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Checked: Boolean read FChecked write SetChecked default False;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
    property InlineCheck: Boolean read FInlineCheck write FInlineCheck default False;
    property LabelText: string read FLabelText write FLabelText;
    property DescribeText: string read FDescribeText write FDescribeText;
    property Disabled: Boolean read FDisabled write FDisabled default False;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property AutoFocus: Boolean read FAutoFocus write FAutoFocus default False;
    property FormInclude: string read FFormInclude write FFormInclude;
    property Custom: Boolean read FCustom write FCustom default True;
    property DataTarget: TIWCustomRegion read FDataTarget write SetDataTarget;
    property DataTargetRegion: TIWBS4Region read FDataTargetRegion write SetDataTargetRegion;
    property DataTargetMoab: TIWBS4Moab read FDataTargetMoab write SetDataTargetMoab;
    property Css: string read FCss write FCss;
  end;

  // https://www.abeautifulsite.net/bootstrap-4-switches
  {$include IWPlatformAttrib.inc}
  TIWBS4Switch = class(TIWBS4CustomControl)
  private
    FChecked: Boolean;
    FValueChecked: string;
    FValueUnchecked: string;
    FInputSize: TIWBS4InputSize;
    FLabelText: string;
    FDescribeText: string;
    FDisabled: Boolean;
    FReadOnly: Boolean;
    FAutoFocus: Boolean;
    FFormInclude: string;
    FDataTarget: IIWBS4Container;
    FDataTargetRegion: TIWBS4Region;
    FDataTargetMoab: TIWBS4Moab;
    FCss: string;
    procedure SetChecked(const Value: Boolean);
    procedure SetDataTarget(const Value: IIWBS4Container);
    procedure SetDataTargetRegion(const Value: TIWBS4Region);
    procedure SetDataTargetMoab(const Value: TIWBS4Moab);
  protected
    FText: TCaption;
    FOldText: string;
    FFormGroupTag: TIWHTMLTag;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Checked: Boolean read FChecked write SetChecked default False;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
    property InputSize: TIWBS4InputSize read FInputSize write FInputSize default bs4isDefault;
    property LabelText: string read FLabelText write FLabelText;
    property DescribeText: string read FDescribeText write FDescribeText;
    property Disabled: Boolean read FDisabled write FDisabled default False;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property AutoFocus: Boolean read FAutoFocus write FAutoFocus default False;
    property FormInclude: string read FFormInclude write FFormInclude;
    property DataTarget: IIWBS4Container read FDataTarget write SetDataTarget;
    property DataTargetRegion: TIWBS4Region read FDataTargetRegion write SetDataTargetRegion;
    property DataTargetMoab: TIWBS4Moab read FDataTargetMoab write SetDataTargetMoab;
    property Css: string read FCss write FCss;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4RadioButtonExp = class(TIWBS4CustomControl)
  private
    FInlineCheck: Boolean;
    FGroupName: string;
    FLabelText: string;
    FDescribeText: string;
    FDisabled: Boolean;
    FReadOnly: Boolean;
    FAutoFocus: Boolean;
    FFormInclude: string;
    FCustom: Boolean;
    FCss: string;
  protected
    FFormCheckTag: TIWHTMLTag;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property InlineCheck: Boolean read FInlineCheck write FInlineCheck default False;
    property GroupName: string read FGroupName write FGroupName;
    property LabelText: string read FLabelText write FLabelText;
    property DescribeText: string read FDescribeText write FDescribeText;
    property Disabled: Boolean read FDisabled write FDisabled default False;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property AutoFocus: Boolean read FAutoFocus write FAutoFocus default False;
    property FormInclude: string read FFormInclude write FFormInclude;
    property Custom: Boolean read FCustom write FCustom default True;
    property Css: string read FCss write FCss;
  end;

implementation

uses
  IWBS4Common, IWBS4Utils, IW.Common.System;

constructor TIWBS4CheckboxExp.Create(AOwner: TComponent);
begin
  inherited;

  // Why not? They look way better
  FCustom := True;
end;

procedure TIWBS4CheckboxExp.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  if Text <> FOldText then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").prop("checked", ' + iif(Checked, 'true', 'false') + ');', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBS4CheckboxExp.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FCss <> '' then
  begin
    TIWBS4Common.AddCssClass(ACss, FCss);
  end;
end;

procedure TIWBS4CheckboxExp.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  LabelTag: TIWHTMLTag;
  InputTag: TIWHTMLTag;
  DescribeTag: TIWHTMLTag;
  DescribeID: string;
begin
  inherited;

  if FCustom then
  begin
 {<div class="custom-control custom-checkbox">
    <input type="checkbox" class="custom-control-input" id="czech" name="czech">
    <label class="custom-control-label" for="czech">Wants Lunch</label>
  </div>}

    FFormCheckTag := TIWHTMLTag.CreateTag('div');
    if FInlineCheck then
      FFormCheckTag.AddClassParam('custom-control custom-checkbox custom-control-inline')
    else
      FFormCheckTag.AddClassParam('custom-control custom-checkbox');
    FFormCheckTag.Contents.AddText(sLineBreak);

    // Create the input
    InputTag := FFormCheckTag.Contents.AddTag('input');
  //InputTag.AddStringParam('value', '');
    InputTag.AddStringParam('id', HTMLName);
    InputTag.AddStringParam('name', HTMLName);
    InputTag.AddClassParam('custom-control-input');
    InputTag.AddStringParam('type', 'checkbox');
    // now all the options
    if FFormInclude <> '' then
    begin
      InputTag.AddStringParam('form', FFormInclude);
    end;
    // naked attributes
    if FAutoFocus then
    begin
      InputTag.Add('autofocus');
    end;
    if FDisabled then
    begin
      InputTag.Add('disabled');
    end;
    if FReadOnly then
    begin
      InputTag.Add('readonly');
    end;
    if FDescribeText <> '' then
    begin
      DescribeID := 'descby' + IntToStr(Top) + '_' + IntToStr(Left);
      InputTag.AddStringParam('aria-describedby', DescribeID);
    end;

    // Label
    LabelTag := FFormCheckTag.Contents.AddTag('label');
    LabelTag.AddClassParam('custom-control-label');
    LabelTag.AddStringParam('for', HTMLName);

    // See if we have a collapse target
    if Assigned(FDataTarget) then
    begin
      LabelTag.AddStringParam('data-toggle', 'collapse');
      LabelTag.AddStringParam('data-target', '#' + FDataTarget.HTMLName);
    end;
    if Assigned(FDataTargetRegion) then
    begin
      LabelTag.AddStringParam('data-toggle', 'collapse');
      LabelTag.AddStringParam('data-target', '#' + FDataTargetRegion.HTMLName);
    end;

    if Assigned(FDataTargetMoab) then
    begin
      LabelTag.AddStringParam('data-target', '#' + FDataTargetMoab.HTMLName);
    end;

    LabelTag.Contents.AddText(FLabelText);
  end
  else
  begin
    // Create the Form Group and everything in it right here
    FFormCheckTag := TIWHTMLTag.CreateTag('div');
    if FInlineCheck then
      FFormCheckTag.AddClassParam('form-check-inline')
    else
      FFormCheckTag.AddClassParam('form-check');
    FFormCheckTag.Contents.AddText(sLineBreak); // so I can see the damn thing in the output

    // Next is the Label (later we'll make the label optional)
    LabelTag := FFormCheckTag.Contents.AddTag('label');
    LabelTag.AddClassParam('form-check-label');

    // See if we have a collapse target
    if Assigned(FDataTarget) then
    begin
      LabelTag.AddStringParam('data-toggle', 'collapse');
      LabelTag.AddStringParam('data-target', '#' + FDataTarget.HTMLName);
    end;
    if Assigned(FDataTargetRegion) then
    begin
      LabelTag.AddStringParam('data-toggle', 'collapse');
      LabelTag.AddStringParam('data-target', '#' + FDataTargetRegion.HTMLName);
    end;

    if Assigned(FDataTargetMoab) then
    begin
      LabelTag.AddStringParam('data-target', '#' + FDataTargetMoab.HTMLName);
    end;

    // Create the actual input
    InputTag := LabelTag.Contents.AddTag('input');
    InputTag.AddStringParam('type', 'checkbox');
    InputTag.AddClassParam('form-check-input');
    InputTag.AddStringParam('value', '');
    // now all the options
    if FFormInclude <> '' then
    begin
      InputTag.AddStringParam('form', FFormInclude);
    end;
    // naked attributes
    if FAutoFocus then
    begin
      InputTag.Add('autofocus');
    end;
    if FDisabled then
    begin
      InputTag.Add('disabled');
    end;
    if FReadOnly then
    begin
      InputTag.Add('readonly');
    end;
    if FDescribeText <> '' then
    begin
      DescribeID := 'descby' + IntToStr(Top) + '_' + IntToStr(Left);
      InputTag.AddStringParam('aria-describedby', DescribeID);
    end;

    LabelTag.Contents.AddText(FLabelText);
  end;

  // This block is identical for checkboxes and custom checkboxes, so no need to repeat it
  // Described By
  if FDescribeText <> '' then
  begin
    DescribeTag := FFormCheckTag.Contents.AddTag('small');
    DescribeTag.AddStringParam('id', DescribeID);
    DescribeTag.AddClassParam('form-text text-muted');
    DescribeTag.Contents.AddText(FDescribeText);
  end;

  AHTMLTag := FFormCheckTag;
end;

procedure TIWBS4CheckboxExp.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
begin
  inherited;
  FChecked := ASubmitValue = 'on';
  if FChecked then
    ATextValue := FValueChecked
  else
    ATextValue := FValueUnchecked;
end;

procedure TIWBS4CheckboxExp.SetChecked(const Value: Boolean);
begin
  FChecked := Value;
  if Value then
    FText := FValueChecked
  else
    FText := FValueUnchecked;
  Invalidate;
end;

procedure TIWBS4CheckboxExp.SetDataTarget(const Value: TIWCustomRegion);
begin
  if FDataTarget <> Value then
  begin
    FDataTarget := Value;
    Invalidate;
  end;
end;

procedure TIWBS4CheckboxExp.SetDataTargetRegion(const Value: TIWBS4Region);
begin
  FDataTargetRegion := Value;
  Invalidate;
end;

procedure TIWBS4CheckboxExp.SetDataTargetMoab(const Value: TIWBS4Moab);
begin
  FDataTargetMoab := Value;
  Invalidate;
end;

constructor TIWBS4RadioButtonExp.Create(AOwner: TComponent);
begin
  inherited;

  // Why not? They look way better
  FCustom := True;
end;

procedure TIWBS4RadioButtonExp.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FCss <> '' then
  begin
    TIWBS4Common.AddCssClass(ACss, FCss);
  end;
end;

procedure TIWBS4RadioButtonExp.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  LabelTag: TIWHTMLTag;
  InputTag: TIWHTMLTag;
  DescribeTag: TIWHTMLTag;
  DescribeID: string;
begin
  inherited;

 {<div class="custom-control custom-radio">
    <input type="radio" class="custom-control-input" id="customRadio" name="example1" value="customEx">
    <label class="custom-control-label" for="customRadio">Custom radio</label>
  </div>}

  if FCustom then
  begin
    // Create the Form Group and everything in it right here
    FFormCheckTag := TIWHTMLTag.CreateTag('div');
    if FInlineCheck then
      FFormCheckTag.AddClassParam('custom-control custom-radio custom-control-inline')
    else
      FFormCheckTag.AddClassParam('custom-control custom-radio');
    FFormCheckTag.Contents.AddText(sLineBreak); // so I can see the damn thing in the output

    // Create the actual input
    InputTag := FFormCheckTag.Contents.AddTag('input');
    InputTag.AddStringParam('type', 'radio');
    InputTag.AddClassParam('custom-control-input');
    InputTag.AddStringParam('id', HTMLName);
    InputTag.AddStringParam('name', FGroupName);
    InputTag.AddStringParam('value', HTMLName);
    // now all the options
    if FFormInclude <> '' then
    begin
      InputTag.AddStringParam('form', FFormInclude);
    end;
    // naked attributes
    if FAutoFocus then
    begin
      InputTag.Add('autofocus');
    end;
    if FDisabled then
    begin
      InputTag.Add('disabled');
    end;
    if FReadOnly then
    begin
      InputTag.Add('readonly');
    end;
    if FDescribeText <> '' then
    begin
      DescribeID := 'descby' + IntToStr(Top) + '_' + IntToStr(Left);
      InputTag.AddStringParam('aria-describedby', DescribeID);
    end;

    // Next is the Label (later we'll make the label optional)
    LabelTag := FFormCheckTag.Contents.AddTag('label');
    LabelTag.AddClassParam('custom-control-label');
    LabelTag.AddStringParam('for', HTMLName);
    LabelTag.Contents.AddText(FLabelText);
  end
  else
  begin
    // Create the Form Group and everything in it right here
    FFormCheckTag := TIWHTMLTag.CreateTag('div');
    if FInlineCheck then
      FFormCheckTag.AddClassParam('form-check-inline')
    else
      FFormCheckTag.AddClassParam('form-check');
    FFormCheckTag.Contents.AddText(sLineBreak); // so I can see the damn thing in the output

    // Next is the Label (later we'll make the label optional)
    LabelTag := FFormCheckTag.Contents.AddTag('label');
    LabelTag.AddClassParam('form-check-label');

    // Create the actual input
    InputTag := LabelTag.Contents.AddTag('input');
    InputTag.AddStringParam('type', 'radio');
    InputTag.AddClassParam('form-check-input');
    InputTag.AddStringParam('name', FGroupName);
    // now all the options
    if FFormInclude <> '' then
    begin
      InputTag.AddStringParam('form', FFormInclude);
    end;
    // naked attributes
    if FAutoFocus then
    begin
      InputTag.Add('autofocus');
    end;
    if FDisabled then
    begin
      InputTag.Add('disabled');
    end;
    if FReadOnly then
    begin
      InputTag.Add('readonly');
    end;
    if FDescribeText <> '' then
    begin
      DescribeID := 'descby' + IntToStr(Top) + '_' + IntToStr(Left);
      InputTag.AddStringParam('aria-describedby', DescribeID);
    end;

    LabelTag.Contents.AddText(FLabelText);
  end;

  // Described By
  if FDescribeText <> '' then
  begin
    DescribeTag := FFormCheckTag.Contents.AddTag('small');
    DescribeTag.AddStringParam('id', DescribeID);
    DescribeTag.AddClassParam('form-text text-muted');
    DescribeTag.Contents.AddText(FDescribeText);
  end;

  AHTMLTag := FFormCheckTag;
end;

procedure TIWBS4Switch.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FCss <> '' then
  begin
    TIWBS4Common.AddCssClass(ACss, FCss);
  end;
end;

procedure TIWBS4Switch.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  SpanTag: TIWHTMLTag;
  LabelTag: TIWHTMLTag;
  InputTag: TIWHTMLTag;
  DescribeTag: TIWHTMLTag;
  DescribeID: string;
begin
  inherited;

  // Create the Form Group and everything in it right here
  FFormGroupTag := TIWHTMLTag.CreateTag('div');
  FFormGroupTag.AddClassParam('form-group m-0');
  FFormGroupTag.Contents.AddText(sLineBreak); // so I can see the damn thing in the output

  // Span surrounds everything
  SpanTag := FFormGroupTag.Contents.AddTag('span');
  case FInputSize of
    bs4isSmall:
      SpanTag.AddClassParam('switch switch-sm');
    bs4isLarge:
      SpanTag.AddClassParam('switch switch-lg');
  else
    SpanTag.AddClassParam('switch');
  end;

  // Create the actual input
  InputTag := SpanTag.Contents.AddTag('input');
  InputTag.AddStringParam('type', 'checkbox');
  InputTag.AddClassParam('switch');
  InputTag.AddStringParam('id', HTMLName);
  // now all the options
  if FFormInclude <> '' then
  begin
    InputTag.AddStringParam('form', FFormInclude);
  end;
  // naked attributes
  if FAutoFocus then
  begin
    InputTag.Add('autofocus');
  end;
  if FDisabled then
  begin
    InputTag.Add('disabled');
  end;
  if FReadOnly then
  begin
    InputTag.Add('readonly');
  end;
  if FDescribeText <> '' then
  begin
    DescribeID := 'descby' + IntToStr(Top) + '_' + IntToStr(Left);
    InputTag.AddStringParam('aria-describedby', DescribeID);
  end;

  // Next is the Label (later we'll make the label optional)
  // --> turns out that the components does NOT render correctly without the label
 {if FLabelText <> '' then
  begin}
  LabelTag := SpanTag.Contents.AddTag('label');
  LabelTag.AddStringParam('for', HTMLName);
  LabelTag.Contents.AddText(FLabelText);
//end;

  // See if we have a collapse target
  if Assigned(FDataTarget) then
  begin
    LabelTag.AddStringParam('data-toggle', 'collapse');
    LabelTag.AddStringParam('data-target', '#' + FDataTarget.HTMLName);
  end;
  if Assigned(FDataTargetRegion) then
  begin
    LabelTag.AddStringParam('data-toggle', 'collapse');
    LabelTag.AddStringParam('data-target', '#' + FDataTargetRegion.HTMLName);
  end;

  // This block is identical for checkboxes and custom checkboxes, so no need to repeat it
  // Described By
  if FDescribeText <> '' then
  begin
    DescribeTag := FFormGroupTag.Contents.AddTag('small');
    DescribeTag.AddStringParam('id', DescribeID);
    DescribeTag.AddClassParam('form-text text-muted');
    DescribeTag.Contents.AddText(FDescribeText);
  end;

  AHTMLTag := FFormGroupTag;
end;

procedure TIWBS4Switch.SetChecked(const Value: Boolean);
begin
  FChecked := Value;
  if Value then
    FText := FValueChecked
  else
    FText := FValueUnchecked;
  Invalidate;
end;

procedure TIWBS4Switch.SetDataTarget(const Value: IIWBS4Container);
begin
  FDataTarget := Value;
  Invalidate;
end;

procedure TIWBS4Switch.SetDataTargetRegion(const Value: TIWBS4Region);
begin
  FDataTargetRegion := Value;
  Invalidate;
end;

procedure TIWBS4Switch.SetDataTargetMoab(const Value: TIWBS4Moab);
begin
  FDataTargetMoab := Value;
  Invalidate;
end;

constructor TIWBS4Switch.Create(AOwner: TComponent);
var
  OwnerForm: TIWAppForm;
begin
  inherited;

  FInputSize := bs4isDefault;

  // Requires special style
  OwnerForm := FindOwnerForm(AOwner);
  if Assigned(OwnerForm) then
  begin
    if Pos('.switch.switch-sm', OwnerForm.ExtraHeader.Text) = 0 then
    begin
      OwnerForm.ExtraHeader.Add('<style>' + sLineBreak +
      '.switch {' + sLineBreak +
      '  font-size: 1rem;' + sLineBreak +
      '  position: relative;' + sLineBreak +
      '}' + sLineBreak +
      '.switch input {' + sLineBreak +
      '  position: absolute;' + sLineBreak +
      '  height: 1px;' + sLineBreak +
      '  width: 1px;' + sLineBreak +
      '  background: none;' + sLineBreak +
      '  border: 0;' + sLineBreak +
      '  clip: rect(0 0 0 0);' + sLineBreak +
      '  clip-path: inset(50%);' + sLineBreak +
      '  overflow: hidden;' + sLineBreak +
      '  padding: 0;' + sLineBreak +
      '}' + sLineBreak +
      '.switch input + label {' + sLineBreak +
      '  position: relative;' + sLineBreak +
      '  min-width: calc(calc(2.375rem * .8) * 2);' + sLineBreak +
      '  border-radius: calc(2.375rem * .8);' + sLineBreak +
      '  height: calc(2.375rem * .8);' + sLineBreak +
      '  line-height: calc(2.375rem * .8);' + sLineBreak +
      '  display: inline-block;' + sLineBreak +
      '  cursor: pointer;' + sLineBreak +
      '  outline: none;' + sLineBreak +
      '  user-select: none;' + sLineBreak +
      '  vertical-align: middle;' + sLineBreak +
      '  text-indent: calc(calc(calc(2.375rem * .8) * 2) + .5rem);' + sLineBreak +
      '}' + sLineBreak +
      '.switch input + label::before,' + sLineBreak +
      '.switch input + label::after {' + sLineBreak +
      '  content: '''';' + sLineBreak +
      '  position: absolute;' + sLineBreak +
      '  top: 0;' + sLineBreak +
      '  left: 0;' + sLineBreak +
      '  width: calc(calc(2.375rem * .8) * 2);' + sLineBreak +
      '  bottom: 0;' + sLineBreak +
      '  display: block;' + sLineBreak +
      '}' + sLineBreak +
      '.switch input + label::before {' + sLineBreak +
      '  right: 0;' + sLineBreak +
      '  background-color: #dee2e6;' + sLineBreak +
      '  border-radius: calc(2.375rem * .8);' + sLineBreak +
      '  transition: 0.2s all;' + sLineBreak +
      '}' + sLineBreak +
      '.switch input + label::after {' + sLineBreak +
      '  top: 2px;' + sLineBreak +
      '  left: 2px;' + sLineBreak +
      '  width: calc(calc(2.375rem * .8) - calc(2px * 2));' + sLineBreak +
      '  height: calc(calc(2.375rem * .8) - calc(2px * 2));' + sLineBreak +
      '  border-radius: 50%;' + sLineBreak +
      '  background-color: white;' + sLineBreak +
      '  transition: 0.2s all;' + sLineBreak +
      '}' + sLineBreak +
      '.switch input:checked + label::before {' + sLineBreak +
      '  background-color: #08d;' + sLineBreak +
      '}' + sLineBreak +
      '.switch input:checked + label::after {' + sLineBreak +
      '  margin-left: calc(2.375rem * .8);' + sLineBreak +
      '}' + sLineBreak +
      '.switch input:focus + label::before {' + sLineBreak +
      '  outline: none;' + sLineBreak +
      '  box-shadow: 0 0 0 0.2rem rgba(0, 136, 221, 0.25);' + sLineBreak +
      '}' + sLineBreak +
      '.switch input:disabled + label {' + sLineBreak +
      '  color: #868e96;' + sLineBreak +
      '  cursor: not-allowed;' + sLineBreak +
      '}' + sLineBreak +
      '.switch input:disabled + label::before {' + sLineBreak +
      '  background-color: #e9ecef;' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-sm {' + sLineBreak +
      '  font-size: 0.875rem;' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-sm input + label {' + sLineBreak +
      '  min-width: calc(calc(1.9375rem * .8) * 2);' + sLineBreak +
      '  height: calc(1.9375rem * .8);' + sLineBreak +
      '  line-height: calc(1.9375rem * .8);' + sLineBreak +
      '  text-indent: calc(calc(calc(1.9375rem * .8) * 2) + .5rem);' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-sm input + label::before {' + sLineBreak +
      '  width: calc(calc(1.9375rem * .8) * 2);' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-sm input + label::after {' + sLineBreak +
      '  width: calc(calc(1.9375rem * .8) - calc(2px * 2));' + sLineBreak +
      '  height: calc(calc(1.9375rem * .8) - calc(2px * 2));' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-sm input:checked + label::after {' + sLineBreak +
      '  margin-left: calc(1.9375rem * .8);' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-lg {' + sLineBreak +
      '  font-size: 1.25rem;' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-lg input + label {' + sLineBreak +
      '  min-width: calc(calc(3rem * .8) * 2);' + sLineBreak +
      '  height: calc(3rem * .8);' + sLineBreak +
      '  line-height: calc(3rem * .8);' + sLineBreak +
      '  text-indent: calc(calc(calc(3rem * .8) * 2) + .5rem);' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-lg input + label::before {' + sLineBreak +
      '  width: calc(calc(3rem * .8) * 2);' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-lg input + label::after {' + sLineBreak +
      '  width: calc(calc(3rem * .8) - calc(2px * 2));' + sLineBreak +
      '  height: calc(calc(3rem * .8) - calc(2px * 2));' + sLineBreak +
      '}' + sLineBreak +
      '.switch.switch-lg input:checked + label::after {' + sLineBreak +
      '  margin-left: calc(3rem * .8);' + sLineBreak +
      '}' + sLineBreak +
      '.switch + .switch {' + sLineBreak +
      '  margin-left: 1rem;' + sLineBreak +
      '}' + sLineBreak +
      '</style>');
    end;
  end;
end;

procedure TIWBS4Switch.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
begin
  inherited;
  FChecked := ASubmitValue = 'on';
  if FChecked then
    ATextValue := FValueChecked
  else
    ATextValue := FValueUnchecked;
end;

procedure TIWBS4Switch.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  if Text <> FOldText then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").prop("checked", ' +
      iif(Checked, 'true', 'false') + ');', False, True);
    FOldText := FText;
  end;
end;

end.

