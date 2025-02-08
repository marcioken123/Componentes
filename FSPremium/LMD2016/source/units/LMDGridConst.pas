unit LMDGridConst;
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

LMDGridConst unit (VT)
---------------------
This unit contains Resource Strings for the LMD-Tools Grid package.

Changes
-------
Release 1.0 (July 2009)
 - Initial Release

###############################################################################}

interface

resourcestring
  SLMDGridParentGridIsNil = 'Parent grid object should be non-nil';
  SLMDGridParentColIsNil = 'Parent column object should be non-nil';

  SLMDGridDsgColumnsEdit = 'Columns...';
  SLMDGridDsgTextColumnDescr = 'Text column';
  SLMDGridDsgSpinColumnDescr = 'Spin edit column';
  SLMDGridDsgDateColumnDescr = 'Date edit column';
  SLMDGridDsgFloatColumnDescr = 'Float/double numbers edit column';
  SLMDGridDsgCheckBoxColumnDescr = 'Checkbox column';
  SLMDGridImageColumnDescr = 'Image column';
  SLMDGridRatingColumnDescr = 'Rating column';
  SLMDGridProgressColumnDescr = 'Progress column';

  SLMDGridPickListChooserDescr = 'Picklist chooser';
  SLMDGridMemoListChooserDescr = 'Memo chooser';
  SLMDGridDateChooserDescr = 'Date chooser';
  SLMDGridCalculatorChooserDescr = 'Calculator chooser';
  SLMDGridCustomChooserDescr = 'Custom event chooser';
  SLMDGridLookupChooserDescr = 'Lookup chooser';

  SLMDGridChooserOkCaption = 'OK';
  SLMDGridChooserCancelCaption = 'Cancel';

  SLMDGridColumnsEditorCaption = 'Columns editor';

  SLMDGridGridArgIsNil = 'Grid argument can''t be nil here';
  SLMDGridDesignerArgIsNil = 'Designer argument can''t be nil here';
  SLMDGridDesignerCantDeleteAncestor = 'You''re trying to delete a column(s) introduced in an ancestor form which cannot be deleted';
  SLMDGridDesignerCantAddToFrame = 'New columns cannot be added to frame instances.';

  SLMDGridDsgBtnDelete = 'Delete column';
  SLMDGridDsgBtnUp = 'Move column up';
  SLMDGridDsgBtnDown = 'Move column down';
  SLMDGridDsgBtnClear = 'Clear columns';
  SLMDGridDsgBtnTop = 'Stay on top';
  SLMDGridDsgBtnAddAllColumns = 'Add all columns from data source fields';
  SLMDGridDsgBtnAddAllColumnsAsk = 'Are you sure to auto-fill columns? All existing columns will be deleted';

  SLMDGridInternalClass = 'This is internal object of Grid. Don''t create it manually';

  SLMDGridBadChooserData = 'Bad chooser data in dfm. Chooser data should start with ''ChooserName'' property';

  SLMDGridInvalidColumnIdx = 'Invalid column index: %d. Valid bounds: [0, %d]';
  SLMDGridInvalidRowIdx = 'Invalid row index: %d. Valid bounds: [0, %d]';
  SLMDGridInvalidCellIdx = 'Invalid cell index: [%d, %d]. Valid bounds: [0, 0]-[%d, %d]';
  SLMDGridBadIntValueOneBound = 'This property or method argument (%s = %d) should be >= %d';
  SLMDGridBadIntValueTwoBound = 'This property or method argument (%s = %d) should be >= %d and <= %d';
  SLMDGridRequireHaveCols = 'This method requires non-empty column collection';
  SLMDGridBedBeginEndUpdate = 'Incorrect BeginUpdate/EndUpdate sequence';
  SLMDGridNilArgument = 'This argument can''t be nil: %s';
  SLMDGridNoCurrentRow = 'This method/property requires CurrentRow <> -1';

  SLMDGridTextColumnBadValue = 'Bad value given for TLMDGridTextColumn. Only string values are accepted.';
  SLMDGridSpinColumnBadValue = 'Bad value given for TLMDGridSpinColumn. Only integer values are accepted.';
  SLMDGridDateColumnBadValue = 'Bad value given for TLMDGridDateColumn. Only date values are accepted.';
  SLMDGridFloatColumnBadValue = 'Bad value given for TLMDGridFloatColumn. Only double/float values are accepted.';

  SLMDGridNoColumns = 'This method/property requires non-empty columns collection';
  SLMDGridNoRows = 'This method/property requires non-empty row collection';
  SLMDGridConfirmRowDel = 'Delete record?';

  SLMDGridDuplicateColClass = 'Don''t try to register one column class twice';
  SLMDGridDuplicateChooserClass = 'Chooser class and chooser name should be unique in registered choosers collection';

  SLMDGridEmptyBanner = 'No data entered';
  SLMDGridAutoColumnsSelected = 'Auto-generated columns selected.' + #13 + #10 +
                                'You can''t change its properties in object inspector.' + #13 + #10 +
                                'Click data area to unselect columns.';

  SLMDGridEmptyGridRequired = 'Grid should contain no rows for this method';
  SLMDGridCBColumnBoolRequired = 'Boolean values required for this checkbox column';
  SLMDGridCBColumnIntRequired = 'Integer values required for this checkbox column';
  SLMDGridCBColumnStrRequired = 'String values required for this checkbox column';
  SLMDGridCBColumnStateValueRequired = 'Value for cell of check box column should be one of its prop values:' +
                                       ' CheckedValue, UncheckedValue, UndefinedValue';

  SLMDGridCBColumnNoNullValueSet = 'Some of CheckedValue/UncheckedValue/UndefinedValue properties should be empty to correspond Null values in the grid';
  SLMDGridCantSetColVisibleInMode = 'Can''t set Column.Visible property while column moving/sizing or in new row mode';
  SLMDGridVisibleColumnRequired = 'This operation requires that column argument should be visible';

  //DBGrid - specific

  SLMDGridDataSetUnidirectional = 'Operation not allowed on a unidirectional dataset';
  SLMDGridBadFieldName = 'Bad field name: %s. No one field in dataset found for this name';
  SLMDGridIncompatibleField = 'Field %s is incompatible with this column';
  SLMDGridFieldTypeIncompatibleWithSettings = 'Field %s is incompatible with this column because of column settings: %s';
  SLMDGridIncompatibleChooserClass = 'Column <%s> is incompatible with chooser named <%s>';
  SLMDGridCantFindChooserByClass = 'Can''t find registered chooser descriptor for chooser class name <%s>';
  SLMDGridCantFindChooserByName = 'Can''t find registered chooser descriptor for chooser name <%s>';
  SLMDGridCantSetNilChooser = 'Can''t set column chooser to nil';

  SLMDGridIntegerValueRequired = 'Invalid value: "%s". This column requires integer values for cells.';
  SLMDGridFloatValueRequired = 'Invalid value: "%s". This column requires float/double values for cells.';
  SLMDGridDateTimeValueRequired = 'Invalid value: "%s". This column requires date/time values for cells.';

implementation

end.
