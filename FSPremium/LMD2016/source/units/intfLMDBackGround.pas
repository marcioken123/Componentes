unit intfLMDBackGround;
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

intfLMDBackGround unit (RM)
---------------------------
Interface for the semi-transparency feature of LMD-Tools.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Graphics, Controls, Classes,  
  intfLMDBase;

type
  ILMDBackground = interface(IInterface)
    ['{0068598D-C5C6-488F-8E00-D813525C9163}']
    function BackBitmap: TBitmap;
    function BackBitmapCheck: Boolean;
    function BackDrawArea(Canvas: TCanvas; const dest: TRect; const src: TPoint;
                          flags:Word=0): Boolean;
    function isTransparentSet: Boolean;
    function BackMapPoint(const aValue: TPoint):TPoint;
    function BackBitmapPalette: HPalette;
    procedure BackUpdate;
    function BackControl (index: Integer): TControl;
    function BackControlCount: Integer;
  end;

  //helpers which can be used by controls implementing the ILMDBackground
  function LMDBackBitmap (aControl: TControl): TBitmap;
  function LMDBackBitmapCheck (aControl: TControl): Boolean;
  function LMDBackDrawArea(aControl: TControl; Canvas: TCanvas; const dest: TRect; const src: TPoint;
                        flags:Word): Boolean;
  function LMDBackMapPoint(aControl: TControl; const aValue: TPoint):TPoint;
  function LMDBackBitmapPalette(aControl: TControl): HPalette;
  procedure LMDBackUpdate (aControl: TControl); overload;
  procedure LMDBackUpdate (notComponent: TComponent; aControl: TControl); overload;

implementation

uses
  Types, Forms, SysUtils;

// -----------------------------------------------------------------------------
//checks whether there is a component on the form supporting
//the background method
function LMDCheckForFormBackgroundComponent(aParent: TCustomForm; out itmp):Boolean;// Integer;
var
  i:Integer;
begin
  result:=false; //-1;
  if not (aParent is TCustomForm) or (aParent = nil) then exit;

  with aParent do
    for i:=0 to Pred(ComponentCount) do
      //restrict search for "form" components non controls
      if not (Components[i] is TControl) then
        begin
          if LMDSupports(Components[i], ILMDBackground, itmp) then
            begin
              result:=true;
              break;
            end;
        end;
end;

{ ---------------------------------------------------------------------------- }
{function LMDCheckForFormBackgroundComponent1(aParent: TCustomForm; out itmp): Integer;
var
  i:Integer;
begin
  result:=-1;
  if not (aParent is TCustomForm) or (aParent = nil) then exit;

  with aParent do
    for i:=0 to Pred(ComponentCount) do
      //restrict search for "form" components non controls
      if not (Components[i] is TControl) then
        begin
          if LMDSupports(Components[i], ILMDBackground, itmp) then
            begin
              result:=i;
              break;
            end;
        end;
end;}

// -----------------------------------------------------------------------------
function LMDBackBitmap (aControl: TControl): TBitmap;
var
  itmp:ILMDBackground;
begin
  result := nil;
  if aControl.Parent is TCustomForm then
    begin
      if LMDCheckForFormBackgroundComponent(TCustomForm(aControl.Parent), itmp) then
        result := itmp.BackBitmap
    end
  else
    if LMDSupports (aControl.Parent, ILMDBackground, itmp) then
      result := itmp.BackBitmap;
end;

// -----------------------------------------------------------------------------
function LMDBackBitmapCheck (aControl: TControl): Boolean;
var
 iParent, iControl:ILMDBackground;
begin
  result := false;
  if not LMDSupports (aControl, ILMDBackground, iControl) then exit;

  if aControl.Parent is TCustomForm then
  begin
    if LMDCheckForFormBackgroundComponent(TCustomForm(aControl.Parent), iParent) then
      result:={aControl.Parent.Components[i] as ILMDBackground).}iParent.BackBitmapCheck
  end
  else
    if LMDSupports (aControl.Parent, ILMDBackground, iParent) then
      //with (tmp{aControl.Parent} as ILMDBackground) do
        result := {(aControl as ILMDBackground).}iControl.isTransparentSet and {aControl.Parent.HandleAllocated and}
                  iParent.BackBitmapCheck;
end;

// -----------------------------------------------------------------------------
function LMDBackDrawArea(aControl: TControl; Canvas: TCanvas; const dest: TRect;
                         const src: TPoint; flags:Word): Boolean;
begin
  result:=false;
end;

// -----------------------------------------------------------------------------
function LMDBackMapPoint(aControl: TControl; const aValue: TPoint): TPoint;
var
  itmp:ILMDBackground;
begin
  result := aValue;
  if aControl.Parent is TCustomForm then
    begin
      if LMDCheckForFormBackgroundComponent(TCustomForm(aControl.Parent), itmp) then
        result := Types.Point(aControl.Left+aValue.X, aControl.Top+aValue.Y)
    end
  else
      if LMDSupports (aControl.Parent, ILMDBackground, itmp) then
        with itmp.BackMapPoint(Point(aControl.Left, aControl.Top)) do
          result:=Point(X+aValue.X, Y+aValue.Y);
end;

// -----------------------------------------------------------------------------
function LMDBackBitmapPalette(aControl: TControl): HPalette;
begin
  result := 0;
  if LMDBackBitmapCheck(aControl) then
    result := LMDBackBitmap (aControl).Palette;
end;

//especially needed for components like TLMDFormShape
// -----------------------------------------------------------------------------
procedure LMDBackUpdate(notComponent: TComponent; aControl: TControl);
var
  i    : Integer;
  cintf,
  itmp : ILMDBackground;
begin
  if not LMDSupports(aControl, ILMDBackground, cintf) then
    if not LMDSupports(notComponent, ILMDBackground, cintf) then
      exit;

  for i := 0 to Pred(cintf.BackControlCount) do
    if LMDSupports(cintf.BackControl(i), ILMDBackground, itmp) and
       (cintf.BackControl(i) <> notComponent) then
      itmp.BackUpdate;
end;

// -----------------------------------------------------------------------------
procedure LMDBackUpdate (aControl: TControl);
begin
  LMDBackUpdate (aControl, aControl);
end;

end.

