unit LMDListBox;
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

LMDListBox unit (FL)
--------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, StdCtrls, ExtCtrls, Controls, ComCtrls, Classes, Graphics, Forms,
  LMDTypes, LMDBase, LMDBaseLabel, LMDClass, LMDIniCtrl, LMDHeaderControl,
  LMDCustomListBox, LMDExtListBox, LMDCustomScrollBox,
  LMDVldBase;

const
  IDS_LISTBOXSAVE='ListBoxData';  // do not localize!

type
  TLMDLBGridLines = (glNone, glHorizontal, glVertical, glBoth);
  TLMDLBCompareItemEvent = procedure (Sender : TObject; const s1, s2 : String; var result : ShortInt) of object;

  TLMDLBGetLineSettingsEvent=procedure(Sender : TObject; Index:Integer; State:TOwnerDrawState; var bColor:TColor; aFont:TFont) of object;

  {------------------------------- TLMDListBox --------------------------------}
  TLMDListBox=class(TLMDCustomScrollBox, ILMDValidatingMsgControl)
  private
    function GetBool(Index:Integer):Boolean;
    function GetCanvas:TCanvas;
    function GetColor(Index:Integer):TColor;
    function GetCursor(Index:Integer):TCursor;
    function GetFont(Index:Integer):TFont;
    function GetHint:String;
    function GetImeMode:TImeMode;
    function GetImeName:TImeName;

    function GetInteger(Index:Integer):Integer;
    function GetItems:TStrings;
    function GetDragMode:TDragMode;
    function GetMeasureItemEvent:TMeasureItemEvent;
    function GetSectionEvent:TSectionNotifyEvent;
    function GetSectionTrackEvent:TSectionTrackEvent;
    function GetSelected(index:integer):Boolean;
    function GetDrawSectionEvent: TDrawSectionEvent;
    function GetControlBar: TControlScrollBar;
    // V6.01
    function GetOnData:TLBGetDataEvent;
    function GetOnDataFind:TLBFindDataEvent;
    function GetCount:Integer;
    procedure SetOnData(aValue:TLBGetDataEvent);
    procedure SetOnDataFind(aValue:TLBFindDataEvent);
    procedure SetCount(aValue:Integer);
    procedure SetBool(Index:Integer;aValue:Boolean);
    procedure SetColor(Index:Integer; aValue:TColor);
    procedure SetCursor(Index:Integer; aValue:TCursor);
    procedure SetGridLines(aValue:TLMDLBGridLines);
    procedure SetDelimiter(aValue:Char);
    procedure SetDragMod(aValue:TDragMode);
    procedure SetFont(Index:Integer; aValue:TFont);
    procedure SetHint(aValue:String);
    procedure SetImeMode(aValue:TImeMode);
    procedure SetImeName(aValue:TImeName);
    procedure SetInteger(Index:Integer; aValue:Integer);
    procedure SetListBoxStyle(aValue:TListBoxStyle);
    procedure SetMeasureItemEvent(aValue:TMeasureItemEvent);
    procedure SetSelectedFontStyle(const aValue:TFontStyles);
    procedure SetPenStyle(const Index: Integer; const Value: TPenStyle);
    procedure SetSectionEvent(aValue:TSectionNotifyEvent);
    procedure SetSectionTrackEvent(aValue:TSectionTrackEvent);
    procedure SetDrawSectionEvent(aValue:TDrawSectionEvent);

    // 4.0
    procedure SetItems(aValue:TStrings);
    procedure SetVirtualWidth(aValue:Integer);
    procedure SetSelected(index:integer;flag:boolean);

    // 4.0 Ini-Support
    procedure SetIniLink(aValue:TLMDIniCtrl);
    function SaveKey:Boolean;
    function SaveSection:Boolean;
    {-----}

    // 6.0
    procedure SetOptions (aValue : TLMDLabelOptions);
    //----
     procedure SetHeaderSections(aValue:THeaderSections);
    function GetHeaderSections:THeaderSections;
    // --
    procedure CMTRANSPARENTCHANGED(var Message: TMessage); message CM_TRANSPARENTCHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    function GetOnSelect: TNotifyEvent;
    procedure SetOnSelect(const Value: TNotifyEvent);
    function GetListBox: TLMDExtListBox;
    //procedure GetChange(Sender: TObject);
  protected
    //4.0
    FHeader        : TLMDHeaderControl;

    FDelimiter     : Char;
    FDesc,
    FHScroll       : Boolean;
    FGridLines     : TLMDLBGridLines;

    //FListBox       : TLMDExtListBox;
    FListBox       : TLMDCustomListBox;
    FListBoxStyle  : TListBoxStyle;
    FSelectedFontColor,
    FGridHorzColor,
    FGridVertColor,
    FSelColor      : TColor;
    FSelectedFontStyle:TFontStyles;
    FOnHeaderSized : TSectionEvent;
    FOnHeaderResize: TSectionNotifyEvent;
    FOnDrawItem    : TDrawItemEvent;
    FOnCompare     : TLMDLBCompareItemEvent;

    // 4.0
    FVirtualWidth  : Integer;   //-> Width of inner ListBox
    {Ini-Support}
    FIniLink       : TLMDIniCtrl;
    FIniUse        : TLMDIniUse;
    FSection,
    FKey           : String;
    FOnIniReadData,
    FOnIniWriteData: TLMDIniCtrlEvent;
    // 6.0
    FOptions          : TLMDLabelOptions;
    FOnPrepareDrawItem:TDrawItemEvent;
    FGridHorzStyle: TPenStyle;
    FGridVertStyle: TPenStyle;

    // 7.0
    FVirtualAutoWidth,
    FAlternateLineColors:Boolean;
    FAltColor,
    FAltFontColor:TColor;
    FOnGetLineSettings:TLMDLBGetLineSettingsEvent;

    procedure AlignControls(AControl: TControl;var Rect : TRect);override;
    procedure InternalMouseMove(Shift: TShiftState; X, Y: Integer);virtual;
    function  CalcColumnsWidth:Integer;
    procedure CreateParams(var Params: TCreateParams); override;

    procedure CreateHeader; virtual;
    procedure CreateLB; virtual;

    procedure DefineProperties(Filer:TFiler);override;
    procedure DoReadData;dynamic;
    procedure DoWriteData;dynamic;
    procedure DoThemeChanged; override;
    procedure DrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
                       State: TOwnerDrawState); virtual;
    function  GetOptionsFlag:Word;
    procedure HeaderSized(Sender:THeaderControl;Section: THeaderSection);
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation);override;
    procedure ReadState(Reader:TReader);override;
    procedure Resize; override;
    // 7.0
    procedure UpdateVirtualWidth;
    // ---
    function GetThemedBkColor: TColor;
    function GetThemedTextColor: TColor;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    procedure SpecialSort(sortOrder : Array of Integer);overload;
    procedure SpecialSort;overload;

    function  AddLine(const X:array of String):Integer;
    procedure Clear;
    procedure PrepareDrawItem(Rect:TRect;State:TOwnerDrawState;Index:Integer=-1);
    procedure SetFocus;override;
    function  GetIniString:String;
    procedure SetIniString(w:String);
    function  GetPartString(const w:String;col:Integer):String;
    function  ItemAtPos(Pos:TPoint;Existing:Boolean):Integer;
    function  ItemPart(Index:Integer; Col:Integer):String;
    procedure SetItemPart(Index:Integer; Col:Integer; partStr : String);
    function  Focused: Boolean; override;

    // 4.0
    procedure ReadData;
    procedure WriteData;
    property Canvas:TCanvas read GetCanvas;
    property Header:TLMDHeaderControl read FHeader;
    property ItemIndex:Integer index 1 read GetInteger write SetInteger;
    property LB:TLMDExtListBox read GetListBox;
    property SectionCount:Integer index 5 read GetInteger;
    property SelCount:Integer index 3 read GetInteger;
    property Selected[Index:integer]:Boolean read GetSelected write SetSelected;
    property Showing;
    property TopIndex:Integer index 2 read GetInteger write SetInteger;

    property SortDescending : Boolean read FDesc write FDesc default false;
    //7.0
    property ColumnsWidth:Integer read CalcColumnsWidth;
    //--
    property Count: Integer read GetCount write SetCount;

    //Validation support, May 2006, RS
    procedure SetErrorMessage(val : TLMDString; errorLevel: integer);
    function GetLastErrorMessage : TLMDString;
    property CtlXP;  // compatiblity
  published
    property About;
    property Align;
    property AllowResize:Boolean index 5 read GetBool write SetBool default True;
    property AutoScroll:Boolean index 21 read GetBool;
    property Bevel;

    property Color:TColor index 0 read GetColor write SetColor default clWhite;
    property Cursor:TCursor index 0 read GetCursor write SetCursor default crDefault;
    property Delimiter:Char read FDelimiter write SetDelimiter default ';';

    property DragCursor:TCursor index 1 read GetCursor write SetCursor default crDrag;
    property DragMode:TDragMode read GetDragMode write SetDragMod default dmManual;
    property Enabled:Boolean index 0 read GetBool write SetBool default True;
    property ExtendedSelect:Boolean index 1 read GetBool write SetBool default True;

    property Font:TFont index 1 read GetFont write SetFont;
    property GridHorzColor:TColor index 2 read FGridHorzColor write SetColor default clSilver;
    property GridLines:TLMDLBGridLines read FGridLines write SetGridLines default glNone;
    property GridVertColor:TColor index 3 read FGridVertColor write SetColor default clSilver;
    property HeaderFont:TFont index 0 read GetFont write SetFont;
    property HeaderHeight:Integer index 0 read GetInteger write SetInteger default 17;
    property HeaderSections:THeaderSections read GetHeaderSections write SetHeaderSections;
    property HeaderVisible:Boolean index 2 read GetBool write SetBool default True;
    property HeaderHotTrack:Boolean index 12 read GetBool write SetBool default false;
    property HeaderFlat:Boolean index 13 read GetBool write SetBool default false;
    property Hint:String read GetHint write SetHint;
    property ImeMode:TImeMode read GetImeMode write SetImeMode default imDontCare;
    property ImeName:TImeName read GetImeName write SetImeName;
    property ItemHeight:Integer index 4 read GetInteger write SetInteger;
    property Items:TStrings read GetItems write SetItems;
    property MultiSelect:Boolean index 3 read GetBool write SetBool default false;
    property ParentShowHint:Boolean index 7 read GetBool write SetBool default True;
    property PopupMenu;
    property SelectedColor:TColor index 1 read GetColor write SetColor default clHighLight;

    property ShowHint:Boolean index 6 read GetBool write SetBool default false;
    property Sorted:Boolean index 4 read GetBool write SetBool default false;

    property Style:TListBoxStyle read FListBoxStyle write SetListBoxStyle default lbStandard;
    property TabOrder;
    property TabStop:Boolean index 8 read GetBool write SetBool default True;
    property Visible;

    // NEW in 4.0
    // ------------
    // hide the VertScrollBar property
    property VertScrollBar:TControlScrollBar read GetControlBar stored false;  // 7.01 -> Change for VCL.NET
    property VirtualWidth:Integer read FVirtualWidth write SetVirtualWidth default 0;

    //Ini-Support
    property IniLink:TLMDIniCtrl read FIniLink write SetIniLink;
    property IniUse:TLMDIniUse read FIniUse write FIniUse default ioNone; {not active by default}
    property Section:String read FSection write FSection stored SaveSection;
    property IniKey:String read FKey write FKey stored SaveKey;
    property OnIniReadData:TLMDIniCtrlEvent read FOnIniReadData write FOnIniReadData;
    property OnIniWriteData:TLMDIniCtrlEvent read FOnIniWriteData write FOnIniWriteData;

    // NEW in 6.0
    // ------------
    property ColumnOptions:TLMDLabelOptions read FOptions write SetOptions default [];

    // NEW in 7.0
    // ------------
    property AlternateColors:Boolean index 14 read FAlternateLineColors write SetBool default false;
    property AltLineColor:TColor index 5 read FAltColor write SetColor default clSilver;
    property AltFontColor:TColor index 6 read FAltFontColor write SetColor default clWindowText;
    property BeveledFocus:Boolean index 15 read GetBool write SetBool default false;
    property BevelFocusShadowColor:TColor index 7 read GetColor write SetColor default clGray;
    property BevelFocusLightColor:TColor index 8 read GetColor write SetColor default clWhite;
    property VirtualAutoWidth:Boolean index 16 read FVirtualAutoWidth write SetBool default false;
    property OnGetLineSettings:TLMDLBGetLineSettingsEvent read FOnGetLineSettings write FOnGetLineSettings;
    // ---

    property GridHorzStyle:TPenStyle index 0 read FGridHorzStyle write SetPenStyle default psSolid;
    property GridVertStyle:TPenStyle index 1 read FGridVertStyle write SetPenStyle default psSolid;
    property ItemAutoHeight:Boolean index 9 read GetBool write SetBool default false;
    property SelectedFontColor:TColor index 4 read FSelectedFontColor write SetColor default clHighlightText;
    property SelectedFontStyle:TFontStyles read FSelectedFontStyle write SetSelectedFontStyle default [];
    property Transparent;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;    

     {Events}
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;

    // specific events
    // ListBox
    property OnMeasureItem:TMeasureItemEvent read GetMeasureItemEvent write SetMeasureItemEvent;
    property OnDrawItem:TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    // 6.0
    property OnPrepareDrawItem:TDrawItemEvent read FOnPrepareDrawItem write FOnPrepareDrawItem;

    // Header
    property OnHeaderSized:TSectionEvent read FOnHeaderSized write FOnHeaderSized;
    property OnHeaderDrawSection:TDrawSectionEvent read GetDrawSectionEvent write SetDrawSectionEvent;
    property OnHeaderSectionClick:TSectionNotifyEvent read GetSectionEvent write SetSectionEvent;
    property OnHeaderSectionResize:TSectionNotifyEvent read FOnHeaderResize write FOnHeaderResize;
    property OnHeaderSectionTrack:TSectionTrackEvent read GetSectionTrackEvent write SetSectionTrackEvent;

    property OnSelect:TNotifyEvent read GetOnSelect write SetOnSelect;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;

    // Sorting
    property OnSSCompareItem : TLMDLBCompareItemEvent read FOnCompare write FOnCompare;

    // V6 Enhancements
    property OnData: TLBGetDataEvent read GetOnData write SetOnData;
    property OnDataFind: TLBFindDataEvent read GetOnDataFind write SetOnDataFind;
  end;

implementation

uses
  Types, SysUtils, CommCtrl, Themes, LMDThemes,
  LMDStrings, LMDConst, LMDUtils, LMDProcs;

type
  // ListBox Cracker
  TLMDMyListBox=class(TLMDExtListBox)
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  end;

  procedure TLMDMyListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
  begin
    inherited;
    if Parent.HandleAllocated then
      TLMDListBox(Parent).InternalMouseMove(Shift, X,Y);
  end;

  procedure TLMDListBox.InternalMouseMove(Shift: TShiftState; X, Y: Integer);
  begin
  end;

{********************* Class TLMDListBox **************************************}
{------------------ Private ---------------------------------------------------}
function TLMDListBox.AddLine(const X:array of String):Integer;
begin
  result:=Items.Add(LMDAnsiCodeString(X, FDelimiter));
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetIniString(w:String);
var
  temp:TStringList;
  i:Integer;
begin
  temp:=TStringList.Create;
  try
    LMDAnsiParseToStrList(w,',', temp);
    if temp.count=0 then exit;
    for i:=0 to Pred(temp.Count) do //JH -1 removed behind .count (otherwies last col size will be dropped)
      begin
        if FHeader.Sections.Count<i+1 then
          begin
            FHeader.Sections.Add;
            FHeader.Sections[Pred(FHeader.Sections.Count)].Text:=Format('S. %d', [i+1]);
          end;
          FHeader.Sections[i].Width:=StrToInt(temp[i]);
      end;
  finally
    temp.free;
  end;
end;

{RM 3.5.12}
{------------------------------------------------------------------------------}
function TLMDListBox.GetIniString:String;
var
  i:Integer;
begin
  result:='';
  if FHeader.Sections.Count=0 then exit;
  result:=inttostr(FHeader.Sections[0].Width);
  for i:=1 to Pred(FHeader.Sections.Count) do
    result:=result+','+inttostr(FHeader.Sections[i].Width);
end;

{------------------------------------------------------------------------------}
function TLMDListBox.ItemPart(Index:Integer; Col:Integer):String;
begin
  result:={$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF}(Items[index], FDelimiter, Col);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetItemPart(Index:Integer; Col:Integer; partStr:String);
var
  s: String;
begin
  if Index >= Items.Count then
    exit;
  s := Items[index];
  LMDAnsiSetCodedString(s, partStr, FDelimiter, Col);
  Items[index] := s;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.UpdateVirtualWidth;
var
  tmp:Integer;
begin
  if FVirtualAutoWidth then
  begin
    tmp:=CalcColumnsWidth;
    if tmp>{FListBox.}ClientWidth then
      FVirtualWidth:=tmp
    else
      VirtualWidth:=0;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.Focused: Boolean;
begin
  result := inherited Focused or lb.Focused;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetPartString(const w:String;col:Integer):String;
begin
  result:={$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF}(w, FDelimiter, Col);
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetBool(index:Integer):Boolean;
begin
  case index of
    0: result:=FListBox.Enabled;
    1: result:=FListbox.ExtendedSelect;
    2: result:=FHeader.Visible;
    3: result:=FListbox.MultiSelect;
    4: result:=FlistBox.Sorted;
    5: result:=FHeader.Enabled;
    6: result:=FListBox.ShowHint;
    7: result:=FListBox.ParentShowHint;
    8: result:=FListBox.TabStop;
    9: result:=FListBox.ItemAutoHeight;
   12: result:=FHeader.HotTrack;
   13: result:=FHeader.Style=hsFlat;
   15: result:=FListBox.BeveledFocus;
  else
    result:=false
  end;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetCanvas:TCanvas;
begin
  result:=FListBox.Canvas;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetColor(Index:Integer):TColor;
begin
  case Index of
    0: Result:=FListBox.Color;
    1: Result:=FSelColor;
    7: Result:=FListBox.BevelFocusShadowColor;
    8: Result:=FListBox.BevelFocusLightColor;
  else
    result:=clWhite
  end;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetControlBar: TControlScrollBar;
begin
  result:=inherited VertScrollBar;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetCursor(Index:Integer):TCursor;
begin
  case index of
    0: result:=FListBox.Cursor;
    1: result:=FListBox.DragCursor;
  else
    result:=crDefault;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetDragMode:TDragMode;
begin
 result:=FListBox.DragMode;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetFont(index:Integer):TFont;
begin
  case index of
    0:result:=FHeader.Font;
    1:result:=FListBox.Font;
  else
    result:=nil
  end;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetHint:String;
begin
  result:=FListBox.Hint;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetImeName:TImeName;
begin
  result:=FListBox.ImeName;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetImeMode:TImeMode;
begin
  result:=FListBox.ImeMode;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetInteger(index:Integer):Integer;
begin
  case index of
    0:result:=FHeader.Height;
    1:result:=FListBox.Itemindex;
    2:result:=FListBox.TopIndex;
    3:result:=FListBox.SelCount;
    4:result:=FListBox.ItemHeight;
    5:result:=FHeader.Sections.Count;
  else
    result:=0;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetSectionEvent:TSectionNotifyEvent;
begin
  result:=FHeader.OnSectionClick;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetDrawSectionEvent:TDrawSectionEvent;
begin
  result:=FHeader.OnDrawSection;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetSectionTrackEvent:TSectionTrackEvent;
begin
  result:=FHeader.OnSectionTrack;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetItems:TStrings;
begin
  result:=LB.Items;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetCount;
begin
  result:=LB.Count;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetOnData;
begin
  result:=LB.OnData;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetOnDataFind;
begin
  result:=LB.OnDataFind;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetMeasureItemEvent:TMeasureItemEvent;
begin
  result:=LB.OnMeasureItem;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetSelected(index:integer):Boolean;
begin
  result:=FListBox.Selected[index];
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetThemedBkColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scListBox)
  else
  {$ENDIF}
    Result := Self.Color;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetThemedTextColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleFontColor(sfListItemTextNormal)
  else
  {$ENDIF}
    Result := Font.Color;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetBool(index:Integer;aValue:Boolean);
begin
  case index of
    0: if FListBox.Enabled<>aValue then
         begin
           FListBox.Enabled:=aValue;
           FHeader.Enabled:=aValue;
           inherited Enabled := aValue;
         end;
    1: if FListBox.ExtendedSelect<>aValue then FListBox.ExtendedSelect:=aValue;
    2: if aValue<>FHeader.Visible then
         begin
           FHeader.Visible:=aValue;
           ReAlign;
         end;
    3: if FListBox.MultiSelect<>aValue then FListBox.MultiSelect:=aValue;
    4: if FListBox.Sorted<>aValue then FListBox.Sorted:=aValue;
    5: if aValue<>FHeader.Enabled then FHeader.Enabled:=aValue;
    6: if aValue<>FListBox.ShowHint then
         begin
           FListBox.ShowHint:=aValue;
           FHeader.ShowHint:=aValue;
         end;
    7: if aValue<>FListBox.ParentShowHint then
         begin
           FListBox.ParentShowHint:=aValue;
           FHeader.ParentShowHint:=aValue;
         end;
    8: if FListBox.TabStop<>aValue then FListBox.TabsTop:=aValue;
    9: FListBox.ItemAutoHeight:=aValue;
   12: FHeader.HotTrack:=aValue;
   13: if aValue then FHeader.Style:=hsFlat else FHeader.Style:=hsButtons;
   14: begin
         FAlternateLineColors:=aValue;
         if Visible and not (csLoading in ComponentState) then
           FListBox.Refresh;
       end;
   15: FListBox.BeveledFocus:=aValue;
   16: if FVirtualAutoWidth<>aValue then
        begin
           FVirtualAutoWidth:=aValue;
           if aValue then
             begin
               UpdateVirtualWidth;
               ReAlign;
               FListBox.Invalidate;
             end
           else
             VirtualWidth:=0;
         end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetOnData(aValue:TLBGetDataEvent);
begin
  LB.OnData:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetCount;
begin
  LB.Count:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetOnDataFind(aValue:TLBFindDataEvent);
begin
  LB.OnDataFind:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetColor(Index:Integer; aValue:TColor);
begin
  case Index of
    0: if FListBox.Color=aValue then exit else FListBox.Color:=aValue;
    1: if FSelColor=aValue then exit else FSelColor:=aValue;
    2: if FGridHorzColor=aValue then exit else FGridHorzColor:=aValue;
    3: if FGridVertColor=aValue then exit else FGridVertColor:=aValue;
    4: if FSelectedFontColor=aValue then exit else FSelectedFontColor:=aValue;
    5: if FAltcolor=aValue then exit else FAltColor:=aValue;
    6: if FAltFontcolor=aValue then exit else FAltFontColor:=aValue;
    7: if FListBox.BevelFocusShadowColor=aValue then exit else FListBox.BevelFocusShadowColor:=aValue;
    8: if FListBox.BevelFocusLightColor=aValue then exit else FListBox.BevelFocusLightColor:=aValue;
  end;
  FListBox.Refresh;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetCursor(Index:Integer; aValue:TCursor);
begin
  case index of
    0: FListBox.Cursor := aValue;
    1: FListBox.DragCursor := aValue;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetDelimiter(aValue:Char);
begin
  if aValue<>FDelimiter then
    begin
      FDelimiter:=aValue;
      FListBox.Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetDragMod(aValue:TDragMode);
begin
  FListBox.DragMode:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetFont(index:Integer;aValue:TFont);
begin
  case index of
    0:FHeader.Font.Assign(aValue);
    1:FListBox.Font.Assign(aValue);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetGridLines(aValue:TLMDLBGridLines);
begin
  if aValue<>FGridLines then
    begin
      FGridLines:=aValue;
      FListBox.Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetHint(aValue:String);
begin
  if aValue<>FListBox.Hint then
    begin
      FListBox.Hint:=aValue;
      FHeader.Hint:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetImeMode(aValue:TImeMode);
begin
  FListBox.ImeMode:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetImeName(aValue:TImeName);
begin
  FListBox.ImeName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetInteger(index:Integer;aValue:Integer);
begin
  case index of
    0:if FHeader.Height<>aValue then
        begin
          FHeader.Height:=aValue;
          ReAlign;
        end;
    1:FListBox.ItemIndex:=aValue;
    2:FListBox.TopIndex:=aValue;
    4:FListBox.ItemHeight:=aValue;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetListBoxStyle(aValue:TListBoxStyle);
begin
  if aValue<>FListboxStyle then
  begin
    FListBoxStyle:=aValue;
    LB.MeasureItemEvent:=FListBoxStyle in [lbVirtualOwnerDraw, lbOwnerDrawVariable];
    LB.VirtualMode:=FListBoxStyle in [lbVirtualOwnerDraw, lbVirtual];
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetItems(aValue:TStrings);
begin
  FListbox.Items.Assign(aValue);
end;
{------------------------------------------------------------------------------}
procedure TLMDListBox.SetPenStyle(const Index: Integer; const Value: TPenStyle);
begin
  case index of
    0: if FGridHorzStyle=Value then exit else FGridHorzStyle:=Value;
    1: if FGridVertStyle=Value then exit else FGridVertStyle:=Value;
  end;
  FListBox.Refresh;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetMeasureItemEvent(aValue:TMeasureItemEvent);
begin
  FListBox.OnMeasureItem:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetDrawSectionEvent(aValue:TDrawSectionEvent);
begin
  FHeader.OnDrawSection:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetSelectedFontStyle(const aValue:TFontStyles);
begin
  if aValue<>FSelectedFontStyle then
    begin
      FSelectedFontStyle:=aValue;
      if not (csDesigning in ComponentState) then
        FListBox.Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetSectionEvent(aValue:TSectionNotifyEvent);
begin
  FHeader.OnSectionClick:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetSectionTrackEvent(aValue:TSectionTrackEvent);
begin
  FHeader.OnSectionTrack:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetSelected(index:integer;flag:boolean);
begin
  FListBox.Selected[index]:=flag;
end;

// 4.0
{------------------------------------------------------------------------------}
procedure TLMDListBox.SetVirtualWidth(aValue:Integer);
begin
  if (aValue<>FVirtualWidth) and (aValue>=0) then
    begin
      FVirtualWidth:=aValue;
      if FVirtualAutoWidth then
        UpdateVirtualWidth;
      if FVirtualWidth=0 then
        begin
          FListBox.Align:=alClient;
          FListBox.Invalidate;
          FHeader.Align:=alTop;
        end
      else
        begin
          HorzScrollBar.Range:=FVirtualWidth;
          HorzScrollBar.Position:=0;
          FListBox.Align:=alNone;
          FListBox.Left:=0;
          FHeader.Align:=alNone;
          FHeader.Left:=0;
          FListBox.Width:=FVirtualWidth;
        end;
      ReAlign;
    end;
end;
{------------------------------------------------------------------------------}
procedure TLMDListBox.SetOptions (aValue : TLMDLabelOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      FListBox.Refresh;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDListBox.GetOnSelect: TNotifyEvent;
begin
 result:=FListBox.OnSelect;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDListBox.SetOnSelect(const Value: TNotifyEvent);
begin
 FListBox.OnSelect:=Value;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetOptionsFlag:Word;
const
  OPTFLAGS:array[TLMDLabelOption] of Word = (DT_PATH_ELLIPSIS, DT_END_ELLIPSIS, DT_EDITCONTROL,0);
var
  i:TLMDLabelOption;
begin
  result:=DT_NOPREFIX;
  for i:=Low(TLMDLabelOption) to High(TLMDLabelOption) do
    if i in FOptions then result:=result or OptFlags[i];
  if result<>0 then result:=result or DT_MODIFYSTRING;
end;

//compatability for older versions
{------------------------------------------------------------------------------}
{procedure TLMDListBox.SetHeaderStrings(aValue:TLMDHeaderStrings);
begin
  raise Exception.Create(IDS_PROPERTYNOTUSED);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetHeaderSections(aValue:THeaderSections);
begin
  FHeader.Sections.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDListBox.GetHeaderSections:THeaderSections;
begin
  result:=FHeader.Sections;
end;

{------------------------------------------------------------------------------}
procedure TLMDListbox.HeaderSized(Sender:THeaderControl;Section: THeaderSection);
{$IFDEF LMDCOMP7}
var
  aRect:TRect;
{$ENDIF}
begin
  UpdateVirtualWidth;
  ReAlign;
  {$IFDEF LMDCOMP7}
  If VirtualWidth>0 then
    aRect:=Rect(0,0,HorzScrollBar.Position+ClientWidth, ClientHeight)
  else
    aRect:=Bevel.ClientRect(ClientRect);
  LMDInvalidateRect(FListBox.Handle, aRect, true);
  {$ENDIF}
  FlistBox.Refresh;
  if Assigned(FOnHeaderSized) then FOnHeaderSized(Sender, Section.Index, Section.Width);
  if Assigned(FOnHeaderResize) then FOnHeaderResize(Sender, Section);
end;


{------------------------------------------------------------------------------}
function TLMDListbox.SaveKey:Boolean;
begin
  result:=(FKey<>'') and (FKey<>IDS_LISTBOXSAVE);
end;

{------------------------------------------------------------------------------}
function TLMDListbox.SaveSection:Boolean;
begin
  result:=(FSection<>'') and (FSection<>IDS_COMMON);
end;

{------------------------------------------------------------------------------}
procedure TLMDListbox.SetIniLink(aValue:TLMDIniCtrl);
begin
  FIniLink:=aValue;
  if FIniLink<>nil then FIniLink.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  tmpList:TStringList;
  tmpItem:String;
  tmpRect:TRect;
  i,j:Integer;
  oldflags, flags:LongInt;

const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
begin
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then
    Exit;

  if (FListBoxStyle<>lbStandard) and Assigned(FOnDrawItem) then
  begin
    FOnDrawItem(Control, Index, Rect, State);
    Exit;
  end;

  with FListBox.Canvas do
    begin
      PrepareDrawItem(Rect, State, Index);

      if Assigned(FOnPrepareDrawItem) then
        FOnPrepareDrawItem(Control, Index, Rect, State);

      oldflags := GetOptionsFlag;
      oldflags := DrawTextBiDiModeFlags(oldflags);
      tmpItem  := FListBox.Items[Index];

      if Length(LMDAnsiTrim(tmpItem))<>0 then
        begin
           tmpList:=TStringList.Create;
           try
             tmpRect:=Rect;

             if FHeader.Sections.Count=0 then
               begin
                 flags:=oldflags or Alignments[taLeftJustify]; // 7.00.60
                 tmpRect.Left:=tmpRect.Left+2;
                 DrawText(FListBox.Canvas.Handle, int_Ref(tmpItem), Length(tmpItem), tmpRect, flags);
                 //TextRect(tmpRect, tmprect.Left+2, tmpRect.Top, tmpItem);
               end
             else
               begin
                 LMDAnsiParseToStrList(tmpItem, FDelimiter, tmpList);

                 for i:=0 to Pred(tmpList.Count) do
                   begin
                     tmpRect.Right:=tmpRect.Left+FHeader.Sections[i].Width-1;
                     if tmpRect.Right>FListBox.ClientWidth then tmpRect.Right:=FListBox.ClientWidth-1;

                     flags:=oldflags or Alignments[FHeader.Sections[i].Alignment];
                     tmpRect.Left:=tmpRect.Left+1;

                     // 6.0 Support of Alignment
                     // Extended Drawing Support
                     DrawText(FListBox.Canvas.Handle, int_Ref(tmpList[i]), Length(tmpList[i]), tmpRect, flags);

                     tmpRect.Left:=tmpRect.Right+1; // +1 (-1 from above:=0)
                     if Pred(FHeader.Sections.Count)=i then break;
                   end;

                 if FGridLines in [glVertical, glBoth] then
                   begin
                     Pen.Width:=1;
                     Pen.Style:=FGridVertStyle;
                     Pen.Color:=FGridVertColor;
                     j:=Rect.Left;
                     for i:=0 to Pred(FHeader.Sections.Count) do
                       begin
                         Inc(j, FHeader.Sections[i].Width);
                         if Abs(j-ClientWidth)<2 then Continue;  // don't draw last vertical line if it is last column at the left edge
                         MoveTo(j-1, ClientRect.Top);
                         LineTo(j-1, ClientRect.Bottom);
                       end;
                   end;
               end;
             if FGridLines in [glHorizontal, glBoth] then
               begin
                 Pen.Width:=1;
                 Pen.Style:=FGridHorzStyle;
                 Pen.Color:=FGridHorzColor;
                 MoveTo(Rect.Left, Rect.Bottom-1);
                 LineTo(Rect.Right, Rect.Bottom-1);
               end;
           finally
             tmpList.free;
           end;
        end;
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.PrepareDrawItem(Rect: TRect;
  State: TOwnerDrawState; Index: Integer = -1);
var
  tmpc,
  tmpfc: TColor;
  utm: TLMDThemeMode;
begin
  with FListBox.Canvas do
    begin
      if odSelected in State then
       begin
         tmpc       := FSelColor;
         tmpfc      := FSelectedFontColor;
         Font.Style := FSelectedFontStyle;
       end
       else
       begin
         utm        := UseThemeMode;
         Font.Style := Self.Font.Style;

         if FAlternateLineColors and (Index<>-1) and (Index Mod 2 = 1)then
         begin
           tmpc  := FAltColor;
           tmpfc := FaltFontColor;
         end
         else if utm = ttmPlatform then
         begin
           tmpfc := GetThemedTextColor;
           tmpc  := GetThemedBkColor;
         end
         else
         begin
           tmpfc := Self.Font.Color;
           tmpc  := Self.Color;
         end;
         if oddisabled in State then
           tmpfc := clInactiveCaption;
       end;

       Font.Color := tmpfc;

        // 7.0
       if Assigned(FOnGetLineSettings) then
         FOnGetLineSettings(self, Index, State, tmpc, Font);

       if not Transparent then
       begin
         Brush.Color := tmpc;
         Brush.Style := bsSolid;
         FillRect(Rect);
       end;

       Brush.Style := bsClear;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.CMTRANSPARENTCHANGED(var Message: TMessage);
begin
  inherited;
  FListBox.Transparent:=self.Transparent;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
{$IFDEF LMDCOMP7}
var
  aRect:TRect;
{$ENDIF}
begin
  Message.result:=1;
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then exit;
  if (FGridLines in [glVertical, glBoth]) and FListBox.HandleAllocated then
    begin
      {$IFDEF LMDCOMP7}
      aRect:=Bevel.ClientRect(ClientRect);
      LMDInvalidateRect(FListBox.Handle, aRect, true);
      {$ELSE}
      FListBox.Refresh;
      {$ENDIF}
    end;
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDListBox.AlignControls(AControl: TControl;var Rect : TRect);
begin
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then exit;
  inherited AlignControls(AControl, Rect);
  DisableAlign;
  //UpdateVirtualWidth;
  if FVirtualWidth>0 then
    begin
      HorzScrollBar.Range:=FVirtualWidth;
      if FListBox.Align=alClient then FListBox.Align:=alNone;
      if FHeader.Visible then
        begin
          FHeader.Width:=FVirtualWidth;
          FListBox.Width:=FHeader.Width;
          FListBox.Top:=FHeader.Height;
        end
      else
        begin
          FListBox.Width:=FVirtualWidth;
          FListBox.Top:=0;
        end;
      FListBox.Height:=ClientHeight-FListBox.Top;
    end
  else
    HorzScrollBar.Range:=0;
  EnableAlign;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.CalcColumnsWidth: Integer;
var
  i:Integer;
begin
  result:=0;
  for i:=0 to FHeader.Sections.Count-1 do
    Inc(result, FHeader.SectionWidth[i]);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  //Filer.DefineProperty('ItemHeight', ReadI, WriteI, FListBoxStyle<>lbStandard);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.DoReadData;

  procedure DoReadValues(aLink:TLMDIniCtrl);
  var
    tmp:String;
  begin
     with aLink do
       begin
         tmp:=ReadString(FSection, FKey, '');
         if tmp<>'' then SetIniString(tmp);
       end;
     if Assigned(FOnIniReadData) then FOnIniReadData(self, aLink, FSection);
  end;

begin
  if (FIniUse=ioUseLink) and Assigned(FIniLink) then
    DoReadValues(FiniLink)
  else
    if FIniUse=ioUseGlobal then
      DoReadValues(LMDApplication.Ini)
    else
     if Assigned(FOnIniReadData) then FOnIniReadData(self, nil, FSection);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.DoThemeChanged;
begin
  inherited;
  if Assigned(FHeader) then
    FHeader.ThemeMode := ThemeMode;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.DoWriteData;

  procedure WriteValues(aLink:TLMDIniCtrl);
  var
    tmp:String;
  begin
    tmp:=GetInistring;
    if tmp='' then
      aLink.DeleteKey(FSection, FKey)
    else
      with aLink do WriteString(FSection, FKey, tmp);
    if Assigned(FOnIniWriteData) then FOnIniWriteData(self, aLink, FSection);
  end;

begin
  if (FIniUse=ioUseLink) and Assigned(FIniLink) then
    WriteValues(FiniLink)
  else
    if FIniUse=ioUseGlobal then
      WriteValues(LMDApplication.Ini)
    else
     if Assigned(FOnIniWriteData) then FOnIniWriteData(self, nil, FSection);
end;

{------------------------------------------------------------------------------}
{procedure TLMDListBox.GetChange(Sender:TObject);
begin
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDListbox.Loaded;
begin
  inherited Loaded;
  // assign event handler
  FListBox.OnClick:=OnClick;
  FListBox.OnDblClick:=OnDblClick;
  FListBox.OnEnter:=OnEnter;
  FListBox.OnExit:=OnExit;
  FListBox.OnDragDrop:=OnDragDrop;
  FListBox.OnDragOver:=OnDragOver;
  FListBox.OnEndDrag:=OnEndDrag;
  FListBox.OnStartDrag:=OnStartDrag;
  FListBox.OnMouseDown:=OnMouseDown;
  FListBox.OnMouseMove:=OnMouseMove;
  FListBox.OnMouseUp:=OnMouseUp;
  FListBox.OnKeyDown:=OnKeyDown;
  FListBox.OnKeyUp:=OnKeyUp;
  FListBox.OnKeypress:=OnKeyPress;

  FHeader.OnDragDrop:=OnDragDrop;
  FHeader.OnDragOver:=OnDragOver;
  FHeader.OnEndDrag:=OnEndDrag;
  FHeader.OnStartDrag:=OnStartDrag;

  if not (csDesigning in ComponentState) then DoReadData;
  UpdateVirtualWidth;
  ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.Notification(aComponent:TComponent;Operation:TOperation);
begin
  inherited Notification(aComponent,Operation);
  if csDestroying in ComponentState then exit;
  if (Operation=opRemove) then
    if aComponent=FIniLink then FIniLink:=nil;
  if (Operation=opInsert) then
  begin
    // attach IniCtrl automatically
    if (FIniUse=ioUseLink) and (aComponent is TLMDIniCtrl) and not Assigned(FIniLink) then
    FIniLink:=TLMDIniCtrl(aComponent);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.ReadState(Reader:TReader);
begin
  // 7.01 RM
  if not (Parent is TFrame) then
    FHeader.Sections.Clear;
  // ----
  inherited ReadState(Reader);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.Resize;
begin
  inherited Resize;
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then exit;
  ReAlign;
  FListBox.Invalidate;
end;

{----------------- Public -----------------------------------------------------}
{ procedure SpecialSort
  added: 00/05/18
  author: JH

  parameters: sortOrder = list of columns to be used as sorting index
              ([2,1] means sorting after column 2 + 1

  comments: very rudimentary implementation
            the string used for comparison has to be created for each compare
            => relatively high effort

  #############
  Changes: Sept 2001, JH
           rewritten compare method, now works accurate
           now compares partial strings as specified
           now returns in the OnCompare event complete strings to be compared (with delimiters)
}
procedure TLMDListBox.SpecialSort(sortOrder : Array of Integer);

  //0 = equal; -1 = Item[i] < Item[j]; 1 = Item[i] > Item[j]
  function comp (i: Integer; j: TStringItem; sortOrder : Array of Integer) : ShortInt;
  var
    c,
    k: Integer;
  begin
    if Assigned (FOnCompare) then FOnCompare (self, FListBox.Items[i], j.FString, result)
    else
      begin
        //estimate comparison result

        k := Low(sortOrder);
        c := sortOrder[0];

        while (k < High (sortOrder) + 1) and ({$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF} (FListBox.Items[i], FDelimiter, c) =
                                              {$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF} (j.FString, FDelimiter, c)) do
          begin
            inc (k);
            c := sortOrder[k];
          end;

        if {$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF} (FListBox.Items[i], FDelimiter, c) > {$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF} (j.FString, FDelimiter, c) then
          result := 1
        else
          if {$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF} (FListBox.Items[i], FDelimiter, c) < {$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF} (j.FString, FDelimiter, c) then
            result := -1
          else
            result := 0;
      end;
    //just invert the result for descending order
    if FDesc then result := result * -1;
  end;

  procedure QuickSort(iLo, iHi: Integer;sortOrder : Array of Integer);
  var
    Lo, Hi: Integer;
    Middle: TStringItem;
  begin
    Lo := iLo;
    Hi := iHi;
    //get item "in the middle"
    Middle.FString := FListBox.Items[(Lo + Hi) div 2];
    //Middle.FObject := FListBox.Items.Objects[(Lo + Hi) div 2];
    repeat
      //while the "first value's" order is lower as the order of the value
      //in the middle increment the lower border
      while comp(Lo,Middle, sortOrder) < 0 do Inc(Lo);
      //while the "last value's" order is higher as the order of the value
      //in the middle decrement the lower border
      while comp(Hi,Middle, sortOrder) > 0 do Dec(Hi);
      //
      if Lo <= Hi then
      begin
        FListBox.Items.Exchange (Lo, Hi);
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    //sort left part of items
    if Hi > iLo then QuickSort(iLo, Hi, sortOrder);
    //sort right part of items
    if Lo < iHi then QuickSort(Lo, iHi, sortOrder);
  end;

begin
  FListBox.Items.BeginUpdate;
  QuickSort (0, FListBox.Items.Count-1, sortOrder);
  FListBox.Items.EndUpdate;
end;
{ ---------------------------------------------------------------------------- }
procedure TLMDListBox.SpecialSort;
begin
  SpecialSort([]);
end;

{------------------------------------------------------------------------------}
constructor TLMDListBox.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle-[csAcceptsControls, csSetCaption];

  FDelimiter:=';';
  FHScroll:=False;

  FSelColor:=clHighLight;
  FGridHorzColor:=clSilver;
  FGridHorzStyle:=psSolid;
  FGridVertColor:=clSilver;
  FGridVertStyle:=psSolid;
  FSelectedFontColor:=clHighlightText;

  FGridLines:=glNone;
  FDesc := false;

  CreateHeader;
  CreateLB;

  FAltColor:=clSilver;
  FAltFontColor:=clWindowText;
  //Ini-Support
  FKey:=IDS_LISTBOXSAVE;
  FIniUse:=ioNone;
  FSection:=IDS_COMMON;
  //last
  inherited TabStop:=False;
  inherited AutoScroll:=True;
  Width:=100;
  Height:=100;
  inherited VertScrollBar.Visible:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.CreateHeader;
begin
  FHeader:=TLMDHeaderControl.Create(Self);
  with FHeader do
  begin
    Parent:=Self;
    OnSectionResize:=HeaderSized;
    TabStop:=False;
    FHeader.Align:=alTop;
    FHeader.Height:=17;  // 7.01
    ThemeGlobalMode := false;
    ThemeMode := ttmPlatform;
  end;
  FHeader.Sections.Add;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.CreateLB;
begin
  FListBox:=TLMDMyListBox.Create(Self);
  with FListBox do
  begin
    ParentCtl3D:=False;
    Ctl3D:=False;
    Borderstyle:=bsNone;
    Parent:=Self;
    Color:=clWindow;
    OnDrawItem := DrawItem;
    //Style:=lbOwnerDrawFixed;
    Align:=alClient;
  end;
end;

{------------------------------------------------------------------------------}
destructor TLMDListBox.Destroy;
begin
  if not (csDesigning in ComponentState) then DoWriteData;
  FListBox.OnDrawItem:=nil;
  FreeAndNil(FHeader);
  FreeAndNil(FListBox);

  inherited destroy;
end;

{------------------------------------------------------------------------------}
function TLMDListBox.ItemAtPos(Pos:TPoint;Existing:Boolean):Integer;
begin
  result:=FListBox.ItemAtPos(Pos,Existing);
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.Clear;
begin
  FListBox.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.SetFocus;
begin
  FListBox.SetFocus;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.WriteData;
begin
  DoWriteData;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBox.ReadData;
begin
  DoReadData;
end;

{------------------------------------------------------------------------------}
//Validation support, May 2006, RS
{------------------------------------------------------------------------------}

function TLMDListBox.GetLastErrorMessage: TLMDString;
begin
  if Self.Items.Count > 0 then
    Result := Self.Items[Self.Items.Count - 1];
end;

function TLMDListBox.GetListBox: TLMDExtListBox;
begin
  result := TLMDExtListBox(FListBox);
end;

procedure TLMDListBox.SetErrorMessage(val: TLMDString; errorLevel: integer);
begin
  if val <> '' then
    Self.Items.Add(val);
end;

end.
