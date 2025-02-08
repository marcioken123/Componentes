// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBExtSpinEdit.pas' rev: 31.00 (Windows)

#ifndef LmddbextspineditHPP
#define LmddbextspineditHPP

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
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDDBBase.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCurrencySettings.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbextspinedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBExtSpinEdit;
class DELPHICLASS TLMDDBLabeledExtSpinEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBExtSpinEdit : public Lmdcustomextspinedit::TLMDCustomExtSpinEdit
{
	typedef Lmdcustomextspinedit::TLMDCustomExtSpinEdit inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TNotifyEvent FOnDataChange;
	bool FUseDBMinMax;
	bool FUseZeroLogic;
	bool FUseDBDecimals;
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
	void __fastcall SetUseZeroLogic(const bool Value);
	void __fastcall SetUseDBMinMax(const bool Value);
	void __fastcall SetUseDBDecimals(const bool Value);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall BeforeChangeText(void);
	virtual void __fastcall ChangedText(int At);
	virtual void __fastcall DoInc(System::TObject* Sender);
	virtual void __fastcall DoDec(System::TObject* Sender);
	virtual void __fastcall DrawEditText(int from)/* overload */;
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBExtSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBExtSpinEdit(void);
	__property Data::Db::TField* Field = {read=GetField};
	__property Value = {stored=false, index=2, default=0};
	__property InfiniteMax = {default=0};
	__property InfiniteMin = {default=0};
	
__published:
	__property Alignment = {default=0};
	__property Decimals = {index=0, default=1};
	__property CurrencySettings;
	__property ReadOnly = {index=1, default=0};
	__property TabOnEnter = {default=0};
	__property LargeStep = {default=0};
	__property FractionStep = {default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::Classes::TNotifyEvent OnDataChange = {read=FOnDataChange, write=FOnDataChange};
	__property bool UseDBMinMax = {read=FUseDBMinMax, write=SetUseDBMinMax, default=1};
	__property bool UseDBDecimals = {read=FUseDBDecimals, write=SetUseDBDecimals, default=1};
	__property bool UseZeroLogic = {read=FUseZeroLogic, write=SetUseZeroLogic, default=1};
	__property MaxValue = {index=2, default=0};
	__property MinValue = {index=1, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBExtSpinEdit(HWND ParentWindow) : Lmdcustomextspinedit::TLMDCustomExtSpinEdit(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DrawEditText(int from, const Lmdtypes::TLMDString aTxt){ Lmdcustomedit::TLMDCustomEdit::DrawEditText(from, aTxt); }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


class PASCALIMPLEMENTATION TLMDDBLabeledExtSpinEdit : public TLMDDBExtSpinEdit
{
	typedef TLMDDBExtSpinEdit inherited;
	
public:
	__fastcall virtual TLMDDBLabeledExtSpinEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDDBExtSpinEdit.Destroy */ inline __fastcall virtual ~TLMDDBLabeledExtSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBLabeledExtSpinEdit(HWND ParentWindow) : TLMDDBExtSpinEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbextspinedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBEXTSPINEDIT)
using namespace Lmddbextspinedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbextspineditHPP
