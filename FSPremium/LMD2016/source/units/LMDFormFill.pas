unit LMDFormFill;
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

LMDFormFill unit (RM)
--------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes,
  LMDGraph, LMDFillObject, LMDCustomFormFill;

type
  TLMDFormFill = class(TLMDCustomFormFill)
  private
    FFillObject:TLMDFillObject;
    procedure SetFillObject(aValue:TLMDFillObject);
    procedure SetEraseMode;
  protected
    procedure GetChange(Sender:TObject);override;
    procedure GetIMLChange(Sender:TObject);override;
    procedure Loaded;override;
    function PaintClientArea(DC:HDC):Boolean;override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ImageList;
    property ImageIndex;
    property FillObject:TLMDFillObject read FFillObject write SetFillObject;
    property ListIndex;
  end;

implementation

uses
  Types, SysUtils,
  LMDCustomImageList, LMDClass, LMDCont;

{--------------------------- Private ------------------------------------------}
procedure TLMDFormFill.SetFillObject(aValue:TLMDFillObject);
begin
  FFillObject.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormFill.SetEraseMode;
begin
  if PaintMode=pcOwnerDraw then
    EraseBack:=True
  else
    if PaintMode=pcControl then EraseBack:=FFillObject.SizeDependent;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFormFill.GetChange(Sender:TObject);
begin
  if (Paintmode=pcControl) and (FFillObject.Style<>sfGradient) and (Assigned (FBack) and not FBack.Empty) then
    begin
      DestroyBuffer;
    end;
  SetEraseMode;
  inherited GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormFill.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
    LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FFillObject.ListBitmap)
  else
    FFillObject.ListBitmap:=nil;
  GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormFill.Loaded;
begin
  inherited Loaded;
  SetEraseMode;
end;

{------------------------------------------------------------------------------}
function TLMDFormFill.PaintClientArea(DC:HDC):Boolean;
var
  aCanvas:TCanvas;
begin
   if (PaintMode<>pcControl) or FillObject.Empty then
     result:=inherited PaintClientArea(DC)
   else
     with WndOwner do
       begin
         aCanvas:=TCanvas.Create;
         try
           aCanvas.Handle:=DC;
           if (FFillObject.Style=sfGradient) or Buffered then
             begin
               if not Assigned (FBack) then
                 FBack := TBitmap.Create;
               if FFlag or not EqualRect(Rect(0,0,FBack.Width, FBack.Height), WndOwner.ClientRect) then
                 begin
                   FBack.FreeImage;
                   FBack.Width:=ClientWidth;
                   FBack.Height:=ClientHeight;
                   FFillObject.FillCanvas(FBack.Canvas, ClientRect, clBlack);
                 end;
               FFillObject.Gradient.SetRealPalette(aCanvas);
               aCanvas.Draw(0,0, FBack);
               {BitBlt(aCanvas.Handle, 0,0, ClientWidth, ClientHeight, FBitmap.Canvas.Handle,0,0,SRCCOPY);  }
               result:=True;
             end
           else
             result:=FFillObject.FillCanvas(aCanvas, Rect(0,0,ClientWidth+1, ClientHeight+1), WndOwner.Color);
         finally
           aCanvas.Free;
         end;
//         BackUpdate;
       end;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFormFill.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FFillObject:=TLMDFillObject.Create;
  FFillObject.OnChange:=GetChange;
   Buffered := true;
  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      raise ELMDOneInstError.Create(self.ClassName,0);

end;

{------------------------------------------------------------------------------}
destructor TLMDFormFill.Destroy;
begin
//  FBitmap.Free;
  FFillObject.OnChange:=nil;
  FreeAndNil(FFillObject);
  inherited Destroy;
end;

end.
