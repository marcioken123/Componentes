// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormDisplay.pas' rev: 31.00 (Windows)

#ifndef LmdformdisplayHPP
#define LmdformdisplayHPP

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
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Graphics.hpp>

//-- user supplied -----------------------------------------------------------
namespace Lmdformdisplay
{
class DELPHICLASS TLMDCustomFormDisplay;
class PASCALIMPLEMENTATION TLMDCustomFormDisplay : public Lmdcustombevelpanel::TLMDCustomBevelPanel 
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;	
protected:
	virtual int __fastcall AddFormExt(Forms::TCustomForm* aValue, bool Display) = 0 ;	
public:
	int __fastcall AddForm(Forms::TCustomForm* aValue, bool Display);
public:
	#pragma option push -w-inl
	/* TLMDCustomBevelPanel.Create */ inline __fastcall virtual TLMDCustomFormDisplay(Classes::TComponent* 
		AOwner) : Lmdcustombevelpanel::TLMDCustomBevelPanel(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TLMDCustomBevelPanel.Destroy */ inline __fastcall virtual ~TLMDCustomFormDisplay(void) { }
	#pragma option pop
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomFormDisplay(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(
		ParentWindow) { }
	#pragma option pop
};
};

namespace Lmdformdisplay
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormDisplay;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDFormDisplayChangeEvent)(System::TObject* Sender, Vcl::Forms::TCustomForm* NewForm, bool &Cancel);

typedef void __fastcall (__closure *TLMDFDMessageEvent)(System::TObject* Sender, Winapi::Messages::TMessage &Message);

enum DECLSPEC_DENUM TLMDFormDisplayPosition : unsigned char { fdpTopLeft, fdpTopCenter, fdpTopRight, fdpCenterLeft, fdpCenter, fdpCenterRight, fdpBottomLeft, fdpBottomCenter, fdpBottomRight, fdpClient };

class PASCALIMPLEMENTATION TLMDFormDisplay : public TLMDCustomFormDisplay
{
	typedef TLMDCustomFormDisplay inherited;
	
private:
	Vcl::Forms::TForm* FForm;
	System::UnicodeString FFormName;
	bool FAssignColor;
	bool FHook;
	bool FUseRes;
	bool FSaveResources;
	System::Classes::TWndMethod FOldWndProc;
	TLMDFDMessageEvent FOnMessage;
	System::Classes::TList* FList;
	int FActiveIndex;
	bool FAutoFocus;
	TLMDFormDisplayPosition FPosition;
	System::Classes::TNotifyEvent FOnChange;
	TLMDFormDisplayChangeEvent FOnChanging;
	void __fastcall SetForm(Vcl::Forms::TForm* aValue);
	void __fastcall SetFormName(const System::UnicodeString aValue);
	void __fastcall SetActiveForm(Vcl::Forms::TCustomForm* aValue);
	void __fastcall SetActiveFormIndex(int aValue);
	void __fastcall SetPosition(TLMDFormDisplayPosition aValue);
	int __fastcall GetCount(void);
	Vcl::Forms::TCustomForm* __fastcall GetActiveForm(void);
	Vcl::Forms::TCustomForm* __fastcall GetForms(int Index);
	int __fastcall GetFormIndex(Vcl::Forms::TCustomForm* Index);
	void __fastcall CheckFormName(const System::UnicodeString aValue);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	
protected:
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	void __fastcall NewWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TLMDFormDisplay(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormDisplay(void);
	bool __fastcall Execute(Vcl::Forms::TForm* aForm);
	Vcl::Forms::TForm* __fastcall ExecuteEnh(Vcl::Forms::TFormClass aForm);
	HIDESBASE void __fastcall Hide(void);
	void __fastcall UnLoad(void);
	__property Vcl::Forms::TForm* Form = {read=FForm, write=SetForm};
	virtual int __fastcall AddFormExt(Vcl::Forms::TCustomForm* aValue, bool Display);
	int __fastcall AddFormClass(Vcl::Forms::TFormClass aValue, bool Display);
	Vcl::Forms::TCustomForm* __fastcall FindNextForm(Vcl::Forms::TCustomForm* CurForm, bool GoForward);
	void __fastcall HideForm(Vcl::Forms::TCustomForm* aValue);
	void __fastcall MoveForm(Vcl::Forms::TCustomForm* aValue, int NewIndex);
	void __fastcall RemoveForm(Vcl::Forms::TCustomForm* aValue, bool FreeForm);
	void __fastcall SelectNextForm(bool GoForward);
	__property int ActiveFormIndex = {read=FActiveIndex, write=SetActiveFormIndex, nodefault};
	__property Vcl::Forms::TCustomForm* ActiveForm = {read=GetActiveForm, write=SetActiveForm};
	__property int FormCount = {read=GetCount, nodefault};
	__property Vcl::Forms::TCustomForm* Forms[int index] = {read=GetForms};
	__property int FormIndex[Vcl::Forms::TCustomForm* index] = {read=GetFormIndex};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Bevel;
	__property Color = {default=-16777201};
	__property Enabled = {default=1};
	__property System::UnicodeString FormName = {read=FFormName, write=SetFormName};
	__property bool HookWindowProc = {read=FHook, write=FHook, default=0};
	__property ParentBackground = {default=0};
	__property ParentColor = {default=0};
	__property PopupMenu;
	__property bool SaveResources = {read=FSaveResources, write=FSaveResources, default=0};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property bool UseResForms = {read=FUseRes, write=FUseRes, default=0};
	__property bool AssignColor = {read=FAssignColor, write=FAssignColor, default=0};
	__property TLMDFormDisplayPosition Position = {read=FPosition, write=SetPosition, default=9};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDFormDisplayChangeEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TLMDFDMessageEvent OnMessage = {read=FOnMessage, write=FOnMessage};
	__property bool AutoFocus = {read=FAutoFocus, write=FAutoFocus, default=1};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Font;
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Transparent = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFormDisplay(HWND ParentWindow) : TLMDCustomFormDisplay(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformdisplay */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMDISPLAY)
using namespace Lmdformdisplay;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformdisplayHPP
