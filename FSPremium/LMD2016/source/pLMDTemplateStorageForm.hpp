// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDTemplateStorageForm.pas' rev: 31.00 (Windows)

#ifndef PlmdtemplatestorageformHPP
#define PlmdtemplatestorageformHPP

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
#include <Winapi.ShellAPI.hpp>
#include <Winapi.ShlObj.hpp>
#include <System.Win.Registry.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Buttons.hpp>
#include <LMDStorTemplateStorage.hpp>
#include <LMDTypes.hpp>
#include <pLMDCst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdtemplatestorageform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExWriter;
class DELPHICLASS TLMDExReader;
class DELPHICLASS TLMDIDEStorageItem;
class DELPHICLASS TLMDIDEStorageItems;
class DELPHICLASS TLMDTemplateStorageForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDExWriter : public System::Classes::TWriter
{
	typedef System::Classes::TWriter inherited;
	
public:
	/* TWriter.Destroy */ inline __fastcall virtual ~TLMDExWriter(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TLMDExWriter(System::Classes::TStream* Stream, int BufSize) : System::Classes::TWriter(Stream, BufSize) { }
	
};


class PASCALIMPLEMENTATION TLMDExReader : public System::Classes::TReader
{
	typedef System::Classes::TReader inherited;
	
public:
	/* TReader.Destroy */ inline __fastcall virtual ~TLMDExReader(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TLMDExReader(System::Classes::TStream* Stream, int BufSize) : System::Classes::TReader(Stream, BufSize) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEStorageItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FClassName;
	System::UnicodeString FName;
	System::UnicodeString FFileName;
	void __fastcall SetClassName(const System::UnicodeString Value);
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetName(const System::UnicodeString Value);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString StoredClassName = {read=FClassName, write=SetClassName};
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDIDEStorageItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDIDEStorageItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEStorageItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDIDEStorageItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDIDEStorageItem* __fastcall GetItem(int Index);
	
public:
	__fastcall TLMDIDEStorageItems(void);
	__fastcall virtual ~TLMDIDEStorageItems(void);
	HIDESBASE TLMDIDEStorageItem* __fastcall Add(void);
	__property TLMDIDEStorageItem* Items[int Index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDTemplateStorageForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* OkBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	Vcl::Comctrls::TTreeView* ComponentsTree;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* StoragePathEdit;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TComboBox* TLCombo;
	Vcl::Stdctrls::TButton* AddBtn;
	Vcl::Stdctrls::TButton* LoadBtn;
	Vcl::Stdctrls::TButton* BrowseFolderBtn;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TButton* DeleteButton;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall OkBtnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ComponentsTreeChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall AddBtnClick(System::TObject* Sender);
	void __fastcall TLComboChange(System::TObject* Sender);
	void __fastcall LoadBtnClick(System::TObject* Sender);
	void __fastcall BrowseFolderBtnClick(System::TObject* Sender);
	void __fastcall DeleteButtonClick(System::TObject* Sender);
	
public:
	Lmdstortemplatestorage::TLMDStorTemplateStorage* SC;
	TLMDIDEStorageItems* StoredItems;
	void __fastcall SaveObject(System::TObject* aObj, System::UnicodeString szFileName);
	void __fastcall LoadObject(System::TObject* aObj, System::UnicodeString szFileName);
	System::TObject* __fastcall GetSelectedObject(void);
	void __fastcall UpdatePropertiesTree(void);
	void __fastcall UpdateStoredItems(System::TObject* aObject);
	void __fastcall LoadStoredItems(void);
	void __fastcall SaveStoredItems(void);
	void __fastcall Apply(void);
	void __fastcall UpdateBtn(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDTemplateStorageForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDTemplateStorageForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDTemplateStorageForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTemplateStorageForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define IS_KEY L"SOFTWARE\\LMD Innovative\\LMD-Tools 2016\\Shared\\IDEStora"\
	L"ge"
#define IS_DIR_VALUE L"Directory"
#define IS_FILE_NAME L"storage.key"
}	/* namespace Plmdtemplatestorageform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDTEMPLATESTORAGEFORM)
using namespace Plmdtemplatestorageform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdtemplatestorageformHPP
