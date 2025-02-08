unit LMDBack;
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

LMDBack unit (RM)
-----------------
Component for filling a form's background.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  LMDCustomFormFill;

type
  TLMDBack=class(TLMDCustomFormFill)
  protected
    function PaintClientArea(DC:HDC):Boolean;override;
  published
    property About;
    property DefaultFill;
    property Enabled;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property PaintMode;
  end;

implementation

uses
  LMDClass, LMDProcs, LMDSysIn, LMDGraphUtils, LMDCont, Graphics;

{--------------------------- Protected ----------------------------------------}
function TLMDBack.PaintClientArea(DC:HDC):Boolean;
var
  aCanvas:TCanvas;
  flags:Word;
begin
   if (PaintMode<>pcControl) or IMLEmpty then
     result:=inherited PaintClientArea(DC)
   else
     with WndOwner do
       begin
         aCanvas:=TCanvas.Create;
         try
           aCanvas.Handle:=DC;
           flags:=DSF_TILE;
           if not ((aoAutoRealizePalette in LMDApplication.Options) and (LMDSIColorDepth<9)) then
             flags:=flags or DSF_PALETTEREALIZE;

           if not Buffered then
             LMDIMLClipDraw(aCanvas, ClientRect, flags, 0, 0, ImageList, ListIndex, ImageIndex)
           else
             begin
               if not Assigned (FBack) then
                 begin
                   FBack := TBitmap.Create;
                   FBack.Width := ClientRect.Right - ClientRect.Left;
                   FBack.Height := ClientRect.Bottom - ClientRect.Top;
                   LMDIMLClipDraw(FBack.Canvas, ClientRect, flags, 0, 0, ImageList, ListIndex, ImageIndex)
                 end;
               aCanvas.Draw (0, 0, FBack);
             end;

           result:=true;
         finally
           aCanvas.Free;
         end;
       end;
end;

end.
