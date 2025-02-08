// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTaskDlg.pas' rev: 31.00 (Windows)

#ifndef LmdtaskdlgHPP
#define LmdtaskdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <intfLMDBase.hpp>
#include <LMDProcs.hpp>
#include <LMDSysIn.hpp>
#include <Winapi.CommCtrl.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTaskDialog.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtaskdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTaskDlgControl;
class DELPHICLASS TLMDTaskProgressBar;
class DELPHICLASS TLMDTaskDlgBaseButton;
class DELPHICLASS TLMDTaskDlgRadioButton;
class DELPHICLASS TLMDTaskDlgButton;
class DELPHICLASS TLMDTaskDlgButtons;
class DELPHICLASS TLMDTaskDialog;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTaskDlgProgressState : unsigned char { tdpsNormal, tdpsError, tdsPaused };

enum DECLSPEC_DENUM TLMDTaskDlgIcon : unsigned char { tdiBlank, tdiWarning, tdiQuestion, tdiError, tdiInformation, tdiBlankAgain, tdiShield };

enum DECLSPEC_DENUM TLMDTaskDialogCommonButton : unsigned char { tdcbOk, tdcbYes, tdcbNo, tdcbCancel, tdcbRetry, tdcbClose };

typedef System::Set<TLMDTaskDialogCommonButton, TLMDTaskDialogCommonButton::tdcbOk, TLMDTaskDialogCommonButton::tdcbClose> TLMDTaskDialogCommonButtons;

enum DECLSPEC_DENUM TLMDTaskDialogFlag : unsigned char { tdfEnableHyperlinks, tdfUseHiconMain, tdfUseHiconFooter, tdfAllowDialogCancellation, tdfUseCommandLinks, tdfUseCommandLinksNoIcon, tdfExpandFooterArea, tdfExpandedByDefault, tdfVerificationFlagChecked, tdfShowProgressBar, tdfShowMarqueeProgressBar, tdfCallbackTimer, tdfPositionRelativeToWindow, tdfRtlLayout, tdfNoDefaultRadioButton, tdfCanBeMinimized };

typedef System::Set<TLMDTaskDialogFlag, TLMDTaskDialogFlag::tdfEnableHyperlinks, TLMDTaskDialogFlag::tdfCanBeMinimized> TLMDTaskDialogFlags;

typedef void __fastcall (__closure *TLMDOnTaskDialogHyperlink)(System::TObject* Sender, System::WideString AHref);

typedef void __fastcall (__closure *TLMDOnTaskDialogTimer)(System::TObject* Sender, unsigned ATickCount);

typedef void __fastcall (__closure *TLMDOnTaskDialogChecked)(System::TObject* Sender, bool AState);

typedef void __fastcall (__closure *TLMDOnTaskDialogButtonClick)(System::TObject* Sender, bool &ANoCloseDialog);

typedef void __fastcall (__closure *TLMDOnTaskDialogCommonButtonClick)(System::TObject* Sender, TLMDTaskDialogCommonButton AButtonId, bool &ANoCloseDialog);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTaskDlgControl : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	TLMDTaskDialog* FOwner;
	virtual void __fastcall InitControl(void) = 0 ;
	
public:
	__fastcall virtual TLMDTaskDlgControl(TLMDTaskDialog* AOwner);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTaskDlgControl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTaskProgressBar : public TLMDTaskDlgControl
{
	typedef TLMDTaskDlgControl inherited;
	
private:
	int FMin;
	int FPosition;
	int FMax;
	TLMDTaskDlgProgressState FState;
	bool FMarquee;
	int FMarqueeSpeed;
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetState(const TLMDTaskDlgProgressState Value);
	void __fastcall SetMarquee(const bool Value);
	void __fastcall SetMarqueeSpeed(const int Value);
	
protected:
	virtual void __fastcall InitControl(void);
	
public:
	__fastcall virtual TLMDTaskProgressBar(TLMDTaskDialog* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Marquee = {read=FMarquee, write=SetMarquee, default=0};
	__property int MarqueSpeed = {read=FMarqueeSpeed, write=SetMarqueeSpeed, default=0};
	__property TLMDTaskDlgProgressState State = {read=FState, write=SetState, default=0};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTaskProgressBar(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTaskDlgBaseButton : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FButtonId;
	System::WideString FCaption;
	bool FEnabled;
	TLMDTaskDialog* __fastcall GetTaskDialog(void);
	
protected:
	virtual bool __fastcall GetIsDefault(void) = 0 ;
	virtual void __fastcall InitButton(void) = 0 ;
	virtual void __fastcall SetEnabled(const bool Value) = 0 ;
	virtual void __fastcall SetIsDefault(const bool Value) = 0 ;
	__property TLMDTaskDialog* TaskDialog = {read=GetTaskDialog};
	
public:
	virtual void __fastcall Click(void) = 0 ;
	
__published:
	__property int ButtonId = {read=FButtonId, write=FButtonId, nodefault};
	__property System::WideString Caption = {read=FCaption, write=FCaption};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool IsDefault = {read=GetIsDefault, write=SetIsDefault, default=0};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDTaskDlgBaseButton(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDTaskDlgBaseButton(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDTaskDlgRadioButton : public TLMDTaskDlgBaseButton
{
	typedef TLMDTaskDlgBaseButton inherited;
	
private:
	System::Classes::TNotifyEvent FOnClick;
	
protected:
	virtual bool __fastcall GetIsDefault(void);
	virtual void __fastcall TriggerClick(System::TObject* Sender);
	virtual void __fastcall SetEnabled(const bool Value);
	virtual void __fastcall SetIsDefault(const bool Value);
	virtual void __fastcall InitButton(void);
	
public:
	virtual void __fastcall Click(void);
	__fastcall virtual TLMDTaskDlgRadioButton(System::Classes::TCollection* Collection);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDTaskDlgRadioButton(void) { }
	
};


class PASCALIMPLEMENTATION TLMDTaskDlgButton : public TLMDTaskDlgBaseButton
{
	typedef TLMDTaskDlgBaseButton inherited;
	
private:
	bool FIsElevationButton;
	TLMDOnTaskDialogButtonClick FOnClick;
	void __fastcall SetIsElevationButton(const bool Value);
	
protected:
	virtual void __fastcall TriggerClick(System::TObject* Sender, bool &ANoCloseDialog);
	virtual void __fastcall SetEnabled(const bool Value);
	virtual void __fastcall SetIsDefault(const bool Value);
	virtual void __fastcall InitButton(void);
	virtual bool __fastcall GetIsDefault(void);
	
public:
	virtual void __fastcall Click(void);
	__fastcall virtual TLMDTaskDlgButton(System::Classes::TCollection* Collection);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool IsElevationButton = {read=FIsElevationButton, write=SetIsElevationButton, default=0};
	__property TLMDOnTaskDialogButtonClick OnClick = {read=FOnClick, write=FOnClick};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDTaskDlgButton(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTaskDlgButtons : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
private:
	TLMDTaskDialog* __fastcall IntGetOwner(void);
	TLMDTaskDlgBaseButton* __fastcall GetButton(int Index);
	
protected:
	__property TLMDTaskDialog* TaskDialog = {read=IntGetOwner};
	void * __fastcall GetNativeArray(void);
	void __fastcall FreeNativeArray(void * AArray);
	
public:
	__property TLMDTaskDlgBaseButton* Buttons[int Index] = {read=GetButton};
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDTaskDlgButtons(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDTaskDlgButtons(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDTaskDialog : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	NativeUInt FHandle;
	Lmdtaskdialog::TASKDIALOGCONFIG FConfig;
	bool FResetTimer;
	bool FIsNavigate;
	TLMDTaskProgressBar* FProgressBar;
	TLMDTaskDialogFlags FFlags;
	TLMDTaskDlgIcon FFooterIcon;
	TLMDTaskDlgIcon FMainIcon;
	Vcl::Graphics::TIcon* FCustomFooterIcon;
	Vcl::Graphics::TIcon* FCustomMainIcon;
	TLMDTaskDlgButtons* FRadioButtons;
	TLMDTaskDlgButtons* FButtons;
	System::Classes::TNotifyEvent FOnDialogConstructed;
	System::Classes::TNotifyEvent FOnHelp;
	System::Classes::TNotifyEvent FOnDestroyed;
	System::Classes::TNotifyEvent FOnNavigated;
	System::Classes::TNotifyEvent FOnCreated;
	TLMDOnTaskDialogHyperlink FOnHyperlink;
	TLMDOnTaskDialogTimer FOnTimer;
	TLMDOnTaskDialogChecked FOnVerificationClicked;
	TLMDOnTaskDialogChecked FOnExpandoButtonClicked;
	int FResultRadioButtonId;
	int FResultButtonId;
	bool FResultVerificationState;
	System::WideString FCollapsedControlText;
	System::WideString FVerificationText;
	System::WideString FFooterText;
	System::WideString FExpandedInformation;
	System::WideString FTitle;
	System::WideString FExpandedControlText;
	System::WideString FMainInstruction;
	System::WideString FContent;
	TLMDTaskDialogCommonButtons FCommonButtons;
	TLMDOnTaskDialogCommonButtonClick FOnCommonButtonClick;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FThemeGlobalMode;
	void __fastcall SetHandle(const NativeUInt Value);
	void __fastcall SetCollapsedControlText(const System::WideString Value);
	void __fastcall SetContent(const System::WideString Value);
	void __fastcall SetCustomFooterIcon(Vcl::Graphics::TIcon* const Value);
	void __fastcall SetCustomMainIcon(Vcl::Graphics::TIcon* const Value);
	void __fastcall SetExpandedControlText(const System::WideString Value);
	void __fastcall SetExpandedInformation(const System::WideString Value);
	void __fastcall SetFooterText(const System::WideString Value);
	void __fastcall SetFooterIcon(const TLMDTaskDlgIcon Value);
	void __fastcall SetMainIcon(const TLMDTaskDlgIcon Value);
	void __fastcall SetMainInstruction(const System::WideString Value);
	void __fastcall SetTitle(const System::WideString Value);
	void __fastcall SetVerificationText(const System::WideString Value);
	void __fastcall SetButtons(TLMDTaskDlgButtons* const Value);
	void __fastcall SetFlags(const TLMDTaskDialogFlags Value);
	void __fastcall SetProgressBar(TLMDTaskProgressBar* const Value);
	void __fastcall SetRadioButtons(TLMDTaskDlgButtons* const Value);
	int __fastcall GetWidth(void);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetCommonButtons(const TLMDTaskDialogCommonButtons Value);
	void __fastcall UpdateFlags(void);
	void __fastcall SetOnCustomize(const Lmdtaskdialog::TLMDTaskDlgCustomizationEvent Value);
	Lmdtaskdialog::TLMDTaskDlgCustomizationEvent __fastcall GetOnCustomize(void);
	int __fastcall GetDefaultButton(void);
	void __fastcall SetDefaultButton(const int Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	
protected:
	bool __fastcall GetResetTimer(void);
	int __fastcall SendMessageToDialog(unsigned Msg, NativeUInt wParam, NativeInt lParam);
	virtual bool __fastcall TriggerButtonClicked(int AButtonId);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall TriggerCreated(void);
	virtual void __fastcall TriggerRadionButtonClicked(int AButtonId);
	virtual void __fastcall TriggerHyperlink(System::WideString AHref);
	virtual void __fastcall TriggerNavigated(void);
	virtual void __fastcall TriggerTimer(unsigned ATickCount);
	virtual void __fastcall TriggerDestroyed(void);
	virtual void __fastcall TriggerDialogConstructed(void);
	virtual void __fastcall TriggerVerificationClicked(bool AChecked);
	virtual void __fastcall TriggerHelp(void);
	virtual void __fastcall TriggerExpandoButtonCliked(bool AExpanded);
	virtual void __fastcall TriggerCommonButtonClick(System::TObject* Sender, TLMDTaskDialogCommonButton AButtonId, bool &ANoCloseDialog);
	
public:
	__fastcall virtual TLMDTaskDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTaskDialog(void);
	bool __fastcall HandleAllocated(void);
	void __fastcall InitTaskDialog(void);
	void __fastcall BeginNavigate(void);
	void __fastcall Navigate(void);
	void __fastcall ResetTimer(void);
	void __fastcall VerificationClick(bool ACheckBoxState, bool ASetFocusToVerificationCheckBox);
	bool __fastcall Execute(void)/* overload */;
	bool __fastcall Execute(NativeUInt AParentHandle)/* overload */;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property NativeUInt Handle = {read=FHandle, write=SetHandle, nodefault};
	__property int ResultButtonId = {read=FResultButtonId, nodefault};
	__property int ResultRadioButtonId = {read=FResultRadioButtonId, nodefault};
	__property bool ResultVerificationState = {read=FResultVerificationState, nodefault};
	
__published:
	__property About = {default=0};
	__property System::WideString Title = {read=FTitle, write=SetTitle};
	__property System::WideString MainInstruction = {read=FMainInstruction, write=SetMainInstruction};
	__property System::WideString VerificationText = {read=FVerificationText, write=SetVerificationText};
	__property System::WideString ExpandedInformation = {read=FExpandedInformation, write=SetExpandedInformation};
	__property System::WideString ExpandedControlText = {read=FExpandedControlText, write=SetExpandedControlText};
	__property System::WideString CollapsedControlText = {read=FCollapsedControlText, write=SetCollapsedControlText};
	__property System::WideString FooterText = {read=FFooterText, write=SetFooterText};
	__property System::WideString Content = {read=FContent, write=SetContent};
	__property TLMDTaskDlgIcon MainIcon = {read=FMainIcon, write=SetMainIcon, default=0};
	__property Vcl::Graphics::TIcon* CustomMainIcon = {read=FCustomMainIcon, write=SetCustomMainIcon};
	__property TLMDTaskDlgIcon FooterIcon = {read=FFooterIcon, write=SetFooterIcon, default=0};
	__property Vcl::Graphics::TIcon* CustomFooterIcon = {read=FCustomFooterIcon, write=SetCustomFooterIcon};
	__property TLMDTaskDialogFlags Flags = {read=FFlags, write=SetFlags, default=16449};
	__property TLMDTaskProgressBar* ProgressBar = {read=FProgressBar, write=SetProgressBar};
	__property TLMDTaskDlgButtons* RadioButtons = {read=FRadioButtons, write=SetRadioButtons};
	__property TLMDTaskDlgButtons* Buttons = {read=FButtons, write=SetButtons};
	__property TLMDTaskDialogCommonButtons CommonButtons = {read=FCommonButtons, write=SetCommonButtons, default=1};
	__property int DefaultButton = {read=GetDefaultButton, write=SetDefaultButton, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, default=0};
	__property Lmdtaskdialog::TLMDTaskDlgCustomizationEvent OnCustomize = {read=GetOnCustomize, write=SetOnCustomize};
	__property System::Classes::TNotifyEvent OnCreated = {read=FOnCreated, write=FOnCreated};
	__property System::Classes::TNotifyEvent OnHelp = {read=FOnHelp, write=FOnHelp};
	__property System::Classes::TNotifyEvent OnNavigated = {read=FOnNavigated, write=FOnNavigated};
	__property System::Classes::TNotifyEvent OnDestroyed = {read=FOnDestroyed, write=FOnDestroyed};
	__property System::Classes::TNotifyEvent OnDialogConstructed = {read=FOnDialogConstructed, write=FOnDialogConstructed};
	__property TLMDOnTaskDialogHyperlink OnHyperlink = {read=FOnHyperlink, write=FOnHyperlink};
	__property TLMDOnTaskDialogTimer OnTimer = {read=FOnTimer, write=FOnTimer};
	__property TLMDOnTaskDialogChecked OnVerificationClicked = {read=FOnVerificationClicked, write=FOnVerificationClicked};
	__property TLMDOnTaskDialogChecked OnExpandoButtonClicked = {read=FOnExpandoButtonClicked, write=FOnExpandoButtonClicked};
	__property TLMDOnTaskDialogCommonButtonClick OnCommonButtonClick = {read=FOnCommonButtonClick, write=FOnCommonButtonClick};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
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


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int __fastcall LMDTaskDialogCommonButtonToID(TLMDTaskDialogCommonButton AButton);
}	/* namespace Lmdtaskdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTASKDLG)
using namespace Lmdtaskdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtaskdlgHPP
