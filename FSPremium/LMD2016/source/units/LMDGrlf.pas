unit LMDGrlf;
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

LMDGrlf unit ()
---------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics,
  LMDFXCaption
  ;
//  Messages, SysUtils, Classes, Controls, Forms, Dialogs,
//  lmdgraph, LMDClass, LMDProcs, ;

Type
  TLMDToggle = -180..180;

  TLMDTransLabelTypes = (tmWave, tmNone, tmHalfcircle, tmArrow, tmSpeaker, tmInvSpeaker,
                         tmFly, tmChair, tmStairs, tmInvStairs, tmBuckled, tmEnterprise,
                         tmLNoseUp, tmLNoseDown, tmRNoseUp, tmRNoseDown,  tmCube,
                         tmHalfmoon);
  TLMDTransLabelAttributes = (taPerspective, taToggled, taAutoToggled, taEqualLetters);
  TLMDTransLabelAttr = set of TLMDTransLabelAttributes;
  TLMDPerspective = (tpFrog, tpBird);

{ procedures and functions used by the component LMDGraphicLabel }

{ the procedure CalcSize returns the width and height of the transformed text }
procedure CalcSize       (Canvas : TCanvas;Var aRect : TRect;FFont : TFont;
                          FFontFX : TLMDFXCaption; Caption : String;
                          FTransform:TLMDTransLabelTypes;FToggle :TLMDToggle;
                          FFactor : Integer;FInvertCaption : Boolean;
                          FPerspective : TLMDPerspective;FPerspectiveDepth : Integer;
                          FTransAttr : TLMDTransLabelAttr);
{ the procedure CalcPosAndSize returns the position of one single letter in a
  text transfomation. it is used by the procedures CalcSize and the procedure
  SpecialTextOut }
procedure CalcPosAndSize (X, Y, i, FFactor, MinSize, FToggle, FPerspectiveDepth : Integer;
                          FFont : TFont;FTransAttr : TLMDTransLabelAttr;
                          FTransform : TLMDTransLabelTypes;bm : single;
                          DCaption : String;Canvas : TCanvas; Var LogRec: TLOGFONT;
                          FFontFX : TLMDFXCaption; Var TS : TSize;
                          Var X2, Y2 : Integer);

{ the procedure SpecialTextOut paints the transformed text on the Canvas }
procedure SpecialTextOut (Canvas : TCanvas; var aRect : TRect;FFont : TFont;
                          FFontFX : TLMDFXCaption; Caption : String;
                          FTransform:TLMDTransLabelTypes;FToggle :TLMDToggle;
                          FFactor : Integer;FInvertCaption : Boolean;
                          FPerspective : TLMDPerspective;FPerspectiveDepth : Integer;
                          FTransAttr : TLMDTransLabelAttr);

implementation

uses

  SysUtils,
  lmdgraph
  ;

procedure i_GetLogRec(Font: TFont; var LogRec: TLOGFONT);
begin

  GetObject(Font.Handle, SizeOf(TLOGFONT), @LogRec);

end;

{------------------------------------------------------------------------------}
procedure CalcPosAndSize (X, Y, i, FFactor, MinSize, FToggle, FPerspectiveDepth : Integer;
                          FFont : TFont;FTransAttr : TLMDTransLabelAttr;
                          FTransform : TLMDTransLabelTypes;bm : single;
                          DCaption : String;Canvas : TCanvas; Var LogRec: TLOGFONT;
                          FFontFX : TLMDFXCaption; Var TS : TSize;
                          Var X2, Y2 : Integer);
var
  c, x3 : Integer;
  bm2 : single;

  procedure GetLetterDimens(Var dim : TSIZE);
  begin
    dim.cx := Canvas.TextWidth(DCaption[i]);
    dim.cy := Canvas.TextHeight(DCaption[i]);
  end;

begin
  with Canvas do
    begin
      LogRec.lfEscapement := 0;
      Font.Assign (FFont);
      case FTransform of
        tmWave : begin
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := Round(cos(i)*FFactor)+FFontFX.Angle*10; { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x + (Round(cos(bm) * sin(i) * (FFactor/10)));
                   y2 := y - (Round(sin(bm) * sin(i) * (FFactor/10)));

                 end; { end of tmWave }
        tmNone : begin
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10; { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x;
                   y2 := y;

                 end; { end of tmNone }
        tmArrow :
                 begin
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10; { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x;
                   If (Length(DCaption) / i <= 2) Then
                     Y2 := Y-(Length(DCaption)-i)*FFactor
                   else
                     Y2 := y-i*FFactor;

                 end; { end of tmArrow }
        tmHalfmoon,
        tmEnterprise,
        tmHalfCircle:
                 begin
                   c := 1;
                   If FTransform In [tmEnterprise, tmHalfmoon] Then
                     begin
                       If i <= Length(DCaption) div 2 Then
                         Font.Size := Round (FFont.Size / Length(DCaption) * (2*i))
                       else
                         Font.Size := Round (FFont.Size / Length(DCaption) * (Length(DCaption) - i)*2);
                       i_GetLogRec(Font, LogRec);
                     end;
                   If FTransform = tmHalfmoon Then
                     c := -1;
                   bm2 := (Pi/(Length(DCaption)-1)*(i-1));
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10+Round(cos(bm2)*100); { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x + c*Round(cos((bm)) *sin(bm2) * FFactor/10);
                   y2 := Y - c*(Round(sin((bm)) * sin(bm2) * FFactor/10));

                 end; { end of tmHalfCircle }
      tmLNoseDown,
      tmRNoseDown:
                 begin
                   If FTransForm = tmRNoseDown Then
                     Font.Size := Round ( MinSize + (FFont.Size - MinSize) / Length( DCaption ) *
                                        (Length (DCaption) + 1 - i) )
                   else { tmLNoseDown }
                     Font.Size := Round ( MinSize + (FFont.Size - MinSize) / Length( DCaption ) * (i) );

                   i_GetLogRec(Font, LogRec);

                   bm2 := (Pi/(Length(DCaption)-1)*(i-1));

                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10+Round(cos(bm2)*100); { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x + Round(cos(bm) * sin(bm2) * FFactor / 10);
                   y2 := y - Round(sin(bm) * sin(bm2) * FFactor / 10);

                 end; { end of tm?NoseDown }
      tmLNoseUp,
      tmRNoseUp:
                 begin
                   If FTransForm = tmRNoseUp Then
                     Font.Size := Round ( MinSize + (FFont.Size - MinSize) / Length( DCaption ) *
                                        (Length (DCaption) + 1 - i) )
                   else { tmLNoseUp }
                     Font.Size := Round ( MinSize + (FFont.Size - MinSize) / Length( DCaption ) * (i) );

                   i_GetLogRec(Font, LogRec);

                   bm2 := (Pi/(Length(DCaption)-1)*(i-1));
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10+Round(cos(bm2)*100); { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x - Round(cos(bm) * sin(bm2) * FFactor/10);
                   y2 := y + Round(sin(bm) * sin(bm2) * FFactor/10);

                 end; { end of tm?NoseUp }
        tmInvStairs,
        tmStairs :
                 begin
                   If FTransForm = tmStairs Then
                     Font.Size := Round ( MinSize + (FFont.Size - MinSize) / Length( DCaption ) *
                                        (Length (DCaption) + 1 - i) )
                   else { tmInvStairs }
                     Font.Size := Round ( MinSize + (FFont.Size - MinSize) / Length( DCaption ) * (i) );

                   i_GetLogRec(Font, LogRec);
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10; { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x;
                   y2 := y;

                 end; { end of tmStairs }
        tmInvSpeaker,
        tmSpeaker :
                 begin
                   If FTransForm = tmSpeaker Then
                     Font.Size := Round ( MinSize + (FFont.Size - MinSize) / Length( DCaption ) *
                                        (Length (DCaption) + 1 - i) )
                   else { tmInvSpeaker }
                     Font.Size := Round ( MinSize + (FFont.Size - MinSize) / Length( DCaption ) * (i) );

                   i_GetLogRec(Font, LogRec);
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10; { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x - round(cos(bm) * ((ffont.size - font.size) div 2));
                   y2 := y - round(sin(bm) * ((ffont.size - font.size) div 2));

                 end; { end of tmSpeaker }
        tmBuckled,
        tmChair :
                 begin
                   If FTransForm = tmChair Then
                     If Length(DCaption) div 2 >= i then
                       Font.Size := Round ( MinSize + ((FFont.Size - MinSize) / (Length( DCaption ) * 2 ) *
                                          (Length (DCaption) + 1 - i))) * 2
                     else
                       Font.Size := Round ( MinSize + ((FFont.Size - MinSize) / (Length( DCaption ) * 2 ) * i)) * 2
                   else { tmBuckled }
                     If Length(DCaption) div 2 >= i then
                       Font.Size := Round ( MinSize + ((FFont.Size - MinSize) / (Length( DCaption ) * 2 ) * i)) * 2
                     else
                       Font.Size := Round ( MinSize + ((FFont.Size - MinSize) / (Length( DCaption ) * 2 ) *
                                          (Length (DCaption) + 1 - i) )) * 2;

                   i_GetLogRec(Font, LogRec);
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10; { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x;
                   y2 := y;

                 end; { end of tmChair }
        tmCube,
        tmFly :
                 begin
                   If FTransform = tmFly Then
                     If Length(DCaption) div 2 >= i then
                       begin
                         If FFont.Size -Round((i-1)*(FFont.Size / Length(DCaption))) > MinSize Then
                           Font.Size := FFont.Size -Round((i-1)*(FFont.Size / Length(DCaption)))
                         else
                           Font.Size := MinSize;
                       end
                     else
                       If FFont.Size -(Round((Length(DCaption) - i)  * (FFont.Size / (Length(DCaption)) )) ) > MinSize Then
                         Font.Size := FFont.Size -(Round((Length(DCaption) - i)  * (FFont.Size / (Length(DCaption)) )) )
                       Else
                         Font.Size := MinSize;
                   If FTransform = tmCube Then
                     If i <= Length(DCaption) div 2 then
                       Font.Size := FFont.Size div 3 + Round ((FFont.Size-FFont.Size / 3) / (Length(DCaption) / 2) * (i-1))
                     Else
                       Font.Size := FFont.Size div 3 + Round ((FFont.Size-FFont.Size / 3) / (Length(DCaption) / 2) *
                                                     (Length (DCaption) - i));
                   i_GetLogRec(Font, LogRec);
                   If taAutoToggled In FTransAttr Then
                     LogRec.lfEscapement := FFontFX.Angle*10; { cos(x) is f'(x) from sin(x) }
                   If taToggled In FTransAttr Then
                     LogRec.lfEscapement := LogRec.lfEscapement+FToggle*10;

                   x2 := x - round(cos(bm) * ((ffont.size - font.size) div 2));
                   y2 := y - round(sin(bm) * ((ffont.size - font.size) div 2));

                 end; //end of tmFly
      end; // end of case FTransform

      { create font }
      Font.Handle:=CreateFontIndirect(LogRec);

      { get the specific dimensions of the current letter }
      If NOT ((taEqualLetters In FTransAttr) And (FTransform In [tmNone, tmWave])) Then
        begin
          GetLetterDimens(ts);
          If taPerspective In FTransAttr Then
            ts.cx := ts.cx + FPerspectiveDepth;
        end;

      // correct the letter position
      if (LogRec.lfEscapement-FFontFX.Angle*10 <> 0) then // letters are toggled
        begin
          //remove normal angel
          bm2 := Pi / 180 * ((LogRec.lfEscapement-FFontFX.Angle*10) / 10) + pi / 2;
          x3 := Abs(round( cos(bm2) * ts.cy / 2.5)); { div 3 maximum }

          x2 := x2 + Round( cos(-(bm - pi / 2)) * x3);
          //x := x + Round( cos(-(bm - pi / 2)) * x3);
          y2 := y2 + Round( sin(-(bm - pi / 2)) * x3);
          //y := y + Round( sin(-(bm - pi / 2)) * x3);
        end;
    end; //end of with canvas do begin
end;

{------------------------------------------------------------------------------}
procedure CalcSize       (Canvas : TCanvas;Var aRect : TRect;FFont : TFont;
                          FFontFX : TLMDFXCaption; Caption : String;
                          FTransform:TLMDTransLabelTypes;FToggle :TLMDToggle;
                          FFactor : Integer;FInvertCaption : Boolean;
                          FPerspective : TLMDPerspective;FPerspectiveDepth : Integer;
                          FTransAttr : TLMDTransLabelAttr);
Var
  h2, h3,
  tw, th,                      { pre calculated textwidth+height }
  i, minsize        : Integer; { counter, minimum size of text }
  bm                : single;
  DCaption          : String; { original or inverted Caption }
  LogRec            : TLOGFONT; { pointer to a font handle }
  ts                : TSize; { contains x and y dimension of a letter }

  { the function getlength calls CalcPosAndSize and returns
    the required place for the text in x direction }
  procedure getLength(var x, h : Integer);
  var
    y, x2, y2, i  : Integer;
  begin
    X := 0;
    Y := 0;
    // x, y : Position of first char (0, 0)
    h := 0;
    h2 := 0;
    h3 := 0;
    bm := Pi / 180 * (FFontFX.Angle)+Pi/2;
    //for each char of text to be printed do
    for i := 1 to Length (DCaption) do
      begin
        //calc each chars position and size (for the i-th char)
        CalcPosAndSize (X, Y, i, FFactor, MinSize, FToggle, FPerspectiveDepth,
                        FFont, FTransAttr,
                        FTransForm, bm,
                        DCaption, Canvas, LogRec,
                        FFontFX, ts,
                        X2, Y2);

        // calculate the new x and y positions
        // x, y : previous char (i-1) position
        x := x + round(cos(-(bm-pi/2)) * ts.cx);
        y := y + round(sin(-(bm-pi/2)) * ts.cx);
        //x, y : current char (i) position

        if abs(y2) > h2 then
          h2 := (abs(y2));
        if ts.cy > h then
          h := ts.cy;
      end;
    ts.cy := h;
    h := Abs(h2);
    if x = 0 then
      x := ts.cy;
  end;

begin
  // MinSize is 1/4 of Size;
  minsize := FFont.Size div 4;
  // get String for painting
  DCaption := Caption;

  aRect.Left := 0;
  aRect.Top := 0;
  // assign font text to be printed with
  Canvas.Font.Assign (FFont);
  // set text alignment (only left, top possible)
  SetTextAlign (Canvas.Handle, TA_BASELINE + TA_LEFT);
  // set character tracing
  SetTextCharacterExtra (Canvas.Handle,FFontFX.Tracing);

  tw := 0;
  // get pointer to Fonthandle
  i_GetLogRec(Canvas.Font, LogRec);

  // Get Length and Height
  getLength(tw, th);

  { equal letters and Transform in tmNone and tmWave }
  If (taEqualLetters In FTransAttr) And (FTransform In [tmNone, tmWave]) Then
    begin
      for i := 1 to Length(caption) Do
         If tw < Canvas.TextWidth (caption[i]) Then
           tw := Canvas.TextWidth (caption[i]);
      tw := tw*Length(caption);
    end;

  bm := Pi / 180 * (FFontFX.Angle+90);

  //if label runs to left side or to bottom th or and tw could be negative
  tw := Abs(tw);
  th := Abs(th);

  //tw >= 0 && th >= 0

  aRect.Right := tw+abs(round(cos(bm)*ts.cy));
  aRect.Bottom :=  th+abs(round(sin(bm)*ts.cy));
end;

{------------------------------------------------------------------------------}
procedure SpecialTextOut (Canvas : TCanvas; var aRect : TRect;FFont : TFont;
                          FFontFX : TLMDFXCaption; Caption : String;
                          FTransform:TLMDTransLabelTypes;FToggle :TLMDToggle;
                          FFactor : Integer;FInvertCaption : Boolean;
                          FPerspective : TLMDPerspective;FPerspectiveDepth : Integer;
                          FTransAttr : TLMDTransLabelAttr);

Var
  LogRec: TLOGFONT;
  i, x, y, sh, sw : integer;
  bm : single;
  x1,y1,x2,y2,x3,y3,x4,y4 : integer;
  DCaption : String;
  {FFacX,} FFacY : integer;
  ts : TSIZE;

  buffer : Array[0..255] Of char;

  MinSize : Integer;

  { the procedure DrawALetter paints the current letter with a special color }
  procedure DrawALetter (x1,y1 : integer;newcolor : TColor);
  begin
    Canvas.Font.Color := newcolor;

    ExtTextOut(Canvas.Handle, x1,y1,
               0{ETO_CLIPPED}, {@aRect}nil, buffer, StrLen(buffer), nil);

  end;

  { the procedure DrawFontFXAt paints the current letter with the FontFX
    Attributes }
  procedure DrawFontFXAt (X, Y : Integer);
  begin
    With FFontFX Do
      case Style of
        tdSunken: DrawALetter (x + LightDepth, y + LightDepth, LightColor);
        tdRaised: DrawALetter (x - LightDepth, y - LightDepth, LightColor);
        tdShadow: DrawALetter (x + ShadowDepth, y + ShadowDepth, ShadowColor);
        tdSunkenShadow, tdPColorSunken:
        begin
          DrawALetter (x - ShadowDepth - LightDepth, y - ShadowDepth - LightDepth, ShadowColor);
          DrawALetter (x + LightDepth, y + LightDepth, LightColor);
        end;
        tdRaisedShadow, tdPColorRaised:
        begin
          DrawALetter (x + ShadowDepth - LightDepth, y + ShadowDepth - LightDepth, ShadowColor);
          DrawALetter (x - LightDepth, y - LightDepth, LightColor);
        end;
      end;
  end;

  { the function highest returns the highest of four values }
  function highest (v1,v2,v3,v4 : integer) : integer;
  var
    v : integer;
  begin
    v := v1;
    If v < v2 Then
      v := v2;
    If v < v3 then
      v := v3;
    If v < v4 Then
      v := v4;
    result := v;
  end;
  { the function lowest returns the lowest of four values }
  function lowest (v1,v2,v3,v4 : integer) : integer;
  var
    v : integer;
  begin
    v := v1;
    If v > v2 Then
      v := v2;
    If v > v3 then
      v := v3;
    If v > v4 Then
      v := v4;
    result := v;
  end;
  { the function getLength calculates the length of the drawn text
    through calling CalcPosAndSize with fictive coordinates }
  function getLength : Integer;
  Var
    x,y,x2,y2, i : Integer;
  begin
    X := 0;
    Y := 0;
    {Canvas.Font.Assign (FFont);}
    For i := 1 to Length (DCaption) do
      begin
        CalcPosAndSize (X, Y, i, FFactor, MinSize, FToggle, FPerspectiveDepth,
                        FFont, FTransAttr,
                        FTransForm, bm,
                        DCaption, Canvas, LogRec,
                        FFontFX, ts,
                        X2, Y2);

        { calculate the new x and y positions }
        x := x + ts.cx;

      end;
    result := x;
  end;

begin
  if Length(caption) = 1 then Exit; { text must be longer than one char }
  MinSize := FFont.Size div 4; { calculate the minsize of the Font }
  sh:=0;
  With Canvas Do { start painting }
    Begin
      DCaption := '';
      If NOT FInvertCaption Then { if not inverted get string }
        DCaption := Caption
      Else { invert string }
        For i := Length(Caption) DownTo 1 Do
           DCaption := DCaption+Caption[i];

      Font.Assign (FFont); { assign paint font }

      //FFacX := FFactor;
      FFacY := FFactor;

      bm := Pi/180*(-FFontFX.Angle); { precalculate Angle for sin and cos }

      SetTextAlign (Canvas.Handle, TA_BASELINE + TA_LEFT);
      SetTextCharacterExtra (Canvas.Handle, FFontFX.Tracing); { set Tracing }

      i := 0; { i as distance value from lower border }
      { calculate/set start values }
      Case FTransform Of
         tmWave : begin
                    sh := Canvas.TextHeight(DCaption) + Round(FFactor / 5);
                    i := FFactor div 10;
                  end;
         tmLNoseUp,
         tmRNoseUp,
         tmLNoseDown,
         tmRNoseDown,
         tmHalfmoon,
         tmEnterprise,
         tmHalfCircle : begin
                          sh := Canvas.TextHeight(DCaption) + Round(FFacY / 10);
                          If FTransForm In [tmHalfmoon, tmLNoseUp, tmRNoseUp] then
                            i := FFactor div 10;
                        end;
         tmArrow : begin
                     sh := Canvas.TextHeight(DCaption) + Round({Length(DCaption) div 2*} FFacY/10);
                   end;
         tmBuckled,
         tmInvStairs,
         tmStairs,
         tmChair,
         tmFly,
         tmCube,
         tmInvSpeaker,
         tmSpeaker,
         tmNone : begin
                    sh := Canvas.TextHeight(DCaption);
                  end;
      end;

      i := i + Canvas.TextHeight(DCaption) div 4; { one third for p,q,... }
      If taPerspective In FTransAttr Then
        begin
          If FPerspective = tpBird Then
            i := i + FPerspectiveDepth; { Increase bottom line }
          sh := sh + FPerspectiveDepth;
        end;

      x := aRect.Left;
      y := aRect.Bottom;
      bm := Pi / 180 * (-FFontFX.Angle);

      If FFontFX.Style In [tdShadow, tdSunkenShadow, tdRaisedShadow] Then
        begin
          sh := sh + FFontFX.ShadowDepth;
          If FFontFX.Style = tdShadow Then
            i := i + FFontFX.ShadowDepth
          else
            begin
              x := x + Round(cos(bm) * FFontFX.ShadowDepth);
              y := y + Round(sin(bm) * FFontFX.ShadowDepth);
            end;
        end;

      i_GetLogRec(Font, LogRec); { get object for font effects }
      sw := getLength; { gets length of drawn text }

      x1 := X+Round(cos(bm) * sw);   { calc bottom of test end }
      y1 := Y+Round(sin(bm) * sw);
      bm := Pi/180*(-FFontFX.Angle - 90);
      x2 := x1+ Round(cos(bm) * sh); { calc top of text end }
      y2 := y1+ Round(sin(bm) * sh);
      bm := Pi/180*(-FFontFX.Angle - 180);
      x3 := x2+ Round(cos(bm) * sw); { calc top of text start }
      y3 := y2+ Round(sin(bm) * sw);
      bm := Pi/180*(-FFontFX.Angle - 270);
      x4 := x3+ Round(cos(bm) * sh); { calc bottom of text start }
      y4 := y3+ Round(sin(bm) * sh);

      bm := Pi/180*(-FFontFX.Angle-90);

      x := x4;
      y := y4;

      y := y + (Round(sin(bm) * i));
      x := x + (Round(cos(bm) * i));
      If Lowest(x1,x2,x3,x4) < aRect.Left Then
        INC(x, Abs(Lowest(x1,x2,x3,x4)));

      bm := Pi / 180 * (FFontFX.Angle)+Pi/2;

      If (FFontFX.Style In [tdSunkenShadow, tdRaisedShadow]) And
         (x-cos(-(bm-pi/2))*FFontFX.Shadowdepth < aRect.Left) Then
        INC(x, Round(cos(-(bm-pi/2))*FFontFX.ShadowDepth));

      If Abs(Highest(y1,y2,y3,y4)) > aRect.Bottom Then
        DEC(y, Abs(Highest(y1,y2,y3,y4)-aRect.Bottom))
      else
        INC(y, Abs(Highest(y1,y2,y3,y4)-aRect.Bottom));

      ts.cx := 0;
      ts.cy := 0;
      for i := 1 to Length(DCaption) do
         begin
           If Canvas.TextWidth (Copy(DCaption,i,1)) > ts.cx Then
             ts.cx := TextWidth (Copy(DCaption,i,1));
           If TextHeight (Copy(DCaption,i,1)) > ts.cy Then
             ts.cy := TextHeight (Copy(DCaption,i,1));
         end;

      Brush.Style:=bsClear;

      For i := 1 To Length(DCaption) Do
        begin
          { get one char to draw }

          StrPCopy (buffer,(Copy(DCaption,i,1)));

          { calc the pos of the current letter }
          CalcPosAndSize (X, Y, i, FFactor, MinSize, FToggle, FPerspectiveDepth,
                          FFont, FTransAttr,
                          FTransForm, bm,
                          DCaption, Canvas, LogRec,
                          FFontFX, ts,
                          X2, Y2);

          { draw the current letter perspective view }
          If taPerspective In FTransAttr Then
            If FPerspective = tpBird Then
              For y1 := 1 To FPerspectiveDepth Do
                DrawALetter (x2, y2 + y1, clBlack)
            else
              For y1 := 1 To FPerspectiveDepth Do
                DrawALetter (x2, y2 - y1, clBlack);
          { draw letter with FontFX }
          DrawFontFXAt (x2, y2);
          { draw the letter }
          DrawALetter  (x2, y2, FFont.Color);

          { calculate the new x and y positions }
          x := x + round(cos(-(bm-pi/2)) * ts.cx);
          y := y + round(sin(-(bm-pi/2)) * ts.cx);

        End; { end of for i }
    End; { end of with canvas }

end;

end.
