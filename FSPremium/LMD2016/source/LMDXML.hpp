// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDXML.pas' rev: 34.00 (Windows)

#ifndef LmdxmlHPP
#define LmdxmlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <LMDFiles.hpp>
#include <LMDTypes.hpp>
#include <LMDRTLConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdxml
{
//-- forward type declarations -----------------------------------------------
__interface DELPHIINTERFACE ILMDXmlBase;
typedef System::DelphiInterface<ILMDXmlBase> _di_ILMDXmlBase;
__interface DELPHIINTERFACE ILMDXmlNameTable;
typedef System::DelphiInterface<ILMDXmlNameTable> _di_ILMDXmlNameTable;
__interface DELPHIINTERFACE ILMDXmlNodeList;
typedef System::DelphiInterface<ILMDXmlNodeList> _di_ILMDXmlNodeList;
__interface DELPHIINTERFACE ILMDXmlNode;
typedef System::DelphiInterface<ILMDXmlNode> _di_ILMDXmlNode;
__interface DELPHIINTERFACE ILMDXmlElement;
typedef System::DelphiInterface<ILMDXmlElement> _di_ILMDXmlElement;
__interface DELPHIINTERFACE ILMDXmlCharacterData;
typedef System::DelphiInterface<ILMDXmlCharacterData> _di_ILMDXmlCharacterData;
__interface DELPHIINTERFACE ILMDXmlText;
typedef System::DelphiInterface<ILMDXmlText> _di_ILMDXmlText;
__interface DELPHIINTERFACE ILMDXmlCDATASection;
typedef System::DelphiInterface<ILMDXmlCDATASection> _di_ILMDXmlCDATASection;
__interface DELPHIINTERFACE ILMDXmlComment;
typedef System::DelphiInterface<ILMDXmlComment> _di_ILMDXmlComment;
__interface DELPHIINTERFACE ILMDXmlProcessingInstruction;
typedef System::DelphiInterface<ILMDXmlProcessingInstruction> _di_ILMDXmlProcessingInstruction;
__interface DELPHIINTERFACE ILMDXmlDocument;
typedef System::DelphiInterface<ILMDXmlDocument> _di_ILMDXmlDocument;
//-- type declarations -------------------------------------------------------
__interface ILMDXmlBase  : public System::IInterface 
{
	virtual System::TObject* __fastcall GetObject() = 0 ;
};

__interface ILMDXmlNameTable  : public ILMDXmlBase 
{
	virtual int __fastcall GetID(const Lmdtypes::TLMDString aName) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetName(int anID) = 0 ;
};

__interface ILMDXmlNodeList  : public ILMDXmlBase 
{
	
public:
	_di_ILMDXmlNode operator[](int anIndex) { return this->Item[anIndex]; }
	virtual int __fastcall get_Count() = 0 ;
	virtual _di_ILMDXmlNode __fastcall get_Item(int anIndex) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall get_XML() = 0 ;
	__property int Count = {read=get_Count};
	__property _di_ILMDXmlNode Item[int anIndex] = {read=get_Item/*, default*/};
	__property Lmdtypes::TLMDString XML = {read=get_XML};
};

__interface ILMDXmlNode  : public ILMDXmlBase 
{
	
public:
	System::Variant operator[](const Lmdtypes::TLMDString aName) { return this->Values[aName]; }
	virtual _di_ILMDXmlNameTable __fastcall get_NameTable() = 0 ;
	virtual Lmdtypes::TLMDString __fastcall get_NodeName() = 0 ;
	virtual int __fastcall get_NodeNameID() = 0 ;
	virtual int __fastcall get_NodeType() = 0 ;
	virtual Lmdtypes::TLMDString __fastcall get_Text() = 0 ;
	virtual void __fastcall set_Text(const Lmdtypes::TLMDString aValue) = 0 ;
	virtual int __fastcall get_DataType() = 0 ;
	virtual System::Variant __fastcall get_TypedValue() = 0 ;
	virtual void __fastcall set_TypedValue(const System::Variant &aValue) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall get_XML() = 0 ;
	virtual _di_ILMDXmlNode __fastcall CloneNode(bool aDeep = true) = 0 ;
	virtual _di_ILMDXmlNode __fastcall get_ParentNode() = 0 ;
	virtual _di_ILMDXmlDocument __fastcall get_OwnerDocument() = 0 ;
	virtual _di_ILMDXmlNodeList __fastcall get_ChildNodes() = 0 ;
	virtual void __fastcall AppendChild(const _di_ILMDXmlNode aChild) = 0 ;
	virtual void __fastcall InsertBefore(const _di_ILMDXmlNode aChild, const _di_ILMDXmlNode aBefore) = 0 ;
	virtual void __fastcall ReplaceChild(const _di_ILMDXmlNode aNewChild, const _di_ILMDXmlNode anOldChild) = 0 ;
	virtual void __fastcall RemoveChild(const _di_ILMDXmlNode aChild) = 0 ;
	virtual _di_ILMDXmlElement __fastcall AppendElement(int aNameID) = 0 /* overload */;
	virtual _di_ILMDXmlElement __fastcall AppendElement(const Lmdtypes::TLMDString aName) = 0 /* overload */;
	virtual _di_ILMDXmlText __fastcall AppendText(const Lmdtypes::TLMDString aData) = 0 ;
	virtual _di_ILMDXmlCDATASection __fastcall AppendCDATA(const Lmdtypes::TLMDString aData) = 0 ;
	virtual _di_ILMDXmlComment __fastcall AppendComment(const Lmdtypes::TLMDString aData) = 0 ;
	virtual _di_ILMDXmlProcessingInstruction __fastcall AppendProcessingInstruction(int aTargetID, const Lmdtypes::TLMDString aData) = 0 /* overload */;
	virtual _di_ILMDXmlProcessingInstruction __fastcall AppendProcessingInstruction(const Lmdtypes::TLMDString aTarget, const Lmdtypes::TLMDString aData) = 0 /* overload */;
	virtual Lmdtypes::TLMDString __fastcall GetChildText(const Lmdtypes::TLMDString aName, const Lmdtypes::TLMDString aDefault = Lmdtypes::TLMDString()) = 0 /* overload */;
	virtual Lmdtypes::TLMDString __fastcall GetChildText(int aNameID, const Lmdtypes::TLMDString aDefault = Lmdtypes::TLMDString()) = 0 /* overload */;
	virtual void __fastcall SetChildText(const Lmdtypes::TLMDString aName, const Lmdtypes::TLMDString aValue) = 0 /* overload */;
	virtual void __fastcall SetChildText(int aNameID, const Lmdtypes::TLMDString aValue) = 0 /* overload */;
	virtual _di_ILMDXmlNode __fastcall NeedChild(int aNameID) = 0 /* overload */;
	virtual _di_ILMDXmlNode __fastcall NeedChild(const Lmdtypes::TLMDString aName) = 0 /* overload */;
	virtual _di_ILMDXmlNode __fastcall EnsureChild(int aNameID) = 0 /* overload */;
	virtual _di_ILMDXmlNode __fastcall EnsureChild(const Lmdtypes::TLMDString aName) = 0 /* overload */;
	virtual void __fastcall RemoveAllChilds() = 0 ;
	virtual _di_ILMDXmlNodeList __fastcall SelectNodes(const Lmdtypes::TLMDString anExpression) = 0 ;
	virtual _di_ILMDXmlNode __fastcall SelectSingleNode(const Lmdtypes::TLMDString anExpression) = 0 ;
	virtual _di_ILMDXmlElement __fastcall FindElement(const System::UnicodeString anElementName, const System::UnicodeString anAttrName, const System::Variant &anAttrValue) = 0 ;
	virtual int __fastcall get_AttrCount() = 0 ;
	virtual int __fastcall get_AttrNameIDs(int anIndex) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall get_AttrNames(int anIndex) = 0 ;
	virtual void __fastcall RemoveAttr(const Lmdtypes::TLMDString aName) = 0 /* overload */;
	virtual void __fastcall RemoveAttr(int aNameID) = 0 /* overload */;
	virtual void __fastcall RemoveAllAttrs() = 0 ;
	virtual bool __fastcall AttrExists(int aNameID) = 0 /* overload */;
	virtual bool __fastcall AttrExists(const Lmdtypes::TLMDString aName) = 0 /* overload */;
	virtual int __fastcall GetAttrType(int aNameID) = 0 /* overload */;
	virtual int __fastcall GetAttrType(const Lmdtypes::TLMDString aName) = 0 /* overload */;
	virtual System::Variant __fastcall GetVarAttr(int aNameID, const System::Variant &aDefault) = 0 /* overload */;
	virtual System::Variant __fastcall GetVarAttr(const Lmdtypes::TLMDString aName, const System::Variant &aDefault) = 0 /* overload */;
	virtual void __fastcall SetVarAttr(int aNameID, const System::Variant &aValue) = 0 /* overload */;
	virtual void __fastcall SetVarAttr(const Lmdtypes::TLMDString aName, const System::Variant &aValue) = 0 /* overload */;
	virtual Lmdtypes::TLMDString __fastcall NeedAttr(int aNameID) = 0 /* overload */;
	virtual Lmdtypes::TLMDString __fastcall NeedAttr(const Lmdtypes::TLMDString aName) = 0 /* overload */;
	virtual Lmdtypes::TLMDString __fastcall GetAttr(int aNameID, const Lmdtypes::TLMDString aDefault = Lmdtypes::TLMDString()) = 0 /* overload */;
	virtual Lmdtypes::TLMDString __fastcall GetAttr(const Lmdtypes::TLMDString aName, const Lmdtypes::TLMDString aDefault = Lmdtypes::TLMDString()) = 0 /* overload */;
	virtual void __fastcall SetAttr(int aNameID, const Lmdtypes::TLMDString aValue) = 0 /* overload */;
	virtual void __fastcall SetAttr(const Lmdtypes::TLMDString aName, const Lmdtypes::TLMDString aValue) = 0 /* overload */;
	virtual bool __fastcall GetBoolAttr(int aNameID, bool aDefault = false) = 0 /* overload */;
	virtual bool __fastcall GetBoolAttr(const Lmdtypes::TLMDString aName, bool aDefault = false) = 0 /* overload */;
	virtual void __fastcall SetBoolAttr(int aNameID, bool aValue = false) = 0 /* overload */;
	virtual void __fastcall SetBoolAttr(const Lmdtypes::TLMDString aName, bool aValue) = 0 /* overload */;
	virtual int __fastcall GetIntAttr(int aNameID, int aDefault = 0x0) = 0 /* overload */;
	virtual int __fastcall GetIntAttr(const Lmdtypes::TLMDString aName, int aDefault = 0x0) = 0 /* overload */;
	virtual void __fastcall SetIntAttr(int aNameID, int aValue) = 0 /* overload */;
	virtual void __fastcall SetIntAttr(const Lmdtypes::TLMDString aName, int aValue) = 0 /* overload */;
	virtual System::TDateTime __fastcall GetDateTimeAttr(int aNameID, System::TDateTime aDefault = 0.000000E+00) = 0 /* overload */;
	virtual System::TDateTime __fastcall GetDateTimeAttr(const Lmdtypes::TLMDString aName, System::TDateTime aDefault = 0.000000E+00) = 0 /* overload */;
	virtual void __fastcall SetDateTimeAttr(int aNameID, System::TDateTime aValue) = 0 /* overload */;
	virtual void __fastcall SetDateTimeAttr(const Lmdtypes::TLMDString aName, System::TDateTime aValue) = 0 /* overload */;
	virtual double __fastcall GetFloatAttr(int aNameID, double aDefault = 0.000000E+00) = 0 /* overload */;
	virtual double __fastcall GetFloatAttr(const Lmdtypes::TLMDString aName, double aDefault = 0.000000E+00) = 0 /* overload */;
	virtual void __fastcall SetFloatAttr(int aNameID, double aValue) = 0 /* overload */;
	virtual void __fastcall SetFloatAttr(const Lmdtypes::TLMDString aName, double aValue) = 0 /* overload */;
	virtual int __fastcall GetHexAttr(const Lmdtypes::TLMDString aName, int aDefault = 0x0) = 0 /* overload */;
	virtual int __fastcall GetHexAttr(int aNameID, int aDefault = 0x0) = 0 /* overload */;
	virtual void __fastcall SetHexAttr(const Lmdtypes::TLMDString aName, int aValue, int aDigits = 0x8) = 0 /* overload */;
	virtual void __fastcall SetHexAttr(int aNameID, int aValue, int aDigits = 0x8) = 0 /* overload */;
	virtual int __fastcall GetEnumAttr(const Lmdtypes::TLMDString aName, const Lmdtypes::TLMDString *aValues, const int aValues_High, int aDefault = 0x0) = 0 /* overload */;
	virtual int __fastcall GetEnumAttr(int aNameID, const Lmdtypes::TLMDString *aValues, const int aValues_High, int aDefault = 0x0) = 0 /* overload */;
	virtual int __fastcall NeedEnumAttr(const Lmdtypes::TLMDString aName, const Lmdtypes::TLMDString *aValues, const int aValues_High) = 0 /* overload */;
	virtual int __fastcall NeedEnumAttr(int aNameID, const Lmdtypes::TLMDString *aValues, const int aValues_High) = 0 /* overload */;
	virtual System::Variant __fastcall get_Values(const Lmdtypes::TLMDString aName) = 0 ;
	virtual void __fastcall set_Values(const Lmdtypes::TLMDString aName, const System::Variant &aValue) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall get_AttrValues(int anIndex) = 0 ;
	virtual void __fastcall set_AttrValues(int anIndex, const Lmdtypes::TLMDString aValue) = 0 ;
	virtual _di_ILMDXmlElement __fastcall AsElement() = 0 ;
	virtual _di_ILMDXmlText __fastcall AsText() = 0 ;
	virtual _di_ILMDXmlCDATASection __fastcall AsCDATASection() = 0 ;
	virtual _di_ILMDXmlComment __fastcall AsComment() = 0 ;
	virtual _di_ILMDXmlProcessingInstruction __fastcall AsProcessingInstruction() = 0 ;
	virtual _di_ILMDXmlNodeList __fastcall GetElementsByTagName(const System::WideString ATagName) = 0 ;
	__property Lmdtypes::TLMDString NodeName = {read=get_NodeName};
	__property int NodeNameID = {read=get_NodeNameID};
	__property int NodeType = {read=get_NodeType};
	__property _di_ILMDXmlNode ParentNode = {read=get_ParentNode};
	__property _di_ILMDXmlDocument OwnerDocument = {read=get_OwnerDocument};
	__property _di_ILMDXmlNameTable NameTable = {read=get_NameTable};
	__property _di_ILMDXmlNodeList ChildNodes = {read=get_ChildNodes};
	__property int AttrCount = {read=get_AttrCount};
	__property Lmdtypes::TLMDString AttrNames[int anIndex] = {read=get_AttrNames};
	__property int AttrNameIDs[int anIndex] = {read=get_AttrNameIDs};
	__property Lmdtypes::TLMDString AttrValues[int anIndex] = {read=get_AttrValues, write=set_AttrValues};
	__property Lmdtypes::TLMDString Text = {read=get_Text, write=set_Text};
	__property int DataType = {read=get_DataType};
	__property System::Variant TypedValue = {read=get_TypedValue, write=set_TypedValue};
	__property Lmdtypes::TLMDString XML = {read=get_XML};
	__property System::Variant Values[const Lmdtypes::TLMDString aName] = {read=get_Values, write=set_Values/*, default*/};
};

__interface ILMDXmlElement  : public ILMDXmlNode 
{
	virtual void __fastcall ReplaceTextByCDATASection(const Lmdtypes::TLMDString aText) = 0 ;
	virtual void __fastcall ReplaceTextByBynaryData(const void *aData, int aSize, int aMaxLineLength) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetTextAsBynaryData() = 0 ;
};

__interface ILMDXmlCharacterData  : public ILMDXmlNode 
{
	
};

__interface ILMDXmlText  : public ILMDXmlCharacterData 
{
	
};

__interface ILMDXmlCDATASection  : public ILMDXmlCharacterData 
{
	
};

__interface ILMDXmlComment  : public ILMDXmlCharacterData 
{
	
};

__interface ILMDXmlProcessingInstruction  : public ILMDXmlNode 
{
	
};

__interface ILMDXmlDocument  : public ILMDXmlNode 
{
	virtual _di_ILMDXmlElement __fastcall get_DocumentElement() = 0 ;
	virtual System::UnicodeString __fastcall get_BinaryXML() = 0 ;
	virtual bool __fastcall get_PreserveWhiteSpace() = 0 ;
	virtual void __fastcall set_PreserveWhiteSpace(bool aValue) = 0 ;
	virtual bool __fastcall get_CaseSensitive() = 0 ;
	virtual void __fastcall set_CaseSensitive(const bool AValue) = 0 ;
	virtual _di_ILMDXmlElement __fastcall NewDocument(const Lmdtypes::TLMDString aVersion, const Lmdtypes::TLMDString anEncoding, int aRootElementNameID) = 0 /* overload */;
	virtual _di_ILMDXmlElement __fastcall NewDocument(const Lmdtypes::TLMDString aVersion, const Lmdtypes::TLMDString anEncoding, const Lmdtypes::TLMDString aRootElementName) = 0 /* overload */;
	virtual _di_ILMDXmlElement __fastcall CreateElement(int aNameID) = 0 /* overload */;
	virtual _di_ILMDXmlElement __fastcall CreateElement(const Lmdtypes::TLMDString aName) = 0 /* overload */;
	virtual _di_ILMDXmlText __fastcall CreateText(const Lmdtypes::TLMDString aData) = 0 ;
	virtual _di_ILMDXmlCDATASection __fastcall CreateCDATASection(const Lmdtypes::TLMDString aData) = 0 ;
	virtual _di_ILMDXmlComment __fastcall CreateComment(const Lmdtypes::TLMDString aData) = 0 ;
	virtual _di_ILMDXmlProcessingInstruction __fastcall CreateProcessingInstruction(const Lmdtypes::TLMDString aTarget, const Lmdtypes::TLMDString aData) = 0 /* overload */;
	virtual _di_ILMDXmlProcessingInstruction __fastcall CreateProcessingInstruction(int aTargetID, const Lmdtypes::TLMDString aData) = 0 /* overload */;
	virtual void __fastcall LoadXML(const Lmdtypes::TLMDString aXML) = 0 ;
	virtual void __fastcall LoadBinaryXML(const System::UnicodeString aXML) = 0 ;
	virtual void __fastcall Load(System::Classes::TStream* aStream) = 0 /* overload */;
	virtual void __fastcall Load(const Lmdtypes::TLMDString aFileName) = 0 /* overload */;
	virtual void __fastcall LoadResource(System::WideChar * aType, System::WideChar * aName) = 0 ;
	virtual void __fastcall Save(System::Classes::TStream* aStream) = 0 /* overload */;
	virtual void __fastcall Save(const Lmdtypes::TLMDString aFileName) = 0 /* overload */;
	virtual void __fastcall SaveBinary(System::Classes::TStream* aStream, unsigned anOptions = (unsigned)(0x0)) = 0 /* overload */;
	virtual void __fastcall SaveBinary(const Lmdtypes::TLMDString aFileName, unsigned anOptions = (unsigned)(0x0)) = 0 /* overload */;
	__property bool CaseSensitive = {read=get_CaseSensitive, write=set_CaseSensitive};
	__property bool PreserveWhiteSpace = {read=get_PreserveWhiteSpace, write=set_PreserveWhiteSpace};
	__property _di_ILMDXmlElement DocumentElement = {read=get_DocumentElement};
	__property System::UnicodeString BinaryXML = {read=get_BinaryXML};
};

typedef void __fastcall (*TLMDXmlNodeEvent)(System::TObject* Sender, _di_ILMDXmlNode ANode);

//-- var, const, procedure ---------------------------------------------------
static const int LMDBinXmlSignatureSize = int(14);
extern DELPHI_PACKAGE System::UnicodeString LMDBinXmlSignature;
static const System::Int8 LMD_BINXML_USE_WIDE_CHARS = System::Int8(0x1);
static const System::Int8 LMD_BINXML_COMPRESSED = System::Int8(0x2);
#define LMD_XSTR_NULL L"{{null}}"
static const System::Int8 LMD_NODE_INVALID = System::Int8(0x0);
static const System::Int8 LMD_NODE_ELEMENT = System::Int8(0x1);
static const System::Int8 LMD_NODE_ATTRIBUTE = System::Int8(0x2);
static const System::Int8 LMD_NODE_TEXT = System::Int8(0x3);
static const System::Int8 LMD_NODE_CDATA_SECTION = System::Int8(0x4);
static const System::Int8 LMD_NODE_ENTITY_REFERENCE = System::Int8(0x5);
static const System::Int8 LMD_NODE_ENTITY = System::Int8(0x6);
static const System::Int8 LMD_NODE_PROCESSING_INSTRUCTION = System::Int8(0x7);
static const System::Int8 LMD_NODE_COMMENT = System::Int8(0x8);
static const System::Int8 LMD_NODE_DOCUMENT = System::Int8(0x9);
static const System::Int8 LMD_NODE_DOCUMENT_TYPE = System::Int8(0xa);
static const System::Int8 LMD_NODE_DOCUMENT_FRAGMENT = System::Int8(0xb);
static const System::Int8 LMD_NODE_NOTATION = System::Int8(0xc);
extern DELPHI_PACKAGE _di_ILMDXmlNameTable DefaultNameTable;
extern DELPHI_PACKAGE bool DefaultPreserveWhiteSpace;
extern DELPHI_PACKAGE bool DefaulCaseSensitive;
extern DELPHI_PACKAGE System::UnicodeString DefaultEncoding;
extern DELPHI_PACKAGE Lmdtypes::TLMDBOM DefaultBOM;
extern DELPHI_PACKAGE System::UnicodeString DefaultIndentText;
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDTextToXML(const Lmdtypes::TLMDString aText);
extern DELPHI_PACKAGE double __fastcall LMDXSTRToFloat(Lmdtypes::TLMDString s);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDFloatToXSTR(double v);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDDateTimeToXSTR(System::TDateTime v);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDVarToXSTR(const System::Variant &AVar);
extern DELPHI_PACKAGE void __fastcall LMDPrepareToSaveXml(_di_ILMDXmlElement &anElem, const System::UnicodeString aChildName);
extern DELPHI_PACKAGE bool __fastcall LMDPrepareToLoadXml(_di_ILMDXmlElement &anElem, const System::UnicodeString aChildName);
extern DELPHI_PACKAGE bool __fastcall LoadXMLResource(NativeUInt aModule, System::WideChar * aName, System::WideChar * aType, const _di_ILMDXmlDocument aXMLDoc);
extern DELPHI_PACKAGE bool __fastcall LMDIsXmlDataString(const System::UnicodeString aData);
extern DELPHI_PACKAGE bool __fastcall LMDXmlIsInBinaryFormat(const System::UnicodeString aData);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDBinToBase64(const void *aBin, int aSize, int aMaxLineLength);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDBase64ToBin(const System::UnicodeString aBase64);
extern DELPHI_PACKAGE _di_ILMDXmlNameTable __fastcall LMDCreateNameTable(int aHashTableSize = 0x1000);
extern DELPHI_PACKAGE _di_ILMDXmlElement __fastcall LMDCreateXmlElement(const Lmdtypes::TLMDString aName, const _di_ILMDXmlNameTable aNameTable = _di_ILMDXmlNameTable());
extern DELPHI_PACKAGE _di_ILMDXmlDocument __fastcall LMDCreateXmlDocument(const System::UnicodeString aRootElementName = System::UnicodeString(), const System::UnicodeString aVersion = L"1.0", const System::UnicodeString anEncoding = System::UnicodeString(), const _di_ILMDXmlNameTable aNames = _di_ILMDXmlNameTable(), const bool ACaseSensitive = true);
extern DELPHI_PACKAGE _di_ILMDXmlDocument __fastcall LMDLoadXmlDocumentFromXML(const Lmdtypes::TLMDString aXML);
extern DELPHI_PACKAGE _di_ILMDXmlDocument __fastcall LMDLoadXmlDocumentFromBinaryXML(const System::UnicodeString aXML);
extern DELPHI_PACKAGE _di_ILMDXmlDocument __fastcall LMDLoadXmlDocument(System::Classes::TStream* aStream)/* overload */;
extern DELPHI_PACKAGE _di_ILMDXmlDocument __fastcall LMDLoadXmlDocument(const Lmdtypes::TLMDString aFileName)/* overload */;
extern DELPHI_PACKAGE _di_ILMDXmlDocument __fastcall LMDLoadXmlDocument(System::WideChar * aResType, System::WideChar * aResName)/* overload */;
}	/* namespace Lmdxml */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDXML)
using namespace Lmdxml;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdxmlHPP
