// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFFontComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdrtffontcomboboxHPP
#define LmdrtffontcomboboxHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <LMDTypes.hpp>
#include <LMDRTFRichEdit.hpp>
#include <LMDRTFBase.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtffontcombobox
{
//-- forward type declarations -----------------------------------------------
struct TLMDRichFontInfo;
class DELPHICLASS TLMDRichFontComboBox;
class DELPHICLASS TLMDRichFontSizeComboBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDRichFontDevice : unsigned char { fdScreen, fdPrinter, fdBoth };

struct DECLSPEC_DRECORD TLMDRichFontInfo
{
public:
	System::Word FontType;
	System::Word Charset;
};


class PASCALIMPLEMENTATION TLMDRichFontComboBox : public Lmdrtfrichedit::TLMDRichCustomComboBox
{
	typedef Lmdrtfrichedit::TLMDRichCustomComboBox inherited;
	
private:
	Vcl::Graphics::TBitmap* TrueTypeBMP;
	Vcl::Graphics::TBitmap* DeviceBMP;
	TLMDRichFontDevice FDevice;
	bool FTrueTypeOnly;
	bool FUpdate;
	bool FDisplayFont;
	bool FHideAtPrefixedFonts;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMFontChange(Winapi::Messages::TMessage &Message);
	void __fastcall SetFontName(const System::Uitypes::TFontName NewFontName);
	System::Uitypes::TFontName __fastcall GetFontName(void);
	void __fastcall SetDevice(TLMDRichFontDevice Value);
	void __fastcall SetDisplayFont(bool Value);
	void __fastcall SetTrueTypeOnly(bool Value);
	void __fastcall ReadBitmaps(void);
	void __fastcall ResetItemHeight(void);
	void __fastcall Reset(void);
	void __fastcall SetHideAtPrefixedFonts(const bool Value);
	
protected:
	virtual void __fastcall BuildList(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall ChangeSettings(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall UpdateInfo(void);
	
public:
	__fastcall virtual TLMDRichFontComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDRichFontComboBox(void);
	__property Text = {default=0};
	void __fastcall Initialize(void);
	
__published:
	__property Flat = {default=0};
	__property DropDownWidth = {default=0};
	__property TLMDRichFontDevice Device = {read=FDevice, write=SetDevice, default=0};
	__property System::Uitypes::TFontName FontName = {read=GetFontName, write=SetFontName};
	__property bool DisplayFont = {read=FDisplayFont, write=SetDisplayFont, default=0};
	__property bool TrueTypeOnly = {read=FTrueTypeOnly, write=SetTrueTypeOnly, default=0};
	__property bool HideAtPrefixedFonts = {read=FHideAtPrefixedFonts, write=SetHideAtPrefixedFonts, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichFontComboBox(HWND ParentWindow) : Lmdrtfrichedit::TLMDRichCustomComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDRichFontSizeComboBox : public Lmdrtfrichedit::TLMDRichCustomComboBox
{
	typedef Lmdrtfrichedit::TLMDRichCustomComboBox inherited;
	
private:
	System::Uitypes::TFontName FFontName;
	int FVRES;
	bool FUpdate;
	void __fastcall SetFontName(const System::Uitypes::TFontName NewFontName);
	int __fastcall GetFontSize(void);
	void __fastcall SetFontSize(const int Value);
	
protected:
	virtual void __fastcall BuildList(void);
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
	virtual void __fastcall ChangeSettings(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall UpdateInfo(void);
	
public:
	__fastcall virtual TLMDRichFontSizeComboBox(System::Classes::TComponent* AOwner);
	__property Text = {default=0};
	
__published:
	__property Flat = {default=0};
	__property DropDownWidth = {default=0};
	__property System::Uitypes::TFontName FontName = {read=FFontName, write=SetFontName};
	__property int FontSize = {read=GetFontSize, write=SetFontSize, default=10};
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TLMDRichFontSizeComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichFontSizeComboBox(HWND ParentWindow) : Lmdrtfrichedit::TLMDRichCustomComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtffontcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFFONTCOMBOBOX)
using namespace Lmdrtffontcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtffontcomboboxHPP
