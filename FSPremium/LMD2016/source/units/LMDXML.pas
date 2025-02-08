unit LMDXML;
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

LMDXML unit - Core XML Library (AH)
-----------------------------------
This unit implements the core XML library used in all LMD Innovative packages.
This code is based on SimpleXML code by Michail Vlasov, see description below
for more info.

ToDo
----
* Add OnNodeLoaded, OnProgress events
* For IXmlNode add next methods: LoadOuterXML, LoadOuterBinaryXML, LoadOuter
  LoadInnerXML, LoadInnerBinaryXML LoadInner
* XInlcude
* XPath?

Changes
-------
(May 2008)
+ GetElementsByTagName
* FindElement, FindAttr fixes

Release 8.0 (July 2006)
 - Initial Release
 + BOM support

###############################################################################}

{************************************************************
   SimpleXML - XML parsing library. Converts XML file into
   hierarchy of XML objects. And vice versa - converts XML
   objects hirarchy into XML file.

   Worthy replacement for MSXML. At use of Ansi-lines works
   faster and eats less memories.

   (c) Copyright 2002, 2003 by Michail Vlasov
   Library is free and can be used for any purposes
   Entering  any  changes  and  use of the changed libraries
   without restrictions is authorized.

   Only one requirement: This text should exists without
   modifications in all of changed versions of library.

  Current version: 1.0.1
*************************************************************}

interface

uses
  Windows,
  SysUtils,
  Classes,
  Types,
  Variants,

  LMDFiles,
  LMDTypes,
  LMDRTLConst;

const
  LMDBinXmlSignatureSize = Length('< binary-xml >');
  LMDBinXmlSignature: string = '< binary-xml >';

  LMD_BINXML_USE_WIDE_CHARS = 1;
  LMD_BINXML_COMPRESSED = 2;

  LMD_XSTR_NULL = '{{null}}';

  LMD_NODE_INVALID = $00000000;
  LMD_NODE_ELEMENT = $00000001;
  LMD_NODE_ATTRIBUTE = $00000002;
  LMD_NODE_TEXT = $00000003;
  LMD_NODE_CDATA_SECTION = $00000004;
  LMD_NODE_ENTITY_REFERENCE = $00000005;
  LMD_NODE_ENTITY = $00000006;
  LMD_NODE_PROCESSING_INSTRUCTION = $00000007;
  LMD_NODE_COMMENT = $00000008;
  LMD_NODE_DOCUMENT = $00000009;
  LMD_NODE_DOCUMENT_TYPE = $0000000A;
  LMD_NODE_DOCUMENT_FRAGMENT = $0000000B;
  LMD_NODE_NOTATION = $0000000C;

type
  ILMDXmlDocument = interface;
  ILMDXmlElement = interface;
  ILMDXmlText = interface;
  ILMDXmlCDATASection = interface;
  ILMDXmlComment = interface;
  ILMDXmlProcessingInstruction = interface;

  /// <summary>
  /// IXmlBase - base interface for all other interfaces in SimpleXML</summary>
  ILMDXmlBase = interface
    /// <summary>
    /// GetObject - return TObject that implement interface</summary>
    /// <returns>TObject successor that implement interface</returns>
    function GetObject: TObject;
  end;

  /// <summary>
  /// IXmlNameTable - Names table. Eaach name has it's own unique identifier.
  /// Used as storage for attribute and tag names.
  /// </summary>
  ILMDXmlNameTable = interface(ILMDXmlBase)
    /// <summary>
    /// GetID - Returna a Identifier</summary>
    /// <param name="aName">Name for ID</param>
    function GetID(const aName: TLMDString): Integer;
    /// <summary>
    /// GetName - Returns a Name for passed Identifier</summary>
    /// <param name="anID">ID for Name</param>
    function GetName(anID: Integer): TLMDString;
  end;

  ILMDXmlNode = interface;

  // IXmlNodeList - Node list. List is arranged as array.
  // Access to items of the list by index.
  ILMDXmlNodeList = interface(ILMDXmlBase)
    // get_Count - Count of nodes in a list
    function get_Count: Integer;
    // get_Item - Get Node by index.
    function get_Item(anIndex: Integer): ILMDXmlNode;
    // get_XML - Returns representation of the list nodes in XML format
    function get_XML: TLMDString;

    property Count: Integer read get_Count;
    property Item[anIndex: Integer]: ILMDXmlNode read get_Item; default;
    property XML: TLMDString read get_XML;
  end;

  // IXmlNode - Node of XML-tree
  ILMDXmlNode = interface(ILMDXmlBase)
    // get_NameTable - Names table, used by this node
    function get_NameTable: ILMDXmlNameTable;
    // get_NodeName - Returns Node name.
    // Interpretation of the Node name depends on its type
    function get_NodeName: TLMDString;
    // get_NodeNameID - Returns a identifier of Node
    function get_NodeNameID: Integer;
    // get_NodeType - Return Node type
    function get_NodeType: Integer;
    // get_Text - Returns Node text
    function get_Text: TLMDString;
    // set_Text - Changes Node text
    procedure set_Text(const aValue: TLMDString);
    // get_DataType - Returns Node data type as Varint type
    function get_DataType: Integer;
    // get_TypedValue - Returns node value as Variant
    function get_TypedValue: Variant;
    // set_TypedValue - Changes node value to an Variant value
    procedure set_TypedValue(const aValue: Variant);
    // get_XML - Returns representation of the Node and all included nodes in XML format
    function get_XML: TLMDString;

    // CloneNode - Creates a clone of this node
    // If aDeep is True, then it creates clone of all branch.
    function CloneNode(aDeep: Boolean = True): ILMDXmlNode;

    // get_ParentNode - Returns a parent node
    function get_ParentNode: ILMDXmlNode;
    // get_OwnerDocument - Returns a owner Document
    // that contain this Node
    function get_OwnerDocument: ILMDXmlDocument;

    // get_ChildNodes - Returns child nodes
    function get_ChildNodes: ILMDXmlNodeList;
    // AppendChild - Adds passed node to the end of list of child nodes
    procedure AppendChild(const aChild: ILMDXmlNode);
    // InsertBefore - Inserts passed node into spicified place of list of child nodes
    procedure InsertBefore(const aChild, aBefore: ILMDXmlNode);
    // ReplaceChild - Replaces passed node by another.
    procedure ReplaceChild(const aNewChild, anOldChild: ILMDXmlNode);
    // RemoveChild - Deletes passed node form list of child nodes
    procedure RemoveChild(const aChild: ILMDXmlNode);

    // AppendElement - Appends Element and adds it to child nodes list
    function AppendElement(aNameID: Integer): ILMDXmlElement; overload;
    function AppendElement(const aName: TLMDString): ILMDXmlElement; overload;

    // AppendText - Creates text node and appends it to child nodes list
    function AppendText(const aData: TLMDString): ILMDXmlText;

    // AppendCDATA - Creates CDTA section and apeends it to child nodes list
    function AppendCDATA(const aData: TLMDString): ILMDXmlCDATASection;

    // AppendComment - Creates Comment and apeends it to child nodes list
    function AppendComment(const aData: TLMDString): ILMDXmlComment;

    // AppendProcessingInstruction - Creates processing instruction
    //  and apeends it to child nodes list
    function AppendProcessingInstruction(aTargetID: Integer;
      const aData: TLMDString): ILMDXmlProcessingInstruction; overload;
    function AppendProcessingInstruction(const aTarget: TLMDString;
      const aData: TLMDString): ILMDXmlProcessingInstruction; overload;

    // GetChildText - Returns text of child node
    function GetChildText(const aName: TLMDString; const aDefault: TLMDString = ''): TLMDString; overload;
    function GetChildText(aNameID: Integer; const aDefault: TLMDString = ''): TLMDString; overload;
    // SetChildText - Adds (or changes) text of child node
    procedure SetChildText(const aName, aValue: TLMDString); overload;
    procedure SetChildText(aNameID: Integer; const aValue: TLMDString); overload;

    // NeedChild - Returns child node with passed name
    // If node isn't exists, then method throw exception
    function NeedChild(aNameID: Integer): ILMDXmlNode; overload;
    function NeedChild(const aName: TLMDString): ILMDXmlNode; overload;

    // EnsureChild - Returns child node with passed name
    // If node isn't exists, then it will be create.
    function EnsureChild(aNameID: Integer): ILMDXmlNode; overload;
    function EnsureChild(const aName: TLMDString): ILMDXmlNode; overload;

    // RemoveAllChilds - Removes all children nodes
    procedure RemoveAllChilds;

    // SelectNodes - Selects nodes for passed conditions
    function SelectNodes(const anExpression: TLMDString): ILMDXmlNodeList;
    // SelectSingleNode - Selects first node for passed conditions
    function SelectSingleNode(const anExpression: TLMDString): ILMDXmlNode;
    // FindElement - Finds first node for passed conditions
    function FindElement(const anElementName, anAttrName: string; const anAttrValue: Variant): ILMDXmlElement;

    // get_AttrCount - Resturns attributes count
    function get_AttrCount: Integer;
    // get_AttrNameIDs - Returns attribute name ID
    function get_AttrNameIDs(anIndex: Integer): Integer;
    // get_AttrNames - Returns attribute name
    function get_AttrNames(anIndex: Integer): TLMDString;
    // RemoveAttr - Removes attribute
    procedure RemoveAttr(const aName: TLMDString); overload;
    procedure RemoveAttr(aNameID: Integer); overload;
    // RemoveAllAttrs - Removes all atributes
    procedure RemoveAllAttrs;

    // AttrExists - Checks if atribute is exists
    function AttrExists(aNameID: Integer): Boolean; overload;
    function AttrExists(const aName: TLMDString): Boolean; overload;

    // GetAttrType - Returns attribute data type as Variant type
    function GetAttrType(aNameID: Integer): Integer; overload;
    function GetAttrType(const aName: TLMDString): Integer; overload;

    // GetVarAttr - Returns attribute as Variant
    //  If attribute not found, then returns default value
    function GetVarAttr(aNameID: Integer; const aDefault: Variant): Variant; overload;
    function GetVarAttr(const aName: TLMDString; const aDefault: Variant): Variant; overload;

    // SetVarAttr - Changes or adds attribute with passed Name
    procedure SetVarAttr(aNameID: Integer; const aValue: Variant); overload;
    procedure SetVarAttr(const aName: TLMDString; aValue: Variant); overload;

    // NeedAttr - Returns text of attribute with passed name
    //  if attribute not found, then method throw exception
    function NeedAttr(aNameID: Integer): TLMDString; overload;
    function NeedAttr(const aName: TLMDString): TLMDString; overload;

    // GetAttr - Returns text representation of passed attribute
    //  if attribute not found, then it returns default value
    function GetAttr(aNameID: Integer; const aDefault: TLMDString = ''): TLMDString; overload;
    function GetAttr(const aName: TLMDString; const aDefault: TLMDString = ''): TLMDString; overload;
    // SetAttr - Changes or adds attribute with passed name
    procedure SetAttr(aNameID: Integer; const aValue: TLMDString); overload;
    procedure SetAttr(const aName, aValue: TLMDString); overload;

    // GetBoolAttr - Returns value of attribute as Boolean
    function GetBoolAttr(aNameID: Integer; aDefault: Boolean = False): Boolean; overload;
    function GetBoolAttr(const aName: TLMDString; aDefault: Boolean = False): Boolean; overload;
    // SetBoolAttr - Sets of adds attribute with passed Boolean value
    procedure SetBoolAttr(aNameID: Integer; aValue: Boolean = False); overload;
    procedure SetBoolAttr(const aName: TLMDString; aValue: Boolean); overload;

    // GetIntAttr - Returns value of attribute as Integer
    function GetIntAttr(aNameID: Integer; aDefault: Integer = 0): Integer; overload;
    function GetIntAttr(const aName: TLMDString; aDefault: Integer = 0): Integer; overload;
    // SetIntAttr - Sets of adds attribute with passed Integer value
    procedure SetIntAttr(aNameID: Integer; aValue: Integer); overload;
    procedure SetIntAttr(const aName: TLMDString; aValue: Integer); overload;

    {$IFDEF LDMCOMP6}
    // GetIntAttr - Returns value of attribute as Int64
    function GetInt64Attr(aNameID: Integer; aDefault: Int64 = 0): Int64; overload;
    function GetInt64Attr(const aName: TLMDString; aDefault: Int64 = 0): Int64; overload;
    // SetIntAttr - Sets of adds attribute with passed Int64 value
    procedure SetInt64Attr(aNameID: Integer; aValue: Int64); overload;
    procedure SetInt64Attr(const aName: TLMDString; aValue: Int64); overload;
    {$ENDIF}

    // GetDateTimeAttr - Returns value of attribute as TDateTime
    function GetDateTimeAttr(aNameID: Integer; aDefault: TDateTime = 0): TDateTime; overload;
    function GetDateTimeAttr(const aName: TLMDString; aDefault: TDateTime = 0): TDateTime; overload;
    // SetDateTimeAttr - Sets of adds attribute with passed TDateTime value
    procedure SetDateTimeAttr(aNameID: Integer; aValue: TDateTime); overload;
    procedure SetDateTimeAttr(const aName: TLMDString; aValue: TDateTime); overload;

    // GetFloatAttr - Returns value of attribute as Double
    function GetFloatAttr(aNameID: Integer; aDefault: Double = 0): Double; overload;
    function GetFloatAttr(const aName: TLMDString; aDefault: Double = 0): Double; overload;
    // SetFloatAttr - Sets of adds attribute with passed Double value
    procedure SetFloatAttr(aNameID: Integer; aValue: Double); overload;
    procedure SetFloatAttr(const aName: TLMDString; aValue: Double); overload;

    /// <summary>
    /// GetHexAttr - Returns value of attribute as Integer
    ///  If attribute not found, then returns default value.
    /// </summary>
    ///  <remark>
    ///  String value of attribute converts to Integer. Source
    ///  string should be an integer in hex format without any prefixes such as
    ///  ("$", "0x" etc.) If convertation isn't possible, then method throw exception.</remark>
    function GetHexAttr(const aName: TLMDString; aDefault: Integer = 0): Integer; overload;
    function GetHexAttr(aNameID: Integer; aDefault: Integer = 0): Integer; overload;
    /// <summary>
    ///  SetHexAttr - Replaces value of attribute by string representation of Integer value
    ///   in hex format.
    ///   If attribute isn't exists, then it will be change, else it change.</summary>
    ///  <exception>If convertation isn't possible</exception>
    ///  <remark>
    ///   Hex value should be without any prefixes such as ("$", "0x" etc.)</remark>
    procedure SetHexAttr(const aName: TLMDString; aValue: Integer; aDigits: Integer = 8); overload;
    procedure SetHexAttr(aNameID: Integer; aValue: Integer; aDigits: Integer = 8); overload;

    //  GetEnumAttr - Searchs attribute value in passed array of string
    //    and returns index of found string. if attribute is exists but not found
    //    in array, then method throw exception
    //    if attribute isn't exists, then retruns default value.
    function GetEnumAttr(const aName: TLMDString;
      const aValues: array of TLMDString; aDefault: Integer = 0): Integer; overload;
    function GetEnumAttr(aNameID: Integer;
      const aValues: array of TLMDString; aDefault: Integer = 0): Integer; overload;

    function NeedEnumAttr(const aName: TLMDString;
      const aValues: array of TLMDString): Integer; overload;
    function NeedEnumAttr(aNameID: Integer;
      const aValues: array of TLMDString): Integer; overload;

    function get_Values(const aName: TLMDString): Variant;
    procedure set_Values(const aName: TLMDString; const aValue: Variant);

    function get_AttrValues(anIndex: Integer): TLMDString;
    procedure set_AttrValues(anIndex: Integer; const aValue: TLMDString);

    function AsElement: ILMDXmlElement;
    function AsText: ILMDXmlText;
    function AsCDATASection: ILMDXmlCDATASection;
    function AsComment: ILMDXmlComment;
    function AsProcessingInstruction: ILMDXmlProcessingInstruction;

    function GetElementsByTagName(const ATagName: WideString): ILMDXmlNodeList;

    property NodeName: TLMDString read get_NodeName;
    property NodeNameID: Integer read get_NodeNameID;
    property NodeType: Integer read get_NodeType;
    property ParentNode: ILMDXmlNode read get_ParentNode;
    property OwnerDocument: ILMDXmlDocument read get_OwnerDocument;
    property NameTable: ILMDXmlNameTable read get_NameTable;
    property ChildNodes: ILMDXmlNodeList read get_ChildNodes;
    property AttrCount: Integer read get_AttrCount;
    property AttrNames[anIndex: Integer]: TLMDString read get_AttrNames;
    property AttrNameIDs[anIndex: Integer]: Integer read get_AttrNameIDs;
    property AttrValues[anIndex: Integer]: TLMDString read get_AttrValues write set_AttrValues;
    property Text: TLMDString read get_Text write set_Text;
    property DataType: Integer read get_DataType;
    property TypedValue: Variant read get_TypedValue write set_TypedValue;
    property XML: TLMDString read get_XML;
    property Values[const aName: TLMDString]: Variant read get_Values write set_Values; default;
  end;

  ILMDXmlElement = interface(ILMDXmlNode)
    //  ReplaceTextByCDATASection - Replaces all text elements by CDATA section
    procedure ReplaceTextByCDATASection(const aText: TLMDString);

    //  ReplaceTextByBynaryData - Deletes all text elements and adds one text element
    //    with aData content coded by base64.
    //    If aMaxLineLength not equal 0, line split into aMaxLineLength length lines
    //    String delimiter is CRLF
    //    The last string hasn't delimiter at the end

    procedure ReplaceTextByBynaryData(const aData; aSize: Integer; aMaxLineLength: Integer);

    //  GetTextAsBynaryData - Collects all text elements into one string and
    //    decode it from base64 into binary data
    //    While decoding all space symbols are ignore.
    function GetTextAsBynaryData: TLMDString;
  end;

  ILMDXmlCharacterData = interface(ILMDXmlNode)
  end;

  ILMDXmlText = interface(ILMDXmlCharacterData)
  end;

  ILMDXmlCDATASection = interface(ILMDXmlCharacterData)
  end;

  ILMDXmlComment = interface(ILMDXmlCharacterData)
  end;

  ILMDXmlProcessingInstruction = interface(ILMDXmlNode)
  end;

  ILMDXmlDocument = interface(ILMDXmlNode)
    function get_DocumentElement: ILMDXmlElement;
    function get_BinaryXML: string;
    function get_PreserveWhiteSpace: Boolean;
    procedure set_PreserveWhiteSpace(aValue: Boolean);
    function get_CaseSensitive: Boolean;
    procedure set_CaseSensitive(const AValue: Boolean);

    function NewDocument(const aVersion, anEncoding: TLMDString;
      aRootElementNameID: Integer): ILMDXmlElement; overload;
    function NewDocument(const aVersion, anEncoding,
      aRootElementName: TLMDString): ILMDXmlElement; overload;

    function CreateElement(aNameID: Integer): ILMDXmlElement; overload;
    function CreateElement(const aName: TLMDString): ILMDXmlElement; overload;
    function CreateText(const aData: TLMDString): ILMDXmlText;
    function CreateCDATASection(const aData: TLMDString): ILMDXmlCDATASection;
    function CreateComment(const aData: TLMDString): ILMDXmlComment;
    function CreateProcessingInstruction(const aTarget,
      aData: TLMDString): ILMDXmlProcessingInstruction; overload;
    function CreateProcessingInstruction(aTargetID: Integer;
      const aData: TLMDString): ILMDXmlProcessingInstruction; overload;

    procedure LoadXML(const aXML: TLMDString);
    procedure LoadBinaryXML(const aXML: string);

    procedure Load(aStream: TStream); overload;
    procedure Load(const aFileName: TLMDString); overload;

    procedure LoadResource(aType, aName: PChar);

    procedure Save(aStream: TStream); overload;
    procedure Save(const aFileName: TLMDString); overload;

    procedure SaveBinary(aStream: TStream; anOptions: LongWord = 0); overload;
    procedure SaveBinary(const aFileName: TLMDString; anOptions: LongWord = 0); overload;

    property CaseSensitive: Boolean read get_CaseSensitive write set_CaseSensitive;
    property PreserveWhiteSpace: Boolean read get_PreserveWhiteSpace write set_PreserveWhiteSpace;
    property DocumentElement: ILMDXmlElement read get_DocumentElement;
    property BinaryXML: string read get_BinaryXML;
  end;

  // Events
  TLMDXmlNodeEvent = procedure(Sender: TObject; ANode: ILMDXmlNode);

function LMDCreateNameTable(aHashTableSize: Integer = 4096): ILMDXmlNameTable;
function LMDCreateXmlDocument(
  const aRootElementName: string = '';
  const aVersion: string = '1.0';
  const anEncoding: string = ''; // SimpleXmlDefaultEncoding
  const aNames: ILMDXmlNameTable = nil;
  const ACaseSensitive: Boolean = True): ILMDXmlDocument;

function LMDCreateXmlElement(const aName: TLMDString; const aNameTable: ILMDXmlNameTable = nil): ILMDXmlElement;
function LMDLoadXmlDocumentFromXML(const aXML: TLMDString): ILMDXmlDocument;
function LMDLoadXmlDocumentFromBinaryXML(const aXML: string): ILMDXmlDocument;

function LMDLoadXmlDocument(aStream: TStream): ILMDXmlDocument; overload;
function LMDLoadXmlDocument(const aFileName: TLMDString): ILMDXmlDocument; overload;

function LMDLoadXmlDocument(aResType, aResName: PChar): ILMDXmlDocument; overload;

var
  DefaultNameTable: ILMDXmlNameTable = nil;
  DefaultPreserveWhiteSpace: Boolean = False;
  DefaulCaseSensitive: Boolean = True;
  DefaultEncoding: string = 'windows-1251';
  DefaultBOM: TLMDBOM = bomNone;
  DefaultIndentText: string = ^I;

function LMDXSTRToFloat(s: TLMDString): Double;
function LMDFloatToXSTR(v: Double): TLMDString;
function LMDDateTimeToXSTR(v: TDateTime): TLMDString;
function LMDVarToXSTR(const AVar: Variant): TLMDString;

function LMDTextToXML(const aText: TLMDString): TLMDString;

function LMDBinToBase64(const aBin; aSize, aMaxLineLength: Integer): string;

function LMDBase64ToBin(const aBase64: string): string;
function LMDIsXmlDataString(const aData: string): Boolean;
function LMDXmlIsInBinaryFormat(const aData: string): Boolean;
procedure LMDPrepareToSaveXml(var anElem: ILMDXmlElement; const aChildName: string);
function LMDPrepareToLoadXml(var anElem: ILMDXmlElement; const aChildName: string): Boolean;

function LoadXMLResource(aModule: HMODULE; aName, aType: PChar; const aXMLDoc: ILMDXmlDocument): boolean;

implementation

uses
  LMDStrings,
  LMDUnicode,
  DateUtils;

function LMDTextToXML(const aText: TLMDString): TLMDString;

var
  i, j: Integer;

begin

  j := 0;
  for i := 1 to Length(aText) do
    case aText[i] of
      '<', '>': Inc(j, 4);
      '&': Inc(j, 5);
      '"': Inc(j, 6);
    else
      Inc(j);
    end;
  if j = Length(aText) then
    Result := aText
  else
  begin
    SetLength(Result, j);
    j := 1;
    for i := 1 to Length(aText) do
      case aText[i] of
        '<':
          begin
            Move(PLMDChar(TLMDString('&lt;'))^, Result[j],
                 4 * SizeOf(TLMDChar));
            Inc(j, 4)
          end;
        '>':
          begin
            Move(PLMDChar(TLMDString('&gt;'))^, Result[j],
                 4 * SizeOf(TLMDChar));
            Inc(j, 4)
          end;
        '&':
          begin
            Move(PLMDChar(TLMDString('&amp;'))^, Result[j],
                 5 * SizeOf(TLMDChar));
            Inc(j, 5)
          end;
        '"':
          begin
            Move(PLMDChar(TLMDString('&quot;'))^, Result[j],
                 6 * SizeOf(TLMDChar));
            Inc(j, 6)
          end;
      else
        begin
          Result[j] := aText[i];
          Inc(j)
        end;
      end;
  end;

end;

function LMDXSTRToFloat(s: TLMDString): Double;
var
  aPos: Integer;
begin
  if '.' = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator then
    aPos := Pos(',', s)
  else
    if ',' = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator then
      aPos := Pos('.', s)
    else
    begin
      aPos := Pos(',', s);
      if aPos = 0 then
        aPos := Pos('.', s);
    end;

  if aPos <> 0 then

    s[aPos] := TLMDChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator);

  Result := StrToFloat(s);
end;

function LMDFloatToXSTR(v: Double): TLMDString;
var
  aPos: Integer;
begin
  Result := FloatToStr(v);
  aPos := Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, Result);
  if aPos <> 0 then
    Result[aPos] := '.';
end;

function LMDXSTRToDateTime(const s: string): TDateTime;
var
  aPos: Integer;

  function FetchTo(aStop: Char): Integer;
  var
    i: Integer;
  begin
    i := aPos;
    while (i <= Length(s)) and ((s[i] >= '0') and (s[i] <= '9')) do
      Inc(i);
    if i > aPos then
      Result := StrToInt(Copy(s, aPos, i - aPos))
    else
      Result := 0;
    if (i <= Length(s)) and (s[i] = aStop) then
      aPos := i + 1
    else
      aPos := Length(s) + 1;
  end;

var
  y, m, d, h, n, ss: Integer;
begin
  aPos := 1;
  y := FetchTo('-');
  m := FetchTo('-');
  d := FetchTo('T');
  h := FetchTo('-');
  n := FetchTo('-');
  ss := FetchTo('-');
  Result := EncodeDateTime(y, m, d, h, n, ss, 0);
end;

function LMDDateTimeToXSTR(v: TDateTime): TLMDString;
var
  y, m, d, h, n, s, ms: Word;
begin
  DecodeDateTime(v, y, m, d, h, n, s, ms);
  Result := Format('%.4d-%.2d-%.2dT%.2d-%.2d-%.2d', [y, m, d, h, n, s])
end;

function LMDVarToXSTR(const AVar: Variant): TLMDString;
const
  // Why string[1]: This is a work-around of very hard to debug D2010 bug. It
  // visible only in IDE at design-time, after some package rebuild. Don't
  // change to 'string' or TLMDString. Please!

  BoolStr: array[Boolean] of string[1] = ('0', '1');
var
  LType: Integer;

  p: Pointer;
  v: TVarData;

begin
  v := TVarData(AVar);
  LType := v.VType;

  case LType of
    varNull: Result := LMD_XSTR_NULL;
    varSmallint: Result := IntToStr(v.VSmallInt);
    varInteger: Result := IntToStr(v.VInteger);
    varSingle: Result := LMDFloatToXSTR(v.VSingle);
    varDouble: Result := LMDFloatToXSTR(v.VDouble);
    varCurrency: Result := LMDFloatToXSTR(v.VCurrency);
    varDate: Result := LMDDateTimeToXSTR(v.VDate);

    varOleStr: Result := v.VOleStr;

    varBoolean: Result := TLMDString(BoolStr[v.VBoolean = True]);

    varShortInt: Result := IntToStr(v.VShortInt);
    varWord: Result := IntToStr(v.VWord);
    varLongWord: Result := IntToStr(v.VLongWord);
    varInt64: Result := IntToStr(v.VInt64);

    varByte: Result := IntToStr(v.VByte);
    varString: Result := string(v.VString);
    {$IFDEF LMDCOMP12}
    varUString: Result := UnicodeString(v.VUString);
    {$ENDIF}
    varArray + varByte:
      begin

        p := VarArrayLock(AVar);
        try
          Result := LMDBinToBase64(p^, VarArrayHighBound(AVar, 1) - VarArrayLowBound(AVar, 1) + 1, 0);
        finally
          VarArrayUnlock(AVar)
        end

      end;
  else
    Result := AVar;
  end;
end;

procedure LMDPrepareToSaveXml(var anElem: ILMDXmlElement; const aChildName: string);
begin
  if aChildName <> '' then
    anElem := anElem.AppendElement(aChildName);
end;

function LMDPrepareToLoadXml(var anElem: ILMDXmlElement; const aChildName: string): Boolean;
begin
  if (aChildName <> '') and Assigned(anElem) then
    anElem := anElem.selectSingleNode(aChildName).AsElement;
  Result := Assigned(anElem);
end;

function LoadXMLResource(aModule: HMODULE; aName, aType: PChar; const aXMLDoc: ILMDXmlDocument): boolean;

var
  aRSRC: HRSRC;
  aGlobal: HGLOBAL;
  aSize: DWORD;

  aPointer: Pointer;

  aStream: TStringStream;
begin
  Result := false;
  aRSRC := FindResource(aModule, aName, aType);
  if aRSRC <> 0 then
  begin
    aGlobal := LoadResource(aModule, aRSRC);
    aSize := SizeofResource(aModule, aRSRC);
    if (aGlobal <> 0) and (aSize <> 0) then
    begin
      aPointer := LockResource(aGlobal);
      if Assigned(aPointer) then
      begin
        aStream := TStringStream.Create('');
        try

          aStream.WriteBuffer(aPointer^, aSize);

          aXMLDoc.LoadXML(aStream.DataString);
          Result := true;
        finally
          aStream.Free;
        end;
      end;
    end;
  end;
end;

function LMDIsXmlDataString(const aData: string): Boolean;
var
  i: Integer;
begin
  Result := Copy(aData, 1, LMDBinXmlSignatureSize) = LMDBinXmlSignature;
  if not Result then
  begin
    i := 1;

    while (i <= Length(aData)) and (AnsiChar(aData[i]) in [#10, #13, #9, ' ']) do

      Inc(i);
    Result := Copy(aData, i, Length('<?xml ')) = '<?xml ';
  end;
end;

function LMDXmlIsInBinaryFormat(const aData: string): Boolean;
begin
  Result := Copy(aData, 1, LMDBinXmlSignatureSize) = LMDBinXmlSignature
end;

var
  Base64Map: array[0..63] of Char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

type
  PLMDChars = ^TLMDChars;
  TLMDChars = packed record
    a, b, c, d: Char;
  end;

  PLMDOctet = ^TLMDOctet;
  TLMDOctet = packed record
    a, b, c: Byte;
  end;

procedure OctetToChars(po: PLMDOctet; aCount: Integer; pc: PLMDChars);
var
  o: Integer;
begin
  if aCount = 1 then
  begin
    o := po.a shl 16;
    pc.a := Base64Map[(o shr 18) and $3F];
    pc.b := Base64Map[(o shr 12) and $3F];
    pc.c := #$3D;
    pc.d := #$3D;
  end
  else
    if aCount = 2 then
    begin
      o := po.a shl 16 or po.b shl 8;
      pc.a := Base64Map[(o shr 18) and $3F];
      pc.b := Base64Map[(o shr 12) and $3F];
      pc.c := Base64Map[(o shr 6) and $3F];
      pc.d := #$3D;
    end
    else
      if aCount > 2 then
      begin
        o := po.a shl 16 or po.b shl 8 or po.c;
        pc.a := Base64Map[(o shr 18) and $3F];
        pc.b := Base64Map[(o shr 12) and $3F];
        pc.c := Base64Map[(o shr 6) and $3F];
        pc.d := Base64Map[o and $3F];
      end;
end;

function LMDBinToBase64(const aBin; aSize, aMaxLineLength: Integer): string;
var
  o: PLMDOctet;
  c: PLMDChars;
  aCount: Integer;
  i: Integer;

begin

  o := @aBin;
  aCount := aSize;
  SetLength(Result, ((aCount + 2) div 3) * 4);
  c := PLMDChars(Result);
  while aCount > 0 do
  begin
    OctetToChars(o, aCount, c);
    Inc(c);
    Inc(o);
    Dec(aCount, 3);
  end;
  if aMaxLineLength > 0 then
  begin
    i := aMaxLineLength;
    while i <= Length(Result) do
    begin
      Insert(#13#10, Result, i);
      Inc(i, 2 + aMaxLineLength);
    end
  end;

end;

function CharTo6Bit(c: Char): Byte;
begin
  if (c >= 'A') and (c <= 'Z') then
    Result := Ord(c) - Ord('A')
  else
    if (c >= 'a') and (c <= 'z') then
      Result := Ord(c) - Ord('a') + 26
    else
      if (c >= '0') and (c <= '9') then
        Result := Ord(c) - Ord('0') + 52
      else
        if c = '+' then
          Result := 62
        else
          if c = '/' then
            Result := 63
          else
            Result := 0
end;

procedure CharsToOctet(c: PLMDChars; o: PLMDOctet);
var
  i: Integer;
begin
  if c.c = '=' then
  begin // 1 byte
    i := CharTo6Bit(c.a) shl 18 or CharTo6Bit(c.b) shl 12;
    o.a := (i shr 16) and $FF;
  end
  else
    if c.d = '=' then
    begin // 2 bytes
      i := CharTo6Bit(c.a) shl 18 or CharTo6Bit(c.b) shl 12 or CharTo6Bit(c.c) shl 6;
      o.a := (i shr 16) and $FF;
      o.b := (i shr 8) and $FF;
    end
    else
    begin // 3 bytes
      i := CharTo6Bit(c.a) shl 18 or CharTo6Bit(c.b) shl 12 or CharTo6Bit(c.c) shl 6 or CharTo6Bit(c.d);
      o.a := (i shr 16) and $FF;
      o.b := (i shr 8) and $FF;
      o.c := i and $FF;
    end;
end;

function LMDBase64ToBin(const aBase64: string): string;
var
  o: PLMDOctet;
  c: PLMDChars;
  aCount: Integer;
  s: string;
  i, j: Integer;
begin
  s := aBase64;
  i := 1;
  while i <= Length(s) do
  begin
    while (i <= Length(s)) and (s[i] > ' ') do
      Inc(i);
    if i <= Length(s) then
    begin
      j := i;
      while (j <= Length(s)) and (s[j] <= ' ') do
        Inc(j);
      Delete(s, i, j - i);
    end;
  end;

  if Length(s) < 4 then
    Result := ''
  else
  begin
    aCount := ((Length(s) + 3) div 4) * 3;
    if aCount > 0 then
    begin
      if s[Length(s) - 1] = '=' then
        Dec(aCount, 2)
      else
        if s[Length(s)] = '=' then
          Dec(aCount);
      SetLength(Result, aCount);
      FillChar(Result[1], aCount, '*');
      c := @s[1];
      o := @Result[1];
      while aCount > 0 do
      begin
        CharsToOctet(c, o);
        Inc(o);
        Inc(c);
        Dec(aCount, 3);
      end;
    end;
  end;
end;

type
  TLMDBinXmlReader = class
  private
    FOptions: LongWord;
  public

    procedure Read(var aBuf; aSize: Integer); virtual; abstract;

    function ReadLongint: Longint;

    function ReadAnsiString: string;

    function ReadWideString: WideString;
    function ReadXmlString: TLMDString;
    procedure ReadVariant(var AVar: Variant);
  end;

  TLMDStmXmlReader = class(TLMDBinXmlReader)
  private
    FStream: TStream;
    FOptions: LongWord;

    FBufStart,
      FBufEnd,
      FBufPtr: PChar;
    FBufSize,
      FRestSize: Integer;

  public
    constructor Create(aStream: TStream; aBufSize: Integer);
    destructor Destroy; override;

    procedure Read(var aBuf; aSize: Integer); override;

  end;

  TLMDStrXmlReader = class(TLMDBinXmlReader)
  private
    FString: string;
    FOptions: LongWord;

    FPtr: PChar;
    FRestSize: Integer;

  public
    constructor Create(const aStr: string);

    procedure Read(var aBuf; aSize: Integer); override;

  end;

  TLMDBinXmlWriter = class
  private
    FOptions: LongWord;
  public

    procedure Write(const aBuf; aSize: Integer); virtual; abstract;

    procedure WriteAnsiString(const aValue: string);

    procedure WriteLongint(aValue: Longint);
    procedure WriteWideString(const aValue: WideString);
    procedure WriteXmlString(const aValue: TLMDString);
    procedure WriteVariant(const AVar: Variant);
  end;

  TLMDStmXmlWriter = class(TLMDBinXmlWriter)
  private
    FStream: TStream;

    FBufStart,
      FBufEnd,
      FBufPtr: PChar;
    FBufSize: Integer;

  public
    constructor Create(aStream: TStream; anOptions: LongWord; aBufSize: Integer);
    destructor Destroy; override;

    procedure Write(const aBuf; aSize: Integer); override;

  end;

  TLMDStrXmlWriter = class(TLMDBinXmlWriter)
  private
    FData: string;

    FBufStart,
      FBufEnd,
      FBufPtr: PChar;
    FBufSize: Integer;

    procedure FlushBuf;
  public
    constructor Create(anOptions: LongWord; aBufSize: Integer);
    destructor Destroy; override;

    procedure Write(const aBuf; aSize: Integer); override;

  end;

  TLMDXmlBase = class(TInterfacedObject, ILMDXmlBase)
  protected
    // IXmlBase interface implementation
    function GetObject: TObject;
  public
  end;

  TLMDNameIndexArray = array of Longint;

  PLMDNameIndexArray = ^TLMDNameIndexArray;

  TLMDXmlNameTable = class(TLMDXmlBase, ILMDXmlNameTable)
  private
    FNames: array of TLMDString;
    FHashTable: array of TLMDNameIndexArray;

    FXmlTextNameID: Integer;
    FXmlCDATASectionNameID: Integer;
    FXmlCommentNameID: Integer;
    FXmlDocumentNameID: Integer;
    FXmlID: Integer;
    FCaseSensitive: Boolean;
  protected
    function GetID(const anName: TLMDString): Integer;
    function GetName(anID: Integer): TLMDString;
  public
    constructor Create(aHashTableSize: Integer; ACaseSensitive: Boolean = True);

    procedure LoadBinXml(aReader: TLMDBinXmlReader);
    procedure SaveBinXml(aWriter: TLMDBinXmlWriter);
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive;
  end;

  { TXmlBase }

function TLMDXmlBase.GetObject: TObject;
begin
  Result := Self;
end;

{ TXmlNameTable }

constructor TLMDXmlNameTable.Create(aHashTableSize: Integer; ACaseSensitive: Boolean = True);
begin
  inherited Create;
  SetLength(FHashTable, aHashTableSize);
  FXmlTextNameID := GetID('#text');
  FXmlCDATASectionNameID := GetID('#cdata-section');
  FXmlCommentNameID := GetID('#comment');
  FXmlDocumentNameID := GetID('#document');
  FXmlID := GetID('xml');
  FCaseSensitive := ACaseSensitive;
end;

procedure TLMDXmlNameTable.LoadBinXml(aReader: TLMDBinXmlReader);
var
  aCount: LongInt;
  anIndex, i: Integer;

begin
  // Read names array
  aCount := aReader.ReadLongint;
  SetLength(FNames, aCount);
  for i := 0 to aCount - 1 do
    FNames[i] := aReader.ReadXmlString;

  // Read hash table
  SetLength(FHashTable, aReader.ReadLongint);
  for i := 0 to Length(FHashTable) - 1 do
    SetLength(FHashTable[i], 0);
  aCount := aReader.ReadLongint;
  for i := 0 to aCount - 1 do
  begin
    anIndex := aReader.ReadLongInt;
    SetLength(FHashTable[anIndex], aReader.ReadLongInt);

    aReader.Read(FHashTable[anIndex][0], Length(FHashTable[anIndex]) * sizeof(Longint));

  end;
end;

procedure TLMDXmlNameTable.SaveBinXml(aWriter: TLMDBinXmlWriter);
var
  aCount: LongInt;
  i: Integer;

begin
  // Write names array
  aCount := Length(FNames);
  aWriter.WriteLongint(aCount);
  for i := 0 to aCount - 1 do
    aWriter.WriteXmlString(FNames[i]);

  // Write hash table
  aWriter.WriteLongint(Length(FHashTable));
  aCount := 0;
  for i := 0 to Length(FHashTable) - 1 do
    if Length(FHashTable[i]) > 0 then
      Inc(aCount);
  aWriter.WriteLongint(aCount);
  for i := 0 to Length(FHashTable) - 1 do
  begin
    aCount := Length(FHashTable[i]);
    if aCount > 0 then
    begin
      aWriter.WriteLongint(i);
      aWriter.WriteLongint(aCount);

      aWriter.Write(FHashTable[i][0], aCount * sizeof(Longint));

    end
  end;
end;

function TLMDXmlNameTable.GetID(const anName: TLMDString): Integer;

  function NameHashKey(const aName: TLMDString): UINT;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 1 to Length(aName) do
      Result := UINT((int64(Result) shl 5) + Result + Ord(aName[i]));
  end;

var
  i: Integer;
  aNameIndexes: PLMDNameIndexArray;
  aName: TLMDString;
  lName: TLMDString;

begin
  if FCaseSensitive then
    aName := anName
  else
    aName := LMDUnicodeUpper(anName);

  if aName = '' then
    Result := -1
  else
  begin

    aNameIndexes := @FHashTable[NameHashKey(aName) mod UINT(Length(FHashTable))];
    for i := 0 to Length(aNameIndexes^) - 1 do
    begin
      Result := aNameIndexes^[i];
      if FCaseSensitive then
        lName := FNames[Result]
      else
        lName := LMDUnicodeUpper(FNames[Result]);

      if lName = aName then
        Exit;
    end;
    Result := Length(FNames);
    SetLength(FNames, Result + 1);
    FNames[Result] := anName;

    SetLength(aNameIndexes^, Length(aNameIndexes^) + 1);
    aNameIndexes^[Length(aNameIndexes^) - 1] := Result;

  end;
end;

function TLMDXmlNameTable.GetName(anID: Integer): TLMDString;
begin
  if anID < 0 then
    Result := ''
  else
    Result := FNames[anID]
end;

function LMDCreateNameTable(aHashTableSize: Integer): ILMDXmlNameTable;
begin
  Result := TLMDXmlNameTable.Create(aHashTableSize)
end;

type
  TLMDXmlNode = class;
  TLMDXmlToken = class
  private
    FValueBuf: TLMDString;
    FValueStart,
      FValuePtr,

    FValueEnd: PLMDChar;

  public
    constructor Create;
    procedure Clear;
    procedure AppendChar(aChar: TLMDChar);
    procedure AppendText(aText: PLMDChar; aCount: Integer);
    function Length: Integer;

    property ValueStart: PLMDChar read FValueStart;

  end;

  TLMDXmlSource = class
  private
    FTokenStack: array of TLMDXmlToken;
    FTokenStackTop: Integer;
    FToken: TLMDXmlToken;
    function ExpectQuotedText(aQuote: TLMDChar): TLMDString;
  public
    CurChar: TLMDChar;
    constructor Create;
    destructor Destroy; override;

    function EOF: Boolean; virtual; abstract;
    function Next: Boolean; virtual; abstract;

    procedure SkipBlanks;
    function ExpectXmlName: TLMDString;
    function ExpectXmlEntity: TLMDChar;
    procedure ExpectChar(aChar: TLMDChar);
    procedure ExpectText(aText: PLMDChar);
    function ExpectDecimalInteger: Integer;
    function ExpectHexInteger: Integer;
    function ParseTo(aText: PLMDChar): TLMDString;
    procedure ParseAttrs(aNode: TLMDXmlNode);

    procedure NewToken;
    procedure AppendTokenChar(aChar: TLMDChar);
    procedure AppendTokenText(aText: PLMDChar; aCount: Integer);
    function AcceptToken: TLMDString;
    procedure DropToken;
  end;

  TLMDXmlStrSource = class(TLMDXmlSource)
  private
    FSource: TLMDString;

    FSourcePtr,
      FSourceEnd: PLMDChar;

  public
    constructor Create(const aSource: TLMDString);
    function EOF: Boolean; override;
    function Next: Boolean; override;
  end;

  // Support UTF8 sequences
  TLMDXmlStmSource = class(TLMDXmlSource)
  private
    FStream: TStream;
    FIsUtf8: Boolean;
    FBuffer: array of byte;
    FBufStart: TLMDString;
    FBufPtr: Integer;
    FBufEnd: Integer;
    FBufSize: Integer;
    FSize: Integer;
  public
    constructor Create(aStream: TStream; aBufSize: Integer; aIsUtf8: Boolean = False);
    function EOF: Boolean; override;
    function Next: Boolean; override;
    destructor Destroy; override;
  end;

  {$ifdef LMD_UNICODE}
  // Unicode stream source (support utf16le)
  TLMDXmlUnicodeStmSource = class(TLMDXmlSource)
  private
    FStream: TStream;
    FBuffer: array of byte;
    FBufStart: TLMDString;
    FBufPtr: Integer;
    FBufEnd: Integer;
    FBufSize: Integer;
    FSize: Integer;
  public
    constructor Create(aStream: TStream; aBufSize: Integer);
    function EOF: Boolean; override;
    function Next: Boolean; override;
    destructor Destroy; override;
  end;
  {$endif}

  TLMDXmlNodeList = class(TLMDXmlBase, ILMDXmlNodeList)
  private
    FOwnerNode: TLMDXmlNode;

    FItems: array of TLMDXmlNode;
    FCount: Integer;
    procedure Grow;
  protected
    function get_Count: Integer;
    function get_Item(anIndex: Integer): ILMDXmlNode;
    function get_XML: TLMDString;
  public
    constructor Create(anOwnerNode: TLMDXmlNode);
    destructor Destroy; override;

    function IndexOf(aNode: TLMDXmlNode): Integer;
    procedure ParseXML(aXML: TLMDXmlSource; aNames: TLMDXmlNameTable; aPreserveWhiteSpace: Boolean);

    procedure LoadBinXml(aReader: TLMDBinXmlReader; aCount: Integer; aNames: TLMDXmlNameTable);
    procedure SaveBinXml(aWriter: TLMDBinXmlWriter);

    procedure Insert(aNode: TLMDXmlNode; anIndex: Integer);
    function Remove(aNode: TLMDXmlNode): Integer;
    procedure Delete(anIndex: Integer);
    procedure Replace(anIndex: Integer; aNode: TLMDXmlNode);
    procedure Clear;
  end;

  TLMDXmlAttrData = record
    NameID: Integer;
    Value: Variant;
  end;

  PLMDXmlAttrData = ^TLMDXmlAttrData;

  TLMDXmlDocument = class;
  TLMDXmlNode = class(TLMDXmlBase, ILMDXmlNode)
  private
    FParentNode: TLMDXmlNode;
    // FNames - Names table
    FNames: TLMDXmlNameTable;
    // Count of attributes in FAttrs array
    FAttrCount: Integer;
    // Array of attributes
    FAttrs: array of TLMDXmlAttrData;
    // Child nodes list
    FChilds: TLMDXmlNodeList;
    function GetChilds: TLMDXmlNodeList; virtual;
    function FindFirstChild(aNameID: Integer): TLMDXmlNode;
    function GetAttrsXML: TLMDString;

    function FindAttrData(aNameID: Integer): PLMDXmlAttrData;

    function GetOwnerDocument: TLMDXmlDocument;
    procedure SetNameTable(aValue: TLMDXmlNameTable; aMap: TList);
    procedure SetNodeNameID(aValue: Integer); virtual;
    function DoCloneNode(aDeep: Boolean): ILMDXmlNode; virtual; abstract;

  protected
    // IXmlNode
    function get_NameTable: ILMDXmlNameTable;
    function get_NodeName: TLMDString;

    function get_NodeNameID: Integer; virtual; abstract;
    function get_NodeType: Integer; virtual; abstract;
    function get_Text: TLMDString; virtual; abstract;
    procedure set_Text(const aValue: TLMDString); virtual; abstract;
    function CloneNode(aDeep: Boolean): ILMDXmlNode;

    procedure LoadBinXml(aReader: TLMDBinXmlReader);
    procedure SaveBinXml(aWriter: TLMDBinXmlWriter);

    function get_DataType: Integer; virtual;
    function get_TypedValue: Variant; virtual;
    procedure set_TypedValue(const aValue: Variant); virtual;

    function get_XML: TLMDString; virtual; abstract;

    function get_OwnerDocument: ILMDXmlDocument; virtual;
    function get_ParentNode: ILMDXmlNode;

    function get_ChildNodes: ILMDXmlNodeList; virtual;
    procedure AppendChild(const aChild: ILMDXmlNode);

    function AppendElement(aNameID: Integer): ILMDXmlElement; overload;
    function AppendElement(const aName: TLMDString): ILMDXmlElement; overload;
    function AppendText(const aData: TLMDString): ILMDXmlText;
    function AppendCDATA(const aData: TLMDString): ILMDXmlCDATASection;
    function AppendComment(const aData: TLMDString): ILMDXmlComment;
    function AppendProcessingInstruction(aTargetID: Integer;
      const aData: TLMDString): ILMDXmlProcessingInstruction; overload;
    function AppendProcessingInstruction(const aTarget: TLMDString;
      const aData: TLMDString): ILMDXmlProcessingInstruction; overload;

    procedure InsertBefore(const aChild, aBefore: ILMDXmlNode);
    procedure ReplaceChild(const aNewChild, anOldChild: ILMDXmlNode);
    procedure RemoveChild(const aChild: ILMDXmlNode);
    function GetChildText(const aName: TLMDString; const aDefault: TLMDString = ''): TLMDString; overload;
    function GetChildText(aNameID: Integer; const aDefault: TLMDString = ''): TLMDString; overload;
    procedure SetChildText(const aName, aValue: TLMDString); overload;
    procedure SetChildText(aNameID: Integer; const aValue: TLMDString); overload;

    function NeedChild(aNameID: Integer): ILMDXmlNode; overload;
    function NeedChild(const aName: TLMDString): ILMDXmlNode; overload;
    function EnsureChild(aNameID: Integer): ILMDXmlNode; overload;
    function EnsureChild(const aName: TLMDString): ILMDXmlNode; overload;

    procedure RemoveAllChilds;

    function SelectNodes(const anExpression: TLMDString): ILMDXmlNodeList;
    function SelectSingleNode(const anExpression: TLMDString): ILMDXmlNode;
    function FindElement(const anElementName, anAttrName: string; const anAttrValue: Variant): ILMDXmlElement;

    function get_AttrCount: Integer;
    function get_AttrNameIDs(anIndex: Integer): Integer;
    function get_AttrNames(anIndex: Integer): TLMDString;
    procedure RemoveAttr(const aName: TLMDString); overload;
    procedure RemoveAttr(aNameID: Integer); overload;
    procedure RemoveAllAttrs;

    function AttrExists(aNameID: Integer): Boolean; overload;
    function AttrExists(const aName: TLMDString): Boolean; overload;

    function GetAttrType(aNameID: Integer): Integer; overload;
    function GetAttrType(const aName: TLMDString): Integer; overload;

    function GetVarAttr(aNameID: Integer; const aDefault: Variant): Variant; overload;
    function GetVarAttr(const aName: TLMDString; const aDefault: Variant): Variant; overload;
    procedure SetVarAttr(aNameID: Integer; const aValue: Variant); overload;
    procedure SetVarAttr(const aName: TLMDString; aValue: Variant); overload;

    function NeedAttr(aNameID: Integer): TLMDString; overload;
    function NeedAttr(const aName: TLMDString): TLMDString; overload;

    function GetAttr(aNameID: Integer; const aDefault: TLMDString = ''): TLMDString; overload;
    function GetAttr(const aName: TLMDString; const aDefault: TLMDString = ''): TLMDString; overload;
    procedure SetAttr(aNameID: Integer; const aValue: TLMDString); overload;
    procedure SetAttr(const aName, aValue: TLMDString); overload;

    function GetBoolAttr(aNameID: Integer; aDefault: Boolean = False): Boolean; overload;
    function GetBoolAttr(const aName: TLMDString; aDefault: Boolean = False): Boolean; overload;
    procedure SetBoolAttr(aNameID: Integer; aValue: Boolean = False); overload;
    procedure SetBoolAttr(const aName: TLMDString; aValue: Boolean); overload;

    function GetIntAttr(aNameID: Integer; aDefault: Integer = 0): Integer; overload;
    function GetIntAttr(const aName: TLMDString; aDefault: Integer = 0): Integer; overload;
    procedure SetIntAttr(aNameID: Integer; aValue: Integer); overload;
    procedure SetIntAttr(const aName: TLMDString; aValue: Integer); overload;

    function GetInt64Attr(aNameID: Integer; aDefault: Int64 = 0): Int64; overload;
    function GetInt64Attr(const aName: TLMDString; aDefault: Int64 = 0): Int64; overload;
    procedure SetInt64Attr(aNameID: Integer; aValue: Int64); overload;
    procedure SetInt64Attr(const aName: TLMDString; aValue: Int64); overload;

    function GetDateTimeAttr(aNameID: Integer; aDefault: TDateTime = 0): TDateTime; overload;
    function GetDateTimeAttr(const aName: TLMDString; aDefault: TDateTime = 0): TDateTime; overload;
    procedure SetDateTimeAttr(aNameID: Integer; aValue: TDateTime); overload;
    procedure SetDateTimeAttr(const aName: TLMDString; aValue: TDateTime); overload;

    function GetFloatAttr(aNameID: Integer; aDefault: Double = 0): Double; overload;
    function GetFloatAttr(const aName: TLMDString; aDefault: Double = 0): Double; overload;
    procedure SetFloatAttr(aNameID: Integer; aValue: Double); overload;
    procedure SetFloatAttr(const aName: TLMDString; aValue: Double); overload;

    function GetHexAttr(const aName: TLMDString; aDefault: Integer = 0): Integer; overload;
    function GetHexAttr(aNameID: Integer; aDefault: Integer = 0): Integer; overload;
    procedure SetHexAttr(const aName: TLMDString; aValue: Integer; aDigits: Integer = 8); overload;
    procedure SetHexAttr(aNameID: Integer; aValue: Integer; aDigits: Integer = 8); overload;

    function GetEnumAttr(const aName: TLMDString;
      const aValues: array of TLMDString; aDefault: Integer = 0): Integer; overload;
    function GetEnumAttr(aNameID: Integer;
      const aValues: array of TLMDString; aDefault: Integer = 0): Integer; overload;
    function NeedEnumAttr(const aName: TLMDString;
      const aValues: array of TLMDString): Integer; overload;
    function NeedEnumAttr(aNameID: Integer;
      const aValues: array of TLMDString): Integer; overload;

    function get_Values(const aName: TLMDString): Variant;
    procedure set_Values(const aName: TLMDString; const aValue: Variant);

    function get_AttrValues(anIndex: Integer): TLMDString;
    procedure set_AttrValues(anIndex: Integer; const aValue: TLMDString);

    function AsElement: ILMDXmlElement; virtual;
    function AsText: ILMDXmlText; virtual;
    function AsCDATASection: ILMDXmlCDATASection; virtual;
    function AsComment: ILMDXmlComment; virtual;
    function AsProcessingInstruction: ILMDXmlProcessingInstruction; virtual;
    function GetElementsByTagName(const ATagName: WideString): ILMDXmlNodeList;
  public
    constructor Create(aNames: TLMDXmlNameTable);
    destructor Destroy; override;
  end;

  TLMDXmlElement = class(TLMDXmlNode, ILMDXmlElement)
  private
    FNameID: Integer;
    FData: Variant;
    procedure RemoveTextNodes;
    procedure SetNodeNameID(aValue: Integer); override;
    function DoCloneNode(aDeep: Boolean): ILMDXmlNode; override;
  protected
    function GetChilds: TLMDXmlNodeList; override;

    function get_NodeNameID: Integer; override;
    function get_NodeType: Integer; override;
    function get_Text: TLMDString; override;
    procedure set_Text(const aValue: TLMDString); override;
    function get_DataType: Integer; override;
    function get_TypedValue: Variant; override;
    procedure set_TypedValue(const aValue: Variant); override;
    function get_XML: TLMDString; override;
    function AsElement: ILMDXmlElement; override;
    function get_ChildNodes: ILMDXmlNodeList; override;

    // IXmlElement
    procedure ReplaceTextByCDATASection(const aText: TLMDString);

    procedure ReplaceTextByBynaryData(const aData; aSize: Integer; aMaxLineLength: Integer);

    function GetTextAsBynaryData: TLMDString;
  public
    constructor Create(aNames: TLMDXmlNameTable; aNameID: Integer);
  end;

  TLMDXmlCharacterData = class(TLMDXmlNode, ILMDXmlCharacterData)
  private
    FData: TLMDString;
  protected
    function get_Text: TLMDString; override;
    procedure set_Text(const aValue: TLMDString); override;
  public
    constructor Create(aNames: TLMDXmlNameTable; const aData: TLMDString);
  end;

  TLMDXmlText = class(TLMDXmlNode, ILMDXmlText)
  private
    FData: Variant;
    function DoCloneNode(aDeep: Boolean): ILMDXmlNode; override;
  protected
    function get_NodeNameID: Integer; override;
    function get_NodeType: Integer; override;
    function get_Text: TLMDString; override;
    procedure set_Text(const aValue: TLMDString); override;
    function get_DataType: Integer; override;
    function get_TypedValue: Variant; override;
    procedure set_TypedValue(const aValue: Variant); override;
    function get_XML: TLMDString; override;
    function AsText: ILMDXmlText; override;
  public
    constructor Create(aNames: TLMDXmlNameTable; const aData: Variant);
  end;

  TLMDXmlCDATASection = class(TLMDXmlCharacterData, ILMDXmlCDATASection)
  protected
    function get_NodeNameID: Integer; override;
    function get_NodeType: Integer; override;
    function get_XML: TLMDString; override;
    function AsCDATASection: ILMDXmlCDATASection; override;
    function DoCloneNode(aDeep: Boolean): ILMDXmlNode; override;
  public
  end;

  TLMDXmlComment = class(TLMDXmlCharacterData, ILMDXmlComment)
  protected
    function get_NodeNameID: Integer; override;
    function get_NodeType: Integer; override;
    function get_XML: TLMDString; override;
    function AsComment: ILMDXmlComment; override;
    function DoCloneNode(aDeep: Boolean): ILMDXmlNode; override;
  public
  end;

  TLMDXmlProcessingInstruction = class(TLMDXmlNode, ILMDXmlProcessingInstruction)
  private
    FTargetID: Integer;
    FData: string;
    procedure SetNodeNameID(aValue: Integer); override;
    function DoCloneNode(aDeep: Boolean): ILMDXmlNode; override;
  protected
    function get_NodeNameID: Integer; override;
    function get_NodeType: Integer; override;
    function get_Text: TLMDString; override;
    procedure set_Text(const aText: TLMDString); override;
    function get_XML: TLMDString; override;
    function AsProcessingInstruction: ILMDXmlProcessingInstruction; override;

  public
    constructor Create(aNames: TLMDXmlNameTable; aTargetID: Integer;
      const aData: TLMDString);
  end;

  TLMDXmlDocument = class(TLMDXmlNode, ILMDXmlDocument)
  private
    FPreserveWhiteSpace: Boolean;
    FCaseSensitive: Boolean;
    FBOM: TLMDBOM;
    function DoCloneNode(aDeep: Boolean): ILMDXmlNode; override;
  protected
    function get_NodeNameID: Integer; override;
    function get_NodeType: Integer; override;
    function get_Text: TLMDString; override;
    procedure set_Text(const aText: TLMDString); override;
    function get_XML: TLMDString; override;
    function get_PreserveWhiteSpace: Boolean;
    procedure set_PreserveWhiteSpace(aValue: Boolean);
    function get_CaseSensitive: Boolean;
    procedure set_CaseSensitive(const AValue: Boolean);

    function NewDocument(const aVersion, anEncoding: TLMDString;
      aRootElementNameID: Integer): ILMDXmlElement; overload;
    function NewDocument(const aVersion, anEncoding,
      aRootElementName: TLMDString): ILMDXmlElement; overload;

    function CreateElement(aNameID: Integer): ILMDXmlElement; overload;
    function CreateElement(const aName: TLMDString): ILMDXmlElement; overload;
    function CreateText(const aData: TLMDString): ILMDXmlText;
    function CreateCDATASection(const aData: TLMDString): ILMDXmlCDATASection;
    function CreateComment(const aData: TLMDString): ILMDXmlComment;
    function get_DocumentElement: ILMDXmlElement;
    function CreateProcessingInstruction(const aTarget,
      aData: TLMDString): ILMDXmlProcessingInstruction; overload;
    function CreateProcessingInstruction(aTargetID: Integer;
      const aData: TLMDString): ILMDXmlProcessingInstruction; overload;
    procedure LoadXML(const aXML: TLMDString);

    procedure Load(aStream: TStream); overload;
    procedure Load(const aFileName: TLMDString); overload;

    procedure LoadResource(aType, aName: PChar);

    procedure Save(aStream: TStream); overload;
    procedure Save(const aFileName: TLMDString); overload;

    procedure SaveBinary(aStream: TStream; anOptions: LongWord); overload;
    procedure SaveBinary(const aFileName: TLMDString; anOptions: LongWord); overload;

    function get_BinaryXML: string;
    procedure LoadBinaryXML(const aXML: string);
  public
    constructor Create(aNames: TLMDXmlNameTable);
  end;

  { TXmlNodeList }

procedure TLMDXmlNodeList.Clear;
var
  i: Integer;
  aNode: TLMDXmlNode;
begin
  for i := 0 to FCount - 1 do
  begin
    aNode := FItems[i];
    if Assigned(FOwnerNode) then
      aNode.FParentNode := nil;

    aNode._Release;

  end;
  FCount := 0;
end;

procedure TLMDXmlNodeList.Delete(anIndex: Integer);
var
  aNode: TLMDXmlNode;
begin
  aNode := FItems[anIndex];
  Dec(FCount);
  if anIndex < FCount then

    Move(FItems[anIndex + 1], FItems[anIndex], (FCount - anIndex) * SizeOf(TLMDXmlNode));

  if Assigned(aNode) then
  begin
    if Assigned(FOwnerNode) then
      aNode.FParentNode := nil;

    aNode._Release;

  end;
end;

constructor TLMDXmlNodeList.Create(anOwnerNode: TLMDXmlNode);
begin
  inherited Create;
  FOwnerNode := anOwnerNode;
end;

destructor TLMDXmlNodeList.Destroy;
begin
  Clear;
  inherited;
end;

function TLMDXmlNodeList.get_Item(anIndex: Integer): ILMDXmlNode;
begin
  if (anIndex < 0) or (anIndex >= FCount) then
    raise Exception.Create(SLMDXmlError1);
  Result := FItems[anIndex]
end;

function TLMDXmlNodeList.get_Count: Integer;
begin
  Result := FCount
end;

function TLMDXmlNodeList.IndexOf(aNode: TLMDXmlNode): Integer;
var
  i: Integer;
begin
  for i := 0 to FCount - 1 do
    if FItems[i] = aNode then
    begin
      Result := i;
      Exit
    end;
  Result := -1;
end;

procedure TLMDXmlNodeList.Grow;
var
  aDelta: Integer;
begin
  if Length(FItems) > 64 then
    aDelta := Length(FItems) div 4
  else
    if Length(FItems) > 8 then
      aDelta := 16
    else
      aDelta := 4;
  SetLength(FItems, Length(FItems) + aDelta);
end;

procedure TLMDXmlNodeList.Insert(aNode: TLMDXmlNode; anIndex: Integer);
begin
  if anIndex = -1 then
    anIndex := FCount;
  if FCount = Length(FItems) then
    Grow;
  if anIndex < FCount then

    Move(FItems[anIndex], FItems[anIndex + 1], (FCount - anIndex) * SizeOf(TLMDXmlNode));

  FItems[anIndex] := aNode;
  Inc(FCount);
  if aNode <> nil then
  begin

    aNode._AddRef;

    if Assigned(FOwnerNode) then
    begin
      aNode.FParentNode := FOwnerNode;
      aNode.SetNameTable(FOwnerNode.FNames, nil);
    end;
  end;
end;

function TLMDXmlNodeList.Remove(aNode: TLMDXmlNode): Integer;
begin
  Result := IndexOf(aNode);
  if Result <> -1 then
    Delete(Result);
end;

procedure TLMDXmlNodeList.Replace(anIndex: Integer; aNode: TLMDXmlNode);
var
  anOldNode: TLMDXmlNode;
begin
  anOldNode := FItems[anIndex];
  if aNode <> anOldNode then
  begin
    if Assigned(anOldNode) then
    begin
      if Assigned(FOwnerNode) then
        anOldNode.FParentNode := nil;

      anOldNode._Release;

    end;
    FItems[anIndex] := aNode;
    if Assigned(aNode) then
    begin

      aNode._AddRef;

      if Assigned(FOwnerNode) then
      begin
        aNode.FParentNode := FOwnerNode;
        aNode.SetNameTable(FOwnerNode.FNames, nil);
      end
    end
  end;
end;

function TLMDXmlNodeList.get_XML: TLMDString;
var
  i: Integer;
  s: TLMDString;
begin
  Result := '';
  for i := 0 to FCount - 1 do
  begin
    s := FItems[i].get_XML;
    Result := Result + s;
  end;
end;

procedure TLMDXmlNodeList.ParseXML(aXML: TLMDXmlSource; aNames: TLMDXmlNameTable; aPreserveWhiteSpace: Boolean);

// Input: text symbol
// Output: symbol '<'

  procedure ParseText;
  var
    aText: string;
    LNode: TLMDXmlText;
  begin
    aXml.NewToken;
    while not aXML.EOF and (aXML.CurChar <> '<') do
      if aXML.CurChar = '&' then
        aXml.AppendTokenChar(aXml.ExpectXmlEntity)
      else
      begin
        aXml.AppendTokenChar(aXML.CurChar);
        aXML.Next;
      end;
    aText := aXml.AcceptToken;
    if aPreserveWhiteSpace or (Trim(aText) <> '') then
    begin
      LNode := TLMDXmlText.Create(aNames, TrimRight(aText));
      Insert(LNode, -1);
    end;
  end;

  // CurChar - '?'

  procedure ParseProcessingInstruction;
  var
    aTarget: TLMDString;
    aNode: TLMDXmlProcessingInstruction;
  begin
    aXML.Next;
    aTarget := aXML.ExpectXmlName;
    aNode := TLMDXmlProcessingInstruction.Create(aNames, aNames.GetID(aTarget), '');
    Insert(aNode, -1);
    if aNode.FTargetID = aNames.FXmlID then
    begin
      aXml.ParseAttrs(aNode);
      aXml.ExpectText('?>');
    end
    else
    begin
      aXML.SkipBlanks;
      aNode.FData := aXml.ParseTo('?>');
    end;
  end;

  // Input: first '--'
  // Output: symbol after '-->'

  procedure ParseComment;
  begin
    aXml.ExpectText('--');
    Insert(TLMDXmlComment.Create(aNames, aXml.ParseTo('-->')), -1);
  end;

  // Input: '[CDATA['
  // Output: symbol after ']]>'

  procedure ParseCDATA;
  begin
    aXml.ExpectText('[CDATA[');
    Insert(TLMDXmlCDATASection.Create(aNames, aXml.ParseTo(']]>')), -1);
  end;

  // Input: 'DOCTYPE'
  // Output: symbol after '>'

  procedure ParseDOCTYPE;
  begin
    aXml.ExpectText('DOCTYPE');
    aXml.ParseTo('>');
  end;

  // Input: 'element-name'
  // Output: symbol after '>'

  procedure ParseElement;
  var
    aNameID: Integer;
    aNode: TLMDXmlElement;
  begin
    aNameID := aNames.GetID(aXml.ExpectXmlName);
    if aXml.EOF then
      raise Exception.Create(SLMDXmlError2);
    if not ((aXml.CurChar <= ' ') or (aXml.CurChar = '/') or (aXml.CurChar = '>')) then
      raise Exception.Create(SLMDXmlError3);
    aNode := TLMDXmlElement.Create(aNames, aNameID);
    Insert(aNode, -1);
    aXml.ParseAttrs(aNode);
    if aXml.CurChar = '/' then
      aXml.ExpectText('/>')
    else
    begin
      aXml.ExpectChar('>');
      aNode.GetChilds.ParseXML(aXml, aNames, aPreserveWhiteSpace);
      aXml.ExpectChar('/');
      aXml.ExpectText(PLMDChar(aNames.GetName(aNameID)));
      aXml.SkipBlanks;
      aXml.ExpectChar('>');
    end;
  end;

begin
  while not aXML.EOF do
  begin
    ParseText;
    if aXML.CurChar = '<' then // symbol of markup
      if aXML.Next then
        if aXML.CurChar = '/' then // closing tag of element.
          Exit
        else
          if aXML.CurChar = '?' then // instruction
            ParseProcessingInstruction
          else
            if aXML.CurChar = '!' then
            begin
              if aXML.Next then
                if aXML.CurChar = '-' then // comment
                  ParseComment
                else
                  if aXML.CurChar = '[' then // CDATA section
                    ParseCDATA
                  else
                    ParseDOCTYPE
            end
            else // openning element tag
              ParseElement
  end;
end;

procedure TLMDXmlNodeList.LoadBinXml(aReader: TLMDBinXmlReader;
  aCount: Integer; aNames: TLMDXmlNameTable);
var
  i: Integer;
  aNodeType: Byte;
  aNode: TLMDXmlNode;
  aNameID: LongInt;
begin
  Clear;
  SetLength(FItems, aCount);
  for i := 0 to aCount - 1 do
  begin

    aReader.Read(aNodeType, sizeof(aNodeType));

    case aNodeType of
      LMD_NODE_ELEMENT:
        begin
          aNameID := aReader.ReadLongint;
          aNode := TLMDXmlElement.Create(aNames, aNameID);
          Insert(aNode, -1);
          with TLMDXmlElement(aNode) do
            aReader.ReadVariant(FData);
          aNode.LoadBinXml(aReader);
        end;
      LMD_NODE_TEXT:
        begin
          aNode := TLMDXmlText.Create(aNames, Unassigned);
          Insert(aNode, -1);
          with TLMDXmlText(aNode) do
            aReader.ReadVariant(FData);
        end;
      LMD_NODE_CDATA_SECTION:
        Insert(TLMDXmlCDATASection.Create(aNames, aReader.ReadXmlString), -1);
      LMD_NODE_PROCESSING_INSTRUCTION:
        begin
          aNameID := aReader.ReadLongint;
          aNode := TLMDXmlProcessingInstruction.Create(aNames, aNameID,
            aReader.ReadXmlString);
          Insert(aNode, -1);
          aNode.LoadBinXml(aReader);
        end;
      LMD_NODE_COMMENT:
        Insert(TLMDXmlComment.Create(aNames, aReader.ReadXmlString), -1);
    else
      raise Exception.Create(SLMDXmlError4);
    end
  end;
end;

procedure TLMDXmlNodeList.SaveBinXml(aWriter: TLMDBinXmlWriter);

const
  EmptyVar: TVarData = (VType: varEmpty);

var
  aCount: LongInt;
  i: Integer;
  aNodeType: Byte;
  aNode: TLMDXmlNode;
begin
  aCount := FCount;
  for i := 0 to aCount - 1 do
  begin
    aNode := FItems[i];
    aNodeType := aNode.get_NodeType;
    aWriter.Write(aNodeType, sizeof(aNodeType));
    case aNodeType of
      LMD_NODE_ELEMENT:
        with TLMDXmlElement(aNode) do
        begin
          aWriter.WriteLongint(FNameID);
          if Assigned(FChilds) and (FChilds.FCount > 0) or VarIsEmpty(FData) then

            aWriter.WriteVariant(Variant(EmptyVar))

          else
            aWriter.WriteVariant(FData);
          SaveBinXml(aWriter);
        end;
      LMD_NODE_TEXT:
        aWriter.WriteVariant(TLMDXmlText(aNode).FData);
      LMD_NODE_CDATA_SECTION:
        aWriter.WriteXmlString(TLMDXmlCDATASection(aNode).FData);
      LMD_NODE_PROCESSING_INSTRUCTION:
        begin
          aWriter.WriteLongint(TLMDXmlProcessingInstruction(aNode).FTargetID);
          aWriter.WriteXmlString(TLMDXmlProcessingInstruction(aNode).FData);
          aNode.SaveBinXml(aWriter);
        end;
      LMD_NODE_COMMENT:
        aWriter.WriteXmlString(TLMDXmlComment(aNode).FData);
    else
      raise Exception.Create(SLMDXmlError5);
    end
  end;
end;

{ TXmlNode }

constructor TLMDXmlNode.Create(aNames: TLMDXmlNameTable);
begin
  inherited Create;
  FNames := aNames;

  FNames._AddRef;

end;

destructor TLMDXmlNode.Destroy;
begin

  if Assigned(FChilds) then
    FChilds._Release;
  FNames._Release;

  inherited;
end;

function TLMDXmlNode.GetChilds: TLMDXmlNodeList;
begin
  if not Assigned(FChilds) then
  begin
    FChilds := TLMDXmlNodeList.Create(Self);

    FChilds._AddRef;

  end;
  Result := FChilds;
end;

procedure TLMDXmlNode.AppendChild(const aChild: ILMDXmlNode);
begin
  GetChilds.Insert(aChild.GetObject as TLMDXmlNode, -1);
end;

function TLMDXmlNode.get_AttrCount: Integer;
begin
  Result := FAttrCount;
end;

function TLMDXmlNode.get_AttrNames(anIndex: Integer): TLMDString;
begin
  Result := FNames.GetName(FAttrs[anIndex].NameID);
end;

function TLMDXmlNode.get_AttrValues(anIndex: Integer): TLMDString;
begin
  Result := GetAttr(get_AttrNameIDs(anIndex));
end;

function TLMDXmlNode.get_AttrNameIDs(anIndex: Integer): Integer;
begin
  Result := FAttrs[anIndex].NameID;
end;

function TLMDXmlNode.get_ChildNodes: ILMDXmlNodeList;
begin
  Result := GetChilds
end;

function TLMDXmlNode.get_NameTable: ILMDXmlNameTable;
begin
  Result := FNames
end;

function TLMDXmlNode.GetAttr(const aName, aDefault: TLMDString): TLMDString;
begin
  Result := GetAttr(FNames.GetID((aName)), aDefault)
end;

function TLMDXmlNode.GetAttr(aNameID: Integer; const aDefault: TLMDString): TLMDString;
var
  aData: PLMDXmlAttrData;
  {$ifdef LMD_UNICODE}
  LWideStr: WideString;
  LOwnerDocument: TLMDXmlDocument;
  Src: AnsiString;
  LBOM: TLMDBOM;
  {$endif}
begin

  aData := FindAttrData(aNameID);
  if Assigned(aData) then

 {$IFDEF LMD_UNICODE}
  begin
    LOwnerDocument := GetOwnerDocument;
    if Assigned(LOwnerDocument) then
      LBOM := LOwnerDocument.FBOM
    else
      LBOM := DefaultBOM;
    if LBOM = bomUTF8 then
    begin
      Src := AnsiString(aData.Value);
      if LMDConvertUTF8toUTF16(Src, LWideStr, strictConversion, False) = conversionOK then
        Result := LWideStr
      else
        Result := aData.Value;
    end
    else
      Result := aData.Value;
  end
  {$ELSE}
    Result := aData.Value
  {$ENDIF}
  else
    Result := aDefault
end;

function TLMDXmlNode.GetBoolAttr(aNameID: Integer;
  aDefault: Boolean): Boolean;
var
  aData: PLMDXmlAttrData;
begin

  aData := FindAttrData(aNameID);
  if Assigned(aData) then

    Result := aData.Value
  else
    Result := aDefault
end;

function TLMDXmlNode.GetBoolAttr(const aName: TLMDString;
  aDefault: Boolean): Boolean;
begin
  Result := GetBoolAttr(FNames.GetID(aName), aDefault)
end;

function TLMDXmlNode.FindFirstChild(aNameID: Integer): TLMDXmlNode;
var
  i: Integer;
begin
  if Assigned(FChilds) then
    for i := 0 to FChilds.FCount - 1 do
    begin
      Result := FChilds.FItems[i];
      if Result.get_NodeNameID = aNameID then
        Exit
    end;
  Result := nil
end;

function TLMDXmlNode.GetChildText(aNameID: Integer; const aDefault: TLMDString): TLMDString;
var
  aChild: TLMDXmlNode;
begin
  aChild := FindFirstChild(aNameID);
  if Assigned(aChild) then
  begin
    Result := aChild.get_Text;
  end
  else
    Result := aDefault
end;

function TLMDXmlNode.GetChildText(const aName: TLMDString;
  const aDefault: TLMDString): TLMDString;
begin
  Result := GetChildText(FNames.GetID(aName), aDefault);
end;

function TLMDXmlNode.GetEnumAttr(const aName: TLMDString;
  const aValues: array of TLMDString; aDefault: Integer): Integer;
begin
  Result := GetEnumAttr(FNames.GetID(aName), aValues, aDefault);
end;

function EnumAttrValue(aNode: TLMDXmlNode; anAttrData: PLMDXmlAttrData;
  const aValues: array of TLMDString): Integer;
var
  anAttrValue: TLMDString;
  s: string;
  i: Integer;
begin
  anAttrValue := anAttrData.Value;
  for Result := 0 to Length(aValues) - 1 do
    if AnsiCompareText(anAttrValue, aValues[Result]) = 0 then
      Exit;
  if Length(aValues) = 0 then
    s := ''
  else
  begin
    s := aValues[0];
    for i := 1 to Length(aValues) - 1 do
      s := s + LMDCRLF + aValues[i];
  end;
  raise Exception.CreateFmt(SLMDXmlError6,
    [aNode.FNames.GetName(anAttrData.NameID), aNode.get_NodeName, s]);
end;

function TLMDXmlNode.GetEnumAttr(aNameID: Integer;
  const aValues: array of TLMDString; aDefault: Integer): Integer;
var
  anAttrData: PLMDXmlAttrData;
begin

  anAttrData := FindAttrData(aNameID);
  if Assigned(anAttrData) then

    Result := EnumAttrValue(Self, anAttrData, aValues)
  else
    Result := aDefault;
end;

function TLMDXmlNode.NeedEnumAttr(const aName: TLMDString;
  const aValues: array of TLMDString): Integer;
begin
  Result := NeedEnumAttr(FNames.GetID(aName), aValues)
end;

function TLMDXmlNode.NeedEnumAttr(aNameID: Integer;
  const aValues: array of TLMDString): Integer;
var
  anAttrData: PLMDXmlAttrData;
begin

  anAttrData := FindAttrData(aNameID);
  if Assigned(anAttrData) then

    Result := EnumAttrValue(Self, anAttrData, aValues)
  else
    raise Exception.CreateFmt(SLMDXmlError7, [FNames.GetName(aNameID)]);
end;

function TLMDXmlNode.GetFloatAttr(const aName: TLMDString;
  aDefault: Double): Double;
begin
  Result := GetFloatAttr(FNames.GetID(aName), aDefault);
end;

function TLMDXmlNode.GetFloatAttr(aNameID: Integer;
  aDefault: Double): Double;
var
  aData: PLMDXmlAttrData;
begin

  aData := FindAttrData(aNameID);
  if Assigned(aData) then

    if VarIsNumeric(aData.Value) then
      Result := aData.Value
    else
      Result := LMDXSTRToFloat(aData.Value)
  else
    Result := aDefault
end;

function TLMDXmlNode.GetHexAttr(aNameID, aDefault: Integer): Integer;
var
  anAttr: PLMDXmlAttrData;
begin

  anAttr := FindAttrData(aNameID);
  if Assigned(anAttr) then

    Result := StrToInt('$' + anAttr.Value)
  else
    Result := aDefault;
end;

function TLMDXmlNode.GetHexAttr(const aName: TLMDString; aDefault: Integer): Integer;
begin
  Result := GetHexAttr(FNames.GetID(aName), aDefault)
end;

function TLMDXmlNode.GetIntAttr(aNameID, aDefault: Integer): Integer;
var
  anAttr: PLMDXmlAttrData;
begin

  anAttr := FindAttrData(aNameID);
  if Assigned(anAttr) then

    Result := anAttr.Value
  else
    Result := aDefault;
end;

function TLMDXmlNode.GetIntAttr(const aName: TLMDString;
  aDefault: Integer): Integer;
begin
  Result := GetIntAttr(FNames.GetID(aName), aDefault)
end;

function TLMDXmlNode.NeedAttr(aNameID: Integer): TLMDString;
var
  anAttr: PLMDXmlAttrData;
begin

  anAttr := FindAttrData(aNameID);
  if not Assigned(anAttr) then

    raise Exception.CreateFmt(SLMDXmlError8, [FNames.GetName(aNameID)]);
  Result := anAttr.Value
end;

function TLMDXmlNode.NeedAttr(const aName: TLMDString): TLMDString;
begin
  Result := NeedAttr(FNames.GetID(aName))
end;

function TLMDXmlNode.GetVarAttr(aNameID: Integer;
  const aDefault: Variant): Variant;
var
  anAttr: PLMDXmlAttrData;
begin

  anAttr := FindAttrData(aNameID);
  if Assigned(anAttr) then

    Result := anAttr.Value
  else
    Result := aDefault;
end;

function TLMDXmlNode.GetVarAttr(const aName: TLMDString;
  const aDefault: Variant): Variant;
begin
  Result := GetVarAttr(FNames.GetID(aName), aDefault)
end;

function TLMDXmlNode.get_NodeName: TLMDString;
begin
  Result := FNames.GetName(get_NodeNameID);
end;

function TLMDXmlNode.GetOwnerDocument: TLMDXmlDocument;
var
  aResult: TLMDXmlNode;
begin
  aResult := Self;
  repeat
    if aResult is TLMDXmlDocument then
      break
    else
      aResult := aResult.FParentNode;
  until not Assigned(aResult);
  Result := TLMDXmlDocument(aResult)
end;

function TLMDXmlNode.get_OwnerDocument: ILMDXmlDocument;
var
  aDoc: TLMDXmlDocument;
begin
  aDoc := GetOwnerDocument;
  if Assigned(aDoc) then
    Result := aDoc
  else
    Result := nil;
end;

function TLMDXmlNode.get_ParentNode: ILMDXmlNode;
begin
  Result := FParentNode
end;

function TLMDXmlNode.get_TypedValue: Variant;
begin
  Result := get_Text
end;

procedure TLMDXmlNode.InsertBefore(const aChild, aBefore: ILMDXmlNode);
var
  i: Integer;
  aChilds: TLMDXmlNodeList;
begin
  aChilds := GetChilds;
  if Assigned(aBefore) then
    i := aChilds.IndexOf(aBefore.GetObject as TLMDXmlNode)
  else
    i := aChilds.FCount;
  GetChilds.Insert(aChild.GetObject as TLMDXmlNode, i)
end;

procedure TLMDXmlNode.RemoveAllAttrs;
begin
  FAttrCount := 0;
end;

procedure TLMDXmlNode.RemoveAllChilds;
begin
  if Assigned(FChilds) then
    FChilds.Clear
end;

procedure TLMDXmlNode.RemoveAttr(const aName: TLMDString);
begin
  RemoveAttr(FNames.GetID(aName));
end;

procedure TLMDXmlNode.RemoveAttr(aNameID: Integer);
var

  a1, a2: PLMDXmlAttrData;

  i: Integer;
begin
  i := 0;

  a1 := @FAttrs[0];
  while (i < FAttrCount) and (a1.NameID <> aNameID) do

  begin
    Inc(a1);
    Inc(i)
  end;
  if i < FAttrCount then
  begin
    a2 := a1;
    Inc(a2);
    while i < FAttrCount - 1 do
    begin

      a1^ := a2^;

      Inc(a1);
      Inc(a2);
      Inc(i)
    end;

    VarClear(a1.Value);

    Dec(FAttrCount);
  end;
end;

procedure TLMDXmlNode.RemoveChild(const aChild: ILMDXmlNode);
begin
  GetChilds.Remove(aChild.GetObject as TLMDXmlNode)
end;

procedure TLMDXmlNode.ReplaceChild(const aNewChild, anOldChild: ILMDXmlNode);
var
  i: Integer;
  aChilds: TLMDXmlNodeList;
begin
  aChilds := GetChilds;
  i := aChilds.IndexOf(anOldChild.GetObject as TLMDXmlNode);
  if i <> -1 then
    aChilds.Replace(i, aNewChild.GetObject as TLMDXmlNode)
end;

function NameCanBeginWith(aChar: TLMDChar): Boolean;
begin
{$IFDEF LMD_UNICODE}
  Result := (aChar = '_') or IsCharAlphaW(aChar)
{$ELSE}
  Result := (aChar = '_') or IsCharAlpha(aChar)
{$ENDIF}
end;

function NameCanContain(aChar: TLMDChar): Boolean;
begin
{$IFDEF LMD_UNICODE}
  Result := (aChar = '_') or (aChar = '-') or (aChar = ':') or (aChar = '.') or
    IsCharAlphaNumericW(aChar)
{$ELSE}
  Result := (aChar in ['_', '-', ':', '.']) or IsCharAlphaNumeric(aChar)
{$ENDIF}
end;

function IsName(const s: TLMDString): Boolean;
var
  i: Integer;
begin
  if s = '' then
    Result := False
  else
    if not NameCanBeginWith(s[1]) then
      Result := False
    else
    begin
      for i := 2 to Length(s) do
        if not NameCanContain(s[i]) then
        begin
          Result := False;
          Exit
        end;
      Result := True;
    end;
end;

{CH const
  ntComment = -2;
  ntNode = -3;
  ntProcessingInstruction = -4;
  ntText = -5; }

type
  TLMDAxis = (axAncestor, axAncestorOrSelf, axAttribute, axChild,
    axDescendant, axDescendantOrSelf, axFollowing, axFollowingSibling,
    axParent, axPreceding, axPrecedingSibling, axSelf);

  TLMDPredicate = class
    function Check(aNode: TLMDXmlNode): Boolean; virtual; abstract;
  end;

  TLMDLocationStep = class
    Next: TLMDLocationStep;
    Axis: TLMDAxis;
    NodeTest: Integer;
    Predicates: TList;
  end;

function TLMDXmlNode.SelectNodes(const anExpression: TLMDString): ILMDXmlNodeList;
var
  aNodes: TLMDXmlNodeList;
  aChilds: TLMDXmlNodeList;
  aChild: TLMDXmlNode;
  aNameID: Integer;
  i: Integer;
  {
    aPath: TXmlPath;
  }
begin
  if IsName(anExpression) then
  begin
    aNodes := TLMDXmlNodeList.Create(nil);
    Result := aNodes;
    aChilds := GetChilds;
    aNameID := FNames.GetID(anExpression);
    for i := 0 to aChilds.FCount - 1 do
    begin
      aChild := aChilds.FItems[i];
      if (aChild.get_NodeType = LMD_NODE_ELEMENT) and (aChild.get_NodeNameID = aNameID) then
        aNodes.Insert(aChild, aNodes.FCount);
    end;
  end
  else
  begin
    raise
      Exception.Create(SLMDXmlError9);
    {
        aPath := TXmlPath.Create;
        try
          aPath.Init(anExpression);
          Result := aPath.SelectNodes(Self);
        finally
          aPath.Free
        end
    }
  end;
end;

function TLMDXmlNode.SelectSingleNode(
  const anExpression: TLMDString): ILMDXmlNode;
var
  aChilds: TLMDXmlNodeList;
  aChild: TLMDXmlNode;
  aNameID: Integer;
  i: Integer;
begin
  if IsName(anExpression) then
  begin
    aChilds := GetChilds;
    aNameID := FNames.GetID(anExpression);
    for i := 0 to aChilds.FCount - 1 do
    begin
      aChild := aChilds.FItems[i];
      if (aChild.get_NodeType = LMD_NODE_ELEMENT) and (aChild.get_NodeNameID = aNameID) then
      begin
        Result := aChild;
        Exit
      end
    end;
    Result := nil;
  end
  else
  begin
    raise
      Exception.Create(SLMDXmlError9)
  end
end;

function TLMDXmlNode.FindElement(const anElementName, anAttrName: string; const anAttrValue: Variant): ILMDXmlElement;
var
  aChild: TLMDXmlNode;
  aNameID, anAttrNameID: Integer;
  i: Integer;
  pa: PLMDXmlAttrData;
begin
  if Assigned(FChilds) then
  begin
    aNameID := FNames.GetID(anElementName);
    anAttrNameID := FNames.GetID(anAttrName);

    for i := 0 to FChilds.FCount - 1 do
    begin
      aChild := FChilds.FItems[i];
      if (aChild.get_NodeType = LMD_NODE_ELEMENT) and (aChild.get_NodeNameID = aNameID) then
      begin
        if anAttrNameID = -1 then
        begin
          Result := aChild.AsElement;
          Exit
        end;

        pa := aChild.FindAttrData(anAttrNameID);
        try
          if Assigned(pa) and VarSameValue(pa.Value, anAttrValue) then

          begin
            Result := aChild.AsElement;
            Exit
          end
        except
          // Exception can throw when VarSameValue function failed
        end;
      end
    end;
  end;
  Result := nil;
end;

procedure TLMDXmlNode.set_AttrValues(anIndex: Integer; const aValue: TLMDString);
begin
  SetAttr(get_AttrNameIDs(anIndex), aValue);
end;

procedure TLMDXmlNode.set_TypedValue(const aValue: Variant);
begin
  set_Text(aValue)
end;

procedure TLMDXmlNode.SetAttr(const aName, aValue: TLMDString);
begin
  SetVarAttr(FNames.GetID(aName), aValue)
end;

procedure TLMDXmlNode.SetAttr(aNameID: Integer; const aValue: TLMDString);
begin
  SetVarAttr(aNameID, aValue)
end;

procedure TLMDXmlNode.SetBoolAttr(aNameID: Integer; aValue: Boolean);
begin
  SetVarAttr(aNameID, aValue)
end;

procedure TLMDXmlNode.SetBoolAttr(const aName: TLMDString; aValue: Boolean);
begin
  SetVarAttr(FNames.GetID(aName), aValue)
end;

procedure TLMDXmlNode.SetChildText(const aName: TLMDString;
  const aValue: TLMDString);
begin
  SetChildText(FNames.GetID(aName), aValue)
end;

procedure TLMDXmlNode.SetChildText(aNameID: Integer; const aValue: TLMDString);
var
  aChild: TLMDXmlNode;
  {$ifdef LMD_UNICODE}
  LOwnerDocument: TLMDXmlDocument;
  LAnsiStr: AnsiString;
  LBOM: TLMDBOM;
  {$endif}
begin
  aChild := FindFirstChild(aNameID);
  if not Assigned(aChild) then
  begin
    aChild := TLMDXmlElement.Create(FNames, aNameID);
    with GetChilds do
      Insert(aChild, FCount);
  end;
  {$ifdef LMD_UNICODE}
  LOwnerDocument := GetOwnerDocument;
  if Assigned(LOwnerDocument) then
    LBOM := LOwnerDocument.FBOM
  else
    LBOM := DefaultBOM;
  if LBOM = bomUTF8 then
  begin
    if LMDConvertUTF16toUTF8(aValue, LAnsiStr, strictConversion, False) = conversionOK then
      aChild.set_Text(WideString(LAnsiStr))
    else
      aChild.set_Text(aValue);
  end
  else
  {$endif}
    aChild.set_Text(aValue);
end;

procedure TLMDXmlNode.SetFloatAttr(aNameID: Integer; aValue: Double);
begin
  SetVarAttr(aNameID, aValue)
end;

procedure TLMDXmlNode.SetFloatAttr(const aName: TLMDString; aValue: Double);
begin
  SetVarAttr(FNames.GetID(aName), aValue);
end;

procedure TLMDXmlNode.SetHexAttr(const aName: TLMDString; aValue,
  aDigits: Integer);
begin
  SetVarAttr(FNames.GetID(aName), IntToHex(aValue, aDigits))
end;

procedure TLMDXmlNode.SetHexAttr(aNameID, aValue, aDigits: Integer);
begin
  SetVarAttr(aNameID, IntToHex(aValue, aDigits))
end;

procedure TLMDXmlNode.SetIntAttr(aNameID, aValue: Integer);
begin
  SetVarAttr(aNameID, aValue)
end;

procedure TLMDXmlNode.SetIntAttr(const aName: TLMDString; aValue: Integer);
begin
  SetVarAttr(FNames.GetID(aName), aValue)
end;

function TLMDXmlNode.GetInt64Attr(aNameID: integer; aDefault: Int64): Int64;
var
  anAttr: PLMDXmlAttrData;
begin
  anAttr := FindAttrData(aNameID);
  if Assigned(anAttr) then
  Result := anAttr.Value
  else
    Result := aDefault;
end;

function TLMDXmlNode.GetInt64Attr(const aName: TLMDString; aDefault: Int64): Int64;
begin
  Result := GetInt64Attr(FNames.GetID(aName), aDefault)
end;

procedure TLMDXmlNode.SetInt64Attr(aNameID: integer; aValue: Int64);
begin
  SetVarAttr(aNameID, aValue)
end;

procedure TLMDXmlNode.SetInt64Attr(const aName: TLMDString; aValue: Int64);
begin
  SetVarAttr(FNames.GetID(aName), aValue)
end;

procedure TLMDXmlNode.SetVarAttr(const aName: TLMDString; aValue: Variant);
begin
  SetVarAttr(FNames.GetID(aName), aValue)
end;

procedure TLMDXmlNode.SetVarAttr(aNameID: Integer; const aValue: Variant);
var
  anAttr: PLMDXmlAttrData;
var
  aDelta: Integer;
begin
  anAttr := FindAttrData(aNameID);
  if not Assigned(anAttr) then

  begin
    if FAttrCount = Length(FAttrs) then
    begin
      if FAttrCount > 64 then
        aDelta := FAttrCount div 4
      else
        if FAttrCount > 8 then
          aDelta := 16
        else
          aDelta := 4;
      SetLength(FAttrs, FAttrCount + aDelta);
    end;

    anAttr := @FAttrs[FAttrCount];

    anAttr.NameID := aNameID;
    anAttr.Value := aValue;
    Inc(FAttrCount);
  end
  else
    anAttr.Value := aValue;
end;

function TLMDXmlNode.FindAttrData(aNameID: Integer): PLMDXmlAttrData;

var
  i: Integer;
begin

  Result := @FAttrs[0];
  for i := 0 to FAttrCount - 1 do
  begin
    if Result.NameID = aNameID then
      exit
    else
      Inc(Result);
  end;
  Result := nil;

end;

function TLMDXmlNode.AsElement: ILMDXmlElement;
begin
  Result := nil
end;

function TLMDXmlNode.AsCDATASection: ILMDXmlCDATASection;
begin
  Result := nil
end;

function TLMDXmlNode.AsComment: ILMDXmlComment;
begin
  Result := nil
end;

function TLMDXmlNode.AsText: ILMDXmlText;
begin
  Result := nil
end;

function TLMDXmlNode.AsProcessingInstruction: ILMDXmlProcessingInstruction;
begin
  Result := nil
end;

function TLMDXmlNode.AppendCDATA(const aData: TLMDString): ILMDXmlCDATASection;
var
  aChild: TLMDXmlCDATASection;
begin
  aChild := TLMDXmlCDATASection.Create(FNames, aData);
  GetChilds.Insert(aChild, -1);
  Result := aChild
end;

function TLMDXmlNode.AppendComment(const aData: TLMDString): ILMDXmlComment;
var
  aChild: TLMDXmlComment;
begin
  aChild := TLMDXmlComment.Create(FNames, aData);
  GetChilds.Insert(aChild, -1);
  Result := aChild
end;

function TLMDXmlNode.AppendElement(const aName: TLMDString): ILMDXmlElement;
var
  aChild: TLMDXmlElement;
begin
  aChild := TLMDXmlElement.Create(FNames, FNames.GetID(aName));
  GetChilds.Insert(aChild, -1);
  Result := aChild
end;

function TLMDXmlNode.AppendElement(aNameID: Integer): ILMDXmlElement;
var
  aChild: TLMDXmlElement;
begin
  aChild := TLMDXmlElement.Create(FNames, aNameID);
  GetChilds.Insert(aChild, -1);
  Result := aChild
end;

function TLMDXmlNode.AppendProcessingInstruction(const aTarget,
  aData: TLMDString): ILMDXmlProcessingInstruction;
var
  aChild: TLMDXmlProcessingInstruction;
begin
  aChild := TLMDXmlProcessingInstruction.Create(FNames, FNames.GetID(aTarget), aData);
  GetChilds.Insert(aChild, -1);
  Result := aChild
end;

function TLMDXmlNode.AppendProcessingInstruction(aTargetID: Integer;
  const aData: TLMDString): ILMDXmlProcessingInstruction;
var
  aChild: TLMDXmlProcessingInstruction;
begin
  aChild := TLMDXmlProcessingInstruction.Create(FNames, aTargetID, aData);
  GetChilds.Insert(aChild, -1);
  Result := aChild
end;

function TLMDXmlNode.AppendText(const aData: TLMDString): ILMDXmlText;
var
  aChild: TLMDXmlText;
begin
  aChild := TLMDXmlText.Create(FNames, aData);
  GetChilds.Insert(aChild, -1);
  Result := aChild
end;

function TLMDXmlNode.GetAttrsXML: TLMDString;
var

  a: PLMDXmlAttrData;

  i: Integer;
begin
  Result := '';
  if FAttrCount > 0 then
  begin

    a := @FAttrs[0];

    for i := 0 to FAttrCount - 1 do
    begin

      Result := Result + ' ' + FNames.GetName(a.NameID) + '="' + LMDTextToXML(LMDVarToXSTR(a.Value)) + '"';

      Inc(a);
    end;
  end;
end;

procedure TLMDXmlNode.LoadBinXml(aReader: TLMDBinXmlReader);
var
  aCount: LongInt;

  a: PLMDXmlAttrData;

  i: Integer;
begin
  // Read attributes
  RemoveAllAttrs;
  aCount := aReader.ReadLongint;
  SetLength(FAttrs, aCount);
  FAttrCount := aCount;

  a := @FAttrs[0];

  for i := 0 to aCount - 1 do
  begin

    a.NameID := aReader.ReadLongint;
    aReader.ReadVariant(a.Value);
    Inc(a);

  end;

  // Read child nodes
  aCount := aReader.ReadLongint;
  if aCount > 0 then
    GetChilds.LoadBinXml(aReader, aCount, FNames);
end;

procedure TLMDXmlNode.SaveBinXml(aWriter: TLMDBinXmlWriter);
var
  aCount: LongInt;

  a: PLMDXmlAttrData;

  i: Integer;
begin
  // Write attributes
  aCount := FAttrCount;
  aWriter.WriteLongint(aCount);

  a := @FAttrs[0];

  for i := 0 to aCount - 1 do
  begin

    aWriter.WriteLongint(a.NameID);
    aWriter.WriteVariant(a.Value);
    Inc(a);

  end;

  // Write child nodes
  if Assigned(FChilds) then
  begin
    aWriter.WriteLongint(FChilds.FCount);
    FChilds.SaveBinXml(aWriter);
  end
  else
    aWriter.WriteLongint(0);
end;

function TLMDXmlNode.get_DataType: Integer;
begin
{$IFDEF LMD_UNICODE}
  Result := varOleStr
{$ELSE}
  Result := varString
{$ENDIF}
end;

function TLMDXmlNode.AttrExists(aNameID: Integer): Boolean;

begin

  Result := FindAttrData(aNameID) <> nil;

end;

function TLMDXmlNode.AttrExists(const aName: TLMDString): Boolean;

begin

  Result := FindAttrData(FNames.GetID(aName)) <> nil;

end;

function TLMDXmlNode.GetAttrType(aNameID: Integer): Integer;
var
  a: PLMDXmlAttrData;
begin

  a := FindAttrData(aNameID);
  if Assigned(a) then

    Result := TVarData(a.Value).VType

  else
{$IFDEF LMD_UNICODE}
    Result := varOleStr
{$ELSE}
    Result := varString
{$ENDIF}
end;

function TLMDXmlNode.GetAttrType(const aName: TLMDString): Integer;
begin
  Result := GetAttrType(FNames.GetID(aName));
end;

function TLMDXmlNode.get_Values(const aName: TLMDString): Variant;
var
  aChild: ILMDXmlNode;
begin
  if aName = '' then
    Result := get_TypedValue
  else
    if aName[1] = '@' then
      Result := GetVarAttr(Copy(aName, 2, Length(aName) - 1), '')
    else
    begin
      aChild := SelectSingleNode(aName);
      if Assigned(aChild) then
        Result := aChild.TypedValue
      else
        Result := ''
    end
end;

procedure TLMDXmlNode.set_Values(const aName: TLMDString; const aValue: Variant);
var
  aChild: ILMDXmlNode;
begin
  if aName = '' then
    set_TypedValue(aValue)
  else
    if aName[1] = '@' then
      SetVarAttr(Copy(aName, 2, Length(aName) - 1), aValue)
    else
    begin
      aChild := SelectSingleNode(aName);
      if not Assigned(aChild) then
        aChild := AppendElement(aName);
      aChild.TypedValue := aValue;
    end
end;

function TLMDXmlNode.GetDateTimeAttr(aNameID: Integer;
  aDefault: TDateTime): TDateTime;
var
  anAttr: PLMDXmlAttrData;
begin

  anAttr := FindAttrData(aNameID);
  if Assigned(anAttr) then

  begin
    if (VarType(anAttr.Value) = varString) or (VarType(anAttr.Value) = varOleStr) {$IFDEF LMDCOMP12}or (VarType(anAttr.Value) = varUString){$ENDIF} then
      Result := LMDXSTRToDateTime(anAttr.Value)
    else
      Result := VarAsType(anAttr.Value, varDate)
  end
  else
    Result := aDefault;
end;

function TLMDXmlNode.GetDateTimeAttr(const aName: TLMDString;
  aDefault: TDateTime): TDateTime;
begin
  Result := GetDateTimeAttr(FNames.GetID(aName), aDefault)
end;

procedure TLMDXmlNode.SetDateTimeAttr(aNameID: Integer; aValue: TDateTime);
begin
  SetVarAttr(aNameID, VarAsType(aValue, varDate))
end;

procedure TLMDXmlNode.SetDateTimeAttr(const aName: TLMDString;
  aValue: TDateTime);
begin
  SetVarAttr(aName, VarAsType(aValue, varDate))
end;

function TLMDXmlNode.EnsureChild(aNameID: Integer): ILMDXmlNode;
var
  aChild: TLMDXmlNode;
begin
  aChild := FindFirstChild(aNameID);
  if Assigned(aChild) then
    Result := aChild
  else
    Result := AppendElement(aNameID)
end;

function TLMDXmlNode.EnsureChild(const aName: TLMDString): ILMDXmlNode;
begin
  Result := EnsureChild(FNames.GetID(aName))
end;

function TLMDXmlNode.NeedChild(aNameID: Integer): ILMDXmlNode;
var
  aChild: TLMDXmlNode;
begin
  aChild := FindFirstChild(aNameID);
  if not Assigned(aChild) then
    raise Exception.CreateFmt(SLMDXmlError10, [FNames.GetName(aNameID)]);
  Result := aChild
end;

function TLMDXmlNode.NeedChild(const aName: TLMDString): ILMDXmlNode;
begin
  Result := NeedChild(FNames.GetID(aName));
end;

procedure TLMDXmlNode.SetNameTable(aValue: TLMDXmlNameTable; aMap: TList);
var
  i: Integer;
  aNewMap: Boolean;
begin
  if aValue <> FNames then
  begin
    aNewMap := not Assigned(aMap);
    if aNewMap then
    begin
      aMap := TList.Create;
      for i := 0 to Length(FNames.FNames) do
        aMap.Add(Pointer(TLMDPtrUInt(aValue.GetID(FNames.FNames[i]))));
    end;
    try
      SetNodeNameID(Integer(aMap[get_NodeNameID]));
      for i := 0 to Length(FAttrs) do
        with FAttrs[i] do

          NameID := Integer(aMap[NameID]);

      if Assigned(FChilds) then
        for i := 0 to FChilds.FCount - 1 do
          FChilds.FItems[i].SetNameTable(aValue, aMap);
    finally
      if aNewMap then
        aMap.Free
    end;
  end;
end;

procedure TLMDXmlNode.SetNodeNameID(aValue: Integer);
begin

end;

function TLMDXmlNode.CloneNode(aDeep: Boolean): ILMDXmlNode;
begin
  Result := DoCloneNode(aDeep)
end;

// <AIH>
function TLMDXmlNode.GetElementsByTagName(const ATagName: WideString): ILMDXmlNodeList;
var
  LUpTagName: WideString;
  LNameID: Integer;
  function GetByTags(ANode: TLMDXmlNode;const ATagName: Integer): TLMDXmlNodeList;
  var
    LCnt, LIter: Integer;
    LChild: TLMDXmlNode;
    LSubList: TLMDXmlNodeList;
  begin
    Result := TLMDXmlNodeList.Create(nil);
    for LIter := 0 to ANode.FChilds.FCount - 1 do
    begin
      LChild := ANode.FChilds.FItems[LIter];
      if (LChild.get_NodeType = LMD_NODE_ELEMENT) and (LChild.get_NodeNameID = LNameID) then
      begin
        Result.Insert(LChild, Result.FCount);
        if Assigned(LChild.FChilds) then
          if LChild.FChilds.FCount > 0 then
          begin
            LSubList := GetByTags(LChild, ATagName);
            for LCnt := 0 to LSubList.FCount - 1 do
              Result.Insert(LSubList.FItems[LCnt], Result.FCount);
            LSubList.Free;
          end;
      end;
    end;
  end;
begin
  LUpTagName := ATagName;
  LNameID := FNames.GetID(LUpTagName);
  Result := GetByTags(Self, LNameID)
end;
// </AIH>

{ TXmlElement }

constructor TLMDXmlElement.Create(aNames: TLMDXmlNameTable; aNameID: Integer);
begin
  inherited Create(aNames);
  FNameID := aNameID;
end;

function TLMDXmlElement.get_NodeNameID: Integer;
begin
  Result := FNameID
end;

function TLMDXmlElement.get_NodeType: Integer;
begin
  Result := LMD_NODE_ELEMENT
end;

function TLMDXmlElement.GetChilds: TLMDXmlNodeList;
begin
  Result := inherited GetChilds;

  if not TVarData(FData).VType in [varEmpty, varNull] then

  begin
    AppendChild(TLMDXmlText.Create(FNames, FData));
    VarClear(FData);
  end;
end;

function TLMDXmlElement.get_Text: TLMDString;
var
  aChilds: TLMDXmlNodeList;
  aChild: TLMDXmlNode;
  aChildText: TLMDString;
  i: Integer;
begin
  Result := '';
  if Assigned(FChilds) and (FChilds.FCount > 0) then
  begin
    aChilds := FChilds;
    for i := 0 to aChilds.FCount - 1 do
    begin
      aChild := aChilds.FItems[i];
      if aChild.get_NodeType in [LMD_NODE_ELEMENT, LMD_NODE_TEXT, LMD_NODE_CDATA_SECTION] then
      begin
        aChildText := aChild.get_Text;
        if aChildText <> '' then
          if Result = '' then
            Result := aChildText
          else
            Result := Result + ' ' + aChildText
      end
    end;
  end
  else
    if VarIsEmpty(FData) then
      Result := ''
    else
      Result := LMDVarToXSTR(FData)
end;

function TLMDXmlElement.GetTextAsBynaryData: TLMDString;
begin
  Result := LMDBase64ToBin(get_Text);
end;

procedure TLMDXmlElement.ReplaceTextByBynaryData(const aData; aSize: Integer; aMaxLineLength: Integer);

begin
  RemoveTextNodes;

  GetChilds.Insert(TLMDXmlText.Create(FNames, LMDBinToBase64(aData, aSize, aMaxLineLength)), -1);

end;

procedure TLMDXmlElement.RemoveTextNodes;
var
  i: Integer;
  aNode: TLMDXmlNode;
begin
  if Assigned(FChilds) then
    for i := FChilds.FCount - 1 downto 0 do
    begin
      aNode := FChilds.FItems[i];
      if aNode.get_NodeType in [LMD_NODE_TEXT, LMD_NODE_CDATA_SECTION] then
        FChilds.Remove(aNode);
    end;
end;

procedure TLMDXmlElement.ReplaceTextByCDATASection(const aText: TLMDString);

  procedure AddCDATASection(const aText: TLMDString);
  var
    i: Integer;
    aChilds: TLMDXmlNodeList;
  begin
    i := Pos(']]>', aText);
    aChilds := GetChilds;
    if i = 0 then
      aChilds.Insert(TLMDXmlCDATASection.Create(FNames, aText), aChilds.FCount)
    else
    begin
      aChilds.Insert(TLMDXmlCDATASection.Create(FNames, Copy(aText, 1, i)), aChilds.FCount);
      AddCDATASection(Copy(aText, i + 1, Length(aText) - i - 1));
    end;
  end;

begin
  RemoveTextNodes;
  AddCDATASection(aText);
end;

procedure TLMDXmlElement.set_Text(const aValue: TLMDString);
begin
  if Assigned(FChilds) then
    FChilds.Clear;
  FData := aValue;
end;

function TLMDXmlElement.AsElement: ILMDXmlElement;
begin
  Result := Self
end;

var
  FGetXMLIntend: Integer = 0;

function GetIndentStr: string;
var
  i: Integer;
begin
  SetLength(Result, FGetXMLIntend * Length(DefaultIndentText));
  for i := 0 to FGetXMLIntend - 1 do
  begin
    Move(DefaultIndentText[1], Result[i * Length(DefaultIndentText) + 1],
         Length(DefaultIndentText) * SizeOf(Char));
  end;
end;

function HasCRLF(const s: string): Boolean;
var
  i: Integer;
begin
  for i := 1 to Length(s) do
    if (s[i] = ^M) or (s[i] = ^J) then
    begin
      Result := True;
      Exit
    end;
  Result := False;
end;

function EndWithCRLF(const s: string): Boolean;
begin
  Result :=
    (Length(s) > 1) and
    (s[Length(s) - 1] = ^M) and
  (s[Length(s)] = ^J);
end;

function TLMDXmlElement.get_XML: TLMDString;
var
  aChildsXML: TLMDString;
  aTag: TLMDString;
  aDoc: TLMDXmlDocument;
  aPreserveWhiteSpace: Boolean;
begin
  aDoc := GetOwnerDocument;
  if Assigned(aDoc) then
    aPreserveWhiteSpace := aDoc.get_PreserveWhiteSpace
  else
    aPreserveWhiteSpace := DefaultPreserveWhiteSpace;
  if aPreserveWhiteSpace then
  begin
    if Assigned(FChilds) and (FChilds.FCount > 0) then
      aChildsXML := FChilds.get_XML
    else
      if VarIsEmpty(FData) then
        aChildsXML := ''
      else
        aChildsXML := LMDTextToXML(LMDVarToXSTR(FData));

    aTag := FNames.GetName(FNameID);
    Result := '<' + aTag + GetAttrsXML;
    if (aChildsXML = '') then
      Result := Result + '/>'
    else
      Result := Result + '>' + aChildsXML + '</' + aTag + '>'
  end
  else
  begin
    if Assigned(FChilds) and (FChilds.FCount > 0) then
    begin
      Inc(FGetXMLIntend);
      try
        aChildsXML := FChilds.get_XML
      finally
        Dec(FGetXMLIntend)
      end
    end
    else
      if VarIsEmpty(FData) then
        aChildsXML := ''
      else
        aChildsXML := LMDTextToXML(LMDVarToXSTR(FData));
    aTag := FNames.GetName(FNameID);
    Result := LMDCRLF + GetIndentStr + '<' + aTag + GetAttrsXML;
    if (aChildsXML = '') then
      Result := Result + '/>'
    else
      if HasCRLF(aChildsXML) then
      begin
        if EndWithCRLF(aChildsXML) then
          Result := Result + '>' + aChildsXML + GetIndentStr + '</' + aTag + '>'
        else
          Result := Result + '>' + aChildsXML + LMDCRLF + GetIndentStr + '</' + aTag + '>'
      end
      else
        Result := Result + '>' + aChildsXML + '</' + aTag + '>';
  end;
end;

function TLMDXmlElement.get_TypedValue: Variant;
begin
  if Assigned(FChilds) and (FChilds.FCount > 0) then
    Result := get_Text
  else
    Result := FData
end;

procedure TLMDXmlElement.set_TypedValue(const aValue: Variant);
begin
  if Assigned(FChilds) then
    FChilds.Clear;
  FData := aValue;
end;

function TLMDXmlElement.get_DataType: Integer;
begin
  if (Assigned(FChilds) and (FChilds.FCount > 0)) or VarIsEmpty(FData) then
{$IFDEF LMD_UNICODE}
    Result := varOleStr
{$ELSE}
    Result := varString
{$ENDIF}
  else

    Result := TVarData(FData).VType;

end;

function TLMDXmlElement.get_ChildNodes: ILMDXmlNodeList;
begin
  Result := inherited get_ChildNodes;
end;

procedure TLMDXmlElement.SetNodeNameID(aValue: Integer);
begin
  FNameID := aValue
end;

function TLMDXmlElement.DoCloneNode(aDeep: Boolean): ILMDXmlNode;
var
  aClone: TLMDXmlElement;
  i: Integer;
begin
  aClone := TLMDXmlElement.Create(FNames, FNameID);
  Result := aClone;
  SetLength(aClone.FAttrs, FAttrCount);
  aClone.FAttrCount := FAttrCount;
  for i := 0 to FAttrCount - 1 do
    aClone.FAttrs[i] := FAttrs[i];
  if aDeep and Assigned(FChilds) and (FChilds.FCount > 0) then
    for i := 0 to FChilds.FCount - 1 do
      aClone.AppendChild(FChilds.FItems[i].CloneNode(True));
end;

{ TLMDCharacterData }

constructor TLMDXmlCharacterData.Create(aNames: TLMDXmlNameTable; const aData: TLMDString);
begin
  inherited Create(aNames);
  FData := aData;
end;

function TLMDXmlCharacterData.get_Text: TLMDString;
var
  aDoc: TLMDXmlDocument;
  aPreserveWhiteSpace: Boolean;
begin
  aDoc := GetOwnerDocument;
  if Assigned(aDoc) then
    aPreserveWhiteSpace := aDoc.get_PreserveWhiteSpace
  else
    aPreserveWhiteSpace := DefaultPreserveWhiteSpace;
  if aPreserveWhiteSpace then
    Result := FData
  else
    Result := Trim(FData);
end;

procedure TLMDXmlCharacterData.set_Text(const aValue: TLMDString);
begin
  FData := aValue
end;

{ TXmlText }

function TLMDXmlText.AsText: ILMDXmlText;
begin
  Result := Self;
end;

constructor TLMDXmlText.Create(aNames: TLMDXmlNameTable; const aData: Variant);
begin
  inherited Create(aNames);
  FData := aData;
end;

function TLMDXmlText.DoCloneNode(aDeep: Boolean): ILMDXmlNode;
begin
  Result := TLMDXmlText.Create(FNames, FData);
end;

function TLMDXmlText.get_DataType: Integer;
begin

  Result := TVarData(FData).VType

end;

function TLMDXmlText.get_NodeNameID: Integer;
begin
  Result := FNames.FXmlTextNameID
end;

function TLMDXmlText.get_NodeType: Integer;
begin
  Result := LMD_NODE_TEXT
end;

function TLMDXmlText.get_Text: TLMDString;
{$ifdef LMD_UNICODE}
var
  LWideStr: WideString;
  LOwnerDocument: TLMDXmlDocument;
  LBOM: TLMDBOM;
{$endif}
begin
  {$ifdef LMD_UNICODE}
  LOwnerDocument := GetOwnerDocument;
  if Assigned(LOwnerDocument) then
    LBOM := LOwnerDocument.FBOM
  else
    LBOM := DefaultBOM;
  if LBOM = bomUTF8 then
  begin
    if LMDConvertUTF8toUTF16(AnsiString(LMDVarToXSTR(FData)), LWideStr, strictConversion, False) = conversionOK then
      Result := LWideStr
    else
      Result := LMDVarToXSTR(FData)
  end
  else
  {$endif}
      Result := LMDVarToXSTR(FData)
end;

function TLMDXmlText.get_TypedValue: Variant;
begin
  Result := FData
end;

function TLMDXmlText.get_XML: TLMDString;
begin
  Result := LMDTextToXML(LMDVarToXSTR(FData));
end;

procedure TLMDXmlText.set_Text(const aValue: TLMDString);
begin
  FData := aValue
end;

procedure TLMDXmlText.set_TypedValue(const aValue: Variant);
begin
  FData := aValue
end;

{ TXmlCDATASection }

function TLMDXmlCDATASection.AsCDATASection: ILMDXmlCDATASection;
begin
  Result := Self
end;

function TLMDXmlCDATASection.DoCloneNode(aDeep: Boolean): ILMDXmlNode;
begin
  Result := TLMDXmlCDATASection.Create(FNames, FData);
end;

function TLMDXmlCDATASection.get_NodeNameID: Integer;
begin
  Result := FNames.FXmlCDATASectionNameID
end;

function TLMDXmlCDATASection.get_NodeType: Integer;
begin
  Result := LMD_NODE_CDATA_SECTION
end;

function GenCDATAXML(const aValue: TLMDString): TLMDString;
var
  i: Integer;
begin
  i := Pos(']]>', aValue);
  if i = 0 then
    Result := '<![CDATA[' + aValue + ']]>'
  else
    Result := '<![CDATA[' + Copy(aValue, 1, i) + ']]>' + GenCDATAXML(Copy(aValue, i + 1, Length(aValue) - i - 1));
end;

function TLMDXmlCDATASection.get_XML: TLMDString;
begin
  Result := GenCDATAXML(FData);
end;

{ TXmlComment }

function TLMDXmlComment.AsComment: ILMDXmlComment;
begin
  Result := Self
end;

function TLMDXmlComment.DoCloneNode(aDeep: Boolean): ILMDXmlNode;
begin
  Result := TLMDXmlComment.Create(FNames, FData);
end;

function TLMDXmlComment.get_NodeNameID: Integer;
begin
  Result := FNames.FXmlCommentNameID
end;

function TLMDXmlComment.get_NodeType: Integer;
begin
  Result := LMD_NODE_COMMENT
end;

function TLMDXmlComment.get_XML: TLMDString;
begin
  Result := '<!--' + FData + '-->'
end;

{ TXmlDocument }

constructor TLMDXmlDocument.Create(aNames: TLMDXmlNameTable);
begin
  inherited Create(aNames);
  FPreserveWhiteSpace := DefaultPreserveWhiteSpace;
  FCaseSensitive := DefaulCaseSensitive;
end;

function TLMDXmlDocument.CreateCDATASection(
  const aData: TLMDString): ILMDXmlCDATASection;
begin
  Result := TLMDXmlCDATASection.Create(FNames, aData)
end;

function TLMDXmlDocument.CreateComment(const aData: TLMDString): ILMDXmlComment;
begin
  Result := TLMDXmlComment.Create(FNames, aData)
end;

function TLMDXmlDocument.CreateElement(aNameID: Integer): ILMDXmlElement;
begin
  Result := TLMDXmlElement.Create(FNames, aNameID)
end;

function TLMDXmlDocument.CreateElement(const aName: TLMDString): ILMDXmlElement;
begin
  Result := TLMDXmlElement.Create(FNames, FNames.GetID(aName));
end;

function TLMDXmlDocument.CreateProcessingInstruction(const aTarget,
  aData: TLMDString): ILMDXmlProcessingInstruction;
begin
  Result := TLMDXmlProcessingInstruction.Create(FNames, FNames.GetID(aTarget), aData)
end;

function TLMDXmlDocument.CreateProcessingInstruction(aTargetID: Integer;
  const aData: TLMDString): ILMDXmlProcessingInstruction;
begin
  Result := TLMDXmlProcessingInstruction.Create(FNames, aTargetID, aData)
end;

function TLMDXmlDocument.CreateText(const aData: TLMDString): ILMDXmlText;
begin
  Result := TLMDXmlText.Create(FNames, aData)
end;

function TLMDXmlDocument.DoCloneNode(aDeep: Boolean): ILMDXmlNode;
var
  aClone: TLMDXmlDocument;
  i: Integer;
begin
  aClone := TLMDXmlDocument.Create(FNames);
  Result := aClone;
  if aDeep and Assigned(FChilds) and (FChilds.FCount > 0) then
    for i := 0 to FChilds.FCount - 1 do
      aClone.AppendChild(FChilds.FItems[i].CloneNode(True));
end;

function TLMDXmlDocument.get_BinaryXML: string;
var
  aWriter: TLMDStrXmlWriter;
begin
  aWriter := TLMDStrXmlWriter.Create(0, $10000);
  try
    FNames.SaveBinXml(aWriter);
    SaveBinXml(aWriter);
    aWriter.FlushBuf;
    Result := aWriter.FData;
  finally
    aWriter.Free
  end
end;

function TLMDXmlDocument.get_DocumentElement: ILMDXmlElement;
var
  aChilds: TLMDXmlNodeList;
  aChild: TLMDXmlNode;
  i: Integer;
begin
  aChilds := GetChilds;
  for i := 0 to aChilds.FCount - 1 do
  begin
    aChild := aChilds.FItems[i];
    if aChild.get_NodeType = LMD_NODE_ELEMENT then
    begin
      Result := aChild.AsElement;
      Exit
    end
  end;
  Result := nil;
end;

function TLMDXmlDocument.get_NodeNameID: Integer;
begin
  Result := FNames.FXmlDocumentNameID
end;

function TLMDXmlDocument.get_NodeType: Integer;
begin
  Result := LMD_NODE_DOCUMENT
end;

function TLMDXmlDocument.get_PreserveWhiteSpace: Boolean;
begin
  Result := FPreserveWhiteSpace;
end;

function TLMDXmlDocument.get_Text: TLMDString;
var
  aChilds: TLMDXmlNodeList;
  aChild: TLMDXmlNode;
  aChildText: TLMDString;
  i: Integer;
begin
  Result := '';
  aChilds := GetChilds;
  for i := 0 to aChilds.FCount - 1 do
  begin
    aChild := aChilds.FItems[i];
    if aChild.get_NodeType in [LMD_NODE_ELEMENT, LMD_NODE_TEXT, LMD_NODE_CDATA_SECTION] then
    begin
      aChildText := aChild.get_Text;
      if aChildText <> '' then
        if Result = '' then
          Result := aChildText
        else
          Result := Result + ' ' + aChildText
    end
  end;
end;

function TLMDXmlDocument.get_XML: TLMDString;
begin
  Result := GetChilds.get_XML
end;

procedure TLMDXmlDocument.Load(aStream: TStream);
var
  aXml: TLMDXmlSource;

  aBinarySign: AnsiString;

  aReader: TLMDBinXmlReader;
begin
  RemoveAllChilds;
  RemoveAllAttrs;
  if aStream.Size > LMDBinXmlSignatureSize then
  begin
    SetLength(aBinarySign, LMDBinXmlSignatureSize);

    aStream.ReadBuffer(aBinarySign[1], LMDBinXmlSignatureSize);

    if String(aBinarySign) = LMDBinXmlSignature then
    begin

      FNames._Release;

      FNames := TLMDXmlNameTable.Create(4096);

      FNames._AddRef;

      aReader := TLMDStmXmlReader.Create(aStream, $10000);
      try
        FNames.LoadBinXml(aReader);
        LoadBinXml(aReader);
      finally
        aReader.Free
      end;
      Exit;
    end;
    aStream.Position := aStream.Position - LMDBinXmlSignatureSize;
  end;
  FBom := LMDReadBOM(aStream);
  case FBom of
  bomNone, bomUTF8:
    aXml := TLMDXmlStmSource.Create(aStream, 1 shl 16, FBOM = bomUTF8);
  bomUTF16LE:
  {$IFDEF LMD_UNICODE}
    aXml := TLMDXmlUnicodeStmSource.Create(aStream, 1 shl 16);
  {$ELSE}
    raise Exception.Create(SLMDXmlError26);
  {$ENDIF}

  else
    raise Exception.Create(SLMDXmlError26);
  end;
  if (FBom = bomNone) then
  begin
    if LowerCase(DefaultEncoding) = 'utf-8' then
      FBOM := bomUTF8;
    if LowerCase(DefaultEncoding) = 'utf-16le' then
      FBOM := bomUTF16LE;
  end;
  try
    GetChilds.ParseXML(aXml, FNames, FPreserveWhiteSpace);
  finally
    aXml.Free
  end
end;

procedure TLMDXmlDocument.Load(const aFileName: TLMDString);
var
  aFile: TLMDFileStream;
begin
  aFile := TLMDFileStream.Create(aFileName, fmOpenRead, fmShareDenyWrite);
  try
    Load(aFile);
  finally
    aFile.Free
  end
end;

procedure TLMDXmlDocument.LoadBinaryXML(const aXML: string);
var
  aReader: TLMDStrXmlReader;
begin
  RemoveAllChilds;
  RemoveAllAttrs;
  aReader := TLMDStrXmlReader.Create(aXML);
  try

    FNames._Release;

    FNames := TLMDXmlNameTable.Create(4096);

    FNames._AddRef;

    FNames.LoadBinXml(aReader);
    LoadBinXml(aReader);
  finally
    aReader.Free
  end
end;

procedure TLMDXmlDocument.LoadResource(aType, aName: PChar);

var
  aRSRC: HRSRC;
  aGlobal: HGLOBAL;
  aSize: DWORD;

  aPointer: Pointer;

  aStream: TStringStream;
begin
  aRSRC := FindResource(HInstance, aName, aType);
  if aRSRC <> 0 then
  begin
    aGlobal := Windows.LoadResource(HInstance, aRSRC);
    aSize := SizeofResource(HInstance, aRSRC);
    if (aGlobal <> 0) and (aSize <> 0) then
    begin
      aPointer := LockResource(aGlobal);
      if Assigned(aPointer) then
      begin
        aStream := TStringStream.Create('');
        try

          aStream.WriteBuffer(aPointer^, aSize);

          LoadXML(aStream.DataString);
        finally
          aStream.Free;
        end;
      end;
    end;
  end;
end;

procedure TLMDXmlDocument.LoadXML(const aXML: TLMDString);
var
  aSource: TLMDXmlStrSource;
begin
  if LMDXmlIsInBinaryFormat(aXML) then
    LoadBinaryXML(aXML)
  else
  begin
    RemoveAllChilds;
    RemoveAllAttrs;
    aSource := TLMDXmlStrSource.Create(aXML);
    try
      GetChilds.ParseXML(aSource, FNames, FPreserveWhiteSpace);
      if (FBom = bomNone) then
      begin
        if LowerCase(DefaultEncoding) = 'utf-8' then
          FBOM := bomUTF8;
        if LowerCase(DefaultEncoding) = 'utf-16le' then
          FBOM := bomUTF16LE;
      end;
    finally
      aSource.Free
    end
  end
end;

function TLMDXmlDocument.NewDocument(const aVersion, anEncoding,
  aRootElementName: TLMDString): ILMDXmlElement;
begin
  Result := NewDocument(aVersion, anEncoding, FNames.GetID(aRootElementName));
end;

function TLMDXmlDocument.NewDocument(const aVersion, anEncoding: TLMDString;
  aRootElementNameID: Integer): ILMDXmlElement;
var
  aChilds: TLMDXmlNodeList;
  aRoot: TLMDXmlElement;
  e: string;
begin
  aChilds := GetChilds;
  aChilds.Clear;
  if anEncoding = '' then
    e := DefaultEncoding
  else
    e := anEncoding;

  if LMDUpperCase(e) = 'UTF-8' then
    FBOM := bomUTF8;

  if (LMDUpperCase(e) = 'UTF-16') or (LMDUpperCase(e) = 'UTF-16LE') then
    FBOM := bomUTF16LE;

  aChilds.Insert(TLMDXmlProcessingInstruction.Create(FNames, FNames.FXmlID,
    'version="' + aVersion + '" encoding="' + e + '"'), 0);
  aRoot := TLMDXmlElement.Create(FNames, aRootElementNameID);
  aChilds.Insert(aRoot, 1);
  Result := aRoot;
end;

procedure TLMDXmlDocument.Save(aStream: TStream);
var
  LXml: TLMDString;
  {$ifdef LMD_UNICODE}
  LString: AnsiString;
  {$endif}
begin
  LXml := get_XML;
  {$ifdef LMD_UNICODE}
  LMDWriteBOM(aStream, FBOM);
  case FBOM of
  bomUTF8:
    begin
      LMDConvertUTF16toUTF8(LXml, LString, strictConversion, False);
      aStream.WriteBuffer(LString[1], sizeof(AnsiChar) * Length(LString));
    end;
  bomNone:
    begin
      LString := AnsiString(LXml);
      aStream.WriteBuffer(LString[1], sizeof(AnsiChar) * Length(LString));
    end;
  bomUTF16LE:
    begin
      aStream.WriteBuffer(LXml[1], sizeof(TLMDChar) * Length(LXml));
    end;
  else
    raise Exception.Create(SLMDXmlError26);
  end;
  {$else}
  aStream.WriteBuffer(LXml[1], sizeof(TLMDChar) * Length(LXml));
  {$endif}
end;

procedure TLMDXmlDocument.Save(const aFileName: TLMDString);
var
  aFile: TLMDFileStream;
begin
  aFile := TLMDFileStream.Create(aFileName, fmCreate, fmShareDenyWrite);
  try
    Save(aFile);
  finally
    aFile.Free
  end
end;

procedure TLMDXmlDocument.SaveBinary(aStream: TStream; anOptions: LongWord);
var
  aWriter: TLMDBinXmlWriter;
begin
  aWriter := TLMDStmXmlWriter.Create(aStream, anOptions, 65536);
  try
    FNames.SaveBinXml(aWriter);
    SaveBinXml(aWriter);
  finally
    aWriter.Free
  end
end;

procedure TLMDXmlDocument.SaveBinary(const aFileName: TLMDString; anOptions: LongWord);
var
  aFile: TLMDFileStream;
begin
  aFile := TLMDFileStream.Create(aFileName, fmCreate, fmShareDenyWrite);
  try
    SaveBinary(aFile, anOptions);
  finally
    aFile.Free
  end
end;

procedure TLMDXmlDocument.set_PreserveWhiteSpace(aValue: Boolean);
begin
  FPreserveWhiteSpace := aValue;
end;

function TLMDXmlDocument.get_CaseSensitive: Boolean;
begin
  Result := FCaseSensitive;
end;

procedure TLMDXmlDocument.set_CaseSensitive(const AValue: Boolean);
begin
  if AValue <> FCaseSensitive then
  begin
    FCaseSensitive := AValue;
    FNames.CaseSensitive := FCaseSensitive;
  end;
end;

procedure TLMDXmlDocument.set_Text(const aText: TLMDString);
var
  aChilds: TLMDXmlNodeList;
begin
  aChilds := GetChilds;
  aChilds.Clear;
  aChilds.Insert(TLMDXmlText.Create(FNames, aText), 0);
end;

{ TXmlProcessingInstruction }

function TLMDXmlProcessingInstruction.AsProcessingInstruction: ILMDXmlProcessingInstruction;
begin
  Result := Self
end;

constructor TLMDXmlProcessingInstruction.Create(aNames: TLMDXmlNameTable;
  aTargetID: Integer; const aData: TLMDString);
begin
  inherited Create(aNames);
  FTargetID := aTargetID;
  FData := aData;
end;

function TLMDXmlProcessingInstruction.DoCloneNode(aDeep: Boolean): ILMDXmlNode;
begin
  Result := TLMDXmlProcessingInstruction.Create(FNames, FTargetID, FData);
end;

function TLMDXmlProcessingInstruction.get_NodeNameID: Integer;
begin
  Result := FTargetID
end;

function TLMDXmlProcessingInstruction.get_NodeType: Integer;
begin
  Result := LMD_NODE_PROCESSING_INSTRUCTION
end;

function TLMDXmlProcessingInstruction.get_Text: TLMDString;
begin
  Result := FData;
end;

function TLMDXmlProcessingInstruction.get_XML: TLMDString;
begin
  if FData = '' then
    Result := '<?' + FNames.GetName(FTargetID) + GetAttrsXML + '?>'
  else
    Result := '<?' + FNames.GetName(FTargetID) + ' ' + FData + '?>'
end;

procedure TLMDXmlProcessingInstruction.SetNodeNameID(aValue: Integer);
begin
  FTargetID := aValue
end;

procedure TLMDXmlProcessingInstruction.set_Text(const aText: TLMDString);
begin
  FData := aText
end;

{ TXmlStrSource }

constructor TLMDXmlStrSource.Create(const aSource: TLMDString);
begin
  inherited Create;
  FSource := aSource;

  FSourcePtr := PLMDChar(FSource);
  FSourceEnd := FSourcePtr + Length(FSource);

  if FSourcePtr = FSourceEnd then
    CurChar := #0
  else

    CurChar := FSourcePtr^;

end;

function TLMDXmlStrSource.EOF: Boolean;
begin
  Result := FSourcePtr = FSourceEnd
end;

function TLMDXmlStrSource.Next: Boolean;
begin
  if FSourcePtr < FSourceEnd then
    Inc(FSourcePtr);
  if FSourcePtr = FSourceEnd then
  begin
    Result := False;
    CurChar := #0;
  end
  else
  begin
    Result := True;

    CurChar := FSourcePtr^;

  end;
end;

{ TXmlSource }

procedure TLMDXmlSource.NewToken;
begin
  Inc(FTokenStackTop);
  if FTokenStackTop < Length(FTokenStack) then
  begin
    FToken := FTokenStack[FTokenStackTop];
    FToken.Clear
  end
  else
  begin
    SetLength(FTokenStack, FTokenStackTop + 1);
    FToken := TLMDXmlToken.Create;
    FTokenStack[FTokenStackTop] := FToken;
  end
end;

function TLMDXmlSource.AcceptToken: TLMDString;
begin

  SetLength(Result, FToken.FValuePtr - FToken.ValueStart);
  if Length(Result) > 0 then
    Move(FToken.ValueStart^, Result[1], Length(Result) * sizeof(TLMDChar));

  DropToken;
end;

procedure TLMDXmlSource.SkipBlanks;
begin
  while not EOF and (CurChar <= ' ') do
    Next;
end;

// Input - First symbol of name
// Output - First symbol that illegal for name

function TLMDXmlSource.ExpectXmlName: TLMDString;
begin
  if not NameCanBeginWith(CurChar) then
    raise Exception.Create(SLMDXmlError11);
  NewToken;
  AppendTokenChar(CurChar);
  while Next and NameCanContain(CurChar) do
    AppendTokenChar(CurChar);
  Result := AcceptToken;
end;

// Input - first symbol of number
// Output - First symbol that illegal for number

function TLMDXmlSource.ExpectDecimalInteger: Integer;
var
  s: TLMDString;
  e: Integer;
begin
  NewToken;
  while (CurChar >= '0') and (CurChar <= '9') do
  begin
    AppendTokenChar(CurChar);
    Next;
  end;
  s := AcceptToken;
  if Length(s) = 0 then
    raise Exception.Create(SLMDXmlError12);
  Val(s, Result, e);
  if e <> 0 then
    raise Exception.Create(SLMDXmlError12);
end;

// Input - first symbol of number
// Output - first symbol whech isn't correct for hexadecimal numbers

function TLMDXmlSource.ExpectHexInteger: Integer;
var
  s: TLMDString;
  e: Integer;
begin
  NewToken;
{$IFDEF LMD_UNICODE}
  while (CurChar >= '0') and (CurChar <= '9') or
    (CurChar >= 'A') and (CurChar <= 'F') or
    (CurChar >= 'a') and (CurChar <= 'f') do
  begin
{$ELSE}
  while CurChar in ['0'..'9', 'A'..'F', 'a'..'f'] do
  begin
{$ENDIF}
    AppendTokenChar(CurChar);
    Next;
  end;
  s := '$';
  s := s + AcceptToken;
  if Length(s) = 1 then
    raise Exception.Create(SLMDXmlError13);
  Val(s, Result, e);
  if e <> 0 then
    raise Exception.Create(SLMDXmlError13);
end;

// Input: "&"
// Output: symbol after ";"

function TLMDXmlSource.ExpectXmlEntity: TLMDChar;
var
  s: TLMDString;
begin
  if not Next then
    raise Exception.Create(SLMDXmlError14);
  if CurChar = '#' then
  begin
    if not Next then
      raise Exception.Create(SLMDXmlError12);
    if CurChar = 'x' then
    begin
      Next;
      Result := TLMDChar(ExpectHexInteger);
    end
    else
      Result := TLMDChar(ExpectDecimalInteger);
    ExpectChar(';');
  end
  else
  begin
    s := ExpectXmlName;
    ExpectChar(';');
    if s = 'amp' then
      Result := '&'
    else
      if s = 'quot' then
        Result := '"'
      else
        if s = 'lt' then
          Result := '<'
        else
          if s = 'gt' then
            Result := '>'
          else
            if s = 'apos' then
              Result := ''''
            else
              raise Exception.Create(SLMDXmlError15);
  end
end;

procedure TLMDXmlSource.ExpectChar(aChar: TLMDChar);
begin
  if EOF or (CurChar <> aChar) then
    raise Exception.CreateFmt(SLMDXmlError16, [aChar]);
  Next;
end;

procedure TLMDXmlSource.ExpectText(aText: PLMDChar);

begin

  while aText^ <> #0 do

  begin

    if (LMDUpperCaseChar(CurChar) <> LMDUpperCaseChar(aText^)) or EOF then

      raise Exception.CreateFmt(SLMDXmlError17, [aText]);

    Inc(aText);

    Next;
  end;
end;

// Input: open quote
// Output: symbole which follow of close quote

function TLMDXmlSource.ExpectQuotedText(aQuote: TLMDChar): TLMDString;
begin
  NewToken;
  Next;
  while not EOF and (CurChar <> aQuote) do
  begin
    if CurChar = '&' then
      AppendTokenChar(ExpectXmlEntity)
    else
      if CurChar = '<' then
        raise Exception.Create(SLMDXmlError18)
      else
      begin
        AppendTokenChar(CurChar);
        Next;
      end
  end;
  if EOF then
    raise Exception.CreateFmt(SLMDXmlError19, [aQuote]);
  Next;
  Result := AcceptToken;
end;

procedure TLMDXmlSource.ParseAttrs(aNode: TLMDXmlNode);
var
  aName: TLMDString;
  aValue: TLMDString;
begin
  SkipBlanks;
  while not EOF and NameCanBeginWith(CurChar) do
  begin
    aName := ExpectXmlName;
    SkipBlanks;
    ExpectChar('=');
    SkipBlanks;
    if EOF then
      raise Exception.Create(SLMDXmlError20);
    if (CurChar = '''') or (CurChar = '"') then
      aValue := ExpectQuotedText(CurChar)
    else
      raise Exception.Create(SLMDXmlError21);
    aNode.SetAttr(aName, aValue);
    SkipBlanks;
  end;
end;

function StrEquals(p1, p2: PLMDChar; aLen: Integer): Boolean;
begin

{$IFDEF LMD_UNICODE}
  while aLen > 0 do
  begin
    if p1^ <> p2^ then
    begin
      Result := False;
      Exit
    end
    else
      if (p1^ = #0) or (p2^ = #0) then
      begin
        Result := p1^ = p2^;
        Exit
      end
      else
      begin
        Inc(p1);
        Inc(p2);
        Dec(aLen);
      end;
  end;
  Result := True;
{$ELSE}
  Result := StrLComp(p1, p2, aLen) = 0
{$ENDIF}

end;

// Input: first symbol of text
// Output: Symbol which follow the last symbol of delimiter

function TLMDXmlSource.ParseTo(aText: PLMDChar): TLMDString;

  function LMDSameStrEquals(const AStr: PLMDChar; AFrom1, AFrom2: Integer; ALen: Integer): boolean;
  var
    i: integer;
  begin
    Result := True;
    for i := 0 to ALen - 1 do
    begin
      if AStr[AFrom1 + i] <> AStr[AFrom2 + i] then
      begin
        Result := False;
        exit;
      end;
    end;
  end;

var

  aCheck: PLMDChar;
  p: PLMDChar;

begin

  NewToken;
  aCheck := aText;
  while not EOF do
  begin
    if CurChar = aCheck^ then
    begin
      Inc(aCheck);
      Next;
      if aCheck^ = #0 then
      begin
        Result := AcceptToken;
        Exit;
      end;
    end
    else
      if aCheck = aText then
      begin
        AppendTokenChar(CurChar);
        Next;
      end
      else
      begin
        p := aText + 1;
        while (p < aCheck) and not StrEquals(p, aText, aCheck - p) do
          Inc(p);
        AppendTokenText(aText, p - aText);
        if p < aCheck then
          aCheck := p
        else
          aCheck := aText;
      end;
  end;
  raise Exception.CreateFmt(SLMDXmlError22, [aText]);

end;

procedure TLMDXmlSource.AppendTokenChar(aChar: TLMDChar);
begin
  FToken.AppendChar(aChar);
end;

procedure TLMDXmlSource.AppendTokenText(aText: PLMDChar; aCount: Integer);
begin
  FToken.AppendText(aText, aCount)
end;

procedure TLMDXmlSource.DropToken;
begin
  Dec(FTokenStackTop);
  if FTokenStackTop >= 0 then
    FToken := FTokenStack[FTokenStackTop]
  else
    FToken := nil
end;

constructor TLMDXmlSource.Create;
begin
  inherited Create;
  FTokenStackTop := -1;
end;

destructor TLMDXmlSource.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(FTokenStack) - 1 do
    FTokenStack[i].Free;
  inherited;
end;

{ TXmlToken }

procedure TLMDXmlToken.AppendChar(aChar: TLMDChar);
var
  aSaveLength: Integer;
begin
  if FValuePtr >= FValueEnd then
  begin
    aSaveLength := FValuePtr - FValueStart;
    SetLength(FValueBuf, ((aSaveLength * 3) div 2) + 1);

    FValueStart := PLMDChar(FValueBuf);

    FValuePtr := FValueStart + aSaveLength;

    FValueEnd := FValueStart + System.Length(FValueBuf);

  end;

  FValuePtr^ := aChar;

  Inc(FValuePtr);
end;

procedure TLMDXmlToken.AppendText(aText: PLMDChar; aCount: Integer);
var
  aSaveLength: Integer;
begin
  // TODO: Check this!
  if (FValuePtr + aCount) > FValueEnd then
  begin
    aSaveLength := FValuePtr - FValueStart;
    SetLength(FValueBuf, (((aSaveLength + aCount) * 3) div 2) + 1);

    FValueStart := PLMDChar(FValueBuf);

    FValuePtr := FValueStart + aSaveLength;

    FValueEnd := FValueStart + System.Length(FValueBuf);

  end;

  Move(aText^, FValuePtr^, aCount * sizeof(TLMDChar));

  Inc(FValuePtr, aCount);
end;

procedure TLMDXmlToken.Clear;
begin
  FValuePtr := FValueStart;
end;

constructor TLMDXmlToken.Create;
begin
  inherited Create;
  SetLength(FValueBuf, 32);

  FValueStart := PLMDChar(FValueBuf);

  FValuePtr := FValueStart;
  FValueEnd := FValueStart + 32;
end;

function TLMDXmlToken.Length: Integer;
begin
  Result := FValuePtr - FValueStart;
end;

{ TXmlStmSource }

constructor TLMDXmlStmSource.Create(aStream: TStream; aBufSize: Integer; aIsUtf8: Boolean = False);
var
  LAnsiStr: AnsiString;
  aSize: Integer;
  {$ifdef LMD_UNICODE}
  LTrail: Integer;
  {$endif}
begin
  inherited Create;
  FStream := aStream;
  FBufSize := aBufSize;
  FIsUtf8 := aIsUtf8;
  SetLength(FBuffer, aBufSize);
  FBufPtr := 1;
  FBufEnd := 1;
  FSize := (aStream.Size - aStream.Position);
  if FSize = 0 then
    CurChar := #0
  else
  begin
    if FSize < FBufSize then
      aSize := FSize
    else
      aSize := FBufSize;

    FStream.ReadBuffer(FBuffer[0], aSize);
    {$ifdef LMD_UNICODE}
    if FIsUtf8 then
    begin
      // Code to read legal utf8 sequence
      LTrail := aSize;
      while LMDGetTrailingBytesUTF8(FBuffer[aSize - 1]) > 0 do
        dec(aSize);
      FStream.Seek(-(LTrail - aSize), soFromCurrent);
    end;
    {$endif}

    FBufEnd := aSize + 1;
    Dec(FSize, aSize);

    SetLength(LAnsiStr, aSize);
    Move(FBuffer[0], LAnsiStr[1], aSize);

    {$ifdef LMD_UNICODE}
    if FIsUtf8 then
    begin
//      if LMDConvertUTF8ToUTF16(LAnsiStr, LWideStr, strictConversion, False) = sourceIllegal then
        FBufStart := WideString(LAnsiStr);
//      else
//        FBufStart := LWideStr;
//      FBufStart := LMDConvertUTF8String(LAnsiStr);
      FBufEnd := Length(FBufStart) + 1;
    end
    else
    {$endif}
      FBufStart := WideString(LAnsiStr);
    CurChar := FBufStart[FBufPtr];
  end
end;

destructor TLMDXmlStmSource.Destroy;
begin
  SetLength(FBuffer, 0);
  inherited;
end;

function TLMDXmlStmSource.EOF: Boolean;
begin
  Result := (FBufPtr = FBufEnd) and (FSize = 0)
end;

function TLMDXmlStmSource.Next: Boolean;
var
  LAnsiStr: AnsiString;
  aSize: Integer;
  {$ifdef LMD_UNICODE}
  LTrail: Integer;
  {$endif}
begin
  if FBufPtr < FBufEnd then
    Inc(FBufPtr);
  if FBufPtr = FBufEnd then
    if FSize = 0 then
    begin
      Result := False;
      CurChar := #0;
    end
    else
    begin
      if FSize < FBufSize then
        aSize := FSize
      else
        aSize := FBufSize;

      FStream.ReadBuffer(FBuffer[0], aSize);
      {$ifdef LMD_UNICODE}
      if FIsUtf8 then
      begin
        // Code to read legal utf8 sequence
        LTrail := aSize;
        while LMDGetTrailingBytesUTF8(FBuffer[aSize - 1]) > 0 do
          dec(aSize);
        FStream.Seek(-(LTrail - aSize), soFromCurrent);
      end;
      {$endif}

      FBufEnd := aSize + 1;
      FBufPtr := 1;

      Dec(FSize, aSize);
      SetLength(LAnsiStr, aSize);
      Move(FBuffer[0], LAnsiStr[1], aSize);

      // TODO Alex: Check in delphi 2009
      {$ifdef LMD_UNICODE}
      if FIsUtf8 then
      begin
        FBufStart := LMDConvertUTF8String(LAnsiStr);
        FBufEnd := Length(FBufStart) + 1;
      end
      else
      {$endif}
        FBufStart := PChar(String(LAnsiStr));
      Result := True;
      CurChar := FBufStart[FBufPtr];
    end
  else
  begin
    Result := True;
    CurChar := FBufStart[FBufPtr];
  end;
end;

{$ifdef LMD_UNICODE}
{ TLMDXmlUnicodeStmSource }
{ ---------------------------------------------------------------------------- }
constructor TLMDXmlUnicodeStmSource.Create(aStream: TStream; aBufSize: Integer);
var
  aSize: Integer;
begin
  inherited Create;
  FStream := aStream;
  FBufSize := aBufSize;
  if (FBufSize mod 2) <> 0 then
    dec(FBufSize);
  SetLength(FBuffer, aBufSize);
  FBufPtr := 1;
  FBufEnd := 1;
  FSize := (aStream.Size - aStream.Position);
  if FSize = 0 then
    CurChar := #0
  else
  begin
    if FSize < FBufSize then
      aSize := FSize
    else
      aSize := FBufSize;

    FStream.ReadBuffer(FBuffer[0], aSize);
    Dec(FSize, aSize);

    SetLength(FBufStart, aSize div SizeOf(TLMDChar));
    Move(FBuffer[0], FBufStart[1], aSize);
    FBufEnd := Length(FBufStart) + 1;

    CurChar := FBufStart[FBufPtr];
  end
end;

destructor TLMDXmlUnicodeStmSource.Destroy;
begin
  SetLength(FBuffer, 0);
  inherited;
end;

function TLMDXmlUnicodeStmSource.EOF: Boolean;
begin
  Result := (FBufPtr = FBufEnd) and (FSize = 0)
end;

function TLMDXmlUnicodeStmSource.Next: Boolean;
var
  aSize: Integer;
begin
  if FBufPtr < FBufEnd then
    Inc(FBufPtr);
  if FBufPtr = FBufEnd then
    if FSize = 0 then
    begin
      Result := False;
      CurChar := #0;
    end
    else
    begin
      if FSize < FBufSize then
        aSize := FSize
      else
        aSize := FBufSize;

      FStream.ReadBuffer(FBuffer[0], aSize);
      FBufPtr := 1;

      Dec(FSize, aSize);
      SetLength(FBufStart, aSize div SizeOf(TLMDChar));
      Move(FBuffer[0], FBufStart[1], aSize);
      FBufEnd := Length(FBufStart) + 1;

      Result := True;
      CurChar := FBufStart[FBufPtr];
    end
  else
  begin
    Result := True;
    CurChar := FBufStart[FBufPtr];
  end;
end;
{$ENDIF}

{ TStmXmlReader }

{ ---------------------------------------------------------------------------- }
constructor TLMDStmXmlReader.Create(aStream: TStream; aBufSize: Integer);
begin
  inherited Create;
  FStream := aStream;

  FRestSize := aStream.Size - aStream.Position;
  FBufSize := aBufSize;
  FBufStart := AllocMem(aBufSize);
  FBufEnd := FBufStart;
  FBufPtr := FBufEnd;
  Read(FOptions, sizeof(FOptions));

end;

{ ---------------------------------------------------------------------------- }
destructor TLMDStmXmlReader.Destroy;
begin

  FreeMem(FBufStart);

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStmXmlReader.Read(var aBuf; aSize: Integer);
var
  aBufRest: Integer;
  aDst: PChar;
  aBufSize: Integer;
begin
  if aSize > FRestSize then
    raise Exception.Create(SLMDXmlError23);

  aBufRest := FBufEnd - FBufPtr;
  if aSize <= aBufRest then
  begin
    Move(FBufPtr^, aBuf, aSize);
    Inc(FBufPtr, aSize);
    Dec(FRestSize, aSize);
  end
  else
  begin
    aDst := @aBuf;
    Move(FBufPtr^, aDst^, aBufRest);
    Inc(aDst, aBufRest);
    FStream.ReadBuffer(aDst^, aSize - aBufRest);
    Dec(FRestSize, aSize);

    if FRestSize < FBufSize then
      aBufSize := FRestSize
    else
      aBufSize := FBufSize;
    FBufPtr := FBufStart;
    FBufEnd := FBufStart + aBufSize;
    if aBufSize > 0 then
      FStream.ReadBuffer(FBufStart^, aBufSize);
  end;
end;

{ TStrXmlReader }

constructor TLMDStrXmlReader.Create(const aStr: string);
var

  aSig: array[1..LMDBinXmlSignatureSize] of Char;

begin
  inherited Create;
  FString := aStr;

  FRestSize := Length(aStr);
  FPtr := PChar(FString);
  Read(aSig, LMDBinXmlSignatureSize);
  Read(FOptions, sizeof(FOptions));

end;

procedure TLMDStrXmlReader.Read(var aBuf; aSize: Integer);
begin
  if aSize > FRestSize then
    raise Exception.Create(SLMDXmlError23);
  Move(FPtr^, aBuf, aSize);
  Inc(FPtr, aSize);
  Dec(FRestSize, aSize);
end;

{ TBinXmlReader }

function TLMDBinXmlReader.ReadAnsiString: string;

var
  aLength: LongInt;

begin
  aLength := ReadLongint;
  if aLength = 0 then
    Result := ''
  else
  begin
    SetLength(Result, aLength);

    Read(Result[1], aLength);

  end
end;

function TLMDBinXmlReader.ReadLongint: Longint;

var
  b: Byte;

begin

  Result := 0;
  Read(Result, 1);
  if Result >= $80 then
    if Result = $FF then
      Read(Result, sizeof(Result))
    else
    begin
      Read(b, 1);
      Result := (Result and $7F) shl 8 or b;
    end

end;

procedure TLMDBinXmlReader.ReadVariant(var AVar: Variant);
var
  aDataType: Word;
  aSize: Longint;

  v: TVarData;
  p: Pointer;

begin

  v := TVarData(AVar);
  VarClear(Variant(v));

  aDataType := ReadLongint;
  case aDataType of
    varEmpty: ;
    varNull: ;
    varSmallint:

      Read(v.VSmallint, sizeof(SmallInt));

    varInteger:

      Read(v.VInteger, sizeof(Integer));

    varSingle:

      Read(v.VSingle, sizeof(Single));

    varDouble:

      Read(v.VDouble, sizeof(Double));

    varCurrency:

      Read(v.VCurrency, sizeof(Currency));

    varDate:

      Read(v.VDate, sizeof(TDateTime));

    varOleStr:
      Variant(v) := ReadWideString;

    varBoolean:

      Read(v.VBoolean, sizeof(WordBool));

    varByte:

      Read(v.VByte, sizeof(Byte));

    varShortInt:

      Read(v.VShortInt, sizeof(ShortInt));

    varWord:

      Read(v.VWord, sizeof(Word));

    varLongWord:

      Read(v.VLongWord, sizeof(LongWord));

    varInt64:

      Read(v.VInt64, sizeof(Int64));

    varString:

      Variant(v) := ReadAnsiString;

    varArray + varByte:
      begin
        aSize := ReadLongint;

        Variant(v) := VarArrayCreate([0, aSize - 1], varByte);
        p := VarArrayLock(Variant(v));
        try
          Read(p^, aSize);
        finally
          VarArrayUnlock(Variant(v))
        end

      end;
  else
    raise Exception.Create(SLMDXmlError24);
  end;

  v.VType := aDataType;
  AVar := Variant(v);

end;

function TLMDBinXmlReader.ReadWideString: WideString;
var
  aLength: LongInt;

begin
  aLength := ReadLongint;
  if aLength = 0 then
    Result := ''
  else
  begin
    SetLength(Result, aLength);

    Read(Result[1], aLength * sizeof(WideChar));

  end
end;

function TLMDBinXmlReader.ReadXmlString: TLMDString;
begin
  if (FOptions and LMD_BINXML_USE_WIDE_CHARS) <> 0 then
    Result := ReadWideString
  else
    Result := ReadAnsiString
end;

{ TStmXmlWriter }

constructor TLMDStmXmlWriter.Create(aStream: TStream; anOptions: LongWord; aBufSize: Integer);

begin
  inherited Create;
  FStream := aStream;
  FOptions := anOptions;

  FBufSize := aBufSize;
  FBufStart := AllocMem(aBufSize);
  FBufEnd := FBufStart + aBufSize;
  FBufPtr := FBufStart;

  Write(LMDBinXmlSignature[1], LMDBinXmlSignatureSize);
  Write(FOptions, sizeof(FOptions));

end;

destructor TLMDStmXmlWriter.Destroy;
begin

  if FBufPtr > FBufStart then
    FStream.WriteBuffer(FBufStart^, FBufPtr - FBufStart);
  FreeMem(FBufStart);

  inherited;
end;

procedure TLMDStmXmlWriter.Write(const aBuf; aSize: Integer);
var
  aBufRest: Integer;
begin
  aBufRest := FBufEnd - FBufPtr;
  if aSize <= aBufRest then
  begin
    Move(aBuf, FBufPtr^, aSize);
    Inc(FBufPtr, aSize);
  end
  else
  begin
    if FBufPtr > FBufStart then
    begin
      FStream.WriteBuffer(FBufStart^, FBufPtr - FBufStart);
      FBufPtr := FBufStart;
    end;
    FStream.WriteBuffer(aBuf, aSize);
  end
end;

{ TStrXmlWriter }

constructor TLMDStrXmlWriter.Create(anOptions: LongWord; aBufSize: Integer);

begin
  inherited Create;
  FData := '';
  FOptions := anOptions;

  FBufSize := aBufSize;
  FBufStart := AllocMem(aBufSize);
  FBufEnd := FBufStart + aBufSize;
  FBufPtr := FBufStart;

  Write(LMDBinXmlSignature[1], LMDBinXmlSignatureSize);
  Write(FOptions, sizeof(FOptions));

end;

destructor TLMDStrXmlWriter.Destroy;
begin

  FreeMem(FBufStart);

  inherited;
end;

procedure TLMDStrXmlWriter.FlushBuf;

var
  aPrevSize: Integer;
  aSize: Integer;

begin

  aPrevSize := Length(FData);
  aSize := FBufPtr - FBufStart;
  SetLength(FData, aPrevSize + aSize);
  Move(FBufStart^, FData[aPrevSize + 1], aSize);
  FBufPtr := FBufStart;

end;

procedure TLMDStrXmlWriter.Write(const aBuf; aSize: Integer);
var
  aBufRest: Integer;
  aPrevSize: Integer;
  aBufSize: Integer;
begin
  aBufRest := FBufEnd - FBufPtr;
  if aSize <= aBufRest then
  begin
    Move(aBuf, FBufPtr^, aSize);
    Inc(FBufPtr, aSize);
  end
  else
  begin
    aPrevSize := Length(FData);
    aBufSize := FBufPtr - FBufStart;
    SetLength(FData, aPrevSize + aBufSize + aSize);
    if aBufSize > 0 then
      Move(FBufStart^, FData[aPrevSize + 1], aBufSize);
    Move(aBuf, FData[aPrevSize + aBufSize + 1], aSize);
    FBufPtr := FBufStart;
  end
end;

{ TBinXmlWriter }

procedure TLMDBinXmlWriter.WriteAnsiString(const aValue: string);

var
  aLength: LongInt;

begin
  aLength := Length(aValue);
  WriteLongint(aLength);
  if aLength > 0 then

    Write(aValue[1], aLength);

end;

procedure TLMDBinXmlWriter.WriteLongint(aValue: Longint);

var
  b: array[0..1] of Byte;

begin

  if aValue < 0 then
  begin
    b[0] := $FF;
    Write(b[0], 1);
    Write(aValue, SizeOf(aValue));
  end
  else
  begin
    if aValue < $80 then
      Write(aValue, 1)
    else
    begin
      if (aValue <= $7FFF) and ((aValue shr 8) or $80 <> $FF) then
      begin
        b[0] := (aValue shr 8) or $80;
        b[1] := aValue and $FF;
        Write(b, 2);
      end
      else
      begin
        b[0] := $FF;
        Write(b[0], 1);
        Write(aValue, SizeOf(aValue));
      end;
    end;
  end;

end;

procedure TLMDBinXmlWriter.WriteVariant(const AVar: Variant);
var
  aSize: Integer;
  LType: Integer;

  v: TVarData;
  p: Pointer;

begin

  v := TVarData(AVar);
  LType := v.VType;

  WriteLongint(LType);
  case LType of
    varEmpty: ;
    varNull: ;
    varSmallint:

      Write(v.VSmallint, sizeof(SmallInt));

    varInteger:

      Write(v.VInteger, sizeof(Integer));

    varSingle:

      Write(v.VSingle, sizeof(Single));

    varDouble:

      Write(v.VDouble, sizeof(Double));

    varCurrency:

      Write(v.VCurrency, sizeof(Currency));

    varDate:

      Write(v.VDate, sizeof(TDateTime));

    varOleStr:
      WriteWideString(Variant(v));

    varBoolean:

      Write(v.VBoolean, sizeof(WordBool));

    varByte:

      Write(v.VByte, sizeof(Byte));

    varShortInt:

      Write(v.VShortInt, sizeof(ShortInt));

    varWord:

      Write(v.VWord, sizeof(Word));

    varLongWord:
      Write(v.VLongWord, sizeof(LongWord));

    varInt64:
      Write(v.VInt64, sizeof(Int64));

    varString:
      WriteAnsiString(Variant(v));

    varArray + varByte:
      begin

        aSize := VarArrayHighBound(Variant(v), 1) - VarArrayLowBound(Variant(v), 1) + 1;
        WriteLongint(aSize);
        p := VarArrayLock(Variant(v));
        try
          Write(p^, aSize);
        finally
          VarArrayUnlock(Variant(v))
        end

      end;
  else
    raise Exception.Create(SLMDXmlError25);
  end;
end;

procedure TLMDBinXmlWriter.WriteWideString(const aValue: WideString);
var
  aLength: LongInt;

begin
  aLength := Length(aValue);
  WriteLongint(aLength);
  if aLength > 0 then

    Write(aValue[1], aLength * sizeof(WideChar));

end;

procedure TLMDBinXmlWriter.WriteXmlString(const aValue: TLMDString);
begin
  if (FOptions and LMD_BINXML_USE_WIDE_CHARS) <> 0 then
    WriteWideString(aValue)
  else
    WriteAnsiString(aValue)
end;

var
  DefaultNameTableImpl: TLMDXmlNameTable = nil;

function LMDCreateXmlElement(const aName: TLMDString; const aNameTable: ILMDXmlNameTable): ILMDXmlElement;
var
  aNameTableImpl: TLMDXmlNameTable;
begin
  if Assigned(aNameTable) then
    aNameTableImpl := aNameTable.GetObject as TLMDXmlNameTable
  else
    aNameTableImpl := DefaultNameTableImpl;
  Result := TLMDXmlElement.Create(aNameTableImpl, aNameTableImpl.GetID(aName));
end;

function LMDCreateXmlDocument(
  const aRootElementName: string;
  const aVersion: string;
  const anEncoding: string;
  const aNames: ILMDXmlNameTable;
  const ACaseSensitive: Boolean): ILMDXmlDocument;
var
  aNameTable: TLMDXmlNameTable;
  s: string;
begin
  if Assigned(aNames) then
    aNameTable := aNames.GetObject as TLMDXmlNameTable
  else
  begin
    aNameTable := DefaultNameTableImpl;
    if ACaseSensitive <> DefaulCaseSensitive then
      aNameTable.CaseSensitive := ACaseSensitive;
  end;
  if anEncoding = '' then
    s := DefaultEncoding
  else
    s := anEncoding;
  Result := TLMDXmlDocument.Create(aNameTable);
  if aRootElementName <> '' then
    Result.NewDocument(aVersion, s, aRootElementName);
end;

function LMDLoadXmlDocumentFromXML(const aXML: TLMDString): ILMDXmlDocument;
begin
  Result := TLMDXmlDocument.Create(DefaultNameTableImpl);
  Result.LoadXML(aXML);
end;

function LMDLoadXmlDocumentFromBinaryXML(const aXML: string): ILMDXmlDocument;
begin
  Result := TLMDXmlDocument.Create(DefaultNameTableImpl);
  Result.LoadBinaryXML(aXML);
end;

function LMDLoadXmlDocument(aStream: TStream): ILMDXmlDocument;
begin
  Result := TLMDXmlDocument.Create(DefaultNameTableImpl);
  Result.Load(aStream);
end;

function LMDLoadXmlDocument(const aFileName: TLMDString): ILMDXmlDocument; overload;
begin
  Result := TLMDXmlDocument.Create(DefaultNameTableImpl);
  Result.Load(aFileName);
end;

function LMDLoadXmlDocument(aResType, aResName: PChar): ILMDXmlDocument; overload;

begin
  Result := TLMDXmlDocument.Create(DefaultNameTableImpl);
  Result.LoadResource(aResType, aResName);
end;

initialization
  DefaultNameTableImpl := TLMDXmlNameTable.Create(4096, DefaulCaseSensitive);
  DefaultNameTable := DefaultNameTableImpl;
finalization
  DefaultNameTable := nil;
  DefaultNameTableImpl := nil;
end.
