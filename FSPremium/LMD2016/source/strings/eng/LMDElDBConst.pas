unit LMDElDBConst;
{###############################################################################

LMDElDBConst unit
-----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils;

{$R LMDElPackDB.res}

type
  TElUpdateStylesType = (stPattern, stFontAndStyles, stHint, stCheckBox, stImages, stCaption, stShowCaption);
  TElTableName = type string;

  EOnUndefinedGridColumnsDataSet = class (Exception)
  end;

  ENoValidDataSetName = class (Exception)
  end;

  EIncorrectFieldName = class (Exception)
  end;
  EIncorrectColumnIndex = class (Exception)
  end;

  EErrorInPattern = class (Exception)
  end;

  EOnGoToBookmark = class (Exception)
  end;

  EOnMoveError = class (Exception)
  end;

  EOnErrorInRelation = class (Exception)
  end;

  TElDBUnicodeMode = (umFieldType, umForceUTF8, umForceUnicode);

resourcestring
  SErrorInMTree = 'Error in MTree : item not found';
  SDeleteFromDenyDataSet = 'Cannot delete from DataSet with DenyLookSetPosition option.';
  SMasterDetailIncompatible = 'Warning! MasterField and DetailField have different data types. When building the tree an attempt will be taken to cast them to one type.';
  SOnErrorInRelation = 'Failed to build relationship in relation %d. Check MasterField and DetailField fields data type and size.';
  SNoSetInstall = 'DataSource undefined. Can'#39't edit.';
  SNoDSetInstall = 'DataSet in DataSource undefined. Can'#39't edit.';
  SOnMoveError = 'Can'#39't move';
  SOnGoToBookmark = 'Can''t find a record in the dataset %s. If you use a parametrised query as a dataset, set DenyLookSetPosition for corresponding relationship to True.';
  SErrorInPattern = 'Error in pattern! Check names of data fields and syntax.';
  SErrorPrebuildLevel = 'Minimum possible value of this parameter is 2';
  SNoColumnSetAssigned = 'DataSet for TreeGrid columns undefined.';
  SNoValidDataSetName = 'The name %s for DataSet for TreeGrid columns is not valid.'#39'Check that this DataSet participates in building of tree';
  SIncorrectColumnIndex = 'Incorrect column index';
  SIncorrectFieldName = 'Name %s is incorrect';

  SLMDNbrFirst = 'First Record';
  SLMDNbrPrior = 'Prior Record';
  SLMDNbrNext = 'Next Record';
  SLMDNbrLast = 'Last Record';
  SLMDNbrInsert = 'Insert Record';
  SLMDNbrDelete = 'Delete Record';
  SLMDNbrEdit = 'Edit Record';
  SLMDNbrPost = 'Post Record';
  SLMDNbrCancel = 'Cancel Changes';
  SLMDNbrRefresh = 'Refresh';
  SLMDNbrSearch = 'Search';
  SLMDNbrSetFilter = 'Set Filter';
  SLMDNbrRemoveFilter = 'Remove Filter';
  SLMDNbrClear = 'Clear';
  SLMDNbrOpen = 'Open';
  SLMDNbrClose = 'Close';
  SLMDNbrFindFirst = 'Find First';
  SLMDNbrFindPrior = 'Find Prior';
  SLMDNbrFindNext = 'Find Next';
  SLMDNbrFindLast = 'Find Last';

  SLMDTnbrFirstRoot = 'First Item in root';
  SLMDTnbrFirst = 'First Item';
  SLMDTnbrPrior = 'Prior Item';
  SLMDTnbrNext = 'Next Item';
  SLMDTnbrLast = 'Last Item';
  SLMDTnbrLastRoot = 'Last Item in root';
  SLMDTnbrInsert = 'Insert Item';
  SLMDTnbrInsertSubItem = 'Insert SubItem';
  SLMDTnbrDelete = 'Delete Item';
  SLMDTnbrEdit = 'Edit Item';
  SLMDTnbrRefresh = 'Refresh';


implementation

end.
