// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgComboBox.pas' rev: 31.00 (Windows)

#ifndef LmddsgcomboboxHPP
#define LmddsgcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Themes.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDDsgClass.hpp>
#include <LMDDsgCst.hpp>
#include <LMDDsgObjects.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDObjectComboBox;
class DELPHICLASS TLMDPopupList;
class DELPHICLASS TLMDCustomObjectComboBox;
class DELPHICLASS TLMDObjectComboBox;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDObjectComboBox : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDObjectComboBox(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDObjectComboBox(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDObjectComboBox(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDObjectComboBox(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDObjectComboBox(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDObjectComboBox(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDObjectComboBox(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDObjectComboBox(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDObjectComboBox(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDObjectComboBox(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDObjectComboBox(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDObjectComboBox(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDObjectComboBox(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDDropDownAlign : unsigned char { daLeft, daRight, daCenter };

class PASCALIMPLEMENTATION TLMDPopupList : public Vcl::Stdctrls::TCustomListBox
{
	typedef Vcl::Stdctrls::TCustomListBox inherited;
	
private:
	TLMDCustomObjectComboBox* FComboBox;
	bool FPopup;
	bool FReadOnly;
	int FRowCount;
	System::Classes::TStrings* FItems;
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TMessage &Message);
	void __fastcall SetRowCount(int Value);
	int __fastcall GetBorderSize(void);
	HIDESBASE void __fastcall SetItems(System::Classes::TStrings* const Value);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateWnd(void);
	
public:
	__fastcall TLMDPopupList(TLMDCustomObjectComboBox* AComboBox);
	__fastcall virtual ~TLMDPopupList(void);
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
	__property int RowCount = {read=FRowCount, write=SetRowCount, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPopupList(HWND ParentWindow) : Vcl::Stdctrls::TCustomListBox(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TLMDObjectComboBoxOnGetObjectNamePath)(System::TObject* Sender, System::Classes::TPersistent* AObject, Lmdtypes::TLMDString &ANamePath, Lmdtypes::TLMDString &AClassName);

class PASCALIMPLEMENTATION TLMDCustomObjectComboBox : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	int FDropDownWidth;
	int FDropDownRows;
	TLMDDropDownAlign FDropDownAlign;
	int FButtonWidth;
	bool FHasFocus;
	bool FListVisible;
	bool FListActive;
	TLMDPopupList* FPopupList;
	bool FMouseInControl;
	bool FTracking;
	bool FPressed;
	System::Classes::TNotifyEvent FOnDropDown;
	System::Classes::TNotifyEvent FOnCloseUp;
	bool FReadOnly;
	System::Classes::TPersistent* FSelectedObjectBuffer;
	int FSelectedCountBuffer;
	Lmddsgobjects::TLMDDesignObjects* FListObjects;
	System::TObject* FListObjsNotifier;
	Lmddsgobjects::TLMDDesignObjects* FSelection;
	System::TObject* FSelnNotifier;
	System::Uitypes::TColor FClassNameColor;
	bool FShowClassName;
	bool FShowFocus;
	TLMDObjectComboBoxOnGetObjectNamePath FOnGetObjectNamePath;
	bool FDestroying;
	bool FSortDropDown;
	void __fastcall SetClassNameColor(const System::Uitypes::TColor Value);
	void __fastcall SetShowClassName(const bool Value);
	void __fastcall StopTracking(void);
	void __fastcall TrackButton(int X, int Y);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMBiDiModeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	void __fastcall UpdateView(void);
	void __fastcall PopupListDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall PaintItem(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, int AX, int AY, System::Classes::TPersistent* AObject, bool AIsComboText, bool AIsSelected, bool AIsFocused);
	void __fastcall SetShowFocus(const bool Value);
	bool __fastcall GetDroppedDown(void);
	void __fastcall SetListObjects(Lmddsgobjects::TLMDDesignObjects* const Value);
	void __fastcall SetSelection(Lmddsgobjects::TLMDDesignObjects* const Value);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall CompsChangeNotification(System::TObject* Sender, System::Classes::TList* AChangedComps);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall GetObjectNamePath(System::Classes::TPersistent* AObject, Lmdtypes::TLMDString &ANamePath, Lmdtypes::TLMDString &AClassName);
	virtual void __fastcall DoGetObjectNamePath(System::Classes::TPersistent* AObject, Lmdtypes::TLMDString &ANamePath, Lmdtypes::TLMDString &AClassName);
	virtual void __fastcall DoDropDown(void);
	virtual void __fastcall DoCloseUp(void);
	virtual int __fastcall GetBorderSize(void);
	virtual int __fastcall GetTextHeight(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	System::Uitypes::TColor __fastcall GetThemedBackColor(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__property TabStop = {default=1};
	__property ParentColor = {default=0};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property Lmddsgobjects::TLMDDesignObjects* ListObjects = {read=FListObjects, write=SetListObjects};
	__property Lmddsgobjects::TLMDDesignObjects* Selection = {read=FSelection, write=SetSelection};
	__property System::Uitypes::TColor ClassNameColor = {read=FClassNameColor, write=SetClassNameColor, default=8421504};
	__property bool ShowClassName = {read=FShowClassName, write=SetShowClassName, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property int DropDownRows = {read=FDropDownRows, write=FDropDownRows, default=7};
	__property int DropDownWidth = {read=FDropDownWidth, write=FDropDownWidth, default=0};
	__property TLMDDropDownAlign DropDownAlign = {read=FDropDownAlign, write=FDropDownAlign, default=0};
	__property bool SortDropDown = {read=FSortDropDown, write=FSortDropDown, default=1};
	__property bool DroppedDown = {read=GetDroppedDown, nodefault};
	__property System::Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property System::Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property TLMDObjectComboBoxOnGetObjectNamePath OnGetObjectNamePath = {read=FOnGetObjectNamePath, write=FOnGetObjectNamePath};
	
public:
	__fastcall virtual TLMDCustomObjectComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomObjectComboBox(void);
	virtual void __fastcall CloseUp(bool Accept);
	virtual void __fastcall DropDown(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SelectAll(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomObjectComboBox(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDObjectComboBox : public TLMDCustomObjectComboBox
{
	typedef TLMDCustomObjectComboBox inherited;
	
public:
	__property DroppedDown;
	
__published:
	__property Align = {default=0};
	__property ServiceProvider;
	__property ListObjects;
	__property Selection;
	__property ClassNameColor = {default=8421504};
	__property ShowClassName = {default=1};
	__property ShowFocus = {default=1};
	__property ReadOnly = {default=0};
	__property DropDownRows = {default=7};
	__property DropDownWidth = {default=0};
	__property DropDownAlign = {default=0};
	__property SortDropDown = {default=1};
	__property OnCloseUp;
	__property OnDropDown;
	__property OnGetObjectNamePath;
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TLMDCustomObjectComboBox.Create */ inline __fastcall virtual TLMDObjectComboBox(System::Classes::TComponent* AOwner) : TLMDCustomObjectComboBox(AOwner) { }
	/* TLMDCustomObjectComboBox.Destroy */ inline __fastcall virtual ~TLMDObjectComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDObjectComboBox(HWND ParentWindow) : TLMDCustomObjectComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddsgcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGCOMBOBOX)
using namespace Lmddsgcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgcomboboxHPP
