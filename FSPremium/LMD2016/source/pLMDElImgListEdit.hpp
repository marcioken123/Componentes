// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElImgListEdit.pas' rev: 31.00 (Windows)

#ifndef PlmdelimglisteditHPP
#define PlmdelimglisteditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <Vcl.Clipbrd.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <System.TypInfo.hpp>
#include <LMDElConst.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElPanel.hpp>
#include <ElScrollBox.hpp>
#include <ElFlatCtl.hpp>
#include <ElImgLst.hpp>
#include <ElStatBar.hpp>
#include <ElSplit.hpp>
#include <ElCheckCtl.hpp>
#include <ElEdits.hpp>
#include <ElBtnEdit.hpp>
#include <ElCombos.hpp>
#include <ElClrCmb.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElComponent.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelimglistedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TListView;
class DELPHICLASS TElImageListEditForm;
class DELPHICLASS TElImageListEditor;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TForEachSelectedHandler)(Vcl::Comctrls::TListItem* Item, int ItemIndex, void * UserData);

class PASCALIMPLEMENTATION TListView : public Vcl::Comctrls::TListView
{
	typedef Vcl::Comctrls::TListView inherited;
	
public:
	/* TCustomListView.Create */ inline __fastcall virtual TListView(System::Classes::TComponent* AOwner) : Vcl::Comctrls::TListView(AOwner) { }
	/* TCustomListView.Destroy */ inline __fastcall virtual ~TListView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TListView(HWND ParentWindow) : Vcl::Comctrls::TListView(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElImageListEditForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* Panel1;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	Elpanel::TElPanel* ElPanel1;
	Elimglst::TElImageList* WorkImageList;
	Vcl::Menus::TPopupMenu* popupLoad;
	Vcl::Menus::TMenuItem* itemImageList;
	Vcl::Menus::TMenuItem* itemBitmaps;
	Vcl::Menus::TMenuItem* itemBmpToIL;
	Vcl::Menus::TPopupMenu* popupSave;
	Vcl::Menus::TMenuItem* itemSaveToIL;
	Vcl::Menus::TMenuItem* itemILToBitmap;
	Vcl::Menus::TMenuItem* itemILSelToBitmap;
	Elpopbtn::TElPopupButton* ApplyButton;
	Vcl::Dialogs::TSaveDialog* SD;
	Vcl::Dialogs::TOpenDialog* OD;
	Vcl::Menus::TPopupMenu* popupSel;
	Vcl::Menus::TMenuItem* popupSel_Delete;
	Vcl::Menus::TMenuItem* popupSel_L1;
	Vcl::Menus::TMenuItem* popupSel_Copy;
	Vcl::Menus::TMenuItem* popupSel_Paste;
	Elpanel::TElPanel* ElPanel2;
	Elpopbtn::TElPopupButton* btnLoad;
	Elpopbtn::TElPopupButton* btnSave;
	Elpopbtn::TElPopupButton* btnClear;
	Elpopbtn::TElPopupButton* btnMono;
	Elpopbtn::TElPopupButton* btnCopy;
	Elpopbtn::TElPopupButton* btnPaste;
	Elstatbar::TElStatusBar* ElStatusBar1;
	Elpanel::TElPanel* ElPanel3;
	TListView* WorkListView;
	Elsplit::TElSplitter* ElSplitter1;
	Elpopbtn::TElPopupButton* btnDelete;
	Elpopbtn::TElPopupButton* btnMove;
	Vcl::Menus::TMenuItem* popupSel_Move;
	Vcl::Menus::TMenuItem* popupSel_Mono;
	Vcl::Extctrls::TPanel* pTop;
	Vcl::Extctrls::TPanel* pColor;
	Elclrcmb::TElColorCombo* ccTrans;
	Vcl::Stdctrls::TLabel* lbTrans;
	Vcl::Menus::TMenuItem* popupSel_TransCol;
	Elpopbtn::TElPopupButton* btnTrans;
	Elpopbtn::TElPopupButton* btnSelectAll;
	Elpanel::TElPanel* ElPanel4;
	Elscrollbox::TElScrollBox* ScrollBox;
	Vcl::Extctrls::TImage* Image;
	Elscrollbox::TElScrollBox* IconScrollBox;
	Vcl::Extctrls::TImage* IconImage;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall itemImageListClick(System::TObject* Sender);
	void __fastcall itemBmpToILClick(System::TObject* Sender);
	void __fastcall itemBitmapsClick(System::TObject* Sender);
	void __fastcall itemSaveToILClick(System::TObject* Sender);
	void __fastcall itemILToBitmapClick(System::TObject* Sender);
	void __fastcall itemILSelToBitmapClick(System::TObject* Sender);
	void __fastcall WorkListViewKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall WorkListViewSelectItem(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, bool Selected);
	void __fastcall WorkListViewStartDrag(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	void __fastcall WorkListViewDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall WorkListViewDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall btnMonoClick(System::TObject* Sender);
	void __fastcall popupSelPopup(System::TObject* Sender);
	void __fastcall ApplyButtonClick(System::TObject* Sender);
	void __fastcall OkButtonClick(System::TObject* Sender);
	void __fastcall btnCopyClick(System::TObject* Sender);
	void __fastcall btnPasteClick(System::TObject* Sender);
	void __fastcall WorkImageListChange(System::TObject* Sender);
	void __fastcall popupSavePopup(System::TObject* Sender);
	void __fastcall ElSplitter1PositionChanged(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall btnMoveClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall WorkListViewDeletion(System::TObject* Sender, Vcl::Comctrls::TListItem* Item);
	void __fastcall ImageMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall popupSel_TransColClick(System::TObject* Sender);
	void __fastcall ImageDblClick(System::TObject* Sender);
	void __fastcall btnTransClick(System::TObject* Sender);
	void __fastcall btnSelectAllClick(System::TObject* Sender);
	void __fastcall WorkListViewMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ScrollBoxMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
private:
	Vcl::Extdlgs::TOpenPictureDialog* fOD;
	Elimglst::TElImageList* fEditImageList;
	bool fModified;
	int fMoveIndex;
	
protected:
	void __fastcall SetImageSize(int Width, int Height);
	void __fastcall SetImageList(Elimglst::TElImageList* IL);
	HIDESBASE MESSAGE void __fastcall WMActivate(Winapi::Messages::TWMActivate &Msg);
	void __fastcall CheckEnabledPaste(void);
	void __fastcall UpdateSelected(void);
	MESSAGE void __fastcall WMChangeTrans(Winapi::Messages::TMessage &Msg);
	void __fastcall ForEachSelected(TForEachSelectedHandler Handler, void * UserData);
	void __fastcall DeleteHandler(Vcl::Comctrls::TListItem* Item, int ItemIndex, void * UserData);
	void __fastcall SaveImageHandler(Vcl::Comctrls::TListItem* Item, int ItemIndex, void * UserData);
	void __fastcall MoveImagesToPos(System::TObject* Sender, int NewPos, int OldPos);
	void __fastcall MonoImageHandler(Vcl::Comctrls::TListItem* Item, int ItemIndex, void * UserData);
	void __fastcall TransHandler(Vcl::Comctrls::TListItem* Item, int ItemIndex, void * UserData);
	
public:
	void __fastcall SetEditImageList(Elimglst::TElImageList* IL);
	__property bool Modified = {read=fModified, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElImageListEditForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElImageListEditForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElImageListEditForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElImageListEditForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElImageListEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TElImageListEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElImageListEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_CHANGETRANSPARENT = System::Word(0x500);
extern DELPHI_PACKAGE TElImageListEditForm* ElImageListEditForm;
}	/* namespace Plmdelimglistedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELIMGLISTEDIT)
using namespace Plmdelimglistedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelimglisteditHPP
