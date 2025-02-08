// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDirDlg.pas' rev: 31.00 (Windows)

#ifndef LmddirdlgHPP
#define LmddirdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.FileCtrl.hpp>
#include <Vcl.Forms.hpp>
#include <LMDClass.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddirdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDirDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDirDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	System::Classes::TNotifyEvent FOnError;
	System::UnicodeString FInitialDir;
	System::UnicodeString FPath;
	bool FAllowDir;
	bool FShowDir;
	Lmdclass::TLMDCharCase FCharCase;
	Vcl::Filectrl::TDirectoryListBox* dirlistbox;
	Vcl::Filectrl::TDriveComboBox* drivecombo;
	void __fastcall drivecomboChange(System::TObject* Sender);
	void __fastcall newPathClick(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDDirDlg(System::Classes::TComponent* AOwner);
	void __fastcall RaiseError(void);
	virtual bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(Vcl::Forms::TForm* Main);
	void __fastcall GetDir(const System::UnicodeString title, System::UnicodeString &aPath);
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property bool AllowNewDir = {read=FAllowDir, write=FAllowDir, default=0};
	__property CaptionFill = {default=0};
	__property CaptionTitle = {default=0};
	__property Lmdclass::TLMDCharCase CharCase = {read=FCharCase, write=FCharCase, default=0};
	__property CustomButton = {default=0};
	__property Colors = {default=32};
	__property Effect = {default=0};
	__property Hints;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property System::UnicodeString InitialDir = {read=FInitialDir, write=FInitialDir};
	__property ListIndex = {index=1, default=0};
	__property System::UnicodeString Path = {read=FPath, write=FPath, stored=false};
	__property Position = {default=5};
	__property RelatePos = {default=0};
	__property ShowHints = {default=1};
	__property bool ShowLabelDir = {read=FShowDir, write=FShowDir, default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnCustomize;
	__property OnCustomClick;
	__property System::Classes::TNotifyEvent OnFolderError = {read=FOnError, write=FOnError};
public:
	/* TLMDBaseDialog.Destroy */ inline __fastcall virtual ~TLMDDirDlg(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddirdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDIRDLG)
using namespace Lmddirdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddirdlgHPP
