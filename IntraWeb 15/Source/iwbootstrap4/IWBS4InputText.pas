unit IWBS4InputText;

interface

uses
  Classes, SysUtils, IWHTMLTag, IWRenderContext, IWBS4InputTypes,
  IWBS4CustomControl;

type
  // Includes Form Group div, Label and Described By (under the input)
  {$include IWPlatformAttrib.inc}
  TIWBS4InputTextExp = class(TIWBS4CustomControl) // this is where we want to start
  private
    FAutoGenFormGroup: Boolean;
    FLabelText: string;
    FDescribeText: string;
    FInputType: TIWBS4InputType;
    FRowCount: Integer; // if greater than one, we render as a textarea
    FInputSize: TIWBS4InputSize;
    FPlaceholder: string;
    FDisabled: Boolean;
    FReadOnly: Boolean;
    FPlainText: Boolean;
    FMin: string;
    FMax: string;
    FMaxLength: Integer;
    FPattern: string;
    FRequired: Boolean;
    FSize: Integer;
    FStep: Integer;
    FAutoComplete: Boolean;
    FAutoFocus: Boolean;
    FFormInclude: string; // allows to place an input outside the form, but still be a part of it
    FCss: string;
    procedure SetInputType(const Value: TIWBS4InputType);
  protected
    FFormGroupTag: TIWHTMLTag;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoGenFormGroup: Boolean read FAutoGenFormGroup write FAutoGenFormGroup default True;
    property LabelText: string read FLabelText write FLabelText;
    property DescribeText: string read FDescribeText write FDescribeText;
    property InputType: TIWBS4InputType read FInputType write SetInputType default bs4itText;
    property RowCount: Integer read FRowCount write FRowCount;
    property InputSize: TIWBS4InputSize read FInputSize write FInputSize default bs4isDefault;
    property Placeholder: string read FPlaceholder write FPlaceholder;
    property Disabled: Boolean read FDisabled write FDisabled;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property PlainText: Boolean read FPlainText write FPlainText;
    property Min: string read FMin write FMin;
    property Max: string read FMax write FMax;
    property MaxLength: Integer read FMaxLength write FMaxLength;
    property Pattern: string read FPattern write FPattern;
    property Required: Boolean read FRequired write FRequired;
    property Size: Integer read FSize write FSize;
    property Step: Integer read FStep write FStep;
    property AutoComplete: Boolean read FAutoComplete write FAutoComplete;
    property AutoFocus: Boolean read FAutoFocus write FAutoFocus;
    property FormInclude: string read FFormInclude write FFormInclude;
    property Css: string read FCss write FCss;
  end;

implementation

uses
  IWBS4Common, IWBS4InputForm;

constructor TIWBS4InputTextExp.Create(AOwner: TComponent);
begin
  inherited;

  // Temp for testing
//FLabelText := 'Enter Some Mission Critical Information';
//FDescribeText := 'Your data is safer than FaceBook, but that''s not saying much';

  // Initial size (get it in the ballpark)
  Height := 25;
  Width := 250;

  FAutoGenFormGroup := True;
  FInputType := bs4itText;
  FInputSize := bs4isDefault;
  FRowCount := 1;
end;

procedure TIWBS4InputTextExp.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FCss <> '' then
  begin
    TIWBS4Common.AddCssClass(ACss, FCss);
  end;
end;

procedure TIWBS4InputTextExp.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  LabelTag: TIWHTMLTag;
  InputTag: TIWHTMLTag;
  DescribeTag: TIWHTMLTag;
  DescribeID: string;
begin
  inherited;

  // Create the Form Group and everything in it right here
  FFormGroupTag := TIWHTMLTag.CreateTag('div');
  FFormGroupTag.AddClassParam('form-group');
  FFormGroupTag.Contents.AddText(sLineBreak); // so I can see the damn thing in the output

  // Next is the Label (later we'll make the label optional)
  LabelTag := FFormGroupTag.Contents.AddTag('label');
  LabelTag.AddStringParam('for', Self.HTMLName);
  LabelTag.Contents.AddText(FLabelText);

  // Create the actual input
  InputTag := FFormGroupTag.Contents.AddTag('input');
  InputTag.AddStringParam('type', aIWBS4InputType[FInputType]);
  InputTag.AddStringParam('id', AHTMLName);
  InputTag.AddStringParam('name', AHTMLName);
  if FPlainText then
    InputTag.AddClassParam('form-control-plaintext')
  else
    InputTag.AddClassParam('form-control');
  // First see if there is a non-standard size set for the input; if not, see if the form has an input size setting
  if FInputSize <> bs4isDefault then
  begin
    if FInputSize <> bs4isNormal then
    begin
      InputTag.AddClassParam(aIWBS4InputSize[FInputSize]);
    end;
  end
  else
  begin
    if Parent is TIWBS4InputForm then
    begin
      if (Parent as TIWBS4InputForm).InputsSize <> bs4isDefault then
      begin
        if (Parent as TIWBS4InputForm).InputsSize <> bs4isNormal then
        begin
          InputTag.AddClassParam(aIWBS4InputSize[(Parent as TIWBS4InputForm).InputsSize]);
        end;
      end;
    end;
  end;
  if FDescribeText <> '' then
  begin
    DescribeID := 'descby' + IntToStr(Top) + '_' + IntToStr(Left);
    InputTag.AddStringParam('aria-describedby', DescribeID);
  end;
  // now all the options
  if FFormInclude <> '' then
  begin
    InputTag.AddStringParam('form', FFormInclude);
  end;
  if FMin <> '' then
  begin
    InputTag.AddStringParam('min', FMin);
  end;
  if FMax <> '' then
  begin
    InputTag.AddStringParam('max', FMax);
  end;
  if FMaxLength <> 0 then
  begin
    InputTag.AddStringParam('maxlength', IntToStr(FMaxLength));
  end;
  if FPattern <> '' then
  begin
    InputTag.AddStringParam('pattern', FPattern);
  end;
  if FPlaceholder <> '' then
  begin
    InputTag.AddStringParam('placeholder', FPlaceholder);
  end;
  if FSize <> 0 then
  begin
    InputTag.AddStringParam('size', IntToStr(FSize));
  end;
  if FStep <> 0 then
  begin
    InputTag.AddStringParam('step', IntToStr(FStep));
  end;
  // naked attributes
  if FAutoComplete then
  begin
    InputTag.Add('autocomplete');
  end;
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

procedure TIWBS4InputTextExp.SetInputType(const Value: TIWBS4InputType);
begin
  FInputType := Value;
  Invalidate;
end;

end.

