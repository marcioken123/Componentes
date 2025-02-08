// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTaskDialog.pas' rev: 31.00 (Windows)

#ifndef LmdtaskdialogHPP
#define LmdtaskdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtaskdialog
{
//-- forward type declarations -----------------------------------------------
struct TASKDIALOGCONFIG;
//-- type declarations -------------------------------------------------------
typedef HRESULT __stdcall (*TLMDTaskDialogCallBack)(HWND hwndDlg, unsigned Msg, NativeUInt wp, NativeInt lp, int dwRefData);

typedef System::StaticArray<Winapi::Commctrl::TASKDIALOG_BUTTON, 134217728> TLMDTaskButtonArray;

typedef TLMDTaskButtonArray *PLMDTaskButtonArray;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TASKDIALOGCONFIG
{
public:
	unsigned cbSize;
	HWND hwndParent;
	NativeUInt hInstance;
	unsigned dwFlags;
	unsigned dwCommonButtons;
	System::WideChar *pszWindowTitle;
	
public:
	union
	{
		struct 
		{
			System::WideChar *pszMainIcon;
			System::WideChar *pszMainInstruction;
			System::WideChar *pszContent;
			unsigned cButtons;
			TLMDTaskButtonArray *pButtons;
			int nDefaultButton;
			unsigned cRadioButtons;
			TLMDTaskButtonArray *pRadioButtons;
			int nDefaultRadioButton;
			System::WideChar *pszVerificationText;
			System::WideChar *pszExpandedInformation;
			System::WideChar *pszExpandedControlText;
			System::WideChar *pszCollapsedControlText;union
			{
				struct 
				{
					System::WideChar *pszFooterIcon;
					System::WideChar *pszFooter;
					TLMDTaskDialogCallBack pfCallback;
					int lpCallbackData;
					unsigned cxWidth;
				};
				struct 
				{
					HICON hFooterIcon;
				};
				
			};
		};
		struct 
		{
			HICON hMainIcon;
		};
		
	};
};
#pragma pack(pop)


typedef TASKDIALOGCONFIG *PTaskDialogConfig;

typedef TASKDIALOGCONFIG TTaskDialogConfig;

typedef HRESULT __stdcall (*TLMDTaskDialogIndirectProc)(const TASKDIALOGCONFIG &ptc, int &pnButton, int &pnRadioButton, bool &pfVerificationFlagChecked);

typedef HRESULT __stdcall (*TLMDTaskDialogProc)(HWND hwndParent, unsigned hInstance, System::WideChar * pszWindowTitle, System::WideChar * pszMainInstruction, System::WideChar * pszContent, unsigned dwCommonButtons, System::WideChar * pszIcon, int &pnButton);

typedef void __fastcall (__closure *TLMDTaskDlgCustomizationEvent)(System::TObject* Sender, System::TObject* ADialog);

//-- var, const, procedure ---------------------------------------------------
static const System::Word TDM_UPDATE_FLAGS = System::Word(0x482);
static const System::Int8 TD_ICON_BLANK = System::Int8(0x64);
static const System::Int8 TD_ICON_WARNING = System::Int8(0x65);
static const System::Int8 TD_ICON_QUESTION = System::Int8(0x66);
static const System::Int8 TD_ICON_ERROR = System::Int8(0x67);
static const System::Int8 TD_ICON_INFORMATION = System::Int8(0x68);
static const System::Int8 TD_ICON_BLANK_AGAIN = System::Int8(0x69);
static const System::Int8 TD_ICON_SHIELD = System::Int8(0x6a);
#define comctl32 L"comctl32.dll"
extern DELPHI_PACKAGE TLMDTaskDlgCustomizationEvent GOnCustomizationEvent;
extern DELPHI_PACKAGE bool CIsNativeTaskDialog;
extern DELPHI_PACKAGE TLMDTaskDialogIndirectProc TaskDialogIndirect;
extern DELPHI_PACKAGE TLMDTaskDialogProc TaskDialog;
extern DELPHI_PACKAGE void __fastcall SwitchToPlatform(void);
extern DELPHI_PACKAGE void __fastcall SwitchToNative(void);
}	/* namespace Lmdtaskdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTASKDIALOG)
using namespace Lmdtaskdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtaskdialogHPP
