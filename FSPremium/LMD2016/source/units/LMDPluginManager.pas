unit LMDPluginManager;
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

LMDPluginManager unit (AIH, AH)
-------------------------------
Description
LMD Plugin Framework:
LMDPluginManager

interfaces:
ILMDHost
ILMDPluginForm
ILMDParameter
ILMDParametersEnum
ILMDAction
ILMDPluginForm

ToDo
----

Changes
-------

Release 0.2 (February 2008)
* Initial Release

###############################################################################}

interface

uses
  Classes, Forms, Windows, Controls, Types, LMDTypes;
type
  TLMDBaseMenuController = class (TObject);
  TLMDBaseToolbarController = class (TObject);

  { ******************************** ILMDHost ******************************** }
  ILMDHost = interface (IInterface)
    ['{66BAAB09-7AF9-4F1F-9002-E4092E2CD8E3}']
  end;

  { ***************************** ILMDPluginForm ***************************** }
  ILMDPluginForm = interface (IInterface)
    ['{9BA7E398-3673-4213-B2B2-6287EC3D6466}']
    procedure Show; stdcall;
    procedure Hide; stdcall;
    procedure ShowAsMDIChild(AParentForm: TForm); stdcall;
    procedure ShowModal; stdcall;
    procedure ShowParented(AParentWindow: HWND); stdcall;
    procedure SetFormData(AData: Pointer); stdcall;
    function GetTitle: WideString; stdcall;
    procedure SetTitle(ATitle: WideString); stdcall;
    function GetVisible: boolean; stdcall;
    procedure SetVisible (AVisible: boolean); stdcall;
    function GetFormName: WideString; stdcall;
    property Visible: Boolean read GetVisible write SetVisible;
    property Title: WideString read GetTitle write SetTitle;
    property FormName: WideString read GetFormName;
  end;

  { ************************** ILMDDelphiPluginForm ************************** }
  ILMDDelphiPluginForm = interface(ILMDPluginForm)
    ['{0BEF55CC-2761-4CCB-B08A-553766806984}']
    function GetTFormInstance: TForm; stdcall;
  end;

  { **************************** ILMDFormWithData **************************** }
  ILMDFormWithData = interface(IInterface)
    ['{8999ED41-2791-4471-BFEB-994923CE1CD4}']
    procedure SetFormData(AData: Pointer);
  end;

  TLMDParameterType = (ptBoolean, ptInteger, ptReal, ptString, ptCurrency, ptSmallInt, ptWord, ptLongWord, ptInt64,
                        ptObject, ptPointer, ptDynArray, ptDateTime, ptGUID);

  { ***************************** ILMDParameter ****************************** }
  ILMDParameter = interface (IInterface)
    ['{CD1FA603-752B-45E5-921F-97F1C8D61644}']
    function GetValue(out APointer: Pointer): HRESULT; stdcall;
    function GetType: TLMDParameterType; stdcall;
    function SetValue(const APointer: Pointer): HRESULT; stdcall;
    procedure SetType(const AType: TLMDParameterType); stdcall;
    function GetIsOptional: boolean; stdcall;
    function GetName: TLMDString; stdcall;
    procedure SetIsOptional(const AIsOptional: boolean); stdcall;
    procedure SetAsBoolean(const AValue: Boolean); stdcall;
    procedure SetAsInteger(const AValue: Integer); stdcall;
    procedure SetAsReal(const AValue: Extended); stdcall;
    procedure SetAsString(const AValue: WideString); stdcall;
    procedure SetAsCurrency(const AValue: Currency); stdcall;
    procedure SetAsSmallInt(const AValue: Smallint); stdcall;
    procedure SetAsWord(const AValue: Word); stdcall;
    procedure SetAsLongWord(const AValue: LongWord); stdcall;
    procedure SetAsInt64(const AValue: Int64); stdcall;
    procedure SetAsObject(const AValue: TObject); stdcall;
    procedure SetAsPointer(const AValue: Pointer); stdcall;
    procedure SetAsByteDynArray(const AValue: TByteDynArray); stdcall;
    procedure SetAsIntegerDynArray(const AValue: TIntegerDynArray); stdcall;
    procedure SetAsWordDynArray(const AValue: TWordDynArray); stdcall;
    procedure SetAsInt64DynArray(const AValue: TInt64DynArray); stdcall;
    procedure SetAsWideStringDynArray(const AValue: TWideStringDynArray); stdcall;
    procedure SetAsLongWordDynArray(const AValue: TLongWordDynArray); stdcall;
    procedure SetAsDoubleDynArray(const AValue: TDoubleDynArray); stdcall;
    procedure SetAsBooleanDynArray(const AValue: TBooleanDynArray); stdcall;
    procedure SetAsGUID(const AValue: TGUID); stdcall;
    function GetAsBoolean: Boolean; stdcall;
    function GetAsInteger: Integer; stdcall;
    function GetAsReal: Extended; stdcall;
    function GetAsString: WideString; stdcall;
    function GetAsCurrency: Currency; stdcall;
    function GetAsSmallInt: Smallint; stdcall;
    function GetAsWord: Word; stdcall;
    function GetAsLongWord: LongWord; stdcall;
    function GetAsInt64: Int64; stdcall;
    function GetAsObject: TObject; stdcall;
    function GetAsPointer: Pointer; stdcall;
    function GetAsByteDynArray: TByteDynArray; stdcall;
    function GetAsIntegerDynArray: TIntegerDynArray; stdcall;
    function GetAsWordDynArray: TWordDynArray; stdcall;
    function GetAsInt64DynArray: TInt64DynArray; stdcall;
    function GetAsWideStringDynArray: TWideStringDynArray; stdcall;
    function GetAsLongWordDynArray: TLongWordDynArray; stdcall;
    function GetAsDoubleDynArray: TDoubleDynArray; stdcall;
    function GetAsBooleanDynArray: TBooleanDynArray; stdcall;
    function GetAsGUID: TGUID; stdcall;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsReal: Extended read GetAsReal write SetAsReal;
    property AsString: WideString read GetAsString write SetAsString;
    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
    property AsSmallInt: Smallint read GetAsSmallInt write SetAsSmallInt;
    property AsWord: Word read GetAsWord write SetAsWord;
    property AsLongWord: LongWord read GetAsLongWord write SetAsLongWord;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsObject: TObject read GetAsObject write SetAsObject;
    property AsPointer: Pointer read GetAsPointer write SetAsPointer;
    property AsByteArray: TByteDynArray read GetAsByteDynArray write SetAsByteDynArray;
    property AsIntegerDynArray: TIntegerDynArray read GetAsIntegerDynArray write SetAsIntegerDynArray;
    property AsWordDynArray: TWordDynArray read GetAsWordDynArray write SetAsWordDynArray;
    property AsInt64DynArray: TInt64DynArray read GetAsInt64DynArray write SetAsInt64DynArray;
    property AsWideStringDynArray: TWideStringDynArray read GetAsWideStringDynArray write SetAsWideStringDynArray;
    property AsLongWordDynArray: TLongWordDynArray read GetAsLongWordDynArray write SetAsLongWordDynArray;
    property AsDoubleDynArray: TDoubleDynArray read GetAsDoubleDynArray write SetAsDoubleDynArray;
    property AsBooleanDynArray: TBooleanDynArray read GetAsBooleanDynArray write SetAsBooleanDynArray;
    property AsGUID: TGUID read GetAsGUID write SetAsGUID;
    property ParameterType: TLMDParameterType read GetType write SetType;
    property IsOptional: Boolean read GetIsOptional write SetIsOptional;
    property Name: TLMDString read GetName;
  end;

  { *************************** ILMDParametersEnum *************************** }
  ILMDParametersEnum = interface (IInterface)
    ['{0CECD86D-8CAC-461F-A5DE-52D4014888B2}']
    function Reset(): HRESULT; stdcall;
    function Skip(ACount: Integer): HRESULT; stdcall;
    function Next(out AnParam: ILMDParameter; out AFetched: boolean): HRESULT; stdcall;
    function Clone(out AClone: ILMDParametersEnum): HRESULT; stdcall;
    function Count: Integer; stdcall;
  end;

  { ******************************* ILMDAction ******************************* }
  ILMDAction = interface (IInterface)
    function PerformAction: ILMDParameter; stdcall;
    function GetParametersEnum(var AParamEnum: ILMDParametersEnum): HRESULT; stdcall;
    function IsParametersCorrect: HRESULT; stdcall;
    function GetName: WideString; stdcall;
    function GetParameter(AIndex: Integer): ILMDParameter; stdcall;
    function GetParameterByName(AName: WideString): ILMDParameter; stdcall;

    property Parameters[Index: Integer]: ILMDParameter read GetParameter; default;
    property ParametersByName[Index: WideString]: ILMDParameter read GetParameterByName;
    property Name: WideString read GetName;
  end;

  TLMDPerformActionEvent = procedure(const AnAction: ILMDAction; var AResult: ILMDParameter) of object; stdcall;
  { ***************************** ILMDActionEnum ***************************** }
  ILMDActionEnum = interface(IInterface)
    ['{7A47C15F-DA0D-4EAA-8D6B-0E2D9DF38E8A}']
    function Reset(): HRESULT; stdcall;
    function Skip(ACount: Integer): HRESULT; stdcall;
    function Next(out AnAction: ILMDAction; out AFetched: boolean): HRESULT; stdcall;
    function Clone(out AClone: ILMDActionEnum): HRESULT; stdcall;
  end;

  TLMDSetHostEvent = procedure (ASender: TInterfacedObject; var AnAccept: boolean) of Object;

  TLMDPluginModuleOnPerformEvent = procedure (const AName: WideString; AData: Pointer) of object;

  ILMDPluginEvent = interface(IUnknown)
    ['{DDB19212-0409-4AA5-BF83-F9C6BB786CCA}']
    procedure PerformEvent(const AName: WideString; AData: Pointer); stdcall;
  end;

  { ******************************* ILMDPlugin ******************************* }
  ILMDPlugin = interface (IInterface)
    ['{04580D43-A86E-4C74-A606-F3F4301DD078}']
    function GetPluginForm(AFormName: WideString; out APluginForm: ILMDPluginForm): HRESULT; stdcall;
    function GetHandle: THandle; stdcall;
    procedure SetHandle(AHandle: THandle); stdcall;
    function GetAuthor: WideString; stdcall;
    function GetDescription: WideString; stdcall;
    function GetMajorVersion: Integer; stdcall;
    function GetMinorVersion: Integer; stdcall;
    function GetFileName: WideString; stdcall;
    function GetHost(out AHost: ILMDHost): HRESULT; stdcall;
    procedure SetFileName(AFileName: WideString); stdcall;
    function SetHost(AHost: ILMDHost): HRESULT; stdcall;
    function GetNamedAction(const AName: WideString): ILMDAction; stdcall;
    function GetNamedForm(const AName: WideString): ILMDPluginForm; stdcall;
    function GetAction(const AName: WideString; out AnAction: ILMDAction): HRESULT; stdcall;
    function SetOnSetHostEvent(AnEvent: TLMDSetHostEvent): HRESULT; stdcall;
    function GetIdentifierCount(): Integer; stdcall;
    function GetIdentifier(ANum: Integer): TGUID; stdcall;
    procedure EventCallback(AEventCallbackInterface: ILMDPluginEvent); stdcall;
    function GetEventCallback(): ILMDPluginEvent; stdcall;
    property Author: WideString read GetAuthor;
    property FileName: WideString read GetFileName write SetFileName;
    property Actions[const AName: WideString]: ILMDAction read GetNamedAction; default;
    property Forms[const AName: WideString]: ILMDPluginForm read GetNamedForm;
    property IdentifierCount: Integer read GetIdentifierCount;
    property Identifiers[AIndex: Integer]: TGUID read GetIdentifier;
  end;

  TLMDGetPluginProc = function(const AnApp: TApplication): ILMDPlugin; stdcall;

implementation

end.
