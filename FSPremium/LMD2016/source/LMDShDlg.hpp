// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShDlg.pas' rev: 31.00 (Windows)

#ifndef LmdshdlgHPP
#define LmdshdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.ShlObj.hpp>
#include <LMDShBase.hpp>
#include <LMDShMisc.hpp>
#include <LMDShUtils.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellAboutDialog;
class DELPHICLASS TLMDShellCustomBaseDialog;
class DELPHICLASS TLMDShellFormatDriveDialog;
class DELPHICLASS TLMDShellPickIconDialog;
class DELPHICLASS TLMDShellRunFileDialog;
class DELPHICLASS TLMDShellRestartDialog;
class DELPHICLASS TLMDShellFindDialog;
class DELPHICLASS TLMDShellSysBrowseDialog;
class DELPHICLASS TLMDShellObjectPropertiesDialog;
class DELPHICLASS TLMDShellCustomIEDialog;
class DELPHICLASS TLMDShellAddFavoritesDialog;
class DELPHICLASS TLMDShellFavoritesDialog;
class DELPHICLASS TLMDShellAppletLoader;
class DELPHICLASS TLMDShellNetConnectionDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShellAboutDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	System::UnicodeString FCaption;
	System::UnicodeString FOtherText;
	System::UnicodeString FProduct;
	Vcl::Graphics::TIcon* FIcon;
	bool __fastcall StoreIcon(void);
	void __fastcall SetIcon(Vcl::Graphics::TIcon* Value);
	
public:
	__fastcall virtual TLMDShellAboutDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellAboutDialog(void);
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Vcl::Graphics::TIcon* Icon = {read=FIcon, write=SetIcon, stored=StoreIcon};
	__property System::UnicodeString Product = {read=FProduct, write=FProduct};
	__property System::UnicodeString Text = {read=FOtherText, write=FOtherText};
};


class PASCALIMPLEMENTATION TLMDShellCustomBaseDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	NativeUInt fShellDLL;
	
protected:
	void * __fastcall int_GetProcAddress(int Index)/* overload */;
	virtual bool __fastcall int_Execute(HWND aHWND = (HWND)(0x0));
	
public:
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDShellCustomBaseDialog(System::Classes::TComponent* AOwner) : Lmdshbase::TLMDShellBaseDialog(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellCustomBaseDialog(void) { }
	
};


enum DECLSPEC_DENUM TLMDShellFormatResult : unsigned char { frFormatSucceeded, frFormatCancelled, frDriveNotFormatable, frFormatError };

enum DECLSPEC_DENUM TLMDShellFormatOption : unsigned char { forDefaultQuickFormat, forDefaultSysOnly, forRememberLast, forSuppressPrompt };

typedef System::Set<TLMDShellFormatOption, TLMDShellFormatOption::forDefaultQuickFormat, TLMDShellFormatOption::forSuppressPrompt> TLMDShellFormatOptions;

class PASCALIMPLEMENTATION TLMDShellFormatDriveDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	TLMDShellFormatResult FResult;
	unsigned FLastFormatID;
	System::WideChar FDriveToFormat;
	TLMDShellFormatOptions FOptions;
	void __fastcall SetDrive(System::WideChar Value);
	
public:
	__fastcall virtual TLMDShellFormatDriveDialog(System::Classes::TComponent* aOwner);
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	__property TLMDShellFormatResult LastFormatResult = {read=FResult, nodefault};
	
__published:
	__property TLMDShellFormatOptions Options = {read=FOptions, write=FOptions, default=12};
	__property System::WideChar DriveToFormat = {read=FDriveToFormat, write=SetDrive, nodefault};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellFormatDriveDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellPickIconDialog : public TLMDShellCustomBaseDialog
{
	typedef TLMDShellCustomBaseDialog inherited;
	
private:
	unsigned FIconIndex;
	Vcl::Graphics::TIcon* FIcon;
	System::Sysutils::TFileName FFileName;
	Vcl::Graphics::TIcon* __fastcall GetIcon(void);
	
protected:
	virtual bool __fastcall int_Execute(HWND aHWND = (HWND)(0x0));
	
public:
	__fastcall virtual TLMDShellPickIconDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellPickIconDialog(void);
	__property Vcl::Graphics::TIcon* Icon = {read=GetIcon};
	
__published:
	__property System::Sysutils::TFileName FileName = {read=FFileName, write=FFileName};
	__property unsigned IconIndex = {read=FIconIndex, write=FIconIndex, default=0};
};


enum DECLSPEC_DENUM TLMDShellRunFileOption : unsigned char { rfNoBrowseButton, rfNoDefaultPick, rfCalculateWorkPath, rfNoEditLabel, rfNoSeparateMemory };

typedef System::Set<TLMDShellRunFileOption, TLMDShellRunFileOption::rfNoBrowseButton, TLMDShellRunFileOption::rfNoSeparateMemory> TLMDShellRunFileOptions;

enum DECLSPEC_DENUM TLMDShellRunFileAction : unsigned char { raRun, raCancel, raRetry };

typedef void __fastcall (__closure *TLMDShellRunFileValidateEvent)(System::TObject* Sender, System::Sysutils::TFileName TheFile, System::Sysutils::TFileName TheWorkPath, bool Visible, TLMDShellRunFileAction &Action);

class PASCALIMPLEMENTATION TLMDShellRunFileDialog : public TLMDShellCustomBaseDialog
{
	typedef TLMDShellCustomBaseDialog inherited;
	
private:
	System::UnicodeString FCaption;
	System::UnicodeString FDescription;
	Vcl::Graphics::TIcon* FIcon;
	HWND FMessageWindow;
	TLMDShellRunFileOptions FOptions;
	System::Sysutils::TFileName FWorkingPath;
	TLMDShellRunFileValidateEvent FOnValidate;
	void __fastcall SetIcon(Vcl::Graphics::TIcon* Value);
	bool __fastcall StoreIcon(void);
	void __fastcall HandleMessage(Winapi::Messages::TMessage &aMessage);
	
protected:
	virtual void __fastcall DoValidate(System::Sysutils::TFileName TheFile, System::Sysutils::TFileName TheWorkPath, bool Visible, TLMDShellRunFileAction &Action);
	virtual bool __fastcall int_Execute(HWND aHWND = (HWND)(0x0));
	
public:
	__fastcall virtual TLMDShellRunFileDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellRunFileDialog(void);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property Vcl::Graphics::TIcon* Icon = {read=FIcon, write=SetIcon, stored=StoreIcon};
	__property TLMDShellRunFileOptions Options = {read=FOptions, write=FOptions, default=0};
	__property System::Sysutils::TFileName WorkingPath = {read=FWorkingPath, write=FWorkingPath};
	__property TLMDShellRunFileValidateEvent OnValidate = {read=FOnValidate, write=FOnValidate};
};


enum DECLSPEC_DENUM TLMDShellRestartOption : unsigned char { roLogoff, roShutdown, roReboot, roRestartWindows, roRebootSystem, roExitAndExecApp };

typedef System::Set<TLMDShellRestartOption, TLMDShellRestartOption::roLogoff, TLMDShellRestartOption::roExitAndExecApp> TLMDShellRestartOptions;

class PASCALIMPLEMENTATION TLMDShellRestartDialog : public TLMDShellCustomBaseDialog
{
	typedef TLMDShellCustomBaseDialog inherited;
	
private:
	System::UnicodeString FReason;
	TLMDShellRestartOption FRestartOption;
	
protected:
	virtual bool __fastcall int_Execute(HWND aHWND = (HWND)(0x0));
	
public:
	__fastcall virtual TLMDShellRestartDialog(System::Classes::TComponent* aOwner);
	
__published:
	__property System::UnicodeString Reason = {read=FReason, write=FReason};
	__property TLMDShellRestartOption RestartOption = {read=FRestartOption, write=FRestartOption, default=3};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellRestartDialog(void) { }
	
};


enum DECLSPEC_DENUM TLMDShellFindMode : unsigned char { fmFiles, fmComputer };

class PASCALIMPLEMENTATION TLMDShellFindDialog : public TLMDShellCustomBaseDialog
{
	typedef TLMDShellCustomBaseDialog inherited;
	
private:
	System::Sysutils::TFileName FSearchFileName;
	_ITEMIDLIST *FRootShellFolder;
	TLMDShellFindMode FMode;
	Lmdshutils::TLMDRoot FRootFolder;
	bool FOldStyle;
	void __fastcall SetRootFolder(Lmdshutils::TLMDRoot Value);
	void __fastcall LoadCustomFolder(System::Classes::TReader* Reader);
	void __fastcall LoadSystemFolder(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual bool __fastcall int_Execute(HWND aHWND = (HWND)(0x0));
	bool __fastcall int_FindComputer(void);
	bool __fastcall int_FindFiles(void);
	
public:
	__fastcall virtual TLMDShellFindDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellFindDialog(void);
	virtual bool __fastcall FindComputer(void);
	virtual bool __fastcall FindFiles(void);
	bool __fastcall ExecuteEx(TLMDShellFindMode Mode, HWND aHWND = (HWND)(0x0));
	__property Winapi::Shlobj::PItemIDList RootShellFolder = {read=FRootShellFolder};
	
__published:
	__property System::Sysutils::TFileName SearchFileName = {read=FSearchFileName, write=FSearchFileName};
	__property Lmdshutils::TLMDRoot RootFolder = {read=FRootFolder, write=SetRootFolder};
	__property TLMDShellFindMode Mode = {read=FMode, write=FMode, default=0};
	__property bool OldStyle = {read=FOldStyle, write=FOldStyle, default=0};
};


enum DECLSPEC_DENUM TLMDShellBrowseFilter : unsigned char { bfBrowseForAnything, bfBrowseForComputers, bfBrowseForDirectories, bfBrowseForFileAncestors, bfBrowseForPrinters };

typedef System::Set<TLMDShellBrowseFilter, TLMDShellBrowseFilter::bfBrowseForAnything, TLMDShellBrowseFilter::bfBrowseForPrinters> TLMDShellBrowseFilters;

enum DECLSPEC_DENUM TLMDShellBrowseOKState : unsigned char { osDefaultState, osEnableOK, osDisableOK };

typedef System::Set<TLMDShellBrowseOKState, TLMDShellBrowseOKState::osDefaultState, TLMDShellBrowseOKState::osDisableOK> TLMDShellBrowseOKStates;

enum DECLSPEC_DENUM TLMDShellBrowseOption : unsigned char { boExpandDomains, boStatusText, boShowFiles, boAllowEdit, boShowPath, boEnableOk, boNewGUI, boNewGUINoNewFolderBtn };

typedef System::Set<TLMDShellBrowseOption, TLMDShellBrowseOption::boExpandDomains, TLMDShellBrowseOption::boNewGUINoNewFolderBtn> TLMDShellBrowseOptions;

typedef void __fastcall (__closure *TLMDShellBrowseChangeEvent)(System::TObject* Sender, System::UnicodeString &Path, System::UnicodeString &StatusText, TLMDShellBrowseOKState &OKState);

typedef void __fastcall (__closure *TLMDShellBrowseInitEvent)(System::TObject* Sender, HWND DialogHandle);

typedef void __fastcall (__closure *TLMDShellBrowseValidateEvent)(System::TObject* Sender, System::UnicodeString Path, bool &Cancel);

class PASCALIMPLEMENTATION TLMDShellSysBrowseDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	System::UnicodeString FCaption;
	System::UnicodeString FDescription;
	System::UnicodeString FDisplayName;
	System::UnicodeString FInstructionText;
	System::UnicodeString FStatusText;
	TLMDShellBrowseFilter FFilter;
	HWND FDialogHandle;
	unsigned FImageIndex;
	Vcl::Graphics::TBitmap* FImageLarge;
	Vcl::Graphics::TBitmap* FImageSmall;
	TLMDShellBrowseChangeEvent FOnChange;
	TLMDShellBrowseInitEvent FOnInitialize;
	TLMDShellBrowseValidateEvent FOnValidate;
	System::Sysutils::TFileName FSelectedPath;
	TLMDShellBrowseOptions FOptions;
	_ITEMIDLIST *FRootShellFolder;
	Lmdshutils::TLMDRoot FRootFolder;
	void __fastcall SetCaption(const System::UnicodeString aValue);
	void __fastcall SetStatusText(const System::UnicodeString aValue);
	Vcl::Graphics::TBitmap* __fastcall GetImage(int Index);
	void __fastcall SetRootFolder(Lmdshutils::TLMDRoot Value);
	void __fastcall LoadCustomFolder(System::Classes::TReader* Reader);
	void __fastcall LoadSystemFolder(System::Classes::TReader* Reader);
	
protected:
	DYNAMIC void __fastcall DoChange(HWND DialogHandle, Winapi::Shlobj::PItemIDList PIDL);
	DYNAMIC void __fastcall DoInit(HWND DialogHandle);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDShellSysBrowseDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellSysBrowseDialog(void);
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	__property System::UnicodeString Description = {read=FDescription};
	__property System::UnicodeString DisplayName = {read=FDisplayName};
	__property unsigned ImageIndex = {read=FImageIndex, nodefault};
	__property Vcl::Graphics::TBitmap* ImageLarge = {read=GetImage, index=1};
	__property Vcl::Graphics::TBitmap* ImageSmall = {read=GetImage, index=2};
	__property Winapi::Shlobj::PItemIDList RootShellFolder = {read=FRootShellFolder};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Lmdshutils::TLMDRoot RootFolder = {read=FRootFolder, write=SetRootFolder};
	__property TLMDShellBrowseFilter Filter = {read=FFilter, write=FFilter, default=2};
	__property System::UnicodeString InstructionText = {read=FInstructionText, write=FInstructionText};
	__property TLMDShellBrowseOptions Options = {read=FOptions, write=FOptions, default=16};
	__property System::Sysutils::TFileName SelectedPath = {read=FSelectedPath, write=FSelectedPath, stored=false};
	__property System::UnicodeString StatusText = {read=FStatusText, write=SetStatusText};
	__property TLMDShellBrowseChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDShellBrowseInitEvent OnInitialize = {read=FOnInitialize, write=FOnInitialize};
	__property TLMDShellBrowseValidateEvent OnValidate = {read=FOnValidate, write=FOnValidate};
};


enum DECLSPEC_DENUM TLMDShellObjectType : unsigned char { soPathObject, soPrinterObject };

typedef System::Set<TLMDShellObjectType, TLMDShellObjectType::soPathObject, TLMDShellObjectType::soPrinterObject> TLMDShellObjectTypes;

class PASCALIMPLEMENTATION TLMDShellObjectPropertiesDialog : public TLMDShellCustomBaseDialog
{
	typedef TLMDShellCustomBaseDialog inherited;
	
private:
	System::UnicodeString FInitialTab;
	System::Sysutils::TFileName FObjectName;
	TLMDShellObjectType FObjectType;
	
protected:
	virtual bool __fastcall int_Execute(HWND aHWND = (HWND)(0x0));
	
public:
	__fastcall virtual TLMDShellObjectPropertiesDialog(System::Classes::TComponent* aOwner);
	
__published:
	__property System::UnicodeString InitialTab = {read=FInitialTab, write=FInitialTab};
	__property System::Sysutils::TFileName ObjectName = {read=FObjectName, write=FObjectName};
	__property TLMDShellObjectType ObjectType = {read=FObjectType, write=FObjectType, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellObjectPropertiesDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellCustomIEDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	NativeUInt FHandle;
	
public:
	virtual bool __fastcall Available(void);
	__fastcall virtual TLMDShellCustomIEDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShellCustomIEDialog(void);
};


class PASCALIMPLEMENTATION TLMDShellAddFavoritesDialog : public TLMDShellCustomIEDialog
{
	typedef TLMDShellCustomIEDialog inherited;
	
private:
	System::LongBool __stdcall (*FMethod)(HWND Wnd, System::WideChar * szPath, int cszPath, System::WideChar * szTitle, int cszTitle, Winapi::Shlobj::PItemIDList pidlFavorites);
	System::UnicodeString FDisplayName;
	System::UnicodeString FDirectory;
	
public:
	virtual bool __fastcall Available(void);
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	__fastcall virtual TLMDShellAddFavoritesDialog(System::Classes::TComponent* AOwner);
	
__published:
	__property System::UnicodeString DisplayName = {read=FDisplayName, write=FDisplayName};
	__property System::UnicodeString Directory = {read=FDirectory, write=FDirectory};
public:
	/* TLMDShellCustomIEDialog.Destroy */ inline __fastcall virtual ~TLMDShellAddFavoritesDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFavoritesDialog : public TLMDShellCustomIEDialog
{
	typedef TLMDShellCustomIEDialog inherited;
	
private:
	unsigned __stdcall (*FMethod)(HWND Wnd, System::WideChar * szPath);
	System::UnicodeString FDirectory;
	
public:
	virtual bool __fastcall Available(void);
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	__fastcall virtual TLMDShellFavoritesDialog(System::Classes::TComponent* AOwner);
	
__published:
	__property System::UnicodeString Directory = {read=FDirectory, write=FDirectory};
public:
	/* TLMDShellCustomIEDialog.Destroy */ inline __fastcall virtual ~TLMDShellFavoritesDialog(void) { }
	
};


enum DECLSPEC_DENUM TLMDShellCPL : unsigned char { cplControlPanel, cplCustomCPL, cplAppWizSystemComponents, cplAppWizAddNewSoftware, cplAppWizAddRemove, cplDateTime, cplDisplayBackground, cplDisplayScreenSaver, cplDisplayAppearance, cplDisplaySettings, cplAccess, cplMouse, cplKeyboard, cplInternetGeneral, cplInternetSecurity, cplInternetContent, cplInternetConnection, cplInternetExtented, cplMMSounds, cplMMHardware, cplModem, cplIntlGeneral, cplIntlNumbers, cplIntlCurrency, cplIntlTime, cplIntlDate, cplIntlInput, cplJoystick, cplNetwork, cplSystem };

class PASCALIMPLEMENTATION TLMDShellAppletLoader : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	TLMDShellCPL FApplet;
	System::UnicodeString FCustom;
	
public:
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	
__published:
	__property TLMDShellCPL Applet = {read=FApplet, write=FApplet, nodefault};
	__property System::UnicodeString Custom = {read=FCustom, write=FCustom};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDShellAppletLoader(System::Classes::TComponent* AOwner) : Lmdshbase::TLMDShellBaseDialog(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellAppletLoader(void) { }
	
};


enum DECLSPEC_DENUM TLMDShellNetResourceType : unsigned char { nrDiskResource, nrPrintResource };

class PASCALIMPLEMENTATION TLMDShellNetConnectionDialog : public TLMDShellCustomBaseDialog
{
	typedef TLMDShellCustomBaseDialog inherited;
	
private:
	System::UnicodeString FResourceName;
	TLMDShellNetResourceType FResourceType;
	
protected:
	virtual bool __fastcall int_Execute(HWND aHWND = (HWND)(0x0));
	
public:
	bool __fastcall DisconnectDrive(HWND aHWND = (HWND)(0x0));
	
__published:
	__property TLMDShellNetResourceType ResourceType = {read=FResourceType, write=FResourceType, nodefault};
	__property System::UnicodeString ResourceName = {read=FResourceName, write=FResourceName};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDShellNetConnectionDialog(System::Classes::TComponent* AOwner) : TLMDShellCustomBaseDialog(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellNetConnectionDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDShellAboutDialog(void);
extern DELPHI_PACKAGE bool __fastcall LMDShellRestartDialog(const System::UnicodeString aReason);
extern DELPHI_PACKAGE bool __fastcall LMDShellObjectPropertiesDialog(System::Sysutils::TFileName aObjectName = System::Sysutils::TFileName(), TLMDShellObjectType aObjectType = (TLMDShellObjectType)(0x0), System::UnicodeString aInitialTab = System::UnicodeString());
extern DELPHI_PACKAGE System::LongBool __fastcall LMDShellFindFilesDialog(void);
extern DELPHI_PACKAGE System::LongBool __fastcall LMDShellFindComputerDialog(void);
extern DELPHI_PACKAGE void __fastcall LMDShellExitWindowsDialog(void);
extern DELPHI_PACKAGE int __fastcall LMDShellOutOfMemoryDialog(void);
extern DELPHI_PACKAGE void __fastcall LMDShellDiskFullDialog(System::WideChar Drive);
extern DELPHI_PACKAGE bool __fastcall LMDShellCopyDiskDialog(void);
extern DELPHI_PACKAGE bool __fastcall LMDShellOpenWithDialog(const System::UnicodeString aFile = System::UnicodeString());
}	/* namespace Lmdshdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHDLG)
using namespace Lmdshdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshdlgHPP
