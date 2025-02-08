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
  LES_BEGIN_URL = 'Begin download URL';
  LES_END_URL = 'End download URL';
  LES_DOWNLOAD_ERROR = 'Download error';
  LES_HTTP_STATUS = 'HTTP Status';
  LES_GET_COOKIES = 'Get cookies';
  LES_POST = 'Post params';
  LES_REDIRECT = 'Redirect to';
  LES_DATA = 'Data';

  strBadType = 'Bad result type';
  strExcludedType = 'Excluded file type';
  IDLE_NAME = 'Idle';
  COMPLITE_NAME = 'Completed';
  ERROR_NAME = 'Error';
  PROCESS_NAME = 'Processing';

//LMDHTMLSupp
  MSG_MAX_HTML_PROCESS_CONST = 'HTML FindTemplate deadlock';
  MSG_BAD_PARAM_INDEX   = 'HTML FindTemplate: Bad param index';

//LMDRAS
  RASE_GETPARAMS = 'Can''t get dial params';

//LMDRASCF
  RS_CONNECTING = 'Connecting';
  RS_CLOSE = 'Close';

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
  DF_FROM='from';
  DF_KBS='Kb/s';
  DF_KB='Kb';
  DF_DOWNLOAD = 'Download:';
  DF_TRANSFER = 'Transfer rate:';
  DF_TOTAL = 'Total size:';
  DF_CLOSE = '&Close';
  DF_CANCEL= 'Cancel';

// LMDWebMBIEFrame
  MB_LOADINGMSG             = 'Loading...';
  MB_EMPTYURLMSG            = 'Blank';
  MB_BADBROWSERMSG          = 'Bad type of Browser';
  MB_NOTSUPPORTMSG          = 'Operation not support';
  MB_LOCKMSG                = 'Lock';

  MB_CLOSEMENUCPT           = 'Close';
  MB_CLOSEALLMENUCPT        = 'Close All';
  MB_FORWARDMENUCPT         = 'Forward';
  MB_BACKMENUCPT            = 'Back';
  MB_STOPMENUCPT            = 'Stop';
  MB_STOPALLMENUCPT         = 'Stop All';
  MB_REFRESHMENUCPT         = 'Refresh';
  MB_REFRESHALLMENUCPT      = 'Refresh All';
  MB_PREVIOUSBROWSERTABCPT  = 'Previous Browser Tab';
  MB_NEXTBROWSERTABCPT      = 'Next Browser Tab';
  MB_TABSCPT                = 'Tabs';

  MB_FONTSIZE0              = 'Largest';
  MB_FONTSIZE1              = 'Large';
  MB_FONTSIZE2              = 'Medium';
  MB_FONTSIZE3              = 'Smaller';
  MB_FONTSIZE4              = 'Smallest';

  MB_CAPLEFT                = 'Left';
  MB_CAPRIGHT               = 'Right';
  MB_CAPTOP                 = 'Top';
  MB_CAPBOTTOM              = 'Bottom';

// LMDUpdateAdapater
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
