// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomImageComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomimagecomboboxHPP
#define LmdcustomimagecomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMD3DCaption.hpp>
#include <LMDCont.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomimagecombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomImageComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomImageComboBox : public Lmdcustomcombobox::TLMDCustomComboBox
{
	typedef Lmdcustomcombobox::TLMDCustomComboBox inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FImageList;
	int FListIndex;
	Vcl::Imglist::TChangeLink* FChangeLink;
	System::WideChar FDelimiter;
	int FDefaultItem;
	Lmdcustomimagelistbox::TLMDImageBoxOptions FOptions;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	Lmdglyphtextlayout::TLMDGlyphTextLayout* FLayout;
	System::Byte FGlyphNumber;
	System::Byte FGlyphColumn;
	bool FMultiline;
	bool FImagesOnly;
	void __fastcall SetImagesOnly(bool aValue);
	void __fastcall SetMultiline(bool aValue);
	void __fastcall UpdateEmptyList(void);
	bool __fastcall StoreItems(void);
	void __fastcall SetDefaultItem(int aValue);
	void __fastcall SetDelimiter(System::WideChar aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetImageIndex(int Index, int aValue);
	void __fastcall SetIndex(int aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetLayout(Lmdglyphtextlayout::TLMDGlyphTextLayout* aValue);
	void __fastcall SetOptions(Lmdcustomimagelistbox::TLMDImageBoxOptions aValue);
	void __fastcall SetGlyphNumber(const System::Byte Value);
	void __fastcall SetGlyphColumn(const System::Byte Value);
	int __fastcall GetImageIndex(int aValue);
	System::UnicodeString __fastcall GetStringValue(int aValue);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &aRect, Winapi::Windows::TOwnerDrawState State);
	virtual int __fastcall GetFieldValue(void);
	virtual System::UnicodeString __fastcall GetItemString(int Index);
	virtual int __fastcall GetImageHeight(int aValue);
	virtual int __fastcall GetImageWidth(int aValue);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	bool __fastcall IMLEmpty(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDCustomImageComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomImageComboBox(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Init(void);
	__property Canvas;
	__property Text = {default=0};
	__property CtlXP = {default=1};
	__property int ImageIndexValue[int Index] = {read=GetImageIndex, write=SetImageIndex};
	__property System::UnicodeString StringValue[int Index] = {read=GetStringValue};
	
__published:
	__property About = {default=0};
	__property Lmdcustomimagelistbox::TLMDImageBoxOptions Options = {read=FOptions, write=SetOptions, default=3};
	__property System::WideChar Delimiter = {read=FDelimiter, write=SetDelimiter, default=124};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ListIndex = {read=FListIndex, write=SetIndex, default=0};
	__property Lmdglyphtextlayout::TLMDGlyphTextLayout* Layout = {read=FLayout, write=SetLayout};
	__property int DefaultItem = {read=FDefaultItem, write=SetDefaultItem, default=-1};
	__property System::Byte GlyphNumber = {read=FGlyphNumber, write=SetGlyphNumber, default=1};
	__property System::Byte GlyphColumn = {read=FGlyphColumn, write=SetGlyphColumn, default=0};
	__property bool ImagesOnly = {read=FImagesOnly, write=SetImagesOnly, default=0};
	__property ItemIndex;
	__property Items = {stored=StoreItems};
	__property bool MultiLine = {read=FMultiline, write=SetMultiline, default=0};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {index=0, default=0};
	__property Enabled = {default=1};
	__property Flat = {index=0, default=0};
	__property FocusControl;
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ItemHeight;
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnSelect;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnCloseUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomImageComboBox(HWND ParentWindow) : Lmdcustomcombobox::TLMDCustomComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomimagecombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMIMAGECOMBOBOX)
using namespace Lmdcustomimagecombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomimagecomboboxHPP
