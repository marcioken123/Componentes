// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElFormDisplay.pas' rev: 31.00 (Windows)

#ifndef ElformdisplayHPP
#define ElformdisplayHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDElConst.hpp>
#include <LMDProcs.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <ElPanel.hpp>
#include <ElHTMLLbl.hpp>
#include <ElFormContainer.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDGraph.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElImgFrm.hpp>
#include <LMDClass.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elformdisplay
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElFormDisplayChangeLink;
class DELPHICLASS TElFormDisplay;
class DELPHICLASS TElFDHTMLForm;
class DELPHICLASS EElFormDisplay;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElAlignment : unsigned char { agTopLeft, agTopCenter, agTopRight, agCenterLeft, agCenter, agCenterRight, agBottomLeft, agBottomCenter, agBottomRight };

typedef void __fastcall (__closure *TElFormDisplayChangeEvent)(System::TObject* Sender, Vcl::Forms::TCustomForm* NewForm, bool &Cancel);

typedef void __fastcall (__closure *TElFDMessageEvent)(System::TObject* Sender, Winapi::Messages::TMessage &Message);

enum DECLSPEC_DENUM TElFormDisplayPosition : unsigned char { fdpTopLeft, fdpTopCenter, fdpTopRight, fdpCenterLeft, fdpCenter, fdpCenterRight, fdpBottomLeft, fdpBottomCenter, fdpBottomRight, fdpClient };

class PASCALIMPLEMENTATION TElFormDisplayChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElFormDisplay* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TElFormDisplayChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TElFormDisplay* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TElFormDisplayChangeLink(void) : System::TObject() { }
	
};


class PASCALIMPLEMENTATION TElFormDisplay : public Elpanel::TCustomElPanel
{
	typedef Elpanel::TCustomElPanel inherited;
	
private:
	System::Classes::TList* FClients;
	Elformcontainer::TElFormContainer* FFormContainer;
	Elformcontainer::TElFormContainerChangeLink* FChangeLink;
	bool FCloseInactiveForms;
	TElFDHTMLForm* FDHTMLForm;
	System::Uitypes::TColor FDHTMLFormColor;
	bool FAssignColor;
	bool FHook;
	bool FUseRes;
	bool FSaveResources;
	System::Classes::TWndMethod FOldWndProc;
	TElFDMessageEvent FOnMessage;
	int FActiveFormIndex;
	TElFormDisplayPosition FPosition;
	System::Classes::TNotifyEvent FOnChange;
	TElFormDisplayChangeEvent FOnChanging;
	void __fastcall DoFormChange(System::TObject* Sender);
	Vcl::Forms::TCustomForm* __fastcall GetActiveForm(void);
	void __fastcall SetActiveForm(Vcl::Forms::TCustomForm* aValue);
	void __fastcall SetActiveFormIndex(int aValue);
	void __fastcall SetPosition(TElFormDisplayPosition aValue);
	void __fastcall SetFormContainer(Elformcontainer::TElFormContainer* aValue);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	
protected:
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	void __fastcall NewWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall TriggerLinkClickEvent(System::UnicodeString HRef);
	
public:
	__fastcall virtual TElFormDisplay(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFormDisplay(void);
	void __fastcall DetachForm(int AXPos = 0x0, int AYPos = 0x0, int AWidth = 0x0, int AHeight = 0x0, Vcl::Forms::TFormBorderStyle ABorderStyle = (Vcl::Forms::TFormBorderStyle)(0x2), System::Uitypes::TBorderIcons ABorderIcons = (System::Uitypes::TBorderIcons() << System::Uitypes::TBorderIcon::biSystemMenu << System::Uitypes::TBorderIcon::biMinimize << System::Uitypes::TBorderIcon::biMaximize ), bool AModal = false);
	Vcl::Forms::TCustomForm* __fastcall FindNextForm(Vcl::Forms::TCustomForm* CurForm, bool GoForward);
	void __fastcall CloseActiveForm(void);
	void __fastcall HideActiveForm(void);
	void __fastcall SelectNextForm(bool GoForward);
	void __fastcall RegisterChanges(TElFormDisplayChangeLink* aValue);
	void __fastcall UnRegisterChanges(TElFormDisplayChangeLink* aValue);
	__property Vcl::Forms::TCustomForm* ActiveForm = {read=GetActiveForm, write=SetActiveForm};
	
__published:
	__property bool HookWindowProc = {read=FHook, write=FHook, default=0};
	__property bool SaveResources = {read=FSaveResources, write=FSaveResources, default=0};
	__property bool UseResForms = {read=FUseRes, write=FUseRes, default=0};
	__property bool AssignColor = {read=FAssignColor, write=FAssignColor, default=0};
	__property System::Uitypes::TColor HTMLFormBackColor = {read=FDHTMLFormColor, write=FDHTMLFormColor, default=536870911};
	__property TElFormDisplayPosition Position = {read=FPosition, write=SetPosition, default=9};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TElFormDisplayChangeEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property TElFDMessageEvent OnMessage = {read=FOnMessage, write=FOnMessage};
	__property Elformcontainer::TElFormContainer* FormContainer = {read=FFormContainer, write=SetFormContainer};
	__property int ActiveFormIndex = {read=FActiveFormIndex, write=SetActiveFormIndex, stored=true, nodefault};
	__property bool CloseInactiveForms = {read=FCloseInactiveForms, write=FCloseInactiveForms, nodefault};
	__property AlphaLevel = {default=0};
	__property AlwaysPaintBackground = {default=0};
	__property Background;
	__property BackgroundType = {default=2};
	__property GradientEndColor = {default=0};
	__property GradientStartColor = {default=0};
	__property GradientSteps = {default=16};
	__property Alignment = {default=2};
	__property Layout = {default=1};
	__property OwnerDraw = {default=0};
	__property ImageForm;
	__property Resizable = {default=0};
	__property Movable = {default=0};
	__property OnMove;
	__property OnPaint;
	__property SizeGrip = {default=0};
	__property Align;
	__property AutoSize = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelSpaceColor = {default=-16777201};
	__property BevelWidth = {default=1};
	__property BorderStyle = {default=0};
	__property BorderWidth = {default=0};
	__property TransparentXPThemes = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Locked = {default=0};
	__property MouseCapture = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowFocus = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property Caption;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockSite = {default=0};
	__property DockOrientation;
	__property BevelKind = {default=0};
	__property DoubleBuffered = {default=0};
	__property DragKind = {default=0};
	__property OnContextPopup;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElFormDisplay(HWND ParentWindow) : Elpanel::TCustomElPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElFDHTMLForm : public Vcl::Forms::TCustomForm
{
	typedef Vcl::Forms::TCustomForm inherited;
	
private:
	Elhtmllbl::TElHTMLLabel* FHTMLLabel;
	void __fastcall HTMLLabelLinkClick(System::TObject* Sender, Lmdtypes::TLMDString HRef);
	
public:
	__fastcall virtual TElFDHTMLForm(System::Classes::TComponent* AOwner, int Dummy);
	__property Elhtmllbl::TElHTMLLabel* HTMLLabel = {read=FHTMLLabel, write=FHTMLLabel};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElFDHTMLForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TCustomForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElFDHTMLForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElFDHTMLForm(HWND ParentWindow) : Vcl::Forms::TCustomForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION EElFormDisplay : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElFormDisplay(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElFormDisplay(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElFormDisplay(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElFormDisplay(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElFormDisplay(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElFormDisplay(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElFormDisplay(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElFormDisplay(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElFormDisplay(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElFormDisplay(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElFormDisplay(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElFormDisplay(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElFormDisplay(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall ElFreeResources(Vcl::Controls::TWinControl* aControl);
extern DELPHI_PACKAGE System::Types::TRect __fastcall ElAlignRect(TElAlignment Alignment, const System::Types::TRect &srcRect, const System::Types::TRect &destRect);
extern DELPHI_PACKAGE void __fastcall ElGetRectWH(const System::Types::TRect &srcRect, int &w, int &h);
extern DELPHI_PACKAGE bool __fastcall ElStrEmpty(const System::UnicodeString aValue);
}	/* namespace Elformdisplay */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELFORMDISPLAY)
using namespace Elformdisplay;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElformdisplayHPP
