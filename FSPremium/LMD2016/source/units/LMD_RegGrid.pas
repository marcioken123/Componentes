unit LMD_RegGrid;
{$I LMDCmps.inc}

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

_LMD_RegGrid unit (VT)
-------------------
Unit contains component registration code needed in LMD Grid.

Changes
-------
Release 1.0 (July 2009)
 - Initial Release
 - Code formatting (YB, FEB 2011)

###############################################################################}


interface

uses
  Classes, Controls, DesignIntf, LMDGrid, LMDDBGrid, pLMDGridPE;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LMD Grid', [TLMDGrid, TLMDDBGrid]);
  RegisterComponentEditor(TLMDCustomGrid, TLMDGridCompEditor);

  RegisterPropertyEditor(TypeInfo(TLMDGridColumns), TLMDCustomGrid, '',
                         TLMDGridColumnsProperty);
  RegisterPropertyEditor(TypeInfo(string), TLMDGridColumn, 'FieldName',
                         TLMDGridFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TLMDGridColumn, 'ChooserName',
                         TLMDGridChooserNameProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TLMDGridColumnChooser, 'Tag', nil);
  RegisterPropertyEditor(TypeInfo(TPersistent), TLMDGridColumn, 'DsgHelper', nil);

  RegisterNoIcon([TLMDGridTextColumn, TLMDGridIntegerColumn, TLMDGridSpinColumn,
                  TLMDGridDateColumn, TLMDGridFloatColumn, TLMDGridCheckBoxColumn,
                  TLMDGridImageColumn, TLMDGridRatingColumn, TLMDGridProgressColumn]);
  RegisterClasses([TLMDGridTextColumn, TLMDGridIntegerColumn, TLMDGridSpinColumn,
                   TLMDGridDateColumn, TLMDGridFloatColumn, TLMDGridCheckBoxColumn,
                   TLMDGridImageColumn, TLMDGridRatingColumn, TLMDGridProgressColumn]);
end;

end.
