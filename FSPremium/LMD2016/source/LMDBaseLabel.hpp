// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseLabel.pas' rev: 31.00 (Windows)

#ifndef LmdbaselabelHPP
#define LmdbaselabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Themes.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDVldBase.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbaselabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseLabel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDLabelOption : unsigned char { loPathEllipsis, loEndEllipsis, loEditControl, loShowLabelHint };

typedef System::Set<TLMDLabelOption, TLMDLabelOption::loPathEllipsis, TLMDLabelOption::loShowLabelHint> TLMDLabelOptions;

class PASCALIMPLEMENTATION TLMDBaseLabel : public Lmdbasegraphiccontrol::TLMDBaseGraphicControl
{
	typedef Lmdbasegraphiccontrol::TLMDBaseGraphicControl inherited;
	
private:
	bool FAccelChar;
	bool FDBControl;
	bool FTwinkle;
	bool FMultiLine;
	Lmdgraph::TLMDAlignment FAlignment;
	TLMDLabelOptions FOptions;
	Lmdclass::TLMDTimer* FTwinkleTimerId;
	int FTwinkleVisible;
	int FTwinkleInVisible;
	System::Uitypes::TColor FTwinkleColor;
	bool FAntialiased;
	bool FUseGlobalTimer;
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	void __fastcall SetOptions(TLMDLabelOptions aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetBool(int index, bool aValue);
	void __fastcall SetControl(Vcl::Controls::TWinControl* aValue);
	void __fastcall SetAntialised(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	
protected:
	Vcl::Controls::TWinControl* FControl;
	bool FAutoSize;
	bool FTwinkleFlag;
	bool FCChange;
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	bool __fastcall CheckAntiAliasedState(void);
	void __fastcall OnTwinkleTimer(System::TObject* Sender);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	virtual bool __fastcall GetStatusControl(void);
	System::Word __fastcall GetOptionsFlag(void);
	virtual void __fastcall FontChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDBaseLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBaseLabel(void);
	__classmethod bool __fastcall SystemFontSmoothingState();
	__property bool FontSmoothing = {read=FAntialiased, write=SetAntialised, default=0};
	Vcl::Controls::TWinControl* __fastcall GetControl(void);
	virtual void __fastcall CorrectBounds(void);
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetBool, index=0, default=1};
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property bool DBControl = {read=FDBControl, write=FDBControl, nodefault};
	__property bool StatusBarControl = {read=GetStatusControl, nodefault};
	__property Vcl::Controls::TWinControl* FocusControl = {read=FControl, write=SetControl};
	__property Font;
	__property bool MultiLine = {read=FMultiLine, write=SetBool, index=1, default=0};
	__property TLMDLabelOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property bool ShowAccelChar = {read=FAccelChar, write=SetBool, index=2, default=1};
	__property Transparent = {default=1};
	__property bool Twinkle = {read=FTwinkle, write=SetBool, index=3, default=0};
	__property int TwinkleVisible = {read=FTwinkleVisible, write=SetInteger, index=0, default=700};
	__property int TwinkleInVisible = {read=FTwinkleInVisible, write=SetInteger, index=1, default=700};
	__property System::Uitypes::TColor TwinkleColor = {read=FTwinkleColor, write=FTwinkleColor, default=536870911};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	void __fastcall SetErrorMessage(Lmdtypes::TLMDString val, int errorLevel);
	Lmdtypes::TLMDString __fastcall GetLastErrorMessage(void);
	
__published:
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
private:
	void *__ILMDValidatingMsgControl;	// Lmdvldbase::ILMDValidatingMsgControl 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F85159D2-2952-4FAB-B795-D772368DEBC4}
	operator Lmdvldbase::_di_ILMDValidatingMsgControl()
	{
		Lmdvldbase::_di_ILMDValidatingMsgControl intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdvldbase::ILMDValidatingMsgControl*(void) { return (Lmdvldbase::ILMDValidatingMsgControl*)&__ILMDValidatingMsgControl; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbaselabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASELABEL)
using namespace Lmdbaselabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbaselabelHPP
