// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFontListBox.pas' rev: 31.00 (Windows)

#ifndef LmdfontlistboxHPP
#define LmdfontlistboxHPP

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
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDFontComboBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomListBox.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfontlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFontListBox;
class DELPHICLASS TLMDLabeledFontListBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFontListExampleAlign : unsigned char { eaListRightTop, eaMousePos, eaRow };

class PASCALIMPLEMENTATION TLMDFontListBox : public Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox
{
	typedef Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox inherited;
	
private:
	Lmdfontcombobox::TLMDFontCBOptions FOptions;
	Vcl::Graphics::TBitmap* FBuffer;
	bool FShowExample;
	Vcl::Controls::THintWindow* FHintWnd;
	int FLastExample;
	int FExampleFontSize;
	System::UnicodeString FExampleText;
	TLMDFontListExampleAlign FExampleAlign;
	System::Types::TPoint FMousePos;
	System::Classes::TNotifyEvent FSizeChange;
	void __fastcall SetOptions(Lmdfontcombobox::TLMDFontCBOptions aValue);
	void __fastcall SetSelectedFont(const System::Uitypes::TFontName aValue);
	System::Uitypes::TFontName __fastcall GetSelectedFont(void);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMCAPTURECHANGED(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChange(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &pRect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall ShowExampleFor(int i);
	virtual void __fastcall DoSelect(void);
	__property System::Classes::TNotifyEvent OnFontChange = {read=FSizeChange, write=FSizeChange};
	
public:
	void __fastcall CreateFontList(void);
	__fastcall virtual TLMDFontListBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDFontListBox(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Init(void);
	__property System::Uitypes::TFontName SelectedFont = {read=GetSelectedFont, write=SetSelectedFont};
	
__published:
	__property Lmdfontcombobox::TLMDFontCBOptions Options = {read=FOptions, write=SetOptions, default=18};
	__property System::UnicodeString ExampleText = {read=FExampleText, write=FExampleText};
	__property int ExampleFontSize = {read=FExampleFontSize, write=FExampleFontSize, default=12};
	__property TLMDFontListExampleAlign ExampleAlign = {read=FExampleAlign, write=FExampleAlign, default=0};
	__property bool ShowExample = {read=FShowExample, write=FShowExample, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFontListBox(HWND ParentWindow) : Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledFontListBox : public TLMDFontListBox
{
	typedef TLMDFontListBox inherited;
	
public:
	__fastcall virtual TLMDLabeledFontListBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDFontListBox.Destroy */ inline __fastcall virtual ~TLMDLabeledFontListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledFontListBox(HWND ParentWindow) : TLMDFontListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfontlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFONTLISTBOX)
using namespace Lmdfontlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfontlistboxHPP
