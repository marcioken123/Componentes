unit pLMDExDsgnOIEnh;

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

pLMDExDsgnOIEnh unit (TS + RM)
------------------------------

Introduces Object Inspector Design Enhancements

This units extendes pLMDOIEnh from Shared Module - LMD-Tools Property may contain 
OI display enhancements as well, check for PropDrawValue property.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
{$I lmdcmps.inc}

uses
  DesignIntf, DesignEditors, VCLEditors,
  Windows, Classes, Sysutils,  Types, Dialogs, Graphics, TypInfo, Forms,
  pLMDOIEnh, LMDUtils, LMDBase;

type

  // Beispiel for LMD eigener Typen
  {*********************** TLMDGlyphKindProperty ******************************}
  TLMDGlyphKindProperty = class(TEnumProperty, ICustomPropertyListDrawing)
  public
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer);
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer);
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  // Global Enhancement
  {*********************** TLMDSetProperty ************************************}
  TLMDExtSetProperty = class(TLMDSetProperty)
  private
    FDefault:Integer;
    FDlg:TComponent;
    procedure GetCustomClick(Sender:TObject);
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Initialize; override;
    end;

implementation
uses
  LMDClass, LMDCustomCheckListDlg, LMDCheckListBox, LMDButtonBase, LMDProcs, LMDTypes,
  pLMDCPGetCore, pLMDPECst, pLMDCECore;

//type
//  TLMDIntegerSet=set of TLMDSet;

{*********************** TLMDGlyphKindProperty ********************************}
{------------------------------------------------------------------------------}
procedure TLMDGlyphKindProperty.ListDrawValue(const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  vRight: Integer;
  tmp:TBitmap;
begin
  vRight := ARect.Left + 20;
  tmp:=TBitmap.Create;
  with ACanvas do
    try
      aCanvas.FillRect(aRect);
      LMDGetGlyphKind(tmp, TLMDGlyphKind(GetEnumValue(TypeInfo(TLMDGlyphKind), Value)));
      tmp.Transparent:=True;
      aCanvas.Draw(ARect.Left+2, ARect.Top+2, tmp);
    finally
      DefaultPropertyListDrawValue(Value, ACanvas, Types.Rect(vRight, ARect.Top, ARect.Right, ARect.Bottom), ASelected);
      tmp.Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphKindProperty.ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth := AWidth + 20;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphKindProperty.ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := LMDMax([ACanvas.TextHeight('Wg'), 18]);
end;

{*********************** TLMDExtSetProperty ***********************************}
{------------------------- private --------------------------------------------}
procedure TLMDExtSetProperty.GetCustomClick(Sender:TObject);
begin
  // we use an hidden feature here: CheckListBox pointer stored in Tag
  if Assigned(FDlg) then
    TLMDCustomCheckListDlg(FDlg).CheckListBox.Value:=FDefault;
end;

{------------------------- public ---------------------------------------------}
procedure TLMDExtSetProperty.Initialize;
begin
  inherited;
  Fdlg:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDExtSetProperty.Edit;
var
  i:TLMDSet;
  Data: TLMDTypeData;
  tmp: TIntegerSet;
  tmpd:TLMDCustomCheckListDlg;
begin
  tmpd:=TLMDCustomCheckListDlg.Create(nil);
  with tmpd do
    try
      Data := GetTypeData(FEnumInfo);
      for i:=Data.MinValue to Data.MaxValue do
        Items.Add(GetEnumName(FEnumInfo, i));
      DefaultValue:=GetOrdValue;
      FDefault:=DefaultValue;
      Prompt:='Select desired settings...';
      CustomButton:='Reset';
      ListBoxShowItems:=16;  // do not show more than 16 items, otherwise show scrollbars
      FDlg:=tmpd;
      OnCustomClick:=GetCustomClick;
      if Execute then
        begin
          tmp:=[];
          for i:=Data.MinValue to Data.MaxValue do
            if Checked[Ord(i)] then Include(tmp, i);
          SetOrdValue(Integer(tmp));
          end;
    finally
      Free;
      Fdlg:=nil;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExtSetProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

end.
