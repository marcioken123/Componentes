unit IWBS4CustomInput;

interface

uses
  Classes, SysUtils, StrUtils, Controls, Db, IWHTMLTag, IWApplication,
  IWRenderContext, IWBaseInterfaces, IWHTML40Interfaces, IWScriptEvents,
  IWControl, IWBS4CustomControl, IWBS4Common, IWBS4Typography, IWBS4InputTypes;

type
  TIWBS4CustomInput = class(TIWBS4CustomDbControl, IIWInputControl, IIWInputControl40, IIWAutoEditableControl)
  private
    FAutoEditable: Boolean;
    FAutoFocus: Boolean;
    FDbEditable: Boolean;
    FCaption: string;
    FInputType: TIWBS4InputType;
    FReadOnly: Boolean;
    FRequired: Boolean;
    FInvalidFeedback : string;
    FValidFeedback : string;
    procedure EditingChanged;
    function GetAsDateTime: TDateTime;
    function GetAsDouble: Double;
    function GetAsVariant: Variant;
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsDouble(const Value: Double);
  protected
    FIsStatic: Boolean;
    FSupportReadOnly: Boolean;
    FText: TCaption;
    FOldText: string;
    procedure CheckData(AContext: TIWCompContext); override;
    procedure SetCaption(const AValue: string);
    procedure SetReadOnly(const AValue: Boolean);
    procedure SetRequired(const AValue: Boolean);
    procedure SetValue(const AValue: string);

    function get_ShouldRenderTabOrder: Boolean; override;

    procedure GetInputControlNames(ANames: TStringList); override;
    function IsForThisControl(AName: string): Boolean; override;

    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean); virtual;

    function IsReadOnly: Boolean; override;
    function IsDisabled: Boolean; override;

    function getText: TCaption; override;

    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property InputType: TIWBS4InputType read FInputType write FInputType;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Invalidate; override;
    procedure SetText(const AValue: TCaption); override;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsDouble: Double read GetAsDouble write SetAsDouble;
    property AsVariant: Variant read GetAsVariant;
  published
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable default True;
    property AutoFocus: Boolean read FAutoFocus write FAutoFocus default False;
    property Caption: string read FCaption write SetCaption;
    property Editable default True;
    property Enabled default True;
    property ExtraTagParams;
    property FriendlyName;
    property NonEditableAsLabel default False;
    property Required: Boolean read FRequired write SetRequired default False;
    property ScriptEvents;
    property ScriptInsideTag default False;
    property SubmitOnAsyncEvent default True;
    property Text: TCaption read GetText write SetText;
    property InvalidFeedback : string read FInvalidFeedback write FInvalidFeedback;
    property ValidFeedback : string read FValidFeedback     write FValidFeedback;
  end;

  TIWBS4CustomTextInput = class(TIWBS4CustomInput)
  private
    FPlaceHolder: string;
    FTextAlignment: TIWBS4TextAlignment;
    FTextCase: TIWBS4TextTransform;
  protected
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderCss(var ACss: string); override;
  published
    constructor Create(AOwner: TComponent); override;
    property BSTextAlignment: TIWBS4TextAlignment read FTextAlignment write FTextAlignment default bs4taNone;
    property BSTextCase: TIWBS4TextTransform read FTextCase write FTextCase default bs4xfNone;
    property MaxLength default 0;
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
    property ReadOnly default False;
  end;

  TIWBS4CustomSelectInput = class(TIWBS4CustomInput)
  private
    FItems: TStringList;
    FItemsHaveValues: Boolean;
    procedure SetItems(AValue: TStringList);
    procedure SetItemsHaveValues(AValue: Boolean);
  protected
    FItemIndex: Integer;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean); override;
    function FindValue(const AValue: string): Integer;
    procedure Loaded; override;
    procedure OnItemsChange(ASender: TObject); virtual;
    procedure SetItemIndex(AValue: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetText(const AValue: TCaption); override;
  published
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Items: TStringList read FItems write SetItems;
    property ItemsHaveValues: Boolean read FItemsHaveValues write SetItemsHaveValues default False;
  end;

implementation

uses IWDBCommon, IWDBStdCtrls;

var
  LFormatSettings: TFormatSettings;

{$region 'TIWBS4CustomInput'}
constructor TIWBS4CustomInput.Create(AOwner: TComponent);
begin
  inherited;
  FAutoEditable := True;
  FAutoFocus := False;
  FCaption := '';
  FInputType := bs4itText;
  FNonEditableAsLabel := False;
  FReadOnly := False;
  FRequired := False;
  FFriendlyName := '-';

  FNeedsFormTag := True;
  FIsStatic := False;
  FSupportReadOnly := False;

  ScriptInsideTag := False;
  Height := 25;
  Width := 121;
end;

procedure TIWBS4CustomInput.Invalidate;
begin
  inherited;
end;

function TIWBS4CustomInput.GetAsDateTime: TDateTime;
begin
  if FInputType in [bs4itDateTimeLocal, bs4itDate, bs4itMonth, bs4itTime] then
  begin
    if FText = ''
      then Result := 0
      else Result := StrToDateTime(ReplaceStr(FText, 'T', ' '), LFormatSettings)
  end else
  begin
    raise Exception.Create('Invalid InputType');
  end;
end;

procedure TIWBS4CustomInput.SetAsDateTime(const Value: TDateTime);
begin
  if Value = 0 then
    FText := ''
  else
  if FInputType = bs4itDateTimeLocal then
    FText := FormatDateTime('yyyy-mm-dd"T"hh:nn', Value)
  else
  if FInputType = bs4itDate then
    FText := FormatDateTime('yyyy-mm-dd', Value)
  else
  if FInputType = bs4itTime then
    FText := FormatDateTime('hh:nn', Value)
  else
    FText := DateTimeToStr(Value, LFormatSettings);
end;

function TIWBS4CustomInput.GetAsDouble: Double;
begin
  if FInputType = bs4itNumber then
  begin
    if FText = ''
      then Result := 0
      else Result := StrToFloat(FText, LFormatSettings)
  end else
  begin
    raise Exception.Create('Invalid InputType');
  end;
end;

procedure TIWBS4CustomInput.SetAsDouble(const Value: Double);
begin
  if FInputType = bs4itNumber
    then FText := FloatToStr(Value, LFormatSettings)
    else raise Exception.Create('Invalid InputType');
end;

function TIWBS4CustomInput.GetAsVariant: Variant;
begin
  if FInputType = bs4itNumber then
    Result := GetAsDouble
  else
  if FInputType in [bs4itDateTimeLocal, bs4itDate, bs4itMonth, bs4itTime] then
    Result := GetAsDateTime
  else
    Result := FText;
end;

procedure TIWBS4CustomInput.GetInputControlNames(ANames: TStringList);
begin
  ANames.Text := HTMLName + InputSuffix;
end;

function TIWBS4CustomInput.IsForThisControl(AName: string): Boolean;
begin
  Result := SameText(HTMLName + InputSuffix, AName);
end;

function TIWBS4CustomInput.getText: TCaption;
begin
  Result := FText;
end;

procedure TIWBS4CustomInput.SetText(const AValue: TCaption);
begin
  if not SameStr(FText, AValue) then
  begin
    if AValue = '' then
      FText := AValue
    else if FInputType in [bs4itDateTimeLocal, bs4itDate, bs4itTime] then
      SetAsDateTime(StrToDateTime(AValue, LFormatSettings))
    else if FInputType in [bs4itNumber] then
      SetAsDouble(StrToFloat(AValue, LFormatSettings))
    else
      FText := AValue;
    Invalidate;
  end;
end;

procedure TIWBS4CustomInput.CheckData(AContext: TIWCompContext);
var
  LField: TField;
begin
  if DataSource <> nil then
  begin
    if CheckDataSource(DataSource, DataField, LField) then
    begin
      if AutoEditable then
      begin
        FDbEditable := InEditMode(DataSource.Dataset) and FieldIsEditable(DataSource, DataField);
      end;
      if Assigned(LField.OnGetText) then
        Text := LField.Text
      else
      if (FInputType = bs4itNumber) and (LField.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBCD, ftExtended]) then
        Text := FloatToStr(LField.AsExtended, LFormatSettings)
      else
      if (FInputType in [bs4itDateTimeLocal, bs4itDate, bs4itTime]) and (LField.DataType in [ftDate, ftTime, ftDateTime, ftTimeStamp, ftOraTimeStamp]) then
        Text := FormatDateTime('yyyy-mm-dd"T"hh:nn', LField.AsDateTime)
      else
        Text := LField.AsString;
    end else
    begin
      Text := '';
      if AutoEditable then
      begin
        FDbEditable := True;
      end;
    end;
  end else
  begin
    FDbEditable := true;
    SetText(FText);  // Force SetText() of inherited controls to be called if no DataSource is used
  end;
end;

procedure TIWBS4CustomInput.SetValue(const AValue: string);
var
  LField: TField;
  LText: string;
  LSave: Boolean;
begin
  if RequiresUpdateNotification(Parent) then
  begin
    UpdateNotifiedInterface(Parent).NotifyUpdate(Self,AValue);
  end;
  LSave := True;
  InternalSetValue(AValue, LText, LSave);
  if (FOldText <> LText) or (FText <> LText) then
  begin
    FOldText := LText;
    FText := LText;
    try
      if CheckDataSource(DataSource, DataField, LField) and LSave then
        if InEditMode(DataSource.DataSet) and LField.CanModify then
        begin
          if Assigned(LField.OnSetText) then
          begin
            LField.Text := LText
          end else
          begin
            if FInputType = bs4itNumber then
              LField.AsFloat := StrToFloat(LText, LFormatSettings)
            else
            if FInputType = bs4itDateTimeLocal then  // agregar todos los tipos fecha que hay
              LField.AsDateTime := StrToDateTime(ReplaceStr(LText, 'T', ' '), LFormatSettings)
            else
              LField.AsString := LText;
          end;
        end else
        begin
          raise EIWDataSetNotEditingError.Create(DataSource);
        end;
    finally
      Invalidate;
      CheckData(nil);
    end;
  end;
end;

procedure TIWBS4CustomInput.EditingChanged;
begin
  Invalidate;
end;

function TIWBS4CustomInput.get_ShouldRenderTabOrder: Boolean;
begin
  Result := Editable or (NonEditableAsLabel = False);
end;

procedure TIWBS4CustomInput.InternalSetValue(const ASubmitValue: string;
  var ATextValue: string; var ASetFieldValue: Boolean);
begin
  ATextValue := ASubmitValue;
end;

function TIWBS4CustomInput.IsReadOnly: Boolean;
begin
  Result := FSupportReadOnly and (FReadOnly or not FDbEditable);
end;

function TIWBS4CustomInput.IsDisabled: Boolean;
begin
  Result := not (Enabled and Editable and (FDbEditable or FSupportReadOnly));
end;

procedure TIWBS4CustomInput.InternalRenderHTML(const AHTMLName: string;
  AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;

  FOldText := FText;
end;

procedure TIWBS4CustomInput.SetCaption(const AValue: string);
begin
  FCaption := AValue;
  Invalidate;
end;

procedure TIWBS4CustomInput.SetReadOnly(const AValue: Boolean);
begin
  if FReadOnly <> AValue then
  begin
    FReadOnly := AValue;
    Invalidate;
  end;
end;

procedure TIWBS4CustomInput.SetRequired(const AValue: Boolean);
begin
  if FRequired <> AValue then
  begin
    FRequired := AValue;
    Invalidate;
  end;
end;
{$endregion}

{$region 'TIWBS4CustomTextInput'}
constructor TIWBS4CustomTextInput.Create(AOwner: TComponent);
begin
  inherited;

  FSupportReadOnly := True;
  FTextAlignment := bs4taNone;
  FTextCase := bs4xfNone;
end;

procedure TIWBS4CustomTextInput.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;

  if FIsStatic
    then TIWBS4Common.SetAsyncHtml(AApplication, AHTMLName, FText, FOldText)
    else TIWBS4Common.SetAsyncText(AApplication, AHTMLName, FText, FOldText);
end;

procedure TIWBS4CustomTextInput.InternalRenderCss(var ACss: string);
begin
  inherited;

  FIsStatic := not Editable and NonEditableAsLabel;
  if FIsStatic
    then TIWBS4Common.AddCssClass(ACss, 'form-control-static')
    else TIWBS4Common.AddCssClass(ACss, 'form-control');
  if FTextAlignment <> bs4taNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4TextAlignment[FTextAlignment]);
  end;
  if FTextCase <> bs4xfNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4TextTransform[FTextCase]);
  end;
end;
{$endregion}

{$region 'TIWBS4CustomSelectInput'}
constructor TIWBS4CustomSelectInput.Create(AOwner: TComponent);
begin
  inherited;
  FItemIndex := -1;
  FItems := TStringList.Create;
  FItems.OnChange := OnItemsChange;
  FItemsHaveValues := False;
  FSupportReadOnly := False;
end;

destructor TIWBS4CustomSelectInput.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

procedure TIWBS4CustomSelectInput.OnItemsChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;

procedure TIWBS4CustomSelectInput.Loaded;
begin
  SetItemIndex(FItemIndex);
end;

procedure TIWBS4CustomSelectInput.SetItemIndex(AValue: Integer);
begin
  if csReading in ComponentState then
  begin
    FItemIndex := AValue
  end else
  begin
    if (AValue >= -1) and (AValue < FItems.Count) then
    begin
      FItemIndex := AValue;
      if FItemIndex >= 0 then
      begin
        if FItemsHaveValues
          then FText := FItems.ValueFromIndex[AValue]
          else FText := FItems[AValue]
      end else
      begin
        FText := '';
      end;
    end else
    begin
      FItemIndex := -1;
      FText := ''
    end;
    Invalidate;
  end;
end;

procedure TIWBS4CustomSelectInput.SetItems(AValue: TStringList);
begin
  FItems.Assign(AValue);
end;

procedure TIWBS4CustomSelectInput.SetItemsHaveValues(AValue: Boolean);
begin
  FItemsHaveValues := AValue;
  Invalidate;
end;

function TIWBS4CustomSelectInput.FindValue(const AValue: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FItems.Count - 1 do
    if AnsiSameStr(IfThen(FItemsHaveValues, FItems.ValueFromIndex[i], FItems[i]), AValue) then
    begin
      Result := i;
      Break;
    end;
end;

procedure TIWBS4CustomSelectInput.SetText(const AValue: TCaption);
begin
  inherited;

  FItemIndex := FindValue(FText);
end;

procedure TIWBS4CustomSelectInput.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'form-control');

  inherited;
end;

procedure TIWBS4CustomSelectInput.InternalSetValue(const ASubmitValue: string;
  var ATextValue: string; var ASetFieldValue: Boolean);
var
  i: Integer;
begin
  // 2018-11-18 - SS - Submit value text value ??
  if not TryStrToInt(ASubmitValue, i) then
  begin
    i := FindValue(ASubmitValue);
  end;

  if (i >= 0) and (i < Items.Count) then
  begin
    if ItemsHaveValues
      then ATextValue := Items.ValueFromIndex[i]
      else ATextValue := Items[i];
    FItemIndex := i;
  end else
  begin
    ATextValue := '';
    FItemIndex := -1;
  end;
end;
{$endregion}

{$DEFINE HAS_TFORMATSETTINGS}
{$IFDEF VER200} {$UNDEF HAS_FORMATSETTINGS} {$ENDIF}  // D2009
{$IFDEF VER201} {$UNDEF HAS_FORMATSETTINGS} {$ENDIF}  // D2010

initialization
  {$IFDEF HAS_FORMATSETTINGS}
  LFormatSettings := TFormatSettings.Create('en-US'); // locale de us
  LFormatSettings.DateSeparator := '-';
  LFormatSettings.LongDateFormat := 'yyyy-mm-dd';
  LFormatSettings.ShortDateFormat := LFormatSettings.LongDateFormat;
  LFormatSettings.LongTimeFormat := 'hh:nn:ss';
  LFormatSettings.ShortTimeFormat := LFormatSettings.LongTimeFormat;
  {$ENDIF}

end.
