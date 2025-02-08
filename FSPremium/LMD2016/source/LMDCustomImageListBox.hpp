// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomImageListBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomimagelistboxHPP
#define LmdcustomimagelistboxHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDCont.hpp>
#include <LMDGraph.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDBase.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomimagelistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomImageListBox;
class DELPHICLASS TLMDCustomDerivedImageListBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDImageBoxOption : unsigned char { lboImageListOrder, lboCheckImageNr, lboCalcHeight, lboTransparentImages };

typedef System::Set<TLMDImageBoxOption, TLMDImageBoxOption::lboImageListOrder, TLMDImageBoxOption::lboTransparentImages> TLMDImageBoxOptions;

class PASCALIMPLEMENTATION TLMDCustomImageListBox : public Lmdcustomlistbox::TLMDCustomListBox
{
	typedef Lmdcustomlistbox::TLMDCustomListBox inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FImageList;
	int FListIndex;
	Vcl::Imglist::TChangeLink* FChangeLink;
	int FDefaultItem;
	TLMDImageBoxOptions FOptions;
	Lmdglyphtextlayout::TLMDGlyphTextLayout* FLayout;
	System::WideChar FDelimiter;
	bool FImagesOnly;
	System::Byte FGlyphNumber;
	System::Byte FGlyphColumn;
	void __fastcall SetImagesOnly(bool aValue);
	void __fastcall UpdateEmptyList(void);
	bool __fastcall StoreItems(void);
	void __fastcall SetDefaultItem(int aValue);
	void __fastcall SetDelimiter(System::WideChar aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetImageIndex(int Index, int aValue);
	void __fastcall SetIndex(int aValue);
	void __fastcall SetLayout(Lmdglyphtextlayout::TLMDGlyphTextLayout* aValue);
	void __fastcall SetOptions(TLMDImageBoxOptions aValue);
	int __fastcall GetImageIndex(int aValue);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	void __fastcall SetGlyphNumber(const System::Byte Value);
	void __fastcall SetGlyphColumn(const System::Byte Value);
	
protected:
	virtual System::UnicodeString __fastcall GetStringValue(int aValue);
	virtual int __fastcall GetHorzExtent(int index);
	virtual int __fastcall GetImageHeight(int aValue);
	virtual int __fastcall GetImageWidth(int aValue);
	virtual bool __fastcall CanEdit(void);
	virtual System::Types::TRect __fastcall GetEditRect(int index);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &aRect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	bool __fastcall IMLEmpty(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDCustomImageListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomImageListBox(void);
	__property CtlXP;
	__property Canvas;
	__property Text = {default=0};
	__property int ImageIndexValue[int Index] = {read=GetImageIndex, write=SetImageIndex};
	__property Items = {stored=StoreItems};
	__property Lmdglyphtextlayout::TLMDGlyphTextLayout* Layout = {read=FLayout, write=SetLayout};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ListIndex = {read=FListIndex, write=SetIndex, default=0};
	__property bool ImagesOnly = {read=FImagesOnly, write=SetImagesOnly, default=0};
	__property System::Byte GlyphNumber = {read=FGlyphNumber, write=SetGlyphNumber, default=1};
	__property System::Byte GlyphColumn = {read=FGlyphColumn, write=SetGlyphColumn, default=0};
	
__published:
	__property Ctl3D;
	__property System::WideChar Delimiter = {read=FDelimiter, write=SetDelimiter, default=124};
	__property TLMDImageBoxOptions Options = {read=FOptions, write=SetOptions, default=3};
	__property int DefaultItem = {read=FDefaultItem, write=SetDefaultItem, default=-1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomImageListBox(HWND ParentWindow) : Lmdcustomlistbox::TLMDCustomListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomDerivedImageListBox : public Lmdcustomlistbox::TLMDCustomListBox
{
	typedef Lmdcustomlistbox::TLMDCustomListBox inherited;
	
private:
	void __fastcall ReadChar(System::Classes::TReader* Reader);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall ReadInteger(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
public:
	/* TLMDCustomListBox.Create */ inline __fastcall virtual TLMDCustomDerivedImageListBox(System::Classes::TComponent* AOwner) : Lmdcustomlistbox::TLMDCustomListBox(AOwner) { }
	/* TLMDCustomListBox.Destroy */ inline __fastcall virtual ~TLMDCustomDerivedImageListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomDerivedImageListBox(HWND ParentWindow) : Lmdcustomlistbox::TLMDCustomListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomimagelistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMIMAGELISTBOX)
using namespace Lmdcustomimagelistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomimagelistboxHPP
