unit LMDHTMLUnit;
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

LMDHTMLUnit unit - Core HTML Library (VB)
-----------------------------------------
Description

ToDo
----
* Check DrawBevel;

Changes
-------
Release 9.1 (June 2009)
 - Fixed incorrect images with different heights drawing (elpack newsgroup
   "Wrong Displaying of Images in HTML (ElPack6/7)" 10.06.2009)

Release 8.0 (May 2006)
 * Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Math, Forms, Windows, Graphics, Types, Controls,
  LMDList, LMDStack, LMDGraphUtils, LMDStrings, LMDUnicode, LMDTypes,
  LMDHookComponent,  Messages, StdCtrls;

const
  flIsLink = 1;
  flSub = 2;
  flSuper = 4;
  flAbsInd = 8;
  flIsParE = $80000000;

  def_LMDLinkStyle = [fsUnderline];
  def_LMDLinkColor = clBlue;

type
  TLMDHTMLItem = class;
  //TLMDString = LMDTypes.TLMDString;
  //{$EXTERNALSYM TLMDString}

  // TLMDHTMLVariableNeededEvent <- TLMDGetVariableEvent in TextPack
  TLMDHTMLVariableNeededEvent = procedure(Sender: TObject; const aVarName: TLMDString; var aVarValue: TLMDString) of object;

  // TLMDHTMLImageNeededEvent supports arbitrary graphics type
  TLMDHTMLImageNeededEvent = procedure(Sender: TObject; SourceName: TLMDString; Image: TPicture) of object;
  TLMDHTMLLinkClickEvent = procedure(Sender: TObject; HRef: TLMDString) of object;
  TLMDHTMLControlCreatedEvent = procedure(Sender : TObject; aControl: TControl) of object;
  TLMDHTMLControlPositionNeededEvent = procedure(Sender : TObject; aControl: TControl; aData: Pointer; var X, Y: Integer) of object;
  TLMDHTMLControlVisibilityNeededEvent = procedure(Sender : TObject; aControl: TControl; aData: Pointer; var aVisible: boolean) of object;

  TLMDHTMLTagFoundEvent = procedure(Sender: TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean) of object;

  // ElPack compatibility
  //TLMDString = LMDTypes.TLMDString;
  //{$EXTERNALSYM TLMDString}
  TElHTMLImageNeededEvent = procedure(Sender: TObject; Src: TLMDString; var Image: Graphics.TBitmap) of object;
  TElHTMLLinkClickEvent = procedure(Sender : TObject; HRef: TLMDString) of object;
  TElHTMLLinkOverEvent = procedure(Sender : TObject; HRef: TLMDString; X, Y: Integer) of object;

  TLMDHTMLItemType = (hitChar, hitSoftBreak, hitBreak, hitPara, hitBitmap, hitHR, hitLI, hitUL, hitOL, hitIndent, hitInput, hitControl, hitVar);
  TLMDHTMLInputType = (itCheckBox, itRadioButton);
  //TLMDHTMLItemTypes = set of TLMDHTMLItemType;     // never used

  TLMDHTMLRender = class;
  TLMDHTMLData = class;
  TLMDHTMLInputItem = class;
  TLMDHTMLInputItemChangedEvent = procedure(Sender : TObject; InputItem: TLMDHTMLInputItem) of object;

  { ********************** TLMDHTMLItem ************************************** }
  TLMDHTMLItem = class
  private
    FOwner: TLMDHTMLData;
    FItemType: TLMDHTMLItemType;
    FText: TLMDString;
    FontStyle: TFontStyles;
    FontHeight: integer;
    FontBgColor,
    FontColor: TColor;
    FLinkRef: TLMDString;
    FFontRef: TLMDString;
    FFntCnt: integer;
    FTWidth,
    FWidth,
    FHeight: Word;
    FIndent: integer;
    FBoolState: integer;
    FTransparent: boolean;
    FTag: integer;
    function GetIsLink: Boolean;
    procedure SetIsLink(Value: Boolean);
    function GetIsSub: Boolean;
    procedure SetIsSub(Value: Boolean);
    function GetIsSuper: Boolean;
    procedure SetIsSuper(Value: Boolean);
  protected
    function GenerateHTML: TLMDString; virtual;
  public
    procedure Assign(Source: TLMDHTMLItem);
    constructor Create(Owner: TLMDHTMLData); virtual;
    destructor Destroy; override;
    function GetWidth: integer; virtual;
    function GetHeight(var BaseLine: integer): integer; virtual;
    property IsLink: Boolean read GetIsLink write SetIsLink;
    property IsSub: Boolean read GetIsSub write SetIsSub;
    property IsSuper: Boolean read GetIsSuper write SetIsSuper;
    property LinkRef: TLMDString read FLinkRef write FLinkRef;
    property Text: TLMDString read FText write FText;
    property Transparent: Boolean read FTransparent write FTransparent;
    property ItemType: TLMDHTMLItemType read FItemType;
  end;

  { ********************** TLMDHTMLBreakItem ********************************* }
  TLMDHTMLBreakItem = class(TLMDHTMLItem)
  private
    FParams: integer;
    FListLevel: integer;
    FListItemN: integer;

  public
    function GetHeight(var BaseLine: integer): integer; override;
    function GetWidth: integer; override;
    procedure Assign(Source: TLMDHTMLItem);
    procedure AssignBreakProps(Source: TLMDHTMLBreakItem);
    constructor Create(Owner: TLMDHTMLData); override;
  end;

  { ********************** TLMDHTMLControlPainter ********************************* }
  TLMDHTMLControlPainter = class(TObject)
  protected
    FInputItem: TLMDHTMLInputItem;
  public
    constructor Create(AInputItem: TLMDHTMLInputItem);
    procedure PaintTo(Canvas: TCanvas;const ARect: TRect);virtual;
  end;

  { ********************** TLMDHTMLCheckBoxPainter ********************************* }
  TLMDHTMLCheckBoxPainter = class(TLMDHTMLControlPainter)
  public
    procedure PaintTo(Canvas: TCanvas; const ARect: TRect);override;
  end;

  { ********************** TLMDHTMLInputItem ********************************* }
  TLMDHTMLInputItem = class(TLMDHTMLItem)
  protected
    FChecked: Boolean;
    FInputType: TLMDHTMLInputType;
    FName, FValue: TLMDString;
    FControlPainter: TLMDHTMLControlPainter;
    procedure ReCreateControlPainter;
    procedure SetInputType(Value: TLMDHTMLInputType);
    procedure ProcessAtributes(AList: TLMDMemoryStrings);
    procedure SetChecked(AValue: Boolean);
    procedure SetValue(AValue: TLMDString);
    function GenerateHTML: TLMDString; override;
  public
    constructor Create(Owner: TLMDHTMLData); override;
    procedure Click;
    destructor Destroy; override;
    procedure KeyDownTransfer(var Key: Word; Shift: TShiftState);
    procedure Assign(Source: TLMDHTMLItem);
    property Checked: Boolean read FChecked write SetChecked;
    property Name: TLMDString read FName;
    property Value: TLMDString read FValue write SetValue;
    property InputType: TLMDHTMLInputType read FInputType write SetInputType;
  end;  
  
  { ********************** TLMDHTMLControlItem ************************************** }
  TLMDHTMLControlItem = class(TLMDHTMLItem)
  private
    function GetControl: TControl;
  protected
    FControlHook: TLMDHookComponent;
    FControlClass : TLMDString;
    FControlPropList : TLMDMemoryStrings;
    FControl: TControl;
    procedure ProcessAtributes(AList: TLMDMemoryStrings);
    procedure BeforeHook(Sender: TObject; var Message: TMessage; var Handled: boolean);
    function GenerateHTML: TLMDString; override;
  public
    constructor Create(Owner: TLMDHTMLData); override;
    destructor Destroy; override;
    procedure Assign(Source: TLMDHTMLItem);
    property Control: TControl read GetControl;
  end;

  { ********************** TLMDHTMLData ************************************** }

  TLMDHTMLData = class
  protected
    FArray: TLMDList;
    FControlsArray: TLMDList;
    FRadioList: TLMDMemoryStrings;
    FRender: TLMDHTMLRender;
    FLinkColor: TColor;
    FDefaultColor: TColor;
    FLinkStyle: TFontStyles;
    FDefaultStyle: TFontStyles;
    FDefaultHeight: Integer;
    FCharset: TFontCharset;
    FDefaultFont: string;
    FLineSpacing: Integer;
    FLineGap: Integer;
    FMaxWidth: Integer;

    FDefaultBgColor: TColor;
    FHighlightBgColor: TColor;
    FHighlightColor: TColor;
    FSelectedItem: TLMDHTMLItem;
    FRect: TRect;

    FTextSize: TSize;
    FActiveItem: TLMDHTMLInputItem;
    FHOffset, FVOffset: integer;
    FAuxData: Pointer;
    FHTMLTabWidth: Integer;

    procedure SetSelectedItem(const Value: TLMDHTMLItem);
    procedure SetActiveItem(const Value: TLMDHTMLInputItem);
    function  GetItemCount: integer;
    function  GetItem(Index: Integer): TLMDHTMLItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearArray;
    property ControlsArray: TLMDList read FControlsArray;
    function LineCount: integer;
    property ItemCount: integer read GetItemCount;
    property Item[Index: Integer]: TLMDHTMLItem read GetItem;
    function GenerateHTML: TLMDString;
    property TextSize: TSize read FTextSize;
    property LinkColor: TColor read FLinkColor write FLinkColor;
    property DefaultBgColor: TColor read FDefaultBgColor write FDefaultBgColor;
    property DefaultColor: TColor read FDefaultColor write FDefaultColor;
    property LinkStyle: TFontStyles read FLinkStyle write FLinkStyle;
    property LineSpacing: Integer read FLineSpacing write FLineSpacing;
    property LineGap: Integer read FLineGap write FLineGap;
    property DefaultStyle: TFontStyles read FDefaultStyle write FDefaultStyle;
    property DefaultHeight: Integer read FDefaultHeight write FDefaultHeight;
    property DefaultFont: string read FDefaultFont write FDefaultFont;
    property Charset: TFontCharset read FCharset write FCharset;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property HighlightBgColor: TColor read FHighlightBgColor write FHighlightBgColor;
    property HighlightColor: TColor read FHighlightColor write FHighlightColor;
    property SelectedItem: TLMDHTMLItem read FSelectedItem write SetSelectedItem;
    property Rect: TRect read FRect write FRect;
    property ActiveItem: TLMDHTMLInputItem read FActiveItem write SetActiveItem;
    property HOffset: integer read FHOffset write FHOffset;
    property VOffset: integer read FVOffset write FVOffset;
    property AuxData: Pointer read FAuxData write FAuxData;
    property HTMLTabWidth: Integer read FHTMLTabWidth write FHTMLTabWidth;
  end;

  { ********************** TLMDHTMLREnder ************************************ }
  TLMDHTMLRender = class
  private
    FLinkSelect: Boolean;
    FHook: TLMDHookComponent;
    FOnImageNeededEx: TLMDHTMLImageNeededEvent;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FCurListItem: integer;
    FIntData,
    FData: TLMDHTMLData;
    FCanvas: TCanvas;
    FBitmap: TBitmap;
    FSaveObj: HGDIOBJ;
    FOnChange: TNotifyEvent;
    FOnInputItemChecked, FOnInputItemTextChanged: TLMDHTMLInputItemChangedEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnAdjustControlPosition: TLMDHTMLControlPositionNeededEvent;
    FOnSetControlVisibility: TLMDHTMLControlVisibilityNeededEvent;
    FOnControlCreated: TLMDHTMLControlCreatedEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;

    function GetControl: TControl;
    procedure SetControl(const Value: TControl);
  protected
    FDoubleBuffered: Boolean;
    procedure CalcTokenSizes(FCurData: TLMDHTMLData);
    function FindItemAt(Point: TPoint; SrcPoint: TPoint; R: TRect):TLMDHTMLItem;
    function GetTextSize: TSize;
    procedure TriggerImageNeededEvent(Src: TLMDString; Image: TPicture); overload; virtual;
    procedure TriggerImageNeededEvent(Src: TLMDString; var Image: Graphics.TBitmap); overload; virtual;
    procedure TriggerInputItemChecked(InputItem: TLMDHTMLInputItem);
    procedure TriggerInputItemTextChanged(InputItem: TLMDHTMLInputItem);
    procedure TriggerVariableNeededEvent(aName: TLMDString; var aValue: TLMDString);
    procedure TriggerAdjustControlPositionEvent(aControl: TControl; aData: Pointer; var X: integer; var Y: integer);
    procedure TriggerControlVisibilityNeededEvent(aControl: TControl; aData: Pointer; var aVisible: boolean);
    procedure TriggerControlCreated(aControl: TControl);
    procedure TriggerTagFound(var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean); virtual;
    procedure BeforeHook(Sender: TObject; var Message: TMessage; var Handled: boolean);
  public
    function AsText: TLMDString;
    constructor Create;
    function CreateData: TLMDHTMLData;
    destructor Destroy; override;
    procedure DestroyData(Data: TLMDHTMLData);
    procedure Change;
    procedure DrawText(Canvas: TCanvas; SrcPoint: TPoint; R: TRect;
      AdjustFromColor: TColor);
    procedure DrawTextEx(ACanvas: TCanvas; ASrcPoint: TPoint; AR: TRect;
      UseOverColors: boolean; AColor, ABkColor, ASelColor, ASelBkColor: TColor;
      AAdjustFromColor: TColor);
    function IsCursorOverLink(Point: TPoint; SrcPoint: TPoint; R: TRect; var
      href: TLMDString): Boolean;

    procedure PrepareText(const Text: TLMDString; MaxWidth: integer; AutoWrap: boolean);
    procedure PrepareToData(const Text: TLMDString; MaxWidth: integer; AutoWrap: boolean;
                            var CurData: TLMDHTMLData);
    procedure SetDC(DC: HDC);
    procedure SetData(NewData: TLMDHTMLData);
    procedure SelectLinkAt(Point: TPoint; SrcPoint: TPoint; R: TRect);
    procedure SelectNextLink;
    procedure SelectPrevLink;
    procedure SelectNextSuitableItem;
    procedure SelectPrevSuitableItem;
    function FindInputItemByName(AName: TLMDString; const FindFrom: TLMDHTMLItem = nil): TLMDHTMLInputItem;
    procedure MouseMoveTransfer(Shift: TShiftState; X, Y: Integer; R: TRect);
    procedure ClickTransfer(X, Y: Integer; R: TRect);
    procedure KeyDownTransfer(var Key: Word; Shift: TShiftState);
    property Data: TLMDHTMLData read FData;
    property DoubleBuffered: Boolean read FDoubleBuffered write FDoubleBuffered default true;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnImageNeededEx: TLMDHTMLImageNeededEvent read FOnImageNeededEx write FOnImageNeededEx;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnInputItemChecked: TLMDHTMLInputItemChangedEvent read FOnInputItemChecked write FOnInputItemChecked;
    property OnInputItemTextChanged: TLMDHTMLInputItemChangedEvent read FOnInputItemTextChanged write FOnInputItemTextChanged;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property OnAdjustControlPosition: TLMDHTMLControlPositionNeededEvent read FOnAdjustControlPosition write FOnAdjustControlPosition;
    property OnSetControlVisibility: TLMDHTMLControlVisibilityNeededEvent read FOnSetControlVisibility write FOnSetControlVisibility;
    property OnControlCreated: TLMDHTMLControlCreatedEvent read FOnControlCreated write FOnControlCreated;
    property OnTagFound: TLMDHTMLTagFoundEvent read FOnTagFound write FOnTagFound;
    property Control: TControl read GetControl write SetControl;
    property LinkSelect: Boolean read FLinkSelect write FLinkSelect;
  end;

procedure InitHTMLRender;
function SpecialCharsFunc(aText: string): TLMDChar;
function LMDColorToRGB(aValue: TColor): string;
function LMDHTMLDrawText(Canvas: TCanvas; szStr: string; ARect: TRect;
  uFlags: TOwnerDrawState; LineGap: integer; bCalcOnly: Boolean = False):
    Integer; overload;
function LMDHTMLDrawText(Canvas: TCanvas; szStr: string; ARect: TRect;
  uFlags: TOwnerDrawState; bCalcOnly: Boolean = False): Integer; overload;

implementation
uses
  TypInfo, Themes, LMDClass,  LMDThemes,LMDGraph, LMDProcs, LMDHashTable;

const
  BulletMargin = 5;
  CInst: Integer = 0;
  CVarTag = '~~';

var
  ScreenPixelsPerInch: integer;
  HTMLRender: TLMDHTMLRender;
  LMDHTMLTags: TStringList;
  LMDInputCtrls: TStringList;

{ ---------------------------------------------------------------------------- }
function AdjustColor(Color, BkColor: TColor): TColor;
var
  HLS: TColor;
begin
  HLS := LMDRGBToHLS(ColorToRGB(BkColor));
  if ((HLS and ($00FF00)) shr 8) > 160 then
    begin
      result := LMDColorDarker(Color, 50);
    end
  else
    begin
      result := LMDColorLighter(Color, 50);
    end;
end;

{ ********************** TLMDHTMLItem **************************************** }
{ ------------------------ private ------------------------------------------- }

function TLMDHTMLItem.GetHeight(var BaseLine: integer): integer;
var
  LTM: {$IFDEF LMD_UNICODE}tagTextMetricW{$ELSE}tagTextMetricA{$ENDIF};
begin
  BaseLine := 0;
  case ItemType of
    hitChar:
      begin
        if Assigned(FOwner.FRender) then
          begin
            with FOwner.FRender.FCanvas.Font do
              begin
                {
                if IsLink then
                  Style := FOwner.FLinkStyle
                else
                }
                Style := FontStyle;
                Charset := FOwner.Charset;
                Name := FFontRef;
                if IsSub or IsSuper then
                  Height := FontHeight - 2
                else
                  Height := FontHeight;
              end;
            LMDGetTextMetrics(FOwner.FRender.FCanvas.Handle, LTM);
            baseLine := LTM.tmDescent;
            Result := Abs(LTM.tmHeight);
          end
        else
          Result := 0;
      end;
    hitBitmap, hitInput, hitControl:
      result := FHeight;
    else
      result := 0;
  end;
  result := result + FOwner.LineGap;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHTMLItem.GetWidth: integer;
var
  LR: TRect;
  LTM: {$IFDEF LMD_UNICODE}tagTextMetricW{$ELSE}tagTextMetricA{$ENDIF};
begin
  case Self.ItemType of
    hitIndent:
      begin
        result := FWidth;
      end;
    hitUL:
      begin
        if FOwner.FRender <> nil then
          begin
            with FOwner.FRender.FCanvas.Font do
              begin
                {if IsLink then
                  Style := FOwner.FLinkStyle
                else}
                  Style := FontStyle;
                Charset := FOwner.Charset;
                Name := FFontRef;
                Height := FontHeight;
              end;
            LMDGetTextMetrics(FOwner.FRender.FCanvas.Handle, LTM);
            result := LTM.tmMaxCharWidth;
          end
        else
          result := 0;
      end;
    hitOL:
      begin
        if FOwner.FRender <> nil then
          begin
            with FOwner.FRender.FCanvas.Font do
              begin
                {if IsLink then
                  Style := FOwner.FLinkStyle
                else
                } Style := FontStyle;
                Charset := FOwner.Charset;
                Name := FFontRef;
                Height := FontHeight;
              end;
            LMDGetTextMetrics(FOwner.FRender.FCanvas.Handle, LTM);
            result := LTM.tmMaxCharWidth;
          end
        else
          result := 0;
      end;
    hitChar, hitVar:
      begin
        if FTWidth <> Word(-1) then
          result := FTWidth
        else
          begin
            if FOwner.FRender <> nil then
              begin
                with FOwner.FRender.FCanvas.Font do
                  begin
                    begin
                      Style := FontStyle;
                    end;
                    Name := FFontRef;
                    if IsSub or IsSuper then
                      Height := FontHeight - 2
                    else
                      Height := FontHeight;
                  end;
                SetRectEmpty(LR);
                LMDDrawText(FOwner.FRender.FCanvas.Handle, Text,
                  Length(Text), LR, DT_SINGLELINE or DT_BOTTOM or DT_NOPREFIX or
                  DT_CALCRECT);
                result := LR.Right - LR.Left + 1;
              end
            else
              result := 0;
            FTWidth := Result;
          end;
      end;
    hitBitmap, hitInput, hitControl:
      result := FWidth;
    hitHR:
      result := FWidth;
    else
      result := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHTMLItem.GetIsLink: Boolean;
begin
  Result := (FBoolState and flIsLink) = flIsLink;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLItem.SetIsLink(Value: Boolean);
begin
  if Value then
    FBoolState := FBoolState or flIsLink
  else
    FBoolState := FBoolState and not flIsLink;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHTMLItem.GetIsSub: Boolean;
begin
  Result := (FBoolState and flSub) = flSub;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLItem.SetIsSub(Value: Boolean);
begin
  if Value then
    FBoolState := FBoolState or flSub
  else
    FBoolState := FBoolState and not flSub;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHTMLItem.GetIsSuper: Boolean;
begin
  Result := (FBoolState and flSuper) = flSuper;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLItem.SetIsSuper(Value: Boolean);
begin
  if Value then
    FBoolState := FBoolState or flSuper
  else
    FBoolState := FBoolState and not flSuper;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLItem.GenerateHTML: TLMDString;
begin
//
end;

{ ------------------------ public -------------------------------------------- }

procedure TLMDHTMLItem.Assign(Source: TLMDHTMLItem);
begin
  if Source <> nil then
    begin
      FontStyle := Source.FontStyle;
      FontHeight := Source.FontHeight;
      FontBgColor := Source.FontBgColor;
      FontColor := Source.FontColor;
      FLinkRef := Source.FLinkRef;
      FFontRef := Source.FFontRef;
      FIndent := Source.FIndent;
      FFntCnt := Source.FFntCnt;
      FBoolState := Source.FBoolState;
    end;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDHTMLItem.Create(Owner: TLMDHTMLData);
begin
  inherited Create;
  FOwner := Owner;
  FTWidth := Word(-1);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDHTMLItem.Destroy;
begin
  inherited;
end;

{ ********************** TLMDHTMLBreakItem *********************************** }
{ ------------------------- private ------------------------------------------ }

function TLMDHTMLBreakItem.GetHeight(var BaseLine: integer): integer;
var
  idx: integer;
  LTM: {$IFDEF LMD_UNICODE}tagTextMetricW{$ELSE}tagTextMetricA{$ENDIF};
begin
  BaseLine := 0;
  idx := FOwner.FArray.IndexOf(Self);
  case Self.ItemType of
    hitLI,
      hitSoftBreak,
      hitBreak:
      begin
        if (idx >= FOwner.FArray.Count) or
         (TLMDHTMLItem(FOwner.FArray[idx + 2]) is TLMDHTMLBreakItem) then
          begin
            if FOwner.FRender <> nil then
              (*
              with FOwner.FRender.FCanvas.Font do
              begin
                Charset := FOwner.Charset;
                Name    := FOwner.DefaultFont;
                Height := FOwner.FDefaultHeight;
                result := Abs(Height);
              end
              else
                result := 0;
              *)
              begin
                with FOwner.FRender.FCanvas.Font do
                  begin
                    {if IsLink then
                      Style := FOwner.FLinkStyle
                    else
                    } Style := FontStyle;
                    Charset := FOwner.Charset;
                    Name := FFontRef;
                    if IsSub or IsSuper then
                      Height := FontHeight - 2
                    else
                      Height := FontHeight;
                  end;
                LMDGetTextMetrics(FOwner.FRender.FCanvas.Handle, LTM);
                baseLine := LTM.tmDescent;
                Result := Abs(LTM.tmHeight);
              end
            else
              result := 0;

          end
        else
          result := 0;
      end;
    hitPara:
      begin
        (*
        if FOwner.FRender <> nil then
        with FOwner.FRender.FCanvas.Font do
        begin
          Charset := FOwner.Charset;
          Name    := FOwner.DefaultFont;
          Height  := FOwner.FDefaultHeight;
          if FOwner.FArray.IndexOf(Self) = 0 then
             result := Abs(Height)
          else
             result := MulDiv(Abs(Height), 3, 2);
        end else
        *)
        result := 0;
      end;
    else
      result := 0;
  end;
  if FOwner.LineSpacing <> 0 then
    Result := Max(Result, FOwner.LineSpacing);
  Result := Result + FOwner.LineGap;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHTMLBreakItem.GetWidth: integer;
var
  LTM: {$IFDEF LMD_UNICODE}tagTextMetricW{$ELSE}tagTextMetricA{$ENDIF};
begin
  case Self.ItemType of
    hitLI:
      begin
        if Assigned(FOwner.FRender) then
          begin
            with FOwner.FRender.FCanvas.Font do
              begin
                {if IsLink then
                  Style := FOwner.FLinkStyle
                else
                } Style := FontStyle;
                Charset := FOwner.Charset;
                Name := FFontRef;
                Height := FontHeight;
              end;
            LMDGetTextMetrics(FOwner.FRender.FCanvas.Handle, LTM);
            result := LTM.tmAveCharWidth;
          end
        else
          result := 0;
      end;
    hitSoftBreak,
      hitBreak,
      hitPara: result := 0;
    else
      result := inherited GetWidth;
  end;
end;

{ ------------------------ public -------------------------------------------- }

procedure TLMDHTMLBreakItem.Assign(Source: TLMDHTMLItem);
begin
  inherited;
  if Source is TLMDHTMLBreakItem then
    begin
      with TLMDHTMLBreakItem(Source) do
        begin
          Self.FListLevel := FListLevel;
          Self.FListItemN := FListItemN;
          Self.FParams := FParams and not (DT_LEFT or DT_CENTER or DT_RIGHT);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLBreakItem.AssignBreakProps(Source: TLMDHTMLBreakItem);
begin
  if Source <> nil then
    with Source do
      begin
        Self.FListLevel := FListLevel;
        Self.FListItemN := FListItemN;
        Self.FParams := FParams;
      end;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDHTMLBreakItem.Create(Owner: TLMDHTMLData);
begin
  inherited;
end;

{ ---------------------- public ---------------------------------------------- }

constructor TLMDHTMLData.Create;
begin
  inherited;
  FArray := TLMDList.Create;
  FControlsArray := TLMDList.Create;
  FRadioList := TLMDMemoryStrings.Create;

  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;

  FDefaultColor := clWindowText;
  FDefaultBgColor := clNone;
  FDefaultStyle := [];
  FDefaultHeight := -11;
  FDefaultFont := 'MS Sans Serif';
  FActiveItem := nil;
  FHOffset := 0;
  FVOffset := 0;
  FHTMLTabWidth := 20;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDHTMLData.Destroy;
begin
  ClearArray;
  FControlsArray.Free;
  FArray.Free;
  FRadioList.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLData.ClearArray;
var
  i: integer;
  Item: TLMDHTMLItem;
begin
  //NOTE: LMDList items are numbered from 1 to count
  FActiveItem := nil;
  for i := 1 to FArray.Count do
    begin
      Item := TLMDHTMLItem(FArray[i]);
      Item.Free;
      FArray[i] := nil;
    end;
  FControlsArray.Clear;
  FRadioList.Clear;
  FArray.Clear;
end; { ClearArray }
{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLData.SetSelectedItem(const Value: TLMDHTMLItem);
begin
  FSelectedItem := Value;
  if Value is TLMDHTMLControlItem then
    if Assigned(TLMDHTMLControlItem(Value).FControl) and (TLMDHTMLControlItem(Value).FControl is TWinControl) then
      TWinControl(TLMDHTMLControlItem(Value).FControl).SetFocus;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLData.SetActiveItem(const Value: TLMDHTMLInputItem);
begin
  if (FActiveItem <> Value) then
  begin
    FActiveItem := Value;
    FRender.Change;
  end;
end;
{ ---------------------------------------------------------------------------- }
function TLMDHTMLData.LineCount: integer;
var
  i, j: integer;
begin
  result := 0;
  j := FArray.Count - 1;
  if j > 0 then
    begin
      for i := 0 to j do
        if TLMDHTMLItem(FArray[i + 1]) is TLMDHTMLBreakItem then
          inc(result);
    end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDHTMLData.GetItem(Index: Integer): TLMDHTMLItem;
begin
  result := TLMDHTMLItem(FArray[Index]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDHTMLData.GetItemCount: integer;
begin
  result := FArray.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLData.GenerateHTML: TLMDString;
var
  i: integer;
  LItem: TLMDHTMLItem;
begin
  Result := '<html>';
  for i := 1 to FArray.Count do
  begin
    LItem := TLMDHTMLItem(FArray[I]);
//(hitSoftBreak, hitPara, hitBitmap, hitHR, hitLI, hitUL, hitOL, hitIndent, hitInput, hitControl);
    case LItem.FItemType of
      hitChar : Result := Result + LItem.FText;
      hitBreak : Result := Result + '<br>'+#13#10;
      hitControl, hitInput: Result := Result + LItem.GenerateHTML+#13#10;
      hitVar: Result := Result + '<~~'+LItem.FText+'>';
    end;
  end;
  Result := Result + '</html>';
end;

{ ********************** TLMDHTMLREnder ************************************** }
{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.SetData(NewData: TLMDHTMLData);
begin
  FData := newData;
  if FData = nil then
    FData := FIntData;
  FData.FRender := Self;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.PrepareText(const Text: TLMDString; MaxWidth: integer; AutoWrap: boolean);
begin
  PrepareToData(Text, MaxWidth, AutoWrap, FData);
end;

{ ---------------------------------------------------------------------------- }
const
  TLMDQuote1 = TLMDChar('''');
  TLMDQuote2 = TLMDChar('"');
function RemoveQuotes(const S: TLMDString): TLMDString;
var
  i: integer;
begin
  i := Length(S);
  if i = 0 then
    result := ''
  else
    begin
      if (S[1] = TLMDQuote1) or (S[1] = TLMDQuote2) then
        begin
          result := Copy(S, 2, i - 1);
          if S[i] = S[1] then
            SetLength(result, i - 2);
        end
      else
        result := S;
    end;
end;

procedure TLMDHTMLRender.PrepareToData(const Text: TLMDString;
  MaxWidth: integer; AutoWrap: boolean; var CurData: TLMDHTMLData);

type
  TFontSettings = record
    FontName: TFontName;
    Height: integer;
    Color: TColor;
    BgColor: TColor;
  end;
  PFontSettings = ^TFontSettings;
var
  BPrp: TLMDHTMLBreakItem;
  DefPrp, CurPrp: TLMDHTMLItem;
  CurC: TLMDChar;
  s: TLMDString;
  f, b: boolean;
  i,h,LCurPos: integer;
  FStack: TLMDStack;
  FCurFont: PFontSettings;
  FSaveData: TLMDHTMLData;
  LListLevel: integer;
  LSPos: integer;
  tlen : integer;

  function GetLastItemBeforeLink(AArray: TLMDList): TLMDHTMLItem;
  var
    i: integer;
  begin
    Result := nil;
    for i := AArray.Count - 1 downto 0 do
      begin
        if (AArray[i]<> nil) and (not TLMDHTMLItem(AArray[i]).IsLink) then
          begin
            result := TLMDHTMLItem(AArray[i]);
            break;
          end;
      end;
  end;

  function GetLastBreakItem(AArray: TLMDList): TLMDHTMLBreakItem;
  var
    i: integer;
  begin
    Result := nil;
    for i := AArray.Count - 1 downto 0 do
      begin
        if TObject(AArray[i]) is TLMDHTMLBreakItem then
          begin
            result := TLMDHTMLBreakItem(AArray[i]);
            break;
          end;
      end;
  end;

  procedure SetItemFont(Item: TLMDHTMLItem; Font: PFontSettings);
  begin
    with Item, Font^ do
      begin
        FFontRef := FontName;
        FontColor := Color;
        FontBgColor := BgColor;
        FontHeight := Height;
      end;
  end;

  procedure SetFontFromItem(Item: TLMDHTMLItem; Font: PFontSettings);
  begin
    with Item, Font^ do
      begin
        FontName := FFontRef;
        Color := FontColor;
        BgColor := FontBgColor;
        Height := FontHeight;
      end;
  end;

  procedure SkipComment;
  var
    LPos: integer;
  begin
    while LCurPos <= Length(Text[LCurPos]) do
      begin
        if Text[LCurPos] = TLMDChar('-') then
          begin
            LPos := LCurPos;
            Inc(LPos);
            if Text[LPos] = TLMDChar('-') then
              begin
                inc(LPos);
                if Text[LPos] = TLMDChar('>') then
                  begin
                    inc(LCurPos, 2);
                    exit;
                  end
                else
                  inc(LCurPos);
              end
            else
              inc(LCurPos);
          end
        else
          inc(LCurPos);
      end;
    dec(LCurPos);
  end;

  function FindParamName(SL: TLMDMemoryStrings; Name: TLMDstring): integer;
  var
    i: integer;
  begin
    for i := 0 to Pred(SL.Count) do
      begin
        if SL.Names[i] = Name then
          begin
            result := i;
            exit;
          end;
      end;
    result := -1;
  end;

  procedure CollectParameters(SL: TLMDMemoryStrings);
  var
    S, S1, S2: TLMDString;
    quote: TLMDChar;
    CurC: TLMDChar;
    quoted: boolean;
    lUnnamedParamCount: integer;
  begin
    S := '';
    quote := #0;
    quoted := False;
    lUnnamedParamCount := 0;
    while LCurPos <= Length(Text) do
      begin
        CurC := Text[LCurPos];
        if quoted then
          begin
            if CurC = quote then
              begin
                quoted := False;
              end;
          end
        else
          begin
            if (CurC = TLMDQuote1) or (CurC = TLMDQuote2) then
              begin
                quote := CurC;
                quoted := True;
              end;
          end;
        if (not quoted) and ((CurC = TLMDChar(#32)) or (CurC = TLMDChar('>')))
          then
          begin
{$IFDEF LMD_UNICODE}
            if Assigned(LMDWideStrScan(PWideChar(S),
              TLMDChar('='))) then
{$ELSE}
            if (Pos('=', S) > 0) then
{$ENDIF}
              begin
{$IFDEF LMD_UNICODE}
                S1 := LMDWideTrim(Copy(S, 1, Pos('=', S) - 1));
                S2 := LMDWideTrim(Copy(S, Pos('=', S), Length(S)));
{$ELSE}
                S1 := Trim(Copy(S, 1, Pos('=', S) - 1));
                S2 := Trim(Copy(S, Pos('=', S), Length(S)));
{$ENDIF}
                SL.Add(LowerCase(S1) + S2);
              end
            else
              if Length(S) > 0 then
              begin
                inc(lUnnamedParamCount);
                SL.Add('p' + inttostr(lUnnamedParamCount) + '=' + S);
              end;
            S := '';
            if CurC = '>' then
              break;
          end
        else
          if (CurC <> #32) or (S = '') or (S[Length(S)] <> #32) then
            S := S + CurC;
        Inc(LCurPos);
      end;
  end;

  procedure SkipToTagEnd;
  begin
    while not ((LCurPos > Length(Text)) or (Text[LCurPos] = TLMDChar('>'))) do
      inc(LCurPos);
    if LCurPos > Length(Text) then
      LCurPos := Length(Text);
  end;

  procedure ProcessTag;
  var
    S, S1: TLMDString;
    BPrp: TLMDHTMLBreakItem;
    PrevPrp, APrp: TLMDHTMLItem;
    AInpPrp: TLMDHTMLInputItem;
    AConPrp: TLMDHTMLControlItem;
    SL: TLMDMemoryStrings;
    LImg: TPicture;
    b: boolean;
    c, i: Integer;
    LTag: TLMDPtrInt;
    LInpt: string;
    idx: Integer;

    procedure ParseFontSettings;
    var
      lpxls: boolean;
      lpos: integer;
    begin
      if SL <> nil then
        begin
          s := RemoveQuotes(SL.Values[TLMDString('face')]);
          if s <> '' then
            FCurFont.FontName := S;
          s := RemoveQuotes(SL.Values[TLMDString('name')]);
          if s <> '' then
            FCurFont.FontName := S;
          s := RemoveQuotes(SL.Values[TLMDString('size')]);
          if Length(s) > 0 then
            begin
              if (s[1] = TLMDChar('+')) or (s[1] = TLMDChar('-')) then
                FCurFont.Height := LMDSign(FCurFont.Height) *
                  (abs(CurData.FDefaultHeight) + MulDiv(StrToIntDef(S, 0),
                  ScreenPixelsPerInch, 72))
              else
                begin
                  lpxls := false;
                  lpos := Pos('px', s);
                  if (lpos > 0) then
                    begin
                      Delete(s, lpos, 2);
                      s := Trim(s);
                      //must use exact value in pixels if param like size="6 px" used
                      lpxls := true;
                    end;
                  //This implements old LMDHTMLUnit behaviour for SIZE=1,2,...,9
                  //and old HTMLRender behavior for exact sizing (lpxls = true)
                  h := StrToIntDef(s, CurData.FDefaultHeight);
                  if (h > 0) and (h < 10) and not (lpxls) then
                    FCurFont.Height := LMDSign(FCurFont.Height) * (Abs(CurData.FDefaultHeight) + h * 5)
                  else
                    FCurFont.Height := h;
                end;
            end;
          s := RemoveQuotes(SL.Values[TLMDString('color')]);
          if Length(s) > 0 then
            begin
              if s[1] = TLMDChar('#') then
                begin
                  Delete(s, 1, 1);
                  FCurFont.Color := LMDSwapInt32(LMDAnsiH2DDef(S,
                    CurData.FDefaultColor) shl 8);
                end
              else
                begin
                  if not LMDAnsiContainsAt(s, 1, 'cl') then
                    s := TLMDString('cl') + s;
                  if IdentToColor(s, c) then
                    FCurFont.Color := c;
                end;
            end;
          s := RemoveQuotes(SL.Values[TLMDString('bgcolor')]);
          if Length(s) = 0 then
            s := RemoveQuotes(SL.Values[TLMDString('background')]);
          if Length(s) > 0 then
            begin
              if s[1] = TLMDChar('#') then
                begin
                  Delete(s, 1, 1);
                  FCurFont.BgColor := LMDSwapInt32(LMDAnsiH2DDef(S,
                    CurData.FDefaultBgColor) shl 8);
                end
              else
                begin
                  if not LMDAnsiContainsAt(s, 1, 'cl') then
                    s := TLMDString('cl') + s;
                  if IdentToColor(s, c) then
                    FCurFont.BgColor := c;
                end;
            end;
          if ((Length(SL.Values[TLMDString('color')]) > 0)) or
            ((Length(SL.Values['bgcolor'])) > 0) or
            ((Length(SL.Values['background'])) > 0) then
            Inc(APrp.FFntCnt);
        end;
    end;

    procedure ProcessFontStyleTag(Style: TFontStyles);
    begin
      if b then
        CurData.FArray.Add(CurPrp);
      APrp := TLMDHTMLItem.Create(CurData);
      APrp.Assign(CurPrp);
      if S[1] <> TLMDChar('/') then
        APrp.FontStyle := APrp.FontStyle + Style
      else
        if not (Style <= FData.FDefaultStyle) then
          APrp.FontStyle := APrp.FontStyle - Style;
      if not b then
        CurPrp.Free;
      CurPrp := APrp;
      if SL <> nil then
        SkipToTagEnd;
    end;

    procedure ProcessSubStyleTag(Style: integer);
    begin
      if b then
        CurData.FArray.Add(CurPrp);
      APrp := TLMDHTMLItem.Create(CurData);
      APrp.Assign(CurPrp);

      if S[1] <> TLMDChar('/') then
        APrp.FBoolState := APrp.FBoolState or Style
      else
        APrp.FBoolState := APrp.FBoolState and not Style;

      if not b then
        CurPrp.Free;
      CurPrp := APrp;
      if SL <> nil then
        SkipToTagEnd;
    end;

  begin
    inc(LCurPos);
    S := '';
    while (LCurPos <= Length(Text)) and not ((Text[LCurPos] = TLMDChar('>')) or
      (Text[LCurPos] = TLMDChar(' '))) do
      begin
        s := s + Text[LCurPos];
        if S = TLMDString('!--') then
          begin
            SkipComment;
            exit;
          end;
        inc(LCurPos);
      end;
    if LCurPos > Length(Text) then
      begin
        LCurPos := Length(Text);
        exit;
      end;
    SL := nil;
    try
      if Text[LCurPos] = TLMDChar(' ') then
      begin
        SL := TLMDMemoryStrings.Create;
        CollectParameters(SL);
      end
      else
        if Copy(s, 1, Length(CVarTag)) = CVarTag then
        begin
          SL := TLMDMemoryStrings.Create;
          SL.Add('p1='+copy(s, Length(CVarTag)+1, Length(s)));
          s := CVarTag;
        end;

      s := lowercase(s);
      b := (CurPrp.ItemType <> hitChar) or (Length(CurPrp.Text) > 0);
      idx := LMDHTMLTags.IndexOf(s);
      if idx <> -1 then
        LTag := TLMDPtrInt(LMDHTMLTags.Objects[idx])
      else
        LTag := -1;

      s1 := s;
      TriggerTagFound(s, CurPrp, SL, Pos('/', s1) > 0, LTag >= 0);
      if (s <> s1) then
      begin
        s := lowercase(s);
        idx := LMDHTMLTags.IndexOf(s);
        if idx <> -1 then
          LTag := TLMDPtrInt(LMDHTMLTags.Objects[idx])
        else
          LTag := -1;
      end;

      if LTag >= 0 then
        case LTag of
          0 : ProcessSubStyleTag(flSub); // 'sub'
          1 : ProcessSubStyleTag(flSuper); //'sup'
          2 : ProcessFontStyleTag([fsBold]); // 'b', 'strong'
          3 : ProcessFontStyleTag([fsItalic]); // 'i', 'em'
          4 : ProcessFontStyleTag([fsItalic, fsBold]); // 'var', 'site'
          5 : ProcessFontStyleTag([fsStrikeOut]); // 'strikeout', 's'
          6 : ProcessFontStyleTag([fsUnderline]); // 'u'
          7 : // 'ul'
            begin
              if (CurPrp is TLMDHTMLBreakItem) and (CurPrp.ItemType
                in [hitBreak, hitSoftBreak]) then
                b := false
              else
                begin
                  BPrp := GetLastBreakItem(CurData.FArray);
                  if (BPrp <> nil) and (BPrp.ItemType in [hitBreak,
                    hitSoftBreak]) and
                    (CurPrp <> nil) and (CurPrp.ItemType = hitChar)
                      and (Trim(CurPrp.Text) = '') then
                    begin
                      b := false;
                      for i := CurData.FArray.IndexOf(BPrp) + 1 to
                        CurData.FArray.Count - 1 do
                        begin
                          APrp := TLMDHTMLItem(CurData.FArray[i +
                            1]);
                          if (APrp.ItemType <> hitChar) or
                            (Trim(APrp.Text) <> '') then
                            begin
                              b := true;
                              break;
                            end;
                        end;
                      if not b then
                        begin
                          BPrp := GetLastBreakItem(CurData.FArray);
                          i := CurData.FArray.IndexOf(BPrp);
                          while CurData.FArray.Count > i do
                            begin
                              CurData.FArray.Last;
                              CurData.FArray.Delete;
                            end;
                        end;
                      b := (CurPrp.ItemType <> hitChar) or
                        (Length(CurPrp.Text) > 0);
                    end;
                end;
              if b then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              if not b then
                CurPrp.Free;
              Inc(LListLevel);
              FCurListItem := -1;

              CurPrp := TLMDHTMLBreakItem.Create(CurData);
              CurPrp.Assign(APrp);
              CurPrp.FItemType := hitUL;
              CurData.FArray.Add(CurPrp);
              CurPrp.FIndent := CurPrp.FIndent + CurPrp.GetWidth;
              APrp.FIndent := CurPrp.FIndent;
              APrp.FItemType := hitChar;
              CurPrp := APrp;
            end;
          8 : // '/ul'
            begin
              if b and (CurPrp.ItemType <> hitBreak) then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              if (not b) or (CurPrp.ItemType = hitBreak) then
                CurPrp.Free;
              Dec(LListLevel);
              APrp.FItemType := hitUL;
              APrp.FIndent := APrp.FIndent - APrp.GetWidth;
              CurData.FArray.Last;
              if TLMDHTMLItem(CurData.FArray.Item).ItemType =
                hitBreak then
                CurData.FArray.Delete;
              CurPrp := TLMDHTMLBreakItem.Create(CurData);
              CurPrp.Assign(APrp);
              CurPrp.FItemType := hitBreak;
              CurData.FArray.Add(CurPrp);
              APrp.FItemType := hitChar;
              CurPrp := APrp;
            end;
          9 : // 'ol'
            begin
              if (CurPrp is TLMDHTMLBreakItem) and
                (CurPrp.ItemType in [hitBreak, hitSoftBreak]) then
                b := false
              else
                begin
                  BPrp := GetLastBreakItem(CurData.FArray);
                  if (BPrp <> nil) and (BPrp.ItemType in
                    [hitBreak, hitSoftBreak]) and
                    (CurPrp <> nil) and (CurPrp.ItemType =
                      hitChar) and (Trim(CurPrp.Text) = '') then
                    begin
                      b := false;
                      for i := CurData.FArray.IndexOf(BPrp) + 1
                        to CurData.FArray.Count - 1 do
                        begin
                          APrp := TLMDHTMLItem(CurData.FArray[i + 1]);
                          if (APrp.ItemType <> hitChar) or
                            (Trim(APrp.Text) <> '') then
                            begin
                              b := true;
                              break;
                            end;
                        end;
                      if not b then
                        begin
                          BPrp :=
                            GetLastBreakItem(CurData.FArray);
                          i := CurData.FArray.IndexOf(BPrp);
                          while CurData.FArray.Count > i do
                            begin
                              CurData.FArray.Last;
                              CurData.FArray.Delete;
                            end;
                        end;
                      b := (CurPrp.ItemType <> hitChar) or
                        (Length(CurPrp.Text) > 0);
                    end;
                end;
              if b then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              if not b then
                CurPrp.Free;
              Inc(LListLevel);
              FCurListItem := 1;
              CurPrp := TLMDHTMLBreakItem.Create(CurData);
              CurPrp.Assign(APrp);
              CurPrp.FItemType := hitOL;
              CurData.FArray.Add(CurPrp);
              CurPrp.FIndent := CurPrp.FIndent +
                CurPrp.GetWidth;
              APrp.FIndent := CurPrp.FIndent;
              APrp.FItemType := hitChar;
              CurPrp := APrp;
            end;
          10 : // '/ol'
            begin
              if b and (CurPrp.ItemType <> hitBreak) then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              if (not b) or (CurPrp.ItemType = hitBreak) then
                CurPrp.Free;
              Dec(LListLevel);
              APrp.FItemType := hitOL;
              APrp.FIndent := APrp.FIndent - APrp.GetWidth;
              CurData.FArray.Last;
              if TLMDHTMLItem(CurData.FArray.Item).ItemType =
                hitBreak then
                CurData.FArray.Delete;

              FCurListItem := -1;

              CurPrp := TLMDHTMLBreakItem.Create(CurData);
              CurPrp.Assign(APrp);
              CurPrp.FItemType := hitBreak;
              CurData.FArray.Add(CurPrp);
              APrp.FItemType := hitChar;
              CurPrp := APrp;
            end;
          11 :  // 'li'
            begin
              if b and (CurPrp.ItemType <> hitBreak) then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              if (not b) or (CurPrp.ItemType = hitBreak)
                then
                CurPrp.Free;
              CurData.FArray.Last;
              if TLMDHTMLItem(CurData.FArray.Item).ItemType
                = hitBreak then
                CurData.FArray.Delete;
              CurPrp := TLMDHTMLBreakItem.Create(CurData);
              CurPrp.FItemType := hitLI;
              TLMDHTMLBreakItem(CurPrp).FListItemN :=
                FCurListItem;
              TLMDHTMLBreakItem(CurPrp).FListLevel :=
                LListLevel;

              if FCurListItem > 0 then
                Inc(FCurListItem);

              CurPrp.Assign(APrp);
              CurData.FArray.Add(CurPrp);

              APrp.FItemType := hitChar;
              CurPrp := APrp;
            end;
          12 :  // 'p'
            begin
              if (s = TLMDString('p')) and
                (CurData.FArray.Count > 0) then
                begin
                  PrevPrp :=
                    TLMDHTMLItem(CurData.FArray.LastItem^);
                  if (PrevPrp.ItemType = hitBreak) and
                    ((PrevPrp.FBoolState and flIsParE) =
                      flIsParE) then
                    begin
                      PrevPrp.FBoolState :=
                        PrevPrp.FBoolState and not flIsParE;
                      exit;
                    end;
                end
              else
                if (s = TLMDString('/p')) and
                  (CurData.FArray.Count > 0) then
                  begin
                    PrevPrp :=
                      TLMDHTMLItem(CurData.FArray.LastItem^);
                    if (PrevPrp.ItemType = hitBreak) and
                      ((PrevPrp.FBoolState and flIsParE) =
                        flIsParE) then
                      exit;
                  end;
              if b then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              if not b then
                CurPrp.Free;
              CurPrp := TLMDHTMLBreakItem.Create(CurData);
              CurPrp.FItemType := hitPara;
              CurPrp.Assign(APrp);
              if (s = TLMDString('/p')) then
                CurPrp.FBoolState := CurPrp.FBoolState or
                  Integer(flIsParE);
              TLMDHTMLBreakItem(CurPrp).FParams := 0;
              if SL <> nil then
                begin
                  s :=
                    lowercase(RemoveQuotes(SL.Values[TLMDString('align')]));
                  TLMDHTMLBreakItem(CurPrp).FParams :=
                    DT_LEFT;
                  if s <> '' then
                    begin
                      if s = TLMDString('left') then
                        TLMDHTMLBreakItem(CurPrp).FParams
                          := DT_LEFT
                      else
                        if s = TLMDString('center') then
                          TLMDHTMLBreakItem(CurPrp).FParams
                            := DT_CENTER
                        else
                          if s = TLMDString('right') then
                            TLMDHTMLBreakItem(CurPrp).FParams := DT_RIGHT;
                    end;
                  s :=
                    RemoveQuotes(SL.Values[TLMDString('indent')]);
                  if (Length(s) > 0) then
                    TLMDHTMLBreakItem(CurPrp).FIndent :=
                      StrToIntDef(s, 0);
                end;
              APrp.Assign(CurPrp);
              CurData.FArray.Add(CurPrp);
              APrp.FItemType := hitChar;
              CurPrp := APrp;
            end;
          13 : // 'br'
            begin
              if b then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              if not b then
                CurPrp.Free;

              CurPrp := TLMDHTMLBreakItem.Create(CurData);
              CurPrp.Assign(APrp);
              CurPrp.FItemType := hitBreak;

              BPrp := GetLastBreakItem(CurData.FArray);
              if BPrp = nil then
                TLMDHTMLBreakItem(CurPrp).FParams := 0
              else
                TLMDHTMLBreakItem(CurPrp).FParams := BPrp.FParams;
              CurData.FArray.Add(CurPrp);
              CurPrp := APrp;
            end;
          14 :  // 'ind'
            begin
              if SL <> nil then
                begin
                  s :=
                    RemoveQuotes(SL.Values[TLMDString('width')]);
                  if Length(S) > 0 then
                    begin
                      if b then
                        CurData.FArray.Add(CurPrp);
                      APrp :=
                        TLMDHTMLItem.Create(CurData);
                      APrp.Assign(CurPrp);
                      APrp.FItemType := hitIndent;
                      APrp.Text := '';
                      APrp.FWidth := StrToIntDef(s,
                        0);
                      s :=
                        lowercase(RemoveQuotes(SL.Values[TLMDString('pos')]));

                      if s = 'abs' then
                        APrp.FBoolState :=
                          APrp.FBoolState or flAbsInd
                      else
                        APrp.FBoolState :=
                          APrp.FBoolState and not
                          flAbsInd;

                      CurData.FArray.Add(APrp);
                      APrp :=
                        TLMDHTMLItem.Create(CurData);
                      APrp.Assign(CurPrp);
                      APrp.FItemType := hitChar;
                      if not b then
                        CurPrp.Free;
                      CurPrp := APrp;
                    end;
                end;
            end;
          15 : // 'img'
            begin
              if SL <> nil then
                begin
                  s := RemoveQuotes(SL.Values[TLMDString('src')]);
                  if Length(S) > 0 then
                    begin
                      if b then
                        CurData.FArray.Add(CurPrp);
                      APrp := TLMDHTMLItem.Create(CurData);
                      APrp.Assign(CurPrp);
                      APrp.FItemType := hitBitmap;
                      APrp.Text := s;
                      LImg := TPicture.Create;
                      try
                        TriggerImageNeededEvent(S, LImg);

                        s := RemoveQuotes(SL.Values[TLMDString('transparent')]);
                        APrp.Transparent := s <> 'solid';

                        s := RemoveQuotes(SL.Values[TLMDString('width')]);
                        if (LImg.Graphic <> nil) and not LImg.Graphic.Empty then
                          APrp.FWidth := StrToIntDef(s, LImg.Graphic.Width)
                        else
                          APrp.FWidth := StrToIntDef(s, 0);
                        s := RemoveQuotes(SL.Values[TLMDString('height')]);
                        if (LImg.Graphic <> nil) and not LImg.Graphic.Empty then
                          APrp.FHeight := StrToIntDef(s, LImg.Graphic.Height)
                        else
                          APrp.FHeight := StrToIntDef(s, 0);
                      finally
                        LImg.Free;
                      end;
                      CurData.FArray.Add(APrp);
                      APrp := TLMDHTMLItem.Create(CurData);
                      APrp.Assign(CurPrp);
                      APrp.FItemType := hitChar;
                      if not b then
                        CurPrp.Free;
                      CurPrp := APrp;
                    end;
                end;
            end;
          16 :  // 'a'
            begin
              if SL <> nil then
                begin
                  s := RemoveQuotes(SL.Values[TLMDString('href')]);
                  CurData.FArray.Add(CurPrp);
                  APrp := TLMDHTMLItem.Create(CurData);
                  APrp.Assign(CurPrp);
                  APrp.IsLink := true;
                  APrp.FLinkRef := s;
                  s := RemoveQuotes(SL.Values[TLMDString('color')]);
                  try
                    if s <> '' then
                      APrp.FontColor := StringToColor(s)
                    else
                      APrp.FontColor := CurData.FLinkColor;
                  except
                    APrp.FontColor := clNone; //Used for check in DrawTextEx
                  end;
                  APrp.FontStyle := CurData.FLinkStyle;
                  CurPrp := APrp;
                  CurData.FControlsArray.Add(APrp);
                end;
            end;
          17 :  // '/a'
            begin
              if b then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              APrp.FLinkRef := '';
              APrp.IsLink := false;
              PrevPrp := GetLastItemBeforeLink(CurData.FArray);
              if PrevPrp <> nil then
              begin
                APrp.FontStyle := PrevPrp.FontStyle;
                APrp.FontColor := PrevPrp.FontColor;
              end
              else
              begin
                APrp.FontStyle := CurData.DefaultStyle;
                APrp.FontColor := CurData.DefaultColor;
              end;
              if not b then
                CurPrp.Free;
              CurPrp := APrp;
            end;
          18 : ; // 'html' intentionally left blank
          19 :  // 'hr'
            begin
              if b then
                CurData.FArray.Add(CurPrp);
              // add line break
              APrp := TLMDHTMLBreakItem.Create(CurData);
              APrp.Assign(CurPrp);
              APrp.FItemType := hitBreak;
              CurData.FArray.Add(APrp);
              // create new token
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              CurData.FArray.Add(APrp);
              // add HR
              if not b then
                CurPrp.Free;
              CurPrp := TLMDHTMLItem.Create(CurData);
              CurPrp.Assign(APrp);
              APrp.FItemType := hitHR;
              if (SL <> nil) then
                begin
                  s := RemoveQuotes(SL.Values[TLMDString('width')]);
                  APrp.FWidth := StrToIntDef(s, 0);
                end;
              APrp := TLMDHTMLBreakItem.Create(CurData);
              APrp.Assign(CurPrp);
              APrp.FItemType := hitBreak;
              CurData.FArray.Add(APrp);
            end;
          20: // '/font'
            begin
              if b then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              if FStack.Count > 0 then
                begin
                  if (PFontSettings(FStack.Top).Color <> FCurFont.Color) or
                    (PFontSettings(FStack.Top).BgColor <> FCurFont.BgColor) then
                    Dec(APrp.FFntCnt);
                  if (FCurFont <> nil) then
                    begin
                      Dispose(FCurFont);
                      FCurFont := nil;
                    end;
                  FCurFont := PFontSettings(FStack.ExtractTop);
                end;
              SetItemFont(APrp, FCurFont);
              if not b then
                CurPrp.Free;
              CurPrp := APrp;
              if SL <> nil then
                SkipToTagEnd;
            end;
          21: // 'font'
            begin
              if b then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              FStack.Push(FCurFont);
              New(FCurFont);
              SetFontFromItem(CurPrp, FCurFont);
              ParseFontSettings;
              SetItemFont(APrp, FCurFont);
              if not b then
                CurPrp.Free;
              CurPrp := APrp;
            end;
          22: //input
            begin
              if SL <> nil then
              begin
                s := lowercase(RemoveQuotes(SL.Values[TLMDString('type')]));
                LInpt := LMDInputCtrls.Values[s];
                if Length(LInpt) > 0 then
                begin
                  if b then
                    CurData.FArray.Add(CurPrp);
                  AInpPrp := TLMDHTMLInputItem.Create(CurData);
                  AInpPrp.Assign(CurPrp);
                  AInpPrp.FItemType := hitInput;
                  s := lowercase(RemoveQuotes(SL.Values[TLMDString('name')]));
                  if Length(s) > 0 then
                    AInpPrp.FName := s;
                  case StrToInt(LInpt) of
                    1:  begin
                          AInpPrp.FWidth := 17;
                          AInpPrp.FHeight := 17;
                          AInpPrp.InputType := itCheckBox;
                        end;
                    2:  begin
                          AInpPrp.FWidth := 17;
                          AInpPrp.FHeight := 17;
                          AInpPrp.InputType := itRadioButton;
                        end;
                  end;
                  AInpPrp.ProcessAtributes(SL);
                  CurData.FArray.Add(AInpPrp);
                  CurData.FControlsArray.Add(AInpPrp);
                  APrp := TLMDHTMLItem.Create(CurData);
                  APrp.Assign(CurPrp);
                  APrp.FItemType := hitChar;
                  if not b then
                    CurPrp.Free;
                  CurPrp := APrp;
                end;
              end;
            end;
          23: //control
            begin
              if SL <> nil then
              begin
                s := lowercase(RemoveQuotes(SL.Values[TLMDString('vclclass')]));
                if assigned(GetClass(s)) then
                begin
                  if b then
                    CurData.FArray.Add(CurPrp);
                  AConPrp := TLMDHTMLControlItem.Create(CurData);
                  AConPrp.Assign(CurPrp);
                  AConPrp.FItemType := hitControl;
                  AConPrp.ProcessAtributes(SL);
                  CurData.FArray.Add(AConPrp);
                  CurData.FControlsArray.Add(AConPrp);
                  APrp := TLMDHTMLItem.Create(CurData);
                  APrp.Assign(CurPrp);
                  APrp.FItemType := hitChar;
                  if not b then
                    CurPrp.Free;
                  CurPrp := APrp;
                end;
              end;
            end;
          24: // 'var'
            begin
              if b then
                CurData.FArray.Add(CurPrp);
              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              APrp.FItemType := hitVar;
              if SL <> nil then
                begin
                  APrp.Text := SL.Values[TLMDString('name')];
                  if APrp.Text='' then
                    APrp.Text := SL.Values[TLMDString('p1')];
                end
              else
                APrp.Text := '';
              TriggerVariableNeededEvent(APrp.Text, s);
              APrp.Text := s;
              CurData.FArray.Add(APrp);

              APrp := TLMDHTMLItem.Create(CurData);
              APrp.Assign(CurPrp);
              APrp.FItemType := hitChar;
              APrp.FText := ' ';
              if not b then
                CurPrp.Free;
              CurPrp := APrp;
            end;
        end;
    finally
      SL.Free;
    end;
  end;

  function GetCurWidth: integer;
  var
    i: integer;
    Item: TLMDHTMLItem;
  begin
    Result := CurPrp.FWidth;
    for i := Pred(CurData.FArray.Count) downto 0 do
      begin
        Item := TLMDHTMLItem(CurData.FArray[i + 1]);
        if Item is TLMDHTMLBreakItem then
          begin
            Inc(Result, Item.FIndent);
            break;
          end
        else
          Inc(Result, Item.GetWidth);
      end;
  end;

  //NOTE! This procedure is used because FontName strings of stack  items must be correctly freed
  //when Stack is being cleared; we might use FStack.OnDestroyItem event as well, but this
  //would require a little bit more code changes. //VB nov 2007
  procedure ClearStack;
  var
    item: Pointer;
    begin
    item := FStack.ExtractTop;
    while item <> nil do
      begin
        SetLength(PFontSettings(item).FontName, 0);
        Dispose(item);
        item := FStack.ExtractTop;
      end;
  end;

begin
  //start of PrepareToData procedure
  LListLevel := 0;
  FSaveData := FData;
//  if Pos(#0, Text) > 0 then
//    SetLength(Text, Pos(#0, Text)); //remove garbage

  FCurFont := nil;

  FData := CurData;
  FData.MaxWidth := MaxWidth;
  FData.ClearArray;
  with CurData do
    begin
      try
        FSelectedItem := nil;
        LCurPos := 1;
        DefPrp := TLMDHTMLItem.Create(CurData);
        try
          FStack := TLMDStack.Create;
          try

            New(FCurFont);

            FCurFont.FontName := '';
            DefPrp.FontStyle := FDefaultStyle;
            FCurFont.FontName := DefaultFont;
            FCurFont.Color := FDefaultColor;
            FCurFont.BgColor := FDefaultBgColor;
            FCurFont.BgColor := FDefaultBgColor;
            FCurFont.Height := FDefaultHeight;
            SetItemFont(DefPrp, FCurFont);

            CurPrp := TLMDHTMLItem.Create(CurData);
            CurPrp.Assign(DefPrp);

            while LCurPos <= Length(Text) do
              begin
                CurC := #0;
                if Text[LCurPos] = TLMDChar('<') then
                  ProcessTag
                else
                  begin
                    if Text[LCurPos] = TLMDChar(#13) then
                      begin
                        inc(LCurPos);
                        if Text[LCurPos] <> TLMDChar(#10) then
                          dec(LCurPos);
                      end
                    else
                      begin
                        if (Text[LCurPos] = TLMDChar('&')) and (Text[LCurPos + 1]
                          <> #32) then
                          begin
                            inc(LCurPos);
                            if Text[LCurPos] = TLMDChar('#') then
                              begin
                                inc(LCurPos);
                                s := '';
                                while (LCurPos <= Length(Text)) and
                                  (Text[LCurPos] <> TLMDChar(';')) do
                                  begin
                                    s := s + Text[LCurPos];
                                    inc(LCurPos);
                                  end;
                                i := StrToIntDef(S, 32);
                                if i <> 32 then
                                  CurC := TLMDChar(i)
                                else
                                  if (Length(CurPrp.Text) = 0) or
                                    (CurPrp.Text[Length(CurPrp.Text)] <>
                                      TLMDChar(#32)) then
                                    CurC := TLMDChar(#32);
                                if LCurPos > Length(Text) then
                                  LCurPos := Length(Text);
                              end
                            else
                              begin
                                s := '';
                                f := false;
                                i := LCurPos;
                                while (LCurPos <= Length(Text)) do
                                  begin
                                    if Text[LCurPos] = TLMDChar(';') then
                                      begin
                                        f := true;
                                        break;
                                      end;
                                    s := s + Text[LCurPos];
                                    inc(LCurPos);
                                  end;
                                if f then
                                  begin
                                    s := Lowercase(s);
                                    CurC := SpecialCharsFunc(s);
                                  end
                                else
                                  begin
                                    //this is in case when ';' after & is absent - VB
                                    CurPrp.Text := CurPrp.Text + '&';
                                    LCurPos := i - 1;
                                  end;
                              end
                          end
                        else
                          if Text[LCurPos] = #32 then
                            begin
                              if (Length(CurPrp.Text) = 0) or
                                (CurPrp.Text[Length(CurPrp.Text)] <> #32) then
                                CurC := Text[LCurPos];
                            end
                          else
                            CurC := Text[LCurPos];
                      end;

                      if CurC = #9 then
                      begin
                        tlen := CurPrp.GetWidth;
                        FArray.Add(CurPrp);
                        CurPrp := TLMDHTMLItem.Create(CurData);
                        CurPrp.FItemType := hitChar;
                        CurPrp.Assign(TLMDHTMLItem(CurData.FArray.LastItem^));
                        CurPrp.Text := '';
                        CurPrp.FTWidth := FHTMLTabWidth - (tlen mod FHTMLTabWidth);
                        FArray.Add(CurPrp);
                        CurPrp := TLMDHTMLItem.Create(CurData);
                        CurPrp.FItemType := hitChar;
                        CurPrp.Assign(TLMDHTMLItem(CurData.FArray.LastItem^));
                        CurPrp.Text := '';
                        CurPrp.FTWidth := Word(-1);
                        CurC := #0;
                      end;

                    if CurC <> #0 then
                      begin
                        CurPrp.Text := CurPrp.Text + CurC;
                        CurPrp.FTWidth := Word(-1);

                        if AutoWrap and (GetCurWidth + CurPrp.GetWidth > MaxWidth) then
                          begin
                            CurPrp.FTWidth := WORD(-1);
                            b := false;
{$IFDEF LMD_UNICODE}
                            LSPos := LMDWideLastPos(' ', CurPrp.Text);
{$ELSE}
                            LSPos := LMDAnsiLastPos(' ', CurPrp.Text);
{$ENDIF}
                            if (LSPos = 0) and (FArray.LastItem <> nil) and
                               (TLMDHTMLItem(FArray.LastItem^) is TLMDHTMLBreakItem) then
                            begin
                              s := CurC;
                              SetLength(CurPrp.FText, Length(CurPrp.FText) - 1);
                            end
                            else
                            begin
                              if Length(CurPrp.FText) > 1 then
                              begin
                                dec(LCurPos);
                                SetLength(CurPrp.FText, Length(CurPrp.FText) - 1);
                              end;
                              S := LMDExtractStr(CurPrp.FText, LSPos + 1,
                                Length(CurPrp.Text));
                            end;

                            if CurPrp.Text <> '' then
                              b := true;
                            FArray.Add(CurPrp);

                            CurPrp := TLMDHTMLBreakItem.Create(CurData);
                            CurPrp.FItemType := hitSoftBreak;
                            CurPrp.Assign(TLMDHTMLItem(FArray.LastItem^));
                            BPrp := GetLastBreakItem(FArray);
                            TLMDHTMLBreakItem(CurPrp).AssignBreakProps(BPrp);
                            FArray.Add(CurPrp);
                            CurPrp := TLMDHTMLItem.Create(CurData);
                            CurPrp.FItemType := hitChar;
                            CurPrp.Assign(TLMDHTMLItem(CurData.FArray.LastItem^));
                            CurPrp.Text := S;
                            CurPrp.FTWidth := Word(-1);
                            with CurData do
                              if not b then
                                begin
                                  FArray.Last;
                                  FArray.Prev;
                                  TLMDHTMLItem(FArray.Get).Free;
                                end;
                          end;
                      end;
                  end;
                inc(LCurPos);
              end;

            if (CurPrp.ItemType <> hitChar) or (Length(CurPrp.Text) > 0) then
              FArray.Add(CurPrp)
            else
              CurPrp.Free;

            if FArray.Count > 0 then
              begin
                CurPrp := TLMDHTMLItem(FArray[1]);
                if CurPrp.ItemType <> hitPara then
                  begin
                    CurPrp := TLMDHTMLBreakItem.Create(CurData);
                    CurPrp.FItemType := hitPara;
                    TLMDHTMLBreakItem(CurPrp).FParams := DT_LEFT;
                    FArray.InsertAt(CurPrp, 0);
                  end;
              end;
            CalcTokenSizes(CurData);
          finally
            if FCurFont <> nil then
              begin
                Dispose(FCurFont);
                FCurFont := nil;
              end;
            ClearStack;
            FStack.Free;
            end;
        finally
          DefPrp.Free;
        end;
      except
        on E: Exception do
          begin
            ClearArray;
            //raise Exception.Create('LMD HTML engine error - the text is not valid HTML'); //removed [VB] Mar 2009 (since release 9.06)
          end;
      end;
    end;
  FData := FSaveData;
end; { PrepareToData }

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.MouseMoveTransfer(Shift: TShiftState; X, Y: Integer; R: TRect);
var
  Item: TLMDHTMLItem;
begin
  if FData = nil then
    exit;
  Item := Self.FindItemAt(Point(X, Y), Point(0, 0), R);
  if Assigned(Item) and (Item is TLMDHTMLInputItem) then
    FData.ActiveItem := (Item as TLMDHTMLInputItem)
  else
    FData.ActiveItem := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.KeyDownTransfer(var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_TAB:
      begin
        if Shift = [] then
          SelectNextSuitableItem
        else
          if Shift = [ssShift] then
            SelectPrevSuitableItem;
        Change;
      end;
  else
    if Assigned(FData) and Assigned(FData.FSelectedItem) and (FData.FSelectedItem is TLMDHTMLInputItem) then
      (FData.FSelectedItem as TLMDHTMLInputItem).KeyDownTransfer(Key, Shift);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.ClickTransfer(X, Y: Integer; R: TRect);
var
  Item: TLMDHTMLItem;
begin
  if FData = nil then
    exit;
  Item := Self.FindItemAt(Point(X, Y), Point(0, 0), R);
  FData.FSelectedItem := nil;
  if Assigned(Item) then
  begin
    if (Item is TLMDHTMLInputItem) then
    begin
      FData.FSelectedItem := Item;
      (Item as TLMDHTMLInputItem).Click;
    end
    else
      if (FLinkSelect and Item.IsLink) then
        FData.FSelectedItem := Item;
    Change;
  end;
end;{ ---------------------------------------------------------------------------- }

function TLMDHTMLRender.IsCursorOverLink(Point: TPoint; SrcPoint: TPoint; R:
  TRect; var href: TLMDString): Boolean;
var
  Item: TLMDHTMLItem;
begin
  href := '';
  Item := Self.FindItemAt(Point, SrcPoint, R);
  if Assigned(Item) then
    begin
      Result := Item.IsLink;
      if Result then
        href := Item.FLinkRef;
    end
  else
    Result := false;
end; { IsCursorOverLink }

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.TriggerVariableNeededEvent(aName: TLMDString; var aValue: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aName, aValue);
end; { TriggerVariableNeededEvent }

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.TriggerAdjustControlPositionEvent(aControl: TControl; aData: Pointer; var X: integer; var Y: integer);
begin
  if Assigned(FOnAdjustControlPosition) then
    FOnAdjustControlPosition(Self, aControl, aData, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.TriggerControlVisibilityNeededEvent(aControl: TControl; aData: Pointer; var aVisible: boolean);
begin
  if Assigned(FOnSetControlVisibility) then
    FOnSetControlVisibility(Self, aControl, aData, aVisible);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.TriggerControlCreated(aControl: TControl);
begin
  if Assigned(FOnControlCreated) then
    FOnControlCreated(Self, aControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.TriggerImageNeededEvent(Src: TLMDString; Image: TPicture);
var
  Bmp: TBitmap;

  procedure DoOnImageNeededEx;
  begin
    if (Assigned(FOnImageNeededEx)) then
      try
        FOnImageNeededEx(Self, TLMDString(Src), Image);
      except
      end;
  end;

begin
  if Assigned(FOnImageNeeded) then
    begin
      Bmp := nil;
      FOnImageNeeded(Self, Src, Bmp);
      if Assigned(Bmp) then
        Image.Bitmap.Assign(Bmp)
      else
        DoOnImageNeededEx;
    end
  else
    DoOnImageNeededEx;
end; { TriggerImageNeededEvent }

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.BeforeHook(Sender: TObject; var Message: TMessage;
  var Handled: boolean);
var
  LMsg1: TWMMouse;
  begin
  Handled := false;
  if FData = nil then
    exit;
  case Message.Msg of
    WM_MOUSEMOVE:
      begin
        LMsg1 := TWMMouse(Message);
        MouseMoveTransfer(KeysToShiftState(LMsg1.Keys), LMsg1.XPos, LMsg1.YPos, FData.Rect);
      end;
    WM_KEYDOWN:
      begin
        KeyDownTransfer(TWMKey(Message).CharCode, KeyDataToShiftState(TWMKey(Message).KeyData));
        end;
    WM_LBUTTONUP:
      begin
        LMsg1 := TWMMouse(Message);
        ClickTransfer(LMsg1.XPos, LMsg1.YPos, FData.Rect);
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.TriggerImageNeededEvent(Src: TLMDString; var Image: Graphics.TBitmap);
begin
  Image := nil;
  if Assigned(FOnImageNeeded) then
    try
      FOnImageNeeded(Self, Src, Image);
    except
    end;
end; { TriggerImageNeededEvent }
{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.TriggerInputItemChecked(
  InputItem: TLMDHTMLInputItem);
begin
  if Assigned(FOnInputItemChecked) then
    FOnInputItemChecked(Self, InputItem);
  Change;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.TriggerInputItemTextChanged(
  InputItem: TLMDHTMLInputItem);
begin
  if Assigned(FOnInputItemTextChanged) then
    FOnInputItemTextChanged(Self, InputItem);
  Change;
end;
{ ---------------------------------------------------------------------------- }

function TLMDHTMLRender.GetTextSize: TSize;
var
  i: integer;
  Item: TLMDHTMLItem;
begin
  Result.cx := 0;
  Result.cy := 0;
  if FData = nil then
    exit;
  for i := 0 to Pred(FData.FArray.Count) do
    begin
      Item := TLMDHTMLItem(FData.FArray[i + 1]);
      if (Item is TLMDHTMLBreakItem) then
        begin
          Result.cx := Max(Result.cx, Item.FWidth);
          Result.cy := Result.cy + Item.FHeight + FData.LineGap;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.CalcTokenSizes(FCurData: TLMDHTMLData);
var
  i, j, cury: integer;

  function ProcessBlock(StartI: integer; var StartY: integer): integer;
  var
    Item: TLMDHTMLItem;
    {
     TxtH,
     CurX,
     CurY,
    }
    cbl,
      mbl,
      curW,
      curH: integer;
  begin
    result := StartI;
    CurW := 0;
    CurH := 0;
    mbl := 0;
    //TxtH := 0;
    Item := TLMDHTMLItem(FCurData.FArray[StartI + 1]);
    Assert(Item <> nil);
    repeat
      Item.FWidth := Item.GetWidth;
      inc(CurW, Item.FWidth);
      Item.FHeight := Item.GetHeight(cbl);
      if (Item.ItemType = hitIndent) and ((Item.FBoolState and flAbsInd) =
        flAbsInd) then
        CurW := Item.FWidth;
      if Item.ItemType = hitChar then
        if Item.IsSub then
          begin
            inc(cbl, Item.FHeight div 4);
            inc(Item.FHeight, Item.FHeight div 4);
          end
        else
          if Item.IsSuper then
            begin
              dec(cbl, Item.FHeight div 2);
              inc(Item.FHeight, Item.FHeight * 2 div 3);
            end;
      mbl := max(mbl, cbl);
      CurH := Max(CurH, Item.FHeight);
      {
      if Item.TexType = hitChar then
         TxtH := Max(TxtH, Item.FHeight);
      }
      inc(result);
      if result = FCurData.FArray.Count then
        break;
      Item := TLMDHTMLItem(FCurData.FArray[result + 1]);
    until (Item is TLMDHTMLBreakItem);
    Item := TLMDHTMLItem(FCurData.FArray[StartI + 1]);
    Item.FHeight := CurH;
    Item.FWidth := CurW + TLMDHTMLBreakItem(Item).FIndent;
    TLMDHTMLBreakItem(Item).FParams := (mbl shl 16) or
      (TLMDHTMLBreakItem(Item).FParams and $0000FFFF);
    StartY := StartY + CurH;
  end;

begin
  i := 0;
  cury := 0;
  j := FCurData.FArray.Count - 1;
  while i <= j do
    i := ProcessBlock(i, CurY);
  FCurData.FTextSize := GetTextSize;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.SelectLinkAt(Point: TPoint; SrcPoint: TPoint; R:
  TRect);
var
  Item: TLMDHTMLItem;
begin
  if FData = nil then
    exit;
  Item := FindItemAt(Point, SrcPoint, R);
  FData.FSelectedItem := Item;
end; { HighlightItemAt }

{ ---------------------------------------------------------------------------- }

function TLMDHTMLRender.FindItemAt;
var
  i, j,
    k,
    LCurX,
    LCurY: integer;
  Lfx,
    LRH: integer;
  LBreakItem,
    LItem: TLMDHTMLItem;
begin
  result := nil;
  if FData = nil then
    exit;
  if R.Right = R.Left then
    R := FData.Rect;
  j := FData.FArray.Count - 1;
  LCurX := 0;
  LCurY := 0;
  for i := 0 to j do
  begin
    LItem := TLMDHTMLItem(FData.FArray[i + 1]);
    if (LItem is TLMDHTMLBreakItem) then
    begin
      LBreakItem := LItem;
      if LCurY + LItem.FHeight > Point.Y + SrcPoint.Y then
      begin
        case LoWord(TLMDHTMLBreakItem(LItem).FParams) of
          DT_LEFT:
            LCurX := LBreakItem.FIndent;
          DT_RIGHT:
            LCurX := Max(R.Right - R.Left, LBreakItem.FWidth) -
              LItem.FWidth - 1;
          DT_CENTER:
            LCurX := (Max(R.Right - R.Left, LBreakItem.FWidth) -
              LItem.FWidth - 1) div 2;
        end;
        k := i + 1;
        if k <= j then
        begin
          LItem := TLMDHTMLItem(FData.FArray[k + 1]);
          while (not (LItem is TLMDHTMLBreakItem)) and (k <= j) do
          begin
            if LItem.IsSub or LItem.IsSuper then
              LRH := LItem.GetHeight(LFx)
            else
              LRH := LItem.FHeight;
            LFx := 0;
            if LItem.IsSuper then
              LFx := LRH div 2;
            if (LCurX + LItem.FWidth >= Point.X + SrcPoint.X) and
              (LCurX <= Point.X + SrcPoint.X) and
              (Point.Y + SrcPoint.Y >= LCurY + LBreakItem.FHeight - LRH
                - LFx) and
              (Point.Y + SrcPoint.Y <= LCurY + LBreakItem.FHeight -
                LFx) then
            begin
              result := LItem;
              exit;
            end;
            Inc(LCurX, LItem.FWidth);
            inc(k);
            if k <= j then
              LItem := TLMDHTMLItem(FData.FArray[k + 1]);
          end;
        end;
        exit;
      end;
      inc(LCurY, LItem.FHeight);
    end;
  end;
end; { FindItemAt }

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.SelectPrevLink;
var
  LItem: TLMDHTMLItem;
  i: integer;
begin
  if FData = nil then
    exit;
  i := FData.FArray.IndexOf(FData.FSelectedItem) - 1;
  while i >= 0 do
    begin
      LItem := TLMDHTMLItem(FData.FArray[i + 1]);
      if LItem.IsLink then
        begin
          FData.FSelectedItem := LItem;
          break;
        end;
      dec(i);
    end;
end; { SelectPrevLink }

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.SelectNextLink;
var
  Item: TLMDHTMLItem;
  i: integer;
begin
  if FData = nil then
    exit;
  for i := Succ(FData.FArray.IndexOf(FData.FSelectedItem)) to
    Pred(FData.FArray.Count) do
    begin
      Item := TLMDHTMLItem(FData.FArray[i + 1]);
      if Item.IsLink then
        begin
          FData.FSelectedItem := Item;
          break;
        end;
    end;
end; { SelectNextLink }
{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.SelectPrevSuitableItem;
var
  i: integer;
begin
  if (FData = nil) or (FData.FControlsArray.Count = 0) then
    exit;
  i := FData.FControlsArray.IndexOf(FData.FSelectedItem) - 1;
  if i < 0 then
    i := FData.FControlsArray.Count - 1;
  FData.SelectedItem := TLMDHTMLItem(FData.FControlsArray[i]);
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.SelectNextSuitableItem;
var
  i: integer;
begin
  if (FData = nil) or (FData.FControlsArray.Count = 0) then
    exit;
  i := FData.FControlsArray.IndexOf(FData.FSelectedItem);
  inc(i);
  if i = FData.FControlsArray.Count then
    i := 0;
  FData.SelectedItem := TLMDHTMLItem(FData.FControlsArray[i + 1]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLRender.FindInputItemByName(AName: TLMDString;
  const FindFrom: TLMDHTMLItem): TLMDHTMLInputItem;
var
  i, j: integer;
  LItem: TLMDHTMLItem;
begin
  Result := nil;
  if FData = nil then
    exit;
  i := -1;
  if Assigned(FindFrom) then
    i := FData.FControlsArray.IndexOf(FindFrom);
  inc(i);
  for j := i to Pred(FData.FControlsArray.Count) do
  begin
    LItem := TLMDHTMLItem(FData.FControlsArray[i]);
    if (LItem is TLMDHTMLInputItem) and ((LItem as TLMDHTMLInputItem).Name = AName) then
    begin
      Result := (LItem as TLMDHTMLInputItem);
      Break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.SetDC(DC: HDC);
begin
  if DC <> 0 then
    begin
      SelectObject(FCanvas.Handle, FSaveObj);

      FCanvas.Handle := CreateCompatibleDC(DC);
      FBitmap.Handle := CreateCompatibleBitmap(DC, 1, 1);
      FSaveObj := SelectObject(FCanvas.Handle, FBitmap.Handle);
    end;
end;

{ ------------------------- public ------------------------------------------- }

function TLMDHTMLRender.AsText: TLMDString;
var
  i: integer;
begin
  result := '';
  for i := 0 to FData.FArray.Count - 1 do
    begin
      case TLMDHTMLItem(FData.FArray[i + 1]).ItemType of
        hitChar: result := result + TLMDHTMLItem(FData.FArray[i + 1]).Text;
        hitSoftBreak:
          begin
          end;
        hitBreak: result := result + LMDCRLF;
        hitPara:
          begin
            if i > 0 then
              begin
                result := result + LMDCRLF + LMDCRLF;
              end;
          end;
        hitLI: result := result + '- ';
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDHTMLRender.Create;
var
  LDC: HDC;
begin
  inherited;
  FHook := TLMDHookComponent.Create(nil);
  FHook.OnBeforeProcess := BeforeHook;

  FData := TLMDHTMLData.Create;
  FData.FRender := Self;
  FIntData := FData;

  FDoubleBuffered := true;
  FBitmap := TBitmap.Create;
  FCanvas := TCanvas.Create;
  //Canvas.Handle := QPainter_Create(Bitmap.Handle);

  LDC := GetDC(Application.Handle);
  FCanvas.Handle := CreateCompatibleDC(LDC);
  // Bitmap.Handle := CreateCompatibleBitmap(ADC, 1, 1);
  FSaveObj := SelectObject(FCanvas.Handle, FBitmap.Handle);
  ReleaseDC(Application.Handle, LDC);
  FLinkSelect := false;
end; { Create }

{ ---------------------------------------------------------------------------- }

function TLMDHTMLRender.CreateData: TLMDHTMLData;
begin
  Result := TLMDHTMLData.Create;
  result.FRender := Self;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDHTMLRender.Destroy;
var
  LDC: HDC;
begin
  FHook.Free;
  LDC := FCanvas.Handle;
  SelectObject(LDC, FSaveObj);
  FCanvas.Free;
  DeleteDC(LDC);
  FBitmap.Free;
  FIntData.Free;
  inherited;
end; { Destroy }

{ ---------------------------------------------------------------------------- }
function TLMDHTMLRender.GetControl: TControl;
begin
  Result := FHook.Control;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLRender.SetControl(const Value: TControl);
begin
 FHook.Active := False;
 FHook.Control := Value;
 if Assigned(Value) then
   FHook.Active := True;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.DestroyData(Data: TLMDHTMLData);
begin
  Data.Free;
  if Data = FData then
    FData := nil;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.DrawText(Canvas: TCanvas; SrcPoint: TPoint; R: TRect;
  AdjustFromColor: TColor);
begin
  DrawTextEx(Canvas, SrcPoint, R, false, 0, 0, 0, 0, AdjustFromColor);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDHTMLRender.DrawTextEx(ACanvas: TCanvas; ASrcPoint: TPoint; AR:
  TRect; UseOverColors: boolean; AColor, ABkColor, ASelColor, ASelBkColor: TColor;
  AAdjustFromColor: TColor);
var
  i, j,
  LLeft, LTop,
  LCurX,
  LCurY: integer;
  LRealX,
  LRealY: integer;
  LBreakItem: TLMDHTMLBreakItem;
  LItem: TLMDHTMLItem;
  LInputItem: TLMDHTMLInputItem;
  LControlItem: TLMDHTMLControlItem;
  LImg: TPicture;
  LR1: TRect;
  c: TColor;
  fx: integer;
  LOrgX,
  LOrgY: integer;
  LCanvas: TCanvas;
  LSavedAlign: Cardinal;
  LOldColor: TColor;
  LColor: TColor;
  LText: TLMDString;
  LControlVisible: boolean;
begin
  if FData = nil then
    exit;

  if DoubleBuffered then
    begin
      // prepare a temp canvas for painting
      FBitmap.Height := AR.Bottom - AR.Top + 1;
      FBitmap.Width := AR.Right - AR.Left + 1;
      // Bitmap.Canvas.Brush.Color := clWhite;
      // Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.FWidth, Bitmap.Height));
      bitblt(FBitmap.Canvas.Handle, 0, 0, FBitmap.Width, FBitmap.Height,
        ACanvas.Handle, AR.Left, AR.Top, SRCCOPY);
      LOrgX := 0;
      LOrgY := 0;
      LCanvas := FBitmap.Canvas;
      LCanvas.Brush.Color := ACanvas.Brush.Color;
    end
  else
    begin
      LCanvas := ACanvas;
      // SDC := saveDC(Canvas.Handle);
      LOrgX := AR.Left;
      LOrgY := AR.Top;
      //SetWindowOrgEx(LCanvas.Handle, -OrgX, -OrgY, @OldP);
    end;
  LOldColor := LCanvas.Brush.Color;

  LCurX := 0;
  LCurY := 0;
  LBreakItem := nil;
  j := FData.FArray.Count - 1;
  LSavedAlign := GetTextAlign(LCanvas.Handle);
  SetTextAlign(LCanvas.Handle, TA_BASELINE or TA_LEFT or TA_NOUPDATECP);
  //bladj := 0;
  LCanvas.Font.Charset := FData.Charset;

  FData.Rect := AR;
  for i := 0 to j do
    begin
      LItem := TLMDHTMLItem(FData.FArray[i + 1]);
      if LItem is TLMDHTMLBreakItem then
        begin
          if LBreakItem <> nil then
            LCurY := LCurY + LBreakItem.FHeight
          else
            LBreakItem := TLMDHTMLBreakItem(LItem);
          if LCurY > (AR.Bottom - AR.Top + 1) + ASrcPoint.Y then
            break;

          case LoWord(TLMDHTMLBreakItem(LItem).FParams) of
            DT_LEFT:
              LCurX := TLMDHTMLBreakItem(LItem).FIndent;
            DT_RIGHT:
              LCurX := Max(LBreakItem.FWidth, (AR.Right - AR.Left + 1)) -
                LItem.FWidth - 1;
            DT_CENTER:
              LCurX := (Max(LBreakItem.FWidth, (AR.Right - AR.Left + 1)) - 1 -
                LItem.FWidth) div 2;
          end;

          LBreakItem := TLMDHTMLBreakItem(LItem);

          if LItem.ItemType = hitLI then
            begin
              LR1.Left := LCurX - ASrcPoint.x - LItem.GetWidth - 1;
              LR1.Right := LCurX - ASrcPoint.x - 1;
              LR1.Top := LCurY - ASrcPoint.Y + (LBreakItem.FHeight -
                LBreakItem.FParams shr 16 - (LR1.Right - LR1.Left)) div 2
                + LBreakItem.FParams shr 16;
              LR1.Bottom := LR1.Top + (LR1.Right - LR1.Left);

              if UseOverColors and (LItem.FFntCnt = 0) then
                c := AColor
              else
                c := LItem.FontColor;

              if TLMDHTMLBreakItem(LItem).FListItemN > 0 then
                begin
                  LCanvas.Font.Color := LItem.FontColor;
                  LCanvas.Brush.Color := LOldColor;
                end
              else
                LCanvas.Brush.Color := c;

              OffsetRect(LR1, LOrgX, LOrgY);
              with LR1 do
                if TLMDHTMLBreakItem(LItem).FListItemN > 0 then
                  begin
                    LRealX := LCurX - ASrcPoint.x;
                    LRealY := LCurY - ASrcPoint.Y;
                    if LItem.IsSuper then
                      LRealY := LRealY - LItem.GetHeight(fx) div 2
                    else
                      if LItem.IsSub then
                        LRealY := LRealY + LItem.GetHeight(fx) div 4;

                    LCanvas.TextOut(LOrgX + LRealX,
                      LOrgY + LRealY + LBreakItem.FHeight -
                      HIWORD(LBreakItem.FParams),
                        IntToStr(TLMDHTMLBreakItem(LItem).FListItemN) + '.');

                    Inc(LCurX,
                      LCanvas.TextWidth(IntToStr(TLMDHTMLBreakItem(LItem).FListItemN) + '.'));
                  end
                else
                  LCanvas.Ellipse(Left - BulletMargin, Top, Right -
                    BulletMargin, Bottom);
            end;

          if LCurY + LBreakItem.FHeight < ASrcPoint.Y then
            Continue;
        end
      else
        begin
          if LItem.ItemType in [hitChar, hitVar] then
            begin
              with LCanvas do
                begin
                  if (FData.FSelectedItem = LItem) then
                    begin
                      if UseOverColors then
                        c := ASelBkColor
                      else
                        c := FData.FHighlightBgColor;
                      if c = clNone then
                        Brush.Style := bsClear
                      else
                        Brush.Color := c;
                    end
                  else
                    begin
                      if UseOverColors and (LItem.FFntCnt = 0) then
                        c := ABkColor
                      else
                        c := LItem.FontBgColor;
                      begin
                        if c = clNone then
                          Brush.Style := bsClear
                        else
                          Brush.Color := c;
                      end;
                    end;
                  if LItem = FData.FSelectedItem then
                    begin
                      if UseOverColors then
                        c := ASelColor
                      else
                        c := FData.FHighlightColor;

                      if AAdjustFromColor <> clNone then
                        Font.Color := AdjustColor(c, AAdjustFromColor)
                      else
                        Font.Color := c;

                      Font.Style := LItem.FontStyle;
                    end
                  else
                    begin
                      if UseOverColors and (LItem.FFntCnt = 0) then
                        begin
                          if AAdjustFromColor <> clNone then
                            Font.Color := AdjustColor(AColor, AAdjustFromColor)
                          else
                            Font.Color := AColor;
                        end
                      else
                        begin
                          if AAdjustFromColor <> clNone then
                            Font.Color := AdjustColor(LItem.FontColor,
                              AAdjustFromColor)
                          else
                            Font.Color := LItem.FontColor;
                        end;
                      Font.Style := LItem.FontStyle;


                      if LItem.IsLink then
                      begin
                        Font.Style := FData.FLinkStyle;
                        if LItem.FontColor = clNone then
                          LColor := FData.FLinkColor
                        else
                          LColor := LItem.FontColor;
// seems that current <font ... color ...> have to be ignored
//                        if LItem.FFntCnt > 0 then
//                          LColor := LItem.FontColor + LColor;
                        if AAdjustFromColor <> clNone then
                          Font.Color := AdjustColor(LColor, AAdjustFromColor)
                        else
                          Font.Color := LColor;
                      end;
                    end;
                  Font.Name := LItem.FFontRef;
                  if LItem.IsSub or LItem.IsSuper then
                    Font.Height := LItem.FontHeight - 2 *
                      LMDSign(LItem.FontHeight)
                  else
                    Font.Height := LItem.FontHeight;

                  LRealX := LCurX - ASrcPoint.X;
                  LRealY := LCurY - ASrcPoint.Y;
                  if LItem.IsSuper then
                    LRealY := LRealY - LItem.GetHeight(fx) div 2
                  else
                    if LItem.IsSub then
                      LRealY := LRealY + LItem.GetHeight(fx) div 4;

                  LText := LItem.Text;
                  if (LCurX = 0) then
                    while (Length(LText)>0) and (LText[1] = ' ') do Delete(LText, 1, 1);

{$IFDEF LMD_UNICODE}
                  Windows.TextOutW(LCanvas.Handle,
                    LOrgX + LRealX,
                    LOrgY + LRealY + LBreakItem.FHeight -
                    HIWORD(LBreakItem.FParams),
                    PWideChar(LText)
                    ,
                    Length(LText));
{$ELSE}
                  Windows.TextOut(LCanvas.Handle,
                    LOrgX + LRealX,
                    LOrgY + LRealY + LBreakItem.FHeight -
                    HIWORD(LBreakItem.FParams),
                    PAnsiChar(AnsiString(LText))
                    ,
                    Length(LText));
{$ENDIF}
                end;
              inc(LCurX, LItem.FWidth);
            end
          else
            if LItem.ItemType = hitIndent then
              begin
                if (LItem.FBoolState and flAbsInd) = 0 then
                  inc(LCurX, LItem.FWidth)
                else
                  LCurX := LItem.FWidth;
              end
            else
              if LItem.ItemType = hitBitmap then
                begin
                  LImg := TPicture.Create;
                  try
                    TriggerImageNeededEvent(LItem.Text, LImg);
                    if (LImg.Graphic <> nil) then
                      if (LImg.Graphic is TBitmap) and LItem.Transparent then
                         LMDDrawTransparentBitmapEx(LCanvas.Handle, LImg.Bitmap,
                                                      LOrgX + LCurX - ASrcPoint.X,
                                                      LOrgY + LCurY - ASrcPoint.Y + FData.LineGap,
                                                      Rect(0, 0, LItem.FWidth, LItem.FHeight - FData.LineGap),
                                                      LImg.Bitmap.Canvas.Pixels[0, LImg.Bitmap.Height - 1])
                       else
                         LCanvas.StretchDraw(Rect(LCurX - ASrcPoint.x,
                            LCurY + LBreakItem.FHeight - LItem.FHeight - ASrcPoint.y + FData.LineGap,
                            LCurX - ASrcPoint.x + LItem.FWidth, LCurY + LBreakItem.FHeight - ASrcPoint.y
                               + FData.LineGap{+ LItem.FHeight}), LImg.Graphic);
                  finally
                    LImg.Free;
                  end;
                  inc(LCurX, LItem.FWidth + 1);
                end
              else
                if LItem.ItemType = hitHR then
                  begin
                    if LItem.FWidth = 0 then
                      LR1 := Rect(LCurX - ASrcPoint.X, LCurY + LBreakItem.FHeight
                        div 2 - ASrcPoint.Y, Max(LBreakItem.FWidth, (AR.Right -
                        AR.Left + 1)), LCurY + LBreakItem.FHeight div 2 + 2 -
                        ASrcPoint.Y)
                    else
                      LR1 := Rect(LCurX - ASrcPoint.X, LCurY + LBreakItem.FHeight
                        div 2 - ASrcPoint.Y, LCurX - ASrcPoint.X + LItem.FWidth,
                        LCurY + LBreakItem.FHeight div 2 + 2 - ASrcPoint.Y);

                    OffsetRect(LR1, LOrgX, LOrgY);
                    LMDDrawFrame3D(LCanvas, LR1, bvRaised, clBtnShadow, clBtnFace, 1);
                  end
                  else
                    if LItem.ItemType = hitInput then
                    begin
                      LInputItem := TLMDHTMLInputItem(LItem);
                      LR1 := Rect(LCurX - ASrcPoint.x,
                            LCurY + LBreakItem.FHeight - LItem.FHeight - ASrcPoint.y + FData.LineGap,
                            LCurX - ASrcPoint.x + LItem.FWidth, LCurY - ASrcPoint.y + LItem.FHeight);
                      if Assigned(LInputItem.FControlPainter) then
                        LInputItem.FControlPainter.PaintTo(LCanvas, LR1);
                      LCurX := LCurX + LItem.FWidth;
                    end
                    else
                      if LItem.ItemType = hitControl then
                      begin
                        LControlItem := TLMDHTMLControlItem(LItem);
                        LR1 := Rect(LCurX - ASrcPoint.x,
                              LCurY + LBreakItem.FHeight - LItem.FHeight - ASrcPoint.y + FData.LineGap,
                              LCurX - ASrcPoint.x + LItem.FWidth, LCurY - ASrcPoint.y + LItem.FHeight);
                        if Assigned(LControlItem.FControl){ and (not LControlItem.FControl.Visible)} then
                        begin
                          LLeft := 0;
                          LTop := 0;
                          TriggerAdjustControlPositionEvent(LControlItem.FControl, Data.AuxData, LLeft, LTop);
                          if LControlItem.FControl.Owner is TWinControl then
                          begin
                            LControlItem.FControl.Parent := (LControlItem.FControl.Owner as TWinControl);
                            LControlItem.FControl.Left := LLeft + LR1.Left + Data.HOffset;
                            LControlItem.FControl.Top := LTop +LR1.Top + Data.VOffset;
                          end
                          else
                            if Assigned(LItem.FOwner.FRender.Control.Parent) then
                            begin
                              LControlItem.FControl.Parent := LItem.FOwner.FRender.Control.Parent;
                              LControlItem.FControl.Left := LLeft + LR1.Left + LItem.FOwner.FRender.Control.Left;
                              LControlItem.FControl.Top := LTop + LR1.Top + LItem.FOwner.FRender.Control.Top;
                            end;
                          LControlVisible := true;
                          TriggerControlVisibilityNeededEvent(LControlItem.FControl, Data.AuxData, LControlVisible);
                          LControlItem.FControl.Visible := LControlVisible;
                        end;
                        LCurX := LCurX + LItem.FWidth;
                      end;
        end;
    end;
  if DoubleBuffered then
    bitblt(ACanvas.Handle, AR.Left, AR.Top, FBitmap.Width, FBitmap.Height,
      LCanvas.Handle, 0, 0, SRCCOPY);
  SetTextAlign(LCanvas.Handle, LSavedAlign);
end; { DrawTextEx }

{ ---------------------------------------------------------------------------- }
procedure InitHTMLRender;
begin
  HTMLRender := TLMDHTMLRender.Create;
end;
{ ---------------------------------------------------------------------------- }

function LMDHTMLDrawText(Canvas: TCanvas; szStr: string; ARect: TRect;
  uFlags: TOwnerDrawState; LineGap: integer; bCalcOnly: Boolean = False):
    Integer; overload;
begin
  if not Assigned(HTMLRender) then
    InitHTMLRender;
  with HTMLRender do
    begin
      Data.LineGap := LineGap;
      PrepareText(szStr, ARect.Right - ARect.Left, false);
      if not bCalcOnly then
        DrawText(Canvas, Point(0, 0), ARect, clNone);
    end;
  result := 0;
end;

{ ---------------------------------------------------------------------------- }

function LMDHTMLDrawText(Canvas: TCanvas; szStr: string; ARect: TRect;
  uFlags: TOwnerDrawState; bCalcOnly: Boolean = False): Integer; overload;
begin
  result := LMDHTMLDrawText(Canvas, szStr, aRect, uFlags, 0, bCalcOnly);
end;

{ ---------------------------------------------------------------------------- }

function LMDColorToRGB(aValue: TColor): string;
var
  ac: LongInt;
begin
  ac := ColorToRGB(aValue);
  result := IntToHex(GetRValue(ac), 2) + InttoHex(GetGValue(ac), 2) +
    InttoHex(GetBValue(ac), 2);
end;

{-----------------------------------------------------------------------------}
function SpecialCharsFunc(aText: string): TLMDChar;
const
  spCharsCount = 103;
  spChars: array[0..spCharsCount - 1] of
    record
    spChar: string;
    spRepl: TLMDChar;
  end =
   ((spChar: 'nbsp'; spRepl: ' '),
    (spChar: 'quot'; spRepl: '"'),
    (spChar: 'amp'; spRepl: '&'),
    (spChar: 'lt'; spRepl: '<'),
    (spChar: 'gt'; spRepl: '>'),
    (spChar: 'iexcl'; spRepl: #161),
    (spChar: 'cent'; spRepl: #162),
    (spChar: 'pound'; spRepl: #163),
    (spChar: 'curren'; spRepl: #164),
    (spChar: 'yen'; spRepl: #165),
    (spChar: 'brvbar'; spRepl: #166),
    (spChar: 'sect'; spRepl: #167),
    (spChar: 'uml'; spRepl: #168),
    (spChar: 'copy'; spRepl: #169),
    (spChar: 'ordf'; spRepl: #170),
    (spChar: 'laquo'; spRepl: #171),
    (spChar: 'not'; spRepl: #172),
    (spChar: 'shy'; spRepl: #173),
    (spChar: 'reg'; spRepl: #174),
    (spChar: 'macr'; spRepl: #175),
    (spChar: 'deg'; spRepl: #176),
    (spChar: 'plusmn'; spRepl: #177),
    (spChar: 'sup2'; spRepl: #178),
    (spChar: 'sup3'; spRepl: #179),
    (spChar: 'acute'; spRepl: #180),
    (spChar: 'micro'; spRepl: #181),
    (spChar: 'para'; spRepl: #182),
    (spChar: 'middot'; spRepl: #183),
    (spChar: 'cedil'; spRepl: #184),
    (spChar: 'sup1'; spRepl: #185),
    (spChar: 'ordm'; spRepl: #186),
    (spChar: 'raquo'; spRepl: #187),
    (spChar: 'frac14'; spRepl: #188),
    (spChar: 'frac12'; spRepl: #189),
    (spChar: 'frac34'; spRepl: #190),
    (spChar: 'iquest'; spRepl: #191),
    (spChar: 'Agrave'; spRepl: #192),
    (spChar: 'Aacute'; spRepl: #193),
    (spChar: 'Acirc'; spRepl: #194),
    (spChar: 'Atilde'; spRepl: #195),
    (spChar: 'Auml'; spRepl: #196),
    (spChar: 'Aring'; spRepl: #197),
    (spChar: 'AElig'; spRepl: #198),
    (spChar: 'Ccedil'; spRepl: #199),
    (spChar: 'Egrave'; spRepl: #200),
    (spChar: 'Eacute'; spRepl: #201),
    (spChar: 'Ecirc'; spRepl: #202),
    (spChar: 'Euml'; spRepl: #203),
    (spChar: 'Igrave'; spRepl: #204),
    (spChar: 'Iacute'; spRepl: #205),
    (spChar: 'Icirc'; spRepl: #206),
    (spChar: 'Iuml'; spRepl: #207),
    (spChar: 'ETH'; spRepl: #208),
    (spChar: 'Ntilde'; spRepl: #209),
    (spChar: 'Ograve'; spRepl: #210),
    (spChar: 'Oacute'; spRepl: #211),
    (spChar: 'Ocirc'; spRepl: #212),
    (spChar: 'Otilde'; spRepl: #213),
    (spChar: 'Ouml'; spRepl: #214),
    (spChar: 'times'; spRepl: #215),
    (spChar: 'Oslash'; spRepl: #216),
    (spChar: 'Ugrave'; spRepl: #217),
    (spChar: 'Uacute'; spRepl: #218),
    (spChar: 'Ucirc'; spRepl: #219),
    (spChar: 'Uuml'; spRepl: #220),
    (spChar: 'Yacute'; spRepl: #221),
    (spChar: 'THORN'; spRepl: #222),
    (spChar: 'szlig'; spRepl: #223),
    (spChar: 'agrave'; spRepl: #224),
    (spChar: 'aacute'; spRepl: #225),
    (spChar: 'acirc'; spRepl: #226),
    (spChar: 'atilde'; spRepl: #227),
    (spChar: 'auml'; spRepl: #228),
    (spChar: 'aring'; spRepl: #229),
    (spChar: 'aelig'; spRepl: #230),
    (spChar: 'ccedil'; spRepl: #231),
    (spChar: 'egrave'; spRepl: #232),
    (spChar: 'eacute'; spRepl: #233),
    (spChar: 'ecirc'; spRepl: #234),
    (spChar: 'euml'; spRepl: #235),
    (spChar: 'igrave'; spRepl: #236),
    (spChar: 'iacute'; spRepl: #237),
    (spChar: 'icirc'; spRepl: #238),
    (spChar: 'iuml'; spRepl: #239),
    (spChar: 'eth'; spRepl: #240),
    (spChar: 'ntilde'; spRepl: #241),
    (spChar: 'ograve'; spRepl: #242),
    (spChar: 'oacute'; spRepl: #243),
    (spChar: 'ocirc'; spRepl: #244),
    (spChar: 'otilde'; spRepl: #245),
    (spChar: 'ouml'; spRepl: #246),
    (spChar: 'divide'; spRepl: #247),
    (spChar: 'oslash'; spRepl: #248),
    (spChar: 'ugrave'; spRepl: #249),
    (spChar: 'uacute'; spRepl: #250),
  	(spChar: 'ucirc'; spRepl: #251),
  	(spChar: 'uuml'; spRepl: #252),
  	(spChar: 'yacute'; spRepl: #253),
  	(spChar: 'thorn'; spRepl: #254),
  	(spChar: 'yuml'; spRepl: #255),
    (spChar: 'trade'; spRepl: #$99),
    (spChar: 'euro'; spRepl: #0136),
    (spChar: 'tab'; spRepl: #9));
var
  i: integer;
begin
  result := #0;
  for i := 0 to spCharsCount - 1 do
    if aText = spChars[i].spChar then
      begin
        result := spChars[i].spRepl;
        break;
      end;
end;

var
  DC: HDC;

{ TLMDHTMLInputItem }

procedure TLMDHTMLInputItem.Assign(Source: TLMDHTMLItem);
begin
  inherited;
  if Source is TLMDHTMLInputItem then
    begin
      with TLMDHTMLInputItem(Source) do
      begin
        Self.FName := FName;
        Self.FChecked := FChecked;
        Self.InputType := FInputType;
        Self.FValue := FValue;
      end;
    end;
end;

procedure TLMDHTMLInputItem.ReCreateControlPainter;
begin
  if Assigned(FControlPainter) then
    FControlPainter.Free;
  case FInputType of
    itCheckBox : FControlPainter := TLMDHTMLCheckBoxPainter.Create(Self);
    itRadioButton : FControlPainter := TLMDHTMLCheckBoxPainter.Create(Self);
  else
    FControlPainter := nil;
  end;
end;

destructor TLMDHTMLInputItem.Destroy;
begin
  if Assigned(FControlPainter) then
    FControlPainter.free;
  inherited;
end;

procedure TLMDHTMLInputItem.SetInputType(Value: TLMDHTMLInputType);
begin
  if (FInputType <> Value) or (FControlPainter = nil) then
  begin
    FInputType := Value;
    ReCreateControlPainter;
    if (FInputType = itRadioButton) and (Length(FName) > 0) then
    begin
      FTag := FOwner.FRadioList.IndexOf(FName) + 1; // radiogroup
      if FTag = 0 then
      begin
        FOwner.FRadioList.Add(FName);
        FTag := FOwner.FRadioList.Count;
      end;
    end;
  end;
end;

procedure TLMDHTMLInputItem.ProcessAtributes(AList: TLMDMemoryStrings);
var
  s: TLMDString;
begin
  s := RemoveQuotes(AList.Values[TLMDString('checked')]);
  if Length(s) > 0 then
    FChecked := StrToBool(s);
  s := RemoveQuotes(AList.Values[TLMDString('value')]);
  if Length(s) > 0 then
    FValue := s;
  try
    s := RemoveQuotes(AList.Values[TLMDString('width')]);
    if Length(s) > 0 then
      FWidth := StrToInt(s);
    s := RemoveQuotes(AList.Values[TLMDString('height')]);
    if Length(s) > 0 then
      FHeight := StrToInt(s);
  except
  end;
end;

procedure TLMDHTMLInputItem.Click;
begin
  if (FInputType = itRadioButton) and (not FChecked) then
    Checked := True
  else
    Checked := not Checked;
  if (FInputType in [itCheckBox, itRadioButton]) then
    FOwner.FRender.Change;
end;

constructor TLMDHTMLInputItem.Create(Owner: TLMDHTMLData);
begin
  inherited;
//  InputType := itText - todo
end;

procedure TLMDHTMLInputItem.SetChecked(AValue: Boolean);
var
  i: integer;
begin
  if FChecked <> AValue then
  begin
    if (FInputType = itRadioButton) and (FTag > 0) and AValue then
    begin
      for i := 0 to FOwner.FControlsArray.Count - 1 do
      begin
        if TLMDHTMLItem(FOwner.FControlsArray[i + 1]).FTag = FTag then
          TLMDHTMLInputItem(FOwner.FControlsArray[i + 1]).FChecked := False;
      end;
    end;
    FChecked := AValue;
    if (FInputType in [itCheckBox, itRadioButton]) then
      FOwner.FRender.TriggerInputItemChecked(Self);
  end;
end;

procedure TLMDHTMLInputItem.SetValue(AValue: TLMDString);
begin
  if FValue <> AValue then
  begin
    FValue := AValue;
    FOwner.FRender.TriggerInputItemTextChanged(Self);
  end;
end;

procedure TLMDHTMLInputItem.KeyDownTransfer(var Key: Word;
  Shift: TShiftState);
begin
  if (FInputType = itCheckBox) then
  begin
    if Key = VK_SPACE then
      Checked := not Checked;
  end;
  if (FInputType = itRadioButton) then
  begin
    if Key = VK_SPACE then
      Checked := True;
  end;
end;

function TLMDHTMLInputItem.GenerateHTML: TLMDString;
begin
  case InputType of
    itCheckBox: Result := '<input type="checkbox" ';
    itRadioButton: Result := '<input type="radio" ';
  end;
  if Length(FName) > 0 then
    Result := Result + 'name="'+FName+'" ';
  if FChecked then
    Result := Result + 'checked="True" ';
  if Length(FValue) > 0 then
    Result := Result + 'value="'+FValue+'" ';
  Result := Result+'>';
end;

{ TLMDHTMLCheckBoxPainter }

procedure TLMDHTMLCheckBoxPainter.PaintTo(Canvas: TCanvas; const ARect: TRect);
var
  sid: Integer;
  Bitmap: TBitmap;
const
  LSidArr: array [Boolean, Boolean, Boolean] of TThemedButton = (
                 ((tbCheckBoxUncheckedNormal, tbCheckBoxUncheckedHot),
                  (tbCheckBoxCheckedNormal, tbCheckBoxCheckedHot)),
                 ((tbRadioButtonUncheckedNormal, tbRadioButtonUncheckedHot),
                  (tbRadioButtonCheckedNormal, tbRadioButtonCheckedHot)));
begin
  if LMDThemeServices.ThemesEnabled then
    begin
      LMDThemeServices.DrawElement(ttmPlatform, Canvas.Handle,
                                   LSidArr[FInputItem.FInputType = itRadioButton, FInputItem.Checked, (FInputItem = FInputItem.FOwner.FActiveItem)],
                                   ARect);
    end
  else
  begin
    if FInputItem.FInputType = itRadioButton then
      sid := DFCS_BUTTONRADIO
    else
      sid := DFCS_BUTTONCHECK;
    if FInputItem.Checked then
      sid := sid or DFCS_CHECKED;
    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := ARect.Right - ARect.Left;
      Bitmap.Height := ARect.Bottom - ARect.Top;
      DrawFrameControl(Bitmap.Canvas.Handle, Rect(0,0,Bitmap.Width,Bitmap.Height), DFC_BUTTON, sid);
      bitblt(Canvas.Handle, ARect.Left, ARect.Top, Bitmap.Width, Bitmap.Height, Bitmap.Canvas.Handle, 0,0, SRCCOPY);
    finally
      Bitmap.Free;
    end;
  end;
  if (FInputItem = FInputItem.FOwner.FSelectedItem) then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.DrawFocusRect(ARect);
  end;
end;

constructor TLMDHTMLControlPainter.Create(AInputItem: TLMDHTMLInputItem);
begin
  inherited Create;
  FInputItem := AInputItem;
end;

procedure TLMDHTMLControlPainter.PaintTo(Canvas: TCanvas;const ARect: TRect);
begin
//do nothing
end;

{ TLMDHTMLControlItem }

procedure TLMDHTMLControlItem.Assign(Source: TLMDHTMLItem);
begin
  inherited;
end;

procedure TLMDHTMLControlItem.BeforeHook(Sender: TObject;
  var Message: TMessage; var Handled: boolean);
begin
// todo
end;

constructor TLMDHTMLControlItem.Create(Owner: TLMDHTMLData);
begin
  inherited;
  FControl := nil;
  FControlPropList := TLMDMemoryStrings.Create;
  FControlHook := TLMDHookComponent.Create(nil);
  FControlHook.OnBeforeProcess := BeforeHook;
end;

destructor TLMDHTMLControlItem.Destroy;
begin
  FControlHook.Control := nil;
  FControlHook.Free;
  if Assigned(FControl) then
  begin
    if not FControl.Visible or Assigned(FControl.Parent) then
    begin
      FControlHook.Active := False;
      FControlHook.Control := nil;
      FreeAndNil(FControl);
    end;
  end;
  FControlPropList.Free;
  inherited;
end;

function TLMDHTMLControlItem.GenerateHTML: TLMDString;
var
  i, clr: integer;
  s : TLMDString;
  PropInfo: PPropInfo;
  LValue: string;
begin
  if Assigned(FControl) then
  begin
    Result := '<control vclclass="'+ FControl.ClassName+'" ';
    for i := 0 to FControlPropList.Count - 1  do
    begin
      s := RemoveQuotes(FControlPropList.Names[i]);
      PropInfo := TypInfo.GetPropInfo(FControl, s);
      if PropInfo <> nil then
      begin
        case PropInfo.PropType^.Kind of
          tkInteger, tkInt64 :
            begin
              clr := GetOrdProp(FControl, PropInfo);
              if ColorToIdent(clr, LValue) then
                Result := Result + s+'="'+LValue+'" '
              else
                Result := Result + s+'="'+IntToStr(clr)+'" '
            end;
          tkFloat : Result := Result + s + '="'+FloatToStr(GetFloatProp(FControl, PropInfo))+'" ';
          tkWString, tkWChar : Result := Result + s + '="'+GetWideStrProp(FControl, PropInfo)+'" ';
          tkEnumeration: Result := Result + s + '="'+ GetEnumProp(FControl, PropInfo)+'" ';
          tkSet: Result := Result + s + '="' + GetSetProp(FControl, PropInfo)+'" ';
        else ;
          Result := Result + s + '="'+GetWideStrProp(FControl, PropInfo)+'" ';
        end;
      end;
    end;
    Result := Result + '>';
  end;
end;

function TLMDHTMLControlItem.GetControl: TControl;
begin
  result := FControl;
end;

procedure TLMDHTMLControlItem.ProcessAtributes(AList: TLMDMemoryStrings);
var
  s: TLMDString;
  i, clr: integer;
  PropInfo: PPropInfo;
begin
  s := RemoveQuotes(AList.Values[TLMDString('vclclass')]);
  if Length(s) > 0 then
  begin
    if FControlClass <> s then
    begin
      if Assigned(FControl) then
      begin
        FControlHook.Active := False;
        FControlHook.Control := nil;
        FreeAndNil(FControl);
      end;
      FControlClass := s;
      if assigned(FOwner.FRender.Control) and assigned(GetClass(FControlClass)) then
      begin
        FControl := TControlClass(GetClass(FControlClass)).Create(FOwner.FRender.Control);
        FControl.Left := 0;
        FControl.Top := 0;
        FControl.Visible := False;
        if Assigned(FOwner.FRender.Control) then
        begin
          if FOwner.FRender.Control is TWinControl then
            FControl.Parent := TWinControl(FOwner.FRender.Control)
          else
            if Assigned(FOwner.FRender.Control.Parent) then
              FControl.Parent := FOwner.FRender.Control.Parent;
        end;
        FWidth := FControl.Width;
        FHeight := FControl.Height;
        FControlHook.Active := False;
        FControlHook.Control := FControl;
        FControlHook.Active := True;
      end;
    end;
    FControlPropList.Assign(AList);
    try
      s := RemoveQuotes(AList.Values[TLMDString('width')]);
      if Length(s) > 0 then
      begin
        FWidth := StrToInt(s);
        if Assigned(FControl) then
          FControl.Width := FWidth;
      end;
      s := RemoveQuotes(AList.Values[TLMDString('height')]);
      if Length(s) > 0 then
      begin
        FHeight := StrToInt(s);
        if Assigned(FControl) then
          FControl.Width := FWidth;
      end;
    except
    end;
    for i := 0 to AList.Count - 1  do
    begin
      s := RemoveQuotes(AList.Names[i]);
      PropInfo := TypInfo.GetPropInfo(FControl, s);
      s := RemoveQuotes(AList.Values[s]);
      if PropInfo <> nil then
      begin
        try
          case PropInfo.PropType^.Kind of
            tkInteger, tkInt64 :
              begin
                if pos('cl', s) = 1 then // color
                begin
                  if IdentToColor(s, clr) then
                    SetOrdProp(FControl, PropInfo, clr);
                end
                else
                begin
                  if pos('#', s) = 1 then
                    s := Copy(s, 2, length(s) - 1);
                  SetOrdProp(FControl, PropInfo, StrToInt(s));
                end;
              end;
            tkFloat : SetFloatProp(FControl, PropInfo, StrToFloat(s));
            tkWString, tkWChar : SetWideStrProp(FControl, PropInfo, s);
            tkEnumeration: SetEnumProp(FControl, PropInfo, s);
            tkSet: SetSetProp(FControl, PropInfo, s);
          else
            SetStrProp(FControl, PropInfo, s);
          end;
        except
          Continue;
        end;
      end;
    end;
    if FControl is TWinControl then
    begin
      TWinControl(FControl).TabStop := False;
      if Assigned(FOwner) then
        if Assigned(TLMDHTMLData(FOwner).FRender) then
          TLMDHTMLData(FOwner).FRender.TriggerControlCreated(FControl);
    end;
  end;
end;

procedure TLMDHTMLRender.TriggerTagFound(var Tag: TLMDString;
  var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing, aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

initialization
  DC := GetDC(0);
  if DC <> 0 then
    begin
      ScreenPixelsPerInch := GetDeviceCaps(DC, LOGPIXELSY);
      ReleaseDC(0, DC);
    end
  else
    ScreenPixelsPerInch := 100;
  LMDHTMLTags := TStringList.Create;
  LMDHTMLTags.AddObject('sub', TObject(0));
  LMDHTMLTags.AddObject('/sub', TObject(0));
  LMDHTMLTags.AddObject('sup', TObject(1));
  LMDHTMLTags.AddObject('/sup', TObject(1));
  LMDHTMLTags.AddObject('b', TObject(2));
  LMDHTMLTags.AddObject('/b', TObject(2));
  LMDHTMLTags.AddObject('strong', TObject(2));
  LMDHTMLTags.AddObject('/strong', TObject(2));
  LMDHTMLTags.AddObject('big', TObject(2));
  LMDHTMLTags.AddObject('/big', TObject(2));
  LMDHTMLTags.AddObject('i', TObject(3));
  LMDHTMLTags.AddObject('/i', TObject(3));
  LMDHTMLTags.AddObject('em', TObject(3));
  LMDHTMLTags.AddObject('/em', TObject(3));
  LMDHTMLTags.AddObject('var', TObject(4));
  LMDHTMLTags.AddObject('/var', TObject(4));
  LMDHTMLTags.AddObject('cite', TObject(4));
  LMDHTMLTags.AddObject('/cite', TObject(4));
  LMDHTMLTags.AddObject('strikeout', TObject(5));
  LMDHTMLTags.AddObject('/strikeout', TObject(5));
  LMDHTMLTags.AddObject('s', TObject(5));
  LMDHTMLTags.AddObject('/s', TObject(5));
  LMDHTMLTags.AddObject('u', TObject(6));
  LMDHTMLTags.AddObject('/u', TObject(6));
  LMDHTMLTags.AddObject('ul', TObject(7));
  LMDHTMLTags.AddObject('/ul', TObject(8));
  LMDHTMLTags.AddObject('ol', TObject(9));
  LMDHTMLTags.AddObject('/ol', TObject(10));
  LMDHTMLTags.AddObject('li', TObject(11));
  LMDHTMLTags.AddObject('p', TObject(12));
  LMDHTMLTags.AddObject('/p', TObject(12));
  LMDHTMLTags.AddObject('br', TObject(13));
  LMDHTMLTags.AddObject('ind', TObject(14));
  LMDHTMLTags.AddObject('img', TObject(15));
  LMDHTMLTags.AddObject('a', TObject(16));
  LMDHTMLTags.AddObject('/a', TObject(17));
  LMDHTMLTags.AddObject('html', TObject(18));
  LMDHTMLTags.AddObject('hr', TObject(19));
  LMDHTMLTags.AddObject('/font', TObject(20));
  LMDHTMLTags.AddObject('font', TObject(21));
  LMDHTMLTags.AddObject('input', TObject(22));
  LMDHTMLTags.AddObject('control', TObject(23));
  LMDHTMLTags.AddObject(CVarTag, TObject(24));

  LMDInputCtrls := TStringList.Create;
  LMDInputCtrls.Add('checkbox=1');
  LMDInputCtrls.Add('radio=2');

  RegisterClasses([TEdit, TButton, TCheckBox, TRadioButton]);

finalization
  if HTMLRender <> nil then
    FreeAndNil(HTMLRender);
  if LMDHTMLTags <> nil then
    LMDHTMLTags.Free;
  if LMDInputCtrls <> nil then
    LMDInputCtrls.Free;
end.
