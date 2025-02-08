unit LMDSedConst;
{$I LMDCmps.inc}

{###############################################################################

LMDSedConst unit (VT)
---------------------
This unit contains Resource Strings for the LMD-Tools Syntax Edit packages.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface
         
{------------------------------------------------------------------------------}

resourcestring
  //Utils
  SLMDBadSegment = 'Неверный сегмент передан функции';
  
  //Parser
  SLMDSedIntAttirbuteRequired = 'Здесь требуется атрибут %s типа Int';
  SLMDSedIntAttrRangeRequired = 'Здесь требуется атрибут %s типа Int в диапазоне (а не это: %d ): [%d, %d]';
  SLMDSedBadIntAttribute = 'Задан неверный формат Int-атрибута: %s';
  SLMDSedBoolAttributeRequired = 'Здесь требуется атрибут %s типа Boolean';
  SLMDSedBadBoolAttribute = 'Задан неверный формат Boolean-атрибута: %s. Правильный формат: 0/1 или "true"/"false"';
  SLMDSedEmptyRegexAttribute = 'Задан пустой Regex-атрибут ''%s'' в узле ''%s''. Нужен непустой.';
  SLMDSedEmptyRegexSubNode = 'Задан пустой Regex-подузел ''%s'' в узле ''%s''. Нужен непустой.';

  SLMDSedEmptyRegexNodeText = 'Заданы пустые Regex-атрибут ''%s'' и соответствующий подузел в узле''%s''. Впишите Regexp в узел или атрибут.';
  SLMDSedBadRegexAttribute = 'Ошибка в атрибуте ''%s'' узла %s: regex: %s, ошибка: %s';
  SLMDSedBadRegexSubNode = 'Ошибка в подузле''%s'' узла %s: regex: %s, ошибка: %s';
  SLMDSedBadRegexNodeText = 'Ошибка в Regex-узле ''%s'': regex: %s, ошибка: %s';

  SLMDSedEmptyInheritAttribute = 'Атрибут ''inherit'' должен быть непустой ссылкой на схему';
  SLMDSedUnnamedScheme = 'Не задано имя для схемы';
  SLMDSedEmptyKeywordNode = 'Узел ''Keyword'' не должен быть пустым';
  SLMDSedEmptyKeywordsList = 'Узел ''Keywords'' должен содержать непустой список ключевых слов';
  SLMDSedBadSkipTokenName = 'В SkipSyntaxTokens указан токен ''%s'', не существующий ни в схеме, ни в её предках. Задайте какой-нибудь токен из схемы';  
  SLMDSedStartGroupUsedBadIndex = 'Атрибут startGroupUsed должен быть в диапазоне: >=0  and < (regex groups count: %d)';

  SLMDSedEndGroupUsedBadIndex = 'Атрибут endGroupUsed должен быть в диапазоне: >=0  и < (число групп в regexp-е: %d)';
  SLMDSedInvalidFontStyle = 'Неверный формат атрибута ''fontStyle'': ';
  SLMDSedTokenShouldHaveNameAttr = 'Не задано имя для узла <Token>';
  SLMDSedInvalidBgColor = 'Задан неверный формат цвета для атрибута ''backgroundColor''';
  SLMDSedInvalidTextColor = 'Задан неверный формат цвета для атрибута ''textColor''';
  SLMDSedErrorLoadingSyntaxScheme = 'Ошибка %s на загрузке синтаксической схемы. Ошибка такая: %s';
  SLMDSedDocumentShouldHaveSchemeList = 'В документе должен быть корневой эелемент SchemeList!';
  SLMDSedSchemeListShouldNameRoot = 'Узел SchemeList должен содержать атрибут ''root'' с именем начальной схемы!';
  SLMDSedRootSchemeNotFound = 'В документе не находится начальная схема ''%s''!';
  SLMDSedCantFindSchemeDocument = 'Не находится документ для схемы ''%s''';
  SLMDSedCantFindSchemeByRef = 'Не находится схема по имени: ''%s''!';
  SLMDSedCyclicInheritance = 'Циклическая ссылка в цепочке наследования схем! ==> Цепочка: ';
  SLMDSedSchemeLoadError = 'Ошибка загрузки схемы: ';
  SLMDSedCurrentDocIs = 'Текущий документ: %s, %s';
  SLMDSedCurrentSchemeNameIs = 'Имя текущей схемы: %s';
  SLMDSedCurrentRuleCodeIs = 'Код текущего узла с правилом (RegexRule/RegexBlock etc): ';

  SLMDSedCurrentBlockCodeIs = 'Код текущего узла <SyntaxBlock>: ';
  SLMDSedDocumentLoadingError = 'Ошибка загрузки XML-документа со схемами: ';
  SLMDSedBadIntCodeName = 'Ошибочный код токена: ';
  SLMDSedAttributesDocIs = 'Документ с цветовой схемой: %s';
  SLMDSedErrorLoadingColorScheme = 'Ошибка ''%s'' на загрузке цветовой схемы. Ошибка такая: %s';
  SLMDSedAttributesDocNoRootNode = 'Цветовая схема должна содержать корневой атрибут <Attributes>.';
  SLMDSedUniqueTokenName = 'Атрибут ''name'' в узле <Token> должен быть уникален по всей цветовой схеме. Найдено дублирующееся имя: %s';
  SLMDSedEmptyTokenName = 'Attribute ''name'' of node <Token> should exist and be non-empty';
  SLMDSedTokenNodeReadingError = 'Ошибка загрузки узла <Token>: %s';
  SLMDSedInvalidTokenReference = 'Атрибут ''%s'' узла <Token> должен быть ссылкой на существующий <Token>!';
  SLMDSedRegexNodeInnerSchemeTokenBoth = 'Узел <Regex> не может содержать атрибуты ''innerScheme'' и ''token'' одновременно';
  SLMDSedInvalidInnerScheme = 'Атрибут ''innerScheme'' должен ссылаться на какую-нибудь схему';
  SLMDSedStartTokenInRegexBlock = 'Узел <RegexBlock> не может содержать атрибуты ''start_token'' или ''token*'' в подузле ''Start''';
  SLMDSedInnerContentGoupBadIndex = 'Атрибут ''innerContentGroup'' должен быть меньше %d (числа подвыражений в стартовом Regexp-е)';
  SLMDSedChainBlockShouldHaveUniqueNameInScheme = 'Атрибут ''name'' узла <ChainBlock> должен быть уникален для всех узлов <ChainBlock> в схеме';
  SLMDSedChainBlockNotFound = 'Не находится узел <ChainBlock> по имени:''%s''';
  SLMDSedEmptyTokenLine = 'This line does not have any tokens';
  SLMDSedBadTokenIdx = 'Bad index for token: %d. Valid range: [%d, %d]';  

  SLMDSedDecodeAttributesBadArgument = 'Bad argument for LMDDecodeTokenXML: CustomAttributes field should be nil';

  //Document
  SLMDSedDocInvalidMarkUsed = 'Нельзя работать с атрибутами удалённого маркера. Mark.Valid=false.';
  SLMDSedDocDisposedMarkersUsed = 'Эта коллекция маркеров была удалена из документа. Теперь ей пользоваться нельзя.';
  SLMDSedDocCantRemoveInvalidMarker = 'Нельзя удалить маркер со свойством Valid=false';
  SLMDSedDocInvalidCharIndex = 'Неверный индекс символа: %d. Допустимый диапазон: [%d, %d].';
  SLMDSedDocInvalidCharInsIndex = 'Неверный индекс символа: %d. Допустимый диапазон: [%d, %d].';
  SLMDSedDocInvalidSegment = 'Плохой Segment задан параметром методу документа';
  SLMDSedDocSyntaxSchemeNotFound = 'Не находится синтаксическая схема по имени: ';
  SLMDSedDocColorSchemeNotFound = 'Не находится цветовая схема по имени: ';
  SLMDSedInvalidSchemeName = 'Имя элемента в коллекции должно быть уникальным и непустым';
  SLMDSedInvalidRangeOrder = 'Начало диапазона должно быть меньше или равно его концу: диапазон: [%d, %d]';
  SLMDSedDocMethodInUpdatingState = 'Этот метод нельзя вызывать, пока документ в пакетном режиме (Doc.InsideCompoundEdit=true)';
  SLMDSedDocChangesLocked = 'Сейчас изменения в тексте документа запрещены';
  SLMDSedDocMarkersLocked = 'Сейчас запрещены изменения маркеров документа';
  SLMDSedDocCantUndoForAuthor = 'Отмена для автора с ID=%d невозможна';
  SLMDSedDocCantRedoForAuthor = 'Возврат для автора с ID=%d невозможен';
  SLMDSedDocCantUndo = 'Отмена невозможна. Стек отмен пуст.';
  SLMDSedDocCantRedo = 'Возврат невозможен. Стек возвратов пуст.';
  SLMDSedDocNotInCompoundEdit = 'Документ должен быть в пакетном режиме для этой операции. (Doc.InsideCompoundEdit=true)';
  SLMDSedDocInvalidCustomMarkers = 'Заданные маркеры не принадлежат этому документу';
  SLMDSedDocCantDetachDocumentMarkers = 'Document.Bookmarks or Document.Breakpoints can''t be detached from Document';
  SLMDSedInvalidLineIdx = 'Плохой индекс для строчки: %d. Правильный диапазон: [%d, %d]';
  SLMDSedDocInvalidOffsetToSearch = 'Плохой индекс для поиска в документе: %d. Правильный диапазон: [%d, %d]';
  SLMDSedDocInvalidOffset = 'Плохой индекс символа в документе: %d. Правильный диапазон: [%d, %d]';
  SLMDSedDocBreakpointExpectedByMethod = 'Маркер для этого метода должен принадлежать коллекции Breakpoints';
  SLMDSedDocReadOnly = 'Запрещены изменения в документе (ReadOnly=true)';
  SLMDSedDocInternalClassCreate = 'Этот объект не может быть создан пользователем. Его сам документ для себя создаёт.';  

  //View
  SLMDSedViewBadPhysScreenLineIdx = 'Плохой индекс физической строчки: %d. Правильный диапазон: [%d, %d]';
  SLMDSedViewBadPhysLineIdx = 'Плохой индекс физической строчки в пределах экрана: %d. Правильный диапазон: [%d, %d]';
  SLMDSedViewBadScreenWidth = 'Invalid screen width given: [%d]. Valid range: [1..MAXINT]';
  SLMDSedViewBadScreenHeight = 'Invalid screen height given: [%d]. Valid range: [1..MAXINT]';
  SLMDSedViewBadNegativeScrollY = 'Bad scroll line index: [y < 0].';
  SLMDSedViewBadNegativeScrollYInPos = 'Bad scroll position: [y < 0].';
  SLMDSedViewBadNegativeScrollXInPos = 'Bad scroll position: [x < 0].';
  SLMDSedViewBadScrollPosForOffset = 'Плохая экранная позиция для получения её индекса символа: [x=%d, y=%d]. Правильный диапазон: [x=%d, y=%d]-[x=%d, y=%d]';
  SLMDSedViewBadScrollRangeOrder = 'Неправильный порядок в экранном диапазоне: [x=%d, y=%d]-[x=%d, y=%d]';
  SLMDSedViewCollapsedLineOp = 'Нельзя выполнить эту операцию со свёрнутой физической строчкой: %d';
  SLMDSedViewNotCollapsedLineOp = 'Нельзя выполнить эту операцию с несвёрнутой физической строчкой: %d';
  SLMDSedViewOpWithFoldOnly = 'Для этой операции требуется, чтобы строчка была началом свёртки: %d';
  SLMDSedViewBadTabWidth = 'Bad tab width: %d. It should be in bounds: [%d, %d]';  
  SLMDSedViewBadScrollLine = 'Плохой индекс экранной строчки: %d. Правильный диапазон: [%d, %d]';
  SLMDSedViewBadScreenLine = 'Плохой индекс дисплейной строчки: %d. Правильный диапазон: [%d, %d]';
  SLMDSedViewBadScreenLineRange = 'Неверный диапазон дисплейных строчек: [%d, %d]';
  SLMDSedViewBadOffsetForScroll = 'Нельзя получить экранное положение символа по этому индексу: %d. Возможно, он находится на свёрнутой строчке или внутри перевода строки (CRLF).';
  SLMDSedViewBadOffsetRange = 'Bad offset range: [start: %d, count: %d]. Its bounds should be inside some scroll line.';
  SLMDSedViewBadScrollLineToScrConvert = 'Плохой индекс экранной строчки для конверсии её в дисплейную: %d. Правильный диапазон: [%d, %d]';
  SLMDSedViewBadScrollColToScrConvert = 'Bad scroll column index to convert to screen: %d, for line: %d. Valid index: [%d, %d]';  
  SLMDSedViewInvisibleOffset = 'Для этой операции требуется, чтобы символ заданным индексом был видимым. Индекс: %d';
  SLMDSedViewInvisibleLine = 'This operation requires given physical line to be visible. Line: %d';
  SLMDSedViewFixedFontRequired = 'Syntax Edit работает только со fixed-with шрифтами';
  SLMDSedViewDocNotSet = 'Для этой операции требуется, чтобы свойство Document было задано';
  SLMDSedViewChangesLocked = 'Во время этого события изменения в виде запрещены';
  SLMDSedViewGutterBarInvalid = 'Этот Gutter bar невидимый или не принадлежит этому виду';
  SLMDSedViewBadSpecialChar = 'Спец. символ должен быть или печатным Ansi-символом, или кодом символа в формате, подходящем для StrToInt';
  SLMDSedViewNotInSearchMode = 'Перед вызовом SearchNext нужно вызвать BeginSearch';
  SLMDSedViewNotInReplaceMode = 'Перед вызовом ReplaceNext нужно вызвать BeginReplace';
  SLMDSedViewIsReadOnly = 'Запрещены изменения в документе этого вида (View.Document.ReadOnly=true)';
  SLMDSedViewUniqueCommand = 'Команды в коллекции должны быть уникальны по свойству Command';
  SLMDSedViewUniqueCommandBinding = 'Сочетание клавиш (Shortcut+Shortcut2) в объекте TLMDEditCommandBinding должно быть уникальным по всей коллекции команд.';
  SLMDSedViewInternalClassCreate = 'Этот объект не может быть создан пользователем. Его сам вид для себя создаёт.';
  SLMDSedViewInvalidGutterBarWidth = 'Значение свойства "Width" объекта TLMDGutterBar должно быть больше нуля';
  SLMDSedViewInvalidGutterBarPadding = 'Значения свойств "LeftPadding, RightPadding" объекта TLMDGutterBar должны быть больше или равны нулю';
  SLMDSedViewIncrementalSearchModeRequired = 'View should be in incremental search mode for this command (or method)';
  SLMDSedViewNoIncrementalSearchModeRequired = 'View should NOT be in incremental search mode for this command (or method)';
  SLMDSedViewComplListShownRequired = 'Completion list should be shown for this command (or method)';
  SLMDSedViewNoComplListShownRequired = 'Completion list should NOT be shown for this command (or method)';

  //Dialogs
  SLMDSedDlgGotoLine = 'Перейти на строку';

  SLMDSedDlgSearchCancel = 'Отмена';
  SLMDSedDlgSearchOk = 'OK';
  SLMDSedDlgReplaceAll = 'Заменить &всё';
  SLMDSedDlgSearchText = 'Найт&и';
  SLMDSedDlgReplaceText = 'За&менить на';
  SLMDSedDlgSearchOptions = 'Настройки';
  SLMDSedDlgSearchDirection = 'Направление поиска';
  SLMDSedDlgSearchBounds = 'Границы для полной замены';
  SLMDSedDlgSearchStartFrom = 'Искать от';
  SLMDSedDlgSearchRegexps = 'Регуля&рные выражения';
  SLMDSedDlgSearchWholeWords = 'Только слово &целиком';
  SLMDSedDlgSearchCaseSensitive = 'У&читывать регистр';
  SLMDSedDlgSearchConfirmReplace = 'Подтвержд&ать замену';
  SLMDSedDlgSearchBackward = 'На&зад';
  SLMDSedDlgSearchForward = 'Вперё&д';
  SLMDSedDlgSearchAllText = 'Весь &текст';
  SLMDSedDlgSearchSelection = 'В&ыделенное';
  SLMDSedDlgSearchFromCursor = 'От к&урсора';
  SLMDSedDlgSearchFromTextStart = 'От начала/&конца текста';

  SLMDSedDlgSearchBadRegex = 'Ошибка в регулярном выражении или в подстановочной строчке: %s';
  SLMDSedDlgReplaceConfirm = 'Заменить это вхождение ''%s''?';
  SLMDSedDlgContinueSearchFromStart = 'Достигнут конец документа. Продолжить с начала?';
  SLMDSedDlgContinueSearchFromEnd = 'Достигнуто начало документа. Продолжить с конца?';

  SLMDSedLoadSyntaxSchemes = 'Загрузить синтаксические схемы из каталога...';
  SLMDSedLoadColorSchemes = 'Загрузить цветовые схемы из каталога...';

  SLMDSedColorSchemeNotFound = 'Can''t find color scheme ''%s''';  
  SLMDSedColorSchemeCustomColor = 'Пользовательский...';
  SLMDSedColorSchemeAddToken = 'Задайте имя новому токену';
  SLMDSedColorSchemeAddCustomAttr = 'Enter new custom attribute name';
  SLMDSedColorSchemeDuplicateCustomAttr = 'Custom attribute name should be unique';
  SLMDSedColorSchemeDuplicateToken = 'Token name should be unique';
  SLMDSedColorSchemeLoadError = 'Ошибка на загрузке цветовой схемы ''%s'': %s';
  SLMDSedColorSchemeCaption = 'Редактор цветовых схем';
  SLMDSedColorSchemeTokens = 'Токены';
  SLMDSedColorSchemeTokensPlusHint = 'Добавить новый токен';
  SLMDSedColorSchemeTokensMinusHint = 'Удалить текущий токен';
  SLMDSedColorSchemeColors = 'Цвета';
  SLMDSedColorSchemeColor = '&Цвет:';
  SLMDSedColorSchemeBgColor = 'Цвет &фона:';
  SLMDSedColorSchemeAttributes = 'Атрибуты';
  SLMDSedColorSchemeItalic = '&Курсив';
  SLMDSedColorSchemeBold = '&Жирный';
  SLMDSedColorSchemeUnderline = '&Подчёркнутый';
  SLMDSedColorSchemeStrikeout = '&Зачёркнутый';
  SLMDSedColorSchemeFontAttributesDefined = '&Атрибуты определены';
  SLMDSedColorSchemeExample = 'Примеры';
  SLMDSedColorSchemeCancel = 'Отмена';
  SLMDSedColorSchemeOk = 'OK';
SLMDSedColorSchemeMainAttrs = 'Main attributes';
  SLMDSedColorSchemeCustomAttrs = 'Custom attributes';
  SLMDSedColorSchemeCustomAttrName = 'Name';
  SLMDSedColorSchemeCustomAttrValue = 'Value';
  SLMDSedColorSchemeRemoveCustomAttrHint = 'Remove this custom attribute';
  SLMDSedColorSchemeAddCustomAttrHint = 'Add new custom attribute';
  SLMDSedColorSchemeRemoveTokenHint = 'Remove this token';
  SLMDSedColorSchemeAddTokenHint = 'Add new token';  

  SLMDSedCmdLeft = 'Назад на символ';
  SLMDSedCmdRight = 'Вперёд на символ';
  SLMDSedCmdUp = 'Вверх на строчку';
  SLMDSedCmdDown = 'Вниз на строчку';
  SLMDSedCmdLineHome = 'К началу строчки';
  SLMDSedCmdLineEnd = 'К концу строчки';
  SLMDSedCmdNextWord = 'Вперёд на слово';
  SLMDSedCmdPrevWord = 'Назад на слово';
  SLMDSedCmdPageUp = 'Вверх на страницу';
  SLMDSedCmdPageDown = 'Вниз на страницу';
  SLMDSedCmdPageHome = 'К началу страницы';
  SLMDSedCmdPageEnd = 'К концу страницы';
  SLMDSedCmdTextHome = 'К началу текста';
  SLMDSedCmdTextEnd = 'К концу текста';

  SLMDSedCmdUndo = 'Отмена';
  SLMDSedCmdRedo = 'Повтор';
  SLMDSedCmdCut = 'Вырезать выделенное';
  SLMDSedCmdCopy = 'Скопировать выделенное';
  SLMDSedCmdPaste = 'Вставить';

  SLMDSedCmdDeletePrevChar = 'Удалить символ слева';
  SLMDSedCmdDeleteChar  = 'Удалить символ справа';
  SLMDSedCmdDeletePrevWord  = 'Удалить слово слева';
  SLMDSedCmdDeleteWord  = 'Удалить слово справа';
  SLMDSedCmdDeleteToLineEnd  = 'Delete to line end';
  SLMDSedCmdDeleteToLineWrap  = 'Delete to line wrap';  
  SLMDSedCmdDeleteLine  = 'Delete line';  
  SLMDSedCmdChar = 'Вставить символ';
  SLMDSedCmdNewLine  = 'Вставить перевод строки';
  SLMDSedCmdTab = 'Вставить табуляцию';
  SLMDSedCmdTabOrIndent = 'Move to prev line indent or insert tab';  
  SLMDSedCmdIndent = 'Сдвинуть выделенное вправо';
  SLMDSedCmdUnIndent = 'Сдвинуть выделенное влево';
  SLMDSedCmdIndentToPrev = 'Indent selection to prev indent';
  SLMDSedCmdUnIndentToPrev = 'Unindent selection to prev indent';
  SLMDSedCmdBackspaceOrUnindent = 'Delete char backward or unindent';
  SLMDSedCmdIncSearchStart = 'Start incremental search';
  SLMDSedCmdIncSearchBack = 'Move to previous result';
  SLMDSedCmdIncSearchFwd = 'Move to next result';
  SLMDSedCmdSearchNext = 'Move to next search result';
  SLMDSedCmdScrollUp = 'Прокрутить экран вверх на строчку';
  SLMDSedCmdScrollDown = 'Прокрутить экран вниз на строчку';

  SLMDSedCmdSelectLeft = 'Выделить на символ влево';
  SLMDSedCmdSelectRight = 'Выделить на символ вправо';
  SLMDSedCmdSelectPrevWord = 'Выделить на слово влево';
  SLMDSedCmdSelectNextWord = 'Выделить на слово вправо';
  SLMDSedCmdSelectUp = 'Выделить на строчку вверх';
  SLMDSedCmdSelectDown = 'Выделить на строчку вниз';
  SLMDSedCmdSelectPageUp = 'Выделить на страницу вверх';
  SLMDSedCmdSelectPageDown = 'Выделить на страницу вниз';
  SLMDSedCmdSelectPageHome = 'Выделить до начала страницы';
  SLMDSedCmdSelectPageEnd = 'Выделить до конца страницы';
  SLMDSedCmdSelectLineHome = 'Выделить до начала строчки';
  SLMDSedCmdSelectLineEnd = 'Выделить до конца строчки';
  SLMDSedCmdSelectTextHome = 'Выделить до начала текста';
  SLMDSedCmdSelectTextEnd = 'Выделить до конца текста';

  SLMDSedCmdSelectAll = 'Выделить всё';
  SLMDSedCmdSelectNone = 'Отменить выделение';

  SLMDSedCmdToggleOwerwrite = 'Переключить режим вставки/замены';
  SLMDSedCmdCompletionShow = 'Show completion list for current word';

  SLMDSedCmdCatMovement = 'Перемещение';
  SLMDSedCmdCatSelection = 'выделение';
  SLMDSedCmdCatDeletion = 'Удаление';
  SLMDSedCmdCatClipboard = 'Буфер обмена';
  SLMDSedCmdCatOther = 'Прочее';
  SLMDSedCmdCatIncSearch = 'Incremental search';
  SLMDSedCmdCatIndent = 'Indentation';
  SLMDSedKeyDlgCaption = 'Редактор клавиатурных раскладок';
  SLMDSedKeyDlgCancel = 'Отмена';
  SLMDSedKeyDlgOk = 'Ок';
  SLMDSedKeyDlgDeleteBinding = 'У&далить сочетание';
  SLMDSedKeyDlgResetBinding = '&Восстановить по умолчанию';
  SLMDSedKeyDlgResetAllBinding = 'Восстановить вс&ё';
  SLMDSedKeyDlgAddBinding = 'До&бавить сочетание';
  SLMDSedKeyDlgClearBinding = 'О&чистить';  

  SLMDSedKeyDlgReplaceBinding = 'Сочетание ''%s'' затрёт следующие действия:'+
                                #13+#10+'%s'+#13+#10+'Продолжить?';

  SLMDSedKeyDlgResetAlert = 'Восстановление сочетаний тут затрёт другие действия:'+
                            #13+#10+'%s'+#13+#10+'Продолжить?';

  SLMDSedTaskPagesNotPrepared = 'Вы должны сначала выполнить PreparePages';
  SLMDSedTaskPagesNotFinalized = 'Вы должны сначала выполнить FinalizePages';
  SLMDSedTaskPrinterNotAssigned = 'Вы должны сначала установить свойство "Printer"';
  SLMDSedTaskViewNotAssigned = 'Вы должны сначала установить свойство "View"';  
  SLMDSedbadEncodingName = 'Неверное имя кодировки: ''%s''. Ожидается целочисленный код либо имя кодировки (ищите в MDSN), установленной в системе';
  SLMDSedDialogViewNotSet = 'View property should be assigned for this method';
  SLMDSedDialogDocumentNotSet = 'Document property should be assigned for this method';
  SLMDSedDialogFindCaption = 'Find text';
  SLMDSedDialogReplaceCaption = 'Find text';
  SLMDSedDialogFindBadState = 'You must call Execute method first. View SearchState should be stInSearch';
  SLMDSedDialogReplaceBadState = 'You must call Execute method first. View SearchState should be stInReplace';
  SLMDSedDialogColorSchemeNotFound = 'Color scheme %s not found in Document.ColorSchemes collection';
  SLMDSedDialogSyntaxSchemeNotFound = 'Syntax scheme %s not found in Document.SyntaxSchemes collection';  
  SLMDSedDialogSchemeNotSet = 'Scheme property should be set for this method';

  SLMDSedCmdSelectLeftBlock      = 'Widen sel left by char (block mode)';
  SLMDSedCmdSelectRightBlock     = 'Widen sel right by char (block mode)';
  SLMDSedCmdSelectPrevWordBlock  = 'Widen sel left by word (block mode)';
  SLMDSedCmdSelectNextWordBlock  = 'Widen sel right by word (block mode)';
  SLMDSedCmdSelectUpBlock        = 'Widen sel up by line (block mode)';
  SLMDSedCmdSelectDownBlock      = 'Widen sel down by line (block mode)';
  SLMDSedCmdSelectPageUpBlock    = 'Widen sel up by page (block mode)';
  SLMDSedCmdSelectPageDownBlock  = 'Widen sel down by page (block mode)';
  SLMDSedCmdSelectPageHomeBlock  = 'Widen sel up to page start (block mode)';
  SLMDSedCmdSelectPageEndBlock   = 'Widen sel up to page end (block mode)';
  SLMDSedCmdSelectLineHomeBlock  = 'Widen sel up to line start (block mode)';
  SLMDSedCmdSelectLineEndBlock   = 'Widen sel up to line end (block mode)';
  SLMDSedCmdSelectTextHomeBlock  = 'Widen sel up to text start (block mode)';
  SLMDSedCmdSelectTextEndBlock   = 'Widen sel up to text end (block mode)';

  SLMDSedCmdCatSelectionBlock = 'Selection (block mode)';

  SLMDSedInvalidLineColIdx = 'Invalid line column: %d. Valid range: [0, %d]';  

  SLMDSedDocDbgStackExpectedByMethod = 'This method expects passed marker belongs to DebuggerStackLines document collection';
  SLMDSedDocReadOnly = 'Document is read-only';
  SLMDSedDocInternalClassCreate = 'This internal Document class should not be created manually.';  

  SLMDSedCmdToggleOverwrite = 'Toggle overwrite mode';
  SLMDSedCmdCompletionShow = 'Show completion list for current word';


{------------------------------------------------------------------------------}

implementation

end.
