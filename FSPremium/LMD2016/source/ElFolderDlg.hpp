// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElFolderDlg.pas' rev: 31.00 (Windows)

#ifndef ElfolderdlgHPP
#define ElfolderdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Types.hpp>
#include <Winapi.MultiMon.hpp>
#include <Winapi.ShlObj.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Menus.hpp>
#include <ElPopBtn.hpp>
#include <ElShellUtils.hpp>
#include <ElVCLUtils.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <LMDUnicode.hpp>
#include <LMDSysIn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elfolderdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElFolderDialog;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TBrowseForFolderOption : unsigned char { bfoFileSysDirsOnly, bfoDontGoBelowDomain, bfoStatusText, bfoFileSysAncestors, bfoBrowseForComputer, bfBrowseForPrinter, bfoBrowseIncludeFiles, bfoShowPath, bfoNewDialogStyle, bfoAllowEdit };

typedef System::Set<TBrowseForFolderOption, TBrowseForFolderOption::bfoFileSysDirsOnly, TBrowseForFolderOption::bfoAllowEdit> TBrowseForFolderOptions;

enum DECLSPEC_DENUM TFolderDialogPosition : unsigned char { fdpDefault, fdpScreenCenter, fdpDesktopCenter, fdpMainFormCenter, fdpOwnerFormCenter };

class PASCALIMPLEMENTATION TElFolderDialog : public Vcl::Dialogs::TCommonDialog
{
	typedef Vcl::Dialogs::TCommonDialog inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	void *FXDefWndProc;
	void *ObjInstance;
	_browseinfoW FBrowseInfoW;
	_browseinfoA FBrowseInfo;
	Elpopbtn::TElPopupButton* FCustBtn;
	Lmdtypes::TLMDString FCustomButtonCaption;
	Lmdtypes::TLMDString FDialogTitle;
	System::StaticArray<char, 261> FDisplayNameAnsi;
	System::StaticArray<System::WideChar, 261> FDisplayNameUni;
	System::WideString FFolderUni;
	System::AnsiString FFolderAnsi;
	_ITEMIDLIST *FFolderPIDL;
	int FHandle;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnCustomButtonClick;
	TBrowseForFolderOptions FOptions;
	Vcl::Controls::TWinControl* FParent;
	Elshellutils::TShellFolders FRootFolder;
	bool FShowCustomButton;
	bool JustInit;
	bool OriginalSelect;
	bool FVisible;
	bool FEnableCustomButton;
	Lmdtypes::TLMDString __fastcall GetFolder(void);
	Vcl::Controls::TWinControl* __fastcall GetParent(void);
	void __fastcall SetFolder(const Lmdtypes::TLMDString Value);
	void __fastcall SetParent(Vcl::Controls::TWinControl* Value);
	void __fastcall SetRootFolder(Elshellutils::TShellFolders Value);
	void __fastcall SetEnableCustomButton(const bool Value);
	
protected:
	Lmdtypes::TLMDString FCustomRootFolder;
	Lmdtypes::TLMDString FStatusText;
	Lmdtypes::TLMDString FPrompt;
	TFolderDialogPosition FPosition;
	int __fastcall Perform(unsigned Msg, int WParam, int LParam);
	void __fastcall SetStatusText(const Lmdtypes::TLMDString Value);
	
public:
	__fastcall virtual TElFolderDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFolderDialog(void);
	virtual void __fastcall DefaultHandler(void *Message);
	virtual bool __fastcall Execute(void)/* overload */;
	bool __fastcall ExecuteModal(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetSelectionPIDL(Winapi::Shlobj::PItemIDList PIDL);
	void __fastcall WinInitialized(int Param);
	void __fastcall WinSelChanged(int Param);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property int Handle = {read=FHandle, nodefault};
	__property Winapi::Shlobj::PItemIDList SelectionPIDL = {read=FFolderPIDL};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Vcl::Controls::TWinControl* Parent = {read=GetParent, write=SetParent, stored=false};
	__property Lmdtypes::TLMDString DialogTitle = {read=FDialogTitle, write=FDialogTitle};
	__property Lmdtypes::TLMDString CustomButtonCaption = {read=FCustomButtonCaption, write=FCustomButtonCaption};
	__property Lmdtypes::TLMDString Folder = {read=GetFolder, write=SetFolder};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnCustomButtonClick = {read=FOnCustomButtonClick, write=FOnCustomButtonClick};
	__property TBrowseForFolderOptions Options = {read=FOptions, write=FOptions, default=0};
	__property Elshellutils::TShellFolders RootFolder = {read=FRootFolder, write=SetRootFolder, default=0};
	__property bool ShowCustomButton = {read=FShowCustomButton, write=FShowCustomButton, default=0};
	__property Lmdtypes::TLMDString CustomRootFolder = {read=FCustomRootFolder, write=FCustomRootFolder};
	__property Lmdtypes::TLMDString StatusText = {read=FStatusText, write=SetStatusText};
	__property Lmdtypes::TLMDString Prompt = {read=FPrompt, write=FPrompt};
	__property TFolderDialogPosition Position = {read=FPosition, write=FPosition, default=0};
	__property bool EnableCustomButton = {read=FEnableCustomButton, write=SetEnableCustomButton, default=1};
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Vcl::Dialogs::TCommonDialog::Execute(ParentWnd); }
	
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
}	/* namespace Elfolderdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELFOLDERDLG)
using namespace Elfolderdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElfolderdlgHPP
