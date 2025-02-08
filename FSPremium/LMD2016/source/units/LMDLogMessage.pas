unit LMDLogMessage;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDLogMessage unit (AH, AIH)
----------------------------
Log system that can help monitoring actions of application without debugger.

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

[+] Added SendHDC, SendCanvas

###############################################################################}

interface

uses
  Windows, Graphics, SysUtils, Messages, Classes, Controls, TypInfo,
  LMDZLib, LMDDebugUnit, LMDFiles, LMDTypes, LMDIniCtrl,
  LMDObjectList, LMDUnicode, LMDStrings, LMDSysIn, LMDThreads,
  LMDXML, LMDProcs;

const
  CHeaderMarker: array[0..5] of byte = ($4C, $4D, $44, $4C, $4F, $47); // *.lgl file marker
  LMDLogMarker: Integer = $4C444D4C; // Magic number 'LMDL';

type
  TLMDLogMessageType = (mtControlMessage, mtDataMessage, mtFlowMessage, mtWatchMessage);
  TLMDLogMessageSubType = TGUID;

const
  mstNumber: TLMDLogMessageSubType  = '{38BFADBE-25FD-4C31-A66A-781B178D6B31}';
  mstDateTime: TLMDLogMessageSubType = '{C8EEDFE6-9039-4B0D-B8D0-0C0673DD2E50}';
  mstObject: TLMDLogMessageSubType = '{54E2DF1F-483D-47A4-900C-5CDCCDF22CFE}';
  mstString: TLMDLogMessageSubType = '{D3F85E8A-2834-45CF-B42C-15DB0EFE6027}';
  mstSourceCode: TLMDLogMessageSubType = '{B652C0A8-7CA9-454E-AA1D-7F09C2753AFA}';
  mstKeyValue: TLMDLogMessageSubType = '{9591208D-3845-4FDC-A8CF-C3DF19EA0C55}';
  mstImage: TLMDLogMessageSubType = '{605F11D0-78A3-45F0-9191-246EDE4EEB03}';
  mstWarning: TLMDLogMessageSubType = '{938E87D7-3153-4E05-912F-C520CF530E1F}';
  mstError: TLMDLogMessageSubType = '{4EA3B269-CE71-4870-9655-5323C5DB268B}';
  mstFatal: TLMDLogMessageSubType = '{3AC317D6-B681-4D75-A24A-3FD018644FE5}';
  mstInformation: TLMDLogMessageSubType = '{14CAB6FB-CB46-45A5-B496-163E4D04EDBB}';
  mstException: TLMDLogMessageSubType = '{E06293C0-BDB7-4C50-9BBD-4D2493D9B701}';
  mstBinary: TLMDLogMessageSubType = '{A3F92619-A9DA-4338-A1DB-021CD20272F8}';
  mstCommand: TLMDLogMessageSubType = '{30E820E9-3BD8-4DD1-8827-E4B7D4625B77}';
  mstFlowControl: TLMDLogMessageSubType = '{8CF8427B-53AB-4E1A-B779-47AE75F3D1D0}';
  mstProfiling: TLMDLogMessageSubType = '{C65733BB-9876-44EB-B3AF-3D3268553614}';
  mstCurrency: TLMDLogMessageSubType = '{F15E7922-15F4-42D7-A451-8930EA0C8C06}';
  mstMessage: TLMDLogMessageSubType = '{329BD257-6E0A-4A35-80E7-15BFF39AEBD3}';
  mstComment: TLMDLogMessageSubType = '{58AFCC1F-6A85-4C63-B2BF-1A9CDA5E2D23}';
  mstPoint: TLMDLogMessageSubType = '{6680CD2D-7A3D-4AF7-8019-2455637F271C}';
  mstRect: TLMDLogMessageSubType = '{7C350102-E06B-4826-AC01-44C4DBECF383}';
  mstPointer: TLMDLogMessageSubType = '{779AED7F-8670-412D-A47A-3C798327B0F7}';
  mstBoolean: TLMDLogMessageSubType = '{46A47F8B-8BBB-405D-AEE3-30672305D11A}';
  mstCounter: TLMDLogMessageSubType = '{1300E811-9D9D-4978-BF26-4807F8231870}';
  mstIncCounter: TLMDLogMessageSubType = '{D7B7FDBB-2E44-48D1-8E32-FF51795472AC}';
  mstDecCounter: TLMDLogMessageSubType = '{2B62C864-9C88-4601-A6AA-1362BDFF7458}';
  mstTable: TLMDLogMessageSubType = '{E9362750-96B6-45F2-9969-E8E8EFC27F30}';
  mstDataSetStructure: TLMDLogMessageSubType = '{540BEBC8-DE34-4C5D-8386-655B2BB4CBBA}';
  mstImageList: TLMDLogMessageSubType = '{A5E94D37-2650-4773-8BEA-720525B854DA}';
  mstComponentAsText: TLMDLogMessageSubType = '{DA6C4580-50F7-4773-80A4-100AA2BBC395}';
  mstEnum: TLMDLogMessageSubType = '{A0F60AF4-5E7A-43DC-A664-31B9BD8953FE}';
  mstSet: TLMDLogMessageSubType = '{91A2353F-5FA7-46DC-90CF-4378DC1958C8}';
  mstHTML: TLMDLogMessageSubType = '{FDC8A95E-1244-43D3-8697-5BE113157660}';
  mstStringList: TLMDLogMessageSubType = '{B5580B8E-94A4-4196-9C5F-BE2F33BB648F}';
  mstStackTrace: TLMDLogMessageSubType = '{BDDBAA4C-D39E-4DE6-AB8A-7A7CA9695D70}';
  mstNone: TLMDLogMessageSubType = '{00000000-0000-0000-0000-000000000000}';

const
  SID_LMDLogTransport = '{F4F68406-A3CE-4783-A8BE-4293DC9FB72B}';
  SID_LMDGeneralLogLink = '{D974AF86-C7E2-49B5-B88F-1D0253320DB3}';
  SID_LMDImplementing = '{08FBDF7E-3ABB-4731-9B84-5D4F806DD019}';
  SID_LMDStreamed = '{CFDA3B56-D4D8-4174-A9BF-8D863DE0308B}';

  IID_LMDLogTransport: TGUID = '{F4F68406-A3CE-4783-A8BE-4293DC9FB72B}';
  IID_LMDImplementing: TGUID = '{08FBDF7E-3ABB-4731-9B84-5D4F806DD019}';
  IID_LMDStreamed: TGUID = '{CFDA3B56-D4D8-4174-A9BF-8D863DE0308B}';
  IID_LMDGeneralLogLink: TGUID = '{D974AF86-C7E2-49B5-B88F-1D0253320DB3}';

type
  // Forward class declaration
  TLMDLogLevel = class;
  {$M+}
  TLMDLogMessage = class;
  {$M-}
  TLMDLogManager = class;

  // Events
  TLMDLogMessageNotify = procedure(Sender: TObject; ALogMessage: TLMDLogMessage) of object;
  TLMDLogCollectorProgress = procedure(Sender: TObject; ACount, ACurrent: Integer) of object;
  TLMDFilterLogMessageEvent = procedure(Sender: TObject; const AMessage: TLMDLogMessage; var AFiltered: Boolean) of object;

  ILMDStreamed = interface(IInterface)
  [SID_LMDStreamed]
    procedure SaveToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
  end;

  {$HINTS OFF}
  ILMDLogTransport = interface(IInterface)
  [SID_LMDGeneralLogLink]
    procedure SetActive(const AValue: Boolean);
    function GetActive: Boolean;
    function GetParameters: WideString;
    procedure SetParameters(const AValue: WideString);
    function GetType: WideString;
    function SendMsg(AMessage: TLMDLogMessage): boolean;
    property Active: Boolean read GetActive write SetActive;
    property Parameters: WideString read GetParameters write SetParameters;
  end;
  {$HINTS ON}

  // Exception class
  ELMDLogException = class(Exception);

  // Represents Log Level and methods for comparing to other
  // levels                                                    
  TLMDLogLevel = class(TObject)
  private
    FValue: Cardinal;
    FName: TLMDString;
  public
    constructor Create(ALevelValue: Longword; ALevelName: TLMDString);
    // Return True if current LogLevel.Value <= ALevel.Value
    function IsAllow(ALevel: TLMDLogLevel): boolean;
    // Returns True if Levels are equal
    function IsEqual(ALevel: TLMDLogLevel): boolean;
    // Returns True if Self.Value is greater than ALevel.Value
    function IsGreater(ALevel: TLMDLogLevel): boolean;
    // Returns True if Self.Value is lesser than ALevel.Value
    function IsLesser(Alevel: TLMDLogLevel): boolean;
    // Returns weight of level
    property Value: Cardinal read FValue;
    // Returns name of level
    property Name: TLMDString read FName;
  end;

  // Helper class for message subtypes
  TLMDLogMessageSubtypeClass = class(TObject)
  private
    FGUID: TGUID;
    function GetAsString: String;
    procedure SetAsString(const Value: String);
  public
    // Returns True if GUID of subtype is equal to AGUID
    function Equal(const AGUID: TGUID): Boolean;
    // Saves message subtype into stream
    procedure SaveToStream(const AStream: TStream);
    // Loads message subtype from stream
    procedure LoadFromStream(const AStream: TStream);
    // Returns message subtype as GUID
    property AsGUID: TGUID read FGUID write FGUID;
    // Returns message subtype as String
    property AsString: String read GetAsString write SetAsString;
  end;

  TLMDLogMessage = class(TInterfacedPersistent, ILMDStreamed)
  private
    FThreadId: Cardinal;
    FProcessId: Cardinal;
    FUserName: TLMDString;
    FAppName: TLMDString;
    FComputerName: TLMDString;

    FLogLevel: Cardinal;
    FSessionName: TLMDString;
    FMessageTitle: TLMDString;
    FDateTimeSent: TDateTime;
    FDateTimeReceived: TDateTime;
    FStorage: TMemoryStream;
    FMessageType: TLMDLogMessageType;
    FMessageSubType: TLMDLogMessageSubtypeClass;
    FBackgroundColor: TColor;
    function GetMessageName: TLMDString;
    function GetMessageValue: TLMDString;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);

    property Storage: TMemoryStream read FStorage;
    property MessageName: TLMDString read GetMessageName;
    property MessageValue: TLMDString read GetMessageValue;

  published
    property LogLevel: Cardinal read FLogLevel;
    property MessageSubType: TLMDLogMessageSubtypeClass read FMessageSubType write FMessageSubType;
    property MessageType: TLMDLogMessageType read FMessageType write FMessageType;
    property SessionName: TLMDString read FSessionName;
    property ComputerName: TLMDString read FComputerName;
    property UserName: TLMDString read FUserName;
    property AppName: TLMDString read FAppName write FAppName;
    property ProcessId: Cardinal read FProcessId write FProcessId;
    property ThreadId: Cardinal read FThreadId write FThreadId;
    property DateTimeSent: TDateTime read FDateTimeSent;
    property DateTimeReceived: TDateTime read FDateTimeReceived write FDateTimeReceived;
    property Title: TLMDString read FMessageTitle write FMessageTitle;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
  end;

  TLMDLogCustomSession = class(TPersistent)
  protected
    FProcessId: Cardinal;
    FComputerName: TLMDString;
    FUserName: TLMDString;
    FAppName: TLMDString;

    FLogManager: TLMDLogManager;
    FDefaultLogLevel: TLMDLogLevel;
    FAllowLogLevel: TLMDLogLevel;
    FSessionName: TLMDString;
    FOnFilterMessage: TLMDFilterLogMessageEvent;
    FFiltered: Boolean;
    FCurrentBackgroundColor: TColor;
    FTransport: ILMDLogTransport;

    procedure TriggerFilterMessage(ALogMsg: TLMDLogMessage; var ARejected: Boolean); virtual;
    procedure CreateMessage(var LLogMsg: TLMDLogMessage); virtual;
    procedure DestroyMessage(var LLogMsg: TLMDLogMessage); virtual;
    procedure TransferMessage(ALogMsg: TLMDLogMessage);
    procedure SetCurrentBackgroundColor(const AColor: TColor); virtual;
  public
    constructor Create(AOwner: TLMDLogManager; const AName: TLMDString; ATransport: ILMDLogTransport); virtual;
    destructor Destroy; override;

    // NB. This method should return _unique_ name for Session type. Must be overrided in ancestors
    class function GetName: WideString; virtual; // abstract

    // Raw messages
    procedure SendCustomStream(ALogLevel: TLMDLogLevel; AName, AValue: TLMDString; AStream: TStream; AType: TLMDLogMessageType; ASubType: TLMDLogMessageSubType); overload;
    procedure SendCustomStream(AName, AValue: TLMDString; AStream: TStream; AType: TLMDLogMessageType; ASubType: TLMDLogMessageSubType); overload;
    procedure SendCustomString(ALogLevel: TLMDLogLevel; AName, AValue: TLMDString; AType: TLMDLogMessageType; ASubType: TLMDLogMessageSubType); overload;
    procedure SendCustomString(AName, AValue: TLMDString; AType: TLMDLogMessageType; ASubType: TLMDLogMessageSubType); overload;
    procedure SendCustomFile(ALogLevel: TLMDLogLevel; AName, AValue: TLMDString; const AFileName: TLMDString; AType: TLMDLogMessageType; ASubType: TLMDLogMessageSubType); overload;
    procedure SendCustomFile(AName, AValue: TLMDString; const AFileName: TLMDString; AType: TLMDLogMessageType; ASubType: TLMDLogMessageSubType); overload;

    // Log level
    property DefaultLogLevel: TLMDLogLevel read FDefaultLogLevel write FDefaultLogLevel;
    property AllowLogLevel: TLMDLogLevel read FAllowLogLevel write FAllowLogLevel;

    property Name: TLMDString read FSessionName;
    property BackgroundColor: TColor read FCurrentBackgroundColor write SetCurrentBackgroundColor;
    property Filtered: Boolean read FFiltered write FFiltered;
    property OnFilterMessage: TLMDFilterLogMessageEvent read FOnFilterMessage write FOnFilterMessage;
  end;

  TLMDLogSession = class(TLMDLogCustomSession)
  public
    class function GetName: WideString; override;

    // Control messages
    procedure ClearLog;
    procedure ClearWatch;
    procedure ClearCallStack;
    procedure SendSeparator;

    // Flowcontrol messages
    procedure TouchCounter(AName: TLMDString);
    procedure ReleaseCounter(AName: TLMDString);
    procedure EnterProcess(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure EnterProcess(AName: TLMDString); overload;
    procedure EnterThread(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure EnterThread(AName: TLMDString); overload;
    procedure EnterMethod(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure EnterMethod(AName: TLMDString); overload;
    procedure LeaveProcess(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure LeaveProcess(AName: TLMDString); overload;
    procedure LeaveThread(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure LeaveThread(AName: TLMDString); overload;
    procedure LeaveMethod(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure LeaveMethod(AName: TLMDString); overload;

    // add by khamov
    procedure CreateCounter(AName: TLMDString); overload;
    procedure CreateCounter(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure DeleteCounter(AName: TLMDString); overload;
    procedure DeleteCounter(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;

    procedure IncCounter(AName: TLMDString; ADelta: Integer = 1); overload;
    procedure IncCounter(ALogLevel: TLMDLogLevel; AName: TLMDString; ADelta: Integer = 1); overload;

    procedure DecCounter(AName: TLMDString; ADelta: Integer = 1); overload;
    procedure DecCounter(ALogLevel: TLMDLogLevel; AName: TLMDString; ADelta: Integer = 1); overload;

    // Data messages
    // Graphics
    procedure SendBitmap(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TBitmap); overload;
    procedure SendBitmap(AName: TLMDString; AValue: TBitmap); overload;
    procedure SendIcon(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AValue: TIcon); overload;
    procedure SendIcon(const AName: TLMDString; AValue: TIcon); overload;
    procedure SendMetafile(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AValue: TMetafile); overload;
    procedure SendMetafile(const AName: TLMDString; AValue: TMetafile); overload;
    procedure SendPoint(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AValue: TPoint); overload;
    procedure SendPoint(const AName: TLMDString; AValue: TPoint); overload;
    procedure SendRect(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TRect); overload;
    procedure SendRect(AName: TLMDString; AValue: TRect); overload;
    procedure SendHDC(ALogLevel: TLMDLogLevel; AName: TLMDString; const AHDC: HDC; const ARect: TRect); overload;
    procedure SendHDC(AName: TLMDString; const AHDC: HDC; const ARect: TRect); overload;
    procedure SendCanvas(ALogLevel: TLMDLogLevel; AName: TLMDString; const ACanvas: TCanvas; const ARect: TRect); overload;
    procedure SendCanvas(AName: TLMDString; const ACanvas: TCanvas; const ARect: TRect); overload;

    // Misc
    procedure SendHtml(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const AValue: TLMDString); overload;
    procedure SendHtml(const AName: TLMDString; const AValue: TLMDString); overload;
    procedure SendSql(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const AValue: TLMDString); overload;
    procedure SendSql(const AName: TLMDString; const AValue: TLMDString); overload;

    // General types
    procedure SendString(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TLMDString); overload;
    procedure SendString(AName: TLMDString; AValue: TLMDString); overload;
    procedure SendFormatString(ALogLevel: TLMDLogLevel; AName: TLMDString; AFormat: TLMDString; AValues: array of const); overload;
    procedure SendFormatString(AName: TLMDString; AFormat: TLMDString; AValues: array of const); overload;
    procedure SendSourceCode(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TLMDString; const ASyntaxScheme: TLMDString); overload;
    procedure SendSourceCode(AName: TLMDString; AValue: TLMDString; const ASyntaxScheme: TLMDString); overload;
    procedure SendDate(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime); overload;
    procedure SendDate(AName: TLMDString; AValue: TDateTime); overload;
    procedure SendTime(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime); overload;
    procedure SendTime(AName: TLMDString; AValue: TDateTime); overload;
    procedure SendDateTime(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime); overload;
    procedure SendDateTime(AName: TLMDString; AValue: TDateTime); overload;
    procedure SendInteger(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Integer); overload;
    procedure SendInteger(AName: TLMDString; AValue: Integer); overload;
    procedure SendCurrency(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Currency); overload;
    procedure SendCurrency(AName: TLMDString; AValue: Currency); overload;
    procedure SendFloat(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Extended); overload;
    procedure SendFloat(AName: TLMDString; AValue: Extended); overload;
    procedure SendHResult(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: HResult); overload;
    procedure SendHResult(AName: TLMDString; AValue: HResult); overload;
    procedure SendBoolean(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Boolean); overload;
    procedure SendBoolean(AName: TLMDString; AValue: Boolean); overload;
    procedure SendEnum(ALogLevel: TLMDLogLevel; const AName: TLMDString; ATypeInfo: PTypeInfo; const AValue: Integer); overload;
    procedure SendEnum(const AName: TLMDString; ATypeInfo: PTypeInfo; const AValue: Integer); overload;
    procedure SendSet(ALogLevel: TLMDLogLevel; const AName: TLMDString; ATypeInfo: PTypeInfo; const AValue: Integer); overload;
    procedure SendSet(const AName: TLMDString; ATypeInfo: PTypeInfo; const AValue: Integer); overload;

    procedure SendLastOSError(ALogLevel: TLMDLogLevel; AName: TLMDString; ALastError: Integer); overload;
    procedure SendLastOSError(AName: TLMDString; ALastError: Integer); overload;
    procedure SendLastOSError(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure SendLastOSError(AName: TLMDString); overload;
    procedure SendPointer(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Pointer); overload;
    procedure SendPointer(AName: TLMDString; AValue: Pointer); overload;
    procedure SendBinaryData(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Pointer; ASize: Integer); overload;
    procedure SendBinaryData(AName: TLMDString; AValue: Pointer; ASize: Integer); overload;
    procedure SendScreenShot(ALogLevel: TLMDLogLevel; AName: TLMDString; AWindow: THandle = 0); overload;
    procedure SendScreenShot(AName: TLMDString; AWindow: THandle = 0); overload;
    procedure SendDesktopScreenshot(ALogLevel: TLMDLogLevel); overload;
    procedure SendDesktopScreenshot; overload;
    procedure SendSystemInformation(ALogLevel: TLMDLogLevel); overload;
    procedure SendSystemInformation; overload;
    procedure SendWindowMessage(ALogLevel: TLMDLogLevel; AMessage: Cardinal; AWParam: WPARAM; ALParam: LPARAM); overload;
    procedure SendWindowMessage(AMessage: Cardinal; AWParam: WPARAM; ALParam: LPARAM); overload;
    procedure SendWindowMessage(ALogLevel: TLMDLogLevel; AMessage: Cardinal); overload;
    procedure SendWindowMessage(AMessage: Cardinal); overload;
    procedure SendObject(ALogLevel: TLMDLogLevel; AName: TLMDString; AInstance: TObject); overload;
    procedure SendObject(AName: TLMDString; AInstance: TObject); overload;
    procedure SendComment(AValue: TLMDString); overload;
    procedure SendComment(ALogLevel: TLMDLogLevel; AValue: TLMDString); overload;
    procedure SendImageList(ALogLevel: TLMDLogLevel; AName: TLMDString; AImageList: TImageList); overload;
    procedure SendImageList(AName: TLMDString; AImageList: TImageList); overload;
    procedure SendImageList(ALogLevel: TLMDLogLevel; AName: TLMDString; AImageList: TImageList; const AFromIndex, AToIndex: Integer); overload;
    procedure SendImageList(AName: TLMDString; AImageList: TImageList; const AFromIndex, AToIndex: Integer); overload;
    procedure SendComponentAsText(AName: TLMDString; AComponent: TComponent); overload;
    procedure SendComponentAsText(ALogLevel: TLMDLogLevel; AName: TLMDString; AComponent: TComponent); overload;
    procedure SendStringList(const AName: TLMDString; AValue: TStrings); overload;
    procedure SendStringList(ALogLevel: TLMDLogLevel; const AName: TLMDString; AValue: TStrings); overload;

    // Send*Stream methods
    procedure SendHtmlStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AStream: TStream); overload;
    procedure SendHtmlStream(const AName: TLMDString; AStream: TStream); overload;
    procedure SendBitmapStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AStream: TStream); overload;
    procedure SendBitmapStream(const AName: TLMDString; AStream: TStream); overload;
    procedure SendIconStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AStream: TStream); overload;
    procedure SendIconStream(const AName: TLMDString; AStream: TStream); overload;
    procedure SendMetafileStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AStream: TStream); overload;
    procedure SendMetafileStream(const AName: TLMDString; AStream: TStream); overload;
    procedure SendSourceCodeStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const ASyntaxScheme: TLMDString; AStream: TStream); overload;
    procedure SendSourceCodeStream(const AName: TLMDString; const ASyntaxScheme: TLMDString; AStream: TStream); overload;

    // Send*File methods
    procedure SendHtmlFile(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const AFileName: TLMDString); overload;
    procedure SendHtmlFile(const AName: TLMDString; const AFileName: TLMDString); overload;
    procedure SendBitmapFile(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const AFileName: TLMDString); overload;
    procedure SendBitmapFile(const AName: TLMDString; const AFileName: TLMDString); overload;
    procedure SendIconFile(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const AFileName: TLMDString); overload;
    procedure SendIconFile(const AName: TLMDString; const AFileName: TLMDString); overload;
    procedure SendMetafileFile(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const AFileName: TLMDString); overload;
    procedure SendMetafileFile(const AName: TLMDString; const AFileName: TLMDString); overload;
    procedure SendSourceCodeFile(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const ASyntaxScheme: TLMDString; const AFileName: TLMDString); overload;
    procedure SendSourceCodeFile(const AName: TLMDString; const ASyntaxScheme: TLMDString; const AFileName: TLMDString); overload;

    procedure SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue: TLMDString); overload;
    procedure SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: TLMDString); overload;
    procedure SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue: Integer); overload;
    procedure SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: Integer); overload;
    procedure SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue: Real); overload;
    procedure SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: Real); overload;
    procedure SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue: TObject); overload;
    procedure SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: TObject); overload;
    procedure SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue: Boolean); overload;
    procedure SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: Boolean); overload;
    procedure SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: TLMDString); overload;
    procedure SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: TLMDString); overload;
    procedure SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Integer); overload;
    procedure SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Integer); overload;
    procedure SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Real); overload;
    procedure SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Real); overload;
    procedure SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: TObject); overload;
    procedure SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: TObject); overload;
    procedure SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Boolean); overload;
    procedure SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Boolean); overload;
    procedure SendAssigned(AName: TLMDString; APointer: Pointer); overload;
    procedure SendAssigned(ALogLevel: TLMDLogLevel; AName: TLMDString; APointer: Pointer); overload;
    procedure SendProperty(ALogLevel: TLMDLogLevel; AName: TLMDString; AObject: TObject; APropName: TLMDString); overload;
    procedure SendProperty(AName: TLMDString; AObject: TObject; APropName: TLMDString); overload;
    procedure SendHeapStatus(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure SendHeapStatus(AName: TLMDString); overload;
    procedure SendWindowInfo(ALogLevel: TLMDLogLevel; AName: TLMDString; AHandle: THandle); overload;
    procedure SendWindowInfo(AName: TLMDString; AHandle: THandle); overload;

    // Errors
    procedure SendWarning(AWarning: TLMDString); overload;
    procedure SendException(AException: Exception); overload;
    procedure SendError(AError: TLMDString); overload;
    procedure SendFatal(AError: TLMDString); overload;

    // Watch messages
    procedure WatchBoolean(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Boolean); overload;
    procedure WatchBoolean(AName: TLMDString; AValue: Boolean); overload;
    procedure WatchString(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TLMDString); overload;
    procedure WatchString(AName: TLMDString; AValue: TLMDString); overload;
    procedure WatchFormatString(ALogLevel: TLMDLogLevel; AName: TLMDString; AFormat: TLMDString; AValues: array of const); overload;
    procedure WatchFormatString(AName: TLMDString; AFormat: TLMDString; AValues: array of const); overload;
    procedure WatchInteger(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Integer); overload;
    procedure WatchInteger(AName: TLMDString; AValue: Integer); overload;
    procedure WatchFloat(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Extended); overload;
    procedure WatchFloat(AName: TLMDString; AValue: Extended); overload;
    procedure WatchDate(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime); overload;
    procedure WatchDate(AName: TLMDString; AValue: TDateTime); overload;
    procedure WatchTime(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime); overload;
    procedure WatchTime(AName: TLMDString; AValue: TDateTime); overload;
    procedure WatchDateTime(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime); overload;
    procedure WatchDateTime(AName: TLMDString; AValue: TDateTime); overload;
    procedure WatchCurrency(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Currency); overload;
    procedure WatchCurrency(AName: TLMDString; AValue: Currency); overload;

    // Profiling messages
    procedure TimeMark(ALogLevel: TLMDLogLevel; AName: TLMDString); overload;
    procedure TimeMark(AName: TLMDString); overload;
  end;

  TLMDLogSessionClass = class of TLMDLogCustomSession;

  TLMDLogCustomTransport = class(TInterfacedObject, ILMDLogTransport)
  protected
    FActive: Boolean;
    FBuffer: TLMDThreadBuffer;
    FSendThread: TThread;
    function CreateSendThread: TThread; virtual; abstract;
    function GetParameters: WideString; virtual; abstract;
    procedure SetParameters(const Value: WideString); virtual; abstract;
    procedure SetActive(const AValue: Boolean); virtual;
    function GetActive: Boolean; virtual;
    function GetType: WideString;
    function GetMessagesBufferSize: Integer; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    class function GetName: WideString; virtual; // abstract
    function SendMsg(AMessage: TLMDLogMessage): Boolean; virtual;
    property Active: Boolean read GetActive write SetActive;
    property Parameters: WideString read GetParameters write SetParameters;
  end;

  // Metaclass for transport
  TLMDLogTransportClass = class of TLMDLogCustomTransport;

  TLMDLogManager = class(TPersistent)
  private
    FSessionList: TLMDObjectList;
    FTransportList: TLMDObjectList;

    FSessionClasses: TLMDObjectList;
    FTransportClasses: TLMDObjectList;

    FLogLevelList: TLMDObjectList;

    function GetSession(const AName: TLMDString): TLMDLogCustomSession;
    function GetSessionIndex(const AName: TLMDString): Integer;
    function GetSessionClass(const ASessionClassType: TLMDString): TLMDLogSessionClass;
    function GetTransportClass(const ATransportName: TLMDString): TLMDLogTransportClass;
    procedure ParseConnectString(const ASessionConnectString: TLMDString;
                                 var ASessionName, ASessionType, ATransportType: TLMDString;
                                 var ATransportParams: TLMDMemoryStrings);
    function GetRootSession: TLMDLogSession;
  public
    constructor Create;
    destructor Destroy; override;
    function SaveConfig(AFileName: TLMDString): Boolean;
    function LoadConfig(AFileName: TLMDString): Boolean;

    procedure RegisterTransportClass(ATransportClass: TLMDLogTransportClass);
    procedure RegisterSessionClass(ASessionClass: TLMDLogSessionClass);
    procedure RegisterLogLevel(ALogLevel: TLMDLogLevel);

    // Log level service methods
    function GetLogLevelNameByValue(const AValue: Cardinal): TLMDString;
    function GetLogLevelValueByName(const AName: TLMDString): Cardinal;

    function AddSession(const ASessionConnectString: TLMDString): TLMDLogCustomSession;
    procedure DeleteSession(const AName: TLMDString);
    property RootSession: TLMDLogSession read GetRootSession;
    property Session[const AName: TLMDString]: TLMDLogCustomSession read GetSession;
  end;

  TLMDLogCustomSendThread = class(TThread)
  protected
    FBuffer: TLMDThreadBuffer;
    procedure Execute; override;
    function DoMessage(AMessage: TLMDLogMessage): Boolean; virtual; abstract;
  public
    constructor Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
  end;

var
  // Log levels
  LogTrace:TLMDLogLevel;
  LogDebug:TLMDLogLevel;
  LogInformation:TLMDLogLevel;
  LogWarning:TLMDLogLevel;
  LogError:TLMDLogLevel;
  LogFatal:TLMDLogLevel;
  LogAll:TLMDLogLevel;
  LogOff:TLMDLogLevel;

  // Global instances
  LMDLogManager: TLMDLogManager;
  LMDLog: TLMDLogSession;

const
  // !!! Do not localize !!!
  CMSeparator = '|';
  CPSeparator = ';';
  CRootConnectString = 'Root' + CMSeparator + 'lmd_general_session' + CMSeparator +
                       'lmd_wmcopydata_log' + CMSeparator + 'WindowClass=TLMDLogHelperWindow' +
                       CPSeparator + 'WindowName=LMDLogHelper';

implementation

uses
  LMDLogWMCopyTransport, LMDRegExpr;

{ ************************ TLMDLogMessageSubtypeClass ************************* }
{ ---------------------------------------------------------------------------- }
function TLMDLogMessageSubtypeClass.Equal(const AGUID: TGUID): Boolean;
begin
  Result := IsEqualGUID(FGUID, AGUID);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogMessageSubtypeClass.GetAsString: String;
begin
  Result := GUIDToString(FGUID);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogMessageSubtypeClass.LoadFromStream(const AStream: TStream);

begin
  AStream.Read(FGUID, SizeOf(FGUID));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogMessageSubtypeClass.SaveToStream(const AStream: TStream);
begin
  AStream.Write(FGuid, SizeOf(FGuid));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogMessageSubtypeClass.SetAsString(const Value: String);
begin
  FGUID := StringToGUID(Value);
end;

{******************************** TLMDLogMessage ******************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDLogMessage.Create;
begin
  inherited Create;
  FDateTimeSent := Now;
  FThreadId := GetCurrentThreadId;
  FStorage := TMemoryStream.Create;
  FMessageSubType := TLMDLogMessageSubtypeClass.Create; 
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDLogMessage.Destroy;
begin
  FMessageSubType.Free;
  FStorage.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogMessage.GetMessageName: TLMDString;
begin
  Result := Copy(FMessageTitle, 1, Pos('=', FMessageTitle) - 1);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogMessage.GetMessageValue: TLMDString;
begin
  Result := Copy(FMessageTitle, Pos('=', FMessageTitle) + 1, Length(FMessageTitle));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogMessage.SaveToStream(AStream: TStream);
var
  LType: TLMDLogMessageType;
  LVersion: Byte;
  LDataLen: Integer;
  LColor: Integer;

  function LMDUTF8Encode(const ASource: WideString): AnsiString;
  begin
    LMDConvertUTF16toUTF8(ASource, Result, strictConversion, False);
  end;

begin
  try
    LType := MessageType;
    LVersion := $01; // Ver 1.0
    AStream.Write(LMDLogMarker, SizeOf(LMDLogMarker));
    // Write Version (for future use)
    AStream.Write(LVersion, SizeOf(LVersion));
    AStream.Write(LType, SizeOf(LType));
    MessageSubType.SaveToStream(AStream);
    AStream.Write(FProcessId, SizeOf(FProcessId));
    AStream.Write(FThreadId, SizeOf(FThreadId));
    AStream.Write(FDateTimeSent, SizeOf(FDateTimeSent));
    AStream.Write(FDateTimeReceived, SizeOf(FDateTimeSent));
    LColor := ColorToRGB(FBackgroundColor);
    AStream.Write(LColor, SizeOf(Integer));
    AStream.Write(FLogLevel, SizeOf(FLogLevel));
    LMDAnsiWriteStringToStream(AStream, LMDUTF8Encode(FSessionName));
    LMDAnsiWriteStringToStream(AStream, LMDUTF8Encode(FComputerName));
    LMDAnsiWriteStringToStream(AStream, LMDUTF8Encode(FUserName));
    LMDAnsiWriteStringToStream(AStream, LMDUTF8Encode(FAppName));
    LMDAnsiWriteStringToStream(AStream, LMDUTF8Encode(FMessageTitle));

    LDataLen := FStorage.Size;
    AStream.Write(LDataLen, SizeOf(LDataLen));
    AStream.CopyFrom(FStorage, 0);
  except
    raise ELMDLogException.Create('Message write error');
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogMessage.LoadFromStream(AStream: TStream);
var
  LMarker, LDataLen: Integer;
  LVersion: Byte;

  LSessionName: AnsiString;
  LCompName: AnsiString;
  LUser: AnsiString;
  LAppName: AnsiString;
  LMessageTitle: AnsiString;

  function LMDUTF8Decode(const ASource: AnsiString): WideString;
  begin
    LMDConvertUTF8toUTF16(ASource, Result, strictConversion, False);
  end;

begin
  try
    AStream.Read(LMarker, SizeOf(LMarker));
    if LMarker <> LMDLogMarker then
      raise ELMDLogException.Create('Invalid message marker');

    // Read version (for future use)
    AStream.Read(LVersion, SizeOf(LVersion));
    AStream.Read(FMessageType, SizeOf(FMessageType));
    FMessageSubType.LoadFromStream(AStream);
    AStream.Read(FProcessId, SizeOf(FProcessId));
    AStream.Read(FThreadId, SizeOf(FThreadId));
    AStream.Read(FDateTimeSent, SizeOf(FDateTimeSent));
    AStream.Read(FDateTimeReceived, SizeOf(FDateTimeReceived));
    AStream.Read(FBackgroundColor, SizeOf(FBackgroundColor));
    AStream.Read(FLogLevel, SizeOf(FLogLevel));
    LMDAnsiReadStringFromStream(AStream, LSessionName);
    LMDAnsiReadStringFromStream(AStream, LCompName);
    LMDAnsiReadStringFromStream(AStream, LUser);
    LMDAnsiReadStringFromStream(AStream, LAppName);
    LMDAnsiReadStringFromStream(AStream, LMessageTitle);

    FSessionName := LMDUTF8Decode(LSessionName);
    FComputerName := LMDUTF8Decode(LCompName);
    FUserName := LMDUTF8Decode(LUser);
    FAppName := LMDUTF8Decode(LAppName);
    FMessageTitle := LMDUTF8Decode(LMessageTitle);

    AStream.Read(LDataLen, SizeOf(LDataLen));
    if LDataLen > 0 then
      FStorage.CopyFrom(AStream, LDataLen);
    FStorage.Position := 0;
  except
    raise ELMDLogException.Create('Message read error');
  end;
end;

{ ****************************** TLMDBaseLogSession *************************** }
{  ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.TriggerFilterMessage(ALogMsg: TLMDLogMessage; var ARejected: Boolean);
begin
  ARejected := False;
  if Assigned(FOnFilterMessage) then
    FOnFilterMessage(Self, ALogMsg, ARejected);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDLogCustomSession.Create(AOwner: TLMDLogManager; const AName: TLMDString; ATransport: ILMDLogTransport);
begin
  inherited Create;
  FSessionName := AName;
  FLogManager := AOwner;

  FUserName := LMDSIUserName;
  FComputerName := LMDSIComputerName;
  FAppName := ExtractFileName(ParamStr(0));
  FProcessId := GetCurrentProcessId;

  // Init transport
  FTransport := ATransport;
  FTransport.Active := True;
  {$ifdef LMD_DEBUG}
  FAllowLogLevel := LogAll;
  FDefaultLogLevel := LogDebug;
  {$else}
  FAllowLogLevel := LogFatal;
  FDefaultLogLevel := LogTrace;
  {$endif}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.SetCurrentBackgroundColor(const AColor: TColor);
begin
  FCurrentBackgroundColor := AColor;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.TransferMessage(ALogMsg: TLMDLogMessage);
var
  LRejected: Boolean;
begin
  if FFiltered then
    TriggerFilterMessage(ALogMsg, LRejected)
  else
    LRejected := False;
  if Assigned(FTransport) and (not LRejected) then
    FTransport.SendMsg(ALogMsg);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogCustomSession.GetName: WideString;
begin
  raise ELMDLogException.Create('This method must be overriden');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.SendCustomStream(ALogLevel: TLMDLogLevel; AName,
  AValue: TLMDString; AStream: TStream; AType: TLMDLogMessageType;
  ASubType: TLMDLogMessageSubType);
var
  LLogMsg: TLMDLogMessage;
begin
  if FAllowLogLevel.IsAllow(ALogLevel) then
  begin
    CreateMessage(LLogMsg);
    try
      LLogMsg.FLogLevel := ALogLevel.Value;
      LLogMsg.MessageType := AType;
      LLogMsg.MessageSubType.AsGUID := ASubType;
      if AName = '' then
        LLogMsg.Title := AValue
      else
        LLogMsg.Title := Format('%s=%s', [AName, AValue]);

      LLogMsg.BackgroundColor := FCurrentBackgroundColor;
      FCurrentBackgroundColor := clBlack;

      if Assigned(AStream) then
      begin
        AStream.Position := 0;
        LLogMsg.FStorage.CopyFrom(AStream, AStream.Size);
      end;

      TransferMessage(LLogMsg);
    finally
      // Should be deleted in transport after sending
      //DestroyMessage(LLogMsg);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.SendCustomFile(ALogLevel: TLMDLogLevel; AName,
  AValue: TLMDString; const AFileName: TLMDString; AType: TLMDLogMessageType;
  ASubType: TLMDLogMessageSubType);
var
  LStream: TLMDFileStream;
begin
  LStream := TLMDFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    SendCustomStream(ALogLevel, AName, AValue, LStream, AType, ASubType);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.SendCustomFile(AName, AValue: TLMDString;
  const AFileName: TLMDString; AType: TLMDLogMessageType;
  ASubType: TLMDLogMessageSubType);
var
  LStream: TLMDFileStream;
begin
  LStream := TLMDFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    SendCustomStream(FDefaultLogLevel, AName, AValue, LStream, AType, ASubType);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.SendCustomStream(AName, AValue: TLMDString;
  AStream: TStream; AType: TLMDLogMessageType; ASubType: TLMDLogMessageSubType);
begin
  SendCustomStream(FDefaultLogLevel, AName, AValue, AStream, AType, ASubType);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.SendCustomString(AName, AValue: TLMDString; AType: TLMDLogMessageType;
                                            ASubType: TLMDLogMessageSubType);
begin
  SendCustomString(FDefaultLogLevel, AName, AValue, AType, ASubType);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.SendCustomString(ALogLevel: TLMDLogLevel; AName,
  AValue: TLMDString; AType: TLMDLogMessageType; ASubType: TLMDLogMessageSubType);
begin
  SendCustomStream(ALogLevel, AName, AValue, nil, AType, ASubType);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.CreateMessage(var LLogMsg: TLMDLogMessage);
begin
  LLogMsg := TLMDLogMessage.Create;
  LLogMsg.FUserName := FUserName;
  LLogMsg.FComputerName := FComputerName;
  LLogMsg.FProcessId := FProcessId;
  LLogMsg.FAppName := FAppName;
  LLogMsg.FSessionName := FSessionName;
  LLogMsg.FDateTimeSent := Now;
  LLogMsg.FDateTimeReceived := Now;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDLogCustomSession.Destroy;
begin
  FTransport.Active := False;
  FTransport := nil;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSession.DestroyMessage(var LLogMsg: TLMDLogMessage);
begin
  FreeAndNil(LLogMsg);
end;

{ ******************************* TLMDLogSession ***************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.EnterMethod(AName: TLMDString);
begin
  SendCustomString('EnterMethod', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.EnterProcess(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString(ALogLevel, 'EnterProcess', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.EnterMethod(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString(ALogLevel, 'EnterMethod', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.EnterProcess(AName: TLMDString);
begin
  SendCustomString('EnterProcess', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.EnterThread(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString(ALogLevel, 'EnterThread', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.EnterThread(AName: TLMDString);
begin
  SendCustomString('EnterThread', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogSession.GetName: WideString;
begin
  // NB. Do not localize
  Result := 'lmd_general_session';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.LeaveMethod(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString(ALogLevel, 'LeaveMethod', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.LeaveMethod(AName: TLMDString);
begin
  SendCustomString('LeaveMethod', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.LeaveProcess(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString(ALogLevel, 'LeaveProcess', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.LeaveProcess(AName: TLMDString);
begin
  SendCustomString('LeaveProcess', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.LeaveThread(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString(ALogLevel, 'LeaveThread', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.LeaveThread(AName: TLMDString);
begin
  SendCustomString('LeaveThread', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.TimeMark(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString('TimeMark', AName, mtFlowMessage, mstProfiling);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.TimeMark(AName: TLMDString);
begin
  TimeMark(FDefaultLogLevel, AName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.TouchCounter(AName: TLMDString);
begin
  SendCustomString('TouchCounter', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.ReleaseCounter(AName: TLMDString);
begin
  SendCustomString('ReleaseCounter', AName, mtFlowMessage, mstFlowControl);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDLogSession.SendBinaryData(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Pointer; ASize: Integer);

var
  LMemStream: TMemoryStream;
begin
  LMemStream := TMemoryStream.Create;
  try
    LMemStream.Write(AValue^, ASize);
    SendCustomStream(ALogLevel, 'Binary', AName, LMemStream, mtDataMessage, mstBinary);
  finally
    LMemStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDLogSession.SendBinaryData(AName: TLMDString; AValue: Pointer; ASize: Integer);

begin
  SendBinaryData(FDefaultLogLevel, AName, AValue, ASize);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendBitmap(AName: TLMDString; AValue: TBitmap);
begin
  SendBitmap(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendBitmapFile(const ALogLevel: TLMDLogLevel;
  const AName, AFileName: TLMDString);
begin
  SendCustomFile(ALogLevel, 'Bitmap', AName, AFileName, mtDataMessage, mstImage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendBitmapFile(const AName, AFileName: TLMDString);
begin
  SendCustomFile(FDefaultLogLevel, 'Bitmap', AName, AFileName, mtDataMessage, mstImage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendBitmapStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AStream: TStream);
begin
  SendCustomStream(ALogLevel, 'Bitmap', AName, AStream, mtDataMessage, mstImage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendBitmapStream(const AName: TLMDString; AStream: TStream);
begin
  SendCustomStream(FDefaultLogLevel, 'Bitmap', AName, AStream, mtDataMessage, mstImage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendBitmap(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TBitmap);
var
  LMemStream: TMemoryStream;
begin
  LMemStream := TMemoryStream.Create;
  try
    AValue.SaveToStream(LMemStream);
    SendBitmapStream(ALogLevel, AName, LMemStream);
  finally
    LMemStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendCurrency(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Currency);
begin
  SendCustomString(ALogLevel, AName, Format('%m', [AValue]), mtDataMessage, mstCurrency);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendCurrency(AName: TLMDString; AValue: Currency);
begin
  SendCustomString(AName, Format('%m', [AValue]), mtDataMessage, mstCurrency);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendDate(AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(AName, DateToStr(AValue), mtDataMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendDate(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(ALogLevel, AName, DateToStr(AValue), mtDataMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendDateTime(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(ALogLevel, AName, DateTimeToStr(AValue), mtDataMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendDateTime(AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(AName, DateTimeToStr(AValue), mtDataMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendDesktopScreenshot(ALogLevel: TLMDLogLevel);
begin
  SendScreenShot(ALogLevel, 'Current desktop', 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendDesktopScreenshot;
begin
  SendScreenShot('Current desktop', 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendException(AException: Exception);
begin
  SendCustomString(LogError, AException.ClassName, AException.Message, mtDataMessage, mstException);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendEnum(ALogLevel: TLMDLogLevel; const AName: TLMDString; ATypeInfo: PTypeInfo; const AValue: Integer);
begin
  SendCustomString(ALogLevel, AName, GetEnumName(ATypeInfo, AValue), mtDataMessage, mstEnum);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendEnum(const AName: TLMDString; ATypeInfo: PTypeInfo; const AValue: Integer);
begin
  SendCustomString(FDefaultLogLevel, AName, GetEnumName(ATypeInfo, AValue), mtDataMessage, mstEnum);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendError(AError: TLMDString);
begin
  SendCustomString(LogError, 'Error', AError, mtDataMessage, mstError);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendFormatString(ALogLevel: TLMDLogLevel; AName,
  AFormat: TLMDString; AValues: array of const);
begin
  SendCustomString(ALogLevel, AName, Format(AFormat, AValues), mtDataMessage, mstString);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendFatal(AError: TLMDString);
begin
  SendCustomString(LogFatal, 'Fatal', AError, mtDataMessage, mstFatal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendFormatString(AName, AFormat: TLMDString;
  AValues: array of const);
begin
  SendFormatString(FDefaultLogLevel, AName, AFormat, AValues);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHResult(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: HResult);
begin
  SendCustomString(ALogLevel, AName, SysErrorMessage(AValue), mtDataMessage, mstError);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHResult(AName: TLMDString; AValue: HResult);
begin
  SendHResult(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendInteger(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Integer);
begin
  SendCustomString(ALogLevel, AName, IntToStr(AValue), mtDataMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendInteger(AName: TLMDString; AValue: Integer);
begin
  SendCustomString(AName, IntToStr(AValue), mtDataMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendLastOSError(ALogLevel: TLMDLogLevel; AName: TLMDString; ALastError: Integer);
begin
  SendCustomString(ALogLevel, AName, SysErrorMessage(ALastError), mtDataMessage, mstError);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendLastOSError(AName: TLMDString; ALastError: Integer);
begin
  SendCustomString(AName, SysErrorMessage(ALastError), mtDataMessage, mstError);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendLastOSError(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendLastOSError(ALogLevel, AName, GetLastError);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendLastOSError(AName: TLMDString);
begin
  SendLastOSError(AName, GetLastError);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendMetafile(const ALogLevel: TLMDLogLevel; const AName: TLMDString;
  AValue: TMetafile);
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    AValue.SaveToStream(LStream);
    SendMetafileStream(ALogLevel, AName, LStream);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendMetafile(const AName: TLMDString; AValue: TMetafile);
begin
  SendMetafile(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendMetafileFile(const ALogLevel: TLMDLogLevel; const AName,
  AFileName: TLMDString);
var
  LStream: TLMDFileStream;
begin
  LStream := TLMDFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    SendMetafileStream(ALogLevel, AName, LStream);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendMetafileFile(const AName, AFileName: TLMDString);
begin
  SendMetafileFile(FDefaultLogLevel, AName, AFileName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendMetafileStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString;
  AStream: TStream);
begin
  SendCustomStream(ALogLevel, 'Metafile', AName, AStream, mtDataMessage, mstImage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendMetafileStream(const AName: TLMDString; AStream: TStream);
begin
  SendMetafileStream(FDefaultLogLevel, AName, AStream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendBoolean(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Boolean);
begin
  SendCustomString(AName, BoolToStr(AValue, True), mtDataMessage, mstBoolean);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendBoolean(AName: TLMDString; AValue: Boolean);
begin
  SendBoolean(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
// Khamov add
procedure TLMDLogSession.SendComment(AValue: TLMDString);
begin
  SendComment(FDefaultLogLevel, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendCanvas(ALogLevel: TLMDLogLevel; AName: TLMDString;
  const ACanvas: TCanvas; const ARect: TRect);
var
  LBitmap: TBitmap;
begin
  LBitmap := TBitmap.Create;
  try
    LBitmap.Width := ARect.Right - ARect.Left;
    LBitmap.Height := ARect.Bottom - ARect.Top;
    LBitmap.Canvas.CopyRect(Rect(0, 0, LBitmap.Width, LBitmap.Height), ACanvas, ARect);
    SendBitmap(ALogLevel, AName, LBitmap);
  finally
    LBitmap.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendCanvas(AName: TLMDString; const ACanvas: TCanvas; const ARect: TRect);
begin
  SendCanvas(FDefaultLogLevel, AName, ACanvas, ARect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendComment(ALogLevel: TLMDLogLevel; AValue: TLMDString);
begin
  SendCustomString(ALogLevel, 'Comment', AValue, mtDataMessage, mstComment);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.CreateCounter(AName: TLMDString);
begin
  CreateCounter(FDefaultLogLevel, AName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.CreateCounter(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString('CreateCounter', AName, mtFlowMessage, mstCounter)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.DeleteCounter(AName: TLMDString);
begin
  DeleteCounter(FDefaultLogLevel, AName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.DeleteCounter(ALogLevel: TLMDLogLevel; AName: TLMDString);
begin
  SendCustomString(ALogLevel, 'DeleteCounter', AName, mtFlowMessage, mstCounter);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.IncCounter(AName: TLMDString; ADelta: Integer = 1);
begin
  IncCounter(FDefaultLogLevel, AName, ADelta);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.IncCounter(ALogLevel: TLMDLogLevel; AName: TLMDString; ADelta: Integer = 1);
begin
  SendCustomString(ALogLevel, AName, IntToStr(ADelta), mtFlowMessage, mstIncCounter);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.DecCounter(AName: TLMDString; ADelta: Integer = 1);
begin
  DecCounter(FDefaultLogLevel, AName, ADelta);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.DecCounter(ALogLevel: TLMDLogLevel; AName: TLMDString; ADelta: Integer = 1);
begin
  SendCustomString(ALogLevel, AName, IntToStr(ADelta), mtFlowMessage, mstDecCounter);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendImageList(ALogLevel: TLMDLogLevel; AName: TLMDString;
  AImageList: TImageList; const AFromIndex, AToIndex: Integer);
var
  LMemStream: TMemoryStream;
  i: Integer;
  LBitmap: TBitmap;
  LByte: Byte;
  LColor: TColor;
  LFromIndex: Integer;
  LToIndex: Integer;
begin
  if not Assigned(AImageList) then exit;
  LMemStream := TMemoryStream.Create;

  LColor := AImageList.BlendColor;
  LMemStream.Write(LColor, SizeOf(TColor));

  LColor := AImageList.BkColor;
  LMemStream.Write(LColor, SizeOf(TColor));

  i := AImageList.Width;
  LMemStream.WriteBuffer(i, SizeOf(Integer));
  i := AImageList.Height;
  LMemStream.WriteBuffer(i, SizeOf(Integer));
  LByte := Byte(AImageList.ImageType);
  LMemStream.Write(LByte, SizeOf(Byte));
  LByte := Byte(AImageList.Masked);
  LMemStream.Write(LByte, SizeOf(Byte));
  LByte := Byte(AImageList.ShareImages);
  LMemStream.Write(LByte, SizeOf(Byte));
  i := AImageList.Count;
  LMemStream.WriteBuffer(i, SizeOf(Integer));

  if AFromIndex < 0 then
    LFromIndex := 0
  else
    LFromIndex := AFromIndex;

  if AToIndex >= AImageList.Count then
    LToIndex := AImageList.Count - 1
  else
    LToIndex := AToIndex;

  for i := LFromIndex to LToIndex do
  begin
    LBitmap := TBitmap.Create;
    LBitmap.Width := AImageList.Width;
    LBitmap.Height := AImageList.Height;
    AImageList.GetBitmap(i, LBitmap);
    LBitmap.SaveToStream(LMemStream);
    LBitmap.Free;
  end;
  SendCustomStream(ALogLevel, 'ImageList', AName, LMemStream, mtDataMessage, mstImageList);
  LMemStream.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendImageList(AName: TLMDString; AImageList: TImageList; const AFromIndex,
  AToIndex: Integer);
begin
  SendImageList(FDefaultLogLevel, AName, AImageList, AFromIndex, AToIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendImageList(ALogLevel: TLMDLogLevel; AName: TLMDString; AImageList: TImageList);
begin
  SendImageList(ALogLevel, AName, AImageList, 0, AImageList.Count - 1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendImageList(AName: TLMDString; AImageList: TImageList);
begin
  SendImageList(FDefaultLogLevel, AName, AImageList);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendComponentAsText(AName: TLMDString; AComponent: TComponent);
begin
  SendComponentAsText(FDefaultLogLevel, AName, AComponent);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendComponentAsText(ALogLevel: TLMDLogLevel; AName: TLMDString; AComponent: TComponent);
var
  LMemCompStream,
  LOutTextStream: TMemoryStream;
begin
  LMemCompStream := TMemoryStream.Create;
  LOutTextStream := TMemoryStream.Create;
  LMemCompStream.WriteComponent(AComponent);
  LMemCompStream.Position := 0;
  ObjectBinaryToText(LMemCompStream, LOutTextStream);
  SendCustomStream(ALogLevel, 'Component', AName, LOutTextStream, mtDataMessage, mstComponentAsText);
  LMemCompStream.Free;
  LOutTextStream.Free
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: TLMDString);
begin
  if AExpr then
    SendString(ALogLevel, AName, AIfTrue)
  else
    SendString(ALogLevel, AName, AIfFalse)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: TLMDString);
begin
  SendIfThen(FDefaultLogLevel, AName, AExpr, AIfTrue, AIfFalse);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Integer);
begin
  if AExpr then
    SendInteger(ALogLevel, AName, AIfTrue)
  else
    SendInteger(ALogLevel, AName, AIfFalse)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Integer);
begin
  SendIfThen(FDefaultLogLevel, AName, AExpr, AIfTrue, AIfFalse);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Real);
begin
  if AExpr then
    SendFloat(ALogLevel, AName, AIfTrue)
  else
    SendFloat(ALogLevel, AName, AIfFalse)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Real);
begin
  SendIfThen(FDefaultLogLevel, AName, AExpr, AIfTrue, AIfFalse);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: TObject);
begin
  if AExpr then
    SendObject(ALogLevel, AName, AIfTrue)
  else
    SendObject(ALogLevel, AName, AIfFalse)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: TObject);
begin
  SendIfThen(FDefaultLogLevel, AName, AExpr, AIfTrue, AIfFalse);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Boolean);
begin
  SendIfThen(FDefaultLogLevel, AName, AExpr, AIfTrue, AIfFalse);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: Integer);
begin
  if AExpr then
    SendInteger(FDefaultLogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean;
  AIfTrue: Real);
begin
  if AExpr then
    SendFloat(ALogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean;
  AIfTrue: Integer);
begin
  if AExpr then
    SendInteger(ALogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHtml(const AName: TLMDString; const AValue: TLMDString);
begin
  SendHtml(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHtmlFile(const ALogLevel: TLMDLogLevel;
  const AName, AFileName: TLMDString);
begin
  SendCustomFile(ALogLevel, 'HTML', AName, AFileName, mtDataMessage, mstHTML);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHtmlFile(const AName, AFileName: TLMDString);
begin
  SendCustomFile(FDefaultLogLevel, 'HTML', AName, AFileName, mtDataMessage, mstHTML);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHtmlStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AStream: TStream);
begin
  SendCustomStream(ALogLevel, 'HTML', AName, AStream, mtDataMessage, mstHTML);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHtmlStream(const AName: TLMDString; AStream: TStream);
begin
  SendCustomStream(FDefaultLogLevel, 'HTML', AName, AStream, mtDataMessage, mstHTML);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHtml(const ALogLevel: TLMDLogLevel; const AName: TLMDString; const AValue: TLMDString);
var
  LMemStream: TMemoryStream;
begin
  LMemStream := TMemoryStream.Create;
  try
    LMDStringToStream(AValue, LMemStream);
    SendHtmlStream(ALogLevel, AName, LMemStream);
  finally
    LMemStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean; AIfTrue: TLMDString);
begin
  if AExpr then
    SendString(ALogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: TLMDString);
begin
  if AExpr then
    SendString(FDefaultLogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr, AIfTrue: Boolean);
begin
  if AExpr then
    SendBoolean(ALogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIcon(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AValue: TIcon);
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    AValue.SaveToStream(LStream);
    SendIconStream(ALogLevel, AName, LStream);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIcon(const AName: TLMDString; AValue: TIcon);
begin
  SendIcon(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIconFile(const ALogLevel: TLMDLogLevel; const AName,
  AFileName: TLMDString);
var
  LStream: TLMDFileStream;
begin
  LStream := TLMDFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    SendIconStream(ALogLevel, AName, LStream);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIconFile(const AName, AFileName: TLMDString);
begin
  SendIconFile(FDefaultLogLevel, AName, AFileName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIconStream(const ALogLevel: TLMDLogLevel; const AName: TLMDString;
  AStream: TStream);
begin
  SendCustomStream(ALogLevel, 'Icon', AName, AStream, mtDataMessage, mstImage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIconStream(const AName: TLMDString; AStream: TStream);
begin
  SendCustomStream(FDefaultLogLevel, 'Icon', AName, AStream, mtDataMessage, mstImage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(AName: TLMDString; AExpr, AIfTrue: Boolean);
begin
  if AExpr then
    SendBoolean(FDefaultLogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: TObject);
begin
  if AExpr then
    SendObject(FDefaultLogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(AName: TLMDString; AExpr: boolean; AIfTrue: Real);
begin
  if AExpr then
    SendFloat(FDefaultLogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIf(ALogLevel: TLMDLogLevel; AName: TLMDString; AExpr: boolean;
  AIfTrue: TObject);
begin
  if AExpr then
    SendObject(ALogLevel, AName, AIfTrue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendIfThen(AName: TLMDString; AExpr: boolean; AIfTrue, AIfFalse: Boolean);
begin
  if AExpr then
    SendBoolean(FDefaultLogLevel, AName, AIfTrue)
  else
    SendBoolean(FDefaultLogLevel, AName, AIfFalse)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendAssigned(AName: TLMDString; APointer: Pointer);
begin
  SendAssigned(FDefaultLogLevel, AName, APointer);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendAssigned(ALogLevel: TLMDLogLevel; AName: TLMDString; APointer: Pointer);
begin
  SendBoolean(ALogLevel, 'Assined(' + AName + ')', Assigned(APointer));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendProperty(ALogLevel: TLMDLogLevel; AName: TLMDString; AObject: TObject; APropName: TLMDString);
var
  LPropInfo: PPropInfo;
begin
  LPropInfo := GetPropInfo(AObject, APropName, [tkInteger, tkChar, tkEnumeration, tkFloat,
    tkString, tkClass, tkWChar, tkLString, tkWString, tkInt64]);
  if LPropInfo = nil then
    exit;
  case LPropInfo^.PropType^.Kind of
    tkString,
    tkWChar,
    tkLString,
    tkWString:
      SendString(ALogLevel, AName, GetStrProp(AObject, APropName));
    tkClass:
      SendObject(ALogLevel, AName, TObject(Pointer(GetOrdProp(AObject, APropName))));
      tkInteger,
    tkInt64:
      SendInteger(ALogLevel, AName, GetOrdProp(AObject, APropName));
    tkEnumeration:
      SendEnum(ALogLevel, AName, LPropInfo.PropType^, GetOrdProp(AObject, APropName));
    tkSet:
      SendSet(ALogLevel, AName, LPropInfo.PropType^, GetOrdProp(AObject, APropName));
    tkFloat:
      SendFloat(ALogLevel, AName, GetFloatProp(AObject, APropName));
    // TODO: Continue with other tk* consts
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendProperty(AName: TLMDString; AObject: TObject; APropName: TLMDString);
begin
  SendProperty(FDefaultLogLevel, AName, AObject, APropName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHeapStatus(ALogLevel: TLMDLogLevel; AName: TLMDString);
var
  LHeapStatus: THeapStatus;

  LIni: TLMDMemIniFile;
  LIniCtr: TLMDIniCtrl;
  LMemStream: TMEmoryStream;
  LStr: TStringList;
begin
  LHeapStatus := GetHeapStatus();

  LIniCtr := TLMDIniCtrl.Create(nil);
  try
    LIniCtr.Target := itMemIniFile;
    LIni := LIniCtr.MemIniFile;
    LIni.WriteInteger('Heap Status', 'TotalAddrSpace', LHeapStatus.TotalAddrSpace);
    LIni.WriteInteger('Heap Status', 'TotalUncommitted', LHeapStatus.TotalUncommitted);
    LIni.WriteInteger('Heap Status', 'TotalCommitted', LHeapStatus.TotalCommitted);
    LIni.WriteInteger('Heap Status', 'TotalAllocated', LHeapStatus.TotalAllocated);
    LIni.WriteInteger('Heap Status', 'TotalFree', LHeapStatus.TotalFree);
    LIni.WriteInteger('Heap Status', 'FreeSmall', LHeapStatus.FreeSmall);
    LIni.WriteInteger('Heap Status', 'FreeBig', LHeapStatus.FreeBig);
    LIni.WriteInteger('Heap Status', 'Unused', LHeapStatus.Unused);
    LIni.WriteInteger('Heap Status', 'Overhead', LHeapStatus.Overhead);
    LIni.WriteInteger('Heap Status', 'HeapErrorCode', LHeapStatus.HeapErrorCode);

    LStr := TStringList.Create;
    try
      LMemStream := TMemoryStream.Create;
      LStr.Clear;
      try
        LIni.GetStrings(LStr);
        LStr.SaveToStream(LMemStream);
        SendCustomStream(ALogLevel, 'Heap Status', AName, LMemStream, mtDataMessage, mstObject);
      finally
        LMemStream.Free;
      end;
    finally
      LStr.Free;
    end;
  finally
    LIniCtr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHDC(ALogLevel: TLMDLogLevel; AName: TLMDString; const AHDC: HDC;
  const ARect: TRect);
var
  LBitmap: TBitmap;
begin
  LBitmap := TBitmap.Create;
  try
    LBitmap.Width := ARect.Right - ARect.Left;
    LBitmap.Height := ARect.Bottom - ARect.Top;
    BitBlt(LBitmap.Canvas.Handle, 0, 0, LBitmap.Width, LBitmap.Height, AHDC, ARect.Left, ARect.Top,
           SRCCOPY);
    SendBitmap(ALogLevel, AName, LBitmap);
  finally
    LBitmap.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHDC(AName: TLMDString; const AHDC: HDC; const ARect: TRect);
begin
  SendHDC(FDefaultLogLevel, AName, AHDC, ARect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendHeapStatus(AName: TLMDString);
begin
  SendHeapStatus(FDefaultLogLevel, AName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendWindowInfo(ALogLevel: TLMDLogLevel; AName: TLMDString; AHandle: THandle);
var
  LWindowRect: TRect;
  LWindowInfo: TWindowInfo;
  LIni: TLMDMemIniFile;
  LIniCtr: TLMDIniCtrl;
  LMemStream: TMemoryStream;
  LStr: TStringList;
  LStrArray: array [0..255] of Char;
  hHandle: THandle;
  LChildNo: Integer;
  LTemp: array[0..255] of TLMDChar;
  LLen: Integer;
  LCaption: TLMDString;

begin
  GetWindowRect(AHandle, LWindowRect);
  GetWindowInfo(AHandle, LWindowInfo);
  {$IFDEF LMD_UNICODE}
  LLen := GetWindowTextW(AHandle, LTemp, SizeOf(LTemp));
  {$ELSE}
  LLen := GetWindowTextA(AHandle, LTemp, SizeOf(LTemp));
  {$ENDIF}
  LCaption := Copy(LTemp, 0, LLen);
  LIniCtr := TLMDIniCtrl.Create(nil);
  try
    LIniCtr.Target := itMemIniFile;
    LIni := LIniCtr.MemIniFile;
    LIni.WriteString('Window text', 'Text', LCaption);
    LIni.WriteInteger('Window Rect', 'Top', LWindowInfo.rcWindow.Top);
    LIni.WriteInteger('Window Rect', 'Left', LWindowInfo.rcWindow.Left);
    LIni.WriteInteger('Window Rect', 'Bottom', LWindowInfo.rcWindow.Bottom);
    LIni.WriteInteger('Window Rect', 'Right', LWindowInfo.rcWindow.Right);

    LIni.WriteInteger('Window Client Rect', 'Top', LWindowInfo.rcClient.Top);
    LIni.WriteInteger('Window Client Rect', 'Left', LWindowInfo.rcClient.Left);
    LIni.WriteInteger('Window Client Rect', 'Bottom', LWindowInfo.rcClient.Bottom);
    LIni.WriteInteger('Window Client Rect', 'Right', LWindowInfo.rcClient.Right);

    LIni.WriteString('Style', 'Style', LMDWindowsStyleToString(LWindowInfo.dwStyle));
    LIni.WriteString('Style', 'Extended Style', LMDWindowExStyleToString(LWindowInfo.dwExStyle));
    LIni.WriteInteger('Style', 'Other Stuff', LWindowInfo.dwOtherStuff);

    LIni.WriteInteger('Borders', 'x', LWindowInfo.cxWindowBorders);
    LIni.WriteInteger('Borders', 'y', LWindowInfo.cyWindowBorders);

    LIni.WriteInteger('Creator', 'Creator Version', LWindowInfo.wCreatorVersion);

    hHandle := GetWindow(AHandle, GW_CHILD);
    hHandle := GetWindow(hHandle, GW_HWNDFIRST);
    LChildNo := 0;
    while hHandle > 0 do
    begin
      Inc(LChildNo);
      RealGetWindowClass(hHandle, LStrArray, 255);
      LIni.WriteString('Child Window ' + IntToStr(LChildNo), 'Class', Trim(LStrArray));
      GetWindowText(hHandle, LStrArray, 255);
      LIni.WriteString('Child Window ' + IntToStr(LChildNo), 'Content', Trim(LStrArray));
      hHandle := GetWindow(hHandle, GW_HWNDNEXT);
    end;

    LStr := TStringList.Create;
    try
      LMemStream := TMemoryStream.Create;
      LStr.Clear;
      try
        LIni.GetStrings(LStr);
        LStr.SaveToStream(LMemStream);
        SendCustomStream(ALogLevel, 'Window Details', AName, LMemStream, mtDataMessage, mstObject);
      finally
        LMemStream.Free;
      end;
    finally
      LStr.Free;
    end;
  finally
    LIniCtr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendWindowInfo(AName: TLMDString; AHandle: THandle);
begin
  SendWindowInfo(FDefaultLogLevel, AName, AHandle);
end;
{/AIH}

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendWindowMessage(AMessage: Cardinal; AWParam: WPARAM;
  ALParam: LPARAM);
begin
  SendWindowMessage(FDefaultLogLevel, AMessage, AWParam, ALParam);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendWindowMessage(ALogLevel: TLMDLogLevel;
  AMessage: Cardinal; AWParam: WPARAM; ALParam: LPARAM);
begin
   SendCustomString(ALogLevel, 'Message',
                      Format('Message: %s, WPARAM: %d, LPARAM: %d',
                             [LMDMessageToStr(AMessage), AWParam, ALParam]),
                      mtDataMessage,
                      mstMessage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendWindowMessage(AMessage: Cardinal);
begin
  SendWindowMessage(FDefaultLogLevel, AMessage);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendWindowMessage(ALogLevel: TLMDLogLevel; AMessage: Cardinal);
begin
  SendWindowMessage(ALogLevel, AMessage, 0, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendObject(ALogLevel: TLMDLogLevel; AName: TLMDString; AInstance: TObject);
var
  LIni: TLMDMemIniFile;
  LIniCtr: TLMDIniCtrl;
  LStr: TStringList;
  LMemStream: TMEmoryStream;
begin
  LIniCtr := TLMDIniCtrl.Create(nil);
  try
    LIniCtr.Target := itMemIniFile;
    LIniCtr.WriteObject(AName, AInstance);
    LIni := LIniCtr.MemIniFile;
    LStr := TStringList.Create;
    try
      LMemStream := TMemoryStream.Create;
      try
        LIni.GetStrings(LStr);
        LStr.SaveToStream(LMemStream);
        SendCustomStream(ALogLevel, 'Object', AName, LMemStream, mtDataMessage, mstObject);
      finally
        LMemStream.Free;
      end;
    finally
      LStr.Free;
    end;
  finally
    LIniCtr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendObject(AName: TLMDString; AInstance: TObject);
begin
  SendObject(FDefaultLogLevel, AName, AInstance);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendPoint(const ALogLevel: TLMDLogLevel; const AName: TLMDString; AValue: TPoint);
begin
  SendCustomString(ALogLevel, AName, Format('(X: %d, Y: %d)', [AValue.X, AValue.Y]), mtDataMessage, mstPoint);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendPoint(const AName: TLMDString; AValue: TPoint);
begin
  SendPoint(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendPointer(ALogLevel: TLMDLogLevel; AName: TLMDString;
  AValue: Pointer);
begin
  SendCustomString(ALogLevel, AName, '$' + IntToHex(Integer(AValue), SizeOf(Pointer) * 2),
    mtDataMessage, mstPointer);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendPointer(AName: TLMDString; AValue: Pointer);
begin
  SendPointer(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendFloat(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Extended);
begin
  SendCustomString(ALogLevel, AName, FloatToStr(AValue), mtDataMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendFloat(AName: TLMDString; AValue: Extended);
begin
  SendCustomString(AName, FloatToStr(AValue), mtDataMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendRect(AName: TLMDString; AValue: TRect);
begin
  SendRect(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendRect(ALogLevel: TLMDLogLevel; AName: TLMDString;
  AValue: TRect);
begin
  SendCustomString(ALogLevel, AName, Format('(Left: %d, Top: %d, Right: %d, Bottom: %d)',
       [AValue.Left, AValue.Top, AValue.Right, AValue.Bottom]), mtDataMessage, mstRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendScreenShot(ALogLevel: TLMDLogLevel; AName: TLMDString; AWindow: THandle);
var
  LDC: HDC;
  LRect: TRect;
  LBitmap: TBitmap;
begin
  LBitmap := TBitmap.Create;
  try
    if AWindow = 0 then
      SystemParametersInfo(SPI_GETWORKAREA, 0, @LRect, 0)
    else
      GetWindowRect(AWindow, LRect);
    LBitmap.Width := LRect.Right - LRect.Left;
    LBitmap.Height := LRect.Bottom - LRect.Top;
    LBitmap.PixelFormat := pf24bit;
//    if not LMDPrintWindow(AWindow, LBitmap.Canvas.Handle, 0) then
    begin
      if AWindow = 0 then
        LDC := GetDC(0)
      else
        LDC := GetWindowDC(AWindow);
      BitBlt(LBitmap.Canvas.Handle, 0, 0, LBitmap.Width, LBitmap.Height, LDC, 0, 0, SRCCOPY);
    end;
    SendBitmap(ALogLevel, AName, LBitmap);
  finally
    LBitmap.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendScreenShot(AName: TLMDString; AWindow: THandle);
begin
  SendScreenShot(FDefaultLogLevel, AName, AWindow);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSeparator;
begin
  SendCustomString(FDefaultLogLevel, '-', '-', mtControlMessage, mstCommand);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSet(ALogLevel: TLMDLogLevel; const AName: TLMDString; ATypeInfo: PTypeInfo;
  const AValue: Integer);
begin
  SendCustomString(ALogLevel, AName, LMDSetToString(ATypeInfo, AValue, True), mtDataMessage, mstSet);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSet(const AName: TLMDString; ATypeInfo: PTypeInfo; const AValue: Integer);
begin
  SendCustomString(FDefaultLogLevel, AName, LMDSetToString(ATypeInfo, AValue, True), mtDataMessage, mstSet);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSourceCode(ALogLevel: TLMDLogLevel; AName: TLMDString;
  AValue: TLMDString; const ASyntaxScheme: TLMDString);
var
  LMemStream: TMemoryStream;
  {$IFDEF LMD_UNICODE}
  LTarget: AnsiString;
  {$ENDIF}
begin
  LMemStream := TMemoryStream.Create;
  try
    {$ifdef LMD_UNICODE}
    LMDConvertUTF16toUTF8(AValue, LTarget, strictConversion, True);
    LMDAnsiStringToStream(LTarget, LMemStream);
    {$else}
    LMDStringToStream(AValue, LMemStream);
    {$endif}
    SendCustomStream(ALogLevel, AName, ASyntaxScheme, LMemStream, mtDataMessage, mstSourceCode);
  finally
    LMemStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSourceCode(AName: TLMDString; AValue: TLMDString; const ASyntaxScheme: TLMDString);
begin
  SendSourceCode(FDefaultLogLevel, AName, AValue, ASyntaxScheme);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSourceCodeFile(const ALogLevel: TLMDLogLevel; const AName,
  ASyntaxScheme: TLMDString; const AFileName: TLMDString);
var
  LStream: TLMDFileStream;
begin
  LStream := TLMDFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    SendSourceCodeStream(ALogLevel, AName, ASyntaxScheme, LStream);
  finally
    LStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSourceCodeFile(const AName, ASyntaxScheme: TLMDString;
  const AFileName: TLMDString);
begin
  SendSourceCodeFile(FDefaultLogLevel, AName, ASyntaxScheme, AFileName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSourceCodeStream(const ALogLevel: TLMDLogLevel;
  const AName: TLMDString; const ASyntaxScheme: TLMDString; AStream: TStream);
begin
  SendCustomStream(ALogLevel, AName, ASyntaxScheme, AStream, mtDataMessage, mstSourceCode);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSourceCodeStream(const AName: TLMDString; const ASyntaxScheme: TLMDString;
  AStream: TStream);
begin
  SendCustomStream(FDefaultLogLevel, AName, ASyntaxScheme, AStream, mtDataMessage, mstSourceCode);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSql(const ALogLevel: TLMDLogLevel; const AName, AValue: TLMDString);
begin
  SendSourceCode(ALogLevel, AName, AValue, 'SQL');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSql(const AName, AValue: TLMDString);
begin
  SendSql(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendString(ALogLevel: TLMDLogLevel; AName, AValue: TLMDString);
begin
  SendCustomString(ALogLevel, AName, AValue, mtDataMessage, mstString);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendString(AName: TLMDString; AValue: TLMDString);
begin
  SendCustomString(AName, AValue, mtDataMessage, mstString);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendStringList(const AName: TLMDString; AValue: TStrings);
begin
  SendStringList(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendStringList(ALogLevel: TLMDLogLevel;
  const AName: TLMDString; AValue: TStrings);
var
  LMemSteam: TMemoryStream;
begin
  LMemSteam := TMemoryStream.Create;
  try
    AValue.SaveToStream(LMemSteam);
    SendCustomStream(ALogLevel, 'StringList', AName, LMemSteam, mtDataMessage, mstStringList);
  finally
    LMemSteam.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSystemInformation(ALogLevel: TLMDLogLevel);
var
  LIni: TLMDMemIniFile;
  LStr: TStringList;
  LMemStream: TMemoryStream;
begin
  LIni := TLMDMemIniFile.Create('');
  try
    {$IFDEF LMDCOMP6}
    LIni.WriteFloat('Delphi information', 'CompilerVersion', CompilerVersion);
    LIni.WriteFloat('Delphi information', 'RTLVersion', RTLVersion);
    {$ELSE}
    // Delphi 5
    LIni.WriteFloat('Delphi information', 'CompilerVersion', 13.0);
    LIni.WriteFloat('Delphi information', 'RTLVersion', 13.0);
    {$ENDIF}
    LIni.WriteString('OS Information', 'Platform', LMDSIVersionString);
    LIni.WriteString('OS Information', 'Version', Format('%d.%d.%d', [LMDSIMajorVersionNr, LMDSIMinorVersionNr, LMDSIBuildNr]));
    LIni.WriteInteger('Memory information', 'Total physical memory (Kb)', LMDSIMemTotal);
    LIni.WriteInteger('Memory information', 'Free physical memory (Kb)', LMDSIMemFree);
    LIni.WriteInteger('Memory information', 'Total paging file (Kb)', LMDSIMemPageTotal);
    LIni.WriteInteger('Memory information', 'Free paging file (Kb)', LMDSIMemPageFree);
    LIni.WriteInteger('Memory information', 'Total virtual memory (Kb)', LMDSIMemVirtTotal);
    LIni.WriteInteger('Memory information', 'Free virtual memory (Kb)', LMDSIMemVirtFree);
    LIni.WriteInteger('Memory information', 'Memory in use (%)', LMDSIMemLoaded);

    LStr := TStringList.Create;
    try
      LIni.GetStrings(LStr);
      LMemStream := TMemoryStream.Create;
      try
        LStr.SaveToStream(LMemStream);
        SendCustomStream(ALogLevel, '', 'System Information', LMemStream, mtDataMessage, mstInformation);
      finally
        LMemStream.Free;
      end;
    finally
      LStr.Free;
    end;

  finally
    LIni.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendSystemInformation;
begin
  SendSystemInformation(FDefaultLogLevel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendTime(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(ALogLevel, AName, TimeToStr(AValue), mtDataMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendTime(AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(AName, TimeToStr(AValue), mtDataMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.SendWarning(AWarning: TLMDString);
begin
  SendCustomString(LogWarning, 'Warning', AWarning, mtDataMessage, mstWarning);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchBoolean(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Boolean);
begin
  SendCustomString(AName, BoolToStr(AValue, True), mtWatchMessage, mstBoolean);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchBoolean(AName: TLMDString; AValue: Boolean);
begin
  WatchBoolean(FDefaultLogLevel, AName, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchCurrency(AName: TLMDString; AValue: Currency);
begin
  SendCustomString(AName, Format('%m', [AValue]), mtWatchMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchCurrency(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Currency);
begin
  SendCustomString(ALogLevel, AName, Format('%m', [AValue]), mtWatchMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchDate(AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(AName, DateToStr(AValue), mtWatchMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchDateTime(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(ALogLevel, AName, DateTimeToStr(AValue), mtWatchMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchDateTime(AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(AName, DateTimeToStr(AValue), mtWatchMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchFormatString(ALogLevel: TLMDLogLevel; AName,
  AFormat: TLMDString; AValues: array of const);
begin
  SendCustomString(ALogLevel, AName, Format(AFormat, AValues), mtWatchMessage, mstString);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchFormatString(AName, AFormat: TLMDString;
  AValues: array of const);
begin
  WatchFormatString(FDefaultLogLevel, AName, AFormat, AValues);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchDate(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(ALogLevel, AName, DateToStr(AValue), mtWatchMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchInteger(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Integer);
begin
  SendCustomString(ALogLevel, AName, IntToStr(AValue), mtWatchMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchInteger(AName: TLMDString; AValue: Integer);
begin
  SendCustomString(AName, IntToStr(AValue), mtWatchMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchFloat(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: Extended);
begin
  SendCustomString(ALogLevel, AName, FloatToStr(AValue), mtWatchMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchFloat(AName: TLMDString; AValue: Extended);
begin
  SendCustomString(AName, FloatToStr(AValue), mtWatchMessage, mstNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchString(ALogLevel: TLMDLogLevel; AName, AValue: TLMDString);
begin
  SendCustomString(ALogLevel, AName, AValue, mtWatchMessage, mstString);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchString(AName, AValue: TLMDString);
begin
  SendCustomString(AName, AValue, mtWatchMessage, mstString);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchTime(ALogLevel: TLMDLogLevel; AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(ALogLevel, AName, TimeToStr(AValue), mtWatchMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.WatchTime(AName: TLMDString; AValue: TDateTime);
begin
  SendCustomString(AName, TimeToStr(AValue), mtWatchMessage, mstDateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.ClearCallStack;
begin
  SendCustomString('Command', 'ClearCallStack', mtControlMessage, mstCommand);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.ClearLog;
begin
  SendCustomString('Command', 'ClearLog', mtControlMessage, mstCommand);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogSession.ClearWatch;
begin
  SendCustomString('Command', 'ClearWatch', mtControlMessage, mstCommand);
end;

{***************************** TLMDLogManager *********************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDLogManager.Create;
begin
  inherited;
  FSessionList := TLMDObjectList.Create;
  FSessionList.AutoClearObjects := True;
  FTransportList := TLMDObjectList.Create;

  FSessionClasses := TLMDObjectList.Create;
  FTransportClasses := TLMDObjectList.Create;
  FLogLevelList := TLMDObjectList.Create;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogManager.ParseConnectString(const ASessionConnectString: TLMDString;
  var ASessionName, ASessionType, ATransportType: TLMDString;
  var ATransportParams: TLMDMemoryStrings);
var
  LParams: TLMDMemoryStrings;
begin
  LParams := TLMDMemoryStrings.Create;
  try
    try
      LMDSplitRegExpr(LMDQuoteRegExprMetaChars(CMSeparator), ASessionConnectString, LParams);
      ASessionName := LParams[0];
      ASessionType := LParams[1];
      ATransportType := LParams[2];
      LMDSplitRegExpr(LMDQuoteRegExprMetaChars(CPSeparator), LParams[3], LParams);
      ATransportParams.Assign(LParams);
    except
      raise ELMDLogException.CreateFmt('Error parsing "%s" connect string', [ASessionConnectString]);
    end;
  finally
    LParams.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogManager.AddSession(const ASessionConnectString: TLMDString): TLMDLogCustomSession;
var
  LSessionName: TLMDString;
  LSessionType: TLMDString;
  LTransportType: TLMDString;
  LTransportParams: TLMDMemoryStrings;
  LSessionClass: TLMDLogSessionClass;
  LTransportClass: TLMDLogTransportClass;
  LTransport: TLMDLogCustomTransport;
begin
  Result := nil;
  // Format of connection string:
  // SessionName:SessionType:TransportType:TransportParam1=Value1;...;TransportParamN=ValueN
  LTransportParams := TLMDMemoryStrings.Create;
  try
    ParseConnectString(ASessionConnectString, LSessionName, LSessionType, LTransportType, LTransportParams);

    LSessionClass := GetSessionClass(LSessionType);
    if LSessionClass = nil then
      raise ELMDLogException.CreateFmt('Session type %s isn''t registered', [LSessionType]);

    LTransportClass := GetTransportClass(LTransportType);
    if LTransportClass = nil then
      raise ELMDLogException.CreateFmt('Transport type %s isn''t registered', [LTransportType]);

    FTransportList.Add(LTransportClass.Create);
    LTransport := TLMDLogCustomTransport(FTransportList.Last);
    LTransport.Parameters := LTransportParams.Text;

    Result := LSessionClass.Create(Self, LSessionName, LTransport);
    FSessionList.Add(Result);
  finally
    LTransportParams.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogManager.GetSessionClass(const ASessionClassType: TLMDString): TLMDLogSessionClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FSessionClasses.Count - 1 do
  begin
    if TLMDLogSessionClass(FSessionClasses.Items[i]).GetName = ASessionClassType then
    begin
      Result := TLMDLogSessionClass(FSessionClasses.Items[i]);
      break;
    end;
  end;
end;

function TLMDLogManager.GetSessionIndex(const AName: TLMDString): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FSessionList.Count - 1 do
  begin
    if TLMDLogCustomSession(FSessionList[i]).Name = AName then
    begin
      Result := i;
      Break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogManager.GetTransportClass(const ATransportName: TLMDString): TLMDLogTransportClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FTransportClasses.Count - 1 do
  begin
    if TLMDLogTransportClass(FTransportClasses.Items[i]).GetName = ATransportName then
    begin
      Result := TLMDLogTransportClass(FTransportClasses.Items[i]);
      break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogManager.DeleteSession(const AName: TLMDString);
var
  LIndex: Integer;
begin
  LIndex := GetSessionIndex(AName);
  if LIndex > -1 then
    FSessionList.Delete(LIndex);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDLogManager.Destroy;
begin
  FSessionList.Free;
  FTransportList.Free;
  FSessionClasses.Free;
  FTransportClasses.Free;
  FLogLevelList.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogManager.GetLogLevelNameByValue(const AValue: Cardinal): TLMDString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FLogLevelList.Count - 1 do
  begin
    if TLMDLogLevel(FLogLevelList[i]).Value = AValue then
    begin
      Result := TLMDLogLevel(FLogLevelList[i]).Name;
      exit;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogManager.GetLogLevelValueByName(const AName: TLMDString): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FLogLevelList.Count - 1 do
  begin
    if TLMDLogLevel(FLogLevelList[i]).Name = AName then
    begin
      Result := TLMDLogLevel(FLogLevelList[i]).Value;
      exit;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogManager.GetRootSession: TLMDLogSession;
begin
  Result := TLMDLogSession(Session['Root']);
  if not Assigned(Result) then
    Result := TLMDLogSession(AddSession(CRootConnectString));
end;

{ ---------------------------------------------------------------------------- }
// NB. Searching of names is case sensitive!
function TLMDLogManager.GetSession(const AName: TLMDString): TLMDLogCustomSession;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FSessionList.Count - 1 do
  begin
    if TLMDLogCustomSession(FSessionList[i]).Name = AName then
    begin
      Result := TLMDLogCustomSession(FSessionList[i]);
      break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogManager.RegisterLogLevel(ALogLevel: TLMDLogLevel);
begin
  if not Assigned(ALogLevel) then
    exit;
  if FLogLevelList.IndexOf(ALogLevel) > 0 then
    raise ELMDLogException.CreateFmt('This Log Level (%s) is already registered', [ALogLevel.Name]);
  FLogLevelList.Add(ALogLevel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogManager.RegisterSessionClass(ASessionClass: TLMDLogSessionClass);
begin
  if not Assigned(GetSessionClass(ASessionClass.GetName)) then
    FSessionClasses.Add(ASessionClass)
  else
    raise ELMDLogException.CreateFmt('Class %s is already registered', [ASessionClass.GetName]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogManager.RegisterTransportClass(ATransportClass: TLMDLogTransportClass);
begin
  if not Assigned(GetTransportClass(ATransportClass.GetName)) then
    FTransportClasses.Add(ATransportClass)
  else
    raise ELMDLogException.CreateFmt('Transport %s is already registered', [ATransportClass.GetName]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogManager.LoadConfig(AFileName: TLMDString): Boolean;
var
  LConfig: ILMDXmlDocument;
  LSessions: ILMDXmlNodeList;
  i, j: Integer;
  LSessionConnectString: TLMDString;
  LParams: ILMDXmlNodeList;
  LStrParam: TLMDString;
begin
  Result := True;

  // Set nil to global var
  LMDLog := nil;

  // Clear Session list
  FSessionList.Clear;
  FTransportList.Clear;
  try
    LConfig := LMDCreateXmlDocument();
    LConfig.Load(AFileName);
    LSessions := LConfig.DocumentElement.SelectNodes('session');
    for i := 0 to LSessions.Count - 1 do
    begin
      LSessionConnectString := LSessions[i].GetAttr('name');
      LSessionConnectString := LSessionConnectString + CMSeparator + LSessions[i].GetAttr('type');
      with LSessions[i].SelectSingleNode('transport') do
      begin
        LSessionConnectString := LSessionConnectString + CMSeparator + GetAttr('type');
        LParams := SelectNodes('parameter');
        LStrParam := '';
        for j := 0 to LParams.Count - 1 do
        begin
          LStrParam := LStrParam + LParams[j].GetAttr('name') + '=' + LParams[j].Text;
          if j < (LParams.Count - 1) then
            LStrParam := LStrParam + CPSeparator;
        end;
        LSessionConnectString := LSessionConnectString + CMSeparator + LStrParam;
        AddSession(LSessionConnectString);
      end;
    end;
    LMDLog := RootSession;
  except
    Result := False;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogManager.SaveConfig(AFileName: TLMDString): Boolean;
var
  LConfig: ILMDXmlDocument;
  LStr: TLMDMemoryStrings;
  i: Integer;
  j: Integer;
begin
  Result := True;
  // Do not localize strings here
  LConfig := LMDCreateXmlDocument('lmdlogconfig', '1.0', 'UTF-8');
  try
    for i := 0 to FSessionList.Count - 1 do
    begin
      with LConfig.DocumentElement.AppendElement('session') do
      begin
        SetAttr('name', TLMDLogCustomSession(FSessionList.Items[i]).Name);
        SetAttr('type', TLMDLogCustomSession(FSessionList.Items[i]).GetName);
        with AppendElement('transport') do
        begin
          SetAttr('type', TLMDLogCustomSession(FSessionList.Items[i]).FTransport.GetType);
          LStr := TLMDMemoryStrings.Create;
          try
            LStr.Text := TLMDLogCustomSession(FSessionList.Items[i]).FTransport.Parameters;
            for j := 0 to LStr.Count - 1 do
            begin
              with AppendElement('parameter') do
              begin
                SetAttr('name', LStr.Names[j]);
                AppendText(LStr.Values[LStr.Names[j]]);
              end;
            end;
          finally
            LStr.Free;
          end;
        end;
      end;
    end;
    LConfig.Save(AFileName);
  except
    Result := False
  end;
end;

{******************************* TLMDGeneralLink ******************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDLogCustomTransport.Create;
begin
  inherited;
  FActive := False;
  FBuffer := TLMDThreadBuffer.Create;
  FBuffer.Size := GetMessagesBufferSize;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDLogCustomTransport.Destroy;
begin
  if Assigned(FSendThread) then
  begin
    FBuffer.PutItem(nil);
    FSendThread.WaitFor;
    FreeAndNil(FSendThread);
  end;
  FBuffer.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomTransport.GetActive: Boolean;
begin
  Result := FActive;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomTransport.GetMessagesBufferSize: Integer;
begin
  Result := 200;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomTransport.GetType: WideString;
begin
  Result := GetName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomTransport.SetActive(const AValue: Boolean);
begin
  FActive := AValue;
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogCustomTransport.GetName: WideString;
begin
  raise ELMDLogException.Create('This method must be overriden');
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomTransport.SendMsg(AMessage: TLMDLogMessage): Boolean;
var
  LFree: Integer;
begin
  Result := False;
  if FActive then
  begin
    if not Assigned(FSendThread) then
      FSendThread := CreateSendThread;

    FBuffer.GetFreeSlots(LFree);
    if LFree > 0 then
      Result := FBuffer.PutItem(AMessage);
    while LFree = 0  do
    begin
      FBuffer.GetFreeSlots(LFree);
      if LFree > 0 then
        Result := FBuffer.PutItem(AMessage);
    end;
  end;
end;

{ **************************** TLMDGeneralSendThread ************************* }
{ ---------------------------------------------------------------------------- }
constructor TLMDLogCustomSendThread.Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
begin
  inherited Create(ACreateSuspended);
  FBuffer := AOwner.FBuffer;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogCustomSendThread.Execute;
var
  LUsed: Integer;
  i: Integer;
  LItem: TObject;
begin
  while True do
  begin
    Sleep(1);
    FBuffer.GetUsedSlots(LUsed);
    if LUsed > 0 then
    begin
      for i := 0 to LUsed - 1 do
      begin
        LItem := FBuffer.GetItem;
        if Assigned(LItem) then
          DoMessage(TLMDLogMessage(LItem))
        else
          exit; // nil in queue as signal of end
      end;
    end;
  end;
end;

{******************************** TLMDLogLevel ********************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDLogLevel.Create(ALevelValue: Longword; ALevelName: TLMDString);
begin
  FValue := ALevelValue;
  FName := ALevelName;
  inherited Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogLevel.IsAllow(ALevel: TLMDLogLevel): boolean;
begin
  Result := False;
  if not Assigned(ALevel) then
    exit;
  if Value <= ALevel.Value then
    Result := True;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogLevel.IsEqual(ALevel: TLMDLogLevel): boolean;
begin
  Result := False;
  if Value = ALevel.Value then
    Result := True;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogLevel.IsGreater(ALevel: TLMDLogLevel): boolean;
begin
  Result := False;
  if Value > ALevel.Value then
    Result := True;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogLevel.IsLesser(Alevel: TLMDLogLevel): boolean;
begin
  Result := False;
  if Value < ALevel.Value then
    Result := True;
end;

const
  TRACE_VALUE = 100;
  DEBUG_VALUE = 200;
  INFO_VALUE = 500;
  WARNING_VALUE = 1000;
  ERROR_VALUE = 5000;
  FATAL_VALUE = 10000;
  ALL_VALUE = Low(Longword);
  OFF_VALUE = High(Longword);

procedure InitializeLevels;
begin
  LogTrace := TLMDLogLevel.Create(TRACE_VALUE, 'Trace');
  LogDebug := TLMDLogLevel.Create(DEBUG_VALUE, 'Debug');
  LogInformation := TLMDLogLevel.Create(INFO_VALUE, 'Information');
  LogWarning := TLMDLogLevel.Create(WARNING_VALUE, 'Warning');
  LogError := TLMDLogLevel.Create(ERROR_VALUE, 'Error');
  LogFatal := TLMDLogLevel.Create(FATAL_VALUE, 'Fatal');
  LogAll := TLMDLogLevel.Create(ALL_VALUE, 'All');
  LogOff := TLMDLogLevel.Create(OFF_VALUE, 'Off');

  RegisterClass(TPersistentClass(TLMDLogMessage));

  LMDLogManager := TLMDLogManager.Create;
  LMDLogManager.RegisterSessionClass(TLMDLogSession);
  LMDLogManager.RegisterTransportClass(TLMDWMCopyDataTransport);
  LMDLog := LMDLogManager.RootSession;
end;

procedure FinalizeLevels;
begin
  FreeAndNil(LogTrace);
  FreeAndNil(LogDebug);
  FreeAndNil(LogInformation);
  FreeAndNil(LogWarning);
  FreeAndNil(LogError);
  FreeAndNil(LogFatal);
  FreeAndNil(LogAll);
  FreeAndNil(LogOff);
  LMDLog := nil;
  FreeAndNil(LMDLogManager);
end;

initialization
  InitializeLevels;

finalization
  FinalizeLevels;

end.
