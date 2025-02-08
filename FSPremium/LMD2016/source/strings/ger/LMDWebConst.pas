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
  LES_BEGIN_URL = 'Beginn Download';
  LES_END_URL = 'Ende Download';
  LES_DOWNLOAD_ERROR = 'Download Fehler';
  LES_HTTP_STATUS = 'HTTP Status';
  LES_GET_COOKIES = 'Cookies laden';
  LES_POST = 'Parameter senden';
  LES_REDIRECT = 'Redirekt nach';
  LES_DATA = 'Daten';

  strBadType = 'Ungültiger Rückgabewert';
  strExcludedType = 'Ausgeschlossener Dateityp';
  IDLE_NAME = 'Leerlauf';
  COMPLITE_NAME = 'Vollständig';
  ERROR_NAME = 'Fehler';
  PROCESS_NAME = 'Berbeiten';

//LMDRAS
  RASE_GETPARAMS = 'Wählparameter konnten nicht ermittelt werden';

//LMDRASCF
  RS_CONNECTING = 'Verbinden';
  RS_CLOSE = 'Schließen';

//LMDHTMLSupp
  MSG_MAX_HTML_PROCESS_CONST = 'HTML FindTemplate deadlock';
  MSG_BAD_PARAM_INDEX   = 'HTML FindTemplate: Bad param index';

//Internet Errors
  SERROR_INTERNET_UNKNOWN = 'Internet Error: %d';
  SERROR_INTERNET = '%s';
  SERROR_HTTP_UNKNOWN = 'HTTP Error: %d';
  SERROR_HTTP = '%s';
  SERROR_STOPPED = 'Stopped';
  SERROR_INTERNET_OUT_OF_HANDLES = 'Out of handles';
  SERROR_INTERNET_TIMEOUT = 'Timeout';
  SERROR_INTERNET_EXTENDED_ERROR = 'Extended error';
  SERROR_INTERNET_INTERNAL_ERROR = 'Internal error';
  SERROR_INTERNET_INVALID_URL = 'Invalid URL';
  SERROR_INTERNET_UNRECOGNIZED_SCHEME = 'Unrecognized scheme';
  SERROR_INTERNET_NAME_NOT_RESOLVED = 'Name not resolved';
  SERROR_INTERNET_PROTOCOL_NOT_FOUND = 'Protocol not found';
  SERROR_INTERNET_INVALID_OPTION = 'Invalid option';
  SERROR_INTERNET_BAD_OPTION_LENGTH = 'Bad option length';
  SERROR_INTERNET_OPTION_NOT_SETTABLE = 'Option not settable';
  SERROR_INTERNET_SHUTDOWN = 'Shutdown';
  SERROR_INTERNET_INCORRECT_USER_NAME = 'Incorrect user name';
  SERROR_INTERNET_INCORRECT_PASSWORD = 'Incorrect password';
  SERROR_INTERNET_LOGIN_FAILURE = 'Login failure';
  SERROR_INTERNET_INVALID_OPERATION = 'Invalid operation';
  SERROR_INTERNET_OPERATION_CANCELLED = 'Operation cancelled';
  SERROR_INTERNET_INCORRECT_HANDLE_TYPE = 'Incorrect handle type';
  SERROR_INTERNET_INCORRECT_HANDLE_STATE = 'Incorrect handle state';
  SERROR_INTERNET_NOT_PROXY_REQUEST = 'Not proxy request';
  SERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND = 'Registry value not found';
  SERROR_INTERNET_BAD_REGISTRY_PARAMETER = 'Bad registry parameter';
  SERROR_INTERNET_NO_DIRECT_ACCESS = 'No direct access';
  SERROR_INTERNET_NO_CONTEXT = 'No context';
  SERROR_INTERNET_NO_CALLBACK = 'No callback';
  SERROR_INTERNET_REQUEST_PENDING = 'Request pending';
  SERROR_INTERNET_INCORRECT_FORMAT = 'Incorrect format';
  SERROR_INTERNET_ITEM_NOT_FOUND = 'Item not found';
  SERROR_INTERNET_CANNOT_CONNECT = 'Cannot connect';
  SERROR_INTERNET_CONNECTION_ABORTED = 'Connection aborted';
  SERROR_INTERNET_CONNECTION_RESET = 'Connection reset';
  SERROR_INTERNET_FORCE_RETRY = 'Force retry';
  SERROR_INTERNET_INVALID_PROXY_REQUEST = 'Invalid proxy request';
  SHTTP_ERROR_HTTP_STATUS_GATEWAY_TIMEOUT = 'Gateway timeout';
  SHTTP_ERROR_HTTP_STATUS_SERVICE_UNAVAIL = 'Service unavailable';
  SHTTP_ERROR_HTTP_STATUS_BAD_GATEWAY = 'Bad gateway';
  SHTTP_ERROR_HTTP_STATUS_NOT_SUPPORTED = 'Not supported';
  SHTTP_ERROR_HTTP_STATUS_SERVER_ERROR = 'Server error';
  SHTTP_ERROR_HTTP_STATUS_UNSUPPORTED_MEDIA = 'Unsupported media';
  SHTTP_ERROR_HTTP_STATUS_URI_TOO_LONG = 'URI too long';
  SHTTP_ERROR_HTTP_STATUS_REQUEST_TOO_LARGE = 'Request too large';
  SHTTP_ERROR_HTTP_STATUS_PRECOND_FAILED = 'Precond failed';
  SHTTP_ERROR_HTTP_STATUS_AUTH_REFUSED = 'Auth refused';
  SHTTP_ERROR_HTTP_STATUS_GONE = 'Gone';
  SHTTP_ERROR_HTTP_STATUS_CONFLICT = 'HTTP Conflict';
  SHTTP_ERROR_HTTP_STATUS_REQUEST_TIMEOUT = 'Request timeout';
  SHTTP_ERROR_HTTP_STATUS_PROXY_AUTH_REQ = 'Proxy auth req';
  SHTTP_ERROR_HTTP_STATUS_NONE_ACCEPTABLE = 'None acceptable';
  SHTTP_ERROR_HTTP_STATUS_BAD_METHOD = 'Bad method';
  SHTTP_ERROR_HTTP_STATUS_NOT_FOUND = 'File not found';
  SHTTP_ERROR_HTTP_STATUS_FORBIDDEN = 'Access forbidden';
  SHTTP_ERROR_HTTP_STATUS_DENIED = 'Access denied';
  SHTTP_ERROR_HTTP_STATUS_BAD_REQUEST = 'Bad request';
  NOT_CONNECTED_ERROR = 'Not connected';

// LMDWebDownloadForm
  DF_FROM='von';
  DF_KBS='Kb/s';
  DF_KB='Kb';
  DF_DOWNLOAD = 'Download:';
  DF_TRANSFER = 'Transferrate:';
  DF_TOTAL = 'Gesamtgröße::';
  DF_CLOSE = '&Schließen';
  DF_CANCEL= 'Abbrechen';

// LMDWebMBIEFrame
  MB_LOADINGMSG             = 'Lade...';
  MB_EMPTYURLMSG            = 'Leer';
  MB_BADBROWSERMSG          = 'Ungültiger Browsertyp';
  MB_NOTSUPPORTMSG          = 'Operation nicht unterstützt';
  MB_LOCKMSG                = 'Lock';

  MB_CLOSEMENUCPT           = 'Schließen';
  MB_CLOSEALLMENUCPT        = 'Alle schließen';
  MB_FORWARDMENUCPT         = 'Vor';
  MB_BACKMENUCPT            = 'Zurück';
  MB_STOPMENUCPT            = 'Abbrechen';
  MB_STOPALLMENUCPT         = 'Alle Abbrechen';
  MB_REFRESHMENUCPT         = 'Aktualisieren';
  MB_REFRESHALLMENUCPT      = 'Alle aktualisieren';
  MB_PREVIOUSBROWSERTABCPT  = 'Vorheriger Browser Tab';
  MB_NEXTBROWSERTABCPT      = 'Nächster Browser Tab';
  MB_TABSCPT                = 'Tabs';

  MB_FONTSIZE0              = 'Groß';
  MB_FONTSIZE1              = 'Größer';
  MB_FONTSIZE2              = 'Mittel';
  MB_FONTSIZE3              = 'Kleiner';
  MB_FONTSIZE4              = 'Klein';

  MB_CAPLEFT                = 'Links';
  MB_CAPRIGHT               = 'Rechts';
  MB_CAPTOP                 = 'Oben';
  MB_CAPBOTTOM              = 'Unten';

// LMDUpdateAdapater, TODO: Need to translate
  IDS_UPDATE_CLOSEHOST = 'Close host application';
  IDS_UPDATE_SQL_SCRIPT_RECEIVE = 'Executing SQL Script';
  IDS_UPDATE_FINISH = 'Finish update process';
  IDS_UPDATE_ERROR = 'An error was occurred';
  IDS_UPDATE_WAITING_FOR_INTERACTIVE_CONFIRM = 'Wating for interactive confirm action';
  IDS_UPDATE_INFORMATION = 'Information';
  IDS_UPDATE_PROGRESS = 'Progress';  
  IDS_UPDATE_GETCONFIG = 'Getting internet configuration from host';

  IDS_UPDATE_USER_CANCELED = 'User canceled';
  IDS_UPDATE_CONTINUE = 'Continue update';
  IDS_UPDATE_CANCEL = 'Cancel update';
  IDS_COULNDT_LOAD_SCRIPT = 'Couldn''t load update script file';
  IDS_FOLDER_DOESNT_EXISTS = 'Folder doesn''t exists';
  IDS_LEAVE_SINGLE_OR_NOTHING_VALUE = 'Please, leave single value or nothing';

implementation

end.
