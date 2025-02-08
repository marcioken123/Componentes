// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBrowseDlg.pas' rev: 31.00 (Windows)

#ifndef LmdbrowsedlgHPP
#define LmdbrowsedlgHPP

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
#include <Winapi.ShlObj.hpp>
#include <LMDClass.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDShUtils.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbrowsedlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBrowseDlg;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDBrowseDlgOption : unsigned char { doBrowseForComputer, doBrowseForPrinter, doDontGoBelowDomain, doReturnFileSysAncestors, doReturnFileSysDirs, doStatusText, doShowFiles, doAllowEdit, doShowPath, doEnableOK, doNewGUI, doNewGUINoNewFolderBtn };

typedef System::Set<TLMDBrowseDlgOption, TLMDBrowseDlgOption::doBrowseForComputer, TLMDBrowseDlgOption::doNewGUINoNewFolderBtn> TLMDBrowseDlgOptions;

enum DECLSPEC_DENUM TLMDSystemFolders : unsigned char { bfoDesktop, bfoDesktopExpanded, bfoPrograms, bfoControlPanel, bfoPrinters, bfoPersonal, bfoFavorites, bfoStartup, bfoRecent, bfoSendto, bfoRecycleBin, bfoStartMenu, bfoDesktopDirectory, bfoMyComputer, bfoNetwork, bfoNetworkNeighborhood, bfoInternet, bfoFonts, bfoTemplates, bfoCommonStartMenu, bfoCommonPrograms, bfoCommonStartup, bfoCommonDesktopDirectory, bfoAppData, bfoPrintHood, bfoAltStartup, bfoCommonAltstartup, bfoCommonFavorites, bfoInternetChache, bfoCookies, bfoHistory, bfoProfile, bfoConnections, bfoCommonMusic, bfoCommonPictures, bfoCommonVideos, bfoCDBurnArea, bfpProfiles };

typedef void __fastcall (__closure *TLMDBrowseDlgSelectionChangeEvent)(System::TObject* Sender, HWND DialogHandle, System::UnicodeString path, Winapi::Shlobj::PItemIDList item);

typedef void __fastcall (__closure *TLMDBrowseDlgEditValidateEvent)(System::TObject* Sender, System::UnicodeString path, bool &Cancel);

class PASCALIMPLEMENTATION TLMDBrowseDlg : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	System::UnicodeString FPath;
	System::UnicodeString FDisplayName;
	System::UnicodeString FCaption;
	System::UnicodeString FCaptionTitle;
	System::UnicodeString FStatusText;
	HWND FHandle;
	System::Classes::TNotifyEvent FOnInit;
	TLMDBrowseDlgEditValidateEvent FOnValidate;
	TLMDBrowseDlgSelectionChangeEvent FOnSelectionChanged;
	Lmdclass::TLMDDlgPosRel FDlgPosRel;
	TLMDBrowseDlgOptions FOptions;
	Lmdclass::TLMDDlgPosition FPosition;
	TLMDSystemFolders FStartFolder;
	_ITEMIDLIST *FSelected;
	void __fastcall SetPath(const System::UnicodeString aValue);
	void __fastcall SetStatusText(const System::UnicodeString aValue);
	void __fastcall SetSelected(Winapi::Shlobj::PItemIDList aValue);
	
protected:
	void __fastcall DoInit(void);
	void __fastcall DoSelectionChange(Winapi::Shlobj::PItemIDList aValue);
	
public:
	__fastcall virtual TLMDBrowseDlg(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBrowseDlg(void);
	bool __fastcall ConvertPathToItemIDList(const System::UnicodeString aPath, Winapi::Shlobj::PItemIDList ItemIDList);
	void __fastcall EnableOKButton(bool aValue);
	bool __fastcall ExecuteEnh(Vcl::Forms::TCustomForm* Main);
	bool __fastcall Execute(void);
	__property Winapi::Shlobj::PItemIDList SelectedItemID = {read=FSelected, write=SetSelected};
	__property System::UnicodeString SelectedName = {read=FDisplayName};
	
__published:
	__property About = {default=0};
	__property System::UnicodeString CaptionTitle = {read=FCaptionTitle, write=FCaptionTitle};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property TLMDSystemFolders StartFolder = {read=FStartFolder, write=FStartFolder, default=1};
	__property TLMDBrowseDlgOptions Options = {read=FOptions, write=FOptions, default=272};
	__property System::UnicodeString SelectedFolder = {read=FPath, write=SetPath};
	__property Lmdclass::TLMDDlgPosition Position = {read=FPosition, write=FPosition, default=5};
	__property Lmdclass::TLMDDlgPosRel RelatePos = {read=FDlgPosRel, write=FDlgPosRel, default=3};
	__property System::UnicodeString StatusText = {read=FStatusText, write=SetStatusText};
	__property System::Classes::TNotifyEvent OnInit = {read=FOnInit, write=FOnInit};
	__property TLMDBrowseDlgSelectionChangeEvent OnSelectionChanged = {read=FOnSelectionChanged, write=FOnSelectionChanged};
	__property TLMDBrowseDlgEditValidateEvent OnValidate = {read=FOnValidate, write=FOnValidate};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 LMD_MAX_STATUSPATH = System::Int8(0x28);
}	/* namespace Lmdbrowsedlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBROWSEDLG)
using namespace Lmdbrowsedlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbrowsedlgHPP
