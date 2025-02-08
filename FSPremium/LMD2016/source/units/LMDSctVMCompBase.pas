unit LMDSctVMCompBase;
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

LMDSctPasBase unit (YB)
-----------------------
LMD ScriptPack base classes unit for Pascal Script.

Changes
-------
Release 4.0 (March 2009)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Variants, SysUtils, SyncObjs, ActiveX, Dialogs,
  LMDSctClass, LMDSctVMByteCode;

type
  {***************************** ELMDCompileBase ******************************}

  ELMDCompileBase = class(Exception)
  private
    FSourcePos: Integer;
  public
    constructor Create(const Msg: WideString; ASourcePos: Integer);
    constructor CreateFmt(const Msg: WideString; const Args: array of const;
                          ASourcePos: Integer);
    property    SourcePos: Integer read FSourcePos write FSourcePos; // In Delphi format,
                                                                     // starting from 1.
  end;

  TLMDVMBase = class
  public
    procedure MakeEventHandler(const AProcName: WideString;
                               var AResult: OleVariant); virtual; abstract;
  end;

  {***************************** TLMDGlobalObject *****************************}

  TLMDGlobalObjType = (gtVar, gtConst, gtProcedure, gtExit, gtBreak,
                       gtContinue, gtIntrinsic, gtExtern);

  TLMDGlobalObject = class(TLMDNamedItem)
  private
    FGlobalObjType: TLMDGlobalObjType;
    FStrName:       WideString;
  protected
    function GetGlobalObjType: TLMDGlobalObjType; virtual; abstract;
  public
    constructor Create(const AName: Integer; const AStrName: WideString);

    property    GlobalObjType: TLMDGlobalObjType read FGlobalObjType;
    property    StrName: WideString read FStrName;
  end;

  TLMDDispIdObject = class(TLMDGlobalObject)
  private
    FDispId:      Integer;
    FInvokeFlags: DWORD;
    FResMask:     DWORD;
  public
    property DispId: Integer read FDispId write FDispId;
    property InvokeFlags: DWORD read FInvokeFlags;
    property ResMask: DWORD read FResMask write FResMask; // Zero for 'void' procedures,
                                                          // Otherwise - $FFFFFFFF.
  end;

  TLMDGlobalValuedObject = class(TLMDDispIdObject)
  public
    Value: OleVariant;
  end;

  TLMDVarObject = class(TLMDGlobalValuedObject)
  public
    constructor Create(const AName: Integer; const AStrName: WideString);
    function    GetGlobalObjType: TLMDGlobalObjType; override;
  end;

  TLMDConstObject = class(TLMDGlobalValuedObject)
  public
    constructor Create(const AName: Integer; const AStrName: WideString);
    function    GetGlobalObjType: TLMDGlobalObjType; override;
  end;

  TLMDProcObject = class(TLMDDispIdObject)
  private
    FByteCode:   TLMDByteCode;
    FParamCount: Integer;
  protected
    procedure ParamAdded;
  public
    constructor Create(const AName: Integer; const AStrName: WideString);
    destructor Destroy; override;

    function  GetGlobalObjType: TLMDGlobalObjType; override;
    procedure EmitByteCode(AGlobalNamespace: TLMDAbstractNamespace); virtual; abstract;
    property  ParamCount: Integer read FParamCount;
    property  ByteCode: TLMDByteCode read FByteCode;
  end;

  TLMDExitObject = class(TLMDGlobalObject)
  public
    function GetGlobalObjType: TLMDGlobalObjType; override;
  end;

  TLMDBreakObject = class(TLMDGlobalObject)
  public
    function GetGlobalObjType: TLMDGlobalObjType; override;
  end;

  TLMDContinueObject = class(TLMDGlobalObject)
  public
    function GetGlobalObjType: TLMDGlobalObjType; override;
  end;

  TIntrinsic = class(TLMDGlobalObject)
  public
    function  GetGlobalObjType: TLMDGlobalObjType; override;
    procedure Execute(AVM: TLMDVMBase; ACall: TLMDCall; AArgs: PLMDVarArray;
                      var AResult: OleVariant); virtual; abstract;
  end;

  TLMDExternObject = class(TLMDGlobalObject)
  private
    FObj:            IDispatch;
    FCodeObject:     TObject; // Optional TLMDCodeObject.
    FPublishMembers: Boolean;
  public
    constructor Create(const AName: Integer; const AStrName: WideString;
                       AObj: IDispatch; ACodeObject: TObject;
                       APublishMembers: Boolean);

    function GetGlobalObjType: TLMDGlobalObjType; override;
    property Obj: IDispatch read FObj;
    property CodeObject: TObject read FCodeObject;
    property PublishMembers: Boolean read FPublishMembers;
  end;

  {****************************** TLMDNameTable *******************************}

  TLMDNameTable = class
  private
    FMap:         TLMDIdentifierHashTable;
    FNameByIndex: array of TLMDIdentifierItem;
    FCount:       Integer;
    FSection:     TCriticalSection;

    procedure AddNameIndex(const AUpperName: WideString);
    procedure Grow(AOldLen: Integer);
    function  GetNameIndexes(AIndex: Integer): TLMDIdentifierItem;
  public
    constructor Create;
    destructor Destroy; override;

    function GetName(AIndex: Integer): WideString;
    function GetNameIndex(const AName: WideString;
                          ACreateNewItem: Boolean = True): Integer;
    property NameIndexes[AIndex: Integer]: TLMDIdentifierItem read GetNameIndexes;
  end;

  {****************************** TLMDParserBase ******************************}

  ILMDEmitable = class
  public
    procedure Emit(ANamespace: TLMDAbstractNamespace;
                   AByteCode: TLMDByteCode); virtual; abstract;
  end;

  ILMDParserCallbacks = class
  public
    function  GetNameId(const AName: WideString): Integer; virtual; abstract;
    procedure GlobalStmtParsed(AStmt: ILMDEmitable); virtual; abstract;
    procedure GlobalObjParsed(AObj: TLMDGlobalObject;
                              var ADuplicateName: Boolean); virtual; abstract;
    procedure UsedUnitParsed(const AName: WideString;
                             var ADuplicateName: Boolean); virtual; abstract;
  end;

  ILMDParserBase = class
  public
    procedure Parse(const ASource: WideString); virtual; abstract;
    function  ParseStmt(const ASource: WideString): ILMDEmitable; virtual; abstract;
    function  ParseExpr(const ASource: WideString): ILMDEmitable; virtual; abstract;
  end;

  TLMDAddIntrinsicProc = procedure(AObject: TLMDGlobalObject) of object;

  ILMDLanguage = interface
    function  CreateParser(ACbs: ILMDParserCallbacks): ILMDParserBase;
    procedure AddIntrinsics(AProc: TLMDAddIntrinsicProc);
    function  DebugEmpty: WideString;
    function  DebugNothing: WideString;
    function  DebugNull: WideString;
    function  DebugStrLiteral(const S: WideString): WideString;
  end;

var
  GlobNameTable: TLMDNameTable;
  OleNull:       OleVariant;
  OleUnassigned: OleVariant;
  OleZero:       OleVariant;
  OleOne:        OleVariant;
  OleMinusOne:   OleVariant;

implementation

{****************************** TLMDNameTable *********************************}
constructor TLMDNameTable.Create;
begin
  inherited Create;
  FMap     := TLMDIdentifierHashTable.Create(false);
  FSection := TCriticalSection.Create;
end;

{-----------------------------------------------------------------------------}
destructor TLMDNameTable.Destroy;
var
  I: Integer;
begin
  FMap.Free;
  for I := 0 to FCount - 1 do
    FNameByIndex[I].Free;

  FSection.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}
function TLMDNameTable.GetName(AIndex: Integer): WideString;
begin
  FSection.Acquire;
  try
    Result := FNameByIndex[AIndex].Name;
  finally
    FSection.Release;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDNameTable.GetNameIndex(const AName: WideString;
  ACreateNewItem: Boolean = true): Integer;
var
  UpName: WideString;
  IdItem: TLMDIdentifierItem;
begin
  FSection.Acquire;
  try
    UpName := WideUpperCase(AName);
    IdItem := FMap.Find(UpName);

    if IdItem <> nil then
      Result := Integer(IdItem.Data)
    else if ACreateNewItem then
    begin
      AddNameIndex(UpName);
      Result := FCount - 1;
    end
    else
      Result := -1;
  finally
    FSection.Release;
  end;
end;

{------------------------------- private -------------------------------------s}
procedure TLMDNameTable.AddNameIndex(const AUpperName: WideString);
var
  IdItem: TLMDIdentifierItem;
  OldLen: Integer;
begin
  IdItem := TLMDIdentifierItem.Create;
  try
    IdItem.Name := AUpperName;
    IdItem.Data := TObject(FCount);

    FMap.Add(IdItem);

    OldLen := Length(FNameByIndex);
    if OldLen <= FCount then
    begin
      Grow(OldLen);
    end;

    FNameByIndex[FCount] := IdItem;
    Inc(FCount);
  except
    IdItem.Free;
    Dec(FCount);
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDNameTable.GetNameIndexes(AIndex: Integer): TLMDIdentifierItem;
begin
  Result := FNameByIndex[AIndex];
end;

{-----------------------------------------------------------------------------}
procedure TLMDNameTable.Grow(AOldLen: Integer);
begin
  if AOldLen = 0 then
    SetLength(FNameByIndex,4)
  else
    SetLength(FNameByIndex,AOldLen * 2);
end;

constructor ELMDCompileBase.Create(const Msg: WideString; ASourcePos: Integer);
begin
  inherited Create(Msg);
  FSourcePos := ASourcePos;
end;

constructor ELMDCompileBase.CreateFmt(const Msg: WideString;
  const Args: array of const; ASourcePos: Integer);
begin
  inherited CreateFmt(Msg, Args);
  FSourcePos := ASourcePos;
end;

{-----------------------------------------------------------------------------}

constructor TLMDGlobalObject.Create(const AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(AName);

  FGlobalObjType := GetGlobalObjType;
  FStrName       := AStrName;
end;

{*************************** TLMDExitObject ***********************************}
{------------------------------------------------------------------------------}
function TLMDExitObject.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtExit;
end;

{******************************* TLMDBreakObject ******************************}
{------------------------------------------------------------------------------}
function TLMDBreakObject.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtBreak;
end;

{************************* TLMDContinueObject *********************************}
{------------------------------------------------------------------------------}
function TLMDContinueObject.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtContinue;
end;

{ TLMDExternObject }

constructor TLMDExternObject.Create(const AName: Integer;
  const AStrName: WideString; AObj: IDispatch;
  ACodeObject: TObject; APublishMembers: Boolean);
begin
  inherited Create(AName, AStrName);

  FObj            := AObj;
  FCodeObject     := ACodeObject;
  FPublishMembers := APublishMembers;
end;

function TLMDExternObject.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtExtern;
end;

{ TLMDProcObject }

constructor TLMDProcObject.Create(const AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(AName, AStrName);
  FByteCode    := TLMDByteCode.Create;
  FInvokeFlags := DISPATCH_METHOD;
end;

destructor TLMDProcObject.Destroy;
begin
  FByteCode.Free;
  inherited;
end;

function TLMDProcObject.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtProcedure;
end;

procedure TLMDProcObject.ParamAdded;
begin
  Inc(FParamCount);
end;

{ TIntrinsic }

function TIntrinsic.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtIntrinsic;
end;

{ TLMDVarObject }

constructor TLMDVarObject.Create(const AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(AName, AStrName);
  FInvokeFlags := (DISPATCH_PROPERTYGET or DISPATCH_PROPERTYPUT or
                   DISPATCH_PROPERTYPUTREF);
  FResMask     := $FFFFFFFF;
end;

function TLMDVarObject.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtVar;
end;

{ TLMDConstObject }

constructor TLMDConstObject.Create(const AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(AName, AstrName);
  FInvokeFlags := DISPATCH_PROPERTYGET;
  FResMask     := $FFFFFFFF;
end;

function TLMDConstObject.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtConst;
end;

initialization
  GlobNameTable := TLMDNameTable.Create;
  OleNull       := Null;
  OleUnassigned := Unassigned;
  OleZero       := 0;
  OleOne        := 1;
  OleMinusOne   := -1;

{-----------------------------------------------------------------------------}
finalization
  GlobNameTable.Free;

{-----------------------------------------------------------------------------}
end.
