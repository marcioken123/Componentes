unit LMDBase;
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

LMDBase unit ()
---------------

Base unit - defines several constants and events which are used by many different classes.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Controls, Classes, Graphics, Types,
  LMDButtonBase;

  {$R LMDBMPCore.RES}

type
  TLMDStandardEvent=procedure(Sender:TObject; var Cancel:Boolean) of object;
  TLMDIndexEvent = procedure (Sender : TObject; Index : Integer) of object;

procedure LMDRaiseDockError(tmp, tmp1:TComponent);
procedure LMDCreateHandle(aControl:TWinControl);
procedure LMDGetGlyphKind(aValue:TBitmap; Kind:TLMDGlyphKind);
procedure LMDGetSysButton(aValue:TBitmap);

const
  // Bitmap Resource Identifier
  IDB_GLYPHBMP='LMDBMPGLYPH';
  IDB_FONTBMP='LMDBMPFONT';
  //IDB_CHECKBMP = 'LMDBMPCHECK';
  //IDB_OPTIONBMP = 'LMDBMPOPTION';
  IDB_FILEBMP = 'LMDBMPFILE';
  IDB_CDROMBMP = 'LMDBMPCDROM';

  IDB_HINTICONERROR = 'HINTICONERROR';
  IDB_HINTICONWARNING = 'HINTICONWARNING';
  IDB_HINTICONINFO = 'HINTICONINFO';
  IDB_HINTICONQUESTION = 'HINTICONQUESTION';

implementation
uses
 SysUtils{$IFDEF LMD_DEBUGTRACE},Dialogs;{$I C2.INC}{$ELSE};{$ENDIF}

procedure LMDRaiseDockError(tmp, tmp1:TComponent);
var
  S1, S2: string;
begin
  if  Assigned(tmp) then
    S1 := tmp.Name
  else
    S1 := '';

  if  Assigned(tmp1) then
    S1 := tmp1.Name
  else
    S1 := '';

  raise Exception.Create('Component '+S1+':'#13'A TLMDDockLabel- or' +
    ' Button component was already attached to the component: '+
    S2+#13'Only one LMDDockXXXX per control is allowed.');
end;

{helper routines}
{------------------------------------------------------------------------------}
procedure LMDCreateHandle(aControl:TWinControl);
begin
  if Assigned(aControl) then
    aControl.HandleNeeded;
end;

{------------------------------------------------------------------------------}
procedure LMDGetGlyphKind(aValue:TBitmap; Kind:TLMDGlyphKind);
begin
  if aValue=nil then exit;
  aValue.LoadFromResourceName(HInstance, IDB_GLYPHBMP);
  if Kind<>gkEllipsis then
    aValue.Canvas.CopyRect(Rect(0,0,13,14), aValue.Canvas,
                           Rect((Ord(Kind)-1)*13, 0, (Ord(Kind))*13, 14));
  aValue.Width:=13;
end;

{------------------------------------------------------------------------------}
procedure LMDGetSysButton(aValue:TBitmap);
begin
  if not Assigned(aValue) then
    aValue:=TBitmap.Create;
  aValue.Width:=14;
  aValue.Height:=13;
  DrawFrameControl(aValue.Canvas.Handle, Rect(-1, -1, 15, 14), DFC_CAPTION, DFCS_CAPTIONCLOSE OR DFCS_FLAT);
  aValue.Transparent := True;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
