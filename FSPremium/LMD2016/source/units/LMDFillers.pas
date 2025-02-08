unit LMDFillers;
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

LMD VCL Series 2010
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdtools.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
BugTracking        : http://bts.lmd.de
Fax                : ++49 69 15347696

################################################################################

LMDFillers unit (EN/VB)
--------------------

Changes
-------

Release 10.0X (January 2010)
 - Initial Release
###############################################################################}


interface

uses Classes, Types, Graphics, LMDGraphUtils;

type
  TLMDColorChannel = class (TObject)
  private
    FBasePoint: TPoint;
    FLengthN: Integer;
    FLengthT: Integer;
    FValues: array of byte;
    FVectorN: TPoint;
    FVectorT: TPoint;
    function GetBasePoint: TPoint; virtual;
    function GetFixedValues(Index: Integer): Byte;
    function GetStartValue: Byte; virtual;
    function GetValueByPosAndDist(ADist, APos: integer): Byte; virtual;
    function GetValueCount: Integer;
    function GetEndValue: Byte; virtual;
    function GetVectorN: TPoint; virtual;
    function GetVectorT: TPoint; virtual;
    procedure SetBasePoint(Value: TPoint); virtual;
    procedure SetFixedValues(Index: Integer; const Value: Byte);
    procedure SetLengthN(Value: Integer); virtual;
    procedure SetLengthT(Value: Integer); virtual;
    procedure SetStartValue(Value: Byte); virtual;
    procedure SetValueCount(NewCount: Integer);
    procedure SetEndValue(Value: Byte); virtual;
    procedure SetVectorN(Value: TPoint); virtual;
    procedure SetVectorT(Value: TPoint); virtual;
    property LengthN: Integer read FLengthN write SetLengthN;
    property LengthT: Integer read FLengthT write SetLengthT;
  protected
    procedure BoundRect(ARect: TRect); virtual;
    procedure SetPosition(AObject: TObject); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function Value(APoint: TPoint): Byte; virtual;
    property BasePoint: TPoint read GetBasePoint write SetBasePoint;
    property FixedValues[Index: Integer]: Byte read GetFixedValues write
            SetFixedValues;
    property StartValue: Byte read GetStartValue write SetStartValue;
    property ValueCount: Integer read GetValueCount write SetValueCount;
    property EndValue: Byte read GetEndValue write SetEndValue;
    property VectorN: TPoint read GetVectorN write SetVectorN;
    property VectorT: TPoint read GetVectorT write SetVectorT;
  end;

  TLMDContainerColorChannel = class (TLMDColorChannel)
  private
    FComponentFillerList: TList;
    function GetBasePoint: TPoint; override;
    function GetItem(Index: Integer): TLMDColorChannel; virtual;
    function GetStartValue: Byte; override;
    function GetEndValue: Byte; override;
    function GetVectorN: TPoint; override;
    function GetVectorT: TPoint; override;
    procedure SetBasePoint(Value: TPoint); override;
    procedure SetItem(Index: Integer; Value: TLMDColorChannel); virtual;
    procedure SetLengthN(Value: Integer); override;
    procedure SetLengthT(Value: Integer); override;
    procedure SetStartValue(Value: Byte); override;
    procedure SetEndValue(Value: Byte); override;
    procedure SetVectorN(Value: TPoint); override;
    procedure SetVectorT(Value: TPoint); override;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Add(AComponentFiller: TLMDColorChannel); virtual;
    function Count: Integer; virtual;
    procedure Delete(AComponentFiller: TLMDColorChannel); virtual;
    property Item[Index: Integer]: TLMDColorChannel read GetItem write SetItem;
  end;

  TLMDMixedColorChannel = class (TLMDContainerColorChannel)
  private
    FWeight: array of byte;
    function GetWeight(Index: Integer): Byte;
    procedure SetWeight(Index: Integer; NewValue: Byte);
  public
    destructor Destroy; override;
    procedure Add(AComponentFiller: TLMDColorChannel); override;
    procedure Delete(AComponentFiller: TLMDColorChannel); override;
    function Value(APoint: TPoint): Byte; override;
    property Weight[Index: Integer]: Byte read GetWeight write SetWeight;
  end;

  TLMDCompositeColorChannel = class (TLMDContainerColorChannel)
  private
    FFillerRects: array of TRect;
    function GetFillerRect(Index: Integer): TRect;
    procedure SetFillerRect(Index: Integer; Value: TRect);
  protected
    procedure SetBasePoint(Value: TPoint); override;
  public
    destructor Destroy; override;
    procedure Add(AComponentFiller: TLMDColorChannel); override;
    procedure Delete(AComponentFiller: TLMDColorChannel); override;
    function Value(APoint: TPoint): Byte; override;
    property FillerRect[Index: Integer]: TRect read GetFillerRect write SetFillerRect;
  end;

  TLMDSolidColorChannel = class (TLMDColorChannel)
  public
    function Value(APoint: TPoint): Byte; override;
  end;

  TLMDVerticalColorChannel = class (TLMDColorChannel)
  public
    function Value(APoint: TPoint): Byte; override;
  end;

  TLMDHorizontalColorChannel = class (TLMDColorChannel)
  public
    function Value(APoint: TPoint): Byte; override;
  end;

  TLMDEllipseColorChannel = class (TLMDColorChannel)
  private
    FAxis1: Integer;
    FAxis2: Integer;
    FFirstAxisDirection: TPoint;
    FLengthNt: Integer;
    procedure SetAxis1(Value: Integer);
    procedure SetAxis2(Value: Integer);
    procedure SetFirstAxisDirection(Value: TPoint);
    procedure SetLengthN(Value: Integer); override;
    procedure SetLengthT(Value: Integer); override;
    procedure SetParam;
  protected
    procedure SetPosition(AObject: TObject); override;
  public
    function Value(APoint: TPoint): Byte; override;
    property Axis1: Integer read FAxis1 write SetAxis1;
    property Axis2: Integer read FAxis2 write SetAxis2;
    property FirstAxisDirection: TPoint read FFirstAxisDirection write SetFirstAxisDirection;
  end;

  TLMDDirectedColorChannel = class (TLMDColorChannel)
  private
    function GetDirection: TPoint;
    procedure SetDirection(Value: TPoint);
  protected
    procedure BoundRect(ARect: TRect); override;
  public
    property Direction: TPoint read GetDirection write SetDirection;
  end;

  TLMDLineColorChannel = class (TLMDDirectedColorChannel)
  protected
    procedure SetPosition(AObject: TObject); override;
  public
    function Value(APoint: TPoint): Byte; override;
  end;

  TLMDBandColorChannel = class (TLMDDirectedColorChannel)
  private
    FWidth: Integer;
  protected
    procedure BoundRect(ARect: TRect); override;
    procedure SetPosition(AObject: TObject); override;
  public
    function Value(APoint: TPoint): Byte; override;
    property Width: Integer read FWidth write FWidth;
  end;

  TLMDRectangleColorChannel = class (TLMDColorChannel)
  public
    function Value(APoint: TPoint): Byte; override;
  end;

  TLMDFiller = class (TObject)
  private
    function GetColorCount: Integer;
    function GetFixedAlpha(Index: Integer): Byte;
    function GetFixedColors(Index: Integer): TColor;
    procedure SetColorCount(Value: Integer);
    procedure SetFixedAlpha(Index: Integer; Value: Byte);
    procedure SetFixedColors(Index: Integer; Value: TColor);
  protected
    FUseRelativeUnits: boolean;
    FRedChannel: TLMDColorChannel;
    FGreenChannel: TLMDColorChannel;
    FBlueChannel: TLMDColorChannel;
    FAlphaChannel: TLMDColorChannel;
    function GetBasePoint: TPoint; virtual;
    function GetStartColor: TColor; virtual;
    function GetEndColor: TColor; virtual;
    function GetVectorN: TPoint; virtual;
    function GetVectorT: TPoint; virtual;
    procedure SetBasePoint(Value: TPoint); virtual;
    procedure SetStartColor(Value: TColor); virtual;
    procedure SetEndColor(Value: TColor); virtual;
    function GetStartAlpha: Byte; virtual;
    function GetEndAlpha: Byte; virtual;
    procedure SetStartAlpha(Value: Byte); virtual;
    procedure SetEndAlpha(Value: Byte); virtual;
    procedure SetVectorN(Value: TPoint); virtual;
    procedure SetVectorT(Value: TPoint); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function CreateFrom(aFiller: TLMDFiller): TLMDFiller;
    function Clone(aCopyColorsAndAlpha: boolean = true): TLMDFiller;
    procedure ChangeColorBrightness(aPercent: integer; aIndex: integer = -1);
    //Replaces colors starting from aIndex (-1 or 0 means that all entries of aOldColor will be replaced)
    procedure ReplaceColor(aOldColor, aNewColor: TColor; aIndex: integer = -1);
    procedure SetNewColor(aColor: TColor; aIndex: integer = -1);
    //procedure ChangeAlpha(aFiller: TLMDFiller; aIndex: integer = -1);
    procedure AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true); reintroduce; virtual;
    procedure BoundRect(ARect: TRect); virtual;
    procedure CopyColorsAndAlphaFrom(aFiller: TLMDFiller; aReverse: Boolean = false);
    procedure Draw(ABitmap24: TBitmap); virtual;
    procedure SetPosition(AObject: TObject); virtual;
    property BasePoint: TPoint read GetBasePoint write SetBasePoint;
    property StartColor: TColor read GetStartColor write SetStartColor;
    property EndColor: TColor read GetEndColor write SetEndColor;
    property StartAlpha: Byte read GetStartAlpha write SetStartAlpha;
    property EndAlpha: Byte read GetEndAlpha write SetEndAlpha;
    property RedChannel: TLMDColorChannel read FRedChannel write FRedChannel;
    property GreenChannel: TLMDColorChannel read FGreenChannel write
            FGreenChannel;
    property BlueChannel: TLMDColorChannel read FBlueChannel write FBlueChannel;
    property AlphaChannel: TLMDColorChannel read FAlphaChannel write
            FAlphaChannel;
    property VectorN: TPoint read GetVectorN write SetVectorN;
    property VectorT: TPoint read GetVectorT write SetVectorT;
    property ColorCount: Integer read GetColorCount write SetColorCount;
    property FixedAlpha[Index: Integer]: Byte read GetFixedAlpha write
            SetFixedAlpha;
    property FixedColors[Index: Integer]: TColor read GetFixedColors write
            SetFixedColors;
    property UseRelativeUnits: boolean read FUseRelativeUnits write FUseRelativeUnits;
  end;

  TLMDFillerClass = class of TLMDFiller;

  TLMDContainerFiller = class (TLMDFiller)
  private
    FFillerList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TLMDFiller;
    procedure SetItem(Index: Integer; Value: TLMDFiller);
  public
    procedure Add(AFiller: TLMDFiller); virtual;
    procedure AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true); override;
    constructor Create; override;
    procedure Clear(aFreeItems: boolean = false);
    destructor Destroy; override;
    procedure Delete(AFiller: TLMDFiller); overload; virtual;
    procedure Delete(aFillerIndex: integer); overload; virtual;
    property Count: Integer read GetCount;
    property Item[Index: Integer]: TLMDFiller read GetItem write SetItem;
  end;

  TLMDCompositeFiller = class (TLMDContainerFiller)
  private
    function GetFillerRect(Index: Integer): TRect;
    procedure SetFillerRect(Index: Integer; Value: TRect);
  protected
    procedure SetBasePoint(Value: TPoint); override;
  public
    procedure AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true); override;
    constructor Create; override;
    property FillerRect[Index: Integer]: TRect read GetFillerRect write SetFillerRect;
  end;

  TLMDMixedFiller = class (TLMDContainerFiller)
  private
    function GetWeight(Index: Integer): Byte;
    procedure SetWeight(Index: Integer; NewValue: Byte);
  protected
  public
    procedure AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true); override;
    constructor Create; override;
    property Weight[Index: Integer]: Byte read GetWeight write SetWeight;
  end;

  TLMDSolidFiller = class (TLMDFiller)
  private
    function GetColor: TColor;
    procedure SetColor(Value: TColor);
  public
    constructor Create; override;
    property Color: TColor read GetColor write SetColor;
  end;

  TLMDEllipseFiller = class (TLMDFiller)
  private
    FAxis1: Integer;
    FAxis2: Integer;
    FFirstAxisDirection: TPoint;
    procedure SetAxis1(Value: Integer);
    procedure SetAxis2(Value: Integer);
    procedure SetFirstAxisDirection(Value: TPoint);
  public
    procedure AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true); override;
    constructor Create; override;
    property Axis1: Integer read FAxis1 write SetAxis1;
    property Axis2: Integer read FAxis2 write SetAxis2;
    property FirstAxisDirection: TPoint read FFirstAxisDirection write
            SetFirstAxisDirection;
  end;

  TLMDRoundFiller = class (TLMDEllipseFiller)
  private
    function GetRadius: Integer;
    procedure SetRadius(Value: Integer);
  public
    procedure AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true); override;
    property Radius: Integer read GetRadius write SetRadius;
  end;

  TLMDLineFiller = class (TLMDFiller)
  private
    function GetDirection: TPoint;
    procedure SetDirection(Value: TPoint);
  public
    constructor Create; override;
    property Direction: TPoint read GetDirection write SetDirection;
  end;

  TLMDVerticalGradient = class (TLMDFiller)
  private
    function GetHeight: Integer;
    procedure SetHeight(Value: Integer);
  public
    constructor Create; override;
    property Height: Integer read GetHeight write SetHeight;
  end;

  TLMDHorizontalGradient = class (TLMDFiller)
  private
    function GetHeight: Integer;
    procedure SetHeight(Value: Integer);
  public
    constructor Create; override;
    property Height: Integer read GetHeight write SetHeight;
  end;

  TLMDBandFiller = class (TLMDFiller)
  private
    function GetDirection: TPoint;
    function GetWidth: Integer;
    procedure SetDirection(Value: TPoint);
    procedure SetWidth(Value: Integer);
  public
    constructor Create; override;
    property Direction: TPoint read GetDirection write SetDirection;
    property Width: Integer read GetWidth write SetWidth;
  end;

  TLMDRectangleFiller = class (TLMDFiller)
  public
    constructor Create; override;
  end;

implementation

uses SysUtils, LMDProcs, LMDFigures;

{****************************** TLMDColorChannel *****************************}
constructor TLMDColorChannel.Create;
begin
  inherited Create;
  ValueCount := 2;
  FBasePoint := Point(0,0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.BoundRect(ARect: TRect);
begin
  BasePoint := ARect.TopLeft;
  VectorN := Point(ARect.Right - ARect.Left, 0);
  VectorT := Point(0, ARect.Bottom - ARect.Top);
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.GetBasePoint: TPoint;
begin
  Result := FBasePoint;
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.GetFixedValues(Index: Integer): Byte;
begin
  if (Index >= low(FValues)) and (Index <= high(FValues)) then
    result := FValues[Index]
  else
    result := 255;  
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.GetStartValue: Byte;
begin
  result := FValues[0];
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.GetValueByPosAndDist(ADist, APos: integer): Byte;
var
  i: Integer;
  LStep: Integer;
  lV: byte;
begin
  if ADist = 0 then
    result := FValues[0]
  else
  begin
    LStep := ADist div (ValueCount - 1);
    if LStep <> 0 then
      i := APos div LStep
    else
      i := 0;

    if (low(FValues) <= i+1) and (i+1 <= high(FValues)) then
      lV := FValues[i+1]
    else
      lV := 255;

    result := LMDCalcProportion(FValues[i], lV, LStep, APos - LStep * i);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.GetValueCount: Integer;
begin
  result := Length(FValues);
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.GetEndValue: Byte;
begin
  result := FValues[ValueCount - 1];
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.GetVectorN: TPoint;
begin
  Result := FVectorN;
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.GetVectorT: TPoint;
begin
  Result := FVectorT;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetBasePoint(Value: TPoint);
begin
  FBasePoint := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetFixedValues(Index: Integer; const Value: Byte);
begin
  if (Index >= low(FValues)) and (Index <= high(FValues)) then
    FValues[Index] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetLengthN(Value: Integer);
begin
  FLengthN := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetLengthT(Value: Integer);
begin
  FLengthT := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetPosition(AObject: TObject);
begin
  if AObject is TLMDFigure then
    BoundRect((AObject as TLMDFigure).IncludeRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetStartValue(Value: Byte);
begin
  FValues[0] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetValueCount(NewCount: Integer);
var
  i, lOldValueCount, k: Integer;
begin
  if NewCount > 1 then
  begin
    lOldValueCount := Length(FValues);
    if NewCount <> lOldValueCount then
      begin
        SetLength(FValues, NewCount); //todo: FastMM does not like this place
        if lOldValueCount = 0 then
          k := 0
        else
          k := lOldValueCount - 1;

        if lOldValueCount < NewCount then
          for i := k to NewCount - 1 do
            FValues[i] := 255;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetEndValue(Value: Byte);
begin
  FValues[ValueCount - 1] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetVectorN(Value: TPoint);
begin
  FVectorN := Value;
  LengthN := Round(Sqrt(Value.X * Value.X + Value.Y * Value.Y));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorChannel.SetVectorT(Value: TPoint);
begin
  FVectorT := Value;
  LengthT := Round(Sqrt(Value.X * Value.X + Value.Y * Value.Y));
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorChannel.Value(APoint: TPoint): Byte;
begin
  result := 0;
end;

{
*************************** TLMDContainerColorChannel ***************************
}
constructor TLMDContainerColorChannel.Create;
begin
  FComponentFillerList := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDContainerColorChannel.Destroy;
var
  i: integer;
begin
  for i := FComponentFillerList.Count - 1 downto 0 do
    begin
      TLMDColorChannel(FComponentFillerList.Items[i]).Free;
      FComponentFillerList.Delete(i);
    end;
  FComponentFillerList.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.Add(AComponentFiller: TLMDColorChannel);
begin
  FComponentFillerList.Add(AComponentFiller);
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerColorChannel.Count: Integer;
begin
  result := FComponentFillerList.Count;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.Delete(AComponentFiller: TLMDColorChannel);
begin
  if FComponentFillerList.IndexOf(AComponentFiller) > -1 then
    FComponentFillerList.Delete(FComponentFillerList.IndexOf(AComponentFiller));
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerColorChannel.GetBasePoint: TPoint;
begin
  if FComponentFillerList.Count > 0 then
    result := TLMDColorChannel(FComponentFillerList.Items[0]).BasePoint
  else
    result := Point(0, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerColorChannel.GetItem(Index: Integer): TLMDColorChannel;
begin
  if (Index < FComponentFillerList.Count) then
    result := TLMDColorChannel(FComponentFillerList.Items[Index])
  else
    result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerColorChannel.GetStartValue: Byte;
begin
  if FComponentFillerList.Count > 0 then
    result := TLMDColorChannel(FComponentFillerList.Items[0]).StartValue
  else
    result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerColorChannel.GetEndValue: Byte;
begin
  if FComponentFillerList.Count > 0 then
    result := TLMDColorChannel(FComponentFillerList.Items[0]).EndValue
  else
    result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerColorChannel.GetVectorN: TPoint;
begin
  if FComponentFillerList.Count>0 then
    result := TLMDColorChannel(FComponentFillerList.Items[0]).VectorN
  else
    result := Point(0, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerColorChannel.GetVectorT: TPoint;
begin
  if FComponentFillerList.Count > 0 then
    result := TLMDColorChannel(FComponentFillerList.Items[0]).VectorT
  else
    result := Point(0, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.SetBasePoint(Value: TPoint);
var
  i: Integer;
begin
  for i:=0 to FComponentFillerList.Count - 1 do
    TLMDColorChannel(FComponentFillerList.Items[i]).BasePoint := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.SetItem(Index: Integer; Value:
        TLMDColorChannel);
begin
  FComponentFillerList.Items[Index] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.SetLengthN(Value: Integer);
var
  i: Integer;
begin
  for i:=0 to FComponentFillerList.Count - 1 do
    TLMDColorChannel(FComponentFillerList.Items[i]).LengthN := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.SetLengthT(Value: Integer);
var
  i: Integer;
begin
  for i:=0 to FComponentFillerList.Count - 1 do
    TLMDColorChannel(FComponentFillerList.Items[i]).LengthT := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.SetStartValue(Value: Byte);
var
  i: Integer;
begin
  for i:=0 to FComponentFillerList.Count - 1 do
    TLMDColorChannel(FComponentFillerList.Items[i]).StartValue := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.SetEndValue(Value: Byte);
var
  i: Integer;
begin
  for i:=0 to FComponentFillerList.Count - 1 do
    TLMDColorChannel(FComponentFillerList.Items[i]).EndValue := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.SetVectorN(Value: TPoint);
var
  i: Integer;
begin
  for i:=0 to FComponentFillerList.Count - 1 do
    TLMDColorChannel(FComponentFillerList.Items[i]).VectorN := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerColorChannel.SetVectorT(Value: TPoint);
var
  i: Integer;
begin
  for i:=0 to FComponentFillerList.Count - 1 do
    TLMDColorChannel(FComponentFillerList.Items[i]).VectorT := Value;
end;

{*************************** TLMDMixedColorChannel ***************************}
procedure TLMDMixedColorChannel.Add(AComponentFiller: TLMDColorChannel);
begin
  inherited Add(AComponentFiller);
  SetLength(FWeight, FComponentFillerList.Count);
  FWeight[FComponentFillerList.Count - 1] := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMixedColorChannel.Delete(AComponentFiller: TLMDColorChannel);
var
  i, FIndexOfFiller: Integer;
begin
  FIndexOfFiller := FComponentFillerList.IndexOf(AComponentFiller);
  if FIndexOfFiller>-1 then
    for i:=FIndexOfFiller to FComponentFillerList.Count - 2 do
      FWeight[i] := FWeight[i - 1];
  inherited Delete(AComponentFiller);
  SetLength(FWeight, FComponentFillerList.Count);
end;

destructor TLMDMixedColorChannel.Destroy;
begin
  SetLength(FWeight, 0);
  inherited;
end;

function TLMDMixedColorChannel.GetWeight(Index: Integer): Byte;
begin
  result := FWeight[Index];
end;

procedure TLMDMixedColorChannel.SetWeight(Index: Integer; NewValue: Byte);
begin
  FWeight[Index] := NewValue;
end;

function TLMDMixedColorChannel.Value(APoint: TPoint): Byte;
var
  LSumValue, LSumWeight: Integer;
  i: Integer;
begin
  LSumValue := 0;
  LSumWeight := 0;
  for i:=0 to FComponentFillerList.Count - 1 do
    if FWeight[i] <> 0 then
    begin
      Inc(LSumValue, FWeight[i] * TLMDColorChannel(FComponentFillerList.Items[i]).Value(APoint));
      Inc(LSumWeight, FWeight[i]);
    end;

  if (FComponentFillerList.Count > 0) and (LSumWeight > 0) then
    result := LSumValue div LSumWeight
  else
    result := 0;
end;

{
************************** TLMDCompositeColorChannel ***************************
}
procedure TLMDCompositeColorChannel.Add(AComponentFiller: TLMDColorChannel);
begin
  inherited Add(AComponentFiller);
  SetLength(FFillerRects, FComponentFillerList.Count);
end;

procedure TLMDCompositeColorChannel.Delete(AComponentFiller: TLMDColorChannel);
var
  i, FIndexOfFiller: Integer;
begin
  FIndexOfFiller := FComponentFillerList.IndexOf(AComponentFiller);
  if FIndexOfFiller > -1 then
    for i:=FIndexOfFiller to FComponentFillerList.Count - 2 do
      FFillerRects[i] := FFillerRects[i - 1];
  inherited Delete(AComponentFiller);
  SetLength(FFillerRects,  FComponentFillerList.Count);
end;

destructor TLMDCompositeColorChannel.Destroy;
begin
  SetLength(FFillerRects, 0);
  inherited;
end;

function TLMDCompositeColorChannel.GetFillerRect(Index: Integer): TRect;
begin
  result := FFillerRects[Index];
end;

procedure TLMDCompositeColorChannel.SetBasePoint(Value: TPoint);
begin
  inherited;
end;

procedure TLMDCompositeColorChannel.SetFillerRect(Index: Integer; Value: TRect);
begin
  FFillerRects[Index] := Value;
end;

function TLMDCompositeColorChannel.Value(APoint: TPoint): Byte;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to FComponentFillerList.Count - 1 do
    if LMDPointInRect(APoint, FFillerRects[i]) then
    begin
      value := Item[i].Value(APoint);
      break;
    end;
end;

{
**************************** TLMDSolidColorChannel *****************************
}
function TLMDSolidColorChannel.Value(APoint: TPoint): Byte;
begin
  result := FValues[0];
end;

{
*************************** TLMDVerticalColorChannel ***************************
}
function TLMDVerticalColorChannel.Value(APoint: TPoint): Byte;
begin
  result := GetValueByPosAndDist(abs(FVectorT.Y), abs(APoint.Y - FBasePoint.Y));
end;

{
************************** TLMDHorizontalColorChannel **************************
}
function TLMDHorizontalColorChannel.Value(APoint: TPoint): Byte;
begin
  result := GetValueByPosAndDist(abs(FVectorN.X), abs(APoint.X - FBasePoint.X));
end;

{
*************************** TLMDEllipseColorChannel ****************************
}
procedure TLMDEllipseColorChannel.SetAxis1(Value: Integer);
begin
  FAxis1 := Value;
  SetParam;
end;

procedure TLMDEllipseColorChannel.SetAxis2(Value: Integer);
begin
  FAxis2 := Value;
  SetParam;
end;

procedure TLMDEllipseColorChannel.SetFirstAxisDirection(Value: TPoint);
begin
  FFirstAxisDirection := Value;
  SetParam;
end;

procedure TLMDEllipseColorChannel.SetLengthN(Value: Integer);
begin
  inherited SetLengthN(Value);
  FLengthNt := LengthN * LengthT;
end;

procedure TLMDEllipseColorChannel.SetLengthT(Value: Integer);
begin
  inherited SetLengthT(Value);
  FLengthNt := LengthN * LengthT;
end;

procedure TLMDEllipseColorChannel.SetParam;
var
  LDirectionLength: Double;
begin
  if (FAxis1 <> 0) and (FAxis2 <> 0) and
     ((FFirstAxisDirection.X <> 0) or (FFirstAxisDirection.Y <> 0)) then
  begin
    LDirectionLength := Sqrt(FFirstAxisDirection.X * FFirstAxisDirection.X + FFirstAxisDirection.Y * FFirstAxisDirection.X);
    VectorN := Point(Round(FFirstAxisDirection.X*FAxis1/LDirectionLength),
                      Round(FFirstAxisDirection.Y*FAxis1/LDirectionLength));
    VectorT := Point(Round(FFirstAxisDirection.Y*FAxis2/LDirectionLength),
                      Round(-FFirstAxisDirection.X*FAxis2/LDirectionLength));
  end;
end;

procedure TLMDEllipseColorChannel.SetPosition(AObject: TObject);
var
  LFigure: TLMDFigure;
  LLengthN: Double;
begin
  if AObject is TLMDFigure then
  begin
    LFigure := AObject as TLMDFigure;
    if (LFigure is TLMDEllipse) or (LFigure is TLMDCircle) then
    begin
      BasePoint := LFigure.BasePoint;
      VectorN := LFigure.VectorN;
      VectorT := LFigure.VectorT;
    end;
    if LFigure is TLMDLine then
    begin
      BasePoint := Point(LFigure.BasePoint.X + LFigure.VectorN.X div 2, LFigure.BasePoint.Y + LFigure.VectorN.Y div 2);
      VectorN := Point(LFigure.VectorN.X div 2, LFigure.VectorN.Y div 2);
      LLengthN := Sqrt(LFigure.VectorN.X * LFigure.VectorN.X + LFigure.VectorN.Y * LFigure.VectorN.Y);
      VectorT := Point(-Round((LFigure.VectorN.Y * (LFigure as TLMDLine).Width ) / LLengthN / 2),
                        Round((LFigure.VectorN.X * (LFigure as TLMDLine).Width ) / LLengthN / 2));
    end;
    if (LFigure is TLMDRectangle) or (LFigure is TLMDRoundRectangle) or (LFigure is TLMDCutRectangle) then
    begin
      BasePoint := Point(LFigure.BasePoint.X + LFigure.VectorN.X div 2 + LFigure.VectorT.X div 2,
                         LFigure.BasePoint.Y + LFigure.VectorN.Y div 2 + LFigure.VectorT.Y div 2);
      VectorN := Point(LFigure.VectorN.X div 2, LFigure.VectorN.Y div 2);
      VectorT := Point(LFigure.VectorT.X div 2, LFigure.VectorT.Y div 2);
    end;
  end;
end;

function TLMDEllipseColorChannel.Value(APoint: TPoint): Byte;
var
  X1, Y1, X2, Y2, X2LT, Y2LN: Integer;
  lr1 : double;
  lr2 : double;
   lr : double;
begin
  X1 := APoint.X - BasePoint.X;
  Y1 := APoint.Y - BasePoint.Y;
  X2 := (X1 * VectorN.X + Y1 * VectorN.Y) div LengthN;
  Y2 := (X1 * VectorT.X + Y1 * VectorT.Y) div LengthT;

  //fast method
  //result := GetValueByPosAndDist(FLengthNt, FastIntDistance(X2 * LengthT, Y2 * LengthN))

  //slow method
  X2LT := X2 * LengthT;
  Y2LN := Y2 * LengthN;
  lr1 := X2LT;
  lr1 := SQR(lr1);
  lr2 := Y2LN;
  lr2 := SQR(lr2);
  lr := lr1 + lr2;
  result := GetValueByPosAndDist(FLengthNt, Round(Sqrt(lr)));
end;

{
*************************** TLMDDirectedColorChannel ***************************
}
procedure TLMDDirectedColorChannel.BoundRect(ARect: TRect);
begin
  Direction := Point(ARect.Right - ARect.Left, 0);
  BasePoint := Point(ARect.Left, ARect.Top + (ARect.Bottom - ARect.Top) div 2);
end;

function TLMDDirectedColorChannel.GetDirection: TPoint;
begin
  result := VectorN;
end;

procedure TLMDDirectedColorChannel.SetDirection(Value: TPoint);
begin
  VectorN := Value;
end;

{
***************************** TLMDLineColorChannel *****************************
}
procedure TLMDLineColorChannel.SetPosition(AObject: TObject);
var
  LFigure: TLMDFigure;
begin
  if AObject is TLMDFigure then
  begin
    LFigure := AObject as TLMDFigure;
    if (LFigure is TLMDLine) or (LFigure is TLMDRectangle) or (LFigure is TLMDRoundRectangle) or (LFigure is TLMDCutRectangle) then
    begin
      BasePoint := LFigure.BasePoint;
      VectorN := LFigure.VectorN;
      VectorT := LFigure.VectorT;
    end;
    if (LFigure is TLMDEllipse) or (LFigure is TLMDCircle) then
    begin
      BasePoint := Point(LFigure.BasePoint.X - LFigure.VectorN.X, LFigure.BasePoint.Y - LFigure.VectorN.Y);
      VectorN := Point(LFigure.VectorN.X * 2, LFigure.VectorN.Y * 2);
      VectorT := LFigure.VectorT;
    end;
  end;
end;

function TLMDLineColorChannel.Value(APoint: TPoint): Byte;
begin
  result := GetValueByPosAndDist(LengthN * LengthN, Abs(((APoint.X - BasePoint.X) * VectorN.X + (APoint.Y - BasePoint.Y) * VectorN.Y)));
end;

{
***************************** TLMDBandColorChannel *****************************
}
procedure TLMDBandColorChannel.BoundRect(ARect: TRect);
begin
  inherited BoundRect(ARect);
  Width := ARect.Bottom - ARect.Top;
end;

procedure TLMDBandColorChannel.SetPosition(AObject: TObject);
var
  LFigure: TLMDFigure;
begin
  if AObject is TLMDFigure then
  begin
    LFigure := AObject as TLMDFigure;
    if (LFigure is TLMDLine) then
    begin
      BasePoint := LFigure.BasePoint;
      VectorN := LFigure.VectorN;
      VectorT := LFigure.VectorT;
      Width := (LFigure as TLMDLine).Width;
    end;
    if (LFigure is TLMDRectangle) or (LFigure is TLMDRoundRectangle) or (LFigure is TLMDCutRectangle) then
    begin
      BasePoint := Point(LFigure.BasePoint.X + LFigure.VectorT.X div 2, LFigure.BasePoint.Y + LFigure.VectorT.Y div 2);
      VectorN := LFigure.VectorN;
      VectorT := LFigure.VectorT;
      Width := Round(Sqrt(LFigure.VectorT.X * LFigure.VectorT.X + LFigure.VectorT.Y * LFigure.VectorT.Y)) div 2;
    end;
    if (LFigure is TLMDEllipse) or (LFigure is TLMDCircle) then
    begin
      BasePoint := Point(LFigure.BasePoint.X - LFigure.VectorN.X, LFigure.BasePoint.Y - LFigure.VectorN.Y);
      VectorN := Point(LFigure.VectorN.X * 2, LFigure.VectorN.Y * 2);
      VectorT := LFigure.VectorT;
      Width := Round(Sqrt(LFigure.VectorT.X * LFigure.VectorT.X + LFigure.VectorT.Y * LFigure.VectorT.Y));
    end;
  end;
end;

function TLMDBandColorChannel.Value(APoint: TPoint): Byte;
begin
  result := GetValueByPosAndDist(LengthN * FWidth, Abs(((APoint.X - BasePoint.X) * VectorN.Y - (APoint.Y - BasePoint.Y) * VectorN.X)));
end;

{
************************** TLMDRectangleColorChannel ***************************
}
function TLMDRectangleColorChannel.Value(APoint: TPoint): Byte;
var
  X1, Y1, X2, Y2: Integer;
begin
  X1 := APoint.X - BasePoint.X;
  Y1 := APoint.Y - BasePoint.Y;
  X2 := ABS((X1 * VectorN.X + Y1 * VectorN.Y) div FLengthN);
  Y2 := ABS((X1 * VectorT.X + Y1 * VectorT.Y) div FLengthT);

  if X2 * FLengthT > Y2 * FLengthN then
    result := GetValueByPosAndDist(FLengthN, X2)
  else
    result := GetValueByPosAndDist(FLengthT, Y2);
end;

{********************************** TLMDFiller ********************************}
procedure TLMDFiller.CopyColorsAndAlphaFrom(aFiller: TLMDFiller; aReverse: Boolean = false);
var
  i, j: integer;
begin
  if aFiller = nil then
    exit;
  ColorCount := aFiller.ColorCount;
  for i := 0 to ColorCount - 1 do
    begin
      if aReverse then
        j := ColorCount - 1 - i
      else
        j := i;
      FixedColors[i] := aFiller.FixedColors[j];
      FixedAlpha[i] := aFiller.FixedAlpha[j];
    end;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFiller.Destroy;
begin
  if Assigned(RedChannel) then
    RedChannel.Free;
  if Assigned(GreenChannel) then
    GreenChannel.Free;
  if Assigned(BlueChannel) then
    BlueChannel.Free;
  if Assigned(AlphaChannel) then
    AlphaChannel.Free;    
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.BoundRect(ARect: TRect);
begin
  if Assigned(FRedChannel) then
    FRedChannel.BoundRect(ARect);
  if Assigned(FGreenChannel) then
    FGreenChannel.BoundRect(ARect);
  if Assigned(FBlueChannel) then
    FBlueChannel.BoundRect(ARect);
  if Assigned(FAlphaChannel) then
    FBlueChannel.BoundRect(ARect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.Draw(ABitmap24: TBitmap);
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetStartAlpha: Byte;
begin
  result := FAlphaChannel.StartValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetEndAlpha: Byte;
begin
  result := FAlphaChannel.EndValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetBasePoint: TPoint;
begin
  result := FRedChannel.BasePoint;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetStartColor: TColor;
begin
  result := LMDGetARGBColor(FRedChannel.StartValue, FGreenChannel.StartValue, FBlueChannel.StartValue, FAlphaChannel.StartValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetColorCount: Integer;
begin
  result := FRedChannel.ValueCount;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetEndColor: TColor;
begin
  result := LMDGetARGBColor(FRedChannel.EndValue, FGreenChannel.EndValue, FBlueChannel.EndValue, FAlphaChannel.EndValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetFixedAlpha(Index: Integer): Byte;
begin
  if Index < ColorCount then
    result := FAlphaChannel.FixedValues[Index]
  else
    result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetFixedColors(Index: Integer): TColor;
begin
  if Index < ColorCount then
    result := LMDGetColor(FRedChannel.FixedValues[Index], FGreenChannel.FixedValues[Index], FBlueChannel.FixedValues[Index])
  else result := $00000000;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetVectorN: TPoint;
begin
  result := FRedChannel.VectorN;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.GetVectorT: TPoint;
begin
  result := FRedChannel.VectorT;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetStartAlpha(Value: Byte);
begin
  FAlphaChannel.StartValue := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetEndAlpha(Value: Byte);
begin
  FAlphaChannel.EndValue := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetBasePoint(Value: TPoint);
begin
  FRedChannel.BasePoint := Value;
  FGreenChannel.BasePoint := Value;
  FBlueChannel.BasePoint := Value;
  FAlphaChannel.BasePoint := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetStartColor(Value: TColor);
begin
  FixedColors[0] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetColorCount(Value: Integer);
begin
  FRedChannel.ValueCount := Value;
  FGreenChannel.ValueCount := Value;
  FBlueChannel.ValueCount := Value;
  FAlphaChannel.ValueCount := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetEndColor(Value: TColor);
begin
  FixedColors[ColorCount - 1] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetFixedAlpha(Index: Integer; Value: Byte);
begin
  if Index < ColorCount then
    FAlphaChannel.FixedValues[Index] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetFixedColors(Index: Integer; Value: TColor);
begin
  if Index < ColorCount then
  begin
    FRedChannel.FixedValues[Index] := LMDGetRedValue(Value);
    FGreenChannel.FixedValues[Index] := LMDGetGreenValue(Value);
    FBlueChannel.FixedValues[Index] := LMDGetBlueValue(Value);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetPosition(AObject: TObject);
begin
  FRedChannel.SetPosition(AObject);
  FGreenChannel.SetPosition(AObject);
  FBlueChannel.SetPosition(AObject);
  FAlphaChannel.SetPosition(AObject);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetVectorN(Value: TPoint);
begin
  FRedChannel.VectorN := Value;
  FGreenChannel.VectorN := Value;
  FBlueChannel.VectorN := Value;
  FAlphaChannel.VectorN := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetVectorT(Value: TPoint);
begin
  FRedChannel.VectorT := Value;
  FGreenChannel.VectorT := Value;
  FBlueChannel.VectorT := Value;
  FAlphaChannel.VectorT := Value;
end;

{***************************** TLMDContainerFiller ***************************}
constructor TLMDContainerFiller.Create;
begin
  inherited Create;
  FFillerList := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDContainerFiller.Destroy;
begin
  Clear(true);
  FFillerList.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFiller.Add(AFiller: TLMDFiller);
begin
  FFillerList.Add(AFiller);
  (RedChannel   as TLMDContainerColorChannel).Add(AFiller.RedChannel);
  (GreenChannel as TLMDContainerColorChannel).Add(AFiller.GreenChannel);
  (BlueChannel  as TLMDContainerColorChannel).Add(AFiller.BlueChannel);
  (AlphaChannel  as TLMDContainerColorChannel).Add(AFiller.AlphaChannel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFiller.Delete(AFiller: TLMDFiller);
var
  IndexOfFiller: Integer;
begin
  IndexOfFiller := FFillerList.IndexOf(AFiller);
  Delete(IndexOfFiller);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFiller.Delete(aFillerIndex: integer);
begin
  if (aFillerIndex > -1) and (aFillerIndex < Count) then
  begin
    FFillerList.Delete(aFillerIndex);
    (RedChannel   as TLMDContainerColorChannel).Delete((RedChannel   as TLMDContainerColorChannel).Item[aFillerIndex]);
    (GreenChannel as TLMDContainerColorChannel).Delete((GreenChannel as TLMDContainerColorChannel).Item[aFillerIndex]);
    (BlueChannel  as TLMDContainerColorChannel).Delete((BlueChannel  as TLMDContainerColorChannel).Item[aFillerIndex]);
    (AlphaChannel as TLMDContainerColorChannel).Delete((AlphaChannel as TLMDContainerColorChannel).Item[aFillerIndex]);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerFiller.GetCount: Integer;
begin
  result := FFillerList.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerFiller.GetItem(Index: Integer): TLMDFiller;
begin
  result := FFillerList.Items[Index];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFiller.SetItem(Index: Integer; Value: TLMDFiller);
begin
  FFillerList.Items[Index] := Value;
  if Value <> nil then
    begin
     (RedChannel   as TLMDContainerColorChannel).Item[Index] := Value.RedChannel;
     (GreenChannel as TLMDContainerColorChannel).Item[Index] := Value.GreenChannel;
     (BlueChannel  as TLMDContainerColorChannel).Item[Index] := Value.BlueChannel;
    end; 
end;

{**************************** TLMDCompositeFiller ****************************}
procedure TLMDCompositeFiller.AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true);
var
  D: TLMDCompositeFiller;
  i: integer;
begin
  inherited AssignTo(aDestFiller, aCopyColorsAndAlpha);
  if aDestFiller is TLMDCompositeFiller then
    begin
      D := TLMDCompositeFiller(aDestFiller);
      for i := 0 to Count - 1 do
        D.FillerRect[i] := FillerRect[i];
    end;
end;

constructor TLMDCompositeFiller.Create;
begin
  inherited Create;
  RedChannel := TLMDCompositeColorChannel.Create;
  GreenChannel := TLMDCompositeColorChannel.Create;
  BlueChannel := TLMDCompositeColorChannel.Create;
  AlphaChannel := TLMDCompositeColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCompositeFiller.GetFillerRect(Index: Integer): TRect;
begin
  result := (RedChannel as TLMDCompositeColorChannel).FillerRect[Index];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCompositeFiller.SetBasePoint(Value: TPoint);
begin
  inherited;
end;

procedure TLMDCompositeFiller.SetFillerRect(Index: Integer; Value: TRect);
begin
  (RedChannel   as TLMDCompositeColorChannel).FillerRect[Index] := Value;
  (GreenChannel as TLMDCompositeColorChannel).FillerRect[Index] := Value;
  (BlueChannel  as TLMDCompositeColorChannel).FillerRect[Index] := Value;
  (AlphaChannel as TLMDCompositeColorChannel).FillerRect[Index] := Value;
end;

{****************************** TLMDMixedFiller ******************************}
procedure TLMDMixedFiller.AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true);
var
  D: TLMDMixedFiller;
  i: integer;
begin
  inherited AssignTo(aDestFiller, aCopyColorsAndAlpha);
  if aDestFiller is TLMDMixedFiller then
    begin
      D := TLMDMixedFiller(aDestFiller);
      for i:= 0 to Count - 1 do
        D.Weight[i] := Weight[i];
    end;
end;

constructor TLMDMixedFiller.Create;
begin
  inherited Create;
  RedChannel := TLMDMixedColorChannel.Create;
  GreenChannel := TLMDMixedColorChannel.Create;
  BlueChannel := TLMDMixedColorChannel.Create;
  AlphaChannel := TLMDMixedColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDMixedFiller.GetWeight(Index: Integer): Byte;
begin
  result := (RedChannel   as TLMDMixedColorChannel).Weight[Index];
end;


procedure TLMDMixedFiller.SetWeight(Index: Integer; NewValue: Byte);
begin
  (RedChannel   as TLMDMixedColorChannel).Weight[Index] := NewValue;
  (GreenChannel as TLMDMixedColorChannel).Weight[Index] := NewValue;
  (BlueChannel  as TLMDMixedColorChannel).Weight[Index] := NewValue;
  (AlphaChannel  as TLMDMixedColorChannel).Weight[Index] := NewValue;
end;

{****************************** TLMDSolidFiller ******************************}
constructor TLMDSolidFiller.Create;
begin
  inherited Create;
  RedChannel := TLMDSolidColorChannel.Create;
  GreenChannel := TLMDSolidColorChannel.Create;
  BlueChannel := TLMDSolidColorChannel.Create;
  AlphaChannel := TLMDSolidColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSolidFiller.GetColor: TColor;
begin
  result := StartColor;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSolidFiller.SetColor(Value: TColor);
begin
  StartColor := Value;
end;

{**************************** TLMDEllipseFiller ******************************}
procedure TLMDEllipseFiller.AssignTo(aDestFiller: TLMDFiller;
  aCopyColorsAndAlpha: boolean);
var
  D: TLMDEllipseFiller;
begin
  inherited;
  if (aDestFiller <> Self) and (aDestFiller is TLMDEllipseFiller) then
    begin
      D := TLMDEllipseFiller(aDestFiller);
      D.Axis1 := Axis1;
      D.Axis2 := Axis2;
      D.FirstAxisDirection := FirstAxisDirection;
    end;
end;

constructor TLMDEllipseFiller.Create;
begin
  inherited Create;
  RedChannel := TLMDEllipseColorChannel.Create;
  GreenChannel := TLMDEllipseColorChannel.Create;
  BlueChannel := TLMDEllipseColorChannel.Create;
  AlphaChannel := TLMDEllipseColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEllipseFiller.SetAxis1(Value: Integer);
begin
  FAxis1 := Value;
  (RedChannel as TLMDEllipseColorChannel).Axis1 := Value;
  (GreenChannel as TLMDEllipseColorChannel).Axis1 := Value;
  (BlueChannel as TLMDEllipseColorChannel).Axis1 := Value;
  (AlphaChannel as TLMDEllipseColorChannel).Axis1 := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEllipseFiller.SetAxis2(Value: Integer);
begin
  FAxis2 := Value;
  (RedChannel as TLMDEllipseColorChannel).Axis2 := Value;
  (GreenChannel as TLMDEllipseColorChannel).Axis2 := Value;
  (BlueChannel as TLMDEllipseColorChannel).Axis2 := Value;
  (AlphaChannel as TLMDEllipseColorChannel).Axis2 := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEllipseFiller.SetFirstAxisDirection(Value: TPoint);
begin
  FFirstAxisDirection := Value;
  (RedChannel as TLMDEllipseColorChannel).FirstAxisDirection := Value;
  (GreenChannel as TLMDEllipseColorChannel).FirstAxisDirection := Value;
  (BlueChannel as TLMDEllipseColorChannel).FirstAxisDirection := Value;
  (AlphaChannel as TLMDEllipseColorChannel).FirstAxisDirection := Value;
end;

{******************************** TLMDRoundFiller ****************************}
procedure TLMDRoundFiller.AssignTo(aDestFiller: TLMDFiller;
  aCopyColorsAndAlpha: boolean);
var
  D: TLMDRoundFiller;
begin
  inherited;
  if (aDestFiller <> Self) and (aDestFiller is TLMDRoundFiller) then
    begin
      D := TLMDRoundFiller(aDestFiller);
      D.Radius := Radius;
    end;
end;

function TLMDRoundFiller.GetRadius: Integer;
begin
  result := VectorN.Y;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRoundFiller.SetRadius(Value: Integer);
begin
  VectorN := Point(0,Value);
  VectorT := Point(Value,0);
  FirstAxisDirection := Point(Value, 0);
end;

{******************************* TLMDLineFiller ******************************}
constructor TLMDLineFiller.Create;
begin
  inherited Create;
  RedChannel := TLMDLineColorChannel.Create;
  GreenChannel := TLMDLineColorChannel.Create;
  BlueChannel := TLMDLineColorChannel.Create;
  AlphaChannel := TLMDLineColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLineFiller.GetDirection: TPoint;
begin
  result := VectorN;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLineFiller.SetDirection(Value: TPoint);
begin
  VectorN := Value;
end;

{************************** TLMDVerticalGradient ******************************}
constructor TLMDVerticalGradient.Create;
begin
  inherited Create;
  RedChannel := TLMDVerticalColorChannel.Create;
  GreenChannel := TLMDVerticalColorChannel.Create;
  BlueChannel := TLMDVerticalColorChannel.Create;
  AlphaChannel := TLMDVerticalColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDVerticalGradient.GetHeight: Integer;
begin
  result := VectorN.X;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDVerticalGradient.SetHeight(Value: Integer);
begin
  VectorN := Point(Value, 0);
  VectorT := Point(0, Value);  
end;

{*************************** TLMDHorizontalGradient ***************************}
constructor TLMDHorizontalGradient.Create;
begin
  inherited Create;
  RedChannel := TLMDHorizontalColorChannel.Create;
  GreenChannel := TLMDHorizontalColorChannel.Create;
  BlueChannel := TLMDHorizontalColorChannel.Create;
  AlphaChannel := TLMDHorizontalColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHorizontalGradient.GetHeight: Integer;
begin
  result := VectorT.Y;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHorizontalGradient.SetHeight(Value: Integer);
begin
  VectorN := Point(Value, 0);
  VectorT := Point(0, Value);
end;

{******************************** TLMDBandFiller ******************************}
constructor TLMDBandFiller.Create;
begin
  inherited Create;
  RedChannel := TLMDBandColorChannel.Create;
  GreenChannel := TLMDBandColorChannel.Create;
  BlueChannel := TLMDBandColorChannel.Create;
  AlphaChannel := TLMDBandColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBandFiller.GetDirection: TPoint;
begin
  result := VectorN;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBandFiller.GetWidth: Integer;
begin
  result := (RedChannel as TLMDBandColorChannel).Width;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBandFiller.SetDirection(Value: TPoint);
begin
  VectorN := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBandFiller.SetWidth(Value: Integer);
begin
  (RedChannel as TLMDBandColorChannel).Width := Value;
  (GreenChannel as TLMDBandColorChannel).Width := Value;
  (BlueChannel as TLMDBandColorChannel).Width := Value;
  (AlphaChannel as TLMDBandColorChannel).Width := Value;
end;

{**************************** TLMDRectangleFiller *****************************}
constructor TLMDRectangleFiller.Create;
begin
  inherited Create;
  RedChannel := TLMDRectangleColorChannel.Create;
  GreenChannel := TLMDRectangleColorChannel.Create;
  BlueChannel := TLMDRectangleColorChannel.Create;
  AlphaChannel := TLMDRectangleColorChannel.Create;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true);
var
  D: TLMDFiller;
begin
  if (aDestFiller <> Self) and (aDestFiller is TLMDFiller) then
    begin
      D := TLMDFiller(aDestFiller);
      if aCopyColorsAndAlpha then
        begin
          D.ColorCount := ColorCount;
          D.CopyColorsAndAlphaFrom(Self);
        end;
      D.UseRelativeUnits := UseRelativeUnits;
      D.BasePoint := BasePoint;
      D.VectorN := VectorN;
      D.VectorT := VectorT;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFiller.AssignTo(aDestFiller: TLMDFiller; aCopyColorsAndAlpha: boolean = true);
var
  i: integer;
  D: TLMDContainerFiller;
  F: TLMDFiller;
begin
  if aDestFiller is TLMDContainerFiller then
    begin
      D := TLMDContainerFiller(aDestFiller);
      D.UseRelativeUnits := UseRelativeUnits;
      D.Clear(true);
      for i := 0 to Count - 1 do
        begin
          F := Item[i].Clone(aCopyColorsAndAlpha);
          D.Add(F);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFiller.Clear(aFreeItems: boolean = false);
var
  i: integer;
  lF: TLMDFiller;
begin
  for i := Count - 1 downto 0 do
    begin
      lF := Item[i];
      if aFreeItems then
        Item[i] := nil;
      Delete(i);
      if aFreeItems and (lF <> nil) then
        lF.Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDFiller.Create;
begin
//
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.CreateFrom(aFiller: TLMDFiller): TLMDFiller;
begin
  result := TLMDFillerClass(aFiller.ClassType).Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFiller.Clone(aCopyColorsAndAlpha: boolean = true): TLMDFiller;
begin
  result := TLMDFillerClass(Self.ClassType).Create;
  Self.AssignTo(result, aCopyColorsAndAlpha);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.ChangeColorBrightness(aPercent: integer;
  aIndex: integer = -1);
var
  i : integer;
  lColor: TColor;

  procedure ChangeBrightness(colorindex: integer);
  begin
    lColor := FixedColors[colorindex];
    if lColor <> clNone then
      begin
        if aPercent > 0 then
          FixedColors[colorindex] := LMDColorLighter(lColor, aPercent)
        else
          FixedColors[colorindex] := LMDColorDarker(lColor, -aPercent);
      end;
  end;

begin
  if (aIndex < - 1) or (aIndex > 255) then
    exit;
  if Self is TLMDContainerFiller then
    begin
      for i := 0 to TLMDContainerFiller(Self).Count - 1 do
        TLMDFiller(TLMDContainerFiller(Self).Item[i]).ChangeColorBrightness(aPercent, aIndex);
    end
  else
    begin
      if aIndex = -1 then
        for i := 0 to ColorCount - 1 do
          ChangeBrightness(i)
      else
        ChangeBrightness(aIndex);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.ReplaceColor(aOldColor, aNewColor: TColor; aIndex: integer);
var
  i, k : integer;

  procedure DoReplaceColor(colorindex: integer);
  begin
    if FixedColors[colorindex] = aOldColor then
      FixedColors[colorindex] := aNewColor;
  end;

begin
  if (aIndex < - 1) or (aIndex > 255) then
    exit;

  if aIndex = -1 then
    k := 0
  else
    k := aIndex;

  if Self is TLMDContainerFiller then
    begin
      for i := 0 to TLMDContainerFiller(Self).Count - 1 do
        TLMDFiller(TLMDContainerFiller(Self).Item[i]).ReplaceColor(aOldColor, aNewColor, aIndex);
    end
  else
    begin
      for i := k to ColorCount - 1 do
        DoReplaceColor(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDColorChannel.Destroy;
begin
  SetLength(FValues, 0);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFiller.SetNewColor(aColor: TColor; aIndex: integer);
var
  i: integer;
begin
  if (aIndex < - 1) or (aIndex > 255) then
    exit;

  if Self is TLMDContainerFiller then
    begin
      for i := 0 to TLMDContainerFiller(Self).Count - 1 do
        TLMDFiller(TLMDContainerFiller(Self).Item[i]).SetNewColor(aColor, aIndex);
    end
  else
    if (aIndex >= 0) and (aIndex < ColorCount) then
      FixedColors[aIndex] := aColor;
end;

end.
