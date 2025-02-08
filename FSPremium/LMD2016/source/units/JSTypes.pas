{ Unit that contains the type definitions that allows Delphi versions from Delphi 2005 to support
  Unicode.                                                                                        }
unit JSTypes;

interface

{$I lmddlgcmps.inc}

uses
    Classes
  , Windows
  , StdCtrls
  , Graphics
  {$IFDEF UNICODE}
    {$IFDEF TNTUnicode}
    , TntClasses
    {$ELSE}
    , WideStrings
    {$ENDIF TNTUnicode}
  {$ENDIF UNICODE}
  {$IFDEF FORCEUNICODE}
  , WideStrings
  {$ENDIF FORCEUNICODE}
  {$IFDEF BDS}
  , GraphUtil
  {$ENDIF BDS}
  , JSGraphUtil
  {$IFDEF TNTUnicode}
  , TntStdCtrls
  {$ENDIF TNTUnicode}
  ;

type
  {$IFDEF FORCEUNICODE}
  TJSWideStringList = TWideStringList;
  TJSString = WideString;
  TJSStrings = TWideStrings;
  {$ELSE}
  { Summary
    Default type used for TStringList.
    Description
    This is the default TStringList type used in JSDialog Pack. By aliasing the string type different
    compiler versions can support Unicode where it isn't supported by the VCL.                        }
  TJSWideStringList = {$IFDEF UNICODE}{$IFDEF TNTUnicode}TTntStringList{$ELSE}TWideStringList{$ENDIF}{$ELSE}TStringList{$ENDIF};
  { Summary
    Default string type used in JSDialogs Pack.
    Description
    This is the default string type used in JSDialog Pack. By aliasing the string type different compiler
    versions can support Unicode where it isn't supported by the VCL.                                     }
  TJSString = {$IFDEF UNICODE}WideString{$ELSE}string{$ENDIF};
  { Summary
    Default type used for TStrings.
    Description
    This is the default TStrings type used in JSDialog Pack. By aliasing the string type different
    compiler versions can support Unicode where it isn't supported by the VCL.                     }
  TJSStrings = {$IFDEF UNICODE}{$IFDEF TNTUnicode}TTntStrings{$ELSE}TWideStrings{$ENDIF}{$ELSE}TStrings{$ENDIF};
  {$ENDIF FORCEUNICODE}

  {$IFDEF DELPHI5}
  { THelpType indicates whether components invoke the help system using a context ID or a keyword.<p />
    <p />
    These are the possible values of the THelpType type:<p />                                           }
  THelpType = (htKeyword, { Summary
    Help topics are identified by a string. The HelpKeyword property is used to identify help topics.
    This mechanism is available for all help systems. }
   htContext { Summary
    Help topics are identified by a context ID. The HelpContext property is used to identify help topics.
    This mechanism is not available for all help systems, but is typically faster for those systems that
    support it. }
  );
  {$ENDIF DELPHI5}

  {$IFDEF TNTUnicode}
  TJSButton = TTntButton;
  TJSRadioButtonCtrl = TTntRadioButton;
  {$ELSE TNTUnicode}
  { Summary
    Default type used for button controls.
    Description
    Default type used for button controls. }
  TJSButton = TButton;
  { Summary
    Default type used for radio button controls.
    Description
    Default type used for radio button controls. }
  TJSRadioButtonCtrl = TRadioButton;
  {$ENDIF TNTUnicode}
  
  { Summary
    Base class for providing an OnChange event for TPersistent descendants.
    Description
    When descending from TJSChangePersistent all the functionality is provided to allow for handling when
    a property has changed.                                                                               }
  TJSChangePersistent = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
  protected
    FIgnoreChange: Boolean;
    { Summary
      Calls the OnChange event if assigned.
      Description
      If the OnChange event has an event handler than it is called. When creating descendant classes from
      TJSChangePersistent, when property values are changed, you should call DoChange after changing the
      property to its new value.                                                                          }
    procedure DoChange; virtual;
    { Descendant classes can prevent the OnChange event from being
      called by setting the IgnoreChange property.                 }
    property IgnoreChange: Boolean read FIgnoreChange write FIgnoreChange;
  public
    constructor Create; virtual;
  published
    { Summary
      Event triggered when a property has changed.
      Description
      When creating a descendant of the TJSChangePersistent class,
      set an OnChange event handler to be notified when a property
      within that class has been changed.<p />
      <p />
      <b>NOTE:</b> The OnChange event will only be triggered if the
      DoChange method has been called within the properties setter
      method.                                                       }
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { Summary
    Class that encapsulates properties relating to the painting of a gradient.
    Description
    Class that encapsulates properties relating to the painting of a gradient. }
  TJSGradient = class(TJSChangePersistent)
  private
    FEnabled: Boolean;
    FDirection: TGradientDirection;
    FEndColor: TColor;
    FStartColor: TColor;
    procedure SetDirection(const Value: TGradientDirection);
    procedure SetEnabled(const Value: Boolean);
    procedure SetEndColor(const Value: TColor);
    procedure SetStartColor(const Value: TColor);
  public
    constructor Create; override;
    procedure Assign(Source: TPersistent); override;
  published
    { Summary
      Specifies the direction of the gradient.
      Description
      Specifies the direction of the gradient. }
    property Direction: TGradientDirection read FDirection write SetDirection default gdHorizontal;
    { Summary
      Determines if the Gradient is drawn.
      Description
      Determines if the Gradient is drawn. }
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    { Summary
      Specifies the EndColor used when drawing the gradient.
      Description
      Specifies the EndColor used when drawing the gradient.
      Remarks
      The Enabled property must be set to True before the gradient is visible. }
    property EndColor: TColor read FEndColor write SetEndColor default clNone;
    { Summary
      Specifies the StartColor used when drawing the gradient.
      Description
      Specifies the StartColor used when drawing the gradient.
      Remarks
      The Enabled property must be set to True before the gradient is visible. }
    property StartColor: TColor read FStartColor write SetStartColor default clNone;
  end;

  { Summary
    Class that determines how the background of a TJSCaption is rendered.
    Description
    Determines how the background of a TJSCaption control is rendered.    }
  TJSBackground = class(TJSChangePersistent)
  private
    FColor: TColor;
    FGradient: TJSGradient;
    FAutoFree: Boolean;
    FCopyRect: TRect;
    FBuffered: Boolean;
  public
    constructor Create(const AColor: TColor; AGradient: TJSGradient; ACopyRect: TRect;
      ABuffered: Boolean = True; AAutoFree: Boolean = True); reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    { Summary
      Determines the color of the background.
      Description
      Determines the color of the background.
      Remarks
      The Color property has no effect if a Gradient is visible. }
    property Color: TColor read FColor write FColor;
    { Summary
      Specifies the properties for filling the background with a gradient.
      Description
      Specifies the properties for filling the background with a gradient. }
    property Gradient: TJSGradient read FGradient;
    { Summary
      Specifies if the JSCaption control should free the instance when it has used it.
      Description
      Specifies if the JSCaption control should free the instance when it has used it. }
    property AutoFree: Boolean read FAutoFree;
    { Summary
      Specifies the background rect to copy.
      Description
      Specifies the background rect to copy. }
    property CopyRect: TRect read FCopyRect write FCopyRect;
    { Summary
      Determines if the background is double buffered.
      Description
      Determines if the background is double buffered. Set buffered to True if you are experiencing
      unwanted flickering of the caption area.                                                      }
    property Buffered: Boolean read FBuffered write FBuffered;
  end;

implementation

{ TJSChangePersistent }

constructor TJSChangePersistent.Create;
begin
  inherited;
  FIgnoreChange := False;
end;

{ Call this method to trigger the classes OnChange event, if
  one has been specified.                                    }
procedure TJSChangePersistent.DoChange;
begin
  if not FIgnoreChange and Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TJSGradient }

procedure TJSGradient.Assign(Source: TPersistent);
var
  lSrc: TJSGradient;
begin
  if Source is TJSGradient then
  begin
    lSrc := Source as TJSGradient;
    FEnabled := lSrc.Enabled;
    FDirection := lSrc.Direction;
    FEndColor := lSrc.EndColor;
    FStartColor := lSrc.StartColor;
  end
  else
    inherited;
end;

constructor TJSGradient.Create;
begin
  inherited;
  FEnabled := False;
  FDirection := gdHorizontal;
  FStartColor := clNone;
  FEndColor := clNone;
end;

procedure TJSGradient.SetDirection(const Value: TGradientDirection);
begin
  if FDirection <> Value then
  begin
    FDirection := Value;
    DoChange;
  end;
end;

procedure TJSGradient.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    DoChange;
  end;
end;

procedure TJSGradient.SetEndColor(const Value: TColor);
begin
  if FEndColor <> Value then
  begin
    FEndColor := Value;
    DoChange;
  end;
end;

procedure TJSGradient.SetStartColor(const Value: TColor);
begin
  if FStartColor <> Value then
  begin
    FStartColor := Value;
    DoChange;
  end;
end;

{ TJSBackground }

procedure TJSBackground.Assign(Source: TPersistent);
var
  LSrc: TJSBackground;
begin
  if Source is TJSBackground then
  begin
    LSrc := TJSBackground(Source);
    FColor := LSrc.Color;
    FGradient := LSrc.Gradient;
    FAutoFree := LSrc.AutoFree;
    FCopyRect := LSrc.CopyRect;
    FBuffered := LSrc.Buffered;
  end
  else
    inherited;
end;

constructor TJSBackground.Create(const AColor: TColor; AGradient: TJSGradient; ACopyRect: TRect;
  ABuffered: Boolean = True; AAutoFree: Boolean = True);
begin
  inherited Create;
  FGradient := TJSGradient.Create;
  if AGradient <> nil then
    FGradient.Assign(AGradient)
  else
    FGradient.Enabled := False;
  FColor := AColor;
  FAutoFree := AAutoFree;
  FCopyRect := ACopyRect;
  FBuffered := ABuffered;
end;

destructor TJSBackground.Destroy;
begin
  FGradient.Free;
  inherited;
end;

end.

