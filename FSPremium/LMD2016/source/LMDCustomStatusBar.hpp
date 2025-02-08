// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomStatusBar.pas' rev: 31.00 (Windows)

#ifndef LmdcustomstatusbarHPP
#define LmdcustomstatusbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <LMDBevel.hpp>
#include <LMD3DCaption.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDVldBase.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomstatusbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStatusCustomPanel;
class DELPHICLASS TLMDStatusPanel;
class DELPHICLASS TLMDStatusPanels;
class DELPHICLASS TLMDCustomStatusBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDStatusPanelStyle : unsigned char { spText, spOwnerDraw, spPanel };

class PASCALIMPLEMENTATION TLMDStatusCustomPanel : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	int FId;
	HIDESBASE void __fastcall ReadIdent(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__property int BarPanelId = {read=FId, write=FId, nodefault};
	
__published:
	__property Color = {default=-16777201};
	__property ParentColor = {default=0};
public:
	/* TLMDCustomPanel.Create */ inline __fastcall virtual TLMDStatusCustomPanel(System::Classes::TComponent* aOwner) : Lmdcustompanel::TLMDCustomPanel(aOwner) { }
	/* TLMDCustomPanel.Destroy */ inline __fastcall virtual ~TLMDStatusCustomPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStatusCustomPanel(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStatusPanel : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdgraph::TLMDAlignment FAlignment;
	Lmdbevel::TLMDBevel* FBevel;
	TLMDStatusPanelStyle FStyle;
	System::UnicodeString FText;
	int FBarPanelId;
	int FLeft;
	int FTag;
	int FSize;
	Vcl::Graphics::TFont* FFont;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	TLMDStatusCustomPanel* FControl;
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetText(System::UnicodeString aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	void __fastcall SetStyle(TLMDStatusPanelStyle aValue);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDStatusPanel(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDStatusPanel(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TLMDStatusCustomPanel* Control = {read=FControl, write=FControl};
	__property int BarPanelId = {read=FBarPanelId, write=FBarPanelId, stored=true, default=-1};
	
__published:
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property TLMDStatusPanelStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int Size = {read=FSize, write=SetInteger, index=0, default=50};
	__property int Left = {read=FLeft, write=SetInteger, index=1, default=3};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Index;
	__property DisplayName = {default=0};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStatusPanels : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDStatusPanel* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDCustomStatusBar* FStatusBar;
	HIDESBASE TLMDStatusPanel* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDStatusPanel* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDStatusPanels(TLMDCustomStatusBar* StatusBar);
	__fastcall virtual ~TLMDStatusPanels(void);
	HIDESBASE TLMDStatusPanel* __fastcall Add(void);
	__property TLMDStatusPanel* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDOwnerDrawPanel)(System::TObject* Sender, int Nr, const System::Types::TRect &aRect, Vcl::Graphics::TCanvas* Canvas);

typedef void __fastcall (__closure *TLMDOnPanelClick)(System::TObject* Sender, int Nr);

class PASCALIMPLEMENTATION TLMDCustomStatusBar : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	Lmdgraph::TLMDAlignment FAlignment;
	System::UnicodeString FSimpleText;
	bool FAutoSizeLastPanel;
	bool FOldStyle;
	bool FSimplePanel;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	TLMDStatusPanels* FPanels;
	int FGap;
	TLMDOwnerDrawPanel FOnOwnerDrawPanel;
	TLMDOnPanelClick FOnPanelClick;
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetSimpleText(System::UnicodeString aValue);
	HIDESBASE void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetGap(int aValue);
	void __fastcall SetPanels(TLMDStatusPanels* aValue);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	
protected:
	System::Types::TRect InnerRect;
	int FValidationPanelNumber;
	void __fastcall UpdatePanel(int Nr);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property System::UnicodeString SimpleText = {read=FSimpleText, write=SetSimpleText};
	__property bool SimplePanel = {read=FSimplePanel, write=SetBoolean, index=0, default=0};
	__property SizeGrip = {default=1};
	__property bool OldStyle = {read=FOldStyle, write=SetBoolean, index=2, default=1};
	__property bool AutoSizeLastPanel = {read=FAutoSizeLastPanel, write=SetBoolean, index=3, default=1};
	__property int ControlGap = {read=FGap, write=SetGap, default=0};
	__property TLMDStatusPanels* Panels = {read=FPanels, write=SetPanels};
	__property TLMDOwnerDrawPanel OnOwnerDrawPanel = {read=FOnOwnerDrawPanel, write=FOnOwnerDrawPanel};
	__property TLMDOnPanelClick OnPanelClick = {read=FOnPanelClick, write=FOnPanelClick};
	__property int ValidationPanelNumber = {read=FValidationPanelNumber, write=FValidationPanelNumber, nodefault};
	
public:
	__fastcall virtual TLMDCustomStatusBar(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomStatusBar(void);
	virtual int __fastcall GetControlGap(void);
	void __fastcall SetErrorMessage(Lmdtypes::TLMDString val, int ErrorLevel);
	Lmdtypes::TLMDString __fastcall GetLastErrorMessage(void);
	
__published:
	__property About = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomStatusBar(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
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
}	/* namespace Lmdcustomstatusbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSTATUSBAR)
using namespace Lmdcustomstatusbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomstatusbarHPP
