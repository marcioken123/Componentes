{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxGridStrs;

interface

resourcestring
  scxGridRecursiveLevels = 'You cannot create recursive levels';

  scxGridDeletingConfirmationCaption = 'Confirm';
  scxGridDeletingFocusedConfirmationText = 'Delete record?';
  scxGridDeletingSelectedConfirmationText = 'Delete all selected records?';

  scxGridNoDataInfoText = '<No data to display>';

  scxGridFilterRowInfoText = 'Click here to define a filter';
  scxGridNewItemRowInfoText = 'Click here to add a new row';

  scxGridFilterIsEmpty = '<Filter is Empty>';

  scxGridCustomizationFormCaption = 'Customization';
  scxGridCustomizationFormColumnsPageCaption = 'Columns';
  scxGridGroupByBoxCaption = 'Drag a column header here to group by that column';
  scxGridFilterApplyButtonCaption = 'Apply Filter'; 
  scxGridFilterCustomizeButtonCaption = 'Customize...';
  scxGridColumnsQuickCustomizationHint = 'Click here to show/hide/move columns';

  scxGridCustomizationFormBandsPageCaption = 'Bands';
  scxGridBandsQuickCustomizationHint = 'Click here to show/hide/move bands';

  scxGridCustomizationFormRowsPageCaption = 'Rows';

  scxGridConverterIntermediaryMissing = 'Missing an intermediary component!'#13#10'Please add a %s component to the form.';
  scxGridConverterNotExistGrid = 'cxGrid does not exist';
  scxGridConverterNotExistComponent = 'Component does not exist';
  scxImportErrorCaption = 'Import error';

  scxNotExistGridView = 'Grid view does not exist';
  scxNotExistGridLevel = 'Active grid level does not exist';
  scxCantCreateExportOutputFile = 'Can''t create the export output file';

  cxSEditRepositoryExtLookupComboBoxItem = 'ExtLookupComboBox|Represents an ultra-advanced lookup using the QuantumGrid as its drop down control';

  // date ranges

  scxGridYesterday = 'Yesterday';
  scxGridToday = 'Today';
  scxGridTomorrow = 'Tomorrow';
  scxGridLast30Days = 'Last 30 days';
  scxGridLast14Days = 'Last 14 days';
  scxGridLast7Days = 'Last 7 days';
  scxGridNext7Days = 'Next 7 days';
  scxGridNext14Days = 'Next 14 days';
  scxGridNext30Days = 'Next 30 days';
  scxGridLastTwoWeeks = 'Last two weeks';
  scxGridLastWeek = 'Last week';
  scxGridThisWeek = 'This week';
  scxGridNextWeek = 'Next week';
  scxGridNextTwoWeeks = 'Next two weeks';
  scxGridLastMonth = 'Last month';
  scxGridThisMonth = 'This month';
  scxGridNextMonth = 'Next month';
  scxGridLastYear = 'Last year';
  scxGridThisYear = 'This year';
  scxGridNextYear = 'Next year';
  scxGridPast = 'Past';
  scxGridFuture = 'Future';

  scxGridMonthFormat = 'mmmm yyyy';
  scxGridYearFormat = 'yyyy';

  // ChartView
  
  scxGridChartCategoriesDisplayText = 'Data';

  scxGridChartValueHintFormat = '%s for %s is %s';  // series display text, category, value
  scxGridChartPercentValueTickMarkLabelFormat = '0%';

  scxGridChartToolBoxDataLevels = 'Data Levels:';
  scxGridChartToolBoxDataLevelSelectValue = 'select value';
  scxGridChartToolBoxCustomizeButtonCaption = 'Customize Chart';

  scxGridChartNoneDiagramDisplayText = 'No diagram';
  scxGridChartColumnDiagramDisplayText = 'Column diagram';
  scxGridChartBarDiagramDisplayText = 'Bar diagram';
  scxGridChartLineDiagramDisplayText = 'Line diagram';
  scxGridChartAreaDiagramDisplayText = 'Area diagram';
  scxGridChartPieDiagramDisplayText = 'Pie diagram';

  scxGridChartCustomizationFormSeriesPageCaption = 'Series';
  scxGridChartCustomizationFormSortBySeries = 'Sort by:';
  scxGridChartCustomizationFormNoSortedSeries = '<none series>';
  scxGridChartCustomizationFormDataGroupsPageCaption = 'Data Groups';
  scxGridChartCustomizationFormOptionsPageCaption = 'Options';

  scxGridChartLegend = 'Legend';
  scxGridChartLegendKeyBorder = 'Key Border';
  scxGridChartPosition = 'Position';
  scxGridChartPositionDefault = 'Default';
  scxGridChartPositionNone = 'None';
  scxGridChartPositionLeft = 'Left';
  scxGridChartPositionTop = 'Top';
  scxGridChartPositionRight = 'Right';
  scxGridChartPositionBottom = 'Bottom';
  scxGridChartAlignment = 'Alignment';
  scxGridChartAlignmentDefault = 'Default';
  scxGridChartAlignmentStart = 'Start';
  scxGridChartAlignmentCenter = 'Center';
  scxGridChartAlignmentEnd = 'End';
  scxGridChartOrientation = 'Orientation';
  scxGridChartOrientationDefault = 'Default';
  scxGridChartOrientationHorizontal = 'Horizontal';
  scxGridChartOrientationVertical = 'Vertical';
  scxGridChartBorder = 'Border';
  scxGridChartTitle = 'Title';
  scxGridChartToolBox = 'ToolBox';
  scxGridChartDiagramSelector = 'Diagram Selector';
  scxGridChartOther = 'Other';
  scxGridChartValueHints = 'Value Hints';

implementation

end.
