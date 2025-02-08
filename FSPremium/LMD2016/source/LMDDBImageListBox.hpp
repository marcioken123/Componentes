// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBImageListBox.pas' rev: 31.00 (Windows)

#ifndef LmddbimagelistboxHPP
#define LmddbimagelistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDDBBase.hpp>
#include <LMDCustomListBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbimagelistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBImageListBox;
class DELPHICLASS TLMDDBLabeledImageListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBImageListBox : public Lmdcustomimagelistbox::TLMDCustomImageListBox
{
	typedef Lmdcustomimagelistbox::TLMDCustomImageListBox inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(bool aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall DoSelect(void);
	virtual int __fastcall GetFieldValue(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBImageListBox(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__fastcall virtual ~TLMDDBImageListBox(void);
	
__published:
	__property Columns = {default=0};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ImageList;
	__property ListIndex = {default=0};
	__property Items;
	__property Layout;
	__property ImagesOnly = {default=0};
	__property MultiLine = {default=0};
	__property AutoComplete = {default=1};
	__property LargeTextOptions = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBImageListBox(HWND ParentWindow) : Lmdcustomimagelistbox::TLMDCustomImageListBox(ParentWindow) { }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


class PASCALIMPLEMENTATION TLMDDBLabeledImageListBox : public TLMDDBImageListBox
{
	typedef TLMDDBImageListBox inherited;
	
public:
	__fastcall virtual TLMDDBLabeledImageListBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDDBImageListBox.Destroy */ inline __fastcall virtual ~TLMDDBLabeledImageListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBLabeledImageListBox(HWND ParentWindow) : TLMDDBImageListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbimagelistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBIMAGELISTBOX)
using namespace Lmddbimagelistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbimagelistboxHPP
