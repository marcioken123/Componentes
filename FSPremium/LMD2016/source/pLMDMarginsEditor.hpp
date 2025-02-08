// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDMarginsEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdmarginseditorHPP
#define PlmdmarginseditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <LMDShSpinEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdmarginseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMarginsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMarginsEditor : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
private:
	Lmdshspinedit::TLMDShSpinEdit* FSETopMargin;
	Lmdshspinedit::TLMDShSpinEdit* FSELeftMargin;
	Lmdshspinedit::TLMDShSpinEdit* FSERightMargin;
	Lmdshspinedit::TLMDShSpinEdit* FSEBottomMargin;
	System::Classes::TNotifyEvent __fastcall GetBottomMarginChange(void);
	System::Classes::TNotifyEvent __fastcall GetLeftMarginChange(void);
	System::Classes::TNotifyEvent __fastcall GetRightMarginChange(void);
	System::Classes::TNotifyEvent __fastcall GetTopMarginChange(void);
	void __fastcall SetBottomMarginChange(const System::Classes::TNotifyEvent Value);
	void __fastcall SetLeftMarginChange(const System::Classes::TNotifyEvent Value);
	void __fastcall SetRightMarginChange(const System::Classes::TNotifyEvent Value);
	void __fastcall SetTopMarginChange(const System::Classes::TNotifyEvent Value);
	
protected:
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDMarginsEditor(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDMarginsEditor(void);
	
__published:
	__property Lmdshspinedit::TLMDShSpinEdit* SETopMargin = {read=FSETopMargin};
	__property Lmdshspinedit::TLMDShSpinEdit* SEBottomMargin = {read=FSEBottomMargin};
	__property Lmdshspinedit::TLMDShSpinEdit* SELeftMargin = {read=FSELeftMargin};
	__property Lmdshspinedit::TLMDShSpinEdit* SERightMargin = {read=FSERightMargin};
	__property System::Classes::TNotifyEvent TopMarginChange = {read=GetTopMarginChange, write=SetTopMarginChange};
	__property System::Classes::TNotifyEvent BottomMarginChange = {read=GetBottomMarginChange, write=SetBottomMarginChange};
	__property System::Classes::TNotifyEvent LeftMarginChange = {read=GetLeftMarginChange, write=SetLeftMarginChange};
	__property System::Classes::TNotifyEvent RightMarginChange = {read=GetRightMarginChange, write=SetRightMarginChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDMarginsEditor(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdmarginseditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDMARGINSEDITOR)
using namespace Plmdmarginseditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdmarginseditorHPP
