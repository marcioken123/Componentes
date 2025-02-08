unit LMDWebConst;
{###############################################################################

LMDWebConst unit (DD)
--------------------
LMD Web package constants

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}
interface

resourcestring
//LMD Download
  LES_BEGIN_URL = 'Начало загрузки URL';
  LES_END_URL = 'Загрузка URL закончена';
  LES_DOWNLOAD_ERROR = 'Ошибка при загрузке';
  LES_HTTP_STATUS = 'HTTP Статус';
  LES_GET_COOKIES = 'Полученные Cookies';
  LES_POST = 'Параметры POST';
  LES_REDIRECT = 'Перенаправление на';
  LES_DATA = 'Данные';

  strBadType = 'Ошибочный тип файла';
  strExcludedType = 'Исключенный тип файла';
  IDLE_NAME = 'Ожидание';
  COMPLITE_NAME = 'Завершенно';
  ERROR_NAME = 'Ошибка';
  PROCESS_NAME = 'Обработка';

//LMDHTMLSupp
  MSG_MAX_HTML_PROCESS_CONST = 'Зацикливание HTML FindTemplate';
  MSG_BAD_PARAM_INDEX   = 'HTML FindTemplate: Плохой индекс параметра';  

//LMDRAS
  RASE_GETPARAMS = 'Не могу найти dialup параметры';

//LMDRASCF
  RS_CONNECTING = 'Соединение';
  RS_CLOSE = 'Закрыть';

//Internet Errors
  SERROR_INTERNET_UNKNOWN = 'Internet ошибка: %d';
  SERROR_INTERNET = '%s';
  SERROR_HTTP_UNKNOWN = 'HTTP ошибка: %d';
  SERROR_HTTP = '%s';
  SERROR_STOPPED = 'Остановлен';
  SERROR_INTERNET_OUT_OF_HANDLES = 'Не хватает ресурсов';
  SERROR_INTERNET_TIMEOUT = 'Таймаут';
  SERROR_INTERNET_EXTENDED_ERROR = 'Расширенная ошибка';
  SERROR_INTERNET_INTERNAL_ERROR = 'Внутренняя ошибка';
  SERROR_INTERNET_INVALID_URL = 'Ошибочный URL';
  SERROR_INTERNET_UNRECOGNIZED_SCHEME = 'Не распознаная схема';
  SERROR_INTERNET_NAME_NOT_RESOLVED = 'Имя не разименованно';
  SERROR_INTERNET_PROTOCOL_NOT_FOUND = 'Протокол не найден';
  SERROR_INTERNET_INVALID_OPTION = 'Ошибочная опция';
  SERROR_INTERNET_BAD_OPTION_LENGTH = 'Ошибочная длина опции';
  SERROR_INTERNET_OPTION_NOT_SETTABLE = 'Опция только для чтения';
  SERROR_INTERNET_SHUTDOWN = 'Shutdown';
  SERROR_INTERNET_INCORRECT_USER_NAME = 'Ошибочное имя ползователя';
  SERROR_INTERNET_INCORRECT_PASSWORD = 'Ошибочный пароль';
  SERROR_INTERNET_LOGIN_FAILURE = 'Ошибка аутентификации';
  SERROR_INTERNET_INVALID_OPERATION = 'Ошибочная операция';
  SERROR_INTERNET_OPERATION_CANCELLED = 'Операция отменена';
  SERROR_INTERNET_INCORRECT_HANDLE_TYPE = 'Ошибочный тип идентификатора';
  SERROR_INTERNET_INCORRECT_HANDLE_STATE = 'Ошибочное состояние идентификатора';
  SERROR_INTERNET_NOT_PROXY_REQUEST = 'Запрос не на прокси';
  SERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND = 'Значение Registry не найдено';
  SERROR_INTERNET_BAD_REGISTRY_PARAMETER = 'Ошибочный параметр registry';
  SERROR_INTERNET_NO_DIRECT_ACCESS = 'Нет прямого доступа';
  SERROR_INTERNET_NO_CONTEXT = 'Нет контекста';
  SERROR_INTERNET_NO_CALLBACK = 'Нет callback';
  SERROR_INTERNET_REQUEST_PENDING = 'Request pending';
  SERROR_INTERNET_INCORRECT_FORMAT = 'Ошибочный формат';
  SERROR_INTERNET_ITEM_NOT_FOUND = 'Элемент не найден';
  SERROR_INTERNET_CANNOT_CONNECT = 'Нет соединения';
  SERROR_INTERNET_CONNECTION_ABORTED = 'Соединение оборвано';
  SERROR_INTERNET_CONNECTION_RESET = 'Соединение сброшено';
  SERROR_INTERNET_FORCE_RETRY = 'Force retry';
  SERROR_INTERNET_INVALID_PROXY_REQUEST = 'Ошибочный прокси запрос';
  SHTTP_ERROR_HTTP_STATUS_GATEWAY_TIMEOUT = 'Таймаут шлюза';
  SHTTP_ERROR_HTTP_STATUS_SERVICE_UNAVAIL = 'Сервис не доступен';
  SHTTP_ERROR_HTTP_STATUS_BAD_GATEWAY = 'Ошибочный шлюз';
  SHTTP_ERROR_HTTP_STATUS_NOT_SUPPORTED = 'Не поддерживается';
  SHTTP_ERROR_HTTP_STATUS_SERVER_ERROR = 'Ошибка сервера';
  SHTTP_ERROR_HTTP_STATUS_UNSUPPORTED_MEDIA = 'Не поддерживаемый формат';
  SHTTP_ERROR_HTTP_STATUS_URI_TOO_LONG = 'URI слишком длинный';
  SHTTP_ERROR_HTTP_STATUS_REQUEST_TOO_LARGE = 'Запрос слишком большой';
  SHTTP_ERROR_HTTP_STATUS_PRECOND_FAILED = 'Precond failed';
  SHTTP_ERROR_HTTP_STATUS_AUTH_REFUSED = 'Аутентификация отвергнута';
  SHTTP_ERROR_HTTP_STATUS_GONE = 'Gone';
  SHTTP_ERROR_HTTP_STATUS_CONFLICT = 'Конфликт HTTP';
  SHTTP_ERROR_HTTP_STATUS_REQUEST_TIMEOUT = 'Таймаут запроса';
  SHTTP_ERROR_HTTP_STATUS_PROXY_AUTH_REQ = 'Прокси требует аутентификации';
  SHTTP_ERROR_HTTP_STATUS_NONE_ACCEPTABLE = 'Не применимо';
  SHTTP_ERROR_HTTP_STATUS_BAD_METHOD = 'Ошибочный метод';
  SHTTP_ERROR_HTTP_STATUS_NOT_FOUND = 'Файл не найден';
  SHTTP_ERROR_HTTP_STATUS_FORBIDDEN = 'Доступ запрещен';
  SHTTP_ERROR_HTTP_STATUS_DENIED = 'Доступ отвергнут';
  SHTTP_ERROR_HTTP_STATUS_BAD_REQUEST = 'Неверный запрос';
  NOT_CONNECTED_ERROR = 'Нет соединения';

// LMDWebDownloadForm
  DF_FROM='с';
  DF_KBS='Кб/с';
  DF_KB='Кб';
  DF_DOWNLOAD = 'Загрузка:';
  DF_TRANSFER = 'Скорость загрузки:';
  DF_TOTAL = 'Размер:';
  DF_CLOSE = 'Закрыть';
  DF_CANCEL= 'Отменить';

// LMDWebMBIEFrame
  MB_LOADINGMSG             = 'Загрузка...';
  MB_EMPTYURLMSG            = 'Пусто';
  MB_BADBROWSERMSG          = 'Плохой тип браузера';
  MB_NOTSUPPORTMSG          = 'Операция не поддерживается';
  MB_LOCKMSG                = 'Блокировка';

  MB_CLOSEMENUCPT           = 'Закрыть';
  MB_CLOSEALLMENUCPT        = 'Закрыть все';
  MB_FORWARDMENUCPT         = 'Вперед';
  MB_BACKMENUCPT            = 'Назад';
  MB_STOPMENUCPT            = 'Стоп';
  MB_STOPALLMENUCPT         = 'Остановить все';
  MB_REFRESHMENUCPT         = 'Обновить';
  MB_REFRESHALLMENUCPT      = 'Обновить все';
  MB_PREVIOUSBROWSERTABCPT  = 'Предыдущая закладка браузера';
  MB_NEXTBROWSERTABCPT      = 'Следующая закладка бразузера';
  MB_TABSCPT                = 'Закладки';

  MB_FONTSIZE0              = 'Огромный';
  MB_FONTSIZE1              = 'Большой';
  MB_FONTSIZE2              = 'Средний';
  MB_FONTSIZE3              = 'Маленький';
  MB_FONTSIZE4              = 'Наименьший';

  MB_CAPLEFT                = 'Лево';
  MB_CAPRIGHT               = 'Право';
  MB_CAPTOP                 = 'Верх';
  MB_CAPBOTTOM              = 'Низ';

// LMDUpdateAdapater
  IDS_UPDATE_CLOSEHOST = 'Закрытие хост приложения';
  IDS_UPDATE_SQL_SCRIPT_RECEIVE = 'Выполнение SQL скрипта';
  IDS_UPDATE_FINISH = 'Завершение обновления';
  IDS_UPDATE_ERROR = 'Обнаружена ошибка';
  IDS_UPDATE_WAITING_FOR_INTERACTIVE_CONFIRM = 'Ожидание интерактивного подтверждения';
  IDS_UPDATE_INFORMATION = 'Информация';
  IDS_UPDATE_PROGRESS = 'Прогресс';  
  IDS_UPDATE_GETCONFIG = 'Получить конфигурации подключения к интернету';


  IDS_UPDATE_USER_CANCELED = 'User canceled';
  IDS_UPDATE_CONTINUE = 'Continue update';
  IDS_UPDATE_CANCEL = 'Cancel update';
  IDS_COULNDT_LOAD_SCRIPT = 'Couldn''t load update script file';
  IDS_FOLDER_DOESNT_EXISTS = 'Folder doesn''t exists';
  IDS_LEAVE_SINGLE_OR_NOTHING_VALUE = 'Please, leave single value or nothing';
  
implementation

end.
