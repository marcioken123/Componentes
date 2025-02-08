unit LMDDTD;
{$I LMDCmps.inc}

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

LMDDTD unit (VO)
----------------

TLMDDTD used for description of HTLM elements 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
  uses
    Classes,
    LMDListObjects, LMDExtParser, LMDText, LMDEntryPoint, LMDDeductionTree,
    LMDRule;

type

  TLMDDTDDefinition = class;
  TLMDDataModel = class;

  { ******************************* TLMDDTD ********************************** }
  TLMDDTD = class
  private
    FParser        : TLMDExtParser;
    FDefinition    : TLMDDTDDefinition;
    FEntryTable    : TLMDListObjects;//TList;
    FDeductionTree : TLMDDeductionTree;
    function  BuildRule(aDataModel : TLMDDataModel) : TLMDRule;
    function  BuildExclusion(aExclusion : TStringList) : TList;
    function  FindEntry(const aName : string) : TLMDEntryPoint;
    procedure ClearEntryTable;
    procedure BuildEntryTable;
  protected
  public
    constructor Create(aParser : TLMDExtParser);
    destructor Destroy; override;
    function Check(const aRule : string; var aParsedText : TLMDParsedTextList) : boolean;
    property Definition : TLMDDTDDefinition read FDefinition;
  end;

  TLMDDTDBaseDefinition = class;

  { ******************************* TLMDDTDDefinition ************************ }
  TLMDDTDDefinition = class
  private
    FList : TList;
    function GetItem(index : LongInt) : TLMDDTDBaseDefinition;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Count : LongInt;
    procedure DTD_TYPE(const aName : string; aTypeFunc : TLMDParseFunc; aAction : TLMDParseAction);
    procedure DTD_ENTITY(const aName : string; aDataModel : TLMDDataModel);
    procedure DTD_ELEMENT(const aName : string; aOpenTag, aCloseTag : boolean; aCloseTags : TStringList;
      aDataModel : TLMDDataModel; aExclusion : TStringList;
      aAction : TLMDParseAction; aExceptionHandler : TLMDParseAction); overload;
    procedure DTD_ELEMENT(const aName : string; aOpenTag, aCloseTag : boolean; aCloseTags : TStringList;
      aDataModel : TLMDDataModel; const aExclusion : string; aAction : TLMDParseAction;
      aExceptionHandler : TLMDParseAction); overload;
    property Item[index : LongInt] : TLMDDTDBaseDefinition read GetItem; default;
  end;

  { ******************************* TLMDDataModelBase ************************ }
  TLMDDataModelElement = (deENTRY, deDataModel, deOperation);
  TLMDDataModeBase = class
  private
    FType     : TLMDDataModelElement;
    FIterator : TLMDIteratorType;
  public
    property ElementType : TLMDDataModelElement read FType;
    property Iterator : TLMDIteratorType read FIterator write FIterator;
  end;

  { ******************************* TLMDDataModelEntry *********************** }
  TLMDDataModelEntry = class(TLMDDataModeBase)
  private
    FName : string;
  public
    constructor Create(const aName : string; aIterator : TLMDIteratorType);
    property Name : string read FName;
  end;

  { ******************************* TLMDDataModelOperation ******************* }
  TLMDDataModelOperation = class(TLMDDataModeBase)
  public
    constructor Create;
  end;

  { ******************************* TLMDDataModel **************************** }
  TLMDDataModel = class(TLMDDataModeBase)
  private
    FList : TList;
    function GetItem(index : longint) : TLMDDataModeBase;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function Count : LongInt;
    procedure Add(const aEntry : string; aIterator : TLMDIteratorType); overload;
    procedure Add(aEntry : TLMDDataModel); overload;
    procedure Add_OR;
    property Item[index : LongInt] : TLMDDataModeBase read GetItem; default;
  end;

  { ******************************* TLMDDTDBaseDefinition ******************** }
  TLMDDefinitionType = (dtTYPE, dtENTITY, dtELEMENT);
  TLMDDTDBaseDefinition = class
  private
    FType : TLMDDefinitionType;
    FName : string;
  public
    property DefinitionType : TLMDDefinitionType read FType;
    property Name : string read FName;
  end;

  { ******************************* TLMDDTDTypeDefiniton ********************* }
  TLMDDTDTypeDefiniton = class(TLMDDTDBaseDefinition)
  private
    FAction   : TLMDParseAction;
    FTypeFunc : TLMDParseFunc;
  public
    constructor Create(const aName : string; aTypeFunc : TLMDParseFunc;
      aAction : TLMDParseAction);
    property Action : TLMDParseAction read FAction;
    property TypeFunc : TLMDParseFunc read FTypeFunc;
  end;

  { ******************************* TLMDDTDEntityDefiniton ******************* }
  TLMDDTDEntityDefiniton = class(TLMDDTDBaseDefinition)
  private
    FDataModel : TLMDDataModel;
  public
    constructor Create(const aName : string; aDataModel : TLMDDataModel);
    destructor Destroy; override;
    property DataModel : TLMDDataModel read FDataModel;
  end;

  { ******************************* TLMDDTDElementDefiniton ****************** }
  TLMDDTDElementDefiniton = class(TLMDDTDBaseDefinition)
  private
    FOpenTag    : boolean;
    FCloseTag   : boolean;
    FDataModel  : TLMDDataModel;
    FExclusion  : TStringList;
    FAction     : TLMDParseAction;
    FExceptionHandler : TLMDParseAction;
    FCloseTags : TStringList;
  public
    constructor Create(const aName : string; aOpenTag, aCloseTag : boolean;
      aCloseTags : TStringList; aDataModel : TLMDDataModel; aExclusion : TStringList;
      aAction : TLMDParseAction; aExceptionHandler : TLMDParseAction);
    destructor Destroy; override;
    property OpenTag  : boolean read FOpenTag;
    property CloseTag : boolean read FCloseTag;
    property DataModel : TLMDDataModel read FDataModel;
    property Exclusion  : TStringList read FExclusion;
    property Action : TLMDParseAction read FAction;
    property ExceptionHandler : TLMDParseAction read FExceptionHandler;
    property CloseTags : TStringList read FCloseTags;
  end;

implementation
uses
  Windows, Sysutils;

{ ********************************* TLMDDTD ********************************** }
{------------------------------------------------------------------------------}

function  TLMDDTD.BuildRule(aDataModel : TLMDDataModel) : TLMDRule;
var
  I       : LongInt;
  lEntry  : TLMDEntryPoint;
  SubRule : TLMDRule;
begin
  Result := nil;
  if not assigned(aDataModel) then Exit;
  result := TLMDRule.Create;
  result.Iterator := aDataModel.Iterator;
  for I := 0 to aDataModel.Count-1 do
    case aDataModel[I].ElementType of
      deOperation : Result.Add_OR;
      deENTRY : begin
        lEntry := FindEntry(TLMDDataModelEntry(aDataModel[I]).Name);
        if assigned(lEntry) then Result.Add(lEntry, aDataModel[I].Iterator);
      end;
      deDataModel : begin
        SubRule := BuildRule(TLMDDataModel(aDataModel[I]));
        if assigned(SubRule) then begin
          SubRule.Iterator := aDataModel[I].Iterator;
          Result.Add(SubRule);
        end;
      end;
    end;
end;

{------------------------------------------------------------------------------}

function  TLMDDTD.BuildExclusion(aExclusion : TStringList) : TList;
var
  I : LongInt;
  lEntry : TLMDEntryPoint;
begin
  Result := nil;
  if not assigned(aExclusion) then Exit;
  result := TList.Create;
  for I := 0 to aExclusion.count-1 do begin
    lEntry := FindEntry(aExclusion[I]);
    if assigned(lEntry) then result.add(lEntry);
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDDTD.FindEntry(const aName : string) : TLMDEntryPoint;
var
  I : LongInt;
begin
  result := nil;
  for I := 0 to FEntryTable.count-1 do
    if AnsiSameText(TLMDEntryPoint(FEntryTable[I]).Name, aName) then
    begin
      result := TLMDEntryPoint(FEntryTable[I]);
      Break;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDDTD.ClearEntryTable;
//var
//  I : LongInt;
begin
{
  for I := 0 to FEntryTable.count-1 do
    if assigned(FEntryTable[I]) then
      TLMDEntryPoint(FEntryTable[I]).Free;
}
  FEntryTable.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDDTD.BuildEntryTable;
var
  I : LongInt;
  D: TLMDDTDBaseDefinition;
  E: TObject;
begin
  ClearEntryTable;

  for I := 0 to FDefinition.count-1 do
  begin
    D := FDefinition[I];
    case D.DefinitionType of
      dtTYPE    : FEntryTable.Add(TLMDTypeEntry.Create(
        D.Name,
        TLMDDTDTypeDefiniton(D).TypeFunc,
        TLMDDTDTypeDefiniton(D).Action,
        FParser,
        FEntryTable));
      dtENTITY  : FEntryTable.Add(TLMDEntityEntry.Create(
        D.Name,
        FParser,
        FEntryTable));
      dtELEMENT : FEntryTable.Add(TLMDElementEntry.Create(D.Name,
        TLMDDTDElementDefiniton(D).OpenTag,
        TLMDDTDElementDefiniton(D).CloseTag,
        TLMDDTDElementDefiniton(D).CloseTags,
        TLMDDTDElementDefiniton(D).Action,
        FParser,
        TLMDDTDElementDefiniton(D).ExceptionHandler,
        FEntryTable));
    end;
  end;

  for I := 0 to FDefinition.Count - 1 do 
  begin
    D := FDefinition[I];
    E := FEntryTable[I];
    case D.DefinitionType of
      dtENTITY  :
        begin
          TLMDEntityEntry(E).SetRule(
             BuildRule(TLMDDTDEntityDefiniton(D).DataModel), True);
          if assigned(TLMDEntityEntry(E).Rule) then
            TLMDEntityEntry(E).Rule.Name := D.Name;
        end;
      dtELEMENT :
        begin
          TLMDElementEntry(E).SetRule(
            BuildRule(TLMDDTDElementDefiniton(D).DataModel), True);
          if assigned(TLMDElementEntry(E).Rule) then
            TLMDElementEntry(E).Rule.Name := D.Name;
          TLMDElementEntry(E).Exclusion :=
            BuildExclusion(TLMDDTDElementDefiniton(D).Exclusion);
        end;
    end;
  end;

end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDDTD.Create(aParser : TLMDExtParser);
begin
  inherited Create;
  FParser := aParser;
  FDefinition := TLMDDTDDefinition.Create;
  FEntryTable := TLMDListObjects.Create;//TList.Create;
  FDeductionTree :=  TLMDDeductionTree.Create(nil);
end;

{------------------------------------------------------------------------------}

destructor TLMDDTD.Destroy;
begin
  ClearEntryTable;
  FEntryTable.Free;
  FDefinition.Free;
  FDeductionTree.Free;
  inherited;
end;

function TLMDDTD.Check(const aRule : string; var aParsedText : TLMDParsedTextList) : boolean;
var
  StartRule : TLMDEntryPoint;
begin
  result := False;
  BuildEntryTable;
  StartRule := FindEntry(aRule);
  if not assigned(StartRule) then Exit;
  FDeductionTree.Clear;
  FDeductionTree.EntryPoint := StartRule;
  FDeductionTree.ParsedText := aParsedText;
  StartRule.GetFirstToken(FDeductionTree);
  result := StartRule.IsTrue(FDeductionTree);
  aParsedText := FDeductionTree.ParsedText;
end;

{ ********************************* TLMDDataModelEntry *********************** }
{------------------------------------------------------------------------------}

constructor TLMDDataModelEntry.Create(const aName : string; aIterator : TLMDIteratorType);
begin
  inherited Create;
  FType := deENTRY;
  FIterator := aIterator;
  fName := aName;
end;

{ ********************************* TLMDDataModelOperation ******************* }
{------------------------------------------------------------------------------}

constructor TLMDDataModelOperation.Create;
begin
  inherited;
  FType := deOperation;
end;

{ ********************************* TLMDDataModel **************************** }
{------------------------------------------------------------------------------}

function TLMDDataModel.GetItem(index : longint) : TLMDDataModeBase;
begin result := TLMDDataModeBase(FList[index]) end;

{------------------------------------------------------------------------------}

procedure TLMDDataModel.Clear;
var
  I : LongInt;
begin
  for I := 0 to FList.count-1 do
    if assigned(FList[I]) then
      TLMDDataModeBase(FList[I]).Free;
  FList.Clear;
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDDataModel.Create;
begin
  inherited;
  FType := deDataModel;
  FIterator := iONCE;
  FList := TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDDataModel.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDDataModel.Count : LongInt;
begin result := FList.count end;

{------------------------------------------------------------------------------}

procedure TLMDDataModel.Add(const aEntry : string; aIterator : TLMDIteratorType);
begin
  FList.Add(TLMDDataModelEntry.Create(aEntry, aIterator));
end;

{------------------------------------------------------------------------------}

procedure TLMDDataModel.Add(aEntry : TLMDDataModel);
begin FList.Add(aEntry) end;

{------------------------------------------------------------------------------}

procedure TLMDDataModel.Add_OR;
begin FList.Add(TLMDDataModelOperation.Create) end;

{ ********************************* TLMDDTDDefinition ************************ }
{------------------------------------------------------------------------------}

function TLMDDTDDefinition.GetItem(index : LongInt) : TLMDDTDBaseDefinition;
begin result := TLMDDTDBaseDefinition(FList[index]) end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDDTDDefinition.Create;
begin
  inherited;
  FList := TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDDTDDefinition.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDDTDDefinition.Clear;
var
  I : LongInt;
begin
  for I := 0 to FList.count-1 do
    if assigned(FList[I]) then
      TLMDDTDBaseDefinition(FList[I]).Free;
  FList.Clear;
end;

{------------------------------------------------------------------------------}

function TLMDDTDDefinition.Count : LongInt;
begin result := FList.count end;

{------------------------------------------------------------------------------}

procedure TLMDDTDDefinition.DTD_TYPE(const aName : string; aTypeFunc : TLMDParseFunc; aAction : TLMDParseAction);
begin FList.Add(TLMDDTDTypeDefiniton.Create(aName, aTypeFunc, aAction)) end;

{------------------------------------------------------------------------------}

procedure TLMDDTDDefinition.DTD_ENTITY(const aName : string; aDataModel : TLMDDataModel);
begin FList.Add(TLMDDTDEntityDefiniton.Create(aName, aDataModel)) end;

{------------------------------------------------------------------------------}

procedure TLMDDTDDefinition.DTD_ELEMENT(const aName : string; aOpenTag, aCloseTag : boolean; aCloseTags : TStringList;
      aDataModel : TLMDDataModel; aExclusion : TStringList; aAction : TLMDParseAction;
      aExceptionHandler : TLMDParseAction);
begin
  FList.Add(TLMDDTDElementDefiniton.Create(aName, aOpenTag, aCloseTag, aCloseTags,
    aDataModel, aExclusion, aAction, aExceptionHandler));
end;

{------------------------------------------------------------------------------}

procedure TLMDDTDDefinition.DTD_ELEMENT(const aName : string; aOpenTag, aCloseTag : boolean; aCloseTags : TStringList;
      aDataModel : TLMDDataModel; const aExclusion : string; aAction : TLMDParseAction;
      aExceptionHandler : TLMDParseAction);
var
  List : TStringList;
begin
  List := TStringList.Create;
  List.Add(aExclusion);
  FList.Add(TLMDDTDElementDefiniton.Create(aName, aOpenTag, aCloseTag, aCloseTags, 
    aDataModel, List, aAction, aExceptionHandler));
end;

{ ********************************* TLMDDTDTypeDefiniton ********************* }
{------------------------------------------------------------------------------}

constructor TLMDDTDTypeDefiniton.Create(const aName : string; aTypeFunc : TLMDParseFunc;
  aAction : TLMDParseAction);
begin
  inherited create;
  FType  := dtTYPE;
  FName := aName;
  FAction := aAction;
  FTypeFunc := aTypeFunc;
end;

{ ********************************* TLMDDTDEntityDefiniton ******************* }
{------------------------------------------------------------------------------}

constructor TLMDDTDEntityDefiniton.Create(const aName : string; aDataModel : TLMDDataModel);
begin
  inherited Create;
  FType  := dtENTITY;
  FName := aName;
  FDataModel := aDataModel;
end;

{------------------------------------------------------------------------------}

destructor TLMDDTDEntityDefiniton.Destroy;
begin
  if assigned(FDataModel) then FDataModel.Free;
  inherited;
end;

{ ********************************* TLMDDTDElementDefiniton ****************** }
{------------------------------------------------------------------------------}

constructor TLMDDTDElementDefiniton.Create(const aName : string; aOpenTag, aCloseTag : boolean;
  aCloseTags : TStringList;
  aDataModel : TLMDDataModel; aExclusion : TStringList; aAction : TLMDParseAction;
  aExceptionHandler : TLMDParseAction);
begin
  inherited Create;
  FType  := dtELEMENT;
  FName := aName;
  FAction := aAction;
  FDataModel := aDataModel;
  FOpenTag := aOpenTag;
  FCloseTag := aCloseTag;
  FExclusion := aExclusion;
  FCloseTags := aCloseTags;
  FExceptionHandler := aExceptionHandler;
end;

{------------------------------------------------------------------------------}

destructor TLMDDTDElementDefiniton.Destroy;
begin
  FCloseTags.Free;
  if assigned(FDataModel) then FDataModel.Free;
  if assigned(FExclusion) then FExclusion.Free;
  inherited;
end;

end.
