// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDExtImageListEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdextimagelisteditordlgHPP
#define PlmdextimagelisteditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <System.Variants.hpp>
#include <pLMDActionsData.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDGraphicList.hpp>
#include <LMDPNGImage.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomIniComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDFormPersistent.hpp>
#include <LMDBaseMRUList.hpp>
#include <LMDHookComponent.hpp>
#include <LMDFMDrop.hpp>
#include <LMDIniCtrl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdextimagelisteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExtImageListEditorDlg;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 2> Plmdextimagelisteditordlg__1;

enum DECLSPEC_DENUM TLMDExtImageListClassType : unsigned char { icGraphicList, icPNGImageList };

class PASCALIMPLEMENTATION TLMDExtImageListEditorDlg : public Designwindows::TDesignWindow
{
	typedef Designwindows::TDesignWindow inherited;
	
__published:
	Vcl::Menus::TMainMenu* MainMenu;
	Vcl::Actnlist::TActionList* ActionList;
	Vcl::Actnlist::TAction* actLoad;
	Vcl::Actnlist::TAction* actSave;
	Vcl::Actnlist::TAction* actOK;
	Vcl::Actnlist::TAction* actPaste;
	Vcl::Menus::TMenuItem* File1;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* ools1;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Comctrls::TToolButton* ToolButton4;
	Vcl::Comctrls::TToolButton* ToolButton5;
	Vcl::Comctrls::TToolButton* ToolButton6;
	Vcl::Comctrls::TToolButton* ToolButton7;
	Vcl::Comctrls::TToolButton* ToolButton8;
	Vcl::Comctrls::TToolButton* ToolButton9;
	Vcl::Comctrls::TToolButton* ToolButton10;
	Vcl::Comctrls::TToolButton* ToolButton11;
	Vcl::Comctrls::TToolButton* ToolButton12;
	Vcl::Comctrls::TToolButton* ToolButton13;
	Vcl::Comctrls::TToolButton* ToolButton14;
	Vcl::Comctrls::TToolButton* ToolButton15;
	Vcl::Comctrls::TToolButton* ToolButton16;
	Vcl::Comctrls::TToolButton* ToolButton18;
	Vcl::Extctrls::TPanel* DetailsPanel;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Actnlist::TAction* actCut;
	Vcl::Actnlist::TAction* actCopy;
	Vcl::Actnlist::TAction* actDelete;
	Vcl::Actnlist::TAction* actUp;
	Vcl::Actnlist::TAction* actDown;
	Vcl::Actnlist::TAction* actSelectAll;
	Vcl::Actnlist::TAction* actClearAll;
	Vcl::Actnlist::TAction* actSaveSelection;
	Vcl::Comctrls::TStatusBar* StatusBar;
	Vcl::Extctrls::TPanel* ItemViewPanel;
	Vcl::Actnlist::TAction* actMultiline;
	Vcl::Actnlist::TAction* actAddItem;
	Vcl::Actnlist::TAction* actAddMultipleItems;
	Vcl::Menus::TMenuItem* Load1;
	Vcl::Menus::TMenuItem* Save1;
	Vcl::Menus::TMenuItem* OK1;
	Vcl::Menus::TMenuItem* Cut1;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Up1;
	Vcl::Menus::TMenuItem* Down1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* Selectall1;
	Vcl::Menus::TMenuItem* Clearall1;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TMenuItem* Saveas1;
	Vcl::Menus::TMenuItem* Addmultipleitems1;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Extdlgs::TOpenPictureDialog* OpenPictureDialog;
	Vcl::Extdlgs::TSavePictureDialog* SavePictureDialog;
	Vcl::Forms::TScrollBox* ScrollBox;
	Vcl::Extctrls::TImage* ImageView;
	Vcl::Comctrls::TTreeView* ItemTreeView;
	Vcl::Comctrls::TToolButton* ToolButton17;
	Vcl::Comctrls::TToolButton* ToolButton19;
	Vcl::Comctrls::TToolButton* ToolButton20;
	Vcl::Actnlist::TAction* actZoomIN;
	Vcl::Actnlist::TAction* actZoomOut;
	Vcl::Actnlist::TAction* actActualSize;
	Vcl::Comctrls::TToolButton* ToolButton21;
	Vcl::Menus::TMenuItem* View1;
	Vcl::Menus::TMenuItem* Zoomin1;
	Vcl::Menus::TMenuItem* Zoomout1;
	Vcl::Menus::TMenuItem* N4;
	Vcl::Menus::TMenuItem* Actualsize1;
	Vcl::Menus::TPopupMenu* PopupMenu;
	Vcl::Menus::TMenuItem* Additem1;
	Vcl::Menus::TMenuItem* Delete2;
	Vcl::Menus::TMenuItem* Clearall2;
	Vcl::Menus::TMenuItem* N5;
	Vcl::Menus::TMenuItem* Up2;
	Vcl::Menus::TMenuItem* Down2;
	Vcl::Menus::TMenuItem* N6;
	Lmdinictrl::TLMDIniCtrl* Ini;
	Lmdfmdrop::TLMDFMDrop* FMDrop;
	Lmdbasemrulist::TLMDBaseMRUList* MRUList;
	Lmdformpersistent::TLMDFormPersistent* FormPersistent;
	Lmdfmdrop::TLMDFMDrop* FMDrop1;
	Vcl::Menus::TMenuItem* Additem2;
	Vcl::Menus::TMenuItem* N7;
	Vcl::Controls::TImageList* Images;
	Vcl::Menus::TMenuItem* Cut2;
	Vcl::Menus::TMenuItem* Copy2;
	Vcl::Menus::TMenuItem* Paste2;
	Vcl::Menus::TMenuItem* N8;
	Vcl::Actnlist::TAction* actCancel;
	Vcl::Comctrls::TToolButton* ToolButton22;
	Vcl::Menus::TMenuItem* N9;
	Vcl::Menus::TMenuItem* Cancel1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall actAddItemExecute(System::TObject* Sender);
	void __fastcall ItemTreeViewClick(System::TObject* Sender);
	void __fastcall actMultilineExecute(System::TObject* Sender);
	void __fastcall ItemViewPanelResize(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall actUpExecute(System::TObject* Sender);
	void __fastcall actDownExecute(System::TObject* Sender);
	void __fastcall actAddMultipleItemsExecute(System::TObject* Sender);
	void __fastcall actSaveExecute(System::TObject* Sender);
	void __fastcall actLoadExecute(System::TObject* Sender);
	void __fastcall actClearAllExecute(System::TObject* Sender);
	void __fastcall actUpDownUpdate(System::TObject* Sender);
	void __fastcall actDeleteUpdate(System::TObject* Sender);
	void __fastcall actDeleteExecute(System::TObject* Sender);
	void __fastcall actPasteUpdate(System::TObject* Sender);
	void __fastcall actCutCopyExecute(System::TObject* Sender);
	void __fastcall actPasteExecute(System::TObject* Sender);
	void __fastcall actCutCopyUpdate(System::TObject* Sender);
	void __fastcall actSaveSelectionExecute(System::TObject* Sender);
	void __fastcall actSaveSelectionUpdate(System::TObject* Sender);
	void __fastcall actOKExecute(System::TObject* Sender);
	void __fastcall actZoomINExecute(System::TObject* Sender);
	void __fastcall actZoomOutExecute(System::TObject* Sender);
	void __fastcall actZoomInOutUpdate(System::TObject* Sender);
	void __fastcall actActualSizeExecute(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall ItemTreeViewKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall ItemTreeViewKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall actMultilineUpdate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall MRUListClick(System::TObject* Sender, const System::UnicodeString aValue, bool &Remove);
	void __fastcall FMDropFMDragDrop(System::TObject* Sender, int fcount, int x, int y, System::Classes::TStrings* FileList);
	void __fastcall ItemTreeViewCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall actSelectAllExecute(System::TObject* Sender);
	void __fastcall actCancelExecute(System::TObject* Sender);
	
private:
	int FZoom;
	bool FModified;
	Vcl::Graphics::TBitmap* FBmp;
	Vcl::Imglist::TCustomImageList* FImageList;
	Vcl::Comctrls::TTreeNode* FRoot;
	TLMDExtImageListClassType FListType;
	bool FShown;
	void __fastcall AddItemFromFile(System::UnicodeString FileName);
	void __fastcall AddItems(System::Classes::TStrings* Files);
	void __fastcall AddItem(Lmdgraphiclist::TLMDGraphicListItem* AItem)/* overload */;
	void __fastcall AddItem(Lmdpngimage::TLMDPNGObject* AItem)/* overload */;
	void __fastcall BuildItemTreeView(void);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall UpdateView(void);
	void __fastcall UpdateStatusBar(void);
	void __fastcall UpdateImageView(void);
	void __fastcall SaveListPath(System::UnicodeString AValue);
	System::UnicodeString __fastcall RestoreListPath(void);
	int __fastcall SelectionCount(void);
	void __fastcall SetModified(const bool Value);
	void __fastcall SetType(TLMDExtImageListClassType AValue);
	void __fastcall Scale(int ASrcW, int ASrcH, int ACntW, int ACntH, int DestL, int DestT, int dx, int dy, System::Types::TRect &DRect);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	Lmdgraphiclist::TLMDGraphicList* __fastcall GetGraphicList(void);
	Lmdpngimagelist::TLMDPNGImageList* __fastcall GetPNGImageList(void);
	
public:
	__fastcall virtual ~TLMDExtImageListEditorDlg(void);
	__property Lmdgraphiclist::TLMDGraphicList* GraphicList = {read=GetGraphicList};
	__property Lmdpngimagelist::TLMDPNGImageList* PNGImageList = {read=GetPNGImageList};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
public:
	/* TDesignWindow.Create */ inline __fastcall virtual TLMDExtImageListEditorDlg(System::Classes::TComponent* AOwner) : Designwindows::TDesignWindow(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDExtImageListEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Designwindows::TDesignWindow(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDExtImageListEditorDlg(HWND ParentWindow) : Designwindows::TDesignWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Plmdextimagelisteditordlg__1 Status;
}	/* namespace Plmdextimagelisteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDEXTIMAGELISTEDITORDLG)
using namespace Plmdextimagelisteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdextimagelisteditordlgHPP
