// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeExport.pas' rev: 34.00 (Windows)

#ifndef TreeexportHPP
#define TreeexportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeExport.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeexport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreeExportForm;
class DELPHICLASS TTreeData;
class DELPHICLASS TTreeDataText;
class DELPHICLASS TTreeDataXML;
class DELPHICLASS TTreeDataHTML;
class DELPHICLASS TTreeDataXLS;
class DELPHICLASS TTreeDataJSON;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreeExportForm : public Vcltee::Teeexport::TTeeExportFormBase
{
	typedef Vcltee::Teeexport::TTeeExportFormBase inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBFullSize;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBFullSizeClick(System::TObject* Sender);
	
protected:
	virtual Vcltee::Teeprocs::TTeeExportData* __fastcall CreateData();
	virtual bool __fastcall ExistData();
	
public:
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* const AOwner, Teetree::TCustomTree* const ATree);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTreeExportForm(System::Classes::TComponent* AOwner) : Vcltee::Teeexport::TTeeExportFormBase(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTreeExportForm(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeexport::TTeeExportFormBase(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTreeExportForm() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTreeExportForm(HWND ParentWindow) : Vcltee::Teeexport::TTeeExportFormBase(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeData : public Vcltee::Teeprocs::TTeeExportData
{
	typedef Vcltee::Teeprocs::TTeeExportData inherited;
	
private:
	Teetree::TCustomTree* FTree;
	
protected:
	virtual void __fastcall WriteNode(Teetree::TTreeNodeShape* ANode, System::Classes::TStream* AStream) = 0 ;
	void __fastcall WriteText(const System::UnicodeString AStr, System::Classes::TStream* const AStream);
	virtual System::UnicodeString __fastcall GetHeader();
	virtual System::UnicodeString __fastcall GetFooter();
	
public:
	__fastcall virtual TTreeData(Teetree::TCustomTree* ATree);
	DYNAMIC void __fastcall SaveToStream(System::Classes::TStream* AStream);
	virtual System::UnicodeString __fastcall AsString();
	__property Teetree::TCustomTree* Tree = {read=FTree, write=FTree};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTreeData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeDataText : public TTreeData
{
	typedef TTreeData inherited;
	
private:
	System::WideChar FTextDelimiter;
	System::UnicodeString FTextQuotes;
	
protected:
	virtual void __fastcall WriteNode(Teetree::TTreeNodeShape* ANode, System::Classes::TStream* AStream);
	
public:
	__fastcall virtual TTreeDataText(Teetree::TCustomTree* ATree);
	
__published:
	__property System::WideChar TextDelimiter = {read=FTextDelimiter, write=FTextDelimiter, default=9};
	__property System::UnicodeString TextQuotes = {read=FTextQuotes, write=FTextQuotes};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTreeDataText() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeDataXML : public TTreeData
{
	typedef TTreeData inherited;
	
private:
	bool FCompact;
	System::UnicodeString FEncoding;
	
protected:
	virtual void __fastcall WriteNode(Teetree::TTreeNodeShape* ANode, System::Classes::TStream* AStream);
	virtual System::UnicodeString __fastcall GetHeader();
	virtual System::UnicodeString __fastcall GetFooter();
	
public:
	__fastcall virtual TTreeDataXML(Teetree::TCustomTree* ATree);
	__property bool Compact = {read=FCompact, write=FCompact, default=0};
	__property System::UnicodeString Encoding = {read=FEncoding, write=FEncoding};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTreeDataXML() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeDataHTML : public TTreeData
{
	typedef TTreeData inherited;
	
protected:
	virtual void __fastcall WriteNode(Teetree::TTreeNodeShape* ANode, System::Classes::TStream* AStream);
	virtual System::UnicodeString __fastcall GetHeader();
	virtual System::UnicodeString __fastcall GetFooter();
public:
	/* TTreeData.Create */ inline __fastcall virtual TTreeDataHTML(Teetree::TCustomTree* ATree) : TTreeData(ATree) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTreeDataHTML() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeDataXLS : public TTreeData
{
	typedef TTreeData inherited;
	
private:
	System::StaticArray<System::Word, 5> Buf;
	int Row;
	int Col;
	void __fastcall WriteBuf(System::Classes::TStream* AStream, System::Word Value, System::Word Size);
	
protected:
	virtual void __fastcall WriteNode(Teetree::TTreeNodeShape* ANode, System::Classes::TStream* AStream);
	
public:
	DYNAMIC void __fastcall SaveToStream(System::Classes::TStream* AStream);
public:
	/* TTreeData.Create */ inline __fastcall virtual TTreeDataXLS(Teetree::TCustomTree* ATree) : TTreeData(ATree) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTreeDataXLS() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeDataJSON : public TTreeData
{
	typedef TTreeData inherited;
	
protected:
	virtual void __fastcall WriteNode(Teetree::TTreeNodeShape* ANode, System::Classes::TStream* AStream);
	virtual System::UnicodeString __fastcall GetHeader();
	virtual System::UnicodeString __fastcall GetFooter();
public:
	/* TTreeData.Create */ inline __fastcall virtual TTreeDataJSON(Teetree::TCustomTree* ATree) : TTreeData(ATree) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTreeDataJSON() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treeexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEEXPORT)
using namespace Treeexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeexportHPP
