// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sFrameBar.pas' rev: 27.00 (Windows)

#ifndef SframebarHPP
#define SframebarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <sScrollBox.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sframebar
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsTitleState : unsigned char { stClosed, stOpened, stClosing, stOpening };

class DELPHICLASS TsTitleItem;
typedef void __fastcall (__closure *TOnFrameChangeEvent)(System::TObject* Sender, TsTitleItem* TitleItem);

typedef void __fastcall (__closure *TOnFrameChangingEvent)(System::TObject* Sender, TsTitleItem* NewTitleItem, bool &CanChange);

typedef void __fastcall (__closure *TOnFrameClosingEvent)(System::TObject* Sender, TsTitleItem* TitleItem, bool &CanClose);

class DELPHICLASS TsFrameBar;
class DELPHICLASS TsTitles;
class PASCALIMPLEMENTATION TsFrameBar : public Sscrollbox::TsScrollBox
{
	typedef Sscrollbox::TsScrollBox inherited;
	
private:
	TsTitles* FItems;
	int FTitleHeight;
	bool FAnimation;
	Vcl::Imglist::TCustomImageList* FImages;
	int FSpacing;
	bool FAllowAllClose;
	bool FAllowAllOpen;
	bool FAutoFrameSize;
	int FBorderWidth;
	TOnFrameChangeEvent FOnChange;
	TOnFrameChangingEvent FOnChanging;
	TOnFrameClosingEvent FOnClosing;
	int FActiveFrame;
	void __fastcall SetItems(TsTitles* const Value);
	void __fastcall SetTitleHeight(const int Value);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	int __fastcall Offset(void);
	void __fastcall UpdateWidths(void);
	void __fastcall SetSpacing(const int Value);
	System::Types::TRect __fastcall CalcClientRect(void);
	Vcl::Forms::TFrame* __fastcall CreateDefaultFrame(void);
	bool __fastcall UpdateFrame(int i, int y, int h, int w);
	void __fastcall SetAutoFrameSize(const bool Value);
	void __fastcall SetAllowAllOpen(const bool Value);
	HIDESBASE void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetActiveFrame(const int Value);
	
public:
	bool Arranging;
	bool Sizing;
	__fastcall virtual TsFrameBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsFrameBar(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall ArrangeTitles(void);
	void __fastcall UpdatePositions(bool DoRepaint = true);
	void __fastcall ChangeSize(int Index, bool AllowAnimation, int Height);
	void __fastcall OpenItem(int Index, bool AllowAnimation);
	void __fastcall CloseItem(int Index, bool AllowAnimation);
	void __fastcall ExpandAll(bool AllowAnimation);
	void __fastcall CollapseAll(bool AllowAnimation);
	void __fastcall Rearrange(void);
	
__published:
	__property Align = {default=3};
	__property BorderStyle = {default=1};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=2};
	__property int ActiveFrameIndex = {read=FActiveFrame, write=SetActiveFrame, nodefault};
	__property bool AllowAllClose = {read=FAllowAllClose, write=FAllowAllClose, default=0};
	__property bool AllowAllOpen = {read=FAllowAllOpen, write=SetAllowAllOpen, default=0};
	__property bool Animation = {read=FAnimation, write=FAnimation, default=1};
	__property bool AutoFrameSize = {read=FAutoFrameSize, write=SetAutoFrameSize, nodefault};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TsTitles* Items = {read=FItems, write=SetItems};
	__property int TitleHeight = {read=FTitleHeight, write=SetTitleHeight, default=28};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=2};
	__property TOnFrameChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TOnFrameChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TOnFrameClosingEvent OnClosing = {read=FOnClosing, write=FOnClosing};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsFrameBar(HWND ParentWindow) : Sscrollbox::TsScrollBox(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TsTitles : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TsTitleItem* operator[](int Index) { return Items[Index]; }
	
private:
	TsFrameBar* FOwner;
	
protected:
	HIDESBASE TsTitleItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TsTitleItem* Value);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TsTitles(TsFrameBar* AOwner);
	__fastcall virtual ~TsTitles(void);
	__property TsTitleItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class DELPHICLASS TsTitleButton;
class PASCALIMPLEMENTATION TsTitleButton : public Sspeedbutton::TsSpeedButton
{
	typedef Sspeedbutton::TsSpeedButton inherited;
	
protected:
	TsFrameBar* FOwner;
	bool Active;
	
public:
	TsTitleItem* TitleItem;
	__fastcall TsTitleButton(TsFrameBar* AOwner, int Index);
	__fastcall virtual TsTitleButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsTitleButton(void);
	virtual int __fastcall CurrentState(void);
	__property TextAlignment = {default=0};
	__property OnClick;
};


typedef void __fastcall (__closure *TCreateFrameEvent)(System::TObject* Sender, Vcl::Forms::TCustomFrame* &Frame);

typedef void __fastcall (__closure *TFrameDestroyEvent)(System::TObject* Sender, Vcl::Forms::TCustomFrame* &Frame, bool &CanDestroy);

class PASCALIMPLEMENTATION TsTitleItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TsTitles* FOwner;
	System::UnicodeString FCaption;
	bool FVisible;
	TCreateFrameEvent FOnCreateFrame;
	int FImageIndex;
	TFrameDestroyEvent FOnFrameDestroy;
	System::Classes::TNotifyEvent FOnClick;
	int FTag;
	System::Uitypes::TCursor FCursor;
	System::Classes::TNotifyEvent FOnTitleItemDestroy;
	System::Classes::TNotifyEvent FOnFrameShow;
	System::Classes::TNotifyEvent FOnFrameClose;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall TitleButtonClick(System::TObject* Sender);
	System::UnicodeString __fastcall GetSkinSection(void);
	void __fastcall SetSkinSection(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	int __fastcall GetMargin(void);
	int __fastcall GetSpacing(void);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetSpacing(const int Value);
	Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	void __fastcall SetPopupMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetCursor(const System::Uitypes::TCursor Value);
	System::Classes::TAlignment __fastcall GetTextAlignment(void);
	void __fastcall SetTextAlignment(const System::Classes::TAlignment Value);
	
protected:
	virtual void __fastcall SetIndex(int Value);
	
public:
	TsTitleButton* TitleButton;
	Vcl::Forms::TCustomFrame* Frame;
	TsTitleState State;
	int FrameSize;
	bool Closing;
	System::TObject* Obj;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual ~TsTitleItem(void);
	__fastcall virtual TsTitleItem(System::Classes::TCollection* Collection);
	
__published:
	__property DisplayName = {default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property System::UnicodeString SkinSection = {read=GetSkinSection, write=SetSkinSection};
	__property int Margin = {read=GetMargin, write=SetMargin, default=5};
	__property int Spacing = {read=GetSpacing, write=SetSpacing, default=8};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property System::Classes::TAlignment TextAlignment = {read=GetTextAlignment, write=SetTextAlignment, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=GetPopupMenu, write=SetPopupMenu};
	__property TCreateFrameEvent OnCreateFrame = {read=FOnCreateFrame, write=FOnCreateFrame};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDestroy = {read=FOnTitleItemDestroy, write=FOnTitleItemDestroy};
	__property TFrameDestroyEvent OnFrameDestroy = {read=FOnFrameDestroy, write=FOnFrameDestroy};
	__property System::Classes::TNotifyEvent OnFrameShow = {read=FOnFrameShow, write=FOnFrameShow};
	__property System::Classes::TNotifyEvent OnFrameClose = {read=FOnFrameClose, write=FOnFrameClose};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sframebar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SFRAMEBAR)
using namespace Sframebar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SframebarHPP
