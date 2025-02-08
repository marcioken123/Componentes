unit LMDSctCst;
{###############################################################################

LMDSctCst unit (YB)
-------------------
Contains resource strings needed in the  LMD Script Pack.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  SLMDCannotMixDebuggers        = 'Cannot connect ActiveX and Pascal scripts to ' +
                                  'single debugger.';
  SLMDScriptCantCreateEngine    = 'Can''t create script engine ''%s''';
 
  SLMDTooManyParams             = 'Превышено максимальное количество аргументов.';
  SLMDWrongArgCount             = 'Неверное количество аргументов. Метод или свойство: %s';
  SLMDUnsupportedSetType        = 'Неподдерживаемый тип множества (set).';
  SLMDUnregisteredEventType     = 'Незарегистрированный тип события: %s.';
  SLMDDuplicateNamedItem        = 'Объект %s уже существует.';
  SLMDDebuggingNotSupported     = 'Виртуальная машина скрипта не поддерживает отладку.';
  SLMDValNamedItemRequired      = 'Value named item required. ''%s'' is an object.';
  SLMDCantFindConstructor       = 'Конструктор типа %s с параметрами [%s] не найден.';

  SLMDWrongFloat                = 'Синтаксическая ошибка в числовой константе.';
  SLMDWrongInteger              = 'Синтаксическая ошибка в целочисленной константе.';
  SLMDUnterminatedStr           = 'Незавершенный строковый литерал.';
  SLMDIllegalChar               = 'Неверный символ: ''%s'' ($%x)';

  SLMDInvalidDirective          = 'Неверная директива: ''%s''.';
  SLMDTooComplexIfCond          = 'Too complex $IF directive condition.';
  SLMDDirectiveNotSupported     = 'Директива ''%s'' не поддерживается.';
  SLMDUnterminatedDirective     = 'Незавершенная директива условной компиляции.';
  SLMDIncFileNotFound           = 'Включаемый файл ''%s'' не найден.';


  SLMDStrExpected               = 'Ожидается %s. Строка: %d, Позиция: %d.';
  SLMDInvalidToken              = 'Неверный токен: %s. Строка: %d, Позиция: %d. Данные: %s';
  SLMDInvalidTokenShort         = 'Неверный токен: %s.';
  SLMDValidClassVis             = 'токен видимости класса';
  SLMDValidPropSpecifier        = 'спецификатор свойства';
  SLMDValidDirective            = 'директива';

  SLMDDocParseError             = '[Ошибка] Грамматическая ошибка: %s';
  SLMDDocInvalidFileFormat      = 'Неверный формат файла.';
  SLMDDocUnsuppFileVers         = 'Неподдерживаемая версия формата файла.';

  SLMDCompWarning               = '[Предупреждение] %s';
  SLMDCompError                 = '[Ошибка] %s';
  SLMDCompAnalizeResNotFound    = 'Не найдены результаты анализа модуля ''%s''.';
  SLMDCompFioleReadFailed       = 'Сбой при чтении файла ''%s'': %s.';
  SLMDCompNotValidIdent         = 'Неверный идентификатор ''%s''.';
  SLMDCompCantAnalizeUntpdCst   = 'Анализ типа нетипизированной константы не поддерживается.';
  SLMDCompOverlProcsNotSupp     = 'Перегруженные (overloaded) процедуры не поддерживаются.';
  SLMDCompOverlMethodsNotSupp   = 'Перегруженные (overloaded) методы не поддерживаются.';
  SLMDCompOpenArraysNotSupp     = 'Вариантные ''open arrays'' не поддерживаются.';
  SLMDCompUntypedParamNotSupp   = 'Нетипизированные const, var или out параметры не поддерживаются.';
  SLMDCompBoundedStrTypeNotSupp = 'Ограниченные строковые типы не поддерживаются в var ' +
                                  'и out параметрах.';
  SLMDCompNObjProcTypesNotSupp  = 'Не объектные процедурные типы не ' +
                                  'поддерживаются.';
  SLMDCompPointersNotSupp       = 'Указатели не поддерживаются.';
  SLMDCompFileTypesNotSupp      = 'Файловые типы не поддерживаются.';
  SLMDCompArraysNotSupp         = 'Массивы не поддерживаются.';
  SLMDCompInterfacesNotSupp     = 'Интерфейсные типы не поддерживаются.';
  SLMDCompUnnamedTypesNotSupp   = 'Неявные неименованные %s типы не поддерживаются.';
  SLMDCompDeclHasErrors         = '''%s'' имеет ошибки.';
  SLMDCompDeclHasWarnings       = '''%s'' имеет предупреждения.';
  SLMDCompDeclHasBeenUnchecked  = '''%s'' был отключен пользователем.';
  SLMDCompDeclNotType           = '''%s'' не является типом.';
  SLMDCompDeclNotSupp           = '''%s'' не поддерживается.';
  SLMDCompDeclNotFound          = '''%s'' не найден.';

  SLMDCompConstantType          = 'Тип константы: ';
  SLMDCompVariableType          = 'Тип переменной: ';
  SLMDCompReturnType            = 'Тип возвращаемого значения: ';
  SLMDCompFieldType             = 'Тип поля: ';
  SLMDCompPropertyType          = 'Тип свойства: ';
  SLMDCompParameter             = 'Параметр ''%s'': ';
  SLMDCompTypeAlias             = 'Альяс типа: ';
  SLMDCompAncestorType          = 'Тип класса-предка: ';

  SLMDDocFormOk                 = 'Ok';
  SLMDDocFormFailed             = 'Ошибка';
  SLMDDocFormNoSelection        = '<нет выденения>';
  SLMDDocFormParsing            = 'Идет грамматический разбор...';
  SLMDDocFormAnalizing          = 'Идет анализ...';
  SLMDDocFormNoIDESourceEditor  = 'Не найден редактор кода для модуля ''%s''.';

  SLMDInvalidIDEVers            = 'LMD ScriptPack ImportWizard: ' +
                                  'Неподдерживаемая версия Delphi IDE.';
  SLMDNoIDEConfigKey            = 'LMD ScriptPack ImportWizard: ' +
                                  'Не удается прочитать ключ конфигурации ' +
                                  'IDE ''%s'' из реестра.';
  SLMDNoOpenedUnit              = 'Нет открытых модулей.'#13#10 +
                                  'Пожалуйста, откройте импортируемый модуль в ' +
                                  'редакторе Delphi IDE.';
  SLMDDirNotExists              = 'Каталог ''%s'' не существет.';
  SLMDRegValueNotExists         = 'Значение ''%s'' не найдено в реестре.';

  SLMDBreakpointReached         = 'Breakpoint at %s, line: %d';
  SLMDBreakpointReachedPass     = 'Breakpoint at %s, line: %d. Pass %d of %d';
  SLMDBreakpointMessage         = 'Breakpoint message: %s';
  SLMDBreakpointEvalExpr        = 'Breakpoint expression %s: %s';
  TLMDBreakpointWholeStackHdr   = 'Breakpoint Call Stack: log all stack frames';
  TLMDBreakpointNStackHdr       = 'Breakpoint Call Stack: log %d stack frame(s)';


  { Pascal Script }

  SLMDVMNonInitialize           = 'Виртуальная машина должна быть не инициализирована.';
  SLMDVMInitialize              = 'Виртуальная машина должна быть инициализирована.';
  SLMDVMActive                  = 'Виртуальная машина должна быть активна.';
  SLMDVMProcRequired            = 'Ожидается указатель на функцию.';
  SLMDVMValObjRequired          = 'Ожидается переменная или константа.';
  SLMDVMAborted                 = 'Выполнение скрипта было прервано.';
  SLMDInvalidDebugThread        = 'Debug evaluation is only allowed from the breaked thread.';


  SLMDParserTypeExpected        = 'Ожидается идентификатор типа';
  SLMDParserReRaise             = 'Инструкция raise без аргументов разрешена только ' +
                                  'внутри обработчика исключительных ситуаций';
  SLMDParserIEInvalidOperator   = 'Внутренняя ошибка: неверный тип оператора';

  SLMDRuntimeUndeclaredId       = 'Необъявленный идентификатор: ''%s''';
  SLMDRuntimeOutsideOfLoop      = 'BREAK или CONTINUE за пределами цикла';
  SLMDRuntimeEBCFromFinally     = 'Невозможно выполнить BREAK, CONTINUE или EXIT ведущие вне текущего FINALLY';
  SLMDRuntimeCannotAssign       = 'Недопустимое присвоение';
  SLMDRuntimeInvalidParamCount  = 'Неверное количество аргументов';
  SLMDRuntimeTypeMismatch       = 'Неподходящий тип или неверное приведение типов';
  SLMDRuntimeObjectRequired     = 'Тебуется ненулевая ссылка на объект';
  SLMDRuntimeLoopVar            = 'Переменная в цикле for должна быть простой локальной переменной';
  SLMDRuntimeCannotRaiseNil     = 'Невозможно выбросить (raise) nil исключение';
  SLMDRuntimeCannotRaiseLocked  = 'Невозможно выбросить (raise) исключение: Исключение заблокировано обработчиком';
  SLMDRuntimeLowOnlyArray       = 'Функция Low: ожидается массив';
  SLMDRuntimeHighOnlyArray      = 'Функция High: ожидается массив';
  SLMDRuntimeViolatesBounds     = 'Значение выражения выходит за границы допустимого диапазона';
  SLMDRuntimeInvalidDispId      = 'Неверный DispId';
  SLMDRuntimeInvalidException   = 'Внутренняя ошибка: Неверный тип исключительной ситуации';
  SLMDRuntimeOleError           = 'Ошибка OLE %.8x';
  SLMDRuntimeIEInvalidInstr     = 'Внутренняя ошибка: Неверный код инструкции';
  SLMDRuntimeIEInvalidObjKind   = 'Внутренняя ошибка: Неверный тип объекта';
  SLMDRuntimeIEInvalidBracket   = 'Внутренняя ошибка: Неверный тип скобок';
  SLMDRuntimeIENoBreakpointInfo = 'Внутренняя ошибка: Не найдено информации о брейкпойнте';

  SLMDCompTemplatesNotSupp      = 'Templates are not supported.';

  SLMDCompOverlGroupIsEmpty     = 'Overload group is empty.';
  SLMDCompOverlGroupNotSupp     = 'Overload group not supported.';
  SLMDCompHelpersNotSupp        = 'Class or record helpers are not supported.';
  SLMDCompRefToTypesNotSupp     = 'Procedure reference types are not ' +
                                  'supported.';


implementation

end.
