unit LMDShConsts;
{###############################################################################

LMDShConsts unit (DS)
------------------------
Contains ShellPack constants


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface
resourcestring
  // ToDo
  IDShell_About ='About...';

  IDSHELL_ErrShVersion                 = 'Операция не поддерживается в этой версии shell';
  IDSHELL_ErrInvalidFolder             = 'Неверный каталог';

  IDSHELL_OK                    = 'Ok';
  IDSHELL_CANCEL                = 'Отмена';

  IDSHELL_ColumnName            = 'Имя';
  IDSHELL_ColumnSize            = 'Размер';
  IDSHELL_ColumnType            = 'Тип';
  IDSHELL_ColumnAttr            = 'Атрибуты';
  IDSHELL_ColumnCreateDate      = 'Дата создания';
  IDSHELL_ColumnCreateTime      = 'Время создания';
  IDSHELL_ColumnAccessDate      = 'Дата последнего доступа';
  IDSHELL_ColumnAccessTime      = 'Время последнего доступа';
  IDSHELL_ColumnWriteDate       = 'Дата модификации';
  IDSHELL_ColumnWriteTime       = 'Время модификации';
  IDSHELL_ColumnModified        = 'Изменен';
  sBrowseForFolder              = 'Выбор папки';
  sBrowseInstruction            = 'Пожалуйста, выберите папку';
  sDeleteFolderHint             = 'Удаление выбранных папок.';
  sCreateFolderHint             = 'Создание новой папки.';
  sEmpty                        = '(пусто)';
  sNewFolderName                = 'Новая папка';
  sDuplicatedPath               = 'Путь уже существует в списке!';
  sPickRootPath                 = 'Пожалуйста, выберите root path';
  sEditRoot                     = 'Редактировать корневой каталог';
  sPathCaption                  = 'Каталоги';

  // LMDSHListDlg
  IDSHELL_SELECTDETAILS         = 'Выбор столбцов в таблице';
  IDSHELL_DEFAULTCOLUMNS        = 'Использовать умалчиваемые колонки';
  IDSHELL_BUTTONUP              = 'Вверх';
  IDSHELL_BUTTONDOWN            = 'Вниз';
  IDSHELL_WIDTHCAPTION          = 'Ширина выбранного столбца (точек):';
  IDSHELL_COLINSTRUCTION        = 'Пометьте столбцы, которые следует отображать для файлов в этой папке';
  IDSHELL_HIDE                  = 'Скрыть';
  IDSHELL_DISPLAY               = 'Показать';

  // Filter Dialog
  IDSHELL_SpecifyFilter         = 'Установите фильтр...';
  IDSHELL_FilterInstruction     = 'Элементы фильтра, разделенные точкой с запятой.';
  IDSHELL_FilterOptions         = 'Фильтр отключен'#13#10'Только файлы'#13#10'Файлы и папки';
  IDSHELL_Filters               = 'Фильтры';
  IDSHELL_ApplyFilter           = 'Применить фильтр к...';

  IDSHELL_COPYTO                = 'Копировать в...';
  IDSHELL_COPYTOINST            = 'Щелкните на папке, куда должны быть скопированы элементы.';
  IDSHELL_MOVETO                = 'Переместить в ...';
  IDSHELL_MOVETOINST            = 'Щелкните на папке, куда должны быть перемещены элементы.';
  IDSHELL_SHOWPROPERTIES        = 'Свойства';
  IDSHELL_RENAME                = 'Перименовать';
  IDSHELL_OPENWITH              = 'Открыть с помощью...';
  IDSHELL_OPEN                  = 'Открыть';
  IDSHELL_CREATEFOLDER          = 'Создать папку';
  IDSHELL_RUN                   = 'Выполнить';
  IDSHELL_MAILTO                = 'Mail To...';
  IDSHELL_BACKWARD              = 'Назад';
  IDSHELL_FORWARD               = 'Вперед';
  IDSHELL_UPLEVEL               = 'Вверх';
  IDSHELL_CUT                   = 'Вырезать';
  IDSHELL_COPY                  = 'Копировать';
  IDSHELL_PASTE                 = 'Вставить';
  IDSHELL_DELETE                = 'Удалить';
  IDSHELL_SELECTALL             = 'Выделить все';
  IDSHELL_INVERTSELECTION       = 'Обратить выделение';
  IDSHELL_OPENDOSWINDOW         = 'Открыть DOS окно';
  IDSHELL_FINDFILES             = 'Поиск файлов...';
  IDSHELL_FINDCOMPUTER          = 'Поиск компьютера...';
  IDSHELL_FORMATDISK            = 'Форматировать диск...';
  IDSHELL_SELECTDISKFORMAT      = 'Выберите диск для форматирования';
  IDSHELL_COPYDISK              = 'Копировать диск...';
  IDSHELL_MAPDRIVE              = 'Подключить сетевой диск...';
  IDSHELL_UNMAPDRIVE            = 'Отключить сетевой диск...';
  IDSHELL_EDITDISKLABEL         = 'Метка диска ...';
  IDSHELL_SELECTDISKLABEL       = 'Выберите метку диска';
  IDSHELL_FILTER                = 'Фильтр...';
  IDSHELL_COPYFILENAMEASTEXT    = 'Копировать имя файла как текст';
  IDSHELL_COPYPATHNAMEASTEXT    = 'Копировать путь к файлу как текст';
  IDSHELL_VIEW                  = 'Просмотр';

implementation


end.
