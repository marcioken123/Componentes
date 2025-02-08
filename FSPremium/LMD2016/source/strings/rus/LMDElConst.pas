unit LMDElConst;
{###############################################################################

LMDElConst unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}
interface

uses
  Graphics;

{$R 'LMDElPack.res'}

resourcestring
  SLMDDay  = 'День ';
  SLMDWeek = 'Неделя ';
  SLMDHintNextYear = 'Следующий год';
  SLMDHintPrevYear = 'Предыдущий год';
  SLMDHintNextMonth = 'Следующий месяц';
  SLMDHintPrevMonth = 'Предыдущий месяц';
  SLMDCapClear      = 'Очистить';
  SLMDCapToday      = 'Сегодня';
  SLMDCapOk      = 'OK';
  SLMDCapCancel      = 'Отмена';
  SLMDCapCalendar   = 'Календарь';
  SLMDCapCalendarGB = 'Дата';
  SLMDCapClockGB = 'Время';

  SLMDCustom = 'Пользовательский ...';

  SLMDUndo = '&Отменить';
  SLMDCut = '&Вырезать';
  SLMDCopy = '&Копировать';
  SLMDPaste = 'Вст&авить';
  SLMDDelete = '&Удалить';
  SLMDSelectAll = 'В&ыделить все';

  SLMDShiftP = 'Shift+';
  SLMDAltP = 'Alt+';
  SLMDCtrlP = 'Ctrl+';
  SLMDLeftP = 'Left+';
  SLMDRightP = 'Right+';
  SLMDMiddleP = 'Middle+';
  SLMDDoubleP = 'Double+';
  SLMDLWinP = 'Win+';
  SLMDRWinP = 'Win+';

  SLMDElCantSetThisEntryAs = 'Нельзя установить параметр инициализации  %s';
  SLMDElCantGetThisPropAs = 'Нельзя получить это свойство как %s';
  SLMDElCantSetThisPropAs = 'Нельзя установить это свойство как %s';

  SLMDListIndexOutOfBounds = 'Индекс [%d] выходит за допустимые пределы в списке';

  SLMDBitmapInvalid = 'Изображение имеет неправильный формат.';
  SLMDSyntaxError = 'Синтаксическая ошибка';
  SLMDCloseBracketExpected = 'ожидается ")"';
  SLMDExpressionEmpty = 'Выражение пусто';
  SLMDOpenBracketExpected = 'ожидается "("';
  SLMDInvalidArgument = 'Неправильный аргумент';
  SLMDMathFunctions = 'Математические функции';

  SLMDShowNextTime = 'Показать в следующий раз';
  SLMDDSecondsLeft = 'Осталось %d секунд(ы)';

  SElNotIdent = 'Данное целое не имеет идентификатора';
  SElInstanceIsNotDefined = 'Экземпляр не определен';
  SElRequiredPropertyIsNotDefined = 'Необходимое свойство %s не определено';
  SElCantGetThisPropAs = 'Нельзя получить это свойство как %s';
  SElCantSetThisPropAs = 'Нельзя установить это свойство как %s';
  SElIsNotEnum = 'Свойство %s не имеет перечисляемых значений';
  SElReadonly = 'Свойство %s не может быть изменено';
  SElInvalidType = 'Неправильное преобразование типа для %s';
  SElNotFound = '%s %s не найдено';
  SElCompUnassignedValue = '';
  SElClassUnassignedValue = '';

  SLMDNoControl = 'Не указан скроллбар при попытке создания экземпляра класса TElScrollBarStyles';

  SLMDNoMoreTokensMessage = 'Символов больше не осталось';

  SInvalidThemeFileName = 'Неправильное имя файла темы [%s]';
  SUnknownTheme = 'Неизвестная тема [%s]';
  SUnknownThemePart = 'Неизвестный элемент [%d] в теме';
  SUnknownThemeColorScheme = 'Неизвестная цветовая схема [%s] в теме';
  SUnknownThemeBool = 'Неизвестная системная метрика - логичекое [%d]';
  SUnknownThemeColor = 'Неизвестная системная метрика - цвет [%d]';
  SUnknownThemeFont = 'Неизвестная системная метрика - шрифт [%d]';
  SUnknownThemeInt = 'Неизвестная системная метрика - целое [%d]';
  SUnknownThemeSize = 'Неизвестная системная метрика - размер [%d]';
  SUnknownThemeString = 'Неизвестная системная метрика - строка [%d]';
  SInvalidRefCount = 'Неправильное значение RefCount в [%s]';

  SWinXPThemeNoDisplayName = 'Не указано отображаемое имя для данной темы';
  SWinXPThemeInvalidParameter = 'Неправильный параметр функции';
  SWinXPThemeNoDocProp = 'Свойство [%s] не определено';
  SWinXPThemeNoSchemeSection = 'Не удается найти подходящую секцю темы';
  SWinXPThemeNoMetricsProp = 'Свойство [%d] системной метрики не определено';
  SWinXPThemeNoSchemeProp = 'Свойство темы [%d] не определено';
  SWinXPThemeTextMetricFailed = 'Не удалось получить текстовую метрику';

  SUnkOSError = 'Не удалось вызвать функцию ОС';
  SOSError = 'Системная ошибка.  Код: %d.'#13#10'%s';

  STExOutOfBounds = 'Индекс элемента ElTree выходит за границы.';
  STexInvItem = 'Не указан элемент ElTree';
  STexRecursiveMove = 'Нельзя переместить элемент в один из его подэлементов';

  SInvalidPropertyValue = 'Неправильное значение свойства';

  SLMDCaption = 'Редактор списка изображений';

  SLMDQuestion = 'Выберите способ обработки данного изображения';

  SLMDTipOfTheDay = 'Совет дня...';
  SLMDDidYouKnow = '  Знаете ли Вы, что...';
  SLMDShowTipsAtStartup = 'Показывать при запуске';
  SLMDNextTip = '&Далее...';
  SLMDClose = '&Отмена';

  SLMDStyleInstanceNotAssigned  = 'Стиль не инициализирован для %s';

const
  LMDElHideSelectTextColor = clBtnShadow;
implementation
end.
