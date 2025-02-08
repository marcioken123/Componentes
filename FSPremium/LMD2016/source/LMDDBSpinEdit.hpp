// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBSpinEdit.pas' rev: 31.00 (Windows)

#ifndef LmddbspineditHPP
#define LmddbspineditHPP

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
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDDBBase.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbspinedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBSpinEdit;
class DELPHICLASS TLMDDBLabeledSpinEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBSpinEdit : public Lmdspinedit::TLMDCustomSpinEdit
{
	typedef Lmdspinedit::TLMDCustomSpinEdit inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TNotifyEvent FOnDataChange;
	bool FUseDBMinMax;
	bool FUseZeroLogic;
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpDateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall SetUseDBMinMax(const bool Value);
	void __fastcall SetUseZeroLogic(const bool Value);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall BeforeChangeText(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall DrawEditText(int from)/* overload */;
	virtual void __fastcall DoInc(System::TObject* Sender);
	virtual void __fastcall DoDec(System::TObject* Sender);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBSpinEdit(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__property Data::Db::TField* Field = {read=GetField};
	__property Value = {stored=false, index=4, default=0};
	__property InfiniteMax = {default=0};
	__property InfiniteMin = {default=0};
	
__published:
	__property Alignment = {default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::Classes::TNotifyEvent OnDataChange = {read=FOnDataChange, write=FOnDataChange};
	__property ReadOnly = {index=1, default=0};
	__property bool UseDBMinMax = {read=FUseDBMinMax, write=SetUseDBMinMax, default=1};
	__property bool UseZeroLogic = {read=FUseZeroLogic, write=SetUseZeroLogic, default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBSpinEdit(HWND ParentWindow) : Lmdspinedit::TLMDCustomSpinEdit(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DrawEditText(int from, const Lmdtypes::TLMDString aTxt){ Lmdcustomedit::TLMDCustomEdit::DrawEditText(from, aTxt); }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


class PASCALIMPLEMENTATION TLMDDBLabeledSpinEdit : public TLMDDBSpinEdit
{
	typedef TLMDDBSpinEdit inherited;
	
public:
	__fastcall virtual TLMDDBLabeledSpinEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDDBSpinEdit.Destroy */ inline __fastcall virtual ~TLMDDBLabeledSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBLabeledSpinEdit(HWND ParentWindow) : TLMDDBSpinEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbspinedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBSPINEDIT)
using namespace Lmddbspinedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbspineditHPP
