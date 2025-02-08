unit LMDLImage;
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

LMDLImage unit (RM)
-------------------
TLMDLImage component.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDCustomLImage;

type
  TLMDLImage=class(TLMDCustomLImage)
  protected
    procedure Paint; override;
  published
    property ForceTransparent;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property SilentMove;
    property Style;
    property Transparent default True;
  end;

implementation
uses
  Types, Windows, Classes, Graphics, SysUtils,
  LMDUtils, LMDGraphUtils, LMDCustomControl, LMDCont;

{------------------------- Protected ------------------------------------------}
procedure TLMDLImage.Paint;
var
  aRect:TRect;
  flags:Word;
  t:TBitmap;

begin
  if (csLoading in ComponentState) then exit;

  if CorrectBounds then exit;

  if not Transparent then
    if not (SilentMove and CheckOptimized and not GetEmpty) then FillControl else
  else
    if GetEmpty and (BevelExt=0) then
      begin
        inherited Paint;
        Exit;
      end;

  aRect:=Bevel.PaintBevel(Canvas, GetClientRect, inherited Transparent);

  if GetEmpty then exit;

  flags:=0;
  if ForceTransparent then flags:=flags+DSF_TRANSPARENCY;
  AddStyleFlags(flags);

  try
    if SilentMove and CheckOptimized then
      begin
        t:=TBitmap.Create;
        try
           t.Width:=aRect.Right-aRect.Left;
           t.Height:=aRect.Bottom-aRect.Top;
           BackDrawArea(t.Canvas, Rect(0,0, t.Width, t.Height), Point(aRect.Left,aRect.Top));

           LMDIMLClipDraw(t.Canvas, Rect(0,0, t.Width, t.Height), flags, 0,
                          LMDIMLTransparentColor(Imagelist, ListIndex, ImageIndex), ImageList,
                          ListIndex, ImageIndex);
           if not QuickDraw then
             begin
               SelectPalette(Canvas.Handle, t.Palette, True);
               RealizePalette(Canvas.Handle);
             end;
           Canvas.Draw(aRect.Left, aRect.Top, t);
        finally
          t.Free;
        end;
      end
    else
      begin
        if not QuickDraw then
          begin
            SelectPalette(Canvas.Handle, LMDIMLPalette(ImageList, ListIndex), True);
            RealizePalette(Canvas.Handle);
          end;
        LMDIMLClipDraw(Canvas, aRect, flags, MakeLong(Left, Top),
                        LMDIMLTransparentColor(ImageList, ListIndex, ImageIndex),
                        ImageList, ListIndex, ImageIndex);
      end;
  except
    on exception do exit;
  end;
end;

end.
