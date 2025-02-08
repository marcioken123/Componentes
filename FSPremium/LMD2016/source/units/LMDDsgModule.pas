unit LMDDsgModule;
{$I LmdCmps.inc}

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

LMDDsgModule unit (YB)
------------------------
TLMDModule unit.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, Messages, SysUtils, Forms, Consts, Graphics, Dialogs,
  TypInfo, RTLConsts, LMDUnicode, LMDDsgCst, LMDDsgClass, LMDTypes, intfLMDBase;

  {********************** TLMDComponentChangeNotification *********************}

type
  TLMDComponentChangeNotification = procedure(Sender: TObject;
    AChangedComps: TList) of object;

  {******************************** TLMDModule ********************************}

type
  ELMDModule = class(Exception);
  TLMDModule = class;

  ILMDModuleNotifier = class
  public
    procedure RootChange(AModule: TLMDModule); virtual; abstract;
    procedure RootReloaded(AModule: TLMDModule); virtual; abstract;
  end;

  TLMDModuleFrameQueryKind = (fqkGetModule, fqkLoadBase);
  TLMDModuleFrameContext   = class // Opaque for the user.
  private
    FOwnedModule:        TLMDModule;
    FQueryKind:          TLMDModuleFrameQueryKind;
    FFrameModuleName:    TLMDString;
    FFrameOwner:         TComponent;

    FHandled:            Boolean;
    FResultFrameModule:  TLMDModule;
    FResultFrame:        TCustomFrame;
  end;

  TLMDEventValue = record
    Owner: TComponent;
    Name:  TLMDString;
  end;

  TLMDModuleState = set of (msReading, msWriting, msEvtHdrRenaming);

  TLMDModuleOnValidateCompName = procedure(Sender: TObject;
    AComponent: TComponent; const AName: TLMDString;
    var AIsValidName: Boolean; var AErrorMsg: TLMDString) of object;

  TLMDModuleOnGetUniqueCompName = procedure(Sender: TObject;
    const ABaseName: TLMDString; var AUniqueName: TLMDString) of object;

  TLMDModuleOnGetCompRef = procedure(Sender: TObject;
    const ACompName: TLMDString; var AComponent: TComponent) of object;

  {$IFDEF LMDCOMP9}
  TLMDOnGetLoadingCompRef = procedure(Sender: TObject;
    const Name: string; var Instance: TComponent) of object;
  {$ENDIF}

  TLMDModuleOnGetCompRefName = procedure(Sender: TObject;
    AComponent: TComponent; var AName: TLMDString) of object;

  TLMDModuleOnGetCompRefList = procedure(Sender: TObject;
    AClass: TComponentClass; AResult: TList) of object;

  TLMDModuleOnValidateEventHandlerName = procedure(Sender: TObject;
    const AName: TLMDString; var AIsValidName: Boolean) of object;

  TLMDModuleOnGetEventHandlerName = procedure(Sender: TObject;
    AInstance: TPersistent; const AEventName: TLMDString;
    AEventTypeInfo: TLMDTypeInfo; var AName: TLMDString) of object;

  TLMDModuleOnGetEventHandlerList = procedure(Sender: TObject;
    AEventTypeInfo: TLMDTypeInfo; AResult: TLMDStrings) of object;

  TLMDModuleOnEnsureEventHandlerSource = procedure(Sender: TObject;
    const AName, AOldName: TLMDString; AEventTypeInfo: TLMDTypeInfo;
    AShowSource: Boolean; var AIsRenamed: Boolean) of object;

  TLMDModuleOnValidateEventHandler = procedure(Sender: TObject;
    AInstance: TPersistent; APropInfo: TLMDPropInfo;
    const AHandlerName: TLMDString; var ACancel: Boolean) of object;

  TLMDModuleOnHookEvent = procedure(Sender: TObject; AInstance: TPersistent;
    APropInfo: TLMDPropInfo; const AEventHandler: TLMDEventValue) of object;

  TLMDModuleOnLoadError = procedure(Sender: TObject; const AMessage: TLMDString;
    var AHandled: Boolean) of object;

  TLMDModuleOnQueryFrameData = procedure(Sender: TObject;
    const AFrameModuleName: TLMDString; AQueryKind: TLMDModuleFrameQueryKind;
    AContext: TLMDModuleFrameContext) of object;

  {******************************** TLMDModule ********************************}

  TLMDModule = class(TComponent, ILMDComponent)
  private
    FAbout:                       TLMDAboutVar;
    FState:                       TLMDModuleState;
    FRoot:                        TWinControl;
    FReadLevel:                   Integer; // Recursive reading/writing.
    FWriteLevel:                  Integer; //
    FReadingEventOwner:           TComponent;
    FCreateCompClassName:         TLMDString;
    FModuleName:                  TLMDString;
    FTraits:                      TObject;
    FFramesMap:                   TList;
    FAncestoredComps:             TList;
    FEventHandlers:               TList;
    FRenamingOld:                 TObject;
    FRenamingNew:                 TObject;
    FNextEventHandlerId:          Word;
    FReaderNameReplaces:          TObject;
    FNotifiers:                   TList;
    FOnGetUniqueCompName:         TLMDModuleOnGetUniqueCompName;
    FOnValidateCompName:          TLMDModuleOnValidateCompName;
    FOnValidateEventHandlerName:  TLMDModuleOnValidateEventHandlerName;
    FOnGetCompRef:                TLMDModuleOnGetCompRef;
    {$IFDEF LMDCOMP9}
    FOnGetLoadingCompRef:         TLMDOnGetLoadingCompRef;
    {$ENDIF}
    FOnGetCompRefList:            TLMDModuleOnGetCompRefList;
    FOnGetCompRefName:            TLMDModuleOnGetCompRefName;
    FOnGetEventHandlerName:       TLMDModuleOnGetEventHandlerName;
    FOnGetEventHandlerList:       TLMDModuleOnGetEventHandlerList;
    FOnEnsureEventHandlerSource:  TLMDModuleOnEnsureEventHandlerSource;
    FOnValidateEventHandler:      TLMDModuleOnValidateEventHandler;
    FOnHookEvent:                 TLMDModuleOnHookEvent;
    FOnQueryFrameData:            TLMDModuleOnQueryFrameData;
    FOnLoadError:                 TLMDModuleOnLoadError;
    FOnCompsModified:             TNotifyEvent;

    procedure SetRoot(const Value: TWinControl);
    procedure SetModuleName(const Value: TLMDString);
    procedure ReaderSetName(Reader: TReader; Component: TComponent; var Name: string);
    procedure ReaderReferenceName(Reader: TReader; var Name: string);
    procedure ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
    procedure ReaderFindComponentClass(Reader: TReader; const ClassName: string;
                                       var ComponentClass: TComponentClass);
    {$IFDEF LMDCOMP9}
    procedure ReaderFindComponentInstance(Reader: TReader; const Name: string;
                                          var Instance: TLMDDataTag);
    {$ENDIF}
    procedure ReaderCreateComponent(Reader: TReader; ComponentClass: TComponentClass;
                                    var Component: TComponent);
    procedure WriterFindAncestor(Writer: TWriter; Component: TComponent;
                                 const Name: string; var Ancestor,
                                 RootAncestor: TComponent);
    procedure RenameHandlerProc(AInstance: TPersistent; APropInfo: TLMDPropInfo);
    procedure ResetEventProc(AInstance: TPersistent; APropInfo: TLMDPropInfo);
    procedure ValidateHandlerProc(AInstance: TPersistent; APropInfo: TLMDPropInfo);
    procedure HookEventProc(AInstance: TPersistent; APropInfo: TLMDPropInfo);
    procedure UpdateDesigner;
    procedure CompsChangeNotification(Sender: TObject; AChangedComps: TList);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure DoRootChange; virtual;
    procedure DoRootReload; virtual;
    procedure DoCompsModified; virtual;

    procedure BeforeRead(AEventOwner: TComponent; AReader: TReader;
                         out AOldEventOwner: TComponent);
    procedure AfterRead(AOldEventOwner: TComponent);
    procedure BeforeWrite(AWriter: TWriter);
    procedure AfterWrite;

    procedure RemoveAncestorFlags;
    procedure ReplaceRootClassName;

    function  FindEventHandler(AId: Integer): TObject; overload;
    function  FindEventHandler(AOwner: TComponent; const AName: TLMDString): TObject; overload;
    function  EventHandlerNeeded(AOwner: TComponent; const AName: TLMDString): TObject;
    function  HasOwnedEventHandlers(AOwner: TComponent): Boolean;
    procedure RenameEventHandler(AOwner: TComponent; const AName, AOldName: TLMDString);
    procedure ClearEventHandlers;
    procedure ClearOwnedEventHandlers(AOwner: TComponent);
    procedure CollectUnusedEventHandlers;
    procedure DeleteEventHandler(AIndex: Integer);

    procedure InsertFrameToMap(AFrame: TCustomFrame; const AModuleName: TLMDString);
    procedure RemoveFrameFromMap(AFrame: TCustomFrame);
    function  IndexOfFrame(AFrame: TCustomFrame): Integer;
    procedure ClearFramesMap;

    function  CreateInitedFrameInstance(const AFrameModuleName: TLMDString;
                                        AFrameOwner: TComponent;
                                        out AResFrame: TCustomFrame): Boolean;
    function  GetBaseFrameModule(const AFrameModuleName: TLMDString;
                                 out AResModule: TLMDModule): Boolean;
    procedure DoLoadFrameCopy(AFrame: TCustomFrame; AStream: TStream);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddNotifier(ANotifier: ILMDModuleNotifier);
    procedure RemoveNotifier(ANotifier: ILMDModuleNotifier);

    function  IsUniqueCompName(const AName: TLMDString): Boolean;
    function  IsValidCompName(AComponent: TComponent;
                              const AName: TLMDString;
                              var AErrorMsg: TLMDString): Boolean;
    procedure CheckCompName(AComponent: TComponent; const AName: TLMDString);
    function  GetUniqueCompName(const ABaseName: TLMDString): TLMDString;
    function  GetCompRef(const ACompName: TLMDString): TComponent;
    function  GetCompRefName(AComponent: TComponent): TLMDString;
    procedure GetCompRefList(AClass: TComponentClass; AResult: TList);

    function  GetEventHandlerName(AInstance: TPersistent;
                                  const AEventName: TLMDString;
                                  AEventTypeInfo: TLMDTypeInfo): TLMDString;
    function  IsValidEventHandlerName(const AName: TLMDString): Boolean;
    procedure CheckEventHandler(AValue: TLMDEventValue);
    function  GetEventProp(AInstance: TPersistent;
                           APropInfo: TLMDPropInfo): TLMDEventValue;
    procedure SetEventProp(AInstance: TPersistent; APropInfo: TLMDPropInfo;
                           AValue: TLMDEventValue);
    procedure GetEventHandlerList(AEventTypeInfo: TLMDTypeInfo;
                                  AResult: TLMDStrings);
    procedure EnsureEventHandlerSource(const AName, AOldName: TLMDString;
                                       AEventTypeInfo: TLMDTypeInfo;
                                       AShowSource: Boolean = False);
    function  ValidateEventHandlers: Boolean;
    procedure HookEvents;

    procedure ClipboardSave(AStream: TStream; AComponents: TList);
    procedure ClipboardLoad(AStream: TStream; AParent: TWinControl;
                            AProc: TReadComponentsProc);
    procedure SaveToStream(AStream: TStream;
                           AFormat: TStreamOriginalFormat = sofText);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AFileName: TLMDString;
                         AFormat: TStreamOriginalFormat = sofText);
    procedure LoadFromFile(const AFileName: TLMDString);

    function  ClientToScreen(const APoint: TPoint): TPoint;
    function  ScreenToClient(const APoint: TPoint): TPoint;

    function  GetFrameModuleName(AFrame: TCustomFrame): TLMDString;
    procedure SetFrameModuleName(AFrame: TCustomFrame; const AValue: TLMDString);
    function  InsertFrame(const AFrameModuleName: TLMDString): TCustomFrame;

    property  Root: TWinControl read FRoot write SetRoot;
    property  ModuleName: TLMDString read FModuleName write SetModuleName;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property OnCompsModified: TNotifyEvent read FOnCompsModified write FOnCompsModified;
    property OnGetUniqueCompName: TLMDModuleOnGetUniqueCompName read FOnGetUniqueCompName write FOnGetUniqueCompName;
    property OnValidateCompName: TLMDModuleOnValidateCompName read FOnValidateCompName write FOnValidateCompName;
    property OnGetCompRef: TLMDModuleOnGetCompRef read FOnGetCompRef write FOnGetCompRef;
    {$IFDEF LMDCOMP9}
    property OnGetLoadingCompRef: TLMDOnGetLoadingCompRef read FOnGetLoadingCompRef write FOnGetLoadingCompRef;
    {$ENDIF}
    property OnGetCompRefName: TLMDModuleOnGetCompRefName read FOnGetCompRefName write FOnGetCompRefName;
    property OnGetCompRefList: TLMDModuleOnGetCompRefList read FOnGetCompRefList write FOnGetCompRefList;
    property OnValidateEventHandlerName: TLMDModuleOnValidateEventHandlerName read FOnValidateEventHandlerName write FOnValidateEventHandlerName;
    property OnGetEventHandlerName: TLMDModuleOnGetEventHandlerName read FOnGetEventHandlerName write FOnGetEventHandlerName;
    property OnGetEventHandlerList: TLMDModuleOnGetEventHandlerList read FOnGetEventHandlerList write FOnGetEventHandlerList;
    property OnEnsureEventHandlerSource: TLMDModuleOnEnsureEventHandlerSource read FOnEnsureEventHandlerSource write FOnEnsureEventHandlerSource;
    property OnValidateEventHandler: TLMDModuleOnValidateEventHandler read FOnValidateEventHandler write FOnValidateEventHandler;
    property OnHookEvent: TLMDModuleOnHookEvent read FOnHookEvent write FOnHookEvent;
    property OnQueryFrameData: TLMDModuleOnQueryFrameData read FOnQueryFrameData write FOnQueryFrameData;
    property OnLoadError: TLMDModuleOnLoadError read FOnLoadError write FOnLoadError;
  end;

function  LMDEventValue(AOwner: TComponent; const AName: TLMDString): TLMDEventValue;
function  LMDMakeEventHandlerName(const AInstanceName: TLMDString;
                                  const AEventName: TLMDString;
                                  AEventTypeInfo: TLMDTypeInfo): TLMDString; overload;
function  LMDMakeEventHandlerName(AInstance: TPersistent; const AEventName: TLMDString;
                                  AEventTypeInfo: TLMDTypeInfo;
                                  ARoot: TComponent = nil): TLMDString; overload;

procedure LMDSetFrameModule(AContext: TLMDModuleFrameContext;
                            AFrameModule: TLMDModule);
procedure LMDLoadFrameBase(AContext: TLMDModuleFrameContext;
                           AFrameModule: TLMDModule); overload;
procedure LMDLoadFrameBase(AContext: TLMDModuleFrameContext;
                           AFrameClass: TCustomFrameClass;
                           ASavedFrame: TStream); overload;
procedure LMDLoadFrameBase(AContext: TLMDModuleFrameContext;
                           AFrameClass: TCustomFrameClass;
                           const AFileName: TLMDString); overload;

function  LMDIsOwnerValid(ARoot: TWinControl; AOwner: TComponent): Boolean;
function  LMDIsFrameCopy(AComp: TComponent): Boolean;
function  LMDIsOwnedByFrameCopy(AComp: TComponent): Boolean;

procedure LMDShowModuleStructure(AModule: TLMDModule);

function  LMDFindObjectModule(AObject: TPersistent): TLMDModule;
function  LMDIsObjectOwnedBy(AObject: TPersistent; AOwner: TWinControl): Boolean;

procedure LMDRegisterComponentChangeNotification(AKey: TObject;
            AProc: TLMDComponentChangeNotification);
procedure LMDUnregisterComponentChangeNotification(AKey: TObject);
procedure LMDComponentsChanged(Sender: TObject; AComps: TList);
procedure LMDComponentChanged(Sender: TObject; AComp: TComponent);
procedure LMDTransformToCompList(APersObjects: TList);
function  LMDHasCommonItems(AListA, AListB: TList): Boolean;

function  LMDGetPersistentComponent(AObj: TPersistent): TComponent;

procedure LMDShowDefaultEventHandler(AInstance: TPersistent;
                                     ANotifyCompChange: Boolean = True);

implementation

uses
  LMDInsClass, LMDDsgDesigner, LMDDsgStructDlg;

type
  ECancelHandlerValidation  = class(Exception);
  TComponentAccess          = class(TComponent);
  TPersistentAccess         = class(TPersistent);
  TReaderUnknownMark        = class(TComponent);
  TWriterDummyAncestor      = class(TComponent);

  {****************************** TNameReplaces *******************************}

  TNameReplaces = class
  private
    FSourceNames: TStringList;
    FDestNames  : TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Add(const ASourceName, ADestName: TLMDString);
    function  IndexOf(const ASourceName: TLMDString): Integer;
    function  DestName(AI: Integer): TLMDString;
  end;

  {****************************** TFrameMapItem *******************************}

  TFrameMapItem = class
  public
    Frame:      TCustomFrame;
    ModuleName: TLMDString;
  end;

  {****************************** TEventHandler *******************************}

  TEventHandler = class
  public
    Owner:    TComponent;
    Name:     TLMDString;
    Id:       Integer;
    MarkFlag: Boolean; // For GC.
  end;

  {****************************** TEventIterator ******************************}

  TEventIteratorProc = procedure(AInstance: TPersistent;
                                 APropInfo: TLMDPropInfo) of object;

  TEventIterator = class
  private
    FRoot:  TComponent;
    FProc:  TEventIteratorProc;
    FFound: TList;

    procedure ObjectFound(AObject: TPersistent);
    procedure PropFound(AObject: TPersistent; APropInfo: TLMDPropInfo);
  public
    constructor Create;
    destructor Destroy; override;
    
    class procedure Iterate(ARoot: TComponent; AProc: TEventIteratorProc);
  end;

  {****************************** IModuleTraits *******************************}

  IModuleTraits = class
  public
    procedure ClearEventHandlers(AOwner: TComponent); virtual; abstract; // AOwner can be nil.
    procedure MarkEventHandlers; virtual; abstract;
    procedure ReplaceClassName(AClass: TClass; const ANewName: TLMDString); virtual; abstract;
    procedure BeforeRead(ALevel: Integer; AReader: TReader); virtual; abstract;
    procedure AfterRead(ALevel: Integer); virtual; abstract;
    procedure BeforeWrite(ALevel: Integer; AWriter: TWriter); virtual; abstract;
    procedure AfterWrite(ALevel: Integer); virtual; abstract;
    function  GetEventProp(AInstance: TPersistent;
                           APropInfo: TLMDPropInfo): TEventHandler; virtual; abstract;
    procedure SetEventProp(AInstance: TPersistent; APropInfo: TLMDPropInfo;
                           AEventHandler: TEventHandler); virtual; abstract;
  end;

  {******************************* TWin32Traits *******************************}

  TWin32ClassNameRepl = class
    Class_:     TClass;
    OriginName: PShortString; // Real class name.
    CurName:    ShortString;  // Replaced class name, can changes
                              // several times.
  end;

  TWin32Traits = class(IModuleTraits)
  private
    FModule:        TLMDModule;
    FOldTbl:        Pointer;
    FMdTbl:         TMemoryStream;
    FClsNameRepls:  TList;

    procedure ReaderFindMethod(Reader: TReader; const MethodName: String;
                               var Address: Pointer; var Error: Boolean);

    procedure WriteMemHack(var ADest; const ASource; ASize: Integer);

    procedure ReplaceMethodTable;
    procedure RestoreMethodTable;
    procedure MarkEventHandlerProc(AInstance: TPersistent;
                                   APropInfo: TLMDPropInfo);

    procedure RestoreClassNames;
    function  DoReplaceClassName(AClass: TClass;
                                 ANewName: PShortString): PShortString;
  public
    constructor Create(AModule: TLMDModule);
    destructor Destroy; override;

    procedure ClearEventHandlers(AOwner: TComponent); override;
    procedure MarkEventHandlers; override;
    procedure ReplaceClassName(AClass: TClass; const ANewName: TLMDString); override;
    procedure BeforeRead(ALevel: Integer; AReader: TReader); override;
    procedure AfterRead(ALevel: Integer); override;
    procedure BeforeWrite(ALevel: Integer; AWriter: TWriter); override;
    procedure AfterWrite(ALevel: Integer); override;

    function  GetEventProp(AInstance: TPersistent;
                           APropInfo: TLMDPropInfo): TEventHandler; override;
    procedure SetEventProp(AInstance: TPersistent; APropInfo: TLMDPropInfo;
                           AEventHandler: TEventHandler); override;
  end;

  {**************************** TCompChangeNotifList **************************}

  TCompChangeNotifItem = class
  public
    Key:  TObject;
    Proc: TLMDComponentChangeNotification;
  end;

  TCompChangeNotifList = class
  private
    FItems: TList;

    procedure ClearAll;
    function  IndexOf(Akey: TObject): Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(AKey: TObject; AProc: TLMDComponentChangeNotification);
    procedure Remove(AKey: TObject);
    procedure CallProcs(Sender: TObject; AComps: TList);
  end;

  {********************************** Globals *********************************}

var
  CompChangeNotifs:    TCompChangeNotifList;
  WriterDummyAncestor: TWriterDummyAncestor;
  ModuleList:          TList;

{ ---------------------------------------------------------------------------- }

function LMDEventValue(AOwner: TComponent;
  const AName: TLMDString): TLMDEventValue;
begin
  Result.Owner := AOwner;
  Result.Name  := AName;
end;

{ ---------------------------------------------------------------------------- }

function LMDMakeEventHandlerName(const AInstanceName: TLMDString;
  const AEventName: TLMDString; AEventTypeInfo: TLMDTypeInfo): TLMDString;
var
  event: TLMDString;
begin
  event := AEventName;
  if (Length(event) >= 2) and (Ord(event[1]) in [Ord('O'), Ord('o')]) and
     (Ord(event[2]) in [Ord('N'), Ord('n')]) then
    Delete(event, 1, 2);

  Result := AInstanceName + event;
end;

{------------------------------------------------------------------------------}

function LMDMakeEventHandlerName(AInstance: TPersistent;
  const AEventName: TLMDString; AEventTypeInfo: TLMDTypeInfo;
  ARoot: TComponent): TLMDString;
var
  i:      Integer;
  instnm: TLMDString;
begin
  if AInstance = ARoot then
  begin
    instnm := AInstance.ClassName;

    if (instnm <> '') and (instnm[1] = 'T') then
      Delete(instnm, 1, 1);
  end
  else
  begin
    instnm := AInstance.GetNamePath;

    for i := Length(instnm) downto 1 do
    begin
      if AnsiChar(instnm[i]) in ['.', '[', ']', '-', '>'] then
        Delete(instnm, i, 1);
    end;
  end;

  Result := LMDMakeEventHandlerName(instnm, AEventName, AEventTypeInfo);
end;
       
{------------------------------------------------------------------------------}

procedure LMDSetFrameModule(AContext: TLMDModuleFrameContext;
  AFrameModule: TLMDModule);
begin
  Assert((AContext.FQueryKind = fqkGetModule) and not AContext.FHandled,
         'Invalid context query kind or query is already handled.');
  Assert((AFrameModule <> nil) and
         (AFrameModule.ModuleName = AContext.FFrameModuleName) and
         (AFrameModule.Root is TCustomFrame),
         'Invalid frame module specified.');

  AContext.FHandled           := True;
  AContext.FResultFrameModule := AFrameModule;
end;
       
{------------------------------------------------------------------------------}

procedure LMDLoadFrameBase(AContext: TLMDModuleFrameContext;
  AFrameModule: TLMDModule);
var
  str: TStream;
  cls: TCustomFrameClass;
begin
  Assert((AContext.FQueryKind = fqkLoadBase) and not AContext.FHandled,
         'Invalid context query kind or query is already handled.');
  Assert((AFrameModule <> nil) and
         (AFrameModule.ModuleName = AContext.FFrameModuleName) and
         (AFrameModule.Root is TCustomFrame),
         'Invalid frame module specified.');

  str := TMemoryStream.Create;
  try
    AFrameModule.SaveToStream(str, sofBinary);
    str.Position := 0;

    cls := TCustomFrameClass(AFrameModule.Root.ClassType);
    LMDLoadFrameBase(AContext, cls, str);
  finally
    str.Free;
  end;
end;
      
{------------------------------------------------------------------------------}

procedure LMDLoadFrameBase(AContext: TLMDModuleFrameContext;
  AFrameClass: TCustomFrameClass; ASavedFrame: TStream);
var
  frame:  TCustomFrame;
  ownmdl: TLMDModule;
begin
  Assert((AContext.FQueryKind = fqkLoadBase) and not AContext.FHandled,
         'Invalid context query kind or query is already handled.');

  ownmdl := AContext.FOwnedModule;
  frame  := AFrameClass.Create(AContext.FFrameOwner);
  try
    ownmdl.DoLoadFrameCopy(frame, ASavedFrame);
    ownmdl.InsertFrameToMap(frame, AContext.FFrameModuleName);
  except
    frame.Free;
    raise;
  end;

  AContext.FHandled     := True;
  AContext.FResultFrame := frame;
end;

{------------------------------------------------------------------------------}

procedure LMDLoadFrameBase(AContext: TLMDModuleFrameContext;
  AFrameClass: TCustomFrameClass; const AFileName: TLMDString);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LMDLoadFrameBase(AContext, AFrameClass, stream);
  finally
    stream.Free;
  end;
end;
         
{------------------------------------------------------------------------------}

function LMDIsOwnerValid(ARoot: TWinControl; AOwner: TComponent): Boolean;
var
  cur: TComponent;
begin
  cur := AOwner;

  while cur <> nil do
  begin
    if cur = ARoot then
    begin
      Result := True;
      Exit;
    end;

    if LMDIsFrameCopy(cur) then
      cur := cur.Owner
    else
      cur := nil;
  end;

  Result := False;
end;
                                                     
{------------------------------------------------------------------------------}

function LMDIsFrameCopy(AComp: TComponent): Boolean;
begin
  Result := (AComp <> nil) and (AComp is TCustomFrame) and
            (csInline in AComp.ComponentState);
end;

{------------------------------------------------------------------------------}

function LMDIsOwnedByFrameCopy(AComp: TComponent): Boolean;
begin
  Result := (AComp.Owner <> nil) and LMDIsFrameCopy(AComp.Owner);
end;

{------------------------------------------------------------------------------}

procedure LMDShowModuleStructure(AModule: TLMDModule);
var
  form: TLMDStructDlg;
begin
  form := TLMDStructDlg.Create(Application, AModule);
  try
    form.ShowModal;
  finally
    form.Free;
  end;
end;
                                                                
{------------------------------------------------------------------------------}

function LMDFindObjectModule(AObject: TPersistent): TLMDModule;
var
  i: Integer;
begin
  Result := nil;

  if AObject = nil then
    Exit
  else if AObject is TWinControl then
  begin
    for i := 0 to ModuleList.Count - 1 do
      if TLMDModule(ModuleList[i]).Root = AObject then
      begin
        Result := TLMDModule(ModuleList[i]);
        Exit;
      end;
  end;

  if Result = nil then
    Result := LMDFindObjectModule(TPersistentAccess(AObject).GetOwner);
end;
    
{------------------------------------------------------------------------------}

function LMDIsObjectOwnedBy(AObject: TPersistent; AOwner: TWinControl): Boolean;
begin
  Result := False;
  if AOwner = nil then
    Exit;

  while AObject <> nil do
  begin
    if AObject = AOwner then
    begin
      Result := True;
      Exit;
    end;

    AObject := TPersistentAccess(AObject).GetOwner;
  end;
end;

{------------------------------------------------------------------------------}

procedure LMDRegisterComponentChangeNotification(AKey: TObject;
  AProc: TLMDComponentChangeNotification);
begin
  CompChangeNotifs.Add(AKey, AProc);
end;

{------------------------------------------------------------------------------}

procedure LMDUnregisterComponentChangeNotification(AKey: TObject);
begin
  CompChangeNotifs.Remove(AKey);
end;

{------------------------------------------------------------------------------}

procedure LMDComponentsChanged(Sender: TObject; AComps: TList);
begin
  CompChangeNotifs.CallProcs(Sender, AComps);
end;
              
{------------------------------------------------------------------------------}

procedure LMDComponentChanged(Sender: TObject; AComp: TComponent);
var
  list: TList;
begin
  list := TList.Create;
  try
    list.Add(AComp);
    LMDComponentsChanged(Sender, list);
  finally
    list.Free;
  end;
end;
      
{------------------------------------------------------------------------------}

procedure LMDTransformToCompList(APersObjects: TList);
var
  i: Integer;
begin
  for i := 0 to APersObjects.Count - 1 do
    APersObjects[i] := LMDGetPersistentComponent(TPersistent(APersObjects[i]));
end;

{------------------------------------------------------------------------------}

function LMDHasCommonItems(AListA, AListB: TList): Boolean;
var
  i: Integer;
begin
  for i := 0 to AListA.Count - 1 do
    if (AListA[i] <> nil) and (AListB.IndexOf(AListA[i]) <> -1) then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;

{------------------------------------------------------------------------------}

function LMDGetPersistentComponent(AObj: TPersistent): TComponent;
begin
  while AObj <> nil do
  begin
    if AObj is TComponent then
    begin
      Result := TComponent(AObj);
      Exit;
    end;

    AObj := TPersistentAccess(AObj).GetOwner;
  end;

  Result := nil;
end;
 
{------------------------------------------------------------------------------}

procedure LMDShowDefaultEventHandler(AInstance: TPersistent;
  ANotifyCompChange: Boolean);
const
  PropNames: array[0..3] of string = ('onclick', 'onchanged', 'onchange',
                                      'oncreate');
var
  i:        Integer;
  count:    Integer;
  props:    TLMDPropList;
  best:     TLMDPropInfo;
  bestidx:  Integer;
  eventval: TLMDEventValue;
  module:   TLMDModule;

  procedure _PropFound(APropInfo: TLMDPropInfo);
  var
    i: Integer;
  begin
    if best = nil then
    begin
      best    := APropInfo;
      bestidx := -1;
    end;

    for i := bestidx + 1 to High(PropNames) do
      if SameText({$IFDEF LMDCOMP12}string{$ENDIF}(APropInfo.Name),
                  {$IFDEF LMDCOMP12}string{$ENDIF}(PropNames[i])) then
      begin
        best    := APropInfo;
        bestidx := i;
      end;
  end;

begin
  best    := nil;
  bestidx := -1;
  module  := LMDFindObjectModule(AInstance);

  if module = nil then
    Exit;

  { Iterate event props }

  count := GetPropList(AInstance.ClassInfo, [tkMethod], nil);
  GetMem(props, count * SizeOf(Pointer));
  GetPropList(AInstance.ClassInfo, [tkMethod], props);
  try
    for i := 0 to count - 1 do
      _PropFound(props[i]);
  finally
    FreeMem(props);
  end;

  { Show event handler }

  if best <> nil then
  begin
    { Get current event value }

    eventval := module.GetEventProp(AInstance, best);
    if eventval.Owner <> module.Root then
      eventval.Name := ''; // Delphi like behavior; Don't show
                           // inherited frame event handlers.

    if eventval.Name = '' then
    begin
      eventval.Owner := module.Root;
      eventval.Name  := module.GetEventHandlerName(
                                AInstance,
                                {$IFDEF LMDCOMP12}TLMDString{$ENDIF}(best.Name),
                                best.PropType^);
    end;

    module.SetEventProp(AInstance, best, eventval);
    module.EnsureEventHandlerSource(eventval.Name, '', best.PropType^,
                                    True);

    if ANotifyCompChange then
      LMDComponentChanged(nil, LMDGetPersistentComponent(AInstance));
  end;
end;

{******************************* TNameReplaces ********************************}
{--------------------------------- public -------------------------------------}

constructor TNameReplaces.Create;
begin
  inherited Create;
  FSourceNames := TStringList.Create;
  FDestNames   := TStringList.Create;
end;

{------------------------------------------------------------------------------}

destructor TNameReplaces.Destroy;
begin
  Clear;
  FSourceNames.Free;
  FDestNames.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TNameReplaces.Clear;
begin
  FSourceNames.Clear;
  FDestNames.Clear;
end;

{------------------------------------------------------------------------------}

procedure TNameReplaces.Add(const ASourceName, ADestName: TLMDString);
begin
  FSourceNames.Add(ASourceName);
  FDestNames.Add(ADestName);
end;

{------------------------------------------------------------------------------}

function TNameReplaces.IndexOf(const ASourceName: TLMDString): Integer;
begin
  Result := FSourceNames.IndexOf(ASourceName);
end;

{------------------------------------------------------------------------------}

function TNameReplaces.DestName(AI: Integer): TLMDString;
begin
  Result := FDestNames[AI];
end;

{******************************* TEventIterator *******************************}
{---------------------------------- private -----------------------------------}

procedure TEventIterator.ObjectFound(AObject: TPersistent);
const
  PropKinds = [tkClass, tkMethod];
var
  i:     Integer;
  count: Integer;
  props: TLMDPropList;
begin
  { Prevent circular iterations }

  if FFound.IndexOf(AObject) <> -1 then
    Exit;
  FFound.Add(AObject);

  { Iterate properties }

  count := GetPropList(AObject.ClassInfo, PropKinds, nil);
  GetMem(props, count * SizeOf(Pointer));
  GetPropList(AObject.ClassInfo, PropKinds, props);
  try
    for i := 0 to count - 1 do
      PropFound(AObject, props[i]);
  finally
    FreeMem(props);
  end;

  { Iterate children }

  if AObject is TCollection then
  begin
    for i := 0 to TCollection(AObject).Count - 1 do
      ObjectFound(TCollection(AObject).Items[i])
  end
  else if AObject is TComponent then
  begin
    for i := 0 to TComponent(AObject).ComponentCount - 1 do
      ObjectFound(TComponent(AObject).Components[i])
  end;
end;
           
{------------------------------------------------------------------------------}

procedure TEventIterator.PropFound(AObject: TPersistent;
  APropInfo: TLMDPropInfo);
var
  obj: TObject;
begin
  case APropInfo.PropType^.Kind of
    tkMethod: FProc(AObject, APropInfo);
    tkClass:  begin
                obj := GetObjectProp(AObject, APropInfo);
                if obj is TPersistent then
                  ObjectFound(TPersistent(obj));
              end;
  end;
end;

{---------------------------------- public ------------------------------------}

constructor TEventIterator.Create;
begin
  inherited Create;
  FFound := TList.Create;
end;
                  
{------------------------------------------------------------------------------}

destructor TEventIterator.Destroy;
begin
  FFound.Free;
  inherited;
end;
              
{------------------------------------------------------------------------------}

class procedure TEventIterator.Iterate(ARoot: TComponent;
  AProc: TEventIteratorProc);
var
  i:    Integer;
  iter: TEventIterator;
begin
  if ARoot = nil then
    Exit;

  iter := TEventIterator.Create;
  try
    iter.FRoot := ARoot;
    iter.FProc := AProc;

    iter.ObjectFound(ARoot);
    for i := 0 to ARoot.ComponentCount - 1 do
      iter.ObjectFound(ARoot.Components[i]);
  finally
    iter.Free;
  end;
end;

{********************************* TWin32Traits *******************************}
{----------------------------------- private ----------------------------------}

procedure TWin32Traits.ReaderFindMethod(Reader: TReader;
  const MethodName: String; var Address: Pointer; var Error: Boolean);
var
  evhdr: TEventHandler;
begin
  Address := FModule.FRoot.MethodAddress(MethodName);

  if Address = nil then
  begin
    evhdr    := TEventHandler(FModule.EventHandlerNeeded(
                      FModule.FReadingEventOwner, MethodName));
    Address  := Pointer(evhdr.Id);
  end;

  Error := False;
end;
        
{------------------------------------------------------------------------------}

procedure TWin32Traits.WriteMemHack(var ADest; const ASource;
  ASize: Integer);
var
  ressz: {$IFDEF LMDCOMP16}NativeUInt{$ELSE}Cardinal{$ENDIF};
begin
  WriteProcessMemory(GetCurrentProcess, @ADest, @ASource, ASize, ressz);
  Assert(ressz = Cardinal(ASize));
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.ReplaceMethodTable;
type
  PPointer = ^Pointer;

  PMethodTable = ^TMethodTable;
  TMethodTable = packed record
    Size:       Word;
    MethodDefs: array[0..1000] of Byte;
  end;

  PMethodDef = ^TMethodDef;
  TMethodDef = packed record
    Size: Word;
    Addr: Pointer;
    Name: ShortString;
  end;

var
  i:       Integer;
  oldtbl:  PMethodTable;
  newtbl:  PMethodTable;
  oldsz:   Integer;
  ehlst:   TList;
  wval:    Word;
  mdef:    TMethodDef;
  pmdef:   PMethodDef;
  evhdr:   TEventHandler;
begin
  oldtbl := PPointer(TLMDPtrInt(FModule.Root.ClassType) + vmtMethodTable)^;
  FMdTbl := TMemoryStream.Create;

  if oldtbl <> nil then
    oldsz := oldtbl.Size
  else
    oldsz := 0;

  ehlst := TList.Create;
  try
    { Get root event handler list }

    for i := 0 to FModule.FEventHandlers.Count - 1 do
      if TEventHandler(FModule.FEventHandlers[i]).Owner = FModule.FRoot then
        ehlst.Add(FModule.FEventHandlers[i]);

    { Write method count }

    wval := oldsz + ehlst.Count;
    FMdTbl.Write(wval, SizeOf(Word));

    { Write original methods }

    if oldsz > 0 then
    begin
      pmdef := @oldtbl.MethodDefs;
      for i := 0 to oldsz - 1 do
      begin
        FMdTbl.Write(pmdef^, pmdef.Size);
        pmdef := PMethodDef(TLMDPtrInt(pmdef) + pmdef.Size);
      end;
    end;

    { Write event handler methods }

    for i := 0 to ehlst.Count - 1 do
    begin
      evhdr := TEventHandler(ehlst[i]);

      mdef.Size := SizeOf(Word) + SizeOf(Pointer) + Length(evhdr.Name) + 1;
      mdef.Addr := Pointer(evhdr.Id);
      mdef.Name := {$IFDEF LMDCOMP12}ShortString{$ENDIF}(evhdr.Name);
      FMdTbl.Write(mdef, mdef.Size);
    end;

    { Replace method table }

    newtbl := FMdTbl.Memory;
    if wval = 0 then // No zero sized ethod table. Otherwise the
      newtbl := nil; // TObject.MethodName method will raise en exception.
      
    WriteMemHack(PPointer(TLMDPtrInt(FModule.Root.ClassType) + vmtMethodTable)^,
                 newtbl, SizeOf(Pointer));

    FOldTbl := oldtbl;
  finally
    ehlst.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.RestoreMethodTable;
type
  PPointer = ^Pointer;
begin
  WriteMemHack(PPointer(TLMDPtrInt(FModule.Root.ClassType) + vmtMethodTable)^,
               FOldTbl, SizeOf(Pointer));
  FMdTbl.Free;
end;
  
{------------------------------------------------------------------------------}

procedure TWin32Traits.MarkEventHandlerProc(AInstance: TPersistent;
  APropInfo: TLMDPropInfo);
var
  evhdr: TEventHandler;
begin
  evhdr := GetEventProp(AInstance, APropInfo);
  if evhdr <> nil then
    evhdr.MarkFlag := True;
end;
                         
{------------------------------------------------------------------------------}

procedure TWin32Traits.RestoreClassNames;
var
  i:    Integer;
  item: TWin32ClassNameRepl;
begin
  for i := 0 to FClsNameRepls.Count - 1 do
  begin
    item := TWin32ClassNameRepl(FClsNameRepls[i]);

    DoReplaceClassName(item.Class_, item.OriginName);
    item.Free;
  end;
  FClsNameRepls.Clear;
end;
                    
{------------------------------------------------------------------------------}

function TWin32Traits.DoReplaceClassName(AClass: TClass;
  ANewName: PShortString): PShortString;
type
  PPShortString = ^PShortString;
var
  nmpp: PPShortString;
begin
  nmpp := PPShortString(TLMDPtrInt(AClass) + vmtClassName);

  Result := nmpp^;
  WriteMemHack(nmpp^, ANewName, SizeOf(Pointer));
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.ReplaceClassName(AClass: TClass;
  const ANewName: TLMDString);
var
  i:     Integer;
  item:  TWin32ClassNameRepl;
  oldnm: PShortString;
begin
  if AClass.ClassName = ANewName then
    Exit;

  { Find item }

  item := nil;
  for i := 0 to FClsNameRepls.Count - 1 do
    if TWin32ClassNameRepl(FClsNameRepls[i]).Class_ = AClass then
    begin
      item := TWin32ClassNameRepl(FClsNameRepls[i]);
      Break; // for
    end;

  { Create item if not found }

  if item = nil then
  begin
    item := TWin32ClassNameRepl.Create;
    item.Class_     := AClass;
    item.OriginName := nil;
    
    FClsNameRepls.Add(item);
  end;

  { Replace class name }

  item.CurName := {$IFDEF LMDCOMP12}ShortString{$ENDIF}(ANewName);
  oldnm        := DoReplaceClassName(AClass, @item.CurName);
  if item.OriginName = nil then // Remeber only original class name.
    item.OriginName := oldnm;   //
end;

{----------------------------------- public -----------------------------------}

constructor TWin32Traits.Create(AModule: TLMDModule);
begin
  inherited Create;
  FModule       := AModule;
  FClsNameRepls := TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TWin32Traits.Destroy;
begin
  FClsNameRepls.Free;// No clear. Should be empty.
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.ClearEventHandlers(AOwner: TComponent);
begin
  // No additional state. Do nothing.
end;
    
{------------------------------------------------------------------------------}

procedure TWin32Traits.MarkEventHandlers;
begin
  TEventIterator.Iterate(FModule.FRoot, MarkEventHandlerProc);
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.BeforeRead(ALevel: Integer; AReader: TReader);
begin
  AReader.OnFindMethod := ReaderFindMethod;
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.AfterRead(ALevel: Integer);
begin
 // Do nothing.
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.BeforeWrite(ALevel: Integer; AWriter: TWriter);
begin
  if  ALevel = 0 then
    ReplaceMethodTable;
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.AfterWrite(ALevel: Integer);
begin
  if ALevel = 0 then
  begin
    RestoreMethodTable;
    RestoreClassNames;
  end;
end;
    
{------------------------------------------------------------------------------}

function TWin32Traits.GetEventProp(AInstance: TPersistent;
  APropInfo: TLMDPropInfo): TEventHandler;
var
  md: TMethod;
  cd: Pointer;
begin
  md := GetMethodProp(AInstance, APropInfo);
  cd := md.Code;

  if (cd = nil) or                   // No handler or real
     (LongRec((@cd)^).Hi <> 0) then  // non-designer handler.
    Result := nil
  else
    Result := TEventHandler(FModule.FindEventHandler(LongRec((@cd)^).Lo));
end;

{------------------------------------------------------------------------------}

procedure TWin32Traits.SetEventProp(AInstance: TPersistent;
  APropInfo: TLMDPropInfo; AEventHandler: TEventHandler);
var
  md: TMethod;
begin
  if AEventHandler = nil then
  begin
    md.Data := nil;
    md.Code := nil;
  end
  else
  begin
    md.Data := nil;
    md.Code := Pointer(AEventHandler.Id);
  end;

  SetMethodProp(AInstance, APropInfo, md);
end;

{********************************* TLMDModule *********************************}
{---------------------------------- private -----------------------------------}

procedure TLMDModule.SetRoot(const Value: TWinControl);
begin
  if FRoot <> Value then
  begin
    ClearEventHandlers; // Will reset old root
                        // event properties.
    ClearFramesMap;

    if FRoot <> nil then
      FRoot.RemoveFreeNotification(Self);
    FRoot := Value;
    if FRoot <> nil then
      FRoot.FreeNotification(Self);

    DoRootChange;
  end;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDModule.SetModuleName(const Value: TLMDString);
begin
  if FModuleName <> Value then
    FModuleName := Value;
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.ReaderSetName(Reader: TReader; Component: TComponent;
  var Name: string);
var
  oldName: string;
begin
  if (FReaderNameReplaces <> nil) and not IsUniqueCompName(Name) then
  begin
    oldName := Name;
    Name    := GetUniqueCompName(Component.ClassName);

    TNameReplaces(FReaderNameReplaces).Add(oldName, Name);
  end;
end;
  
{------------------------------------------------------------------------------}

{$IFDEF LMDCOMP9}
procedure TLMDModule.ReaderFindComponentInstance(
  Reader: TReader; const Name: string; var Instance: TLMDDataTag);
var
  comp: TComponent;
begin
  if Assigned(FOnGetLoadingCompRef) then
  begin
    comp := TComponent(Instance);
    FOnGetLoadingCompRef(Self, Name, comp);
    Instance := comp;
  end;
end;
{$ENDIF}

{------------------------------------------------------------------------------}

procedure TLMDModule.ReaderCreateComponent(Reader: TReader;
  ComponentClass: TComponentClass; var Component: TComponent);
var
  frame: TCustomFrame;
begin
  if ComponentClass = TReaderUnknownMark then
  begin
    if CreateInitedFrameInstance(FCreateCompClassName, Reader.Owner, frame) then
      Component := frame;

    if Component = nil then // Not handled.
      raise EClassNotFound.CreateFmt(SClassNotFound, [FCreateCompClassName]);
  end;
end;
                                  
{------------------------------------------------------------------------------}

procedure TLMDModule.WriterFindAncestor(Writer: TWriter;
  Component: TComponent; const Name: string; var Ancestor,
  RootAncestor: TComponent);
var
  mdlnm:   TLMDString;
  basemdl: TLMDModule;
begin
  { Process frame-copy }

  if (Component <> FRoot) and LMDIsFrameCopy(Component) then
  begin
    mdlnm := GetFrameModuleName(TCustomFrame(Component));

    if Ancestor = nil then
    begin
      if GetBaseFrameModule(mdlnm, basemdl) then
      begin
        if not Component.InheritsFrom(basemdl.Root.ClassType) then
          raise ELMDModule.CreateFmt('Frame-copy ''%s'' is not inherits from ' +
                                     'provided frame module ''%s'' root class.',
                                     [Component.Name, mdlnm]);

        Ancestor     := basemdl.Root;
        RootAncestor := Ancestor;
      end
      else
      begin
        // Provide dummy ancestor to allow *inner* (that are children
        // of current component) frame-copies to be saved as 'inherited'.

        Ancestor     := WriterDummyAncestor;
        RootAncestor := Ancestor;
      end;
    end;

    IModuleTraits(FTraits).ReplaceClassName(Component.ClassType, mdlnm);
  end;

  { Process frame-copy child }

  if (Component <> FRoot) and (Component.Owner <> nil) and
     LMDIsFrameCopy(Component.Owner) then
  begin
    if LMDIsFrameCopy(Component) and
       not (csAncestor in Component.ComponentState) then
    begin
      // Inner frame-copy should be marked as csAncestor. Otherwize
      // it will be not saved as 'inherited'.

      FAncestoredComps.Add(Component);
      TComponentAccess(Component).SetAncestor(True);
    end;

    if Ancestor = nil then
    begin
      // Provide dummy ancestor to allow this child of a frame-copy
      // to be saved as 'inherited'.

      Ancestor     := WriterDummyAncestor;
      RootAncestor := Ancestor;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.ReaderError(Reader: TReader; const Message: string;
  var Handled: Boolean);
begin
  if Assigned(FOnLoadError) then
    FOnLoadError(Self, Message, Handled);
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.ReaderFindComponentClass(Reader: TReader;
  const ClassName: string; var ComponentClass: TComponentClass);
begin
  // Defer class-not-found error to component creation event.
  // This will allow frame class testing and frame instance
  // creation in one step.

  if ComponentClass = nil then // If not found by reader itself.
  begin
    ComponentClass       := TReaderUnknownMark;
    FCreateCompClassName := ClassName;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.ReaderReferenceName(Reader: TReader;
  var Name: string);
var
  i: Integer;
begin
  if FReaderNameReplaces <> nil then
  begin
    i := TNameReplaces(FReaderNameReplaces).IndexOf(Name);
    if i <> -1 then
      Name := TNameReplaces(FReaderNameReplaces).DestName(i);
  end;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDModule.RenameHandlerProc(AInstance: TPersistent;
  APropInfo: TLMDPropInfo);
var
  old: TEventHandler;
begin
  old := IModuleTraits(FTraits).GetEventProp(AInstance, APropInfo);
  if old = FRenamingOld then
    IModuleTraits(FTraits).SetEventProp(AInstance, APropInfo,
                                        TEventHandler(FRenamingNew));
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.ResetEventProc(AInstance: TPersistent;
  APropInfo: TLMDPropInfo);
var
  traits: IModuleTraits;
begin
  traits := IModuleTraits(FTraits);

  if traits.GetEventProp(AInstance, APropInfo) <> nil then // Only design
    traits.SetEventProp(AInstance, APropInfo, nil);        // time handlers.
end;
     
{------------------------------------------------------------------------------}

procedure TLMDModule.ValidateHandlerProc(AInstance: TPersistent;
  APropInfo: TLMDPropInfo);
var
  evval:  TLMDEventValue;
  cancel: Boolean;
begin
  evval  := GetEventProp(AInstance, APropInfo);
  cancel := False;

  if (evval.Owner = FRoot) and (evval.Name <> '') and
     Assigned(FOnValidateEventHandler) then
    FOnValidateEventHandler(Self, AInstance, APropInfo, evval.Name, cancel);

  if cancel then
    raise ECancelHandlerValidation.Create(''); // Not for user.
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.HookEventProc(AInstance: TPersistent;
  APropInfo: TLMDPropInfo);
var
  evval: TLMDEventValue;
begin
  evval := GetEventProp(AInstance, APropInfo);
  if (evval.Name <> '') and Assigned(FOnHookEvent) then
    FOnHookEvent(Self, AInstance, APropInfo, evval);
end;
                   
{------------------------------------------------------------------------------}

procedure TLMDModule.UpdateDesigner;
var
  dsgr: TLMDCustomDesigner;
begin
  // While loading, components are created in they initial state,
  // so active designer will show non-visual components in the left-top
  // corner of the root (or frame) because component's Left and Top
  // properties are not yet loaded.

  dsgr := LMDFindDesigner(FRoot);
  if dsgr <> nil then
    dsgr.UpdateNonvisualComponents;
end;
                   
{------------------------------------------------------------------------------}

procedure TLMDModule.CompsChangeNotification(Sender: TObject;
  AChangedComps: TList);
var
  i:        Integer;
  modified: Boolean;
begin
  if (Sender = Self) or (FRoot = nil) then
    Exit;

  modified := False;
  for i := 0 to AChangedComps.Count - 1 do
    if LMDIsObjectOwnedBy(TComponent(AChangedComps[i]), FRoot) then
    begin
      modified := True;
      Break; // for
    end;

  if modified then
    DoCompsModified;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDModule.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DESIGN;
end;

{----------------------------------- protected --------------------------------}

procedure TLMDModule.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent <> Self) then
  begin
    if AComponent = FRoot then
      Root := nil
    else
      ClearOwnedEventHandlers(AComponent);
      
    if AComponent is TCustomFrame then
      RemoveFrameFromMap(TCustomFrame(AComponent));
  end;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDModule.DoRootChange;
var
  i: Integer;
begin
  for i := 0 to FNotifiers.Count - 1 do
    ILMDModuleNotifier(FNotifiers[i]).RootChange(Self);
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.DoRootReload;
var
  i: Integer;
begin
  for i := 0 to FNotifiers.Count - 1 do
    ILMDModuleNotifier(FNotifiers[i]).RootReloaded(Self);
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.DoCompsModified;
begin
  if Assigned(FOnCompsModified) then
    FOnCompsModified(Self);
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.BeforeRead(AEventOwner: TComponent; AReader: TReader;
  out AOldEventOwner: TComponent);
begin
  if FReadLevel = 0 then
    Include(FState, msReading);

  AOldEventOwner     := FReadingEventOwner;
  FReadingEventOwner := AEventOwner;

  AReader.OnSetName               := ReaderSetName;
  AReader.OnReferenceName         := ReaderReferenceName;
  AReader.OnError                 := ReaderError;
  {$IFDEF LMDCOMP9}
  AReader.OnFindComponentInstance := ReaderFindComponentInstance;
  {$ENDIF}
  AReader.OnFindComponentClass    := ReaderFindComponentClass;
  AReader.OnCreateComponent       := ReaderCreateComponent;
  IModuleTraits(FTraits).BeforeRead(FReadLevel, AReader);

  Inc(FReadLevel);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDModule.AfterRead(AOldEventOwner: TComponent);
begin
  Dec(FReadLevel);
  IModuleTraits(FTraits).AfterRead(FReadLevel);

  FReadingEventOwner := AOldEventOwner;

  if FReadLevel = 0 then
    Exclude(FState, msReading);
end;
                                       
{------------------------------------------------------------------------------}

procedure TLMDModule.BeforeWrite(AWriter: TWriter);
begin
  if FWriteLevel = 0 then
    Include(FState, msWriting);

  AWriter.OnFindAncestor := WriterFindAncestor;
  IModuleTraits(FTraits).BeforeWrite(FWriteLevel, AWriter);
  ReplaceRootClassName;

  Inc(FWriteLevel);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDModule.AfterWrite;
begin
  Dec(FWriteLevel);
  IModuleTraits(FTraits).AfterWrite(FWriteLevel);

  if FWriteLevel = 0 then
  begin
    RemoveAncestorFlags;
    Exclude(FState, msWriting);
  end;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDModule.RemoveAncestorFlags;
var
  i: Integer;
begin
  for i := 0 to FAncestoredComps.Count - 1 do
    TComponentAccess(FAncestoredComps[i]).SetAncestor(False);
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.ReplaceRootClassName;
begin
  if (FWriteLevel = 0) and (FModuleName <> '') then
    IModuleTraits(FTraits).ReplaceClassName(FRoot.ClassType, FModuleName);
end;

{------------------------------------------------------------------------------}

function TLMDModule.FindEventHandler(AId: Integer): TObject;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FEventHandlers.Count - 1 do
    if TEventHandler(FEventHandlers[i]).Id = AId then
    begin
      Result := TEventHandler(FEventHandlers[i]);
      Exit;
    end;
end;
   
{------------------------------------------------------------------------------}

function TLMDModule.FindEventHandler(AOwner: TComponent;
  const AName: TLMDString): TObject;
var
  i:  Integer;
  eh: TEventHandler;
begin
  Result := nil;

  for i := 0 to FEventHandlers.Count - 1 do
  begin
    eh := TEventHandler(FEventHandlers[i]);

    if (eh.Owner = AOwner) and (eh.Name = AName) then
    begin
      Result := eh;
      Exit;
    end;
  end;
end;
    
{------------------------------------------------------------------------------}

function TLMDModule.EventHandlerNeeded(AOwner: TComponent;
  const AName: TLMDString): TObject;
var
  id:    Integer;
  evhdr: TEventHandler;
begin
  { Try to find existing event handler }

  Result := FindEventHandler(AOwner, AName);
  if Result <> nil then
    Exit;

  { Create new one }

  if (FEventHandlers.Count mod 32) = 0 then // Run GC sometimes only.
    CollectUnusedEventHandlers;

  id := FNextEventHandlerId;
  Inc(FNextEventHandlerId);

  evhdr       := TEventHandler.Create;
  evhdr.Owner := AOwner;
  evhdr.Name  := AName;
  evhdr.Id    := id;

  FEventHandlers.Add(evhdr);
  AOwner.FreeNotification(Self);

  Result := evhdr;
end;
                             
{------------------------------------------------------------------------------}

function TLMDModule.HasOwnedEventHandlers(AOwner: TComponent): Boolean;
var
  i:  Integer;
  eh: TEventHandler;
begin
  Result := False;

  for i := 0 to FEventHandlers.Count - 1 do
  begin
    eh := TEventHandler(FEventHandlers[i]);

    if eh.Owner = AOwner then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.RenameEventHandler(AOwner: TComponent;
  const AName, AOldName: TLMDString);
begin
  Include(FState, msEvtHdrRenaming);
  FRenamingOld := TEventHandler(FindEventHandler(AOwner, AOldName));
  FRenamingNew := TEventHandler(FindEventHandler(AOwner, AName));
  try
    if (FRenamingOld <> nil) and
       (FRenamingOld <> FRenamingNew) then
    begin
      if FRenamingNew <> nil then
      begin
        if FRoot <> nil then
          TEventIterator.Iterate(FRoot, RenameHandlerProc);
      end
      else
        TEventHandler(FRenamingOld).Name := AName;
    end;
  finally
    Exclude(FState, msEvtHdrRenaming);
    FRenamingOld := nil;
    FRenamingNew := nil;
  end;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDModule.ClearEventHandlers;
begin
  if (FRoot <> nil) and not (csDestroying in FRoot.ComponentState) then
    TEventIterator.Iterate(FRoot, ResetEventProc);

  IModuleTraits(FTraits).ClearEventHandlers(nil);

  while FEventHandlers.Count  > 0 do
    DeleteEventHandler(0);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDModule.ClearOwnedEventHandlers(AOwner: TComponent);
var
  i: Integer;
begin
  IModuleTraits(FTraits).ClearEventHandlers(AOwner);

  for i := FEventHandlers.Count - 1 downto 0 do
    if TEventHandler(FEventHandlers[i]).Owner = AOwner then
      DeleteEventHandler(i);
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.CollectUnusedEventHandlers;
var
  i: Integer;
begin
  if (msReading in FState) or (msEvtHdrRenaming in FState) then // Prevent GC.
    Exit;

  if FRoot <> nil then
  begin
    IModuleTraits(FTraits).MarkEventHandlers;

    for i := FEventHandlers.Count - 1 downto 0 do
      if not TEventHandler(FEventHandlers[i]).MarkFlag then
        DeleteEventHandler(i)
      else
        TEventHandler(FEventHandlers[i]).MarkFlag := False;
  end;
end;
            
{------------------------------------------------------------------------------}

procedure TLMDModule.DeleteEventHandler(AIndex: Integer);
var
  ownr: TComponent;
begin
  ownr := TEventHandler(FEventHandlers[AIndex]).Owner;

  TEventHandler(FEventHandlers[AIndex]).Free;
  FEventHandlers.Delete(AIndex);

  if not HasOwnedEventHandlers(ownr) then
    ownr.RemoveFreeNotification(Self);
end;
              
{------------------------------------------------------------------------------}

procedure TLMDModule.InsertFrameToMap(AFrame: TCustomFrame;
  const AModuleName: TLMDString);
var
  item: TFrameMapItem;
begin
  Assert(AModuleName <> '', 'Can''t insert frame module with empty name.');

  item := TFrameMapItem.Create;
  try
    item.Frame      := AFrame;
    item.ModuleName := AModuleName;
  except
    item.Free;
    raise;
  end;
  FFramesMap.Add(item);

  AFrame.FreeNotification(Self);
end;
             
{------------------------------------------------------------------------------}

procedure TLMDModule.RemoveFrameFromMap(AFrame: TCustomFrame);
var
  i: Integer;
begin
  i := IndexOfFrame(AFrame);
  if i <> -1 then
  begin
    TFrameMapItem(FFramesMap[i]).Free;
    FFramesMap.Delete(i);

    AFrame.RemoveFreeNotification(Self);
  end;
end;
            
{------------------------------------------------------------------------------}

function TLMDModule.IndexOfFrame(AFrame: TCustomFrame): Integer;
var
  i: Integer;
begin
  for i := 0 to FFramesMap.Count - 1 do
    if TFrameMapItem(FFramesMap[i]).Frame = AFrame then
    begin
      Result := i;
      Exit;
    end;
  Result := -1;
end;
             
{------------------------------------------------------------------------------}

procedure TLMDModule.ClearFramesMap;
begin
  while FFramesMap.Count > 0 do
    RemoveFrameFromMap(TFrameMapItem(FFramesMap[0]).Frame);
end;
             
{------------------------------------------------------------------------------}

function TLMDModule.CreateInitedFrameInstance(
  const AFrameModuleName: TLMDString; AFrameOwner: TComponent;
  out AResFrame: TCustomFrame): Boolean;
var
  ctx: TLMDModuleFrameContext;
begin
  ctx := TLMDModuleFrameContext.Create;
  try
    ctx.FOwnedModule     := Self;
    ctx.FQueryKind       := fqkLoadBase;
    ctx.FFrameModuleName := AFrameModuleName;
    ctx.FFrameOwner      := AFrameOwner;

    if Assigned(FOnQueryFrameData) then
      FOnQueryFrameData(Self, ctx.FFrameModuleName, ctx.FQueryKind, ctx);

    Result    := ctx.FHandled;
    AResFrame := ctx.FResultFrame;
  finally
    ctx.Free;
  end;
end;
           
{------------------------------------------------------------------------------}

function TLMDModule.GetBaseFrameModule(const AFrameModuleName: TLMDString;
  out AResModule: TLMDModule): Boolean;
var
  ctx: TLMDModuleFrameContext;
begin
  ctx := TLMDModuleFrameContext.Create;
  try
    ctx.FOwnedModule     := Self;
    ctx.FQueryKind       := fqkGetModule;
    ctx.FFrameModuleName := AFrameModuleName;

    if Assigned(FOnQueryFrameData) then
      FOnQueryFrameData(Self, ctx.FFrameModuleName, ctx.FQueryKind, ctx);

    Result     := ctx.FHandled;
    AResModule := ctx.FResultFrameModule;
  finally
    ctx.Free;
  end;
end;
               
{------------------------------------------------------------------------------}

procedure TLMDModule.DoLoadFrameCopy(AFrame: TCustomFrame; AStream: TStream);
var
  reader:    TReader;
  curStream,
  binStream: TStream;
  oldevowr:  TComponent;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');

  binStream := TMemoryStream.Create;
  try
    if TestStreamFormat(AStream) = sofText then
    begin
      ObjectTextToBinary(AStream, binStream);
      binStream.Position := 0;
      curStream          := binStream;
    end
    else
    begin
      AStream.ReadResHeader;
      curStream := AStream;
    end;

    AFrame.DestroyComponents;

    reader := TReader.Create(curStream, 4096);
    BeforeRead(AFrame, reader, oldevowr);
    try
      TComponentAccess(AFrame).SetInline(True); // Frame-copy always has
                                                // csInline flag.
      reader.ReadRootComponent(AFrame);
    finally
      AfterRead(oldevowr);
      reader.Free;
    end;
  finally
    binStream.Free;
  end;

  UpdateDesigner;
end;

{----------------------------------- public -----------------------------------}

constructor TLMDModule.Create(AOwner: TComponent);
begin
  inherited;
  FNotifiers          := TList.Create;
  FEventHandlers      := TList.Create;
  FNextEventHandlerId := 1; // Non zero.

  FTraits          := TWin32Traits.Create(Self); // CLR traits is no more used.
  FFramesMap       := TList.Create;
  FAncestoredComps := TList.Create;

  ModuleList.Add(Self);
  LMDRegisterComponentChangeNotification(Self, CompsChangeNotification);
end;

{------------------------------------------------------------------------------}

destructor TLMDModule.Destroy;
begin
  Destroying;
  ModuleList.Remove(Self);
  LMDUnregisterComponentChangeNotification(Self);

  Root := nil;
  ClearEventHandlers;
  ClearFramesMap;

  FTraits.Free;
  FFramesMap.Free;
  FAncestoredComps.Free;
  FEventHandlers.Free;
  FNotifiers.Free;
  FNotifiers := nil;
  inherited;
end;
   
{------------------------------------------------------------------------------}

procedure TLMDModule.AddNotifier(ANotifier: ILMDModuleNotifier);
begin
  if FNotifiers.IndexOf(ANotifier) = -1 then
    FNotifiers.Add(ANotifier);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDModule.RemoveNotifier(ANotifier: ILMDModuleNotifier);
begin
  if FNotifiers <> nil then
    FNotifiers.Remove(ANotifier);
end;
   
{------------------------------------------------------------------------------}

function TLMDModule.IsUniqueCompName(const AName: TLMDString): Boolean;
begin
  Result := True;
  if FRoot = nil then
    Exit;

  Result := (FRoot.FindComponent(AName) = nil)
end;
   
{------------------------------------------------------------------------------}

function TLMDModule.IsValidCompName(AComponent: TComponent;
  const AName: TLMDString; var AErrorMsg: TLMDString): Boolean;
begin
  Result := IsValidIdent(AName);

  if Result and Assigned(FOnValidateCompName) then
    FOnValidateCompName(Self, AComponent, AName, Result, AErrorMsg);
end;
   
{------------------------------------------------------------------------------}

procedure TLMDModule.CheckCompName(AComponent: TComponent;
  const AName: TLMDString);
var
  errmsg: TLMDString;
begin
  errmsg := '';
  if (AName <> '') and not IsValidCompName(AComponent, AName, errmsg) then
  begin
    if errmsg = '' then
      errmsg := Format(SInvalidName, [AName]);
    raise ELMDModule.Create(errmsg);
  end;
end;
    
{------------------------------------------------------------------------------}

function TLMDModule.GetUniqueCompName(const ABaseName: TLMDString): TLMDString;
var
  i: Integer;
  s: TLMDString;
begin
  Result := '';

  if Assigned(FOnGetUniqueCompName) then
    FOnGetUniqueCompName(Self, ABaseName, Result);

  if Result = '' then
  begin
    if (Length(ABaseName) >= 2) and
       ((ABaseName[1] = 't') or (ABaseName[1] = 'T')) then
      s := Copy(ABaseName, 2, MaxInt)
    else
      s := ABaseName;

    i := 0;
    repeat
      Inc(i);
      Result := Format('%s%d', [s, i]);
    until IsUniqueCompName(Result);
  end;
end;
   
{------------------------------------------------------------------------------}

function TLMDModule.GetCompRef(const ACompName: TLMDString): TComponent;
begin
  if FRoot <> nil then
    Result := FRoot.FindComponent(ACompName)
  else
    Result := nil;

  if Assigned(FOnGetCompRef) then
    FOnGetCompRef(Self, ACompName, Result);
end;
    
{------------------------------------------------------------------------------}

function TLMDModule.GetCompRefName(AComponent: TComponent): TLMDString;
begin
  Result := AComponent.Name;
  if Assigned(FOnGetCompRefName) then
    FOnGetCompRefName(Self, AComponent, Result);
end;
   
{------------------------------------------------------------------------------}

procedure TLMDModule.GetCompRefList(AClass: TComponentClass;
  AResult: TList);
var
  i:    Integer;
  comp: TComponent;
begin
  if FRoot <> nil then
  begin
    for i := 0 to FRoot.ComponentCount - 1 do
    begin
      comp := FRoot.Components[i];
      if (comp.ClassType = AClass) or
         comp.ClassType.InheritsFrom(AClass) then
        AResult.Add(comp);
    end;
  end;

  if Assigned(FOnGetCompRefList) then
    FOnGetCompRefList(Self, AClass, AResult);
end;
    
{------------------------------------------------------------------------------}

function TLMDModule.GetEventHandlerName(AInstance: TPersistent;
  const AEventName: TLMDString; AEventTypeInfo: TLMDTypeInfo): TLMDString;
begin
  Result := LMDMakeEventHandlerName(AInstance, AEventName,
                                    AEventTypeInfo, FRoot);
                                    
  if Assigned(FOnGetEventHandlerName) then
    FOnGetEventHandlerName(Self, AInstance, AEventName, AEventTypeInfo, Result);
end;
     
{------------------------------------------------------------------------------}

function TLMDModule.IsValidEventHandlerName(const AName: TLMDString): Boolean;
begin
  Result := IsValidIdent(AName);
  if Result and (FRoot <> nil) then
    Result := (FRoot.MethodAddress(AName) = nil);

  if Result and Assigned(FOnValidateEventHandlerName) then
    FOnValidateEventHandlerName(Self, AName, Result);
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.CheckEventHandler(AValue: TLMDEventValue);
begin
  if AValue.Owner = nil then
    AValue.Owner := FRoot;

  if not LMDIsOwnerValid(FRoot, AValue.Owner) then
    raise ELMDModule.CreateFmt(SLMDInvalidHandlerOwner, [AValue.Name]);

  if (AValue.Name <> '') and not IsValidEventHandlerName(AValue.Name) then
    raise ELMDModule.CreateFmt(SLMDInvalidHandlerName, [AValue.Name]);
end;
      
{------------------------------------------------------------------------------}

function TLMDModule.GetEventProp(AInstance: TPersistent;
  APropInfo: TLMDPropInfo): TLMDEventValue;
var
  evhdr: TEventHandler;
begin
  Result.Owner := nil;
  Result.Name  := '';
  if FRoot = nil then
    Exit;

  evhdr := IModuleTraits(FTraits).GetEventProp(AInstance, APropInfo);
  if evhdr <> nil then
  begin
    Result.Owner := evhdr.Owner;
    Result.Name  := evhdr.Name;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDModule.SetEventProp(AInstance: TPersistent;
  APropInfo: TLMDPropInfo; AValue: TLMDEventValue);
var
  evhdr: TEventHandler;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');
  CheckEventHandler(AValue);

  if AValue.Owner = nil then // Simplify owner providing for users. And
    AValue.Owner := FRoot;   // ensure non-nil owner.

  if AValue.Name <> '' then
    evhdr := TEventHandler(EventHandlerNeeded(AValue.Owner, AValue.Name))
  else
    evhdr := nil;

  IModuleTraits(FTraits).SetEventProp(AInstance, APropInfo, evhdr);
end;
     
{------------------------------------------------------------------------------}

procedure TLMDModule.GetEventHandlerList(AEventTypeInfo: TLMDTypeInfo;
  AResult: TLMDStrings);
begin
  if Assigned(FOnGetEventHandlerList) then
    FOnGetEventHandlerList(Self, AEventTypeInfo, AResult);
end;
   
{------------------------------------------------------------------------------}

procedure TLMDModule.EnsureEventHandlerSource(const AName,
  AOldName: TLMDString; AEventTypeInfo: TLMDTypeInfo; AShowSource: Boolean);
var
  renamed: Boolean;
begin
  if Assigned(FOnEnsureEventHandlerSource) then
  begin
    renamed := False;
    FOnEnsureEventHandlerSource(Self, ANAme, AOldName, AEventTypeInfo,
                                AShowSource, renamed);

    if renamed and (AName <> '') and (AOldName <> '') and
       (AName <> AOldName) then
      RenameEventHandler(FRoot, AName, AOldName);
  end;
end;
    
{------------------------------------------------------------------------------}

function TLMDModule.ValidateEventHandlers: Boolean;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');
  Result := True;
  try
    TEventIterator.Iterate(FRoot, ValidateHandlerProc);
  except
    on ECancelHandlerValidation do
      Result := False
    else
      raise;
  end;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDModule.HookEvents;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');
  TEventIterator.Iterate(FRoot, HookEventProc);
end;
      
{------------------------------------------------------------------------------}

procedure TLMDModule.ClipboardSave(AStream: TStream; AComponents: TList);
var
  i:      Integer;
  writer: TWriter;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');

  writer := TWriter.Create(AStream, 1024);
  BeforeWrite(writer);
  try
    writer.Root := FRoot;
    for i := 0 to AComponents.Count - 1 do
      begin
        writer.WriteSignature;
        writer.WriteComponent(TComponent(AComponents[i]));
      end;
    writer.WriteListEnd;
  finally
    AfterWrite;
    writer.Free;
  end;
end;
   
{------------------------------------------------------------------------------}

procedure TLMDModule.ClipboardLoad(AStream: TStream; AParent: TWinControl;
  AProc: TReadComponentsProc);
var
  reader:   TReader;
  oldevowr: TComponent;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');

  FReaderNameReplaces := TNameReplaces.Create;
  try
    reader := TReader.Create(AStream, 1024);
    BeforeRead(FRoot, reader, oldevowr);
    try
      reader.ReadComponents(FRoot, AParent, AProc);
    finally
      AfterRead(oldevowr);
      reader.Free;
    end;
  finally
    FReaderNameReplaces.Free;
    FReaderNameReplaces := nil;
  end;

  UpdateDesigner;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDModule.SaveToStream(AStream: TStream;
  AFormat: TStreamOriginalFormat);
var
  writer:     TWriter;
  curStream,
  textStream: TStream;
  fixupInfo:  Integer;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');

  textStream := TMemoryStream.Create;
  try
    if AFormat in [sofText, sofUnknown] then
      curStream := textStream
    else
    begin
      AStream.WriteResourceHeader(FRoot.ClassName, fixupInfo);
      curStream := AStream;
    end;

    writer := TWriter.Create(curStream, 4096);
    BeforeWrite(writer);
    try
      writer.WriteDescendent(FRoot, nil);
    finally
      AfterWrite;
      writer.Free;
    end;

    if AFormat in [sofText, sofUnknown] then
    begin
      curStream.Position := 0;
      ObjectBinaryToText(curStream, AStream);
    end
    else
      curStream.FixupResourceHeader(fixupInfo);
  finally
    textStream.Free;
  end;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDModule.LoadFromStream(AStream: TStream);
var
  reader:    TReader;
  curStream,
  binStream: TStream;
  oldevowr:  TComponent;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');

  binStream := TMemoryStream.Create;
  try
    if TestStreamFormat(AStream) = sofText then
    begin
      ObjectTextToBinary(AStream, binStream);
      binStream.Position := 0;
      curStream          := binStream;
    end
    else
    begin
      AStream.ReadResHeader;
      curStream := AStream;
    end;

    FRoot.DestroyComponents;
    ClearEventHandlers;
    ClearFramesMap;

    reader := TReader.Create(curStream, 4096);
    BeforeRead(FRoot, reader, oldevowr);
    try
      reader.ReadRootComponent(FRoot);
    finally
      AfterRead(oldevowr);
      reader.Free;
    end;
  finally
    binStream.Free;
  end;

  DoRootReload;
  UpdateDesigner;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDModule.SaveToFile(const AFileName: TLMDString;
  AFormat: TStreamOriginalFormat);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(stream, AFormat);
  finally
    stream.Free;
  end;
end;
         
{------------------------------------------------------------------------------}

procedure TLMDModule.LoadFromFile(const AFileName: TLMDString);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(stream);
  finally
    stream.Free;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDModule.ClientToScreen(const APoint: TPoint): TPoint;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');
  Result := FRoot.ClientToScreen(APoint);
end;
      
{------------------------------------------------------------------------------}

function TLMDModule.ScreenToClient(const APoint: TPoint): TPoint;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');
  Result := FRoot.ScreenToClient(APoint);
end;
            
{------------------------------------------------------------------------------}

function TLMDModule.GetFrameModuleName(AFrame: TCustomFrame): TLMDString;
var
  i: Integer;
begin
  i := IndexOfFrame(AFrame);
  if i <> -1 then
    Result := TFrameMapItem(FFramesMap[i]).ModuleName
  else
    Result := AFrame.ClassName;
end;
          
{------------------------------------------------------------------------------}

procedure TLMDModule.SetFrameModuleName(AFrame: TCustomFrame;
  const AValue: TLMDString);
begin
  if GetFrameModuleName(AFrame) <> AValue then
  begin
    RemoveFrameFromMap(AFrame);
    InsertFrameToMap(AFrame, AValue);
  end;
end;
                  
{------------------------------------------------------------------------------}

function TLMDModule.InsertFrame(const AFrameModuleName: TLMDString): TCustomFrame;
begin
  Assert(FRoot <> nil, 'Root is not assigned.');
  Assert(AFrameModuleName <> '', 'Frame module name can''t be empty.');

  Result := nil;
  if not CreateInitedFrameInstance(AFrameModuleName, FRoot, Result) then
    raise ELMDModule.CreateFmt('Frame module %s is not found.',
                               [AFrameModuleName]);
end;

{------------------------------------------------------------------------------}

procedure TCompChangeNotifList.ClearAll;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TObject(FItems[i]).Free;
  FItems.Clear;
end;

function TCompChangeNotifList.IndexOf(Akey: TObject): Integer;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    if TCompChangeNotifItem(FItems[i]).Key = AKey then
    begin
      Result := i;
      Exit;
    end;
  Result := -1;
end;

constructor TCompChangeNotifList.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

destructor TCompChangeNotifList.Destroy;
begin
  ClearAll;
  FItems.Free;
  inherited;
end;

procedure TCompChangeNotifList.Add(AKey: TObject;
  AProc: TLMDComponentChangeNotification);
var
  i:    Integer;
  item: TCompChangeNotifItem;
begin
  i := IndexOf(AKey);

  if i <> -1 then
    TCompChangeNotifItem(FItems[i]).Proc := AProc
  else
  begin
    item := TCompChangeNotifItem.Create;
    item.Key  := AKey;
    item.Proc := AProc;

    FItems.Add(item);
  end;
end;

procedure TCompChangeNotifList.Remove(AKey: TObject);
var
  i: Integer;
begin
  i := IndexOf(AKey);
  if i <> -1 then
  begin
    TObject(FItems[i]).Free;
    FItems.Delete(i);
  end;
end;

procedure TCompChangeNotifList.CallProcs(Sender: TObject; AComps: TList);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TCompChangeNotifItem(FItems[i]).Proc(Sender, AComps);
end;

initialization
  WriterDummyAncestor := TWriterDummyAncestor.Create(nil);
  CompChangeNotifs    := TCompChangeNotifList.Create;
  ModuleList          := TList.Create;

finalization
  WriterDummyAncestor.Free;
  CompChangeNotifs.Free;
  ModuleList.Free;

end.
