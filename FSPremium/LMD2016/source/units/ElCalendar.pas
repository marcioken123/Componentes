unit ElCalendar;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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

ElCalendar unit
---------------

Changes
-------
Release 6.0 (March 2007)
 - Initial Release

###############################################################################}

interface

uses
  LMDTypes, Classes, Windows, Messages, Graphics, Controls, StdCtrls, Forms, Buttons,
  Types, Grids, ImgList, Math, SysUtils, Themes,
  ElVCLUtils, ElStyleMan, ElImgFrm, LMDUtils, ElCalendarDefs, 
  LMDElConst, intfLMDBase,  LMDObjectList, LMDGraph,  LMDThemes,LMDClass, 
  LMDDateUtils, LMDProcs;

type

  TElCalendar = class(TCustomGrid, ILMDComponent)
  private
    FCustomCalendarNames: TElCustomCalendarNames;
    FAbout: TLMDAboutVar;
    FHolidayColor : TColor;
    FShowPeriods : Boolean;
    FPeriodStart : TDateTime;
    FPeriodLength : Word;
    FPeriodInterval : Word;
    FPeriodColor : TColor;
    FShowHolidays : Boolean;
    FHolidays : TElHolidays;
    FWeekEndColor : TColor;
    FWeekEndDays : TElWeekEndDays;
    FShowWeekNum : Boolean;
    FDate : TDateTime;
    FMonthOffset : Integer;
    FOnChange : TNotifyEvent;
    FReadOnly : Boolean;
    FStartOfWeek : TDayOfWeek;
    FUpdating : Boolean;
    FUserNavigation : boolean;
    FUseCurrentDate : Boolean;
    FTranslateDays : boolean;
    FTmpBmp : TBitmap;
    FImgFormChLink  : TImgFormChangeLink;
    FImgForm : TElImageForm;
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FMouseOver : boolean;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FFlat : boolean;
    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;
    FUseLineColors: Boolean;
    FBorderSides: TLMDBorderSides;
    FSelectionBorder: TElFlatBorderType;
    FDayCellBorder: TElFlatBorderType;
    FCurrentDayBorder: TElFlatBorderType;
    FCurrentDayBitmap: TBitmap;
    FCurrentDayUseBitmap: Boolean;
    FLastHit : TGridCoord;
    FWeekNumCellBorder: TElFlatBorderType;
    procedure NamesChanged(Sender: TObject);
    procedure SetActiveBorderType(newValue : TElFlatBorderType);
    procedure SetInactiveBorderType(newValue : TElFlatBorderType);
    function GetCellText(ACol, ARow : Integer) : TLMDString;//string;
    function GetDateElement(Index : Integer) : Integer;
    procedure SetCalendarDate(Value : TDateTime);
    procedure SetDateElement(Index : Integer; Value : Integer);
    procedure SetStartOfWeek(Value : TDayOfWeek);
    procedure SetUseCurrentDate(Value : Boolean);
    function StoreCalendarDate : Boolean;
    procedure SetShowWeekNum(newValue : Boolean);
    procedure SetWeekEndDays(newValue : TElWeekEndDays);
    procedure SetWeekEndColor(newValue : TColor);
    procedure CMHintShow(var Msg : TCMHintShow); message CM_HINTSHOW;
    procedure SetHolidays(newValue : TElHolidays);
    procedure FixHolidayDate(AHoliday : TElHoliday; var Date : TDateTime);
    procedure SetShowHolidays(newValue : Boolean);
    procedure SetShowPeriods(newValue : Boolean);
    procedure SetPeriodStart(newValue : TDateTime);
    procedure SetPeriodLength(newValue : Word);
    procedure SetPeriodInterval(newValue : Word);
    procedure SetPeriodColor(newValue : TColor);
    procedure SetHolidayColor(newValue : TColor);
    procedure SetDate(newValue : TDateTime);
    procedure SetFlat(newValue : Boolean);
    procedure SetTranslateDays(value : boolean);
    procedure SetStyleManager(Value: TElStyleManager); virtual;
    procedure SetStyleName(const Value: string); virtual;
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;

    procedure DrawFlatBorder;
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure WMNCPaint(var Msg : TWMNCPaint); message WM_NCPAINT;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure WMVScroll(var Msg : TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Msg : TWMHScroll); message WM_HSCROLL;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMSize(var Message : TWMSize); message WM_SIZE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGING;
    procedure IFMRepaintChildren(var Message: TMessage); message IFM_REPAINTCHILDREN;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

    function StoreDate: boolean;
    procedure SetLineColorLight(Value: TColor);
    procedure SetLineColorDark(Value: TColor);
    procedure SetUseLineColors(Value: Boolean);
    procedure SetSelectionBorder(Value: TElFlatBorderType);
    procedure SetDayCellBorder(Value: TElFlatBorderType);
    procedure SetCurrentDayBitmap(Value : TBitmap);
    procedure SetCurrentDayUseBitmap(Value : Boolean);
    procedure SetCurrentDayBorder(Value: TElFlatBorderType);
    procedure SetWeekNumCellBorder(Value: TElFlatBorderType);
    procedure SetCustomCalendarNames(const Value: TElCustomCalendarNames);
  protected
    FLineBorderColor : TColor;
    FLineColorLight: TColor;
    FLineColorDark: TColor;
    FUseSystemStartOfWeek: Boolean;
    FOnDetermineHoliday: TElHolidayEvent;
    FFocusedSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectColor: TColor;
    FHideSelection: Boolean;
    FHideSelectTextColor: TColor;
    FBackground: TBitmap;
    FBackgroundType: TLMDBackgroundType;
    FGradientEndColor: TColor;
    FGradientStartColor: TColor;
    FGradientSteps: Integer;
    FGridLineColor: TColor;
    FHighlightAlphaLevel: Integer;
    FDayNameColor: TColor;
    FWeekNumColor: TColor;
    FDayNameTextColor: TColor;
    FWeekNumTextColor: TColor;
    FOnBeforeCellDraw: TBeforeCellDrawEvent;
    FShowOtherMonthDays: Boolean;
    FOtherMonthDayColor: TColor;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;
  procedure SetAutoSize(Value: Boolean); override;
  procedure CalcSizes;virtual;
    procedure SetLineBorderColor(Value: TColor);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure SetImageForm(newValue : TElImageForm);
    procedure ImageFormChange(Sender : TObject);
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    {$endif}
    procedure Change; dynamic;
    procedure ChangeMonth(Delta : Integer);
    procedure Click; override;
    function DaysThisMonth : Integer; virtual;
    function IsLeapYear(AYear : Integer) : Boolean; virtual;
    function SelectCell(ACol, ARow : Longint) : Boolean; override;
    procedure Loaded; override;
    procedure UpdateFrame;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure SetUseSystemStartOfWeek(Value: Boolean);
    procedure TriggerDetermineHoliday(ADay, AMonth, AYear : word; var IsHoliday : boolean);
        virtual;
    procedure SetFocusedSelectColor(newValue: TColor);
    procedure SetFocusedSelectTextColor(newValue: TColor);
    procedure SetHideSelectColor(newValue: TColor);
    procedure SetHideSelection(Value: Boolean);
    procedure SetHideSelectTextColor(newValue: TColor);
    procedure SetBackground(newValue : TBitmap);
    procedure SetBackgroundType(newValue : TLMDBackgroundType);
    procedure SetGradientEndColor(newValue : TColor);
    procedure SetGradientStartColor(newValue : TColor);
    procedure SetGradientSteps(newValue : Integer);
    procedure RedoTmpBmp;
    procedure ImageChange(Sender : TObject);
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    procedure Paint; override;
    procedure SetGridLineColor(Value: TColor);
    procedure DrawBackground(Canvas : TCanvas);
    procedure DefineProperties(Filer : TFiler); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DrawCell(ACol, ARow : Longint; ARect : TRect; AState :TGridDrawState); override;
    procedure SetHighlightAlphaLevel(Value: Integer);
    procedure SetDayNameColor(Value: TColor);
    procedure SetWeekNumColor(Value: TColor);
    procedure SetDayNameTextColor(Value: TColor);
    procedure SetWeekNumTextColor(Value: TColor);
    function GetGridVertLines: Boolean;
    procedure SetGridVertLines(Value: Boolean);
    function GetGridHorzLines: Boolean;
    procedure SetGridHorzLines(Value: Boolean);
    procedure TriggerBeforeCellDraw(Canvas : TCanvas; RowNum, ColNum : integer; Date : TDateTime;
        CellType : TElCalendarCellTypes);
    function DaysPrevMonth: Integer; virtual;
    procedure SetShowOtherMonthDays(Value: Boolean);
    procedure SetOtherMonthDayColor(Value: TColor);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure NextMonth;
    procedure NextYear;
    procedure PrevMonth;
    procedure PrevYear;
    procedure UpdateCalendar; virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure MouseToCell(X, Y : Integer; var ACol, ARow : Longint);

    property CalendarDate : TDateTime read FDate write SetCalendarDate stored StoreCalendarDate;
    property CellText[ACol, ARow : Integer] : TLMDString read GetCellText;
    function IsHoliday(AYear, AMonth, ADay : integer) : Boolean;
    function IsInPeriod(AYear, AMonth, ADay : word) : Boolean;

    function IsRestHoliday(AYear, AMonth, ADay : word) : Boolean;
    function GetEffectiveHeight: Integer;
    function GetEffectiveWidth: Integer;
    function getLMDPackage:TLMDPackageID;
  published
    property CustomCalendarNames: TElCustomCalendarNames read FCustomCalendarNames write SetCustomCalendarNames;
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Flat : Boolean read FFlat write SetFlat; { Published }

    property Date : TDateTime read FDate write SetDate stored StoreDate;
    property Day : Integer index 3 read GetDateElement write SetDateElement stored False;
    property Holidays : TElHolidays read FHolidays write SetHolidays;
    property Month : Integer index 2 read GetDateElement write SetDateElement stored False;
    property ReadOnly : Boolean read FReadOnly write FReadOnly default False;

    property StartOfWeek : TDayOfWeek read FStartOfWeek write SetStartOfWeek default 0;
    property TranslateDays : boolean read FTranslateDays write SetTranslateDays default true;
    property UseCurrentDate : Boolean read FUseCurrentDate write SetUseCurrentDate default True;
    property Year : Integer index 1 read GetDateElement write SetDateElement stored False;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property ImageForm : TElImageForm read FImgForm write SetImageForm;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;

    property ShowWeekNum : Boolean read FShowWeekNum write SetShowWeekNum default False;
    property WeekEndDays : TElWeekEndDays read FWeekEndDays write SetWeekEndDays  default [Sat, Sun];
    property WeekEndColor : TColor read FWeekEndColor write SetWeekEndColor default clRed;
    property ShowHolidays : Boolean read FShowHolidays write SetShowHolidays default True;
    property ShowPeriods : Boolean read FShowPeriods write SetShowPeriods default False;
    property PeriodStart : TDateTime read FPeriodStart write SetPeriodStart;
    property PeriodLength : Word read FPeriodLength write SetPeriodLength default 1;
    property PeriodInterval : Word read FPeriodInterval write SetPeriodInterval default 28;
    property PeriodColor : TColor read FPeriodColor write SetPeriodColor default clAqua;
    property HolidayColor : TColor read FHolidayColor write SetHolidayColor default clWindowText;
    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;  { Published }
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;  { Published }
    property UserNavigation : boolean read FUserNavigation write FUserNavigation default False;
    property LineColorLight: TColor read FLineColorLight write SetLineColorLight
        stored FUseLineColors default clWindow;
    property LineColorDark: TColor read FLineColorDark write SetLineColorDark
        stored FUseLineColors default clBtnFace;
    property LineBorderColor: TColor read FLineBorderColor write SetLineBorderColor default clWindowText;
    property UseSystemStartOfWeek: Boolean read FUseSystemStartOfWeek write
        SetUseSystemStartOfWeek default True;
    property UseLineColors: Boolean read FUseLineColors write SetUseLineColors
        default false;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsTop, ebsRight, ebsBottom];
    property SelectionBorder: TElFlatBorderType read FSelectionBorder write
        SetSelectionBorder default fbtSunken;
    property DayCellBorder: TElFlatBorderType read FDayCellBorder write
        SetDayCellBorder default fbtLine;
    property CurrentDayBorder: TElFlatBorderType read FCurrentDayBorder write
        SetCurrentDayBorder default fbtSunken;
    property CurrentDayUseBitmap: Boolean read FCurrentDayUseBitmap write SetCurrentDayUseBitmap default false;
    property CurrentDayBitmap: TBitmap read FCurrentDayBitmap write SetCurrentDayBitmap;
    property OnDetermineHoliday: TElHolidayEvent read FOnDetermineHoliday write
        FOnDetermineHoliday;
    property FocusedSelectColor: TColor read FFocusedSelectColor write
        SetFocusedSelectColor default clHighlight;
    property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write
        SetFocusedSelectTextColor default clHighlightText;
    property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor
        default clBtnFace;
    property HideSelection: Boolean read FHideSelection write SetHideSelection
        default true;
    property HideSelectTextColor: TColor read FHideSelectTextColor write
        SetHideSelectTextColor default LMDElHideSelectTextColor;
    property Background: TBitmap read FBackground write SetBackground;
    property BackgroundType: TLMDBackgroundType read FBackgroundType write
        SetBackgroundType default bgtColorFill;
    property GradientEndColor: TColor read FGradientEndColor write
        SetGradientEndColor default clBlack;
    property GradientStartColor: TColor read FGradientStartColor write
        SetGradientStartColor default clBlack;
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps
        default 16;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor
        default clBtnFace;
    property HighlightAlphaLevel: Integer read FHighlightAlphaLevel write
        SetHighlightAlphaLevel default 255;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property DayNameColor: TColor read FDayNameColor write SetDayNameColor default
        clBtnFace;
    property WeekNumColor: TColor read FWeekNumColor write SetWeekNumColor default
        clBtnFace;
    property DayNameTextColor: TColor read FDayNameTextColor write
        SetDayNameTextColor default clBtnText;
    property WeekNumTextColor: TColor read FWeekNumTextColor write
        SetWeekNumTextColor default clBtnText;
    property WeekNumCellBorder: TElFlatBorderType read FWeekNumCellBorder write
        SetWeekNumCellBorder default fbtNone;
    property GridVertLines: Boolean read GetGridVertLines write SetGridVertLines
        default true;
    property GridHorzLines: Boolean read GetGridHorzLines write SetGridHorzLines
        default true;
    property OnBeforeCellDraw: TBeforeCellDrawEvent read FOnBeforeCellDraw write
        FOnBeforeCellDraw;
    property ShowOtherMonthDays: Boolean read FShowOtherMonthDays write
        SetShowOtherMonthDays default false;
    property OtherMonthDayColor: TColor read FOtherMonthDayColor write
        SetOtherMonthDayColor default clGrayText;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;

  property AutoSize;
  property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnStartDrag;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
    {$IFDEF LMCCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
    end;

implementation

uses
  LMDGraphUtils;

var
  sDayS : string;
  sWeekS : string;

constructor TElCalendar.Create(AOwner : TComponent);
begin
  FHolidays := TElHolidays.Create(Self);
  inherited Create(AOwner);
  //  Font.OnChange := FontChanged;
  FCustomCalendarNames := TElCustomCalendarNames.Create;
  FCustomCalendarNames.OnChange := NamesChanged;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;

  FBackground := TBitmap.Create;
  FBackground.OnChange := ImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
  FBackgroundType := bgtColorFill;
  FTmpBmp := TBitmap.Create;

  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  if not (csDesigning in ComponentState) then
    StyleManager := DefaultStyleManager;

  FUseCurrentDate := True;
  DefaultDrawing := false;

  FixedCols := 0;
  FixedRows := 1;
  ColCount := 7;
  RowCount := 7;

  ScrollBars := ssNone;
  Options := Options - [goRangeSelect, goColSizing, goRowSizing] + [goDrawFocusSelected, goHorzLine, goVertLine, goFixedHorzLine, goFixedVertLine];
  FDate := SysUtils.Date;
  FShowWeekNum := False;
  FWeekEndDays := [Sat, Sun];
  FWeekEndColor := clRed;
  FShowHolidays := True;
  FPeriodLength := 1;
  FPeriodInterval := 28;
  FPeriodColor := clAqua;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FTranslateDays := true;
  FLineColorLight := clWindow;
  FLineColorDark := clBtnFace;
  FSelectionBorder := fbtSunken;
  FDayCellBorder   := fbtLine;
  FCurrentDayBorder:= fbtSunken;
  FHolidayColor := clWindowText;
  FHideSelection := true;
  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := LMDElHideSelectTextColor;
  FGridLineColor := clBtnFace;
  FDayNameColor := clBtnFace;
  FWeekNumColor := clBtnFace;
  FDayNameTextColor := clBtnText;
  FWeekNumTextColor := clBtnText;
  FWeekNumCellBorder := fbtNone;
  FOtherMonthDayColor := clGrayText;
  GridLineWidth := 1;
  FLineBorderColor := clWindowText;
  FCurrentDayBitmap := TBitmap.Create;
  FCurrentDayUseBitmap := False;

  HighlightAlphaLevel := 255;
  UpdateCalendar;
  if AutoSize then
    CalcSizes;
  end;

destructor TElCalendar.Destroy;
begin
  Destroying;
  FHolidays.Free;
  FTmpBmp.Free;
  FBackground.Free;
  FCurrentDayBitmap.Free;
  FreeAndNil(FCustomCalendarNames);
  ImageForm := nil;
  FreeAndNil(FImgFormChLink);
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  inherited;
end;

procedure TElCalendar.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TElCalendar.Click;
var
  TheCellText : string;
  ACol, ARow : integer;
  p : TPoint;
begin
  TheCellText := CellText[Col, Row];
  if Copy(TheCellText, 1, 4) = '(-) ' then
    TheCellText := '';

  if (TheCellText <> '') then
  begin
    Day := StrToInt(TheCellText);
    Change;
    inherited Click;
  end;
  GetCursorPos(p);
  with ScreenToClient(p) do
    MouseToCell(x, y, ACol, ARow);
  TheCellText := CellText[ACol, ARow];
  if (Copy(TheCellText, 1, 4) = '(-) ') and UserNavigation then
  begin
    if ARow = 1 then
    begin
      PrevMonth;
      Day := StrToInt(Trim(Copy(TheCellText, 4, Length(TheCellText))));
      Change;
    end
    else
    if ARow >= 4 then
    begin
      NextMonth;
      Day := StrToInt(Trim(Copy(TheCellText, 4, Length(TheCellText))));
      Change;
    end;
  end;
end;

function TElCalendar.IsLeapYear(AYear : Integer) : Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function TElCalendar.DaysThisMonth : Integer;
begin
  Result := LMDDaysPerMonth(Year, Month);
end;

function TElCalendar.GetCellText(ACol, ARow : Integer) : TLMDString;//string;
var
  DayNum : Integer;
  AYear, AMonth, ADay : Word;
  iWeekNum, FDay : integer;

const
  USShortDayNames : array[1..7] of string = ('Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa');

begin
  if ARow = 0 then { day names at tops of columns }
  begin
    if FShowWeekNum then
    begin
      if ACol = 0 then
      begin
        Result := '#';
        Exit;
      end
      else
        dec(ACol);
    end;
    if FTranslateDays then
       Result := FCustomCalendarNames.GetShortDayNames((StartOfWeek + ACol) mod 7 + 1)
    else
       Result := USShortDayNames[(StartOfWeek + ACol) mod 7 + 1];
  end
  else
  begin
    if FShowWeekNum then
    begin
      if ACol = 0 then
      begin
        try
          DecodeDate(FDate, AYear, AMonth, ADay);
          FDay := FMonthOffset + (ARow - 1) * 7 + (7 - StartOfWeek + 1) mod 7;
          if FDay > LMDDaysPerMonth(AYear, AMonth) then
          begin
            if AMonth = 12 then
            begin
              FDay := FDay - LMDDaysPerMonth(AYear, AMonth);
              AMonth := 1;
              Inc(AYear);
            end
            else
            begin
              FDay := FDay - LMDDaysPerMonth(AYear, AMonth);
              Inc(AMonth);
            end;
          end;
          iWeekNum := LMDWeekNumber(AYear, AMonth, FDay);
          Result := IntToStr(iWeekNum);
        except
          Result := '';
        end;
        Exit;
      end
      else
        dec(ACol);
    end;
    DayNum := FMonthOffset + ACol + (ARow - 1) * 7;
    if (DayNum < 1) or (DayNum > DaysThisMonth) then
    begin
      if DayNum < 1 then
        Result := '(-) ' + IntToStr(DayNum + DaysPrevMonth)
      else
        Result := '(-) ' + IntToStr(DayNum - DaysThisMonth);
    end
    else
      Result := IntToStr(DayNum);
  end;
end;

function TElCalendar.SelectCell(ACol, ARow : Longint) : Boolean;
var TheCellText : string;
begin
  if ((not FUpdating) and FReadOnly) then
    Result := False
  else
  begin
    TheCellText := CellText[ACol, ARow];
    if (TheCellText = '') or (Copy(TheCellText, 1, 4) = '(-) ') then
    begin
      {if ARow > 3 then
      begin
        Updating;
        FUpdating := true;
        NextMonth;
        Day := 1;
        result := false;
        Updated;
      end else
      if ARow < 3 then
      begin
        Updating;
        PrevMonth;
        Day := LMDDaysPerMonth(Year, Month);
        result := false;
        Updated;
      end;} result := false;
    end else Result := inherited SelectCell(ACol, ARow);
  end;
end;

procedure TElCalendar.SetCalendarDate(Value : TDateTime);
begin
  FDate := Value;
  UpdateCalendar;
end;

function TElCalendar.StoreCalendarDate : Boolean;
begin
  Result := not FUseCurrentDate;
end;

function TElCalendar.GetDateElement(Index : Integer) : Integer;
var
  AYear, AMonth, ADay : Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  case Index of
    1 : Result := AYear;
    2 : Result := AMonth;
    3 : Result := ADay;
  else
    Result := -1;
  end;
end;

procedure TElCalendar.SetDate(newValue : TDateTime);
begin
  if Trunc(FDate) <> Trunc(newValue) then
  begin
    FDate := NewValue;
    FUseCurrentDate := False;
    UpdateCalendar;
  end;
end;

procedure TElCalendar.SetDateElement(Index : Integer; Value : Integer);
var
  AYear, AMonth, ADay : Word;
begin
  if Value > 0 then
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    case Index of
      1 :
        if AYear <> Value then
          AYear := Value
        else
          Exit;
      2 :
        if (Value <= 12) and (Value <> AMonth) then
          AMonth := Value
        else
          Exit;
      3 :
        if (Value <= DaysThisMonth) and (Value <> ADay) then
          ADay := Value
        else
          Exit;
    else
      Exit;
    end;
    ADay := Min(ADay, LMDDaysPerMonth(AYear, AMonth));
    FDate := EncodeDate(AYear, AMonth, ADay);
    FUseCurrentDate := False;
    UpdateCalendar;
  end;
end;

procedure TElCalendar.SetStartOfWeek(Value : TDayOfWeek);
begin
  if Value <> FStartOfWeek then
  begin
    FStartOfWeek := Value;
    FUseSystemStartOfWeek := False;
    UpdateCalendar;
  end;
end;

procedure TElCalendar.SetUseCurrentDate(Value : Boolean);
begin
  if Value <> FUseCurrentDate then
  begin
    FUseCurrentDate := Value;
    if Value and (not (csLoading in ComponentState)) then
    begin
      FDate := SysUtils.Date;
      UpdateCalendar;
    end;
  end;
end;

{ Given a value of 1 or -1, moves to Next or Prev month accordingly }

procedure TElCalendar.ChangeMonth(Delta : Integer);
var
  AYear, AMonth, ADay : Word;
  NewDate : TDateTime;
  CurDay : Integer;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  CurDay := ADay;
  if Delta > 0 then
    ADay := LMDDaysPerMonth(AYear, AMonth)
  else
    ADay := 1;
  NewDate := EncodeDate(AYear, AMonth, ADay);
  NewDate := NewDate + Delta;
  DecodeDate(NewDate, AYear, AMonth, ADay);
  if LMDDaysPerMonth(AYear, AMonth) > CurDay then
    ADay := CurDay
  else
    ADay := LMDDaysPerMonth(AYear, AMonth);
  CalendarDate := EncodeDate(AYear, AMonth, ADay);
end;

procedure TElCalendar.PrevMonth;
begin
  ChangeMonth(-1);
end;

procedure TElCalendar.NextMonth;
begin
  ChangeMonth(1);
end;

procedure TElCalendar.NextYear;
begin
  if IsLeapYear(Year) and (Month = 2) and (Day = 29) then Day := 28;
  Year := Year + 1;
end;

procedure TElCalendar.PrevYear;
begin
  if IsLeapYear(Year) and (Month = 2) and (Day = 29) then Day := 28;
  Year := Year - 1;
end;

procedure TElCalendar.UpdateCalendar;
var
  AYear, AMonth, ADay : Word;
  FirstDate : TDateTime;
  imod : integer;
begin
  FUpdating := True;
  try
    DecodeDate(FDate, AYear, AMonth, ADay);
    FirstDate := EncodeDate(AYear, AMonth, 1);
    FMonthOffset := 2 - ((SysUtils.DayOfWeek(FirstDate) - StartOfWeek + 7) mod 7); { day of week for 1st of month }
    if FMonthOffset = 2 then FMonthOffset := -5;
    imod := 0;
    if FShowWeekNum then Inc(imod);
    MoveColRow((ADay - FMonthOffset) mod 7 + imod, (ADay - FMonthOffset) div 7 + 1, False, False);
    Invalidate;
  finally
    FUpdating := False;
  end;
end;

procedure TElCalendar.WMSize(var Message : TWMSize);

var
  GridLines : Integer;
  icolnum : integer;
  VertLineHeight,
  HorzLineWidth : integer;
begin
  begin
    if FShowWeekNum then
    begin
      GridLines := 8 * GridLineWidth;
      icolnum := 8;
    end
    else
    begin
      GridLines := 7 * GridLineWidth;
      icolnum := 7;
    end;

    if goVertLine in Options then
      VertLineHeight := GridLineWidth
    else
      VertLineHeight := 0;
    if goHorzLine in Options then
      HorzLineWidth := GridLineWidth
    else
      HorzLineWidth := 0;

    DefaultColWidth := (Message.Width - VertLineHeight * GridLines) div icolnum;
    DefaultRowHeight := (Message.Height - HorzLineWidth * RowCount) div RowCount;
  end;
  inherited;
end;

procedure TElCalendar.CMFontChanged(var Message: TMessage);
begin
  Canvas.Font.Assign(Font);
  if AutoSize then
  begin
    CalcSizes;
  end;
  if HandleAllocated then
    Invalidate;
end;

procedure TElCalendar.SetShowWeekNum(newValue : Boolean);
begin
  if (FShowWeekNum <> newValue) then
  begin
    FShowWeekNum := newValue;
    if FShowWeekNum then
    begin
      FixedCols := 1;
      ColCount := 8;
    end
    else
    begin
      ColCount := 7;
      FixedCols := 0;
    end;
    Width := Width - 1;
    Width := Width + 1;
    UpdateCalendar;
  end; {if}
end;

procedure TElCalendar.Loaded;
begin
  inherited;
  if UseCurrentDate then
  begin
    FUseCurrentDate := False;
    UseCurrentDate := true;
  end;
  if UseSystemStartOfWeek then
  begin
    FUseSystemStartOfWeek := false;
    UseSystemStartOfWeek  := true;
  end;
  UpdateStyle;
end;

procedure TElCalendar.SetWeekEndDays(newValue : TElWeekEndDays);
begin
  if (FWeekEndDays <> newValue) then
  begin
    FWeekEndDays := newValue;
    Repaint;
  end; {if}
end;

procedure TElCalendar.SetWeekEndColor(newValue : TColor);
begin
  if (FWeekEndColor <> newValue) then
  begin
    FWeekEndColor := newValue;
    Repaint;
  end; {if}
end;

procedure TElCalendar.SetHolidays(newValue : TElHolidays);
begin
  FHolidays.Assign(newValue);
end;

procedure TElCalendar.FixHolidayDate(AHoliday : TElHoliday; var Date : TDateTime);
var
  T1 : TSystemTime;
  FirstDate : TDateTime;
  FMonthOffset,
    Dim, DayNum : integer;
begin
  T1.wDayOfWeek := AHoliday.DayOfWeek;
  T1.wMonth := AHoliday.Month;
  T1.wDay := AHoliday.Day;
  T1.wYear := Year;
  FirstDate := EncodeDate(T1.wYear, T1.wMonth, 1);
  FMonthOffset := DayOfWeek(FirstDate) - 1;// 2 - ((DateTimeToTimeStamp(FirstDate).Date mod 7 + 8) mod 7); { day of week for 1st of month }

  DayNum := 1 + (T1.wDayOfWeek - FMonthOffset);
  // DayNum := FMonthOffset + T1.wDayOfWeek + ;
  if (DayNum < 1) then inc(DayNum, 7);
  Dim := LMDDaysPerMonth(T1.wYear, T1.wMonth);
  while (DayNum > Dim) do
    dec(DayNum, 7);
  if (T1.wDay <> 5) then
    inc(DayNum, (T1.wDay - 1) * 7)
  else
  begin
    while DayNum <= Dim do
      inc(DayNum, 7);
    dec(DayNum, 7);
  end;

  T1.wDay := DayNum;
  T1.wHour := 0;
  T1.wMinute := 0;
  T1.wSecond := 0;
  T1.wMilliseconds := 0;
  Date := EncodeDate(T1.wYear, T1.wMonth, T1.wDay) + EncodeTime(T1.wHour, T1.wMinute, T1.wSecond, T1.wMilliseconds);
end;

procedure TElCalendar.MouseToCell(X, Y : Integer; var ACol, ARow : Longint);
var
  Coord : TGridCoord;
begin
  Coord := MouseCoord(X, Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;

procedure TElCalendar.CMHintShow(var Msg : TCMHintShow);
var
  HintInfo : PHintInfo;
  ARow, ACol : integer;
  i, DayNum : integer;
  AHoliday : TElHoliday;
  ADate : TDateTime;
  wAYear,
    wAMonth,
    wADay : Word;
  ths : string;
  pp : TPoint;
  {$ifdef LMD_UNICODE}
  T: WideChar;
  l : integer;
  S : String;
  WS: WideString;
  {$endif}
begin

  HintInfo := Msg.HintInfo;

  if HintInfo.HintControl <> Self then Exit;
  pp := HintInfo.CursorPos;
  //pp := ScreenToClient(pp);
  with pp do
    MouseToCell(X, Y, ACol, ARow);
  if ARow < 1 then
  begin
    {$ifdef LMD_UNICODE}
    if Length(FHint) = 0 then
      HintInfo.hintStr := ''
    else
    begin
      S := GetShortHint(inherited Hint);
      if HintInfo.HintStr = S then
      begin
        WS := LMDWideGetShortHint(FHint);
      end
      else
      begin
        S := FHint;
        WS := FHint;
      end;

      l := Length(S) + 1 + Length(WS) * 2;
      SetLength(HintInfo.HintStr, l + 4);
      Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

      Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
      T := #0;
      Move(T, HintInfo.HintStr[l + 1], sizeof(T));
      T := #$FFFE;
      Move(T, HintInfo.HintStr[l + 3], sizeof(T));
      end;

    {$endif}
    exit;
  end;
  if (not FShowWeekNum) or (ACol > 0) then
  begin
    if FShowWeekNum then Dec(ACol);
    DayNum := FMonthOffset + ACol + (ARow - 1) * 7;
    if (DayNum >= 1) and (DayNum <= DaysThisMonth) then
    begin
      ths := sDayS + IntToStr(LMDDayNumber(Year, Month, DayNum)) + #13#10 +
        sWeekS + IntToStr(LMDWeekNumber(Year, Month, DayNum));
      for i := 0 to FHolidays.Count - 1 do // Iterate
      begin
        AHoliday := FHolidays[i];
        if AHoliday.Month = Month then
        begin
          if AHoliday.FixedDate then
            ADate := EncodeDate(Year, Month, AHoliday.Day)
          else
            FixHolidayDate(AHoliday, ADate);
          DecodeDate(ADate, wAYear, wAMonth, wADay);
          if wADay = DayNum then
            ths := ths + #13#10 + String(AHoliday.Description);
        end;
      end; // for
      if ths <> '' then HintInfo.HintStr := ths;
    end;
  end;
end;

function TElCalendar.IsHoliday(AYear, AMonth, ADay : integer) : Boolean;
var
  I : Integer;
  AHoliday : TElHoliday;
  ADate : TDateTime;
  wAYear,
    wAMonth,
    wADay : Word;

begin
  result := false;
  for i := 0 to FHolidays.Count - 1 do // Iterate
  begin
    AHoliday := FHolidays[i];
    if AHoliday.Month = AMonth then
    begin
      if AHoliday.FixedDate then
        ADate := EncodeDate(Year, Month, AHoliday.Day)
      else
        FixHolidayDate(AHoliday, ADate);
      DecodeDate(ADate, wAYear, wAMonth, wADay);
      result := wADay = ADay;
      if Result then break;
    end;
  end; // for
end; {IsHoliday}

procedure TElCalendar.SetShowHolidays(newValue : Boolean);
begin
  if (FShowHolidays <> newValue) then
  begin
    FShowHolidays := newValue;
    UpdateCalendar;
  end; {if}
end; {SetShowHolidays}

procedure TElCalendar.SetShowPeriods(newValue : Boolean);
begin
  if (FShowPeriods <> newValue) then
  begin
    FShowPeriods := newValue;
    UpdateCalendar;
  end; {if}
end; {SetShowPeriods}

procedure TElCalendar.SetPeriodStart(newValue : TDateTime);
begin
  if (FPeriodStart <> newValue) then
  begin
    FPeriodStart := newValue;
    if FShowPeriods then UpdateCalendar;
  end; {if}
end; {SetPeriodStart}

procedure TElCalendar.SetPeriodInterval(newValue : Word);
begin
  if (FPeriodInterval <> newValue) then
  begin
    FPeriodInterval := newValue;
    if FShowPeriods then UpdateCalendar;
  end; {if}
end;

procedure TElCalendar.SetPeriodLength(newValue : Word);
begin
  if (FPeriodLength <> newValue) then
  begin
    FPeriodLength := newValue;
    if FShowPeriods then UpdateCalendar;
  end; {if}
end; {SetPeriodLength}

procedure TElCalendar.SetPeriodColor(newValue : TColor);
begin
  if (FPeriodColor <> newValue) then
  begin
    FPeriodColor := newValue;
    if FShowPeriods then UpdateCalendar;
  end; {if}
end; {SetPeriodColor}

function TElCalendar.IsInPeriod(AYear, AMonth, ADay : word) : Boolean;
var
  FDate, FDate1 : TDateTime;
begin
  result := false;
  FDate1 := EncodeDate(AYear, AMonth, ADay);
  FPeriodStart := Trunc(FPeriodStart);
  if FDate1 < FPeriodStart then exit;
  FDate := FPeriodStart;
  if FPeriodInterval > 0 then
  begin
    while true do
    begin
      FDate := FDate + FPeriodInterval;
      if FDate > FDate1 then
      begin
        FDate := FDate - FPeriodInterval + FPeriodLength;
        if FDate > FDate1 then result := true;
        break;
      end;
    end; // while
  end else
    result := (FDate1 >= FPeriodStart) and (FDate1 < FPeriodStart + FPeriodLength);
end; {IsInPeriod}

function TElCalendar.IsRestHoliday(AYear, AMonth, ADay : word) : Boolean;
var
  I : Integer;
  AHoliday : TElHoliday;
  ADate : TDateTime;
  wAYear,
    wAMonth,
    wADay : Word;

begin
  result := false;
  for i := 0 to FHolidays.Count - 1 do // Iterate
  begin
    AHoliday := FHolidays[i];
    if AHoliday.Month = AMonth then
    begin
      if AHoliday.FixedDate then
        ADate := EncodeDate(Year, Month, AHoliday.Day)
      else
        FixHolidayDate(AHoliday, ADate);
      DecodeDate(ADate, wAYear, wAMonth, wADay);
      result := (wADay = ADay) and (AHoliday.IsRest);
      if Result then break;
    end;
  end; // for
end; {IsRestHoliday}

procedure TElCalendar.SetHolidayColor(newValue : TColor);
begin
  if (FHolidayColor <> newValue) then
  begin
    FHolidayColor := newValue;
    if FShowHolidays then UpdateCalendar;
  end; {if}
end; {SetHolidayColor}

procedure TElCalendar.SetTranslateDays(value : boolean);
begin
  if FTranslateDays <> value then
  begin
    FTranslateDays := value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetFlat(newValue : Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    UpdateFrame;
    end; { if }
end; { SetFlat }

procedure TElCalendar.CMMouseEnter(var Msg : TMessage); { private }
begin
  inherited;
  FMouseOver := true;
  if Flat and (not Focused) and (not ThemeServices.ThemesEnabled) then UpdateFrame;
end; { CMMouseEnter }

procedure TElCalendar.CMMouseLeave(var Msg : TMessage); { private }
begin
  inherited;
  FMouseOver := false;
  if Flat and (not Focused) and (not LMDThemeServices.ThemesEnabled(LMDApplication.ThemeGlobalMode)) then UpdateFrame;
end; { CMMouseLeave }

procedure TElCalendar.UpdateFrame; { protected }
var
  R : TRect;
begin
  if HandleAllocated then
  begin
    R := Rect(0, 0, Width, Height);
    RedrawWindow(Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame);
  end;
end; { UpdateFrame }

procedure TElCalendar.DrawFlatBorder;
var
  DC : HDC;
  R  : TRect;
  b  : boolean;
  BS : TElFlatBorderType;
  begin
  R := Rect(0, 0, Width, Height);
  DC := GetWindowDC(Handle);
  try
    if (LMDThemeServices.ThemesEnabled(LMDApplication.ThemeGlobalMode)) and (BorderStyle = bsSingle) then
    begin
      begin
        // DrawThemeBackground(Theme, DC, 0, 0, R, nil);
        LMDThemeServices.DrawThemeEdge(LMDApplication.ThemeGlobalMode, DC, teEdit, 0, 0, R, EDGE_SUNKEN, BF_MONO or BF_FLAT or BF_RECT);
        exit;
      end;
    end;
    if (BorderStyle = bsSingle) and Flat then
    begin
      b := Focused or FMouseOver;
      if b then
        BS := FActiveBorderType
      else
        BS := FInactiveBorderType;
      if BS in [fbtLineBorder, fbtColorLineBorder, fbtNone] then
      begin
        dec(R.Right);
        dec(R.Bottom);
      end;
      if BS = fbtColorLineBorder then
        DrawFlatFrameEx2(DC, R, FLineBorderColor, Color, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow)
      else
        DrawFlatFrameEx2(DC, R, Color, Color, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
      if BS in [fbtLineBorder, fbtColorLineBorder, fbtNone] then
      begin
        inc(R.Right);
        inc(R.Bottom);
      end;
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TElCalendar.WMNCPaint(var Msg : TWMNCPaint); { private }
begin
  if (not Flat) or LMDThemeServices.ThemesEnabled(LMDApplication.ThemeGlobalMode) then
  begin
    inherited;
    exit;
  end;
  inherited;
  DrawFlatBorder;
  Msg.Result := 0;
end; { WMNCPaint }

procedure TElCalendar.WMKillFocus(var Msg : TWMKillFocus); { private }
begin
  inherited;
  if not HandleAllocated then exit;
  if Flat then UpdateFrame;
end; { WMKillFocus }

procedure TElCalendar.WMSetFocus(var Msg : TWMSetFocus); { private }
begin
  inherited;
  if Flat then UpdateFrame;
end; { WMSetFocus }

procedure TElCalendar.WMPaint(var Msg : TWMPaint); { private }
begin
  DrawFlatBorder;
  inherited;
end; { WMPaint }

procedure TElCalendar.WMVScroll(var Msg : TWMVScroll); { private }
begin
  inherited;
  if Flat then DrawFlatBorder;
end; { WMVScroll }

procedure TElCalendar.WMHScroll(var Msg : TWMHScroll); { private }
begin
  inherited;
  if Flat then DrawFlatBorder;
end; { WMHScroll }

procedure TElCalendar.SetActiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FActiveBorderType to newValue. }
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if (Focused or FMouseOver) then UpdateFrame;
    end;  { if }
end;  { SetActiveBorderType }

procedure TElCalendar.SetInactiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FInactiveBorderType to newValue. }
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if not (Focused or FMouseOver) then UpdateFrame;
    end;  { if }
end;  { SetInactiveBorderType }

procedure TElCalendar.KeyDown(var Key: Word; Shift: TShiftState);  { protected }
var b : boolean;
    TheCellText: string;
    ACol, ARow : Word;

  function SameMonth (Date1, Date2 : TDateTime) : boolean;
  var Day1, Day2,
      Month1, Month2,
      Year1, Year2  : word;
  begin
    DecodeDate(Date1, Year1, Month1, Day1);
    DecodeDate(Date2, Year2, Month2, Day2);
    result := Month1 = Month2;
  end;

begin
  if (Shift = []) //and (Key in [VK_DOWN, VK_UP, VK_LEFT, VK_RIGHT, VK_PRIOR, VK_NEXT]) then
  then
  begin
    ACol := Col;
    ARow := Row;
    if Self.ShowWeekNum then
      dec(ACol);

    case Key of
      VK_RETURN:
        begin
          try
            TheCellText := CellText[ACol, ARow];
            if Copy(TheCellText, 1, 4) = '(-) ' then
              TheCellText := '';
          except
            TheCellText := '';
          end;
          if (TheCellText <> '') then
          begin
            if StrToIntDef(TheCellText, -1) <> -1 then
            begin
              Day := StrToInt(TheCellText);
              Change;
              Click;
              exit;
            end;
          end;
          b := false;
        end;

      VK_DOWN:
        begin
          b := true;
          if UserNavigation then
            Date := Date + 7
          else
          if SameMonth(Date, Date + 7) then
            Date := Date + 7
          else
            b := false;
        end;
      VK_UP:
        begin
          b := true;
          if UserNavigation then
             Date := Date - 7
          else
          if SameMonth(Date, Date - 7) then
            Date := Date - 7
          else
            b := false;
        end;
      VK_LEFT:
        begin
          b := true;
          if UserNavigation then
             Date := Date - 1
          else
          if SameMonth(Date, Date - 1) then
            Date := Date - 1
          else
            b := false;
        end;
      VK_RIGHT:
        begin
          b := true;
          if UserNavigation then
             Date := Date + 1
          else
          if SameMonth(Date, Date + 1) then
             Date := Date + 1
          else b := false;
        end;
      VK_PRIOR:
        begin
          b := true;
          if UserNavigation then
            Date := Date - DaysThisMonth
          else
            b := false;
        end;
      VK_NEXT:
        begin
          b := true;
          if UserNavigation then
             Date := Date + DaysThisMonth
          else
             b := false;
        end;
      else
        b := false;
    end;
    if b then
    begin
      Change;
      Key := 0;
    end
    else
      inherited;
  end
  else
    inherited;
end;  { KeyDown }

function TElCalendar.StoreDate: boolean;
begin
  Result := not FUseCurrentDate;
end;

procedure TElCalendar.SetUseSystemStartOfWeek(Value: Boolean);
begin
  if FUseSystemStartOfWeek <> Value then
  begin
    if (not (csLoading in ComponentState)) then
      if Value then
        StartOfWeek := TDayOfWeek(LMDGetSysStartDayOfWeek)
      else
        UpdateCalendar;
    FUseSystemStartOfWeek := Value;
  end;
end;

procedure TElCalendar.SetLineColorLight(Value: TColor);
begin
  if FLineColorLight <> Value then
  begin
    FLineColorLight := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetLineColorDark(Value: TColor);
begin
  if FLineColorDark <> Value then
  begin
    FLineColorDark := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetUseLineColors(Value: Boolean);
begin
  if FUseLineColors <> Value then
  begin
    FUseLineColors := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
    end;
end;

procedure TElCalendar.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if (BorderStyle = bsSingle) then
    begin
      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
    end;;
end;

procedure TElCalendar.SetSelectionBorder(Value: TElFlatBorderType);
begin
  if FSelectionBorder <> Value then
  begin
    FSelectionBorder := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetDayCellBorder(Value: TElFlatBorderType);
begin
  if FDayCellBorder <> Value then
  begin
    FDayCellBorder := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetCurrentDayBorder(Value: TElFlatBorderType);
begin
  if FCurrentDayBorder <> Value then
  begin
    FCurrentDayBorder := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetCurrentDayBitmap(Value: TBitmap);
begin
  FCurrentDayBitmap.Assign(Value);
  Invalidate;
end;

procedure TElCalendar.SetCurrentDayUseBitmap(Value: Boolean);
begin
  if Value <> FCurrentDayUseBitmap then
  begin
    FCurrentDayUseBitmap := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.TriggerDetermineHoliday(ADay, AMonth, AYear : word; var IsHoliday :
    boolean);
begin
  IsHoliday := Self.IsHoliday(AYear, AMonth, ADay);
  if assigned(FOnDetermineHoliday) then
    FOnDetermineHoliday(Self, ADay, AMonth, AYear, IsHoliday);
end;

procedure TElCalendar.SetFocusedSelectColor(newValue: TColor);
begin
  if (FFocusedSelectColor <> newValue) then
  begin
    FFocusedSelectColor := newValue;
    if (Focused or (not FHideSelection)) then Invalidate;
  end;  {if}
end;

procedure TElCalendar.SetFocusedSelectTextColor(newValue: TColor);
begin
  if (FFocusedSelectTextColor <> newValue) then
  begin
    FFocusedSelectTextColor := newValue;
    if (Focused or (not FHideSelection)) then Invalidate;
  end;  {if}
end;

procedure TElCalendar.SetHideSelectColor(newValue: TColor);
begin
  if (FHideSelectColor <> newValue) then
  begin
    FHideSelectColor := newValue;
    if not Focused and not FHideSelection then Invalidate;
  end;  {if}
end;

procedure TElCalendar.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    if not Focused then Invalidate;
  end;
end;

procedure TElCalendar.SetHideSelectTextColor(newValue: TColor);
begin
  if (FHideSelectTextColor <> newValue) then
  begin
    FHideSelectTextColor := newValue;
    if not Focused and not FHideSelection then Invalidate;
  end;  {if}
end;

procedure TElCalendar.SetBackground(newValue : TBitmap);
begin
  FBackground.Assign(newValue);
  if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
     then BackgroundType := bgtColorFill;
end; {SetBackground}

procedure TElCalendar.SetBackgroundType(newValue : TLMDBackgroundType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill;
    RedoTmpBmp;
    Invalidate;
  end; {if}
end; {SetBackgroundType}

procedure TElCalendar.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then Invalidate;
  end;  { if }
end;  { SetGradientEndColor }

procedure TElCalendar.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then Invalidate;
  end;  { if }
end;  { SetGradientStartColor }

procedure TElCalendar.SetGradientSteps(newValue : Integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then Invalidate;
  end;  { if }
end;  { SetGradientSteps }

procedure TElCalendar.RedoTmpBmp;
var BgRect,
    BgRect2 : TRect;
begin
  if LMDBackgroundIsGradient(FBackgroundType) or (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then
  begin
    FTmpBmp.FreeImage;
  end else
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight - 1;
      FTmpBmp.Width := ClientWidth - 1;
      BgRect := ClientRect;
      BgRect2 := BgRect;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      LMDExtDrawBkgnd(FTmpBmp.Canvas.Handle,  BgRect, BgRect, BgRect, BgRect2, false, Color, Color, Background, BackgroundType);
    end;
  end;
end;

procedure TElCalendar.ImageChange(Sender : TObject);
begin
  if ((FBackground.Height = 0) or (FBackground.Width = 0)) then
    BackgroundType := bgtColorFill
  else
  begin
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;
    Invalidate;
  end;
end;

procedure TElCalendar.SetImageForm(newValue : TElImageForm);
begin
  if (FImgForm <> newValue) then
  begin
    if FImgForm <> nil then
    begin
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := newValue;
    if (newValue <> nil) then
    begin
      newValue.FreeNotification(Self);
      FImgForm.RegisterChanges(FImgFormChLink);
    end;
    if not (csDesigning in ComponentState) then Invalidate;
  end;  { if }
end;  { SetImageForm }

procedure TElCalendar.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if (AComponent = FImgForm) then
      ImageForm := nil;
    end;  { if }
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end;  { Notification }

procedure TElCalendar.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TElCalendar.WMWindowPosChanged(var Message:
    TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElCalendar.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TElCalendar.Paint;
  var
    i : integer;
    VertLineWidth,
    HorzLineWidth : integer;
    HorzFixedBoundary,
    VertFixedBoundary,
    HorzGridBoundary,
    VertGridBoundary : integer;
    Bitmap: TBitmap;
    Canvas: TCanvas;
    ClRect: TRect;

  function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): Boolean;
  begin
    Result := (Col >= Rect.Left) and (Col <= Rect.Right) and (Row >= Rect.Top)
      and (Row <= Rect.Bottom);
  end;

  procedure DrawCell(ACol, ARow : Longint; ARect : TRect; AState : TGridDrawState);
  var
    TheText       : TLMDString;
    SaveColor1    : TColor;
    SaveFontColor : TColor;
    FSaveBStyle   : TBrushStyle;
    FillRect      : TRect;
    R             : TRect;
    iDayNum       : integer;
    ib            : boolean;
    isHol         : boolean;
    DoFill        : boolean;
    FillColor     : TColor;
    CurDate       : TDateTime;
    DrawOptions   : TElCalendarCellTypes;
    BorderSides   : TLMDBorderSides;
    ABorder       : TElFlatBorderType;
    FTmpBitmap    : TBitmap;
    LDaysThisMonth: integer;
  begin

    LDaysThisMonth := DaysThisMonth;
    DoFill := false;
    TheText := CellText[ACol, ARow];

    FillRect := ARect;

    Canvas.Font.Assign(Font);

    Canvas.Brush.Color := Color;

    SaveFontColor := Canvas.Font.Color;
    FSaveBStyle := Canvas.Brush.Style;

    ib := false;

    DrawOptions := [];

    if (gdFixed in AState) then
    begin
      if ARow = 0 then
      begin
        FillColor := DayNameColor;
        DrawOptions := [cctDayName];
      end
      else
      begin
        FillColor := WeekNumColor;
        DrawOptions := [cctWeekNum];
      end;
      DoFill := true;
      if HighlightAlphaLevel = 255 then
      begin
        Canvas.Brush.Color := FillColor;
        Canvas.FillRect(ARect);
      end;
      if ARow = 0 then
      begin
        if DayCellBorder in [fbtLine, fbtNone] then
          BorderSides := []
        else
          BorderSides := AllBorderSides;
        ABorder := FDayCellBorder;
      end
      else
      begin
        if WeekNumCellBorder in [fbtLine, fbtNone]  then
          BorderSides := []
        else
          BorderSides := AllBorderSides;
        ABorder := WeekNumCellBorder;
      end;
      if ABorder in [fbtLineBorder, fbtColorLineBorder, fbtNone] then
      begin
        dec(ARect.Right);
        dec(ARect.Bottom);
      end;
      if ABorder = fbtColorLineBorder then
        DrawFlatFrameEx2(Canvas.Handle, ARect, FLineBorderColor, FillColor, false, true, BorderSides, ABorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow)
      else
        DrawFlatFrameEx2(Canvas.Handle, ARect, FillColor, FillColor, false, true, BorderSides, ABorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
      if ABorder in [fbtLineBorder, fbtColorLineBorder, fbtNone] then
      begin
        inc(ARect.Right);
        inc(ARect.Bottom);
      end;
      InflateRect(ARect, -2, -2);
    end
    else
    begin
      if Copy(TheText, 1, 4) = '(-) ' then
      begin
        if Self.ShowOtherMonthDays then
        begin
          Delete(TheText, 1, 4);
          Include(DrawOptions, cctOtherMonth);
        end
        else
          TheText := '';
      end;

      if (gdSelected in AState) then
      begin
        DrawOptions := [cctSelected];
        if Focused then
        begin
          FillColor := FocusedSelectColor;
          DoFill := true;
          Canvas.Font.Color := FocusedSelectTextColor;
        end
        else
        if not HideSelection then
        begin
          FillColor := HideSelectColor;
          DoFill := true;
          Canvas.Font.Color := HideSelectTextColor;
        end
        else
        begin
          FillColor := Color;
          Canvas.Font.Color := Font.Color;
        end;
      end
      else
      begin
        if UseLineColors then
        begin
          if ((ARow and 1) = 0) then
            FillColor := LineColorLight
          else
            FillColor := LineColorDark;
          DoFill := true;
        end
        else
        begin
          DoFill := false;
          FillColor := Color;
        end;
        Canvas.Font.Color := Font.Color;
        if cctOtherMonth in DrawOptions then
          Canvas.Font.Color := FOtherMonthDayColor;
      end;

      if (not FShowWeekNum) or (ACol > 0) then
      begin
        if FShowWeekNum then dec(ACol);
        iDayNum := FMonthOffset + ACol + (ARow - 1) * 7;

        if (iDayNum > 0) and (iDayNum <= LDaysThisMonth) and
           (EncodeDate(Year, Month, iDayNum) = Trunc(Now)) then
        begin
          if CurrentDayBorder in [fbtLine, fbtNone]  then
            BorderSides := []
          else
            BorderSides := AllBorderSides;
          if CurrentDayBorder in [fbtLineBorder, fbtColorLineBorder, fbtNone] then
          begin
            dec(ARect.Right);
            dec(ARect.Bottom);
          end;
          if not FCurrentDayBitmap.Empty and FCurrentDayUseBitmap then
          begin
            FTmpBitmap := TBitmap.Create;
            FTmpBitmap.Height := ARect.Bottom - ARect.Top;
            FTmpBitmap.Width := ARect.Right - ARect.Left;
            FTmpBitmap.Canvas.StretchDraw(Rect(0,0,FTmpBitmap.Width,FTmpBitmap.Height),FCurrentDayBitmap);
            FTmpBitmap.TransparentColor := FTmpBitmap.Canvas.Pixels[1, FTmpBitmap.Height-1];
            FTmpBitmap.Transparent := True;
            FTmpBitmap.TransparentMode := tmAuto;
            Canvas.Draw(ARect.Left, ARect.Top, FTmpBitmap);
            FTmpBitmap.Free;
          end;
          if CurrentDayBorder = fbtColorLineBorder then
            DrawFlatFrameEx2(Canvas.Handle, ARect, FLineBorderColor, Canvas.Brush.Color, false, true, AllBorderSides, CurrentDayBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow)
          else
            DrawFlatFrameEx2(Canvas.Handle, ARect, Canvas.Brush.Color, Canvas.Brush.Color, false, true, AllBorderSides, CurrentDayBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
          if CurrentDayBorder in [fbtLineBorder, fbtColorLineBorder, fbtNone] then
          begin
            inc(ARect.Right);
            inc(ARect.Bottom);
          end;
          InflateRect(FillRect, -2, -2);
          InflateRect(ARect, -2, -2);
          ib := true;
        end;
        if FShowWeekNum then inc(ACol);
      end;

      if (gdSelected in AState) and (not ib) then
      begin
        if Focused then
        begin
          FillColor := FocusedSelectColor;
          DoFill := true;
          Canvas.Font.Color := FocusedSelectTextColor;
        end
        else
        if not HideSelection then
        begin
          FillColor := HideSelectColor;
          DoFill := true;
          Canvas.Font.Color := HideSelectTextColor;
        end
        else
        begin
          FillColor := Color;
          Canvas.Font.Color := Font.Color;
        end;
        InflateRect(FillRect, -2, -2);
        if SelectionBorder in [fbtLine, fbtNone] then
          BorderSides := []
        else
          BorderSides := AllBorderSides;

        if SelectionBorder in [fbtLineBorder, fbtColorLineBorder, fbtNone] then
        begin
          dec(ARect.Right);
          dec(ARect.Bottom);
        end;
        if SelectionBorder = fbtColorLineBorder then
          DrawFlatFrameEx2(Canvas.Handle, ARect, FLineBorderColor, Canvas.Brush.Color, false, true, AllBorderSides, SelectionBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow)
        else
          DrawFlatFrameEx2(Canvas.Handle, ARect, Canvas.Brush.Color, Canvas.Brush.Color, false, true, AllBorderSides, SelectionBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
        if SelectionBorder in [fbtLineBorder, fbtColorLineBorder, fbtNone] then
        begin
          inc(ARect.Right);
          inc(ARect.Bottom);
        end;
        InflateRect(ARect, -2, -2);
      end;
    end;

    if (not FShowWeekNum) or (ACol > 0) then
    begin
      if FShowWeekNum then dec(ACol);
      iDayNum := FMonthOffset + ACol + (ARow - 1) * 7;
      ACol := (StartOfWeek + ACol) mod 7;
      if ACol < 0 then Inc(ACol, 7);

      if (TElWeekEndDay(ACol) in FWeekEndDays) and not ((gdSelected in AState) and (Focused or (not HideSelection))) and (not (cctOtherMonth in DrawOptions)) then
        Canvas.Font.Color := FWeekEndColor;

      if TElWeekEndDay(ACol) in FWeekEndDays then
        Include(DrawOptions, cctWeekend);

      isHol := False;
      if (iDayNum > 0) and (iDayNum <= LDaysThisMonth) then
        TriggerDetermineHoliday(iDayNum, Month, Year, IsHol);
      if IsHol then
      begin
        if IsRestHoliday(Year, Month, iDayNum) and
           (not ((Selection.Left = ACol) and (Selection.Top = ACol))) then
          Canvas.Font.Color := FHolidayColor;
        Include(DrawOptions, cctHoliday);
      end;
      if (iDayNum > 0) and (iDayNum <= LDaysThisMonth) then
        if IsInPeriod(Year, Month, iDayNum) then
          Include(DrawOptions, cctInPeriod);

      if (iDayNum > 0) and (iDayNum <= LDaysThisMonth) then
      begin
        CurDate := EncodeDate(Year, Month, iDayNum);
        if Trunc(CurDate) = Trunc(Now) then
          Include(DrawOptions, cctToday);
      end
      else
      begin
        CurDate := 0;
        if ARow > 0 then
        begin
          if ShowOtherMonthDays then
          begin
            Include(DrawOptions, cctOtherMonth);

            if iDayNum < 1 then
            begin
              if Month = 1 then
                CurDate := EncodeDate(Year -1, 12, iDayNum + DaysPrevMonth)
              else
                CurDate := EncodeDate(Year, Month - 1, iDayNum + DaysPrevMonth)
            end
            else
            begin
              if Month = 12 then
                CurDate := EncodeDate(Year + 1, 1, iDayNum - LDaysThisMonth)
              else
                CurDate := EncodeDate(Year, Month + 1, iDayNum - LDaysThisMonth)
            end;
          end
          else
            Include(DrawOptions, cctEmpty);
        end;
      end;

      if DoFill and (HighlightAlphaLevel = 255) then
        Canvas.Brush.Color := FillColor
      else
        Canvas.Brush.Style := bsClear;

      TriggerBeforeCellDraw(Canvas, ARow, ACol, CurDate, DrawOptions);

      if GridHorzLines then
        dec(ARect.Bottom);
      if GridVertLines then
        dec(ARect.Right);
      if Canvas.Brush.Style <> bsClear then
        Canvas.FillRect(ARect);
      if GridHorzLines then
        inc(ARect.Bottom);
      if GridVertLines then
        inc(ARect.Right);
      {
      end
      else
        TriggerBeforeCellDraw(Canvas, ARow, ACol, CurDate, DrawOptions);
      }
      if ShowHolidays and IsHol then
      begin
        SaveColor1 := Canvas.Brush.Color;
        Canvas.Brush.Color := FHolidayColor;
        R := Rect(ARect.Left, ARect.Top, ARect.Left + ((ARect.Right - ARect.Left) div 4),
                  ARect.Top + ((ARect.Bottom - ARect.Top) div 4));

        OffsetRect(R, 1, 1);
        Canvas.FillRect(R);
        Canvas.Brush.Color := SaveColor1;
        Canvas.Brush.Style := bsClear;
      end;
      if (iDayNum > 0) and (iDayNum <= LDaysThisMonth) then
      begin
        if ShowPeriods and IsInPeriod(Year, Month, iDayNum) then
        begin
          SaveColor1 := Canvas.Brush.Color;
          Canvas.Brush.Color := FPeriodColor;
          R := Rect(ARect.Left + 1, ARect.Bottom - ((ARect.Bottom - ARect.Top) div 4) - 1,
                    ARect.Right - 1, ARect.Bottom - 1);
          Canvas.FillRect(R);
          Canvas.Brush.Color := SaveColor1;
          Canvas.Brush.Style := bsClear;
        end;
      end;
    end
    else // this is WeekNum
    begin
      TriggerBeforeCellDraw(Canvas, ARow, ACol, 0, [cctWeekNum]);
      if Canvas.Brush.Color <> clNone then
      begin
        if HighlightAlphaLevel = 255 then
        Canvas.FillRect(ARect)
        else
          DoFill := true;
        end;
    end;

    Canvas.Brush.Style := bsClear;
    with ARect, Canvas do
      LMDDrawText(Handle, TheText, Length(TheText), ARect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);

{      TextRect(ARect, Left + (Right - Left - TextWidth(TheText)) div 2,
        Top + (Bottom - Top - TextHeight(TheText)) div 2, TheText);
}
    if DoFill and (HighlightAlphaLevel < 255) then
    begin
      Canvas.Brush.Color := FillColor;
      if Canvas.Brush.Color <> clNone then
        LMDAlphaFillRect(Canvas, FillRect, Canvas.Brush.Color, HighlightAlphaLevel);
    end;
    Canvas.Brush.Style := FSaveBStyle;
    Canvas.Font.Color := SaveFontColor;
  end;//of: DrawCell

  procedure DrawCells(ACol, ARow: Longint; StartX, StartY, StopX, StopY: Integer;
    Color: TColor; IncludeDrawState: TGridDrawState);
  var
    CurCol,
    CurRow: Longint;
    Where : TRect;
    DrawState: TGridDrawState;
  begin
    CurRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (CurRow < RowCount) do
    begin
      CurCol := ACol;
      Where.Left := StartX;
      Where.Bottom := Where.Top + RowHeights[CurRow] + HorzLineWidth;
      while (Where.Left < StopX) and (CurCol < ColCount) do
      begin
        Where.Right := Where.Left + ColWidths[CurCol] + VertLineWidth;
        if (Where.Right > Where.Left) and RectVisible(Canvas, Where) then
        begin
          DrawState := IncludeDrawState;

          if PointInGridRect(CurCol, CurRow, Selection) then
            Include(DrawState, gdSelected);
          if Focused and (CurRow = Row) and (CurCol = Col)  then
            Include(DrawState, gdFocused);

          DrawCell(CurCol, CurRow, Where, DrawState);
        end;
        Where.Left := Where.Right;
        Inc(CurCol);
      end;
      Where.Top := Where.Bottom;
      Inc(CurRow);
    end;
  end;

begin
  Bitmap := TBitmap.Create;
  Bitmap.Width := ClientWidth;
  Bitmap.Height := ClientHeight;
  Canvas := Bitmap.Canvas;
  DrawBackground(Canvas);

  Canvas.Pen.Color := GridLineColor;
  Canvas.Pen.Width := GridLineWidth;
  VertLineWidth := 0;
  HorzLineWidth := 0;

  if goHorzLine in Options then
  begin
    HorzLineWidth := GridLineWidth;

    for i := 1 to RowCount do
    begin
      Canvas.Polyline([Point(0, i * DefaultRowHeight + (i - 1) * GridLineWidth), Point((DefaultColWidth + GridLineWidth) * ColCount, i * DefaultRowHeight + (i - 1) * GridLineWidth)]);
    end;
  end;
  if goVertLine in Options then
  begin
    VertLineWidth := GridLineWidth;

    for i := 1 to ColCount do
    begin
      Canvas.Polyline([Point(i * DefaultColWidth + (i - 1) * GridLineWidth, 0), Point(i * DefaultColWidth + (i - 1) * GridLineWidth, (DefaultRowHeight + GridLineWidth) * RowCount)]);
    end;
  end;
  HorzFixedBoundary := FixedCols * (DefaultColWidth + VertLineWidth);
  VertFixedBoundary := FixedRows * (DefaultRowHeight + HorzLineWidth);
  HorzGridBoundary := ColCount * (DefaultColWidth + VertLineWidth);
  VertGridBoundary := RowCount * (DefaultRowHeight + HorzLineWidth);

  DrawCells(0, 0, 0, 0, HorzFixedBoundary, VertFixedBoundary, Color,
    [gdFixed]);
  DrawCells(LeftCol, 0, HorzFixedBoundary, 0, HorzGridBoundary,
    VertFixedBoundary, Color, [gdFixed]);
  DrawCells(0, TopRow, 0, VertFixedBoundary, HorzFixedBoundary,
    VertGridBoundary, Color, [gdFixed]);
  DrawCells(LeftCol, TopRow, HorzFixedBoundary,
    VertFixedBoundary, HorzGridBoundary, VertGridBoundary, Color, []);
  ClRect := Canvas.ClipRect;
  if IsRectEmpty(ClRect) then
    ClRect := ClientRect;
  bitblt(Self.Canvas.Handle, ClRect.Left, ClRect.Top, ClRect.Right - ClRect.Left, ClRect.Bottom - ClRect.Top, Bitmap.Canvas.Handle, ClRect.Left, ClRect.Top, SRCCOPY);
  Bitmap.Free;
  end;

procedure TElCalendar.SetGridLineColor(Value: TColor);
begin
  if FGridLineColor <> Value then
  begin
    FGridLineColor := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.DrawBackground(Canvas : TCanvas);
var
    R, R1,
    Rect : TRect;
    P    : TPoint;
    ACtl   : TWinControl;
    BgRect : TRect;
begin
  R := ClientRect;

  if (FImgForm <> nil) and (not (csDesigning in FImgForm.ComponentState)) then
  begin
    if FImgForm.Control <> Self then
    begin
      ACtl := FImgForm.GetRealControl;
      BgRect := R;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
      P := Parent.ClientToScreen(Point(Left, Top));

      BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
      FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, false);
    end;
  end
  else
  begin
    with Canvas do
    case BackgroundType of //
      bgtColorFill :
        begin
          Canvas.Brush.Style := bsSolid;
          Canvas.Brush.Color := Color;
          Canvas.FillRect(R);
        end;
      bgtHorzGradient, bgtVertGradient, bgtSquareGradient, bgtEllipticGradient,
      bgtTopLeftGradient, bgtTopRightGradient, bgtBottomLeftGradient,
      bgtBottomRightGradient, bgtTopLeftDiagonalGradient, bgtTopRightDiagonalGradient:
        LMDGradientPaint(Canvas, R, GradientStartColor, GradientEndColor, GradientSteps,LMDBackgroundType2GradientStyle[BackgroundType], 0, 0);
      bgtStretchBitmap,
      bgtTileBitmap:
        begin
          CopyRect(R, FTmpBmp.Canvas, Classes.Rect(0, 0, FTmpBmp.Width, FTmpBmp.Height));
        end;
      bgtCenterBitmap :
        begin
          Brush.Color := Color;
          Rect := R;
          FillRect(Rect);
          R := Classes.Rect(0, 0, FBackground.Width, FBackground.Height);
          LMDCenterRects(FBackground.Width, Rect.Right - Rect.Left, FBackground.Height, Rect.Bottom - Rect.Top, R1);
          OffsetRect(R1, Rect.Left, Rect.Top);
          CopyRect(R1, FBackground.Canvas, Classes.Rect(0, 0, FBackground.Width, FBackground.Height));
        end;
    end; // case
  end;
end;

procedure TElCalendar.DefineProperties(Filer : TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('GridLineWidth', FakeInteger, nil, false);
end;

procedure TElCalendar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  CellHit: TGridCoord;
  P : TPoint;
  AMsg : TMessage;
  begin
  CellHit := MouseCoord(X, Y);
  if (CellHit.X <> FLastHit.X) or (CellHit.Y <> FLastHit.Y) then
  begin
    FLastHit := CellHit;
    if ShowHint then
    begin
      P := ClientToScreen(Point(X, Y));
      ZeroMemory(@AMsg, sizeof(AMsg));
      TWMMouse(AMsg).XPos := -10000;
      TWMMouse(AMsg).YPos := -10000;
      AMsg.Msg := WM_MOUSEMOVE;
      Application.HintMouseMessage(Self, AMsg);
      TWMMouse(AMsg).Pos := SmallPoint(X, Y);
      Application.HintMouseMessage(Self, AMsg);
      end;
  end;
  inherited MouseMove(Shift, X, Y);
  // ���� �� ������� Invalidate, �� ��� ����������� ������� ���� ����� ���������� ����.
  // ����� ��� ��������� ���� , ���� ���������� ���������� �� ����� ����������������
  // DrawCell, � �������� ������...
  //if (not GridVertLines) or ( not GridHorzLines) then
  //  Invalidate;
end;

procedure TElCalendar.DrawCell(ACol, ARow : Longint; ARect : TRect; AState :TGridDrawState);
begin
end;

procedure TElCalendar.SetHighlightAlphaLevel(Value: Integer);
begin
  if (FHighlightAlphaLevel <> Value) and (Value >= 0) and (Value <= 255) then
  begin
    FHighlightAlphaLevel := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetDayNameColor(Value: TColor);
begin
  if FDayNameColor <> Value then
  begin
    FDayNameColor := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetWeekNumColor(Value: TColor);
begin
  if FWeekNumColor <> Value then
  begin
    FWeekNumColor := Value;
    if ShowWeekNum then
      Invalidate;
  end;
end;

procedure TElCalendar.SetDayNameTextColor(Value: TColor);
begin
  if FDayNameTextColor <> Value then
  begin
    FDayNameTextColor := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetWeekNumTextColor(Value: TColor);
begin
  if FWeekNumTextColor <> Value then
  begin
    FWeekNumTextColor := Value;
    if ShowWeekNum then
      Invalidate;
  end;
end;

procedure TElCalendar.SetWeekNumCellBorder(Value: TElFlatBorderType);
begin
  if FWeekNumCellBorder <> Value then
  begin
    FWeekNumCellBorder := Value;
    Invalidate;
  end;
end;

function TElCalendar.GetGridVertLines: Boolean;
begin
  Result := goVertLine in Options;
end;

function TElCalendar.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

procedure TElCalendar.SetGridVertLines(Value: Boolean);
begin
  if Value then
    Options := Options + [goVertLine, goFixedVertLine]
  else
    Options := Options - [goVertLine, goFixedVertLine];
end;

function TElCalendar.GetGridHorzLines: Boolean;
begin
  Result := goHorzLine in Options;
end;

procedure TElCalendar.SetGridHorzLines(Value: Boolean);
begin
  if Value then
    Options := Options + [goHorzLine, goFixedHorzLine]
  else
    Options := Options - [goHorzLine, goFixedHorzLine];
end;

procedure TElCalendar.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    if FStyleManager <> nil then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TElCalendar.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TElCalendar.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TElCalendar.UpdateStyle;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if FStyleManager <> nil then
  begin
    if HandleAllocated and Visible then
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if HandleAllocated and Visible then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      Invalidate;
    end;
  end;
end;

{$ifdef LMD_UNICODE}

procedure TElCalendar.SetHint(Value: TLMDString);
{var S : String;

    i,
    l : integer;
    T : WideChar;}

begin
  FHint := Value;

  inherited Hint := LMDConvertVCLHint(FHint)
  {S := FHint;

  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;
  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));

  inherited Hint := S;}
end;
{$endif}

function TElCalendar.GetEffectiveHeight: Integer;
var
  HorzLineWidth : integer;
  tm : TLMDTextMetric;
begin
  if goHorzLine in Options then
    HorzLineWidth := GridLineWidth
  else
    HorzLineWidth := 0;
  if HandleAllocated and AutoSize then
  begin
    LMDGetTextMetrics(Canvas.Handle, tm);
    Result := RowCount * (tm.tmHeight + 2 + HorzLineWidth) // + GetSystemMetrics(SM_CXEDGE) * 2;
  end
  else
    Result := RowCount * (DefaultRowHeight + HorzLineWidth);// + GetSystemMetrics(SM_CXEDGE) * 2;
end;

function TElCalendar.GetEffectiveWidth: Integer;
var
  VertLineHeight : integer;
  tm : TLMDTextMetric;
begin
  if goVertLine in Options then
    VertLineHeight := GridLineWidth
  else
    VertLineHeight := 0;
  if HandleAllocated and AutoSize then
  begin
    LMDGetTextMetrics(Canvas.Handle, tm);
    Result := ColCount * ({tm.tmAveCharWidth * 5}min(tm.tmMaxCharWidth * 2 + 2, tm.tmAveCharWidth * 5) + VertLineHeight) // + GetSystemMetrics(SM_CYEDGE) * 2;
  end
  else
    Result := ColCount * (DefaultColWidth + VertLineHeight);// + GetSystemMetrics(SM_CYEDGE) * 2;
end;

procedure TElCalendar.CalcSizes;
var
  tm : TLMDTextMetric;
begin
  if AutoSize then
  begin
    FUpdating := True;
    LMDGetTextMetrics(Canvas.Handle, tm);
    DefaultRowHeight := tm.tmHeight + 2;
//    DefaultColWidth := tm.tmAveCharWidth * 5;
    DefaultColWidth := min(tm.tmMaxCharWidth * 2 + 2, tm.tmAveCharWidth * 4);
    Height := GetEffectiveHeight;
    Width := GetEffectiveWidth;
    FUpdating := False;
  end;
end;

procedure TElCalendar.TriggerBeforeCellDraw(Canvas : TCanvas; RowNum, ColNum : integer; Date :
    TDateTime; CellType : TElCalendarCellTypes);
begin
  if assigned(FOnBeforeCellDraw) then
    FOnBeforeCellDraw(Self, Canvas, RowNum, ColNum, Date, CellType);
end;

function TElCalendar.DaysPrevMonth: Integer;
begin
  if Month > 1 then
    Result := LMDDaysPerMonth(Year, Month - 1)
  else
    Result := LMDDaysPerMonth(Year - 1, 12);
end;

procedure TElCalendar.SetShowOtherMonthDays(Value: Boolean);
begin
  if FShowOtherMonthDays <> Value then
  begin
    FShowOtherMonthDays := Value;
    Invalidate;
  end;
end;

procedure TElCalendar.SetOtherMonthDayColor(Value: TColor);
begin
  if FOtherMonthDayColor <> Value then
  begin
    FOtherMonthDayColor := Value;
    if ShowOtherMonthDays then
      Invalidate;
  end;
end;

procedure TElCalendar.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElCalendar.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElCalendar.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElCalendar.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElCalendar.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElCalendar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  GridLines : Integer;
  icolnum : integer;
  VertLineHeight,
  HorzLineWidth : integer;
begin
  if HandleAllocated then
  begin
    inherited;
    exit;
  end;
  if not FUpdating then
  begin
    if FShowWeekNum then
    begin
      GridLines := 8 * GridLineWidth;
      icolnum := 8;
    end
    else
    begin
      GridLines := 7 * GridLineWidth;
      icolnum := 7;
    end;

    if goVertLine in Options then
      VertLineHeight := GridLineWidth
    else
      VertLineHeight := 0;
    if goHorzLine in Options then
      HorzLineWidth := GridLineWidth
    else
      HorzLineWidth := 0;

    DefaultColWidth := (AWidth - VertLineHeight * GridLines) div icolnum;
    DefaultRowHeight := (AHeight - HorzLineWidth * RowCount) div RowCount;
  end;
  inherited;
end;

procedure TElCalendar.SetLineBorderColor(Value: TColor);
begin
  if FLineBorderColor <> Value then
  begin
    FLineBorderColor := Value;
    Invalidate;
  end;
end;

(*
procedure TElCalendar.FontChanged(Sender: TObject);
begin
  inherited;
  Canvas.Font.Assign(Font);
  if AutoSize then
  begin
    CalcSizes;
  end;
  if HandleAllocated then
    Invalidate;
end;
*)

procedure TElCalendar.SetAutoSize(Value: Boolean);
begin
  inherited;
  if HandleAllocated and Value then
    CalcSizes;
end;

procedure TElCalendar.WMWindowPosChanging(
  var Message: TWMWindowPosChanged);
begin
// nothing to do
end;

procedure TElCalendar.SetCustomCalendarNames(const Value: TElCustomCalendarNames);
begin
  FCustomCalendarNames.Assign(Value);
end;

procedure TElCalendar.NamesChanged(Sender: TObject);
begin
  if HandleAllocated then
    invalidate;
end;

initialization

  sDayS  := SLMDDay;
  sWeekS := SLMDWeek;

end.
