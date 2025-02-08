// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextListBox.pas' rev: 31.00 (Windows)

#ifndef LmdtextlistboxHPP
#define LmdtextlistboxHPP

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
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDTextObject.hpp>
#include <LMDText.hpp>
#include <LMDCustomListBox.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextListBox : public Lmdcustomimagelistbox::TLMDCustomImageListBox
{
	typedef Lmdcustomimagelistbox::TLMDCustomImageListBox inherited;
	
private:
	Lmdtextobject::TLMDTextObject* FText;
	bool FWordWrap;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	void __fastcall SetTextObject(Lmdtextobject::TLMDTextObject* aValue);
	
protected:
	void __fastcall DoGraphicError(System::TObject* Sender, Vcl::Graphics::TPicture* aPicture, const System::UnicodeString aFileName, int aImageIndex);
	virtual System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	void __fastcall DoTxtChange(System::TObject* Sender);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	
public:
	__fastcall virtual TLMDTextListBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextListBox(void);
	virtual void __fastcall Loaded(void);
	
__published:
	__property Items;
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
	__property GlyphNumber = {default=1};
	__property GlyphColumn = {default=0};
	__property ItemIndex = {default=-1};
	__property ImageList;
	__property ListIndex = {default=0};
	__property Layout;
	__property ImagesOnly = {default=0};
	__property MultiLine = {default=0};
	__property Margin = {default=1};
	__property Columns = {default=0};
	__property LargeTextOptions = {default=0};
	__property VerticalScrollBar = {default=1};
	__property HorzGridColor = {default=12632256};
	__property HorzGridStyle = {default=0};
	__property HorzGridLine = {default=0};
	__property EditOptions = {default=0};
	__property OnEditShow;
	__property OnEditMeasure;
	__property OnEditChange;
	__property OnEditHide;
	__property AutoComplete = {default=1};
	__property VirtualMode = {default=0};
	__property OnData;
	__property OnDataObject;
	__property OnDataFind;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextListBox(HWND ParentWindow) : Lmdcustomimagelistbox::TLMDCustomImageListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTLISTBOX)
using namespace Lmdtextlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextlistboxHPP
