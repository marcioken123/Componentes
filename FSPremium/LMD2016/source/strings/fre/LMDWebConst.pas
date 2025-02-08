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
  LES_BEGIN_URL = 'Début de chargement de l''URL';
  LES_END_URL = 'Fin de chargement de l''URL';
  LES_DOWNLOAD_ERROR = 'Erreur de chargement';
  LES_HTTP_STATUS = 'Statut HTTP';
  LES_GET_COOKIES = 'Obtenir les cookies';
  LES_POST = 'Envoyer les paramètres';
  LES_REDIRECT = 'Rediriger vers';
  LES_DATA = 'Données';

  strBadType = 'Mauvais type de résultat';
  strExcludedType = 'Type de fichier exclu';
  IDLE_NAME = 'Inactif';
  COMPLITE_NAME = 'Terminé';
  ERROR_NAME = 'Erreur';
  PROCESS_NAME = 'Traitement en cours';

//LMDHTMLSupp
  MSG_MAX_HTML_PROCESS_CONST = 'HTML FindTemplate deadlock';
  MSG_BAD_PARAM_INDEX   = 'HTML FindTemplate: Bad param index';

//LMDRAS
  RASE_GETPARAMS = 'Impossible d''obtenir les paramètres de connexion';

//LMDRASCF
  RS_CONNECTING = 'Connexion';
  RS_CLOSE = 'Fermeture';

//Internet Errors
  SERROR_INTERNET_UNKNOWN = 'Erreur Internet: %d';
  SERROR_INTERNET = '%s';
  SERROR_HTTP_UNKNOWN = 'Erreur HTTP: %d';
  SERROR_HTTP = '%s';
  SERROR_STOPPED = 'Stoppé';
  SERROR_INTERNET_OUT_OF_HANDLES = 'Out of handles';
  SERROR_INTERNET_TIMEOUT = 'Temps expiré';
  SERROR_INTERNET_EXTENDED_ERROR = 'Erreur étendue';
  SERROR_INTERNET_INTERNAL_ERROR = 'Erreur interne';
  SERROR_INTERNET_INVALID_URL = 'URL non valide';
  SERROR_INTERNET_UNRECOGNIZED_SCHEME = 'Unrecognized scheme';
  SERROR_INTERNET_NAME_NOT_RESOLVED = 'Nom non résolu';
  SERROR_INTERNET_PROTOCOL_NOT_FOUND = 'Protocole non trouvé';
  SERROR_INTERNET_INVALID_OPTION = 'Option non valide';
  SERROR_INTERNET_BAD_OPTION_LENGTH = 'Option de longueur incorrecte';
  SERROR_INTERNET_OPTION_NOT_SETTABLE = 'Option non modifiable';
  SERROR_INTERNET_SHUTDOWN = 'Fermeture';
  SERROR_INTERNET_INCORRECT_USER_NAME = 'Nom d''utilisateur incorrect';
  SERROR_INTERNET_INCORRECT_PASSWORD = 'Mot de passe incorrect';
  SERROR_INTERNET_LOGIN_FAILURE = 'Echec de l''authentification';
  SERROR_INTERNET_INVALID_OPERATION = 'Opération non valide';
  SERROR_INTERNET_OPERATION_CANCELLED = 'Opération annulée';
  SERROR_INTERNET_INCORRECT_HANDLE_TYPE = 'Incorrect handle type';
  SERROR_INTERNET_INCORRECT_HANDLE_STATE = 'Incorrect handle state';
  SERROR_INTERNET_NOT_PROXY_REQUEST = 'Pas une requête proxy';
  SERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND = 'Valeur du registre non trouvée';
  SERROR_INTERNET_BAD_REGISTRY_PARAMETER = 'Mauvais paramètre du registre';
  SERROR_INTERNET_NO_DIRECT_ACCESS = 'Pas d''accès direct';
  SERROR_INTERNET_NO_CONTEXT = 'Pas de contexte';
  SERROR_INTERNET_NO_CALLBACK = 'Pas de rappel';
  SERROR_INTERNET_REQUEST_PENDING = 'Requête en cours';
  SERROR_INTERNET_INCORRECT_FORMAT = 'Format incorrect';
  SERROR_INTERNET_ITEM_NOT_FOUND = 'Elément non trouvé';
  SERROR_INTERNET_CANNOT_CONNECT = 'Ne peut pas se connecter';
  SERROR_INTERNET_CONNECTION_ABORTED = 'Connexion annulée';
  SERROR_INTERNET_CONNECTION_RESET = 'Connexion réinitialisée';
  SERROR_INTERNET_FORCE_RETRY = 'Ré-essayer';
  SERROR_INTERNET_INVALID_PROXY_REQUEST = 'Requête proxy non valide';
  SHTTP_ERROR_HTTP_STATUS_GATEWAY_TIMEOUT = 'Expiration passerelle';
  SHTTP_ERROR_HTTP_STATUS_SERVICE_UNAVAIL = 'Service non disponible';
  SHTTP_ERROR_HTTP_STATUS_BAD_GATEWAY = 'Mauvaise passerelle';
  SHTTP_ERROR_HTTP_STATUS_NOT_SUPPORTED = 'Non supporté';
  SHTTP_ERROR_HTTP_STATUS_SERVER_ERROR = 'Erreur du serveur';
  SHTTP_ERROR_HTTP_STATUS_UNSUPPORTED_MEDIA = 'Média non supporté';
  SHTTP_ERROR_HTTP_STATUS_URI_TOO_LONG = 'URI trop longue';
  SHTTP_ERROR_HTTP_STATUS_REQUEST_TOO_LARGE = 'Requête trop grande';
  SHTTP_ERROR_HTTP_STATUS_PRECOND_FAILED = 'Precond échoué';
  SHTTP_ERROR_HTTP_STATUS_AUTH_REFUSED = 'Authentification refusée';
  SHTTP_ERROR_HTTP_STATUS_GONE = 'Gone';
  SHTTP_ERROR_HTTP_STATUS_CONFLICT = 'Conflit HTTP';
  SHTTP_ERROR_HTTP_STATUS_REQUEST_TIMEOUT = 'Expiration requête';
  SHTTP_ERROR_HTTP_STATUS_PROXY_AUTH_REQ = 'Authentification du proxy requise';
  SHTTP_ERROR_HTTP_STATUS_NONE_ACCEPTABLE = 'Non acceptable';
  SHTTP_ERROR_HTTP_STATUS_BAD_METHOD = 'Mauvaise méthode';
  SHTTP_ERROR_HTTP_STATUS_NOT_FOUND = 'Fichier non trouvé';
  SHTTP_ERROR_HTTP_STATUS_FORBIDDEN = 'Accès interdit';
  SHTTP_ERROR_HTTP_STATUS_DENIED = 'Accès refusé';
  SHTTP_ERROR_HTTP_STATUS_BAD_REQUEST = 'Mauvaise requête';
  NOT_CONNECTED_ERROR = 'Non connecté';

// LMDWebDownloadForm
  DF_FROM='de';
  DF_KBS='Kb/s';
  DF_KB='Kb';
  DF_DOWNLOAD = 'Chargement:';
  DF_TRANSFER = 'Taux de transfert:';
  DF_TOTAL = 'Taille totale:';
  DF_CLOSE = '&Fermer';
  DF_CANCEL= 'Annuler';

// LMDWebMBIEFrame
  MB_LOADINGMSG             = 'Chargement...';
  MB_EMPTYURLMSG            = 'Page vierge';
  MB_BADBROWSERMSG          = 'Mauvais type de navigateur';
  MB_NOTSUPPORTMSG          = 'Opération non supportée';
  MB_LOCKMSG                = 'Verrouillage';

  MB_CLOSEMENUCPT           = 'Fermer';
  MB_CLOSEALLMENUCPT        = 'Fermer tout';
  MB_FORWARDMENUCPT         = 'Suivante';
  MB_BACKMENUCPT            = 'Précédente';
  MB_STOPMENUCPT            = 'Arrêter';
  MB_STOPALLMENUCPT         = 'Arrêter tout';
  MB_REFRESHMENUCPT         = 'Rafraîchir';
  MB_REFRESHALLMENUCPT      = 'Rafraîchir tout';
  MB_PREVIOUSBROWSERTABCPT  = 'Page précédente';
  MB_NEXTBROWSERTABCPT      = 'Page suivante';
  MB_TABSCPT                = 'Pages';

  MB_FONTSIZE0              = 'La plus grande';
  MB_FONTSIZE1              = 'Plus grande';
  MB_FONTSIZE2              = 'Moyenne';
  MB_FONTSIZE3              = 'Plus petite';
  MB_FONTSIZE4              = 'La plus petite';

  MB_CAPLEFT                = 'Gauche';
  MB_CAPRIGHT               = 'Droite';
  MB_CAPTOP                 = 'Haut';
  MB_CAPBOTTOM              = 'Bas';
  
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
