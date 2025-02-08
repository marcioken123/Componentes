// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDStdListEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdstdlisteditordlgHPP
#define PlmdstdlisteditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.RTLConsts.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Consts.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Clipbrd.hpp>
#include <LMDCustomIniComponent.hpp>
#include <LMDBaseMRUList.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDHookComponent.hpp>
#include <LMDFMDrop.hpp>
#include <LMDCustomContainer.hpp>
#include <pLMDActionsData.hpp>
#include <LMDBitmapList.hpp>
#include <LMDGenericList.hpp>
#include <LMDWaveList.hpp>
#include <LMDStringList.hpp>
#include <LMDImageList.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDFormPersistent.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdstdlisteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStdListEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStdListEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* FileDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Lmdfmdrop::TLMDFMDrop* fm;
	Vcl::Menus::TPopupMenu* pop;
	Vcl::Menus::TMenuItem* Add1;
	Vcl::Menus::TMenuItem* Remove1;
	Vcl::Menus::TMenuItem* Clear1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Up1;
	Vcl::Menus::TMenuItem* Down1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* prop;
	Vcl::Menus::TMainMenu* MainMenu1;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* mnuCut;
	Vcl::Menus::TMenuItem* bmp2iml;
	Vcl::Menus::TMenuItem* avi2iml;
	Vcl::Menus::TMenuItem* mnuCopy;
	Vcl::Menus::TMenuItem* mnuPaste;
	Vcl::Menus::TMenuItem* mnuDelete;
	Vcl::Menus::TMenuItem* N4;
	Vcl::Menus::TMenuItem* cline;
	Vcl::Menus::TMenuItem* saveasbmp;
	Vcl::Menus::TMenuItem* Up2;
	Vcl::Menus::TMenuItem* down2;
	Vcl::Menus::TMenuItem* N5;
	Vcl::Menus::TMenuItem* mnuSelectAll;
	Vcl::Menus::TMenuItem* ClearAll1;
	Vcl::Menus::TMenuItem* N6;
	Vcl::Menus::TMenuItem* Properties1;
	Vcl::Menus::TMenuItem* Tools1;
	Vcl::Menus::TMenuItem* comp;
	Vcl::Menus::TMenuItem* checkall;
	Vcl::Menus::TMenuItem* UnCheckAll;
	Vcl::Menus::TMenuItem* mnuSave;
	Vcl::Menus::TMenuItem* N7;
	Vcl::Menus::TMenuItem* mnuMulti;
	Lmdinictrl::TLMDIniCtrl* ini;
	Lmdbasemrulist::TLMDBaseMRUList* mru;
	Vcl::Menus::TMenuItem* Play1;
	Vcl::Menus::TMenuItem* N8;
	Vcl::Menus::TMenuItem* mnuLoad;
	Vcl::Menus::TMenuItem* quit1;
	Vcl::Menus::TMenuItem* quit2;
	Vcl::Extctrls::TPanel* pnlMain;
	Vcl::Comctrls::THeaderControl* header;
	Vcl::Stdctrls::TListBox* lb;
	Vcl::Comctrls::TCoolBar* CoolBar1;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* btnLoad;
	Vcl::Comctrls::TToolButton* btnSave;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Comctrls::TToolButton* btnCut;
	Vcl::Comctrls::TToolButton* btnCopy;
	Vcl::Comctrls::TToolButton* btnPaste;
	Vcl::Comctrls::TToolButton* ToolButton7;
	Vcl::Comctrls::TToolButton* btnMultiSelect;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Comctrls::TToolButton* addfast;
	Vcl::Comctrls::TToolButton* remove;
	Vcl::Comctrls::TToolButton* up;
	Vcl::Comctrls::TToolButton* down;
	Vcl::Comctrls::TToolButton* add;
	Vcl::Comctrls::TToolButton* clear;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* btnProp;
	Vcl::Comctrls::TToolButton* ToolButton4;
	Vcl::Comctrls::TToolButton* playdiv;
	Vcl::Comctrls::TToolButton* play;
	Vcl::Menus::TMenuItem* mnuAddFromFile;
	Lmdformpersistent::TLMDFormPersistent* fp;
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall lbClick(System::TObject* Sender);
	void __fastcall PopupClick(System::TObject* Sender);
	void __fastcall fileactionClick(System::TObject* Sender);
	void __fastcall fmFMDragDrop(System::TObject* Sender, int fcount, int x, int y, System::Classes::TStrings* FileList);
	void __fastcall lbDblClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall mruClick(System::TObject* Sender, const System::UnicodeString aValue, bool &Remove);
	void __fastcall lbDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall FormResize(System::TObject* Sender);
	
private:
	Lmdcustomcontainer::TLMDListItemClassType FType;
	Lmdbitmaplist::TLMDBitmapList* FBitmapList;
	Lmdgenericlist::TLMDGenericList* FGenericList;
	Lmdstringlist::TLMDStringList* FStringList;
	Lmdwavelist::TLMDWaveList* FWaveList;
	Lmdimagelist::TLMDImageList* FImageList;
	Lmdimagelist::TLMDImageListItem* FImageListItem;
	System::UnicodeString FDefaultExt;
	System::UnicodeString FName;
	void __fastcall SetList(Lmdgenericlist::TLMDGenericList* aValue);
	void __fastcall SetBitmapList(Lmdbitmaplist::TLMDBitmapList* const Value);
	void __fastcall SetImageList(Lmdimagelist::TLMDImageList* const Value);
	void __fastcall SetWaves(Lmdwavelist::TLMDWaveList* const Value);
	void __fastcall SetStrings(Lmdstringlist::TLMDStringList* aValue);
	void __fastcall SetItemHeight(int aValue);
	void __fastcall SetImageListItem(Lmdimagelist::TLMDImageListItem* const Value);
	void __fastcall WriteGeneral(void);
	bool __fastcall ImageListItemProp(Lmdimagelist::TLMDImageListItem* aValue);
	int __fastcall GetCount(void);
	bool __fastcall GetEmpty(void);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	void __fastcall ItemDelete(int index);
	
public:
	void __fastcall SetLabels(int Index, bool Update = false);
	void __fastcall SetType(const Lmdcustomcontainer::TLMDListItemClassType Value);
	__property Lmdbitmaplist::TLMDBitmapList* BitmapList = {read=FBitmapList, write=SetBitmapList};
	__property Lmdimagelist::TLMDImageList* ImageList = {read=FImageList, write=SetImageList};
	__property Lmdstringlist::TLMDStringList* StringList = {read=FStringList, write=SetStrings};
	__property Lmdwavelist::TLMDWaveList* WaveList = {read=FWaveList, write=SetWaves};
	__property Lmdgenericlist::TLMDGenericList* GenericList = {read=FGenericList, write=SetList};
	__property Lmdimagelist::TLMDImageListItem* ImageListItem = {read=FImageListItem, write=SetImageListItem};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDStdListEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDStdListEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDStdListEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStdListEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdstdlisteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSTDLISTEDITORDLG)
using namespace Plmdstdlisteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdstdlisteditordlgHPP
