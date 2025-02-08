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
  LES_BEGIN_URL = '������ �������� URL';
  LES_END_URL = '�������� URL ���������';
  LES_DOWNLOAD_ERROR = '������ ��� ��������';
  LES_HTTP_STATUS = 'HTTP ������';
  LES_GET_COOKIES = '���������� Cookies';
  LES_POST = '��������� POST';
  LES_REDIRECT = '��������������� ��';
  LES_DATA = '������';

  strBadType = '��������� ��� �����';
  strExcludedType = '����������� ��� �����';
  IDLE_NAME = '��������';
  COMPLITE_NAME = '����������';
  ERROR_NAME = '������';
  PROCESS_NAME = '���������';

//LMDHTMLSupp
  MSG_MAX_HTML_PROCESS_CONST = '������������ HTML FindTemplate';
  MSG_BAD_PARAM_INDEX   = 'HTML FindTemplate: ������ ������ ���������';  

//LMDRAS
  RASE_GETPARAMS = '�� ���� ����� dialup ���������';

//LMDRASCF
  RS_CONNECTING = '����������';
  RS_CLOSE = '�������';

//Internet Errors
  SERROR_INTERNET_UNKNOWN = 'Internet ������: %d';
  SERROR_INTERNET = '%s';
  SERROR_HTTP_UNKNOWN = 'HTTP ������: %d';
  SERROR_HTTP = '%s';
  SERROR_STOPPED = '����������';
  SERROR_INTERNET_OUT_OF_HANDLES = '�� ������� ��������';
  SERROR_INTERNET_TIMEOUT = '�������';
  SERROR_INTERNET_EXTENDED_ERROR = '����������� ������';
  SERROR_INTERNET_INTERNAL_ERROR = '���������� ������';
  SERROR_INTERNET_INVALID_URL = '��������� URL';
  SERROR_INTERNET_UNRECOGNIZED_SCHEME = '�� ����������� �����';
  SERROR_INTERNET_NAME_NOT_RESOLVED = '��� �� �������������';
  SERROR_INTERNET_PROTOCOL_NOT_FOUND = '�������� �� ������';
  SERROR_INTERNET_INVALID_OPTION = '��������� �����';
  SERROR_INTERNET_BAD_OPTION_LENGTH = '��������� ����� �����';
  SERROR_INTERNET_OPTION_NOT_SETTABLE = '����� ������ ��� ������';
  SERROR_INTERNET_SHUTDOWN = 'Shutdown';
  SERROR_INTERNET_INCORRECT_USER_NAME = '��������� ��� �����������';
  SERROR_INTERNET_INCORRECT_PASSWORD = '��������� ������';
  SERROR_INTERNET_LOGIN_FAILURE = '������ ��������������';
  SERROR_INTERNET_INVALID_OPERATION = '��������� ��������';
  SERROR_INTERNET_OPERATION_CANCELLED = '�������� ��������';
  SERROR_INTERNET_INCORRECT_HANDLE_TYPE = '��������� ��� ��������������';
  SERROR_INTERNET_INCORRECT_HANDLE_STATE = '��������� ��������� ��������������';
  SERROR_INTERNET_NOT_PROXY_REQUEST = '������ �� �� ������';
  SERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND = '�������� Registry �� �������';
  SERROR_INTERNET_BAD_REGISTRY_PARAMETER = '��������� �������� registry';
  SERROR_INTERNET_NO_DIRECT_ACCESS = '��� ������� �������';
  SERROR_INTERNET_NO_CONTEXT = '��� ���������';
  SERROR_INTERNET_NO_CALLBACK = '��� callback';
  SERROR_INTERNET_REQUEST_PENDING = 'Request pending';
  SERROR_INTERNET_INCORRECT_FORMAT = '��������� ������';
  SERROR_INTERNET_ITEM_NOT_FOUND = '������� �� ������';
  SERROR_INTERNET_CANNOT_CONNECT = '��� ����������';
  SERROR_INTERNET_CONNECTION_ABORTED = '���������� ��������';
  SERROR_INTERNET_CONNECTION_RESET = '���������� ��������';
  SERROR_INTERNET_FORCE_RETRY = 'Force retry';
  SERROR_INTERNET_INVALID_PROXY_REQUEST = '��������� ������ ������';
  SHTTP_ERROR_HTTP_STATUS_GATEWAY_TIMEOUT = '������� �����';
  SHTTP_ERROR_HTTP_STATUS_SERVICE_UNAVAIL = '������ �� ��������';
  SHTTP_ERROR_HTTP_STATUS_BAD_GATEWAY = '��������� ����';
  SHTTP_ERROR_HTTP_STATUS_NOT_SUPPORTED = '�� ��������������';
  SHTTP_ERROR_HTTP_STATUS_SERVER_ERROR = '������ �������';
  SHTTP_ERROR_HTTP_STATUS_UNSUPPORTED_MEDIA = '�� �������������� ������';
  SHTTP_ERROR_HTTP_STATUS_URI_TOO_LONG = 'URI ������� �������';
  SHTTP_ERROR_HTTP_STATUS_REQUEST_TOO_LARGE = '������ ������� �������';
  SHTTP_ERROR_HTTP_STATUS_PRECOND_FAILED = 'Precond failed';
  SHTTP_ERROR_HTTP_STATUS_AUTH_REFUSED = '�������������� ����������';
  SHTTP_ERROR_HTTP_STATUS_GONE = 'Gone';
  SHTTP_ERROR_HTTP_STATUS_CONFLICT = '�������� HTTP';
  SHTTP_ERROR_HTTP_STATUS_REQUEST_TIMEOUT = '������� �������';
  SHTTP_ERROR_HTTP_STATUS_PROXY_AUTH_REQ = '������ ������� ��������������';
  SHTTP_ERROR_HTTP_STATUS_NONE_ACCEPTABLE = '�� ���������';
  SHTTP_ERROR_HTTP_STATUS_BAD_METHOD = '��������� �����';
  SHTTP_ERROR_HTTP_STATUS_NOT_FOUND = '���� �� ������';
  SHTTP_ERROR_HTTP_STATUS_FORBIDDEN = '������ ��������';
  SHTTP_ERROR_HTTP_STATUS_DENIED = '������ ���������';
  SHTTP_ERROR_HTTP_STATUS_BAD_REQUEST = '�������� ������';
  NOT_CONNECTED_ERROR = '��� ����������';

// LMDWebDownloadForm
  DF_FROM='�';
  DF_KBS='��/�';
  DF_KB='��';
  DF_DOWNLOAD = '��������:';
  DF_TRANSFER = '�������� ��������:';
  DF_TOTAL = '������:';
  DF_CLOSE = '�������';
  DF_CANCEL= '��������';

// LMDWebMBIEFrame
  MB_LOADINGMSG             = '��������...';
  MB_EMPTYURLMSG            = '�����';
  MB_BADBROWSERMSG          = '������ ��� ��������';
  MB_NOTSUPPORTMSG          = '�������� �� ��������������';
  MB_LOCKMSG                = '����������';

  MB_CLOSEMENUCPT           = '�������';
  MB_CLOSEALLMENUCPT        = '������� ���';
  MB_FORWARDMENUCPT         = '������';
  MB_BACKMENUCPT            = '�����';
  MB_STOPMENUCPT            = '����';
  MB_STOPALLMENUCPT         = '���������� ���';
  MB_REFRESHMENUCPT         = '��������';
  MB_REFRESHALLMENUCPT      = '�������� ���';
  MB_PREVIOUSBROWSERTABCPT  = '���������� �������� ��������';
  MB_NEXTBROWSERTABCPT      = '��������� �������� ���������';
  MB_TABSCPT                = '��������';

  MB_FONTSIZE0              = '��������';
  MB_FONTSIZE1              = '�������';
  MB_FONTSIZE2              = '�������';
  MB_FONTSIZE3              = '���������';
  MB_FONTSIZE4              = '����������';

  MB_CAPLEFT                = '����';
  MB_CAPRIGHT               = '�����';
  MB_CAPTOP                 = '����';
  MB_CAPBOTTOM              = '���';

// LMDUpdateAdapater
  IDS_UPDATE_CLOSEHOST = '�������� ���� ����������';
  IDS_UPDATE_SQL_SCRIPT_RECEIVE = '���������� SQL �������';
  IDS_UPDATE_FINISH = '���������� ����������';
  IDS_UPDATE_ERROR = '���������� ������';
  IDS_UPDATE_WAITING_FOR_INTERACTIVE_CONFIRM = '�������� �������������� �������������';
  IDS_UPDATE_INFORMATION = '����������';
  IDS_UPDATE_PROGRESS = '��������';  
  IDS_UPDATE_GETCONFIG = '�������� ������������ ����������� � ���������';


  IDS_UPDATE_USER_CANCELED = 'User canceled';
  IDS_UPDATE_CONTINUE = 'Continue update';
  IDS_UPDATE_CANCEL = 'Cancel update';
  IDS_COULNDT_LOAD_SCRIPT = 'Couldn''t load update script file';
  IDS_FOLDER_DOESNT_EXISTS = 'Folder doesn''t exists';
  IDS_LEAVE_SINGLE_OR_NOTHING_VALUE = 'Please, leave single value or nothing';
  
implementation

end.
