unit LMDTextObject;
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

LMDTextObject unit (JH)
-----------------------

Text output capsulation, used in several controls for managing parser class affaires

ToDo
----

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Messages, SysUtils, Classes, Controls, Forms,
  LMDObject, LMDParser, LMDText, LMDProcs, 

  //needed for text + glyph rendering
  LMDButtonBase, LMDButtonLayout, LMDGlyphTextLayout, LMD3DCaption, LMDGraph,
  LMDUtils, LMDGraphUtils,

  //include the default parsers
  LMDHTMLParser,        //some kind of 'sub' HTML parser
  LMDPlainTextParser,   //a plain ascii text parser
  LMDSimpleXMLParser,
  LMDDBFParser,
  LMDCSVParser;

type
  TLMDLinkClickEvent = procedure(Button: TMouseButton;
    aShift: TShiftState; const aLinkText: string) of object;

  TLMDTextObject = class(TLMDObject)
  private
    FParser         : TLMDParser;
    FParsedText     : TLMDParsedTextList;
    FEnabled        : Boolean;
    FOffset         : TPoint;
    FOwnerControl   : TControl;
    FParentControl  : TWinControl;
    FOnBeforeParse,
    FOnAfterParse   : TNotifyEvent;
    FOnLinkClick    : TLMDLinkClickEvent;
    FOnGraphicError : TLMDGraphicErrorEvent;
    FOnGetVariable  : TLMDGetVariableEvent;
    FOnControlCreated: TLMDEmbdControlEvent;
    FOnRepeat       : TLMDRepeatEvent;
    // this flag specifies whether Changed should be called even if object
    // does not contain text. Required e.g. for group controls
    FForceChange    : Boolean;
    function IsNotDefault:Boolean;
    //retrieves a string determining the currently set parser class
    function GetParserClass: string;
    //sets a parser class to be used for future parsing processes
    procedure SetParserClass(const Value: string);
  protected
    //internally used before a stream is parsed -> will execute the
    //OnBeforeParse event
    procedure DoBeforeParse; dynamic;
    //internally used after a stream is parsed -> will execute the
    //OnAfterParse event
    procedure DoAfterParse; dynamic;
    //internally used if its detected that someone clicked on a link
    procedure DoLinkClick (aButton: TMouseButton; aShift: TShiftState;
                           const aLinkText: string);
    //usually this object is automaticcaly enabled
    property Enabled : Boolean read FEnabled write FEnabled default true;
  public
    //check a mouse click
    procedure MouseDown (aControl: TControl; Button: TMouseButton;
                         Shift: TShiftState; X, Y: Integer;
                         autoSize, wordWrap : Boolean; aFont: TFont;
                         aCanvas: TCanvas);
    //check a mouse move
    procedure MouseMove (aControl: TControl; Shift: TShiftState;
                         X, Y: Integer; autoSize, wordWrap : Boolean;
                         aFont: TFont; aCanvas: TCanvas);

    //parse a text stream with the actual set parser
    procedure Parse (M: TStream); overload; virtual;
    //parse a string
    procedure Parse (const S: String); overload;
    //parse a string list
    procedure Parse (aLines : TStrings); overload;

    //does not work!!
    function Render(aRect: TRect; aDefFont: TFont; aBkColor: TColor;
      aAutoSize: Boolean; aWordWrap: Boolean): TBitmap; overload; virtual;

    procedure Render3D(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
                                aDefFont: TFont; aBkColor: TColor; aAutoSize:
                                Boolean; aWordWrap: Boolean; Effects : TLMD3DCaption;
                                ExtFlags:TLMDDrawTextStyles);

    //render the last parsed text to the given canvas
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean);
      overload;

    //render the last parsed text together with a specified glyph according
    //to the glyph text layout settings
    function Render(aCanvas: TCanvas; Effects:TLMD3DCaption; aDefFont:TFont;
                     const aDest: TRect; srcCanvas: TCanvas; var srcRect:TRect;
                     aMaskCanvas: TCanvas; aBkColor:TColor; TransColor:TColor;
                     aLayout: TLMDGlyphTextLayout; autoSize, wordwrap,
                     Transparent:Boolean; ExtFlags:TLMDDrawTextStyles;
                     flags:LongInt) : TLMDWhereRect; overload;

    //parse the given string and render it afterwards to the given canvas
    procedure ParseAndRender (const s : String; aCanvas: TCanvas; const aRect: TRect;
                              const aOffset: TPoint; aDefFont: TFont;
                              aBkColor: TColor; aAutoSize: Boolean;
                              aWordWrap: Boolean);

    //retrieve the client rect needed for the parsed text
    function GetClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean): TRect;

    constructor Create(Owner:TPersistent=nil); overload; override;
    // 7.0.61 -
    constructor Create(ForceChange:Boolean); reintroduce; overload;
    constructor CreateExt(Owner : TControl; Parent : TWinControl);
    destructor Destroy; override;
    procedure Assign (Source: TPersistent); override;

    property Parent : TWinControl read FParentControl write FParentControl stored false;
    //pointer to the list of parsed text
    property ParsedText: TLMDParsedTextList read FParsedText;
    //this event will be executed before a stream is parsed
    property OnBeforeParse: TNotifyEvent read FOnBeforeParse write FOnBeforeParse;
    //this event will be executed after the parsing is finished
    property OnAfterParse: TNotifyEvent read FOnAfterParse write FOnAfterParse;
    //this event is executed if the Mousedown procedure detects a mouse click
    //on a link
    property OnLinkClick: TLMDLinkClickEvent read FOnLinkClick write FOnLinkClick;
    //this event is executed if the parser is not able to load the referenced
    //graphic
    property OnGraphicError: TLMDGraphicErrorEvent read FOnGraphicError write FOnGraphicError;
    //this event is executed whenever the parser finds a variable definition
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
    //this event is executed whenever the repeat loop is passed
    property OnRepeat: TLMDRepeatEvent read FOnRepeat write FOnRepeat;
    property OnControlCreated: TLMDEmbdControlEvent read FOnControlCreated write FOnControlCreated;
  published
    //pointer to the parser class to be used
    property ParserClass: string read GetParserClass write SetParserClass stored IsNotDefault;
  end;

  TLMDStrings = class(TStringList)
  private
    FLoading: Boolean;
  public
    constructor Create;//(aTextOut: TLMDCustomTextOut);
    procedure LoadFromStream(Stream: TStream); override;
  end;

implementation

uses
  LMDFXCaption;

type
  //Attention: This Stream is created for directly pointing to a string
  //saved in another object!!
  //the stream should not destroy neither hcnage the stream!
  TLMDMemoryStream = class(TCustomMemoryStream)
  private
    function  GetMemory: PChar;
  public
    // ToDo?
    function Write(const Buffer; Count: Longint): Longint; override;
    property Memory: PChar read GetMemory;
  end;

function TLMDMemoryStream.Write(const Buffer; Count: Longint): Longint;
begin
  result := 0; //will not write anything
end;

function  TLMDMemoryStream.GetMemory: PChar;
begin
  Result := inherited Memory;
end;

(*
  TLMDMemoryStream = class(TStream)
  private
    FPos,
    FMemory: PChar;
    FPosition,
    FSize: Longint;
  protected
    procedure SetPointer(Ptr: PChar; Size: Longint);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    property Memory: PChar read FMemory;
  end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMemoryStream.SetPointer(Ptr: PChar; Size: Longint);
begin
  FMemory := Ptr;
  FPos := FMemory;
  FSize := Size;
end;

{ ---------------------------------------------------------------------------- }
function TLMDMemoryStream.Read(var Buffer; Count: Longint): Longint;
begin
  //will always read 1 char!!
  //Move (FPos^, Buffer, 1);
  Char(Buffer) := FPos^;
  inc(FPos);
  Inc(FPosition);
  result := 1;
{  if (FPosition >= 0) and (Count >= 0) then
  begin
    Result := FSize - FPosition;
    if Result > 0 then
    begin
      if Result > Count then Result := Count;
      Move(Pointer(TLMDPtrInt(FMemory) + FPosition)^, Buffer, Result);
      Inc(FPosition, Result);
      Exit;
    end;
  end;
  Result := 0;}
end;

{ ---------------------------------------------------------------------------- }
function TLMDMemoryStream.Write(const Buffer; Count: Longint): Longint;
begin
  result := 0; //will not write anything
end;

{ ---------------------------------------------------------------------------- }
function TLMDMemoryStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning: FPosition := Offset;
    soFromCurrent: Inc(FPosition, Offset);
    soFromEnd: FPosition := FSize + Offset;
  end;
  FPos := FMemory + FPosition;
  Result := LongInt(FPosition);
end;
*)
{ **************************************************************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDTextObject.GetParserClass: string;
begin
  if  Assigned(FParser) then
    Result:= FParser.ClassName
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.SetParserClass(const Value: string);
var
  i:integer;
begin
  if not Assigned(FParser) or not AnsiSameText(Value, FParser.ClassName) then
    for i:=0 to Parsers.Count - 1 do
      if AnsiSameText(Value, PLMDParserRec(Parsers[I])^.ParserClass.ClassName) then
      begin
          FreeAndNil(FParser);
          FParser:= PLMDParserRec(Parsers[I])^.ParserClass.Create;
          if  (Assigned(FParsedText) and (FParsedText.Count > 0)) or FForceChange then
            GetChange (self);
          system .Break;
          end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextObject.IsNotDefault:Boolean;
begin
  result := GetParserClass <> 'TLMDPlainTextParser';
end;

{ -------------------------- protected --------------------------------------- }
procedure TLMDTextObject.DoBeforeParse;
begin
  //ShowMessage ('BeforeParse');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.DoAfterParse;
begin
  //ShowMessage ('AfterParse');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.DoLinkClick(aButton: TMouseButton; aShift: TShiftState; const aLinkText: string);
begin
  if Assigned(FOnLinkClick) then FOnLinkClick(aButton, aShift, aLinkText);
end;

{ ------------------------- public ------------------------------------------- }
procedure TLMDTextObject.MouseDown(aControl: TControl; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; autoSize, wordWrap : Boolean; aFont: TFont;
  aCanvas: TCanvas);
var
  T: TLMDBaseText;
begin
  inherited;
  inc (x, -FOffset.X);
  inc (y, -FOffset.Y);
  if Assigned(FParsedText) then
    begin
      T:= FParsedText.CheckMousePos(Point(X, Y), aCanvas,
                                aControl.ClientRect, AFont, autoSize, wordWrap);
      if (T <> nil) and (T is TLMDPieceOfText) and TLMDPieceOfText(T).Link then
        DoLinkClick(Button, Shift, TLMDPieceOfText(T).HREF);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.MouseMove(aControl: TControl; Shift: TShiftState;
                                   X, Y: Integer; autoSize, wordWrap : Boolean;
                                   aFont: TFont; aCanvas: TCanvas);
var
  T: TLMDBaseText;
begin
  inherited;
  inc (x, -FOffset.X);
  inc (y, -FOffset.Y);
  if Assigned(FParsedText) then
    begin
      T:= FParsedText.CheckMousePos(Point(X, Y), aCanvas,
                                    aControl.ClientRect, aFont,
                                    autoSize, wordWrap);
      if (T <> nil) and (T is TLMDPieceOfText) and TLMDPieceOfText(T).Link then
        aControl.Cursor:= crHandPoint
      else
        aControl.Cursor:= crDefault;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.Parse (M : TStream);
begin
  DoBeforeParse;
  if Assigned(FParsedText) then FreeAndNil(FParsedText);

  if  (M.Size - M.Position) > 0 then
    begin
      FParsedText:= FParser.Parse(M, FOnGraphicError, FOnGetVariable,
                                  FOnControlCreated, FOnRepeat);
      FParsedText.OwnerControl := FOwnerControl;
      FParsedText.ParentControl := FParentControl;
    end;
  DoAfterParse;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.Parse (const S : String) ;
var
  M: TLMDMemoryStream;
  begin
  M := TLMDMemoryStream.Create;
  try
    M.SetPointer (PChar(s), Length(S) * SizeOf(Char));
    Parse (M);
    M.SetPointer (nil, 0);
    finally
    M.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.Parse (aLines : TStrings);
var
  {$ifdef LMDCOMP12}
  M : TLMDMemoryStream;
  {$else}
  M : TMemoryStream;
  {$ENDIF}
begin
  {$ifdef LMDCOMP12}
  M := TLMDMemoryStream.Create;
  {$else}
  M := TMemoryStream.Create;
  {$ENDIF}
  try
    {$ifdef LMDCOMP12}
    M.SetPointer (PChar(aLines.Text), Length(aLines.Text) * SizeOf(Char));
    {$else}
    aLines.SaveToStream (M);
    {$endif}
    M.Position:= 0;
    Parse (M);
  finally
    M.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextObject.Render(aRect: TRect; aDefFont: TFont; aBkColor: TColor;
                               aAutoSize: Boolean; aWordWrap: Boolean): TBitmap;
begin
  FOffset := Point (0, 0);
  result := nil;
  if not Assigned (FParsedText) then exit;
//  result := FParsedText.Render (aRect, aDefFont, aBkColor, aAutoSize, aWordWrap);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
                                aDefFont: TFont; aBkColor: TColor; aAutoSize:
                                Boolean; aWordWrap: Boolean);
begin
  FOffset := aOffset;
  if not Assigned (FParsedText) then exit;
  FParsedText.Render (aCanvas, aRect, aOffset, aDefFont, aBkColor, aAutoSize, aWordWrap, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.Render3D(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
                                aDefFont: TFont; aBkColor: TColor; aAutoSize:
                                Boolean; aWordWrap: Boolean; Effects : TLMD3DCaption;
                                ExtFlags:TLMDDrawTextStyles);
var
  LogRec: TLOGFONT;
  Rgn:HRgn;
  tempcol:TColor;
  tempStyle:TLMDThreeDStyle;
  temp:TRect;
  flag:Byte;
  x,y,i,j:Integer;
  myFont:TFont;

   Procedure DrawC(aMoveX, aMoveY:Integer;aColor:TColor);
      begin
        myFont.Color:=aColor;
        if flag<2 then
           begin
            OffsetRect(temp, aMoveX, aMoveY);
            FParsedText.Render (aCanvas, temp, aOffset, myFont, aBkColor, aAutoSize, aWordWrap, false);
           end
        else
          with TLMDFxCaption(Effects), temp do
            begin
              Left:=Left+aMoveX;
              Top:=Top+aMoveY;
              FParsedText.Render (aCanvas, temp, aOffset, myFont, aBkColor, aAutoSize, aWordWrap, false);
            end;
      end;

begin
  FOffset := aOffset;
  if not Assigned (FParsedText) then exit;

  x := 0; y := 0; j := 0; //happy compiler

  if IsRectEmpty(aRect) then exit;
  flag:=0;
  Rgn:=0;

  myFont := TFont.Create;
  myFont.Assign (aDefFont);

  if effects=nil then
    begin
      FParsedText.Render (aCanvas, aRect, aOffset, aDefFont, aBkColor, aAutoSize, aWordWrap, false);
      exit;
    end;

  if effects is TLMDFxCaption then
    if TLMDFXCaption(effects).Angle=0 then flag:=1 else flag:=2;

  if dtClip in ExtFlags then
    Rgn:=CreateRectRgnIndirect(aRect);

  try
    with TLMD3DCaption(Effects) do
      begin

        if Rgn<>0 then SelectClipRgn(aCanvas.Handle, Rgn);

        tempStyle:=Style;

        if (dtEnabled in ExtFlags) or (DisabledStyle=dsNone) then
          if Style in [tdPColorSunken, tdPColorRaised] then
            tempcol:=aCanvas.Brush.Color
          else
            tempcol:=aCanvas.Font.Color
        else
          begin
            tempcol:=clGrayText;
            case DisabledStyle of
              dsAuto:if dt3DDisabled in ExtFlags then tempStyle:=tdSunken;
              ds3d:tempStyle:=tdSunken;
            end;
          end;

        if flag>0 then
          begin
            if Flag=2 then
              begin
                GetObject(aCanvas.Font.Handle, SizeOf(TLOGFONT), Addr(LogRec));
                LogRec.lfEscapement:=TLMDFxCaption(Effects).Angle*10;
                aCanvas.Font.Handle:=CreateFontIndirect(LogRec);
              end;
            with aRect do
              temp:=Rect(Left+TLMDFxCaption(Effects).PosX, Top+TLMDFxCaption(Effects).PosY, Right, Bottom);
          end
        else
          temp:=aRect;

        if Effects.Tracing<>0 then
          SetTextCharacterExtra(aCanvas.Handle,Effects.Tracing);

        if tempStyle in [tdExtrude, tdExtrudeEnh] then
          begin
            case Orientation of
              toTopLeft:begin x:=ShadowDepth;y:=ShadowDepth;end;
              toTopRight:
                begin
                  x:=-ShadowDepth;
                  y:=ShadowDepth;
                  OffsetRect(temp, ShadowDepth+1, 0);
                end;
              toBottomLeft:
                begin
                  x:=ShadowDepth;
                  y:=-ShadowDepth;
                  OffsetRect(temp, 0, ShadowDepth+1);
                end;
              toBottomRight:
                begin
                  x:=-ShadowDepth;
                  y:=-ShadowDepth;
                  OffsetRect(temp, ShadowDepth+1, ShadowDepth+1);
                end;
            end;
            if Abs(x)>Abs(y) then j:=Abs(x) else j:=Abs(y);
          end;

        aCanvas.Brush.Style:=bsClear;
        case tempStyle of
          //5.0
          tdOutline:begin
                      aCanvas.Pen.Style:=psSolid;
                      BeginPath(aCanvas.Handle);
                      DrawC(ShadowDepth Div 2,ShadowDepth Div 2,tempcol);
                      EndPath(aCanvas.Handle);
                      aCanvas.Pen.Color:=tempcol;
                      aCanvas.Pen.Width := ShadowDepth;
                      StrokePath(aCanvas.Handle);
                    end;
          //Jan --> New Styles
          tdExtrude:begin
                      for i := j downto 1 do
                        begin
                          if x>0 then x:=1 else x:=-1;
                          if y>0 then y:=1 else y:=-1;
                          DrawC(x,y, ShadowColor);
                        end;
                      DrawC(0,0, tempcol);
                    end;
          tdExtrudeEnh:
                    begin
                      for i := j downto 1 do
                        begin
                          if x>0 then x:=1 else x:=-1;
                          if y>0 then y:=1 else y:=-1;
                          DrawC(x,y, LMDGradientGetColor(ShadowColor, LightColor, i-1,j));
                        end;
                      DrawC(0,0, tempcol);
                    end;
          tdSunken:begin
                     Dec(temp.Right, LightDepth);
                     DrawC(LightDepth, LightDepth, LightColor);
                     DrawC(-LightDepth, -LightDepth, tempcol);
                   end;
          tdRaised:begin
                     Dec(temp.Right, LightDepth);
                     DrawC(0, 0, LightColor);
                     DrawC(LightDepth, LightDepth, tempcol);
                   end;
          tdShadow:begin
                     Dec(temp.Right, ShadowDepth);
                     DrawC(ShadowDepth, ShadowDepth, ShadowColor);
                     DrawC(-ShadowDepth, -ShadowDepth, tempcol);
                   end;
          tdSunkenShadow, tdPColorSunken:
                   begin
                     Dec(temp.Right, LightDepth+ShadowDepth);
                     DrawC(0, 0, ShadowColor);
                     DrawC(LightDepth+ShadowDepth, LightDepth+ShadowDepth, LightColor);
                     DrawC(-LightDepth, -LightDepth, tempcol);
                   end;
          tdRaisedShadow, tdPColorRaised:
                   begin
                     Dec(temp.Right, LightDepth+ShadowDepth);
                     DrawC(LightDepth+ShadowDepth,LightDepth+ShadowDepth, ShadowColor);
                     DrawC(-(LightDepth+ShadowDepth), -(LightDepth+ShadowDepth), LightColor);
                     DrawC(LightDepth, LightDepth, tempcol);
                   end;
        else
          DrawC(0,0,tempcol);
        end;

     end;
   finally
     if Rgn<>0 then
       if DeleteObject(Rgn) then SelectClipRgn(aCanvas.Handle, 0);
     if Effects.Tracing<>0 then
       SetTextCharacterExtra(aCanvas.Handle, 0);
     myFont.Free;
   end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextObject.Render(aCanvas: TCanvas; Effects:TLMD3DCaption; aDefFont:TFont;
                     const aDest: TRect; srcCanvas: TCanvas; var srcRect:TRect;
                     aMaskCanvas: TCanvas; aBkColor:TColor; TransColor:TColor;
                     aLayout: TLMDGlyphTextLayout; autoSize, wordwrap,
                     Transparent:Boolean; ExtFlags:TLMDDrawTextStyles;
                     flags:LongInt) : TLMDWhereRect;
var
  DrawArrow : Boolean;  //arrow to be drawn
  aRect,
  cRect,
  bRect,
  txtRect,              //text rect
  arrowRect,            //arrow rect
  gRect     : TRect;    //glyph rect
begin
  if not Assigned (FParsedText) then exit;

  //DrawArrow determines whether there is an arrow to be painted or not
  DrawArrow := false;
  if aLayout is TLMDButtonLayout then
    DrawArrow := (aLayout as TLMDButtonLayout).Arrow;

  aRect := aDest;
  //it's assumed that the aRect contains the paintable rect of the button!!!

  // -----------------------
  // The basic idea of the following lines:
  // let's generate rects for each of the objects to be drawn (all (0,0) based))
  // let's combine them according to ButtonLayout rules
  // let's position the combination
  // draw the objects
  // -----------------------

  //estimate the space needed by the arrow (is empty if the arrow has not to be drawn)
  arrowRect := Rect (0,0,0,0);
  if DrawArrow then
    with (aLayout as TLMDButtonLayout) do
      arrowRect := Rect (0, 0, ArrowSize+ArrowIndent, ArrowSize);

  //get rect of glyph (if one exists)
  gRect := Rect (0,0,0,0);
  if (srcCanvas <> nil)  or (dtGhostGlyph in ExtFlags) then  // RM 7.01, UseXP Mode
    begin
      gRect := srcRect;
      //remove any offset
      OffsetRect (gRect, -gRect.Left, -gRect.Top);
      //let's move the bitmap by one pixel right and down
      OffsetRect (gRect, 1, 1);
    end;

  //add, if needed the size of the arrow rect to the glyph rect
  if DrawArrow and ((aLayout as TLMDButtonLayout).ArrowPosition in [apRightGlyph, apLeftGlyph]) then
    inc (gRect.Right, arrowRect.Right);

  //get rect of text
  cRect := aRect;
  if Assigned(Effects) then
    if (Effects.Tracing<>0) then SetTextCharacterExtra(aCanvas.Handle,Effects.Tracing);
  txtRect := GetClientRect(aCanvas, cRect, aDefFont, AutoSize, WordWrap);
  //correct the rect if needed
  if Assigned (Effects) then
    begin
      with Effects, txtRect do
        case Style of
          tdRaised, tdSunken:
              txtRect:=Rect(Left, Top, Right+LightDepth, Bottom+LightDepth);
          tdShadow, tdExtrude, tdExtrudeEnh:
              txtRect:=Rect(Left, Top, Right+ShadowDepth, Bottom+ShadowDepth);
          tdRaisedShadow, tdSunkenShadow, tdPColorRaised, tdPColorSunken:
              txtRect:=Rect(Left, Top, Right+LightDepth+ShadowDepth, Bottom+LightDepth+ShadowDepth);
          tdOutline:
              txtRect:=Rect(Left, Top, Right+ShadowDepth, Bottom+ShadowDepth);
        end;
    end;
  //add, if needed the size of the arrow rect to the text rect
  if DrawArrow and ((aLayout as TLMDButtonLayout).ArrowPosition in [apRightText, apLeftText]) then
    //include the arrow rect into the text rect for easier calcs
    inc (txtRect.Right, arrowRect.Right);
  //build up a rect containing the txtRect and the gRect (and arrowRect,
  //which is included in one of them)
  bRect := txtRect;
  case aLayout.AlignText2Glyph of
    taRight,
    taLeft: begin //glyph to be painted left or right of the text
              //simply increase the resulting rect (width) by the glyph rect (width)
              inc (bRect.Right, gRect.Right + aLayout.Spacing);
              //check whether the resulting rects height (text height here) if large enough for the glyph
              if bRect.Bottom < gRect.Bottom then
                bRect.Bottom := gRect.Bottom;
            end;
    taTop,
    taBottom:
            begin //glyph to be painted on the top or below the text
              //simply increase the resulting rect (height) by the glyph rect (height)
              inc (bRect.Bottom, gRect.Bottom + aLayout.Spacing);
              //check whether the resulting rects width (text width here) if large enough for the glyph
              if bRect.Right < gRect.Right then
                bRect.Right := gRect.Right;
            end;
  end;
  //let's position the glyph and the text relative to each other
  case aLayout.AlignText2Glyph of
    taLeft : OffsetRect (gRect, txtRect.Right + aLayout.Spacing, 0);
    taTop : OffsetRect (gRect, (txtRect.Right - gRect.Right) div 2, txtRect.Bottom + aLayout.Spacing);
    taRight : OffsetRect (txtRect, gRect.Right + aLayout.Spacing, 0);
    taBottom : begin
                 OffsetRect (txtRect, 0, gRect.Bottom + aLayout.Spacing);
                 OffsetRect (gRect, (txtRect.Right - gRect.Right) div 2, 0);
               end;
  end;
  //lets use the Alignment of the ButtonLayout for aligning the complete
  //button content
  bRect := LMDAlignRect (aLayout.Alignment, bRect, aRect);
  //reposition the rects if an arrow is painted
  if DrawArrow and ((aLayout as TLMDButtonLayout).ArrowPosition in [apRightText, apLeftText]) then
    begin
      //take the arrow rect away from the text rect (we previously added it)
      dec (txtRect.Right, arrowRect.Right-arrowRect.Left);
      if (aLayout as TLMDButtonLayout).ArrowPosition = apRightText then
        begin //arrow to be painted right of the text
          //move the arrow rect to the right side of the text rect
          OffsetRect (arrowRect, txtRect.Right, txtRect.Top + (txtRect.Bottom - txtRect.Top) div 2);
          //add the arrow indent to the left side of the arrow rect
          inc (arrowRect.Left, (aLayout as TLMDButtonLayout).ArrowIndent);
        end
      else
        begin
          //only works if text >> glyph
          OffsetRect (txtRect, arrowRect.Right, 0);
          OffsetRect (arrowRect, 0, txtRect.Top + (txtRect.Bottom - txtRect.Top) div 2);
        end;
    end;
  if DrawArrow and ((aLayout as TLMDButtonLayout).ArrowPosition in [apRightGlyph, apLeftGlyph]) then
    begin
      dec (gRect.Right, arrowRect.Right-arrowRect.Left);
      if (aLayout as TLMDButtonLayout).ArrowPosition = apRightGlyph then
        begin //arrow to be painted on the right of the glyph
          //move the arrow rect to the right side of the glyph rect
          OffsetRect (arrowRect, gRect.Right, gRect.Top + (gRect.Bottom-gRect.Top) div 2);
          //add the arrow indent to the left side of the arrow rect
          inc (arrowRect.Left, (aLayout as TLMDButtonLayout).ArrowIndent);
        end
      else
        begin
          //only works of glyph >> text
          OffsetRect (gRect, arrowRect.Right, 0);
          OffsetRect (arrowRect, 0, gRect.Top + (gRect.Bottom-gRect.Top) div 2);
        end;
    end;
  //reposition the rects according to button contens alignment
  //(brect = combination of all rects)
  OffsetRect (txtRect, bRect.Left + aLayout.OffsetX, bRect.Top + aLayout.OffsetY);
  OffsetRect (gRect, bRect.Left + aLayout.OffsetX, bRect.Top + aLayout.OffsetY);
  OffsetRect (arrowRect, bRect.Left + aLayout.OffsetX, bRect.Top + aLayout.OffsetY);

  inc (bRect.Bottom, aLayout.OffsetX);
  inc (bRect.Right, aLayout.OffsetY);

  if not (dtCalculate in ExtFlags) then
    begin
      //correct the text rect by one (otherwise lasrt word will not be drawn)
      inc(txtRect.Right, 1);
      //draw the text
      Render3D(aCanvas, txtRect, Point(0,0), aDefFont, aBkColor, AutoSize, WordWrap, Effects, ExtFlags);
      //draw the glyph
      if srcCanvas <> nil then
        if Transparent then
          LMDBmpDrawExt(aCanvas, gRect, srcCanvas, srcRect, DSF_TRANSPARENCY, TransColor, 0, nil)
        else
          LMDBmpDrawExt(aCanvas, gRect, srcCanvas, srcRect, 0, aBkColor, 0, nil);
      //FCanvas.Draw (gRect.Left, gRect.Top, tmp);
      //draw the arrow
      if DrawArrow then
        with (aLayout as TLMDButtonLayout) do
          LMDDrawTriangle(aCanvas, arrowRect.Left,
                            arrowRect.Top - (ArrowSize div 2),
                            ArrowSize, ArrowColor, True, enabled);
    end;
  result.CompleteRect := bRect;
  result.GlyphRect := gRect;
  result.TextRect := txtRect;
  result.ArrowRect := arrowRect;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.ParseAndRender (const s : String; aCanvas: TCanvas;
                                         const aRect: TRect; const aOffset: TPoint;
                                         aDefFont: TFont; aBkColor: TColor;
                                         aAutoSize: Boolean; aWordWrap: Boolean);
begin
  Parse (s);
  Render (aCanvas, aRect, aOffset, aDefFont, aBkColor, aAutoSize, aWordWrap);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextObject.GetClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean): TRect;
begin
  if not Assigned (FParsedText) then begin result := Rect (0,0,10,10); exit; end;
  result := FParsedText.GetClientRect (aCanvas, aDisplayRect, aDefFont,
                                       aAutoSize, aWordWrap);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDTextObject.Create(Owner:TPersistent=nil);
begin
  inherited Create;
  FParser:= DefaultParserClass.Create;
  FParsedText:= nil;
  FOffset := Point (0, 0);
  FEnabled := true;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDTextObject.Create(ForceChange:Boolean);
begin
  inherited Create;
  FParser:= DefaultParserClass.Create;
  FParsedText:= nil;
  FOffset := Point (0, 0);
  FEnabled := true;
  FForceChange:=ForceChange;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDTextObject.CreateExt(Owner : TControl; Parent : TWinControl);
begin
  inherited Create;
  FParser:= DefaultParserClass.Create;
  FParsedText:= nil;
  FOffset := Point (0, 0);
  FEnabled := true;
  FOwnerControl := Owner;
  FParentControl := Parent;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextObject.Destroy;
begin
  FParsedText.Free;
  FreeAndNil(FParser);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextObject.Assign (Source : TPersistent);
begin
  if Source is TLMDTextObject then
    begin
      ParserClass := TLMDTextObject(Source).ParserClass;
      FEnabled := TLMDTextObject(Source).Enabled;
//      exit;
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStrings.LoadFromStream(Stream: TStream);
begin
  //FLoading needed because the internally used string list will create
  //a OnChange event for EACH read line of text
  //but its enough (at least for parser affaires) if this is done once,
  //after the whole text has been read!
  FLoading:= true;
  inherited;
  FLoading:= false;
//  Changed;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDStrings.Create;//(aTextOut: TLMDCustomTextOut);
begin
  inherited Create;
//  FTextOut:= aTextOut;
  FLoading:= false;
end;

end.
