unit LMDRTFConst;
{###############################################################################

LMDRTFConst unit (RM)
--------------------
Unit containing resource strings used by the components

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring

 // General
 IDRTF_OK='Готово';
 IDRTF_CANCEL='Отмена';
 IDRTF_CLOSE='Закрыть';
 IDRTF_HELP='&Помощь';

 // used for unnamed items in "Save as" dialog
 IDRTF_DOCUMENT='document';
 

 IDRTF_AVAILABLEFORMATS='Доступные форматы:';
 IDRTF_DATETIME='Дата/время';

 IDRTF_NEW='Создать';
 IDRTF_NONE='(none)';
 IDRTF_DELETE='Удалить';
 IDRTF_DELETEALL='Удалить все';
 IDRTF_SELECT='Выбрать';

 // Bookmark Dialog
 IDRTF_BOOKMARKS='Закладки';

 // RichText Editor
 IDRTF_ALIGN='Выравнивание';
 IDRTF_NUMBERING='Нумерация';
 IDRTF_UNDERLINE='Подчеркивание';

 // Paragraph
 IDRTF_PARAGRAPH = 'Параграф';
 IDRTF_JUSTIFY = '&Выравнять:';
 IDRTF_JUSTIFIES = 'Слева,"По центру",Справа,"С обеих сторон"';
 IDRTF_JUSTIFYLEFT = 'Выравнять влево';
 IDRTF_JUSTIFYCENTER = 'Выравнять по центру';
 IDRTF_JUSTIFYRIGHT = 'Выравнять вправо';

 IDRTF_MARGINS = 'Отступы';
 IDRTF_LEFT = 'левый';
 IDRTF_RIGHT = 'правый';
 IDRTF_FIRSTLINE = 'первая строка:';
 IDRTF_INDENTAT = 'на:';
 IDRTF_INDENTS = '(нет),увеличить отступ,"уменьшить отступ"';

 IDRTF_INTERVALS = 'Интервалы';
 IDRTF_BEFORE = 'перед:';
 IDRTF_AFTER = 'после:';
 IDRTF_LINESPACING = 'межстрочный интервал:';
 IDRTF_SPACINGS = 'одинарный,полуторный,двойной,минимум,точно,множитель';
 IDRTF_VALUE = 'значение:'; 

 IDRTF_TABSTOPS = '&Табулостопы';

 IDRTF_SET = 'Установить';

 // Link Dialog
 IDRTF_URL = 'URL';
 IDRTF_Link = 'Link';

 // Actions Category
 IDRTF_AC_FILE = 'Файл';
 IDRTF_AC_EDIT = 'Редактировать';
 IDRTF_AC_FORMAT = 'Формат';

 // Actions
 IDRTF_ANEW = 'Создать';
 IDRTF_AOPEN = 'Открыть...';
 IDRTF_ASAVE = 'Сокранить';
 IDRTF_ASAVEAS = 'Сохранить как...';
 IDRTF_APARAGRAPH = 'Параграф...';
 IDRTF_AFONT = 'Шрифт...';
 IDRTF_ABOLD = 'Полужирный';
 IDRTF_AITALIC = 'Курсив';
 IDRTF_AUNDERLINE = 'Подчеркнутый';
 IDRTF_ASUBSCRIPT = 'Подстрочный режим';
 IDRTF_ASUPERSCRIPT = 'Надстрочный режим';
 IDRTF_AUNDO = 'Отменить';
 IDRTF_AREDO = 'Вернуть';
 IDRTF_APRINT = 'Печать';
 IDRTF_APREVIEW = 'Предварительный просмотр...';
 IDRTF_APAGESETTINGS = 'Параметры страницы';
 IDRTF_AINSERTOBJ = 'Вставить объект...';
 IDRTF_AOBJPROPS = 'Свойства объекта';
 IDRTF_ACOPY = 'Копировать';
 IDRTF_ACUT = 'Вырезать';
 IDRTF_APASTE = 'Вставить';
 IDRTF_APASTESPECIAL = 'Специальная вставка...';
 IDRTF_ASELECTALL = 'Выделить все';
 IDRTF_ADELETE = 'Удалить';
 IDRTF_AALIGN = 'Выравнивание';
 IDRTF_AINCREASEINDENT = 'Увеличить отступ';
 IDRTF_ADECREASEINDENT = 'Уменьшить отступ';
 IDRTF_ANUMBERING = 'Нумерация';
 IDRTF_ANUMBERINGBULLET = 'Маркеры';
 IDRTF_ANUMBERINGARABICNUMBERS = 'Нумерация';
 IDRTF_AFIND = 'Поиск...';
 IDRTF_AREPLACE = 'Замена...';
 IDRTF_AINSERTCHAR = 'Вставить символ...';
 IDRTF_AINSERTDATETIME = 'Дата/время...';
 IDRTF_ASTATISTICS = 'Статистика...';


 // Charmap dialog
 IDRTF_FONT = 'Шрифт';
 IDRTF_CHARSET = 'CharSet';
 IDRTF_CHARMAP = 'Таблица символов';

 // Find&Replace Dialog
 IDRTF_FR_NOTFOUND = 'Строка не найдена!';
 IDRTF_FR_REPLACED = 'Произведено %d замен.';

 // TLMDRTFStatisticsDlg
 IDRTF_SD_CAPTION = 'Общая статистика';
 IDRTF_SD_STATISTICS = 'Статистика :';
 IDRTF_SD_PAGES = 'Страниц';
 IDRTF_SD_WORDS = 'Слов';
 IDRTF_SD_CHARACTERSWOS = 'Символов (без пробелов)';
 IDRTF_SD_CHARACTERSWS = 'Символов (включая пробелы)';
 IDRTF_SD_PARAGRAPHS = 'Абзацев';
 IDRTF_SD_LINES = 'Строк';

 // Ranges dialogs
 {IDRTF_COMMON = 'Common';
 IDRTF_STARTPOSITION = 'Start position:';
 IDRTF_ENDPOSITION = 'End position:';
 IDRTF_ADDRESS = 'Address:';
 IDRTF_DATASET = 'DataSet';
 IDRTF_CONNECTIONSTRING = 'Connection string:';
 IDRTF_QUERY = 'Query:';
 IDRTF_VIEW = 'View';
 IDRTF_FIELDNAME = 'Show field names';
 IDRTF_TABLEVIEW = 'Table view';
 IDRTF_FILENAME = 'File name:';
 IDRTF_IMAGE = 'Image';}

implementation

end.
