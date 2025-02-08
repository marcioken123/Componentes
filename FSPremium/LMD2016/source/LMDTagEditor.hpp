// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTagEditor.pas' rev: 31.00 (Windows)

#ifndef LmdtageditorHPP
#define LmdtageditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDTypes.hpp>
#include <LMDFlowPanel.hpp>
#include <LMDEdit.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDFigures.hpp>
#include <LMDFillers.hpp>
#include <LMDCustomControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDGraph.hpp>
#include <LMDGradientFrames.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDButtonBase.hpp>
#include <LMDGlyph.hpp>
#include <LMDMain.hpp>
#include <LMDFXCaption.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtageditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTagControl;
class DELPHICLASS TLMDTag;
class DELPHICLASS TLMDTags;
class DELPHICLASS TLMDTagProperties;
class DELPHICLASS TLMDTagEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTagControl : public Lmdcustomspeedbutton::TLMDCustomSpeedButton
{
	typedef Lmdcustomspeedbutton::TLMDCustomSpeedButton inherited;
	
private:
	bool FMouseOnGlyph;
	
protected:
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall InformOptionSet(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TLMDTagControl(System::Classes::TComponent* AOwner);
public:
	/* TLMDCustomSpeedButton.Destroy */ inline __fastcall virtual ~TLMDTagControl(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTag : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FHint;
	System::UnicodeString FCaption;
	TLMDTagControl* FTagControl;
	bool __fastcall GetPressed(void);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetPressed(const bool Value);
	void __fastcall SetTagControl(TLMDTagControl* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	
public:
	__fastcall virtual TLMDTag(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDTag(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TLMDTagControl* TagControl = {read=FTagControl, write=SetTagControl};
	
__published:
	__property System::UnicodeString Text = {read=FCaption, write=SetText};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property bool Pressed = {read=GetPressed, write=SetPressed, default=0};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDTags : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
private:
	Vcl::Controls::TWinControl* FOwner;
	System::Classes::TNotifyEvent FOnChange;
	bool FCaseSensetive;
	HIDESBASE TLMDTag* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDTag* Value);
	TLMDTagControl* __fastcall GetItemControl(int Index);
	
protected:
	void __fastcall Change(void);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLMDTags(Vcl::Controls::TWinControl* Owner);
	__fastcall virtual ~TLMDTags(void);
	HIDESBASE TLMDTag* __fastcall Add(void);
	int __fastcall IndexOf(const Lmdtypes::TLMDString ASearch);
	int __fastcall IndexOfObject(TLMDTagControl* const AObject);
	__property TLMDTag* Items[int Index] = {read=GetItem, write=SetItem};
	__property TLMDTagControl* Objects[int Index] = {read=GetItemControl};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool CaseSensitive = {read=FCaseSensetive, write=FCaseSensetive, nodefault};
};


class PASCALIMPLEMENTATION TLMDTagProperties : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Lmdbuttonlayout::TLMDButtonLayout* FLayout;
	System::Classes::TNotifyEvent FOnChanged;
	Lmdclass::TLMDThemeMode FThemeMode;
	Lmdfxcaption::TLMDFxCaption* FFontFX;
	Vcl::Graphics::TFont* FFont;
	System::Uitypes::TCursor FCursor;
	Lmdbuttonbase::TLMDUserButtonStyle FStyle;
	void __fastcall SetCursor(const System::Uitypes::TCursor Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetFontFX(Lmdfxcaption::TLMDFxCaption* const Value);
	void __fastcall SetLayout(Lmdbuttonlayout::TLMDButtonLayout* const Value);
	void __fastcall SetOnChanged(const System::Classes::TNotifyEvent Value);
	void __fastcall SetStyle(const Lmdbuttonbase::TLMDUserButtonStyle Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	
protected:
	virtual void __fastcall AssignTo(System::Classes::TPersistent* AObject);
	void __fastcall Changed(void);
	__property System::Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=SetOnChanged};
	
public:
	__fastcall TLMDTagProperties(void);
	__fastcall virtual ~TLMDTagProperties(void);
	
__published:
	__property Lmdbuttonbase::TLMDUserButtonStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=-2};
	__property Lmdbuttonlayout::TLMDButtonLayout* Layout = {read=FLayout, write=SetLayout};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFX, write=SetFontFX};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=0};
};


class PASCALIMPLEMENTATION TLMDTagEditor : public Lmdflowpanel::TLMDCustomFlowPanel
{
	typedef Lmdflowpanel::TLMDCustomFlowPanel inherited;
	
private:
	int FMinEditorWidth;
	bool FDisableCorrectWidth;
	Vcl::Graphics::TBitmap* FDeleteGlyph;
	Vcl::Graphics::TBitmap* FDeleteHighlightGlyph;
	bool FSelectDuplicatedTags;
	bool FMultiselect;
	TLMDTagProperties* FTagProperties;
	void __fastcall CorrectEditorWidth(void);
	void __fastcall SetMinEditorWidth(const int Value);
	TLMDTagControl* __fastcall CreateTagControl(const System::UnicodeString ATag);
	void __fastcall SetupMinEditorWidth(void);
	void __fastcall SetMultiselect(const bool Value);
	void __fastcall SetGlyphDelete(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetGlyphDeleteHighlight(Vcl::Graphics::TBitmap* const Value);
	
protected:
	TLMDTagControl* FTag;
	TLMDTags* FTags;
	Lmdedit::TLMDEdit* FEditor;
	void __fastcall SetCaseSensetive(const bool Value);
	bool __fastcall GetCaseSensetive(void);
	virtual void __fastcall Paint(void);
	void __fastcall DoEditorKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TLMDTagEditor(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTagEditor(void);
	virtual bool __fastcall AddTag(const System::UnicodeString ATag);
	virtual bool __fastcall RemoveTag(const System::UnicodeString ATag)/* overload */;
	virtual bool __fastcall RemoveTag(TLMDTagControl* const ATag)/* overload */;
	virtual bool __fastcall RemoveTag(const int ATagIndex)/* overload */;
	virtual bool __fastcall SelectTag(const System::UnicodeString ATag)/* overload */;
	virtual bool __fastcall SelectTag(TLMDTagControl* const ATag)/* overload */;
	virtual bool __fastcall SelectTag(const int ATagIndex)/* overload */;
	
__published:
	__property bool CaseSensetive = {read=GetCaseSensetive, write=SetCaseSensetive, default=0};
	__property int MinEditorWidth = {read=FMinEditorWidth, write=SetMinEditorWidth, default=20};
	__property bool SelectDuplicatedTags = {read=FSelectDuplicatedTags, write=FSelectDuplicatedTags, default=0};
	__property bool Multiselect = {read=FMultiselect, write=SetMultiselect, nodefault};
	__property Vcl::Graphics::TBitmap* GlyphDelete = {read=FDeleteGlyph, write=SetGlyphDelete};
	__property Vcl::Graphics::TBitmap* GlyphDeleteHighlight = {read=FDeleteHighlightGlyph, write=SetGlyphDeleteHighlight};
	__property TLMDTagProperties* TagProperties = {read=FTagProperties};
	__property TLMDTags* Tags = {read=FTags};
	__property BorderMargins;
	__property ControlsPaddingX = {default=3};
	__property ControlsPaddingY = {default=3};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTagEditor(HWND ParentWindow) : Lmdflowpanel::TLMDCustomFlowPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtageditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTAGEDITOR)
using namespace Lmdtageditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtageditorHPP
