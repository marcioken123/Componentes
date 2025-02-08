{***************************************************************************}
{ Scripter Studio Components for Delphi & C++Builder                        }
{ version 4.7.1 (Std), 1.7.1 (Pro)                                              }
{                                                                           }
{ written by TMS Softwar                                                    }
{            copyright � 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

{$DEFINE CODE_OPTIMIZATION}

unit atScript;

{$I ASCRIPT.INC}

interface

uses
  Messages, Controls,
  {$IFNDEF LINUX}
  Windows, SysUtils, Classes, Dialogs, Forms, ComCtrls, atParser, TypInfo, Math, Contnrs
  {$ELSE}
  SysUtils, Classes, QDialogs, QForms, atParser, TypInfo, Math, Contnrs
  {$ENDIF}

  {$IFDEF DELPHI6_LVL}
  , Variants
  {$ENDIF}

  {$IFDEF DELPHI2010_LVL}
  , Rtti
  {$ENDIF}
  ;

{$WARNINGS OFF}

type
  {Internal structure}
  TInstruction = (
    inPrepare,            // Allocate space in stack for local variables
    inPushInteger,        // Push an integer in stack
    inPushDouble,         // Push a double in stack
    inPushString,         // Push a string in stack
    inPushConst,          // Push a Null variant in stack
    inPushOutput,         // Push the output result of a function in the stack
    inPushClass,          // Push a class reference in stack
    inDuplicate,          // // obsolete
    inDuplicate2,         // // obsolete
    inDrop2,              // // obsolete
    inSwap2,              // // obsolete
    inOperNE,             // Remove 2 values from stack, test if they are not equal, push the result in stack
    inOperGE,             // Remove 2 values from stack, test if first is greater or equal to second, push the result in stack
    inOperLE,             // Remove 2 values from stack, test if first is less or equal to second, push the result in stack
    inOperEqual,          // Remove 2 values from stack, test if first is equal to second, push the result in stack
    inOperGreater,        // Remove 2 values from stack, test if first is greater than second, push the result in stack
    inOperLess,           // Remove 2 values from stack, test if first is less than second, push the result in stack
    inOperAdd,            // Remove 2 values from stack, add them and push the result in stack
    inOperConcat,         // Remove 2 values from stack, concatenate them and push the result in stack
    inOperSub,            // Remove 2 values from stack, subtract the second from the first and push the result in stack
    inOperOr,             // Remove 2 values from stack, perform the logic OR operation and push the result in stack
    inOperXor,            // Remove 2 values from stack, perform the logic XOR operation and push the result in stack
    inOperMul,            // Remove 2 values from stack, multiply the first by the second and push the result in stack
    inOperSlash,          // Remove 2 values from stack, divide the first by the second and push the result in stack with "/"
    inOperDiv,            // Remove 2 values from stack, divide the first by the second and push the result in stack as integer
    inOperMod,            // Remove 2 values from stack, divide the first by the second and push the rest as the result
    inOperAnd,            // Remove 2 values from stack, perform the logic AND operation and push the result in stack
    inOperShl,            // Remove 2 values from stack, perform the logic SHL operation and push the result in stack
    inOperShr,            // Remove 2 values from stack, perform the logic SHR operation and push the result in stack
    inOperExp,            // Remove 2 values from stack, raise the first to the power of the second and push the result in stack
    inOperIs,             // Remove 2 values from stack, test if the class of the first corresponds or is derivated from the second, return the logic result of the test
    inOperNeg,            // Complement the sign of the value in top of stack
    inOperNot,            // Complement the value in top of stack using the logic NOT operation
    inJumpIfFalse,        // Remove the value in top of stack and jump if it is zero
    inJumpIfTrue,         // Remove the value in top of stack and jump if it is not zero
    inJump,               // Jump unconditionally with no return
    inStoreVar,           // Remove the value in top of stack and store it in the variable
    inStoreVarRef,        // Remove the value in top of stack and store it in the variable passed by reference
    inStoreIdxVar,        // Remove the value in top of stack and store it in the variable
    inStoreIdxVarRef,     // Remove the value in top of stack and store it in the variable passed by reference
    inStoreVarInteger,    // Store an integer parameter directly into the variable
    inStoreVarRefInteger, // Store an integer parameter directly into the variable passed by reference
    inStoreVarDouble,     // Store a numeric (non integer) parameter directly into the variable
    inStoreVarRefDouble,  // Store a numeric (non integer) parameter directly into the variable passed by reference
    inStoreVarString,     // Store a string parameter directly into the variable
    inStoreVarRefString,  // Store a string parameter directly into the variable passed by reference
    inStoreVarConst,      // Store a constant directly into the variable
    inStoreVarRefConst,   // Store a constant directly into the variable passed by reference
    inCopyVar,            // Copy the content of one variable to another without using the stack
    inCopyVarRef,         // Copy the content of one variable to another passed by reference without using the stack
    inStoreInput,         // Store a subroutine input argument in a variable
    inPushVar,            // Stack the content of a local variable
    inPushIdxVar,         // Stack the content of a local indexed variable
    inPushVarByRef,       // Stack a reference to a local variable
    inVarTest,            // Compare the value of the variable to the expression in the top of the stack, and jump to vInteger according to vByte
    inVarTestInteger,     // Compare the value of the variable to the integer parameter, and jump to vInteger according to vByte
    inVarTestDouble,      // Compare the value of the variable to the numeric (non integer) parameter, and jump to vInteger according to vByte
    inVarTestString,      // Compare the value of the variable to the string parameter, and jump to vInteger according to vByte
    inVarTestVar,         // Compare the value of the variable to the value of other variable, and jump to vInteger according to vByte
    inStoreGlobalVar,     // Remove the value in top of stack and store it in the global variable
    inStoreGlobalIdxVar,  // Remove the value in top of stack and store it in the global variable
    inPushGlobalVar,      // Stack the content of a global variable
    inPushGlobalIdxVar,   // Stack the content of a global indexed variable
    inPushGlobalVarByRef, // Stack a reference to the global variable
    inCall,               // Jump to internal subroutine
    inRet,                // Return from subroutine/end of try..except block. vInteger = 0 (ret); vInteger = 1 (try..execept)
    inExecFun,            // Execute an external function
    inCallProc,           // Execute a special procedure call
    inTryFinally,         // Execute a code block protected with guaranteed conclusion
    inTryExcept,          // Execute a code block protected with exception handling
    inCallClassProc,      // Execute a procedure call to a class member (method or property)
    inBreakPoint,         // Entry point to all debugger funcionalities
    inAbort,              // Create a silent execution
    inArrayOf,            // Create an array of variants with values in stack
    inCastClass,          // Forces the object in stack to the class defined in instruction
    inWithObject,         // Adjust the instance to be used by the next CallProc instruction (With expression)
    inGlobalPrepare,      // Allocate space in stack to global variables
    inTestIfFalse,        // Jump if current stack is false, without removing value from stack
    inTestIfTrue);        // Jump if current stack is true, without removing value from stack

const
  StackSize        = 3000; // runtime stack size
  CODEFILE_VERSION = 4;    // current scripter version
  CURRENT_VERSION  = 4;    // current scripter version

  DefaultTypeInfoFilter = [ TTypeKind(tkInteger), TTypeKind(tkChar),
    TTypeKind(tkEnumeration),TTypeKind(tkFloat),TTypeKind(tkString),
    TTypeKind(tkSet),TTypeKind(tkClass),TTypeKind(tkWChar),
    TTypeKind(tkLString),TTypeKind(tkWString),TTypeKind(tkVariant),
    {$IFDEF DELPHI2009_LVL}
    TTypeKind(tkUString),
    {$ENDIF}
    TTypeKind(tkArray) ];

type
  PInteger = ^integer;
  PBoolean = ^boolean;
  PPointer = ^pointer;
  PPChar   = ^PChar;

  {Internal structure}
  TGenericProc = procedure of object;

  /// Description:
  ///   This is the type of user-defined procedure.
  ///   Input param can contain one or more variant values. Results must be put in Output parameter.
  TBuiltInProc = procedure( Input:Variant;var Output:Variant ) of object;

  {Internal structure}
  pSimplifiedCode = ^TSimplifiedCode;

  // elements order and zise must be keeped
  // this structure was fixed on 48 bytes size
  // BE CAREFUL: when changing this structure, keep record size
  // a multiple of 8, to keep alignment in the variant part of the record

  /// Description:
  ///   TSimplifiedCode is the atomic structure for a virtual machine pseudo-code. In other words,
  ///   a compiled code is a list of TSimplified code records.
  TSimplifiedCode = record
    OpCode      : TInstruction;    // instruction op-code 1 byte
    vByte       : byte;            // first byte parameter 1 byte
    vSmallInt   : smallint;        // first smallint parameter 2 bytes
    vInteger    : integer;         // first integer parameter 4 bytes
    vInteger1   : integer;         // second integer parameter 4 bytes
    vString     : string;          // string parameter: element name 4 bytes
    vDebugInfo  : integer;         // debug information: source code position 4 bytes
    Next        : pSimplifiedCode; // Next instruction pointer 4 bytes
    Compute     : TGenericProc;    // instruction method pointer 8 bytes
    vString2    : string;          // string parameter: second element name 4 bytes
    Dummy       : integer;         // add unused 4 bytes in the record to keep record size a multiple of 8
    // Extra parameters
    case byte of
      0: ( vDouble:double );               // 1 double parameter - 8 bytes
      1: ( vProc:TGenericProc );           // 1 method parameter - 8 bytes
      2: ( vInteger2,vInteger3:integer );  // 2 adicional integer parameters - 8 bytes
  end;

  /// Summary:
  ///   Open arrays.
  intarray = array of integer;
  //openarray = array of TVarRec;

  /// Summary:
  ///   Internal structure.
  TSingleStepProc = procedure( p:pSimplifiedCode ) of object;

  /// Summary:
  ///   Internal structure.
  TStackType = (
    stPendingOperators, // stack of pending operators (unstacking follows an order of precedence)
    stIdentifierList,   // stack of identifiers of procedures and local variables
    stContext,          // generic context stack for IF, FOR, WHILE, REPEAT and ARG_LIST
    stTempVariables );  // stack of local context temporary variables (ex.: for context of structures like With)

  /// Summary:
  ///   Internal structure.
  pStackElement = ^TStackElement;
  /// Summary:
  ///   Internal structure.
  TStackElement = record
    Previous : pStackElement;
    Element  : Variant;
    Index    : integer;
  end;

  /// Summary:
  ///   Internal structure.
  pAddress = ^TAddress;
  TAddress = record
    Address : integer;         // Line number that references label
    Code    : pSimplifiedCode; // Pointer to instruction
    Next    : pAddress;        // Pointer to the next label reference
  end;

  /// Summary:
  ///   Internal structure.
  pLabelSpec   = ^TLabelSpec;
  /// Summary:
  ///   Internal structure.
  TLabelSpec   = record
    Name      : string;        // label name
    Address   : integer;       // line number where label was defined
    FirstRef  : pAddress;      // pointer to the first label reference
    LastRef   : pAddress;      // pointer to the last label reference
    Next      : pLabelSpec;    // pointer to the next label
  end;

  { SIMPLIFIED CODE FILE STRUCTURE }
  { <TCodeFileHeader> }
  { TCodeFileHeader.ImplicitRefCount * <TImplicitClassRef> }
  { N * <TInstructionDescriptor> }

  /// Summary:
  ///   atPascal simplified code file implicit class reference.
  TImplicitClassRef = record
    ClassIndex      : integer; // relative to TatClasses instance
    ElementIndex    : integer; // relative to TatMethods or TatProperties
    ElementIsMethod : boolean; // true if element is a method, false if element is a property
    ClassNameSize   : integer;
    ElementNameSize : integer;
  end;

  TUsedUnitRec = record
    UnitNameSize : integer;
    IsDefault: boolean;
    IsScript: boolean;
    DeclSourcePos: integer;
  end;

  /// Summary:
  ///   atPascal simplified code file header.
  TCodeFileHeader      = record
    Signature         : array[0..24] of char; // Signature: 'atPascal Executable File'#26
    Version           : byte;                 // Version byte identifier
    ImplicitRefCount  : integer;              // Implicit class referencing collection size
    UsedUnitCount     : integer;              // Number of used units in source code
    ScriptInfoSize    : integer;
    Reserved          : array[0..27] of byte; // for future use (always 0)
  end;

  /// Summary:
  ///   atPascal simplified instruction when saved to file.
  TInstructionDetails = record
    OpCode     : byte;
    vByte      : byte;
    vSmallInt  : smallint;
    vDebugInfo : integer;
    vInteger   : integer;
    vInteger1  : integer;
    vInteger2  : integer;
    vInteger3  : integer;
    {* vString : string *}
  end;

  /// Summary:
  ///   Descriptor for instructions when saved to file.
  TInstructionDescriptor = record
    Size: integer;
    Size2: integer;
    Details: TInstructionDetails;
  end;

  /// Summary:
  ///   Internal structure.
  TDataOperation = (
    doRead,     // leitura de dado
    doWrite,    // escrita de dado
    doExec,     // execu��o de c�digo
    doAddr  );  // endere�amento de c�digo

  /// Summary:
  ///   Class reference types.
  TClassReference = (crNone, crGetter, crSetter, crMethod);

  /// Summary:
  ///   EatScripterRuntime is raised when a runtime error occurs in script.
  EatScripterRuntime = class(Exception);
  /// Summary:
  ///   EatRuntimeError is raised when a runtime error occurs in script.
  EatRuntimeError = class(Exception);
  /// Summary:
  ///   EatCompileError is raised when a compile error occurs during script compilation.
  EatCompileError = class(Exception);
  /// Summary:
  ///   Exception raised from the scripter component.
  EatInternalError = class(Exception);
  /// Summary:
  ///   Exception raised from the scripter component.
  EatScriptInfoError = class(Exception);
  /// Summary:
  ///   Exception raised from the scripter component.
  EatDefinitionError = class(Exception);
  /// Summary:
  ///   Exception raised from the scripter component.
  EatScripterFatal = class(Exception);
  /// Summary:
  ///   Exception raised from the scripter component.
  EatScripterDebug = class(Exception);

  pAddrVector = ^TAddrVector;
  TAddrVector = array[0..0] of pSimplifiedCode;

  CORE_CONST = (coTrue, coFalse, coNull, coUnassigned, coNil);

  TatCallingConvention = (ccStdCall, ccRegister, ccPascal, ccCDecl, ccSafeCall);
  PReal = ^Real;
  {$WARNINGS OFF}
  PComp = ^Comp;
  {$WARNINGS ON}

const
  { tipos de dados adicionais (continuando a partir dos tipos declarados no System.pas }
//vtInteger    = 0;
//vtBoolean    = 1;
//vtChar       = 2;
//vtExtended   = 3;
//vtString     = 4;
//vtPointer    = 5;
//vtPChar      = 6;
//vtObject     = 7;
//vtClass      = 8;
//vtWideChar   = 9;
//vtPWideChar  = 10;
//vtAnsiString = 11;
//vtCurrency   = 12;
//vtVariant    = 13;
//vtInterface  = 14;
//vtWideString = 15;
//vtInt64      = 16;
  vtLongint    = 0100; {=0}
  vtCardinal   = 0200; {=0}
  vtLongword   = 0300; {=0}
  vtSingle     = 0400; {=0}
  vtByte       = 0502; {=2}
  vtShortint   = 0602; {=2}
  vtWord       = 0709; {=9}
  vtSmallint   = 0809; {=9}
  vtDouble     = 0912; {=12}
  vtReal       = 1012; {=12}
  vtDateTime   = 1112; {=12}
  vtComp       = 1212; {=12}

type
  TatCustomScripter = class;
  TatClasses = class;
  TatClass = class;
  TatObjects = class;
  TatObject = class;
  TatProperties = class;
  TatProperty = class;
  TatMethods = class;
  TatMethod = class;
  TatDataDefs = class;
  TatDataDef = class;
  TatClassRefs = class;
  TatClassRef = class;
  TatUsedUnits = class;
  TatUsedUnit = class;
  TatScriptInfo = class;
  TatRoutinesInfo = class;
  TatRoutineInfo = class;
  TatVariablesInfo = class;
  TatVariableInfo = class;
  TatScriptBreakPoints = class;
  TatScriptBreakPoint = class;
  TatScripts = class;
  TatScript = class;
  TatVirtualMachines = class;
  TatVirtualMachine = class;
  TatDebugWatch = class;
  TatDebugWatches = class;
  TatScripterWatch = class;
  TatScripterWatches = class;
  TScriptForm = class;
  TScriptFormClass = class of TScriptForm;

  /// Summary:
  ///   For event support.
  TatScripterEventBroker = class;
  TatEventAdapters = class;
  TatEventAdapter = class;
  TatEventDispatchers = class;
  TatEventDispatcher = class;
  TatDispatcherRemoveNotificator = class;
  TDispatcherClass = class of TatEventDispatcher;

  /// Description:
  ///   Specifies how a event handler set from script will replace a previously set event handler for the object event.
  ///   epReplaceCall: replaces the event handler (previous event handler is not called)
  ///   epTopCall: executes the new event handler, then calls the previous event handler
  ///   etBottomCall: calls the previous event handler, then execute the new event handler}
  TatEventPlacement = (epReplaceCall, epTopCall, epBottomCall);

  /// Description:
  ///   Specifies how a event handler set from script will replace a previously set event handler for the object event.
  ///   esReplaceEvent: replaces the event handler (previous event handler is not called)
  ///   esAddEventOnTop: executes the new event handler, then calls the previous event handler
  ///   esAddEventOnBottom: calls the previous event handler, then execute the new event handler}
  TEventSetMode = (esReplaceEvent, esAddEventOnTop, esAddEventOnBottom);

  /// Description:
  ///   Specifies what happens when a event handler set from script is then removed. For example, when caling UnsetEvent or
  ///   when calling from script MyButton.OnClick := '';
  ///   euReplaceNil: event handler will be empty script routine
  ///   euOriginalEvent: event handler will be the original Delphi event
  ///   euClearEvent: event handler will be set to nil pointer
  ///   euPreviousEvent: the previously set event handler will be used
  TEventUnsetMode = (euReplaceNil, euOriginalEvent, euClearEvent, euPreviousEvent);

  TExecuteEventProc = procedure(AEventDispatcher: TatEventDispatcher; var AExecute: boolean) of object;
  TSettingEventProc = procedure(Sender: TObject; AInstance: TObject; APropName: string; ARoutineName: string; AScripter:TatCustomScripter; APlacement: TatEventPlacement; var AProcede: boolean) of object;
  TSetEventProc = procedure(AEventDispatcher: TatEventDispatcher) of object;
  TUnsetEventProc = procedure(AEventDispatcher: TatEventDispatcher; var AProcede: boolean) of object;
  TTranslateMethodGetterProc = procedure(AMachine: TatVirtualMachine; AInstance:TObject; APropInfo: PPropInfo; var AValue: Variant) of object;
  TTranslateMethodSetterProc = procedure(AMachine: TatVirtualMachine; AInstance:TObject; APropInfo: PPropInfo; AValue: Variant ) of object;

  TScriptClass = class of TatScript;
  TMachineClass = class of TatVirtualMachine;
  TatScripterLibraryClass = class of TatScripterLibrary;
  TatScripterLibrary = class;

  /// Description:
  ///   Argument modifiers for use in atPascal class methods.
  TatArgumentModifier = ( moNone, moConst, moVar );

  /// Description:
  ///   Specifies which argument modifiers applies to a param.
  TatArgumentModifiers = set of TatArgumentModifier;

  /// Description:
  ///   TScriptErrorEvent event is called when an error occurs in script. The error message is provided in msg
  ///   parameter, and you can change it from here. Row and col parameters contain the position in the source code where
  ///   the error occured. ShowException is true by default. If it is true, an EatScriptRuntime (or EatCompileError) exception will be raised
  ///   with the message specified by msg. If ShowException is false, an Abort exception will raised.
  TScriptErrorEvent = procedure(Sender: TObject; var msg: string; row, col: integer; var ShowException: boolean) of object;

  /// Description:
  ///   TBeforeExecuteEvent is called before a script routine (or main block) is executed. ALabel contains the name of the
  ///   routine to be executed. If the main block is to be executed, ALabel is an empty string.
  TBeforeExecuteEvent = procedure(AMachine: TatVirtualMachine; ALabel: string) of object;

  /// Description:
  ///   TMachineProc is a multi-purpose event mostly used when a script compiled p-code is being executed by the virtual machine.
  ///   The machine executing the code is passed in AMachine parameter.
  TMachineProc = procedure(AMachine:TatVirtualMachine) of object;

  /// Description:
  ///   Type kinds for use in atPascal classes.
  TatTypeKind = ( tkNone, tkInteger, tkChar, tkEnumeration, tkFloat,
                  tkString, tkSet, tkClass, tkMethod, tkWChar, tkLString,
                  tkWString, tkVariant, tkArray, tkRecord, tkInterface,
                  tkInt64, tkDynArray
                  {$IFDEF DELPHI2009_LVL}
                  ,tkUString
                  {$ENDIF} ); // from TypInfo

  /// Description:
  ///   TWatchStatus holds the possible status for a specified scripter watch.
  ///   wsNotEvaluated - The watch value was not yet computed
  ///   wsEvaluated - The watch value was computed and is available in LastResult property
  ///   wsCompileError - The expression caused a compile error during evaluation
  ///   wsRuntimeError - The expression caused a runtime error during evaluation
  ///   wsProcessNotAvailable - The script is not running so the watch cannot be evaluated
  /// See Also:
  ///   TatScripterWatch.WatchStatus
  TWatchStatus = (wsNotEvaluated, wsEvaluated, wsCompileError, wsRuntimeError, wsProcessNotAvailable);

  {$IFDEF DELPHI2010_LVL}
  TMemberVisibilitySet = set of TMemberVisibility;
  TRedefineOption = (roNone, roInclude, roOverwrite);
  {$ENDIF}

  /// Description:
  ///   TScripterLibraryOptions holds some environment/running options for the scripts being compiled/executed.
  ///   It contains info like search path, default file extension, and some other available options.
  TScripterLibraryOptions = class(TPersistent)
  private
    FUseScriptFiles: boolean;
    FCompiledFileExt: string;
    FSourceFileExt: string;
    FFormFileExt: string;
    FSearchPath: TStrings;
    procedure SetSearchPath(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    /// Description:
    ///   SearchPath holds a list of valid directory names to be used as search paths for script compilation/execution.
    ///   Whenever the compiler (or virtual machine) finds a reference to a file and needs to find one, it will search
    ///   in the list of search paths. The order is important, it will try to find the file in the first path in the list,
    ///   if not found, the second path is used, an so on. You can use two macros in the paths:
    ///   <code>
    ///   $(CURDIR): Contains the current directory
    ///   $(APPDIR): Contains the application (.exe) directory
    ///   </code>
    ///   Example:
    ///   $(CURDIR)\MyPath}
    property SearchPath: TStrings read FSearchPath write SetSearchPath;

    /// Description:
    ///   Contains the default extension for source code files. When scripter finds a reference to a file unit (like in "uses"
    ///   clause for example), it tries to find the source code file for that file. If it doesn't find, then it tries to find
    ///   the compiled code. Similar to the way Delphi does when compiling an application.
    ///   So, for example, if SourceFileExt is ".pas", then if the script states "uses SomeFile;", the compiler will try to find
    ///   SomeFile.pas in the source path.
    property SourceFileExt: string read FSourceFileExt write FSourceFileExt;

    /// Description:
    ///   Contains the default extension for compiled unit files. When scripter finds a reference to a file unit (like in "uses"
    ///   clause for example), it tries to find the source code file for that file. If it doesn't find, then it tries to find
    ///   the compiled code. Similar to the way Delphi does when compiling an application.
    ///   So, for example, if CompiledFileExt is ".pcu", then if the compiler states "uses SomeFile;", the compiler will
    ///   try to find the source code file (for example, SomeFile.pas). If not found, the compiler will try to find SomeFile.pcu
    ///   in the source path.
    property CompiledFileExt: string read FCompiledFileExt write FCompiledFileExt;

    /// Description:
    ///   Contains the default extension for form files. When scripter finds a reference to a form ($FORM directive), it tries
    ///   to find the form (dfm) file in the source path. The FormFileExt extension is used as the extension of that file.
    property FormFileExt: string read FFormFileExt write FFormFileExt;

    /// Description:
    ///   When UseScriptFiles is true, the scripter enabled file-based script libraries. For example, if the script has the
    ///   following uses clause:
    ///   <code>
    ///   uses MyScript;
    ///   </code>
    ///   If MyScript is a library added from code (imported by import tool, for example), then everything works ok. If the
    ///   MyScript library is not found, an error occurs.
    ///   But if UseScriptFiles is set to true, it also tries to find script files in the search path with name MyScript.
    ///   The default file extension is specified by SourceFileExt and CompiledFileExt. So, for example, the compiler tries
    ///   to find MyScript.pas or MyScript.pcu files in search path. If found, then the file is also compiled and used as a library
    ///   by the original script.
    ///   By default, UseScriptFiles is false.
    property UseScriptFiles: boolean read FUseScriptFiles write FUseScriptFiles;
  end;

  TElementContext = record
    HasArgList: boolean;
    HasUpnode: boolean;
    HasSubNode: boolean;
    IsNewClause: boolean;
    Operation: TDataOperation;
    ArgCount: integer;
    IdxCount: integer;
    RepeatChecking: boolean;
    ElementName: string;
    CurrentClass: TatClass;
  end;

  TUnknownElementEvent = procedure(Sender: TObject; var Context: TElementContext) of object;

  /// Description:
  ///   TatCustomScripter component is the base class for all scripter components (TatPascalScripter, TatBasicScripter,
  ///   TatScripter, etc.). TatCustomScripter holds a collection of scripts in the Scripts property. You can add scripts,
  ///   compile and execute. For the scripts to access Delphi variables, classes, methods and properties, the scripter must
  ///   know that information. Some properties and methods and provides to registered such information, like DefineMethod,
  ///   DefineClass, etc. All registered information about available classes, methods and properties are kept in Classes
  ///   property collection.
  TatCustomScripter = class(TComponent)
  private
    { scripter configuration }
    FDeferObjectResolution      : boolean;       // permite o adiamento da resolu��o de classes para runtime
    FScriptClass                : TScriptClass;  // descendente de TatScript a ser usado
    FMachineClass               : TMachineClass; // descendente de TatVirtualMachine a ser usado
    FTypeInfoFilter             : TTypeKinds;    // knowledgeable types on RTTI member loading
    { aggregated parts }
    FScripts                    : TatScripts;    // cole��o interna de scripts
    FCurrentScript              : TatScript;     // script padr�o do componente
    FDefaultInstances           : TatObjects;    // inst�ncias padr�o
    FClasses                    : TatClasses;    // classes conhecidas
    FLibInstances               : TList;         // inst�ncias das bibliotecas conhecidas
    FInternalInstance           : TatObject;     // to store global members
    { PCode - memory stream }
    FPCode                      : TMemoryStream; // for streamming purpose
    FOptionExplicit             : boolean;
    FOnCompileError             : TScriptErrorEvent;
    FOnRuntimeError             : TScriptErrorEvent;
    FOnBeforeExecute            : TBeforeExecuteEvent;
    { event handling }
    FOnTranslateMethodGetter    : TTranslateMethodGetterProc; // for internal purpose
    FOnTranslateMethodSetter    : TTranslateMethodSetterProc; // for internal purpose
    FEventSupport               : boolean;
    FEventSetMode               : TEventSetMode;
    FEventUnsetMode             : TEventUnsetMode;
    FEventBroker                : TatScripterEventBroker;
    FLoadedScripts              : TList;
    FShortBooleanEval: boolean;
    FSaveCompiledCode: boolean;
    FLibOptions: TScripterLibraryOptions;
    FAllowDLLCalls: boolean;
    FOnUnknownElement: TUnknownElementEvent;
    FOnRunningChanged: TNotifyEvent;
    FOnDebugHook: TNotifyEvent;
    FOnSingleDebugHook: TNotifyEvent;
    FLastRunning: boolean; //holds the last overall running status for the scripter
    FOnBreakpointStop: TNotifyEvent;
    FWatches: TatScripterWatches;
    FScriptFormClass: TScriptFormClass;
    FLoadFormEvents: boolean;
    //FOnExecuteEvent  : TExecuteEventProc;
    //FOnSettingEvent  : TSettingEventProc;
    //FOnSetEvent      : TSetEventProc;
    //FOnUnsettingEvent    : TUnsetEventProc;
    {internal}
    procedure ReadPCodeProp(Stream: TStream);
    procedure WritePCodeProp(Stream: TStream);
    function PCodeEquals(pcode: TStream): boolean;
    function GetBreakPoints: TatScriptBreakPoints;
    function GetCompiled: boolean;
    function GetCurrentObject: TObject;
    function GetCurrentClass: TatClass;
    function GetFirstInstruction: pSimplifiedCode;
    function GetHalted: boolean;
    function GetLastExceptionClassName: string;
    function GetLastExceptionHelpContext: integer;
    function GetLastExceptionMessage: string;
    function GetNextInstruction: pSimplifiedCode;
    function GetOnExecHook: TNotifyEvent;
    function GetOnPauseChanged: TNotifyEvent;
    function GetPaused: boolean;
    function GetRunning: boolean;
    function GetSourceCode: TStrings;
    procedure SetCompiled(const Value: boolean);
    procedure SetOnExecHook(const Value: TNotifyEvent);
    procedure SetOnPauseChanged(const Value: TNotifyEvent);
    procedure SetPaused(const Value: boolean);
    procedure SetRunning(const Value: boolean);
    procedure SetSourceCode(const Value: TStrings);
    procedure CreateLibraries;
    procedure SetClasses(const Value: TatClasses);
    function GetScriptInfo: TatScriptInfo;
    procedure SetEventSetMode(const Value: TEventSetMode);
    procedure SetEventSupport(const Value: boolean);
    procedure SetEventUnsetMode(const Value: TEventUnsetMode);
    procedure TranslateMethodGetter(AMachine: TatVirtualMachine; AInstance:TObject; APropInfo: PPropInfo; var AValue: Variant);
    procedure TranslateMethodSetter(AMachine: TatVirtualMachine; AInstance:TObject; APropInfo: PPropInfo; AValue: Variant );
    function GetOnExecuteEvent: TExecuteEventProc;
    function GetOnSetEvent: TSetEventProc;
    function GetOnSettingEvent: TSettingEventProc;
    function GetOnUnsettingEvent: TUnsetEventProc;
    procedure SetOnExecuteEvent(const Value: TExecuteEventProc);
    procedure SetOnSetEvent(const Value: TSetEventProc);
    procedure SetOnSettingEvent(const Value: TSettingEventProc);
    procedure SetOnUnsettingEvent(const Value: TUnsetEventProc);
    procedure FreeLibInstances;
    procedure InternalCompileError(msg: string; debuginfo: integer; AScript: TatScript); overload;
    procedure InternalCompileError(msg: string; row,col: integer; AScript: TatScript); overload;
    procedure InternalRuntimeError(msg: string; AScript: TatScript);
    procedure SetOnBeforeExecute(const Value: TBeforeExecuteEvent);
    function GetSilentCompiled: boolean;
    procedure SetSilentCompiled(const Value: boolean);
    function DoSaveCompiledCode: boolean;
    function FindFileInSearchPath(const CompName, SrcName: string): string;
    function FindScriptFile(AName: string): string;
    function IsFileRegisteredAsLibrary(AFileName: string; var ALib: TatScripterLibrary): boolean;
    procedure SetLibOptions(const Value: TScripterLibraryOptions);
    function GetCallExecHookEvent: boolean;
    procedure SetCallExecHookEvent(const Value: boolean);
    function FindFormFile(AName: string): string;
    procedure ScriptFormCreateProc(AMachine: TatVirtualMachine);
    procedure ComponentCreateProc(AMachine: TatVirtualMachine);
    procedure CheckRunningChanged(AMachine: TatVirtualMachine);
    function IsAnyRunning: boolean;
    function GetCurrentDebugScript: TatScript;
    procedure SetScriptFormClass(const Value: TScriptFormClass);
    {$IFDEF DELPHI2010_LVL}
    function ScrClassType(AType: TRttiType): TClass;
    function ScrPrepareValue(AType: TRttiType; AValue: variant): TValue;
    function ScrTypeKind(AType: TRttiType): TatTypeKind;
    procedure GenericMethodMachineProc(AMachine: TatVirtualMachine);
    procedure GenericPropGetterMachineProc(AMachine: TatVirtualMachine);
    procedure GenericPropSetterMachineProc(AMachine: TatVirtualMachine);
    procedure GenericFieldGetterMachineProc(AMachine: TatVirtualMachine);
    procedure GenericFieldSetterMachineProc(AMachine: TatVirtualMachine);
    procedure GenericRecordFieldGetterMachineProc(AMachine: TatVirtualMachine);
    procedure GenericRecordFieldSetterMachineProc(AMachine: TatVirtualMachine);
    procedure RecordCreateProc(AMachine: TatVirtualMachine);
    procedure RecordFreeProc(AMachine: TatVirtualMachine);
    {$ENDIF}
  protected
    procedure DoCompileError(msg: string; row,col: integer; var AShow: boolean; AScript: TatScript); virtual;
    procedure Loaded; override;
    procedure DoUnknownElement(var Context: TElementContext);
    procedure BeforeExecute( AMachine: TatVirtualMachine; ALabel: string);
    procedure DefineInternalClasses; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure BeforeCompile; virtual;
    procedure BeforeLoadCode; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoRunningChanged(AMachine: TatVirtualMachine); virtual;
    function DoDebugHook(AMachine: TatVirtualMachine): boolean; virtual;
    procedure SingleDebugHook(AMachine: TatVirtualMachine); virtual;
    procedure SourceCodeChanged(AScript: TatScript); virtual;
    function DefaultScriptClass: TScriptClass; virtual;
    procedure DoBreakpointStop; virtual;
    property ScriptClass: TScriptClass read FScriptClass write FScriptClass;
    property MachineClass: TMachineClass read FMachineClass write FMachineClass;
    property OnTranslateMethodGetter: TTranslateMethodGetterProc read FOnTranslateMethodGetter write FOnTranslateMethodGetter;
    property OnTranslateMethodSetter: TTranslateMethodSetterProc read FOnTranslateMethodSetter write FOnTranslateMethodSetter;
    property EventSupport     : boolean read FEventSupport write SetEventSupport default True;
    property EventSetMode     : TEventSetMode read FEventSetMode write SetEventSetMode default esReplaceEvent;
    property EventUnsetMode   : TEventUnsetMode read FEventUnsetMode write SetEventUnsetMode default euReplaceNil;
    property OnExecuteEvent   : TExecuteEventProc read GetOnExecuteEvent write SetOnExecuteEvent;
    property OnSettingEvent   : TSettingEventProc read GetOnSettingEvent write SetOnSettingEvent;
    property OnSetEvent       : TSetEventProc     read GetOnSetEvent     write SetOnSetEvent;
    property OnUnsettingEvent : TUnsetEventProc   read GetOnUnsettingEvent   write SetOnUnsettingEvent;
  public
    /// Description:
    ///   Create component method.
    constructor Create( AOwner:TComponent ); override;

    /// Description:
    ///   Destroy component method.
    destructor Destroy; override;

    /// Description:
    ///   Initialize all internal structures, disposing memory resources and clearing internal state
    ///   variables. This method is automaticlly called before any compiling.
    procedure Clear; virtual;

    /// Description:
    ///   Load compiled code from the file specified by AFileName parameter.
    procedure LoadCodeFromFile(AFileName: string);

    /// Description:
    ///   Save compiled code in the file specified by AFileName parameter.
    procedure SaveCodeToFile(AFileName: string);

    /// Description:
    ///   Load compiled code from the stream specified by AStream parameter.
    procedure LoadCodeFromStream(AStream: TStream);

    /// Description:
    ///   Save compiled code in the stream specified by AStream parameter.
    procedure SaveCodeToStream(AStream: TStream);

    /// Description:
    ///   This method is deprecated. Use DefineMethod instead.
    ///   Add a new user-function to the TatPascalScripter component.
    ///   Input argument for TBuiltInProc always is a variant array of variants. As atPascal allows free
    ///   parameter transfering, the user's implemented functions always should test length and variant
    ///   types of input arguments. Output variant may be a single variant value or a variant array of
    ///   variants. Although atPascal explicitly manipulate only strings and double values you are able
    ///   to use or produce another variant types, such as varInteger, varDate, varDouble, varVariant
    ///   and others.
    procedure AddFunction(Name:string; Address:TBuiltInProc);

    /// Description:
    ///   Compile the current script. See TatScript.Compile for more details.
    procedure Compile; virtual;

    /// Description:
    ///   SilentCompile does the same job of Compile, but instead it continue compilations if any error
    ///   occurs. The Compiled flag is not set in this case, but some information about source code is loaded.
    ///   In it calls SilentCompile method of current script. See TatScript.SilentCompile for more information.
    procedure SilentCompile;

    /// Description:
    ///   Executes the current script. If the script is not compiled, compilation is performed automatically.
    ///   The input parameter is deprecated and not used anymore.
    ///   The Execute function result contains value returned by the script main block. In pascal, you can use
    ///   return variable to pass the return value, even in the script main block.
    ///   In Basic, you must set MAIN variable to provide the return value.
    function Execute: variant; overload; virtual;
    function Execute( input:variant ):variant; overload; virtual;

    /// Description:
    ///   Executes a specific routine (procedure) declared in current script. If
    ///   program is still not compiled, compilation is performed automatically.
    ///   ALabel must contain the name of the routine to be execute, no matching case is performed.
    ///   if the routine doesn't exist, an exception is raised. You can previously check if the routine
    ///   exists using TatScriptInfo.RoutineByName method.
    ///   Input parameter can contain values that will be passed to the script routine. Input
    ///   can be a single Variant-type value, or an array of variant, or an array of const.
    ///   These values are passed to the script routine as parameters. If the routine parameter is declared
    ///   as a parameter by reference - for example, MyScriptFunction(var MyParam: integer); - then to have your
    ///   variable to be updated, you must use the array of const version of ExecuteSubRoutine, passing a variant of
    ///   type Variant. Example:
    ///   <code>
    ///   //script
    ///   procedure MultiplyMyVar(var AValue: integer; AFactor: integer);
    ///   begin
    ///     AValue := AValue * AFactor;
    ///   end;
    ///   //Delphi
    ///   var
    ///     SomeVar: Variant; //MUST BE of Variant type
    ///   begin
    ///     SomeVar := 10;
    ///     atScripter1.ExecuteSubroutine('DoubleMyVar', [SomeVar, 3]);
    ///    //At this point, SomeVar will have value of 30
    ///   end;
    ///   </code>
    ///   The ExecuteSubRoutine function result contains value returned by the called function.
    function ExecuteSubroutine( ALabel:string; input:variant ):variant; overload;
    function ExecuteSubroutine( ALabel:string ):variant; overload;
    function ExecuteSubroutine( ALabel:string; input:array of const ):variant; overload;

    /// Description:
    ///   Calls GetArrayIndex for current virtual machine. See TatVirtualMachine.GetArrayIndex.
    function GetArrayIndex(ADim:integer):variant;

    /// Description:
    ///   Calls InputArgCount for current virtual machine. See TatVirtualMachine.InputArgCount.
    function InputArgCount: integer;

    /// Description:
    ///   Calls GetInputArg for current virtual machine. See TatVirtualMachine.GetInputArg.
    function GetInputArg(AIndex:integer):variant;

    /// Description:
    ///   Calls GetInputArgAsString for current virtual machine. See TatVirtualMachine.GetInputArgAsString.
    function GetInputArgAsString(AIndex:integer):string;

    /// Description:
    ///   Calls GetInputArgAsClass for current virtual machine. See TatVirtualMachine.GetInputArgAsClass.
    function GetInputArgAsClass(AIndex: integer): TClass;

    /// Description:
    ///   Calls GetInputArgAsWideString for current virtual machine. See TatVirtualMachine.GetInputArgAsWideString.
    function GetInputArgAsWideString(AIndex:integer):Widestring;

    /// Description:
    ///   Calls GetInputArgAsInteger for current virtual machine. See TatVirtualMachine.GetInputArgAsInteger.
    function GetInputArgAsInteger(AIndex:integer):integer;

    /// Description:
    ///   Calls GetInputArgAsBoolean for current virtual machine. See TatVirtualMachine.GetInputArgAsBoolean.
    function GetInputArgAsBoolean(AIndex:integer):boolean;

    /// Description:
    ///   Calls GetInputArgAsFloat for current virtual machine. See TatVirtualMachine.GetInputArgAsFloat.
    function GetInputArgAsFloat(AIndex:integer):double;

    /// Description:
    ///   Calls GetInputArgAsDateTime for current virtual machine. See TatVirtualMachine.GetInputArgAsDateTime.
    function GetInputArgAsDateTime(AIndex:integer):TDateTime;

    /// Description:
    ///   Calls SetInputArg for current virtual machine. See TatVirtualMachine.SetInputArg.
    procedure SetInputArg(AIndex: integer; const AValue: variant);

    /// Description:
    ///   Calls SetInputArgIfByRef for current virtual machine. See TatVirtualMachine.SetInputArgIfByRef.
    procedure SetInputArgIfByRef(AIndex: integer; const AValue: variant);

    /// Description:
    ///   Calls ReturnOutputArg for current virtual machine. See TatVirtualMachine.ReturnOutputArg.
    procedure ReturnOutputArg(AValue: variant);

    /// Description:
    ///   Convert a script source position to a row and column information.
    procedure GetRowColFromSource(APos:integer;var row,col:integer);

    /// Description:
    ///   Calls SolveAbsoluteAddressing for current virtual machine. See TatVirtualMachine.SolveAbsoluteAddressing.
    procedure SolveAbsoluteAddressing;

    /// Description:
    ///   Calls Halt for current virtual machine. See TatVirtualMachine.Halt.
    procedure Halt;

    /// Description:
    ///   Calls InstructionByLine for current virtual machine. See TatVirtualMachine.InstructionByLine.
    function InstructionByLine(ARow: integer): pSimplifiedCode;

    /// Description:
    ///   Calls EntryPoint for current virtual machine. See TatVirtualMachine.EntryPoint.
    function EntryPoint(ALabel: string): pSimplifiedCode;

    /// Description:
    ///   Calls DebugTraceInto for current virtual machine. See TatVirtualMachine.DebugTraceInto.
    procedure DebugTraceInto;

    /// Description:
    ///   Calls DebugStepOver for current virtual machine. See TatVirtualMachine.DebugStepOver.
    procedure DebugStepOver;

    /// Description:
    ///   Calls DebugTraceIntoLine for current virtual machine. See TatVirtualMachine.DebugTraceIntoLine.
    procedure DebugTraceIntoLine;

    /// Description:
    ///   Calls DebugStepOverLine for current virtual machine. See TatVirtualMachine.DebugStepOverLine.
    procedure DebugStepOverLine;

    /// Description:
    ///   Calls DebugRunUntilReturn for current virtual machine. See TatVirtualMachine.DebugRunUntilReturn.
    procedure DebugRunUntilReturn;

    /// Description:
    ///   Calls DebugRunToPoint for current virtual machine. See TatVirtualMachine.DebugRunToPoint.
    procedure DebugRunToPoint(AInstruction:pSimplifiedCode);

    /// Description:
    ///   Calls DebugRunToLine for current virtual machine. See TatVirtualMachine.DebugRunToLine.
    procedure DebugRunToLine(ALine:integer);

    /// Description:
    ///   Calls DebugToggleBreakPoint for current virtual machine. See TatVirtualMachine.DebugToggleBreakPoint.
    function DebugToggleBreakPoint(AInstruction: pSimplifiedCode):boolean;

    /// Description:
    ///   Calls DebugToggleBreakLine for current virtual machine. See TatVirtualMachine.DebugToggleBreakLine.
    function DebugToggleBreakLine(ALine:integer):pSimplifiedCode;

    /// Description:
    ///   Calls DebugExecutionLine for current virtual machine. See TatVirtualMachine.DebugExecutionLine.
    function DebugExecutionLine: integer;

    /// Description:
    ///   Calls ExpandedDebugInfo for current script. See TatScript.ExpandedDebugInfo.
    function ExpandedDebugInfo: boolean;

    /// Description:
    ///   Calls ExpandDebugInfo for current script. See TatScript.ExpandDebugInfo.
    procedure ExpandDebugInfo(RequiresCompilation: boolean = true);

    /// Description:
    ///   Same as Classes.ClassByName, please refer to TatClasses reference.
    function ClassByName(AName:string):TatClass;

    /// Description:
    ///   Deprecated. Use DefineClass instead.
    function AddClass(AName,AAncestorName:string):TatClass;

    /// Description:
    ///   Deprecated. Use DefineClass instead.
    function AddDelphiClass(AClass:TClass):TatClass; // obsolete

    /// Description:
    ///   Same as Classes.DefineClass, please refer to TatClasses reference.
    function DefineClass(AClass: TClass; AClassName: string = ''): TatClass;

    {$IFDEF DELPHI2010_LVL}
    /// Description:
    ///   Register a record structure to be used in Scripter like a class
    ///   (see TatClasses.AddRecord) and define constructor/destructor methods.
    function DefineRecord(ATypeInfo: PTypeInfo; ARecordName: string = ''): TatClass;
    {$ENDIF}

    /// Description:
    ///   Registers the component specified by AComp to be accessible from all scripts. The component will be accessible
    ///   by its name. Published properties of component will also be automatically available for reading/writing.
    procedure AddComponent(AComp: TComponent);

    /// Description:
    ///   Register all the components owned by AComp to be accessible from all scripts. The components will be accessible
    ///   by their name. Published properties of components will also be automatically available for reading/writing.
    ///   Be aware that AComp itself is not register - only the components owned by it.
    procedure AddComponents(AComp:TComponent);

    /// Description:
    ///   DefineFormClass is similar to DefineClass, with the difference that all components owned by the form
    ///   are made available as properties of the form class. This way if you have an object MyForm you can access
    ///   their components directly using for example MyForm.Edit1.
    function DefineFormClass(AForm: TCustomForm; AFormClassName: string = ''): TatClass;

    /// Description:
    ///   AddForm registers the form instance specified by AForm to be accessible from all scripts. The form will be
    ///   accessible by its name. AddForm is similar to AddComponent, but the difference is that all components owned by the form
    ///   are made available as properties of the form class. This way if you have an object MyForm you can access
    ///   their components directly using for example MyForm.Edit1.
    procedure AddForm(AForm: TCustomForm; AFormClassName:string='');

    /// Description:
    ///   AddDataModule registers the data module instance specified by ADataModule to be accessible from all scripts. The data module will be
    ///   accessible by its name. AddDataModule is similar to AddComponent, but the difference is that all components owned by the data module
    ///   are made available as properties of the data module class. This way if you have an object MyDataModule you can access
    ///   their components directly using for example MyDataModule.Table1.
    procedure AddDataModule(ADataModule: TDataModule; ADataModuleClassName:string='');

    /// Description:
    ///   Register the object specified by AObject to be acessible from all scripts. The object will be acessible by the name specified
    ///   by AName. Published properties of component will also be automatically available for reading/writing.
    ///   This method is similar to AddComponent, with the difference that you must specify the name from which the object will
    ///   be acessible from script.
    procedure AddObject( AName:string; AObject:TObject );

    /// Description:
    ///   Register a constant specified by AValue to be accessible from all scripts by the name AName. Example:
    ///   AddConstant('Pi', 3.1415);
    procedure AddConstant( AName:string; AValue:variant );

    /// Description:
    ///   AddVariable is deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:variant ); overload;
    /// Description:
    ///   AddVariable is deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:extended  ); overload;
    /// Description:
    ///   AddVariable is deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:double  ); overload;
    /// Description:
    ///   AddVariable is deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:string  ); overload; 
    /// Description:
    ///   AddVariable is deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:widestring  ); overload;
    /// Description:
    ///   AddVariable is deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:integer ); overload;
    /// Description:
    ///   AddVariable is deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:boolean ); overload;

    /// Description:
    ///   Adds an enumerated type to be accessible from all scripts. All enumerated type items will be accessible from all scripts
    ///   by their name, and the value will be the integer value of enumerated type item. Only enumerated types with RTTI
    ///   can be included using this method. A better and more generic approach is to use AddConstant for each enumerated type:
    ///   <code>
    ///   AddConstant('alClient', alClient);
    ///   </code>
    procedure AddEnumeration( ATypeInfo: PTypeInfo );

    /// Description:
    ///   Use DefineProp to define a "global" property. DefineProp can be called from an existing TatClass object to register a new
    ///   property in that class. When you call DefineProp directly from scripter component, the property is not included in a class,
    ///   but globally in scripter. Thus the property will behave as a global variable, being accessible from all scripts without
    ///   needing to define an object from which the property will be used.
    ///   For more details about usage of DefineProp, see TatClasses.DefineProp.
    /// See Also:                                           
    ///   TatClass.DefineProp
    function DefineProp(AName:string;ADataType:TatTypeKind;AGetter,ASetter:TMachineProc;APropertyClass:TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0):TatProperty;

    /// Description:
    ///   Use DefineMethod to define a "global" method. DefineMethod can be called from an existing TatClass object to register a new
    ///   method in that class. When you call DefineMethod directly from scripter component, the method is not included in a class,
    ///   but globally in scripter. Thus the method will behave as a regular procedure/function, being accessible from scripts without
    ///   needing to define an object from which the method will be called.
    ///   For more details about usage of DefineMethod, see TatClasses.DefineMethod.
    /// See Also:
    ///   TatClass.DefineMethod
    function DefineMethod(AName: string; AArgCount: integer; AResultDataType: TatTypeKind; AResultClass: TClass;
      AProc: TMachineProc; AIsClassMethod: boolean = false; ADefArgCount: integer = 0):TatMethod;

    /// Description:
    ///   UsesObject makes methods and properties of AObject to be accessible directly from script. In other words, the methods of
    ///   the object behave as regular procedures, and properties as global variables. For example, if you have the object MyObj for the
    ///   class TMyClass and that class is registered in scripter with method MyMethod and property MyProperty. If you call
    ///   <code>
    ///   UsesObject(MyObj);
    ///   </code>
    ///   then you will be able to use MyMethod and MyProperty directly from script as if they were global:
    ///   <code>
    ///   //Script:
    ///   MyProperty := SomeValue;
    ///   MyMethod(Param1);
    ///   </code>
    ///   Alternatively you can specify the name of object using AName. In this case, you can optionally also use the name of object
    ///   as if it were a regular object. Using methods and properties directly still works. Example:
    ///   <code>
    ///   UsesObject(MyObj, 'MyObj');
    ///
    ///   //Script:
    ///   MyObj.MyProperty := SomeValue;
    ///   MyObj.MyMethod(Param1);
    ///   MyProperty := SomeValue;
    ///   MyMethod(Param1);
    ///   </code>
    ///   Just like any other object in scripter, only published properties will be accessible, unless you previously
    ///   register the class of the object and register its methods and properties. Do not use AClassName parameter, it's
    ///   for internal use.
    function UsesObject(AObject:TObject; AName: string = ''; AClassName: string = ''):TatClass;

    /// Description:
    ///   AddLibraryInstance adds a new library to be available in scripter. You should rarely use this method, call AddLibrary instead.
    ///   AddLibraryInstance requires an already instantiated TatScripterLibrary object, to be passed in ALibrary parameter.
    ///   AName must contain the name which the library instance will be accessible (e.g., if AName is "MyLibrary", you access
    ///   library methods and properties with MyLibrary.MyMethod). Used only if AddMethod is true.
    ///   ADefault parameter indicates if the library methods and properties will be accessible from all scripts without needing
    ///   to use the library name prefix. For example, if ADefault is true, you can directly access MyMethod from script, without
    ///   needing to use MyLibrary.MyMethod.
    ///   AddMethod allows you to access library methods and properties as if the library was an object. The object name is
    ///   specified by AName parameter. (e.g., if AddMethod is true and AName is "MyLibrary", you access library methods and
    ///   properties using MyLibrary.MyMethod).
    ///   LibName is the name of the class of the library. You can use it, for example, when the library has class methods.
    ///   If LibName is empty, the name of the Delphi class will be used. For example, if the class of your library is TatMyLibrary,
    ///   and LibName is empty, you can access class methods using TatMyLibrary.MyClassMethod. If LibName is not empty, for example,
    ///   if LibName is "TMyNewLibraryClassName", then you can access class methods using TMyNewLibraryClassName.MyClassMethod.
    ///   AddLibraryInstance calls the Init method of library to perform the registration of the library.
    procedure AddLibraryInstance(ALibrary: TatScripterLibrary; AName: string;
      ADefault: boolean = true; AddMethod: boolean = true; LibName: string = '');

    /// Description:
    ///   RemoveLibraryInstance removes a library instance previously registered with AddLibraryInstance. If the library was
    ///   previously registered using a method name, then you must provide the AName method for the library to be removed.
    ///   RemoveLibraryInstance calls library's Finalize method to perform finalization operations. It's up to the library to
    ///   include correct code in Finalize method to remove previously classes, methods and properties registered by Init method.
    procedure RemoveLibraryInstance(ALibrary: TatScripterLibrary; AName: string);

    /// Description:
    ///   AddLibrary registers the library specified by ALibraryClass in the scripter registration system. You don't need to
    ///   instantiate the library, just provide the name of the library class. Scripter will automatically instantiate it
    ///   and call AddLibraryInstance method to register the library. The library's Init method will be called to initiate the
    ///   library. If the library class has been already registered, nothing will be done.
    ///   The methods and properties of the library will be accessible through the name specified by LibraryName method declared
    ///   in the library class. For example, if LibraryName returns 'MyLibrary', then methods and properties will be accessible this way:
    ///   <code>
    ///   MyLibrary.MyMethod;
    ///   </code>
    ///   If ADefault parameter is true, you have the option to omit library name and call the method directly from script:
    ///   <code>
    ///   MyMethod;
    ///   </code>
    ///   Example of usage:
    ///   atScripter1.AddLibrary(TatButtonsLibrary);
    function AddLibrary(ALibraryClass: TatScripterLibraryClass; ADefault: boolean = true): TatScripterLibrary;

    /// Description:
    ///   FindLibraryByClass searches for all libraries registered in the scripter and returns the library instance if found.
    ///   If there are no registered libraries of the class ALibraryClass, then the function returns false. Example:
    ///   <code>
    ///   MyClassesLibrary := atScripter1.FindLibraryClass(TatClassesLibrary);
    ///   </code>
    function FindLibraryByClass(ALibraryClass: TatScripterLibraryClass): TatScripterLibrary;

    /// Description:
    ///   LoadLibrary loads a library with the name specified by ALibraryName. LoadLibrary is the most generic way to load
    ///   libraries, since it tries to load different kinds of libraries (Delphi-based libraries, file-based libraries, etc.)
    ///   given an unique name. When the compiler finds an "uses" clause in the script, it calls LoadLibrary for each "used" unit.
    ///   So, calling LoadLibrary "simulates" a unit usage specified in an uses clause. Here is what happens when LoadLibrary
    ///   is called:
    ///
    ///   1. Scripter tries to find a Delphi-based library with the name ALibraryName. Delphi-based libraries are those libraries
    ///   inherited from TatScripterLibrary that were previously registered with RegisterScripterLibrary. The ALibraryName must
    ///   match the method LibraryName of the registered library. If found, the library is added to scripter with a call to
    ///   AddLibrary method
    ///
    ///   2. If Delphi-based library is not found, scripter tries to find a script-based library. It searches for all scripts
    ///   in the Scripts collection, which UnitName is the same as ALibraryName. If the script is found, then the script is registered
    ///   as a library. In other words, SelfRegisterAsLibrary is called for that script.
    ///
    ///   3. If still no library are found, the scripter tries to find a file-based library (if LibOptions.UseScriptFiles is true).
    ///   It tries to find a script file which matches the name specified by ALibraryName. See TatCustomScripter.LibOptions property
    ///   to see the rules for searching the file (search path, default extensions, etc.). If the file is founds, it is loaded
    ///   in the Scripts collection, compiled (not needed if the file found is already a compiled p-code file), and registered
    ///   using SelfRegisterAsLibrary method
    ///
    ///   If ADefault parameter is true, you have the option to omit library name and call the method directly from script.
    ///   if no library is found, an exception is raised. If ASilent parameter is true, then no exception is raised and nothing happens.
    function LoadLibrary(ALibraryName: string; ADefault:boolean=true; ASilent: boolean = false): TatScripterLibrary;

    /// Description:
    ///   LoadLibrary2 is a work around for C++ automatic header generation. It just calls LoadLibrary method.
    procedure LoadLibrary2(ALibraryName: string; ADefault:boolean=true);

    /// Description:
    ///  Copy customized information from another scripter.
    procedure AssignInfo(ASourceScripter:TatCustomScripter);

    /// Description:
    ///   Calls InProcessExecute method of current virtual machine. See TatVirtualMachine.IncProcessExecute method.
    function InProcessExecute(AScriptStub:string): boolean;

    /// Description:
    ///   BuildEventHandlerName is a function which builds a friendly name for a script procedure
    ///   which will be an event handler for the event PropName in the component Instance. So, for example, if
    ///   Instance is the button Button1 and PropName is 'OnClick', BuildEventHandlerName returns 'Button1Click'.
    function BuildEventHandlerName(Instance: TComponent; PropName: string): string;

    /// Description:
    ///   DeclareEventHandler will include a event handler declaration in script for the AProcName procedure
    ///   The result of function is the line on which the code must be written, not the line of declaration itself.
    function DeclareEventHandler(AProcName: string): integer;

    /// Description:
    ///   For internal use only. Do not use this method.
    procedure GetInfoFromRoutineName(var RName: string; var AMachine: TatVirtualMachine);

    {$IFDEF DELPHI2010_LVL}
    /// Description:
    ///   DefineClassByRTTI register AClass and its methods, properties and fields into Scripter,
    ///   using RTTI to retrieve information about given class.
    ///   AClassName: custom name for registered class, the original class name is used if empty.
    ///   AVisibilityFilter: register only members whose visibility is in this set.
    ///   ARecursive: if true, register also types used by methods and properties of this class.
    ///   ARedefine: default behavior if AClass is already registered in scripter:
    ///     roNone: keeps currently registered class and does not register anything new;
    ///     roInclude: adds methods and properties that are not defined yet to registered class;
    ///     roOverwrite: defines the class and its members overwriting the currently registered one.
    procedure DefineClassByRTTI(AClass: TClass; AClassName: string='';
      AVisibilityFilter: TMemberVisibilitySet = [mvPublic, mvPublished];
      ARecursive: boolean = False; ARedefine: TRedefineOption = roNone);

    /// Description:
    ///   DefineRecordByRTTI register the record structure specified by ATypeInfo into Scripter,
    ///   using RTTI to retrieve information about given record. Records registered in Scripter
    ///   will work like a class and need to be instantiated (TRecord.Create).
    procedure DefineRecordByRTTI(ATypeInfo: Pointer);
    {$ENDIF}

    /// Description:
    ///   EventBroker property provides access to the TatScripterEventBroker object which controls the binding between
    ///   scripter and Delphi events. See TatScripterEventBroker class for more information.
    property EventBroker: TatScripterEventBroker read FEventBroker;

    /// Description:
    ///   DefaultInstances holds a list of objects which are treated by scripter as default objects. A default object is
    ///   an object which methods and properties are directly accessible from all scripts without the need to prepend the method
    ///   name with the object name. For example, if an object MyObject has the method MyMethod, and it is added as a default
    ///   instance in DefaultInstances property, you can access the method directly this way:
    ///   <code>
    ///   MyMethod;
    ///   </code>
    ///   You will rarely add objects directly to DefaultInstances, you should use UsesObject method instead.
    property DefaultInstances: TatObjects read FDefaultInstances;

    /// Description:
    ///   Classes property holds the list of all registered classes in scripter. For the scripter to know about a class and
    ///   the class to be accessible from all scripts, it must be in this collection. Each registered class is a TatClass object
    ///   which holds information about all methods and properties known by the scripter. When the scripter finds in script
    ///   a reference to an object of a specified class, it will look for that class in the Classes property to find all
    ///   the methods and properties that can be accessed from that object.
    ///   When you call a DefineClass method, an entry is added in this collection.
    property Classes: TatClasses read FClasses write SetClasses;

    /// Description:
    ///   SystemLibrary returns the instance of the TatClass object which holds information about all methods and properties
    ///   registered in the default system library. This reference is useful when you want to find and remove/change a
    ///   specified method or property in the system library.
    ///   The system library is a collection of basic methods and constants (like IntToStr, Format, Date, etc.) that are registered
    ///   by default in the scripter component.
    function SystemLibrary: TatClass;

    /// Description:
    ///   This property provides access to the SourceCode property of current script. See TatScript.SourceCode for more details.
    ///   Compilation is NOT called automatically when changing this property.
    /// See Also:
    ///   TatScript.SourceCode
    property SourceCode: TStrings read GetSourceCode write SetSourceCode;

    /// Description:
    ///   Provides access to LastExceptionMessage property of current virtual machine. See TatVirtualMachine.LastExceptionMessage for more details.
    /// See Also:
    ///   TatVirtualMachine.LastExceptionMessage
    property LastExceptionMessage: string read GetLastExceptionMessage;

    /// Description:
    ///   Provides access to LastExceptionHelpContext property of current virtual machine.
    ///   See TatVirtualMachine.LastExceptionHelpContext for more details.
    /// See Also:
    ///   TatVirtualMachine.LastExceptionHelpContext
    property LastExceptionHelpContext: integer read GetLastExceptionHelpContext;

    /// Description:
    ///   Provides access to LastExceptionClassName property of current virtual machine.
    ///   See TatVirtualMachine.LastExceptionClassName for more details.
    /// See Also:
    ///   TatVirtualMachine.LastExceptionClassName
    property LastExceptionClassName: string read GetLastExceptionClassName;

    /// Description:
    ///   Provides access to ScriptInfo property of current script. See TatScript.ScriptInfo for more details.
    /// See Also:
    ///   TatScript.ScriptInfo
    property ScriptInfo: TatScriptInfo read GetScriptInfo;

    /// Description:
    ///   Provides access to CurrentObject property of current virtual machine. See TatVirtualMachine.CurrentObject for more details.
    /// See Also:
    ///   TatVirtualMachine.CurrentObject
    property CurrentObject: TObject read GetCurrentObject;

    /// Description:
    ///   Provides access to CurrentClass property of current virtual machine. See TatVirtualMachine.CurrentClass for more details.
    /// See Also:
    ///   TatVirtualMachine.CurrentClass
    property CurrentClass: TatClass read GetCurrentClass;

    /// Description:
    ///   Provides access to Compiled property of current script. See TatScript.Compiled for more details.
    /// See Also:
    ///   TatScript.Compiled
    property Compiled:boolean read GetCompiled write SetCompiled stored DoSaveCompiledCode;

    /// Description:
    ///   Deprecated property. This should be always false.
    property SaveCompiledCode: boolean read FSaveCompiledCode write FSaveCompiledCode;

    /// Description:
    ///   Provides access to SilentCompiled property of current script. See TatScript.SilentCompiled for more details.
    /// See Also:
    ///   TatScript.SilentCompiled
    property SilentCompiled:boolean read GetSilentCompiled write SetSilentCompiled;

    /// Description:
    ///   Deprecated property. Don't use it.
    property PCode:TMemoryStream read FPCode write FPCode;

    {Provides access to BreakPoints property of current virtual machine. See TatVirtualMachine.BreakPoints for more details}
    property BreakPoints: TatScriptBreakPoints read GetBreakPoints;

    /// Description:
    ///   Provides access to Halted property of current virtual machine. See TatVirtualMachine.Halted for more details.
    /// See Also:
    ///   TatVirtualMachine.Halted
    property Halted: boolean read GetHalted;

    /// Description:
    ///   Running property indicates if a script is being executed by the scripter component. If the scripter holds multiple
    ///   scripts, Running property will be true if any of the scripts is running. If not script is running, the value will
    ///   be false.
    ///   When setting Running to true of false, it will change the Running value of the current virtual machine.
    ///   See TatVirtualMachine.Running for more details.
    /// See Also:
    ///   TatVirtualMachine.Running
    property Running: boolean read GetRunning write SetRunning;

    /// Description:
    ///   Provides access to Paused property of current virtual machine. See TatVirtualMachine.Paused for more details.
    /// See Also:
    ///   TatVirtualMachine.Paused
    property Paused: boolean read GetPaused write SetPaused;

    /// Description:
    ///   Enables OnExecHook event. If CallExecHookEvent is true, OnExecHook event is fired, otherwise it's disabled.
    ///   CallExecHookEvent is false by default.
    property CallExecHookEvent: boolean read GetCallExecHookEvent write SetCallExecHookEvent;

    /// Description:
    ///   Provides acess to FirstInstruction property of current script. See TatScript.FirstInstruction for more details.
    /// See Also:
    ///   TatScript.FirstInstruction
    property FirstInstruction: pSimplifiedCode read GetFirstInstruction;

    /// Description:
    ///   OnDebugHook event is a callback event that is called when a script running but in paused condition. When the script
    ///   is paused, the main application loop is executed by scripter not by VCL. OnDebugHook is then a way to have a callback
    ///   from this loop and perform operations like updating the application user-interface.
    ///   OnDebugHook is called many times while the script execution is paused. See also OnSingleDebugHook which is fired only once.
    property OnDebugHook: TNotifyEvent read FOnDebugHook write FOnDebugHook;

    /// Description:
    ///   OnSingleDebugHook event is called whenever the script execution is paused or a debug action is performed (like StepOver,
    ///   TraceInto, etc.. Different from OnDebugHook, which is called many times inside a loop when the script is paused,
    ///   OnSingleDebugHook is called only once. It provides a better performance if the purpose is to update a debugging IDE
    ///   when a debug action takes place.
    property OnSingleDebugHook: TNotifyEvent read FOnSingleDebugHook write FOnSingleDebugHook;

    /// Description:
    ///   OnExecHook event is called during scripter execution. It's a callback event that you can use for performing operations
    ///   while a script is being executed. For performance reasons, OnExecHook is only called when CallExecHookEvent property is true.
    property OnExecHook: TNotifyEvent read GetOnExecHook write SetOnExecHook;

    /// Description:
    ///   OnPauseChanged is fired whenever Paused property value is changed.
    property OnPauseChanged: TNotifyEvent read GetOnPauseChanged write SetOnPauseChanged;

    /// Description:
    ///   OnRunningChanged event is fired whenever value of Running property changes.
    property OnRunningChanged: TNotifyEvent read FOnRunningChanged write FOnRunningChanged;

    /// Description:
    ///   Provides access to NextInstruction property of current virtual machine. See TatVirtualMachine.NextInstruction for more details.
    /// See Also:
    ///   TatScript.FirstInstruction
    property NextInstruction: pSimplifiedCode read GetNextInstruction;

    /// Description:
    ///   CurrentScript returns the current selected script among the available scripts in the Scripts collection.
    ///   When the scripter is running, CurrentScript contains the current script object that is being executed.
    ///   It might change from time to time depending on the calls inside the script source code: if the current script
    ///   calls functions and procedures in another script, the current script changes when the subroutine is executed.
    property CurrentScript: TatScript read FCurrentScript write FCurrentScript;

    /// Description:
    ///   CurrentDebugScript is similar to CurrentScript, with a small difference when it comes to forms.
    ///   When a new form instance is created, a new script is created in Scripts collection, and the script information
    ///   (source code, etc.) is copied from original form script. When the form executes its script, then CurrentScript
    ///   changes, but CurrentDebugScript continues pointing to the original script object which generated the form instance.
    property CurrentDebugScript: TatScript read GetCurrentDebugScript;

    /// Description:
    ///   ScriptFormClass property specifies the class of script form that are to be created
    ///   dynamically by scripter when a new form is instantiated from script. Default value is TScriptForm, but you can set any
    ///   other form class that descends from TScriptForm.
    property ScriptFormClass: TScriptFormClass read FScriptFormClass write SetScriptFormClass;

    /// Description:
    ///   Scripts property holds a collection of existing scripts in the scripter component. A scripter can hold one or more
    ///   scripts, each of them can be individually compiled and executed (one at time) and each one holds script information
    ///   like source code, variables, routines, etc.. A script is analog to a unit in a Delphi project.
    property Scripts: TatScripts read FScripts;

    /// Description:
    ///   When OptionExplicit is true, you must declare variables inside script. When OptionExplicit is false, you don't need
    ///   to declare variables, just initializing a variable will automatically declare it. For example:
    ///   <code>
    ///   begin
    ///     MyNewVar := 0;
    ///   end;
    ///   </code>
    ///   the above code is valid when OptionExplicit is false. If it is set to true, a compilation error will be raised, and
    ///   you be explicity declare the variable:
    ///   <code>
    ///   var
    ///     MyNewVar: integer;
    ///   begin
    ///     MyNewVar := 0;
    ///   end;
    ///   </code>
    ///   Even when OptionExplicit is false, you cannot use a variable before it is initialized. The following code is invalid
    ///   in any situation:
    ///   <code>
    ///   begin
    ///     ShowMessage(IntToStr(MyNewVar)); //Error, MyNewVar not declared/initialized
    ///   end;
    ///   </code>
    ///   OptionExplicit is false by default in TatPascalScripter and TatBasicScripter components, for backward compatibility purposes,
    ///   but it is true by default in the new TatScripter component.
    property OptionExplicit: boolean read FOptionExplicit write FOptionExplicit;

    /// Description:
    ///   Watches property holds a collection of current watches for debugging purposes. You can add, edit and delete watches
    ///   in this collection, specify the expression for each watch and retrieve its result value. This property is mostly used
    ///   for building debugging IDE's, but you can use it programmatically as well.
    property Watches: TatScripterWatches read FWatches;

    /// Description:
    ///   OnCompileError event is fired whenever an error occurs during a script compilation.
    property OnCompileError: TScriptErrorEvent read FOnCompileError write FOnCompileError;

    /// Description:
    ///   OnRuntimeError event is fired whenever a runtime error occurs during a script execution.
    property OnRuntimeError: TScriptErrorEvent read FOnRuntimeError write FOnRuntimeError;

    /// Description:
    ///   When DeferObjectResolution is true, the compiler will ignore class types and defer all methods/properties
    ///   resolution to runtime. For example, if you have "MyButton.Click;" in your script, it will not check if
    ///   MyButton is a class which holds a valid Click method. All will be defered to runtime.
    ///   Default value for DeferObjectResolution is false. You should rarely use this property.
    property DeferObjectResolution: boolean read FDeferObjectResolution write FDeferObjectResolution;

    /// Description:
    ///   OnBeforeExecute is called before a script routine (or main block) is executed. ALabel contains the name of the
    ///   routine to be executed. If the main block is to be executed, ALabel is an empty string.
    property OnBeforeExecute: TBeforeExecuteEvent read FOnBeforeExecute write SetOnBeforeExecute;

    /// Description:
    ///   When ShortBooleanEval property is true, the boolean expression will be available only when needed, just like Delphi.
    ///   For example, for an expression "if (IsEnabled) or (IsVisible) then..." , if IsEnabled returns true, the method
    ///   IsVisible is not even called, because the boolean value of expression is already known to be true.
    ///   When ShortBooleanEval property is false, the whole boolean expression is evaluated.
    ///   ShortBooleanEval is false by default in old TatPascalScripter and TatBasicScripter for backward compatibility.
    ///   In TatScripter component, it is true by default.
    property ShortBooleanEval: boolean read FShortBooleanEval write FShortBooleanEval;

    /// Description:
    ///   When AllowDllCalls is true, you can call dll functions directly from script, using a syntax similar to Delphi:
    ///   <code>
    ///    function MessageBox(hwnd: pointer; text, caption: AnsiString;
    ///      msgtype: integer): integer; stdcall; external 'User32.dll' name 'MessageBoxA';
    ///   </code>
    ///   MessageBox(nil, 'Are you sure?', 'Confirmation', MB_ICONQUESTION + MB_YESNO);
    ///
    ///   For security purposes, AllowDllCalls is false by default.
    property AllowDLLCalls: boolean read FAllowDLLCalls write FAllowDLLCalls;

    /// Description:
    ///   LibOptions property holds a TScripterLibraryOptions object with configuration about how libraries are found and
    ///   loaded in scripter environment. See TScripterLibraryOptions class for more information.
    property LibOptions: TScripterLibraryOptions read FLibOptions write SetLibOptions;

    /// Description:
    ///   OnUnknownElement event is fired during a script compilation when the compiler finds an identifier it cannot recognize.
    ///   Attach an event handler to this event to add properties, methods and references on the fly, according to the identifiers
    ///   used in the script.
    property OnUnknownElement: TUnknownElementEvent read FOnUnknownElement write FOnUnknownElement;

    /// Description:
    ///   Set LoadFormEvents to true to allow loading dfm files which contain event handlers.
    ///   When a script form is compiled, the dfm file specified in directive $FORM is loaded.
    ///   Usually, if the dfm contain specified event handlers, like for example "OnClick = Button1Click",
    ///   an error will raised. When LoadFormEvents is true, it will check if the script contains
    ///   a routine named Button1Click, and if it does, it sets the correct event handler to the
    ///   component's event, as specified in the dfm. By default, LoadFormEvents is false.
    property LoadFormEvents: boolean read FLoadFormEvents write FLoadFormEvents;

    /// Description:
    ///   OnBreakpointStop event is fired whenever a breakpoint is reached in a script execution, and the execution goes to
    ///   paused state.
    property OnBreakpointStop: TNotifyEvent read FOnBreakpointStop write FOnBreakpointStop;
  end;

  /// Description:
  ///   TatScripterWatches class holds a collection of TatScripterWatch objects which represent watches in an IDE interface.
  ///   Using a watch you can define its expression and check its value while the script is running/paused. This collection
  ///   is mostly used from a IDE interface, so you will rarely use it directly.
  TatScripterWatches = class(TOwnedCollection)
  private
    function GetItem(i: Integer): TatScripterWatch;
    function Scripter: TatCustomScripter;
  public
    /// Description:
    ///   Add method creates and adds a new TatScripterWatch object to the collection.
    function Add: TatScripterWatch;

    /// Description:
    ///   Provides indexed access to all TatScripterWatch objects in the collection.
    property Items[i:Integer]: TatScripterWatch read GetItem; default;

    /// Description:
    ///   Updates the result value of all watches.
    procedure EvaluateAll;
  end;

  /// Description:
  ///   TatScripterWatch holds information about a watch in scripter system, for debugging purposes.
  ///   It holds the expression of the watch, calculate its value, among other properties.
  TatScripterWatch = class(TCollectionItem)
  private
    FExpression    : string;
    FDebugScript   : TatScript;
    FEnabled       : boolean;
    FWatchStatus: TWatchStatus;
    FLastResult: variant;
    procedure SetExpression(const Value: string);
    procedure ScriptDestroyed(Sender: TObject);
    function Watches: TatScripterWatches;
    function Scripter: TatCustomScripter;
    procedure Reset;
    procedure InternalEvaluate(AMachine: TatVirtualMachine);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;

    /// Description:
    ///   Call Evaluate method to update the value of the watch. The value can be retrieved using LastResult property.
    ///   if the watch is not enabled, nothing happens.
    procedure Evaluate;

    /// Description:
    ///   Expression property holds the string which contains the expression of the watch to be evaluated. Expression
    ///   can be a variable name, a constant or a complex expression. Examples: 'MyVar', '10 + 20', 'MyArray[c]'.
    property Expression: string read FExpression write SetExpression;

    /// Description:
    ///   WatchStatus is a read-only property which contains the current status of the watch. For example, you can use it to check
    ///   if the watch was already evaluated, or if the expression was incorrect (raising a compiling error).
    property WatchStatus: TWatchStatus read FWatchStatus;

    /// Description:
    ///   LastResult contains the calculated value of the watch for the last evaluation. If no evaluation was done before,
    ///   WatchStatus is wsNotEvaluated and LastResult will hold an invalid value. To update the value of LastResult,
    ///   call Evaluate method.
    property LastResult: variant read FLastResult;

    /// Description:
    ///   Enabled property enables/disables the current watch. If the watch is disabled, calling Evaluate does nothing and
    ///   LastResult is never updated.
    property Enabled: boolean read FEnabled write FEnabled;
  end;

  /// Description:
  ///   TatScripts holds a collection of TatScript objects belonging to the scripter. You can add, delete and iterate through the
  ///   available scripts.
  TatScripts = class(TCollection)
  private
    FScripter : TatCustomScripter;
    function GetItem(i: integer): TatScript;
  public
    constructor Create(AScripter:TatCustomScripter);

    /// Description:
    ///   Adds a new script. You can then set source code, set language type, compile, execute the script, among other
    ///   actions.
    function Add: TatScript;

    /// Description:
    ///   FindByUnitName method searchs for a script which unit name matches AUnitName parameter. It's useful to search
    ///   for script-based libraries, which usually have a non-empty UnitName.
    function FindByUnitName(AUnitName: string): TatScript;

    /// Description:
    ///   Provides indexed access to the TatScript objects in the Scripts collection.
    property Items[i:integer]:TatScript read GetItem; default;
  end;

  /// Description:
  ///   TScriptForm is the base class for script forms, a special kind of form declared in script. Script forms are defined
  ///   using the $FORM directive. When this happens, the scripter understands the script as a "form declaration", and all
  ///   methods and properties declared in script are treated as if they were methods and properties of the form class.
  ///   You can instantiate such forms from another script. All forms instantiated that way are inherited from TScriptForm class.
  TScriptForm = class(TForm)
  private
    FRunScript: TatScript;
    FDesignScript: TatScript;
    FSaveProps: TStrings;
    FSaveEvents: TStrings;
    FLastSearchedMethod: string;
    procedure LoadFormResource(AFormRes: string; ALoadEvents: boolean);
    procedure NewFormInstance(AMachine: TatVirtualMachine);
    procedure RestoreSavedProps;
    procedure SetSaveProps(const Value: TStrings);
    procedure SetSaveEvents(const Value: TStrings);
    procedure RestoreSavedEvents;
    procedure ReaderFindMethod(Reader: TReader; const MethodName: string;
      var Address: Pointer; var Error: Boolean);
    procedure ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
  protected
    /// Description:
    ///   RunScript retrieves the underlying script object which has the source code for the form. The script routines
    ///   will behave as form methods. Each form instance has its own RunScript. When a form is instantiated, a new RunScript
    ///   is created and its content is copied from the base script where the form was declared.
    property RunScript: TatScript read FRunScript write FRunScript;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;

    /// Description:
    ///   CreateFromScript constructor is called from scripter engine when a script form is instantiated by a script code.
    ///   You will not need to call CreateFromScript method nor to instantiate a TScriptForm class directly.
    constructor CreateFromScript(AOwner: TComponent; AMachine: TatVirtualMachine); virtual;
    destructor Destroy; override;
    function IsShortCut(var Message: TWMKey): Boolean; override;

    /// Description:
    ///   DesignScript property is not being used in current version.
    property DesignScript: TatScript read FDesignScript write FDesignScript;
  published
    /// Description:
    ///   SaveProps property holds the list of property values to be saved when the form is serialized. The format is
    ///   PropertyName=PropertyValue
    ///   You should not use this property, it's only used by scripter IDE.
    property SaveProps: TStrings read FSaveProps write SetSaveProps;

    /// Description:
    ///   SaveEvents property holds the list of event values to be saved when the form is serialized. The format is
    ///   EventName=EventHandler
    ///   You should not used this property, it's only used by scripter IDE.
    property SaveEvents: TStrings read FSaveEvents write SetSaveEvents;

    property Visible stored false;
  end;

  TatScriptBasedLibrary = class;

  /// Description:
  ///   TatScriptRefactor is an auxiliary class that provides useful methods for safely change a script source code,
  ///   like adding a unit in the uses clause, changing the form directive, among others.
  TatScriptRefactor = class(TPersistent)
  private
    FScript: TatScript;
    FDirtySource: boolean;
    FUpcaseSource: string;
    function GetSource: TStrings;
    function GetUpcaseSource: string;
  protected
    /// Description:
    ///   Retrieves the source code of the script associated with this refactor.
    property Source: TStrings read GetSource;

    /// Description:
    ///   Retrieves the script source code all in upper case.
    property UpcaseSource: string read GetUpcaseSource;

    /// Description:
    ///   Retrieve the position of the SubStr in the source code. Search starts from the position indicated by FromPos.
    function SourcePos(SubStr: string; FromPos: integer = 1): integer;
  public
    constructor Create(AScript: TatScript);

    /// Description:
    ///   Call BeginRefactor before doing any change to script source. This avoids the scripter engine to clear some references
    ///   attached to the script, like events.
    procedure BeginRefactor;

    /// Description:
    ///   Call EndRefactor after doing any change to script source using the refactor.
    procedure EndRefactor;

    /// Description:
    ///   Create (or update) the FORM directive in the script giving the AFormClass (form class name)
    ///   and AFileName (form file name). For example, the code below:
    ///   <code>
    ///    UpdateFormHeader('TMyForm', 'myform.dfm');
    ///   </code>
    ///   will create (or update) the form directive in the script as following (in this case,
    ///   the example is in Basic syntax):
    ///   <code>
    ///    #FORM TMyForm, myform.dfm
    ///   </code>
    procedure UpdateFormHeader(AFormClass, AFileName: string); virtual;

    /// Description:
    ///   Declare a routine named ProcName in source code, and return the line number
    ///   of the declared routine. The line number returned is not the line where the
    ///   routine is declared, but the line with the first statement. For example, in pascal,
    ///   it returns the line after the "begin" of the procedure.
    function DeclareRoutine(ProcName: string): integer; overload;

    /// Description:
    ///   Declare a routine in source code, and return the line number
    ///   of the declared routine. The line number returned is not the line where the
    ///   routine is declared, but the line with the first statement. For example, in pascal,
    ///   it returns the line after the "begin" of the procedure.
    ///   This method uses the AInfo property to retrieve information about the procedure
    ///   to be declared. Basicaly it uses AInfo.Name as the name of routine to be declared,
    ///   and also uses AInfo.Variables to declare the parameters. This is a small example:
    ///   <code>
    ///     AInfo.Name := 'MyRoutine';
    ///     AInfo.IsFunction := true;
    ///     AInfo.ResultTypeDecl := 'string';
    ///     With AInfo.Variables.Add do
    ///     begin
    ///       VarName := 'MyParameter';
    ///       Modifier := moVar;
    ///       TypeDecl := 'integer';
    ///     end;
    ///     With AInfo.Variables.Add do
    ///     begin
    ///       VarName := 'SecondPar';
    ///       Modifier := moNone;
    ///       TypeDecl := 'TObject';
    ///     end;
    ///     ALine := Script.DeclareRoutine(AInfo);
    ///   </code>
    ///   The script above will declare the following routine (in pascal):
    ///   <code>
    ///    function MyRoutine(var MyParameter: integer; SecondPar: TObject): string;
    ///   </code>
    function DeclareRoutine(AInfo: TatRoutineInfo): integer; overload; virtual;

    /// Description:
    ///   Adds a unit named AUnitName to the list of used units in the uses clause.
    ///   If the unit is already being used, nothing is done. If the uses clause is not
    ///   present in the script, it is included. Example:
    ///   <code>
    ///    AddUsedUnit('Classes');
    ///   </code>
    ///   You can also include several units at once by separating them with commas:
    ///   <code>
    ///    AddUsedUnit('Classes,Graphics,Controls');
    ///   </code>
    procedure AddUsedUnit(AUnitName: string); virtual;

    /// Description:
    ///   Returns the script object which the refactor belongs to.
    property Script: TatScript read FScript;
  end;

  TRefactorClass = class of TatScriptRefactor;

  /// Description:
  ///   TatScriptBreak contains information about a breakpoint set in the script. Use this class to programatically
  ///   set a breakpoint in the script source code for debugging purposes.
  TatScriptBreak = class(TCollectionItem)
  private
    FLine: integer;
    FBreakList: TObjectList;
    FAutoDestroy: boolean;
    function Script: TatScript;
    procedure SetLine(const Value: integer);
    procedure UpdateBreakPoints;
    procedure BreakpointDestroyed(ABreakPoint: TatScriptBreakPoint);
    procedure RemoveBreakPoints;
    procedure TemporaryBreakProc;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    /// Description:
    ///   Use Line property to get or set the line number in the source code in which the breakpoint will be set.
    property Line: integer read FLine write SetLine;

    /// Description:
    ///   AutoDestroy is a read-only property. If it's true, it indicates that the breakpoint will be removed when
    ///   script execution stops at it. In other words, it will only stop once in this breakpoint.
    property AutoDestroy: boolean read FAutoDestroy;
  end;

  /// Description:
  ///   TatScriptBreaks holds a collection of all breakpoints set in the script. Use this collection to programatically add, edit
  ///   and remove breakpoints in script source code.
  TatScriptBreaks = class(TOwnedCollection)
  private
    function GetItem(Index: integer): TatScriptBreak;
    function Script: TatScript;
    procedure UpdateAll;
  public
    /// Description:
    ///   Adds (if it doesn't exist) or removes (if it exists) a breakpoint at the line specified by ALine.
    procedure ToggleBreak(ALine: integer);

    /// Description:
    ///   Retrieves the TatScriptBreak object related to the breakpoint set at the line specified by ALine. If no breakpoint
    ///   is set at that line, FindByLine returns nil.
    function FindByLine(ALine: integer): TatScriptBreak;

    /// Description:
    ///   Add a new TatScriptBreak object in the TatScriptBreaks collection. You should not usually use Add method.
    ///   Use ToggleBreak method instead.
    function Add: TatScriptBreak;

    /// Description:
    ///   Provides indexed access to all breakpoints set in the script.
    property Items[Index: integer]: TatScriptBreak read GetItem; default;
  end;

  /// Description:
  ///   TatScript object contains all information related to a script in the scripter component. The scripts are kept
  ///   in the Scripts property which is a TatScripts collection.
  ///   TatScript allows you to set the source code of the script using SourceCode property. Several methods are provided
  ///   for clearing the script (Clear), compiling (Compile), executing (Execute). Information about the compiled script
  ///   is also provided in the ScriptInfo property which holds the list of declared routines, global variables, etc.
  ///   Many other properties and methods related to a single script are available.
  TatScript = class(TCollectionItem)
  private
    FScripter                   : TatCustomScripter;
    FParser                     : TatSyntaxParser; // refer�ncia � sintaxe da linguagem
    FVirtualMachines            : TatVirtualMachines; // m�quinas virtuais para execu��o de scripts
    FVirtualMachine             : TatVirtualMachine; // m�quina virtual para execu��o do script
    { auxiliary code generation variables }
    FStack                      : array[TStackType] of pStackElement; // pilhas auxiliares
    FCodeLine                   : integer; // �ndice para a instru��o corrente na gera��o de c�digo
    FFirstLabelSpec             : pLabelSpec; // ponteiro para o primeiro r�tulo gerado
    FLastLabelSpec              : pLabelSpec; // ponteiro para o �ltimo r�tulo gerado
    FCurrentRoutine             : TatRoutineInfo;
    FIsDebugScript              : boolean;
    FDebugScriptMainRoutine     : TatRoutineInfo; // para evitar a declara��o de um novo Main quando compilar um debug script
    { script source information }
    FSourceCode                 : TStrings;
    { compiled script runtime information }
    FFirstInstruction           : pSimplifiedCode; // primeiro instru��o execut�vel
    FLastInstruction            : pSimplifiedCode; // �ltima instru��o execut�vel
    FScriptInfo                 : TatScriptInfo; // script symbols information
    FCompiled                   : boolean; //indicates that last compilation was successful
    FSilentCompiled             : boolean; //indicates that scripter was compiled silently
    FSolvedAddressing           : boolean; // indica se o enderecamento absoluto ja foi resolvido
    FExpandedDebugInfo          : boolean; // indica que o campo vDebugInfo j� contem linha e coluna do programa-fonte
    FUsedUnits                  : TatUsedUnits;
    FCounterInit                : integer; // inicializador de contadores para gera��o de vari�veis internas (ver DebugExecute)
    FOnDestroy                  : TNotifyEvent; // para resolu��o de links internos (como nos DebugWatches)
    FRollbackSourceCode         : boolean;
    FLibraries                  : TList;
    FSilentCompilation          : boolean;
    FFileName                   : string;
    FUnitName                   : string;
    FLoadedDLL                  : boolean;
    FDefInstances               : TatObjects;
    FIntInstance                : TatObject;
    FScriptForm: TScriptForm;
    FRefactor: TatScriptRefactor;
    FRefactorClass: TRefactorClass;
    FDesignScriptForm: TScriptForm;
    FDesignFormResource: string;
    FCodeStream: TStream;
    FBreaks: TatScriptBreaks;
    FOriginalScript: TatScript;
    FDerivedScripts: TObjectList;
    FCompiling: boolean;
    FOriginalForm: TScriptForm;
    FClearingScript: boolean;
    FRefactoring: integer;
    procedure InternalCompile(Silent: boolean);
    procedure DisposeDLL;
    procedure RemoveAttachedEvents(RemoveAll: boolean);
    function GetFormFileAsString(AFormFile: string): string;
    procedure InternalSaveCodeToStream(AStream: TStream);
    procedure SetCompiled(const Value: boolean);
    function CheckRegisteredAsLibrary(AScripter: TatCustomScripter; var ALib: TatScripterLibrary): boolean;
    procedure SetOriginalScript(AScript: TatScript);
    procedure UnregisterForm;
    procedure DoBreakpointStop;
    function _FindClass(idx: integer; AName: string): TatClass;
    function _FindMethod(AClass: TatClass; idx: integer;
      AName: string): TatMethod;
    function _FindProperty(AClass: TatClass; idx: integer;
      AName: string): TatProperty;
    procedure InternalLoadCodeFromStream(AStream: TStream; ARegisterForm: boolean);
    procedure GetRowColFromInst(Inst: pSimplifiedCode; var Row,
      Col: integer);
  protected
    procedure DoUnknownElement(var Context: TElementContext);
    procedure CompileError(msg: string; debuginfo: integer); overload;
    procedure CompileError(msg: string; row,col: integer); overload;
    procedure RuntimeError(msg: string);

    procedure StackPush(StackType:TStackType; x: Variant );
    procedure StackPushDelimitter(StackType: TStackType );
    function  EmptyStack(StackType: TStackType):boolean;
    function  StackPop(StackType: TStackType):Variant;
    function  StackView(StackType: TStackType):Variant;
    function  StackIndex(StackType: TStackType):integer;
    function  StackDelimitterFound(StackType: TStackType):boolean;
    function  StackGetByIndex(st: TStackType; i: integer):Variant;
    function  IndexOfStackTextValue(st: TStackType; s: string):integer;
    function GetStack(st: TStackType): pStackElement;
    procedure ClearStacks;

    function  NewLabelSpec(Name: string ):pLabelSpec;
    function  FindLabelSpec(name: string ):pLabelSpec;
    function RegisterReference(Name: string ):integer;
    procedure SolveReference(LabelSpec: pLabelSpec );
    procedure DefineReferenceAddress(Name: string );
    procedure ClearLabelSpecs;
    procedure SolveUndefinedReferences;
    function RegisterVariableReference(id: string): TatVariableInfo;
    function DeclareVariable(AName: string; AArgIndex: integer = -1; AModifier: TatArgumentModifier = moNone;
      AGlobal: boolean = False; ASourcePos: integer = -1): TatVariableInfo;
    function AppendInstruction(i: TInstruction): pSimplifiedCode; overload;
    function RemoveLastInstruction: pSimplifiedCode;
    procedure AppendInstruction(AInstruction: pSimplifiedCode); overload;
    procedure OptimizeStoreVar(AVar: TatVariableInfo; AIgnoreConstant: boolean = false);
    procedure OptimizeVarTest(ACaseVarIndex: integer; ACaseVarName, AJumpLabel: string; ACondition:boolean );
    procedure SetSourceCode(value: TStrings);
    function ErrorComplement(APos: integer):string;
    procedure SourceCodeChange(Sender: TObject);
    procedure DisposeCode(var code: pSimplifiedCode);

    procedure RelativeMethodRef(AMethod:TatMethod; AInst: pSimplifiedCode);
    procedure RelativeGetterRef(AProperty:TatProperty; AInst: pSimplifiedCode);
    procedure RelativeSetterRef(AProperty:TatProperty; AInst: pSimplifiedCode);

    property CodeLine: integer read FCodeLine write FCodeLine;
    property LastInstruction: pSimplifiedCode read FLastinstruction write FLastInstruction;
    property CurrentRoutine: TatRoutineInfo read FCurrentRoutine write FCurrentRoutine;
    property CounterInit: integer read FCounterInit write FCounterInit;
    property DebugScriptMainRoutine : TatRoutineInfo read FDebugScriptMainRoutine write FDebugScriptMainRoutine;
    property IsDebugScript: boolean read FIsDebugScript write FIsDebugScript;


    /// Description:
    ///   RefactorClass property indicates which descendant of TatScriptRefactor will be used as Refactor object.
    ///   Used only when creating descendants of TatScript.
    property RefactorClass: TRefactorClass read FRefactorClass write FRefactorClass;

    /// Description:
    ///   Override EncodeSingleAssign to provide a standard way to represent a single function
    ///   in a script. Commonly used in debugger watches. WARNING: EncondeSingleAssign must assure
    ///   that the variable is declared as local.
    function EncodeSingleAssign(AVarName, AExpression: string): string; virtual; abstract;

    function DeclareEventHandler(AProcName: string): integer; virtual;

    function SelfRegisterAsLibrary(AScripter: TatCustomScripter; AName: string; AClassRef: TClass;
      AClassName: string; ADefault: boolean; AddMethod: boolean): TatScripterLibrary; overload;
    procedure CompileForm(AFormClassName, AFormFile: string);
    procedure RegisterForm;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;

    /// Description:
    ///   Use Clear method to clear all info about script compilation. When Clear method is called, the Compiled property is
    ///   set to false, all meta-information in ScriptInfo is erased, events attached to the script are removed, and other
    ///   clean up operations. Please note that Clear method only refers to compilation information. It doesn't clear the source
    ///   code, or other information like unit name, etc.
    ///   You cannot clear a script if it is running.
    procedure Clear; virtual;

    /// Description:
    ///   Call Compile method to compile the current script source code. After a successful compilation is performed, the Compiled
    ///   property is set to true, and the compiled code is saved into a internal stream in memory for further execution.
    ///   SilentCompiled property is also set to true after a sucessful compilation.
    ///   If compilation fails, an exception is raised.
    procedure Compile; virtual;

    /// Description:
    ///   Call SilentCompile method to compile the current script source code in silent mode. Silent mode means that if the compilation
    ///   fails, no exception is raised, and still the scripter will save information about the compilation until the point it was
    ///   succesful. SilentCompile is useful when you want to extract meta information from the script (declared routines, variables, etc.)
    ///   without worrying about if the script is compilable or not.
    ///   SilentCompiled property is always set to true when SilentCompile is called.
    ///   Compiled property is always set to false, regardless if the compilation was sucessful or not.
    procedure SilentCompile;

    /// Description:
    ///   ExpandDebugInfo is a deprecated method. It was used to update debug information in the compiled p-code of the script.
    ///   Now this is done automatically and you don't need to call it anymore.
    procedure ExpandDebugInfo(RequiresCompilation: boolean = true);

    /// Description:
    ///   Use GetRowColFromSource to retrieve the row and column values of a specified position in the source code.
    ///   The position is provided in APos variable, and is considered as if the source code was a single string, including
    ///   special characters like #13 and #10. The calculated row and column values are set in row and col parameters.
    procedure GetRowColFromSource(APos:integer;var row,col:integer);

    /// Description:
    ///   LoadCodeFromFile loads a compiled p-code from the file specified by AFileName. It calls LoadCodeFromStream internally
    ///   to perform the loading operation. See LoadCodeFromStream method for more details.
    procedure LoadCodeFromFile(AFileName: string);

    /// Description:
    ///   SaveCodeToFile saves a compiled p-code to the file specified by AFileName. It calls SaveCodetToStream internally
    ///   to perform the saving operation. See SaveCodetToStream method for more details.
    procedure SaveCodeToFile(AFileName: string);

    /// Description:
    ///   Use LoadCodeFromStream to load a compiled script p-code previously saved with SaveCodeToStream. The stream must be
    ///   specified by AStream parameter. After calling LoadCodeFromStream the compiled p-code is loaded into the internal
    ///   memory stream when the script is executed, no compilation is performed. The meta information about the script is also
    ///   loaded (declared routines, variables, used units, etc.
    procedure LoadCodeFromStream(AStream: TStream); virtual;

    /// Description:
    ///   Use SaveCodeToStream to save a compiled script p-code to the stream specified by AStream. SaveCodeToStream does not automatically
    ///   compile the script, so you must do it previously before saving the code.
    ///   You can save the compiled p-code to a stream in order to load it later using LoadCodeFromStream method. Saving and loading p-code
    ///   prevents recompilation of the script, making it faster for script execution. SaveCodeToStream also saves the meta information
    ///   of the script (ScriptInfo object, with all declared routines, methods, etc.).
    ///   Form resources are also saved, so you don't need the form file when loading the code.
    ///   You must be aware that the script might use classes, methods and properties registered in the scripter. Those are not saved in the
    ///   compiled p-code, so when you later load the code, you must be sure that the same used classes, methods
    ///   and properties are registered in the scripter otherwise the loaded code might not execute properly.
    procedure SaveCodeToStream(AStream: TStream); virtual;

    /// Description:
    ///   Use IsRegisteredAsLibrary to check if the script is registered as a script-based library in the scripter component
    ///   specified by AScripter component.
    function IsRegisteredAsLibrary(AScripter: TatCustomScripter): boolean;

    /// Description:
    ///   SelfRegisterAsLibrary method registers the script as a library in the scripter component specified by AScripter.
    ///   This means that all routines and global variables in the script (except those declared as private) will be acessible and
    ///   can be called from any other script in the specified scripter component. If the current script is not compiled, it will be
    ///   automatically compiled. If AName is not empty, the methods and variables can also be accessible prefixed with the AName, for
    ///   example: MyLibrary.MyMethod;
    ///   The function result value will be the instance of the library object created and registered in the scripter.
    function SelfRegisterAsLibrary(AScripter: TatCustomScripter; AName: string = ''): TatScripterLibrary; overload;

    /// Description:
    ///   SelfRegisterAsLibrary method registered the current script as a library in the scripter component that owns this script.
    function SelfRegisterAsLibrary(AName: string = ''): TatScripterLibrary; overload;

    /// Description:
    ///   Use SelfUnregisterAsLibrary to remove the script as a registered library in the scripter component specified by AScripter.
    ///   If the script was previously registered using SelfRegisterAsLibrary, you can use this method to remove it. All routines
    ///   and global variables of the script will not be accessible anymore from other scripts.
    procedure SelfUnregisterAsLibrary(AScripter: TatCustomScripter; AName: string = ''); overload;

    /// Description:
    ///   Use SelfUnregisterAsLIbrary to remove the script as a register library previously registered by SelfRegisterAsLibrary.
    ///   The script will be removed from the scripter component which owns the script.
    procedure SelfUnregisterAsLibrary(AName: string = ''); overload;

    /// Description:
    ///   Calls Scripter.LoadLibrary method. See TatCustomScriper.LoadLibrary method for more information.
    function LoadLibrary(ALibraryName: string; ADefault:boolean=true): TatScripterLibrary;

    /// Description:
    ///   Call UsesObject to access the methods and properties of the object directly from script without using an object name.
    ///   UsesObject behaves exactly like TatCustomScripter.UsesObject (see this method documentation for more information).
    ///   The only difference is that while UsesObject of the scripter makes the object accessible for all scripts in the scripter
    ///   component, this script-only UsesObject method only registered the object for this specified script. Other scripts will
    ///   not be able to access it.
    function UsesObject(AObject: TObject; AName: string = ''; AClassName: string = ''): TatClass;

    /// Description:
    ///   UnuseObject removes an used object previously registered with UsesObject method. Instead of passing the object instance,
    ///   you must pass the class name used to register the object when calling UsesObject. If no class name was specified when
    ///   calling UsesObject, then the class name will be the name of the object class.
    procedure UnuseObject(AClassName: string);

    /// Description:
    ///   Register the object specified by AObject to be acessible from this script. The object will be acessible by the name specified
    ///   by AName. Published properties of component will also be automatically available for reading/writing.
    ///   This method is similar to TatCustomScripter.AddObject method, but while the latter allows the object to accessible from
    ///   all scripts in the scripter component, this one makes the object accessible from this script only.
    procedure AddObject(AName: string; AObject: TObject);

    /// Description:
    ///   Removes an object previously registered with AddObject method. It can remove objects registered by TatCustomScripter.AddObject
    ///   method. Those are global to all scripts and can't be individually removed from a specific script.
    procedure RemoveObject(AName: string);

    /// Description:
    ///   UsedUnits holds a collection of all units (libraries) used by the script in the uses/imports clause. Only libraries declared
    ///   in the script source code will be available here, libraries registered programatically with methods like AddLibrary,
    ///   SelfRegisterAsLibrary, etc., will not be listed.
    property UsedUnits: TatUsedUnits read FUsedUnits;

    /// Description:
    ///   VirtualMachine property provides access to the script virtual machine. The virtual machine is the object which effectively
    ///   executes the compiled p-code. See TatVirtualMachine class for more info.
    property VirtualMachine: TatVirtualMachine read FVirtualMachine write FVirtualMachine;

    /// Description:
    ///   Not used, current version only allows one virtual machine per script.
    property VirtualMachines: TatVirtualMachines read FVirtualMachines;

    /// Description:
    ///   Use Scripter property to get access to the TatCustomScripter component that owns the script.
    property Scripter: TatCustomScripter read FScripter;

    /// Description:
    ///   SourceCode property holds the current source code for the script. Executing a script is as simple as setting the
    ///   SourceCode property and calling Execute method.
    ///   You cannot change SourceCode if the script is running. An exception will be raised and change will not be performed.
    ///   When you change the source code of the script, the script is cleared (see Clear method) and a new compilation is needed
    ///   before executing the script.
    property SourceCode: TStrings read FSourceCode write SetSourceCode;

    /// Description:
    ///   ScriptInfo property gives access to the TatScriptInfo object which holds meta-information about the script. In ScriptInfo
    ///   you can check declared methods, variables, and other information about the script source code.
    ///   ScriptInfo is empty even after you set script source code, information is only available after a compilation.
    ///   Silent compilation (SilentCompile method) also fills information in ScriptInfo object.
    property ScriptInfo: TatScriptInfo read FScriptInfo;

    /// Description:
    ///   Use Compiled property to check if the script is already compiled and ready to execute. You can also set Compiled property
    ///   value to true or false. Setting to true compiles the script (if it's not already compiled), and setting to false clears
    ///   the script.
    property Compiled: boolean read FCompiled write SetCompiled;

    /// Description:
    ///   Use SilentCompiled property to check if the script was compiled in silent mode (a call to SilentCompile method was
    ///   performed). Setting SilentCompiled to true doesn't perform a silent compilation, it only sets the property value to true.
    property SilentCompiled: boolean read FSilentCompiled write FSilentCompiled;

    /// Description:
    ///   FirstInstruction contains the pointer to the very first p-code instruction of the compiled script. The virtual machine
    ///   uses this property to start executing the compiled p-code. You will not need to use this property.
    property FirstInstruction: pSimplifiedCode read FFirstInstruction;

    /// Description:
    ///   ExpandedDebugInfo is true after ExpandDebugInfo method is called. This property is rarely used, since scripter expands
    ///   the debug info automatically when needed.
    property ExpandedDebugInfo: boolean read FExpandedDebugInfo;

    /// Description:
    ///   Provides access to the parser object that parses the script source code.
    property Parser: TatSyntaxParser read FParser;

    /// Description:
    ///   DefInstances holds a list of objects which are treated by script as default objects. A default object is
    ///   an object which methods and properties are directly accessible from the script without the need to prepend the method
    ///   name with the object name. For example, if an object MyObject has the method MyMethod, and it is added as a default
    ///   instance in DefaultInstances property, you can access the method directly this way:
    ///   <code>
    ///   MyMethod;
    ///   </code>
    ///   You will rarely add objects directly to DefInstances, you should use TatScript.UsesObject method instead.
    property DefInstances: TatObjects read FDefInstances;

    /// Description:
    ///   IntInstance is the first object added automatically to the script using UsesObject. It's used internally by
    ///   the scripter.
    property IntInstance: TatObject read FIntInstance;

    /// Description:
    ///   Refactor property gives you access to the TatScriptRefactor object that allows refactoring operation in the script
    ///   source code. See TatScriptRefactor for more information.
    property Refactor: TatScriptRefactor read FRefactor;

    /// Description:
    ///   When compiling a form script, the compiler needs to load the form file in order to check which controls
    ///   are on the form. If DesignScriptForm is set to a valid TScriptForm, then the compiler does not load the form file,
    ///   but instead uses the instantiated form specified by DesignScriptForm to retrieve the names of controls.
    ///   This property should be used only for internal purposes, like the IDE environment.
    property DesignScriptForm: TScriptForm read FDesignScriptForm write FDesignScriptForm;

    /// Description:
    ///   When compiling a form script, the compiler needs to load the form file to retrieve the form resource. The form
    ///   resource is saved "inside" the script in the property ScriptInfo.FormResource, so that the form resource is saved
    ///   when the script is saved as a pcode. If DesignFormResource is set to a valid form resource, then the
    ///   compiler does not load the form file, but instead uses the DesignFormResource as the valid form resource to be saved
    ///   with the compiled script.
    property DesignFormResource: string read FDesignFormResource write FDesignFormResource;

    /// Description:
    ///   UnitName is used for script-based libraries. If a script adds "uses UNIT", the compiler
    ///   searches for files named "UNIT", and also for scripts inside Scripts collection which UnitName
    ///   matches "UNIT". There is UnitName property in both TatScript and TatScriptInfo classes.
    ///   Both are used for the same purpose, the difference is that TatScriptInfo.UnitName is only
    ///   filled after script is compiled, and it's also saved with compiled code. So, you must set
    ///   TatScript.UnitName if you want the unit to be found *before* it's compiled.
    ///   See TatCustomScripter.LoadLibrary for more info on libraries.
    {$WARNINGS OFF}
    property UnitName: string read FUnitName write FUnitName;

    /// Description:
    ///   Breaks property provides access to a TatScriptBreaks collection which holds the breakpoints for the script.
    ///   The different from Breaks to VirtualMachine.BreakPoints is that the latter is a low-level breakpoint
    ///   collection based on p-code, and should be rarely used. Breaks property, instead, is a higher level breakpoints collection
    ///   based on lines. Use Breaks instead of VirtualMachine.Breakpoints for better control of debugging and breakpoints.
    property Breaks: TatScriptBreaks read FBreaks;

    /// Description:
    ///   OnDestroy event is fired when the script object is destroyed.
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
  end;

  /// Description:
  ///   TatVirtualMachines is a collection of virtual machines. Currently this collection holds only one virtual machine, since
  ///   a script can't have more than one virtual machine.
  ///   You should not use this collection.
  TatVirtualMachines = class(TOwnedCollection)
  private
    function GetItems(i: integer): TatVirtualMachine;
  public
    /// Description:
    ///   Adds a new virtual machine. Should not be used, the script object already creates the first and only virtual machine
    ///   it needs
    function Add: TatVirtualMachine;

    /// Description:
    ///   Provides indexed access to existing virtual machines.
    property Items[i: integer]: TatVirtualMachine read GetItems; default;
  end;

  /// Description:
  ///   TatVirtualMachine object is used to execute a script compiled p-code. After the script is compiled, the compiled p-code
  ///   is saved in the memory and the script holds a reference to it. When the script is then executed, it uses the virtual machine
  ///   object to execute the code. The virtual machine then uses the compiled p-code in memory to run the script.
  ///   During script execution, several internal variables are updated by virtual machine. Specially when Delphi interoperation is
  ///   performed (accessing Delphi methods, properties, variables, etc.), the information kept by virtual machine is useful.
  ///   For example, the current object being accessed, the parameters passed to the current subroutine being executed, and so on.
  ///   Those information are useful for the methods that implement Delphi interoperability (those methods call the real Delphi
  ///   methods using the information provided by the virtual machine).
  TatVirtualMachine = class(TCollectionItem)
  private
    FScript                     : TatScript; // referencia o script correspondente
    FScripter                   : TatCustomScripter;
    { scripter configuration }
    FOnExecHook: TNotifyEvent;
    FOnPauseChanged             : TNotifyEvent;
    FOnRunningChanged           : TNotifyEvent;
    { compile time variables }
    FCurrentObject              : TObject;  // in-CallProc associated object
    FCurrentClass               : TatClass; // in-CallProc associated class
    {$IFDEF DELPHI2010_LVL}
    FCurrentRecordName          : string;
    {$ENDIF}
    {$IFNDEF LINUX}
    FCurrentOleObject           : Variant; // in-CallProc associated variant interface
    {$ENDIF}
    { compiled script runtime information }
    FProcStack                  : array[0..StackSize-1] of Variant; // pilha de execu��o
    FStackTop                   : integer; // �ndice de topo da pilha
    FStackBase                  : integer; // �ndice de base da pilha
    FInputBase                  : integer; // �ndice de base dos argumentos de entrada
    FOutputBase                 : integer; // �ndice de base dos resultados de sa�da
    FInputOffset                : integer; // n�mero de vari�veis de entrada
    FOutputOffset               : integer; // n�mero de vari�veis de sa�da
    FCurrentInputArgBase        : integer; // in-CallProc input argument index
    FCurrentArrayIndexBase      : integer; // in-CallProc input array index base
    FCurrentOutputArgIndex      : integer; // in-CallProc output argument index
    FNextInstruction            : pSimplifiedCode; // ponteiro para a pr�xima instru��o a ser executada
    FCurrentInstruction         : pSimplifiedCode; // ponteiro para a instru��o corrente na execu��o
    FLastExceptionMessage       : string;  // �ltima mensagem de exce��o ocorrida
    FLastExceptionHelpContext   : integer; // �ltimo contexto de ajuda de exec��o ocorrida
    FLastExceptionClassName     : string;  // �ltimo nome de classe de exec��o ocorrida
    FPrepareInstruction         : pSimplifiedCode; // Current runtime process (prepare instruction pointer)
    FBreakPoints                : TatScriptBreakPoints; // runtime break point collection
    FHalted                     : boolean; // sinaliza que um Halt foi processado
    FRunning                    : boolean; // indica que o script est� rodando ou est� pausado
    FPaused                     : boolean; // indica que o script est� pausado
    FCallExecHookEvent          : boolean;
    FComputeProcs               : array[TInstruction] of TGenericProc; // m�todos sem�nticos para as instru��es

    FMainBegin                  : pSimplifiedCode; // aponta para a instru��o de prepara��o do bloco principal (quando script j� inicializado)
    FInitialStackTop            : integer; //points to the initial stack top position (only valid if FInitialized is true)

    FDebugWatches               : TatDebugWatches; // watches para depura��o
    FStopInstruction            : pSimplifiedCode;
    FHooking                    : integer;
    FOldOnException             : TExceptionEvent;
    FExceptionRaised            : Exception;
    FInitialized                : boolean; //indicates if the initialization block of the script was executed (mainly for global constants initialization)
    FInTryExcept                : integer; //indicates if execution flow is in a try..except block
    FFastSolving: boolean;

    FAutoPause: boolean;
    FAutoPauseCurLine: integer;
    { execution control }
    function ExecProcess( ParamCount:integer ):integer;
    { sem�ntica }
    procedure _GlobalPrepare;
    procedure _Prepare;
    procedure _PushDouble;
    procedure _PushVar;
    procedure _PushIdxVar;
    procedure _PushVarByRef;
    procedure _PushString;
    procedure _PushOutput;
    procedure _PushConst;
    procedure _Duplicate;
    procedure _Duplicate2;
    procedure _Drop2;
    procedure _Swap2;
    procedure _OperNE;
    procedure _OperGE;
    procedure _OperLE;
    procedure _OperEqual;
    procedure _OperGreater;
    procedure _OperLess;
    procedure _OperAdd;
    procedure _OperConcat;
    procedure _OperSub;
    procedure _OperOr;
    procedure _OperXor;
    procedure _OperMul;
    procedure _OperSlash;
    procedure _OperDiv;
    procedure _OperMod;
    procedure _OperAnd;
    procedure _OperShl;
    procedure _OperShr;
    procedure _OperExp;
    procedure _OperNeg;
    procedure _OperNot;
    procedure _JumpIfFalse;
    procedure _JumpIfTrue;
    procedure _Jump;
    procedure _StoreVar;
    procedure _StoreIdxVar;
    procedure _StoreVarInteger;
    procedure _StoreVarDouble;
    procedure _StoreVarString;
    procedure _StoreVarConst;
    procedure _CopyVar;
    procedure _StoreVarRef;
    procedure _StoreIdxVarRef;
    procedure _StoreVarRefInteger;
    procedure _StoreVarRefDouble;
    procedure _StoreVarRefString;
    procedure _StoreVarRefConst;
    procedure _CopyVarRef;
    procedure _Call;
    procedure _Ret;
    procedure _StoreInput;
    procedure _ExecFun;
    procedure _PushInteger;
    procedure _TryFinally;
    procedure _TryExcept;
    procedure _CallProc;
    procedure _CallClassProc;
    procedure _BreakPoint;
    procedure _VarTest;
    procedure _VarTestInteger;
    procedure _VarTestDouble;
    procedure _VarTestString;
    procedure _VarTestVar;
    procedure _Abort;
    procedure _ArrayOf;
    procedure _CastClass;
    procedure _OperIs;
    procedure _PushClass;
    procedure _WithObject;
    procedure _StoreGlobalVar;
    procedure _StoreGlobalIdxVar;
    procedure _PushGlobalVar;
    procedure _PushGlobalIdxVar;
    procedure _PushGlobalVarByRef;
    procedure _TestIfFalse;
    procedure _TestIfTrue;
    { Undefined _CallProc }             
    procedure UndefinedGetterProc;
    procedure UndefinedSetterProc;
    procedure UndefinedMethodProc;
    {internal}
    procedure SetRunning(const Value: boolean);
    procedure SetPaused(const Value: boolean);
    function HandleScriptRunException(ex: Exception):boolean;
    procedure DoDebugHook;
    procedure DoExecHook;
    function GetStackContentAsString: string;
    function SetVarArrayElement(v: variant; ADim: integer): variant;
    function GetVarArrayElement(v: variant; ADim: integer): variant;
    function InternalExecuteSubroutine(AInstruction: pSimplifiedCode; AInputParamCount: integer=0): variant;
    procedure CompileDebugScript(AScript: TatScript);
    procedure ExecuteDebugScript(AScript: TatScript);
    procedure CheckHalted;
    procedure AppException(Sender: TObject; E: Exception);
    procedure InitializeScript(ADoBeforeExecute: boolean);
    procedure RuntimeError(msg: string);
    function TranslateClass(AClassIndex: integer): Tclass;
    function GetOnDebugHook: TNotifyEvent;
    procedure SetOnDebugHook(const Value: TNotifyEvent);
  protected
    procedure DoRunningChanged; virtual;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;

    /// Description:
    ///   Clear method resets the virtual machine, clearing several internal variables, erasing the stack, among other
    ///   operations. You don't need to call Clear method, it's called internally by other methods of virtual machine.
    procedure Clear;

    /// Description:
    ///   SolveAbsoluteAddressing method is used to translate address references to direct pointers, which are used by
    ///   p-code jump instructions. You don't need to call this method, it's automatically called by the virtual machine when needed.
    procedure SolveAbsoluteAddressing; virtual;

    /// Description:
    ///   InProcessExecute method executes a script code using the current virtual machine context. For example, if you call:
    ///   <code>
    ///    InProcessExecute('ShowMessage(MyVar);');
    ///   </code>
    ///   And MyVar is a global variable in the virtual machine being executed, it will work fine. You should rarely use in process
    ///   executions, this is mostly used for evaluating watches while debugging a script. For that purpose, use higher-level objects,
    ///   like TatCustomScripter.Watches property.
    procedure InProcessExecute( AScriptStr: string );

    /// Description:
    ///   Executes the script associated with the virtual machine.
    ///   If the script is not compiled, compilation is performed automatically.
    ///   <code>
    ///   The input parameter is deprecated and not used anymore.
    ///   </code>
    ///   The Execute function result contains value returned by the script main block. In pascal, you can use
    ///   return variable to pass the return value, even in the script main block.
    ///   In Basic, you must set MAIN variable to provide the return value.
    function Execute( input:variant ):variant; overload; virtual;
    function Execute:variant; overload; virtual;


    /// Description:
    ///   Executes a specific routine (procedure) declared in the script associated with the virtual machine. If
    ///   program is still not compiled, compilation is performed automatically.
    ///   ALabel must contain the name of the routine to be execute, no matching case is performed.
    ///   if the routine doesn't exist, an exception is raised. You can previously check if the routine
    ///   exists using TatScriptInfo.RoutineByName method.
    ///   Input parameter can contain values that will be passed to the script routine. Input
    ///   can be a single Variant-type value, or an array of variant, or an array of const.
    ///   These values are passed to the script routine as parameters. If the routine parameter is declared
    ///   as a parameter by reference - for example, MyScriptFunction(var MyParam: integer); - then to have your
    ///   variable to be updated, you must use the array of const version of ExecuteSubRoutine, passing a variant of
    ///   type Variant. Example:
    ///   <code>
    ///   //script
    ///   procedure MultiplyMyVar(var AValue: integer; AFactor: integer);
    ///   begin
    ///     AValue := AValue * AFactor;
    ///   end;
    ///
    ///   //Delphi
    ///   var
    ///   SomeVar: Variant; //MUST BE of Variant type
    ///   begin
    ///   SomeVar := 10;
    ///   atScripter1.ExecuteSubroutine('DoubleMyVar', [SomeVar, 3]);
    ///   //At this point, SomeVar will have value of 30
    ///   end;
    ///   </code>
    ///   The ExecuteSubRoutine function result contains value returned by the called function.
    function ExecuteSubroutine( ALabel:string; input:variant ):variant; overload;
    function ExecuteSubroutine( ALabel:string ):variant; overload;
    function ExecuteSubroutine( ALabel:string; input:array of const ):variant; overload;

    /// Description:
    ///   Same as ExecuteSubroutine.
    function ExecuteSubroutineEx( ALabel:string; input:array of const ):variant;

    /// Description:
    ///   GetArrayIndex provides the index value of a Delphi indexed property being executed. The desired dimension
    ///   is specified in ADim parameter.
    ///   For example, if the virtual machine is executing a get (or set) operation of an indexed property, like this:
    ///   <code>
    ///   //script
    ///   MyObject.MyIndexedProperty['customer', 5] := 10;
    ///   </code>
    ///   then calling GetArrayIndex(0) will return 'customer' and GetArrayIndex(1) will return 5.
    function GetArrayIndex(ADim:integer):variant;

    /// Description:
    ///   Returns the number of arguments passed to the Delphi method being executed. Example:
    ///   <code>
    ///   //script being executed
    ///   MyObject.MyMethod('param', 20, 0);
    ///   </code>
    ///   When the virtual machine executes the method wrapper for MyMethod above,
    ///   InputArgCount will be 3.
    function InputArgCount: integer;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed.
    ///   The parameter is indexed by AIndex. For the first parameter, index must be 0. Example:
    ///   <code>
    ///   //script being executed
    ///   MyObject.MyMethod('param', 20, 0);
    ///   </code>
    ///   When the virtual machine executes the method wrapper for MyMethod above,
    ///   GetInputArg(0) will be 'param' and GetInputArg(1) will be 20.
    function GetInputArg(AIndex:integer):variant;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as a string value.
    ///   The parameter is indexed by AIndex. For the first parameter, index must be 0. Example:
    ///   <code>
    ///   //script being executed
    ///   MyObject.MyMethod('param', 20, 0);
    ///   </code>
    ///   When the virtual machine executes the method wrapper for MyMethod above,
    ///   GetInputArgAsString(0) will be 'param' and GetInputArgAsString(1) will be '20'.
    function GetInputArgAsString(AIndex:integer):string;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as a string value.
    ///   The parameter is indexed by AIndex. For the first parameter, index must be 0. Example:
    ///   <code>
    ///   //script being executed
    ///   MyObject.MyMethod('param', 20, 0);
    ///   </code>
    ///   When the virtual machine executes the method wrapper for MyMethod above,
    ///   GetInputArgAsString(0) will be 'param' and GetInputArgAsString(1) will be '20'.
    function GetInputArgAsClass(AIndex: integer): TClass;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as a wide string value.
    ///   See GetInputArg for more info.
    function GetInputArgAsWidestring(AIndex: integer): widestring;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as an integer value.
    ///   See GetInputArg for more info.
    function GetInputArgAsInteger(AIndex:integer):integer;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as a boolean value.
    ///   For scripter, a boolean value is a integer test to zero. If zero, then boolean value is false. Otherwise,
    ///   it's true. An exception is raised if the value cannot be converted to an integer.
    ///   See GetInputArg for more info.
    function GetInputArgAsBoolean(AIndex:integer):boolean;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as a float value.
    ///   See GetInputArg for more info.
    function GetInputArgAsFloat(AIndex:integer):double;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as a date time value.
    ///   See GetInputArg for more info.
    function GetInputArgAsDateTime(AIndex:integer):TDateTime;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as a char value.
    ///   See GetInputArg for more info.
    function GetInputArgAsChar(AIndex: integer): char;

    /// Description:
    ///   Returns the value of the parameter passed to the Delphi method being executed, as a wide char value.
    ///   See GetInputArg for more info.
    function GetInputArgAsWideChar(AIndex: integer): WideChar;

    /// Description:
    ///   Sets the value of a parameter passed to a Delphi method by reference. The parameter is specified by index AIndex,
    ///   and the AValue must contain the value to be set. For example, if a Delphi method with the following signature was registered
    ///   in scripter:
    ///   <code>
    ///   MyMethod(AName, ATest: string; ACode: integer; var AStrResult: string);
    ///   </code>
    ///   when that method is executed by virtual machine, the method wrapper can set the value of AStrResult to 'ok' using the following code:
    ///   <code>
    ///   AMachine.SetInputArg(3, 'ok');
    ///   </code>
    ///   if the parameter specified by AIndex is not passed as reference, an exception is raised.
    procedure SetInputArg(AIndex: integer; const AValue: variant);

    /// Description:
    ///   Same as SetInputArg, with one difference: if the parameter is not passed by reference, nothing happens, while SetInputArg
    ///   raises an exception. See SetInputArg for more information.
    procedure SetInputArgIfByRef(AIndex: integer; const AValue: variant);

    {$IFDEF DELPHI2010_LVL}
    /// Description:
    ///   Same as SetInputArg, but receives a TValue record instead a variant.
    procedure SetInputArgValue(AIndex: integer; const AValue: TValue);
    {$ENDIF}

    /// Description:
    ///   Use ReturnOutputArg to set the return value of a Delphi function called by virtual machine. For example, if the machine
    ///   is executing a function with the following signature:
    ///   <code>
    ///   function DoubleTheValue(AValue: integer): integer;
    ///   </code>
    ///   you can set the return value of the function this way, in the method wrapper:
    ///   <code>
    ///   AMachine.ReturnOutputArg(AMachine.GetInputArgAsInteger(0) * 2);
    ///   </code>
    procedure ReturnOutputArg(AValue: variant);

    {$IFDEF DELPHI2010_LVL}
    /// Description:
    ///   Same as ReturnOutputArg, but receives a TValue record instead a variant.
    procedure ReturnOutputArgValue(AValue: TValue);
    {$ENDIF}

    /// Description:
    ///   Stops the current script execution. Same as setting Running property to false.
    procedure Halt;

    /// Description:
    ///   Returns the first p-code instruction that corresponds to the source code line specified by ARow.
    function InstructionByLine(ARow: integer): pSimplifiedCode;

    /// Description:
    ///   Returns the first p-code instruction of the routine specified by ALabel.
    function EntryPoint(ALabel: string): pSimplifiedCode;

    /// Description:
    ///   Performs debug trace info operation in current script. This method should not be used very often because it works
    ///   at p-code instruction level. Use DebugTraceIntoLine instead.
    procedure DebugTraceInto;

    /// Description:
    ///   Performs debug step over operation in current script. This method should not be used very often because it works
    ///   at p-code instruction level. Use DebugStepOverLine instead.
    procedure DebugStepOver;

    /// Description:
    ///   Performs debug trace into operation in script. A trace into operation executes the current line and pauses the execution
    ///   in the very next line. If the current line being executed is a routine call, then the execution stops at the first line
    ///   of the routine.
    procedure DebugTraceIntoLine;

    /// Description:
    ///   Performs debug step over operation in script. A step over operation executes the current line and pauses the execution
    ///   in the very next line. If the current line being executed is a routine call, the whole routine is executed at once.
    procedure DebugStepOverLine;

    /// Description:
    ///   Unpauses the script (if paused) and continues script execution until current routine is terminated (or script main block).
    procedure DebugRunUntilReturn;

    /// Description:
    ///   Unpauses the script (if paused) and continues script execution until the instruction specified by AInstruction is reached.
    ///   When that happens, the script execution is paused again.
    procedure DebugRunToPoint(AInstruction:pSimplifiedCode);

    /// Description:
    ///   Unpauses the script (if paused) and continues script execution until the line specified by ALine is reached.
    ///   When that happens, the script execution is paused again.
    procedure DebugRunToLine(ALine:integer);

    /// Description:
    ///   Create a breakpoint (or remove if there is already one) in the instruction specified by AInstruction. This method returns
    ///   true if a breakpoint was previously set, false otherwise. Do not use this method very often, use DebugToggleBreakLine instead.
    function DebugToggleBreakPoint(AInstruction: pSimplifiedCode):boolean;

    /// Description:
    ///   Create a breakpoint (or remove if there is already one) in the line specified by ALine. This method returns
    ///   the first p-code instruction that correspondes to the line.
    function DebugToggleBreakLine(ALine:integer):pSimplifiedCode;

    /// Description:
    ///   Returns the number of the next line in source code to be executed.
    function DebugExecutionLine:integer;

    /// Description:
    ///   Returns the name of the Delphi property being accessed by the virtual machine. This function is useful when you have a single
    ///   wrapper for multiple Delphi properties, this way you can tell which specific property is being accessed.
    function CurrentPropertyName: string;

    /// Description:
    ///   Returns the name of the Delphi method being called by the virtual machine. This function is useful when you have a single
    ///   wrapper for multiple Delphi method, this way you can tell which specific method is being called.
    function CurrentMethodName: string;

    /// Description:
    ///   Returns the TatScript object which this virtual machine belongs to.
    property Script: TatScript read FScript;

    /// Description:
    ///   Returns the TatScripter component which this virtual machine belongs to.
    property Scripter: TatCustomScripter read FScripter;

    /// Description:
    ///   Contains the error message of the last exception raised during script execution. Same as accessing Message property of the
    ///   exception object.
    property LastExceptionMessage: string read FLastExceptionMessage;

    /// Description:
    ///   Contains the help context of the last exception raised during script execution. Same as accessing HelpContext property of the
    ///   exception object.
    property LastExceptionHelpContext: integer read FLastExceptionHelpContext;

    /// Description:
    ///   Contains the class name of the last exception raised during script execution. For example, if the last exception raised was
    ///   EConvertError, this function will return 'EConvertError'.
    property LastExceptionClassName: string read FLastExceptionClassName;

    /// Description:
    ///   Contains a reference to the Delphi object which property/method is being accessed/called. For example, if the script
    ///   contains a call like this:
    ///   <code>
    ///   MyObject.MyMethod(1);
    ///   </code>
    ///   CurrentObject will return the reference to MyObject. You will often use CurrentObject in the wrappers to access the actual
    ///   object properties or call its methods.
    property CurrentObject: TObject read FCurrentObject;

    /// Description:
    ///   Contains a reference to the Delphi class which class property/method is being accessed/called. For example, if the script
    ///   contains a call like this:
    ///   <code>
    ///   TPersistent.Create;
    ///   </code>
    ///   CurrentClass will return the reference to TPersistent class. You can use CurrentClass in the wrappers to access the actual
    ///   class properties or call its methods.
    property CurrentClass: TatClass read FCurrentClass;

    /// Description:
    ///   Deprecated. Use TatScript.Breaks instead.
    property BreakPoints: TatScriptBreakPoints read FBreakPoints write FBreakPoints;

    /// Description:
    ///   Returns true if the script has been halted and is still being executed. Halted property will always be false if the
    ///   script is not running.
    property Halted: boolean read FHalted;

    /// Description:
    ///   Use Running property to check if the current script is being executed (regardless of the value of Paused property). You can
    ///   also set Running to true to execute a script, or set it to false to halt execution.
    property Running: boolean read FRunning write SetRunning;

    /// Description:
    ///   Indicates if the current script is Paused. You can also set Paused property to true to pause current execution, or to ensure
    ///   that the script will stop at its first instruction when it is executed. Setting Paused to true or false doesn't change
    ///   the value of Running property, they are independent.
    property Paused: boolean read FPaused write SetPaused;

    /// Description:
    ///   Do not use this property, use TatCustomScripter.CallExecHookEvent instead.
    property CallExecHookEvent: boolean read FCallExecHookEvent write FCallExecHookEvent;

    /// Description:
    ///   Do not use this event, use TatCustomScripter.OnDebugHook instead.
    property OnDebugHook: TNotifyEvent read GetOnDebugHook write SetOnDebugHook;

    /// Description:
    ///   Do not use this event, use TatCustomScripter.OnExecHook instead.
    property OnExecHook: TNotifyEvent read FOnExecHook write FOnExecHook;

    /// Description:
    ///   OnPausedChanged is fired whenever the value of Paused property changes.
    property OnPauseChanged: TNotifyEvent read FOnPauseChanged write FOnPauseChanged;

    /// Description:
    ///   OnRunningChanged event is fired whenever the value of Running property changes.
    property OnRunningChanged: TNotifyEvent read FOnRunningChanged write FOnRunningChanged;

    /// Description:
    ///   Returns the current p-code instruction being executed by the virtual machine.
    property CurrentInstruction: pSimplifiedCode read FCurrentInstruction;

    /// Description:
    ///   Returns the next p-code instruction to be executed by the virtual machine.
    property NextInstruction: pSimplifiedCode read FNextInstruction write FNextInstruction;

    /// Description:
    ///   PrepareInstruction contains a reference to the last p-code Prepare instruction executed. When PrepareInstruction
    ///   is not nil, it means that the script is being executed. When script finishes its execution, the PrepareInstruction is
    ///   reverted to the state previously to script execution. Used by internal methods to verify if the current script is
    ///   being executed with reentrant calls (a script is being executed and a Delphi event fires causing the execution of
    ///   a subroutine of the same script.
    ///   You will rarely need to access this property.
    property PrepareInstruction: pSimplifiedCode read FPrepareinstruction;

    /// Description:
    ///   Deprecated, do not use it. For watches manipulation, use TatScript.Watches instead.
    property DebugWatches: TatDebugWatches read FDebugWatches;
  end;

  /// Description:
  ///   TatScriptInfo object provides information about the current script, such as the declared routines (available in Routines property),
  ///   global variables (available in Globals property), among others. Information is only available if the current script was compiled (with Compile method) or silent compiled
  ///   (with SilentCompile method).
  TatScriptInfo = class(TComponent)
  private
    FRoutines    : TatRoutinesInfo;
    FCodeSize    : integer;
    FGlobals     : TatVariablesInfo;
    FScript      : TatScript;
    FMainRoutine : TatRoutineInfo;
    FScriptClassName: string;
    FFormResource: string;
    FIsForm: boolean;
    FUnitName: string;
    procedure UpdateRoutineInfoPointers;
    procedure SetGlobals(const Value: TatVariablesInfo);
    procedure SetRoutines(const Value: TatRoutinesInfo);
    function GetMainRoutineName: string;
    procedure SetMainRoutineName(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// Description:
    ///   Erases all available information. To populate the information again, you will need to recompile the script. Note that
    ///   calling Clear method does not set the TatScript.Compiled flag to false.
    procedure Clear;

    /// Description:
    ///   Retrieves the TatRoutineInfo object associated with the script routine specified by AName. If the routine doesn't exist
    ///   in the script, RoutineByName returns nil.
    function RoutineByName(AName:string):TatRoutineInfo;

    /// Description:
    ///   Adds a new routine in the script info Routines collection. Do not call this method direclty, it's used internally
    ///   by the compiler.
    function DeclareRoutine(AName:string;ADeclInst:pSimplifiedCode;AIsFunction:boolean):TatRoutineInfo;

    /// Description:
    ///   Retrives the number of p-code instructions generated after compilation. In other words, it's the size of the "executable".
    property CodeSize:integer read FCodeSize;

    /// Description:
    ///   Provides access to the TatScript object that owns this script info.
    property Script: TatScript read FScript;

    /// Description:
    ///   Retrieves the TatRoutineInfo obejct associated with the script main block (which is treated in a similar way as
    ///   any other routine in script).
    property MainRoutine: TatRoutineInfo read FMainRoutine write FMainRoutine;
  published
    /// Description:
    ///   Provides access to the TatRoutinesInfo collection which holds information about all routines declared in the script.
    property Routines: TatRoutinesInfo read FRoutines write SetRoutines;

    /// Description:
    ///   Provides access to the TatVariablesInfo collection which holds information about all global variables declared in the script.
    property Globals : TatVariablesInfo read FGlobals write SetGlobals;

    /// Description:
    ///   Used only for streaming (saving of compiled code) purposes. Do not use this property.
    property MainRoutineName: string read GetMainRoutineName write SetMainRoutineName;

    /// Description:
    ///   If the current script is a form script, then it behaves as a form class declaration (all routines act as the form methods,
    ///   and all global variables are form properties). In that case, ScriptClassName will hold the name of the form class ('TMyForm',
    ///   for example). That's the name that will be accessible from script, for creating a form instance, for example: TMyForm.Create.
    property ScriptClassName: string read FScriptClassName write FScriptClassName;

    /// Description:
    ///   If the current script is a form script, once the script is compiled, the dfm file referenced by it is loaded, and saved
    ///   in FormResource property, for further usage (instantiating new forms, saving compiled code to file, etc.). The dfm file
    ///   is not used anymore, unless the script is cleared, which will require a new compilation.
    property FormResource: string read FFormResource write FFormResource;

    /// Description:
    ///   IsForm property indicates if the current script is a regular script (IsForm is false) or a form script (IsForm is true).
    ///   A script is a form script when it contains the $FORM directive.
    property IsForm: boolean read FIsForm write FIsForm;

    {$WARNINGS OFF}
    /// Description:
    ///   UnitName is used for script-based libraries. If a script adds "uses UNIT", the compiler
    ///   searches for files named "UNIT", and also for scripts inside Scripts collection which UnitName
    ///   matches "UNIT".
    property UnitName: string read FUnitName write FUnitName;
  end;

  /// Description:
  ///   TatRoutinesInfo holds a list of TatRoutineInfo objects which contains information about the routines declared in script,
  ///   such as the routine name, parameters, etc.. The main routine is also present in the collection.
  TatRoutinesInfo = class(TOwnedCollection)
  private
    FScriptInfo : TatScriptInfo;
    function GetItem(i:integer):TatRoutineInfo;
  public
    /// Description:
    ///   Returns the index, in the collection, of the routine specified by AName. If there is no such routine, IndexOf returns -1.
    function IndexOf(AName:string):integer;

    /// Description:
    ///   Fills the AStrings object with the names of declared routines.
    procedure GetNames(AStrings: TStrings);

    /// Description:
    ///   Provides indexed-access to the TatRoutineInfo objects in the collection.
    property Items[i:integer]:TatRoutineInfo read GetItem; default;
  end;

  /// Description:
  ///   Indicates if the routine was declared as private or public in the script. When the script is registered as a script library,
  ///   its routines are available from other scripts, except when it is declared as private.
  ///   rvPublic - Routine was declared as public (visible to other scripts)
  ///   rvPrivate - Routine was declared as private (visible only from script itself)
  TatRoutineVisibility = (rvPublic, rvPrivate);

  /// Description:
  ///   TatRoutineInfo holds information about the routine declared in script. You can retrieve parameters, local variables,
  ///   visibility, and more.
  TatRoutineInfo = class(TCollectionItem)
  private
    FVariables              : TatVariablesInfo;
    FName                   : string;
    FDeclarationInstruction : pSimplifiedCode;
    FIsFunction             : boolean;
    FArgCount               : integer;
    FByRefArgMask           : integer;
    FResultIndex            : integer;
    FPrototype              : TatRoutineInfo;
    FCallingConvention      : TatCallingConvention;
    FExternalDll            : string;
    FExternalName           : string;
    FResultTypeDecl         : string;
    FResultClass            : TatClass;
    FVisibility: TatRoutineVisibility;
    procedure SetVariables(const Value: TatVariablesInfo);
    function ResultTypeKind: TatTypeKind;
    function ResultClass: TatClass;
    function ResultClassRef: TClass;
    procedure DispatchDllCall( AMachine: TatVirtualMachine );
    function GetResultTypeDecl: string;
    procedure SetResultTypeDecl(const Value: string);
    procedure SetTypeFromString(ATypeStr: string);
  public
    constructor Create(ACollection:TCollection); override;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;

    /// Description:
    ///   Returns a reference to the TatScriptInfo object which owns this routine info.
    function ScriptInfo: TatScriptInfo;

    /// Description:
    ///   Returns a TatVariableInfo object related to the variable (or parameter) specified by the name AName. If the variable
    ///   or parameter doesn't exist, VariableByName returns nil.
    function VariableByName(AName: string):TatVariableInfo;

    /// Description:
    ///   Returns the number of local variables declared in the routine. This function doesn't take into account the routine
    ///   parameters, only effective local variables. Note that the result variable (in case of a function routine) is also
    ///   considered as a local variable.
    function LocalVarCount: integer;

    /// Description:
    ///   Do not call DeclareVariable directly. It's used by internal parsers/compilers.
    function DeclareVariable(AName: string; ASourcePos:integer;AArgIndex:integer=-1;AModifier:TatArgumentModifier=moNone): TatVariableInfo;

    /// Description:
    ///   DeclarationInstruction contains the Prepare p-code instruction related to the routine. It's the first p-code to be
    ///   executed and allocates space in stack for local variables and parameters.
    ///   You will rarely need to use this property.
    property DeclarationInstruction:pSimplifiedCode read FDeclarationInstruction write FDeclarationInstruction;

    /// Description:
    ///   If a routine had a previous declaration using forward directive, then there will be two TatRoutineInfo objects in the
    ///   Routines collection. In this case, the second routine declaration (after the forward one), will have the Prototype property
    ///   set. This property contains a reference to the routine prototype (declared with forward directive). If the routine
    ///   doesn't have a previous prototype declaration, Prototype property will be nil.
    property Prototype: TatRoutineInfo read FPrototype write FPrototype;

    /// Description:
    ///   Do not use this method directly. Used for internal purposes only.
    procedure PrepareExternalClass;

    /// Description:
    ///   Used by scripter engine only.
    function Internal: boolean;
  published
    /// Description:
    ///   Contains the name of the declared routine.
    property Name: string read FName write FName;

    /// Description:
    ///   Holds a list of TatVariableInfo objects with information about all the parameters and local variables
    ///   declared in the routine.
    property Variables: TatVariablesInfo read FVariables write SetVariables;

    /// Description:
    ///   Returns true if the routine returns a result value. In other words, IsFunction is true when the routine is a function,
    ///   false if the routine is a procedure/sub.
    property IsFunction:boolean read FIsFunction write FIsFunction;

    /// Description:
    ///   ArgCount returns the number of input parameters declared in the routine. Note that it doesn't take local variables into account,
    ///   just input parameters.
    property ArgCount:integer read FArgCount write FArgCount;

    /// Description:
    ///   ByRefArgMask contains information about which input parameters in the routine were declared by reference (using var/byref
    ///   modified). ByRefArgMask is a bit mask, in which each bit represents a parameter, being the less significant bit the first
    ///   parameter, and so on. Below are some examples:
    ///   <code>
    ///   //Parameter AResult is by reference. Index of AResult is 2 (3rd parameter)
    ///   //ByRefArgMask will be in binary 100 (3rd less signficant bit set)
    ///   //So ByRefArgMas integer value will be 4
    ///   procedure MyRoutine(AName: string; AValue: integer; var AResult: boolean);
    ///
    ///   //Parameters Value1, Value2 and Error are passed by reference.
    ///   //Index of parameters are 0, 1 and 3 (1st, 2nd and 4th parameters)
    ///   //ByRefArgMask will be in binary 1011
    ///   //So ByRefArgMas integer value will be 11
    ///   procedure SwapValues(var Value1, Value2: integer; Flag: string; var Error: integer);
    ///   </code>
    property ByRefArgMask:integer read FByRefArgMask write FByRefArgMask;

    /// Description:
    ///   Contains the index of the variable (in Variables collection) that corresponds to the function result. When a
    ///   function is declared, the function result value is declared as a local variable. Its index in the Variables collection
    ///   is provided by this property.
    property ResultIndex: integer read FResultIndex write FResultIndex;

    /// Description:
    ///   Contains information about the calling convention of the declared routine. Used only in dll function calls.
    property CallingConvention: TatCallingConvention read FCallingConvention write FCallingConvention;

    /// Description:
    ///   Contains the name of the dll declared in the routine prototype. This is only used when the declared routine is a
    ///   prototype for a dll function call.
    property ExternalDll: string read FExternalDll write FExternalDll;

    /// Description:
    ///   Contains the real name of the function to be called in the dll. This is only used when the declared routine is a
    ///   prototype for a dll function call.
    property ExternalName: string read FExternalName write FExternalName;

    /// Description:
    ///   Contains the identifier of the result type of the declared function routine. For example, if you declare the
    ///   following routine in script:
    ///   <code>
    ///   function MyFunction: string;
    ///   </code>
    ///   ResultTypeDecl will be 'string'.
    property ResultTypeDecl: string read GetResultTypeDecl write SetResultTypeDecl;

    /// Description:
    ///   Indicates the visibility of the routine (private or public).
    property Visibility: TatRoutineVisibility read FVisibility write FVisibility;
  end;

  /// Description:
  ///   TatVariablesInfo is a collection of TatVariableInfo objects that hold information about variables declared in script.
  ///   If the TatVariablesInfo relates to a routine, then it will contain all declared local variables, the input parameters
  ///   of the routine, and the variable result value (if it's a function). If TatVariablesInfo relates to the script as a whole,
  ///   it will contain the global variables declared in script.
  TatVariablesInfo = class(TOwnedCollection)
  private
    function GetItem(i:integer):TatVariableInfo;
  public
    /// Description:
    ///   Adds a new variable in the collection. Do not call this directly, it will not effectively change source code to declare
    ///   a new variable. This is used by the compiler to add information in the collection.
    function Add:TatVariableInfo;

    /// Description:
    ///   Returns the index of the variable which name is specified by AName. If no variable is found, IndexOf returns -1.
    function IndexOf(AName:string):integer;

    /// Description:
    ///   Returns the TatVariableInfo object which corresponds to the variable which name is specified by Name. If no variable
    ///   is found, FindByName returns nil.
    function FindByName(AName:string):TatVariableInfo;

    /// Description:
    ///   Provides indexed access to the TatVariableInfo objects in the collection.
    property Items[i:integer]:TatVariableInfo read GetItem; default;
  end;

  /// Description:
  ///   Indicates if the global variable was declared as private or public in the script. When the script is registered
  ///   as a script library, its global variables are available from other scripts, except when it is declared as private.
  ///   vvPublic - Global variable was declared as public (visible to other scripts)
  ///   vvPrivate - Global variable was declared as private (visible only from script itself)
  TatVariableVisibility = (vvPublic, vvPrivate);

  /// Description:
  ///   Holds information about a variable declared in the script. Although the word "variable" here, it's important to
  ///   note that not only local and global variables, but also routine input parameters and function result value also have
  ///   an associated TatVariableInfo object.
  TatVariableInfo = class(TCollectionItem)
  private
    FVarName                : string;
    FDeclarationSourcePos   : integer;
    FArgIndex               : integer; // indica que a vari�vel � um argumento de subrotina
    FModifier               : TatArgumentModifier; // indica o modificador do argumento de subrotina
    FDeclaredClass          : TatClass; // classe declarada para a vari�vel
    FGlobal                 : boolean;
    FTypeDecl               : string; // string contendo informa��es sobre o tipo da vari�vel ou argumento de subrotina
    FSystemType             : integer;
    FVisibility: TatVariableVisibility;
    function GetValue:variant;
    procedure SetValue(AValue:variant);
    function Script: TatScript;
    function Routine:TatRoutineInfo;
    function GetDeclaredClassName: string;
    procedure SetDeclaredClassName(const Value: string);
    procedure PullSystemType;
  public
    constructor Create(ACollection: TCollection); override;
    procedure Assign(ASource:TPersistent); override;

    /// Description:
    ///   Used by compiler. Do not use this function.
    procedure SetTypeFromString(ATypeStr: string);

    /// Description:
    ///   Provides a reference to the TatScriptInfo object that holds information about this variable.
    function ScriptInfo: TatScriptInfo;

    /// Description:
    ///   Indicates if the variable is an internal variable, like for-loops variable. Ignore variables that are
    ///   declared as internal.
    function Internal: boolean;

    /// Description:
    ///   VarIndex is used by the compiler to know the position of the variable in the stack, relative to the current
    ///   stack base. With regarding to the stack, local variables are located in a positive index from stack base,
    ///   and input parameters are with negative values.
    ///   You don't need to use this method.
    function VarIndex: integer;

    /// Description:
    ///   Returns true if the variable has the same declaration as the variable passed in AVariable parameter.
    ///   This method is used to check if a routine prototype contains the same declaration and the routine implementation,
    ///   so the compiler can checks for inconsistences and generate a compile error if, for example, the input parameters are different.
    function SameDeclaration(AVariable:TatVariableInfo): boolean;

    /// Description:
    ///   Retrieves or sets the effective value of the variable in script. This only makes sense when the script is running,
    ///   for example, if you have a local routine variable and/or input parameter, the variable will only exist when the script execution
    ///   reaches that routine. The only exception are global variables. In this case, you can set or read the value even before or
    ///   after the script execution.
    property Value:variant read GetValue write SetValue;

    /// Description:
    ///   Retrieves the TatClass object associated with the declared type of variable. If the variable type is not a class, DeclaredClass
    ///   will contain nil.
    property DeclaredClass: TatClass read FDeclaredClass write FDeclaredClass;
  published
    /// Description:
    ///   Holds the name of the declared variable.
    property VarName:string read FVarName write FVarName;

    /// Description:
    ///   Contains the position in the source code where the variable was declared.
    property DeclarationSourcePos:integer read FDeclarationSourcePos write FDeclarationSourcePos;

    /// Description:
    ///   If the TatVariableInfo object refers to an input parameter, ArgIndex will have the position of the input parameter
    ///   in the list of parameters. First parameter has ArgIndex of 0. If the variable is not an input parameter, ArgIndex
    ///   will be -1. For example, for the following routine declared in script:
    ///   <code>
    ///   procedure MyRoutine(Param1, Param2: integer);
    ///   var
    ///     MyVar1, MyVar2: integer;
    ///   begin
    ///   end;
    ///   </code>
    ///   ArgIndex of Param1 will be 0, Param2 will be 1, and both MyVar1 and MyVar2 will have ArgIndex set to -1.
    property ArgIndex: integer read FArgIndex write FArgIndex;

    /// Description:
    ///   If it is an input parameter, Modifier will hold the modifier used in routine declaration ("var", "const", none, etc.).
    property Modifier: TatArgumentModifier read FModifier write FModifier;

    /// Description:
    ///   Indicates if the variable is a global variable or not.
    property Global: boolean read FGlobal write FGlobal;

    /// Description:
    ///   Retrieves the name of the declared variable class. If the variable type is not a class type, but a scalar type
    ///   (string, integer, etc.), DeclaredClassName value will be an empty string.
    property DeclaredClassName: string read GetDeclaredClassName write SetDeclaredClassName;

    /// Description:
    ///   Contains the name of the declared type of variable. For example, if the variable was declared:
    ///   <code>
    ///   var MyVar: integer;
    ///   </code>
    ///   TypeDecl will contain 'integer'.
    property TypeDecl: string read FTypeDecl write FTypeDecl;

    /// Description:
    ///   For internal use only. SystemType contains the TVarType value of the declared variable. This value is extracted and
    ///   calculated by the compiler based on the value of TypeDecl property.
    property SystemType: integer read FSystemType write FSystemType;

    /// Description:
    ///   Indicates the visibility of the variable (private or public).
    property Visibility: TatVariableVisibility read FVisibility write FVisibility;
  end;

  /// Description:
  ///   Internal interface used from manipulation of record types
  IatInterfacedObject = interface
    ['{44284F76-2152-4326-9CB7-DEC05852B5CA}']
    function GetObjectReference: TObject;
  end;

  {$M+}
  /// Description:
  ///   TatRecordWrapper is a class used to allow scripter to iteract with record types. All records in scripter are
  ///   treated as objects descending from TatRecordWraper. When scripter needs to receive or send a record type from/to
  ///   Delphi methods, it encapsulates the record in the TatRecordWrapper object. Each record type must have its own
  ///   class descending from TatRecordWrapper, implementing the record fields as object properties.
  TatRecordWrapper = class(TInterfacedObject,IatInterfacedObject)
  public
    function GetObjectReference: TObject;
  end;
  {$M-}

  /// Description:
  ///   Deprecated.
  ///   Allows manipulation of breakpoints at p-code level. Do not use this approach, use TatScriptBreaks collection instead.
  ///   See TatScript.Breaks property.
  TatScriptBreakPoints = class(TCollection)
  private
    FMachine : TatVirtualMachine;
    function GetItem(i: integer): TatScriptBreakPoint;
  public
    constructor Create(AMachine:TatVirtualMachine);
    function InsertNormalBreak(ATargetInst:pSimplifiedCode):TatScriptBreakPoint;
    function InsertTempBreak(ATargetInst:pSimplifiedCode):TatScriptBreakPoint;
    function RemoveBreakPoint(ATargetInst: pSimplifiedCode): boolean;
    function BreakPointByLine(ALine:integer):TatScriptBreakPoint;
    function Add: TatScriptBreakPoint;
    property Items[i:integer]:TatScriptBreakPoint read GetItem; default;
  end;

  /// Description:
  ///   Deprecated.
  ///   Contains information about a breakpoint at p-code level. Do not use this approach, use TatScriptBreaks collection
  ///   and TatScriptBreak objects instead. See TatScript.Breaks property.
  TatScriptBreakPoint = class(TCollectionItem)
  private
    FOriginalInst : TSimplifiedCode; // Contains a copy of original instruction
    FBreakInst    : pSimplifiedCode; // Points to the inserted break instruction
    FPassCount    : integer;
    FEnabled      : boolean;
    FAutoDestroy  : boolean;
    FNotifyBreak: TatScriptBreak;
    //function GetBreakLine: integer;
    procedure SetBreakInst(ATargetInst: pSimplifiedCode);
    procedure RemoveBreak;
    procedure NormalBreakProc;
    procedure TemporaryBreakProc;
    //function GetBreakLine: integer;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function Machine: TatVirtualMachine;
    property OriginalInst: TSimplifiedCode read FOriginalInst write FOriginalInst;
    //property BreakInst: pSimplifiedCode read FBreakInst  write FBreakInst;
    property PassCount: integer read FPassCount write FPassCount;
    property Enabled: boolean read FEnabled write FEnabled;
    property AutoDestroy: boolean read FAutoDestroy write FAutoDestroy;
  end;

  /// Description:
  ///   Internal use only.
  TLoopStatement = (lsNone, lsFor, lsWhile, lsRepeat);

  /// Description:
  ///   TatClasses holds a collection of TatClass objects that contain information abuot all Delphi classes registered in scripter system,
  ///   including its methods and properties. When a Delphi class is registered, scripter knows about it and can interact with
  ///   the class accordingly.
  TatClasses = class(TCollection)
  private
    FScripter : TatCustomScripter;
    function GetItem(i:integer):TatClass;
    function GetImplicitCount: integer;
  protected
    function AddClassByRTTI(AClass: TClass; AClassName: string=''): TatClass;
    {$IFDEF DELPHI2010_LVL}
    function AddClassByRTTIEx(AClass: TClass; AClassName: string='';
      AVisibilityFilter: TMemberVisibilitySet = [mvPublic, mvPublished];
      ARecursive: boolean = False; ARedefine: TRedefineOption = roNone): TatClass; overload;
    {$ENDIF}
    function AddRecord(ATypeInfo: PTypeInfo; ARecordName: string=''): TatClass;
    function AddDelphiClass(AClass: TClass; AClassName: string=''): TatClass;
    function CheckLoaded(AClass:TClass; AClassName: string=''): TatClass;
    property ImplicitCount: integer read GetImplicitCount;
  public
    constructor Create(AScripter:TatCustomScripter);

    /// Description:
    ///   Do not use this method. Use TatCustomScripter.DefineClass instead.
    function Add(AName,AAncestorName:string):TatClass;

    /// Description:
    ///   Returns the index of a class which name is specified by AName. If the class is not found, IndexOf returns -1.
    function IndexOf(AName:string):integer;

    /// Description:
    ///   Returns the TatClass object corresponding to the class which name is specified by AName.
    ///   If the class is not found, ClassByName returns nil.
    function ClassByName(AName: string): TatClass;

    /// Description:
    ///   Use by internal methods only. Do not call directly.
    function TestCheckLoaded(AClass: TClass; var ACurrentClass:TatClass; AClassName: string = ''): boolean;

    /// Description:
    ///   Provides indexed access to the TatClass objects in the collection.
    property Items[i:integer]:TatClass read GetItem; default;
  end;

  /// Description:
  ///   Holds information about a Delphi class registered in scripter. A TatClass object holds information about the Delphi registered
  ///   class, its methods, properties, and provides methods for registering new methods and properties in the class.
  TatClass = class(TCollectionItem)
  private
    FName            : string;
    FProperties      : TatProperties;
    FMethods         : TatMethods;
    FClassRef        : TClass; // para uso com RTTI tobject
    FRecordRef       : PTypeInfo;
    FAncestorName    : string;
    FAncestor        : TatClass;
    FDescendants     : TList;
    FDefaultProperty : TatProperty;
    //For internal use only, it's used when the class is registered by a SelfRegisterAsLibrary
    FBaseScript      : TatScript;
    FImplicitElement: TCollectionItem;
    procedure Inherits(AAncestorName: string);
    { VCL classes - helper procs }
    procedure RemoveDescendant(ADescendant: TatClass);
    procedure InsertDescendant(ADescendant: TatClass);
    procedure NotifyDescendants;
    procedure AncestorDestroyed;
    procedure SetMethods(const Value: TatMethods);
    procedure SetProperties(const Value: TatProperties);
    function GetIsImplicit: boolean;
    procedure SetImplicitElement(const Value: TCollectionItem);
  public
    constructor Create( ACollection:TCollection ); override;
    destructor Destroy; override;

    /// Description:
    ///   Deprecated. Use DefineMethod instead.
    function SetProc(AName: string; ACode: pointer; AArgCount: integer; AResultDataType: TatTypeKind; AProc: TGenericProc;
      AResultClass: TClass; AIsClassMethod: boolean = false; ADefArgCount: integer = 0): TatMethod;

    /// Description:
    ///   Deprecated. Use DefineNewMethod instead.
    function AddProc(AName: string; ACode: pointer; AArgCount: integer; AResultDataType: TatTypeKind; AProc: TGenericProc;
      AResultClass: TClass; AIsClassMethod: boolean = false; ADefArgCount: integer = 0): TatMethod;

    /// Description:
    ///   Returns the TatProperty object associated with the property specified by AName. If such property doesn't exist,
    ///   PropertyByName returns nil.
    function PropertyByName(AName:string):TatProperty;

    /// Description:
    ///   Returns the TatProperty object associated with the class property specified by AName. If such property doesn't exist,
    ///   ClassPropertyByName returns nil.
    function ClassPropertyByName(AName:string):TatProperty;

    /// Description:
    ///   Returns the TatMethod object associated with the method specified by AName. If such method doesn't exist,
    ///   MethodByName returns nil.
    function MethodByName(AName:string):TatMethod;

    /// Description:
    ///   Returns the TatMethod object associated with the class method specified by AName. If such method doesn't exist,
    ///   ClassMethodByName returns nil.
    function ClassMethodByName(AName: string): TatMethod;

    /// Description:
    ///   Returns the TatClass corresponding to AClassName, only if the current class is descendant from the specified class.
    ///   For example, if this object refers to Delphi class TForm, when you call:
    ///   CastFromString('TWinControl')
    ///   the TatClass corresponding to TWinControl will be retrieved. If TWinControl is not an ancestor or not found, an exception
    ///   is raised.
    function CastFromString( AClassName: string ): TatClass;

    /// Description:
    ///   Remove the property specified by the name AName.
    procedure RemoveProperty(AName: string);

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddEnumeration(ATypeInfo: PTypeInfo);

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddObject( AName:string; AObject:TObject );

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddConstant( AName:string; AValue:variant );

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:variant ); overload;

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:extended  ); overload;

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:double  ); overload;

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:string  ); overload;

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:widestring  ); overload;

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:integer ); overload;

    /// Description:
    ///   Deprecated. Use DefineProp instead.
    procedure AddVariable( AName:string; var AVar:boolean ); overload;

    /// Description:
    ///   Deprecated. Use DefineNewProp/DefineProp instead.
    function AddProp(AName:string;ADataType:TatTypeKind;AGetter,ASetter:TGenericProc;APropertyClass:TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0):TatProperty;

    /// Description:
    ///   Deprecated. Use DefineNewProp/DefineProp instead.
    function SetProp(AName: string; ADataType: TatTypeKind; AGetter,ASetter: TGenericProc; APropertyClass: TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0): TatProperty;

    /// Description:
    ///   Deprecated. Use DefineNewProp/DefineProp instead.
    procedure AddIntegerProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Deprecated. Use DefineNewProp/DefineProp instead.
    procedure AddStringProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Deprecated. Use DefineNewProp/DefineProp instead.
    procedure AddBooleanProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Deprecated. Use DefineNewProp/DefineProp instead.
    procedure AddFloatProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Deprecated. Use DefineNewProp/DefineProp instead.
    procedure AddVariantProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Deprecated. Use DefineNewProp/DefineProp instead.
    procedure AddObjectProp(AName:string;AGetter,ASetter:TGenericProc;APropertyClass:TClass;AIsClassProp:boolean=false);

    /// Description:
    ///   Declare the object specified by AObject as a property in the class, accessible through the name AName. You can then access
    ///   AObject instance from script as if it was a property of another object.
    procedure AddDelphiObjectProp(AName:string;AObject:TObject);

    /// Description:
    ///   Registers a new property in the class. You don't need to register published properties since they are imported automatically
    ///   by Delphi scripter.
    ///   Parameters:
    ///   AName - The name by which the property will be accessible from script.
    ///   ADataType - The data type of the property.
    ///   AGetter, ASetter - The method wrapper which will be called by the script when the property is read/write from script. Those are the methods that should actually read or write the real Delphi property.
    ///   APropertyClass - If ADataType is tkClass, then APropertyClass must contain the class of the property (TFont, for example). Otherwise, PropertyClass must be nil.
    ///   AIsClassProp - Indicates if the property is a regular property (accessible from object instance) or a class property.
    ///   AIndexCount - If the registered property is an indexed property, then AIndexCount must contain the number of dimensions of the property.
    ///
    ///   The function will return the newly created TatProperty.
    ///   If a property with the name AName already exists in the class, nothing is created, and the function will return the existing TatProperty object.
    function DefineProp(AName:string;ADataType:TatTypeKind;AGetter,ASetter:TMachineProc;APropertyClass:TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0):TatProperty;

    /// Description:
    ///   Registers a new property in the class. DefineNewProp works the same as DefineProp, with the small difference that
    ///   regardless if a property named AName already exists in the class or not, a new TatProperty will be created. If there was already
    ///   a property with same name, two objects TatProperty relating to the same property will exist in the class.
    ///   Scripter will always use the last one added, so it will work as expected. The advantage of creating two TatProperty objects
    ///   is that you can destroy your created object and still you have the previous one. The disadvantage is that if you call
    ///   DefineNewProp too many times, you will end up with much more memory consumed because of duplicated properties in the TatClass object.
    ///   See DefineProp for more information.
    function DefineNewProp(AName:string;ADataType:TatTypeKind;AGetter,ASetter:TMachineProc;APropertyClass:TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0):TatProperty;

    /// Description:
    ///   Declares an integer property. See DefineProp for more details.
    procedure DefineIntegerProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Declares a string property. See DefineProp for more details.
    procedure DefineStringProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Declares a boolean property. See DefineProp for more details.
    procedure DefineBooleanProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Declares a float property. See DefineProp for more details.
    procedure DefineFloatProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Declares a variant property. See DefineProp for more details.
    procedure DefineVariantProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);

    /// Description:
    ///   Declares an object property. See DefineProp for more details.
    procedure DefineObjectProp(AName:string;AGetter,ASetter:TMachineProc;APropertyClass:TClass;AIsClassProp:boolean=false);

    /// Description:
    ///   Deprecated. Use DefineMethod/DefineNewMethod instead.
    function AddMethod(AName: string; AArgCount: integer; AResultDataType: TatTypeKind; AResultClass: TClass;
      AProc: TGenericProc; AIsClassMethod: boolean = false; ADefArgCount: integer = 0): TatMethod;

    /// Description:
    ///   Registers a new method in the class. DefineNewMethod works the same as DefineMethod, with the small difference that
    ///   regardless if a method named AName already exists in the class or not, a new TatMethod will be created. If there was already
    ///   a method with same name, two objects TatMethod relating to the same method will exist in the class.
    ///   Scripter will always use the last one added, so it will work as expected. The advantage of creating two TatMethod objects
    ///   is that you can later destroy your created object and still you have the previous one. The disadvantage is that if you call
    ///   DefineNewMethod too many times, you will end up with much more memory consumed because of duplicated method in the TatClass object.
    ///   See DefineMethod for more information.
    function DefineNewMethod(AName: string; AArgCount: integer; AResultDataType: TatTypeKind; AResultClass: TClass;
      AProc: TMachineProc; AIsClassMethod: boolean = false; ADefArgCount: integer = 0): TatMethod;

    /// Description:
    ///   Registers a new method in the class.
    ///   Parameters:
    ///   AName - The name by which the method will be accessible from script.
    ///   AArgCount - The number of input arguments received by the method.
    ///   AResultDataType - The data type returns by the method, in case method is function. If the method is a procedure, this must be tkNone.
    ///   AResultClass - If AResultDataType is tkClass, then AResultClass must contain the class of the result value (TFont, for example). Otherwise, AResultClass must be nil.
    ///   AProc - The method wrapper which will be called by the script when the method is to be called from script. This is the method that should actually execute real Delphi method.
    ///   AIsClassMethod - Indicates if the method is a regular method (accessible from object instance) or a class method.
    ///   ADefArgCount - The number of default arguments of the method. Must be equal or lower than AArgCount.
    ///   If AArgCount is 5 and ADefArgCount is 2, for example, it means that last 2 input parameters are optional, so the method can be
    ///   called with 3, 4 or 5 input parameters.
    ///
    ///   DefineMethod will return the newly created TatMethod object.
    ///   If a method with the name AName already exists in the class, nothing is created, and DefineMethod will return the existing TatMethod object.
    function DefineMethod(AName: string; AArgCount: integer; AResultDataType: TatTypeKind; AResultClass: TClass;
      AProc: TMachineProc; AIsClassMethod: boolean = false; ADefArgCount: integer = 0): TatMethod;

    /// Description:
    ///   Contains the name of the class as it is known by scripter. For example, 'TButton'.
    property Name:string read FName write FName;

    /// Description:
    ///   Holds the list of properties declared in the class.
    property Properties:TatProperties read FProperties write SetProperties;

    /// Description:
    ///   Holds the list of methods declared in the class.
    property Methods:TatMethods read FMethods write SetMethods;

    /// Description:
    ///   Contains the name of the class which is the direct ancestor of current class.
    property AncestorName:string read FAncestorName write FAncestorName;

    /// Description:
    ///   Holds the Delphi TClass reference that is associated with the current registered class.
    property ClassRef: TClass read FClassRef write FClassRef;

    /// Description:
    ///   Contains a reference to the TatClass object which is a direct ancestor of this registered class.
    property Ancestor: TatClass read FAncestor write FAncestor;

    /// Description:
    ///   Indicates which is the default property of the class. Used for indexed properties.
    property DefaultProperty: TatProperty read FDefaultProperty write FDefaultProperty;

    /// Description:
    ///   For internal use only. Do not use this property.
    property ImplicitElement: TCollectionItem read FImplicitElement write SetImplicitElement;

    /// Description:
    ///   For internal use only. Do not use this property.
    property IsImplicit: boolean read GetIsImplicit;
  end;

  /// Description:
  ///   Holds the list of TatProperty objects which are the registered properties for the class.
  TatProperties = class(TCollection)
  private
    FClass : TatClass;
    function GetItem(i:integer):TatProperty;
  public
    constructor Create( AClass:TatClass );

    /// Description:
    ///   Provides indexed access to the TatProperty objects in the collection.
    property Items[i:integer]:TatProperty read GetItem; default;

    /// Description:
    ///   Registers a new property using RTTI info for the property. You don't need to call this method because the scripter already
    ///   registers all published properties automatically using AddByRTTI, so will rarely need to use it.
    function AddByRTTI(APropInfo:PPropInfo):TatProperty;

    /// Description:
    ///   Returns the index of the TatProperty object associated with the property specified by AName.
    function IndexOf(AName:string):integer;

    /// Description:
    ///   Returns the TatProperty object associated with the property specified by AName.
    function PropertyByName(AName:string):TatProperty;

    /// Description:
    ///   Returns the TatProperty object associated with the class property specified by AName.
    function ClassPropertyByName(AName:string):TatProperty;

    /// Description:
    ///   Provides a reference to the TatClass object in which this property collection is registered.
    property atClass: TatClass read FClass;
  end;

  /// Description:
  ///   Contains information about a property registered in scripter system. This information is used by the scripter to know
  ///   if a class contains a specified property, and how this property should be accessed.
  TatProperty = class(TCollectionItem)
  private
    FScripter      : TatCustomScripter;
    FName          : string;
    FDataType      : TatTypeKind;
    FGetter        : TGenericProc;
    FSetter        : TGenericProc;
    FPropertyClass : TClass;
    FPropertyClassName: string;
    FPropInfo      : PPropInfo; // for use with RTTI
    FValue         : variant; // class values
    FIsClassProp   : boolean;
    FIndexCount    : integer; // > 0 if property is an array
    procedure RTTIGetterProc(AMachine:TatVirtualMachine);
    procedure RTTISetterProc(AMachine:TatVirtualMachine);
    procedure GetFormComponentProc(AMachine:TatVirtualMachine);
    procedure GetDelphiObjectPropProc(AMachine:TatVirtualMachine);
    procedure GetVariantPropProc(AMachine:TatVirtualMachine);
    procedure GetBoolVariablePropProc(AMachine: TatVirtualMachine);
    procedure GetExtVariablePropProc(AMachine: TatVirtualMachine);
    procedure GetDblVariablePropProc(AMachine: TatVirtualMachine);
    procedure GetIntVariablePropProc(AMachine: TatVirtualMachine);
    procedure GetStrVariablePropProc(AMachine: TatVirtualMachine);
    procedure GetWStrVariablePropProc(AMachine: TatVirtualMachine);
    procedure GetVarVariablePropProc(AMachine: TatVirtualMachine);
    procedure SetBoolVariablePropProc(AMachine: TatVirtualMachine);
    procedure SetExtVariablePropProc(AMachine: TatVirtualMachine);
    procedure SetDblVariablePropProc(AMachine: TatVirtualMachine);
    procedure SetIntVariablePropProc(AMachine: TatVirtualMachine);
    procedure SetStrVariablePropProc(AMachine: TatVirtualMachine);
    procedure SetWStrVariablePropProc(AMachine: TatVirtualMachine);
    procedure SetVarVariablePropProc(AMachine: TatVirtualMachine);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create( ACollection:TCollection ); override;
    procedure Assign(Source: TPersistent); override;

    /// Description:
    ///   Used by internal compiler, you don't need to use this method.
    ///   When a property type is a class, then calling UpdateObjectInfo will retrieve in ACurrentClass the class object the
    ///   corresponds to the property class type. If the class doesn't exist, the scripter automatically registers it and load
    ///   its published properties. Returns true if the property is a class property.
    function UpdateObjectInfo(var ACurrentClass: TatClass): boolean;

    /// Description:
    ///   Provides a reference to the TatClass object in which this property is registered.
    function atClass: TatClass;

    /// Description:
    ///   Provides a reference to the scripter object which this registered property belongs to.
    property Scripter: TatCustomScripter read FScripter write FScripter;

    /// Description:
    ///   Contains the name of the property.
    property Name:string read FName write FName;

    /// Description:
    ///   Holds the method wrapper which will be called by the script when the property is read from script. This is the method
    ///   that should actually read the real Delphi property.
    property Getter:TGenericProc read FGetter write FGetter;

    /// Description:
    ///   Holds the method wrapper which will be called by the script when the property is written in script. This is the method
    ///   that should actually write the real Delphi property.
    property Setter:TGenericProc read FSetter write FSetter;

    /// Description:
    ///   Holds the data type of the property.
    property DataType:TatTypeKind read FDataType write FDataType;

    /// Description:
    ///   Not used.
    property Value:variant read FValue write FValue;

    /// Description:
    ///   Indicates if the property is a regular property (accessible from object instance) or a class property.
    property IsClassProp:boolean read FIsClassProp write FIsClassProp;

    /// Description:
    ///   Holds the class of the property. If DataType property is tkClass, then PropertyClass must contain the class of the
    ///   property (TFont, for example). Otherwise, PropertyClass must be nil.
    property PropertyClass: TClass read FPropertyClass write FPropertyClass;

    /// Description:
    ///   PropInfo holds RTTI information about the registered property. This property only has a valid value for published properties,
    ///   otherwise its value is nil.
    property PropInfo: PPropInfo read FPropInfo write FPropInfo;

    /// Description:
    ///   If the registered property is an indexed property, then IndexCount must contain the number of dimensions of the property.
    property IndexCount: integer read FIndexCount write FIndexCount;
  end;

  /// Description:
  ///   Holds the list of TatMethod objects which are the registered method for the class.
  TatMethods = class(TCollection)
  private
    FClass : TatClass;
    function GetItem(i:integer):TatMethod;
  public
    constructor Create( AClass:TatClass );

    /// Description:
    ///   Provides indexed access to the TatMethod objects in the collection
    property Items[i:integer]:TatMethod read GetItem; default;

    /// Description:
    ///   Returns the index of the TatMethod object associated with the method specified by AName.
    function IndexOf(AName:string):integer;

    /// Description:
    ///   Returns the TatMethod object associated with the method specified by AName.
    function MethodByName(AName:string):TatMethod;

    /// Description:
    ///   Returns the TatMethod object associated with the class method specified by AName.
    function ClassMethodByName(AName: string): TatMethod;

    /// Description:
    ///   Provides a reference to the TatClass object in which this method is registered.
    property atClass: TatClass read FClass;
  end;

  /// Description:
  ///   Contains information about a method registered in scripter system. This information is used by the scripter to know
  ///   if a class contains a specified method, and how this method should be accessed.
  TatMethod = class(TCollectionItem)
  private
    FScripter       : TatCustomScripter;
    FName           : string;
    FProc           : TGenericProc;
    FResultDataType : TatTypeKind;
    FArgCount       : integer;
    FCode           : pointer; // for use with internal procs
    FResultClass    : TClass;
    FArgDefs        : TatDataDefs;
    FIsClassMethod  : boolean;
    FByRefArgMask   : integer;
    FDefArgCount    : integer;
    FResultClassName: string;
    procedure SetArgDefs(const Value: TatDataDefs); // variable arguments bit mask (just initial 32 arguments will be checked in compile time!!!)
  protected
    function GetDisplayName: string; override;
  public
    constructor Create( ACollection:TCollection ); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    /// Description:
    ///   Used by internal compiler, you don't need to use this method.
    ///   When a method result type is a class, then calling UpdateObjectInfo will retrieve in ACurrentClass the class object that
    ///   corresponds to the method return type. If the class doesn't exist, the scripter automatically registers it and load
    ///   its published properties. Returns true if the method return type is a class.
    function UpdateObjectInfo( var ACurrentClass:TatClass ):boolean;

    /// Description:
    ///   Use SetVarArgs to specify which input parameters must be passed by reference to the method. argi must contain an array
    ///   of byte with the index of the parameters, zero being the first parameter. For example, if you have the following Delphi
    ///   method you want to register in scriper:
    ///   <code>
    ///   procedure MyDelphiMethod(var A, B; integer; C: string; var D: string);
    ///   </code>
    ///   you can register that method this way:
    ///   <code>
    ///   with DefineMethod('MyDelphiMethod', 4, tkNone, nil, MyDelphiMethodProc, 0) do
    ///     SetVarArgs([0, 1, 4]); //First, Second and Third parameters are passed by reference
    ///   </code>
    procedure SetVarArgs(argi:array of byte);

    /// Description:
    ///   Check if an input parameter is specified to be passed by reference.
    ///   IsByRefArg returns true if the n-th input parameter indicated by n is declared to be passed by reference. For the first
    ///   input parameter, n must be zero.
    ///   See SetVarArgs method for more information.
    function IsByRefArg(n:byte):boolean;

    /// Description:
    ///   Provides a reference to the TatClass object in which this method is registered.
    function atClass: TatClass;

    /// Description:
    ///   Provides a reference to the scripter object which this registered method belongs to.
    property Scripter: TatCustomScripter read FScripter write FScripter;

    /// Description:
    ///   Contains the name by which the method will be accessible from script.
    property Name:string read FName write FName;

    /// Description:
    ///   Contains the method wrapper which will be called by the script when the method referenced. This is the method that
    ///   should actually execute real Delphi method.
    property Proc:TGenericProc read FProc write FProc;

    /// Description:
    ///   Holds the data type returned by the method, in case method is function. If the method is a procedure, this must be tkNone.
    property ResultDataType:TatTypeKind read FResultDataType write FResultDataType;

    /// Description:
    ///   Contains the number of input arguments received by the method.
    property ArgCount:integer read FArgCount write FArgCount;

    /// Description:
    ///   Contains the number of default arguments of the method. Must be equal or lower than ArgCount.
    ///   If ArgCount is 5 and ADefArgCount is 2, for example, it means that last 2 input parameters are optional, so the method can be
    ///   called with 3, 4 or 5 input parameters.
    property DefArgCount: integer read FDefArgCount write FDefArgCount;

    /// Description:
    ///   ArgDefs is a collection of TatDataDef objects that hold extra information about the method's input parameters.
    property ArgDefs: TatDataDefs read FArgDefs write SetArgDefs;

    /// Description:
    ///   Indicates if the method is a regular method (accessible from object instance) or a class method.
    property IsClassMethod: boolean read FIsClassMethod write FIsClassMethod;

    {Not used.}
    property Code: pointer read FCode write FCode;

    /// Description:
    ///   if ResultDataType is tkClass, then ResultClass must contain the class of the result value (TFont, for example).
    ///   Otherwise, ResultClass must be nil.
    property ResultClass: TClass read FResultClass write FResultClass;

    /// Description:
    ///   ByRefArgMask contains information about which input parameters in the method must be passed by reference (using var/byref
    ///   modifier), according to what was previously set using SetVarArgs method. ByRefArgMask is a bit mask, in which each bit
    ///   represents a parameter, being the less significant bit the first parameter, and so on. Below are some examples:
    ///   <code>
    ///   //Parameter AResult is by reference. Index of AResult is 2 (3rd parameter)
    ///   //ByRefArgMask will be in binary 100 (3rd less signficant bit set)
    ///   //So ByRefArgMas integer value will be 4
    ///   procedure MyRoutine(AName: string; AValue: integer; var AResult: boolean);
    ///
    ///   //Parameters Value1, Value2 and Error are passed by reference.
    ///   //Index of parameters are 0, 1 and 3 (1st, 2nd and 4th parameters)
    ///   //ByRefArgMask will be in binary 1011
    ///   //So ByRefArgMas integer value will be 11
    ///   procedure SwapValues(var Value1, Value2: integer; Flag: string; var Error: integer);
    ///
    ///   DO NOT set ByRefArgMask directly to specify which parameters are passed by reference, use SetVarArgs method instead.
    ///   </code>
    property ByRefArgMask: integer read FByRefArgMask write FByRefArgMask;
  end;

  /// Description:
  ///   TatDataDefs is a collection of TatDataDef objects that hold information about the input parameters of a specified method.
  ///   You can have name, modifier, data type, among other information for each input parameter.
  TatDataDefs = class(TCollection)
  private
    function GetItem(i:integer):TatDataDef;
  public
    constructor Create( AClass:TatClass );

    /// Description:
    ///   Provides indexed-access to a TatDataDef object in the collection.
    property Items[i: integer]: TatDataDef read GetItem; default;

    /// Description:
    ///   Adds a new TatDataDef object in the collection. Do not call this method directly, it's only used internally
    ///   by the scripter.
    function Add(AName:string;ADataType:TatTypeKind;AModifier:TatArgumentModifier):TatDataDef;
  end;

  /// Description:
  ///   Holds information about a input parameter in a registered method.
  TatDataDef = class(TCollectionItem)
  private
    FName     : string;
    FDataType : TatTypeKind;
    FModifier : TatArgumentModifier;
  public
    procedure Assign(ASource:TPersistent); override;

    /// Description:
    ///   Contains the name of the input parameters. It's not being used for now, in future this might be used for code-insight
    ///   operations, for example.
    property Name:string read FName write FName;

    /// Description:
    ///   Contains the data type of the input parameter. This information is not being used by the scripter yet.
    property DataType:TatTypeKind read FDataType write FDataType;

    /// Description:
    ///   Contains the modifier of the input parameter (const, var, etc.).
    property Modifier:TatArgumentModifier read FModifier write FModifier;
  end;

  /// Description:
  ///   Holds a list of object instances that are being accessible from scripts in a "default" way (methods and properties
  ///   are directly accessed).
  /// See also:
  ///   TatCustomScripter.DefaultInstances; TatScript.DefInstances; TatCustomScripter.UsesObject
  TatObjects = class(TCollection)
  private
    FClasses : TatClasses;
    function GetItem(i:integer):TatObject;
  public
    constructor Create(AClasses:TatClasses);

    /// Description:
    ///   Adds a new object instance. See TatCustomScripter.UsesObject for more info on parameters.
    function Add(AInstance:TObject; AName: string=''; AClassName: string = ''):TatObject;

    /// Description:
    ///   Returns the index of TatObject which holds the method specified by AMethodName. If the method is found,
    ///   a reference to it is returned in AMethod parameter.
    function FindInstanceByMethodName(AMethodName: string; var AMethod: TatMethod): integer;

    /// Description:
    ///   Returns the index of TatObject which holds the property specified by APropertyName. If the property is found,
    ///   a reference to it is returned in AProperty parameter.
    function FindInstanceByPropertyName(APropertyName: string; var AProperty: TatProperty): integer;

    /// Description:
    ///   Returns the TatObject instance which correspondes to the class name specified by AClassName.
    ///   See TatCustomScripter.UsesObject for more information.
    function FindInstanceByClassName(AClassName: string): TatObject;

    /// Description:
    ///   Returns the index in the collection of the object specified by AName.
    function IndexOf(AName:string): integer;

    /// Description:
    ///   Provides indexed-access to the TatObject objects in the collection.
    property Items[i:integer]:TatObject read GetItem; default;
  end;

  /// Description:
  ///   Holds information about an object instance that is being accessible from scripts in a "default" way (methods and properties
  ///   are directly accessed).
  /// See Also:
  ///   TatCustomScripter.DefaultInstances; TatScript.DefInstances; TatCustomScripter.UsesObject
  TatObject = class(TCollectionItem)
  private
    FName     : string;
    FInstance : TObject;
    FatClass  : TatClass;
    procedure SeTatClass(const Value: TatClass);
  public
    procedure Assign(ASource:TPersistent); override;

    /// Description:
    ///   Holds the name by which the object can be accessed from script.
    /// See Also:
    ///   TatCustomScripter.DefaultInstances; TatScript.DefInstances; TatCustomScripter.UsesObject
    property Name:string read FName write FName;

    /// Description:
    ///   Holds the instance of the object that can be accessed from script.
    /// See also:
    ///   TatCustomScripter.DefaultInstances; TatScript.DefInstances; TatCustomScripter.UsesObject
    property Instance:TObject read FInstance write FInstance;

    /// Description:
    ///   Contains a reference to the TatClass object holding information about the class of the object, its methods and
    ///   properties than can be accessed in a default way.
    /// See also:
    ///   TatCustomScripter.DefaultInstances; TatScript.DefInstances; TatCustomScripter.UsesObject
    property atClass:TatClass read FatClass write SeTatClass;
  end;

  /// Description:
  ///   This class is used internally by scripter system. Do not bother about it.
  ///   Contains a list of classes referenced implicit from the script (like a property of type TFont being accessed,
  ///   a reference for TFont is registered.
  ///   This is used for saving compiled code properly, so when loading the code, scripter can recover/re-register all
  ///   classes implicitly registered during compilation.
  TatClassRefs = class(TCollection)
  private
    FScript: TatScript;
    function GetItem(i: integer): TatClassRef;
  public
    constructor Create(AScript: TatScript);
    function Add(AClassIndex,AElementIndex:integer;AElementIsMethod:boolean; AClassName, AElementName: string):TatClassRef;
    property Items[i:integer]:TatClassRef read GetItem; default;
  end;

  /// Description:
  ///   Used internally by scripter system. Do not use it.
  ///   See TatClassRefs for more details.
  TatClassRef = class(TCollectionItem)
  private
    FClassIndex      : integer; // relative to TatClasses instance
    FElementIndex    : integer; // relative to TatMethods or TatProperties
    FElementIsMethod : boolean; // true if element is a method, false if element is a property
    FElementName: string;
    FClassName: string;
  public
    procedure CheckLoaded;
    property ClassIndex: integer read FClassIndex;
    property ElementIndex: integer read FElementIndex;
    property ElementIsMethod: boolean read FElementIsMethod;
  end;

  /// Description:
  ///   Holds information about a unit used in the script. See TatScript.UsedUnits property for more info.
  TatUsedUnit = class(TCollectionItem)
  private
    FIsDefault: boolean;
    FUnitName: string;
    FIsScript: boolean;
    FDeclSourcePos: integer;
  public
    {$WARNINGS OFF}
    /// Description:
    ///   Contains the name of used unit.
    property UnitName: string read FUnitName write FUnitName;

    /// Description:
    ///   Indicates if the unit, as a library, was registered using Default parameter. See RegisterScripterLibrary procedure
    ///   for more information.
    property IsDefault: boolean read FIsDefault write FIsDefault;

    /// Description:
    ///   Indicates if the used unit was a script-based library.
    property IsScript: boolean read FIsScript write FIsScript;

    /// Description:
    ///   Indicates the position of the source code in which the used unit was declared (in uses clause).
    property DeclSourcePos: integer read FDeclSourcePos write FDeclSourcePos;
  end;

  /// Description:
  ///   Holds a collection of TatUsedUnit objects related to the used units in the script. See TatScript.UsedUnits property for more info.
  TatUsedUnits = class(TCollection)
  private
    FScripter : TatCustomScripter;
    function GetItem(i: integer): TatUsedUnit;
  public
    constructor Create(AScripter:TatCustomScripter);

    /// Description:
    ///   Returns the TatUsedUnit object for the used unit specified by the name AUnitName.
    function FindByName(AUnitName: string): TatUsedUnit;

    /// Description:
    ///   Adds a new used unit. Do not use this method, it is used internally by the compiler.
    function Add: TatUsedUnit;

    /// Description:
    ///   Provides indexed-access to the TatUsedUnit objects in the collection.
    property Items[i:integer]: TatUsedUnit read GetItem; default;
  end;

  {$M+}
  /// Description:
  ///   TatScripterLibrary is the ancestor class for all Delphi-based libraries that can be registered in the scripter.
  ///   Descendants of this class can be registered in script system using RegisterScripterLibrary procedure, or
  ///   TatCustomScripter.AddLibrary method. See also TatCustomScripter.LoadLibrary.
  ///   Main method in class is Init. Override Init method to register classes, methods and properties in scripter.
  ///   Other methods can be overriden as well, like Finalize and LibraryName.
  TatScripterLibrary = class
  private
    FScripter: TatCustomScripter;

    /// Description:
    ///   Used to destroy the default instance create. For now, this is just for internal use
    ///   in AddLibraryInstance and RemoveLibraryInstance.
    FDefaultInstanceName: string;
    procedure SelfProc( AMachine: TatVirtualMachine );
  protected
    /// Description:
    ///   Init method is called when this library is registered using TatCustomScripter.AddLibrary method, or when the
    ///   library is initialized after found by the scripter in the uses clause of some script.
    ///   You must override Init method in your libraries to register classes, methods and properties in the scripter.
    procedure Init; virtual; abstract;

    /// Description:
    ///   Finalize method is called by the scripter when the library is removed from the scripter. Override Finalize method
    ///   to remove all classes, methods and properties you have previously registered in Init method.
    procedure Finalize; virtual;

    /// Description:
    ///   Provides a reference to the Scripter object in which you this library must register the classes, methods and properties.
    property Scripter: TatCustomScripter read FScripter;
  public
    /// Description:
    ///   Override class function LibraryName to provide the name for which the library will be known by scripter.
    /// See also:
    ///   TatCustomScripter.LoadLibrary; TatCustomScripter.AddLibrary
    class function LibraryName: string; virtual;

    /// Description:
    ///   Creates a new library instance. You do not need to create scripter library instances, they are created automatically
    ///   by scripter
    constructor Create(AScripter: TatCustomScripter); virtual;
  end;
  {$M-}

  /// Description:
  ///   TatDLL is a special TatScripterLibrary descendant that holds registered methods that will actually call dll functions.
  ///   TatDLL holds a reference to a internal TatClass object.
  ///   When a script declares a function that is a prototype to a dll function, a new method is registered in the internal class
  ///   so that scripter recognized that method as a valid procedure. When that method is called, the actual dll function is executed.
  TatDLL = class(TatScripterLibrary)
  private
    FScript   : TatScript;
    FFileName : string;
    FatClass  : TatClass;
  public
    /// Description:
    ///   Initialized the library. Just registered the class of this library in the scripter.
    procedure Init; override;

    /// Description:
    ///   Remove all methods registered in the class.
    procedure Finalize; override;

    /// Description:
    ///   Returns the internal _DLL_ name for the library.
    class function LibraryName: string; override;
  end;

  /// Description:
  ///   TatScriptBasedLibrary is a special TatScripterLibrary descendant that allows scripts to be registered as libraries.
  ///   When a script is registered as a library, its methods and properties are accessible from script. This class
  ///   helps it make it happen.
  ///   You will not need to use this class, it is used internally by the scripter to allow script-based libraries.
  TatScriptBasedLibrary = class(TatScripterLibrary)
  private
    FInternalScript: TatScript;
    FName: string;
    FMethodList: TList;
    FPropList: TList;
    FRegClass: TClass;
    FRegClassName: string;
    FNewClass: TatClass;
    function GetRunScript(AMachine: TatVirtualMachine): TatScript;
    procedure ExecSubRoutineProc(AMachine: TatVirtualMachine);
    procedure GetScriptVarProc(AMachine: TatVirtualMachine);
    procedure SetScriptVarProc(AMachine: TatVirtualMachine);
  protected
    /// Description:
    ///   Registers the routines and global variables in the script as default methods and properties in the scripter to
    ///   be accessible from other scripts.
    procedure Init; override;

    /// Description:
    ///   Removes all methods and properties registered by Init method.
    procedure Finalize; override;
  public
    constructor Create(AScripter: TatCustomScripter); override;
    destructor Destroy; override;
  end;

  /// Description:
  ///   Holds information about a library registered with RegisterScripterLibrary.
  ///   You don't need to use this class, it's used internally by scripter.
  TatLibraryListItem = class(TCollectionItem)
  private
    FLibraryClass: TatScripterLibraryClass;
    FExplicitLoad: boolean;
  public
    procedure Assign(Source: TPersistent); override;

    /// Description:
    ///   Contains the reference to the library class. This class will be instantiated in the case of the library to be
    ///   requested from a script in the uses clause.
    property LibraryClass: TatScripterLibraryClass read FLibraryClass write FLibraryClass;

    /// Description:
    ///   When ExplicitLoad is true, the library specified by LibraryClass will always be instantiated and automaticaly used
    ///   when a new scripter component is created. If it is false, the library will only be used if it is explicity requested
    ///   from script in a uses clause:
    ///   <code>
    ///   uses MyLibrary;
    ///   </code>
    property ExplicitLoad: boolean read FExplicitLoad write FExplicitLoad;
  end;

  /// Description:
  ///   Holds a list of the libraries registered with RegisterScripterLibrary.
  ///   You don't need to use this class, it's used internally by scripter.
  TatLibraryList = class(TCollection)
  private
    function GetItem(Index: integer): TatLibraryListItem;
  public
    /// Description:
    ///   Adds a new item. Do not use it. See RegisterScripterLibrary procedure for more information.
    function Add: TatLibraryListItem;

    /// Description:
    ///   Removes an item. Do not use it. See RegisterScripterLibrary procedure for more information.
    procedure Remove(ALibrary: TatScripterLibraryClass);

    /// Description:
    ///   Finds a library by its name. Do not use it. See RegisterScripterLibrary procedure for more information.
    function FindByLibraryName( ALibName: string ): TatLibraryListItem;

    /// Description:
    ///   Provides indexed-access to the library items. Do not use it. See RegisterScripterLibrary procedure for more information.
    property Items[Index: integer]: TatLibraryListItem read GetItem; default;
  end;

  /// Description:
  ///   TatScripterEventBroker is a class used by scripter to manipulate Delphi events. You will often set Delphi event handlers
  ///   from script, and want the events to be handled by script routines. This broker makes this happen, providing you methods
  ///   to set events, remove events, informing the object, the event name, and the script routine that will handle the event.
  ///   In addition, the event broker provides a stack mechanism, where the event handler set by the broker doesn't need to completely
  ///   remove th previous event set. Instead, you have the option to keep the previous event being executed.
  ///   Also, when you remove the event set by the broker, the previous event set is recovered.
  TatScripterEventBroker = class(TComponent)
  private
    FScripter: TatCustomScripter;
    FDispatchers      : TatEventDispatchers;
    FOnExecuteEvent   : TExecuteEventProc;
    FOnSettingEvent   : TSettingEventProc;
    FOnSetEvent       : TSetEventProc;
    FOnUnsettingEvent : TUnsetEventProc;
    FEventAdapters    : TatEventAdapters;
    function InternalSetEvent(AInstance: TObject; APropInfo: PPropInfo; ARoutineName: string;
      AScripter: TatCustomScripter; APlacement: TatEventPlacement; AScript: TatScript): TatEventDispatcher;
    function InternalUnsetEvent(AInstance: TObject; APropInfo: PPropInfo; ARoutineName: string;
      AScripter: TatCustomScripter): boolean;
    function InternalUnsetEvents(AInstance: TObject; APropInfo: PPropInfo): boolean;
    procedure SetDispatchers(const Value: TatEventDispatchers);
    procedure SetOnExecuteEvent(const Value: TExecuteEventProc);
    procedure SetOnSetEvent(const Value: TSetEventProc);
    procedure SetOnUnsettingEvent(const Value: TUnsetEventProc);
    function GetOldMethod(m: TMethod): TMethod;
    function MethodIsDesiredDispatcher(m: TMethod; ARoutineName: string;AScripter: TatCustomScripter): boolean;
    function GetDispatcherFromMethod(m: TMethod): TatEventDispatcher;
    procedure SetOnSettingEvent(const Value: TSettingEventProc);
    function GetMethodPropEx(AInstance: TObject; APropInfo: PPropInfo): TMethod;
    procedure SetMethodPropEx(AInstance: TObject; APropInfo: PPropInfo; AMethod: TMethod);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// Description:
    ///   Sets a new event handler for a Delphi object's event.
    ///   Parameters:
    ///   AInstance - Contains the instance of the object for which the event will be set, for example, a button object
    ///   APropName - Contains the name of the event to be set, for example, 'OnClick'
    ///   ARoutineName - Contains the name of the script routine name that will handle the event, for example, 'Button1Click'
    ///   AScripter - Contains the scripter object which holds the script containing the routine
    ///   APlacement - Indicates how this new event will replace the existing one
    ///   AScript - Contains the script object which holds the routine. If AScript is nil, the current script of scripter component will be used
    ///
    ///   This method creates a new TatEventDispatcher object to handle the object's event, and return it as the result value.
    function SetEvent( AInstance: TObject; APropName: string; ARoutineName: string;
      AScripter:TatCustomScripter; APlacement: TatEventPlacement; AScript: TatScript = nil): TatEventDispatcher;

    /// Description:
    ///   Unsets an event handler for a Delphi object's event which was previously set with SetEvent.
    ///   Parameters:
    ///   AInstance - Contains the instance of the object for which the event will be unset
    ///   APropName - Contains the name of the event to be unset, for example, 'OnClick'
    ///   ARoutineName - Must be empty if you want to remove the last event set. If you want to remove an event that was not the last
    ///   one set, then specify the script routine name to be removed
    ///   AScripter - Contains the scripter object which holds the script routine to be removed as an event handler
    ///
    ///    Unset event returns true if the event handler did exist and was removed. It returns false if for example the routine name
    ///    didn't exist, or the object event was just not previously set with SetEvent.
    function UnsetEvent( AInstance: TObject; APropName: string; ARoutineName: string=''; AScripter:TatCustomScripter=nil ): boolean;

    /// Description:
    ///   Remove all event handlers set in the object AInstance for the event specified by APropName.
    ///   See UnsetEvent method for more information.
    function UnsetEvents( AInstance: TObject; APropName: string ): boolean;

    /// Description:
    ///   Returns the name of script routine currently assigned to be the handler of the object's event.
    ///   Parameters:
    ///   AInstance - the instance of the object which contains the event
    ///   APropName - the name of the event. For example, 'OnClick'
    ///   AScripter - the scripter component which holds the routine assigned to the event
    ///
    ///   If no script routine is assigned, the method returns an empty string.
    function GetAssignedRoutineName(AInstance: TObject;
      APropName: string; AScripter: TatCustomScripter): string;

    /// Description:
    ///   Unset all events assigned by this event broker. See UnsetEvent for more details.
    procedure UnsetAllEvents;

    /// Description:
    ///   Holds a list of event adapters registered in scripting system. This is just a pointer to the global variable
    ///   EventAdapters.
    property EventAdapters: TatEventAdapters read FEventAdapters write FEventAdapters;
  published
    /// Description:
    ///   Holds the list of current event dispatcher. An event dispatcher is created for each event set. See
    ///   TatEventDispatchers for more info.
    property Dispatchers: TatEventDispatchers read FDispatchers write SetDispatchers;

    /// Description:
    ///   OnExecuteEvent is fired whenever an event is fired in Delphi object and handled by the dispatcher.
    property OnExecuteEvent: TExecuteEventProc read FOnExecuteEvent write SetOnExecuteEvent;

    /// Description:
    ///   OnSettingEvent is fired when an event is about to be set by the event broker.
    property OnSettingEvent: TSettingEventProc read FOnSettingEvent write SetOnSettingEvent;

    /// Description:
    ///   OnSetEvent is fired when an event is set by the event broker.
    property OnSetEvent: TSetEventProc read FOnSetEvent write SetOnSetEvent;

    /// Description:
    ///   OnUnsettingEvent is fired when an event is about to be unset by the event broker.
    property OnUnsettingEvent: TUnsetEventProc read FOnUnsettingEvent write SetOnUnsettingEvent;
  end;

  /// Description:
  ///   Holds a collection of all event adapters registered in the scripter. You need to register an adapter for each event type.
  ///   For example, TNotifyEvent must have an adapter. Once you register it, all events in any object that are of TNotifyEvent type
  ///   (Button OnClick, Combo OnChange, OnEnter, OnExit, etc.) are supported by the scripter.
  ///   You must include a new event adapter using method or procedure DefineEventAdapter.
  TatEventAdapters = class(TCollection)
  private
    function GetItem(i: integer): TatEventAdapter;
  public
    /// Description:
    ///   Do not call this directly. Use DefineEventAdapter instead.
    function Add: TatEventAdapter;

    /// Description:
    ///   Provides indexed-access to all adapters registered in the scripter.
    property Items[i:integer]:TatEventAdapter read GetItem; default;

    /// Description:
    ///   Finds the event adapter for the event type specified by ARttiInfo. If no adapter is registered for the event type,
    ///   FindAdapter returns nil.
    function FindAdapter(ARttiInfo: PTypeInfo): TatEventAdapter;

    /// Description:
    ///   Finds the event adapter for the event property specified by APropInfo. If no adapter is registered for the event type,
    ///   AdapterByPropInfo returns nil.
    function AdapterByPropInfo( APropInfo:PPropInfo ): TatEventAdapter;

    /// Description:
    ///   Defines a new event adapter for the event type specified by ARttiInfo.
    ///   For example, TNotifyEvent must have an adapter. Once you register it, all events in any object that are of TNotifyEvent type
    ///   (Button OnClick, Combo OnChange, OnEnter, OnExit, etc.) are supported by the scripter.
    ///   Parameters:
    ///   ARttiInfo - Contains RTTI info about the event type being supported (TNotifyEvent, for example)
    ///   ADispatcherClass - Contains class of the TatEventDispatcher descendant that will be instantiated when an event is set. The dispatcher will implement the event handling, taking care of calling the script routine name to be executed and passing the correct parameters.
    ///   AMethodCode - Contains the address of a method in the dispatcher class that will be called when the event fires.
    ///   ACheck - If true, it will first check if an adapter already exists for the event. If it does, then it updates the current adapter. If Check is false, it will always create a new adapter.
    ///
    ///   This method returns the created TatEventAdapter object. You will rarely need this returned object.
    ///
    ///   Example:
    ///   To define an event adapter for the TKeyEvent. The TKeyEvent is declared in the VCL as following:
    ///   <code>
    ///       TKeyEvent = procedure( Sender: TObject; var Key: Word;  Shift: TShiftState) of object;
    ///   </code>
    ///   So you need to register a new adapter using the following call to DefineEventAdapter:
    ///   <code>
    ///       DefineEventAdapter(TypeInfo(TKeyEvent), TatMyKeyEventDispatcher, @TatMyKeyEventDispatcher.__TKeyEvent);
    ///   </code>
    ///   In the first parameter you pass the type info of the TKeyEvent type.
    ///   In second parameter, the dispatcher class to be instantiated that will handle the event and dispatch it to scritper.
    ///   In third parameter, the address of the method in dispatcher class that will be called when the event fires.
    ///
    ///     You can then implement your dispatcher this way:
    ///   <code>
    ///   TatMyKeyEventDispatcher = class(TatEventDispatcher)
    ///   private
    ///   procedure __TKeyEvent( Sender: TObject; var Key: Word;  Shift: TShiftState);
    ///   end;
    ///
    ///       procedure TatMyKeyEventDispatcher.__TKeyEvent( Sender: TObject; var Key: Word;  Shift: TShiftState);
    ///       var
    ///         KeyTemp: variant;
    ///         ShiftTempSet: TShiftState;
    ///         ShiftTemp: variant;
    ///       begin
    ///         if DoOnExecuteEvent then
    ///         begin
    ///           //Call event previous set
    ///           if AssignedMethod(BeforeCall) then
    ///             TKeyEvent(BeforeCall)(Sender,Key,Shift);
    ///
    ///           //Put Key in a variant type so that script routine can update its value
    ///           KeyTemp := Integer(Key);
    ///
    ///           //Converts TShiftState to integer so it can be read from script
    ///           ShiftTempSet := Shift;
    ///           ShiftTemp := IntFromSet(ShiftTempSet, SizeOf(ShiftTempSet));
    ///
    ///           //Execute the script routine that will handle the event, passing the event parameters to it
    ///           if Assigned(Scripter) and (RoutineName > '') then
    ///           Scripter.ExecuteSubroutine(RoutineName, [Sender,KeyTemp,ShiftTemp]);
    ///
    ///           //Update the Key parameter received from the script
    ///           Key := VarToInteger(KeyTemp);
    ///
    ///           //Call event previous set
    ///           if AssignedMethod(AfterCall) then
    ///             TKeyEvent(AfterCall)(Sender,Key,Shift);
    ///   end;
    ///   </code>
    function DefineEventAdapter( ARttiInfo: PTypeInfo; ADispatcherClass: TDispatcherClass;AMethodCode: pointer; ACheck: boolean): TatEventAdapter;
  end;

  /// Description:
  ///   Holds the information for the event adapter. You don't need to use this class, it holds only private information.
  TatEventAdapter = class(TCollectionItem)
  private
    FRttiInfo: PTypeInfo;
    FMethodCode: pointer;
    FDispatcherClass: TDispatcherClass;
  public
    procedure Assign(ASource: TPersistent); override;
  end;

  /// Description:
  ///   Holds the collection of the event dispatchers created by the event broker. When an event is set, a dispatcher is created
  ///   to take care of event handling and passing the execution control to the specified script routine.
  ///   You will rarely need to deal with dispatchers, they are created and destroyed automatically by scripter
  ///   when you set or unset events.
  TatEventDispatchers = class(TOwnedCollection)
  private
    function GetItem(i: integer): TatEventDispatcher;
  public
    function Add: TatEventDispatcher;
    property Items[i:integer]:TatEventDispatcher read GetItem; default;
  end;

  /// Description:
  ///   Contains information about how to dispatch an event from Delphi to scripter. When the event broker sets a new event,
  ///   it creates a new TatEventDispatcher object to handle the event fired from Delphi. The dispatcher will take care
  ///   of passing the event handling to the specified script routine.
  ///   You will rarely need to deal with dispatchers, they are created and destroyed automatically by scripter
  ///   when you set or unset events.
  TatEventDispatcher = class(TCollectionItem)
  private
    FBeforeCall  : TMethod;
    FAfterCall   : TMethod;
    FOldCall     : TMethod; // just for event restoring
    FScripter    : TatCustomScripter;
    FRoutineName : string;
    FCustomCall  : TMethod; // for use instead of Scripter + RoutineName
    FAdapter     : TatEventAdapter; // general usage, like a event runtime type information
    FInstance    : TObject; // general usage, like a event runtime type information
    FPropInfo    : PPropInfo; // general usage, like a event runtime type information
    FNotificator : TatDispatcherRemoveNotificator; // allow remove notifications from Instance (TComponent) to be perceived
    FIsComponent : boolean;
    FScript: TatScript;
    procedure SetScripter(const Value: TatCustomScripter);
    procedure SetAfterCall(const Value: TMethod);
    procedure SetBeforeCall(const Value: TMethod);
    procedure SetOldCall(const Value: TMethod);
    procedure SetAdapter(const Value: TatEventAdapter);
    procedure SetInstance(const Value: TObject);
    procedure SetPropInfo(const Value: PPropInfo);
  protected
    function DoOnExecuteEvent: boolean;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;

    /// Description:
    ///   Unset the event of this dispatcher.
    procedure Unset;

    /// Description:
    ///   Provides a reference to the event broker which owns this dispatcher.
    function EventBroker: TatScripterEventBroker;

    /// Description:
    ///   Provides a reference to the scripter component which contains the script routine which to be executed when
    ///   the Delphi event fires.
    property Scripter : TatCustomScripter read FScripter write SetScripter;

    /// Description:
    ///   Provides a reference to the script object containing the routine to be executed when the Delphi event fires.
    property Script: TatScript read FScript write FScript;

    /// Description:
    ///   Contains a pointer to the Delphi method to be called when the Delphi event fires, before the script routine is executed.
    property BeforeCall : TMethod read FBeforeCall write SetBeforeCall;

    /// Description:
    ///   Contains a pointer to the Delphi method to be called when the Delphi event fires, after the script routine is executed.
    property AfterCall : TMethod read FAfterCall write SetAfterCall;

    /// Description:
    ///   Contains a pointer to the Delphi method that was the previous event handler before the script routine was set.
    property OldCall : TMethod read FOldCall write SetOldCall;

    /// Description:
    ///   Contains the name of the script routine that will be executed when the Delphi event fires.
    property RoutineName : string read FRoutineName write FRoutineName;

    /// Description:
    ///   Contains a reference to the event adapter used to handle this event.
    property Adapter : TatEventAdapter read FAdapter write SetAdapter;

    /// Description:
    ///   Contains the instance of the object for which the event will be handled.
    property Instance : TObject read FInstance write SetInstance;

    /// Description:
    ///   Contains the RTTI information about the event property being handled by this dispatcher.
    property PropInfo : PPropInfo read FPropInfo write SetPropInfo;

    /// Description:
    ///   Not used.
    property CustomCall : TMethod read FCustomCall write FCustomCall;
  end;

  /// Description:
  ///   Used internally by the scripter.
  TatDispatcherRemoveNotificator = class(TComponent)
  private
    FDispatcher : TatEventDispatcher;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

  /// Description:
  ///   Deprecated class.
  ///   Use TatScriptWatches for handling watches for debugging purposes. See TatCustomScripter.Watches property.
  TatDebugWatches = class(TOwnedCollection)
  private
    function GetItem(i: Integer): TatDebugWatch;
  public
    function Add: TatDebugWatch;
    property Items[i:Integer]:TatDebugWatch read GetItem; default;
    procedure Reset;
    procedure CompileAndEvaluateAll;
    procedure EvaluateAll;
    procedure Evaluate(AWatch: TatDebugWatch);
    procedure CompileAndEvaluate(AWatch: TatDebugWatch);
  end;

  /// Description:
  ///   Deprecated class.
  ///   Use TatScriptWatches for handling watches for debugging purposes. See TatCustomScripter.Watches property.
  TatDebugWatch = class(TCollectionItem)
  private
    FExpression    : string;
    FDebugScript   : TatScript;
    FLastResult    : variant;
    FWatchStatus   : TWatchStatus;
    FAlwaysCompile : boolean;
    FEnabled       : boolean;
    FResultChanged : boolean;
    procedure SetLastResult(const Value: variant);
    procedure Reset;
    procedure SetExpression(const Value: string);
    procedure ScriptDestroyed(Sender: TObject);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure CompileAndEvaluate;
    function Machine: TatVirtualMachine;
    procedure Evaluate;
    procedure FullEvaluate;
    property Expression    : string read FExpression write SetExpression;
    property DebugScript   : TatScript read FDebugScript write FDebugScript;
    property WatchStatus   : TWatchStatus read FWatchStatus write FWatchStatus;
    property LastResult    : variant read FLastResult write SetLastResult;
    property ResultChanged : boolean read FResultChanged write FResultChanged;
    property AlwaysCompile : boolean read FAlwaysCompile write FAlwaysCompile;
    property Enabled       : boolean read FEnabled write FEnabled;
  end;

  {$IFDEF DELPHI2010_LVL}
  /// Description:
  ///   Generic event dispatcher class, for auto-definition of classes using RTTI
  ///   (see TatCustomScripter.DefineClassByRTTI).
  TGenericEventDispatcher = class(TatEventDispatcher)
  public
    procedure RaiseEvent;
  end;

  /// Description:
  ///   Generic record wrapper class, for auto-definition of records using RTTI
  ///   (see TatCustomScripter.DefineRecordByRTTI).
  TGenericRecordWrapper = class(TatRecordWrapper)
  private
    FTypeInfo: PTypeInfo;
    FRecord: TRttiRecordType;
    function GetFieldValue(AFieldName: string): TValue;
    procedure SetFieldValue(AFieldName: string; AValue: TValue);
  public
    constructor Create(ATypeInfo: PTypeInfo);
  end;
  {$ENDIF}

/// Description:
///   Returns true if the method specified by m is assigned.
function AssignedMethod(m:TMethod):boolean;

/// Description:
///   Use RegisterScripterLibrary to make a new TatScripterLibrary class available to scripting system. You must
///   pass the class of library that inherits from TatScripterLibrary. Once the library is registered, all scripter
///   components in the application will know that the library exists. When an user tries to use a library using "uses" clause
///   in the script, the scripter component will try to load the library by searching the current registered libraries.
///   If AExplicitLoad is true, then the library is already instantiated and added in all scripter components of the application.
///   See TatCustomScripter.LoadLibrary method for more info about libraries.
procedure RegisterScripterLibrary(ALibrary: TatScripterLibraryClass; AExplicitLoad: boolean=false);

/// Description:
///   Unregisters a library previously registered with RegisterScripterLibrary.
procedure UnregisterScripterLibrary(ALibrary: TatScripterLibraryClass);

/// Description:
///   Converts a variant type to TObject.
function VarToObject(v:variant):TObject;

/// Description:
///   Converts a string value to double. It tries using both '.' and ',' as decimal separator,
///   and it doesn't raise a convert error in case s is a invalid float value.
function StrVal(s:string):double;

/// Description:
///   Converts a variant type to integer.
function VarToInteger(v:variant):integer;

/// Description:
///   Converts a variant type to an enumerated value. The variant can have the enumerated name
///   in string type. For example, 'alClient'. You must provide the PropType of enumerated type so
///   such conversion is possible.
function VarToEnumInteger(v:variant;PropType:PTypeInfo):integer;

/// Description:
///   Converts a variant type to a set type. The variant is an array of string with the names of enumerated
///   types belonging to the set. The PropType parameter must receive the RTTI info about the enumerated type.
function VarToSet(v:variant;PropType:PTypeInfo):integer;

/// Description:
///   Converts a variant to double.
function VarToFloat(v:variant):double;

/// Description:
///   Converts a variant to boolean. Value is false if variant is zero, true otherwise.
function VarToBoolean(v:variant):boolean;

/// Description:
///   Returns a text description describing the content of the variant.
function VarContent(v:variant):string;

/// Description:
///   Converts an integer value to a set type. You must provide the size of set type in ASize parameter.
procedure IntToSet(var ASet; AInt:integer; ASize: integer = 4);

/// Description:
///   Converts a set type to an integer. You must provide the size of set type in ASize parameter.
function IntFromSet(var ASet; ASize: integer = 4): integer;

/// Description:
///   Deprecated.
function IntFromConstSet(const ASet): integer;

/// Description:
///   Raises an EatScriptInfoError exception.
procedure ScriptInfoError(msg:string);

/// Description:
///   Raises an EatRuntimeError exception.
procedure RaiseRuntimeError(msg:string);

/// Description:
///   Raises an EatDefinitionError exception.
procedure DefinitionError(msg:string);

/// Description:
///   Raises an EatInternalError exception.
procedure InternalError(msg:string);

/// Description:
///   Turns an existing variant into a variant with a ByRef flag set.
function MakeVarByRef(var v:variant):variant;

/// Description:
///   Returns the line number in source code corresponding to the p-code instruction specified by inst.
function LineNumberFromInstruction(inst:pSimplifiedCode):integer;

/// Description:
///   Returns the column number in source code corresponding to the p-code instruction specified by inst.
function ColNumberFromInstruction(inst:pSimplifiedCode):integer;

/// Description:
///   Returns true if the instruction specified by inst in the provided scripter contains executable code.
///   Some instructions might not be executable, but only preparation instructions (saving space in stack, for example).
function InstructionIsExecutable(script:TatCustomScripter;inst:pSimplifiedCode): boolean;

/// Description:
///   Use DefineEventAdapter to allow scripter to support a new event type specified by ARttiInfo.
///   For example, TNotifyEvent must have an adapter. Once you register it, all events in any object that are of TNotifyEvent type
///   (Button OnClick, Combo OnChange, OnEnter, OnExit, etc.) are supported by the scripter.
///   You must include a new event adapter using method or procedure DefineEventAdapter.
///   See TatEventAdapters.DefineEventAdapter for more info about the parameters and how to define an adapter. Both
///   methods work the same way.
function DefineEventAdapter(ARttiInfo:PTypeInfo; ADispatcherClass: TDispatcherClass; AMethodCode: pointer; ACheck: boolean=true): TatEventAdapter;

/// Description:
///   returns the initial and final position of a punctuated expression in a string, from inner position.
function ExtractExpression(s:string;pos:integer;var i,len:integer):boolean;

/// Description:
///   Builds a string list containning code completion suggestions related to a input string AInputText (source code)
///   and an cursor position (AInputPos).
function CreateCodeCompletionList(AScripter: TatCustomScripter; AInputText:string; AInputPos:integer; var AExprPos, AExprLen: integer): TStringList; overload;

/// Description:
///   Builds a string list containning code completion suggestions related to a input string AInputText (source code)
///   and an cursor position (AInputPos).
function CreateCodeCompletionList(AScript: TatScript; AInputText:string; AInputPos:integer; var AExprPos, AExprLen: integer): TStringList; overload;

/// Description:
///   Deprecated. Use TatCustomScripter.Watches property.
function EvaluateWatch(AScripter: TatCustomScripter; AExpression: string): Variant;

{$IFNDEF DELPHI7_LVL}
function VarTypeAsText(const AType: integer): string;
{$ENDIF}

var
  /// Description:
  ///   atLibraryList global variable holds a collection of all library classes registered with RegisterScripterLibrary procedure.
  atLibraryList : TatLibraryList;

  /// Description:
  ///   Used internally by the scripter.
  CoreConst     : array[CORE_CONST] of variant;

  /// Description:
  ///   OnGlobalScripterCreate is a global event that is fired whenever a scripter component is created in the application.
  ///   Assign an event handler to this variable to have access to any scripter created, in case you want to register classes, methods,
  ///   properties in all scripter components without having direct access to the instance variables.
  ///   The newly created scripter component is passed in the Sender parameter. You must typecast it to the desired scripter class
  ///   (you will often use TatCustomScripter(Sender).
  OnGlobalScripterCreate : TNotifyEvent;

  /// Description:
  ///   OnGlobalScripterLoaded is a global event that is fired whenever a scripter component is loaded (from dfm) in the application.
  ///   Assign an event handler to this variable to have access to any scripter created and loaded, in case you want to register
  ///   classes, methods, properties in all scripter components without having direct access to the instance variables.
  ///   The loaded scripter component is passed in the Sender parameter. You must typecast it to the desired scripter class
  ///   (you will often use TatCustomScripter(Sender).
  OnGlobalScripterLoaded : TNotifyEvent;


implementation

{$WARNINGS OFF}

uses
  uSystemLibrary
  {$IFDEF DELPHI2009_LVL}, Character{$ENDIF}
  {$IFNDEF LINUX} , DispatchLib, uCallDLL {$ENDIF};

type
  TatInternalObject = class(TObject);

const
   NilMethod: TMethod = (Code: nil; Data: nil);
   SCurDir = '$(CURDIR)';
   SAppDir = '$(APPDIR)';

var
   EventAdapters : TatEventAdapters;

{------------------------------------------------------------------------------}
{                     Variant type helper functions                            }
{------------------------------------------------------------------------------}

{$IFNDEF DELPHI7_LVL}
function FindVarData(const V: Variant): PVarData;
begin
  Result := @TVarData(V);
  while Result.VType = varByRef or varVariant do
    Result := PVarData(Result.VPointer);
end;

function VarIsType(const V: Variant; const AVarTypes: array of integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  with FindVarData(V)^ do
    for I := Low(AVarTypes) to High(AVarTypes) do
      if VType = AVarTypes[I] then
      begin
        Result := True;
        Break;
      end;
end;

{function VarToInt2(V: Variant): integer;
begin
  while TVarData(V).VType and varByRef <> 0 do
    V := Variant(TVarData(V).VPointer^);
  result := V;
end;}

function VarTypeAsText(const AType: integer): string;
const
  CText: array [varEmpty..$0014] of string = ('Empty', 'Null', 'Smallint', //Do not localize
    'Integer', 'Single', 'Double', 'Currency', 'Date', 'OleStr', 'Dispatch', //Do not localize
    'Error', 'Boolean', 'Variant', 'Unknown', 'Decimal', '$0F', 'ShortInt', //Do not localize
    'Byte', 'Word', 'LongWord', 'Int64'); //Do not localize
begin
  if AType and varTypeMask <= $0014 then
    Result := CText[AType and varTypeMask]
  else if AType = varString then
    Result := 'String' //Do not localize
  else if AType = varAny then
    Result := 'Any' //Do not localize
  else
    Result := HexDisplayPrefix + IntToHex(AType and varTypeMask, 4);

  if AType and varArray <> 0 then
    Result := 'Array ' + Result; //Do not localize
  if AType and varByRef <> 0 then
    Result := 'ByRef ' + Result; //Do not localize
end;
{$ENDIF}

function VarToStr(V: Variant): string;
begin
  while TVarData(V).VType and varByRef <> 0 do
    V := Variant(TVarData(V).VPointer^);

  if not VarIsNull(V) then
    Result := V
  else
    Result := '';
end;

function MakeVarByRef(var v:variant):variant;
begin
   { cria um novo variant com o bit varByRef ligado e apontando para o variant dado }
   result := v;
   TVarData(result).VType := varVariant or varByRef;
   TVarData(result).VPointer := @v;
end;

function VarToObject(v:variant):TObject;
begin
   result:=TObject(VarToInteger(v));
end;

function StrVal(s:string):double;
var p:integer;
begin
   p:=pos(',',s);
   if p>0 then s[p]:='.';
   val(s,result,p);
end;

function VarToInteger(v:variant):integer;
begin
   case VarType(v) of
      varSmallint, varInteger, varByte, varError: result:=v;
      varSingle, varDouble, varCurrency, varDate: result:=round(v);
      varBoolean: if v=true then result:=1 else result:=0;
      varString,
      {$IFDEF DELPHI2009_LVL}
      varUString,
      {$ENDIF}
      varOleStr:
        result:=round(StrVal(v));
      varUnknown, varDispatch : result := 0;
      else
         if VarIsNull(v) then
            result := 0
         else
            result := VarAsType(v,varInteger);
   end;
end;

function VarToChar(v:variant):char;
begin
   case VarType(v) of
      varSmallint,
      varInteger,
      varByte,
      varError:
        result := Chr( integer(v) and $ff );

      varSingle,
      varDouble,
      varCurrency,
      varDate:
        result := Chr( round(v) and $ff );

      varBoolean:
        if v=true then
          result := #1
        else
          result := #0;

      varString,
      {$IFDEF DELPHI2009_LVL}
      varUString,
      {$ENDIF}
      varOleStr:
        if Length(v)>0 then
          result := string(v)[1]
        else
          result := #0;

      else
        result := #0;
   end;
end;

function VarToWideChar(v:variant):widechar;
begin
   case VarType(v) of
      varSmallint,
      varInteger,
      varByte,
      varError:
        result := WideChar( integer(v) and $ffff );

      varSingle,
      varDouble,
      varCurrency,
      varDate:
        result := WideChar( round(v) and $ffff );

      varBoolean:
        if v=true then
          result := #1
        else
          result := #0;

      varString,
      {$IFDEF DELPHI2009_LVL}
      varUString,
      {$ENDIF}
      varOleStr:
        if Length(v)>0 then
          result := widestring(v)[1]
        else
          result := #0;

      else
        result := #0;
   end;
end;

function VarToEnumInteger(v:variant;PropType:PTypeInfo):integer;
begin
   case VarType(v) of
      varSmallint,varInteger,varByte,varError: result:=v;
      varSingle,varDouble,varCurrency,varDate: result:=round(v);
      varBoolean: if v=true then result:=1 else result:=0;
      varString,
      {$IFDEF DELPHI2009_LVL}
      varUString,
      {$ENDIF}
      varOleStr:
        result:=GetEnumValue(PropType,v);
      varUnknown, varDispatch : result := 0;
      else
         if VarIsNull(v) then
            result := 0
         else
            result := VarAsType(v,varInteger);
   end;
end;

function VarToSet(v:variant;PropType:PTypeInfo):integer;
var c, d: integer;
begin
  d := VarArrayDimCount(v);
  if d = 1 then
  begin
    { monta um conjunto atrav�s dos itens passados no vetor de variants
      os elementos s�o tratados como bits e o conjunto � formado pela uni�o
      desses bits }
    result := 0;
    if Assigned(PropType) then
    begin
      PropType := GetTypeData(PropType).CompType^;
      for c := VarArrayLowBound(v,1) to VarArrayHighBound(v,1) do
        result := result or (1 shl VarToEnumInteger(v[c],PropType));
    end
    else
      for c := VarArrayLowBound(v,1) to VarArrayHighBound(v,1) do
        result := result or (1 shl VarToInteger(v[c]));
  end
  else
    case VarType(v) of
      varSmallint,varInteger,varByte,varError: result:=v;
      varSingle,varDouble,varCurrency,varDate: result:=round(v);
      varBoolean: if v=true then result:=1 else result:=0;
      varString,
      {$IFDEF DELPHI2009_LVL}
      varUString,
      {$ENDIF}
      varOleStr:
        result:=GetEnumValue(PropType, v);
      varUnknown, varDispatch : result := 0;
      else
        if VarIsNull(v) then
          result := 0
        else
          result := VarAsType(v,varInteger);
    end;
end;

function VarToFloat(v:variant):double;
begin
   case VarType(v) of
      varSmallint,varInteger,varByte,varError,
      varSingle,varDouble,varCurrency,varDate: result:=v;
      varBoolean: if v=true then result := 1 else result := 0;
      varString,
      {$IFDEF DELPHI2009_LVL}
      varUString,
      {$ENDIF}
      varOleStr:
        result := StrVal(v);
      varUnknown, varDispatch : result := 0;
      else
         if VarIsNull(v) then
            result := 0
         else
            result := VarAsType(v,varDouble);
   end;
end;

function VarToBoolean(v:variant):boolean;
begin
   result:=(VarToInteger(v)<>0);
end;

function VarContent(v:variant):string;
begin
  try
    case VarType(v) of
      varEmpty    : result:='Empty';
      varNull     : result:='Null';
      varSmallint : result:='Smallint:'+VarToStr(v);
      varInteger  : result:='Integer:'+VarToStr(v);
      varSingle   : result:='Single:'+VarToStr(v);
      varDouble   : result:='Double:'+VarToStr(v);
      varCurrency : result:='Currency:'+VarToStr(v);
      varDate     : result:='Date:'+VarToStr(v);
      varOleStr   : result:='OleStr:'+VarToStr(v);
      varDispatch : result:='Dispatch:'+VarToStr(v);
      varError    : result:='Error:'+VarToStr(v);
      varBoolean  : result:='Boolean:'+VarToStr(v);
      varVariant  : result:='Variant:'+VarToStr(v);
      varUnknown  : result:='Unknown:'+VarToStr(v);
      varByte     : result:='Byte:'+VarToStr(v);
      varString   : result:='String:'+VarToStr(v);
      {$IFDEF DELPHI2009_LVL}
      varUString  : result:='UnicodeString:'+VarToStr(v);
      {$ENDIF}
      varArray    : result:='Array:'+VarToStr(v);
      varByRef    : result:='ByRef:'+VarToStr(v);
    end;
  except
    result := '(unknown)';
  end;
end;

function VariantFromVarRec( v: TVarRec ): variant;
var
  astr: AnsiString;
  {$IFDEF DELPHI2009_LVL}
  ustr: UnicodeString;
  {$ENDIF}
begin
  with v do
    case VType of
      vtInteger:
        result := VInteger;
      vtBoolean:
        result := VBoolean;
      vtChar:
        result := VChar;
      vtExtended:
        result := VExtended^;
      vtString:
        result := VString^;
      vtAnsiString:
        begin
          astr := AnsiString(VAnsiString);
          UniqueString(astr);
          result := AStr;
        end;
      vtCurrency:
        result := VCurrency^;
      vtVariant:
        result := VVariant^;
      vtObject:
        result := integer(VObject);
      {$IFDEF DELPHI2009_LVL}
      vtUnicodeString:
        begin
          ustr := UnicodeString(VUnicodeString);
          UniqueString(ustr);
          result := UStr;
        end;
      {$ENDIF}
    else
      result := null;
    end;
end;

{------------------------------------------------------------------------------}
{ Other helper functions                                                       }
{------------------------------------------------------------------------------}

function MapTatTypeKind(AKind: TTypeKind): TatTypeKind;
begin
  result := TatTypeKind(AKind);
end;

function GenericProc(m:TMachineProc):TGenericProc;
begin
   result:=TGenericProc(m);
end;

function AssignedMethod(m:TMethod):boolean;
begin
   result := (m.Code<>nil) and (m.Data<>nil);
end;

function SameMethod(m1, m2: TMethod): boolean;
begin
  result := (m1.Code=m2.Code) and (m1.Data=m2.Data);
end;

function LineNumberFromDebugInfo(ADebugInfo: integer): integer;
begin
  Result := ADebugInfo and $FFFFF - 1;
end;

function ColNumberFromDebugInfo(ADebugInfo: integer): integer;
begin
  Result := (ADebugInfo shr 20) - 1;
end;

function LineNumberFromInstruction(inst:pSimplifiedCode): integer;
begin
   if Assigned(inst) then
      Result := LineNumberFromDebugInfo(inst^.vDebugInfo)
   else
      Result := -1;
end;

function ColNumberFromInstruction(inst:pSimplifiedCode): integer;
begin
  if Assigned(inst) then
    Result := ColNumberFromDebugInfo(inst^.vDebugInfo)
  else
    Result := -1;
end;

function InstructionIsExecutable(script:TatCustomScripter;inst:pSimplifiedCode): boolean;
begin
   { se for a primeira instru��o do programa (jump ou prepare) ou for um prepare considera que a
     instru��o n�o � execut�vel }
   result := Assigned(inst) and (inst^.OpCode<>inPrepare) and (not Assigned(script) or (inst<>script.FirstInstruction));
end;

procedure IntToSet(var ASet; AInt:integer; ASize: integer = 4);
begin
  Case ASize of
    1: Byte(Aset) := Byte(AInt);
    2: Word(ASet) := Word(AInt);
  else
    Integer(ASet) := AInt;
  end;
end;

function IntFromSet(var ASet; ASize: integer = 4): integer;
begin
  Case ASize of
    1: result := Byte(ASet);
    2: result := Word(ASet);
  else
    result:=Integer(ASet);
  end;
end;

function IntFromConstSet(const ASet): integer;
begin
   result:=Integer(ASet);
end;

procedure FatalError(msg:string);
begin
   raise EatScripterFatal.Create(msg);
end;

procedure ScriptInfoError(msg:string);
begin
   raise EatScriptInfoError.Create('ScriptInfo ERROR'#13#10+msg);
end;

procedure RaiseRuntimeError(msg:string);
begin
  raise EatRuntimeError.Create(msg);
end;

procedure DefinitionError(msg:string);
begin
   raise EatDefinitionError.Create('Definition ERROR'#13#10+msg);
end;

procedure InternalError(msg:string);
begin
   raise EatInternalError.Create('INTERNAL ERROR'#13#10+msg);
end;

{ --- code completion utilities --- }

function ExtractExpression(s:string;pos:integer;var i,len:integer):boolean;
var cont : boolean;

  function ValidChar(c:char):boolean;
  begin
    result := ((c>='A') and (c<='Z')) or
              ((c>='a') and (c<='z')) or
              ((c>='0') and (c<='9')) or
              (c='.') or (c='_');
  end;

begin
  i := pos;
  len := 0;
  if (i<=Length(s)) and (i>0) then
  begin
    { pesquisa a partir de pos at� a posi��o de in�cio da express�o }
    cont := True;
    while (cont) do
    begin
      if (i>1) and ValidChar(s[i-1]) then
      begin
        Inc(Len);
        Dec(i);
      end
      else
        cont := False;
    end;
    { pesquisa a partir de pos at� a posi��o final da express�o }
    cont := True;
    while (cont) do
    begin
      if (i + len < Length(s)) and ValidChar(s[i + len]) then
        Inc(Len)
      else
        cont := False;
    end;
    { retorna True se a express�o foi encontrada }
    result := (len > 0);
  end
  else
    { posi��o inicial inv�lida }
    result := False;
end;

function SplitList(s:string;const sep:string):TStringList;
var c,i:integer;
begin
   result:=TStringList.Create; // deve ser destru�da externamente
   c:=1;
   i:=1;
   while c<=length(s) do
   begin
      if CompareText( copy(s,c,length(sep)), sep )=0 then
      begin
         result.Add( Trim(copy(s,i,c-i)) );
         inc(c,length(sep));
         i:=c;
      end
      else
         inc(c);
   end;
   if (c>i) then result.Add( Trim(copy(s,i,c-i)) );
end;

function EvaluateWatch(AScripter: TatCustomScripter; AExpression: string): Variant;
begin
  if Assigned(AScripter.CurrentScript) and
    AScripter.CurrentScript.VirtualMachine.Running then
  begin
    with AScripter.CurrentScript.VirtualMachine.DebugWatches.Add do
    try
      Expression := AExpression;
      CompileAndEvaluate;
      if WatchStatus = wsEvaluated then
        result := LastResult
      else
        result := NULL;
    finally
      Free;
    end;
  end
  else
    result := NULL;
end;

function CreateCodeCompletionList(AScripter: TatCustomScripter; AInputText:string; AInputPos:integer; var AExprPos, AExprLen: integer): TStringList;
begin
  result := CreateCodeCompletionList(AScripter.CurrentScript, AInputText, AInputPos, AExprPos, AExprLen);
end;

function CreateCodeCompletionList(AScript: TatScript; AInputText:string; AInputPos:integer; var AExprPos, AExprLen: integer): TStringList; overload;
var expr   : string;
    c,c1   : integer;
    cls    : TatClass;
    found  : string;
    prefix : string;
    slist  : TStringList;

  function IsClassDefaultInstance(AClass: TatClass): boolean;
  var c: integer;
  begin
    result := False;
    for c := 0 to AScript.Scripter.DefaultInstances.Count - 1 do
      if AScript.Scripter.DefaultInstances[c].atClass = AClass then
      begin
        result := True;
        exit;
      end;
  end;

  procedure AddItemToList(AName: string; AValue: integer);
  var
    i: integer;
  begin
    {Avoid duplicated items}
    for i := 0 to sList.Count - 1 do
      if (AnsiCompareText(sList[i], AName) = 0) and (integer(sList.Objects[i]) = AValue) then Exit;

    sList.AddObject(AName, TObject(AValue));
  end;

  function Branch( AClass:TatClass; var APrefix:string; AName: string; AFinalNode: boolean; var AResultClass: TatClass ): boolean;
  var c: integer;
      prop: TatProperty;
      meth: TatMethod;
      avar: TatVariableInfo;
      aroutine: TatRoutineInfo;
      DefaultInstOff: integer;
      parstr: string;
  begin
    { tenta penetrar na classe a partir do nome dado }
    AResultClass := nil;
    result := False;
    with AClass do
    begin
      if AFinalNode then
      begin
        DefaultInstOff := 0;
        if IsClassDefaultInstance(AClass) then
          DefaultInstOff := 16;

        { Since it's final node, search for a partial name }
        for c:=0 to AClass.Properties.Count-1 do
          if Copy( UpperCase(AClass.Properties[c].Name), 1, Length(AName)) = UpperCase(AName) then
            { cria uma op��o com a propriedade encontrada }
            if AClass.Properties[c].DataType <> tkMethod then
              AddItemToList(APrefix + AClass.Properties[c].Name, 0 + DefaultInstOff )
            else
              AddItemToList(APrefix + AClass.Properties[c].Name, 3 + DefaultInstOff );

        for c:=0 to AClass.Methods.Count-1 do
          if Copy( UpperCase(AClass.Methods[c].Name), 1, Length(AName)) = UpperCase(AName) then
            if AClass.Methods[c].ResultDataType = tkNone then {check if it's a procedure or function}
              AddItemToList(APrefix + AClass.Methods[c].Name + '()' , 1 + DefaultInstOff )
            else
              AddItemToList(APrefix + AClass.Methods[c].Name + '()' , 2 + DefaultInstOff );

        {if aprefix is empty, then we can also search global variables names and methods}
        if APrefix = '' then
        begin
          With AScript.ScriptInfo do
          begin
            {Check local routines}
            for c := 0 to Routines.Count - 1 do
              if (AnsiCompareText(Copy(Routines[c].Name, 1, Length(AName)), AName) = 0) and (Routines[c].Name <> '___MAIN___') then
              begin
                if Routines[c].ArgCount > 0 then
                  parstr := '()'
                else
                  parstr := '';
                if Routines[c].IsFunction then
                  AddItemToList(Routines[c].Name + parstr, 2 + 16)
                else
                  AddItemToList(Routines[c].Name + parstr, 1 + 16);
              end;

            {Check global variables}
            for c := 0 to Globals.Count - 1 do
              if (AnsiCompareText(Copy(Globals[c].VarName, 1, Length(AName)), AName) = 0) then
              begin
                AddItemToList(Globals[c].VarName, 0 + 16);
              end;
          end

        end;
      end
      else
      begin
        { n�o est� no final ent�o tenta determinar a classe do objeto corrente }
        prop := AClass.PropertyByName(AName);
        if Assigned(prop) then
        begin
          { � uma propriedade }
          if prop.PropertyClass<>nil then
            AScript.Scripter.Classes.TestCheckLoaded( prop.PropertyClass, AResultClass, prop.FPropertyClassName);
          APrefix := APrefix + prop.Name+'.';
          result := True;
        end;

        {check methods}
        if not result then
        begin
          meth := AClass.MethodByName(AName);
          if Assigned(meth) then
          begin
            { � um m�todo }
            if meth.ResultClass<>nil then
              AScript.Scripter.Classes.TestCheckLoaded(meth.ResultClass, AResultClass, meth.FResultClassName);
            APrefix := APrefix + meth.Name+'.';
            result := True;
          end
        end;

        {if APrefix is empty, then check local things in scripter, in other words, it's not a member of any object.
         Global variables and regular procedures and functions declared in script itself.}
        if APrefix = '' then
        begin

          {Check global variables}
          if not result then
          begin
            avar := AScript.ScriptInfo.Globals.FindByName(AName);
            if Assigned(avar) then
            begin
              if (avar.DeclaredClass <> nil) and (avar.DeclaredClass.ClassRef <> nil) then
                AScript.Scripter.Classes.TestCheckLoaded(avar.DeclaredClass.ClassRef, AResultClass, avar.DeclaredClassName);
              APrefix := APrefix + avar.VarName + '.';
              result := True;
            end;
          end;

          {Check local functions (don't need to check for procedures, because they don't return an object}
          if not result then
          begin
            aroutine := AScript.ScriptInfo.RoutineByName(AName);
            if Assigned(aroutine) then
            begin
              if (aroutine.IsFunction) and (aroutine.ResultClass <> nil) and (aroutine.ResultClass.ClassRef <> nil) then
              begin
                AScript.Scripter.Classes.TestCheckLoaded(aroutine.ResultClass.ClassRef, AResultClass);
              end;
              APrefix := APrefix + aroutine.Name + '.';
              result := True;
            end;
          end;

          {check variables local to the procedure}
        end;
      end;
    end;
  end;

var
  done: boolean;
begin
  { Perform silent compilation to get more information about the script }
  if not AScript.SilentCompiled and not AScript.Scripter.Running then
    AScript.SilentCompile;

  { extrai express�o posicionada no memo }
  if ExtractExpression( AInputText, AInputPos, AExprPos, AExprLen ) then
    expr := Copy( AInputText, AExprPos, AExprLen )
  else
    expr := '';

  slist := TStringList.Create;
  result := slist;
  try
    { desmembra a express�o em identificadores at�micos }
    with SplitList(expr,'.') do
    try
      cls := nil;
      found := '';
      prefix := '';

      if (Count = 0) or (Pos('.*',expr+'*')>0) then
        Add('');

      for c := 0 to Count-1 do
      begin
        {search in script/scripter for members that has a name similar to the extracted expression}
        if c = 0 then
        begin
          done := false;
          for c1 := AScript.DefInstances.Count - 1 downto 0 do
            if branch(AScript.DefInstances[c1].atClass, prefix, Strings[c], (c=Count-1), cls ) then
            begin
              done := true;
              break;
            end;

          if not done then
            for c1 := AScript.Scripter.DefaultInstances.Count-1 downto 0 do
              if branch( AScript.Scripter.DefaultInstances[c1].atClass, prefix, Strings[c], (c=Count-1), cls ) then
                Break;
        end
        else
          if cls = nil then
            { classe n�o definida em express�o pontuada }
            Exit
          else
            branch( cls, prefix, Strings[c], (c=Count-1), cls );
      end;
    finally
      Free;
    end;
    { ordena a lista de op��es }
    slist.Sort;
  except
    slist.Free;
    raise;
  end;
end;

{ TatCustomScripter }

constructor TatCustomScripter.Create(AOwner:TComponent);
begin
   { to customize Script and VirtualMachine, set ScriptClass and MachineClass
     onto begining of the descendant constructor }
   inherited Create(AOwner);

   FScriptFormClass := TScriptForm;

   FLastRunning := false;
   { allow to customize Script and Machine classes }
   DefineInternalClasses;
   FLibOptions := TScripterLibraryOptions.Create;
   FLibOptions.SearchPath.Add(SCurDir);
   FLibOptions.SearchPath.Add(SAppDir);
   FLibOptions.UseScriptFiles := false; {to keep backward compatibility}
   FLoadedScripts := TList.Create;
   { cria a cole��o interna de scripts }
   FScripts := TatScripts.Create(self);
   FSaveCompiledCode := false;
   { cria o stream auxiliar PCode em mem�ria }
   FPCode:=TMemoryStream.Create;
   { Default value: N�o adia a resolu��o de refer�ncias a classes para runtime }
   FDeferObjectResolution := False;
   FTypeInfoFilter := DefaultTypeInfoFilter;
   { cria a estrutura que receber� as informa��es das classes do scripter }
   FClasses:=TatClasses.Create(self);
   { instancia um script para ser usado como padr�o no scripter }
   FCurrentScript := FScripts.Add;
   { cria a lista de objetos padr�o para a compila��o }
   FDefaultInstances := TatObjects.Create(FClasses);
   { event support initialization }
   FEventBroker := TatScripterEventBroker.Create(Self);
   FEventBroker.EventAdapters := EventAdapters;
   SetEventSupport(True);
   FEventSetMode:=esReplaceEvent;
   FEventUnsetMode:=euReplaceNil;
   FWatches := TatScripterWatches.Create(Self, TatScripterWatch);

   {Define create for TComponent to avoid problems after declaring TScriptForm.Create. If we don't do that,
    then all ancestors of TScriptForm would have CReate with 0 parameters, because TObject already declared
    Create}
   DefineClass(TComponent).DefineMethod('Create', 1, tkClass, TComponent, ComponentCreateProc, true);
   DefineClass(TScriptForm).DefineMethod('Create', 1, tkClass, TScriptForm, ScriptFormCreateProc, true);

   { The first default instance is for free constants,
     free variables and other default properties or methods }
   FInternalInstance := FDefaultInstances.Add( TatInternalObject.Create );
   { Create registered libraries (when ExplicitLoad=false) }
   FLibInstances:=TList.Create;
   CreateLibraries;
end;

procedure TatCustomScripter.DefineInternalClasses;
begin
end;

procedure TatCustomScripter.FreeLibInstances;
var c : integer;
begin
  with FLibInstances do
    for c := Count-1 downto 0 do
      TatScripterLibrary(Items[c]).Free;
end;

destructor TatCustomScripter.Destroy;
begin
  FWatches.Free;
  FLibOptions.Free;
  FLoadedScripts.Free;
  FScripts.Free;
  FEventBroker.Free;
  FPCode.Free;
  FreeLibInstances;
  FLibInstances.Free;
  FInternalInstance.Instance.Free;
  FDefaultInstances.Free;
  FClasses.Free;
  inherited;
end;

procedure TatCustomScripter.Clear;
var c: integer;
begin
   {***Check if it is necessary to raise a fatal error is one of scripts are running***}
   FPCode.Size:=0;

   for c:=0 to FScripts.Count-1 do
      FScripts[c].Clear;
end;

procedure TatCustomScripter.Compile;
begin
  if Assigned(FCurrentScript) then
    FCurrentScript.Compile;
end;

procedure TatCustomScripter.SilentCompile;
begin
  if Assigned(FCurrentScript) then
    FCurrentScript.SilentCompile;
end;

function TatCustomScripter.Execute( input:variant ):variant;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.Execute( input );
end;

function TatCustomScripter.Execute: variant;
begin
   result:=Execute(NULL);
end;

{$IFDEF DELPHI2010_LVL}
procedure TatCustomScripter.GenericFieldGetterMachineProc(AMachine: TatVirtualMachine);
var
  context: TRttiContext;
  rtype: TRttiType;
  field: TRttiField;
  result: TValue;
begin
  context := TRttiContext.Create;
  try
    rtype := context.GetType(AMachine.CurrentObject.ClassType);
    field := rtype.GetField(AMachine.CurrentPropertyName);
    result := field.GetValue(AMachine.CurrentObject);
    AMachine.ReturnOutputArgValue(result);
  finally
    context.Free;
  end;
end;

procedure TatCustomScripter.GenericFieldSetterMachineProc(AMachine: TatVirtualMachine);
var
  context: TRttiContext;
  rtype: TRttiType;
  field: TRttiField;
begin
  context := TRttiContext.Create;
  try
    rtype := context.GetType(AMachine.CurrentObject.ClassType);
    field := rtype.GetField(AMachine.CurrentPropertyName);
    field.SetValue(AMachine.CurrentObject, ScrPrepareValue(field.FieldType, AMachine.GetInputArg(0)));
  finally
    context.Free;
  end;
end;

procedure TatCustomScripter.GenericRecordFieldGetterMachineProc(AMachine: TatVirtualMachine);
var
  result: TValue;
begin
  if (AMachine.CurrentObject <> nil) and (AMachine.CurrentObject is TGenericRecordWrapper) then
  begin
    result := TGenericRecordWrapper(AMachine.CurrentObject).GetFieldValue(AMachine.CurrentPropertyName);
    AMachine.ReturnOutputArgValue(result);
  end;
end;

procedure TatCustomScripter.GenericRecordFieldSetterMachineProc(AMachine: TatVirtualMachine);
begin
  if (AMachine.CurrentObject <> nil) and (AMachine.CurrentObject is TGenericRecordWrapper) then
    TGenericRecordWrapper(AMachine.CurrentObject).SetFieldValue(AMachine.CurrentPropertyName, TValue.FromVariant(AMachine.GetInputArg(0)));
end;

procedure TatCustomScripter.GenericMethodMachineProc(AMachine: TatVirtualMachine);
var
  context: TRttiContext;
  rtype: TRttiType;
  methods: TArray<TRttiMethod>;
  method: TRttiMethod;
  args: array of TValue;
  params: TArray<TRttiParameter>;
  result: TValue;
  i, argCount: integer;
  metClass: TClass;
  metName: string;
begin
  context := TRttiContext.Create;
  try
    if AMachine.CurrentObject <> nil then
      metClass := AMachine.CurrentObject.ClassType
    else
      metClass := AMachine.CurrentClass.ClassRef;
    rtype := context.GetType(metClass);
    argCount := AMachine.InputArgCount;

    // retrieve all methods with given name, so we can deal with overloads
    metName := AMachine.CurrentMethodName;
    if metName = '' then
      metName := AMachine.CurrentPropertyName;
    methods := rtype.GetMethods(metName);
    for method in methods do
    begin
      params := method.GetParameters;
      if argCount = Length(params) then
      begin
        // prepare method input parameters (array of TValue)
        SetLength(args, argCount);
        for i := 0 to argCount - 1 do
          args[i] := ScrPrepareValue(params[i].ParamType, AMachine.GetInputArg(i));

        // invoke class or instance method
        if method.IsClassMethod or method.IsConstructor then
          result := method.Invoke(metClass, args)
        else
          result := method.Invoke(AMachine.CurrentObject, args);

        // return method result, if any
        if (ScrTypeKind(method.ReturnType) <> tkNone) or method.IsConstructor then
          AMachine.ReturnOutputArgValue(result);

        // set value of arguments passed by reference
        for i := 0 to argCount - 1 do
          if (pfVar in params[i].Flags) or (pfOut in params[i].Flags) then
            AMachine.SetInputArgValue(i, args[i]);                  

        break;
      end;
    end;
  finally
    context.Free;
  end;
end;

procedure TatCustomScripter.GenericPropGetterMachineProc(AMachine: TatVirtualMachine);
var
  context: TRttiContext;
  rtype: TRttiType;
  prop: TRttiProperty;
  result: TValue;
  v: variant;
begin
  context := TRttiContext.Create;
  try
    rtype := context.GetType(AMachine.CurrentObject.ClassType);
    prop := rtype.GetProperty(AMachine.CurrentPropertyName);
    AMachine.FCurrentRecordName := '';

    if ScrTypeKind(prop.PropertyType) = atScript.tkMethod then
    begin
      if Assigned(FOnTranslateMethodGetter) and (prop is TRttiInstanceProperty) then
      begin
        v := null;
        FOnTranslateMethodGetter(AMachine, CurrentObject, TRttiInstanceProperty(prop).PropInfo, v);
        ReturnOutputArg(v);
      end
      else
        ReturnOutputArg(NULL);
    end
    else
    begin
      result := prop.GetValue(AMachine.CurrentObject);
      AMachine.ReturnOutputArgValue(result);
    end;
  finally
    context.Free;
  end;
end;

procedure TatCustomScripter.GenericPropSetterMachineProc(AMachine: TatVirtualMachine);
var
  context: TRttiContext;
  rtype: TRttiType;
  prop: TRttiProperty;
begin
  context := TRttiContext.Create;
  try
    rtype := context.GetType(AMachine.CurrentObject.ClassType);
    prop := rtype.GetProperty(AMachine.CurrentPropertyName);
    if ScrTypeKind(prop.PropertyType) = atScript.tkMethod then
    begin
      if Assigned(FOnTranslateMethodSetter) and (prop is TRttiInstanceProperty) then
        FOnTranslateMethodSetter(AMachine, AMachine.CurrentObject, TRttiInstanceProperty(prop).PropInfo, AMachine.GetInputArg(0));
    end
    else
      prop.SetValue(AMachine.CurrentObject, ScrPrepareValue(prop.PropertyType, AMachine.GetInputArg(0)));
  finally
    context.Free;
  end;
end;
{$ENDIF}

function TatCustomScripter.GetArrayIndex(ADim:integer):variant;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.GetArrayIndex(ADim)
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.InputArgCount: integer;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result := FCurrentScript.VirtualMachine.InputArgCount
   else
   begin
      result := 0;
      InternalError('Default script is not available');
   end;
end;

function TatCustomScripter.GetInputArg(AIndex:integer):variant;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.GetInputArg(AIndex)
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetInputArgAsString(AIndex:integer):string;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.GetInputArgAsString(AIndex)
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetInputArgAsClass(AIndex:integer):TClass;
begin
   result := nil;
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.GetInputArgAsClass(AIndex)
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetInputArgAsWideString(
  AIndex: integer): Widestring;
begin
  if Assigned(FCurrentScript.VirtualMachine) then
    result := FCurrentScript.VirtualMachine.GetInputArgAsWidestring(AIndex)
  else
    InternalError('Default script is not available');
end;

function TatCustomScripter.GetInputArgAsInteger(AIndex:integer):integer;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.GetInputArgAsInteger(AIndex)
   else
   begin
      InternalError('Default script is not available');
      result:=0;
   end;
end;

function TatCustomScripter.GetInputArgAsBoolean(AIndex:integer):boolean;
begin
   result:=false;
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.GetInputArgAsBoolean(AIndex)
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetInputArgAsFloat(AIndex:integer):double;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.GetInputArgAsFloat(AIndex)
   else
   begin
      InternalError('Default script is not available');
      result:=0;
   end;
end;

function TatCustomScripter.GetInputArgAsDateTime(AIndex:integer):TDateTime;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.GetInputArgAsDateTime(AIndex)
   else
   begin
      InternalError('Default script is not available');
      result:=0;
   end;
end;

procedure TatCustomScripter.ReturnOutputArg(AValue:variant);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.ReturnOutputArg(AValue)
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SetInputArgIfByRef(AIndex:integer;const AValue:variant);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.SetInputArgIfByRef(AIndex,AValue)
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SetInputArg(AIndex:integer;const AValue:variant);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.SetInputArg(AIndex,AValue)
   else
      InternalError('Default script is not available');
end;

{------------------------------------------------------------------------------}
{ Rotina para adicionar fun��es do usu�rio                                     }
{------------------------------------------------------------------------------}

procedure TatCustomScripter.AddFunction(Name:string;Address:TBuiltInProc);
begin
   ShowMessage('Use SetProc instead');
end;

{-------------------------------}
{ Fake PCode published property }
{-------------------------------}

procedure TatCustomScripter.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
     { testa se existe um ancestral e testa o valor herdado }
     if Filer.Ancestor <> nil then
        { se o conte�do do ancestral for nulo ent�o s� grava se o conte�do
          do descendente for n�o nulo }
        if TatCustomScripter(Filer.Ancestor).FPCode.Size=0 then
           Result := Compiled and SaveCompiledCode
        else
           { se o conte�do do ancestral for n�o nulo, s� grava se o
             conte�do do descendente for diferente ou nulo }
           Result := Compiled and SaveCompiledCode and not TatCustomScripter(Filer.Ancestor).PCodeEquals(FPCode)
    else
       { se n�o tem ancestral ent�o s� grava caso o conte�do seja n�o nulo }
       Result := Compiled and SaveCompiledCode;
  end;

begin
   inherited;
   Filer.DefineBinaryProperty(
      'PCode',
      ReadPCodeProp,
      WritePCodeProp,
      DoWrite);
end;

{$IFDEF DELPHI2010_LVL}
function TatCustomScripter.DefineRecord(ATypeInfo: PTypeInfo; ARecordName: string): TatClass;
begin
  result := FClasses.AddRecord(ATypeInfo, ARecordName);

  result.DefineMethod('Create', 0, tkClass, nil, RecordCreateProc, True);
  result.DefineMethod('Free', 0, tkNone, nil, RecordFreeProc);
end;
{$ENDIF}

function TatCustomScripter.PCodeEquals(pcode: TStream): boolean;
begin
   result:=(FPCode.Size=pcode.Size); // not implemented (fail in heritage)
end;

procedure TatCustomScripter.ReadPCodeProp(Stream: TStream);
var size, p : integer;
begin
   { Carrega o conte�do da propriedade a partir do stream }

   { l� o tamanho do stream, como cabe�alho }
   Stream.ReadBuffer(size,sizeof(size));
   p:=Stream.Position;
   { carrega o c�digo do memory stream para a mem�ria execut�vel }
   LoadCodeFromStream(Stream);
   { make a copy of the stream to FPCode stream }
   Stream.Position:=p;
   FPCode.CopyFrom(Stream,size);
end;

{$IFDEF DELPHI2010_LVL}
procedure TatCustomScripter.RecordCreateProc(AMachine: TatVirtualMachine);
begin
  AMachine.ReturnOutputArg(integer(TGenericRecordWrapper.Create(AMachine.CurrentClass.FRecordRef)));
end;

procedure TatCustomScripter.RecordFreeProc(AMachine: TatVirtualMachine);
begin
  if (AMachine.CurrentObject <> nil) and (AMachine.CurrentObject is TGenericRecordWrapper) then
    TGenericRecordWrapper(AMachine.CurrentObject).Free;
end;

procedure TatCustomScripter.DefineClassByRTTI(AClass: TClass; AClassName: string;
  AVisibilityFilter: TMemberVisibilitySet; ARecursive: boolean; ARedefine: TRedefineOption);
begin
  FClasses.AddClassByRTTIEx(AClass, AClassName, AVisibilityFilter, ARecursive, ARedefine);
end;

procedure TatCustomScripter.DefineRecordByRTTI(ATypeInfo: Pointer);
var
  context: TRttiContext;
  atclass: TatClass;
  rtype: TRttiType;
  field: TRttiField;
begin
  context := TRttiContext.Create;
  try
    rtype := context.GetType(ATypeInfo);
    atclass := DefineRecord(ATypeInfo);

    for field in rtype.GetFields do
      atclass.DefineProp(
        field.Name,
        ScrTypeKind(field.FieldType),
        GenericRecordFieldGetterMachineProc,
        GenericRecordFieldSetterMachineProc,
        ScrClassType(field.FieldType));
  finally
    context.Free;
  end;
end;
{$ENDIF}

procedure TatCustomScripter.WritePCodeProp(Stream: TStream);
var size: integer;
begin
   { Armazena no stream o conte�do da propriedade }

   { Save PCode from executable heap to PCode memory stream }
   SaveCodeToStream(FPCode);
   { grava como cabe�alho o tamanho do stream }
   size:=FPCode.Size;
   Stream.Write(size,sizeof(size));
   { grava o conte�do }
   FPCode.Position:=0;
   Stream.CopyFrom(FPCode,size);
end;

function TatCustomScripter.GetCompiled: boolean;
begin
   if Assigned(FCurrentScript) then
      result:=FCurrentScript.Compiled
   else
   begin
      InternalError('Default script is not available');
      result:=false;
   end;
end;

function TatCustomScripter.GetFirstInstruction: pSimplifiedCode;
begin
   if Assigned(FCurrentScript) then
      result:=FCurrentScript.FirstInstruction
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

procedure TatCustomScripter.GetRowColFromSource(APos: integer; var row,
  col: integer);
begin
   if Assigned(FCurrentScript) then
      FCurrentScript.GetRowColFromSource(APos,row,col)
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetScriptInfo: TatScriptInfo;
begin
   if Assigned(FCurrentScript) then
      result:=FCurrentScript.ScriptInfo
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

function TatCustomScripter.GetSourceCode: TStrings;
begin
   if Assigned(FCurrentScript) then
      result:=FCurrentScript.SourceCode
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

procedure TatCustomScripter.SetSourceCode(const Value: TStrings);
begin
   if Assigned(FCurrentScript) then
      FCurrentScript.SourceCode:=Value
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SetCompiled(const Value: boolean);
begin
   if Assigned(FCurrentScript) then
   begin
      if FCurrentScript.VirtualMachine.Running then
        FatalError('Cannot change compiled property while script is running.')
      else
        FCurrentScript.Compiled := Value
   end
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetSilentCompiled: boolean;
begin
   if Assigned(FCurrentScript) then
      result:=FCurrentScript.SilentCompiled
   else
   begin
      InternalError('Default script is not available');
      result:=false;
   end;
end;

procedure TatCustomScripter.SetScriptFormClass(const Value: TScriptFormClass);
begin
  if FScriptFormClass <> Value then
  begin
    FScriptFormClass := Value;
    RegisterClass(FScriptFormClass);
  end;
end;

procedure TatCustomScripter.SetSilentCompiled(const Value: boolean);
begin
   if Assigned(FCurrentScript) then
   begin
      if FCurrentScript.VirtualMachine.Running then
        FatalError('Cannot change compiled property while script is running.')
      else
        FCurrentScript.SilentCompiled := Value
   end
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetBreakPoints: TatScriptBreakPoints;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.BreakPoints
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

function TatCustomScripter.GetCurrentObject: TObject;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.CurrentObject
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

function TatCustomScripter.GetCurrentClass: TatClass;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.CurrentClass
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

function TatCustomScripter.GetHalted: boolean;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.Halted
   else
   begin
      InternalError('Default script is not available');
      result:=false;
   end;
end;

function TatCustomScripter.GetLastExceptionClassName: string;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.LastExceptionClassName
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetLastExceptionHelpContext: integer;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.LastExceptionHelpContext
   else
   begin
      InternalError('Default script is not available');
      result:=0;
   end;
end;

function TatCustomScripter.GetLastExceptionMessage: string;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.LastExceptionMessage
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetNextInstruction: pSimplifiedCode;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.NextInstruction
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

function TatCustomScripter.GetOnExecHook: TNotifyEvent;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.OnExecHook
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetOnPauseChanged: TNotifyEvent;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.OnPauseChanged
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.GetPaused: boolean;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.Paused
   else
   begin
      InternalError('Default script is not available');
      result:=false;
   end;
end;

function TatCustomScripter.GetCallExecHookEvent: boolean;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.CallExecHookEvent
   else
   begin
      InternalError('Default script is not available');
      result:=false;
   end;
end;

function TatCustomScripter.GetRunning: boolean;
var
  c: integer;
begin
  result := false;
  for c := 0 to Scripts.Count - 1 do
    if (Scripts[c].VirtualMachine <> nil) and (Scripts[c].VirtualMachine.Running) then
    begin
      result := true;
      exit;
    end;
end;

procedure TatCustomScripter.Halt;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.Halt
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SetOnExecHook(const Value: TNotifyEvent);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.OnExecHook:=Value
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SetOnPauseChanged(const Value: TNotifyEvent);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.OnPauseChanged:=Value
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.LoadCodeFromStream(AStream: TStream);
begin
   if Assigned(FCurrentScript) then
      FCurrentScript.LoadCodeFromStream(AStream)
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SaveCodeToStream(AStream: TStream);
begin
   if Assigned(FCurrentScript) then
      FCurrentScript.SaveCodeToStream(AStream)
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SolveAbsoluteAddressing;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.SolveAbsoluteAddressing
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SourceCodeChanged(AScript: TatScript);
begin
end;

function TatCustomScripter.ExpandedDebugInfo: boolean;
begin
   if Assigned(FCurrentScript) then
      result:=FCurrentScript.ExpandedDebugInfo
   else
   begin
      InternalError('Default script is not available');
      result:=false;
   end;
end;

procedure TatCustomScripter.ExpandDebugInfo(RequiresCompilation: boolean = true);
begin
   if Assigned(FCurrentScript) then
      FCurrentScript.ExpandDebugInfo(RequiresCompilation)
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.LoadCodeFromFile(AFileName: string);
begin
   if Assigned(FCurrentScript) then
      FCurrentScript.LoadCodeFromFile(AFileName)
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SaveCodeToFile(AFileName: string);
begin
   if Assigned(FCurrentScript) then
      FCurrentScript.SaveCodeToFile(AFileName)
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.FindFileInSearchPath(const CompName, SrcName: string): string;

  function TranslateDir(const S: string): string;
  begin
    result := S;
    if CompareText(S, SCurDir) = 0 then
      result := '.'
    else
    if CompareText(S, SAppDir) = 0 then
      result := ExtractFilePath(ExpandFileName(Application.Exename));
  end;

var
  I, P, L: Integer;
  DirList: string;
  c: integer;
begin
  DirList := '';
  for c := 0 to FLibOptions.SearchPath.Count - 1 do
    if Trim(FLibOptions.SearchPath[c]) <> '' then
    begin
      if DirList <> '' then
        DirList := DirList + ';';
      DirList := DirList + TranslateDir(FLibOptions.SearchPath[c]);
    end;

  P := 1;
  L := Length(DirList);
  while True do
  begin
    while (P <= L) and (DirList[P] = ';') do Inc(P);
    if P > L then Break;
    I := P;
    while (P <= L) and (DirList[P] <> ';') do
    begin
      {$IFDEF DELPHI2009_LVL}
      if IsLeadChar(DirList[P]) then Inc(P);
      {$ELSE}
      if DirList[P] in LeadBytes then Inc(P);
      {$ENDIF}
      Inc(P);
    end;
    Result := Copy(DirList, I, P - I);
    {$IFDEF DELPHI2009_LVL}
    if not ((AnsiLastChar(Result)^ = ':') or (AnsiLastChar(Result)^ = '\')) then Result := Result + '\';
    {$ELSE}
    if not (AnsiLastChar(Result)^ in [':', '\']) then Result := Result + '\';
    {$ENDIF}
    if FileExists(Result + CompName) then
    begin
      Result := ExpandFileName(Result + CompName);
      Exit;
    end else
    if FileExists(Result + SrcName) then
    begin
      Result := ExpandFileName(Result + SrcName);
      Exit;
    end;
  end;
  Result := '';
end;

function TatCustomScripter.FindScriptFile(AName: string): string;
begin
  result := FindFileInSearchPath(ChangeFileExt(AName,
    FLibOptions.FCompiledFileExt), ChangeFileExt(AName, FLibOptions.FSourceFileExt));
end;

function TatCustomScripter.FindFormFile(AName: string): string;
begin
  result := FindFileInSearchPath(AName, ChangeFileExt(AName, FLibOptions.FFormFileExt));
end;

procedure TatCustomScripter.CreateLibraries;
var c: integer;
begin
  { instantiate libraries not marked with ExplicitLoad
    (when ExplicitLoad=true, load occour with method AddLibrary
    or with special script methods - see uSystemLibrary.pas }
  with atLibraryList do
    for c := 0 to Count-1 do
      with Items[c] do
        if not ExplicitLoad then
          AddLibrary( LibraryClass, true ); // auto loaded libraries are also used by scripter
end;

function TatCustomScripter.FindLibraryByClass(ALibraryClass: TatScripterLibraryClass): TatScripterLibrary;
var c: integer;
begin
  for c:=0 to FLibInstances.Count-1 do
    if TatScripterLibrary(FLibInstances[c]).ClassType=ALibraryClass then
    begin
      result := TatScripterLibrary(FLibInstances[c]);
      Exit;
    end;
  result := nil;
end;

procedure TatCustomScripter.AddLibraryInstance(ALibrary: TatScripterLibrary; AName: string;
  ADefault: boolean = true; AddMethod: boolean = true; LibName: string = '');
begin
  FLibInstances.Add(ALibrary);
  { also register a default property on internal class to get a reference to library instances,
    the property will have the same name of the library (virtual method LibraryName) }
  if AddMethod then
    with FInternalInstance.atClass.DefineMethod(AName, 0, tkClass, ALibrary.ClassType, ALibrary.SelfProc) do
    begin
      FResultClassName := LibName;
    end;
  { here the registration process should occur }
  ALibrary.Init;
  ALibrary.FDefaultInstanceName := LibName;
  if ADefault then
    UsesObject(ALibrary, LibName, LibName);
end;

procedure TatCustomScripter.RemoveLibraryInstance(ALibrary: TatScripterLibrary; AName: string);
var
  c: integer;
begin
  ALibrary.Finalize;
  FLibInstances.Remove(ALibrary);
  if FInternalInstance.atClass.MethodByName(AName) <> nil then
    FInternalInstance.atClass.MethodByName(AName).Free;
  if FDefaultInstances.IndexOf(ALibrary.FDefaultInstanceName) <> -1 then
    FDefaultInstances[FDefaultInstances.IndexOf(ALibrary.FDefaultInstanceName)].Free;

  {Since a library was removed, then we need to clear all scripts, because
   the compiled code became outdated and errors might appear. By clearing the scripts,
   we ensure that they will be recompiled in a new execution. This is valid for script-based libraries}
  if ALibrary is TatScriptBasedLibrary then
    for c := 0 to Scripts.Count - 1 do
      if TatScriptBasedLibrary(ALibrary).FInternalScript <> Scripts[c] then
        Scripts[c].Clear;
end;

function TatCustomScripter.AddLibrary(ALibraryClass: TatScripterLibraryClass; ADefault: boolean=true): TatScripterLibrary;
begin
  result := FindLibraryByClass(ALibraryClass);
  { do not duplicate libraries }
  if not Assigned( result ) then
  begin
    result := ALibraryClass.Create(Self);
    AddLibraryInstance(result, ALibraryClass.LibraryName, ADefault);
  end;
end;

function TatCustomScripter.LoadLibrary(ALibraryName: string; ADefault:boolean = true; ASilent: boolean = false): TatScripterLibrary;
var
  c: integer;
  ok: boolean;
  ScriptFileName: string;
  NewScript: TatScript;
begin
  ok := false;
  result := nil;

  {Check if the library name matches the name of a registered Delphi library}
  with atLibraryList do
    for c := 0 to Count - 1 do
      with Items[c] do
        if SameText(ALibraryName, LibraryClass.LibraryName) then
        begin
          result := AddLibrary(LibraryClass, ADefault);
          ok := true;
          break;
        end;

  {Check if there is a script inside Scripts collection with same UnitName as the library being loaded.
   If yes, compile and SelfRegisterAsLibrary}
  if not ok and (ALibraryName <> '') then
  begin
    for c := 0 to Scripts.Count - 1 do
      if SameText(ALibraryName, Scripts[c].UnitName) or SameText(ALibraryName, Scripts[c].ScriptInfo.UnitName) then
      begin
        if not Scripts[c].FCompiling then
        begin
          if not Scripts[c].CheckRegisteredAsLibrary(Self, result) then
          begin
            result := Scripts[c].SelfRegisterAsLibrary(ALibraryName);
          end;
          ok := true;
          break;
        end else
          InternalError(Format('Circular reference for unit %s.', [ALibraryName]));
      end;
  end;

  {Check if there is a compiled script file with the same name in the search path. If yes, register it}
  if LibOptions.UseScriptFiles and not ok then
  begin
    ScriptFileName := FindScriptFile(ALibraryName);
    if (ScriptFileName <> '') then
    begin
      if not IsFileRegisteredAsLibrary(ScriptFileName, result) then
      begin
        NewScript := Scripts.Add;
        if ExtractFileExt(ScriptFileName) = FLibOptions.FCompiledFileExt then
          NewScript.LoadCodeFromFile(ScriptFileName)
        else
          NewScript.SourceCode.LoadFromFile(ScriptFileName);
        result := NewScript.SelfRegisterAsLibrary(ALibraryName);
        {Set FFileName AFTER registering as a library, because SelfRegisterAsLibrary call Clear method
         which set FFileName to empty strings}
        NewScript.FFileName := ScriptFileName;
        FLoadedScripts.Add(NewScript);
        ok := true;
      end else
        ok := true;
    end;
  end;

  {If no library or script file found, and not silent compilation, then raise an error}
  if not ok and not ASilent then
    InternalError(Format('Library ''%s'' not found', [ALibraryName]));
end;

procedure TatCustomScripter.LoadLibrary2(ALibraryName: string; ADefault:boolean=true);
begin
  LoadLibrary(ALibraryName,ADefault);
end;

function TatCustomScripter.IsFileRegisteredAsLibrary(AFileName: string;
  var ALib: TatScripterLibrary): boolean;
var
  c: integer;
begin
  ALib := nil;
  result := false;
  for c := 0 to Scripts.Count - 1 do
    if AnsiCompareText(Scripts[c].FFileName, AFileName) = 0 then
    begin
      result := Scripts[c].CheckRegisteredAsLibrary(Self, ALib);
      break;
    end;
end;

function TatCustomScripter.SystemLibrary:TatClass;
begin
  result := ClassByName('TatSystemLibrary');
end;

function TatCustomScripter.ClassByName(AName:string):TatClass;
begin
  result := FClasses.ClassByName(AName);
end;

function TatCustomScripter.AddClass(AName,AAncestorName:string):TatClass;
Var i: integer;
begin
   i:=FClasses.IndexOf(AName);
   if i>=0 then
      result:=FClasses[i]
   else
      result:=FClasses.Add(AName,AAncestorName);
end;

// obsolete
function TatCustomScripter.AddDelphiClass(AClass:TClass):TatClass;
begin
   result := FClasses.AddClassByRTTI(AClass);
end;

function TatCustomScripter.DefineClass(AClass:TClass; AClassName: string = ''):TatClass;
begin
   result := FClasses.AddClassByRTTI(AClass, AClassName);
end;

function TatCustomScripter.UsesObject(AObject:TObject; AName: string = ''; AClassName: string = ''):TatClass;
begin
   result := FDefaultInstances.Add(AObject, AName, AClassName).atClass;
end;

procedure TatCustomScripter.AddComponents(AComp: TComponent);
var c: integer;
begin
  for c:=0 to AComp.ComponentCount-1 do
    FInternalInstance.atClass.AddDelphiObjectProp(AComp.Components[c].Name,AComp.Components[c])
end;

procedure TatCustomScripter.AddDataModule(ADataModule: TDataModule; ADataModuleClassName:string='');
var ADMClass: TatClass;
    c: integer;
begin
  if ADataModule.Name='' then
    DefinitionError('Cannot add data module without a name');

  { register data module as a global property of scripter }
  AddComponent(ADataModule);

  { register the class of data module }
  ADMClass := DefineClass( ADataModule.ClassType, ADataModuleClassName );

  { register subcomponentes in the data module class }
  for c := 0 to ADataModule.ComponentCount - 1 do
    if ADataModule.Components[c].Name <> '' then
      with ADMClass.DefineProp(ADataModule.Components[c].Name, tkClass, nil, nil,
        ADataModule.Components[c].ClassType) do
        Getter := GenericProc(GetFormComponentProc);
end;

function TatCustomScripter.DefineFormClass(AForm: TCustomForm; AFormClassName: string = ''): TatClass;
var
  c: integer;
begin
  { register the form class }
  result := DefineClass( AForm.ClassType, AFormClassName );

  { register the subcomponents of form}
  for c := 0 to AForm.ComponentCount - 1 do
    if AForm.Components[c].Name <> '' then
      with result.DefineProp(AForm.Components[c].Name, tkClass, nil, nil,
        AForm.Components[c].ClassType) do
        Getter := GenericProc(GetFormComponentProc);
end;

procedure TatCustomScripter.AddForm(AForm: TCustomForm; AFormClassName:string='');
begin
  if AForm.Name='' then
    DefinitionError('Cannot add form without a name');

  { registers the form as a global property in scripter }
  AddComponent(AForm);

  {registers the form class}
  DefineFormClass(AForm, AFormClassName);
end;

procedure TatCustomScripter.AddComponent(AComp: TComponent);
begin
  FInternalInstance.atClass.AddDelphiObjectProp(AComp.Name,AComp);
end;

procedure TatCustomScripter.AddConstant(AName: string; AValue: variant);
begin
  FInternalInstance.atClass.AddConstant(AName,AValue);
end;

procedure TatCustomScripter.AddEnumeration( ATypeInfo: PTypeInfo );
begin
  FInternalInstance.atClass.AddEnumeration(ATypeInfo);
end;

procedure TatCustomScripter.AddObject(AName: string; AObject: TObject);
begin
  FInternalInstance.atClass.AddObject(AName,AObject)
end;

procedure TatCustomScripter.AddVariable(AName: string; var AVar:variant);
begin
  FInternalInstance.atClass.AddVariable(AName,AVar)
end;

procedure TatCustomScripter.AddVariable(AName: string; var AVar: extended);
begin
  FInternalInstance.atClass.AddVariable(AName,AVar)
end;

procedure TatCustomScripter.AddVariable(AName: string; var AVar: double);
begin
  FInternalInstance.atClass.AddVariable(AName,AVar)
end;

procedure TatCustomScripter.AddVariable(AName: string; var AVar: string);
begin
  FInternalInstance.atClass.AddVariable(AName,AVar)
end;

procedure TatCustomScripter.AddVariable(AName: string;
  var AVar: widestring);
begin
  FInternalInstance.atClass.AddVariable(AName, AVar)
end;

procedure TatCustomScripter.AddVariable(AName: string; var AVar: integer);
begin
  FInternalInstance.atClass.AddVariable(AName,AVar)
end;

procedure TatCustomScripter.AddVariable(AName: string; var AVar: boolean);
begin
  FInternalInstance.atClass.AddVariable(AName,AVar)
end;

function TatCustomScripter.DefineProp(AName: string;
  ADataType: TatTypeKind; AGetter, ASetter: TMachineProc;
  APropertyClass: TClass; AIsClassProp: boolean;
  AIndexCount: integer): TatProperty;
begin
   result := FInternalInstance.atClass.DefineProp(
     AName,
     ADataType,
     AGetter,
     ASetter,
     APropertyClass,
     AIsClassProp,
     AIndexCount );
end;

function TatCustomScripter.DefineMethod(AName: string; AArgCount: integer;
  AResultDataType: TatTypeKind; AResultClass: TClass; AProc: TMachineProc;
  AIsClassMethod: boolean = false; ADefArgCount: integer = 0): TatMethod;
begin
   result:=FInternalInstance.atClass.DefineMethod(
     AName,
     AArgCount,
     AResultDataType,
     AResultClass,
     AProc,
     AIsClassMethod,
     ADefArgCount);
end;

procedure TatCustomScripter.AssignInfo(ASourceScripter: TatCustomScripter);
var c : integer;
begin
   { Copia de outro scripter as informa��es necess�rias para compila��o}
   { os seguintes membros s�o copiados:
     - FDefaultInstances     : TatObjects;
     - FClasses              : TatClasses; }
   if Assigned(ASourceScripter) then
   begin
      { copia as defini��es de classes (Classes := ASourceScripter.Classes) }
      { n�o utiliza a mec�nica do Assign porque existem relacionamentos
        hir�rquicos entre as classes }
      FClasses.Clear;
      for c:=0 to ASourceScripter.FClasses.Count-1 do
         with TatClass(TCollection(FClasses).Add) do
         begin
            Name           := ASourceScripter.FClasses[c].Name;
            Properties     := ASourceScripter.FClasses[c].Properties;
            Methods        := ASourceScripter.FClasses[c].Methods;
            ClassRef       := ASourceScripter.FClasses[c].ClassRef;
            AncestorName   := ASourceScripter.FClasses[c].AncestorName;
            // Ancestor � ajustado posteriormente
         end;
      { associa��es entre ancestrais e descendentes }
      for c:=0 to FClasses.Count-1 do
         with FClasses[c] do
            if FAncestorName>'' then
            begin
               FAncestor := FClasses.ClassByName(FAncestorName);
               if Assigned(FAncestor) then
                  FAncestor.InsertDescendant(FClasses[c])
               else
                  DefinitionError(Format('Undefined ancestor class ''%s''',[FAncestorName]));
            end;
      { copia as inst�ncias padr�o }
      { a inst�ncia 0 sempre existe e � interna, ent�o a copia de modo especial }
      FInternalInstance.atClass:=ASourceScripter.FInternalInstance.atClass;
      for c := DefaultInstances.Count-1 downto 1 do
         DefaultInstances.Delete(c);
      for c := 1 to ASourceScripter.FDefaultInstances.Count-1 do
         TatObject(TCollection(DefaultInstances).Add).Assign(ASourceScripter.DefaultInstances[c]);
   end;
end;

procedure TatCustomScripter.SetClasses(const Value: TatClasses);
begin
  FClasses.Assign(Value);
end;

function TatCustomScripter.InProcessExecute(AScriptStub: string): boolean;
begin
  if Assigned(FCurrentScript.VirtualMachine) then
  begin
    FCurrentScript.VirtualMachine.InProcessExecute(AScriptStub);
    result := True;
  end
  else
    result := False;
end;

procedure TatCustomScripter.BeforeCompile;
begin
  //Nothing       
end;

procedure TatCustomScripter.BeforeLoadCode;
begin
  //Nothing
end;

procedure TatCustomScripter.InternalCompileError(msg: string; row, col: integer; AScript: TatScript);
var
  AShow: boolean;
begin
   AShow := true;
   if AScript.FUnitName <> '' then
     msg := 'Unit ' + AScript.FUnitName + ': ' + msg;

   if not AScript.FIsDebugScript then
     DoCompileError(msg, row, col, AShow, AScript);
   if AShow then
     // when the IDE is running an Exception can be triggered here
     // when debugging options "stop on exception" is enabled.
     // This exception is handled correct when run not from the IDE
     raise EatCompileError.Create(msg+'.'#13#10+'Source position: '+inttostr(row)+','+inttostr(col))
   else
      Abort;
end;

procedure TatCustomScripter.InternalCompileError(msg: string;
  debuginfo: integer; AScript: TatScript);
var row, col: integer;
begin
   GetRowColFromSource(debuginfo,row,col);
   InternalCompileError(msg, row, col, AScript);
end;

procedure TatCustomScripter.InternalRuntimeError(msg: string; AScript: TatScript);
var
  AShow: boolean;
  row, col: integer;
  AUnitName: string;
begin
   row := 0;
   col := 0;
   if (AScript <> nil) and (AScript.VirtualMachine <> nil) and
     (AScript.VirtualMachine.FCurrentInstruction <> nil) then
     AScript.GetRowColFromInst(AScript.VirtualMachine.FCurrentInstruction, Row, Col);

   AShow := true;
   AUnitName := AScript.FUnitName;
   if AUnitName = '' then
     AUnitName := AScript.ScriptInfo.UnitName;
   if AUnitName <> '' then
     msg := 'File library ' + AUnitName + ': ' + msg;

   if not AScript.FIsDebugScript and Assigned(FOnRuntimeError) then
      FOnRuntimeError(Self, msg, row, col, AShow);
   if AShow then
     // when the IDE is running an Exception can be triggered here
     // when debugging options "stop on exception" is enabled.
     // This exception is handled correct when run not from the IDE
     raise EatScripterRuntime.Create('RUNTIME ERROR'#13#10 + msg)
   else
      Abort;
end;

procedure TatCustomScripter.SetEventSetMode(const Value: TEventSetMode);
begin
  FEventSetMode := Value;
end;

procedure TatCustomScripter.SetEventSupport(const Value: boolean);
begin
  if FEventSupport <> Value then
  begin
    FEventSupport := Value;
    if FEventSupport then
    begin
      Include(FTypeInfoFilter,TTypeKind(tkMethod));
      FOnTranslateMethodGetter := TranslateMethodGetter;
      FOnTranslateMethodSetter := TranslateMethodSetter;
    end
    else
    begin
      Exclude(FTypeInfoFilter,TTypeKind(tkMethod));
      FOnTranslateMethodGetter := nil;
      FOnTranslateMethodSetter := nil;
    end;
  end;
end;

procedure TatCustomScripter.SetEventUnsetMode(const Value: TEventUnsetMode);
begin
  FEventUnsetMode := Value;
end;

function TatCustomScripter.GetOnExecuteEvent: TExecuteEventProc;
begin
  result:=FEventBroker.OnExecuteEvent;
end;

function TatCustomScripter.GetOnSetEvent: TSetEventProc;
begin
  result:=FEventBroker.OnSetEvent;
end;

function TatCustomScripter.GetOnSettingEvent: TSettingEventProc;
begin
  result:=FEventBroker.OnSettingEvent;
end;

function TatCustomScripter.GetOnUnsettingEvent: TUnsetEventProc;
begin
  result:=FEventBroker.OnUnsettingEvent;
end;

procedure TatCustomScripter.SetOnExecuteEvent(
  const Value: TExecuteEventProc);
begin
  FEventBroker.OnExecuteEvent:=Value;
end;

procedure TatCustomScripter.SetOnSetEvent(const Value: TSetEventProc);
begin
  FEventBroker.OnSetEvent:=Value;
end;

procedure TatCustomScripter.SetOnSettingEvent(
  const Value: TSettingEventProc);
begin
  FEventBroker.OnSettingEvent:=Value;
end;

procedure TatCustomScripter.SetOnUnsettingEvent(const Value: TUnsetEventProc);
begin
  FEventBroker.OnUnsettingEvent:=Value;
end;

procedure TatCustomScripter.BeforeExecute(AMachine: TatVirtualMachine;
  ALabel: string);
begin
  { allow a external event handler to prepare the scripter for start running
    triggered by Execute or ExecuteSubroutine call }
  if Assigned(OnBeforeExecute) then
    OnBeforeExecute(AMachine,ALabel);
end;

procedure TatCustomScripter.SetOnBeforeExecute(
  const Value: TBeforeExecuteEvent);
begin
  FOnBeforeExecute := Value;
end;

procedure TatCustomScripter.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  c: integer;
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TatCustomScripter) and (AComponent <> Self) then
    for c := 0 to Scripts.Count - 1 do
      Scripts[c].SelfUnregisterAsLibrary(TatCustomScripter(AComponent));
end;

function TatCustomScripter.BuildEventHandlerName(Instance: TComponent;
  PropName: string): string;
begin
  if Pos('on', LowerCase(PropName)) = 1 then
    result := Instance.Name + Copy(PropName, 3, MaxInt)
  else
    result := Instance.Name + PropName;
end;

function TatCustomScripter.DeclareEventHandler(AProcName: string): integer;
begin
  if Assigned(FCurrentScript) then
    result := FCurrentScript.DeclareEventHandler(AProcName)
  else
    result := 0;
end;

function TatCustomScripter.DoSaveCompiledCode: boolean;
begin
  result := FSaveCompiledCode;
end;

procedure TatCustomScripter.SetLibOptions(
  const Value: TScripterLibraryOptions);
begin
  FLibOptions.Assign(Value);
end;

procedure TatCustomScripter.Loaded;
{$IFDEF TRIAL}
var
  msg: string;
  i: integer;
{$ENDIF}
begin
  inherited;
  {Must keep in mind that this event is fired after component is loaded, but before any existing code in the descendant is execute}
  if Assigned(OnGlobalScripterLoaded) then
    OnGlobalScripterLoaded(Self);
  {$IFDEF TRIAL}
  msg := 'Stcyruihpgtfedrs xSctvubdnihoj htyrtigaflr evdesrwsqiaosnx.z sPduerrcfhtagshey '+
    'urjekgiiosltpeoriejdu hvnebrgsfivocnd fartt yhuthtypg:t/f/rwdwewd.stwmesdsrotfftgwyahruej.uchotmf.';
  i := 2;
  while i < length(msg) do
  begin
    System.Delete(msg, i, 1);
    inc(i);
  end;
  ShowMessage(msg);
  {$ENDIF}
end;

procedure TatCustomScripter.DoUnknownElement(var Context: TElementContext);
begin
  if Assigned(FOnUnknownElement) then
    FOnUnknownElement(Self, Context);
end;

{$IFDEF DELPHI2010_LVL}
function TatCustomScripter.ScrClassType(AType: TRttiType): TClass;
begin
  if AType <> nil then
  begin
    if AType.TypeKind = TypInfo.tkRecord then
      result := TGenericRecordWrapper
    else
      result := GetClass(AType.Name);
  end
  else
    result := nil;
end;
{$ENDIF}

procedure TatCustomScripter.ScriptFormCreateProc(AMachine: TatVirtualMachine);
var
  AForm: TScriptForm;
begin
  AForm := ScriptFormClass.CreateFromScript(TComponent(GetInputArgAsInteger(0)), AMachine);
  AMachine.ReturnOutputArg(integer(AForm));
end;

{$IFDEF DELPHI2010_LVL}
function TatCustomScripter.ScrPrepareValue(AType: TRttiType; AValue: Variant): TValue;
begin
  if AType.TypeKind = TypInfo.tkClass then
    TValue.Make(AValue, AType.Handle, result)
  else if AType.TypeKind = TypInfo.tkEnumeration then
    result := TValue.FromOrdinal(AType.Handle, AValue)
  else if (AType.TypeKind = TypInfo.tkRecord) and (TObject(integer(AValue)) is TGenericRecordWrapper) then
    TValue.Make(TGenericRecordWrapper(integer(AValue)).FRecord, AType.Handle, result)
  else
    result := TValue.FromVariant(AValue);
end;

function TatCustomScripter.ScrTypeKind(AType: TRttiType): TatTypeKind;
begin
  result := tkNone;
  if AType <> nil then
  begin
    case AType.TypeKind of
      TypInfo.tkInteger:
        result := tkInteger;
      TypInfo.tkChar:
        result := tkChar;
      TypInfo.tkEnumeration:
        result := tkEnumeration;
      TypInfo.tkFloat:
        result := tkFloat;
      TypInfo.tkString:
        result := tkString;
      TypInfo.tkSet:
        result := tkSet;
      TypInfo.tkClass:
        result := tkClass;
      TypInfo.tkMethod:
        result := tkMethod;
      TypInfo.tkWChar:
        result := tkWChar;
      TypInfo.tkLString:
        result := tkLString;
      TypInfo.tkWString:
        result := tkWString;
      TypInfo.tkVariant:
        result := tkVariant;
      TypInfo.tkArray:
        result := tkArray;
      TypInfo.tkRecord:
        result := tkRecord;
      TypInfo.tkInterface:
        result := tkInterface;
      TypInfo.tkInt64:
        result := tkInt64;
      TypInfo.tkDynArray:
        result := tkDynArray;
      TypInfo.tkUString:
        result := tkUString;
    end;
  end;
end;
{$ENDIF}

procedure TatCustomScripter.ComponentCreateProc(AMachine: TatVirtualMachine);
var
  AResult: Variant;
begin
  with AMachine do
  begin
    AResult := Integer(TComponentClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

function TatCustomScripter.DefaultScriptClass: TScriptClass;
begin
  result := nil;
end;

procedure TatCustomScripter.CheckRunningChanged(AMachine: TatVirtualMachine);
begin
  if FLastRunning <> GetRunning then
  begin
    FLastRunning := GetRunning;
    DoRunningChanged(AMachine);
  end;
end;

procedure TatCustomScripter.DoRunningChanged(AMachine: TatVirtualMachine);
begin
  if Assigned(FOnRunningChanged) then
    FOnRunningChanged(AMachine);
end;

function TatCustomScripter.DoDebugHook(AMachine: TatVirtualMachine): boolean;
begin
  result := Assigned(FOnDebugHook);
  if result then
    FOnDebugHook(Self);
end;

function TatCustomScripter.IsAnyRunning: boolean;
var
  c: integer;
begin
  result := false;
  for c := 0 to Scripts.Count - 1 do
    if Scripts[c].VirtualMachine.Running then
    begin
      result := true;
      break;
    end;
end;

procedure TatCustomScripter.SingleDebugHook(AMachine: TatVirtualMachine);
begin
  //nothing
  if Assigned(FOnSingleDebugHook) then
    FOnSingleDebugHook(Self);
end;

function TatCustomScripter.GetCurrentDebugScript: TatScript;
begin
  result := CurrentScript;
  if (CurrentScript <> nil) and (CurrentScript.FOriginalScript <> nil) then
    result := CurrentScript.FOriginalScript;
end;

procedure TatCustomScripter.DoBreakpointStop;
begin
  if Assigned(FOnBreakpointStop) then
    FOnBreakpointStop(Self);
end;

procedure TatCustomScripter.DoCompileError(msg: string; row, col: integer;
  var AShow: boolean; AScript: TatScript);
begin
  if Assigned(FOnCompileError) then
    FOnCompileError(Self, msg, row, col, AShow);
end;

{ TatClasses }

constructor TatClasses.Create(AScripter:TatCustomScripter);
begin
   FScripter := AScripter;
   inherited Create(TatClass);
end;

function TatClasses.GetItem(i:integer):TatClass;
begin
   result := TatClass( inherited Items[i] );
end;

function TatClasses.Add(AName,AAncestorName:string):TatClass;
Var i     : integer;
begin
   i:=IndexOf(AName);
   if i>=0 then
      result:=Items[i]
//      FatalError(Format('Class %s already loaded',[AName]));
   else
   begin
      result:=TatClass( inherited Add );
      with result do
      begin
         FName:=AName;
         FAncestorName:=AAncestorName;
         if (AAncestorName>'') then Inherits( AAncestorName );
      end;
   end;
end;

function TatClasses.AddRecord(ATypeInfo: PTypeInfo; ARecordName: string): TatClass;
var
  i: integer;
begin
  if ARecordName = '' then
    ARecordName := ATypeInfo.Name;

  i := IndexOf(ARecordName);
  if i >= 0 then
    result := Items[i]
  else
    result := TatClass(inherited Add);

  if not Assigned(result.FRecordRef) then
  begin
    result.FName := ARecordName;
    result.FRecordRef := ATypeInfo;
  end;
end;

function TatClasses.AddClassByRTTI(AClass:TClass; AClassName: string = ''):TatClass;
var list     : PPropList;
    c,n,size : integer;
    i        : integer;
begin
   if AClassName = '' then
     AClassName := AClass.ClassName;

   { inclui uma classe para o scripter com base em uma classe do Delphi,
     se ela ainda n�o existir (procurando pelo nome) }
   i := IndexOf(AClassName);
   if i >= 0 then
      result := Items[i]
   else
      result := TatClass(inherited Add);

   { carrega informa��e da classe Delphi, se ainda n�o foram carregadas }
   if not Assigned(result.FClassRef) then
   begin
      result.FName := AClassName;
      result.FClassRef := AClass;

      {if the classname is different from aclass.classname, then addbyrtti the
       original class, and the ancestor will be the original class}
      if CompareText(AClass.ClassName, AClassName) <> 0 then
      begin
        {Add the original class with original name}
        AddClassByRTTI(AClass, '');

        {Makes the original class the ancestor}
        result.FAncestorName := AClass.ClassName;
        result.Inherits(result.FAncestorName);
      end
      else
      begin
        { if the Delphi class has an ancestor, then register register the ancestor class in scripter
         and register the inheritance}
        if AClass.ClassParent <> nil then
        begin
           result.FAncestorName := AClass.ClassParent.ClassName;
           if (result.FAncestorName > '') then result.Inherits(result.FAncestorName);
        end;
      end;

      { se a classe possuir informa��es de runtime (declaradas com $M+)
        ent�o define seus membros atrav�s do RTTI }
      if AClass.ClassInfo <> nil then
      begin
         { load class structure from RTTI (only published properties) }
         n := GetPropList(AClass.ClassInfo,FScripter.FTypeInfoFilter, nil);
         size := n * SizeOf(pointer);
         GetMem(list, size);
         try
            GetPropList(AClass.ClassInfo, FScripter.FTypeInfoFilter, list);
            for c := 0 to n - 1 do
            begin
               if list^[c]^.PropType^^.Kind=TTypeKind(tkArray) then
               begin
               end
               else
                  result.FProperties.AddByRTTI(list^[c]);
            end;
         finally
            FreeMem(list,size);
         end;
      end;
   end;
end;

function TatClasses.AddDelphiClass(AClass:TClass; AClassName: string=''): TatClass;
var list     : PPropList;
    c,n,size : integer;
    i        : integer;
begin
   { inclui uma classe para o scripter com base em uma classe do Delphi }

   { permite fornecer um nome qualquer para a classe }
   if AClassName='' then
     AClassName := AClass.ClassName;

   { evita duplica��o de classes }
   i := IndexOf(AClassName);
   if  i>= 0 then
     result := Items[i]
   else
     result := TatClass( inherited Add );

   { carrega informa��e da classe Delphi, se ainda n�o foram carregadas }
   if not Assigned(result.FClassRef) then
   begin
     with result do
     begin
       FName := AClassName;
       FClassRef := AClass;
       { se a classe do Delphi possui um ancestral ent�o tamb�m
         copia a classe ancestral no scripter }
       if AClass.ClassParent<>nil then
       begin
         FAncestorName := AClass.ClassParent.ClassName;
         if (FAncestorName>'') then Inherits( FAncestorName );
       end;
     end;
     { se a classe possuir informa��es de runtime (declaradas com $M+)
       ent�o define seus membros atrav�s do RTTI }
     if AClass.ClassInfo <> nil then
     begin
       { load class structure from RTTI (only published properties) }
       n := GetPropList(AClass.ClassInfo,FScripter.FTypeInfoFilter,nil);
       size := n*SizeOf(pointer);
       GetMem(list,size);
       try
         GetPropList( AClass.ClassInfo, FScripter.FTypeInfoFilter, list );
         for c:=0 to n-1 do
           result.FProperties.AddByRTTI(list^[c]);
       finally
         FreeMem(list,size);
       end;
     end;
   end;
end;

{$IFDEF DELPHI2010_LVL}
function TatClasses.AddClassByRTTIEx(AClass: TClass; AClassName: string; AVisibilityFilter: TMemberVisibilitySet;
  ARecursive: boolean; ARedefine: TRedefineOption): TatClass;
var
  i: integer;
  context: TRttiContext;
  rtype: TRttiType;
  methods: TArray<TRttiMethod>;
  method: TRttiMethod;
  param: TRttiParameter;
  props: TArray<TRttiProperty>;
  prop: TRttiProperty;
  fields: TArray<TRttiField>;
  field: TRttiField;
  getter, setter: TMachineProc;
  regClass: TClass;
  typeKind: TatTypeKind;
  coverloaded: boolean;

  procedure RecursiveDefine(AType: TRttiType);
  var
    dclass: TClass;
  begin
    if AType <> nil then
    begin
      case AType.TypeKind of
        TypInfo.tkClass:
          begin
            dclass := FScripter.ScrClassType(AType);
            if (dclass <> nil) and (ClassByName(dclass.ClassName) = nil) then
              AddClassByRTTIEx(dclass, dclass.ClassName, AVisibilityFilter, ARecursive, ARedefine);
          end;
        TypInfo.tkEnumeration:
          FScripter.AddEnumeration(AType.Handle);
      end;
    end;
  end;
  
begin
  if AClassName = '' then
    AClassName := AClass.ClassName;

  i := IndexOf(AClassName);
  if i >= 0 then
    result := Items[i]
  else
    result := TatClass(inherited Add);

  if not Assigned(result.FClassRef) or (ARedefine <> roNone) then
  begin
    // option to overwrite class members when redefining an already registered class
    if Assigned(result.FClassRef) and (ARedefine = roOverwrite) then
    begin
      result.Methods.Clear;
      result.Properties.Clear;
      if Assigned(result.FAncestor) then
        result.FAncestor.RemoveDescendant(result);
    end;

    result.FName := AClassName;
    result.FClassRef := AClass;

    // if the classname is different from aclass.classname, then addbyrtti the
    //   original class, and the ancestor will be the original class}
    if CompareText(AClass.ClassName, AClassName) <> 0 then
    begin
      // Add the original class with original name}
      AddClassByRTTIEx(AClass, '', AVisibilityFilter, ARecursive, ARedefine);

      // Makes the original class the ancestor
      result.FAncestorName := AClass.ClassName;
      result.Inherits(result.FAncestorName);
    end
    else
    begin
      // if the Delphi class has an ancestor, then register the ancestor class in scripter
      // and register the inheritance
      if AClass.ClassParent <> nil then
      begin
        AddClassByRTTIEx(AClass.ClassParent, AClass.ClassParent.ClassName, AVisibilityFilter, ARecursive, ARedefine);
        result.FAncestorName := AClass.ClassParent.ClassName;
        if result.FAncestorName > '' then
          result.Inherits(result.FAncestorName);
      end;

      // define class methods and properties, according to visibility filter
      context := TRttiContext.Create;
      try
        rtype := context.GetType(AClass);

        // define methods
        methods := rtype.GetDeclaredMethods;
        coverloaded := False;
        for method in methods do
        begin
          if method.HasExtendedInfo and (method.Visibility in AVisibilityFilter) then
          begin
            if method.IsConstructor then
            begin
              regClass := AClass;
              typeKind := tkClass;
            end
            else
            begin
              regClass := FScripter.ScrClassType(method.ReturnType);
              typeKind := FScripter.ScrTypeKind(method.ReturnType);
            end;

            // define only first declared method when there are overloads
            if (result.MethodByName(method.Name) = nil) or (method.IsConstructor and not coverloaded) then
            begin
              result.DefineMethod(
                method.Name,
                Length(method.GetParameters),
                typeKind,
                regClass,
                FScripter.GenericMethodMachineProc,
                method.IsClassMethod or method.IsConstructor);
              if method.IsConstructor then
                coverloaded := True;
            end;

            if ARecursive then
            begin
              if regClass <> AClass then
                RecursiveDefine(method.ReturnType);
              for param in method.GetParameters do
                RecursiveDefine(param.ParamType);
            end;
          end;
        end;

        // define properties
        props := rtype.GetDeclaredProperties;
        for prop in props do
        begin
          if prop.Visibility in AVisibilityFilter then
          begin
            if prop.IsReadable then
              getter := FScripter.GenericPropGetterMachineProc
            else
              getter := nil;
            if prop.IsWritable then
              setter := FScripter.GenericPropSetterMachineProc
            else
              setter := nil;
            regClass := FScripter.ScrClassType(prop.PropertyType);
            if (ARedefine <> roInclude) or (result.PropertyByName(prop.Name) = nil) then
              result.DefineProp(prop.Name, FScripter.ScrTypeKind(prop.PropertyType), getter, setter, regClass);

            if prop.PropertyType <> nil then
            begin
              //if prop.PropertyType is TRttiMethodType then // events (disabled)
              //  if EventAdapters.FindAdapter(prop.PropertyType.Handle) = nil then
              //    EventAdapters.DefineEventAdapter(prop.PropertyType.Handle, TGenericEventDispatcher, @TGenericEventDispatcher.RaiseEvent, True);

              if prop.PropertyType is TRttiRecordType then // records
                FScripter.DefineRecordByRTTI(prop.PropertyType.Handle);
            end;

            if ARecursive then
              RecursiveDefine(prop.PropertyType);
          end;
        end;

        // define fields as properties
        fields := rtype.GetDeclaredFields;
        for field in fields do
        begin
          if field.Visibility in AVisibilityFilter then
          begin
            regClass := FScripter.ScrClassType(field.FieldType);
            if (ARedefine <> roInclude) or (result.PropertyByName(field.Name) = nil) then
              result.DefineProp(
                field.Name,
                FScripter.ScrTypeKind(field.FieldType),
                FScripter.GenericFieldGetterMachineProc,
                FScripter.GenericFieldSetterMachineProc,
                regClass);

            if ARecursive then
              RecursiveDefine(field.FieldType);
          end;
        end;

      finally
        context.Free;
      end;
    end;
  end;
end;
{$ENDIF}

function TatClasses.IndexOf(AName:string):integer;
begin
   for result:=0 to Count-1 do
      if CompareText(AName,Items[result].FName)=0 then Exit;
   result:=-1;
end;

function TatClasses.ClassByName(AName:string):TatClass;
var i: integer;
begin
   i := IndexOf(AName);
   if i > -1 then
      result := Items[i]
   else
      result := nil;
end;

function TatClasses.CheckLoaded(AClass: TClass; AClassName: string = ''):TatClass;
begin
  result := AddClassByRTTI(AClass, AClassName);
end;                                               

function TatClasses.TestCheckLoaded(AClass: TClass; var ACurrentClass: TatClass; AClassName: string = ''): boolean;
var
  i: integer;
begin
  if AClassName = '' then
    AClassName := AClass.ClassName;

   { return true if class was included }
   i := IndexOf(AClassName);
   result := ((i=-1) or not Assigned(Items[i].FClassRef));
   if result then
     ACurrentClass := AddClassByRTTI(AClass, AClassName)
   else
     ACurrentClass := Items[i];
end;

function TatClasses.GetImplicitCount: integer;
var
  i: integer;
begin
  result := 0;
  for i:=0 to Count-1 do
    if Items[i].IsImplicit then
      Inc(result);
end;

{TatClass}

constructor TatClass.Create( ACollection:TCollection );
begin
   inherited Create( ACollection );
   FDescendants:= TList.Create;
   FProperties := TatProperties.Create( self );
   FMethods    := TatMethods.Create( self );
end;

destructor TatClass.Destroy;
begin
   NotifyDescendants;
   if Assigned(FAncestor) then FAncestor.RemoveDescendant(Self);
   FDescendants.Free;
   FMethods.Free;
   FProperties.Free;
   inherited;
end;

procedure TatClass.NotifyDescendants;
Var c: integer;
begin
   for c:=0 to FDescendants.Count-1 do
      TatClass(FDescendants[c]).AncestorDestroyed;
end;

procedure TatClass.AncestorDestroyed;
begin
   FAncestor:=nil;
end;

procedure TatClass.Inherits(AAncestorName: string); // n�o deve ser chamada com ''
var
  c: integer;
begin
   { se a classe existe no RTTI e ela possui um ancestral,
     ent�o adiciona esse ancestral automaticamente }
   if Assigned(FClassRef) and (FClassRef.ClassParent <> nil) then
      TatClasses(Collection).AddClassByRTTI(FClassRef.ClassParent);

   { se a classe tiver um ancestral j� conhecido ent�o herda dele todas
     as defini��es que foram introduzidas de forma n�o autom�tica (sem RTTI) }
   FAncestor := TatClasses(Collection).ClassByName(AAncestorName);

   { If there is an ancestor and descendant is NOT already included in ancestor
     list of descendants }
   if Assigned(FAncestor) and
      (FAncestor.FDescendants.IndexOf(Self) = -1) then
   begin
      { copia do ancestral, todos os m�todos definidos }
      for c:=0 to FAncestor.FMethods.Count-1 do
         FMethods.Add.Assign(FAncestor.FMethods[c]);
      { copia do ancestral, todos as propriedades definidas
        (exceto aquelas que foram definidas automaticamente pelo RTTI) }
      for c:=0 to FAncestor.FProperties.Count-1 do
         if not Assigned(FAncestor.FProperties[c].FPropInfo) then
            FProperties.Add.Assign(FAncestor.FProperties[c]);
      // inherits default property definition
      if FAncestor.DefaultProperty <> nil then
        DefaultProperty := FProperties.PropertyByName(FAncestor.DefaultProperty.Name);
      FAncestor.InsertDescendant(Self);
   end;
end;

{ user helpful methods }

// deprecated
procedure TatClass.AddObject( AName:string; AObject:TObject );
begin
   AddDelphiObjectProp(AName,AObject);
end;

// deprecated
procedure TatClass.AddConstant( AName:string; AValue:variant );
begin
   with SetProp(AName,tkVariant,nil,nil,nil) do
   begin
      Getter:=GenericProc(GetVariantPropProc);
      Value:=AValue;
   end;
end;

procedure TatClass.AddEnumeration( ATypeInfo: PTypeInfo);
var c: integer;
    typeData : PTypeData;
begin
  if Assigned(ATypeInfo) and (ATypeInfo^.Kind=TypInfo.tkEnumeration) then
  begin
    { declara valores enumerados como constantes no scripter }
    typeData := GetTypeData(ATypeInfo);
    for c := typeData.MinValue to typeData.MaxValue do
       AddConstant( GetEnumName(ATypeInfo,c),c );
  end
  else
    InternalError('Invalid type information on call to AddEnumeration');
end;

// deprecated -> use TatCustomScripter.AddVariable
procedure TatClass.AddVariable( AName:string; var AVar:variant );
begin
   try
      with SetProp(AName,tkVariant,nil,nil,nil) do
      begin
         Getter:=GenericProc(GetVarVariablePropProc);
         Setter:=GenericProc(SetVarVariablePropProc);
         Value:=integer(PVariant(@AVar));
         end
   except
      DefinitionError('Variable is unassigned or not a variant');
   end;
end;

procedure TatClass.AddVariable(AName: string; var AVar: extended);
begin
   try
      with SetProp(AName,tkVariant,nil,nil,nil) do
      begin
         Getter:=GenericProc(GetExtVariablePropProc);
         Setter:=GenericProc(SetExtVariablePropProc);
         Value:=integer(PExtended(@AVar));
         end
   except
      DefinitionError('Variable is unassigned or not a variant');
   end;
end;

procedure TatClass.AddVariable(AName: string; var AVar: double);
begin
   try
      with SetProp(AName,tkVariant,nil,nil,nil) do
      begin
         Getter:=GenericProc(GetDblVariablePropProc);
         Setter:=GenericProc(SetDblVariablePropProc);
         Value:=integer(PDouble(@AVar));
         end
   except
      DefinitionError('Variable is unassigned or not a variant');
   end;
end;

procedure TatClass.AddVariable(AName: string; var AVar: string);
begin
   try
      with SetProp(AName,tkVariant,nil,nil,nil) do
      begin
         Getter:=GenericProc(GetStrVariablePropProc);
         Setter:=GenericProc(SetStrVariablePropProc);
         Value:=integer(PString(@AVar));
         end
   except
      DefinitionError('Variable is unassigned or not a variant');
   end;
end;

procedure TatClass.AddVariable(AName: string; var AVar: widestring);
begin
   try
      with SetProp(AName,tkVariant,nil,nil,nil) do
      begin
         Getter:=GenericProc(GetWStrVariablePropProc);
         Setter:=GenericProc(SetWStrVariablePropProc);
         Value:=integer(PWideString(@AVar));
         end
   except
      DefinitionError('Variable is unassigned or not a variant');
   end;
end;

procedure TatClass.AddVariable(AName: string; var AVar: integer);
begin
   try
      with SetProp(AName,tkVariant,nil,nil,nil) do
      begin
         Getter:=GenericProc(GetIntVariablePropProc);
         Setter:=GenericProc(SetIntVariablePropProc);
         Value:=integer(PInteger(@AVar));
         end
   except
      DefinitionError('Variable is unassigned or not a variant');
   end;
end;

procedure TatClass.AddVariable(AName: string; var AVar: boolean);
begin
   try
      with SetProp(AName,tkVariant,nil,nil,nil) do
      begin
         Getter:=GenericProc(GetBoolVariablePropProc);
         Setter:=GenericProc(SetBoolVariablePropProc);
         Value:=integer(PBoolean(@AVar));
         end
   except
      DefinitionError('Variable is unassigned or not a variant');
   end;
end;

{ property creation }

function TatClass.AddProp(AName:string;ADataType:TatTypeKind;AGetter,ASetter:TGenericProc;APropertyClass:TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0):TatProperty;
Var c: integer;
begin
   result:=TatProperty( FProperties.Add );
   with result do
   begin
      FName:=AName;
      FDataType:=ADataType;
      FGetter:=AGetter;
      FSetter:=ASetter;
      FPropertyClass:=APropertyClass;
      FIsClassProp:=AIsClassProp;
      FIndexCount:=AIndexCount;
      { propaga esta inclus�o nas classes descendentes }
      for c:=0 to FDescendants.Count-1 do
         {$IFNDEF OverrideDescendants}
         if (TatClass(FDescendants[c]).PropertyByName(FName) = nil) then
         {$ENDIF}
           TatClass(FDescendants[c]).AddProp(
              FName,FDataType,FGetter,FSetter,FPropertyClass,FIsClassProp,FIndexCount);
   end;
end;

function TatClass.SetProp(AName:string;ADataType:TatTypeKind;AGetter,ASetter:TGenericProc;APropertyClass:TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0):TatProperty;
var i: integer;
begin
   i := FProperties.IndexOf(AName);
   if i = -1 then
      result := TatProperty( FProperties.Add )
   else
      result := FProperties[i];
   with result do
   begin
      FName:=AName;
      FDataType:=ADataType;
      FGetter:=AGetter;
      FSetter:=ASetter;
      FPropertyClass:=APropertyClass;
      FIsClassProp:=AIsClassProp;
      FIndexCount:=AIndexCount;
      { propaga esta altera��o nas classes descendentes }
      for i:=0 to FDescendants.Count-1 do
         {$IFNDEF OverrideDescendants}
         if (TatClass(FDescendants[i]).PropertyByName(FName) = nil) then
         {$ENDIF}
           TatClass(FDescendants[i]).SetProp(
              FName,FDataType,FGetter,FSetter,FPropertyClass,FIsClassProp,FIndexCount);
   end;
end;

procedure TatClass.AddIntegerProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);
begin
   SetProp(AName,tkInteger,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.AddStringProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);
begin
   SetProp(AName,tkLString,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.AddBooleanProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);
begin
   SetProp(AName,tkInteger,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.AddFloatProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);
begin
   SetProp(AName,tkFloat,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.AddVariantProp(AName:string;AGetter,ASetter:TGenericProc;AIsClassProp:boolean=false);
begin
   SetProp(AName,tkVariant,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.AddObjectProp(AName:string;AGetter,ASetter:TGenericProc;APropertyClass:TClass;AIsClassProp:boolean=false);
begin
   SetProp(AName,tkClass,AGetter,ASetter,APropertyClass,AIsClassProp);
end;

procedure TatClass.AddDelphiObjectProp(AName:string;AObject:TObject);
begin
   with SetProp(AName,tkClass,nil,nil,AObject.ClassType) do
   begin
      Getter:=GenericProc(GetDelphiObjectPropProc);
      Value:=integer(AObject);
   end;
end;

function TatClass.DefineProp(AName:string;ADataType:TatTypeKind;AGetter,ASetter:TMachineProc;APropertyClass:TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0):TatProperty;
begin
   {The code below is a workaround. It avoids a problem cause by pieces of code generated by import tool.
    The import tool sometimes redefines properties with no getter or setter. So, this must be avoided}
   if (ADataType = tkVariant) and not AssignedMethod(TMethod(AGetter)) and
     not AssignedMethod(TMethod(ASetter)) and (APropertyClass = nil) then
     result := nil
   else
     result:=SetProp(AName,ADataType,TGenericProc(AGetter),TGenericProc(ASetter),
        APropertyClass,AIsClassProp,AIndexCount);
end;

function TatClass.DefineNewProp(AName:string;ADataType:TatTypeKind;AGetter,ASetter:TMachineProc;APropertyClass:TClass=nil;AIsClassProp:boolean=false;AIndexCount:integer=0):TatProperty;
begin
   {The code below is a workaround. It avoids a problem cause by pieces of code generated by import tool.
    The import tool sometimes redefines properties with no getter or setter. So, this must be avoided}
   if (ADataType = tkVariant) and not AssignedMethod(TMethod(AGetter)) and
     not AssignedMethod(TMethod(ASetter)) and (APropertyClass = nil) then
     result := nil
   else
     result:=AddProp(AName,ADataType,TGenericProc(AGetter),TGenericProc(ASetter),
        APropertyClass,AIsClassProp,AIndexCount);
end;

(*Var c: integer;
begin
   result:=TatProperty( FProperties.Add );
   with result do
   begin
      FName:=AName;
      FDataType:=ADataType;
      FGetter:=TGenericProc(AGetter);
      FSetter:=TGenericProc(ASetter);
      FPropertyClass:=APropertyClass;
      FIsClassProp:=AIsClassProp;
      FIndexCount:=AIndexCount;
      { propaga esta inclus�o nas classes descendentes }
      for c:=0 to FDescendants.Count-1 do
         TatClass(FDescendants[c]).DefineProp(
            FName,FDataType,AGetter,ASetter,FPropertyClass,FIsClassProp,FIndexCount);
   end;
end;*)

procedure TatClass.DefineIntegerProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);
begin
   DefineProp(AName,tkInteger,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.DefineStringProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);
begin
   DefineProp(AName,tkLString,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.DefineBooleanProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);
begin
   DefineProp(AName,tkInteger,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.DefineFloatProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);
begin
   DefineProp(AName,tkFloat,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.DefineVariantProp(AName:string;AGetter,ASetter:TMachineProc;AIsClassProp:boolean=false);
begin
   DefineProp(AName,tkVariant,AGetter,ASetter,nil,AIsClassProp);
end;

procedure TatClass.DefineObjectProp(AName:string;AGetter,ASetter:TMachineProc;APropertyClass:TClass;AIsClassProp:boolean=false);
begin
   DefineProp(AName,tkClass,AGetter,ASetter,APropertyClass,AIsClassProp);
end;

{ method creation }

function TatClass.AddProc(AName: string; ACode: pointer; AArgCount: integer; AResultDataType: TatTypeKind; AProc: TGenericProc;
  AResultClass: TClass; AIsClassMethod: boolean = false; ADefArgCount: integer = 0):TatMethod;
Var c: integer;
begin
   result:=TatMethod( FMethods.Add );
   with result do
   begin
      FName:=AName;
      FCode:=ACode;
      FArgCount:=AArgCount;
      FDefArgCount := ADefArgCount;
      FResultDataType:=AResultDataType;
      FProc:=AProc;
      FResultClass:=AResultClass;
      FIsClassMethod:=AIsClassMethod;
      { propaga esta inclus�o nas classes descendentes }
      for c:=0 to FDescendants.Count-1 do
         {$IFNDEF OverrideDescendants}
         if (TatClass(FDescendants[c]).MethodByName(FName) = nil) then
         {$ENDIF}
           TatClass(FDescendants[c]).AddProc(
              FName, FCode, FArgCount, FResultDataType, FProc, FResultClass, FIsClassMethod, FDefArgCount);
   end;
end;

function TatClass.SetProc(AName: string; ACode: pointer; AArgCount: integer; AResultDataType: TatTypeKind; AProc: TGenericProc;
  AResultClass: TClass; AIsClassMethod: boolean = false; ADefArgCount: integer = 0): TatMethod;
var i:integer;
begin
   { se o m�todo j� existe, modifica-o sen�o adiciona-o }
   i:=FMethods.IndexOf(AName);
   if i=-1 then
      result := TatMethod( FMethods.Add )
   else
      result := FMethods[i];
   with result do
   begin
      FName:=AName;
      FCode:=ACode;
      FArgCount:=AArgCount;
      FDefArgCount := ADefArgCount;
      FResultDataType:=AResultDataType;
      FProc:=AProc;
      FResultClass:=AResultClass;
      FIsClassMethod:=AIsClassMethod;
      { propaga esta altera��o nas classes descendentes }
      for i:=0 to FDescendants.Count-1 do
         {$IFNDEF OverrideDescendants}
         if (TatClass(FDescendants[i]).MethodByName(FName) = nil) then
         {$ENDIF}
           TatClass(FDescendants[i]).SetProc(
              FName, FCode, FArgCount, FResultDataType, FProc, FResultClass, FIsClassMethod, FDefArgCount);
   end;
end;

function TatClass.AddMethod(AName: string; AArgCount: integer; AResultDataType: TatTypeKind; AResultClass: TClass; AProc: TGenericProc;
  AIsClassMethod: boolean = false; ADefArgCount: integer = 0): TatMethod;
begin
   result:=AddProc(AName,nil,AArgCount,AResultDataType,AProc,AResultClass,AIsClassMethod, ADefArgCount);
end;

function TatClass.DefineNewMethod(AName: string; AArgCount: integer; AResultDataType: TatTypeKind; AResultClass: TClass; AProc: TMachineProc;
  AIsClassMethod: boolean = false; ADefArgCount: integer = 0):TatMethod;
begin
   result:=AddProc(AName, nil, AArgCount, AResultDataType, TGenericProc(AProc), AResultClass, AIsClassMethod, ADefArgCount);
end;

function TatClass.DefineMethod(AName: string; AArgCount: integer; AResultDataType: TatTypeKind; AResultClass: TClass; AProc: TMachineProc;
  AIsClassMethod: boolean = false; ADefArgCount: integer = 0):TatMethod;
begin
   result := SetProc(AName, nil, AArgCount, AResultDataType, TGenericProc(AProc), AResultClass, AIsClassMethod, ADefArgCount);
end;

(*
function TatClass.FindGetterProcByName(AName:string;var AGetter:TGenericProc):boolean;
var i: integer;
begin
   i:=FProperties.IndexOf(AName);
   if i>-1 then
   begin
      AGetter:=FProperties[i].Getter;
      result:=true;
   end
   else
   begin
      with FMethods do
         for i:=0 to Count-1 do
            if (Items[i].FArgCount=0) and
               (CompareText(AName,Items[i].FName)=0) then
            begin
               AGetter:=Items[i].Proc;
               result:=true;
               Exit;
            end;
      result:=false;
   end;
end;
*)

procedure TatClass.InsertDescendant(ADescendant: TatClass);
begin
   FDescendants.Add(ADescendant);
end;

procedure TatClass.RemoveDescendant(ADescendant: TatClass);
begin
   FDescendants.Remove(ADescendant);
end;

procedure TatClass.SetMethods(const Value: TatMethods);
begin
   FMethods.Assign(Value);
end;

procedure TatClass.SetProperties(const Value: TatProperties);
begin
   FProperties.Assign(Value);
end;

function TatClass.ClassMethodByName(AName: string): TatMethod;
begin
   result:=Methods.ClassMethodByName(AName);
end;

function TatClass.ClassPropertyByName(AName: string): TatProperty;
begin
   result:=Properties.ClassPropertyByName(AName);
end;

function TatClass.MethodByName(AName: string): TatMethod;
begin
   result:=Methods.MethodByName(AName);
end;

function TatClass.PropertyByName(AName: string): TatProperty;
begin
   result:=Properties.PropertyByName(AName);
end;

function TatClass.CastFromString(AClassName: string): TatClass;
begin
  { for�a esta classe ser correspondente ou derivada da classe
    indicada em AClassName, gerando uma exce��o caso n�o seja.
    Retorna uma refer�ncia para a classe coergida }
  result := Self;
  while Assigned(result) do
  begin
    if SameText( result.Name, AClassName ) then
      Exit;
    result := result.Ancestor;
  end;
end;

procedure TatClass.RemoveProperty(AName: string);
var
  AProp: TatProperty;
begin
  AProp := PropertyByName(AName);
  if AProp <> nil then
    AProp.Free;
end;

function TatClass.GetIsImplicit: boolean;
begin
  result := FImplicitElement <> nil;
end;

procedure TatClass.SetImplicitElement(const Value: TCollectionItem);
begin
  Assert((Value = nil) or (Value is TatMethod) or (Value is TatProperty));
  FImplicitElement := Value;
end;

{TatProperties}

function TatProperties.GetItem(i:integer):TatProperty;
begin
   result:=TatProperty( inherited Items[i] );
end;

constructor TatProperties.Create( AClass:TatClass );
begin
   FClass:=AClass;
   inherited Create( TatProperty );
end;

function TatProperties.AddByRTTI(APropInfo:PPropInfo):TatProperty;
begin
   result:=TatProperty( inherited Add );
   with result do
   begin
      FName := string(APropInfo^.Name);
      FDataType:=MapTatTypeKind(APropInfo^.PropType^^.Kind);
      if Assigned(APropInfo^.GetProc) then
        FGetter:=GenericProc(RTTIGetterProc);
      if Assigned(APropInfo^.SetProc) then
        FSetter:=GenericProc(RTTISetterProc);
      FPropInfo:=APropInfo;
      if APropInfo^.PropType^^.Kind = TypInfo.tkClass then
        FPropertyClass := GetTypeData(FPropInfo^.PropType^)^.ClassType
      else
        FPropertyClass := nil;
   end;
end;

function TatProperties.IndexOf(AName:string):integer;
begin
   for result:=Count-1 downto 0 do
      if CompareText(AName,Items[result].FName)=0 then Exit;
   result:=-1;
end;

function TatProperties.PropertyByName(AName:string):TatProperty;
var i: integer;
begin
   i:=IndexOf(AName);
   if i>-1 then result:=Items[i] else result:=nil;
end;

function TatProperties.ClassPropertyByName(AName:string):TatProperty;
var i: integer;
begin
   for i:=Count-1 downto 0 do
      if Items[i].IsClassProp and (CompareText(AName,Items[i].FName)=0) then
      begin
         result:=Items[i];
         Exit;
      end;
   result:=nil;
end;

{TatProperty}

constructor TatProperty.Create( ACollection:TCollection );
begin
   inherited Create(ACollection);
   FScripter:=TatClasses(TatProperties(Collection).FClass.Collection).FScripter;
end;

procedure TatProperty.Assign(Source: TPersistent);
begin
   Name          := TatProperty(Source).Name;
   DataType      := TatProperty(Source).DataType;
   Getter        := TatProperty(Source).Getter;
   Setter        := TatProperty(Source).Setter;
   PropertyClass := TatProperty(Source).PropertyClass;
   PropInfo      := TatProperty(Source).PropInfo;
   Value         := TatProperty(Source).Value;
   IsClassProp   := TatProperty(Source).IsClassProp;
   IndexCount    := TatProperty(Source).IndexCount;
   { ajusta a inst�ncia do Getter e do Setter se ela for a propriedade de origem }
   if TMethod(TatProperty(Source).FGetter).Data=Source then
      TMethod(FGetter).Data:=self;
   if TMethod(TatProperty(Source).FSetter).Data=Source then
      TMethod(FSetter).Data:=self;
   (*
   { garante que se o Getter ou o Setter referenciar um UserProc, este corresponder� ao Scripter corrente }
   if Scripter<>TatProperty(Source).Scripter then
   begin
      if TObject(TMethod(TatProperty(Source).FGetter).Data) is TatProcCollectionItem then
         with TatProcCollectionItem(TMethod(TatProperty(Source).FGetter).Data) do
            self.Getter:=self.Scripter.UserProc( UserProc ); // duplica o UserProc alterando apenas a propriedade Scripter
      if TObject(TMethod(TatProperty(Source).FSetter).Data) is TatProcCollectionItem then
         with TatProcCollectionItem(TMethod(TatProperty(Source).FSetter).Data) do
            self.Setter:=self.Scripter.UserProc( UserProc ); // duplica o UserProc alterando apenas a propriedade Scripter
   end;
   *)
end;

procedure TatProperty.RTTIGetterProc(AMachine:TatVirtualMachine);
var v : Variant;
begin
   with AMachine do
   begin
      { Pega a inst�ncia no primeiro par�metro da pilha de execu��o atPascal,
        usa o m�todo apropriado de leitura da propriedade, com base no tipo de dado e
        salva o conte�do da propriedade na pilha de execu��o do atPascal }

      case FDataType of
         tkEnumeration:
            if GetTypeData(FPropInfo.PropType^)^.BaseType^ = TypeInfo(Boolean) then
              ReturnOutputArg(GetOrdProp(CurrentObject, FPropInfo) <> 0)
            else
              ReturnOutputArg(GetOrdProp(CurrentObject,FPropInfo));
         tkInteger, tkChar, tkSet, tkWChar, tkClass:
            ReturnOutputArg(GetOrdProp(CurrentObject,FPropInfo));
         tkString, tkLString:
            ReturnOutputArg(GetStrProp(CurrentObject,FPropInfo));
         tkWString:
            {$IFDEF DELPHI7_LVL}
            ReturnOutputArg(GetWideStrProp(CurrentObject,FPropInfo));
            {$ELSE}
            ReturnOutputArg(GetStrProp(CurrentObject,FPropInfo));
            {$ENDIF}
         {$IFDEF DELPHI2009_LVL}
         tkUString:
            ReturnOutputArg(GetUnicodeStrProp(CurrentObject,FPropInfo));
         {$ENDIF}
         tkFloat:
            ReturnOutputArg(GetFloatProp(CurrentObject,FPropInfo));
         tkVariant:
            ReturnOutputArg(GetVariantProp(CurrentObject,FPropInfo));
         tkMethod:
            if Assigned(FScripter.FOnTranslateMethodGetter) then
            begin
               v := null;
               { generic event translation from TMethod to a Variant type }
               FScripter.FOnTranslateMethodGetter(AMachine, CurrentObject, FPropInfo, v);
               ReturnOutputArg(v);
            end
            else
               ReturnOutputArg(null);
         else
            ReturnOutputArg(null);
      end;
   end;
end;

procedure TatProperty.RTTISetterProc(AMachine:TatVirtualMachine);
begin
   with AMachine do
   begin
      { Pega a inst�ncia no primeiro par�metro da pilha de execu��o atPascal,
        pega o novo valor para a propriedade no segundo par�metro da pilha de execu��o e
        usa o m�todo apropriado de escrita na propriedade, com base no tipo de dado }
      case FDataType of
         tkInteger, tkChar, tkWChar, tkClass:
            SetOrdProp(CurrentObject,FPropInfo,GetInputArgAsInteger(0));
         tkSet:
            SetOrdProp(CurrentObject,FPropInfo,VarToSet(GetInputArg(0),FPropInfo.PropType^));
         tkEnumeration:
            SetOrdProp(CurrentObject,FPropInfo,VarToEnumInteger(GetInputArg(0),FPropInfo.PropType^));
         tkString, tkLString:
            SetStrProp(CurrentObject,FPropInfo,GetInputArgAsString(0));
         tkWString:
            {$IFDEF DELPHI7_LVL}
            SetWideStrProp(CurrentObject,FPropInfo,GetInputArgAsWideString(0));
            {$ELSE}
            SetStrProp(CurrentObject,FPropInfo,GetInputArgAsWideString(0));
            {$ENDIF}
         {$IFDEF DELPHI2009_LVL}
         tkUString:
            SetUnicodeStrProp(CurrentObject,FPropInfo,GetInputArgAsString(0));
         {$ENDIF}
         tkFloat:
            SetFloatProp(CurrentObject,FPropInfo,GetInputArgAsFloat(0));
         tkVariant:
            SetVariantProp(CurrentObject,FPropInfo,GetInputArg(0));
         tkMethod:
            if Assigned(FScripter.FOnTranslateMethodSetter) then
               { generic event translation from Variant to a TMethod type }
               FScripter.FOnTranslateMethodSetter(AMachine, CurrentObject, FPropInfo, GetInputArg(0));
      end;
   end;
end;

function TatProperty.UpdateObjectInfo(var ACurrentClass: TatClass): boolean;
begin
   result:=false;
   { se a propriedade referir-se a uma classe ent�o carrega as informa��es
     desta classe, se ela ainda n�o havia sido carregada }
   case FDataType of
     tkClass:
       if Assigned(FPropertyClass) then
          if FScripter.FDeferObjectResolution then
             { A resolu��o do acesso � classe dever� ocorrer efetivamente em runtime }
             ACurrentClass := TatClass(1) // undefined variable instance
          else
             { Carrega as inform��es da classe referenciada }
             if TatClasses(TatProperties(Collection).FClass.Collection).TestCheckLoaded(
               FPropertyClass, ACurrentClass, FPropertyClassName) then
                result := True
             else
       else
       begin
 //       FatalError(Format('Result class for method ''%s'' not defined',[FName]))
          { class resolution should be procrastinated (runtime resolution) }
          ACurrentClass := TatClass(1) // undefined variable instance
       end;
     tkVariant:
       ACurrentClass := TatClass(1) // undefined variable instance
     else
       ACurrentClass := nil;
   end;
end;

procedure TatProperty.GetDelphiObjectPropProc(AMachine:TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(VarToInteger(FValue));
end;

procedure TatProperty.GetVariantPropProc(AMachine:TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(FValue);
end;

procedure TatProperty.GetVarVariablePropProc(AMachine:TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(PVariant(integer(FValue))^ );
end;

procedure TatProperty.SetVarVariablePropProc(AMachine:TatVirtualMachine);
begin
   PVariant(integer(FValue))^:=AMachine.GetInputArg(0);
end;

procedure TatProperty.GetIntVariablePropProc(AMachine:TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(PInteger(integer(FValue))^ );
end;

procedure TatProperty.SetIntVariablePropProc(AMachine:TatVirtualMachine);
begin
   PInteger(integer(FValue))^:=AMachine.GetInputArg(0);
end;

procedure TatProperty.GetStrVariablePropProc(AMachine:TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(PString(integer(FValue))^ );
end;

procedure TatProperty.SetStrVariablePropProc(AMachine:TatVirtualMachine);
begin
   PString(integer(FValue))^:=AMachine.GetInputArg(0);
end;

procedure TatProperty.GetWStrVariablePropProc(AMachine: TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(PWideString(integer(FValue))^ );
end;

procedure TatProperty.SetWStrVariablePropProc(AMachine: TatVirtualMachine);
begin
   PWideString(integer(FValue))^ := AMachine.GetInputArg(0);
end;

procedure TatProperty.GetBoolVariablePropProc(AMachine:TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(PBoolean(integer(FValue))^ );
end;

procedure TatProperty.SetBoolVariablePropProc(AMachine:TatVirtualMachine);
begin
   PBoolean(integer(FValue))^:=AMachine.GetInputArg(0);
end;

procedure TatProperty.GetDblVariablePropProc(AMachine: TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(PDouble(integer(FValue))^ );
end;

procedure TatProperty.SetDblVariablePropProc(AMachine: TatVirtualMachine);
begin
   PDouble(integer(FValue))^:=AMachine.GetInputArg(0);
end;

procedure TatProperty.GetExtVariablePropProc(AMachine: TatVirtualMachine);
begin
   AMachine.ReturnOutputArg(PExtended(integer(FValue))^ );
end;

procedure TatProperty.SetExtVariablePropProc(AMachine: TatVirtualMachine);
begin
   PExtended(integer(FValue))^:=AMachine.GetInputArg(0);
end;

function TatProperty.atClass: TatClass;
begin
   result:=TatProperties(Collection).FClass;
end;

procedure TatProperty.GetFormComponentProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
    if CurrentObject is TComponent then
      ReturnOutputArg(integer(TComponent(CurrentObject).FindComponent(CurrentPropertyName)))
    else
      ReturnOutputArg(0);
end;

function TatProperty.GetDisplayName: string;
begin
  result := Name;
end;

{TatMethods}

function TatMethods.GetItem(i:integer):TatMethod;
begin
   result:=TatMethod( inherited Items[i] );
end;

constructor TatMethods.Create( AClass:TatClass );
begin
   FClass:=AClass;
   inherited Create( TatMethod );
end;

function TatMethods.IndexOf(AName:string):integer;
begin
   for result:=Count-1 downto 0 do
      if CompareText(AName,Items[result].FName)=0 then Exit;
   result:=-1;
end;

function TatMethods.MethodByName(AName:string):TatMethod;
var
  i: integer;
begin
  i := IndexOf(AName);
  if i > -1 then result := Items[i] else result := nil;
end;

function TatMethods.ClassMethodByName(AName:string):TatMethod;
var i: integer;
begin
   for i:=Count-1 downto 0 do
      if Items[i].IsClassMethod and (CompareText(AName,Items[i].FName)=0) then
      begin
         result:=Items[i];
         Exit;
      end;
   result:=nil;
end;

{TatMethod}

constructor TatMethod.Create( ACollection:TCollection );
begin
   inherited Create( ACollection );
   FArgDefs := TatDataDefs.Create( TatMethods(Collection).FClass );
   FScripter := TatClasses(TatProperties(Collection).FClass.Collection).FScripter;
end;

destructor TatMethod.Destroy;
begin
   FArgDefs.Free;
   inherited;
end;

procedure TatMethod.Assign(Source: TPersistent);
begin
   Name           := TatMethod(Source).Name;
   Proc           := TatMethod(Source).Proc;
   ResultDataType := TatMethod(Source).ResultDataType;
   ArgCount       := TatMethod(Source).ArgCount;
   DefArgCount    := TatMethod(Source).DefArgCount;
   Code           := TatMethod(Source).Code;
   ResultClass    := TatMethod(Source).ResultClass;
   ArgDefs        := TatMethod(Source).ArgDefs;
   IsClassMethod  := TatMethod(Source).IsClassMethod;
   ByRefArgMask   := TatMethod(Source).ByRefArgMask;
   { ajusta a inst�ncia do Proc se ela for o m�todo de origem }
   if TMethod(TatMethod(Source).FProc).Data=Source then
      TMethod(FProc).Data:=self
   else
   (*
   { garante que se o Proc referenciar um UserProc, este corresponder� ao Scripter corrente }
   if (Scripter<>TatMethod(Source).Scripter) and
      (TObject(TMethod(TatMethod(Source).FProc).Data) is TatProcCollectionItem) then
      with TatProcCollectionItem(TMethod(TatMethod(Source).FProc).Data) do
         self.Proc:=self.Scripter.UserProc( UserProc ); // duplica o UserProc alterando apenas a propriedade Scripter
   *)
end;

function TatMethod.UpdateObjectInfo( var ACurrentClass:TatClass ):boolean;
begin
   result:=false;
   { se o m�todo retornar uma classe ent�o carrega as informa��es
     desta classe, se ela ainda n�o havia sido carregada }
   Case FResultDataType of
     tkClass:
       if Assigned(FResultClass) then
          if FScripter.FDeferObjectResolution then
             { A resolu��o do acesso � classe dever� ocorrer efetivamente em runtime }
             ACurrentClass := TatClass(1) // undefined variable instance
          else
             { Carrega as informa��es da classe referenciada }
             if TatClasses(TatMethods(Collection).FClass.Collection).TestCheckLoaded(FResultClass, ACurrentClass, FResultClassName) then
                result := True
             else
       else
       begin
 //       FatalError(Format('Result class for method ''%s'' not defined',[FName]))
          { class resolution should be procrastinated (runtime resolution) }
          ACurrentClass := TatClass(1) // undefined variable instance
       end;
     tkVariant:
       ACurrentClass := TatClass(1); // undefined variable instance
   else
      ACurrentClass := nil;
   end;
end;

procedure TatMethod.SetVarArgs(argi: array of byte);
var c: integer;
begin
   { adjust FArgDefs.Count to FArgCount }
   for c:=FArgDefs.Count to FArgCount-1 do
      TCollection(FArgDefs).Add;
   { sets the TArgumentDef.Modifier property and the ByRefArgMask }
   FByRefArgMask:=0;
   for c:=0 to High(argi) do
   begin
      FArgDefs[argi[c]].FModifier:=moVar;
      FByRefArgMask:=FByRefArgMask or (1 shl argi[c]);
   end;
end;

function TatMethod.IsByRefArg(n: byte): boolean;
begin
   result:=(n<FArgDefs.Count) and (FArgDefs[n].Modifier=moVar);
end;

procedure TatMethod.SetArgDefs(const Value: TatDataDefs);
begin
   FArgDefs.Assign(Value);
end;

function TatMethod.atClass: TatClass;
begin
   result:=TatMethods(Collection).FClass;
end;

function TatMethod.GetDisplayName: string;
begin
  result := Name;
end;

{TatDataDefs}

function TatDataDefs.GetItem(i:integer):TatDataDef;
begin
   result:=TatDataDef( inherited Items[i] );
end;

constructor TatDataDefs.Create( AClass:TatClass );
begin
   inherited Create( TatDataDef );
end;

function TatDataDefs.Add(AName:string;ADataType:TatTypeKind;AModifier:TatArgumentModifier):TatDataDef;
begin
   result:=TatDataDef( inherited Add );
   with result do
   begin
      FName:=AName;
      FDataType:=ADataType;
      FModifier:=AModifier;
   end;
end;

{TatDataDef}

{TatObjects}

constructor TatObjects.Create(AClasses:TatClasses);
begin
   inherited Create( TatObject );
   FClasses:=AClasses;
   Clear;
end;

function TatObjects.IndexOf(AName:string):integer;
begin
   for result:=0 to Count-1 do
      if CompareText(Items[result].FName,AName)=0 then Exit;
   result:=-1;
end;

function TatObjects.GetItem(i:integer):TatObject;
begin
   result:=TatObject( inherited Items[i] );
end;

function TatObjects.Add(AInstance:TObject; AName: string=''; AClassName: string = ''):TatObject;
var i: integer;
begin
  if not Assigned(AInstance) then
    DefinitionError('Invalid atPascal default instance');

  { if AName was not specified then assume a default name }
  if AName='' then
    if AInstance is TatScripterLibrary then
      AName := TatScripterLibrary(AInstance).LibraryName
    else
      AName := AInstance.ClassName;

  { duplication of instances is not allowed }
  i := IndexOf(AName);
  if i = -1 then
  begin
    result := TatObject( inherited Add );
    with result do
    begin
      FInstance := AInstance;
      FatClass := FClasses.CheckLoaded(AInstance.ClassType, AClassName);
      FName := AName;
    end;
  end
  else
    result := Items[i];
//else
//  DefinitionError(Format('Default instance ''%s'' already exists',[AInstance.ClassName]));
end;

function TatObjects.FindInstanceByMethodName( AMethodName:string; var AMethod:TatMethod ):integer;
begin
   for result:=Count-1 downto 0 do
   begin
      AMethod:=Items[result].atClass.Methods.MethodByName(AMethodName);
      if Assigned(AMethod) then Exit;
   end;
   AMethod:=nil;
   result:=-1;
end;

function TatObjects.FindInstanceByPropertyName( APropertyName:string; var AProperty:TatProperty ):integer;
begin
   for result:=Count-1 downto 0 do
   begin
      AProperty:=Items[result].atClass.Properties.PropertyByName(APropertyName);
      if Assigned(AProperty) then Exit;
   end;
   AProperty:=nil;
   result:=-1;
end;

function TatObjects.FindInstanceByClassName(AClassName: string): TatObject;
var
  c: integer;
begin
  result := nil;
  for c := Count - 1 downto 0 do
  begin
    if SameText(Items[c].atClass.Name, AClassName) then
    begin
      result := Items[c];
      break;
    end;
  end;
end;

{TatScriptInfo}

constructor TatScriptInfo.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FRoutines := TatRoutinesInfo.Create(Self, TatRoutineInfo);
   FRoutines.FScriptInfo := Self;
   { cole��o de vari�veis globais do script }
   FGlobals := TatVariablesInfo.Create(Self, TatVariableInfo);
end;

destructor TatScriptInfo.Destroy;
begin
  FGlobals.Free;
  FRoutines.Free;
end;

procedure TatScriptInfo.UpdateRoutineInfoPointers;
var inst : pSimplifiedCode;
    i : integer;
    routine : TatRoutineInfo;
begin
  { load some debug info from compiled code }
  inst := FScript.FirstInstruction;
  FCodeSize := 0;
  while inst <> nil do
  begin
    with inst^ do
    begin
      case OpCode of
        inPrepare:
          begin
            { create or update routine with its name and entry point }
            i := FRoutines.IndexOf(vString);
            if i > -1 then
              routine := FRoutines[i]
            else
              routine := TatRoutineInfo(FRoutines.Add);
            with routine do
            begin
              FName := vString;
              FDeclarationInstruction := inst;
            end;
          end;
      end;
    end;
    inst:=inst^.Next;
    Inc(FCodeSize);
  end;
end;

procedure TatScriptInfo.Clear;
begin
  FRoutines.Clear;
  FGlobals.Clear;
  FFormResource := '';
  FScriptClassName := '';
  FIsForm := false;
  FUnitName := '';
end;

function TatScriptInfo.RoutineByName(AName:string):TatRoutineInfo;
var i: integer;
begin
   i:=Routines.IndexOf(AName);
   if i>-1 then
      result:=Routines[i]
   else
      result:=nil;
end;

function TatScriptInfo.DeclareRoutine(AName: string; ADeclInst: pSimplifiedCode;AIsFunction:boolean):TatRoutineInfo;
begin
  result:=TatRoutineInfo(TCollection(FRoutines).Add);
  with result do
  begin
    FName := AName;
    FDeclarationInstruction := ADeclInst;
    FIsFunction := AIsFunction;
  end;
end;


procedure TatScriptInfo.SetGlobals(const Value: TatVariablesInfo);
begin
  FGlobals.Assign(Value);
end;

procedure TatScriptInfo.SetRoutines(const Value: TatRoutinesInfo);
begin
  FRoutines.Assign(Value);
end;

function TatScriptInfo.GetMainRoutineName: string;
begin
  if MainRoutine <> nil then
    result := MainRoutine.Name
  else
    result := '';
end;

procedure TatScriptInfo.SetMainRoutineName(const Value: string);
begin
  MainRoutine := RoutineByName(Value);
end;

{ TatRoutinesInfo }

function TatRoutinesInfo.GetItem(i:integer):TatRoutineInfo;
begin
   result:=TatRoutineInfo( inherited Items[i] );
end;

procedure TatRoutinesInfo.GetNames(AStrings: TStrings);
var
  c: integer;
begin
  AStrings.Clear;
  for c := 0 to Count - 1 do
    AStrings.Add(Items[c].Name);
end;

function TatRoutinesInfo.IndexOf(AName:string):integer;
begin
   for result:=0 to Count-1 do
      if CompareText(Items[result].FName,AName)=0 then Exit;
   result:=-1;
end;

{ TatRoutineInfo }

constructor TatRoutineInfo.Create(ACollection:TCollection);
begin
   inherited Create(ACollection);
   FVariables := TatVariablesInfo.Create( Self, TatVariableInfo );
end;

destructor TatRoutineInfo.Destroy;
begin
   FVariables.Free;
   inherited;
end;

function TatRoutineInfo.VariableByName(AName: string): TatVariableInfo;
var i : integer;
begin
   i:=FVariables.IndexOf(AName);
   if i>-1 then
     result := FVariables[i]
   else
     result := nil;
end;

function TatRoutineInfo.LocalVarCount: integer;
begin
  result := FVariables.Count - FArgCount;
end;

function TatRoutineInfo.ScriptInfo: TatScriptInfo;
begin
  if Collection is TatRoutinesInfo then
    result := TatScriptInfo( TatRoutinesInfo(Collection).GetOwner )
  else
    result := nil;
end;

function TatRoutineInfo.DeclareVariable(AName: string; ASourcePos:integer;AArgIndex:integer=-1;AModifier:TatArgumentModifier=moNone): TatVariableInfo;
begin
   result := FVariables.Add;
   with result do
   begin
      FVarName := AName;
      FDeclarationSourcePos := ASourcePos;
      FArgIndex := AArgIndex;
      FModifier := AModifier;
   end;
   if AArgIndex > -1 then
      Inc( FArgCount );
   { ajusta a m�scara de par�metros que devem ser passados por refer�ncia }
   if AModifier = moVar then
      FByRefArgMask := FByRefArgMask or (1 shl AArgIndex);
end;

procedure TatRoutineInfo.Assign(ASource: TPersistent);
begin
  FVariables.Assign( TatRoutineInfo(ASource).FVariables );
  FName := TatRoutineInfo(ASource).FName;
  FDeclarationInstruction := TatRoutineInfo(ASource).FDeclarationInstruction;
  FIsFunction := TatRoutineInfo(ASource).FIsFunction;
  FArgCount := TatRoutineInfo(ASource).FArgCount;
  FByRefArgMask := TatRoutineInfo(ASource).FByRefArgMask;
  FResultIndex := TatRoutineInfo(ASource).FResultIndex;

  FCallingConvention := TatRoutineInfo(ASource).FCallingConvention;
  FExternalDll := TatRoutineInfo(ASource).FExternalDll;
  FExternalName := TatRoutineInfo(ASource).FExternalName;
  FResultTypeDecl := TatRoutineInfo(ASource).FResultTypeDecl;
  FResultClass := TatRoutineInfo(ASource).FResultClass;
end;

procedure TatRoutineInfo.SetVariables(const Value: TatVariablesInfo);
begin
  FVariables.Assign(Value);
end;

procedure TatRoutineInfo.PrepareExternalClass;
var
  lib: TatDLL;
  met: TatMethod;
  c: integer;
  dllMethodName: string;
begin
  lib := ScriptInfo.FScript.FScripter.LoadLibrary( '_DLL_', True ) as TatDLL;
  lib.FScript := ScriptInfo.FScript; // forces library destruction when script is destroyed
  lib.FScript.FLoadedDLL := True; // flags that are linked libraries in script
  lib.FFileName := FExternalDll;
  with ScriptInfo.FScript.UsedUnits.Add do
  begin
    UnitName := '_DLL_';
    IsDefault := True;
    IsScript := False;
    DeclSourcePos := -1;
  end;
  { load dll methods }
  with lib.FatClass do
  begin
    { to register the method, remove the @ in front of routine name, if it exists. It might exist when loading the compiled code
      from stream, for example }
    dllMethodName := Self.Name;
    if (length(dllMethodName) > 0) and (dllMethodName[1] = '@') then
      dllMethodName := Copy(dllMethodName, 2, 999);
    { methods }
    if IsFunction then
      met := DefineMethod( dllMethodName, Variables.Count-1, ResultTypeKind, ResultClassRef, DispatchDllCall )
    else
      met := DefineMethod( dllMethodName, Variables.Count, tkNone,  nil, DispatchDllCall );
    { arguments by reference }
    if FByRefArgMask > 0 then
    begin
      for c:=0 to Variables.Count-1 do
        if Variables[c].Modifier=moVar then
          met.SetVarArgs([c]);
    end;
  end;
end;

function TatRoutineInfo.ResultClass: TatClass;
begin
  { retorna a classe correspondente ao ResultTypeDecl }
  result := FResultClass;
end;

function TatRoutineInfo.ResultTypeKind: TatTypeKind;
begin
  { retorna o tipo correspondente ao ResultTypeDecl }
  result := tkVariant;
end;

procedure TatRoutineInfo.DispatchDllCall( AMachine: TatVirtualMachine );
var
  args, argtypes : openarray;
  rettype, vtype : integer;
  result         : variant;
  c, argcount    : integer;
  astr: array of AnsiString;
  {$IFDEF DELPHI2009_LVL}
  ustr: array of UnicodeString;
  {$ENDIF}
begin
{$IFNDEF LINUX}
  if Assigned(ScriptInfo.FScript.FScripter) and ScriptInfo.FScript.FScripter.AllowDLLCalls then
  with AMachine do
  begin
    { converts scripter input arguments to an array of const }
    if IsFunction then
    begin
      argcount := Variables.Count-1;
      rettype := Variables[Variables.Count-1].SystemType;
    end
    else
    begin
      argcount := Variables.Count;
      rettype := vtInteger; // dummy
    end;
    SetLength( args, argcount );
    SetLength( argtypes, argcount );
    SetLength( astr, argcount );
    {$IFDEF DELPHI2009_LVL}
    SetLength( ustr, argcount );
    {$ENDIF}
    try
      for c:=0 to argcount-1 do
      begin
        { creates a TVarRec from the variant that is in the scripter runtime stack, but respects the type declared in the parameter}
        vtype := Variables[c].SystemType;
        argtypes[c].VType := vtInteger;

        { Checks if its by reference or not }
        if Variables[c].Modifier <> moVar then
        begin
          { Parameter NOT by reference }
          argtypes[c].VInteger := vtype mod 100; // uCallDLL uses only standard types declared in System.pas
          args[c].VType := vtype mod 100;
          case vtype of
            vtInteger,
            vtCardinal,
            vtLongword,
            vtLongint:    args[c].VInteger    := GetInputArgAsInteger(c);
            vtBoolean:    args[c].VBoolean    := GetInputArgAsBoolean(c);
            vtByte,
            vtShortInt,
            {$IFDEF DELPHI2009_LVL}
            vtChar:       args[c].VChar       := AnsiChar(GetInputArgAsChar(c));
            {$ELSE}
            vtChar:       args[c].VChar       := GetInputArgAsChar(c);
            {$ENDIF}
            vtExtended:   begin New(args[c].VExtended); args[c].VExtended^ := GetInputArgAsFloat(c); end;
            vtString:     args[c].VString     := PShortString(GetInputArgAsString(c));
            vtPointer:    args[c].VPointer    := Pointer(GetInputArgAsInteger(c));
            {$IFDEF DELPHI2009_LVL}
            vtPChar:
              begin
                {Users must be sure that the string in the parameter is an AnsiString}
                args[c].VPChar := PAnsiChar(GetInputArgAsString(c));
              end;
            {$ELSE}
            vtPChar:      args[c].VPChar      := PChar(GetInputArgAsString(c));
            {$ENDIF}
            vtObject:     args[c].VObject     := TObject(GetInputArgAsInteger(c));
            vtClass:      args[c].VClass      := GetInputArgAsClass(c);
            vtWord,
            vtSmallInt,
            vtWideChar:   args[c].VWideChar   := GetInputArgAsWideChar(c);
            vtPWideChar:  args[c].VPWideChar  := PWideChar(GetInputArgAsString(c));
            vtAnsiString:
              begin
                AStr[c] := AnsiString(GetInputArgAsString(c));
                args[c].VAnsiString := PAnsiString(AStr[c]);
              end;
            {$IFDEF DELPHI2009_LVL}
            vtUnicodeString:
              begin
                ustr[c] := GetInputArgAsString(c);
                args[c].VUnicodeString := PUnicodeString(ustr[c]);
              end;
            {$ENDIF}
            vtCurrency:   begin New(args[c].VCurrency ); args[c].VCurrency^ := GetInputArgAsFloat(c); end;
            vtVariant:    begin New(args[c].VVariant ); args[c].VVariant^ := GetInputArg(c); end;
            vtInterface:  args[c].VInterface  := Pointer( GetInputArgAsInteger(c) );
            vtWideString: args[c].VWideString := PWideChar( GetInputArgAsWideString(c) );
            vtInt64:      begin New(args[c].VInt64); args[c].VInt64^ := GetInputArgAsInteger(c); end;
            vtSingle:     PSingle(@args[c].VInteger)^ := GetInputArgAsFloat(c);
            vtDateTime,
            vtDouble:     begin New(PDouble(args[c].VCurrency)); PDouble(args[c].VCurrency)^ := GetInputArgAsFloat(c); end;
            vtReal:       begin New(PReal(args[c].VCurrency)); PReal(args[c].VCurrency)^ := GetInputArgAsFloat(c); end;
            vtComp:       begin New(PComp(args[c].VCurrency)); PComp(args[c].VCurrency)^ := GetInputArgAsInteger(c); end;
          end;
        end
        else
        begin
          { parameter by reference }
          argtypes[c].VInteger := vtPointer;
          args[c].VType := vtPointer;
          case vtype of
            vtInteger,
            vtCardinal,
            vtLongword,
            vtLongint:    begin New(PInteger(args[c].VPointer)); PInteger(args[c].VPointer)^ := GetInputArgAsInteger(c); end;
            vtBoolean:    begin New(PBoolean(args[c].VPointer)); PBoolean(args[c].VPointer)^ := GetInputArgAsBoolean(c); end;
            vtByte,
            vtShortInt,
            vtChar:       begin New(PChar(args[c].VPointer)); PChar(args[c].VPointer)^ := GetInputArgAsChar(c); end;
            vtExtended:   begin New(PExtended(args[c].VPointer)); PExtended(args[c].VPointer)^ := GetInputArgAsFloat(c); end;
            vtString:     begin New(PString(args[c].VPointer)); PString(args[c].VPointer)^ := GetInputArgAsString(c); end;
            vtPointer:    begin New(PPointer(args[c].VPointer)); PPointer(args[c].VPointer)^ := Pointer(GetInputArgAsInteger(c)); end;
            {$IFDEF DELPHI2009_LVL}
            vtPChar:
              begin
                New(PPAnsiChar(args[c].VPointer));
                astr[c] := AnsiString(GetInputArgAsString(c));
                PPAnsiChar(args[c].VPointer)^ := PAnsiChar(astr[c]);
              end;
            {$ELSE}
            vtPChar:      begin New(PPChar(args[c].VPointer)); PPChar(args[c].VPointer)^ := PChar(GetInputArgAsString(c)); end;
            {$ENDIF}
            vtObject:     begin New(PPointer(args[c].VPointer)); PPointer(args[c].VPointer)^ := TObject(GetInputArgAsInteger(c)); end;
            vtClass:      begin New(PPointer(args[c].VPointer)); PPointer(args[c].VPointer)^ := GetInputArgAsClass(c); end;
            vtWord,
            vtSmallInt,
            vtWideChar:   begin New(PWideChar(args[c].VPointer)); PWideChar(args[c].VPointer)^ := GetInputArgAsWideChar(c); end;
            vtPWideChar:  begin New(PPointer(args[c].VPointer)); PPointer(args[c].VPointer)^ := PWideChar(GetInputArgAsString(c)); end;
            vtAnsiString:
              begin
                astr[c] := AnsiString(GetInputArgAsString(c));
                PPointer(args[c].VPointer)^ := PAnsiString(astr[c]);
              end;
            vtCurrency:   begin New(PCurrency(args[c].VPointer)); PCurrency(args[c].VPointer)^ := GetInputArgAsFloat(c); end;
            vtVariant:    begin New(PVariant(args[c].VPointer)); PVariant(args[c].VPointer)^ := GetInputArg(c); end;
            vtInterface:  begin New(PPointer(args[c].VPointer)); PPointer(args[c].VPointer)^ := Pointer(GetInputArgAsInteger(c)); end;
            vtWideString: begin New(PPointer(args[c].VPointer)); PPointer(args[c].VPointer)^ := PWideChar(GetInputArgAsWideString(c)); end;
            {$IFDEF DELPHI2009_LVL}
            vtUnicodeString:
              begin
                ustr[c] := GetInputArgAsString(c);
                PPointer(args[c].VPointer)^ := PUnicodeString(ustr[c]);
              end;
            {$ENDIF}
            vtInt64:      begin New(PInt64(args[c].VPointer)); PInt64(args[c].VPointer)^ := GetInputArgAsInteger(c); end;
            vtSingle:     begin New(PSingle(args[c].VPointer)); PSingle(args[c].VPointer)^ := GetInputArgAsFloat(c); end;
            vtDateTime,
            vtDouble:     begin New(PDouble(args[c].VPointer)); PDouble(args[c].VPointer)^ := GetInputArgAsFloat(c); end;
            vtReal:       begin New(PReal(args[c].VPointer)); PReal(args[c].VPointer)^ := GetInputArgAsFloat(c); end;
            vtComp:       begin New(PComp(args[c].VPointer)); PComp(args[c].VPointer)^ := GetInputArgAsInteger(c); end;
          end;
        end;
      end;

      { builds parameter structure and call the function (uCallDLL.pas) }
      result := CallDllFunction(
        ExternalDll,
        ExternalName,
        args,
        argtypes,
        rettype mod 100 { standard types (System.pas) },
        TCallingConvention(CallingConvention) );

      { returns function result to scripter }
      if IsFunction then
        ReturnOutputArg( result );

    finally
      { frees variable allocated dynamically }
      for c:=argcount-1 downto 0 do
        if Variables[c].Modifier <> moVar then
          { frees allocated memory for the parameter frame of the external call }
          case Variables[c].SystemType of
            vtExtended: Dispose( args[c].VExtended );
            vtCurrency: Dispose( args[c].VCurrency );
            vtVariant:  Dispose( args[c].VVariant );
            vtInt64:    Dispose( args[c].VInt64 );
            vtDateTime,
            vtDouble:   Dispose( PDouble(args[c].VCurrency) );
            vtReal:     Dispose( PReal(args[c].VCurrency) );
            vtComp:     Dispose( PComp(args[c].VCurrency) );
        end
        else
        begin
          { modifes the scripter variable which was passed by reference and frees the memory }
          case Variables[c].SystemType of
            vtInteger,
            vtCardinal,
            vtLongword,
            vtLongint:    begin SetInputArg(c,PInteger(args[c].VPointer)^); Dispose( PInteger(args[c].VPointer) ); end;
            vtBoolean:    begin SetInputArg(c,PBoolean(args[c].VPointer)^); Dispose( PBoolean(args[c].VPointer) ); end;
            vtByte,
            vtShortInt,
            vtChar:       begin SetInputArg(c,PChar(args[c].VPointer)^); Dispose( PChar(args[c].VPointer) ); end;
            vtExtended:   begin SetInputArg(c,PExtended(args[c].VPointer)^); Dispose( PExtended(args[c].VPointer) ); end;
            vtString:     begin SetInputArg(c,PString(args[c].VPointer)^); Dispose( PString(args[c].VPointer) ); end;
            {$IFDEF DELPHI2009_LVL}
            vtPChar:      begin SetInputArg(c,integer(PPAnsiChar(args[c].VPointer)^)); Dispose( PPAnsiChar(args[c].VPointer) ); end;
            {$ELSE}
            vtPChar:      begin SetInputArg(c,string(PPChar(args[c].VPointer)^)); Dispose( PPChar(args[c].VPointer) ); end;
            {$ENDIF}
            vtPointer,
            vtObject,
            vtClass:      begin SetInputArg(c,PInteger(args[c].VPointer)^); Dispose( PPointer(args[c].VPointer) ); end;
            vtWord,
            vtSmallInt,
            vtWideChar:   begin SetInputArg(c,PWideChar(args[c].VPointer)^); Dispose( PWideChar(args[c].VPointer) ); end;
            vtPWideChar:  begin SetInputArg(c,PInteger(args[c].VPointer)^); Dispose( PPointer(args[c].VPointer) ); end;
            vtAnsiString: begin SetInputArg(c,Astr[c]); end;
            {$IFDEF DELPHI2009_LVL}
            vtUnicodeString: begin SetInputArg(c,ustr[c]); end;
            {$ENDIF}
            vtCurrency:   begin SetInputArg(c,PCurrency(args[c].VPointer)^); Dispose( PCurrency(args[c].VPointer) ); end;
            vtVariant:    begin SetInputArg(c,PVariant(args[c].VPointer)^); Dispose( PVariant(args[c].VPointer) ); end;
            vtInterface,
            vtWideString: begin SetInputArg(c,PInteger(args[c].VPointer)^); Dispose( PPointer(args[c].VPointer) ); end;
            vtInt64:      begin SetInputArg(c,Integer(PInt64(args[c].VPointer)^)); Dispose( PInt64(args[c].VPointer) ); end;
            vtSingle:     begin SetInputArg(c,PSingle(args[c].VPointer)^); Dispose( PSingle(args[c].VPointer) ); end;
            vtDateTime,
            vtDouble:     begin SetInputArg(c,PDouble(args[c].VPointer)^); Dispose( PDouble(args[c].VPointer) ); end;
            vtReal:       begin SetInputArg(c,PReal(args[c].VPointer)^); Dispose( PReal(args[c].VPointer) ); end;
            vtComp:       begin SetInputArg(c,PComp(args[c].VPointer)^); Dispose( PComp(args[c].VPointer) ); end;
          end;
        end;
    end;
  end else
    RaiseRuntimeError(Format('Cannot call external function "%s". DLL calls not allowed in scripter.', [Name]));
{$ENDIF}
end;

function TatRoutineInfo.GetResultTypeDecl: string;
begin
  result := FResultTypeDecl;
end;

procedure TatRoutineInfo.SetResultTypeDecl(const Value: string);
begin
  FResultTypeDecl := Value;
  SetTypeFromString(FResultTypeDecl);
end;

procedure TatRoutineInfo.SetTypeFromString(ATypeStr:string);
begin
  { tries to define the system type based on the string }

  { if it's a class, then set the result class for scripter }
  if (ScriptInfo <> nil) and (ScriptInfo.Script <> nil) and (ScriptInfo.Script.Scripter <> nil) then
    FResultClass := ScriptInfo.Script.Scripter.Classes.ClassByName(ATypeStr);

  { Choose one of system types based on the string (System.pas) }
  //PullSystemType;
end;

function TatRoutineInfo.ResultClassRef: TClass;
begin
  if FResultClass <> nil then
    result := FResultClass.ClassRef
  else
    result := nil;
end;

(*procedure TatRoutineInfo.PullSystemType;
var
  s: string;
begin
  { descobre o tipo da vari�vel com base em sua declara��o }
  { alguns tipos n�o padr�o est�o sendo tratados como padr�o porque seu tamanho � o mesmo de outros padr�o (ex: byte, word, double, ...) }
  s := LowerCase(FResultTypeDecl);
  if s = 'integer'     then FSystemType := vtInteger    else
  if s = 'boolean'     then FSystemType := vtBoolean    else
  if s = 'char'        then FSystemType := vtChar       else
  if s = 'extended'    then FSystemType := vtExtended   else
  if s = 'shortstring' then FSystemType := vtString     else
  if s = 'pointer'     then FSystemType := vtPointer    else
  if s = 'pchar'       then FSystemType := vtPChar      else
  if s = 'tobject'     then FSystemType := vtObject     else
  if s = 'class'       then FSystemType := vtClass      else
  if s = 'widechar'    then FSystemType := vtWideChar   else
  if s = 'pwidechar'   then FSystemType := vtPWideChar  else
  if s = 'ansistring'  then FSystemType := vtAnsiString else
  if s = 'currency'    then FSystemType := vtCurrency   else
  if s = 'variant'     then FSystemType := vtVariant    else
  if s = 'interface'   then FSystemType := vtInterface  else
  if s = 'widestring'  then FSystemType := vtWideString else
  if s = 'int64'       then FSystemType := vtInt64      else
  if s = 'longint'     then FSystemType := vtLongint    else
  if s = 'cardinal'    then FSystemType := vtCardinal   else
  if s = 'longword'    then FSystemType := vtLongword   else
  if s = 'single'      then FSystemType := vtSingle     else
  if s = 'byte'        then FSystemType := vtByte       else
  if s = 'shortint'    then FSystemType := vtShortint   else
  if s = 'word'        then FSystemType := vtWord       else
  if s = 'smallint'    then FSystemType := vtSmallint   else
  if s = 'string'      then FSystemType := vtAnsiString else
  if s = 'double'      then FSystemType := vtDouble     else
  if s = 'real'        then FSystemType := vtReal       else
  if s = 'tdatetime'   then FSystemType := vtDatetime   else
  if s = 'comp'        then FSystemType := vtComp       else
  if Assigned(FDeclaredClass) then FSystemType := vtObject else
    { tipo n�o suportado. Ex: array of, record of, set of, objeto desconhecido, etc. }
    FSystemType := -1;
end;*)

function TatRoutineInfo.Internal: boolean;
begin
  result := (Length(FName) > 0) and (FName[1] = '#');
end;

{ TatVariablesInfo }

function TatVariablesInfo.GetItem(i:integer):TatVariableInfo;
begin
   result:=TatVariableInfo( inherited Items[i] );
end;

function TatVariablesInfo.Add:TatVariableInfo;
begin
   result:=TatVariableInfo( inherited Add );
end;

function TatVariablesInfo.IndexOf(AName:string):integer;
begin
   { pesquisa de traz pra frente para permitir redeclara��o (sobrecarga do result) }
   for result:=Count-1 downto 0 do
      if CompareText(Items[result].FVarName,AName)=0 then Exit;
   result:=-1;
end;

function TatVariablesInfo.FindByName(AName:string):TatVariableInfo;
var i: integer;
begin
   i:=IndexOf(AName);
   if i>-1 then
      result:=Items[i]
   else
      result:=nil;
end;

{ TatVariableInfo }

function TatVariableInfo.Script: TatScript;
begin
  result := TatRoutinesInfo(Routine.Collection).FScriptInfo.FScript;
end;

function TatVariableInfo.Routine:TatRoutineInfo;
begin
  result := TatRoutineInfo(TatVariablesInfo(Collection).GetOwner);
  if TObject(result) is TatScriptInfo then
    result := TatScriptInfo(result).MainRoutine;
end;

function TatVariableInfo.GetValue:variant;
begin
  if Global then
  begin
    if Assigned(Script.VirtualMachine) then
    begin
      if not Script.VirtualMachine.FInitialized then
        Script.VirtualMachine.InitializeScript(true);
      result := Script.VirtualMachine.FProcStack[VarIndex];
    end;
  end
  else
  begin
    if Assigned(Script.VirtualMachine) and Assigned(Script.VirtualMachine.FPrepareInstruction ) then
       with Script.VirtualMachine.FPrepareInstruction^ do
          if (Opcode=inPrepare) and (CompareText(vString, Routine.Name)=0) then
             result:=Script.VirtualMachine.FProcStack[Script.VirtualMachine.FStackBase+VarIndex]
          else
             ScriptInfoError(Format('Variable ''%s'' of routine ''%s'' is not available during execution of routine ''%s''',[FVarName,Routine.Name,vString]))
    else
       ScriptInfoError(Format('Variable ''%s'' is only available while routine ''%s'' is running',[FVarName,Routine.Name]));
  end;
end;

procedure TatVariableInfo.SetValue(AValue:variant);
begin
  if Global then
  begin
    if Assigned(Script.VirtualMachine) then
    begin
      if not Script.VirtualMachine.FInitialized then
        Script.VirtualMachine.InitializeScript(true);
      Script.VirtualMachine.FProcStack[VarIndex] := AValue;
    end;
  end else
  begin
    if Assigned(Script.VirtualMachine) and Assigned(Script.VirtualMachine.FPrepareInstruction) then
       with Script.VirtualMachine.FPrepareInstruction^ do
          if (Opcode=inPrepare) and (CompareText(vString,Routine.Name)=0) then
             Script.VirtualMachine.FProcStack[Script.VirtualMachine.FStackBase+VarIndex] := AValue
          else
             ScriptInfoError(Format('Variable ''%s'' is not available during execution of routine ''%s''',[FVarName,Routine.Name]))
    else
       ScriptInfoError(Format('Variable ''%s'' is only available while routine ''%s'' is running',[FVarName,Routine.Name]));
  end;
end;

function TatVariableInfo.Internal: boolean;
begin
  { Retorna True para vari�veis internamente declaradas no script.
    Por exemplo: para o FOR, CASE e  WITH }
  result := (Length(FVarName)>0) and (FVarName[1]='#');
end;

function TatVariableInfo.VarIndex: integer;
begin
   { retorna o �ndice de runtime da vari�vel
     (os argumentos de entrada tem �ndices negativos e s�o declarados
      na mesma ordem em que foram passados na chamada � subrotina) }
   if FGlobal then
     result := Index
   else
     result := Index - Routine.ArgCount;
end;

procedure TatVariableInfo.SetTypeFromString(ATypeStr:string);
begin
  { tenta definir o tipo da vari�vel atrav�s da string dada que representa o
    nome do tipo da vari�vel }

  { se o tipo � uma classe ent�o armazena uma refer�ncia para a classe do scripter }
  FDeclaredClass := ScriptInfo.Script.Scripter.Classes.ClassByName(ATypeStr);

  { assume um dos tipos padr�o para a vari�vel (System.pas) }
  PullSystemType;
end;

function TatVariableInfo.ScriptInfo: TatScriptInfo;
begin
  result := TatScriptInfo( TatVariablesInfo(Collection).GetOwner );
  if TObject(result) is TatRoutineInfo then
    result := TatRoutineInfo( result ).ScriptInfo;
end;

constructor TatVariableInfo.Create(ACollection: TCollection);
begin
  inherited;
  FVisibility := vvPublic;
end;

procedure TatVariableInfo.Assign(ASource: TPersistent);
begin
  FVarName                := TatVariableInfo(ASource).FVarName;
  FDeclarationSourcePos   := TatVariableInfo(ASource).FDeclarationSourcePos;
  FArgIndex               := TatVariableInfo(ASource).FArgIndex;
  FModifier               := TatVariableInfo(ASource).FModifier;
  FDeclaredClass          := TatVariableInfo(ASource).FDeclaredClass;
  FGlobal                 := TatVariableInfo(ASource).FGlobal;
end;

function TatVariableInfo.SameDeclaration(AVariable: TatVariableInfo): boolean;
begin
  result := SameText(VarName,AVariable.VarName) and
            (ArgIndex = AVariable.ArgIndex) and
            (Modifier = AVariable.Modifier) and
            (DeclaredClass = AVariable.DeclaredClass);
end;

function TatVariableInfo.GetDeclaredClassName: string;
begin
  if DeclaredClass <> nil then
    result := DeclaredClass.Name
  else
    result := '';
end;

procedure TatVariableInfo.SetDeclaredClassName(const Value: string);
begin
  SetTypeFromString(Value);
end;

procedure TatVariableInfo.PullSystemType;
var s: string;
begin
  { descobre o tipo da vari�vel com base em sua declara��o }
  { alguns tipos n�o padr�o est�o sendo tratados como padr�o porque seu tamanho � o mesmo de outros padr�o (ex: byte, word, double, ...) }
  s := LowerCase(FTypeDecl);
  if s = 'integer'     then FSystemType := vtInteger    else
  if s = 'boolean'     then FSystemType := vtBoolean    else
  if s = 'char'        then FSystemType := vtChar       else
  if s = 'extended'    then FSystemType := vtExtended   else
  if s = 'shortstring' then FSystemType := vtString     else
  if s = 'pointer'     then FSystemType := vtPointer    else
  {$IFDEF DELPHI2009_LVL}
  if s = 'pchar'       then FSystemType := vtPWideChar  else
  {$ELSE}
  if s = 'pchar'       then FSystemType := vtPChar      else
  {$ENDIF}
  if s = 'pansichar'   then FSystemType := vtPChar      else
  if s = 'tobject'     then FSystemType := vtObject     else
  if s = 'class'       then FSystemType := vtClass      else
  if s = 'widechar'    then FSystemType := vtWideChar   else
  if s = 'pwidechar'   then FSystemType := vtPWideChar  else
  if s = 'ansistring'  then FSystemType := vtAnsiString else
  if s = 'currency'    then FSystemType := vtCurrency   else
  if s = 'variant'     then FSystemType := vtVariant    else
  if s = 'interface'   then FSystemType := vtInterface  else
  if s = 'widestring'  then FSystemType := vtWideString else
  if s = 'int64'       then FSystemType := vtInt64      else
  if s = 'longint'     then FSystemType := vtLongint    else
  if s = 'cardinal'    then FSystemType := vtCardinal   else
  if s = 'longword'    then FSystemType := vtLongword   else
  if s = 'single'      then FSystemType := vtSingle     else
  if s = 'byte'        then FSystemType := vtByte       else
  if s = 'shortint'    then FSystemType := vtShortint   else
  if s = 'word'        then FSystemType := vtWord       else
  if s = 'smallint'    then FSystemType := vtSmallint   else
  {$IFDEF DELPHI2009_LVL}
  if s = 'string'      then FSystemType := vtUnicodeString else
  {$ELSE}
  if s = 'string'      then FSystemType := vtAnsiString else
  {$ENDIF}
  if s = 'double'      then FSystemType := vtDouble     else
  if s = 'real'        then FSystemType := vtReal       else
  if s = 'tdatetime'   then FSystemType := vtDatetime   else
  if s = 'comp'        then FSystemType := vtComp       else
  if Assigned(FDeclaredClass) then FSystemType := vtObject else
    { tipo n�o suportado. Ex: array of, record of, set of, objeto desconhecido, etc. }
    FSystemType := -1;
end;

{ TatClassRefs }

function TatClassRefs.Add(AClassIndex, AElementIndex: integer;
  AElementIsMethod: boolean; AClassName, AElementName: string): TatClassRef;
begin
   result:=TatClassRef( inherited Add );
   with result do
   begin
      FClassIndex := AClassIndex;
      FElementIndex := AElementIndex;
      FElementIsMethod := AElementIsMethod;
      FClassName := AClassName;
      FElementName := AElementName;
   end;
end;

constructor TatClassRefs.Create(AScript: TatScript);
begin
   FScript := AScript;
   inherited Create( TatClassRef );
end;

function TatClassRefs.GetItem(i: integer): TatClassRef;
begin
   result:=TatClassRef( inherited Items[i] );
end;

{ TatClassRef }

procedure TatClassRef.CheckLoaded;
var
  AClass: TatClass;
  AMethod: TatMethod;
  AProperty: TatProperty;
begin
   try
      with TatClassRefs(Collection).FScript do
      begin
         AClass := _FindClass(FClassIndex, FClassName);
         if FElementIsMethod then
         begin
            AMethod := _FindMethod(AClass, FElementIndex, FElementName);
            Scripter.FClasses.CheckLoaded(AMethod.FResultClass, AMethod.FResultClassName);
         end
         else
         begin
            AProperty := _FindProperty(AClass, FElementIndex, FElementName);
            Scripter.FClasses.CheckLoaded(AProperty.FPropertyClass, AProperty.FPropertyClassName);
         end;
      end;
   except
      on ex: Exception do
         InternalError('Error loading implicit class reference.'#13#10+ex.message);
   end;
end;

{ TatScripterLibrary }

constructor TatScripterLibrary.Create(AScripter: TatCustomScripter);
begin
  FScripter:=AScripter;
end;

class function TatScripterLibrary.LibraryName: string;
begin
  { assume a default library name equal to the class name (excluding intial 'T') }
  if UpperCase(Copy(ClassName,1,1))='T' then
    result := Copy(ClassName,2,MaxInt)
  else
    result := ClassName;
end;

procedure TatScripterLibrary.Finalize;
begin
end;

procedure TatScripterLibrary.SelfProc( AMachine: TatVirtualMachine );
begin
  AMachine.ReturnOutputArg( integer(Self) );
end;

{ TatLibraryList }

function TatLibraryList.Add: TatLibraryListItem;
begin
   result:=TatLibraryListItem(inherited Add);
end;

function TatLibraryList.FindByLibraryName(ALibName: string): TatLibraryListItem;
var c: integer;
begin
  for c:=0 to Count-1 do
    if SameText(ALibName, Items[c].LibraryClass.LibraryName) then
    begin
      result := Items[c];
      Exit;
    end;
  result := nil;
end;

function TatLibraryList.GetItem(Index: integer): TatLibraryListItem;
begin
   result:=TatLibraryListItem(inherited Items[Index]);
end;

procedure TatLibraryList.Remove(ALibrary: TatScripterLibraryClass);
Var c: integer;
begin
   for c:=0 to Count-1 do
      if ALibrary=Items[c].LibraryClass then
      begin
         Items[c].Free;
         Exit;
      end;
end;

{ TatLibraryListItem }

procedure TatLibraryListItem.Assign(Source: TPersistent);
begin
  if Source is TatLibraryListItem then
  begin
     FLibraryClass:=TatLibraryListItem(Source).FLibraryClass;
  end else
     inherited Assign(Source);
end;

procedure RegisterScripterLibrary(ALibrary: TatScripterLibraryClass; AExplicitLoad: boolean=false);
begin
  With atLibraryList.Add do
  begin
     FLibraryClass := ALibrary;
     FExplicitLoad := AExplicitLoad;
  end;
end;

procedure UnRegisterScripterLibrary(ALibrary: TatScripterLibraryClass);
begin
  atLibraryList.Remove(ALibrary);
end;

{ TatRecordWrapper }

function TatRecordWrapper.GetObjectReference: TObject;
begin
   result:=self;
end;

{ TatScriptBreakPoints }

constructor TatScriptBreakPoints.Create(AMachine:TatVirtualMachine);
begin
   FMachine:=AMachine;
   inherited Create(TatScriptBreakPoint);
end;

function TatScriptBreakPoints.GetItem(i: integer): TatScriptBreakPoint;
begin
   result:=TatScriptBreakPoint( inherited Items[i] );
end;

function TatScriptBreakPoints.RemoveBreakPoint( ATargetInst: pSimplifiedCode):boolean;
begin
   if Assigned(ATargetInst) then
   begin
      { ao tentar remover um BreakPoint de uma instru��o Prepare, usa a
        instru��o subsequente porque em Prepare n�o se pode inserir BreakPoint }
      if (ATargetInst^.OpCode=inPrepare) then
         if Assigned(ATargetInst^.Next) and (ATargetInst^.vDebugInfo and $FFFFF=ATargetInst^.Next^.vDebugInfo and $FFFFF) then
            ATargetInst:=ATargetInst^.Next
         else
         begin
            result:=false;
            Exit;
         end;
      if ATargetInst^.OpCode=inBreakPoint then
      begin
         Delete( TatScriptBreakPoint(ATargetInst^.vInteger).Index );
         result:=true;
      end
      else
         result:=false;
   end
   else
      result:=false;
end;

function TatScriptBreakPoints.InsertNormalBreak( ATargetInst: pSimplifiedCode): TatScriptBreakPoint;
begin
   if Assigned(ATargetInst) then
   begin
      { n�o permite inserir Break em instru��o Prepare }
      if ATargetInst^.OpCode=inPrepare then
         if Assigned(ATargetInst^.Next) and (ATargetInst^.vDebugInfo and $FFFFF=ATargetInst^.Next^.vDebugInfo and $FFFFF) then
            ATargetInst:=ATargetInst^.Next
         else
         begin
            result:=nil;
            Exit;
         end;
      { insere uma parada na instru��o indicada (ver _BreakPoint) }
      result:=TatScriptBreakPoint(inherited Add);
      result.SetBreakInst(ATargetInst);
   end
   else
      result:=nil;
end;

function TatScriptBreakPoints.InsertTempBreak( ATargetInst: pSimplifiedCode): TatScriptBreakPoint;
begin
   result := InsertNormalBreak(ATargetInst);
   if result <> nil then
     result.FBreakInst^.vProc := result.TemporaryBreakProc;
end;

function TatScriptBreakPoints.BreakPointByLine(ALine: integer): TatScriptBreakPoint;
var c: integer;
begin
   for c:=0 to Count-1 do
      if Items[c].FOriginalInst.vDebugInfo and $FFFFF=ALine then
      begin
         result:=Items[c];
         Exit;
      end;
   result:=nil;
end;

function TatScriptBreakPoints.Add: TatScriptBreakPoint;
begin
  result := TatScriptBreakPoint(inherited Add);
end;

{ TatScriptBreakPoint }

constructor TatScriptBreakPoint.Create(Collection: TCollection);
begin
  inherited;
  FPassCount := 0;
  FEnabled := true;
  FAutoDestroy := false;
  FNotifyBreak := nil;
end;

destructor TatScriptBreakPoint.Destroy;
begin
  RemoveBreak;
  if FNotifyBreak <> nil then
  begin
    FNotifyBreak.BreakPointDestroyed(Self);
    FNotifyBreak := nil;
  end;
  inherited;
end;

procedure TatScriptBreakPoint.TemporaryBreakProc;
begin
   { BreakPoint falso criado pelo DebugRunToLine }
   with Machine do
   begin
      { paraliza a execu��o do processamento }
      Paused := true;
      { elimina automaticamente esta paraliza��o,
        restaurando todo o conte�do original do FCurrentInstruction }

      RemoveBreak;

      { sets next instruction so that original instruction is executed }
      FNextInstruction := FCurrentInstruction;

      Free;
   end;
end;

procedure TatScriptBreakPoint.NormalBreakProc;
begin
   { BreakPoint normal do usu�rio }
   with Machine do
   begin
      { registra o n�mero de vezes que a execu��o passou por esta paraliza��o }
      inc( TatScriptBreakPoint(FCurrentInstruction^.vInteger).FPassCount );
      { paraliza a execu��o do processamento }
      Paused := true;

      Machine.Script.DoBreakpointStop;
   end;
end;

{ debugger functions }

function TatCustomScripter.InstructionByLine(ARow: integer): pSimplifiedCode;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.InstructionByLine(ARow)
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

function TatCustomScripter.EntryPoint(
  ALabel: string): pSimplifiedCode;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.EntryPoint(ALabel)
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

procedure TatCustomScripter.DebugTraceInto;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.DebugTraceInto
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.DebugStepOver;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.DebugStepOver
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.DebugTraceIntoLine;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.DebugTraceIntoLine
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.DebugStepOverLine;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.DebugStepOverLine
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.DebugRunUntilReturn;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.DebugRunUntilReturn
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.DebugRunToPoint(AInstruction:pSimplifiedCode);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.DebugRunToPoint(AInstruction)
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.DebugRunToLine(ALine:integer);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.DebugRunToLine(ALine)
   else
      InternalError('Default script is not available');
end;

function TatCustomScripter.DebugToggleBreakPoint(AInstruction:pSimplifiedCode):boolean;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.DebugToggleBreakPoint(AInstruction)
   else
   begin
      InternalError('Default script is not available');
      result:=false;
   end;
end;

function TatCustomScripter.DebugToggleBreakLine(ALine:integer):pSimplifiedCode;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.DebugToggleBreakLine(ALine)
   else
   begin
      InternalError('Default script is not available');
      result:=nil;
   end;
end;

function TatCustomScripter.DebugExecutionLine: integer;
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      result:=FCurrentScript.VirtualMachine.DebugExecutionLine
   else
   begin
      InternalError('Default script is not available');
      result:=-1;
   end;
end;

procedure TatCustomScripter.SetRunning(const Value: boolean);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.SetRunning(Value)
   else
      InternalError('Default script is not available');
end;

procedure TatCustomScripter.SetPaused(const Value: boolean);
var
  c: integer;
begin
  for c := 0 to Scripts.Count - 1 do
    Scripts[c].VirtualMachine.FPaused := Value;
  if Running then
    SingleDebugHook(CurrentScript.VirtualMachine);
end;

procedure TatCustomScripter.SetCallExecHookEvent(const Value: boolean);
begin
   if Assigned(FCurrentScript.VirtualMachine) then
      FCurrentScript.VirtualMachine.CallExecHookEvent := Value
   else
      InternalError('Default script is not available');
end;

(*function TatScriptBreakPoint.GetBreakLine: integer;
begin
  result := FOriginalInst.vDebugInfo and $FFFFF;
end;*)

function TatScriptBreakPoint.Machine: TatVirtualMachine;
begin
  if Collection is TatScriptBreakPoints then
    result := TatscriptBreakPoints(Collection).FMachine
  else
    result := nil;
end;

procedure TatScriptBreakPoint.RemoveBreak;
begin
  { remove break point, restoring original instruction }
  if Assigned(FBreakInst) then
  begin
    FBreakInst^.OpCode := FOriginalInst.OpCode;
    FBreakInst^.vByte := FOriginalInst.vByte;
    FBreakInst^.vSmallInt := FOriginalInst.vSmallInt;
    FBreakInst^.vInteger := FOriginalInst.vInteger;
    FBreakInst^.vInteger1 := FOriginalInst.vInteger1;
    FBreakInst^.vString := FOriginalInst.vString;
    FBreakInst^.vDebugInfo := FOriginalInst.vDebugInfo;
    FBreakInst^.Next := FOriginalInst.Next;
    FBreakInst^.Compute := FOriginalInst.Compute;
    FBreakInst^.vProc := FOriginalInst.vProc;
    FBreakInst^.vString2 := FOriginalInst.vString2;

    with Machine do
      if FNextInstruction = @OriginalInst then
        FNextInstruction := FBreakInst;

    FBreakInst := nil;
  end;
end;

procedure TatScriptBreakPoint.SetBreakinst(ATargetInst: pSimplifiedCode);
begin
  {Remove a breakpoint if it exists}
  RemoveBreak;

  FBreakInst := ATargetInst;

  { Save original instruction in an internal copy }
  FOriginalInst.OpCode := FBreakInst^.OpCode;
  FOriginalInst.vByte := FBreakInst^.vByte;
  FOriginalInst.vSmallInt := FBreakInst^.vSmallInt;
  FOriginalInst.vInteger := FBreakInst^.vInteger;
  FOriginalInst.vInteger1 := FBreakInst^.vInteger1;
  FOriginalInst.vString := FBreakInst^.vString;
  FOriginalInst.vDebugInfo := FBreakInst^.vDebugInfo;
  FOriginalInst.Next := FBreakInst^.Next;
  FOriginalInst.Compute := FBreakInst^.Compute;
  FOriginalInst.vProc := FBreakInst^.vProc;
  FOriginalInst.vString2 := FBreakInst^.vString2;

  { modify original instruct so it become a break instruction }
  with FBreakInst^ do
  begin
    { change some fields and keep other ones the same }
    OpCode := inBreakPoint;
    Compute := Machine.FComputeProcs[inBreakPoint];
    vInteger := integer(Self);
    vProc := NormalBreakProc;
    Next := @FOriginalInst;
  end;
end;

{ TatObject }

procedure TatObject.Assign(ASource: TPersistent);
begin
   Name          := TatObject(ASource).Name;
   Instance      := TatObject(ASource).Instance;
   atClass := TatObject(ASource).atClass;
end;

procedure TatObject.SeTatClass(const Value: TatClass);
begin
   FatClass := TatObjects(Collection).FClasses.ClassByName(Value.Name);
   if not Assigned(FatClass) then
      DefinitionError(Format('Undefined default instance class ''%s''',[Value.Name]));
end;

{ TatDataDef }

procedure TatDataDef.Assign(ASource: TPersistent);
begin
   Name     := TatDataDef(ASource).Name;
   DataType := TatDataDef(ASource).DataType;
   Modifier := TatDataDef(ASource).Modifier;
end;

{ TatScripts }

function TatScripts.Add: TatScript;
begin
  if (FScripter <> nil) and (FScripter.DefaultScriptClass <> nil) then
    result := FScripter.DefaultScriptClass.Create(Self)
  else
    result := TatScript( inherited Add );
end;

constructor TatScripts.Create(AScripter:TatCustomScripter);
begin
   FScripter := AScripter;
   if not Assigned(AScripter.FScriptClass) then
      AScripter.FScriptClass:=TatScript;
   inherited Create(AScripter.FScriptClass);
end;

function TatScripts.FindByUnitName(AUnitName: string): TatScript;
var
  c: integer;
begin
  result := nil;
  for c := 0 to Count - 1 do
    if SameText(AUnitName, Items[c].UnitName) then
    begin
      result := Items[c];
      exit;
    end;
end;

function TatScripts.GetItem(i: integer): TatScript;
begin
   result := TatScript( inherited Items[i] );
end;

{ TatScript }

constructor TatScript.Create(ACollection: TCollection);
begin
   FScripter:=TatScripts(ACollection).FScripter;
   inherited Create(ACollection);

   FDerivedScripts := TObjectList.Create(false);
   FBreaks := TatScriptBreaks.Create(Self, TatScriptBreak);
   FCodeStream := TMemoryStream.Create;

   {Create Refactor}
   FRefactor := FRefactorClass.Create(Self);

   { initialize fields }
   FLibraries := TList.Create;

   { cria o objeto para armazenar informa��es de depura��o }
   FScriptInfo := TatScriptInfo.Create(nil);
   FScriptInfo.FScript := Self;

   FSourceCode:=TStringList.Create;
   TStringList(FSourceCode).OnChange:=SourceCodeChange;

   { cria uma SyntaxParser para uso no compilador }
   FParser:=TatSyntaxParser.Create(nil);

   { cria a m�quina virtual para execu��o de scripts }
   FVirtualMachines := TatVirtualMachines.Create(Self,Scripter.FMachineClass);
   FVirtualMachine := FVirtualMachines.Add;

   FUsedUnits := TatUsedUnits.Create(Scripter);
   FRollbackSourceCode := false;

   FDefInstances := TatObjects.Create(Scripter.FClasses);
   FIntInstance := FDefInstances.Add( TatInternalObject.Create );
end;

destructor TatScript.Destroy;
begin
   {if the script was derived from another script (form), then emove the script itself
   from the list of derived scripts of base (original) script}
  SetOriginalScript(nil);

  {if the script is a base (original) script, then iterate through all derived scripts
   and notify them that the original script is not valid anymore (it's destroyed, so it
   must be set to nil. We don't need to remove the items in FDerivedScripts list, because
   when we set originalscript to nil, the derivedscript automatically removes itself
   from the FCreateList of base script.
   Note that this code should never be executed in normal ways, because it doesn't make
   sense to destroy the base script while there are derived scripts still running}
  while FDerivedScripts.Count > 0 do
    TatScript(FDerivedScripts[0]).SetOriginalScript(nil);

  FDerivedScripts.Free;

  {Set runscript to nil}
  if (FOriginalForm <> nil) and not (csDestroying in FOriginalForm.ComponentState) then
    FOriginalForm.FRunScript := nil;

  FBreaks.Free;
  FCodeStream.Free;

  if Assigned(FOnDestroy) then
    { permite que o propriet�rio possa ser notificado sobre a destrui��o desse script }
    FOnDestroy(Self);
  //RemoveAttachedEvents;
  Clear;
  FLibraries.Free;
  FUsedUnits.Free;
  FUsedUnits := nil;
  FVirtualMachines.Free;
  FParser.Free;
  FSourceCode.Free;
  FScriptInfo.Free;
  FIntInstance.Instance.Free;
  FDefInstances.Free;
  if FScriptForm <> nil then
  begin
    FScriptForm.Free;
    FScriptForm := nil;
  end;
  FRefactor.Free;
  inherited;
end;

procedure TatScript.RemoveAttachedEvents(RemoveAll: boolean);
var
  c: integer;
  total: integer;
begin
 with Scripter.EventBroker do
 begin
   c := 0;
   while c < Dispatchers.Count do
   begin
     total := Dispatchers.Count;
     if Dispatchers[c].Script = Self then
     begin
       if (ScriptInfo.RoutineByName(Dispatchers[c].RoutineName) <> nil) or RemoveAll then
         Dispatchers[c].Unset;
     end;
     if total = Dispatchers.Count then
       inc(c);
   end;
 end;
end;

procedure TatScript.Clear;
var st : TStackType;
    c : integer;
begin
  {Avoid stack overflow}
  if not FClearingScript then
  begin
    FClearingScript := true;
    try
      if VirtualMachine.Running then
         FatalError('Cannot clear script while script is running.');

      if not FCompiling and (FRefactoring = 0) then
        RemoveAttachedEvents(true);

      { descarrega as DLL que j� foram carregadas para este script }
      if FLoadedDLL then
        DisposeDLL;

      { INICIALIZA VARI�VEIS E ESTRUTURAS PARA GERAR C�DIGO }

      {Unregister this script whenever it is registered as a library}
      while FLibraries.Count > 0 do
        SelfUnregisterAsLibrary(TatScriptBasedLibrary(FLibraries[0]).Scripter);

      {Unregister the form, if it was registered. It must be called *after* selfunregisteraslibrary,
       because the latter destroys some methods registered in the form class. If the form class is removed
       before, we get some AV when SelfUnregisterLibrary tries to remove those methods}
      UnregisterForm;

      { limpa as informa��es de depura��o se n�o estiver em um script do debugger }
      if not FIsDebugScript then
        FScriptInfo.Clear;

      { leave only one virtual machine, and then clears it. Virtual machine cleaning must
        be *before* disposing p-code (DisposeCode below), due to internal breakpoints }
      for c:=FVirtualMachines.Count-1 downto 1 do
        FVirtualMachines[c].Free;
      FVirtualMachine := FVirtualMachines[0];
      FVirtualMachine.Clear;

      ClearLabelSpecs;

      ClearStacks;

      DisposeCode(FFirstInstruction);
      FLastInstruction:=nil;

      { inicializa os stacks internos }
      for st:=low(TStackType) to High(TStackType) do FStack[st]:=nil;

      { inicializa os especificadores de r�tulos }
      FFirstLabelSpec := nil;
      FLastLabelSpec := nil;

      { inicializa��o de propriedades }
      FCodeLine := -1;
      FCompiled := False;
      FSilentCompiled := false;
      FSolvedAddressing := False;
      FExpandedDebugInfo := False;
      FCurrentRoutine := nil;

      { clear used units }
      if FUsedUnits <> nil then
        FUsedUnits.Clear;

      FFileName := '';
      //FUnitName := '';
    finally
      FClearingScript := false;
    end;
  end;
end;

procedure TatScript.DisposeDLL;
var c: integer;
begin
  { varre as libraries, verificando se h� alguma vinculada ao presente script }
  with FScripter.FLibInstances do
    for c := Count-1 downto 0 do
      if (TObject(Items[c]) is TatDLL) and (TatDLL(Items[c]).FScript = Self) then
        { descarrega a DLL }
        FScripter.RemoveLibraryInstance( TatDLL(Items[c]), TatDLL(Items[c]).LibraryName );
  FLoadedDLL := False;
end;

procedure TatScript.SaveCodeToFile( AFileName:string );
var f:TFileStream;
begin
   try
      f:=TFileStream.Create(AFileName,fmCreate);
      try
         SaveCodeToStream(f);
      finally
         f.Free;
      end;
   except
      InternalError(Format('Unable to save file %s',[AFileName]));
   end;
end;

procedure TatScript.LoadCodeFromFile( AFileName:string );
var
  f:TFileStream;
begin
  f := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadCodeFromStream(f);
  finally
    f.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ Simplified code - file and stream handling                                   }
{------------------------------------------------------------------------------}
procedure TatScript.InternalSaveCodeToStream( AStream:TStream );
var
  c                     : integer;
  CodeFileHeader        : TCodeFileHeader;
  Instruction           : pSimplifiedCode;
  InstructionDescriptor : TInstructionDescriptor;
  ImplicitClassRef      : TImplicitClassRef;
  AUsedUnit             : TUsedUnitRec;
  ScriptInfoStream      : TMemoryStream;
begin
   with Scripter do
   begin
     ScriptInfoStream := TMemoryStream.Create;
     try
       try
          { clear destination stream }
          AStream.Size:=0;

          {Save ScriptInfo}
          ScriptInfoStream.WriteComponent(FScriptInfo);

          { PCODE HEADER }

          { prepare header variables }
          with CodeFileHeader do
          begin
             Signature := 'atPascal Executable File'#26;
             Version := CODEFILE_VERSION;
             ImplicitRefCount := FScripter.Classes.ImplicitCount;
             UsedUnitCount := FUsedUnits.Count;
             ScriptInfoSize := ScriptInfoStream.Size;
             { fill unused bytes }
             FillChar(Reserved, 28, 0);
          end;

          { write header to stream }
          AStream.WriteBuffer( CodeFileHeader, SizeOf(TCodeFileHeader) );

          { write implicit class references to file }
          for c:=0 to FScripter.Classes.Count-1 do
          begin
            with FScripter.Classes[c] do
            begin
              if IsImplicit then
              begin
                ImplicitClassRef.ClassIndex := Index;
                ImplicitClassRef.ElementIndex := ImplicitElement.Index;
                // ImplicitElement is either TatMethod or TatProperty
                ImplicitClassRef.ElementIsMethod := ImplicitElement is TatMethod;
                ImplicitClassRef.ClassNameSize := Length(Name);
                ImplicitClassRef.ElementNameSize := Length(ImplicitElement.DisplayName);

                AStream.WriteBuffer(ImplicitClassRef, SizeOf(TImplicitClassRef));
                AStream.WriteBuffer(PChar(Name)^, ImplicitClassRef.ClassNameSize * SizeOf(Char));
                AStream.WriteBuffer(PChar(ImplicitElement.DisplayName)^, ImplicitClassRef.ElementNameSize * SizeOf(Char));
              end;
            end;
          end;

          { write used units to file }
          for c := 0 to CodeFileHeader.UsedUnitCount-1 do
          begin
             with FUsedUnits[c] do
             begin
                AUsedUnit.UnitNameSize := Length(UnitName);
                AUsedUnit.IsDefault := IsDefault;
                AUsedUnit.IsScript := IsScript;
                AUsedUnit.DeclSourcePos := DeclSourcePos;
             end;
             AStream.WriteBuffer( AUsedUnit, SizeOf(TUsedUnitRec) );
             AStream.WriteBuffer( PChar(FUsedUnits[c].UnitName)^, Length(FUsedUnits[c].UnitName) * SizeOf(Char));
          end;

          { write script info to file }
          ScriptInfoStream.Seek(0, soFromBeginning);
          AStream.CopyFrom(ScriptInfoStream, ScriptInfoStream.Size);

          { INSTRUCTIONS }

          { scan instruction list }
          instruction := FFirstInstruction;
          while instruction <> nil do
          begin
             { prepare instruction descriptor variables }
             with InstructionDescriptor do
             begin
                Size := Length(instruction^.vString);
                Size2 := Length(instruction^.vString2);

                Details.OpCode:=ord(instruction^.OpCode);
                Details.vByte:=instruction^.vByte;
                Details.vSmallInt:=instruction^.vSmallInt;
                Details.vInteger:=instruction^.vInteger;
                Details.vInteger1:=instruction^.vInteger1;
                Details.vInteger2:=instruction^.vInteger2;
                Details.vInteger3:=instruction^.vInteger3;
                Details.vDebugInfo:=instruction^.vDebugInfo;
             end;
             { write instruction to file }
             AStream.WriteBuffer( InstructionDescriptor, SizeOf(InstructionDescriptor) );
             { manually writes the string variable content }
             AStream.WriteBuffer( PChar(instruction^.vString)^, Length(instruction^.vString) * SizeOf(Char));
             AStream.WriteBuffer( PChar(instruction^.vString2)^, Length(instruction^.vString2) * SizeOf(Char));
             { get next instruction }
             instruction:=instruction^.Next;
          end;
       except
          on ex:Exception do
             InternalError(Format('Unable to write stream (%s)',[ex.message]));
       end;
     finally
       ScriptInfoStream.Free;
     end;
   end;
end;

procedure TatScript.SaveCodeToStream( AStream:TStream );
begin
   with Scripter do
   begin
     if not FCompiled then
        { save operation is not allowed after Execute, thus compilation is made before }
       Compile;

     AStream.Size := 0;
     FCodeStream.Position := 0;
     AStream.CopyFrom(FCodeStream, FCodeStream.Size);
   end;
end;

procedure TatScript.LoadCodeFromStream(AStream: TStream);
begin
  InternalLoadCodeFromStream(AStream, true);
end;

procedure TatScript.InternalLoadCodeFromStream(AStream: TStream; ARegisterForm: boolean);
var
  CodeFileHeader        : TCodeFileHeader;
  InstructionDescriptor : TInstructionDescriptor;
  s1, s2                : string;
  c1, c2, i             : integer;
  ImplicitClassRef      : TImplicitClassRef;
  AUsedUnit             : TUsedUnitRec;
  ScriptInfoStream      : TMemoryStream;
  TempUnitName          : string;
  implicitClasses       : TatClassRefs;
begin
   if VirtualMachine.Running then
      FatalError('Cannot load code from stream while script is running.');
   Clear;
   if Assigned(FScripter) then
     FScripter.BeforeLoadCode;
   ScriptInfoStream := TMemoryStream.Create;
   implicitClasses := TatClassRefs.Create(Self);
   try
     try
        { read stream from current position }

        { PCODE HEADER }

        { read header from file }
        AStream.ReadBuffer( CodeFileHeader, SizeOf(TCodeFileHeader) );
        with CodeFileHeader do
        begin
           if Signature <> 'atPascal Executable File'#26 then
              InternalError('Invalid executable file signature');
           if Version <> CURRENT_VERSION then
              InternalError(Format('%d not is a valid executable file version, expected %d', [Version, CURRENT_VERSION]));
        end;

        { read implicit class references from file }
        { load implicit class into script info structure }
        for i := 0 to CodeFileHeader.ImplicitRefCount - 1 do
        begin
           AStream.ReadBuffer(ImplicitClassRef, SizeOf(TImplicitClassRef));

           c1 := ImplicitClassRef.ClassNameSize;
           SetLength(s1, c1);
           AStream.ReadBuffer(PChar(s1)^, c1 * SizeOf(Char));

           c2 := ImplicitClassRef.ElementNameSize;
           SetLength(s2, c2);
           AStream.ReadBuffer(PChar(s2)^, c2 * SizeOf(Char));

           implicitClasses.Add(
              ImplicitClassRef.ClassIndex,
              ImplicitClassRef.ElementIndex,
              ImplicitClassRef.ElementIsMethod,
              s1, s2);
        end;

        { read used units from file }
        for i := 0 to CodeFileHeader.UsedUnitCount - 1 do
        begin
           AStream.ReadBuffer( AUsedUnit, SizeOf(TUsedUnitRec) );
           SetLength(TempUnitName, AUsedUnit.UnitNameSize);
           { read the string content }
           AStream.ReadBuffer(PChar(TempUnitName)^, AUsedUnit.UnitNameSize * SizeOf(Char));
           with FUsedUnits.Add do
           begin
             UnitName := TempUnitName;
             IsDefault := AUsedUnit.IsDefault;
             IsScript := AUsedUnit.IsScript;
             DeclSourcePos := AUsedUnit.DeclSourcePos;
           end;
        end;

        { read script info from file }
        if CodeFileHeader.ScriptInfoSize > 0 then
        begin
          ScriptInfoStream.CopyFrom(AStream, CodeFileHeader.ScriptInfoSize);
          ScriptInfoStream.Seek(0, soFromBeginning);
          ScriptInfoStream.ReadComponent(FScriptInfo);
          if FScriptInfo.IsForm and ARegisterForm then
            RegisterForm;
        end;

        {load implicit classrefs}
        for i := 0 to implicitClasses.Count - 1 do
          implicitClasses[i].CheckLoaded;

        { INSTRUCTIONS }

        { builds instruction list }
        while AStream.Position<AStream.Size-1 do
        begin
           { read the instruction descriptor }
           AStream.ReadBuffer( InstructionDescriptor, SizeOf(TInstructionDescriptor) );

           { alocate memory for wide string }
           c1 := InstructionDescriptor.Size;
           SetLength(s1, c1);

           c2 := InstructionDescriptor.Size2;
           SetLength(s2, c2);

           { read the string content }
           AStream.ReadBuffer(PChar(s1)^, c1 * SizeOf(Char));
           AStream.ReadBuffer(PChar(s2)^, c2 * SizeOf(Char));

           { include the readed instruction into code memory }
           with AppendInstruction(TInstruction(InstructionDescriptor.Details.OpCode))^ do
           begin
              vInteger   := InstructionDescriptor.Details.vInteger;
              vByte      := InstructionDescriptor.Details.vByte;
              vInteger1  := InstructionDescriptor.Details.vInteger1;
              vInteger2  := InstructionDescriptor.Details.vInteger2;
              vInteger3  := InstructionDescriptor.Details.vInteger3;
              vSmallInt  := InstructionDescriptor.Details.vSmallInt;
              vString    := s1;
              vString2   := s2;
              vDebugInfo := InstructionDescriptor.Details.vDebugInfo;
           end;
        end;

        if Assigned(FScripter) then
          for i := 0 to FUsedUnits.Count - 1 do
            FScripter.LoadLibrary(FUsedUnits[i].UnitName, FUsedUnits[i].IsDefault);

        FSolvedAddressing := false;
        FCompiled := true;
        FSilentCompiled := true;
        FExpandedDebugInfo := false;
        FScriptInfo.UpdateRoutineInfoPointers;

        {creates methods for the external calls}
        if Assigned(FScripter) then
          for i := 0 to FScripter.ScriptInfo.Routines.Count - 1 do
            if FScripter.ScriptInfo.Routines[i].ExternalDll > '' then
              FScripter.ScriptInfo.Routines[i].PrepareExternalClass;
     except
        on ex: EatInternalError do raise;
        on ex:Exception do
           InternalError(Format('Unable to read stream (%s)',[ex.message]));
     end;
   finally
     ScriptInfoStream.Free;
     implicitClasses.Free;
   end;

   {After loading, save the code to an internal stream for reuse}
   FCodeStream.Size := 0;
   //OldIsForm := ScriptInfo.IsForm;
   //ScriptInfo.IsForm := false;
   InternalSaveCodeToStream(FCodeStream);
   //ScriptInfo.IsForm := OldIsForm;
   VirtualMachine.FFastSolving := false;
end;

{ m�todos auxiliares para o gera��o de c�digo usando classes }

procedure TatScript.RelativeGetterRef(AProperty: TatProperty; AInst: pSimplifiedCode);
begin
   { Use only the field vProc.Data to relative class indexing, vProc.Code is ignored
     vProc will entirely replaced by SolveAbsoluteAddressing, after compiling or
     after loading code from file }
   if Assigned(AProperty) then
   begin
      TMethod(AInst^.vProc).Code := nil;
      TMethod(AInst^.vProc).Data := pointer(ord(crGetter) + AProperty.Index shl 2 + TatProperties(AProperty.Collection).FClass.Index shl 17);
      AInst^.vString2 := TatProperties(AProperty.Collection).FClass.Name;
   end
   else
   begin
      { Indicate, into field vProc.Data that the reference is for undefined property getter }
      TMethod(AInst^.vProc).Code := nil;
      TMethod(AInst^.vProc).Data := pointer(crGetter);
   end;
end;

procedure TatScript.RelativeSetterRef(AProperty: TatProperty; AInst: pSimplifiedCode);
begin
   { Use only the field vProc.Data to relative class indexing, vProc.Code is ignored
     vProc will entirelly replaced by SolveAbsoluteAddressing, after compiling or
     after loading code from file }
   if Assigned(AProperty) then
   begin
      TMethod(AInst^.vProc).Code := nil;
      TMethod(AInst^.vProc).Data := pointer(ord(crSetter) + AProperty.Index shl 2 + TatProperties(AProperty.Collection).FClass.Index shl 17);
      AInst^.vString2 := TatProperties(AProperty.Collection).FClass.Name;
   end
   else
   begin
      { Indicate, into field vProc.Data that the reference is for undefined property setter }
      TMethod(AInst^.vProc).Code := nil;
      TMethod(AInst^.vProc).Data := pointer(crSetter);
   end;
end;

procedure TatScript.RelativeMethodRef(AMethod: TatMethod; AInst: pSimplifiedCode);
begin
   { Use only the field vProc.Data to relative class indexing, vProc.Code is ignored
     vProc will entirelly replaced by SolveAbsoluteAddressing, after compiling or
     after loading code from file }
   if Assigned(AMethod) then
   begin
      TMethod(AInst^.vProc).Code := nil;
      TMethod(AInst^.vProc).Data := pointer(ord(crMethod) + AMethod.Index shl 2 + TatMethods(AMethod.Collection).FClass.Index shl 17);
      AInst^.vString2 := TatMethods(AMethod.Collection).FClass.Name;
   end
   else
   begin
      { Indicate, into field vProc.Data that the reference is for undefined method }
      TMethod(AInst^.vProc).Code := nil;
      TMethod(AInst^.vProc).Data := pointer(crMethod);
   end;
end;

{------------------------------------------------------------------------------}
{ Pilhas internas do gerador de c�digo                                         }
{------------------------------------------------------------------------------}

procedure TatScript.StackPush(StackType:TStackType; x:Variant );
var prev : pStackElement;
begin
   prev:=FStack[StackType];
   New( FStack[StackType] );
   with FStack[StackType]^ do
   begin
      Previous:=prev;
      Element:=x;
      if VarIsNull(x) then
         Index:=-1
      else
         if Previous=nil then
            Index:=0
         else
            Index:=Previous^.Index+1;
   end;
end;

procedure TatScript.StackPushDelimitter(StackType:TStackType );
begin
   StackPush(StackType,null);
end;

function TatScript.EmptyStack(StackType:TStackType):boolean;
begin
   result:=(FStack[StackType]=nil);
end;

function TatScript.StackPop(StackType:TStackType):Variant;
var aux : pStackElement;
begin
   if FStack[StackType]=nil then
      RuntimeError('Empty stack when trying to pop element '+GetEnumName(TypeInfo(TStackType),ord(StackType)));
   aux:=FStack[StackType].Previous;
   result:=FStack[StackType]^.Element;
   Dispose(FStack[StackType]);
   FStack[StackType]:=aux;
end;

function TatScript.StackView(StackType:TStackType):Variant;
begin
   if FStack[StackType]=nil then
      RuntimeError('Empty stack when trying to pop element '+GetEnumName(TypeInfo(TStackType),ord(StackType)));
   result:=FStack[StackType]^.Element;
end;

function TatScript.StackIndex(StackType:TStackType):integer;
begin
  if FStack[StackType]=nil then
    result := -1
  else
    result:=FStack[StackType]^.Index;
end;

function TatScript.StackDelimitterFound(StackType:TStackType):boolean;
begin
   result:=VarIsNull( StackView(StackType) );
end;

function TatScript.StackGetByIndex(st:TStackType;i:integer):Variant;
var aux : pStackElement;
begin
   aux:=FStack[st];
   while (aux<>nil) and not VarIsNull(aux^.Element) and (aux^.Index>i) do aux:=aux^.Previous;
   if (aux<>nil) and (aux^.Index=i) then
      result:=aux^.Element
   else
      RuntimeError('Element index out of bounds when trying to pop element from stack: '+GetEnumName(TypeInfo(TStackType),ord(st)));
end;

function TatScript.IndexOfStackTextValue(st:TStackType;s:string):integer;
var aux : pStackElement;
begin
   s:=UpperCase(s);
   aux:=FStack[st];
   while (aux<>nil) and not VarIsNull(aux^.Element) and (UpperCase(VarToStr(aux^.Element))<>s) do aux:=aux^.Previous;
   if (aux<>nil) and (UpperCase(VarToStr(aux^.Element))=s) then
      result:=aux^.Index
   else
      result:=-1;
end;

procedure TatScript.ClearStacks;
var st : TStackType;
begin
   for st:=low(TStackType) to High(TStackType) do
      while not EmptyStack(st) do StackPop(st);
end;

{------------------------------------------------------------------------------}
{ Fun��es para manipula��o de desvios - gera��o e solu��o de labels            }
{------------------------------------------------------------------------------}

function TatScript.NewLabelSpec( Name:string ):pLabelSpec;
begin
   { aloca um novo especificador de r�tulo - estabelecendo valores apropriados para
     FFirstLabelSpec e FLastLabelSpec }
   New(result);
   Result^.Name:=Name;
   Result^.Address:=-1;
   Result^.FirstRef:=nil;
   Result^.LastRef:=nil;
   Result^.Next:=nil;
   if FFirstLabelSpec=nil then FFirstLabelSpec:=result else FLastLabelSpec^.Next:=result;
   FLastLabelSpec:=result;
end;

function TatScript.FindLabelSpec( name:string ):pLabelSpec;
begin
   { devolve o LabelSpec se existir, sen�o devolve nil }
   result:=FFirstLabelSpec;
   while (result<>nil) and (UpperCase(result.name)<>UpperCase(Name)) do result:=result^.next;
end;

function TatScript.RegisterReference( Name:string ):integer;
var LabelSpec : pLabelSpec;
    LastRef   : pAddress;
begin
   { esta rotina deve ser chamada ap�s a gera��o do c�digo que fez a refer�ncia
     para o r�tulo de endere�amento }

   { encontra o especificador se j� existir, sen�o o cria }
   LabelSpec:=FindLabelSpec(name);
   if LabelSpec=nil then LabelSpec:=NewLabelSpec(name);
   if LabelSpec^.Address>-1 then
   begin
      { se o r�tulo j� tiver sido definido, n�o registra a refer�ncia }
      result:=LabelSpec^.Address+1;
      FLastInstruction.vInteger:=result; { aponta para a instru��o subseq�ente ao r�tulo }
   end
   else
   begin
      { empilha a refer�ncia ao r�tulo dentro do especificador }
      New(LastRef);
      LastRef^.Next:=nil;
      LastRef^.Address:=FCodeLine;
      LastRef^.Code:=FLastInstruction;
      if LabelSpec^.FirstRef=nil then
         LabelSpec^.FirstRef:=LastRef
      else
         LabelSpec^.LastRef^.Next:=LastRef;
      LabelSpec^.LastRef:=LastRef;
      result:=0; // refer�ncia indefinida
   end;
end;

procedure TatScript.SolveReference( LabelSpec:pLabelSpec );
var Ref : pAddress;
begin
   with LabelSpec^ do
   begin
      while FirstRef<>nil do
      begin
         FirstRef^.Code.vInteger:=Address+1; // aponta para a instru��o subseq�ente ao r�tulo
         { libera a mem�ria alocada e avan�a para a pr�xima refer�ncia }
         Ref:=FirstRef;
         FirstRef:=FirstRef^.Next;
         Dispose(Ref);
      end;
      LastRef:=nil;
   end;
end;

procedure TatScript.DefineReferenceAddress( Name:string );
var LabelSpec : pLabelSpec;
begin
   { esta rotina deve ser chamada antes da primeira instru��o referente ao
     r�tulo de endere�amento  }

   { A resolu��o das refer�ncias ser� feita para a instru��o subseq�ente ao r�tulo }

   { encontra o especificador se j� existir, sen�o o cria }
   LabelSpec:=FindLabelSpec(name);
   if LabelSpec=nil then LabelSpec:=NewLabelSpec(name);
   { registra o endere�o do r�tulo }
   LabelSpec^.Address:=FCodeLine;
   { se haviam refer�ncias pendentes, resolve-as agora }
   if LabelSpec^.FirstRef<>nil then SolveReference( LabelSpec );
end;

procedure TatScript.ClearLabelSpecs;
var LabelSpec : pLabelSpec;
    Address   : pAddress;
begin
   { elimina toda a estrutura de especificadores de r�tulos }
   while FFirstLabelSpec<>nil do
   begin
      while FFirstLabelSpec^.FirstRef<>nil do
      begin
         Address:=FFirstLabelSpec^.FirstRef;
         FFirstLabelSpec^.FirstRef:=FFirstLabelSpec^.FirstRef^.Next;
         Dispose(Address);
      end;
      LabelSpec:=FFirstLabelSpec;
      FFirstLabelSpec:=FFirstLabelSpec^.Next;
      Dispose(LabelSpec);
   end;
   FLastLabelSpec:=nil;
end;

procedure TatScript.SolveUndefinedReferences;
var LabelSpec : pLabelSpec;
    routine : TatRoutineInfo;
begin
   LabelSpec:=FFirstLabelSpec;
   while LabelSpec<>nil do
   begin
      with LabelSpec^ do
         if FirstRef<>nil then { refer�ncias indefinidas }
         begin
            { se for um script do debugger ent�o d� uma segunda chance para resolver a refer�ncia:
              verifica se o endere�o se refere a uma rotina com endere�o j� definido }
            if FIsDebugScript then
            begin
              routine := FScriptInfo.RoutineByName(Name);
              if Assigned(routine) then
              begin
                { resolve a refer�ncia de forma absoluta para o endere�o de
                  in�cio da subrotina }
                LabelSpec^.Address := integer(routine.DeclarationInstruction)-1;
                SolveReference( LabelSpec );
              end
              else
                CompileError(Format('Unknown method ou subroutine: ''%s''',[Name]),FirstRef^.Code^.vDebugInfo);
            end
            else
              CompileError(Format('Unknown method ou subroutine: ''%s''',[Name]),FirstRef^.Code^.vDebugInfo);
         end;
      LabelSpec:=LabelSpec^.Next;
   end;
end;

procedure TatScript.DisposeCode(var code:pSimplifiedCode);
var aux : pSimplifiedCode;
begin
   { libera o programa previamente alocado }
   while code<>nil do
   begin
      aux:=code;
      code:=code^.Next;
      Dispose(aux);
   end;
end;

function TatScript.AppendInstruction(i:TInstruction):pSimplifiedCode;
var Prev : pSimplifiedCode;
begin
  Inc(FCodeLine);
  Prev := FLastInstruction;
  New(FLastInstruction);
  result := FLastInstruction;
  FillChar(result^,SizeOf(TSimplifiedCode),0);
  result^.OpCode := i;
  if not Assigned(Prev) then
    FFirstInstruction := FLastInstruction
  else
    Prev^.Next := FLastInstruction;
end;

procedure TatScript.OptimizeStoreVar(AVar: TatVariableInfo; AIgnoreConstant: boolean = false);
begin
  { Se a �ltima express�o gerada for o empilhamento de uma simples constante ou
    o valor de uma vari�vel ent�o, substitui esta instru��o por outra que
    tamb�m incui o StoreVar, sen�o gera um StoreVar gen�rico (n�o otimizado) }
  if (AVar.Modifier = moConst) and not AIgnoreConstant then
    CompileError(Format('Cannot assign a value to constant ''%s''',
    [AVar.VarName]),FParser.ScanningInputPos);
  with AVar, FLastInstruction^ do
    if not Global then {*** vari�veis globais n�o suportam otimiza��o por enquanto ***}
      case OpCode of
        inPushInteger:
          { transforma o PushInteger em um StoreVarInteger }
          begin
             if Modifier=moVar then
                OpCode := inStoreVarRefInteger
             else
                OpCode := inStoreVarInteger;
             vInteger2 := vInteger; // Armazena o valor inteiro a ser carregado na vari�vel
             vInteger := VarIndex; // Armazena o �ndice da vari�vel do case
             vString := VarName; // Armazena o nome da vari�vel
          end;
        inPushString:
           { transforma o PushString em um StoreVarString }
           begin
             if Modifier = moVar then
               OpCode := inStoreVarRefString
             else
               OpCode := inStoreVarString;
             vInteger := VarIndex; // Armazena o �ndice da vari�vel do case
             vInteger3 := Length(vString); // Armazena o comprimento do conte�do da string
             vString := vString+VarName; // Concatena o conte�do e o nome da vari�vel
           end;
        inPushDouble:
           { transforma o PushDouble em um StoreVarDouble }
           begin
             if Modifier = moVar then
               OpCode := inStoreVarRefDouble
             else
               OpCode := inStoreVarDouble;
             vInteger := VarIndex;   // Armazena o �ndice da vari�vel
             vString := VarName; // Armazena o nome da vari�vel
           end;
        inPushConst:
           { transforma o PushConst em um StoreVarConst }
           begin
             if Modifier = moVar then
               OpCode := inStoreVarRefConst
             else
               OpCode := inStoreVarConst;
             vInteger := VarIndex;        // Armazena o �ndice da vari�vel
             vInteger3 := Length(vString); // Armazena o comprimento do conte�do da string
             vString := vString+VarName; // Concatena o nome da constante com o nome da vari�vel
           end;
        inPushVar:
           { transforma o PushVar em um CopyVar }
           begin
             if Modifier = moVar then
               OpCode := inCopyVarRef
             else
               OpCode := inCopyVar;
             vInteger2 := VarIndex;   // Armazena o �ndice da vari�vel do case
             vInteger3 := length(vString);
             vString := vString+VarName; // Concatena a nome da vari�vel origem com o nome da vari�vel destino
           end;
      else
        { Como a express�o n�o � uma simples constante ou vari�vel ent�o gera uma
          instru��o para carga gen�rica da vari�vel }
        if Modifier = moVar then
          with AppendInstruction(inStoreVarRef)^ do
          begin
            vInteger   := VarIndex;
            vString    := VarName;
            vDebugInfo := FParser.ScanningInputPos;
          end
        else
          with AppendInstruction(inStoreVar)^ do
          begin
            vInteger   := VarIndex;
            vString    := VarName;
            vDebugInfo := FParser.ScanningInputPos;
          end;
      end
    else
      if Modifier = moVar then
        CompileError(Format('Internal error: Trying to generate StoreGlobalVarRef(%s)',
          [AVar.VarName]),FParser.ScanningInputPos)
      else
        with AppendInstruction(inStoreGlobalVar)^ do
        begin
          vInteger   := VarIndex;
          vString    := VarName;
          vDebugInfo := FParser.ScanningInputPos;
        end;
end;

procedure TatScript.OptimizeVarTest( ACaseVarIndex:integer; ACaseVarName,AJumpLabel:string; ACondition:boolean );
begin
   { Se a �ltima express�o gerada for o empilhamento de uma simples constante ou
     o valor de uma vari�vel, ent�o substitui esta instru��o por outra que
     tamb�m inclui faz um VarTest, sen�o gera um VarTest gen�rico (n�o otimizado) }

   {$IFDEF CODE_OPTIMIZATION}
   case FLastInstruction^.OpCode of
      inPushInteger:
         { transforma o PushInteger em um VarTestInteger }
         with FLastInstruction^ do
         begin
            OpCode:=inVarTestInteger;
            vByte:=byte(ACondition);
            vInteger2:=ACaseVarIndex; // Armazena o �ndice da vari�vel do case
            vInteger3:=vInteger; // Armazena o valor inteiro a ser testado na vari�vel
            vInteger:=RegisterReference(AJumpLabel); // aqui ser� armazenado o endere�o do desvio condicional
            vString:=ACaseVarName; // Armazena o nome da vari�vel do teste (e n�o o r�tulo do desvio)
         end;
      inPushString:
         { transforma o PushString em um VarTestString }
         with FLastInstruction^ do
         begin
            OpCode:=inVarTestString;
            vByte:=byte(ACondition);
            vInteger2:=ACaseVarIndex; // Armazena o �ndice da vari�vel do case
            vInteger3:=length(vString); // Armazena o comprimento do conte�do da string
            vInteger:=RegisterReference(AJumpLabel); // aqui ser� armazenado o endere�o do desvio condicional
            vString:=vString+ACaseVarName; // Concatena o conte�do e o nome da vari�vel
         end;
      inPushDouble:
         { transforma o PushDouble em um VarTestDouble }
         with FLastInstruction^ do
         begin
            OpCode:=inVarTestDouble;
            vByte:=byte(ACondition);
            vInteger1:=ACaseVarIndex; // Armazena o �ndice da vari�vel do case
            vInteger:=RegisterReference(AJumpLabel); // aqui ser� armazenado o endere�o do desvio condicional
            vString:=ACaseVarName; // Armazena o nome da vari�vel do teste (e n�o o r�tulo do desvio)
         end;
      inPushVar:
         { transforma o PushVar em um VarTestVar }
         with FLastInstruction^ do
         begin
            OpCode:=inVarTestVar;
            vByte:=byte(ACondition);
            vInteger1:=length(vString); // Armazena o comprimento do conte�do da string
            vInteger2:=vInteger;      // Armazena o �ndice da vari�vel origem
            vInteger3:=ACaseVarIndex; // Armazena o �ndice da vari�vel destino
            vInteger:=RegisterReference(AJumpLabel); // aqui ser� armazenado o endere�o do desvio condicional
            vString:=vString+ACaseVarName; // Concatena os nomes das vari�veis
         end;
   else
      { Como a express�o n�o � uma simples constante nem vari�vel ent�o gera uma
        instru��o para teste gen�rica da vari�vel }
      with AppendInstruction(inVarTest)^ do
      begin
         vInteger   := RegisterReference(AJumpLabel);
         vByte      := byte(ACondition);
         vInteger2  := ACaseVarIndex;
         vString    := ACaseVarName;
         vDebugInfo := FParser.ScanningInputPos;
      end;
   end;
   {$ELSE}
   { Se as otimiza��es de c�digo estiverem desligadas ent�o n�o condensa o
     VarTest com o conte�do que tiver sido salvo na pilha }
   with AppendInstruction(inVarTest)^ do
   begin
      vInteger   := RegisterReference(AJumpLabel);
      vByte      := byte(ACondition);
      vInteger2  := ACaseVarIndex;
      vString    := ACaseVarName;
      vDebugInfo := FParser.ScanningInputPos;
   end;
   {$ENDIF}
end;

function TatScript.RegisterVariableReference(id:string):TatVariableInfo;
begin
   { atualiza a lista de vari�veis do processo }
   { se a vari�vel j� existe apenas determina seu �ndice }
   result := CurrentRoutine.VariableByName(id);
   if result = nil then
     result := ScriptInfo.Globals.FindByName(id);
   if not Assigned(result) then
      if Scripter.FOptionExplicit and not FSilentCompilation then
         CompileError(Format('Undeclared variable ''%s''',[id]),FParser.ScanningInputPos)
      else
      begin
         { como a vari�vel n�o existe e OptionExplicit=false ent�o declara-a automaticamente }
         { inclui informa��es sobre esta vari�vel }
         result := CurrentRoutine.DeclareVariable(id, FParser.ScanningInputPos);
      end;
end;

function TatScript.DeclareVariable(AName: string; AArgIndex: integer = -1; AModifier: TatArgumentModifier = moNone;
      AGlobal: boolean = False; ASourcePos: integer = -1): TatVariableInfo;
begin
  if ASourcePos = -1 then
    ASourcePos := FParser.ScanningInputPos;
  if AGlobal then
  begin
    { evita que a vari�vel seja declarada mais de uma vez }
    if Assigned(ScriptInfo.Globals.FindByName(AName)) then
       CompileError(Format('Redeclaration of global identifier ''%s''',[AName]),FParser.ScanningInputPos);
    { declara o identificador incluindo um item na cole��o de vari�veis globais }
    result := ScriptInfo.Globals.Add;
    with result do
    begin
      FVarName := AName;
      FArgIndex := AArgIndex;
      FModifier := AModifier;
      FGlobal := True;
      FDeclarationSourcePos := ASourcePos
    end;
  end
  else
  begin
    { evita que a vari�vel seja declarada mais de uma vez }
    if Assigned(CurrentRoutine.VariableByName(AName)) then
       CompileError(Format('Redeclaration of identifier ''%s''',[AName]), ASourcePos);
    { inclui informa��es sobre esta vari�vel }
    result := CurrentRoutine.DeclareVariable(AName, ASourcePos, AArgIndex, AModifier);
  end;
end;

procedure TatScript.GetRowColFromSource(APos:integer;var row,col:integer);
begin
   GetRowColFromStrings(FParser.Strings,APos,row,col);
end;

procedure TatScript.InternalCompile(Silent: boolean);
var
  row: integer;
  col: integer;
  {$IFDEF TRIAL}
  msg: string;
  i: integer;
  {$ENDIF}
begin
  {$IFDEF TRIAL}
  if (Now > 40900) or (Now < 40530) then
  begin
    msg := 'Tfhfiesg hSjcgrfidpstcetrg yShtgufdeidof dvcevrfseidofnd wheassz aesxdpfitryeudu.g fPvldecaxssed rrteyguiishtjehrg,f dosrd s'+
      'tdor tcfognvtcisnwueed sewvratlhunagtbifnvgc sdzotwfnglhoiaodk jam nnhegwf d'+
      'vdefrrstigovnc sfdreormf xhttgtyph:j/u/iwnwhwg.btfmvscsdowfqtawsadreer.fcrotm';
    i := 2;
    while i < length(msg) do
    begin
      System.Delete(msg, i, 1);
      inc(i);
    end;
    raise Exception.Create(msg);
  end;
  {$ENDIF}

   FSilentCompilation := Silent;
   FCompiling := true;
   try

     if VirtualMachine.Running then
        FatalError('Cannot compile script while script is running.');

     if Assigned(FScripter) then
        FScripter.BeforeCompile;

     { Inicializa o objeto }
     Clear;

     { Parsing nas strings de entrada }
     with FParser, CheckLanguage do

        if Result<>srCorrect then
        begin
           GetRowColFromSource(MaxInputPos-1,row,col);
           CompileError( 'Syntax error', row, col );
        end;
     { Varre a �rvore sint�tica para gerar c�digo execut�vel }
     FParser.ScanSyntaxTree;
     { Tenta resolver refer�ncias a identificadores ainda n�o resolvidos }
     SolveUndefinedReferences;
     FCompiled := not Silent;
     FSilentCompiled := true;

     { conclui informa��es sobre o script compilado }
     FScriptInfo.FCodeSize := FCodeLine + 1;
     FScriptInfo.UnitName := Self.UnitName;

     {After loading, if the script is a form, then save the code to an internal
      stream for reuse when a new form is created}
     if FCompiled then
     begin
       FCodeStream.Size := 0;
       //OldIsForm := ScriptInfo.IsForm;
       //ScriptInfo.IsForm := false;
       InternalSaveCodeToStream(FCodeStream);
       //ScriptInfo.IsForm := OldIsForm;
       RemoveAttachedEvents(false);
     end;
   finally
     FSilentCompilation := false;
     FCompiling := false;
   end;
end;

procedure TatScript.SilentCompile;
begin
  InternalCompile(true);
end;

procedure TatScript.Compile;
begin
  InternalCompile(false);
end;

procedure TatScript.ExpandDebugInfo(RequiresCompilation: boolean = true);
var Cur  : pSimplifiedCode;
    InputPos : integer; // indica a posi��o corrida correspondente no programa-fonte
    row,col  : integer; // indica a posi��o decomposta correspondente no programa-fonte

    procedure IncInputPos;
    begin
       inc(InputPos);
       if (InputPos > 0) and (InputPos < Length(FParser.Input)) and (FParser.Input[InputPos] = #10) then
       begin
          inc(InputPos);
          inc(row);
          col:=1;
       end
       else
          inc(col);
    end;

    procedure DecInputPos;
    begin
       dec(InputPos);
       if (InputPos > 0) and (InputPos < Length(FParser.Input)) and (FParser.Input[InputPos] = #10) then
       begin
          dec(InputPos);
          dec(row);
          col:=length(FParser.Strings[row-1])+1;
       end
       else
          dec(col);
    end;

begin
   if not FExpandedDebugInfo then
   begin
      { verifica se o m�todo compile j� foi chamado, sen�o chama-o automaticamente }
      if not FCompiled and RequiresCompilation then
        Compile;

//    { verifica se o endere�amento absoluto j� foi resolvido, sen�o resolve-o automaticamente }
      if not FSolvedAddressing and RequiresCompilation then
        VirtualMachine.SolveAbsoluteAddressing;
      { Decodifica o campo vDebugInfo do c�digo simplificado }
      { Expande a posi��o sequencial do programa-fonte em linha e coluna }
      Cur:=FFirstInstruction;
      InputPos:=1;
      Row:=1;
      Col:=1;
      while Cur<>nil do
      begin
         with Cur^ do
         begin
            { converte o campo DebugInfo na linha e coluna correspondente ao programa-fonte }
            { *** este procedimento ser� desnecess�rio quando o parser j� tiver esta
              informa��o assim decomposta *** }
            while InputPos<vDebugInfo+1 do IncInputPos;
            while InputPos>vDebugInfo+1 do DecInputPos;
            vDebugInfo:=Col shl 20 + Row; // esta codifica��o permite 1048576 linhas e 4096 colunas
         end;
         Cur:=Cur^.Next;
      end;
      FExpandedDebugInfo := true;
      Breaks.UpdateAll;
   end;
end;

function TatScript.ErrorComplement(APos:integer):string;
var row,col:integer;
begin
  if ExpandedDebugInfo then
  begin
    row := LineNumberFromDebugInfo(APos) + 1;
    col := ColNumberFromDebugInfo(APos) + 1;
  end else
    GetRowColFromSource(APos,row,col);
  result:='.'#13#10+'Source position: '+inttostr(row)+','+inttostr(col);
end;

procedure TatScript.GetRowColFromInst(Inst: pSimplifiedCode; var Row, Col: integer);
begin
  if ExpandedDebugInfo then
  begin
    row := LineNumberFromDebugInfo(Inst^.vDebugInfo) + 1;
    col := ColNumberFromDebugInfo(Inst^.vDebugInfo) + 1;
  end else
    GetRowColFromSource(Inst^.vDebugInfo, row, col);
end;

procedure TatScript.SourceCodeChange(Sender: TObject);
begin
   if not FRollbackSourceCode then
   begin
     if VirtualMachine.Running then
     begin
       {Script is running, do not change source code (retrieve old source code saved in parser object}
       FRollbackSourceCode := true;
       FSourceCode.Assign(FParser.Strings);
       FRollbackSourceCode := false;
       FatalError('Cannot change script source code while script is running.');
     end else
     begin
       FParser.Strings.Assign(FSourceCode);
       FRefactor.FDirtySource := true;
       Scripter.FPCode.Size:=0;
       Clear;
       if not FIsDebugScript then
         Scripter.SourceCodeChanged(Self);
     end;
   end;
end;

procedure TatScript.SetSourceCode(value:TStrings);
begin
   FSourceCode.Assign(Value);
end;

procedure TatScript.CompileError(msg: string; debuginfo: integer);
var
  row, col: integer;
begin
  if not FSilentCompilation then
  begin
    GetRowColFromSource(debuginfo,row,col);
    CompileError(msg, row, col);
  end;
end;

procedure TatScript.CompileError(msg: string; row, col: integer);
begin
  if not FSilentCompilation then
  begin
    if Assigned(FScripter) then
      FScripter.InternalCompileError(msg,row,col,Self);
  end;
end;

procedure TatScript.RuntimeError(msg: string);
begin
  if Assigned(FScripter) then
    FScripter.InternalRuntimeError(msg, Self);
end;

function TatScript.GetStack(st: TStackType): pStackElement;
begin
  result := FStack[st];
end;

function TatScript.SelfRegisterAsLibrary(AScripter: TatCustomScripter; AName: string; AClassRef: TClass;
  AClassName: string; ADefault: boolean; AddMethod: boolean): TatScripterLibrary;
var
  NewLibrary: TatScriptBasedLibrary;
begin
  FUnitName := AName;
  if not FCompiled then
    Compile;
  SelfUnregisterAsLibrary(AScripter);
  NewLibrary := TatScriptBasedLibrary.Create(AScripter);
  NewLibrary.FInternalScript := Self;
  NewLibrary.FName := AName;
  NewLibrary.FRegClass := AClassRef;

  NewLibrary.FRegClassName := AClassName;
  AScripter.AddLibraryInstance(NewLibrary, NewLibrary.FName, ADefault, AddMethod, AClassName);
  FLibraries.Add(NewLibrary);
  if Scripter <> AScripter then
    AScripter.FreeNotification(Scripter);

  result := NewLibrary;
end;

function TatScript.SelfRegisterAsLibrary(AScripter: TatCustomScripter; AName: string = ''): TatScripterLibrary;
var
  AClass: TClass;
  AClassName: string;
  ADefault: boolean;
  AAddMethod: boolean;
begin
  {Check if the script has the $FORM directive. If the FormResource is not empty, then the script
   is a form unit}
  FUnitName := AName;
  if not FCompiled then
    Compile;
  if ScriptInfo.IsForm then
  begin
    AClass := Scripter.ScriptFormClass;
    AClassName := ScriptInfo.ScriptClassName;
    ADefault := false;
    AAddMethod := false;
  end else
  begin
    AClass := TatScriptBasedLibrary;
    AClassName := 'TatScriptBasedLibrary' + AName;
    ADefault := true;
    AAddMethod := true;
  end;
  result := SelfRegisterAsLibrary(AScripter, AName, AClass, AClassName, ADefault, AAddMethod);
end;

procedure TatScript.SelfUnregisterAsLibrary(AScripter: TatCustomScripter; AName: string = '');
var
  c: integer;
  ALibrary: TatScriptBasedLibrary;
begin
  c := 0;
  while c < FLibraries.Count do
  begin
    ALibrary := TatScriptBasedLibrary(FLibraries[c]);
    if ALibrary.Scripter = AScripter then
      if (AName = '') or (ALibrary.FName = AName) then
      begin
        AScripter.RemoveLibraryInstance(ALibrary, ALibrary.FName);
        ALibrary.Free;
        FLibraries.Delete(c);
        break;
      end;
    inc(c);
  end;
end;

function TatScript.SelfRegisterAsLibrary(AName: string = ''): TatScripterLibrary;
begin
  result := SelfRegisterAsLibrary(Scripter, AName);
end;

procedure TatScript.SelfUnregisterAsLibrary(AName: string = '');
begin
  SelfUnregisterAsLibrary(Scripter, AName);
end;

function TatScript.DeclareEventHandler(AProcName: string): integer;
begin
  if FRefactor <> nil then
    result := FRefactor.DeclareRoutine(AProcName)
  else
    result := 0;
end;

procedure TatScript.DoUnknownElement(var Context: TElementContext);
begin
  Scripter.DoUnknownElement(Context);
end;

function TatScript.LoadLibrary(ALibraryName: string;
  ADefault: boolean): TatScripterLibrary;
begin
  result := Scripter.LoadLibrary(ALibraryName, ADefault, FSilentCompilation);
end;

function TatScript.UsesObject(AObject: TObject; AName: string = ''; AClassName: string = ''): TatClass;
begin
   result := FDefInstances.Add(AObject, AName, AClassName).atClass;
end;

procedure TatScript.UnuseObject(AClassName: string);
var
  AObj: TatObject;
begin
  AObj := FDefInstances.FindInstanceByClassName(AClassName);
  if AObj <> nil then
    AObj.Free;
end;

procedure TatScript.AddObject(AName: string; AObject: TObject);
begin
  FIntInstance.atClass.AddObject(AName, AObject);
end;

procedure TatScript.RemoveObject(AName: string);
begin
  FIntInstance.atClass.RemoveProperty(AName);
end;

procedure TatScript.CompileForm(AFormClassName, AFormFile: string);
begin
  {Compilation}
  ScriptInfo.ScriptClassName := AFormClassName;
  if DesignFormResource <> '' then
    ScriptInfo.FormResource := DesignFormResource
  else
    ScriptInfo.FormResource := GetFormFileAsString(AFormFile);
  ScriptInfo.IsForm := true;
  RegisterForm;
end;

procedure TatScript.RegisterForm;
var
  AClass: TatClass;
  AScriptForm: TScriptForm;
begin
  if ScriptInfo.IsForm then
  begin
    {Registering. A form instance must be created so that it can be "used" in script, specially the
     components inside it}
    if DesignScriptForm <> nil then
    begin
      AScriptForm := DesignScriptForm;
    end else
    begin
      if FScriptForm <> nil then
        FScriptForm.Free;
      FScriptForm := Scripter.ScriptFormClass.CreateNew(nil);
      AScriptForm := FScriptForm;

      {Load form resource only for the purpose of registering the controls and components inside the form}
      FScriptForm.LoadFormResource(ScriptInfo.FormResource, Scripter.LoadFormEvents);
    end;

    {Define the new form class in script. The class will be known as ScriptClassName (TMyForm, for example),
     but the "Delphi" class is still TScriptForm}
    AClass := Scripter.DefineFormClass(AScriptForm, ScriptInfo.ScriptClassName);


    (*************if (AClass.FBaseScript <> nil) and (AClass.FBaseScript <> Self) then
      RuntimeError(Format('Class "%s" already registered by another script.', [ScriptInfo.ScriptClassName]));*************)
    AClass.FBaseScript := Self;

    UsesObject(AScriptForm, '', ScriptInfo.ScriptClassName);
    AddObject('Self', AScriptForm);
  end;
end;

procedure TatScript.UnregisterForm;
var
  AClass: TatClass;
begin
  {Remove the created form class, because when the script is cleared, we don't want that class
   registered anymore}
  if ScriptInfo.IsForm then
  begin
    {Remove the "Self" variable}
    RemoveObject('Self');

    {Remove the default instance}
    UnuseObject(ScriptInfo.ScriptClassName);

    {Remove the class - must be done after the code above, because the code above
     holds reference to the class}
    AClass := Scripter.Classes.ClassByName(ScriptInfo.ScriptClassName);
    if (AClass <> nil) and (AClass.FBaseScript = Self) then
    begin
      AClass.Free;
    end;

  end;
end;

function TatScript.GetFormFileAsString(AFormFile: string): string;
var
  FormFileName: string;
  SL: TStringList;
begin
  {Now loads the associated DFM file}
  FormFileName := Scripter.FindFormFile(AFormFile);
  if not FileExists(FormFileName) then
    RuntimeError(Format('Cannot find form file "%s".', [AFormFile]));
  SL := TStringList.Create;
  try
    SL.LoadFromFile(FormFileName);
    result := SL.Text;
  finally
    SL.Free;
  end;
end;

procedure TatScript.SetCompiled(const Value: boolean);
begin
  if FCompiled <> Value then
  begin
    if Value then
      Compile
    else
      Clear;
  end;
end;

function TatScript.IsRegisteredAsLibrary(AScripter: TatCustomScripter): boolean;
var
  ALib: TatScripterLibrary;
begin
  result := CheckRegisteredAsLibrary(AScripter, ALib);
end;

function TatScript.CheckRegisteredAsLibrary(
  AScripter: TatCustomScripter; var ALib: TatScripterLibrary): boolean;
var
  c: integer;
  ALibrary: TatScriptBasedLibrary;
begin
  ALib := nil;
  result := false;
  for c := 0 to FLibraries.Count - 1 do
  begin
    ALibrary := TatScriptBasedLibrary(FLibraries[c]);
    if ALibrary.Scripter = AScripter then
    begin
      result := true;
      ALib := ALibrary;
      break;
    end;
  end;
end;

procedure TatScript.SetOriginalScript(AScript: TatScript);
begin
  if FOriginalScript <> nil then
    FOriginalScript.FDerivedScripts.Remove(Self);
  FOriginalScript := AScript;
  if FOriginalScript <> nil then
  begin
    FOriginalScript.FDerivedScripts.Add(Self);
    FOriginalScript.Breaks.UpdateAll;
  end;
end;

procedure TatScript.DoBreakpointStop;
begin
  if Scripter <> nil then
    Scripter.DoBreakpointStop;
end;

function TatScript.RemoveLastInstruction: pSimplifiedCode;
var
  inst: pSimplifiedCode;
begin
  Dec(FCodeLine);
  inst := FFirstInstruction;
  while inst^.Next <> FLastInstruction do       
    inst := inst^.Next;
  result := FLastInstruction;
  FLastInstruction := inst;
end;

procedure TatScript.AppendInstruction(AInstruction: pSimplifiedCode);
var
  prev: pSimplifiedCode;
begin
  Inc(FCodeLine);
  prev := FLastInstruction;
  FLastInstruction := AInstruction;
  if not Assigned(prev) then
    FFirstInstruction := FLastInstruction
  else
    prev^.Next := FLastInstruction;
end;

{ TatVirtualMachine }

constructor TatVirtualMachine.Create(ACollection: TCollection);
begin
   FFastSolving := true;
   FScript := TatScript(TatVirtualMachines(ACollection).GetOwner);
   FScripter := FScript.Scripter;
   FHooking := 0;
   FOldOnException := nil;
   FExceptionRaised := nil;
// if (FScript.VirtualMachines.Count>0) and
//    (FScript.Compiled=False) then
//    FatalError('A new virtual machine cannot be created without a compiled script');

   inherited;

   FStopInstruction := nil;
   { cria a cole��o de break-points deste script }
   FBreakPoints := TatScriptBreakPoints.Create(Self);

   { cria a cole��o de watches para depura��o }
   FDebugWatches := TatDebugWatches.Create(Self,TatDebugWatch);

   { carrega a tabela de rotinas sem�nticas }
   FComputeProcs[inPrepare]            := _Prepare;
   FComputeProcs[inPushDouble]         := _PushDouble;
   FComputeProcs[inPushVar]            := _PushVar;
   FComputeProcs[inPushIdxVar]         := _PushIdxVar;
   FComputeProcs[inPushString]         := _PushString;
   FComputeProcs[inPushConst]          := _PushConst;
   FComputeProcs[inPushOutput]         := _PushOutput;
   FComputeProcs[inPushClass]          := _PushClass;
   FComputeProcs[inDuplicate]          := _Duplicate;
   FComputeProcs[inDuplicate2]         := _Duplicate2;
   FComputeProcs[inDrop2]              := _Drop2;
   FComputeProcs[inSwap2]              := _Swap2;
   FComputeProcs[inOperNE]             := _OperNE;
   FComputeProcs[inOperGE]             := _OperGE;
   FComputeProcs[inOperLE]             := _OperLE;
   FComputeProcs[inOperEqual]          := _OperEqual;
   FComputeProcs[inOperGreater]        := _OperGreater;
   FComputeProcs[inOperLess]           := _OperLess;
   FComputeProcs[inOperAdd]            := _OperAdd;
   FComputeProcs[inOperConcat]         := _OperConcat;
   FComputeProcs[inOperSub]            := _OperSub;
   FComputeProcs[inOperOr]             := _OperOr;
   FComputeProcs[inOperXor]            := _OperXor;
   FComputeProcs[inOperMul]            := _OperMul;
   FComputeProcs[inOperSlash]          := _OperSlash;
   FComputeProcs[inOperDiv]            := _OperDiv;
   FComputeProcs[inOperMod]            := _OperMod;
   FComputeProcs[inOperAnd]            := _OperAnd;
   FComputeProcs[inOperShl]            := _OperShl;
   FComputeProcs[inOperShr]            := _OperShr;
   FComputeProcs[inOperExp]            := _OperExp;
   FComputeProcs[inOperIs]             := _OperIs;
   FComputeProcs[inOperNeg]            := _OperNeg;
   FComputeProcs[inOperNot]            := _OperNot;
   FComputeProcs[inJumpIfFalse]        := _JumpIfFalse;
   FComputeProcs[inJumpIfTrue]         := _JumpIfTrue;
   FComputeProcs[inJump]               := _Jump;
   FComputeProcs[inCall]               := _Call;
   FComputeProcs[inRet]                := _Ret;
   FComputeProcs[inStoreInput]         := _StoreInput;
   FComputeProcs[inExecFun]            := _ExecFun;
   FComputeProcs[inPushInteger]        := _PushInteger;
   FComputeProcs[inTryFinally]         := _TryFinally;
   FComputeProcs[inTryExcept]          := _TryExcept;
   FComputeProcs[inCallProc]           := _CallProc;
   FComputeProcs[inCallClassProc]      := _CallClassProc;
   FComputeProcs[inPushVarByRef]       := _PushVarByRef;
   FComputeProcs[inBreakPoint]         := _BreakPoint;
   FComputeProcs[inStoreVar]           := _StoreVar;
   FComputeProcs[inStoreIdxVar]        := _StoreIdxVar;
   FComputeProcs[inStoreVarInteger]    := _StoreVarInteger;
   FComputeProcs[inStoreVarDouble]     := _StoreVarDouble;
   FComputeProcs[inStoreVarString]     := _StoreVarString;
   FComputeProcs[inStoreVarConst]      := _StoreVarConst;
   FComputeProcs[inCopyVar]            := _CopyVar;
   FComputeProcs[inStoreVarRef]        := _StoreVarRef;
   FComputeProcs[inStoreIdxVarRef]     := _StoreIdxVarRef;
   FComputeProcs[inStoreVarRefInteger] := _StoreVarRefInteger;
   FComputeProcs[inStoreVarRefDouble]  := _StoreVarRefDouble;
   FComputeProcs[inStoreVarRefString]  := _StoreVarRefString;
   FComputeProcs[inStoreVarRefConst]   := _StoreVarRefConst;
   FComputeProcs[inCopyVarRef]         := _CopyVarRef;
   FComputeProcs[inVarTest]            := _VarTest;
   FComputeProcs[inVarTestInteger]     := _VarTestInteger;
   FComputeProcs[inVarTestDouble]      := _VarTestDouble;
   FComputeProcs[inVarTestString]      := _VarTestString;
   FComputeProcs[inVarTestVar]         := _VarTestVar;
   FComputeProcs[inAbort]              := _Abort;
   FComputeProcs[inArrayOf]            := _ArrayOf;
   FComputeProcs[inCastClass]          := _CastClass;
   FComputeProcs[inWithObject]         := _WithObject;
   FComputeProcs[inStoreGlobalVar]     := _StoreGlobalVar;
   FComputeProcs[inStoreGlobalIdxVar]  := _StoreGlobalIdxVar;
   FComputeProcs[inPushGlobalVar]      := _PushGlobalVar;
   FComputeProcs[inPushGlobalIdxVar]   := _PushGlobalIdxVar;
   FComputeProcs[inPushGlobalVarByRef] := _PushGlobalVarByRef;
   FComputeProcs[inGlobalPrepare]      := _GlobalPrepare;
   FComputeProcs[inTestIfFalse]        := _TestIfFalse;
   FComputeProcs[inTestIfTrue]         := _TestIfTrue;
end;

destructor TatVirtualMachine.Destroy;
begin
   Clear;
   FDebugWatches.Free;
   FBreakPoints.Free;
   inherited;
end;

procedure TatVirtualMachine.Clear;
var
  c: integer;
begin
   { clear all runtime break points }
   FBreakPoints.Clear;

// FDebugWatches.Reset; there is a bug here, correct it!
   FRunning  := False;
   FMainBegin := nil;
   FInitialized := false;
   FInTryExcept := 0;
   {clear all variable values, including globals}
   for c := StackSize - 1 downto 0 do
     FProcStack[c] := null;
end;

function TatVirtualMachine.Execute( input:variant ):variant;
begin
   result:=ExecuteSubroutine( '',input );
end;

procedure TatVirtualMachine.CheckHalted;
begin
  if FHalted then
    FatalError('Script execution is being halted. A new execution can only start after the current execution finishes.');
end;

procedure TatVirtualMachine.InitializeScript(ADoBeforeExecute: boolean);
begin
  {do not initialize twice}
   if FInitialized then
   begin
     Exit;
   end else
   with Script do
   begin
      {only initialize if scripter is compiled}
      if not FCompiled then Exit;

      {do not initialize if script is already running}
      if Assigned(PrepareInstruction) then Exit;

      { allows an external event to prepare scripter for execution }
      if ADoBeforeExecute then
        Scripter.BeforeExecute(Self, '');
      CheckHalted;

      { check absolute addressing solving }
      if not FSolvedAddressing then SolveAbsoluteAddressing;

      {expand debug info}
      ExpandDebugInfo(false);

      FNextInstruction := nil;

      {*** script initialization ***}
      { execute all different instructions at the beginning of script, until the first iPrepare instruction }
      FCurrentInstruction := FFirstInstruction;
      while (FCurrentInstruction<>nil) and (FCurrentInstruction^.OpCode <> inPrepare) do
      begin
         FNextInstruction := FCurrentInstruction^.Next;
         FCurrentInstruction.Compute;
         FCurrentInstruction := FNextInstruction;
      end;
      FMainBegin := FCurrentInstruction;
      FInitialStackTop := FStackTop;
      FInitialized := true;
   end;
end;


function TatVirtualMachine.InternalExecuteSubroutine(AInstruction: pSimplifiedCode; AInputParamCount: integer=0): variant;
var c: integer;
    outputParamCount: integer;
    dataSize: integer;
    oldNextInstruction: pSimplifiedCode;
    oldcurrent: TatScript;
    WasRunning: boolean;
begin

  { FStackTop and FStackProc should be previously initialized }
  CheckHalted;
  result := Null;
  with Script do
  begin
     { save instruction state for reentrant calls }
     oldNextInstruction := FNextInstruction;

     { subroutine entry point checking }
     FCurrentInstruction := AInstruction;
     FNextInstruction := nil;
     if not Assigned(FCurrentInstruction) then
       Exit;
     if FCurrentInstruction^.OpCode <> inPrepare then
       RuntimeError('Invalid subroutine call. Entry point should be a "Prepare" instruction');

     { Limpa vari�veis de contexto da execu��o }
     FLastExceptionMessage:='';
     FLastExceptionHelpContext:=0;
     FLastExceptionClassName:='';
     //FHalted:=false;
     WasRunning := Script.Scripter.IsAnyRunning;
     FRunning := true;
     oldCurrent := Self.Script.Scripter.FCurrentScript;
     Self.Script.Scripter.FCurrentScript := Self.Script;
     if not Assigned(PrepareInstruction) then // not reentrant call
     begin
       { allow user event to get notifications about running state }
       DoRunningChanged;
     end;
     try
      { gets the local variable data size from inPrepare instruction }
      dataSize:=FCurrentInstruction^.vInteger;
      { runs the subroutine }
      outputParamCount:=ExecProcess(AInputParamCount)-dataSize;
      { returns output arguments }
      if outputParamCount=0 then
        result:=null
      else
        if outputParamCount=1 then
          result:=FProcStack[FStackTop+DataSize]
        else
        begin
          result:=VarArrayCreate([0,outputParamCount-1],varVariant);
          for c:=0 to outputParamCount-1 do result[c]:=FProcStack[FStackTop+DataSize+c];
        end;
      { elimina os par�metros entrada da fun��o chamada }
      Dec(FStackTop,AInputParamCount);
    finally
      if not Assigned(PrepareInstruction) then // not reentrant call
      begin
         FNextInstruction := nil;
         {$IFNDEF LINUX}
         VarClear(FCurrentOleObject);
         {$ENDIF}
         FRunning:=false;
         { allow user event to get notifications about running state }
         DoRunningChanged;
      end
      else
      { retrieve instruction state for reentrant calls }
      begin
        FNextInstruction := oldNextInstruction;
      end;
      Self.Script.Scripter.FCurrentScript := oldCurrent;
      if not WasRunning then
        Paused := false;
    end;
  end;
  FHalted := false;
end;

function TatVirtualMachine.ExecuteSubroutine( ALabel:string; input:variant ):variant;
var c                  : integer;
    InputParamCount    : integer;
    OutputParamCount   : integer;
    DataSize           : integer;
    oldNextInstruction : pSimplifiedCode;
    _StackTop          : integer;
    oldCurrent: TatScript;
    WasRunning: boolean;
begin
   with Script do
   begin
      { permite que um evento externo possa preparar o scripter para uma execu��o }
      Scripter.BeforeExecute(Self,ALabel);

      CheckHalted;

      { se a vari�vel PrepareInstruction estiver com algum valor ent�o um script
        j� est� em execu��o, portanto esta chamada � re-entrante (n�o devendo
        interferir com a execu��o j� disparada) }

      { verifica se o m�todo compile j� foi chamado, sen�o chama-o automaticamente }
      if not FCompiled then Compile;
      { verifica se o endere�amento absoluto j� foi resolvido, sen�o resolve-o automaticamente }
      if not FSolvedAddressing then SolveAbsoluteAddressing;

      {Expand debug information}
      ExpandDebugInfo;

      if (ALabel > '') and (ScriptInfo.RoutineByName(ALabel) = nil) then
        RuntimeError(Format('Subroutine ''%s'' does not exist in script',[ALabel]));


      { Limpa vari�veis de contexto da execu��o }
      FLastExceptionMessage := '';
      FLastExceptionHelpContext := 0;
      FLastExceptionClassName := '';

      oldNextInstruction := FNextInstruction;

      //FHalted := False;
      WasRunning := Script.Scripter.IsAnyRunning;
      FRunning := True;
      oldCurrent := Self.Script.Scripter.FCurrentScript;
      Self.Script.Scripter.FCurrentScript := Self.Script;
      if not Assigned(PrepareInstruction) then // not reentrat call
      begin
         { allow user event to get notifications about running state }
         DoRunningChanged;
         { runtime stack initialization }
         for c := ScriptInfo.Globals.Count to StackSize - 1 do FProcStack[c] := null;

          if not FInitialized then
          begin
            _StackTop := 0;
            FStackTop := 0;
            InitializeScript(false);
          end
          else
          begin
            _StackTop := FInitialStackTop;
            FStackTop := FInitialStackTop;
            FNextInstruction := FMainBegin;
          end;
      end
      else
      begin
         { temos que dar uma posi��o de pilha livre para altera��es (para frente)
           para o processo que vai ser chamado (ExecProcess).
           Para n�o interferir com a pilha do processo chamador vamos utilizar
           o ponteiro mais distante que temos (OutputBase) }
         _StackTop := FStackTop;
         FStackTop := FOutputBase;
      end;
      { prepara��o do ponteiro para a primeira instru��o da rotina a ser executada }
      if ALabel > '' then
        FCurrentInstruction := EntryPoint(ALabel)
      else
        FCurrentInstruction := FMainBegin;
      if not Assigned(FFirstInstruction) then
      begin
         result := Null;
         Exit;
      end;
      if FCurrentInstruction^.OpCode <> inPrepare then
         RuntimeError('Invalid subroutine call. Entry point should be a "Prepare" instruction');

      try
         { load input arguments }
         if not VarIsNull(input) then
         begin
            if VarIsArray(input) then
            begin
               InputParamCount := VarArrayHighBound(input,1)+1;
               for c := 0 to InputParamCount - 1 do
                 FProcStack[FStackTop + c] := Input[c];
            end
            else
            begin
               InputParamCount:=1;
               FProcStack[FStackTop]:=input;
            end;
            inc(FStackTop,InputParamCount)
         end
         else
            InputParamCount := 0;
         { gets the local variable data size from inPrepare instruction }
         DataSize := FCurrentInstruction^.vInteger;
         { runs the subroutine }
         OutputParamCount := ExecProcess(InputParamCount)-DataSize;
         { returns output arguments }
         if OutputParamCount=0 then
            result:=null
         else
            if OutputParamCount=1 then
               result:=FProcStack[FStackTop+DataSize]
            else
            begin
               result:=VarArrayCreate([0,OutputParamCount-1],varVariant);
               for c:=0 to OutputParamCount-1 do result[c]:=FProcStack[FStackTop+DataSize+c];
            end;
         { elimina os par�metros entrada da fun��o chamada }
         Dec(FStackTop,InputParamCount);
      finally
         if not Assigned(PrepareInstruction) then // not reentrant call
         begin
            FNextInstruction := nil;
            { limpa a pilha de variants usada pelo processo }
            for c := StackSize - 1 downto ScriptInfo.Globals.Count do VarClear(FProcStack[c]);
            {$IFNDEF LINUX}
            VarClear(FCurrentOleObject);
            {$ENDIF}
            FRunning:=false;
            { allow user event to get notifications about running state }
            DoRunningChanged;
         end
         else
         begin
           { retrieve instruction state for reentrant calls }
           FNextInstruction := oldNextInstruction;
           { restore the stack-top of the process that was interrupted by this call }
           FStackTop := _StackTop;
         end;
         if not WasRunning then
           Paused := false;
         Self.Script.Scripter.FCurrentScript := oldCurrent;
      end;
   end;
   FHalted := false;
end;

function TatVirtualMachine.ExecuteSubroutine(ALabel: string; input: array of const): variant;
var c : integer;
    paramCount : integer;
    _StackTop : integer;
begin
   with Script do
   begin
     { permite que um evento externo possa preparar o scripter para uma execu��o }
     Scripter.BeforeExecute(Self,ALabel);

     CheckHalted;
     { se a vari�vel PrepareInstruction estiver com algum valor ent�o um script
       j� est� em execu��o, portanto esta chamada � re-entrante (n�o devendo
       interferir com a execu��o j� disparada) }

     { verifica se o m�todo compile j� foi chamado, sen�o chama-o automaticamente }
     if not FCompiled then Compile;
     { verifica se o endere�amento absoluto j� foi resolvido, sen�o resolve-o automaticamente }
     if not FSolvedAddressing then SolveAbsoluteAddressing;

     {Expand debug information}
     ExpandDebugInfo;

     if (ALabel > '') and (ScriptInfo.RoutineByName(ALabel) = nil) then
       RuntimeError(Format('Subroutine ''%s'' does not exist in script',[ALabel]));

     _StackTop := 0;
     try
        if not Assigned(PrepareInstruction) then // not reentrat call
        begin
          { runtime stack initialization }
          for c := ScriptInfo.Globals.Count to StackSize-1 do FProcStack[c] := Null;

          if not FInitialized then
          begin
            FStackTop := 0;
            InitializeScript(false);
          end
          else
          begin
            FStackTop := FInitialStackTop;
            FNextInstruction := FMainBegin;
          end;
        end
        else
        begin
          { temos que dar uma posi��o de pilha livre para altera��es (para frente)
            para o processo que vai ser chamado (ExecProcess).
            Para n�o interferir com a pilha do processo chamador vamos utilizar
            o ponteiro mais distante que temos (OutputBase) }
          _StackTop := FStackTop;
          FStackTop := FOutputBase;
        end;

        { load input arguments }
        paramCount := High(input) + 1;
        for c := 0 to paramCount - 1 do
        begin
          { if argument is a variant then pass it by reference to the routine }
          if input[c].VType = vtVariant then
          begin
            VarClear(FProcStack[FStackTop]);
            { argument by reference }
            with TVarData(FProcStack[FStackTop]) do
            begin
              VType := varVariant or varByRef;
              VPointer := input[c].VVariant;
            end;
          end
          else
            { argument by value }
            FProcStack[FStackTop] := VariantFromVarRec( input[c] );
          Inc(FStackTop);
        end;

        { execute a subroutine or the main block }
        if ALabel>'' then
          result := InternalExecuteSubroutine( EntryPoint(ALabel), paramCount )
        else
          result := InternalExecuteSubroutine( FMainBegin, paramCount );

      finally
        { clear internal stack before return (dealocate variants) }
        if not Assigned(PrepareInstruction) then // not reentrant call
           for c:=StackSize - 1 downto ScriptInfo.Globals.Count do VarClear(FProcStack[c])
        else
          { restore the stack-top of the process that was interrupted by this call }
          FStackTop := _StackTop;
      end;
   end;
   FHalted := false;
end;

function TatVirtualMachine.ExecProcess( ParamCount:integer ):integer;
var OldStackTop           : integer;
    OldStackBase          : integer;
    OldInputBase          : integer;
    OldOutputBase         : integer;
    OldInputOffset        : integer;
    OldOutputOffset       : integer;
    OldPrepareInstruction : pSimplifiedCode;
    OldCurrentInputArgBase   : integer;
    OldCurrentArrayIndexBase : integer;
    OldCurrentOutputArgIndex : integer;
    ReturnInstruction     : pSimplifiedCode;
begin
   result:=-1;
   try
      { preserva os apontadores do processo anterior }
      OldStackTop:=FStackTop;
      OldStackBase:=FStackBase;
      OldInputBase:=FInputBase;
      OldOutputBase:=FOutputBase;
      OldInputOffset:=FInputOffset;
      OldOutputOffset:=FOutputOffset;
      OldPrepareInstruction:=FPrepareInstruction;
      OldCurrentInputArgBase := FCurrentInputArgBase;
      OldCurrentArrayIndexBase := FCurrentArrayIndexBase;
      OldCurrentOutputArgIndex := FCurrentOutputArgIndex;

      { salva endere�o de retorno }
      ReturnInstruction := FNextInstruction;
      { posiciona apontadores para os par�metros do processo }
      FInputBase:=FStackTop-ParamCount;
      FInputOffset:=0;
      { posiciona o in�cio das vari�veis locais }
      FStackBase:=FStackTop;
      try
         while FCurrentInstruction<>nil do
         begin
            FNextInstruction := FCurrentInstruction^.Next;
            FCurrentInstruction.Compute;
            if FAutoPause then
              if FAutoPauseCurLine <> DebugExecutionLine then
              begin
                FPaused := true;
                FAutoPause := false;
              end;
            if FPaused then DoDebugHook;
            if FCallExecHookEvent then DoExecHook;
            FCurrentInstruction := FNextInstruction;
         end;
      finally
         if not FHalted then
            { executa a instru��o subseq�ente a chamada ao ExecProcess (call-ret) }
            FNextInstruction := ReturnInstruction;
         { retorna o n�mero de argumentos de sa�da gerados nesta rotina }
         result:=FStackTop-OldStackTop;
         { restaura os apontadores do processo anterior }
         FPrepareInstruction:=OldPrepareInstruction;
         FStackTop:=OldStackTop;
         FStackBase:=OldStackBase;
         FInputBase:=OldInputBase;
         FOutputBase:=OldOutputBase;
         FInputOffset:=OldInputOffset;
         FOutputOffset:=OldOutputOffset;
         FCurrentInputArgBase := OldCurrentInputArgBase;
         FCurrentArrayIndexBase := OldCurrentArrayIndexBase;
         FCurrentOutputArgIndex := OldCurrentOutputArgIndex;
      end;
   except
      on ex:Exception do
         if not HandleScriptRunException(ex) then raise;
   end;
end;

function TatVirtualMachine.GetStackContentAsString:string;
var c,i: integer;
begin
   result:='';
   if FStackTop>4 then i:=FStackTop-4 else i:=0;
   for c:=FStackTop-1 downto i do
      if result>'' then
         result:=result+','+VarContent(FProcStack[c])
      else
         result:=VarContent(FProcStack[c]);
   if FStackTop>4 then result:=result+'...';
end;

function TatVirtualMachine.HandleScriptRunException(ex:Exception):boolean;
begin
   if FInTryExcept > 0 then
   begin
     result := false;
     Exit;
   end;
   { Atualiza o contexto da exce��o para uso em runtime }
   FLastExceptionMessage:=ex.message;
   FLastExceptionHelpContext:=ex.HelpContext;
   FLastExceptionClassName:=ex.ClassName;
   { tratamento default para exce��es }
   if (ex is EatScripterRuntime) or (ex is EAbort) then
      { exce��es de runtime s�o apresentados como foram geradas }
      result:=false
   else
   begin
      result:=true;
      { outras exce��es s�o apresentadas com informa��es sobre a execu��o }
      if Assigned(FCurrentInstruction) then
         with FCurrentInstruction^ do
            RuntimeError( Format(
               '%s when evaluating instruction %s ($%X,$%X,$%X,$%X,''%s'').'#13#10+
               'Stack content is: [%s]'+Script.ErrorComplement(vDebugInfo),
               [ ex.message,
                 copy(GetEnumName(TypeInfo(TInstruction),integer(OpCode)),3,MaxInt),
                 vInteger,
                 vByte,
                 vInteger2,
                 vInteger3,
                 vString,
                 GetStackContentAsString ]) )
      else
         RuntimeError('Undefined instruction');
   end;
end;

function TatVirtualMachine.TranslateClass(AClassIndex: integer): Tclass;
begin
  {$WARNINGS OFF}
  if AClassIndex < 0 then
    result := TatClass(-AClassIndex).FClassRef
  else
    result := TClass(AClassIndex);
 {$WARNINGS ON}
end;

{--- debugging features ---}

procedure TatVirtualMachine.Halt;
begin
   { Provoca a finaliza��o imediata do script, sem possibilidade de continua��o }
   FCurrentInstruction:=nil;
   FNextInstruction := nil;
   {Only set FHalted flag if script is running}
   FHalted := FRunning;
   Paused := false;
end;

function TatVirtualMachine.GetArrayIndex(ADim:integer):variant;
begin
   { retorna o valor do �ndice de entrada correspondente a dimens�o dada }
   result:=FProcStack[FCurrentArrayIndexBase+ADim];
end;

function TatVirtualMachine.InputArgCount: integer;
begin
  result := FCurrentInstruction^.vByte;
end;

function TatVirtualMachine.GetInputArg(AIndex:integer):variant;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   { retorna o conte�do do variant, mesmo se ele for uma refer�ncia }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result:=FProcStack[FCurrentInputArgBase+AIndex]
      else
         result:=Variant(VPointer^);
end;

function TatVirtualMachine.GetInputArgAsString(AIndex:integer):string;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result:=VarToStr(FProcStack[FCurrentInputArgBase+AIndex])
      else
         result:=VarToStr(Variant(VPointer^));
end;

function TatVirtualMachine.GetInputArgAsClass(AIndex: integer): TClass;
var
  AClassIndex: integer;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   with TVarData(FProcStack[FCurrentInputArgBase + AIndex]) do
      if VType and varByRef = 0 then
         AClassIndex := VarToInteger(FProcStack[FCurrentInputArgBase + AIndex])
      else
         AClassIndex := VarToInteger(PVariant(VPointer)^);

  result := TranslateClass(AClassIndex);
end;

function TatVirtualMachine.GetInputArgAsWidestring(AIndex: integer): widestring;
begin
  {$IFDEF DELPHI7_LVL}
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result:=VarToWideStr(FProcStack[FCurrentInputArgBase+AIndex])
      else
         result:=VarToWideStr(Variant(VPointer^));
  {$ELSE}
  result := GetInputArgAsString(AIndex);
  {$ENDIF}
end;

function TatVirtualMachine.GetInputArgAsInteger(AIndex:integer):integer;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result:=VarToInteger(FProcStack[FCurrentInputArgBase+AIndex])
      else
         result:=VarToInteger(PVariant(VPointer)^);
end;

function TatVirtualMachine.GetInputArgAsChar(AIndex:integer): char;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result := VarToChar(FProcStack[FCurrentInputArgBase+AIndex])
      else
         result := VarToChar(PVariant(VPointer)^);
end;

function TatVirtualMachine.GetInputArgAsWideChar(AIndex:integer): WideChar;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result := VarToWideChar(FProcStack[FCurrentInputArgBase+AIndex])
      else
         result := VarToWideChar(PVariant(VPointer)^);
end;

function TatVirtualMachine.GetInputArgAsBoolean(AIndex:integer):boolean;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result:=VarToInteger(FProcStack[FCurrentInputArgBase+AIndex])<>0
      else
         result:=VarToInteger(Variant(VPointer^))<>0;
end;

function TatVirtualMachine.GetInputArgAsFloat(AIndex:integer):double;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result:=VarToFloat(FProcStack[FCurrentInputArgBase+AIndex])
      else
         result:=VarToFloat(Variant(VPointer^));
end;

function TatVirtualMachine.GetInputArgAsDateTime(AIndex:integer):TDateTime;
begin
   { retorna o valor do par�metro de entrada indicado por FCurrentInputArgBase }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         result:=VarToDateTime(FProcStack[FCurrentInputArgBase+AIndex])
      else
         result:=VarToDateTime(Variant(VPointer^));
end;

procedure TatVirtualMachine.ReturnOutputArg(AValue:variant);
begin
   { grava o valor do par�mentro indicado por AValue como retorno da subrotina corrente }
   FProcStack[FOutputBase] := AValue;
end;

{$IFDEF DELPHI2010_LVL}
procedure TatVirtualMachine.ReturnOutputArgValue(AValue: TValue);
var
  recWrapper: TGenericRecordWrapper;
begin
  if AValue.IsObject then
    ReturnOutputArg(integer(AValue.AsObject))
  else if AValue.Kind = TypInfo.tkRecord then
  begin
    recWrapper := TGenericRecordWrapper.Create(AValue.TypeInfo);
    AValue.ExtractRawData(recWrapper.FRecord);
    FCurrentRecordName := string(AValue.TypeInfo.Name);
    ReturnOutputArg(integer(recWrapper));
  end
  else if AValue.TypeInfo = TypeInfo(Boolean) then
    ReturnOutputArg(AValue.AsBoolean)
  else if AValue.IsOrdinal then
    ReturnOutputArg(AValue.AsOrdinal)
  else
    ReturnOutputArg(AValue.AsVariant);
end;
{$ENDIF}

procedure TatVirtualMachine.SetInputArgIfByRef(AIndex:integer;const AValue:variant);
begin
   { armazena AValue no argumento de entrada indicado por AIndex  }

   { se o conte�do do variant for uma refer�ncia modifica apenas o conte�do desta
     refer�ncia, do contr�rio n�o faz nada }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef<>0 then
         PVariant(VPointer)^:=AValue
end;

{$IFDEF DELPHI2010_LVL}
procedure TatVirtualMachine.SetInputArgValue(AIndex: integer; const AValue: TValue);
begin
  if AValue.IsObject then
    SetInputArg(AIndex, integer(AValue.AsObject))
  else if AValue.IsType<integer> then
    SetInputArg(AIndex, AValue.AsInteger)
  else if AValue.IsOrdinal then
    SetInputArg(AIndex, AValue.AsOrdinal)
  else
    SetInputArg(AIndex, AValue.AsVariant);
end;
{$ENDIF}

function TatCustomScripter.ExecuteSubroutine( ALabel:string; input:variant ):variant;
var
  AMachine: TatVirtualMachine;
begin
   if (Length(ALabel) > 0) and (ALabel[1] = '[') then
   begin
     GetInfoFromRoutineName(ALabel, AMachine);
     if AMachine <> nil then
       result := AMachine.ExecuteSubroutine(ALabel, input);
   end
   else
     if Assigned(FCurrentScript.VirtualMachine) then
        result:=FCurrentScript.VirtualMachine.ExecuteSubroutine( ALabel, input );
end;

function TatCustomScripter.ExecuteSubroutine( ALabel:string ):variant;
var
  AMachine: TatVirtualMachine;
begin
   if (Length(ALabel) > 0) and (ALabel[1] = '[') then
   begin
     GetInfoFromRoutineName(ALabel, AMachine);
     if AMachine <> nil then
       result := AMachine.ExecuteSubroutine(ALabel, NULL);
   end else
     if Assigned(FCurrentScript.VirtualMachine) then
        result:=FCurrentScript.VirtualMachine.ExecuteSubroutine( ALabel, NULL );
end;


function TatCustomScripter.ExecuteSubroutine(ALabel: string; input: array of const): variant;
var
  AMachine: TatVirtualMachine;
begin
   if (Length(ALabel) > 0) and (ALabel[1] = '[') then
   begin
     GetInfoFromRoutineName(ALabel, AMachine);
     if AMachine <> nil then
       result := AMachine.ExecuteSubroutine(ALabel, input);
   end else
     if Assigned(FCurrentScript.VirtualMachine) then
        result:=FCurrentScript.VirtualMachine.ExecuteSubroutine( ALabel, input );
end;

procedure TatCustomScripter.GetInfoFromRoutineName(var RName: string; var AMachine: TatVirtualMachine);
var
  AScript: TatScript;
  P: integer;
begin
  {for speed purposes, consider that the routinename is already in format "[1234123]RoutineName"}
  P := Pos(']', RName);
  AScript := TatScript(StrToInt(Copy(RName, 2, P - 2)));
  RName := Copy(RName, P + 1, MaxInt);
  if AScript <> nil then
    AMachine := AScript.VirtualMachine
  else
    AMachine := nil;
end;

function TatScript._FindClass(idx: integer; AName: string): TatClass;
var
  i1: integer;
  i2: integer;
begin
  result := nil;
  if (idx >= 0) and (idx < Scripter.FClasses.Count) and SameText(Scripter.FClasses[idx].Name, AName) then
    result := Scripter.FClasses[idx]
  else
  begin
    i1 := idx - 1;
    i2 := idx + 1;
    while (result = nil) and ((i1 >= 0) or (i2 < Scripter.FClasses.Count)) do
    begin
      if i1 >= 0 then
        if SameText(Scripter.FClasses[i1].Name, AName) then
          result := Scripter.FClasses[i1];
      if i2 < Scripter.FClasses.Count then
        if SameText(Scripter.FClasses[i2].Name, AName) then
          result := Scripter.FClasses[i2];
      dec(i1);
      inc(i2);
    end;
  end;
  if result = nil then
    RuntimeError(Format('Error in loaded compiled code: Class "%s" not registered', [AName]));
end;

function TatScript._FindMethod(AClass: TatClass; idx: integer; AName: string): TatMethod;
var
  i1, i2: integer;
begin
  result := nil;
  if (idx >= 0) and (idx < AClass.Methods.Count) and SameText(AClass.Methods[idx].Name, AName) then
    result := AClass.Methods[idx]
  else
  begin
    i1 := idx - 1;
    i2 := idx + 1;
    while (result = nil) and ((i1 >= 0) or (i2 < AClass.Methods.Count)) do
    begin
      if i1 >= 0 then
        if SameText(AClass.Methods[i1].Name, AName) then
          result := AClass.Methods[i1];
      if i2 < AClass.Methods.Count then
        if SameText(AClass.Methods[i2].Name, AName) then
          result := AClass.Methods[i2];
      dec(i1);
      inc(i2);
    end;
  end;
  if result = nil then
    RuntimeError(Format('Error in loaded compiled code: Method "%s.%s" not registered', [AClass.Name, AName]));
end;

function TatScript._FindProperty(AClass: TatClass; idx: integer; AName: string): TatProperty;
var
  i1, i2: integer;
begin
  result := nil;
  if (idx >= 0) and (idx < AClass.Properties.Count) and SameText(AClass.Properties[idx].Name, AName) then
    result := AClass.Properties[idx]
  else
  begin
    i1 := idx - 1;
    i2 := idx + 1;
    while (result = nil) and ((i1 >= 0) or (i2 < AClass.Properties.Count)) do
    begin
      if i1 >= 0 then
        if SameText(AClass.Properties[i1].Name, AName) then
          result := AClass.Properties[i1];
      if i2 < AClass.Properties.Count then
        if SameText(AClass.Properties[i2].Name, AName) then
          result := AClass.Properties[i2];
      dec(i1);
      inc(i2);
    end;
  end;

  if result = nil then
    RuntimeError(Format('Error in loaded compiled code: Property "%s.%s" not registered', [AClass.Name, AName]));
end;

procedure TatVirtualMachine.SetInputArg(AIndex:integer;const AValue:variant);
begin
   { armazena AValue no argumento de entrada indicado por AIndex  }

   { se o conte�do do variant for uma refer�ncia modifica apenas o conte�do desta
     refer�ncia, do contr�rio n�o faz nada }
   with TVarData(FProcStack[FCurrentInputArgBase+AIndex]) do
      if VType and varByRef=0 then
         RuntimeError(Format('Method expects argument %d as variable reference',[AIndex]))
      else
         PVariant(VPointer)^:=AValue
end;

function TatVirtualMachine.InstructionByLine(ARow: integer): pSimplifiedCode;
begin
   { varre as instru��es compiladas para encontrar a primeira instru��o
     correspondente a linha do programa-fonte indicada }
   result:=Script.FFirstInstruction;
   while result<>nil do
   begin
      if (ARow=result^.vDebugInfo and $FFFFF) then Exit;
      result:=result^.Next;
   end;
   result:=nil;
end;

function TatVirtualMachine.EntryPoint( ALabel: string): pSimplifiedCode;
begin
  { search instructions to find routine name
    (*** would be better if search by RoutineInfo -> future ***) }

  result := Script.FFirstInstruction;
  { search subroutine start instruction (inPrepare) }
  while Assigned(result) and
        ((result^.OpCode<>inPrepare) or
         (CompareText(result^.vString,ALabel)<>0)) do
        result := result^.Next;

  { se n�o encontrou a subrotina ent�o gera uma exce��o de runtime }
  if not Assigned(result) then
     RuntimeError(Format('Subroutine ''%s'' does not exist in script',[ALabel]));
end;

procedure TatVirtualMachine.DebugTraceInto;
begin
   { continua a execu��o do script em modo pausado }
   if FPaused then
   begin
      FCurrentInstruction := FNextInstruction;
      if FCurrentInstruction<>nil then
      begin
         FNextInstruction := FCurrentInstruction^.Next;
         FCurrentInstruction.Compute;
      end
      else
         Paused := false;
   end;
   Script.Scripter.SingleDebugHook(Self);
end;

procedure TatVirtualMachine.DebugStepOver;
begin
   { executa apenas uma instru��o sem pausa }
   if FPaused then
   begin
      Paused := false;
      FCurrentInstruction := FNextInstruction;
      if FCurrentInstruction<>nil then
      begin
         FNextInstruction := FCurrentInstruction^.Next;
         FCurrentInstruction.Compute;
         Paused := true;
      end
      else
         Paused := false;
   end;
   Script.Scripter.SingleDebugHook(Self);
end;

procedure TatVirtualMachine.DebugTraceIntoLine;
begin
   { execute TraceInto em n�vel de linha do programa-fonte }
   if FPaused then
   begin
      FAutoPause := true;
      FAutoPauseCurLine := DebugExecutionLine;
      FPaused := false;

      {line := DebugExecutionLine;
      repeat
         FCurrentInstruction := FNextInstruction;
         if FCurrentInstruction <> nil then
         begin
            FNextInstruction := FCurrentInstruction^.Next;
            FCurrentInstruction.Compute;
         end
         else
            Break;
      until (line<>DebugExecutionLine);}
   end;
   Script.Scripter.SingleDebugHook(Self);
end;

procedure TatVirtualMachine.DebugStepOverLine;
var line: integer;
begin
   { execute StepOver em n�vel de linha do programa-fonte }
   if FPaused then
   begin
      line:=DebugExecutionLine;
      Paused := false;
      repeat
         FCurrentInstruction := FNextInstruction;
         if FCurrentInstruction<>nil then
         begin
            FNextInstruction := FCurrentInstruction^.Next;
            FCurrentInstruction.Compute;
         end
         else
            Break;
      until (line<>DebugExecutionLine);
      Paused := true;
   end;
   Script.Scripter.SingleDebugHook(Self);
end;

procedure TatVirtualMachine.DebugRunUntilReturn;
begin
   { executa instru��es do script at� encontrar o
     retorno do bloco corrente }
   if FPaused then
   begin
      Paused := false;
      FCurrentInstruction := FNextInstruction;
      if FCurrentInstruction<>nil then
      begin
         while FCurrentInstruction<>nil do
         begin
            FNextInstruction := FCurrentInstruction^.Next;
            FCurrentInstruction.Compute;
            if FAutoPause then
              if FAutoPauseCurLine <> DebugExecutionLine then
              begin
                FPaused := true;
                FAutoPause := false;
              end;
            if FPaused then DoDebugHook;
            FCurrentInstruction := FNextInstruction;
         end;
         Paused := true;
      end
      else
         Paused := false;
   end;
   Script.Scripter.SingleDebugHook(Self);
end;

procedure TatVirtualMachine.DebugRunToPoint(AInstruction:pSimplifiedCode);
begin
   { insere uma paraliza��o auto-destrut�vel na linha indicada }
   FBreakPoints.InsertTempBreak( AInstruction );
   Paused := false;
   Script.Scripter.Running := true;
   Script.Scripter.SingleDebugHook(Self);
end;

procedure TatVirtualMachine.DebugRunToLine(ALine:integer);
begin
   { insere uma paraliza��o auto-destrut�vel na linha indicada }
   with Script.Breaks.Add do
   begin
     Line := ALine;
     FAutoDestroy := true;
   end;
   Paused := false;
   Script.Scripter.Running := true;
   Script.Scripter.SingleDebugHook(Self);
   //DebugRunToPoint( InstructionByLine(ALine) );
end;

function TatVirtualMachine.DebugToggleBreakPoint(AInstruction:pSimplifiedCode):boolean;
begin
   if Assigned(AInstruction) then
   begin
      { se a instru��o j� for um break point ent�o a remove, sen�o a define como break }
      result:=FBreakPoints.RemoveBreakPoint(AInstruction);
      if not result then
         FBreakPoints.InsertNormalBreak( AInstruction );
   end
   else
      result:=false;
end;

function TatVirtualMachine.DebugToggleBreakLine(ALine:integer):pSimplifiedCode;
begin
  result := InstructionByLine(ALine);
  DebugToggleBreakPoint(result);
end;

procedure TatVirtualMachine.AppException(Sender: TObject; E: Exception);
begin
  FExceptionRaised := ExceptClass(E.ClassType).CreateHelp(E.Message, E.HelpContext);
end;

procedure TatVirtualMachine.DoExecHook;
begin
  if Assigned(FOnExecHook) then
    FOnExecHook(Self);
end;

procedure TatVirtualMachine.DoDebugHook;
begin
   { Allow an user callback to implement things while script is being debugged }
   Inc(FHooking);
   if FHooking = 1 then
   begin
     FOldOnException := Application.OnException;
     Application.OnException := AppException;
   end;
   try
      Script.Scripter.SingleDebugHook(Self);
      repeat
         if not Script.Scripter.DoDebugHook(Self) then
         begin
           if GetCurrentThreadID = MainThreadID then
             Application.HandleMessage;
         end;
      until not FPaused or (FNextInstruction=nil) or (FNextInstruction = FStopInstruction) or
        (FExceptionRaised <> nil);
      if FExceptionRaised <> nil then
      try
        raise FExceptionRaised;
      finally
        FExceptionRaised := nil;
      end;
   finally
     Dec(FHooking);
     if FHooking = 0 then
     begin
       Application.OnException := FOldOnException;
     end;
   end;
end;

function TatVirtualMachine.DebugExecutionLine: integer;
begin
   if Assigned(FNextInstruction) then
      result := FNextInstruction^.vDebugInfo and $FFFFF
   else
      result:=-1;
end;

procedure TatVirtualMachine.SetRunning(const Value: boolean);
begin
   { Controla a execu��o do script }
   if FRunning<>Value then
   begin
      if Value then
         Execute(null)
      else
         Halt;
   end;
end;

procedure TatVirtualMachine.SetPaused(const Value: boolean);
begin
   if FPaused <> Value then
   begin
      {Set this machine, and all other machines to the specified paused value}
      FPaused := Value;
      Script.Scripter.SetPaused(Value);
      if Assigned(FOnPauseChanged) then
         FOnPauseChanged(self);
   end;
end;

{-----------------------------------------------------------------------------}
{ Fun��es da sem�ntica do compilador (pseudo-c�digo de m�quina)               }
{ Implementa��o das instru��es do SimplifiedCode                              }
{-----------------------------------------------------------------------------}

procedure TatVirtualMachine._Prepare;
var
  c: integer;
begin
   {allocate space in the stack for all local variables of current process}
   FStackTop:=FStackTop+FCurrentInstruction^.vInteger;

   {initialize local variables to null}
   for c := FStackTop - FCurrentInstruction^.vInteger to FStackTop - 1 do
     FProcStack[c] := NULL;

   { atualiza o apontador da primeira instru��o do processo corrente (inPrepare) }
   FPrepareInstruction:=FCurrentInstruction;
end;

procedure TatVirtualMachine._GlobalPrepare;
begin
   { aloca espa�o no FStack para todas as vari�veis globais do processo corrente }
   FStackTop := FStackTop + FCurrentInstruction^.vInteger;
end;

procedure TatVirtualMachine._PushDouble;
begin
   { empilha um n�mero real no FStack }
   FProcStack[FStackTop]:=FCurrentInstruction^.vDouble;
   inc(FStackTop);
end;

procedure TatVirtualMachine._PushVar;
begin
   { empilha o valor da vari�vel no FStack }
   with TVarData( FProcStack[FStackBase+FCurrentInstruction^.vInteger] ) do
      if VType and varByRef=0 then
         FProcStack[FStackTop] := FProcStack[FStackBase+FCurrentInstruction^.vInteger]
      else
         FProcStack[FStackTop] := PVariant(VPointer)^;
   inc(FStackTop);
end;

procedure TatVirtualMachine._PushIdxVar;
begin
   { empilha o elemento indexado da vari�vel }
   with FCurrentInstruction^ do
   begin
      dec(FStackTop,vByte);
      FProcStack[FStackTop] := GetVarArrayElement( FProcStack[FStackBase+FCurrentInstruction^.vInteger], 1 );
      inc(FStackTop);
   end;
end;

procedure TatVirtualMachine._PushVarByRef;
begin
   { empilha a refer�ncia para uma vari�vel local no FStack }
   VarClear(FProcStack[FStackTop]);
   TVarData(FProcStack[FStackTop]).VType := varVariant or varByRef;
   with TVarData( FProcStack[FStackBase+FCurrentInstruction^.vInteger] ) do
      if VType and varByRef=0 then
         TVarData(FProcStack[FStackTop]).VPointer := @FProcStack[FStackBase+FCurrentInstruction^.vInteger]
      else
         TVarData(FProcStack[FStackTop]).VPointer := VPointer;
   Inc(FStackTop);
end;

procedure TatVirtualMachine._PushString;
begin
   { empilha uma string no FStack }
   FProcStack[FStackTop]:=FCurrentInstruction^.vString;
   inc(FStackTop);
end;

procedure TatVirtualMachine._PushConst;
begin
   { empilha uma string no FStack }
   case CORE_CONST(FCurrentInstruction^.vByte) of
      coNull: FProcStack[FStackTop]:=null;
      coTrue: FProcStack[FStackTop]:=true;
      coFalse: FProcStack[FStackTop]:=false;
      coUnassigned: FProcStack[FStackTop]:=Unassigned;
      coNil: FProcStack[FStackTop]:=0;
   end;
   inc(FStackTop);
end;

procedure TatVirtualMachine._PushOutput;
begin
   { empilha o valor do par�mentro de sa�da do processo chamado }
   FProcStack[FStackTop]:=FProcStack[FOutputBase+FCurrentInstruction^.vInteger];
   inc(FStackTop);
end;

procedure TatVirtualMachine._PushClass;
begin
  with Script, FCurrentInstruction^ do
  begin
    { resolve a refer�ncia de classe caso ainda n�o tenha sido resolvida }
    if vInteger = 0 then
    begin
      vInteger := integer(Scripter.Classes.ClassByName(vString));
      if vInteger > 0 then
      begin
        if CompareText(TatClass(vInteger).FClassRef.ClassName, vString) = 0 then
          vInteger := integer( TatClass(vInteger).FClassRef )
        else //Else, keep the vInteger as a reference to a TatClass object
          vInteger := -vInteger;
      end
      else
        RuntimeError(Format('Invalid class reference ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
    end;
    { empilha o refer�ncia de classe }
    FProcStack[FStackTop] := vInteger;
  end;
  inc(FStackTop);
end;

procedure TatVirtualMachine._Duplicate; // obsolete
begin
   { duplica o topo do FStack }
   FProcStack[FStackTop]:=FProcStack[FStackTop-1];
   inc(FStackTop);
end;

procedure TatVirtualMachine._Duplicate2; // obsolete
begin
   { duplica os dois valores de topo do FStack }
   FProcStack[FStackTop]:=FProcStack[FStackTop-2];
   FProcStack[FStackTop+1]:=FProcStack[FStackTop-1];
   inc(FStackTop,2);
end;

procedure TatVirtualMachine._Drop2; // obsolete
begin
   { elimina os dois valores de topo do FStack }
   dec(FStackTop,2);
end;

procedure TatVirtualMachine._Swap2; // obsolete
var aux : Variant;
begin
   { troca os dois valore de topo do FStack }
   aux:=FProcStack[FStackTop-1];
   FProcStack[FStackTop-1]:=FProcStack[FStackTop-2];
   FProcStack[FStackTop-2]:=aux;
end;

procedure TatVirtualMachine._OperNE;
begin
   { compara dois valores de topo do FStack }
   { devolvendo 1 se o primeiro � diferente do segundo , e 0 em caso contr�rio }
   FProcStack[FStackTop-2]:=(FProcStack[FStackTop-2]<>FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperGE;
begin
   { compara dois valores de topo do FStack }
   { devolvendo 1 se o primeiro � maior ou igula ao segundo , e 0 em caso contr�rio }
   FProcStack[FStackTop-2]:=(FProcStack[FStackTop-2]>=FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperLE;
begin
   { compara dois valores de topo do FStack }
   { devolvendo 1 se o primeiro � menor ou igual ao segundo , e 0 em caso contr�rio }
   FProcStack[FStackTop-2]:=(FProcStack[FStackTop-2]<=FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperEqual;
begin
   { compara dois valores de topo do FStack }
   { devolvendo 1 se o primeiro � igual ao segundo , e 0 em caso contr�rio }
   FProcStack[FStackTop-2]:=(FProcStack[FStackTop-2]=FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperGreater;
begin
   { compara dois valores de topo do FStack }
   { devolvendo 1 se o primeiro � maior que o segundo , e 0 em caso contr�rio }
   FProcStack[FStackTop-2]:=(FProcStack[FStackTop-2]>FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperLess;
begin
   { compara dois valores de topo do FStack }
   { devolvendo 1 se o primeiro � menor que o segundo , e 0 em caso contr�rio }
   FProcStack[FStackTop-2]:=(FProcStack[FStackTop-2]<FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperAdd;
begin
   { soma o primeiro par�metro com o segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=FProcStack[FStackTop-2]+FProcStack[FStackTop-1];
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperConcat;
begin
   { soma o primeiro par�metro com o segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2] := VarToStr(FProcStack[FStackTop-2]) +
     VarToStr(FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperSub;
begin
   { subtrai do primeiro par�metro o segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=FProcStack[FStackTop-2]-FProcStack[FStackTop-1];
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperOr;
begin
   { realiza a opera��o or do primeiro par�mentro com o segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=integer(round(FProcStack[FStackTop-2]) or round(FProcStack[FStackTop-1]));
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperXor;
begin
   { realiza a opera��o or do primeiro par�mentro com o segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=integer(round(FProcStack[FStackTop-2]) xor round(FProcStack[FStackTop-1]));
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperAnd;
begin
   { realiza a opera��o and do primeiro par�mentro com o segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=integer(round(FProcStack[FStackTop-2]) and round(FProcStack[FStackTop-1]));
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperShl;
begin
   { realiza a opera��o and do primeiro par�mentro com o segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=integer(round(FProcStack[FStackTop-2]) shl round(FProcStack[FStackTop-1]));
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperShr;
begin
   { realiza a opera��o and do primeiro par�mentro com o segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=integer(round(FProcStack[FStackTop-2]) shr round(FProcStack[FStackTop-1]));
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperMul;
begin
   { realiza a multiplica��o do primeiro par�mentro pelo segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=double(FProcStack[FStackTop-2])*double(FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperSlash;
begin
   { realiza a divis�o do primeiro par�mentro pelo segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=double(FProcStack[FStackTop-2])/double(FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperDiv;
begin
   { realiza a divis�o do primeiro par�mentro pelo segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=integer(FProcStack[FStackTop-2]) div integer(FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperMod;
begin
   { realiza a divis�o do primeiro par�mentro pelo segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=integer(FProcStack[FStackTop-2]) mod integer(FProcStack[FStackTop-1]);
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperExp;
begin
   { realiza a opera��o de exponencia��o do primeiro par�mentro pelo segundo no FStack devolvendo o resultado no topo }
   FProcStack[FStackTop-2]:=Power(double(FProcStack[FStackTop-2]),double(FProcStack[FStackTop-1]));
   dec(FStackTop);
end;

procedure TatVirtualMachine._OperIs;
var obj: TObject;
begin
   { testa se o primeiro argumento corresponde ou deriva da classe especificada pelo segundo argumento }
   obj := VarToObject( FProcStack[FStackTop-2] );
   if Assigned(obj) then
     FProcStack[FStackTop-2] := obj.InheritsFrom( TranslateClass(VarToInteger(FProcStack[FStackTop - 1])) )
   else
     { nil object always returns False }
     FProcStack[FStackTop-2] := False;
   Dec(FStackTop);
end;

procedure TatVirtualMachine._OperNeg;
begin
   { realiza a opera��o de troca de sinal no topo do FStack }
   FProcStack[FStackTop-1] := -FProcStack[FStackTop-1];
end;

procedure TatVirtualMachine._OperNot;
begin
   { realiza a opera��o l�gica NOT no topo do FStack }
   FProcStack[FStackTop-1] := (Round(FProcStack[FStackTop-1]) = 0);
   {Code below commented by wagner on 20-Jan-2003}
//   FProcStack[FStackTop-1]:=integer(not Round(FProcStack[FStackTop-1]));
end;

procedure TatVirtualMachine._JumpIfFalse;
begin
   if FProcStack[FStackTop-1]=false then
      FNextInstruction := pSimplifiedCode(FCurrentInstruction^.vInteger);
   dec(FStackTop);
end;

procedure TatVirtualMachine._JumpIfTrue;
begin
   if FProcStack[FStackTop-1]<>false then
      FNextInstruction := pSimplifiedCode(FCurrentInstruction^.vInteger);
   dec(FStackTop);
end;

procedure TatVirtualMachine._Jump;
begin
   FNextInstruction := pSimplifiedCode(FCurrentInstruction^.vInteger);
end;

procedure TatVirtualMachine._StoreVar;
begin
   { armazena o valor do topo do FStack na vari�vel }
   FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=FProcStack[FStackTop-1];

// para gravar dados em uma vari�vel que � por refer�ncia
// with TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]) do
//    if VType and varByRef=0 then
//       FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=FProcStack[FStackTop-1]
//    else
//       PVariant(VPointer)^:=FProcStack[FStackTop-1];

   dec(FStackTop);
end;

procedure TatVirtualMachine._StoreVarRef;
begin
   { armazena o valor do topo do FStack na vari�vel (por refer�ncia) }
   with TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]) do
      if VType and varByRef=0 then
         FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=FProcStack[FStackTop-1]
      else
         PVariant(VPointer)^:=FProcStack[FStackTop-1];
   dec(FStackTop);
end;

function TatVirtualMachine.SetVarArrayElement(v:variant;ADim:integer):variant;
var
  s: string;
  i, vardim: integer;
  varClass: TatClass;
  error: boolean;
begin
   with FCurrentInstruction^ do
      { permite modificar strings unidimensionalmente como vetor de caracteres }
      if not VarIsArray(V) and ((VarType(v) = varString)
        {$IFDEF DELPHI2009_LVL}
        or (VarType(v) = varUString)
        {$ENDIF}
        or (VarType(v) = varOleStr)) then
         if ADim=vByte then
         begin
            i:=FProcStack[FStackTop+ADim];
            s:=v;
            Delete(s, i, 1);
            Insert(FProcStack[FStackTop], s, i);
            v:=s;
         end
         else
            RuntimeError('String variable has only one dimension')
      else
         { arrays podem ser acessados multi-dimensionalmente }
         if VarIsArray(V) then
         begin
            i:=FProcStack[FStackTop+ADim];
            vardim := VarArrayDimCount(V);
            case vardim of
               1:  if ADim=vByte then
                      { retorna o elemento contido na indexa��o final }
                      v[i]:=FProcStack[FStackTop]
                   else
                      { o elemento indexado aqui ainda pode ser sub-indexado }
                      v[i]:=SetVarArrayElement(v[i],ADim+1);
               2:  if ADim+1=vByte then
                      { retorna o elemento contido na indexa��o final }
                      v[i,FProcStack[FStackTop+ADim+1]]:=FProcStack[FStackTop]
                   else
                      { o elemento indexado aqui ainda pode ser sub-indexado }
                      v[i,FProcStack[FStackTop+ADim]]:=SetVarArrayElement(v[i,FProcStack[FStackTop+ADim]],ADim+2);
               3:  if ADim+2=vByte then
                      { retorna o elemento contido na indexa��o final }
                      v[i,FProcStack[FStackTop+ADim+1],FProcStack[FStackTop+ADim+2]]:=FProcStack[FStackTop]
                   else
                      { o elemento indexado aqui ainda pode ser sub-indexado }
                      v[i,FProcStack[FStackTop+ADim],FProcStack[FStackTop+ADim+2]]:=SetVarArrayElement(v[i,FProcStack[FStackTop+ADim],FProcStack[FStackTop+ADim+2]],ADim+3);
               4:  if ADim+3=vByte then
                      { retorna o elemento contido na indexa��o final }
                      v[i,FProcStack[FStackTop+ADim+1],FProcStack[FStackTop+ADim+2],FProcStack[FStackTop+ADim+3]]:=FProcStack[FStackTop]
                   else
                      { o elemento indexado aqui ainda pode ser sub-indexado }
                      v[i,FProcStack[FStackTop+ADim],FProcStack[FStackTop+ADim+2],FProcStack[FStackTop+ADim+3]]:=SetVarArrayElement(v[i,FProcStack[FStackTop+ADim],FProcStack[FStackTop+ADim+2],FProcStack[FStackTop+ADim+3]],ADim+3);
               5:  if ADim+4=vByte then
                      { retorna o elemento contido na indexa��o final }
                      v[i,FProcStack[FStackTop+ADim+1],FProcStack[FStackTop+ADim+2],FProcStack[FStackTop+ADim+3],FProcStack[FStackTop+ADim+4]]:=FProcStack[FStackTop]
                   else
                      { o elemento indexado aqui ainda pode ser sub-indexado }
                      v[i,FProcStack[FStackTop+ADim],FProcStack[FStackTop+ADim+2],FProcStack[FStackTop+ADim+3],FProcStack[FStackTop+ADim+4]]:=SetVarArrayElement(v[i,FProcStack[FStackTop+ADim],FProcStack[FStackTop+ADim+2],FProcStack[FStackTop+ADim+3],FProcStack[FStackTop+ADim+4]],ADim+4);
               {*** follow the example above to extend the pure array limit on scripter  ***}
               else RunTimeError(Format('Variant arrays with %d dimensions is still not supported',[vardim]));
            end;
         end
         else
         begin
            // check if the variable is an object with default indexed property
            error := True;
            if VarIsType(v, [varInteger]) then
            begin
              // warning: this cast to TObject is a workaround to try to determine if a variable is a valid instance of
              // a class with default property, but it may cause unexpected behaviors depending on the variable content
              varClass := Scripter.ClassByName(TObject(integer(V)).ClassName);
              if Assigned(varClass) and (varClass.DefaultProperty <> nil) then
              begin
                if Assigned(varClass.DefaultProperty.Setter) then
                begin
                  FProcStack[FCurrentInputArgBase] := FProcStack[FStackTop+ADim];
                  TMachineProc(varClass.DefaultProperty.Setter)(Self);
                  error := False;
                end;
              end;
            end;
            if error then
              RuntimeError('Variable is not an array');
         end;
   result:=v;
end;

function TatVirtualMachine.GetVarArrayElement(v:variant;ADim:integer):variant;
var
  vardim: integer;
  varClass: TatClass;
  error: boolean;
begin
   with FCurrentInstruction^ do
   begin
      { permite acessar string unidimensionalmente como um vetor de caracteres }
      if not VarIsArray(V) and (VarIsType(v, [varString,
        {$IFDEF DELPHI2009_LVL}
        varUString,
        {$ENDIF}
         varOleStr])) then
         if ADim=vByte then // s� aceita acesso aos caracteres da string no �ltimo indice
            result := copy(VarToStr(v), integer(FProcStack[FStackTop + ADim - 1]), 1)
         else
            RuntimeError('String variable has only one dimension')
      else
         { arrays podem ser acessados com multiplos indices quando
         tvartype  forem matrizes multidimensionais, strings ou combina��es destes }
         if VarIsArray(V) then
         begin
            vardim := VarArrayDimCount(V);
            case vardim of
               1: if ADim=vByte then
                     { retorna o elemento contido na indexa��o final }
                     result:=v[ FProcStack[FStackTop+ADim-1] ]
                  else
                     { o elemento indexado aqui ainda pode ser sub-indexado }
                     result:=GetVarArrayElement( v[ FProcStack[FStackTop+ADim-1] ], ADim+1 );
               2: if ADim+1=vByte then
                     { retorna o elemento contido na indexa��o final }
                     result:=v[ FProcStack[FStackTop+ADim-1], FProcStack[FStackTop+ADim] ]
                  else
                     { o elemento indexado aqui ainda pode ser sub-indexado }
                     result:=GetVarArrayElement( v[ FProcStack[FStackTop+ADim-1], FProcStack[FStackTop+ADim] ], ADim+2 );
               3: if ADim+2=vByte then
                     { retorna o elemento contido na indexa��o final }
                     result:=v[ FProcStack[FStackTop+ADim-1], FProcStack[FStackTop+ADim], FProcStack[FStackTop+ADim+1] ]
                  else
                     { o elemento indexado aqui ainda pode ser sub-indexado }
                     result:=GetVarArrayElement( v[ FProcStack[FStackTop+ADim-1], FProcStack[FStackTop+ADim], FProcStack[FStackTop+ADim+1] ], ADim+3 );
               4: if ADim+3=vByte then
                     { retorna o elemento contido na indexa��o final }
                     result:=v[ FProcStack[FStackTop+ADim-1], FProcStack[FStackTop+ADim], FProcStack[FStackTop+ADim+1], FProcStack[FStackTop+ADim+2] ]
                  else
                     { o elemento indexado aqui ainda pode ser sub-indexado }
                     result:=GetVarArrayElement( v[ FProcStack[FStackTop+ADim-1], FProcStack[FStackTop+ADim], FProcStack[FStackTop+ADim+1], FProcStack[FStackTop+ADim+2]], ADim+4 );
               5: if ADim+4=vByte then
                     { retorna o elemento contido na indexa��o final }
                     result:=v[ FProcStack[FStackTop+ADim-1], FProcStack[FStackTop+ADim], FProcStack[FStackTop+ADim+1], FProcStack[FStackTop+ADim+2], FProcStack[FStackTop+ADim+3] ]
                  else
                     { o elemento indexado aqui ainda pode ser sub-indexado }
                     result:=GetVarArrayElement( v[ FProcStack[FStackTop+ADim-1], FProcStack[FStackTop+ADim], FProcStack[FStackTop+ADim+1], FProcStack[FStackTop+ADim+2], FProcStack[FStackTop+ADim+3] ], ADim+5 );
               {*** follow the example above to extend the pure array limit on scripter  ***}
               else RuntimeError(Format('Variant arrays with %d dimensions is still not supported',[vardim]));
            end;
         end
         else
         begin
            // check if the variable is an object with default indexed property
            error := True;
            if VarIsType(V, [varInteger]) then
            begin
              // warning: this cast to TObject is a workaround to try to determine if a variable is a valid instance of
              // a class with default property, but it may cause unexpected behaviors depending on the variable content
              varClass := Scripter.ClassByName(TObject(integer(V)).ClassName);
              if Assigned(varClass) and (varClass.DefaultProperty <> nil) then
              begin
                if Assigned(varClass.DefaultProperty.Getter) then
                begin
                  TMachineProc(varClass.DefaultProperty.Getter)(Self);
                  result := FProcStack[FOutputBase];
                  error := False;
                end;
              end;
            end;
            if error then
              RuntimeError('Variable is not an array');
         end;
   end;
end;

procedure TatVirtualMachine._StoreIdxVar;
begin
   { empilha o elemento indexado da vari�vel }
   dec(FStackTop,FCurrentInstruction^.vByte + 1);
   FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=SetVarArrayElement( FProcStack[FStackBase+FCurrentInstruction^.vInteger], 1 );
end;

procedure TatVirtualMachine._StoreIdxVarRef;
begin
   { empilha o elemento indexado da vari�vel }
   dec(FStackTop,FCurrentInstruction^.vByte + 1);
   with TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]) do
      if VType and varByRef=0 then
         FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=SetVarArrayElement( FProcStack[FStackBase+FCurrentInstruction^.vInteger], 1 )
      else
         PVariant(VPointer)^ := SetVarArrayElement( FProcStack[FStackBase+FCurrentInstruction^.vInteger], 1 );
end;

procedure TatVirtualMachine._StoreVarDouble;
begin
   { armazena o par�metro vDouble na vari�vel indexada por vInteger }
   FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=FCurrentInstruction^.vDouble;
end;

procedure TatVirtualMachine._StoreVarRefDouble;
begin
   { armazena o par�metro vDouble na vari�vel indexada por vInteger }
   with TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]) do
      if VType and varByRef=0 then
         FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=FCurrentInstruction^.vDouble
      else
         PVariant(VPointer)^ := FCurrentInstruction^.vDouble;
end;

procedure TatVirtualMachine._StoreVarInteger;
begin
   { armazena o par�metro vInteger2 na vari�vel indexada por vInteger }
   FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=FCurrentInstruction^.vInteger2;
end;

procedure TatVirtualMachine._StoreVarRefInteger;
begin
   { armazena o par�metro vInteger2 na vari�vel indexada por vInteger }
   with TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]) do
      if VType and varByRef=0 then
         FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=FCurrentInstruction^.vInteger2
      else
         PVariant(VPointer)^ := FCurrentInstruction^.vInteger2;
end;

procedure TatVirtualMachine._StoreVarString;
begin
   { armazena o conte�do da string que est� em vString na vari�vel indexada por vInteger }
   FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=copy(FCurrentInstruction^.vString,1,FCurrentInstruction^.vInteger3);
end;

procedure TatVirtualMachine._StoreVarRefString;
begin
   { armazena o conte�do da string que est� em vString na vari�vel indexada por vInteger }
   with TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]) do
      if VType and varByRef=0 then
         FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=copy(FCurrentInstruction^.vString,1,FCurrentInstruction^.vInteger3)
      else
         PVariant(VPointer)^ := copy(FCurrentInstruction^.vString,1,FCurrentInstruction^.vInteger3);
end;

procedure TatVirtualMachine._StoreVarConst;
begin
   { armazena uma constante na vari�vel indexada por vInteger }
   with FCurrentInstruction^ do
      FProcStack[FStackBase+vInteger]:=CoreConst[CORE_CONST(vByte)];
end;

procedure TatVirtualMachine._StoreVarRefConst;
begin
   { armazena uma constante na vari�vel indexada por vInteger }
   with TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]) do
      if VType and varByRef=0 then
         FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=CoreConst[CORE_CONST(FCurrentInstruction^.vByte)]
      else
         PVariant(VPointer)^ := CoreConst[CORE_CONST(FCurrentInstruction^.vByte)];
end;

procedure TatVirtualMachine._CopyVar;
begin
   { copia o valor de uma vari�vel para outra }
   with TVarData( FProcStack[FStackBase+FCurrentInstruction^.vInteger] ) do
      if VType and varByRef=0 then
         FProcStack[FStackBase+FCurrentInstruction^.vInteger2] := FProcStack[FStackBase+FCurrentInstruction^.vInteger]
      else
         FProcStack[FStackBase+FCurrentInstruction^.vInteger2] := PVariant(VPointer)^;
end;

procedure TatVirtualMachine._CopyVarRef;
begin
   { copia o valor de uma vari�vel para outra }
   with TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger2]) do
      if VType and varByRef=0 then
         if TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]).VType and varByRef=0 then
            FProcStack[FStackBase+FCurrentInstruction^.vInteger2]:=FProcStack[FStackBase+FCurrentInstruction^.vInteger]
         else
            FProcStack[FStackBase+FCurrentInstruction^.vInteger2]:=PVariant(TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]).VPointer)^
      else
         if TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]).VType and varByRef=0 then
            PVariant(VPointer)^ := FProcStack[FStackBase+FCurrentInstruction^.vInteger]
         else
            PVariant(VPointer)^ := PVariant(TVarData(FProcStack[FStackBase+FCurrentInstruction^.vInteger]).VPointer)^;
end;

procedure TatVirtualMachine._Call;
begin
   with FCurrentInstruction^ do
   begin
      { desvia a execu��o para a subrotina }
      FCurrentInstruction:=pSimplifiedCode(vInteger);
      { posiciona os par�metros de sa�da do processo a ser chamado }
      FOutputBase:=FStackTop+FCurrentInstruction^.vInteger; { prepare }
      { cria um novo processo }
      ExecProcess(vByte);
      { elimina os par�metros entrada da fun��o chamada }
      dec(FStackTop,vByte);
   end;
end;

procedure TatVirtualMachine._Ret;
begin
   { encerra o processo corrente }
   FNextInstruction := nil;
end;

procedure TatVirtualMachine._StoreInput;
begin
   { armazena o valor do par�metro de entrada na vari�vel }

   { retorna o conte�do do variant, mesmo se ele for varByRef }
   with TVarData(FProcStack[FInputBase+FInputOffset]) do
      if VType and varByRef=0 then
         FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=FProcStack[FInputBase+FInputOffset]
      else
         FProcStack[FStackBase+FCurrentInstruction^.vInteger]:=Variant(VPointer^);
   inc(FInputOffset);
end;

procedure TatVirtualMachine._ExecFun; // obsolete
begin
   ShowMessage('Use methods instead of obsolete user functions');
end;

procedure TatVirtualMachine._PushInteger;
begin
   { empilha a inst�ncia representada pelo seu ponteiro vInteger }
   FProcStack[FStackTop]:=FCurrentInstruction^.vInteger;
   inc(FStackTop);
end;

procedure TatVirtualMachine._TryFinally;
var try_end, finally_end : pSimplifiedCode;
    OriginalStackTop     : integer;
    Exiting              : boolean;
begin
   Exiting:=false;
   OriginalStackTop:=FStackTop;
   { obt�m o endere�o das instru��es de conclus�o do bloco TRY e do bloco FINALLY }
   with FCurrentInstruction^do
   begin
      try_end:=pSimplifiedCode(vInteger);
      finally_end:=pSimplifiedCode(vInteger2);
   end;
   try
        try
           { executa o bloco de instru��es do TRY }
           FCurrentInstruction := FNextInstruction;
           FStopInstruction := try_end;
           try
             while (FNextInstruction<>try_end) and (FNextInstruction <> nil) do
             begin
                FNextInstruction := FCurrentInstruction^.Next;
                FCurrentInstruction.Compute;
                if FAutoPause then
                  if FAutoPauseCurLine <> DebugExecutionLine then
                  begin
                    FPaused := true;
                    FAutoPause := false;
                  end;
                if FPaused then DoDebugHook;
                if FCallExecHookEvent then DoExecHook;
                FCurrentInstruction := FNextInstruction;
             end;
           finally
             FStopInstruction := nil;
           end;
           { Atualiza o contexto da exce��o para uso em runtime }
           FLastExceptionMessage:='';
           FLastExceptionHelpContext:=0;
           FLastExceptionClassName:='';
           { se saiu com exit ent�o propaga o exit para fora do bloco try }
           if FCurrentInstruction=nil then
              Exiting:=true;
        except
           on ex:Exception do
           begin
              { Atualiza o contexto da exce��o para uso em runtime }
              FLastExceptionMessage:=ex.message;
              FLastExceptionHelpContext:=ex.HelpContext;
              FLastExceptionClassName:=ex.ClassName;
              { em caso de exce��o num bloco try..finally o stack retornar� a situa��o
                em que se encontrava antes do bloco try..finally. Portanto deve-se tomar
                cuidado quando estiver retornando resultados dentro deste bloco }
              FStackTop:=OriginalStackTop;
              raise;
           end;
        end;
   finally
      { garante que a execu��o do boclo FINALLY seja iniciada corretamente }
      FNextInstruction := try_end;
      FCurrentInstruction:=try_end;
      FStopInstruction := finally_end;
      { executa o bloco de instru��es do FINALLY }
      try
        while (FNextInstruction <> finally_end) and (FNextInstruction <> nil) do
        begin
           FNextInstruction := FCurrentInstruction^.Next;
           FCurrentInstruction.Compute;
           if FAutoPause then
             if FAutoPauseCurLine <> DebugExecutionLine then
             begin
               FPaused := true;
               FAutoPause := false;
             end;
           if FPaused then DoDebugHook;
           if FCallExecHookEvent then DoExecHook;
           FCurrentInstruction := FNextInstruction;
        end;
      finally
        FStopInstruction := nil;
      end;
   end;
   if Exiting then
      FNextInstruction := nil;
end;

procedure TatVirtualMachine._TryExcept;
var try_end, except_end : pSimplifiedCode;
    OriginalStackTop    : integer;
    Exiting             : boolean;
begin
   Exiting:=false;
   OriginalStackTop:=FStackTop;
   { obt�m o endere�o das instru��es de conclus�o do bloco TRY e do bloco EXCEPT }
   with FCurrentInstruction^ do
   begin
      try_end:=pSimplifiedCode(vInteger);
      except_end:=pSimplifiedCode(vInteger2);
   end;
   try
      Inc(FInTryExcept);
      { executa o bloco de instru��es do TRY }
      FCurrentInstruction := FNextInstruction;
      FStopInstruction := try_end;
      try
        while (FNextInstruction <> try_end) and (FNextInstruction <> except_end) and (FNextInstruction <> nil) do
        begin
           FNextInstruction := FCurrentInstruction^.Next;
           FCurrentInstruction.Compute;
           if FAutoPause then
             if FAutoPauseCurLine <> DebugExecutionLine then
             begin
               FPaused := true;
               FAutoPause := false;
             end;
           if FPaused then DoDebugHook;
           if FCallExecHookEvent then DoExecHook;
           FCurrentInstruction := FNextInstruction;
        end;
      finally
        FStopInstruction := nil;
      end;
      { evita que o bloco EXCEPT seja executado, j� que n�o ocorreu nenhuma exce��o }
      FNextInstruction := except_end;
      { se saiu com exit ent�o propaga o exit para fora do bloco try }

      if FCurrentInstruction=nil then
         Exiting:=true;
   except
      on ex:Exception do
      begin
         Dec(FInTryExcept);
         { Atualiza o contexto da exce��o para uso em runtime }
         FLastExceptionMessage:=ex.message;
         FLastExceptionHelpContext:=ex.HelpContext;
         FLastExceptionClassName:=ex.ClassName;
         { em caso de exce��o num bloco try..except o stack retornar� a situa��o
           em que se encontrava antes do bloco try..except. Portanto deve-se tomar
           cuidado quando estiver retornando resultados dentro deste bloco }
         FStackTop:=OriginalStackTop;
         { garante que a execu��o do boclo EXCEPT seja iniciada corretamente }
         FNextInstruction := try_end;
         FCurrentInstruction := try_end;
         FStopInstruction := except_end;
         { executa o bloco de instru��es do EXCEPT }
         try
           while (FNextInstruction<>except_end) and (FNextInstruction <> nil) do
           begin
              FNextInstruction := FCurrentInstruction^.Next;
              FCurrentInstruction.Compute;
              if FAutoPause then
                if FAutoPauseCurLine <> DebugExecutionLine then
                begin
                  FPaused := true;
                  FAutoPause := false;
                end;
              if FPaused then DoDebugHook;
              if FCallExecHookEvent then DoExecHook;
              FCurrentInstruction := FNextInstruction;
           end;
         finally
           FStopInstruction := nil;
         end;
      end;
   end;
   if Exiting then
      FNextInstruction := nil;
end;

procedure TatVirtualMachine._WithObject;
begin
  { ajusta o objeto que ser� usado pelo CallProc obrigatoriamente subsequente
   a esta instru��o com o conte�do da vari�vel local especificada aqui }
  with TVarData( FProcStack[FStackBase+FCurrentInstruction^.vInteger] ) do
    if VType and varByRef=0 then
      FCurrentInstruction^.Next^.vInteger := FProcStack[FStackBase+FCurrentInstruction^.vInteger]
    else
      FCurrentInstruction^.Next^.vInteger := PVariant(VPointer)^;
end;

procedure TatVirtualMachine._CallProc;

  procedure GetCurrentObjectFromStack;
  begin
    { se a instru��o corrente (inCallProc) n�o indicar a inst�ncia corrente
     como um par�metro impl�cito, ent�o pega a inst�ncia como o �ltimo
     argumento de entrada na pilha }
    FCurrentObject := TObject(FCurrentInstruction^.vInteger);
    if not Assigned(FCurrentObject) then
    begin
      Dec(FStackTop);
      try
        {$IFNDEF LINUX}
        FCurrentOleObject := FProcStack[FStackTop];
        {$ENDIF}
        FCurrentObject := VarToObject(FProcStack[FStackTop]);
      except
        FCurrentObject := nil;
      end;
    end;
  end;

begin
   with FCurrentInstruction^ do
   begin
      { inicializa o apontador dos argumentos de sa�da }
      FCurrentOutputArgIndex := FStackTop;
      FOutputBase := FStackTop;
      { Elimina os argumentos de indices em chamadas indexadas,
        para trata-los como argumentos simples na pilha }
      Dec(FStackTop,vInteger1);
      { prepara o apontador de base dos indices matriciais de entrada }
      FCurrentArrayIndexBase := FStackTop;
      { Verifica se o proc se refere a um setter, porque a passagem de argumetos
        para um setter proc � especial e sinalizado com argcount=255 }
      if vByte=255 then {! Setter Proc !}
      begin
         { AQUI A INST�NCIA ASSOCIADA AO PROC � PASSADA POR �LTIMO NA PILHA }
         GetCurrentObjectFromStack;
         { elimina o argumento "Setter Value" passado para o processo ) }
         Dec(FStackTop);
         { prepara o apontador do argumento de entrada }
         FCurrentInputArgBase := FStackTop;
      end
      else
      begin
         { AQUI A INST�NCIA ASSOCIADA AO PROC � PASSADA POR PRIMEIRO NA PILHA }
         { elimina todos os argumentos passados para o processo }
         Dec(FStackTop,vByte);
         { prepara o apontador dos argumentos de entrada para o in�cio }
         FCurrentInputArgBase := FStackTop;
         GetCurrentObjectFromStack;
      end;
      { chama a rotina associada a instru��o,
        passando esta inst�ncia de m�quina virtual como argumento }
      TMachineProc(vProc)(self);
   end;
end;

procedure TatVirtualMachine._CallClassProc;
begin
   with FCurrentInstruction^ do
   begin
      { inicializa o apontador dos argumentos de sa�da }
      FCurrentOutputArgIndex := FStackTop;
      FOutputBase := FStackTop;
      { elimina os argumentos de indices em chamadas indexadas }
      Dec(FStackTop,vInteger1);
      { prepara o apontador de base dos indices matriciais de entrada }
      FCurrentArrayIndexBase := FStackTop;
      { membros de classe sempre tem o CurrentObject nulo }
      FCurrentObject := nil;
      {$IFNDEF LINUX}
      FCurrentOleObject := null;
      {$ENDIF}
      FCurrentClass := TatClass(vInteger);
      { elimina todos os argumentos passados para o processo }
      Dec(FStackTop,vByte);
      { prepara o apontador dos argumentos de entrada para o in�cio }
      FCurrentInputArgBase := FStackTop;
      { chama a rotina associada a instru��o }
      TMachineProc(vProc)(self);
   end;
end;

procedure TatVirtualMachine._BreakPoint;
begin
   { executa a rotina de tratamento espec�fico deste break point }
    TMachineProc(FCurrentInstruction^.vProc)(self);
end;

procedure TatVirtualMachine._VarTest;
begin
   { desvia se a express�o do topo da pilha for diferente do valor da vari�vel, elimina o valor do topo da pilha }
   with FCurrentInstruction^ do
      if byte(FProcStack[FStackBase+FCurrentInstruction^.vInteger2]=FProcStack[FStackTop-1])=vByte then
         FNextInstruction := pSimplifiedCode(FCurrentInstruction^.vInteger);
   dec(FStackTop);
end;

procedure TatVirtualMachine._VarTestDouble;
begin
   { desvia se o valor da vari�vel for diferente do par�metro num�rico }
   with FCurrentInstruction^ do
      if byte(FProcStack[FStackBase+vInteger1]=vDouble)=vByte then
         FNextInstruction := pSimplifiedCode(vInteger);
end;

procedure TatVirtualMachine._VarTestInteger;
begin
   { desvia se o valor da vari�vel for diferente do par�metro inteiro }
   with FCurrentInstruction^ do
      if byte(FProcStack[FStackBase+vInteger2]=vInteger3)=vByte then
         FNextInstruction := pSimplifiedCode(vInteger);
end;

procedure TatVirtualMachine._VarTestString;
begin
   { desvia se o valor da vari�vel for diferente do par�metro string }
   with FCurrentInstruction^ do
      if byte(FProcStack[FStackBase+vInteger2]=copy(vString,1,vInteger3))=vByte then
         FNextInstruction := pSimplifiedCode(vInteger);
end;

procedure TatVirtualMachine._VarTestVar;
begin
   { desvia se o valor da vari�vel for diferente do par�metro string }
   with FCurrentInstruction^ do
      if byte(FProcStack[FStackBase+vInteger2]=FProcStack[FStackBase+vInteger3])=vByte then
         FNextInstruction := pSimplifiedCode(vInteger);
end;

procedure TatVirtualMachine._StoreGlobalVar;
begin
  { armazena o valor do topo do FStack na vari�vel global }
  FProcStack[FCurrentInstruction^.vInteger] := FProcStack[FStackTop-1];
  Dec(FStackTop);
end;

procedure TatVirtualMachine._StoreGlobalIdxVar;
begin
  { empilha o elemento indexado da vari�vel global }
  Dec(FStackTop,FCurrentInstruction^.vByte + 1);
  FProcStack[FCurrentInstruction^.vInteger] := SetVarArrayElement( FProcStack[FCurrentInstruction^.vInteger], 1 );
end;

procedure TatVirtualMachine._PushGlobalVar;
begin
  { empilha o valor da vari�vel global no FStack }
  with TVarData( FProcStack[FCurrentInstruction^.vInteger] ) do
    if VType and varByRef=0 then
      FProcStack[FStackTop] := FProcStack[FCurrentInstruction^.vInteger]
    else
      FProcStack[FStackTop] := PVariant(VPointer)^;
  Inc(FStackTop);
end;

procedure TatVirtualMachine._PushGlobalVarByRef;
begin
  { empilha a refer�ncia para uma vari�vel global local no FStack }
  VarClear(FProcStack[FStackTop]);
  TVarData(FProcStack[FStackTop]).VType := varVariant or varByRef;
  with TVarData( FProcStack[FCurrentInstruction^.vInteger] ) do
    if VType and varByRef = 0 then
      TVarData(FProcStack[FStackTop]).VPointer := @FProcStack[FCurrentInstruction^.vInteger]
    else
      TVarData(FProcStack[FStackTop]).VPointer := VPointer;
  Inc(FStackTop);
end;

procedure TatVirtualMachine._PushGlobalIdxVar;
begin
  { empilha o elemento indexado da vari�vel global }
  with FCurrentInstruction^ do
  begin
    Dec(FStackTop,vByte);
    FProcStack[FStackTop] := GetVarArrayElement( FProcStack[vInteger], 1 );
    Inc(FStackTop);
  end;
end;

procedure TatVirtualMachine._Abort;
begin
   Abort;
end;

procedure TatVirtualMachine._ArrayOf;
var c,n: integer;
    v  : variant;
begin
   { transforma n parametros salvos na pilha em um vetor de variants }
   with FCurrentInstruction^ do
   begin
      n:=FCurrentInstruction^.vInteger-1;
      v:=VarArrayCreate([0,n],varVariant);
      for c:=0 to n do
         v[c]:=FProcStack[FStackTop-1-n+c];
      dec(FStackTop,vInteger);
      FProcStack[FStackTop]:=v;
      inc(FStackTop);
   end;
end;

procedure TatVirtualMachine._TestIfFalse;
begin
  if FProcStack[FStackTop - 1] = false then
    FNextInstruction := pSimplifiedCode(FCurrentInstruction^.vInteger);
end;

procedure TatVirtualMachine._TestIfTrue;
begin
  if FProcStack[FStackTop - 1] <> false then
    FNextInstruction := pSimplifiedCode(FCurrentInstruction^.vInteger);
end;

{---}

procedure TatVirtualMachine._CastClass;
var obj : TObject;
begin
 { testa se o objeto contido no topo da pilha corresponde ou � derivado da
   classe especificada, gerando uma exce��o caso n�o seja }
  with Script, FCurrentInstruction^ do
  begin
    { se a classe destino ainda n�o havia sido encontrada ent�o
      procura-a agora }
    if vInteger = 0 then
    begin
      vInteger := integer(Scripter.Classes.ClassByName(vString));
      if vInteger > 0 then
        vInteger := integer( TatClass(vInteger).FClassRef )
      else
        RuntimeError(Format('Invalid type cast. Class ''%s'' is not valid'+ErrorComplement(vDebugInfo),[vString]));
    end;
    { assume que o topo da pilha � um objeto }
    obj := VarToObject( FProcStack[FStackTop-1] );
    if not Assigned(obj) then
      RuntimeError(Format('Invalid object to type cast (nil)'+ErrorComplement(vDebugInfo),[vString]));
    { teste se o objeto corresponde ou � derivado da classe determinada }
    if not obj.InheritsFrom( TranslateClass(vInteger) ) then
      RuntimeError(Format('Object is not of expected class ''%s'''+ErrorComplement(vDebugInfo),[vString]));
  end;
end;

{ _CallProc to unresolved Getter }
procedure TatVirtualMachine.UndefinedGetterProc;
var
  property_obj : TatProperty;
  method_obj   : TatMethod;
  calling      : boolean;
  IsCOM        : boolean;
  loadClass    : TatClass;
  {$IFNDEF LINUX}
  Params: OleVariant;
  i: integer;
  S: Variant;
  {$ENDIF}
begin
   IsCom:=false;
   with FCurrentInstruction^ do
   begin
      calling := (vSmallInt = 1);
      { se o objeto corrente n�o estiver definido tenta encontr�-lo no topo da pilha }
      if not Assigned(CurrentObject) then
      begin
         {$IFNDEF LINUX}
         case VarType(FCurrentOleObject) of
            varDispatch:
               IsCOM:=true;
            varUnknown:
               if IUnknown(FCurrentOleObject).QueryInterface(IatInterfacedObject,FCurrentObject) = S_OK then
               begin
                  FCurrentObject := IatInterfacedObject(pointer(FCurrentObject)).GetObjectReference;
                  IUnknown(FCurrentOleObject)._Release;
               end
               else
                  RuntimeError(Format('Object or Record required to access property: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
         else
            RuntimeError(Format('Object or Record required to access property: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
         end;
         {$ELSE}
         RuntimeError(Format('Object or Record required to access property: ''%s'''+ErrorComplement(vDebugInfo),[vString]))
         {$ENDIF}
      end;

      { localiza a propriedade atrav�s de seu nome, na classe da inst�ncia
        que est� no topo da pilha. Se a classe ainda n�o havia sido carregada,
        ent�o tamb�m carrega suas informa��es atrav�s do RTTI }
      { verifica se a propriedade realmente existe na classe }
      if not IsCOM then
      begin
         {$IFDEF DELPHI2010_LVL}
         if CurrentObject is TGenericRecordWrapper then
            loadClass := Scripter.FClasses.CheckLoaded(CurrentObject.ClassType, FCurrentRecordName)
         else
         {$ENDIF}
            loadClass := Scripter.FClasses.CheckLoaded(CurrentObject.ClassType);

         with loadClass do
         begin
            property_obj:=Properties.PropertyByName(vString);
            if Assigned(property_obj) then
               if calling then
                  RuntimeError(Format('Property ''%s'' cannot be called as a method'+Script.ErrorComplement(vDebugInfo),[vString]))
               else
                  if Assigned(property_obj.Getter) then
                    { se a propriedade puder ser lida, ent�o troca o conte�do do topo da pilha
                      pelo conte�do da propriedade }
                     TMachineProc(property_obj.Getter)(self)
                  else
                     RuntimeError(Format('Property ''%s'' cannot be readed'+Script.ErrorComplement(vDebugInfo),[vString]))
            else
            begin
               { faz a pesquisa tamb�m nos m�todos sem argumentos, porque, em runtime,
                 eles s�o tratados como propriedades readonly }
               method_obj:=Methods.MethodByName(vString);
               if Assigned(method_obj) then
                  TMachineProc(method_obj.Proc)(self)
               else
                  RuntimeError(Format('Unknown property or method: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
            end;
         end;
      end
      else
      begin
        {$IFNDEF LINUX}
        if vInteger1 > 0 then
        begin
          Params := VarArrayCreate([0, vInteger1 - 1], varVariant);
          for i := 0 to vInteger1 - 1 do
          begin
             S := GetArrayIndex(i);
             Params[i] := S;
          end;
          S := Params[0];
        end else
          Params := null;
        ReturnOutputArg(
           DispatchInvoke(
              IDispatch(FCurrentOleObject),
              vString,
              DISPATCH_PROPERTYGET or DISPATCH_METHOD,
              vInteger1,
              Params ) );
        {$ENDIF}
      end;
   end;
end;

{ _CallProc to unresolved Setter }
procedure TatVirtualMachine.UndefinedSetterProc;
var
  property_obj : TatProperty;
  IsCOM        : boolean;
  loadClass    : TatClass;
  {$IFNDEF LINUX}
  Params: OleVariant;
  i: integer;
  S: Variant;
  {$ENDIF}
begin
  IsCom:=false;
  with FCurrentInstruction^ do
  begin
     { se o objeto corrente n�o estiver definido tenta encontr�-lo no topo da pilha }
     if not Assigned(CurrentObject) then
     begin
        {$IFNDEF LINUX}
        case VarType(FCurrentOleObject) of
           varDispatch:
              IsCOM:=true;
           varUnknown:
              if IUnknown(FCurrentOleObject).QueryInterface(IatInterfacedObject,FCurrentObject)=S_OK then
              begin
                 FCurrentObject := IatInterfacedObject(pointer(FCurrentObject)).GetObjectReference;
                 IUnknown(FCurrentOleObject)._Release;
              end
              else
                 RuntimeError(Format('Object or Record required to access property: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
        else
           RuntimeError(Format('Object or Record required to access property: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
        end;
        {$ELSE}
        RuntimeError(Format('Object or Record required to access property: ''%s'''+ErrorComplement(vDebugInfo),[vString]))
        {$ENDIF}
     end;
     { verifica se a propriedade realmente existe na classe }
     { faz a pesquisa tamb�m nos m�todos, porque, em runtime,
       eles s�o tratados como propriedades readonly, neste caso ser�
       provocado um erro notificando que o m�todo n�o pode sofrer atribui��o }
     if not IsCOM then
     begin
        {$IFDEF DELPHI2010_LVL}
        if CurrentObject is TGenericRecordWrapper then
           loadClass := Scripter.FClasses.CheckLoaded(CurrentObject.ClassType, FCurrentRecordName)
        else
        {$ENDIF}
           loadClass := Scripter.FClasses.CheckLoaded(CurrentObject.ClassType);

        with loadClass do
        begin
           { localiza a propriedade atrav�s de seu nome, na classe da inst�ncia
             que est� no topo da pilha. Se a classe ainda n�o havia sido carregada,
             ent�o tamb�m carrega suas informa��es atrav�s do RTTI }
           property_obj:=Properties.PropertyByName(vString);
           if Assigned(property_obj) then
              { se a propriedade puder ser escrita, ent�o escreve o
                conte�do do n�vel 2 da pilha na propriedade correspondente �
                inst�ncia que est� no topo da pilha e desempilha dois n�veis }
              if Assigned(property_obj.Setter) then
                 TMachineProc(property_obj.Setter)(self)
              else
                 RuntimeError(Format('Property ''%s'' cannot be written'+Script.ErrorComplement(vDebugInfo),[vString]))
           else
             if Assigned(Methods.MethodByName(vString)) then
                 RuntimeError(Format('Assign to method ''%s'' is not allowed'+Script.ErrorComplement(vDebugInfo),[vString]))
             else
                 RuntimeError(Format('Unknown property: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
        end;
     end
     else
     begin
        {$IFNDEF LINUX}
        {Set the array with the indexed values, then the last value in array must
         be the value of the property to be set. The DispatchInvoke function will
         invert the order of the array by default}
        Params := VarArrayCreate([0, vInteger1], varVariant);
        for i := 0 to vInteger1 - 1 do
        begin
           S := GetArrayIndex(i);
           Params[i] := S;
        end;
        Params[vInteger1] := GetInputArg(0);
        S := Params[0];

        DispatchInvoke(
           IDispatch(FCurrentOleObject),
           vString,
           DISPATCH_PROPERTYPUT,
           vInteger1 + 1,
           Params );
        {$ENDIF}
     end;
  end;
end;

{ _CallProc to unresolved Method }
procedure TatVirtualMachine.UndefinedMethodProc;
var method_obj : TatMethod;
    IsCOM      : boolean;
    {$IFNDEF LINUX}
    Params     : OleVariant;
    i          : integer;
    S          : Variant;
    {$ENDIF}
begin
  IsCom:=false;
  with FCurrentInstruction^ do
  begin
     { se o objeto corrente n�o estiver definido tenta encontr�-lo no topo da pilha }
     if not Assigned(CurrentObject) then
     begin
        {$IFNDEF LINUX}
        case VarType(FCurrentOleObject) of
           varDispatch:
              IsCOM:=true;
           varUnknown:
              if IUnknown(FCurrentOleObject).QueryInterface(IatInterfacedObject,FCurrentObject)=S_OK then
              begin
                 FCurrentObject := IatInterfacedObject(pointer(FCurrentObject)).GetObjectReference;
                 IUnknown(FCurrentOleObject)._Release;
              end
              else
                 RuntimeError(Format('Object or Record required to access method: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
        else
           RuntimeError(Format('Object or Record required to access method: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
        end;
        {$ELSE}
        RuntimeError(Format('Object required to access method: ''%s'''+ErrorComplement(vDebugInfo),[vString]))
        {$ENDIF}
     end;
     if not IsCOM then
     begin
        { localiza o m�todo atrav�s de seu nome, na classe da inst�ncia
          que est� no topo da pilha. Se a classe ainda n�o havia sido carregada,
          ent�o tamb�m carrega suas informa��es atrav�s do RTTI }
        method_obj:=Scripter.FClasses.CheckLoaded(CurrentObject.ClassType).Methods.MethodByName(vString);
        { verifica se o m�todo realmente existe na classe }
        if Assigned(method_obj) then
           { se o m�todo foi definido ent�o executa-o, eliminando a
             inst�ncia correspondente, que est� no top da pilha }
           if Assigned(method_obj.Proc) then
           begin
              { verifica se o n�mero de par�metros reais est� correto }
              if vByte < method_obj.FArgCount - method_obj.FDefArgCount then
              begin
                if method_obj.FDefArgCount = 0 then
                  RuntimeError(Format('Not enough actual parameters for method ''%s''. Expected %d parameters'+Script.ErrorComplement(vDebugInfo),[vString,method_obj.FArgCount]))
                else
                  RuntimeError(Format('Not enough actual parameters for method ''%s''. Expected %d to %d parameters' + Script.ErrorComplement(vDebugInfo),[vString, method_obj.FArgCount - method_obj.FDefArgCount, vString,method_obj.FArgCount]))
              end
              else
              if vByte > method_obj.FArgCount then
                RuntimeError(Format('Too many parameters for method ''%s''. Expected %d parameters'+Script.ErrorComplement(vDebugInfo),[vString,method_obj.FArgCount]))
              else
                TMachineProc(method_obj.Proc)(self)
           end
           else
              RuntimeError(Format('Method ''%s'' was not defined'+Script.ErrorComplement(vDebugInfo),[vString]))
        else
           RuntimeError(Format('Unknown method: ''%s'''+Script.ErrorComplement(vDebugInfo),[vString]));
     end
     else
     begin
        {$IFNDEF LINUX}
        Params := VarArrayCreate([0,vByte-1],varVariant);
        for i := 0 to vByte - 1 do
        begin
           S:=GetInputArg(i);
           Params[i] := S;
        end;
        S := Params[0];
        ReturnOutputArg(
           DispatchInvoke(
              IDispatch(FCurrentOleObject),
              vString,
              DISPATCH_PROPERTYGET or DISPATCH_METHOD,
              vByte,
              Params ) );
        {$ENDIF}
     end;
  end;
end;

procedure TatVirtualMachine.SolveAbsoluteAddressing;
var Cur : pSimplifiedCode;
    c : integer;
    AddressTable : pAddrVector;
    space : integer;
    classidx: integer;
    itemidx: integer;
    AClass: TatClass;
begin
   { esse procedimento executa os seguintes ajustes:
     a) corrige os endere�os relativos contidos nas instru��es
     b) ajusta os endere�os dos m�todos de execu��o das instru��es, com base no OpCode
     c) corrige os endere�os de m�todos correspondentes a Getters, Setters e M�todos de objeto ou classe }
   with Scripter, Script do
   begin
      { verifica se o m�todo compile j� foi chamado, sen�o chama-o automaticamente }
      if not FCompiled then Compile;
      space := (FCodeLine+1);
      GetMem(AddressTable,SizeOf(pSimplifiedCode)*space);
      try
         { armazena todos os endere�os das intru��es em um vetor din�mico }
         Cur:=FFirstInstruction;
         c:=0;
         while Cur<>nil do
         begin
            AddressTable^[c]:=Cur;
            Cur:=Cur^.Next;
            inc(c);
         end;
         { redefine todos os desvios relativos usando o vetor de endere�os montado }
         Cur:=FFirstInstruction;
         while Cur<>nil do
         begin
            with Cur^ do
            begin
               { ajusta tamb�m os endere�os das rotinas sem�nticas de todas
                 as instru��es do script compilado }
               Compute := FComputeProcs[OpCode];

               { ajusta endere�os absolutos em instru��es de desvio }
               case OpCode of
                  inJump,
                  inCall,
                  inJumpIfFalse,
                  inJumpIfTrue,
                  inVarTest,
                  inVarTestInteger,
                  inVarTestDouble,
                  inVarTestString,
                  inVarTestVar,
                  inTestIfFalse,
                  inTestIfTrue:
                     if vInteger < space then
                       vInteger := integer(AddressTable^[vInteger]);
                  inTryFinally,
                  inTryExcept :
                  begin
                     if vInteger < space then
                       vInteger := integer(AddressTable^[vInteger]);
                     if vInteger2 < space then
                       vInteger2 := integer(AddressTable^[vInteger2]);
                  end;
                  inCallProc :
                  begin
                     { solve default instance reference }
                     if vInteger=-1 then
                        vInteger:=0
                     else
                     begin
                       {if vInteger is positive, then it's an index of scripter.FDefaultInstances.
                        if vInteger is negative, then it's an index of script.FDefInstance. But the index is shifted by 2
                        to avoid -0 indexes. So, after changing the signal, we must subtract 2 so that we find the original index.
                        This sum + 2 is needed to avoid 0 and -1, which are special codes (0 is the 0-index for FDefaultinstances}
                       if vInteger >= 0 then
                         vInteger := integer(FDefaultInstances[vInteger].Instance)
                       else
                         vInteger := integer(FDefInstances[(-vInteger) - 2].Instance);
                     end;

                     classidx := integer(TMethod(vProc).Data) shr 17;
                     itemidx := (integer(TMethod(vProc).Data) shr 2) and $7FFF;
                     { solve vProc relative reference }
                     case TClassReference(integer(TMethod(vProc).Data) and 3) of
                        crGetter : if TMethod(vProc).Data=Pointer(crGetter) then
                                      vProc := UndefinedGetterProc
                                   else
                                     if FFastSolving then
                                       vProc := FClasses[classidx].Properties[itemidx].Getter
                                     else
                                       vProc := _FindProperty(_FindClass(classidx, vString2), itemidx, vString).Getter;
                        crSetter : if TMethod(vProc).Data=Pointer(crSetter) then
                                      vProc := UndefinedSetterProc
                                   else
                                     if FFastSolving then
                                       vProc := FClasses[classidx].Properties[itemidx].Setter
                                     else
                                       vProc := _FindProperty(_FindClass(classidx, vString2), itemidx, vString).Setter;
                        crMethod : if TMethod(vProc).Data=Pointer(crMethod) then
                                      vProc := UndefinedMethodProc
                                   else
                                      if FFastSolving then
                                        vProc := FClasses[classidx].Methods[itemidx].Proc
                                      else
                                        vProc := _FindMethod(_FindClass(classidx, vString2), itemidx, vString).Proc;
                     end;
                  end;
                  inCallClassProc :
                  begin
                     { solve class reference }
                     if vInteger=-1 then
                        vInteger:=0
                     else
                       if FFastSolving then
                         vInteger := integer(FClasses[vInteger])
                       else
                         vInteger := integer(_FindClass(vInteger, vString2));

                     classidx := integer(TMethod(vProc).Data) shr 17;
                     itemidx := (integer(TMethod(vProc).Data) shr 2) and $7FFF;

                     { solve vProc relative reference }
                     if FFastSolving then
                       case TClassReference(integer(TMethod(vProc).Data) and 3) of
                          crGetter : vProc:=FClasses[classidx].Properties[itemidx].Getter;
                          crSetter : vProc:=FClasses[classidx].Properties[itemidx].Setter;
                          crMethod : vProc:=FClasses[classidx].Methods[itemidx].Proc;
                       end
                     else
                       case TClassReference(integer(TMethod(vProc).Data) and 3) of
                          crGetter : vProc := _FindProperty(_FindClass(classidx, vString2), itemidx, vString).Getter;
                          crSetter : vProc := _FindProperty(_FindClass(classidx, vString2), itemidx, vString).Setter;
                          crMethod : vProc := _FindMethod(_FindClass(classidx, vString2), itemidx, vString).Proc;
                       end;
                  end;
                  inCastClass, inPushClass:
                  begin
                     { solve class reference }
                     if vInteger = -1 then
                        vInteger := 0
                     else
                     begin
                       {if the class name is different from real delphi class name, keep index to TatClass}
                       if FFastSolving then
                         AClass := FClasses[vInteger]
                       else
                         AClass := _FindClass(vInteger, vString);

                       if CompareText(AClass.FClassRef.ClassName, vString) = 0 then
                         vInteger := integer(AClass.FClassRef)
                       else
                         vInteger := -integer(AClass);
                     end;
                  end;
               end;
            end;
            Cur:=Cur^.Next;
         end;
      finally
         FreeMem(AddressTable);
      end;
      FSolvedAddressing := true;
      FFastSolving := true;
   end;
end;

function TatVirtualMachine.Execute: variant;
begin
   result := Execute(NULL);
end;

function TatVirtualMachine.ExecuteSubroutine(ALabel: string): variant;
begin
   result := ExecuteSubRoutine(ALabel, NULL);
end;

function TatVirtualMachine.CurrentMethodName: string;
begin
  { return the current method name when running, current instruction
    is a CallProc and refer to a Method call }
  if Running and Assigned(FCurrentInstruction) then
    with FCurrentInstruction^ do
      if (OpCode in [inCallProc,inCallClassProc]) and (vSmallInt=1) then
        result := vString
      else
        result := ''
  else
    result := '';
end;

function TatVirtualMachine.CurrentPropertyName: string;
begin
  { return the current property name when running, current instruction
    is a CallProc and refer to a Property getter or setter }
  if Running and Assigned(FCurrentInstruction) then
    with FCurrentInstruction^ do
      if (OpCode in [inCallProc,inCallClassProc]) and (vSmallInt<>1) then
        result := vString
      else
        result := ''
  else
    result := '';
end;

procedure TatVirtualMachine.InProcessExecute(AScriptStr: string);
var debug_script : TatScript;
begin
  if Running then
  begin
    { cria um novo script }
    debug_script := Scripter.FScripts.Add;
    try
      debug_script.FIsDebugScript := True;
      debug_script.SourceCode.Text := AScriptStr;
      CompileDebugScript( debug_script );
      ExecuteDebugScript( debug_script );
    finally
      debug_script.Free;
    end;
  end
  else
    InternalError('Script is not running for debug');
end;

procedure TatVirtualMachine.CompileDebugScript(AScript:TatScript);
var c: integer;
begin
  { compila um script de depura��o dentro do processo em execu��o }
  with AScript do
  begin
    if FPrepareInstruction = nil then Abort;

    { copia as informa��es do script em execu��o para o novo script }
    ScriptInfo.FRoutines.Assign( Script.FScriptInfo.Routines );
    ScriptInfo.FGlobals.Assign( Script.FScriptInfo.Globals );
    FDebugScriptMainRoutine := ScriptInfo.RoutineByName(FPrepareInstruction^.vString);
    CounterInit := 100000; { para n�o duplicar nomes de vari�veis internas }
    { cria espa�o na �rea de aloca��o de vari�veis para corresponder a eventuais
      elementos ocupados temporariamente na pilha, al�m das vari�veis locais do
       processo corrente (para evitar que o novo trecho compilado possa estragar
       o conte�do da pilha do processo corrente) }
    for c := 1 to FStackTop - (FStackBase + FPrepareInstruction^.vInteger) do
      FDebugScriptMainRoutine.DeclareVariable('#stack' + IntToStr(c), -1);
    { compila o novo script e o prepara para execu��o }
    Compile;
    { corrige a intru��o de prepara��o da subrotina porque ela
      redeclarou todas as vari�veis j� existentes e mais as novas do script }
    FDebugScriptMainRoutine.DeclarationInstruction^.vInteger :=
      FDebugScriptMainRoutine.DeclarationInstruction^.vInteger - FPrepareInstruction^.vInteger;
    //CodeView(AScript); for debug
    VirtualMachine.SolveAbsoluteAddressing;
    ExpandDebugInfo;

    { Run through the compiled instructions and change any reference to the
      virtual machine to a reference to the original virtual machine (Self) }
    FCurrentInstruction := FFirstInstruction;
    while FCurrentInstruction <> nil do
    begin
       {All compute methods are in the virtual machine, so change all of then }
       TMethod(FCurrentInstruction.Compute).Data := Self;
       {The vProc method can be in any object, so first check if it is a method
        of the virtual machine}
       if TMethod(FCurrentInstruction.vProc).Data = VirtualMachine then
         TMethod(FCurrentInstruction.vProc).Data := Self;
       FCurrentInstruction := FCurrentInstruction^.Next;
    end;
  end;
end;

procedure TatVirtualMachine.ExecuteDebugScript( AScript: TatScript );
var
  _paused : boolean;
  _CallExecHookEvent: boolean;
  _CurrentInstruction : pSimplifiedCode;
  _NextInstruction : pSimplifiedCode;
  _PrepareInstruction : pSimplifiedCode;
  _StackTop           : integer;
  _StackBase          : integer;
  _InputBase          : integer;
  _OutputBase         : integer;
  _InputOffset        : integer;
  _OutputOffset       : integer;
  _CurrentInputArgBase : integer;
  _CurrentArrayIndexBase : integer;
  _CurrentOutputArgIndex : integer;
  _OutputStackValue: Variant;
begin
  { executa um script de depura��o dentro do processo em execu��o }
  with AScript do
    if Assigned(FFirstInstruction) then
    begin
      { preserva o estado da m�quina virtual }
      _Paused := FPaused;
      _CallExecHookEvent := FCallExecHookEvent;
      _CurrentInstruction := FCurrentInstruction;
      _NextInstruction := FNextInstruction;
      _PrepareInstruction := FPrepareInstruction;
      _StackTop := FStackTop;
      _StackBase := FStackBase;
      _InputBase := FInputBase;
      _OutputBase := FOutputBase;
      _InputOffset := FInputOffset;
      _OutputOffset := FOutputOffset;
      _CurrentInputArgBase := FCurrentInputArgBase;
      _CurrentArrayIndexBase := FCurrentArrayIndexBase;
      _CurrentOutputArgIndex := FCurrentOutputArgIndex;
      _OutputStackValue := FProcStack[FOutputBase];
      try
        { executa o trecho de c�digo compilado, mas dentro da m�quina virtual corrente }
        FCurrentInstruction := FFirstInstruction;
        FPaused := False;
        while FCurrentInstruction <> nil do
        begin
           FNextInstruction := FCurrentInstruction^.Next;
           FCurrentInstruction.Compute;
           FCurrentInstruction := FNextInstruction;
        end;
        { remove as novas vari�veis eventualmente alocadas da pilha (Unprepare) }
        Dec(FStackTop,FDebugScriptMainRoutine.DeclarationInstruction^.vInteger);
      finally
        { restaura o estado anterior da m�quina virtual }
        FPaused := _Paused;
        FCallExecHookEvent := _CallExecHookEvent;
        FCurrentInstruction := _CurrentInstruction;
        FNextInstruction := _NextInstruction;
        FPrepareInstruction := _PrepareInstruction;
        FStackTop := _StackTop;
        FStackBase := _StackBase;
        FInputBase := _InputBase;
        FOutputBase := _OutputBase;
        FInputOffset := _InputOffset;
        FOutputOffset := _OutputOffset;
        FCurrentInputArgBase := _CurrentInputArgBase;
        FCurrentArrayIndexBase := _CurrentArrayIndexBase;
        FCurrentOutputArgIndex := _CurrentOutputArgIndex;
        FProcStack[FOutputBase] := _OutputStackValue;
      end;
    end
    else
      InternalError('Debugger script not compiled');
end;

function TatVirtualMachine.ExecuteSubroutineEx(ALabel: string;
  input: array of const): variant;
begin
  result := ExecuteSubRoutine(ALabel, input);
end;

procedure TatVirtualMachine.RuntimeError(msg: string);
begin
  if FScript <> nil then
    FScript.RuntimeError(msg);
end;

procedure TatVirtualMachine.DoRunningChanged;
begin
  if Assigned(FOnRunningChanged) then
    FOnRunningChanged(Self);
  if not Script.IsDebugScript then
    Script.Scripter.CheckRunningChanged(Self);
end;

function TatVirtualMachine.GetOnDebugHook: TNotifyEvent;
begin
  if (Script <> nil) and (Script.Scripter <> nil) then
    result := Script.Scripter.FOnDebugHook
  else
    result := nil;
end;

procedure TatVirtualMachine.SetOnDebugHook(const Value: TNotifyEvent);
begin
  if (Script <> nil) and (Script.Scripter <> nil) then
    Script.Scripter.FOnDebugHook := Value;
end;

{ TatScripterEventBroker }

constructor TatScripterEventBroker.Create(AOwner: TComponent);
begin
  inherited;
  FScripter := TatCustomScripter(AOwner);
  FDispatchers := TatEventDispatchers.Create(Self,TatEventDispatcher);
end;

destructor TatScripterEventBroker.Destroy;
begin
  inherited;
  { unset all events setted by current event broker }
  UnsetAllEvents;
  if Assigned(FDispatchers) then FDispatchers.Free;
end;

procedure TatScripterEventBroker.UnsetAllEvents;
var c: integer;
begin
  with FDispatchers do
    for c := Count - 1 downto 0 do
      if Items[c].FIsComponent or not (csDestroying in ComponentState) then
        Items[c].Unset;
end;

function TatScripterEventBroker.InternalSetEvent(
  AInstance: TObject; APropInfo: PPropInfo; ARoutineName: string;
  AScripter: TatCustomScripter; APlacement: TatEventPlacement; AScript: TatScript): TatEventDispatcher;
var
  m : TMethod;
  adap : TAtEventAdapter;
begin
  { find compatible event adapter }
  adap := FEventAdapters.AdapterByPropInfo( APropInfo );

  { instance a new event dispatcher (specialized FDispatchers.Add) }
  result := adap.FDispatcherClass.Create(FDispatchers);
  with result do
  begin
    FAdapter := adap;
    SetInstance(AInstance);
    FPropInfo := APropInfo;
    FScripter := AScripter;
    if Assigned(AScript) then
      FScript := AScript
    else
      FScript := AScripter.CurrentScript;
    {For easy backward compatibility, puts a reference to FScript object inside the RoutineName string}
    FRoutineName := Format('[%s]%s', [IntToStr(integer(FScript)), ARoutineName]);

    FOldCall := GetMethodPropEx(AInstance, APropInfo);
    case APlacement of
      epTopCall: FAfterCall := FOldCall;
      epBottomCall: FBeforeCall := FOldCall;
    end;

    { replace original event by event adapter dispatcher }
    m.Data := result;
    m.Code := adap.FMethodCode;
    SetMethodPropEx(AInstance, APropInfo, m);
  end;

  { event set opportunity }
  if Assigned(FOnSetEvent) then
    FOnSetEvent(result);
end;

function TatScripterEventBroker.GetOldMethod(m:TMethod): TMethod;
begin
  if TObject(m.Data) is TatEventDispatcher then
    with TatEventDispatcher(m.Data) do
      result := OldCall
  else
    result := NilMethod;

(* this implementation avoid unset method that cannot be reached at runtime
   by natural method sequence. I guess this would not be the better behaviour

  if TObject(m.Data) is TatEventDispatcher then
    with TatEventDispatcher(m.Data) do
      if SameMethod(OldCall,BeforeCall) then
        result := BeforeCall
      else
        if SameMethod(OldCall,AfterCall) then
          result := AfterCall
        else
          result := NilMethod
  else
    result := NilMethod; *)
end;

function TatScripterEventBroker.MethodIsDesiredDispatcher(m:TMethod;ARoutineName:string;AScripter:TatCustomScripter): boolean;
begin
  { criteria: m should correspond to an event dispatcher,
    event disptacher should be owned by current event broker,
    (routine name should be null or match dispatcher routine name) and
    (scripter should be nil or match dispatcher scripter) }
  if (TObject(m.Data) is TatEventDispatcher) then
    with TatEventDispatcher(m.Data) do
      if EventBroker=Self then
        result := ((AScripter=nil) or (AScripter=Scripter)) and ((ARoutineName='') or SameText(ARoutineName,RoutineName))
      else
        result := false
  else
    result := false;
end;

function TatScripterEventBroker.GetDispatcherFromMethod(m:TMethod): TatEventDispatcher;
begin
  result := TObject(m.Data) as TatEventDispatcher;
end;

function TatScripterEventBroker.GetMethodPropEx(AInstance: TObject; APropInfo: PPropInfo): TMethod;
{$IFDEF DELPHI2010_LVL}
var
  context: TRttiContext;
  prop: TRttiProperty;
  propName: string;
{$ENDIF}
begin
  {$IFDEF DELPHI2010_LVL}
  propName := string(APropInfo.Name);
  if IsPublishedProp(AInstance, propName) then
  {$ENDIF}
    result := GetMethodProp(AInstance, APropInfo)
  {$IFDEF DELPHI2010_LVL}
  else
  begin
    result := NilMethod;
    context := TRttiContext.Create;
    try
      prop := context.GetType(AInstance.ClassType).GetProperty(propName);
      if prop <> nil then
        prop.GetValue(AInstance).TryAsType<TMethod>(result);
    finally
      context.Free;
    end;
  end;
  {$ENDIF}
end;

function TatScripterEventBroker.GetAssignedRoutineName(AInstance: TObject; APropName: string;
  AScripter: TatCustomScripter): string;
var
  currentMethod, prevMethod, auxMethod: TMethod;
  dispatcher: TatEventDispatcher;
  APropInfo: PPropInfo;
  AMachine: TatVirtualMachine;
begin
  APropInfo := GetPropInfo(AInstance,APropName);

  result := '';

  if Assigned( APropInfo ) then
    currentMethod := GetMethodPropEx(AInstance, APropInfo)
  else
    FatalError('Invalid property (event) information or property is not published');

  prevMethod := NilMethod;

  { explore event stream to find the desired dispatcher }
  auxMethod := currentMethod;
  while AssignedMethod(auxMethod) and not MethodIsDesiredDispatcher(auxMethod, '', AScripter) do
  begin
    prevMethod := auxMethod;
    auxMethod := GetOldMethod(auxMethod);
  end;

  if AssignedMethod(auxMethod) then
  begin
    dispatcher := GetDispatcherFromMethod(auxMethod);
    if dispatcher <> nil then
    begin
      result := dispatcher.RoutineName;
      if (Length(result) > 0) and (result[1] = '[') then
        dispatcher.Scripter.GetInfoFromRoutineName(result, AMachine);
    end;
  end;
end;

function TatScripterEventBroker.InternalUnsetEvent(
  AInstance: TObject; APropInfo: PPropInfo; ARoutineName: string;
  AScripter: TatCustomScripter): boolean;
var
  currentMethod, prevMethod, auxMethod, oldMethod: TMethod;
  dispatcher : TatEventDispatcher;
begin
  { get current method attached to instance property }
  if Assigned(APropInfo) then
    currentMethod := GetMethodPropEx(AInstance, APropInfo)
  else
    FatalError('Invalid property (event) information or property is not published');

  prevMethod := NilMethod;

  { explore event stream to find the desired dispatcher }
  auxMethod := currentMethod;
  while AssignedMethod(auxMethod) and not MethodIsDesiredDispatcher(auxMethod,ARoutineName,AScripter) do
  begin
    prevMethod := auxMethod;
    auxMethod := GetOldMethod(auxMethod);
  end;

  { if found then should redirect instance property (event) and remove the dispatcher }
  if AssignedMethod(auxMethod) then
  begin
    result := true;
    dispatcher := GetDispatcherFromMethod(auxMethod);

    { event unset opportunity }
    if Assigned(FOnUnsettingEvent) then
      FOnUnsettingEvent(dispatcher,result);

    if result then
      with dispatcher do
      begin
        { previous method attached }
        oldMethod := OldCall;

        { if the method have a dispatcher linked to him,
          then should redirect the event stream (like a linked list) }
        if AssignedMethod(prevMethod) then // equivalent to currentMethod <> auxMethod
          with GetDispatcherFromMethod(prevMethod) do
          begin
            if SameMethod(OldCall,BeforeCall) then
            begin
              { redirect top call dispatcher }
              BeforeCall := oldMethod;
              OldCall := oldMethod;
            end;
            if SameMethod(OldCall,AfterCall) then
            begin
              { redirect bottom call dispatcher }
              AfterCall := oldMethod;
              OldCall := oldMethod;
            end;
          end;

        if SameMethod(currentMethod,auxMethod) then // equivalent to not AssignedMethod(prevMethod)
          { redirect the instance property (event) to original method }
          SetMethodPropEx(AInstance, APropInfo, oldMethod);

        { remove dispatcher found }
        Free;
      end;
  end
  else
    result := false;
end;

function TatScripterEventBroker.SetEvent(
  AInstance: TObject; APropName: string; ARoutineName: string;
  AScripter: TatCustomScripter; APlacement: TatEventPlacement; AScript: TatScript = nil): TatEventDispatcher;
var
  procede : boolean;
begin
  result := nil;
  if Assigned(AInstance) and (AInstance.ClassInfo<>nil) and (APropName>'') then
  begin
    procede := True;

    { event setting opportunity }
    if Assigned(FOnSettingEvent) then
      FOnSettingEvent(Self,AInstance,APropName,ARoutineName,AScripter,APlacement,procede);

    if procede then
      result := InternalSetEvent(AInstance,GetPropInfo(AInstance,APropName),ARoutineName,AScripter,APlacement,AScript)
    else
      result := nil;
  end
  else
    FatalError('Cannot set event without an instance and a published property name');
end;

procedure TatScripterEventBroker.SetMethodPropEx(AInstance: TObject;
  APropInfo: PPropInfo; AMethod: TMethod);
{$IFDEF DELPHI2010_LVL}
var
  context: TRttiContext;
  prop: TRttiProperty;
  mvalue: TValue;
  propName: string;
{$ENDIF}
begin
  {$IFDEF DELPHI2010_LVL}
  propName := string(APropInfo.Name);
  if IsPublishedProp(AInstance, propName) then
  {$ENDIF}
    SetMethodProp(AInstance, APropInfo, AMethod)
  {$IFDEF DELPHI2010_LVL}
  else
  begin
    context := TRttiContext.Create;
    try
      prop := context.GetType(AInstance.ClassType).GetProperty(propName);
      if prop <> nil then
      begin
        TValue.Make(@AMethod, prop.PropertyType.Handle, mvalue);
        prop.SetValue(AInstance, mvalue);
      end;
    finally
      context.Free;
    end;
  end;
  {$ENDIF}
end;

function TatScripterEventBroker.UnsetEvent(AInstance: TObject;
  APropName: string; ARoutineName: string=''; AScripter: TatCustomScripter=nil): boolean;
begin
  result := false;
  if Assigned(AInstance) and (AInstance.ClassInfo<>nil) and (APropName>'') then
    result := InternalUnsetEvent(AInstance,GetPropInfo(AInstance,APropName),ARoutineName,AScripter)
  else
    FatalError('Cannot unset event without an instance and a published property name');
end;

procedure TatScripterEventBroker.SetDispatchers(const Value: TatEventDispatchers);
begin
  FDispatchers.Assign(Value);
end;

procedure TatScripterEventBroker.SetOnExecuteEvent(
  const Value: TExecuteEventProc);
begin
  FOnExecuteEvent := Value;
end;

procedure TatScripterEventBroker.SetOnSetEvent(const Value: TSetEventProc);
begin
  FOnSetEvent := Value;
end;

procedure TatScripterEventBroker.SetOnUnsettingEvent(
  const Value: TUnsetEventProc);
begin
  FOnUnsettingEvent := Value;
end;

procedure TatScripterEventBroker.SetOnSettingEvent(
  const Value: TSettingEventProc);
begin
  FOnSettingEvent := Value;
end;

function TatScripterEventBroker.UnsetEvents(AInstance: TObject; APropName: string): boolean;
begin
  result := false;
  if Assigned(AInstance) and (AInstance.ClassInfo<>nil) and (APropName>'') then
    result := InternalUnsetEvents(AInstance,GetPropInfo(AInstance,APropName))
  else
    FatalError('Cannot unset events without an instance and a published property name');
end;

function TatScripterEventBroker.InternalUnsetEvents(AInstance: TObject; APropInfo: PPropInfo): boolean;
var found : boolean;
begin
  { unset all event dispatchers attached to AInstance -> APropName
    since all of them are owned by current event broker }
  result := false;
  repeat
    found := InternalUnsetEvent(AInstance,APropInfo,'',nil);
    if found then result := true;
  until not found;
end;

{ TatEventAdapters }

function TatEventAdapters.FindAdapter(ARttiInfo: PTypeInfo): TatEventAdapter;
var c: integer;
begin
  for c := 0 to Count-1 do
    if Items[c].FRttiInfo=ARttiInfo then
    begin
       result := Items[c];
       Exit;
    end;
  result := nil;
end;

function TatEventAdapters.DefineEventAdapter(ARttiInfo: PTypeInfo; ADispatcherClass: TDispatcherClass; AMethodCode: pointer; ACheck: boolean): TatEventAdapter;
begin
  result := nil;
  if Assigned(ARttiInfo) and (ARttiInfo.Kind=TTypeKind(tkMethod)) then
    if Assigned(ADispatcherClass) then
      if Assigned(AMethodCode) then
      begin
        { find event by RttiInfo,
          if found then replace definition,
          otherwise add a new definition }
        if ACheck then
        begin
          result := FindAdapter(ARttiInfo);
          if not Assigned(result) then
            result := Add;
        end
        else
          result := Add;

        with result do
        begin
          FRttiInfo := ARttiInfo;
          FMethodCode := AMethodCode;
          FDispatcherClass := ADispatcherClass;
        end;
      end
      else
        FatalError('Invalid method pointer on DefineEventAdapter')
    else
      FatalError('Invalid class reference on DefineEventAdapter')
  else
    FatalError('Invalid procedure type information on DefineEventAdapter');
end;

function TatEventAdapters.AdapterByPropInfo(APropInfo: PPropInfo): TatEventAdapter;
var
  c: integer;
  typinf : PTypeInfo;
begin
  result := nil;
  { get type information from property information }
  if Assigned(APropInfo) then
  begin
    typinf := APropInfo^.PropType^;
    if typinf.Kind=TTypeKind(tkMethod) then
      { find and return an adapter based on Rtti property info }
      { use reverse scannig to prior last registered adapters }
      for c:=Count-1 downto 0 do
        if Items[c].FRttiInfo=typinf then
        begin
          result := Items[c];
          Exit;
        end;
    { event adapter not found }
    FatalError(Format('Event adapter not defined for ''%s'' property (%s)',[APropInfo.Name,typinf.Name]));
  end
  else
    FatalError('Invalid property (event) information or property is not published');
end;

function TatEventAdapters.Add: TatEventAdapter;
begin
  result := TatEventAdapter( inherited Add );
end;

function TatEventAdapters.GetItem(i: integer): TatEventAdapter;
begin
  result := TatEventAdapter( inherited Items[i] );
end;

{ TatEventDispatchers }

function TatEventDispatchers.Add: TatEventDispatcher;
begin
  result := TatEventDispatcher( inherited Add );
end;

function TatEventDispatchers.GetItem(i: integer): TatEventDispatcher;
begin
  result := TatEventDispatcher( inherited Items[i] );
end;

{ TatEventDispatcher }

constructor TatEventDispatcher.Create(ACollection: TCollection);
begin
  inherited;
  FNotificator := TatDispatcherRemoveNotificator.Create(nil);
  FNotificator.FDispatcher := Self;
end;

destructor TatEventDispatcher.Destroy;
begin
  FNotificator.Free;
  inherited;
end;

function TatEventDispatcher.DoOnExecuteEvent: boolean;
begin
  result := true;
  with TatScripterEventBroker(TatEventDispatchers(Collection).GetOwner) do
    if Assigned(FOnExecuteEvent) then
      FOnExecuteEvent(Self,result);
end;

function TatEventDispatcher.EventBroker: TatScripterEventBroker;
begin
  result := TatScripterEventBroker(TatEventDispatchers(Collection).GetOwner);
end;

procedure TatEventDispatcher.SetAdapter(const Value: TatEventAdapter);
begin
  FAdapter := Value;
end;

procedure TatEventDispatcher.SetAfterCall(const Value: TMethod);
begin
  FAfterCall := Value;
end;

procedure TatEventDispatcher.SetBeforeCall(const Value: TMethod);
begin
  FBeforeCall := Value;
end;

procedure TatEventDispatcher.SetInstance(const Value: TObject);
begin
  if FInstance <> Value then
  begin
    { disallow EventBroker to receive notifications from FInstance (when FInstance is a component) }
    FIsComponent := Assigned(FInstance) and (FInstance is TComponent);
    if FIsComponent then
      TComponent(FInstance).RemoveFreeNotification(FNotificator);

    FInstance := Value;

    { allow EventBroker to know receive notifications from FInstance (when FInstance is a component) }
    FIsComponent := Assigned(FInstance) and (FInstance is TComponent);
    if FIsComponent then
      TComponent(FInstance).FreeNotification(FNotificator);
  end;
end;

procedure TatEventDispatcher.SetOldCall(const Value: TMethod);
begin
  FOldCall := Value;
end;

procedure TatEventDispatcher.SetPropInfo(const Value: PPropInfo);
begin
  FPropInfo := Value;
end;

procedure TatEventDispatcher.SetScripter(const Value: TatCustomScripter);
begin
  FScripter := Value;
end;

procedure TatEventDispatcher.Unset;
begin
  { remove this dispatcher from EventBroker }
  EventBroker.InternalUnsetEvent(FInstance,FPropInfo,FRoutineName,FScripter);
end;

{ TatEventAdapter }

procedure TatEventAdapter.Assign(ASource: TPersistent);
begin
  if ASource is TatEventAdapter then
  begin
    FRttiInfo   := TatEventAdapter(ASource).FRttiInfo;
    FMethodCode := TatEventAdapter(ASource).FMethodCode;
    FDispatcherClass := TatEventAdapter(ASource).FDispatcherClass;
  end
  else
    inherited;
end;

{ TatDispatcherRemoveNotificator }

procedure TatDispatcherRemoveNotificator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  { unset event dispatcher when component,
    that owns event property attached to this dispatcher,
    has been destroyed }
  if (FDispatcher.FInstance=AComponent) and (Operation=opRemove) then
    FDispatcher.Unset;
end;

{ TatCustomScripter - Event support }

procedure TatCustomScripter.TranslateMethodGetter(AMachine: TatVirtualMachine; AInstance:TObject; APropInfo: PPropInfo; var AValue: Variant);
var
  m: TMethod;
begin
  m := FEventBroker.GetMethodPropEx(AInstance, APropInfo);
  { if event is setted to this scripter and to an event dispatcher
  then RoutineName may be returned,
  otherwise return a generic method representation }
  if (TObject(m.Data) is TatEventDispatcher) and (TatEventDispatcher(m.Data).Scripter=Self) then
    AValue := TatEventDispatcher(m.Data).RoutineName
  else
    AValue := Format('@%.4X-%.4X',[integer(m.Data),integer(m.Code)]);
end;

procedure TatCustomScripter.TranslateMethodSetter(AMachine: TatVirtualMachine; AInstance:TObject; APropInfo: PPropInfo; AValue: Variant );
const NilMethod: TMethod = (Code: nil; Data: nil);
begin
  if VarIsEmpty(AValue) or VarIsNull(AValue) or (VarToStr(AValue) = '') or
     (
      ((VarType(AValue) = varInteger) or (VarType(AValue) = varByte)
       {$IFDEF DELPHI6_LVL}or (VarType(AValue) = varWord){$ENDIF}
       or (VarType(AValue) = varSmallInt))
      and (AValue=0{CoreConst[Nil]})) then
    { Unsetting event }
    case FEventUnsetMode of
      euReplaceNil:
        { replace the event to NIL throuh event broker }
        FEventBroker.InternalSetEvent(AInstance,APropInfo,'',Self,epReplaceCall,nil);
      euOriginalEvent:
        { restore the method to the original state
          (equal to state before pushing the first event dispatcher
          owned by this scripter) }
        FEventBroker.InternalUnsetEvents(AInstance,APropInfo);
      euClearEvent:
        { set the method to NIL }
        FEventBroker.SetMethodPropEx(AInstance, APropInfo, NilMethod);
      euPreviousEvent:
        { remove only the last setted event dispatcher
         (if any, owned by this scripter) }
        FEventBroker.InternalUnsetEvent(AInstance,APropInfo,'',Self);
    end
  else
    case FEventSetMode of
      esReplaceEvent:
        { replace the event, through the event broker }
        FEventBroker.InternalSetEvent(AInstance,APropInfo,VarToStr(AValue),Self,epReplaceCall,nil);
      esAddEventOnTop:
        { insert a new event handler before the previous event handler,
          through the event broker }
        FEventBroker.InternalSetEvent(AInstance,APropInfo,VarToStr(AValue),Self,epTopCall,nil);
      esAddEventOnBottom:
        { append a new event handler after the previous event handler,
          through the event broker }
        FEventBroker.InternalSetEvent(AInstance,APropInfo,VarToStr(AValue),Self,epBottomCall,nil);
    end;
end;

{ global event adapter registration }
{ use ACheck=True to avoid redefinition for adapter of same PTypeInfo }
function DefineEventAdapter(ARttiInfo:PTypeInfo; ADispatcherClass: TDispatcherClass; AMethodCode: pointer; ACheck: boolean=true): TatEventAdapter;
begin
  result := EventAdapters.DefineEventAdapter(ARttiInfo, ADispatcherClass, AMethodCode, ACheck);
end;

{ TatVirtualMachines }

function TatVirtualMachines.Add: TatVirtualMachine;
begin
  result := TatVirtualMachine( inherited Add );
end;

function TatVirtualMachines.GetItems(i: integer): TatVirtualMachine;
begin
  result := TatVirtualMachine( inherited Items[i] );
end;

{ TatUsedUnits }

function TatUsedUnits.Add: TatUsedUnit;
begin
  result := TatUsedUnit(inherited Add);
end;

constructor TatUsedUnits.Create(AScripter: TatCustomScripter);
begin
  FScripter := AScripter;
  inherited Create(TatUsedUnit);
end;

function TatUsedUnits.FindByName(AUnitName: string): TatUsedUnit;
var
  c: integer;
begin
  result := nil;
  for c := 0 to Count - 1 do
    if SameText(AUnitName, Items[c].UnitName) then
    begin
      result := items[c];
      break;
    end;
end;

function TatUsedUnits.GetItem(i: integer): TatUsedUnit;
begin
  result := TatUsedUnit(inherited Items[i]);
end;

{ TatDebugWatches }

function TatDebugWatches.Add: TatDebugWatch;
begin
  result := TatDebugWatch( inherited Add );
end;

function TatDebugWatches.GetItem(i: Integer): TatDebugWatch;
begin
  result := TatDebugWatch( inherited Items[i] );
end;

procedure TatDebugWatches.CompileAndEvaluateAll;
var c: integer;
begin
  { recompila e executa todas as watches }
  for c:=0 to Count-1 do
    CompileAndEvaluate(Items[c]);
end;

procedure TatDebugWatches.CompileAndEvaluate(AWatch:TatDebugWatch);
begin
  with AWatch do
    if Enabled and (Expression > '') then
      CompileAndEvaluate;
end;

procedure TatDebugWatches.EvaluateAll;
var c: integer;
begin
  { executa todas as watches (recompila apenas as que t�m o flag de recompila��o for�ada) }
  for c:=0 to Count-1 do
    Evaluate(Items[c]);
end;

procedure TatDebugWatches.Evaluate(AWatch:TatDebugWatch);
begin
  with AWatch do
    if Enabled and (Expression > '') then
      if AlwaysCompile or (WatchStatus=wsNotEvaluated) then
      begin
      // when the IDE is running an Exception can be triggered here
      // when debugging options "stop on exception" is enabled.
      // This exception is handled correct when run not from the IDE
        CompileAndEvaluate;
      end
      else
        Evaluate;
end;

{ TatDebugWatch }

procedure TatDebugWatches.Reset;
var c: integer;
begin
  for c:=0 to Count-1 do
    Items[c].Reset;
end;

constructor TatDebugWatch.Create(ACollection: TCollection);
begin
  inherited;
  { cria um novo script para compila��o e execu��o da express�o do watch }
  FDebugScript :=  Machine.FScript.FScripter.FScripts.Add;
  FDebugScript.FIsDebugScript := True;
  FDebugScript.FOnDestroy := ScriptDestroyed;
  FAlwaysCompile := True;
  FEnabled := True;
end;

destructor TatDebugWatch.Destroy;
begin
  if Assigned(FDebugScript) then FDebugScript.Free;
  inherited;
end;

procedure TatDebugWatch.ScriptDestroyed(Sender: TObject);
begin
  { remove a refer�ncia ao script que est� sendo destru�do }
  FDebugScript := nil;
end;

function TatDebugWatch.Machine: TatVirtualMachine;
begin
  result := TatDebugWatches(Collection).GetOwner as TatVirtualMachine;
end;

procedure TatDebugWatch.CompileAndEvaluate;
begin
  WatchStatus := wsNotEvaluated;
  try
    if Machine.Running then
      Machine.CompileDebugScript(DebugScript)
    else
      Abort;
    { executa o script que acaba de ser compilado com sucesso }
    Evaluate;
  except
    on ex:Exception do
    begin
      { em caso de falha de compila��o apenas sinaliza no watch que � inv�lido }
      WatchStatus := wsCompileError;
    end;
  end;
end;

procedure TatDebugWatch.Evaluate;
var
  AVar: TatVariableInfo;
  AStackPos: integer;
begin
  WatchStatus := wsNotEvaluated;
  try
    if Machine.Running then
      Machine.ExecuteDebugScript(DebugScript)
    else
      Abort;

    { obt�m o valor da vari�vel tempor�ria que foi alocada no trecho de c�digo
      que representou a express�o do watch }
    AStackPos := -1;
    AVar := DebugScript.ScriptInfo.Globals.FindByName('_TatDebugWatch_expression_');
    if AVar <> nil then
      AStackPos := AVar.VarIndex
    else
    begin
      AVar := DebugScript.FDebugScriptMainRoutine.VariableByName('_TatDebugWatch_expression_');
      if AVar <> nil then
        AStackPos := Machine.FStackBase + AVar.VarIndex;
    end;

    if AStackPos <> -1 then
    begin
      {LastResult := Machine.FProcStack[
        Machine.FStackBase +
        DebugScript.FDebugScriptMainRoutine.VariableByName('_TatDebugWatch_expression_').VarIndex ];}
      LastResult := Machine.FProcStack[AStackPos];
      WatchStatus := wsEvaluated;
    end else
      WatchStatus := wsRuntimeError;

  except
    on ex:Exception do
    begin
      { em caso de falha de execu��o apenas sinaliza no watch que � inv�lido }
      WatchStatus := wsRuntimeError;
    end;
  end;
end;

procedure TatDebugWatch.SetExpression(const Value: string);
begin
  if FExpression <> Value then
  begin
    FExpression := Value;
    FDebugScript.SourceCode.Text := FDebugScript.EncodeSingleAssign(
      '_TatDebugWatch_expression_', FExpression );
    WatchStatus := wsNotEvaluated;
  end;
end;

{ TatDebugWatch }

procedure TatDebugWatch.SetLastResult(const Value: variant);
begin
  if (VarType(FLastResult)<>VarType(Value)) or (Value<>FLastResult) then
  begin
    FLastResult := Value;
    FResultChanged := True;
  end
  else
    FResultChanged := False;
end;

procedure TatDebugWatch.Reset;
begin
  { limpa informa��es de runtime do watch, deixando apenas a parte de seu
    conte�do que n�o � dependente da execu��o }
  DebugScript.Clear;
  LastResult := Unassigned;
  WatchStatus := wsNotEvaluated;
end;

procedure TatDebugWatch.FullEvaluate;
begin
  if (Collection is TatDebugWatches) then
    TatDebugWatches(Collection).Evaluate(Self);
end;

{ TatScriptBasedLibrary }

procedure TatScriptBasedLibrary.GetScriptVarProc(AMachine: TatVirtualMachine);
var
  AGlobalVar: TatVariableInfo;
begin
  AGlobalVar := GetRunScript(AMachine).ScriptInfo.Globals.FindByName(AMachine.CurrentPropertyName);
  if AGlobalVar <> nil then
    AMachine.ReturnOutputArg(AGlobalVar.Value)
  else
    AMachine.ReturnOutputArg(NULL);
end;

procedure TatScriptBasedLibrary.SetScriptVarProc(AMachine: TatVirtualMachine);
var
  AGlobalVar: TatVariableInfo;
begin
  AGlobalVar := GetRunScript(AMachine).ScriptInfo.Globals.FindByName(AMachine.CurrentPropertyName);
  if AGlobalVar <> nil then
    AGlobalVar.Value := AMachine.GetInputArg(0);
end;

procedure TatScriptBasedLibrary.ExecSubRoutineProc(AMachine: TatVirtualMachine);
var
  Params: array of Variant;
  args: array of TVarRec;
  i: integer;
  oldCur: pSimplifiedCode;
begin
  SetLength(Params, AMachine.InputArgCount);
  SetLength(args, AMachine.InputArgCount);

  for i := 0 to AMachine.InputArgCount - 1 do
  begin
    Params[i] := AMachine.GetInputArg(i);
    args[i].VType := vtVariant;
    args[i].VVariant := @(Params[i]);
  end;

  oldCur := AMachine.FCurrentInstruction;

  AMachine.ReturnOutputArg(GetRunScript(AMachine).VirtualMachine.ExecuteSubRoutineEx(AMachine.CurrentMethodName, args));
  AMachine.FCurrentInstruction := oldCur;

  if not AMachine.Halted then
    for i := 0 to AMachine.InputArgCount - 1 do
      AMachine.SetInputArgIfByRef(i, Params[i]);
end;

procedure TatScriptBasedLibrary.Init;
var
  c: integer;
  d: integer;
  i: integer;
  met: TatMethod;
  rout: TatRoutineInfo;
begin
  if FRegClass = nil then
    FRegClass := ClassType;
  if FRegClassName = '' then
    FRegClassName := FRegClass.ClassName;

  if FRegClass <> ClassType then
  begin
    i := Scripter.Classes.IndexOf(FRegClassName);
    if i >= 0 then
    begin
      (***************if Scripter.Classes[i].FBaseScript <> FInternalScript then
        FInternalScript.RuntimeError(Format('Class "%s" already registered by another script.', [FRegClassName]));*************)
    end;
  end;

  FNewClass := Scripter.DefineClass(FRegClass, FRegClassName);
  FNewClass.FBaseScript := FInternalScript;

  With FInternalScript.ScriptInfo do
  begin
    for c := 0 to Routines.Count - 1 do
      if Routines[c].Name <> '___MAIN___' then
      begin
        if Routines[c].Visibility <> rvPrivate then
        begin
          rout := Routines[c];
          met := FNewClass.DefineNewMethod(Routines[c].Name, rout.ArgCount, tkVariant, nil, ExecSubRoutineProc);
          FMethodList.Add(met);
          if rout.FByRefArgMask > 0 then
          begin
            for d := 0 to rout.Variables.Count-1 do
              if rout.Variables[d].Modifier=moVar then
                met.SetVarArgs([d]);
          end;
        end;
      end;
    for c := 0 to Globals.Count - 1 do
      Case Globals[c].Visibility of
        vvPublic:
          FPropList.Add(FNewClass.DefineNewProp(Globals[c].VarName, tkVariant, GetScriptVarProc, SetScriptVarProc));
        vvPrivate: ; //do not register private variables
      end;
  end;
end;

constructor TatScriptBasedLibrary.Create(AScripter: TatCustomScripter);
begin
  inherited Create(AScripter);
  FMethodList := TList.Create;
  FPropList := TList.Create;
end;

destructor TatScriptBasedLibrary.Destroy;
begin
  FMethodList.Free;
  FPropList.Free;
  inherited;
end;

procedure TatScriptBasedLibrary.Finalize;
var
  c: integer;
begin
  for c := 0 to FMethodList.Count - 1 do
    TatMethod(FMethodList[c]).Free;
  FMethodList.Clear;
  for c := 0 to FPropList.Count - 1 do
    TatProperty(FPropList[c]).Free;
  FPropList.Clear;

  {if FRegClass <> ClassType then
    FNewClass.Free;}
end;

function TatScriptBasedLibrary.GetRunScript(AMachine: TatVirtualMachine): TatScript;
begin
  if AMachine.CurrentObject is TatScriptBasedLibrary then
    result := TatScriptBasedLibrary(AMachine.CurrentObject).FInternalScript
  else
  if AMachine.CurrentObject is TScriptForm then
    result := TScriptForm(AMachine.CurrentObject).FRunScript
  else
    result := FInternalScript;
end;

{ TScripterLibraryOptions }

procedure TScripterLibraryOptions.Assign(Source: TPersistent);
begin
  if Source is TScripterLibraryOptions then
  begin
    FSearchPath.Assign(TScripterLibraryOptions(Source));
    FSourceFileExt := TScripterLibraryOptions(Source).FSourceFileExt;
    FCompiledFileExt := TScripterLibraryOptions(Source).FCompiledFileExt;
    FFormFileExt := TScripterLibraryOptions(Source).FFormFileExt;
    FUseScriptFiles := TScripterLibraryOptions(Source).FUseScriptFiles;
  end else
    inherited Assign(Source);
end;

constructor TScripterLibraryOptions.Create;
begin
  FSearchPath := TStringList.Create;
end;

destructor TScripterLibraryOptions.Destroy;
begin
  FSearchPath.Free;
  inherited;
end;

procedure TScripterLibraryOptions.SetSearchPath(const Value: TStrings);
begin
  FSearchPath.Assign(Value);
end;

{ TatDLL }

procedure TatDLL.Finalize;
var c: integer;
begin
  { remove os m�todos criados especificamente para o script que declarou esta DLL }
  { varre as rotinas do scripter, procurando naquelas que s�o externas (dll) }
  with FScript.FScriptInfo do
    for c:=Routines.Count-1 downto 0 do
      with Routines[c] do
        if SameText( FExternalDll, FFileName ) then
          { exclui o m�todo correspondente ao nome da rotina }
          FatClass.MethodByName( Copy(FName,2,999) ).Free;
  inherited;
end;

procedure TatDLL.Init;
begin
  { apenas define uma classe para encapsular os m�todos externos }
  FatClass := Scripter.DefineClass(ClassType);
end;

class function TatDLL.LibraryName: string;
begin
  result := '_DLL_';
end;

{ TScriptForm }

destructor TScriptForm.Destroy;
begin
  if FRunScript <> nil then
  begin
    FRunScript.Free;
    FRunScript := nil;
  end;
  FSaveProps.Free;
  FSaveEvents.Free;
  inherited;
end;

procedure TScriptForm.NewFormInstance(AMachine: TatVirtualMachine);
var
  ABaseScript: TatScript;
  MS: TMemoryStream;
begin
  ABaseScript := nil;

  {Retrieve initial information from the AMachine}
  if AMachine.Script.Scripter = nil then
    AMachine.RunTimeError('Cannot creat script form: Scripter property of machine is not specified.');
  if AMachine.CurrentClass <> nil then
    ABaseScript := AMachine.CurrentClass.FBaseScript
  else
    AMachine.RuntimeError('Cannot create script form: CurrentClass not specified.');
  if ABaseScript = nil then
    AMachine.RuntimeError('Cannot create script form: BaseScript not assigned.');

  {Add a new script in the scripter component}
  FRunScript := AMachine.Script.Scripter.Scripts.Add;

  {We must copy source code from base script to FRunScript, because we need debug information
   for breakpoints, etc.}
  FRunScript.SourceCode.Text := ABaseScript.SourceCode.Text;

  {Uses the newly created form to be default instance so that methods and properties and objects
   are accessible just like in Delphi: "Edit1.Text" or "Show".
   OBS.: This script preparation must be done before the savecode/loadcode below, because
   when LoadCodeFromStream is caled, it automatically solves absolute addressing, and all default instances
   of new script must be the same as the base script}
  FRunScript.UsesObject(Self, '', ABaseScript.ScriptInfo.ScriptClassName);
  FRunScript.AddObject('Self', Self);

  {Copy compiled script code from base script to newly created script}
  MS := TMemoryStream.Create;
  try
    {Load the saved compiled code of script into the new script}
    ABaseScript.FCodeStream.Position := 0;
    FRunScript.InternalLoadCodeFromStream(ABaseScript.FCodeStream, false);
    FRunScript.ScriptInfo.IsForm := true;

    {Adds the newly created FRunScript to the script list in basescript, and also set basescript as
     "owner" of runscript. This is to keep references between the base and generated script, for breaks purpose,
     and also of course to keep pointers correct}
    FRunScript.SetOriginalScript(ABaseScript);
    FRunScript.FOriginalForm := Self;
  finally
    MS.Free;
  end;
  LoadFormResource(ABaseScript.ScriptInfo.FormResource, FRunScript.Scripter.LoadFormEvents);
end;

procedure TScriptForm.LoadFormResource(AFormRes: string; ALoadEvents: boolean);
var
  SS: TStringStream;
  MS: TMemoryStream;
  Reader: TReader;
begin
  SS := TStringStream.Create(AFormRes);
  try
    SS.Position := 0;
    MS := TMemoryStream.Create;
    ObjectTextToBinary(SS, MS);
    MS.Position := 0;

    Reader := TReader.Create(MS, 4096);
    try
      FLastSearchedMethod := '';
      if ALoadEvents then
      begin
        Reader.OnFindMethod := ReaderFindMethod;
        Reader.OnError := ReaderError;
      end;
      Reader.ReadRootComponent(Self);
    finally
      Reader.Free;
    end;

    MS.Free;
  finally
    SS.Free;
  end;
end;

constructor TScriptForm.CreateFromScript(AOwner: TComponent;
  AMachine: TatVirtualMachine);
begin
  CreateNew(AOwner);
  NewFormInstance(AMachine);
  RestoreSavedEvents;
  RestoreSavedProps;
end;

constructor TScriptForm.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
end;

constructor TScriptForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  FSaveProps := TStringList.Create;
  FSaveEvents := TStringList.Create;
  Visible := false;
  FSaveProps.Values['Visible'] := 'False';


//  KeyPreview := true;

  inherited;
end;

procedure TScriptForm.RestoreSavedEvents;

  procedure SetEventFromString(CompName, PropName, RoutineName: string);
  var
    Comp: TComponent;
  begin
    if UpperCase(CompName) = 'SELF' then
      Comp := Self
    else
      Comp := FindComponent(CompName);

    if Assigned(Comp) and Assigned(RunScript) and Assigned(RunScript.Scripter) then
    begin
      RunScript.Scripter.EventBroker.SetEvent(Comp, PropName, RoutineName, RunScript.Scripter,
        epReplaceCall, RunScript);
    end;
  end;

var
  c: integer;
  CompName: string;
  EventName: string;
  StrName: string;
  P: integer;
begin
  for c := 0 to FSaveEvents.Count - 1 do
  begin
    {Retrieve component and event name}
    StrName := FSaveEvents.Names[c];
    P := Pos('.', StrName);
    CompName := Copy(StrName, 1, P - 1);
    EventName := Copy(StrName, P + 1, MaxInt);
    SetEventFromString(CompName, EventName, FSaveEvents.Values[StrName]);
  end;
end;

procedure TScriptForm.RestoreSavedProps;

  function StrToIntSet(APropType: PTypeInfo; Value: string): integer;
  var
    Val,Enum: string;
    P, V: Integer;
  begin
    Result := 0;
    if Length(Value) > 2 then
    begin
      Val := Value;
      if Val[1] = '[' then Delete(Val, 1, 1);
      if Val[Length(Val)] = ']' then Delete(Val, Length(Val), 1);
      repeat
        P := Pos(',', Val);
        if (P=0) and (Val<>'') then Enum:=Val
        else Enum:=Copy(Val,1,Pred(P));
        Delete(Val,1,P);
        V:=GetEnumValue(GetTypeData(APropType).CompType^, Enum);
        if V=0 then V:=1
        else V:=1 shl V;
        Result:=Result or V;
      until P=0;
    end;
  end;

  function StrToObject(Value: string): TObject;
  begin
    result := FindComponent(Value);
  end;

  procedure SetPropFromString(APropInfo: PPropInfo; Value: string);
  var
    APropType: PTypeInfo;
  begin
    APropType := APropInfo.PropType^;
    case APropType.Kind of
      TypInfo.tkString, TypInfo.tkLString, TypInfo.tkWString:
        SetStrProp(Self, APropInfo, Value);
      {$IFDEF DELPHI2009_LVL}
      TypInfo.tkUString:
        SetUnicodeStrProp(Self, APropInfo, value);
      {$ENDIF}
      TypInfo.tkInteger:
        SetOrdProp(Self, APropInfo, StrToInt(Value));

      TypInfo.tkVariant:
        SetVariantProp(Self, APropInfo, Value);

      TypInfo.tkEnumeration:
        SetOrdProp(Self, APropInfo, VarToEnumInteger(Value, APropType));

      TypInfo.tkSet:
        SetOrdProp(Self, APropInfo, StrToIntSet(APropType, Value));

      TypInfo.tkFloat:
        SetFloatProp(Self, APropInfo, StrToFloat(Value));

      TypInfo.tkClass:
        SetOrdProp(Self, APropInfo, integer(StrToObject(Value)));
    end;
  end;

var
  c: integer;
  PropName: string;
begin
  for c := 0 to FSaveProps.Count - 1 do
  begin
    PropName := FSaveProps.Names[c];
    SetPropFromString(GetPropInfo(Self, PropName), FSaveProps.Values[PropName]);
  end;
end;

procedure TScriptForm.SetSaveProps(const Value: TStrings);
begin
  FSaveProps.Assign(Value);
end;

procedure TScriptForm.SetSaveEvents(const Value: TStrings);
begin
  FSaveEvents.Assign(Value);
end;

function TScriptForm.IsShortCut(var Message: TWMKey): Boolean;
var
  debugkey: boolean;
begin
  result := inherited IsShortCut(Message);

  {When in modal mode, perform some debug actions for some specific shortcuts, to avoid hanging}
  debugkey := false;
  if (FRunScript <> nil) and (FRunScript.Scripter <> nil) and
    (FRunScript.Scripter.Running) and (fsModal in FormState) and (FRunScript.Scripter.Paused) then
  begin
    debugkey := true;
    Case message.CharCode of
      VK_F7:
        FRunScript.Scripter.DebugTraceIntoLine;
      VK_F8:
        FRunScript.Scripter.DebugStepOverLine;
      VK_F9:
        FRunScript.Scripter.Paused := false;
    else
      debugkey := false;
    end;
  end;
  result := result or debugkey;
end;

procedure TScriptForm.ReaderFindMethod(Reader: TReader; const MethodName: string;
  var Address: Pointer; var Error: Boolean);
begin
  FLastSearchedMethod := MethodName;
end;

procedure TScriptForm.ReaderError(Reader: TReader; const Message: string;
  var Handled: Boolean);

  function _IsValidChar(C: Char): Boolean;
  const
    Alpha = ['A'..'Z', 'a'..'z', '_'];
    AlphaNumeric = Alpha + ['0'..'9'];
  begin
    {$IFDEF DELPHI2009_LVL}
    Result := TCharacter.IsLetterOrDigit(C) or (C = '_');
    {$ELSE}
    Result := C in AlphaNumeric;
    {$ENDIF}
  end;


var
  Comp: string;
  Event: string;
  P1: integer;
  P: integer;
begin
  {workaround to retrieve events in forms. Find Comp.Event text in message}
  P1 := Pos('.', Message);
  Comp := '';
  P := P1 - 1;
  while (P > 0) and (_IsValidChar(Message[P])) do
  begin
    Comp := Copy(Message, P, P1 - P);
    Dec(P);
  end;

  Event := '';
  P := P1 + 1;
  while (P <= Length(Message)) and (IsValidIdent(Copy(Message, P1 + 1, P - P1))) do
  begin
    Event := Copy(Message, P1 + 1, P - P1);
    Inc(P);
  end;

  {if last searched method is not nil, it means that the reader executed FindMethod to find
  the event handler name, and then raised this error. So we can try to ignore the error and add
  the event to method names}
  if FLastSearchedMethod <> '' then
  begin
    FSaveEvents.Add(Format('%s.%s=%s', [Comp, Event, FLastSearchedMethod]));
    FLastSearchedMethod := '';
    Handled := true;
  end;
end;

{ TatScriptRefactor }

constructor TatScriptRefactor.Create(AScript: TatScript);
begin
  FScript := AScript;
  FDirtySource := true;
end;

function TatScriptRefactor.SourcePos(SubStr: string;
  FromPos: integer = 1): integer;
var
  PtrStart, PtrFound : PChar;
  Str: string;
begin
  Str := UpcaseSource;
  if (FromPos <= 0) or (FromPos > (Length(Str) - Length(SubStr) + 1)) then
  begin
    result := 0;
    exit;
  end;
  PtrStart := PChar(Str);
  inc(PtrStart, FromPos - 1);
  PtrFound := StrPos(PtrStart, PChar(SubStr));
  if PtrFound <> nil then
    Result := PtrFound - PChar(Str) + 1
  else
    Result := 0;
end;

function TatScriptRefactor.GetSource: TStrings;
begin
  if (Script <> nil) then
    result := Script.SourceCode
  else
    result := nil;
end;

function TatScriptRefactor.GetUpcaseSource: string;
begin
  if FDirtySource then
  begin
    FUpcaseSource := UpperCase(Source.Text);
    FDirtySource := false;
  end;
  result := FUpcaseSource;
end;

procedure TatScriptRefactor.UpdateFormHeader(AFormClass,
  AFileName: string);
begin
end;

function TatScriptRefactor.DeclareRoutine(ProcName: string): integer;
var
  AInfo: TatRoutineInfo;
begin
  AInfo := TatRoutineInfo.Create(nil);
  try
    AInfo.Name := ProcName;
    result := DeclareRoutine(AInfo);
  finally
    AInfo.Free;
  end;
end;

function TatScriptRefactor.DeclareRoutine(AInfo: TatRoutineInfo): integer;
begin
  result := 0;
end;

procedure TatScriptRefactor.AddUsedUnit(AUnitName: string);
begin
end;

procedure TatScriptRefactor.BeginRefactor;
begin
  if Script <> nil then
    Inc(Script.FRefactoring);
end;

procedure TatScriptRefactor.EndRefactor;
begin
  if Script <> nil then
  begin
    Dec(Script.FRefactoring);
    if Script.FRefactoring = 0 then
    begin
      //Operations to remove attached events that do not work anymore?
    end;
  end;
end;

{ TatScriptBreaks }

function TatScriptBreaks.Add: TatScriptBreak;
begin
  result := TatScriptBreak(inherited Add);
end;

function TatScriptBreaks.FindByLine(ALine: integer): TatScriptBreak;
var
  c: integer;
begin
  result := nil;
  for c := 0 to Count - 1 do
    if Items[c].Line = ALine then
    begin
      result := Items[c];
      break;
    end;
end;

function TatScriptBreaks.GetItem(Index: integer): TatScriptBreak;
begin
  result := TatScriptBreak(inherited Items[Index]);
end;

function TatScriptBreaks.Script: TatScript;
begin
  if GetOwner is TatScript then
    result := TatScript(GetOwner)
  else
    result := nil;
end;

procedure TatScriptBreaks.ToggleBreak(ALine: integer);
var
  ABreak: TatScriptBreak;
begin
  ABreak := FindByLine(ALine);
  if ABreak <> nil then
    ABreak.Free
  else
  begin
    ABreak := Add;
    ABreak.Line := ALine;
  end;
end;

procedure TatScriptBreaks.UpdateAll;
var
  c: integer;
begin
  if Script.FOriginalScript <> nil then
    Script.FOriginalScript.Breaks.UpdateAll;
  for c := 0 to Count - 1 do
    Items[c].UpdateBreakPoints;
end;

{ TatScriptBreak }

procedure TatScriptBreak.BreakpointDestroyed(
  ABreakPoint: TatScriptBreakPoint);
begin
  FBreakList.Remove(ABreakPoint);
end;

constructor TatScriptBreak.Create(Collection: TCollection);
begin
  inherited;
  FBreakList := TObjectList.Create(false);
  FLine := -1;
end;

destructor TatScriptBreak.Destroy;
begin
  RemoveBreakPoints;
  FBreakList.Free;
  inherited;
end;

function TatScriptBreak.Script: TatScript;
begin
  if Collection is TatScriptBreaks then
    result := TatScriptBreaks(Collection).Script
  else
    result := nil;
end;

procedure TatScriptBreak.SetLine(const Value: integer);
begin
  if FLine <> Value then
  begin
    FLine := Value;
    UpdateBreakPoints;
  end;
end;

procedure TatScriptBreak.RemoveBreakPoints;
begin
  {When destroying a list object, it will be automatically
   removed from FBreakList because the callback method BreakPointDestroyed is called
   and removed the object from list. So we can safely rely that this loop will not be infinite}
  while FBreakList.Count > 0 do
    TatScriptBreakPoint(FBreakList[0]).Free;
end;

procedure TatScriptBreak.UpdateBreakPoints;

  procedure UpdateBreakInScript(ATargetScript: TatScript);
  var
    ATargetInst: pSimplifiedCode;
    ANewBreak: TatScriptBreakpoint;
  begin
    if ATargetScript.ExpandedDebugInfo then
    begin
      ATargetInst := ATargetScript.VirtualMachine.InstructionByLine(FLine);
      if ATargetInst <> nil then
      begin
        ANewBreak := ATargetScript.VirtualMachine.BreakPoints.InsertNormalBreak(ATargetInst);
        if ANewBreak <> nil then
        begin
          ANewBreak.FNotifyBreak := Self;
          FBreakList.Add(ANewBreak);
          if FAutoDestroy then
            ANewBreak.FBreakInst^.vProc := TemporaryBreakProc;
        end;
      end;
    end;
  end;

var
  c: integer;
begin
  {Remove existing breakpoints}
  RemoveBreakPoints;

  {Now insert the breakpoints in the script itself, and all derived scripts (forms)}
  UpdateBreakInScript(Script);
  for c := 0 to Script.FDerivedScripts.Count - 1 do
    UpdateBreakInScript(TatScript(Script.FDerivedScripts[c]));
end;

procedure TatScriptBreak.TemporaryBreakProc;
begin
  {Stop script execution}
  Script.Scripter.Paused := true;

  {Now remove all breakpoints related to the script}
  RemoveBreakpoints;

  Free;
end;


{ TatScripterWatches }

function TatScripterWatches.Add: TatScripterWatch;
begin
  result := TatScripterWatch( inherited Add );
end;

procedure TatScripterWatches.EvaluateAll;
var
  c: integer;
begin
  for c := 0 to Count - 1 do
    Items[c].Evaluate;
end;

function TatScripterWatches.GetItem(i: Integer): TatScripterWatch;
begin
  result := TatScripterWatch(inherited Items[i]);
end;

function TatScripterWatches.Scripter: TatCustomScripter;
begin
  if GetOwner is TatCustomScripter then
    result := TatCustomScripter(GetOwner)
  else
    result := nil;
end;

{ TatScripterWatch }

constructor TatScripterWatch.Create(ACollection: TCollection);
begin
  inherited;
  FDebugScript := Scripter.Scripts.Add;
  FDebugScript.FIsDebugScript := True;
  FDebugScript.FOnDestroy := ScriptDestroyed;
  FEnabled := True;
  Reset;
end;

destructor TatScripterWatch.Destroy;
begin
  if Assigned(FDebugScript) then FDebugScript.Free;
  inherited;
end;

procedure TatScripterWatch.Evaluate;
begin
  Reset;
  if (Scripter <> nil) and (Scripter.CurrentScript <> nil) and (Scripter.CurrentScript.VirtualMachine <> nil) then
    InternalEvaluate(Scripter.CurrentScript.VirtualMachine);
end;

procedure TatScripterWatch.InternalEvaluate(AMachine: TatVirtualMachine);
var
  AVar: TatVariableInfo;
  AStackPos: integer;
begin
  Reset;

  if not Enabled then Exit;

  {Do the checks. First, machine must be running, and the debug script must be compiled and executed}
  if not AMachine.Running then
  begin
    FWatchStatus := wsProcessNotAvailable;
    Exit;
  end;

  {Now compile the debug script}
  try
    AMachine.CompileDebugScript(FDebugScript);
  except
    FWatchStatus := wsCompileError;
    Exit;
  end;

  {Now execute the script}
  try
    AMachine.ExecuteDebugScript(FDebugScript);

    {Get the value of temporary variable which was allocated in the debug script}
    AStackPos := -1;
    AVar := FDebugScript.ScriptInfo.Globals.FindByName('_TatDebugWatch_expression_');
    if AVar <> nil then
      AStackPos := AVar.VarIndex
    else
    begin
      AVar := FDebugScript.FDebugScriptMainRoutine.VariableByName('_TatDebugWatch_expression_');
      if AVar <> nil then
        AStackPos := AMachine.FStackBase + AVar.VarIndex;
    end;

    if AStackPos <> -1 then
    begin
      FLastResult := AMachine.FProcStack[AStackPos];
      FWatchStatus := wsEvaluated;
    end else
      FWatchStatus := wsRuntimeError;
  except
    on ex:Exception do
    begin
      { em caso de falha de execu��o apenas sinaliza no watch que � inv�lido }
      FWatchStatus := wsRuntimeError;
    end;
  end;
end;

procedure TatScripterWatch.Reset;
begin
  FDebugScript.Clear;
  FWatchStatus := wsNotEvaluated;
  FLastResult := Unassigned;
end;

procedure TatScripterWatch.ScriptDestroyed(Sender: TObject);
begin
  { remove a refer�ncia ao script que est� sendo destru�do }
  FDebugScript := nil;
end;

function TatScripterWatch.Scripter: TatCustomScripter;
begin
  if Watches <> nil then
    result := Watches.Scripter
  else
    result := nil;
end;

procedure TatScripterWatch.SetExpression(const Value: string);
begin
  if FExpression <> Value then
  begin
    Reset;
    FExpression := Value;
    FDebugScript.SourceCode.Text := FDebugScript.EncodeSingleAssign(
      '_TatDebugWatch_expression_', FExpression);
  end;
end;

function TatScripterWatch.Watches: TatScripterWatches;
begin
  if Collection is TatScripterWatches then
    result := TatScripterWatches(Collection)
  else
    result := nil;
end;

{ TGenericEventDispatcher }
{$IFDEF DELPHI2010_LVL}
procedure TGenericEventDispatcher.RaiseEvent;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGenericProc(BeforeCall);

    if Assigned(Scripter) and (RoutineName > '') then
      //Scripter.ExecuteSubroutine(RoutineName, GetMethodArgs);
      Scripter.ExecuteSubroutine(RoutineName);

    if AssignedMethod(AfterCall) then
      TGenericProc(AfterCall);
  end;
end;
{$ENDIF}

{ TGenericRecordWrapper }

{$IFDEF DELPHI2010_LVL}
constructor TGenericRecordWrapper.Create(ATypeInfo: PTypeInfo);
var
  context: TRttiContext;
  rtype: TRttiType;
begin
  FTypeInfo := ATypeInfo;
  context := TRttiContext.Create;
  try
    rtype := context.GetType(FTypeInfo);
    FRecord := rtype.NewInstance as TRttiRecordType;
  finally
    context.Free;
  end;
end;

function TGenericRecordWrapper.GetFieldValue(AFieldName: string): TValue;
var
  context: TRttiContext;
  field: TRttiField;
  rtype: TRttiType;
begin
  context := TRttiContext.Create;
  try
    rtype := context.GetType(FTypeInfo);
    field := rtype.GetField(AFieldName);
    result := field.GetValue(FRecord);
  finally
    context.Free;
  end;
end;

procedure TGenericRecordWrapper.SetFieldValue(AFieldName: string; AValue: TValue);
var
  context: TRttiContext;
  field: TRttiField;
  rtype: TRttiType;
begin
  context := TRttiContext.Create;
  try
    rtype := Context.GetType(FTypeInfo);
    field := rtype.GetField(AFieldName);
    field.SetValue(FRecord, AValue);
  finally
    context.Free;
  end;
end;
{$ENDIF}

initialization
  { inicializa a tabela de constantes variant do scripter }
  CoreConst[coNull] := null;
  CoreConst[coTrue] := true;
  CoreConst[coFalse] := false;
  CoreConst[coUnassigned] := Unassigned;
  CoreConst[coNil] := 0;

  { global event adapter collection }
  EventAdapters:=TatEventAdapters.Create(TatEventAdapter);

  { registra a System Library como biblioteca default do Scripter }
  atLibraryList := TatLibraryList.Create(TatLibraryListItem);
  RegisterScripterLibrary( TatSystemLibrary, False );
  RegisterScripterLibrary( TatDLL, True);

  {Create global event OnScripterCreate}
  OnGlobalScripterCreate := nil;
  OnGlobalSCripterLoaded := nil;

finalization
  EventAdapters.Free;
  atLibraryList.Free;

{
A fazer:
- melhorar o multi-thread da maquina virtual (
- corrigir gram�tica quanto a obrigatoriedade de espa�os entre palavras
  reservadas e identifiadores. ex: GetMax n�o deve ser tratado como get Max
}
end.

