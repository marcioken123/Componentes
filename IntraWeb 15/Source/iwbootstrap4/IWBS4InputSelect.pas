unit IWBS4InputSelect;

interface

uses
  Classes, SysUtils, IWHTMLTag, IWRenderContext, IWApplication, IWBS4Utils,
  IWBS4InputTypes, IWBS4CustomControl, IWBS4CustomInput;

type
  // Includes Form Group div, Label and Described By (under the input)
  {$include IWPlatformAttrib.inc}
  TIWBS4SelectExp = class(TIWBS4CustomSelectInput)
  private
    FAutoGenFormGroup: Boolean;
    FLabelText: string;
    FDescribeText: string;
    FInputSize: TIWBS4InputSize;
    FDisabled: Boolean;
    FReadOnly: Boolean;
    FRequired: Boolean;
    FAutoFocus: Boolean;
    FFormInclude: string; // allows to place an input outside the form, but still be a part of it
    FItemsSelected: array of Boolean;
    FMultiSelect: Boolean;
    FSize: Integer;
    FCustom: Boolean;
    FCss: string;
    procedure SetSize(const Value: Integer);
    procedure ResetItemsSelected;
  protected
    FFormGroupTag: TIWHTMLTag;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure OnItemsChange(ASender: TObject); override;
    procedure SetItemIndex(AValue: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoGenFormGroup: Boolean read FAutoGenFormGroup write FAutoGenFormGroup default True;
    property LabelText: string read FLabelText write FLabelText;
    property DescribeText: string read FDescribeText write FDescribeText;
    property InputSize: TIWBS4InputSize read FInputSize write FInputSize default bs4isDefault;
    property Disabled: Boolean read FDisabled write FDisabled;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property Required: Boolean read FRequired write FRequired;
    property AutoFocus: Boolean read FAutoFocus write FAutoFocus;
    property FormInclude: string read FFormInclude write FFormInclude;
    property MultiSelect: Boolean read FMultiSelect write FMultiSelect default False;
    property Size: Integer read FSize write SetSize default 1;
    property Custom: Boolean read FCustom write FCustom default False;
    property Css: string read FCss write FCss;
  end;

function GetLastPositionOfChar(const C: Char; const AStr: string): Integer;

implementation

uses
  StrUtils, IWBS4Common, IWBS4InputForm;

constructor TIWBS4SelectExp.Create(AOwner: TComponent);
begin
  inherited;

  // Initial size (get it in the ballpark)
  Height := 25;
  Width := 250;

  FAutoGenFormGroup := True;
  FInputSize := bs4isDefault;
  FCustom := False;
end;

procedure TIWBS4SelectExp.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
var
  LSelectedIdx: string;
  i: Integer;
begin
  inherited;
  if FText <> FOldText then
  begin
    LSelectedIdx := '';
    if FMultiSelect then
    begin
      for i := 0 to Length(FItemsSelected) - 1 do
        if FItemsSelected[i] then
        begin
          if LSelectedIdx <> '' then
          begin
            LSelectedIdx := LSelectedIdx + ',';
          end;
          LSelectedIdx := LSelectedIdx + IntToStr(i);
        end;
    end
    else if FItemIndex >= 0 then
    begin
      LSelectedIdx := IntToStr(FItemIndex);
    end;
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + AHTMLName + '").val([' + LSelectedIdx + ']);', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBS4SelectExp.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FCss <> '' then
  begin
    TIWBS4Common.AddCssClass(ACss, FCss);
  end;
end;

procedure TIWBS4SelectExp.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  LabelTag: TIWHTMLTag;
  SelectTag: TIWHTMLTag;
  OptionTag: TIWHTMLTag;
  DescribeTag: TIWHTMLTag;
  DescribeID: string;
  CustomClassRendered: Boolean;
  S: string;
  i: Integer;
  DelimPosition: Integer;
begin
  inherited;

  if FCustom then
  begin
    // This is an empty wrapper, but I need it to attach the label and select to
    FFormGroupTag := TIWHTMLTag.CreateTag('div');

    if FLabelText <> '' then
    begin
      // Next is the Label (later we'll make the label optional)
      LabelTag := FFormGroupTag.Contents.AddTag('label');
      LabelTag.AddStringParam('for', Self.HTMLName);
      LabelTag.Contents.AddText(FLabelText);
    end;

    // Create the actual input
    SelectTag := FFormGroupTag.Contents.AddTag('select');
    SelectTag.AddStringParam('id', AHTMLName);
    SelectTag.AddStringParam('name', AHTMLName);
    // First see if there is a non-standard size set for the input; if not, see if the form has an input size setting
    CustomClassRendered := False;
    if FInputSize <> bs4isDefault then
    begin
      case FInputSize of
        bs4isNormal, bs4isDefault:
          SelectTag.AddClassParam('custom-select');
        bs4isSmall:
          SelectTag.AddClassParam('custom-select-sm');
        bs4isLarge:
          SelectTag.AddClassParam('custom-select-lg');
      end;
      CustomClassRendered := True;
    end
    else if Parent is TIWBS4InputForm then
    begin
      if (Parent as TIWBS4InputForm).InputsSize <> bs4isDefault then
      begin
        if (Parent as TIWBS4InputForm).InputsSize <> bs4isNormal then
        begin
          case (Parent as TIWBS4InputForm).InputsSize of
            bs4isNormal, bs4isDefault:
              SelectTag.AddClassParam('custom-select');
            bs4isSmall:
              SelectTag.AddClassParam('custom-select-sm');
            bs4isLarge:
              SelectTag.AddClassParam('custom-select-lg');
          end;
          CustomClassRendered := True;
        end;
      end;
    end;
    if not CustomClassRendered then
    begin
      SelectTag.AddClassParam('custom-select');
    end;
    if FDescribeText <> '' then
    begin
      DescribeID := 'descby' + IntToStr(Top) + '_' + IntToStr(Left);
      SelectTag.AddStringParam('aria-describedby', DescribeID);
    end;
    // now all the options
    if FFormInclude <> '' then
    begin
      SelectTag.AddStringParam('form', FFormInclude);
    end;
    // naked attributes
    if FAutoFocus then
    begin
      SelectTag.Add('autofocus');
    end;
    if FDisabled then
    begin
      SelectTag.Add('disabled');
    end;
    if FReadOnly then
    begin
      SelectTag.Add('readonly');
    end;

    // Loop through the items and add to the select
    for i := 0 to Items.Count - 1 do
    begin
      OptionTag := SelectTag.Contents.AddTag('option');
      OptionTag.Contents.AddText(Items[i]);
    end;
  end
  else
  begin
    if FAutoGenFormGroup then
    begin
      // Create the Form Group and everything in it right here
      FFormGroupTag := TIWHTMLTag.CreateTag('div');
      FFormGroupTag.AddClassParam('form-group');
      FFormGroupTag.Contents.AddText(sLineBreak); // so I can see the damn thing in the output

      // Next is the Label (later we'll make the label optional)
      if FLabelText <> '' then
      begin
        LabelTag := FFormGroupTag.Contents.AddTag('label');
        LabelTag.AddStringParam('for', Self.HTMLName);
        LabelTag.Contents.AddText(FLabelText);
      end;
    end;

    // Create the actual input
    if FAutoGenFormGroup then
      SelectTag := FFormGroupTag.Contents.AddTag('select')
    else
      SelectTag := TIWHTMLTag.CreateTag('select');
    SelectTag.AddStringParam('id', AHTMLName);
    SelectTag.AddStringParam('name', AHTMLName);
    SelectTag.AddClassParam('form-control');
    // First see if there is a non-standard size set for the input; if not, see if the form has an input size setting
    if FInputSize <> bs4isDefault then
    begin
      if FInputSize <> bs4isNormal then
      begin
        SelectTag.AddClassParam(aIWBS4InputSize[FInputSize]);
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
            SelectTag.AddClassParam(aIWBS4InputSize[(Parent as TIWBS4InputForm).InputsSize]);
          end;
        end;
      end;
    end;
    if FDescribeText <> '' then
    begin
      DescribeID := 'descby' + IntToStr(Top) + '_' + IntToStr(Left);
      SelectTag.AddStringParam('aria-describedby', DescribeID);
    end;
    // now all the options
    if FFormInclude <> '' then
    begin
      SelectTag.AddStringParam('form', FFormInclude);
    end;
    // naked attributes
    if FAutoFocus then
    begin
      SelectTag.Add('autofocus');
    end;
    if FDisabled then
    begin
      SelectTag.Add('disabled');
    end;
    if FReadOnly then
    begin
      SelectTag.Add('readonly');
    end;

    // Loop through the items and add to the select
    for i := 0 to Items.Count - 1 do
    begin
      OptionTag := SelectTag.Contents.AddTag('option');
      if ItemsHaveValues then
      begin
        S := Items[i];
        if Pos('=', S) > 0 then
        begin
          DelimPosition := GetLastPositionOfChar(Char('='), S);
          OptionTag.Contents.AddText(Copy(S, 1, DelimPosition - 1));
          OptionTag.AddStringParam('value', Copy(S, DelimPosition + 1, 999));
        end
        else
        begin
          OptionTag.Contents.AddText(Items[i]);
        end;
      end
      else
      begin
        OptionTag.Contents.AddText(Items[i]);
      end;
    end;
  end;

  // Described By -- this is part of the AutoGenFormGroup setting (which generates up to 3 extra elements)
  // If not AutoGen, then we only render the select, nothing more
  if FAutoGenFormGroup and (FDescribeText <> '') then
  begin
    DescribeTag := FFormGroupTag.Contents.AddTag('small');
    DescribeTag.AddStringParam('id', DescribeID);
    DescribeTag.AddClassParam('form-text text-muted');
    DescribeTag.Contents.AddText(FDescribeText);
  end;

  if FAutoGenFormGroup then
    AHTMLTag := FFormGroupTag
  else
    AHTMLTag := SelectTag;
end;

procedure TIWBS4SelectExp.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
var
  LSelectedIdx, LSelectedVal: TStringList;
  i, v: Integer;
begin
  if FMultiSelect and AnsiContainsStr(ASubmitValue, ',') then
  begin
    FItemIndex := -1;
    ResetItemsSelected;
    LSelectedIdx := TStringList.Create;
    LSelectedVal := TStringList.Create;
    try
      LSelectedIdx.CommaText := ASubmitValue;
      for i := 0 to LSelectedIdx.Count - 1 do
        if TryStrToInt(LSelectedIdx[i], v) and (v >= 0) and (v < Items.Count) then
        begin
          if i = 0 then
          begin
            FItemIndex := v
          end
          else if ItemsHaveValues then
            LSelectedVal.Add(Items.ValueFromIndex[v])
          else
            LSelectedVal.Add(Items[v]);
          FItemsSelected[v] := True;
        end;
      LSelectedVal.StrictDelimiter := True;
      ATextValue := LSelectedVal.CommaText;
    finally
      LSelectedIdx.Free;
      LSelectedVal.Free;
    end;
  end
  else
  begin
    inherited InternalSetValue(ASubmitValue, ATextValue, ASetFieldValue);
    ResetItemsSelected;
  end;
end;

procedure TIWBS4SelectExp.OnItemsChange(ASender: TObject);
begin
  inherited;

  SetLength(FItemsSelected, Items.Count);
  ResetItemsSelected;
  AsyncRefreshControl;
end;

procedure TIWBS4SelectExp.SetItemIndex(AValue: Integer);
begin
  if not FMultiSelect and (AValue < 0) and (Items.Count > 0) then
  begin
    AValue := 0;
  end;
  inherited;
  ResetItemsSelected;
end;

procedure TIWBS4SelectExp.SetSize(const Value: Integer);
begin
  FSize := Value;
  Invalidate;
end;

procedure TIWBS4SelectExp.ResetItemsSelected;
var
  i: Integer;
begin
  for i := 0 to Length(FItemsSelected) - 1 do
  begin
    FItemsSelected[i] := False;
  end;
  if (FItemIndex >= 0) and (FItemIndex < Length(FItemsSelected)) then
  begin
    FItemsSelected[FItemIndex] := True;
  end;
end;

function GetLastPositionOfChar(const C: Char; const AStr: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(AStr) do
  begin
    if AStr[i] = C then
    begin
      Result := i;
    end;
  end;
end;

end.

