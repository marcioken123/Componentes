// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomButtonGroup.pas' rev: 31.00 (Windows)

#ifndef LmdcustombuttongroupHPP
#define LmdcustombuttongroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDCont.hpp>
#include <LMDBaseController.hpp>
#include <LMDGraph.hpp>
#include <LMD3DCaption.hpp>
#include <LMDButtonControl.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <System.UITypes.hpp>
#include <LMDBevel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustombuttongroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomButtonGroup;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChildHelpContextID : unsigned char { ciDefault, ciSameAsParent, ciAutoNumbered };

typedef void __fastcall (__closure *TLMDChildBtnClick)(System::TObject* Sender, int ButtonIndex);

class PASCALIMPLEMENTATION TLMDCustomButtonGroup : public Lmdcustomgroupbox::TLMDCustomGroupBox
{
	typedef Lmdcustomgroupbox::TLMDCustomGroupBox inherited;
	
private:
	Lmdglyphtextlayout::TLMDGlyphTextLayout* FBtnAlignment;
	int FItemHeight;
	int FitemOffset;
	int FColumns;
	bool FFlatGlyphs;
	bool FGlyphFlat;
	bool FUseBitmap;
	bool FUseFocusColor;
	bool FReadOnly;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	Lmdgraph::TLMDGlyphTextFocusStyle FFocusStyle;
	System::Uitypes::TColor FFocusColor;
	TLMDChildBtnClick FOnChange;
	Vcl::Imglist::TCustomImageList* FGlyphImageList;
	int FGlyphListIndex;
	Vcl::Imglist::TChangeLink* FGlyphChangeLink;
	bool FIgnoreItemCount;
	bool FMultiLine;
	void __fastcall SetGlyphImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetGlyphIndex(int index, int aValue);
	void __fastcall ReadGIdent(System::Classes::TReader* Reader);
	void __fastcall WriteGIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckGCont(void);
	bool __fastcall HasGControl(void);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall SetColumns(int aValue);
	void __fastcall SetItems(System::Classes::TStringList* aValue);
	void __fastcall SetItemHeight(int aValue);
	void __fastcall SetItemOffset(int aValue);
	void __fastcall SetID(TLMDChildHelpContextID aValue);
	void __fastcall SetFocusColor(System::Uitypes::TColor aValue);
	void __fastcall SetUseFocusColor(bool aValue);
	void __fastcall SetGlyphFlat(bool aValue);
	void __fastcall SetIgnore(const bool aValue);
	void __fastcall SetGlyphSize(System::Byte aValue);
	void __fastcall SetFlatGlyphs(bool aValue);
	void __fastcall SetBtnAlignment(Lmdglyphtextlayout::TLMDGlyphTextLayout* aValue);
	void __fastcall SetMultiline(const bool Value);
	HIDESBASE void __fastcall SetTransparent(bool aValue);
	void __fastcall SetFocusStyle(Lmdgraph::TLMDGlyphTextFocusStyle aValue);
	HIDESBASE void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetTransparentColor(System::Uitypes::TColor aValue);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	
protected:
	bool FUpdating;
	bool FGlyphTransparent;
	bool FReading;
	int FResult;
	System::Classes::TList* FButtons;
	int FGlyphIndex;
	System::Classes::TStringList* FItems;
	System::Byte FGlyphSize;
	System::Uitypes::TColor FTransparentColor;
	TLMDChildHelpContextID FID;
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall ArrangeButtons(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetButtonCount(int aValue) = 0 ;
	virtual void __fastcall UpdateButtons(void) = 0 ;
	virtual int __fastcall GetFieldValue(void);
	bool __fastcall IMLGlyphEmpty(void);
	void __fastcall GetIMLGlyphChange(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property Lmdgraph::TLMDGlyphTextFocusStyle FocusStyle = {read=FFocusStyle, write=SetFocusStyle, default=1};
	__property bool GlyphTransparent = {read=FGlyphTransparent, write=SetTransparent, default=0};
	__property System::Uitypes::TColor GlyphTransparentColor = {read=FTransparentColor, write=SetTransparentColor, default=32896};
	__property System::Byte GlyphSize = {read=FGlyphSize, write=SetGlyphSize, nodefault};
	__property bool GlyphFlat = {read=FGlyphFlat, write=SetGlyphFlat, default=0};
	__property bool UseBitmap = {read=FUseBitmap, write=FUseBitmap, default=0};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=-1};
	__property int ItemOffset = {read=FitemOffset, write=SetItemOffset, default=4};
	__property bool IgnoreValue = {read=FIgnoreItemCount, write=SetIgnore, default=0};
	__property bool FlatGlyphs = {read=FFlatGlyphs, write=SetFlatGlyphs, default=0};
	__property Lmdglyphtextlayout::TLMDGlyphTextLayout* BtnAlignment = {read=FBtnAlignment, write=SetBtnAlignment};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiline, default=1};
	
public:
	__fastcall virtual TLMDCustomButtonGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomButtonGroup(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	virtual void __fastcall EndUpdate(bool aValue = false);
	virtual bool __fastcall CanModify(void);
	__property System::Classes::TList* Buttons = {read=FButtons};
	void __fastcall RegisterButton(Lmdbuttoncontrol::TLMDButtonControl* btn);
	void __fastcall UnRegisterButton(Lmdbuttoncontrol::TLMDButtonControl* btn);
	__property Bevel;
	__property System::Classes::TStringList* Items = {read=FItems, write=SetItems};
	__property Vcl::Imglist::TCustomImageList* GlyphImageList = {read=FGlyphImageList, write=SetGlyphImageList, stored=HasGControl};
	__property int GlyphImageIndex = {read=FGlyphIndex, write=SetGlyphIndex, index=0, default=0};
	__property int GlyphListIndex = {read=FGlyphListIndex, write=SetGlyphIndex, index=1, default=0};
	__property Font;
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Caption = {default=0};
	__property CaptionFont;
	__property CaptionFont3D;
	__property TLMDChildHelpContextID HelpContextBtn = {read=FID, write=SetID, default=0};
	__property Transparent = {default=0};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property bool UseFocusColor = {read=FUseFocusColor, write=SetUseFocusColor, default=0};
	__property System::Uitypes::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=8421504};
	__property TLMDChildBtnClick OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomButtonGroup(HWND ParentWindow) : Lmdcustomgroupbox::TLMDCustomGroupBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustombuttongroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMBUTTONGROUP)
using namespace Lmdcustombuttongroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustombuttongroupHPP
