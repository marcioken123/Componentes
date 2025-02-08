// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElHTMLLbl.pas' rev: 31.00 (Windows)

#ifndef ElhtmllblHPP
#define ElhtmllblHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDUtils.hpp>
#include <LMDThemes.hpp>
#include <ElVCLUtils.hpp>
#include <ElCLabel.hpp>
#include <ElXPThemedControl.hpp>
#include <ElHTMLContainer.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elhtmllbl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElHTMLLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElHTMLLabel : public Elclabel::TCustomElLabel
{
	typedef Elclabel::TCustomElLabel inherited;
	
private:
	bool FAlreadyInSetBounds;
	Elhtmlcontainer::TElHTMLContainer* FContainer;
	int FIndex;
	Elhtmlcontainer::TElHTMLChangeLink* FChangeLink;
	bool FCheck;
	System::Uitypes::TCursor FCursor;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	bool FIsHTML;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeededEx;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	Lmdtypes::TLMDString FHint;
	void __fastcall DoCaptionChange(System::TObject* Sender);
	HIDESBASE void __fastcall SetCursor(System::Uitypes::TCursor newValue);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	void __fastcall SetContainer(Elhtmlcontainer::TElHTMLContainer* aValue);
	void __fastcall SetIndex(int aValue);
	void __fastcall SetIsHTML(bool newValue);
	void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	HIDESBASE void __fastcall SetWordWrap(bool newValue);
	Lmdtypes::TLMDString __fastcall GetPlainText(void);
	Lmdtypes::TLMDString __fastcall GetCaptionText(void);
	bool __fastcall GetWordWrap(void);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall AdjustBounds(void);
	System::Types::TRect __fastcall CalcTextRect(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DoDrawText(System::Types::TRect &Rect, int Flags);
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	bool __fastcall GetEmpty(void);
	bool __fastcall LinkEmpty(void);
	System::Types::TRect __fastcall GetTextRect(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	virtual void __fastcall SetAutoSize(bool newValue);
	virtual void __fastcall SetName(const System::Classes::TComponentName Value);
	virtual void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	void __fastcall TriggerImageNeededExEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	void __fastcall TriggerRenderChange(System::TObject* Sender);
	void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	HIDESBASE void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	
public:
	__fastcall virtual TElHTMLLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElHTMLLabel(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property System::Types::TRect TextRect = {read=GetTextRect};
	__property Lmdtypes::TLMDString PlainText = {read=GetPlainText};
	
__published:
	__property Elhtmlcontainer::TElHTMLContainer* Container = {read=FContainer, write=SetContainer};
	__property int ContainerIndex = {read=FIndex, write=SetIndex, default=0};
	__property bool CheckContainerLinks = {read=FCheck, write=FCheck, default=1};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=0};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=1};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeededEx = {read=FOnImageNeededEx, write=FOnImageNeededEx};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property Lmdhtmlunit::TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
	__property EndEllipsis = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property AutoSize = {default=1};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color;
	__property Constraints;
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Transparent = {default=1};
	__property Layout = {default=0};
	__property Visible = {default=1};
	__property ShowAccelChar = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnEndDock;
	__property OnStartDock;
	__property OnStartDrag;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elhtmllbl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELHTMLLBL)
using namespace Elhtmllbl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElhtmllblHPP
