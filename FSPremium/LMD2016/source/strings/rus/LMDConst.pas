unit LMDConst;
{###############################################################################

LMDConst unit (--)
------------------

Unit containing resource strings used by the components

already available in several other languages!

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  // 8.0  --> TLMDCustomSimpleLabel
 IDS_OPENURL='&Open URL';
 IDS_COPYURL='&Copy URL';
 // ------

 // 7.1 MathParser
 IDS_SyntaxError = 'Синтаксическая ошибка';
 IDS_CloseBracketExpected = 'ожидается ")"';
 IDS_ExpressionEmpty = 'Выражение пусто';
 IDS_OpenBracketExpected = 'ожидается "("';
 IDS_InvalidArgument = 'Неправильный аргумент';
 IDS_MathFunctions = 'Математические функции';
 // ----------------------------------------------------------------------------
 
 IDS_PATH='Путь:';
 IDS_ON='ВКЛ';
 IDS_OFF='ВЫКЛ';

 // TLMDCheckListBoxDlg
 IDS_SELECT='Select...';
 IDS_SELECTOPTIONS='Select desired option(s)...';

 //ButtonBar
 IDS_ADDSECTION='Д&обавить секцию';
 IDS_DELSECTION='Уд&алить секцию';
 IDS_RENSECTION='П&ереименовать секцию';
 IDS_ADDITEM='&Добавить элемент';
 IDS_DELITEM='&Удалить элемент';
 IDS_RENITEM='&Переименовать элемент';
 IDS_SMALLICONS='&Маленькие иконки';
 IDS_LARGEICONS='&Большие иконки';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Календарь...';
 IDS_ACTUALDATE='Реальная дата';

 //EditControls
 IDS_INSERT='&Вставить';
 IDS_COPY='&Копировать';
 IDS_CUT='Выр&езать';
 IDS_UNDO='&Отменить';
 IDS_SELECTALL='Выделить все';
 IDS_DELETE='&Удалить';
 IDS_SEARCH='Поиск';
 IDS_SEARCHMSG1='Начало ... повторить с конца?';
 IDS_SEARCHMSG2='Конец ... повторить сначала?';
 IDS_REPLACE='Заменить';
 IDS_WORDWRAP='Перенос текста';
 IDS_LINED='Выравнивание';
 IDS_REDO='Вернуть';
 IDS_FONT='Шрифт';
 IDS_CLEAR='Очистить';
 IDS_ALIGNLEFT='Левое выравнивание';
 IDS_ALIGNRIGHT='Правое выравнивание';
 IDS_ALIGNCENTER='По центру';
 IDS_STATISTICS='Статистика текста';
 IDS_OPEN='Открыть';
 IDS_SAVE='Сохранить';
 IDS_PRINT='Печать';
 IDS_PAGE='Страница';
 IDS_EDIT='Редактировать'; 

 // Component Messages
 IDS_MUSTSHOWONE='Должен быть выбран хотя бы один стиль!';
 IDS_INVALIDOWNER='Неверный предок (<>TForm) или на форме второй экземпляр';
 IDS_INTERVALNOTFIT='Недопустимое значение в свойстве MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Далее >';
 IDS_BACK='< &Назад';
 IDS_FINISH='&Готово';
 IDS_HELP='&Помощь';
 IDS_CLOSE='&Закрыть';
 IDS_CANCEL='Отмена';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Это свойство больше не доступно в LMD-Tools!';

 // TLMDMessageHintController
 IDS_MESSAGEHINTNOTASSIGNED = 'Значение свойства MessageHintControl не задано!';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='приложение уже запущено...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Информация ';
 IDS_AboutAvailMemory='Доступная память:';
 IDS_AboutSysRes='Системные ресурсы:';
 IDS_AboutCompatible='или совместимый';
 IDS_AboutPlatform='Платформа, процессор:';
 IDS_FREE='свободно';

 {TLMDColorComboBox}
 IDS_COLORCOMBOBOXCUSTOM='Custom color...';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Выбор каталога...';
 IDS_DIRDRIVE='&Диск:';
 IDS_DIRPATH='&Путь:';
 IDS_NEWPATH='&Новый каталог';

 {TLMDTipDlg}
 IDS_TIPERROR='Диалог не доступен - не заполнено свойство Tips...';
 IDS_SHOWATSTART='Показывать при каждом запуске программы';
 IDS_TIPNEXT='&Следущий совет';
 IDS_TIPPREV='&Предыдущий совет';

 {TLMDWindowList}
 IDS_WLCAPTION='Список окон...';
 IDS_WLDESC='Доступные &окна:';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Больше не показывать это сообщение';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Ввод...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Текстовый редактор';


implementation

end.
