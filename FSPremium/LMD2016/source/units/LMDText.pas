unit LMDText;
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

LMDText unit (VO)
-----------------



ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
{$WARNINGS OFF}

uses
  Classes, Windows, Graphics, Controls,
  LMDWriter;

type
  TLMDParsedTextList = class;
  TLMDGraphicErrorEvent = procedure(Sender: TObject; aPicture: TPicture;
    const aFileName: string; aImageIndex: LongInt) of object;
  TLMDGetVariableEvent = function(Sender: TObject; const aVarName: string): string of
    object;
  TLMDEmbdControlEvent = procedure (Sender: TObject; AControl: TControl; const AName: string) of
    object;
  TLMDRepeatEvent = procedure (Sender: TObject; aNumber : LongInt) of
    object;

  { ******************************** TLMDBaseText ******************************}
  TLMDBaseTextClass = class of TLMDBaseText;
  TLMDBaseText = class(TObject)
  private
    FPosInParent: TPoint;
    FParent: TLMDParsedTextList;
    FParentControl: TWinControl;
    FOwnerControl: TControl;
    FPrevAutoSize       : boolean;
    FPrevWordWrap       : boolean;
    FPrevFontName       : string;
    FPrevFontSize       : LongInt;
  protected
    FClientWidth : LongInt;
    FClientHeight : LongInt;
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;virtual;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);virtual; abstract;
  public
    constructor Create(aParent: TLMDParsedTextList); 
    procedure Chop;
    procedure  Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); overload; virtual; abstract;
    function CheckMousePos(const aPos: TPoint; aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean): TLMDBaseText; virtual;
    property PosInParent: TPoint read FPosInParent write FPosInParent;
    function GetClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean): TRect;
    function Clone: TLMDBaseText; virtual;
    procedure ApplyVariables(aGetVariableEvent: TLMDGetVariableEvent); virtual;
    procedure Store(AWriter : TLMDWriter); virtual;
    property Parent: TLMDParsedTextList read FParent write FParent;
    property ParentControl: TWinControl read FParentControl write FParentControl;
    property OwnerControl: TControl read FOwnerControl write FOwnerControl;
  end;

  { ******************************** TLMDParsedTextList ************************}
  TLMDParsedTextList = class(TLMDBaseText)
  private
    FTextList: TList;
    function GetCount: LongInt;
    function GetSubItem(aIndex: LongInt): TLMDBaseText;
    procedure SetSubitem(aIndex: Integer; const Value: TLMDBaseText);
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList);
    procedure Clear;
    destructor Destroy; override;
    function AddSubitem(aSubItem: TLMDBaseText): TLMDBaseText;
    function InsertSubItem(aPos : LongInt; aSubItem: TLMDBaseText): TLMDBaseText;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    function CheckMousePos(const aPos: TPoint; aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean): TLMDBaseText; override;
    procedure ApplyVariables(aGetVariableEvent: TLMDGetVariableEvent); override;
    function Clone: TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;
    property SubItem[aIndex: LongInt]: TLMDBaseText read GetSubItem write
    SetSubitem; default;
    property Count: LongInt read GetCount;
  end;

  { ******************************** TLMDList *****************************}
  TLMDListType = (ltUnordered, ltOrdered);
  TLMDParseList = class(TLMDParsedTextList)
  private
    FListType: TLMDListType;
    function GetBulletOffset(Index : LongInt) : integer;
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList); overload;
    constructor Create(aParent: TLMDParsedTextList; aListType: TLMDListType);
      overload;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    function Clone: TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;
  end;

  { ******************************** TLMDRepeat *****************************}
  TLMDRepeat = class(TLMDParsedTextList)
  private
    FRepeatCount : string;
    FRepeatEvent : TLMDRepeatEvent;
    function GetRepeatCount : LongInt;
  public
    constructor Create(aParent: TLMDParsedTextList); overload;
    constructor Create(aParent: TLMDParsedTextList; const aRepeatCount: string);
      overload;
    constructor Create(aParent: TLMDParsedTextList; const aRepeatCount: string;
      aRepeatEvent : TLMDRepeatEvent); overload;
    procedure ApplyVariables(aGetVariableEvent: TLMDGetVariableEvent); override;
    property RepeatCount : LongInt read GetRepeatCount;
  end;

  { ******************************** TLMDParagraph *****************************}
  TLMDParaAlign = (paLeft, paRight, paCenter, paJustify);
  TLMDParagraph = class(TLMDParsedTextList)
  private
    FAlign: string;
    function GetAlign: TLMDParaAlign;
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList; aAlign: string); overload;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    procedure ApplyVariables(aGetVariableEvent: TLMDGetVariableEvent); override;
    property Align: TLMDParaAlign read GetAlign;
    property AlignTxt: string read FAlign write FAlign;
    function Clone: TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;
  end;

  TLMDParseListItem = class(TLMDParsedTextlist)
    constructor Create(aParent: TLMDParsedTextList);
  end;

  {  TLMDHeading = class(TLMDParagraph)
    end;}

  { ******************************** TLMDPieceOfText ***************************}
  TLMDPieceOfText = class(TLMDBaseText)
  private
    FLink: Boolean;
    FHREF: string;
  public
    constructor Create(aParent: TLMDParsedTextList);
    procedure ApplyVariables(aGetVariableEvent: TLMDGetVariableEvent); override;
    function Clone: TLMDBaseText; override;
    property Link: Boolean read FLink write FLink;
    property HREF: string read FHREF write FHREF;
  end;

  { ******************************** TLMDLine *********************************}
  TLMDLine = class(TLMDPieceOfText)
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    procedure Store(AWriter : TLMDWriter); override;
  end;

  { ******************************** TLMDBreak *********************************}
  TLMDLineBreak = class(TLMDPieceOfText)
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    procedure Store(AWriter : TLMDWriter); override;
  end;

  { ******************************** TLMDImage *********************************}
  TLMDImage = class(TLMDPieceOfText)
  private
    FSrc: string;
    FImageIndex: string;
    FHeight: string;
    FWidth: string;
    FPicture: TPicture;
    FOnGraphicError: TLMDGraphicErrorEvent;
    function GetHeight: LongInt;
    function GetImageIndex: LongInt;
    function GetWidth: LongInt;
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList); overload;
    constructor Create(aParent: TLMDParsedTextList; const aSrc: string;
      const aWidth, aHeight, aImageIndex: string; aOnGraphicError:
      TLMDGraphicErrorEvent); overload;
    destructor Destroy; override;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    procedure ApplyVariables(aGetVariableEvent: TLMDGetVariableEvent); override;
    function Clone: TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;
    property Src: string read FSrc;
    property Width: LongInt read GetWidth;
    property Height: LongInt read GetHeight;
    property ImageIndex: LongInt read GetImageIndex;
  end;

  TLMDTextSubscriptStyle = (tssNone, tssSubscript, tssSuperscript);

  TLMDTextStyle = (tsNormal, tsSunken, tsRaised, tsPColorSunken, tsPColorRaised);
  { ******************************** TLMDText *********************************}
  TLMDText = class(TLMDPieceOfText)
  private
    //FWords: TStringList;
    FText: string;
    FSubscriptStyle: TLMDTextSubscriptStyle;
    FFontFace: string;
    FFontColor: TColor;
    FShadowColor: TColor;
    FShadowDepth: byte;
    FLightColor: TColor;
    FLightDepth: byte;
    FTextStyle: TLMDTextStyle;
    FFontSize: string;
    FBaseFontSize : string;
    FFontStyle: TFontStyles;
    function IsEmpty(const aText : string) : boolean;
  protected
    function GetText: string; virtual;
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList); overload;
    constructor Create(const aText: string; aParent: TLMDParsedTextList); overload;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    procedure ApplyVariables(aGetVariableEvent: TLMDGetVariableEvent); override;
    function Clone: TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;
    property Text: string read GetText;
    property FontFace: string read FFontFace write FFontFace;
    property FontSize: string read FFontSize write FFontSize;
    property BaseFontSize : string read FBaseFontSize write FBaseFontSize;
    property FontColor: TColor read FFontColor write FFontColor;
    property FontStyle: TFontStyles read FFontStyle write FFontStyle;
    property ShadowColor : TColor read FShadowColor write FShadowColor;
    property ShadowDepth: byte read FShadowDepth write FShadowDepth;
    property LightColor: TColor read FLightColor write FLightColor;
    property LightDepth: byte read FLightDepth write FLightDepth;
    property TextStyle: TLMDTextStyle read FTextStyle write FTextStyle;
    property SubscriptStyle: TLMDTextSubscriptStyle read FSubscriptStyle
      write FSubscriptStyle default tssNone;
  end;

function IsVariable(const aValue: string): Boolean;
function GetVariable(aObj: TObject; const aValue: string; aGetVariableEvent:
  TLMDGetVariableEvent): string;

implementation

uses
  Dialogs, Types, SysUtils, LMDTable, LMDHiddenText;
{$IFDEF LMD_DEBUGTRACE}{$I C2.INC}{$ENDIF}

{ ******************************** TLMDBaseText ******************************}
{-----------------------------------------------------------------------------}

procedure TLMDBaseText.Chop;
begin
  if assigned(FParent) then FParent.FTextList.Remove(self);
  Free;
end;

{ ******************************** TLMDParagraph *****************************}
{-----------------------------------------------------------------------------}

procedure TLMDParagraph.ApplyVariables(
  aGetVariableEvent: TLMDGetVariableEvent);
begin
  inherited;
  if IsVariable(FAlign) then
    FAlign:= GetVariable(Self, FAlign, aGetVariableEvent);
end;

{-----------------------------------------------------------------------------}

function TLMDParagraph.Clone: TLMDBaseText;
begin
  Result:= inherited Clone;
  TLMDParagraph(Result).FAlign:= FAlign;
end;

{-----------------------------------------------------------------------------}

procedure TLMDParagraph.Store(AWriter : TLMDWriter);
var
  I : Longint;
begin
  if count=0 then Exit;
  AWriter.WriteOpenParagraph;
  for I := 0 to count-1 do
    SubItem[I].Store(aWriter);
  AWriter.WriteCloseParagraph;
end;

{-----------------------------------------------------------------------------}

constructor TLMDParagraph.Create(aParent: TLMDParsedTextList; aAlign: string);
begin
  inherited Create(aParent);
  FAlign:= AnsiUpperCase(aAlign);
  end;

{-----------------------------------------------------------------------------}

function TLMDParagraph.GetAlign: TLMDParaAlign;
begin
  if IsVariable(FAlign) then
    raise Exception.Create('Unresolved variable' + FAlign);
  if AnsiSameText(FAlign, 'LEFT') then
    Result:= paLeft
  else
    if AnsiSameText(FAlign, 'RIGHT') then
      Result:= paRight
    else
      if AnsiSameText(FAlign, 'CENTER') then
        Result:= paCenter
      else
        if AnsiSameText(FAlign, 'JUSTIFY') then
          Result:= paJustify
        else
          Result:= paLeft;
  end;

{-----------------------------------------------------------------------------}
function  TLMDParagraph.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := inherited NeedReCalcClientRect(aCanvas, aDisplayRect, aDefFont,
    aAutoSize, aWordWrap);
end;

procedure TLMDParagraph.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
var
  X, Y, H, W, Offs      : LongInt;
  I                     : LongInt;
  R                     : TRect;
  fEmpty                : boolean;
begin
  X := 0;
  Y := 0;
  H := 0;
  W := 0;
  I := 0;
  fEmpty := True;
  while I < count do
    begin
      if (TObject(SubItem[I]) is TLMDLineBreak) then
        begin
          if H = 0 then
            begin
              aCanvas.Font.Assign(aDefFont);
              H:= aCanvas.TextHeight('W');
            end;
          Y := Y + H;
          case Align of
            paLeft: Offs:= 0;
            paRight: Offs:= aDisplayRect.Right - aDisplayRect.Left - X;
            paCenter: Offs:= (aDisplayRect.Right - aDisplayRect.Left - X) div 2;
            paJustify: Offs:= 0;
          else
            Offs:= 0;
          end;
          if W < X + Offs then W := X + Offs;
          if not aWordWrap then
            if W > (aDisplayRect.Right -aDisplayRect.Left) then
              W := aDisplayRect.Right -aDisplayRect.Left;
          X := 0;
          H := 0;
          Inc(I);
          fEmpty := True;
          Continue;
        end;

      R := SubItem[I].GetClientRect(aCanvas, aDisplayRect, aDefFont, aAutoSize, aWordWrap);
      if aAutoSize or (not aWordWrap) then
        begin
          X := X + (R.Right-R.Left);
          if H < (R.Bottom - R.Top) then H := R.Bottom - R.Top;
          if not (SubItem[I] is TLMDText) then fEmpty := False
          else if (TLMDText(SubItem[I]).Text <> ' ') then fEmpty := False;
          Inc(I);
          Continue;
        end;

      if (R.Right - R.Left) >= (aDisplayRect.Right - aDisplayRect.Left) then
        begin
          if not fEmpty then
            if X > 0 then
              begin
                case Align of
                  paLeft: Offs:= 0;
                  paRight: Offs:= aDisplayRect.Right - aDisplayRect.Left - X;
                  paCenter: Offs:= (aDisplayRect.Right - aDisplayRect.Left - X) div 2;
                  paJustify: Offs:= 0;
                else
                  Offs:= 0;
                end;
                if W < X + Offs then W := X + Offs;
                Y := Y + H;
//                fEmpty := True;
              end;
          if W < (R.Right - R.Left) then
            W := (R.Right - R.Left);
          Y := Y + (R.Bottom - R.Top);
          X := 0;
          H := 0;
          Inc(I);
          fEmpty := True;
          Continue;
        end;

      if (X + R.Right - R.Left) >= (aDisplayRect.Right - aDisplayRect.Left) then
        begin
          if not fEmpty then
            begin
              case Align of
                paLeft: Offs:= 0;
                paRight: Offs:= aDisplayRect.Right - aDisplayRect.Left - X;
                paCenter: Offs:= (aDisplayRect.Right - aDisplayRect.Left - X) div 2;
                paJustify: Offs:= 0;
              else
                Offs:= 0;
              end;
              if W < X + Offs then W := X + Offs;
              Y := Y + H;
            end;
          X := 0;
          H := 0;
          fEmpty := True;
          Continue;
        end;

      if H < (R.Bottom - R.Top) then H := R.Bottom - R.Top;
      if not (SubItem[I] is TLMDText) then fEmpty := False
        else if (TLMDText(SubItem[I]).Text <> ' ') then fEmpty := False;
      X := X + (R.Right - R.Left);
      Inc(I);
      Continue;
    end;

  if not fEmpty then
    if X > 0 then
      begin
        Y := Y + H;
        case Align of
          paLeft: Offs:= 0;
          paRight: Offs:= aDisplayRect.Right - aDisplayRect.Left - X;
          paCenter: Offs:= (aDisplayRect.Right - aDisplayRect.Left - X) div 2;
          paJustify: Offs:= 0;
        else
          Offs:= 0;
        end;
        if W < X + Offs then W := X + Offs;
//        if not aWordWrap then
//          if W > (aDisplayRect.Right -aDisplayRect.Left) then
//            W := aDisplayRect.Right -aDisplayRect.Left;
      end;
  FClientWidth := W+1;
  FClientHeight := Y;
end;

procedure TLMDParagraph.Render(aCanvas: TCanvas; const aRect: TRect;
  const aOffset: TPoint; aDefFont: TFont; aBkColor: TColor; aAutoSize,
  aWordWrap: Boolean; aMask: Boolean);

var
  srcW: integer;

  procedure DrawLine(aFirst, aLast, aY, aH, aW: LongInt);
  var
    I: LongInt;
    R: TRect;
    X: LongInt;
    Offs: LongInt;
    SI: TLMDBaseText;
  begin
    X:= 0;
    if aFirst > aLast then Exit;
    case Align of
      paLeft: Offs:= 0;
      paRight: Offs:= srcW - aW;
      paCenter: Offs:= (srcW - aW) div 2;
      paJustify: Offs:= 0;
    else
      Offs:= 0;
    end;
    for I:= aFirst to aLast do
      begin
        SI := SubItem[I];
        R:= SI.GetClientRect(aCanvas, aRect, aDefFont, aAutoSize,
          aWordWrap);
        SI.Render(aCanvas, aRect, Point(
          aOffset.X + X + Offs,
          aOffset.Y + aY + aH - R.Bottom + R.Top),
          aDefFont, aBkColor, aAutoSize, aWordWrap, aMask);
        SI.FPosInParent := Point(X + Offs, aY + aH -
          R.Bottom + R.Top);
        X:= X + R.Right - R.Left;
      end;
  end;

var
  R             : TRect;
  X, Y, H{, W}    : LongInt;
  I             : LongInt;
  idxFirst      : LongInt;
  fEmpty        : boolean;
  SI            : TLMDBaseText;
begin
  X := 0;
  Y := 0;
  H := 0;
//  W := 0;
  I := 0;
  srcW := aRect.Right - aRect.Left;
  idxFirst := 0;
  fEmpty := True;

  while I < Count do
    begin
      SI := SubItem[I];
      if (SI is TLMDLineBreak) then
        begin
          if not fEmpty then
            DrawLine(idxFirst, i-1 ,Y, H, X);
          idxFirst := I+1;
          if H = 0 then
            begin
              aCanvas.Font.Assign(aDefFont);
              H:= aCanvas.TextHeight('W');
            end;
          Y := Y + H;
          if (aRect.Top + aOffset.Y + Y) > aRect.Bottom then Exit;
          X := 0;
          H := 0;
          fEmpty := True;
          Inc(I);
          Continue;
        end;

      R := SI.GetClientRect(aCanvas, aRect, aDefFont, aAutoSize, aWordWrap);
      if aAutoSize or (not aWordWrap) then
        begin
          X := X + (R.Right-R.Left);
          if H < (R.Bottom - R.Top) then H := R.Bottom - R.Top;
          if not (SI is TLMDText) then
            fEmpty := False
          else
          if (TLMDText(SI).Text <> ' ') then
            fEmpty := False;
          Inc(I);
          Continue;
        end;

      if ((R.Right - R.Left) >= srcW) or (SI is TLMDParagraph) then
        begin
          if not fEmpty then
            if X > 0 then
              begin
                DrawLine(idxFirst, i-1, Y, H, X);
                Y := Y + H;
                if (aRect.Top + aOffset.Y + Y) > aRect.Bottom then Exit;
//                idxFirst := I;
              end;
          H := (R.Bottom - R.Top);
          X := (R.Right - R.Left);
          DrawLine(I, I, Y, H, X);
          Y := Y + H;
          X := 0;
          if (aRect.Top + aOffset.Y + Y) > aRect.Bottom then Exit;
          idxFirst := I+1;
          fEmpty := True;
          Inc(I);
          Continue;
        end;

      if (X + R.Right - R.Left) >= srcW then
        begin
          if not fEmpty then
            begin
              DrawLine(idxFirst, i-1, Y, H, X);
              Y := Y + H;
            end;
          idxFirst := I;
          if (aRect.Top + aOffset.Y + Y) > aRect.Bottom then Exit;
          X := 0;
          H := 0;
          fEmpty := True;
          Continue;
        end;

      if H < (R.Bottom - R.Top) then
        H := R.Bottom - R.Top;
      if not (SI is TLMDText) then
        fEmpty := False
      else
      if (TLMDText(SI).Text <> ' ') then
        fEmpty := False;
      X := X + (R.Right - R.Left);
      Inc(I);
      Continue;
    end;

  if not fEmpty then
    if X > 0 then
      begin
        DrawLine(idxFirst, Count - 1, Y, H, X);
//        Y := Y + H;
      end;
end;

{ ********************************* TLMDText *********************************}
{-----------------------------------------------------------------------------}

procedure TLMDText.ApplyVariables(aGetVariableEvent: TLMDGetVariableEvent);
begin
  inherited;
  if IsVariable(FFontFace) then
    FFontFace:= GetVariable(Self, FFontFace, aGetVariableEvent);
  if IsVariable(FFontSize) then
    FFontSize:= GetVariable(Self, FFontSize, aGetVariableEvent);
  if IsVariable(FText) then
    FText:= GetVariable(Self, FText, aGetVariableEvent);
end;

function TLMDText.Clone: TLMDBaseText;
begin
  Result:= inherited Clone;
  TLMDText(Result).FText:= FText;
  TLMDText(Result).FSubscriptStyle:= FSubscriptStyle;
  TLMDText(Result).FFontFace:= FFontFace;
  TLMDText(Result).FFontColor:= FFontColor;
  TLMDText(Result).FFontSize:= FFontSize;
  TLMDText(Result).FFontStyle:= FFontStyle;
end;

{-----------------------------------------------------------------------------}

procedure TLMDText.Store(AWriter : TLMDWriter);
begin
  if Length(FText) = 0 then Exit;
  if IsEmpty(FText) then AWriter.Write(' ')
  else
    AWriter.WriteText(Text, Link, HREF, FontFace, FontSize, FontColor, FontStyle,
      Integer(SubscriptStyle), Integer(TextStyle), LightColor, LightDepth, ShadowColor, ShadowDepth);
end;

{-----------------------------------------------------------------------------}

constructor TLMDText.Create(const aText: string; aParent: TLMDParsedTextList);
begin
  Create(aParent);
  FText:= aText;
  FBaseFontSize := '';
  FFontSize := '';
  FTextStyle := tsNormal;
  FSubscriptStyle := tssNone;
  FShadowColor := clbtnShadow;
  FShadowDepth := 1;
  FLightColor := clbtnHighLight;
  FLightDepth := 1;
end;

{-----------------------------------------------------------------------------}

constructor TLMDText.Create(aParent: TLMDParsedTextList);
begin
  inherited;
  FText:= '';
  FFontFace:= '';
  FBaseFontSize := '';
  FFontSize := '';
  FFontColor:= clDefault;
  FTextStyle := tsNormal;
  FShadowColor := clbtnShadow;
  FShadowDepth := 1;
  FLightColor := clbtnHighLight;
  FLightDepth := 1;
  FFontStyle:= [];
  FLink:= false;
  FHREF:= '';
  FSubscriptStyle:= tssNone;
end;

function  TLMDText.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := inherited NeedReCalcClientRect(aCanvas, aDisplayRect, aDefFont, aAutoSize, aWordWrap);
end;

procedure TLMDText.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);

begin
  aCanvas.Font.Assign(aDefFont);
  if FFontFace <> '' then
    aCanvas.Font.Name:= FFontFace;
  if FFontColor <> clDefault then
    aCanvas.Font.Color:= FFontColor;

  aCanvas.Font.Style:= FFontStyle;
  if FFontStyle <> [] then
  begin
//    aCanvas.Font.Style:= aCanvas.Font.Style + FFontStyle;
//    aCanvas.Font.Style:= FFontStyle;
  end;
  if FFontSize <> '' then
    aCanvas.Font.Size:= StrToInt(FFontSize);
  if Link then
    begin
      if FFontColor = clDefault then
        aCanvas.Font.Color:= clNavy;
      aCanvas.Font.Style:= aCanvas.Font.Style + [fsUnderline];
    end;
  FClientWidth := aCanvas.TextWidth(Text);
  FClientHeight := aCanvas.TextHeight(Text);
end;

{-----------------------------------------------------------------------------}

function TLMDText.IsEmpty(const aText : string) : boolean;
var
  I : LongInt;
begin
  result := True;
  for I := 1 to Length(aText) do
    if aText[I] <> ' ' then begin
      result := False;
      Exit;
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDText.GetText: string;
begin
  Result:= FText
end;

{-----------------------------------------------------------------------------}

procedure TLMDText.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
  aDefFont: TFont; aBkColor: TColor; aAutoSize, aWordWrap: Boolean;
  aMask: Boolean);
var
  H: LongInt;
  TempColor : TColor;

  procedure DrawStyledText(Rect: TRect; X, Y: Integer; const Text: string);
  begin
    TempColor := aCanvas.Font.Color;
    case FTextStyle of
      tsNormal : aCanvas.TextRect(Rect, X, Y, Text);
      tsSunken : begin
        aCanvas.Font.Color := FLightColor;
        aCanvas.TextRect(Rect, X+FLightDepth, Y+FLightDepth, Text);
        aCanvas.Font.Color := TempColor;
        aCanvas.TextRect(Rect, X, Y, Text);
      end;
      tsRaised : begin
        aCanvas.Font.Color := FLightColor;
        aCanvas.TextRect(Rect, X-FLightDepth, Y-FLightDepth, Text);
        aCanvas.Font.Color := TempColor;
        aCanvas.TextRect(Rect, X, Y, Text);
      end;
      tsPColorSunken: begin
        aCanvas.Font.Color := FShadowColor;
        aCanvas.TextRect(Rect, X, Y, Text);
        aCanvas.Font.Color := FLightColor;
        aCanvas.TextRect(Rect, X+FLightDepth+FShadowDepth, Y+FLightDepth+FShadowDepth, Text);
        aCanvas.Font.Color := aBkColor;
        aCanvas.TextRect(Rect, X+FShadowDepth, Y+FShadowDepth, Text);
        aCanvas.Font.Color := TempColor;
      end;
      tsPColorRaised: begin
        aCanvas.Font.Color := FShadowColor;
        aCanvas.TextRect(Rect, X+FLightDepth+FShadowDepth, Y+FLightDepth+FShadowDepth, Text);
        aCanvas.Font.Color := FLightColor;
        aCanvas.TextRect(Rect, X, Y, Text);
        aCanvas.Font.Color := aBkColor;
        aCanvas.TextRect(Rect, X+FLightDepth, Y+FLightDepth, Text);
        aCanvas.Font.Color := TempColor;
      end;
    end;
  end;

begin
  aCanvas.Font.Assign(aDefFont);
  if FFontFace <> '' then
    aCanvas.Font.Name:= FFontFace;
  aCanvas.Font.Style:= FFontStyle;
  if FFontStyle <> [] then
  begin
//    aCanvas.Font.Style:= aCanvas.Font.Style + FFontStyle;
  end;
  if FFontColor <> clDefault then
    aCanvas.Font.Color:= FFontColor;
  if FFontSize <> '' then
    aCanvas.Font.Size:= StrToInt(FFontSize);
  if Link then
    begin
      if FFontColor = clDefault then
        aCanvas.Font.Color:= clNavy;
      aCanvas.Font.Style:= aCanvas.Font.Style + [fsUnderline];
    end;
  H:= aCanvas.TextHeight(Text);
  if FSubscriptStyle <> tssNone then
    aCanvas.Font.Size:= aCanvas.Font.Size div 2;
  aCanvas.Brush.Style:= bsClear;
  if aMask then
    aCanvas.Font.Color:= clWhite;
  case FSubscriptStyle of
    tssNone, tssSuperscript:
      if (aRect.Left + aOffset.X < aRect.Right) and
        (aRect.Top + aOffset.Y < aRect.Bottom) then
        DrawStyledText(aRect, aRect.Left + aOffset.X,
          aRect.Top + aOffset.Y, Text);
    tssSubscript:
      if (aRect.Left + aOffset.X < aRect.Right) and
        (aRect.Top + aOffset.Y + H - aCanvas.TextHeight(Text) < aRect.Bottom)
          then
        DrawStyledText(aRect, aRect.Left + aOffset.X, aRect.Top + aOffset.Y +
          H - aCanvas.TextHeight(Text), Text);
  end;
  {
    case FSubscriptStyle of
      ssNone, ssSuperscript:
        aCanvas.TextOut(aRect.Left + aOffset.X, aRect.Top +
          aOffset.Y, Text ;
      ssSubscript:
        aCanvas.TextOut(aRect.Left + aOffset.X, aRect.Top + aOffset.Y +
          H - aCanvas.TextHeight(Text), Text);
    end;
  }
end;

{ ********************************* TLMDLine ******************************** }
{-----------------------------------------------------------------------------}

function  TLMDLine.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := True;
end;

procedure TLMDLine.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
begin
  FClientWidth := aDisplayRect.Right - aDisplayRect.Left;
  FClientHeight := 8;
end;

procedure TLMDLine.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
  aDefFont: TFont; aBkColor: TColor; aAutoSize, aWordWrap: Boolean;
  aMask: Boolean);
begin
  CalcClientRect(aCanvas, aRect, aDefFont, aAutoSize, aWordWrap);
  if aMask then
    aCanvas.Brush.Color:= clWhite
  else
    aCanvas.Brush.Color:= aBkColor;
  aCanvas.MoveTo(aRect.Left + aOffset.X, aRect.Top + aOffset.Y + 4);
  aCanvas.LineTo({aRect.Left + aOffset.X + }aRect.Right{ - aRect.Left}, aRect.Top +
    aOffset.Y + 4);
end;

{-----------------------------------------------------------------------------}

procedure TLMDLine.Store(AWriter : TLMDWriter);
begin
  if Link then AWriter.WriteOpenLink(HREF);
  AWriter.WriteHLine;
  if Link then AWriter.WriteCloseLink;
end;

{ ******************************** TLMDLineBreak *****************************}
{-----------------------------------------------------------------------------}

function  TLMDLineBreak.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := True;
end;

procedure TLMDLineBreak.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
begin
  FClientHeight := 0;
  FClientWidth := 0;
end;

procedure TLMDLineBreak.Render(aCanvas: TCanvas; const aRect: TRect;
  const aOffset: TPoint; aDefFont: TFont; aBkColor: TColor; aAutoSize,
  aWordWrap: Boolean; aMask: Boolean);
begin
end;

{-----------------------------------------------------------------------------}

procedure TLMDLineBreak.Store(AWriter : TLMDWriter);
begin
  if Link then AWriter.WriteOpenLink(HREF);
  AWriter.WriteLineBreak;
  if Link then AWriter.WriteCloseLink;
end;

{ ******************************** TLMDBaseText ******************************}
{-----------------------------------------------------------------------------}

function  TLMDBaseText.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := (FPrevAutoSize <> aAutoSize) or
            (FPrevWordWrap <> aWordWrap) or
            (FPrevFontSize <> aCanvas.Font.Size) or
            (not AnsiSameText(FPrevFontName, aCanvas.Font.Name));
  if result then begin
    FPrevAutoSize := aAutoSize;
    FPrevWordWrap := aWordWrap;
    FPrevFontSize := aCanvas.Font.Size;
    FPrevFontName := aCanvas.Font.Name;
  end;
end;

function TLMDBaseText.GetClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean): TRect;
begin
  if NeedRecalcClientRect(aCanvas, aDisplayRect, aDefFont, aAutoSize, aWordWrap) then
    CalcClientRect(aCanvas, aDisplayRect, aDefFont, aAutoSize, aWordWrap);
  result := Rect(0,0,FClientWidth, FClientHeight);
end;

procedure TLMDBaseText.ApplyVariables(
  aGetVariableEvent: TLMDGetVariableEvent);
begin
end;

procedure TLMDBaseText.Store(AWriter : TLMDWriter);
begin
end;

function TLMDBaseText.CheckMousePos(const aPos: TPoint; aCanvas: TCanvas;
  const aDisplayRect: TRect; aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean):
  TLMDBaseText;
var
  R: TRect;
  P: TLMDBaseText;
begin
  R:= GetClientRect(aCanvas, aDisplayRect, aDefFont, aAutoSize, aWordWrap);
  P:= Self;
  repeat
    OffsetRect(R, P.PosInParent.X, P.PosInParent.Y);
    P:= P.FParent;
  until P = nil;
  if (aPos.X >= R.Left) and (aPos.X <= R.Right) and
    (aPos.Y >= R.Top) and (aPos.Y <= R.Bottom) then
    Result:= Self
  else
    Result:= nil;
end;

{-----------------------------------------------------------------------------}

function TLMDBaseText.Clone: TLMDBaseText;
begin
  Result:= TLMDBaseTextClass(ClassType).Create(FParent);
end;

constructor TLMDBaseText.Create(aParent: TLMDParsedTextList);
begin
  inherited Create;
  FParent:= aParent;
  FParentControl := nil;
  FClientWidth := 0;
  FClientHeight := 0;
  FPrevAutoSize  := False;
  FPrevWordWrap  := False;
  FPrevFontName  := '';
  FPrevFontSize  := 0;
end;

{ ****************************** TLMDParsedTextList **************************}
{-----------------------------------------------------------------------------}

function TLMDParsedTextList.AddSubitem(
  aSubItem: TLMDBaseText): TLMDBaseText;
begin
  FTextList.Add(aSubItem);
  Result:= aSubItem;
end;

{-----------------------------------------------------------------------------}

function TLMDParsedTextList.InsertSubItem(aPos : LongInt; aSubItem: TLMDBaseText): TLMDBaseText;
begin
  FTextList.Insert(aPos, aSubItem);
  Result:= aSubItem;
end;

{-----------------------------------------------------------------------------}

procedure TLMDParsedTextList.Clear;
var
  I : LongInt;
begin
  for I := 0 to count-1 do
    SubItem[I].Free;
  FTextList.Clear;
end;

{-----------------------------------------------------------------------------}

procedure TLMDParsedTextList.ApplyVariables(
  aGetVariableEvent: TLMDGetVariableEvent);
var
  I: LongInt;
begin
  for I:= 0 to Count - 1 do
    SubItem[I].ApplyVariables(aGetVariableEvent);
end;

function TLMDParsedTextList.CheckMousePos(const aPos: TPoint; aCanvas: TCanvas;
  const aDisplayRect: TRect; aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean):
  TLMDBaseText;
var
  I: LongInt;
begin
  if inherited CheckMousePos(aPos, aCanvas, aDisplayRect, aDefFont, aAutoSize,
    aWordWrap)
    <> nil then
    begin
      for I:= 0 to Count - 1 do
        begin
          Result:= SubItem[I].CheckMousePos(aPos, aCanvas, aDisplayRect,
            aDefFont, aAutoSize, aWordWrap);
          if Result <> nil then
            Exit;
        end;
    end;
  Result:= nil;
end;

{-----------------------------------------------------------------------------}

function TLMDParsedTextList.Clone: TLMDBaseText;
var
  I: LongInt;
begin
  Result:= inherited Clone;
  if not assigned(TLMDParsedTextList(Result).FTextList) then
    TLMDParsedTextList(Result).FTextList := TList.Create;
  for I:= 0 to Count - 1 do
    TLMDParsedTextList(Result).AddSubitem(SubItem[I].Clone).FParent:=
      TLMDParsedTextList(Result);
end;

{-----------------------------------------------------------------------------}

procedure TLMDParsedTextList.Store(AWriter : TLMDWriter);
var
  I : LongInt;
begin
  if Parent = nil then
    AWriter.WriteDocumentStart;
  for I := 0 to Count-1 do
    SubItem[I].Store(AWriter);
  if Parent = nil then
    AWriter.WriteDocumentEnd;
end;

{-----------------------------------------------------------------------------}

constructor TLMDParsedTextList.Create;
begin
  inherited Create(aParent);
  FTextList:= TList.Create;
end;

{-----------------------------------------------------------------------------}

destructor TLMDParsedTextList.Destroy;
begin
  Clear;
  while FTextList.Count>0 do
    TLMDBaseText(FTextList[FTextList.Count-1]).Free;
  FreeAndNil(FTextList);
  inherited;
end;

{-----------------------------------------------------------------------------}

function  TLMDParsedTextList.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := inherited NeedReCalcClientRect(aCanvas, aDisplayRect, aDefFont,
    aAutoSize, aWordWrap);
    result := result or (not((FClientWidth = (aDisplayRect.Right-aDisplayRect.Left)-1) or (FClientWidth = (aDisplayRect.Right-aDisplayRect.Left))));
    result := result or (not((FClientHeight = (aDisplayRect.Bottom-aDisplayRect.Top)-1) or (FClientWidth = (aDisplayRect.Bottom-aDisplayRect.Top))));

{  if not result then
    if FClientHeight > (aDisplayRect.Bottom - aDisplayRect.Top) then
      FClientHeight := (aDisplayRect.Bottom - aDisplayRect.Top);}
end;

{-----------------------------------------------------------------------------}

procedure TLMDParsedTextList.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
var
  I, Y: LongInt;
  R: TRect;
  SI: TLMDBaseText;
begin
  FClientHeight := 0;
  FClientWidth  := 0;
  Y:= 0;
  for I:= 0 to Count - 1 do
    begin
      SI := SubItem[I];
      R:= SI.GetClientRect(aCanvas, aDisplayRect, aDefFont, aAutoSize,
        aWordWrap);

      if  ((R.Bottom - R.Top) > 0) and ((R.Right - R.Left) > 0)  then
        begin
          if FClientWidth < (R.Right + SI.PosInParent.X) then
            FClientWidth:= R.Right+SI.PosInParent.X;
          if (R.Bottom > 0) and (FClientHeight < Y + R.Bottom) then
            FClientHeight:= Y + R.Bottom;
          Y:= Y + R.Bottom + 2;
        end;
    end;
end;

function TLMDParsedTextList.GetCount: LongInt;
begin
  if  Assigned(FTextList) then
    Result:= FTextList.Count
  else
    Result:= 0;
end;

{-----------------------------------------------------------------------------}

function TLMDParsedTextList.GetSubItem(aIndex: LongInt): TLMDBaseText;
begin
  Result:= TLMDBaseText(FTextList[aIndex])
end;

procedure TLMDParsedTextList.SetSubitem(aIndex: Integer;
  const Value: TLMDBaseText);
begin
  FTextList[aIndex]:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDParsedTextList.Render(aCanvas: TCanvas; const aRect: TRect;
  const aOffset: TPoint; aDefFont: TFont; aBkColor: TColor; aAutoSize,
  aWordWrap: Boolean; aMask: Boolean);
var
  Y: LongInt;
  I: LongInt;
  R: TRect;
  yOffset, xOffset : LongInt;
begin
  Y:= 0;
  for I:= 0 to Count - 1 do
    begin
      yOffset := 0;
      xOffset := 0;
      R := SubItem[I].GetClientRect(aCanvas, aRect, aDefFont, aAutoSize,
        aWordWrap);
      if TObject(SubItem[I]) is TLMDTable then begin
        case TLMDTable(SubItem[I]).Align of
          paLeft: xOffset := 0;
          paRight: xOffset := (aRect.Right-aRect.Left-aOffset.x) - R.Right+R.Left;
          paCenter: xOffset := round(((aRect.Right-aRect.Left-aOffset.x) - R.Right+R.Left)/2);
          else xOffset := 0;
        end;
        case TLMDTable(SubItem[I]).VAlign of
          vaTop : yOffset := 0;
          vaMiddle : yOffset := round(((aRect.Bottom-aRect.Top-aOffset.y-Y)-R.Bottom+R.Top)/2);
          vaBottom : yOffset := (aRect.Bottom-aRect.Top-aOffset.y-Y)-R.Bottom+R.Top;
          else yOffset := 0;
        end;
        if xOffset < 0 then xOffset := 0;
        if yOffset < 0 then yOffset := 0;
      end;
      SubItem[I].Render(aCanvas, aRect, Point(aOffset.X+xOffset, aOffset.Y + Y+yOffset),
        aDefFont, aBkColor, aAutoSize, aWordWrap, aMask);
      SubItem[I].FPosInParent:= Point(xOffset, Y+yOffset);
      Y:= Y + R.Bottom + 2;
      if Y + aOffset.Y > aRect.Bottom then Exit;
    end;
end;

{ ******************************** TLMDImage *********************************}
{-----------------------------------------------------------------------------}

procedure TLMDImage.ApplyVariables(
  aGetVariableEvent: TLMDGetVariableEvent);
begin
  inherited;
  if IsVariable(FSrc) then
    FSrc:= GetVariable(Self, FSrc, aGetVariableEvent);
  if IsVariable(FImageIndex) then
    FImageIndex:= GetVariable(Self, FImageIndex, aGetVariableEvent);
  if IsVariable(FHeight) then
    FHeight:= GetVariable(Self, FHeight, aGetVariableEvent);
  if IsVariable(FWidth) then
    FWidth:= GetVariable(Self, FWidth, aGetVariableEvent);
end;

{-----------------------------------------------------------------------------}
function TLMDImage.Clone: TLMDBaseText;
begin
  Result:= inherited Clone;
  TLMDImage(Result).FSrc:= FSrc;
  TLMDImage(Result).FWidth:= FWidth;
  TLMDImage(Result).FHeight:= FHeight;
  TLMDImage(Result).FImageIndex:= FImageIndex;
  TLMDImage(Result).FOnGraphicError:= FOnGraphicError;
end;

{-----------------------------------------------------------------------------}
procedure TLMDImage.Store(AWriter : TLMDWriter);
begin
  if Link then AWriter.WriteOpenLink(HREF);
  AWriter.WriteImage(FSrc, Width, Height);
  if Link then AWriter.WriteCloseLink;
end;

{-----------------------------------------------------------------------------}
constructor TLMDImage.Create(aParent: TLMDParsedTextList);
begin
  inherited;
  FSrc:= '';
  FWidth:= '';
  FHeight:= '';
  FImageIndex:= '';
  FPicture:= TPicture.Create;
  FOnGraphicError:= nil;
end;

{-----------------------------------------------------------------------------}
constructor TLMDImage.Create(aParent: TLMDParsedTextList; const aSrc: string;
  const aWidth, aHeight, aImageIndex: string; aOnGraphicError: TLMDGraphicErrorEvent);
begin
  Create(aParent);
  FSrc:= aSrc;
  FWidth:= aWidth;
  FHeight:= aHeight;
  FImageIndex:= aImageIndex;
  FOnGraphicError:= aOnGraphicError;
  try
    if not IsVariable(FSrc) and (FSrc <> '') then
      begin
        if  Pos('://', FSrc) > 0  then
        else
          FPicture.LoadFromFile(StringReplace(FSrc, '/', '\', [rfReplaceAll]));
      end;
  except
  end;
  if FWidth = '' then
    FWidth:= IntToStr(FPicture.Width);
  if FHeight = '' then
    FHeight:= IntToStr(FPicture.Height);
end;

{-----------------------------------------------------------------------------}
destructor TLMDImage.Destroy;
begin
  if assigned (FPicture) then
    FPicture.Free;
  inherited Destroy;
end;

{-----------------------------------------------------------------------------}
function TLMDImage.GetHeight: LongInt;
var
  E: LongInt;
begin
  Val(FHeight, Result, E);
  if E <> 0 then
    Result:= 0;
end;

function  TLMDImage.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := True;
end;

procedure TLMDImage.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
begin
  FClientHeight := 0;
  FClientWidth := 0;

  if not Assigned(FPicture.Graphic) then
    if Assigned(FOnGraphicError) then
      FOnGraphicError(Self, FPicture, FSrc, ImageIndex);

  if Assigned(FPicture.Graphic) then
    begin
      if Width = 0 then
        FClientWidth := FPicture.Width
      else
        FClientWidth := Width;
      if Height = 0 then
        FClientHeight:= FPicture.Height
      else
        FClientHeight:= Height;
    end
  else
    begin
      if Width = 0 then
        FClientWidth:= 24
      else
        FClientWidth:= Width;
      if Height = 0 then
        FClientHeight:= 24
      else
        FClientHeight:= Height;
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDImage.GetImageIndex: LongInt;
var
  E: LongInt;
begin
  Val(FImageIndex, Result, E);
  if E <> 0 then
    Result:= 0;
end;

function TLMDImage.GetWidth: LongInt;
var
  E: LongInt;
begin
  Val(FWidth, Result, E);
  if E <> 0 then
    Result:= 0;
end;

procedure TLMDImage.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
  aDefFont: TFont; aBkColor: TColor; aAutoSize, aWordWrap: Boolean;
  aMask: Boolean);
var
  R: TRect;
begin
  R:= GetClientRect(aCanvas, aRect, aDefFont, aAutoSize, aWordWrap);
  OffsetRect(R, aRect.Left + aOffset.X, aRect.Top + aOffset.Y);

  if aMask then
    begin
      aCanvas.Brush.Color:= clWhite;
      aCanvas.Brush.Style:= bsSolid;
      aCanvas.FillRect(R);
    end
  else
    begin
      if (FPicture.Graphic = nil) or FPicture.Graphic.Empty then
        begin
          aCanvas.Pen.Color:= clGray;
          aCanvas.Pen.Style:= psDot;
          aCanvas.Brush.Style:= bsClear;
          aCanvas.Rectangle(R);
          aCanvas.Font.Color:= clRed;
          aCanvas.Brush.Style:= bsClear;
          aCanvas.TextOut(aRect.Left + aOffset.X + 4, aRect.Top + aOffset.Y + 2,
            {FSRC}
            'x');
        end
      else
        begin
          FPicture.Graphic.Transparent:= true;
          aCanvas.StretchDraw(R, FPicture.Graphic);
        end;
    end;
end;

{ ********************************** TLMDPieceOfText *************************}
{-----------------------------------------------------------------------------}

procedure TLMDPieceOfText.ApplyVariables(
  aGetVariableEvent: TLMDGetVariableEvent);
begin
  inherited;
  if IsVariable(FHREF) then
    FHREF:= GetVariable(Self, FHREF, aGetVariableEvent);
end;

function TLMDPieceOfText.Clone: TLMDBaseText;
begin
  Result:= inherited Clone;
  TLMDPieceOfText(Result).FLink:= FLink;
  TLMDPieceOfText(Result).FHREF:= FHREF;
end;

constructor TLMDPieceOfText.Create(aParent: TLMDParsedTextList);
begin
  inherited Create(aParent);
end;

{ ***************************** TLMDParseList ********************************}
{-----------------------------------------------------------------------------}

function TLMDParseList.GetBulletOffset(Index : LongInt) : integer;
var
  I    : LongInt;
  Item : TLMDBaseText;
begin
  if TLMDParseListItem(Subitem[Index]).count = 0 then
    begin
      Result := 13;
      Exit;
    end;

//  result := 0;
  Item := nil;
  for I := 0 to TLMDParseListItem(Subitem[Index]).count-1 do begin
    Item := TLMDParseListItem(Subitem[Index]).SubItem[I];
    if not assigned(Item) then Break;
    if (Item is TLMDHiddenText) then Continue;
    if ((Item is TLMDParagraph) and (TLMDParagraph(Item).count > 0)) or (Item is TLMDText) then Break;
    if (Item is TLMDParagraph) and (TLMDParagraph(Item).count = 0) then Continue;
    Item := nil;
    break;
  end;
  if assigned(Item) then result := 13
  else result := 0;
end;

function TLMDParseList.Clone: TLMDBaseText;
begin
  Result:= inherited Clone;
  ;
end;

procedure TLMDParseList.Store(AWriter : TLMDWriter);
var
  I : LongInt;
begin
  AWriter.WriteOpenList(integer(FListType));
  for I := 0 to  count-1 do begin
    AWriter.WriterListBullet(integer(FListType), I);
    SubItem[I].Store(AWriter);
  end;
  AWriter.WriteCloseList(integer(FListType));
end;

constructor TLMDParseList.Create(aParent: TLMDParsedTextList;
  aListType: TLMDListType);
begin
  Create(aParent);
  FListType:= aListType;
end;

const
  ListIndent = 20;

constructor TLMDParseList.Create(aParent: TLMDParsedTextList);
begin
  inherited;
  FListType:= ltUnordered;
end;

function  TLMDParseList.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := Inherited NeedReCalcClientRect(aCanvas, aDisplayRect, aDefFont, aAutoSize, aWordWrap);
end;

procedure TLMDParseList.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize, aWordWrap: Boolean);
var
  I, Y: LongInt;
  R: TRect;
begin
  FClientHeight := 0;
  FClientWidth  := 0;
  Y:= 0;
  for I:= 0 to Count - 1 do
    begin
      if not (SubItem[I] is TLMDParseListItem) then continue;
      R:= SubItem[I].GetClientRect(aCanvas, Rect(
        aDisplayRect.Left + ListIndent,
        aDisplayRect.Top + Y,
        aDisplayRect.Right,
        aDisplayRect.Bottom), aDefFont, aAutoSize, aWordWrap);
      if FClientWidth < (R.Right{ +  SubItem[I].PosInParent.X}) then
        FClientWidth:= R.Right{+SubItem[I].PosInParent.X};
      if R.Bottom = 0 then
        R.Bottom := aCanvas.TextHeight('W');
      if FClientHeight < Y + R.Bottom then
        FClientHeight:= Y + R.Bottom;
      Y:= Y + R.Bottom + 2;
    end;
  FClientWidth := FClientWidth + ListIndent;
  FClientHeight := Y;
end;

{-----------------------------------------------------------------------------}

procedure TLMDParseList.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
  aDefFont: TFont; aBkColor: TColor; aAutoSize, aWordWrap: Boolean;
  aMask: Boolean);
var
  Y: LongInt;
  I: LongInt;
  J: LongInt;
  R: TRect;
  lBWidth : integer;
  lBHeight : integer;
  lBrushColor : TColor;
  lBrushStyle : TBrushStyle;
  lPenColor : TColor;
  lFontColor : TColor;
  lFontSize : integer;
  lFontStyle : TFontStyles;
begin
  Y:= 0;
  J:= 0;
//  lBWidth := 0;
//  lBHeight := 0;
  for I:= 0 to Count - 1 do
    begin
      if not (SubItem[I] is TLMDParseListItem) then continue;
//        begin
          Inc(J);
          if aMask then
            aCanvas.Font.Color:= clWhite;
          if (aRect.Top + aOffset.Y + Y+aCanvas.TextHeight('W')) > aRect.Bottom then
            Exit;
          lBWidth := 6;//aCanvas.TextHeight('W') div 2;
          lBHeight := GetBulletOffset(I);
          if FListType = ltOrdered then
            begin
              lFontColor := aCanvas.Font.Color;
              lFontSize := aCanvas.Font.Size;
              lFontStyle := aCanvas.Font.Style;
              aCanvas.Font.Color := clBlack;
              aCanvas.Font.Size := 10;
              aCanvas.Font.Style := [];
              if lBHeight = 0 then
                aCanvas.TextOut(aRect.Left + aOffset.X + 2, aRect.Top + aOffset.Y +
                  Y+aCanvas.TextHeight('W')-aCanvas.TextHeight(IntToStr(J)), IntToStr(J) + '.')
              else
                aCanvas.TextOut(aRect.Left + aOffset.X + 2, aRect.Top + aOffset.Y +
                  Y+lBHeight-aCanvas.TextHeight(IntToStr(J))+3, IntToStr(J) + '.');
              aCanvas.Font.Color := lFontColor;
              aCanvas.Font.Size := lFontSize;
              aCanvas.Font.Style := lFontStyle;
            end
          else
            begin
              lBrushColor := aCanvas.Brush.Color;
              lBrushStyle := aCanvas.Brush.Style;
              lPenColor := aCanvas.Pen.Color;
              aCanvas.Brush.Color:= clBlack;
              aCanvas.Brush.Style:= bsSolid;
              aCanvas.Pen.Color:= clBlack;
              if lBHeight = 0 then
                aCanvas.Ellipse(Bounds(aRect.Left + aOffset.X + 2 + aCanvas.TextHeight('W') div 4,
                  aRect.Top + aOffset.Y + Y + lbWidth div 2, lbWidth, lbWidth))
              else
                aCanvas.Ellipse(Bounds(aRect.Left + aOffset.X + 2 + aCanvas.TextHeight('W') div 4,
                  aRect.Top + aOffset.Y + Y + lBHeight div 2 , lbWidth, lbWidth));
              aCanvas.Brush.Color := lBrushColor;
              aCanvas.Brush.Style := lBrushStyle;
              aCanvas.Pen.Color := lPenColor;
            end;
//        end;
      if lBHeight = 0 then Y := Y +aCanvas.TextHeight('W');
      if Y > aRect.Bottom then Exit;
      SubItem[I].Render(aCanvas, Rect(aRect.Left+aOffset.X + ListIndent,
        aRect.Top+aOffset.Y + Y, aRect.Right, aRect.Bottom), Point(0, 0),
        aDefFont, aBkColor, aAutoSize, aWordWrap, aMask);
      SubItem[I].FPosInParent:= Point(ListIndent, Y);
      R := SubItem[I].GetClientRect(aCanvas, Rect(
        aRect.Left+aOffset.X + ListIndent,
        aRect.Top+aOffset.Y + Y,
        aRect.Right,
        aRect.Bottom), aDefFont, aAutoSize, aWordWrap);
      if R.Bottom = 0 then
        R.Bottom := aCanvas.TextHeight('W');
      Y:= Y + R.Bottom + 2;
      if Y > (aRect.Bottom - aRect.Top) then Exit;
    end;

  FClientWidth := FClientWidth + ListIndent;
  FClientHeight := Y;
end;

{ ********************************** TLMDRepeat ******************************}
{-----------------------------------------------------------------------------}

procedure TLMDRepeat.ApplyVariables(
  aGetVariableEvent: TLMDGetVariableEvent);
var
  P: TLMDParsedTextList;
  P1: TLMDBaseText;
  I, J: LongInt;
  lRepCount : LongInt;
begin
  P:= TLMDParsedTextList.Create(FParent);
  if IsVariable(FRepeatCount) then
    FRepeatCount:= GetVariable(Self, FRepeatCount, aGetVariableEvent);
  lRepCount := RepeatCount;
  for J:= 0 to lRepCount - 1 do
    begin
      if assigned(FRepeatEvent) then FRepeatEvent(Self, J);
      for I:= 0 to Count - 1 do
        begin
          P1:= SubItem[I].Clone;
          P1.FParent:= P;
          P1.ApplyVariables(aGetVariableEvent);
          P.AddSubitem(P1);
        end;
    end;
  for I:= 0 to FParent.Count - 1 do
    begin
      if FParent.SubItem[I] = Self then
        //      FParent.FTextList.Delete[i];
        FParent.SubItem[I]:= P;
    end;
  Free;
end;

{-----------------------------------------------------------------------------}
function TLMDRepeat.GetRepeatCount : LongInt;
var
  E: LongInt;
begin
  Val(FRepeatCount, result, E);
  if E <> 0 then
    result := 1;
end;

{-----------------------------------------------------------------------------}

constructor TLMDRepeat.Create(aParent: TLMDParsedTextList;
  const aRepeatCount: string);
begin
  Create(aParent);
  FRepeatCount := aRepeatCount;
end;

{-----------------------------------------------------------------------------}

constructor TLMDRepeat.Create(aParent: TLMDParsedTextList);
begin
  inherited;
  FRepeatCount:= '1';
  FRepeatEvent := nil;
end;

{-----------------------------------------------------------------------------}

constructor TLMDRepeat.Create(aParent: TLMDParsedTextList; const aRepeatCount: string; aRepeatEvent : TLMDRepeatEvent);
begin
  Create(aParent, aRepeatCount);
  FRepeatEvent := aRepeatEvent;
end;

function GetVariable(aObj: TObject; const aValue: string;
  aGetVariableEvent: TLMDGetVariableEvent): string;
begin
  if Assigned(aGetVariableEvent) then
    Result:= aGetVariableEvent(aObj, AnsiUpperCase(Copy(aValue, 3, Length(aValue) - 2)))
    else
    Result:= '';
end;

function IsVariable(const aValue: string): Boolean;
begin
  Result:= Copy(aValue, 1, 2) = '~~'
end;

constructor TLMDParseListItem.Create(aParent: TLMDParsedTextList);
begin
  inherited Create(aParent);
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.
