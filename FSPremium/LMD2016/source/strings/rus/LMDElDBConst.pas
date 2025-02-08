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
  SErrorInMTree = 'Ошибка в MTree : элемент не найден.';
  SDeleteFromDenyDataSet = 'Нельзя удалять из набора данных с включенной опцией DenyLookSetPosition.';
  SMasterDetailIncompatible = 'Внимание! Типы полей MasterField и DetailField различаются. При построении дерева будет предпринята попытка преобразования типов к одному.';
  SOnErrorInRelation = 'Не удалось установить связь в отношении %d. Проверьте типы и размер полей MasterField и DetailField.';
  SNoSetInstall = 'Источник данных DataSource не определен - нельзя редактировать.';
  SNoDSetInstall = 'Набор данных Dataset не определен в источнике DataSource - нельзя редактировать.';
  SOnMoveError = 'Нельзя переместить';
  SOnGoToBookmark = 'Не удается найти запись в наборе данных %s. Если вы используете в качестве набора данных запрос с параметрами, установите флажок DenyLookSetPosition для соответствующей связи.';
  SErrorInPattern = 'Ошибка в шаблоне! Проверьте имена полей и синтаксис.';
  SErrorPrebuildLevel = 'Минимальное возможное значение этого параметра равно 2.';
  SNoColumnSetAssigned = 'Набор данных для столбцов TreeGrid неопределен.';
  SNoValidDataSetName = 'Имя набора данных %s для столбцов TreeGrid неверно. Проверьте, участвует ли указанный набор данных в построении дерева.';
  SIncorrectColumnIndex = 'Неправильный индекс столбца.';
  SIncorrectFieldName = 'Неправильное имя %s.';

  SLMDNbrFirst = 'Первая запись';
  SLMDNbrPrior = 'Предыдущая запись';
  SLMDNbrNext = 'Следующая запись';
  SLMDNbrLast = 'Последняя запись';
  SLMDNbrInsert = 'Вставить запись';
  SLMDNbrDelete = 'Удалить запись';
  SLMDNbrEdit = 'Редактировать запись';
  SLMDNbrPost = 'Сохранить';
  SLMDNbrCancel = 'Отменить';
  SLMDNbrRefresh = 'Обновить';
  SLMDNbrSearch = 'Найти';
  SLMDNbrSetFilter = 'Установить фильтр';
  SLMDNbrRemoveFilter = 'Удалить фильтр';
  SLMDNbrClear = 'Очистить';
  SLMDNbrOpen = 'Открыть';
  SLMDNbrClose = 'Закрыть';
  SLMDNbrFindFirst = 'Найти первую';
  SLMDNbrFindPrior = 'Найти предыдущую';
  SLMDNbrFindNext = 'Найти следующую';
  SLMDNbrFindLast = 'Найти последнюю';

  SLMDTnbrFirstRoot = 'Первый узел в корне';
  SLMDTnbrFirst = 'Первый узел';
  SLMDTnbrPrior = 'Предыдущий узел';
  SLMDTnbrNext = 'Следующий узел';
  SLMDTnbrLast = 'Последний узел';
  SLMDTnbrLastRoot = 'Последний узел в корне';
  SLMDTnbrInsert = 'Вставить узел';
  SLMDTnbrInsertSubItem = 'Вставить дочерний узел';
  SLMDTnbrDelete = 'Удалить узел';
  SLMDTnbrEdit = 'Редактировать узел';
  SLMDTnbrRefresh = 'Обновить';


implementation

end.
