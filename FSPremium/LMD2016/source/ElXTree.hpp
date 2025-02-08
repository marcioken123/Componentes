// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElXTree.pas' rev: 31.00 (Windows)

#ifndef ElxtreeHPP
#define ElxtreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <System.Math.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.Types.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <System.Variants.hpp>
#include <Winapi.ActiveX.hpp>
#include <Vcl.Themes.hpp>
#include <LMDTypes.hpp>
#include <LMDElConst.hpp>
#include <LMDBmp.hpp>
#include <LMDUtils.hpp>
#include <LMDProcs.hpp>
#include <LMDStrings.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUnicode.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDObjectList.hpp>
#include <LMDGlyphs.hpp>
#include <LMDSysIn.hpp>
#include <LMDArray.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDGraph.hpp>
#include <LMDFiles.hpp>
#include <ElXTreeCell.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElVCLUtils.hpp>
#include <ElIni.hpp>
#include <ElDragDrop.hpp>
#include <ElImgFrm.hpp>
#include <Winapi.Imm.hpp>
#include <ElInputProcessor.hpp>
#include <ElXHeader.hpp>
#include <ElStyleMan.hpp>
#include <ElHook.hpp>
#include <ElXPThemedControl.hpp>
#include <ElHeader.hpp>
#include <ElSBCtrl.hpp>
#include <ElScrollBar.hpp>
#include <ElHintWnd.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elxtree
{
//-- forward type declarations -----------------------------------------------
struct TElXTreeItemStaticData;
class DELPHICLASS TElXTreeCell;
class DELPHICLASS TElXTreeCellRow;
class DELPHICLASS TElXTreeItemStaticDataEx;
class DELPHICLASS TElXTreeItem;
class DELPHICLASS TElXTreeItems;
struct TMouseFrameRec;
class DELPHICLASS TElXHackHeaderCellRow;
class DELPHICLASS TElXHackHeaderSection;
class DELPHICLASS TElXTreeHeader;
class DELPHICLASS TElXTreeView;
class DELPHICLASS TElXDataCache;
class DELPHICLASS TElXTreeScrollBar;
class DELPHICLASS TCustomElXTree;
class DELPHICLASS TElXTree;
class DELPHICLASS TElXTreeDragObject;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TInplaceEditorNeededXEvent)(System::TObject* Sender, TElXTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);

struct DECLSPEC_DRECORD TElXTreeItemStaticData
{
public:
	Lmdtypes::TLMDString FText;
	Lmdtypes::TLMDString FHint;
	Elxtreecell::TElXCellStyle* FCellStyle;
};


typedef TElXTreeItemStaticData *PElXTreeItemStaticData;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXTreeCell : public Elxtreecell::TElXCustomTreeCell
{
	typedef Elxtreecell::TElXCustomTreeCell inherited;
	
private:
	HIDESBASE TElXTreeCell* __fastcall GetJointCellMaster(void);
	
protected:
	Elxheader::TElXHeaderSection* __fastcall GetElHeaderSection(void);
	HIDESBASE TElXTreeItem* __fastcall GetOwner(void);
	void __fastcall SetOwner(TElXTreeItem* const Value);
	virtual void __fastcall SetWidth(const int AValue);
	
public:
	__property TElXTreeItem* Owner = {read=GetOwner, write=SetOwner};
	__property Elxheader::TElXHeaderSection* HeaderSection = {read=GetElHeaderSection};
	__property Data;
	__property Selected;
	__property Index;
	__property UserText;
	__property Text = {default=0};
	__property Control;
	__property CurrentStyle;
	__property Style;
	__property Width;
	__property Height;
	__property HTMLControlsVisible = {default=1};
	__property JointCellRole;
	__property JointRowCount;
	__property JointColumnCount;
	__property TElXTreeCell* JointCellMaster = {read=GetJointCellMaster};
	__property UseOwnStyle;
	__property Tag;
public:
	/* TElXCustomTreeCell.Create */ inline __fastcall virtual TElXTreeCell(System::Classes::TPersistent* AOwner) : Elxtreecell::TElXCustomTreeCell(AOwner) { }
	/* TElXCustomTreeCell.Destroy */ inline __fastcall virtual ~TElXTreeCell(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElXTreeCellRow : public Elxtreecell::TElXTreeCustomCellRow
{
	typedef Elxtreecell::TElXTreeCustomCellRow inherited;
	
public:
	TElXTreeCell* operator[](int AIndex) { return this->Cell[AIndex]; }
	
protected:
	TElXTreeItem* FOwner;
	int FCol;
	HIDESBASE TElXTreeCell* __fastcall GetCell(int AIndex);
	int __fastcall GetCol(void);
	void __fastcall SetCol(const int Value);
	virtual void __fastcall CreateCells(TElXTreeItem* AOwner);
	
public:
	__fastcall TElXTreeCellRow(TElXTreeItem* AOwner);
	HIDESBASE virtual TElXTreeCell* __fastcall Add(void);
	HIDESBASE virtual TElXTreeCell* __fastcall Insert(int AIndex)/* overload */;
	HIDESBASE TElXTreeCell* __fastcall Insert(int AIndex, TElXTreeCell* ACell)/* overload */;
	__property TElXTreeCell* Cell[int AIndex] = {read=GetCell/*, default*/};
	__property TElXTreeItem* Owner = {read=FOwner};
	__property int Col = {read=GetCol, nodefault};
	__property Count;
public:
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElXTreeCellRow(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXTreeItemStaticDataEx : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElXTreeItem* ItemRef;
	Elxtreecell::TElSTIStates FState;
	
protected:
	int FBoolData1;
	int FIndentAdjust;
	Eltreeinplaceeditors::TElCheckBoxType FCheckBoxType;
	Vcl::Stdctrls::TCheckBoxState FCheckBoxState;
	int FImageIndex;
	int FStImageIndex;
	int FImageIndex2;
	int FStImageIndex2;
	int FOverlayIndex;
	int FOverlayIndex2;
	int __fastcall GetImage(int Index);
	void __fastcall SetImage(int Index, int Value);
	bool __fastcall GetBoolFlag(int Index);
	void __fastcall SetBoolFlag(int Index, bool Value);
	void __fastcall Assign(TElXTreeItemStaticDataEx* Source);
	
public:
	__property Vcl::Stdctrls::TCheckBoxState CheckBoxState = {read=FCheckBoxState, write=FCheckBoxState, nodefault};
	__property Eltreeinplaceeditors::TElCheckBoxType CheckBoxType = {read=FCheckBoxType, write=FCheckBoxType, nodefault};
	__property int ImageIndex = {read=GetImage, write=SetImage, index=0, nodefault};
	__property int ImageIndex2 = {read=GetImage, write=SetImage, index=1, nodefault};
	__property int StImageIndex = {read=GetImage, write=SetImage, index=2, nodefault};
	__property int StImageIndex2 = {read=GetImage, write=SetImage, index=3, nodefault};
	__property int OverlayIndex = {read=GetImage, write=SetImage, index=4, nodefault};
	__property int OverlayIndex2 = {read=GetImage, write=SetImage, index=5, nodefault};
	__property int IndentAdjust = {read=FIndentAdjust, write=FIndentAdjust, nodefault};
	__property bool SuppressLines = {read=GetBoolFlag, write=SetBoolFlag, index=4, nodefault};
	__property bool ForceButtons = {read=GetBoolFlag, write=SetBoolFlag, index=32, nodefault};
	__property bool StrikedOutLine = {read=GetBoolFlag, write=SetBoolFlag, index=64, nodefault};
	__property bool DrawHLine = {read=GetBoolFlag, write=SetBoolFlag, index=128, nodefault};
	__property bool AllowEdit = {read=GetBoolFlag, write=SetBoolFlag, index=512, nodefault};
	__property bool UseBackGroundColor = {read=GetBoolFlag, write=SetBoolFlag, index=1024, nodefault};
	__property bool Enabled = {read=GetBoolFlag, write=SetBoolFlag, index=32768, nodefault};
	__property bool SuppressButtons = {read=GetBoolFlag, write=SetBoolFlag, index=65536, nodefault};
	__property bool CheckBoxEnabled = {read=GetBoolFlag, write=SetBoolFlag, index=131072, nodefault};
	__property bool ShowCheckBox = {read=GetBoolFlag, write=SetBoolFlag, index=262144, nodefault};
	__property bool HintIsHTML = {read=GetBoolFlag, write=SetBoolFlag, index=4194304, nodefault};
public:
	/* TObject.Create */ inline __fastcall TElXTreeItemStaticDataEx(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TElXTreeItemStaticDataEx(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXTreeItem : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	void __fastcall IterateProc(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	void __fastcall InvalidateItemPart(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	
protected:
	Elxtreecell::TElXCellStyle* FVirtStyle;
	Lmdhtmlunit::TLMDHTMLData* FHTMLData;
	Lmdarray::TLMDArray* FHTMLDataArray;
	void *FData;
	int FTag;
	System::TObject* FObject;
	System::_di_IInterface FDataInterface;
	void *FSortData;
	int FSortType;
	int FSortRef;
	TElXTreeItemStaticData *FStaticData;
	TElXTreeItemStaticDataEx* FStaticDataEx;
	unsigned FComplexHeight;
	System::Types::TRect FTextRect;
	Lmdobjectlist::TLMDObjectList* FChildren;
	TCustomElXTree* FOwner;
	TElXTreeItems* FList;
	int FBoolData;
	TElXTreeItem* FParent;
	TElXTreeItem* FRoot;
	TElXTreeCellRow* FCells;
	bool FUseOwnStyle;
	virtual TElXTreeCell* __fastcall CreateCell(void);
	TElXTreeCell* __fastcall CreateIntermediateCells(int AIndex);
	Elxheader::TElXHeaderSections* __fastcall GetHeaderSections(void);
	Lmdtypes::TLMDString __fastcall GetText(void);
	virtual Lmdtypes::TLMDString __fastcall GetHint(void);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	TElXTreeItem* __fastcall GetParent(void);
	int __fastcall GetLevel(void);
	bool __fastcall GetHasChildren(void);
	bool __fastcall GetHasVisibleChildren(void);
	void __fastcall SetExpanded(bool value);
	virtual int __fastcall GetIndex(void);
	virtual int __fastcall GetAbsIndex(void);
	int __fastcall GetVisIndex(void);
	int __fastcall GetChildIndex(TElXTreeItem* Child);
	bool __fastcall IsExpanded(void);
	bool __fastcall GetFullExpand(void);
	void __fastcall MakeFullyExpanded(bool value);
	void __fastcall SetImageIndex(int Index, int value);
	void __fastcall SetForceButtons(bool newValue);
	int __fastcall GetChildrenCount(void);
	int __fastcall GetCount(void);
	TElXTreeItem* __fastcall GetItems(int Index);
	void __fastcall OnStyleDelete(System::TObject* Sender, void * &Item);
	void __fastcall SetUseOwnStyle(bool AValue);
	bool __fastcall GetUseOwnStyle(void);
	void __fastcall SetCheckBoxState(Vcl::Stdctrls::TCheckBoxState newValue);
	void __fastcall SetChecked(bool newValue);
	bool __fastcall GetChecked(void);
	void __fastcall SetShowCheckBox(bool newValue);
	void __fastcall SetCheckBoxType(Eltreeinplaceeditors::TElCheckBoxType newValue);
	void __fastcall SetCheckBoxEnabled(bool newValue);
	void __fastcall SetSuppressButtons(bool newValue);
	void __fastcall SetEnabled(bool newValue);
	void __fastcall SetHidden(bool newValue);
	bool __fastcall GetFullyVisible(void);
	void __fastcall SetFullyVisible(bool newValue);
	bool __fastcall GetSelected(void);
	void __fastcall DoSetSelected(bool newValue);
	void __fastcall SetSelected(bool newValue);
	virtual void __fastcall SetOwnerHeight(bool newValue);
	virtual void __fastcall SetHeight(int newValue);
	virtual int __fastcall GetHeight(void);
	void __fastcall SetSuppressLines(bool newValue);
	virtual void __fastcall SetText(Lmdtypes::TLMDString Value);
	void __fastcall RemoveChild(TElXTreeItem* Child);
	void __fastcall RemoveSubChild(TElXTreeItem* Child);
	void __fastcall DeleteChild(TElXTreeItem* Child);
	int __fastcall AddChild(TElXTreeItem* Child);
	void __fastcall AddExistingChild(TElXTreeItem* Child);
	int __fastcall AddLastChild(TElXTreeItem* Child);
	int __fastcall InsertChild(int index, TElXTreeItem* Child);
	void __fastcall ExchangeItems(int I, int J);
	void __fastcall QuickSort(bool recursive, int L, int R, Elheader::TElSSortMode SM, Eltreeinplaceeditors::TSortTypes SortType, int FSortSection);
	void __fastcall AddSortData(Eltreeinplaceeditors::TSortTypes SortType, int FSortSection);
	void __fastcall ReleaseSortData(void);
	void __fastcall NormalizeSorts(int StartIdx);
	bool __fastcall GetOwnerHeight(void);
	virtual void __fastcall SetMultiline(bool newValue);
	void __fastcall SetIsHTML(bool newValue);
	void __fastcall OnHTMLDataDestroy(System::TObject* Sender, void * Item);
	TElXTreeItem* __fastcall GetAncestor(void);
	void __fastcall SetDrawHLine(const bool Value);
	void __fastcall SetAllowEdit(const bool Value);
	int __fastcall CalcSubItemsHeight(void);
	void __fastcall NewStaticData(void);
	void __fastcall DisposeStaticData(void);
	void __fastcall FillStaticData(void);
	void __fastcall CreateStyle(void);
	Elxtreecell::TElXCellStyleRead* __fastcall GetCurrentStyle(void);
	Elxtreecell::TElXCellStyle* __fastcall GetStyle(void);
	bool __fastcall GetUseBackGroundColor(void);
	bool __fastcall GetDrawHLine(void);
	bool __fastcall GetAllowEdit(void);
	bool __fastcall GetForceButtons(void);
	bool __fastcall GetSuppressButtons(void);
	bool __fastcall GetSuppressLines(void);
	bool __fastcall GetIsHTML(void);
	bool __fastcall GetMultiline(void);
	bool __fastcall GetShowCheckBox(void);
	bool __fastcall GetCheckBoxEnabled(void);
	bool __fastcall GetEnabled(void);
	bool __fastcall GetHidden(void);
	void __fastcall CheckHidden(void);
	void __fastcall SetIndentAdjust(int Value);
	bool __fastcall GetDropTarget(void);
	bool __fastcall GetHintIsHTML(void);
	void __fastcall SetHintIsHTML(bool Value);
	void __fastcall ClearSubChild(void);
	int __fastcall GetTextDim(int Index);
	void __fastcall SetIndex(int Value);
	void __fastcall NewStaticDataEx(void);
	void __fastcall DisposeStaticDataEx(void);
	int __fastcall GetImageIndex(int Index);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetCheckBoxState(void);
	Eltreeinplaceeditors::TElCheckBoxType __fastcall GetCheckBoxType(void);
	int __fastcall GetIndentAdjust(void);
	bool __fastcall GetFocused(void);
	void __fastcall SetFocused(bool Value);
	void __fastcall UpdateChangedMainText(void);
	void __fastcall UpdateChangedCellText(int CellIndex);
	void __fastcall NewVirtualSort(void);
	void __fastcall SetWordWrap(bool AWrap);
	bool __fastcall GetWordWrap(void);
	bool __fastcall GetWholeLine(void);
	void __fastcall SetWholeLine(bool Value);
	bool __fastcall GetBoolStaticDataEx(const int Index);
	void __fastcall SetBoolStaticDataEx(const int Index, const bool Value);
	System::Types::TRect __fastcall GetClipRect(void);
	virtual TElXTreeCellRow* __fastcall CreateCellRow(TElXTreeItem* AOwner);
	
public:
	__fastcall virtual TElXTreeItem(TCustomElXTree* AOwner);
	__fastcall virtual ~TElXTreeItem(void);
	virtual void __fastcall ReRenderMainText(void);
	virtual void __fastcall ReRenderAllTexts(void);
	virtual void __fastcall ReRenderCellText(int ColNum);
	virtual int __fastcall GetWidth(void);
	System::Uitypes::TColor __fastcall BackGroundColor(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall ImportFromOldTree(System::Classes::TStream* Stream, int Ver);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall InsertNewCell(int AIndex);
	void __fastcall DeleteCell(int AIndex);
	bool __fastcall IsUnder(TElXTreeItem* Item);
	Lmdtypes::TLMDString __fastcall GetFullName(Lmdtypes::TLMDString separator);
	Lmdtypes::TLMDString __fastcall GetFullNameEx(Lmdtypes::TLMDString separator, bool AddRoot);
	void __fastcall Expand(bool recursive);
	void __fastcall Collapse(bool recursive);
	void __fastcall Sort(bool recursive);
	virtual void __fastcall MoveTo(TElXTreeItem* NewParent);
	virtual void __fastcall MoveToIns(TElXTreeItem* NewParent, int AnIndex);
	virtual void __fastcall CopyTo(TElXTreeItem* NewParent);
	void __fastcall UpdateItem(void);
	void __fastcall Clear(void);
	TElXTreeItem* __fastcall GetFirstVisibleChild(void);
	TElXTreeItem* __fastcall GetFirstChild(void);
	TElXTreeItem* __fastcall GetLastChild(void);
	TElXTreeItem* __fastcall GetNextChild(TElXTreeItem* Child);
	TElXTreeItem* __fastcall GetPrevChild(TElXTreeItem* Child);
	TElXTreeItem* __fastcall GetFirstSibling(void);
	TElXTreeItem* __fastcall GetLastSibling(void);
	TElXTreeItem* __fastcall GetNextSibling(void);
	TElXTreeItem* __fastcall GetPrevSibling(void);
	TElXTreeItem* __fastcall GetLastSubItem(void);
	TElXTreeItem* __fastcall GetChildByIndex(int index);
	void __fastcall EditText(void);
	virtual void __fastcall Delete(void);
	__property TCustomElXTree* TreeView = {read=FOwner};
	bool __fastcall IsVisible(void);
	TElXTreeItem* __fastcall GetNextVisible(void);
	TElXTreeItem* __fastcall GetPrevVisible(void);
	virtual TElXTreeItem* __fastcall GetPrev(void);
	virtual TElXTreeItem* __fastcall GetNext(void);
	virtual void __fastcall MoveToItem(TElXTreeItem* Item, Eltreeinplaceeditors::TNodeAttachMode Mode);
	void __fastcall RedrawItem(bool ADoCheck);
	void __fastcall RedrawItemPart(bool DoCheck, int Left, int Right);
	System::Types::TRect __fastcall DisplayRect(bool TextOnly);
	void __fastcall EndEdit(bool ByCancel);
	void __fastcall RecalcHeight(void);
	bool __fastcall HasAsParent(TElXTreeItem* Item);
	int __fastcall IndexOf(TElXTreeItem* Item);
	void __fastcall MakeVisible(void);
	virtual void __fastcall AllocateStorage(int MaxItems);
	bool __fastcall IsFirstChild(void);
	bool __fastcall IsLastChild(void);
	Vcl::Controls::TControl* __fastcall GetHTMLControlByName(Lmdtypes::TLMDString aControlName);
	void __fastcall HideHTMLControls(void);
	__property Lmdarray::TLMDArray* HTMLDataArray = {read=FHTMLDataArray};
	__property void * Data = {read=FData, write=FData};
	__property System::TObject* AnObject = {read=FObject, write=FObject};
	__property System::_di_IInterface DataInterface = {read=FDataInterface, write=FDataInterface};
	__property TCustomElXTree* Owner = {read=FOwner};
	__property TElXTreeItem* Parent = {read=GetParent, write=MoveTo};
	__property bool HasVisibleChildren = {read=GetHasVisibleChildren, nodefault};
	__property bool HasChildren = {read=GetHasChildren, nodefault};
	__property int Index = {read=GetIndex, write=SetIndex, nodefault};
	__property int AbsoluteIndex = {read=GetAbsIndex, nodefault};
	__property int VisIndex = {read=GetVisIndex, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property int ChildrenCount = {read=GetChildrenCount, nodefault};
	__property TElXTreeItem* Children[int Index] = {read=GetItems};
	__property TElXTreeItem* Item[int Index] = {read=GetItems};
	__property int Level = {read=GetLevel, nodefault};
	__property TElXTreeItem* Ancestor = {read=GetAncestor};
	__property bool DrawHLine = {read=GetDrawHLine, write=SetDrawHLine, nodefault};
	__property bool Selected = {read=GetSelected, write=SetSelected, nodefault};
	__property bool FullyVisible = {read=GetFullyVisible, write=SetFullyVisible, nodefault};
	__property bool DropTarget = {read=GetDropTarget, nodefault};
	__property System::Types::TRect TextRect = {read=FTextRect, write=FTextRect};
	__property Elxtreecell::TElXCellStyleRead* CurrentStyle = {read=GetCurrentStyle};
	__property Elxtreecell::TElXCellStyle* Style = {read=GetStyle};
	__property TElXTreeCellRow* Cells = {read=FCells};
	__property bool Focused = {read=GetFocused, write=SetFocused, nodefault};
	
__published:
	__property bool FullyExpanded = {read=GetFullExpand, write=MakeFullyExpanded, nodefault};
	__property bool Expanded = {read=IsExpanded, write=SetExpanded, nodefault};
	__property bool UseOwnStyle = {read=GetUseOwnStyle, write=SetUseOwnStyle, nodefault};
	__property bool WholeLine = {read=GetWholeLine, write=SetWholeLine, default=0};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property bool AllowEdit = {read=GetAllowEdit, write=SetAllowEdit, nodefault};
	__property int IndentAdjust = {read=GetIndentAdjust, write=SetIndentAdjust, nodefault};
	__property bool HintIsHTML = {read=GetHintIsHTML, write=SetHintIsHTML, nodefault};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property bool IsHTML = {read=GetIsHTML, write=SetIsHTML, nodefault};
	__property Vcl::Stdctrls::TCheckBoxState CheckBoxState = {read=GetCheckBoxState, write=SetCheckBoxState, default=0};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property bool ShowCheckBox = {read=GetShowCheckBox, write=SetShowCheckBox, default=0};
	__property Eltreeinplaceeditors::TElCheckBoxType CheckBoxType = {read=GetCheckBoxType, write=SetCheckBoxType, default=0};
	__property bool CheckBoxEnabled = {read=GetCheckBoxEnabled, write=SetCheckBoxEnabled, nodefault};
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, default=1};
	__property bool Hidden = {read=GetHidden, write=SetHidden, nodefault};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property bool OwnerHeight = {read=GetOwnerHeight, write=SetOwnerHeight, nodefault};
	__property bool Multiline = {read=GetMultiline, write=SetMultiline, nodefault};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, index=0, default=-1};
	__property int StateImageIndex = {read=GetImageIndex, write=SetImageIndex, index=2, default=-1};
	__property int ImageIndex2 = {read=GetImageIndex, write=SetImageIndex, index=1, default=-1};
	__property int StateImageIndex2 = {read=GetImageIndex, write=SetImageIndex, index=3, default=-1};
	__property int OverlayIndex = {read=GetImageIndex, write=SetImageIndex, index=4, default=-1};
	__property int OverlayIndex2 = {read=GetImageIndex, write=SetImageIndex, index=5, default=-1};
	__property bool ForceButtons = {read=GetForceButtons, write=SetForceButtons, default=0};
	__property bool SuppressButtons = {read=GetSuppressButtons, write=SetSuppressButtons, default=0};
	__property bool SuppressLines = {read=GetSuppressLines, write=SetSuppressLines, nodefault};
	__property Lmdtypes::TLMDString Hint = {read=GetHint, write=SetHint};
};

#pragma pack(pop)

typedef System::TMetaClass* TElXTreeItemClass;

typedef bool __fastcall (*TElXLookupCompareProc)(TElXTreeItem* Item, void * SearchDetails);

typedef bool __fastcall (__closure *TElXLookupCompareMethod)(TElXTreeItem* Item, void * SearchDetails);

typedef void __fastcall (*TElXIterateProc)(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);

typedef void __fastcall (__closure *TElXIterateMethod)(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXTreeItems : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	TElXTreeItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	void __fastcall IntFind(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	void __fastcall IntFind1(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	void __fastcall IntFind2(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	void __fastcall IntFind3(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	
protected:
	TCustomElXTree* FOwner;
	TElXTreeItem* FRoot;
	TElXTreeItemClass FItemClass;
	virtual void __fastcall RecheckMasterCells(void);
	int __fastcall GetVisCount(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual TElXTreeItem* __fastcall CreateItem(TCustomElXTree* FOwner);
	int __fastcall GetCount(void);
	int __fastcall GetRootCount(void);
	TElXTreeItem* __fastcall GetRootItem(int Index);
	TElXTreeItem* __fastcall GetItem(int index);
	TElXTreeItem* __fastcall GetVisItem(int index);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TElXTreeItems(TCustomElXTree* AOwner);
	__fastcall TElXTreeItems(TCustomElXTree* AOwner, TElXTreeItemClass ItemClass);
	void __fastcall DoInCreate(TCustomElXTree* AOwner);
	__fastcall virtual ~TElXTreeItems(void);
	void __fastcall AddExistingItem(TElXTreeItem* Item, TElXTreeItem* Parent);
	void __fastcall InsertExistingItem(TElXTreeItem* Item, TElXTreeItem* Parent, int Index);
	void __fastcall RemoveItem(TElXTreeItem* Child);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(Lmdtypes::TLMDString FileName);
	void __fastcall LoadFromFile(Lmdtypes::TLMDString FileName);
	void __fastcall SaveToStringList(System::Classes::TStrings* AStrings);
	void __fastcall LoadFromStringList(System::Classes::TStrings* Strings);
	void __fastcall LoadFromWideStringList(System::Classes::TStrings* Strings);
	void __fastcall SaveToWideStringList(System::Classes::TStrings* AStrings);
	void __fastcall DeleteItem(TElXTreeItem* Child);
	int __fastcall GetAbsIndex(TElXTreeItem* Child);
	int __fastcall GetVisIndex(TElXTreeItem* Child);
	TElXTreeItem* __fastcall AddItem(TElXTreeItem* Parent);
	TElXTreeItem* __fastcall AddLastItem(TElXTreeItem* Parent);
	void __fastcall SetItem(int Index, TElXTreeItem* Value);
	TElXTreeItem* __fastcall SetItemsByString(Lmdtypes::TLMDString AItemPath, TElXTreeItem* AStartItem = (TElXTreeItem*)(0x0), bool AReturnLastInserted = true, System::WideChar APathSeparator = (System::WideChar)(0x5c), System::WideChar ACellSeparator = (System::WideChar)(0x9), bool AJustInsert = false);
	TElXTreeItem* __fastcall InsertItem(int Index, TElXTreeItem* Parent);
	void __fastcall AllocateStorage(int MaxItems);
	void __fastcall AllocateStorageInRoot(int MaxItems);
	virtual TElXTreeItem* __fastcall Add(TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElXTreeItem* __fastcall AddChild(TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElXTreeItem* __fastcall AddChildFirst(TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElXTreeItem* __fastcall AddChildObject(TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElXTreeItem* __fastcall AddChildObjectFirst(TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElXTreeItem* __fastcall AddFirst(TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElXTreeItem* __fastcall AddObject(TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElXTreeItem* __fastcall AddObjectFirst(TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElXTreeItem* __fastcall Insert(TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElXTreeItem* __fastcall InsertObject(TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElXTreeItem* __fastcall InsertAfter(TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElXTreeItem* __fastcall InsertAfterObject(TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	TElXTreeItem* __fastcall InsertItemFromString(int Index, Lmdtypes::TLMDString AString, System::WideChar ASeparator = (System::WideChar)(0x9));
	virtual void __fastcall Delete(TElXTreeItem* Item);
	TElXTreeItem* __fastcall GetFirstNode(void);
	void __fastcall Clear(void);
	void __fastcall IterateBranch(bool VisibleOnly, TElXIterateProc IterateProc, void * IterateData, TElXTreeItem* BranchParent)/* overload */;
	void __fastcall IterateFrom(bool VisibleOnly, bool CheckCollapsed, TElXIterateProc IterateProc, void * IterateData, TElXTreeItem* StartFrom)/* overload */;
	void __fastcall IterateBackFrom(bool VisibleOnly, bool CheckCollapsed, TElXIterateProc IterateProc, void * IterateData, TElXTreeItem* StartFrom)/* overload */;
	void __fastcall Iterate(bool VisibleOnly, bool CheckCollapsed, TElXIterateProc IterateProc, void * IterateData)/* overload */;
	void __fastcall IterateBack(bool VisibleOnly, bool CheckCollapsed, TElXIterateProc IterateProc, void * IterateData)/* overload */;
	void __fastcall Iterate(bool VisibleOnly, bool CheckCollapsed, TElXIterateMethod IterateMethod, void * IterateData)/* overload */;
	void __fastcall IterateBack(bool VisibleOnly, bool CheckCollapsed, TElXIterateMethod IterateMethod, void * IterateData)/* overload */;
	void __fastcall IterateFrom(bool VisibleOnly, bool CheckCollapsed, TElXIterateMethod IterateMethod, void * IterateData, TElXTreeItem* StartFrom)/* overload */;
	void __fastcall IterateBackFrom(bool VisibleOnly, bool CheckCollapsed, TElXIterateMethod IterateMethod, void * IterateData, TElXTreeItem* StartFrom)/* overload */;
	void __fastcall IterateBranch(bool VisibleOnly, TElXIterateMethod IterateMethod, void * IterateData, TElXTreeItem* BranchParent)/* overload */;
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	TElXTreeItem* __fastcall LookForItem(TElXTreeItem* StartItem, Lmdtypes::TLMDString TextToFind, void * DataToFind, int ColumnNum, bool LookForData, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool NoCase);
	TElXTreeItem* __fastcall LookForItem2(TElXTreeItem* StartItem, Lmdtypes::TLMDString TextToFind, bool WholeTextOnly, void * DataToFind, int ColumnNum, bool LookForData, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool CheckCollapsed, bool NoCase);
	TElXTreeItem* __fastcall LookForItemEx(TElXTreeItem* StartItem, int ColumnNum, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, void * SearchDetails, TElXLookupCompareProc CompareProc);
	TElXTreeItem* __fastcall LookBackForItemEx2(TElXTreeItem* StartItem, int ColumnNum, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool CheckCollapsed, void * SearchDetails, TElXLookupCompareProc CompareProc);
	TElXTreeItem* __fastcall LookForItemEx2(TElXTreeItem* StartItem, int ColumnNum, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool CheckCollapsed, void * SearchDetails, TElXLookupCompareProc CompareProc)/* overload */;
	TElXTreeItem* __fastcall LookForItemEx2(TElXTreeItem* StartItem, int ColumnNum, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool CheckCollapsed, void * SearchDetails, TElXLookupCompareMethod CompareMethod)/* overload */;
	__property TElXTreeItemClass ItemClass = {read=FItemClass, write=FItemClass};
	__property TCustomElXTree* Owner = {read=FOwner};
	__property TElXTreeItem* Item[int Index] = {read=GetItem/*, default*/};
	__property TElXTreeItem* ItemAsVis[int Index] = {read=GetVisItem};
	__property int Count = {read=GetCount, nodefault};
	__property int VisCount = {read=GetVisCount, nodefault};
	__property int RootCount = {read=GetRootCount, nodefault};
	__property TElXTreeItem* RootItem[int Index] = {read=GetRootItem};
	__property TElXTreeItem* Root = {read=FRoot};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TElXOleDragStartEvent)(System::TObject* Sender, _di_IDataObject &dataObj, _di_IDropSource &dropSource, Eldragdrop::TDragTypes &dwOKEffects);

typedef void __fastcall (__closure *TElXOleDragFinishEvent)(System::TObject* Sender, Eldragdrop::TDragType dwEffect, HRESULT Result);

typedef void __fastcall (__closure *TElXMeasureItemPartEvent)(System::TObject* Sender, TElXTreeItem* Item, int PartIndex, System::Types::TPoint &Size);

typedef void __fastcall (__closure *TElXOnItemDrawEvent)(System::TObject* Sender, TElXTreeItem* Item, Vcl::Graphics::TCanvas* Surface, const System::Types::TRect &R, int SectionIndex);

typedef void __fastcall (__closure *TElXOnCellDrawEvent)(System::TObject* ASender, TElXTreeCell* ACell, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &R);

typedef void __fastcall (__closure *TElXOnShowHintEvent)(System::TObject* Sender, TElXTreeItem* Item, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text, Vcl::Controls::THintWindow* HintWindow, const System::Types::TPoint &MousePos, bool &DoShowHint);

typedef void __fastcall (__closure *TElXApplyVisFilterEvent)(System::TObject* Sender, TElXTreeItem* Item, bool &Hidden);

typedef void __fastcall (__closure *TElXTuneUpInplaceEditEvent)(System::TObject* Sender, TElXTreeItem* Item, int SectionIndex, Vcl::Stdctrls::TCustomEdit* Editor);

typedef void __fastcall (__closure *TElXOnItemExpandEvent)(System::TObject* Sender, TElXTreeItem* Item);

typedef void __fastcall (__closure *TElXOnItemCheckedEvent)(System::TObject* Sender, TElXTreeItem* Item);

typedef void __fastcall (__closure *TElXOnItemCheckStateChangingEvent)(System::TObject* Sender, TElXTreeItem* Item, int OldValue, int &NewValue, bool &AllowChange);

typedef void __fastcall (__closure *TElXItemSelChangeEvent)(System::TObject* Sender, TElXTreeItem* Item);

typedef void __fastcall (__closure *TElXOnItemChangeEvent)(System::TObject* Sender, TElXTreeItem* Item, Eltreeinplaceeditors::TItemChangeMode ItemChangeMode);

typedef void __fastcall (__closure *TElXOnCellChangeEvent)(System::TObject* Sender, TElXTreeItem* Item, TElXTreeCell* Cell, Eltreeinplaceeditors::TItemChangeMode ItemChangeMode);

typedef void __fastcall (__closure *TElXOnCompareItems)(System::TObject* Sender, TElXTreeItem* Item1, TElXTreeItem* Item2, int &res);

typedef void __fastcall (__closure *TElXOnItemExpanding)(System::TObject* Sender, TElXTreeItem* Item, bool &CanProcess);

typedef void __fastcall (__closure *TElXOnPicDrawEvent)(System::TObject* Sender, TElXTreeItem* Item, int &ImageIndex);

typedef void __fastcall (__closure *TElXOnCellPicDrawEvent)(System::TObject* Sender, TElXTreeItem* Item, int SectionIndex, int &ImageIndex);

typedef void __fastcall (__closure *TElXHotTrackEvent)(System::TObject* Sender, TElXTreeItem* OldItem, TElXTreeItem* NewItem);

typedef void __fastcall (__closure *TElXOnValidateEvent)(System::TObject* Sender, TElXTreeItem* Item, Elheader::TElHeaderSection* Section, System::UnicodeString &Text, bool &Accept);

typedef void __fastcall (__closure *TElXOnEndEditEvent)(System::TObject* Sender, TElXTreeItem* Item, Elheader::TElHeaderSection* Section, bool Canceled);

typedef void __fastcall (__closure *TElXTryEditEvent)(System::TObject* Sender, TElXTreeItem* Item, int SectionIndex, Elheader::TElFieldType &CellType, bool &CanEdit);

typedef void __fastcall (__closure *TElXEditRequestEvent)(System::TObject* Sender, TElXTreeItem* Item, Elheader::TElHeaderSection* Section);

typedef void __fastcall (__closure *TElXComboEditShowEvent)(System::TObject* Sender, TElXTreeItem* Item, Elheader::TElHeaderSection* Section, Vcl::Stdctrls::TComboBox* Combobox);

typedef void __fastcall (__closure *TElXValidateComboEvent)(System::TObject* Sender, TElXTreeItem* Item, Elheader::TElHeaderSection* Section, Vcl::Stdctrls::TComboBox* Combo, bool &Accept);

typedef void __fastcall (__closure *TElXScrollEvent)(System::TObject* Sender, Vcl::Forms::TScrollBarKind ScrollBarKind, int ScrollCode);

typedef void __fastcall (__closure *TElXColumnMoveEvent)(TCustomElXTree* Sender, Elheader::TElHeaderSection* Section, int OldPos, int NewPos);

typedef void __fastcall (__closure *TElXItemSaveEvent)(System::TObject* Sender, System::Classes::TStream* Stream, TElXTreeItem* Item);

typedef void __fastcall (__closure *TElXCellStyleSaveEvent)(System::TObject* Sender, System::Classes::TStream* Stream, Elxtreecell::TElXCellStyleAncestor* Style);

typedef void __fastcall (__closure *TElXTreeChangingEvent)(System::TObject* Sender, TElXTreeItem* Item, bool &AllowChange);

typedef void __fastcall (__closure *TElXTreeItemPostDrawEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, TElXTreeItem* Item, const System::Types::TRect &ItemRect, bool &DrawFocusRect);

typedef void __fastcall (__closure *TElXTreeItemDragTargetEvent)(System::TObject* Sender, TElXTreeItem* Item, const System::Types::TRect &ItemRect, int X, int Y);

typedef void __fastcall (__closure *TElXCanDragEvent)(System::TObject* Sender, TElXTreeItem* const Item, bool &CanDrag);

typedef void __fastcall (__closure *TElXVirtualTextNeededEvent)(System::TObject* Sender, TElXTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);

typedef void __fastcall (__closure *TElXVirtualHintNeededEvent)(System::TObject* Sender, TElXTreeItem* Item, Lmdtypes::TLMDString &Hint);

typedef void __fastcall (__closure *TElXVirtualValueNeededEvent)(System::TObject* Sender, TElXTreeItem* Item, int SectionIndex, int VarType, System::Variant &Value);

typedef void __fastcall (__closure *TElXVirtualPropsNeededEvent)(System::TObject* Sender, TElXTreeItem* Item, Eltreeinplaceeditors::TElVirtPropTypes PropTypes, TElXTreeItemStaticDataEx* Value);

typedef void __fastcall (__closure *TElXVirtualStyleNeededEvent)(System::TObject* Sender, TElXTreeItem* Item, int SectionIndex, Elxtreecell::TElXCellStyle* Style);

typedef void __fastcall (__closure *TElXCellEvent)(System::TObject* Sender, TElXTreeCell* Cell);

struct DECLSPEC_DRECORD TMouseFrameRec
{
public:
	TElXTreeItem* StartItem;
	int StartColumn;
	System::Types::TPoint StartCoord;
	TElXTreeItem* EndItem;
	int EndColumn;
	System::Types::TPoint EndCoord;
};


class PASCALIMPLEMENTATION TElXHackHeaderCellRow : public Elxheader::TElXHeaderCellRow
{
	typedef Elxheader::TElXHeaderCellRow inherited;
	
public:
	/* TElXHeaderCellRow.Create */ inline __fastcall virtual TElXHackHeaderCellRow(Elxheader::TElXCustomHeader* AOwner) : Elxheader::TElXHeaderCellRow(AOwner) { }
	/* TElXHeaderCellRow.Destroy */ inline __fastcall virtual ~TElXHackHeaderCellRow(void) { }
	
};


class PASCALIMPLEMENTATION TElXHackHeaderSection : public Elxheader::TElXHeaderSection
{
	typedef Elxheader::TElXHeaderSection inherited;
	
public:
	/* TElXHeaderSection.Create */ inline __fastcall TElXHackHeaderSection(Elxheader::TElXCustomHeader* AOwner, Elxheader::TElXHeaderSections* ASections) : Elxheader::TElXHeaderSection(AOwner, ASections) { }
	/* TElXHeaderSection.Destroy */ inline __fastcall virtual ~TElXHackHeaderSection(void) { }
	
};


class PASCALIMPLEMENTATION TElXTreeHeader : public Elxheader::TElXCustomHeader
{
	typedef Elxheader::TElXCustomHeader inherited;
	
protected:
	virtual Elxheader::TElXHeaderCellRow* __fastcall CreateHeaderCellRow(void);
	TCustomElXTree* __fastcall GetTree(void);
	Elxheader::TElXHeaderSection* __fastcall GetGutterSection(void);
	virtual void __fastcall SetRowCount(const int AValue);
	
public:
	__fastcall virtual TElXTreeHeader(System::Classes::TComponent* AOwner);
	virtual void __fastcall Loaded(void);
	__property TCustomElXTree* Owner = {read=GetTree};
	
__published:
	__property Elxheader::TElXHeaderSection* GutterSection = {read=GetGutterSection};
	__property ActiveFilterColor = {default=0};
	__property AllowDrag = {default=1};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property DefaultWidth = {default=120};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered;
	__property DragKind = {default=0};
	__property MoveOnDrag = {default=0};
	__property Font;
	__property FilterColor = {default=-16777198};
	__property Images;
	__property AlphaForImages;
	__property LookupStyle = {default=0};
	__property ImageForm;
	__property InvertSortArrows = {default=0};
	__property LockHeight = {default=0};
	__property MultiSort = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ResizeOnDrag = {default=0};
	__property RightAlignedText = {default=0};
	__property RightAlignedOrder = {default=0};
	__property SectionsWidth;
	__property ShowHint;
	__property StickySections = {default=0};
	__property Tracking = {default=1};
	__property Storage;
	__property StoragePath = {default=0};
	__property Visible = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property WrapCaptions = {default=0};
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnSectionClick;
	__property OnSectionResize;
	__property OnSectionDraw;
	__property OnSectionResizing;
	__property OnSectionDelete;
	__property OnSectionMove;
	__property OnSectionShowHide;
	__property OnPictureNeeded;
	__property OnSectionChange;
	__property OnSectionCreate;
	__property OnSectionExpand;
	__property OnSectionCollapse;
	__property OnMeasureSection;
	__property OnHeaderLookup;
	__property OnHeaderLookupDone;
	__property OnHTMLImageNeeded;
	__property OnSectionAutoSize;
	__property OnFilterCall;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TElXCustomHeader.Destroy */ inline __fastcall virtual ~TElXTreeHeader(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXTreeHeader(HWND ParentWindow) : Elxheader::TElXCustomHeader(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElXTreeView : public Eltreeinplaceeditors::TElTreeViewAncestor
{
	typedef Eltreeinplaceeditors::TElTreeViewAncestor inherited;
	
private:
	Lmdgraph::TLMDVerticalAlign FPlusPosition;
	int FLastMouseXPos;
	int FLastMouseYPos;
	void __fastcall IntPrevVis(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	void __fastcall IntVis0(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	void __fastcall IntNextVis(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	void __fastcall IntPgVis(TElXTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElXTree* Tree);
	void __fastcall SetPlusPosition(const Lmdgraph::TLMDVerticalAlign Value);
	
protected:
	TElXTreeHeader* FHeader;
	int FBottomHeight;
	int FHitColumn;
	TCustomElXTree* FOwner;
	TElXTreeItems* FItems;
	Elxtreecell::TElXCellStyle* FVirtStyle;
	Vcl::Extctrls::TTimer* FHintTimer;
	Elhintwnd::TElHintWindow* FHintWnd;
	System::Types::TPoint FHintCoord;
	TElXTreeItem* FHintItem;
	TElXTreeItem* FHintItemEx;
	int FHintCol;
	TElXCanDragEvent FOnCanDrag;
	bool FPainting;
	bool FClearVis;
	bool FClearAll;
	bool FVisUpdated;
	bool FRangeUpdate;
	int FHRange;
	System::Types::TPoint FPressCoord;
	bool FPressed;
	bool FMouseSel;
	System::Types::TPoint FClickCoord;
	bool FClicked;
	Elxtreecell::TElXCellControl* FClickControl;
	bool FIgnoreClick;
	bool FIgnoreClick2;
	bool FClickPassed;
	TElXTreeItem* FPassedItem;
	System::Classes::TShiftState FPassedShift;
	int FClickSection;
	TElXTreeItem* FClickItem;
	TElXTreeItem* FTrackItem;
	TElXTreeItem* FEditingItem;
	TElXTreeItem* FFocused;
	TElXTreeItem* FSelected;
	TElXTreeItem* FDropTrg;
	TMouseFrameRec FMouseFrameRec;
	Vcl::Extctrls::TTimer* FDragScrollTimer;
	Vcl::Extctrls::TTimer* FDragExpandTimer;
	bool FDropAcc;
	bool FInDragging;
	int FDDY;
	Vcl::Controls::TImageList* FDragImages;
	Eltreeinplaceeditors::TElTreeInplaceEditor* FInpEdit;
	Elheader::TElFieldType FEditType;
	int FEditSect;
	Vcl::Extctrls::TTimer* FEditTimer;
	TElXTreeItem* FItemToEdit;
	bool FEndEditWhenDestroy;
	bool FOldHide;
	Vcl::Menus::TPopupMenu* FFakePopup;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Vcl::Graphics::TBitmap* FTmpBmp;
	Elinputprocessor::TElKeyboardInput* Input;
	System::Classes::TThread* SearchTextTimeoutThread;
	bool FScrollFirstClick;
	bool FHasFocus;
	Elxtreecell::TElXTreeViewColorHelper* FColorHelper;
	void __fastcall StartClearSearchTimeoutThread(void);
	void __fastcall StopClearSearchTimeoutThread(void);
	void __fastcall SearchTextTimeout(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	void __fastcall RedoTmpBmp(void);
	virtual void __fastcall RedrawTree(Vcl::Graphics::TCanvas* ACanvas, int ARealLeftPos, Lmdobjectlist::TLMDObjectList* AItemsList);
	virtual void __fastcall DoRedrawItem(Vcl::Graphics::TCanvas* ACanvas, TElXTreeItem* AItem, const System::Types::TRect &AItemRect, const System::Types::TRect &ASurfRect, bool AUsePartialCheck = true, int AAbsIndex = 0xffffffff, int AVisIndex = 0xffffffff);
	virtual void __fastcall Paint(void);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	void __fastcall DoPaintBkgnd(HDC DC, const System::Types::TRect &ClipRect);
	void __fastcall UpdateView(void);
	void __fastcall TryStartHint(int XPos, int YPos);
	void __fastcall OnHintTimer(System::TObject* Sender);
	void __fastcall DoHideLineHint(void);
	void __fastcall DoShowLineHint(TElXTreeItem* Item, Elheader::TElHeaderSection* Section);
	Lmdtypes::TLMDString __fastcall GetHintText(TElXTreeItem* Item, Elheader::TElHeaderSection* &Section);
	int __fastcall CalcPageUpPos(int CurIdx);
	int __fastcall CalcPageDownPos(int CurIdx);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDblClk(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall WMIMEComposition(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMIMEStartComposition(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMDeadChar(Winapi::Messages::TWMKey &Message);
	bool __fastcall IntLButtonDown(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall IntLButtonUp(int X, int Y, System::Classes::TShiftState Shift);
	void __fastcall IntRButtonDown(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall IntRButtonUp(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall IntLButtonDblClick(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall IntRButtonDblClick(int X, int Y, System::Classes::TShiftState Shift);
	void __fastcall IntMouseMove(int X, int Y, System::Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Msg);
	void __fastcall SetLeftPosition(int value);
	void __fastcall SetTopIndex(int value);
	void __fastcall DoSetTopIndex(int Value);
	void __fastcall OnHScroll(System::TObject* Sender, Elsbctrl::TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	void __fastcall OnVScroll(System::TObject* ASender, Elsbctrl::TElScrollCode AScrollCode, int &AScrollPos, bool &ADoChange);
	int __fastcall GetFirstOffsetItemIndex(int AOffset);
	int __fastcall FillVisFwd(int AOffset);
	virtual int __fastcall GetVisCount(void);
	int __fastcall GetVisiblesHeight(void);
	void __fastcall OnEditTimer(System::TObject* Sender);
	virtual void __fastcall DoEditItem(TElXTreeItem* Item, int SectionNum);
	virtual void __fastcall DoEndEdit(bool ByCancel);
	virtual void __fastcall EditOperationCancelled(void);
	virtual void __fastcall EditOperationAccepted(void);
	void __fastcall FillDragImage(void);
	virtual void __fastcall DoCanDrag(TElXTreeItem* const Item, bool &CanDrag);
	DYNAMIC void __fastcall DoStartDrag(Vcl::Controls::TDragObject* &DragObject);
	virtual void __fastcall DoDragOver(Vcl::Controls::TDragObject* Source, int X, int Y, bool CanDrop);
	DYNAMIC void __fastcall DoEndDrag(System::TObject* Target, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMDrag(Vcl::Controls::TCMDrag &Message);
	virtual bool __fastcall DragScroll(Vcl::Controls::TDragObject* Source, int X, int Y);
	void __fastcall OnScrollTimer(System::TObject* Sender);
	void __fastcall OnDragExpandTimer(System::TObject* Sender);
	void __fastcall OnDropTargetDrag(System::TObject* Sender, System::Uitypes::TDragState State, Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	void __fastcall OnDropTargetDrop(System::TObject* Sender, Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	virtual System::Types::TRect __fastcall GetItemRect(int AItemIndex);
	virtual TElXTreeItem* __fastcall GetItemAtY(int Y);
	virtual TElXTreeItem* __fastcall GetItemAt(int X, int Y, Eltreeinplaceeditors::TSTItemPart &ItemPart, int &HitColumn);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	void __fastcall ProcessPassedClick(void);
	void __fastcall FitMostChildren(TElXTreeItem* Item);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DestroyWindowHandle(void);
	void __fastcall DoSetSelected(TElXTreeItem* AItem);
	virtual int __fastcall GetVisCount2(void);
	virtual TElXTreeItem* __fastcall FindNewFocused(System::Word AKey, int &AIndex, bool &ASelected);
	void __fastcall DrawMouseSelectFrame(bool AHide = false);
	void __fastcall AllocateMouseSelectFrame(void);
	void __fastcall DeallocateMouseSelectFrame(void);
	void __fastcall SelectMouseSelectItems(void);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Message);
	void __fastcall CancelMouseSel(void);
	MESSAGE void __fastcall CMDeactivate(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	virtual void __fastcall InitiateEditOp(TElXTreeItem* Item, int HCol, bool Immediate);
	bool __fastcall IsControlCell(TElXTreeItem* Item, int SectionIndex);
	virtual void __fastcall DoPerformSearch(Lmdtypes::TLMDString SearchText);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	void __fastcall OnConstrainedResizeHandler(System::TObject* Sender, int &MinWidth, int &MinHeight, int &MaxWidth, int &MaxHeight);
	
public:
	__fastcall virtual TElXTreeView(System::Classes::TComponent* Owner);
	__fastcall virtual ~TElXTreeView(void);
	virtual void __fastcall SetFocus(void);
	virtual void __fastcall DefineHRange(void);
	virtual Vcl::Controls::TDragImageList* __fastcall GetDragImages(void);
	void __fastcall DrawCellImage(Vcl::Graphics::TCanvas* ACanvas, TElXTreeItem* Item, int ImageIndex, int SectionIndex, Vcl::Graphics::TBitmap* HelperBitmap, System::Types::TRect &R);
	void __fastcall DrawItemLines(Vcl::Graphics::TCanvas* ACanvas, TElXTreeItem* Item, System::Types::TRect &R, System::Types::TRect &ItemRect);
	virtual void __fastcall DrawGutter(Vcl::Graphics::TCanvas* ACanvas, TElXTreeItem* Item, const System::Types::TRect &R);
	void __fastcall DrawButtons(Vcl::Graphics::TCanvas* ACanvas, TElXTreeItem* Item, bool IsNode, System::Types::TRect &R);
	void __fastcall DrawCheckBox(Vcl::Graphics::TCanvas* ACanvas, TElXTreeItem* Item, Vcl::Graphics::TBitmap* HelperBitmap, System::Types::TRect &R);
	void __fastcall DrawImages(Vcl::Graphics::TCanvas* ACanvas, TElXTreeItem* Item, Vcl::Graphics::TBitmap* HelperBitmap, System::Types::TRect &R);
	virtual void __fastcall DrawHorzLine(Vcl::Graphics::TCanvas* const ACanvas, TElXTreeItem* const Item, const System::Types::TRect &R);
	virtual void __fastcall DrawVertLine(Vcl::Graphics::TCanvas* const ACanvas, TElXTreeItem* const Item, const System::Types::TRect &R, bool OnRight = true);
	__property int HitColumn = {read=FHitColumn, nodefault};
	__property Elxtreecell::TElXTreeViewColorHelper* ColorHelper = {read=FColorHelper};
	__property Elxtreecell::TElXCellStyle* VirtStyle = {read=FVirtStyle};
	__property TCustomElXTree* Owner = {read=FOwner};
	__property bool HasFocus = {read=FHasFocus, nodefault};
	__property TElXTreeItem* DropTrg = {read=FDropTrg};
	__property bool DropAcc = {read=FDropAcc, nodefault};
	__property DragCursor = {default=-12};
	__property Lmdhtmlunit::TLMDHTMLRender* Render = {read=FRender};
	__property Lmdgraph::TLMDVerticalAlign PlusPosition = {read=FPlusPosition, write=SetPlusPosition, default=0};
	__property TMouseFrameRec MouseSelectionFrame = {read=FMouseFrameRec};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXTreeView(HWND ParentWindow) : Eltreeinplaceeditors::TElTreeViewAncestor(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TMultiCellSelectStyles : unsigned char { mcsControlSelect, mcsShiftSelect, mcsVisibleOnly, mcsSiblingOnly };

typedef System::Set<TMultiCellSelectStyles, TMultiCellSelectStyles::mcsControlSelect, TMultiCellSelectStyles::mcsSiblingOnly> TMultiCellSelectStyle;

class PASCALIMPLEMENTATION TElXDataCache : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
public:
	HIDESBASE void __fastcall Move(int CurIndex, int NewIndex);
public:
	/* TLMDObjectList.Create */ inline __fastcall TElXDataCache(void) : Lmdobjectlist::TLMDObjectList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElXDataCache(void) { }
	
};


class PASCALIMPLEMENTATION TElXTreeScrollBar : public Elscrollbar::TElScrollBar
{
	typedef Elscrollbar::TElScrollBar inherited;
	
protected:
	TCustomElXTree* FTree;
	
public:
	__fastcall virtual ~TElXTreeScrollBar(void);
public:
	/* TCustomElScrollBar.Create */ inline __fastcall virtual TElXTreeScrollBar(System::Classes::TComponent* AOwner) : Elscrollbar::TElScrollBar(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXTreeScrollBar(HWND ParentWindow) : Elscrollbar::TElScrollBar(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElXTree : public Eltreeinplaceeditors::TElTreeAncestor
{
	typedef Eltreeinplaceeditors::TElTreeAncestor inherited;
	
private:
	bool FIncrementalSearchSelectItem;
	System::Classes::TNotifyEvent FOnCtlDblClick;
	System::Classes::TNotifyEvent FOnCtlClick;
	Vcl::Controls::TMouseEvent FOnCtlMouseDown;
	Vcl::Controls::TMouseMoveEvent FOnCtlMouseMove;
	Vcl::Controls::TMouseEvent FOnCtlMouseUp;
	bool __fastcall IntCompare(TElXTreeItem* Item, void * SearchDetails);
	Lmdgraph::TLMDVerticalAlign __fastcall GetPlusPosition(void);
	void __fastcall SetPlusPosition(const Lmdgraph::TLMDVerticalAlign Value);
	void __fastcall SetForeceAlign(const bool Value);
	void __fastcall SetRowCheck(const bool Value);
	
protected:
	bool FUseThemeForSelection;
	bool FAutoLineVisibleOnly;
	Elxtreecell::TElXCellStyle* FCellStyle;
	int FGutterWidth;
	Lmdtypes::TLMDString FGutterText;
	bool FForceAlign;
	bool FRowCheck;
	System::Uitypes::TColor FStripedOddColor;
	System::Uitypes::TColor FStripedEvenColor;
	System::Uitypes::TColor FTrackColor;
	System::Uitypes::TColor FGradientStartColor;
	System::Uitypes::TColor FGradientEndColor;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectColor;
	System::Uitypes::TColor FHideSelectTextColor;
	System::Uitypes::TColor FLinesColor;
	System::Uitypes::TColor FBackGroundColor;
	System::Uitypes::TColor FTextColor;
	System::Uitypes::TColor FLineHintColor;
	System::Uitypes::TColor FCurBackGroundColor;
	System::Uitypes::TColor FCurTextColor;
	System::Uitypes::TColor FDragRectAcceptColor;
	System::Uitypes::TColor FDragRectDenyColor;
	System::Uitypes::TColor FLinkColor;
	System::Uitypes::TColor FVertDivLinesColor;
	System::Uitypes::TColor FHorzDivLinesColor;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	System::Uitypes::TColor FSortColumnColor;
	bool FStripedItems;
	TElXVirtualStyleNeededEvent FOnVirtualStyleNeeded;
	Lmdobjectlist::TLMDObjectList* FSortSections;
	TElXVirtualTextNeededEvent FOnVirtualTextNeeded;
	TElXVirtualTextNeededEvent FOnUserCellTextNeeded;
	Eltreeinplaceeditors::TVirtualityLevel FVirtualityLevel;
	TElXVirtualHintNeededEvent FOnVirtualHintNeeded;
	TElXVirtualValueNeededEvent FOnVirtualValueNeeded;
	TElXVirtualPropsNeededEvent FOnVirtualPropsNeeded;
	Eltreeinplaceeditors::TLineHintType FLineHintType;
	int FLineHintTimeout;
	int FFireFocusEvents;
	bool FPlusMinusTransparent;
	bool FTransCheckBoxes;
	bool FExpandOnDragOver;
	System::Uitypes::TScrollStyle FForcedScrollBars;
	bool FMoveFocusOnCollapse;
	int FHeaderHeight;
	int FHeaderRowCount;
	Elsbctrl::TElScrollHintNeededEvent FOnVertScrollHintNeeded;
	Elsbctrl::TElScrollDrawPartEvent FOnHorzScrollDrawPart;
	Elsbctrl::TElScrollHintNeededEvent FOnHorzScrollHintNeeded;
	Elsbctrl::TElScrollDrawPartEvent FOnVertScrollDrawPart;
	Elsbctrl::TElScrollHitTestEvent FOnVertScrollHitTest;
	TElXTreeChangingEvent FOnChanging;
	Vcl::Controls::TBevelKind FBevelKindDummy;
	Eltreeinplaceeditors::TElHintType FHintType;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnDblClick;
	Vcl::Controls::TDragDropEvent FOnDrop;
	Vcl::Controls::TDragOverEvent FOnOver;
	Vcl::Controls::TEndDragEvent FOnDrag;
	System::Classes::TNotifyEvent FOnEnter;
	System::Classes::TNotifyEvent FOnExit;
	Vcl::Controls::TKeyEvent FOnKeyDown;
	Vcl::Controls::TKeyPressEvent FOnKeyPress;
	Vcl::Controls::TKeyEvent FOnKeyUp;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	Vcl::Controls::TMouseMoveEvent FOnMouseMove;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	Vcl::Controls::TStartDragEvent FOnStartDrag;
	TElXOnItemExpandEvent FOnItemPreDraw;
	TElXTreeItemDragTargetEvent FOnDragTargetChange;
	int FGradientSteps;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FRowHotTrack;
	Vcl::Graphics::TBitmap* FBackground;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	bool FAdjustMultilineHeight;
	bool FFlatFocusedScrollbars;
	bool FAutoResizeColumns;
	bool FHideFocusRect;
	bool FShowEmptyImages;
	bool FShowEmptyImages2;
	bool FShowRootButtons;
	bool FUnderlineTracked;
	bool FCustomCheckboxes;
	Vcl::Graphics::TBitmap* FCheckBoxGlyph;
	Vcl::Graphics::TBitmap* FRadioButtonGlyph;
	bool FFilteredVisibility;
	TElXApplyVisFilterEvent FOnApplyVisFilter;
	bool FRightAlignedText;
	bool FFlat;
	bool FRightAlignedView;
	System::WideChar FPathSeparator;
	Vcl::Graphics::TPenStyle FLinesStyle;
	bool FDeselectChildrenOnCollapse;
	bool FDrawFocusRect;
	bool FBarStyle;
	bool FNotRaiseForBarStyle;
	bool FAlwaysKeepFocus;
	bool FAlwaysKeepSelection;
	bool FFullRowSelect;
	Eltreeinplaceeditors::TElDragType FDragType;
	bool FMouseOver;
	Eldragdrop::TElDropTarget* FDropTarget;
	Vcl::Controls::TDragObject* FDragObject;
	bool FAutoLookup;
	int FSelectColumn;
	bool FAutoExpand;
	Vcl::Graphics::TBitmap* FLeafPicture;
	Vcl::Graphics::TBitmap* FPlusPicture;
	Vcl::Graphics::TBitmap* FMinusPicture;
	bool FCustomPlusMinus;
	bool FShowColumns;
	bool FShowCheckBoxes;
	Elimgfrm::TElImageForm* FImageForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elini::TElIniFile* FStorage;
	System::UnicodeString FStoragePath;
	Eltreeinplaceeditors::TDragImgMode FDragImageMode;
	bool FHideHorzScrollBar;
	bool FHideVertScrollBar;
	bool FHideHintOnMove;
	int FSortSection;
	Eltreeinplaceeditors::TSortModes FSortMode;
	Eltreeinplaceeditors::TSortTypes FSortType;
	bool FDragAllowed;
	bool FShowButtons;
	bool FShowLines;
	bool FShowImages;
	bool FShowRoot;
	Eltreeinplaceeditors::THintModes FLineHintMode;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	bool FDoInplaceEdit;
	bool FIgnoreSBChange;
	bool FScrollbarsInitialized;
	bool FSortRequired;
	bool FProcUpdate;
	bool FUpdated;
	int FInSorting;
	bool FBarStyleVerticalLines;
	Lmdobjectlist::TLMDObjectList* FAllList;
	Lmdobjectlist::TLMDObjectList* FSelectedList;
	bool FVertScrollTracking;
	bool FHorzScrollTracking;
	bool FHotTrack;
	bool FHeaderHotTrack;
	bool FOwnerDrawByColumn;
	Lmdtypes::TLMDString FOwnerDrawMask;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TCustomImageList* FImages2;
	Vcl::Imglist::TCustomImageList* FAlphaForImages;
	Vcl::Imglist::TCustomImageList* FAlphaForImages2;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Vcl::Imglist::TChangeLink* FAImageChangeLink;
	int FTopIndex;
	int FBottomIndex;
	int FFixedTopRowNum;
	int FFixedBottomRowNum;
	bool FChangeStateImage;
	Lmdtypes::TLMDString FRealHint;
	Lmdtypes::TLMDString FHint;
	int FMainTreeColumn;
	bool FMultiSelect;
	int FMultiSelectLevel;
	bool FRowSelect;
	bool FHideSelection;
	int FLineHeight;
	bool FAutoLineHeight;
	int FItemIndent;
	bool FUseCustomScrollBars;
	int FLeftPosition;
	bool FVertScrollBarVisible;
	bool FHorzScrollBarVisible;
	Eltreeinplaceeditors::TSTSelModes FSelectionMode;
	Eltreeinplaceeditors::TSortDirs FSortDir;
	bool FSelChange;
	bool FColumnSizeUpdate;
	int FUpdateCount;
	bool FHideHintOnTimer;
	bool FUseSystemHintColors;
	bool IgnoreResize;
	bool FDelOnEdit;
	bool FAutoSizingColumns;
	bool FAdjustInplaceEditorPosition;
	TElXTreeItems* FItems;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnColumnResize;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnColumnClick;
	Elxheader::TElXSectionRedrawEvent FOnColumnDraw;
	TElXOnItemChangeEvent FOnItemChange;
	TElXOnCellChangeEvent FOnCellChange;
	TElXOnItemDrawEvent FOnItemDraw;
	TElXOnCellDrawEvent FOnCellDraw;
	TElXOnItemCheckedEvent FOnItemChecked;
	TElXOnItemCheckStateChangingEvent FOnItemCheckStateChanging;
	TElXOnItemExpandEvent FOnItemExpand;
	TElXOnItemExpandEvent FOnItemCollapse;
	TElXOnItemExpanding FOnItemExpanding;
	TElXOnItemExpanding FOnItemCollapsing;
	TElXOnItemExpandEvent FOnItemDelete;
	TElXOnItemExpandEvent FOnItemCreated;
	TElXCellEvent FOnCellDeletion;
	System::Classes::TNotifyEvent FOnItemFocused;
	TElXTreeItemPostDrawEvent FOnItemPostDraw;
	TElXOnShowHintEvent FOnShowHint;
	TElXOnCompareItems FOnCompareItems;
	TElXOnPicDrawEvent FOnItemPicDraw;
	TElXOnPicDrawEvent FOnItemPicDraw2;
	TElXOnCellPicDrawEvent FOnCellPicDraw;
	TElXHotTrackEvent FOnHotTrack;
	TElXScrollEvent FOnScroll;
	TElXItemSaveEvent FOnItemSave;
	TElXItemSaveEvent FOnItemLoad;
	TElXTryEditEvent FOnTryEdit;
	TElXOnEndEditEvent FOnEndEdit;
	TElXColumnMoveEvent FOnHeaderColumnMove;
	TElXCellStyleSaveEvent FOnSave;
	TElXCellStyleSaveEvent FOnLoad;
	TElXItemSelChangeEvent FOnItemSelectedChange;
	Elheader::TElHeaderLookupEvent FOnHeaderLookup;
	Elheader::TElHeaderLookupDoneEvent FOnHeaderLookupDone;
	System::Classes::TNotifyEvent FOnHeaderResize;
	Elxheader::TElXHeaderSectionEvent FOnHeaderSectionExpand;
	Elxheader::TElXHeaderSectionEvent FOnHeaderSectionCollapse;
	Elheader::TMeasureSectionEvent FOnHeaderSectionMeasure;
	Elxheader::TElXHeaderSectionCellEvent FOnHeaderSectionCellClick;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnSectionAutoSize;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnSectionFilterCall;
	TElXMeasureItemPartEvent FOnMeasureItemPart;
	System::Classes::TNotifyEvent FOnSortBegin;
	System::Classes::TNotifyEvent FOnSortEnd;
	TElXOleDragFinishEvent FOnOleDragFinish;
	TElXOleDragStartEvent FOnOleDragStart;
	Eldragdrop::TTargetDragEvent FOnOleTargetDrag;
	Eldragdrop::TTargetDropEvent FOnOleTargetDrop;
	int TotalHiddenCount;
	int TotalVisCount;
	int TotalVarHeightCount;
	TElXTreeView* FView;
	TElXTreeHeader* FHeader;
	Elscrollbar::TElScrollBar* FHScrollBar;
	Elscrollbar::TElScrollBar* FVScrollBar;
	Elscrollbar::TElScrollBarStyles* FHorzScrollBarStyle;
	Elscrollbar::TElScrollBarStyles* FVertScrollBarStyle;
	int FSavedHeaderHeight;
	Vcl::Extctrls::TTimer* FDelayTimer;
	TElXTreeItem* FDelayedItem;
	int FDragExpandDelay;
	int FChangeDelay;
	Eltreeinplaceeditors::TDragTargetDraw FDragTrgDrawMode;
	Vcl::Controls::TMouseEvent FOnHeaderMouseDown;
	System::Classes::TNotifyEvent FOnAfterSelectionChange;
	int FIncrementalSearchTimeout;
	bool FIncrementalSearch;
	bool FRightClickSelect;
	bool FScrollbarOpposite;
	bool FVerticalLinesLong;
	Lmdgraph::TLMDBorderSides FBorderSides;
	TInplaceEditorNeededXEvent FOnInplaceEditorNeeded;
	System::Uitypes::TCursor FCursor;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeededEx;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TElHTMLLinkOverEvent FOnLinkOver;
	Lmdhtmlunit::TLMDHTMLControlCreatedEvent FOnControlCreated;
	Lmdhtmlunit::TLMDHTMLControlPositionNeededEvent FOnAdjustControlPosition;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	System::Uitypes::TCursor FLinkCursor;
	System::Uitypes::TFontStyles FLinkStyle;
	bool FQuickEditMode;
	Elheader::TElFieldType FMainTextType;
	Elsbctrl::TElScrollHitTestEvent FOnHorzScrollHitTest;
	bool FMouseFrameVisible;
	bool FMouseFrameSelect;
	int FDragScrollInterval;
	bool FShowLeafButton;
	int FCheckBoxSize;
	bool FIgnoreEnabled;
	int FInplaceEditorDelay;
	Vcl::Graphics::TFont* FHeaderFont;
	bool FHeaderUseTreeFont;
	bool FKeepSelectionWithinLevel;
	bool FAutoCollapse;
	bool FIgnoreResizes;
	bool FSortUseCase;
	Eltreeinplaceeditors::TElDblClickMode FDblClickMode;
	bool FDoubleBuffered;
	bool FDoubleBufferedOnResize;
	bool FInSizeMove;
	Elhook::TElHook* FHook;
	int FHighlightAlphaLevel;
	TElXDataCache* FDataCache;
	int FDataCacheSize;
	bool FLastWasDown;
	int FSortSectionToCompare;
	Eltreeinplaceeditors::TElIncSearchScope FIncrementalSearchScope;
	Eltreeinplaceeditors::TElIncSearchColumn FIncrementalSearchColumn;
	bool FCheckBoxFlat;
	bool FHorzArrowsScroll;
	bool FCollapsing;
	virtual void __fastcall DoOnCtlClick(System::TObject* Sender);
	virtual void __fastcall DoOnCtlDblClick(System::TObject* Sender);
	virtual void __fastcall DoOnCtlMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoOnCtlMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoOnCtlMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetUseThemeForSelection(const bool Value);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual System::UnicodeString __fastcall GetAlignmentOnSection(int SectionIndex);
	void __fastcall StyleChanged(System::TObject* Sender);
	virtual Eltreeinplaceeditors::TElTreeViewAncestor* __fastcall GetTreeViewAncestor(void);
	void __fastcall InsertColumn(int AIndex);
	void __fastcall DeleteColumn(int AIndex);
	void __fastcall CheckHeaderCount(void);
	void __fastcall SetStripedOddColor(System::Uitypes::TColor Value);
	void __fastcall SetStripedEvenColor(System::Uitypes::TColor Value);
	void __fastcall SetStripedItems(bool Value);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerImageNeededExEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	void __fastcall TriggerAdjustControlPositionEvent(System::TObject* Sender, Vcl::Controls::TControl* aControl, void * aData, int &X, int &Y);
	void __fastcall TriggerControlCreatedEvent(System::TObject* Sender, Vcl::Controls::TControl* aControl);
	void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	void __fastcall UpdateHTMLControlsVisibility(System::TObject* Sender, Vcl::Controls::TControl* aControl, void * aData, bool &aVisible);
	virtual void __fastcall TriggerLinkClickEvent(System::UnicodeString HRef, int X, int Y);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	void __fastcall OnBeforeHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetVirtualityLevel(Eltreeinplaceeditors::TVirtualityLevel Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	int __fastcall GetDefaultSectionWidth(void);
	void __fastcall SetDefaultSectionWidth(int Value);
	void __fastcall OnHeaderSectionResize(Elxheader::TElXCustomHeader* AHeader, Elxheader::TElXHeaderSection* Section);
	virtual void __fastcall OnHeaderSectionClick(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	void __fastcall OnHeaderSectionDelete(Elxheader::TElXCustomHeader* AHeader, Elxheader::TElXHeaderSection* Section);
	void __fastcall DoHeaderMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnHeaderSectionLookup(System::TObject* Sender, Elxheader::TElXHeaderSection* Section, Lmdtypes::TLMDString &Text);
	void __fastcall OnHeaderSectionLookupDone(System::TObject* Sender, Elxheader::TElXHeaderSection* Section, Lmdtypes::TLMDString Text, bool Accepted);
	void __fastcall OnHeaderExpand(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	void __fastcall OnHeaderCollapse(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	void __fastcall OnHeaderSectionVisChange(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	void __fastcall HeaderSectionAutoSizeHandler(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	void __fastcall HeaderSectionAutoSizeTransfer(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall HeaderSectionFilterCallTransfer(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	virtual void __fastcall HeaderSectionCellClickTransfer(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section, Elxheader::TElXHeaderCell* Cell);
	void __fastcall DoHeaderResize(System::TObject* Sender);
	virtual void __fastcall OnFontChange(System::TObject* Sender);
	bool __fastcall IsHeaderFontStored(void);
	HIDESBASE bool __fastcall IsFontStored(void);
	void __fastcall OnSignChange(System::TObject* Sender);
	void __fastcall ImageListChange(System::TObject* Sender);
	TElXCanDragEvent __fastcall GetCanDrag(void);
	void __fastcall SetCanDrag(const TElXCanDragEvent Value);
	TElXTreeItem* __fastcall GetDropTarget(void);
	void __fastcall SetTextColor(System::Uitypes::TColor value);
	void __fastcall SetBackGroundColor(System::Uitypes::TColor value);
	bool __fastcall GetHeaderWrapCaptions(void);
	void __fastcall SetHeaderWrapCaptions(bool Value);
	void __fastcall SetHeaderHotTrack(bool value);
	void __fastcall SetHeaderHeight(int value);
	void __fastcall SetShowEmptyImages(bool newValue);
	void __fastcall SetShowEmptyImages2(bool newValue);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetImages2(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaForImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaForImages2(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetLineHintTimeout(int Value);
	void __fastcall SetShowLines(bool Value);
	void __fastcall SetShowRoot(bool Value);
	void __fastcall SetShowImages(bool Value);
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall SetShowButtons(bool Value);
	void __fastcall SetUpdating(bool value);
	bool __fastcall GetUpdating(void);
	void __fastcall SetHorizontalLines(bool value);
	void __fastcall SetVerticalLines(bool value);
	void __fastcall SetBarStyleVerticalLines(bool value);
	void __fastcall SetRowSelect(bool value);
	void __fastcall SetMultiSelectLevel(int Value);
	void __fastcall SetMultiSelect(bool value);
	void __fastcall SetFocused(TElXTreeItem* value);
	void __fastcall SetHideSelection(bool value);
	void __fastcall SetAutoExpand(bool value);
	void __fastcall SetMoveFocusOnCollapse(bool value);
	Elxheader::TElXHeaderSections* __fastcall GetHeaderSections(void);
	void __fastcall SetHeaderSections(Elxheader::TElXHeaderSections* value);
	void __fastcall SetChangeStateImage(bool value);
	void __fastcall SetUseCustomScrollBars(bool value);
	void __fastcall SetItemIndent(int value);
	void __fastcall SetLineHeight(int value);
	void __fastcall SetAutoLineHeight(bool value);
	void __fastcall SetAutoLineVisibleOnly(bool value);
	int __fastcall GetHeaderHeight(void);
	void __fastcall SetHeaderRowCount(int value);
	int __fastcall GetHeaderRowCount(void);
	void __fastcall SetMainTreeColumn(int value);
	void __fastcall SetItems(TElXTreeItems* value);
	int __fastcall GetTotalVisCount(void);
	bool __fastcall GetDraggableSections(void);
	void __fastcall SetDraggableSections(bool newValue);
	void __fastcall SetSortMode(Eltreeinplaceeditors::TSortModes newValue);
	void __fastcall SetSortSection(int newValue);
	bool __fastcall GetMoveColumnOnDrag(void);
	void __fastcall SetMoveColumnOnDrag(bool newValue);
	void __fastcall SetHideHorzScrollBar(bool newValue);
	void __fastcall SetHideVertScrollBar(bool newValue);
	Vcl::Imglist::TCustomImageList* __fastcall GetHeaderImages(void);
	void __fastcall SetHeaderImages(Vcl::Imglist::TCustomImageList* newValue);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaHeaderImages(void);
	void __fastcall SetAlphaHeaderImages(Vcl::Imglist::TCustomImageList* newValue);
	bool __fastcall GetFireFocusEvents(void);
	void __fastcall SetFireFocusEvents(bool Value);
	void __fastcall SetScrollbarOpposite(bool Value);
	void __fastcall SetVerticalLinesLong(bool Value);
	int __fastcall GetSelCount(void);
	TElXTreeItem* __fastcall GetSelected(void);
	int __fastcall GetHitColumn(void);
	TElXTreeItem* __fastcall GetFocused(void);
	void __fastcall SetSelected(TElXTreeItem* newValue);
	void __fastcall SetStorage(Elini::TElIniFile* newValue);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetHeaderImageForm(Elimgfrm::TElImageForm* newValue);
	Elimgfrm::TElImageForm* __fastcall GetHeaderImageForm(void);
	void __fastcall SetShowCheckBoxes(bool newValue);
	void __fastcall SetPlusPicture(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetMinusPicture(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetCustomPlusMinus(bool newValue);
	void __fastcall SetSelectColumn(int newValue);
	void __fastcall SetDragType(Eltreeinplaceeditors::TElDragType newValue);
	void __fastcall HeaderResizeTransfer(System::TObject* Sender);
	void __fastcall HeaderResizeHandler(System::TObject* Sender);
	bool __fastcall GetStickyHeaderSections(void);
	void __fastcall SetStickyHeaderSections(bool newValue);
	void __fastcall SetBarStyle(bool newValue);
	void __fastcall SetDrawFocusRect(bool newValue);
	void __fastcall SetLinesColor(System::Uitypes::TColor newValue);
	void __fastcall SetHorzDivLinesColor(System::Uitypes::TColor newValue);
	void __fastcall SetLinesStyle(Vcl::Graphics::TPenStyle newValue);
	void __fastcall SetRightAlignedView(bool newValue);
	void __fastcall SetFlat(bool newValue);
	virtual void __fastcall SetRightAlignedText(bool newValue);
	void __fastcall SetFilteredVisibility(bool newValue);
	void __fastcall SetUnderlineTracked(bool newValue);
	void __fastcall SetCustomCheckboxes(bool newValue);
	void __fastcall SetCheckBoxGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetRadioButtonGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetShowRootButtons(bool newValue);
	void __fastcall SetHideFocusRect(bool newValue);
	bool __fastcall GetLockHeaderHeight(void);
	void __fastcall SetLockHeaderHeight(bool newValue);
	void __fastcall SetPlusMinusTransparent(bool newValue);
	void __fastcall UpdateFrame(void);
	void __fastcall SetHeaderActiveFilterColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetHeaderActiveFilterColor(void);
	void __fastcall SetHeaderFilterColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetHeaderFilterColor(void);
	void __fastcall SetHeaderFlat(bool newValue);
	bool __fastcall GetHeaderFlat(void);
	void __fastcall DrawFlatBorder(bool HorzTracking, bool VertTracking);
	void __fastcall DrawFlatBorderEx(HDC DC, bool HorzTracking, bool VertTracking);
	void __fastcall ReRenderAllHTMLItems(void);
	void __fastcall SetFlatFocusedScrollbars(bool newValue);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetBackgroundType(Lmdgraph::TLMDBackgroundType newValue);
	void __fastcall BackgroundChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMNCHITTEST(Winapi::Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	MESSAGE void __fastcall WMEnable(Winapi::Messages::TWMEnable &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSysColorChange(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	MESSAGE void __fastcall IFMCanPaintBkgnd(Winapi::Messages::TMessage &Message);
	void __fastcall SetHideSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetFocusedSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetRowHotTrack(bool newValue);
	void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetGradientStartColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientEndColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientSteps(int newValue);
	void __fastcall SetLeftPosition(int value);
	void __fastcall SetTopIndex(int value);
	virtual void __fastcall ClickTransfer(System::TObject* Sender);
	virtual void __fastcall DblClickTransfer(System::TObject* Sender);
	virtual void __fastcall DropTransfer(System::TObject* Sender, System::TObject* Source, int X, int Y);
	virtual void __fastcall OverTransfer(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	virtual void __fastcall DragTransfer(System::TObject* Sender, System::TObject* Target, int X, int Y);
	virtual void __fastcall EnterTransfer(System::TObject* Sender);
	virtual void __fastcall ExitTransfer(System::TObject* Sender);
	virtual void __fastcall KeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyPressTransfer(System::TObject* Sender, System::WideChar &Key);
	virtual void __fastcall KeyUpTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall MouseDownTransfer(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseMoveTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseUpTransfer(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall StartDragTransfer(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	virtual void __fastcall MeasureSectionTransfer(System::TObject* Sender, Elheader::TElHeaderSection* Section, System::Types::TPoint &Size);
	HIDESBASE void __fastcall SetCursor(System::Uitypes::TCursor newValue);
	System::Uitypes::TCursor __fastcall GetCursor(void);
	int __fastcall SetScrollInfo(HWND hWnd, int BarFlag, const tagSCROLLINFO &ScrollInfo, System::LongBool Redraw);
	System::LongBool __fastcall GetScrollInfo(HWND hWnd, int BarFlag, tagSCROLLINFO &ScrollInfo);
	void __fastcall SetHorzScrollBarStyle(Elscrollbar::TElScrollBarStyles* newValue);
	void __fastcall SetVertScrollBarStyle(Elscrollbar::TElScrollBarStyles* newValue);
	void __fastcall HorzScrollDrawPartTransfer(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, Elsbctrl::TElScrollBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);
	void __fastcall HorzScrollHintNeededTransfer(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);
	void __fastcall VertScrollDrawPartTransfer(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, Elsbctrl::TElScrollBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);
	void __fastcall VertScrollHintNeededHandler(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);
	void __fastcall VertScrollHintNeededTransfer(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);
	bool __fastcall GetHeaderInvertSortArrows(void);
	void __fastcall SetHeaderInvertSortArrows(bool newValue);
	void __fastcall SBChanged(System::TObject* Sender);
	void __fastcall ScrollBarMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetForcedScrollBars(System::Uitypes::TScrollStyle newValue);
	System::Uitypes::TCursor __fastcall GetDragCursor(void);
	void __fastcall SetDragCursor(System::Uitypes::TCursor Value);
	void __fastcall SetTrackColor(System::Uitypes::TColor value);
	int __fastcall GetFixedColNum(void);
	int __fastcall GetGutterWidth(void);
	Lmdtypes::TLMDString __fastcall GetGutterText(void);
	int __fastcall GetFixedBottomRowsHeight(void);
	void __fastcall SetFixedColNum(int Value);
	void __fastcall SetGutterWidth(int AValue);
	void __fastcall SetGutterText(Lmdtypes::TLMDString AValue);
	void __fastcall SetFixedTopRowNum(int Value);
	void __fastcall SetFixedBottomRowNum(int Value);
	virtual void __fastcall SetAdjustMultilineHeight(bool newValue);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall AlignPieces(void);
	virtual TElXTreeItem* __fastcall GetRoot(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual int __fastcall CompareItems(TElXTreeItem* Item1, TElXTreeItem* Item2, Elheader::TElSSortMode SM, Eltreeinplaceeditors::TSortTypes ST, int FSortSection);
	virtual void __fastcall SetDoInplaceEdit(bool value);
	virtual void __fastcall SetShowColumns(bool value);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall Resize(void);
	virtual int __fastcall DoGetPicture(TElXTreeItem* Item, int SectionIndex);
	virtual int __fastcall DoGetPicture2(TElXTreeItem* Item);
	virtual int __fastcall DefineLineHeight(void);
	virtual void __fastcall UpdateScrollBars(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual TElXTreeItems* __fastcall CreateItems(void);
	virtual TElXTreeItems* __fastcall CreateItemsExt(TElXTreeItemClass ItemClass);
	virtual TElXTreeHeader* __fastcall CreateHeader(void);
	bool __fastcall DoSetFocused(TElXTreeItem* value, bool Forced);
	bool __fastcall DoSetFocusedEx(TElXTreeItem* value, bool Forced, bool Delayed);
	virtual void __fastcall SetHeaderColor(System::Uitypes::TColor newValue);
	virtual System::Uitypes::TColor __fastcall GetHeaderColor(void);
	Lmdtypes::TLMDString __fastcall GetHint(void);
	void __fastcall SetHint(Lmdtypes::TLMDString newValue);
	virtual void __fastcall DoChanging(TElXTreeItem* Item, bool &AllowChange);
	virtual void __fastcall DoOnColumnResize(int SectionIndex);
	virtual void __fastcall DoColumnClick(int SectionIndex);
	virtual void __fastcall DoItemFocused(void);
	virtual void __fastcall DoItemDraw(TElXTreeItem* Item, Vcl::Graphics::TCanvas* Surface, const System::Types::TRect &R, int SectionIndex);
	virtual void __fastcall DoItemChange(TElXTreeItem* Item, Eltreeinplaceeditors::TItemChangeMode ItemChangeMode);
	virtual void __fastcall DoCellChange(TElXTreeItem* Item, Elxtreecell::TElXCustomTreeCell* Cell, Eltreeinplaceeditors::TItemChangeMode ItemChangeMode);
	virtual void __fastcall DoItemExpanding(TElXTreeItem* Item, bool &CanProcess);
	virtual void __fastcall DoItemCollapsing(TElXTreeItem* Item, bool &CanProcess);
	virtual void __fastcall DoItemChecked(TElXTreeItem* Item);
	virtual void __fastcall DoItemCheckStateChanging(TElXTreeItem* Item, int OldValue, int &NewValue, bool &AllowChange);
	virtual void __fastcall DoItemExpand(TElXTreeItem* Item);
	virtual void __fastcall DoItemCollapse(TElXTreeItem* Item);
	virtual void __fastcall DoItemDelete(TElXTreeItem* Item);
	virtual void __fastcall DoItemCreated(TElXTreeItem* Item);
	virtual void __fastcall DoCellDeletion(Elxtreecell::TElXCustomTreeCell* Cell);
	virtual void __fastcall DoCompareItems(TElXTreeItem* Item1, TElXTreeItem* Item2, int &res);
	virtual void __fastcall DoHeaderDraw(Elxheader::TElXCustomHeader* Sender, Vcl::Graphics::TCanvas* Canvas, Elxheader::TElXHeaderSection* Section, const System::Types::TRect &R, bool Pressed);
	virtual void __fastcall OnHeaderSectionChange(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section, Elheader::TSectionChangeMode Change);
	virtual void __fastcall OnHeaderSectionMove(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section, int OldPos, int NewPos);
	virtual void __fastcall TriggerHotTrackEvent(TElXTreeItem* OldItem, TElXTreeItem* NewItem);
	virtual void __fastcall TriggerScrollEvent(Vcl::Forms::TScrollBarKind ScrollBarKind, int ScrollCode);
	virtual void __fastcall TriggerHeaderColumnMoveEvent(Elheader::TElHeaderSection* Section, int OldPos, int NewPos);
	virtual void __fastcall TriggerItemSaveEvent(System::Classes::TStream* Stream, TElXTreeItem* Item);
	virtual void __fastcall TriggerItemLoadEvent(System::Classes::TStream* Stream, TElXTreeItem* Item);
	virtual void __fastcall TriggerItemSelectedChangeEvent(TElXTreeItem* Item);
	virtual void __fastcall DoShowHint(TElXTreeItem* Item, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text, Vcl::Controls::THintWindow* HintWindow, const System::Types::TPoint &MousePos, bool &DoShowHint);
	virtual void __fastcall Paint(void);
	virtual void __fastcall OnHeaderSectionCreate(Elxheader::TElXCustomHeader* AHeader, Elxheader::TElXHeaderSection* Section);
	virtual void __fastcall TriggerHeaderLookupEvent(Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text);
	virtual void __fastcall TriggerHeaderLookupDoneEvent(Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString Text, bool Accepted);
	virtual void __fastcall TriggerHeaderSectionExpandEvent(Elxheader::TElXHeaderSection* Section);
	virtual void __fastcall TriggerHeaderSectionCollapseEvent(Elxheader::TElXHeaderSection* Section);
	virtual void __fastcall TriggerMeasureItemPartEvent(TElXTreeItem* Item, int PartIndex, System::Types::TPoint &Size);
	virtual void __fastcall TriggerApplyVisFilterEvent(TElXTreeItem* Item, bool &Hidden);
	virtual void __fastcall TriggerItemPostDrawEvent(Vcl::Graphics::TCanvas* Canvas, TElXTreeItem* Item, const System::Types::TRect &ItemRect, bool &DrawFocusRect);
	virtual void __fastcall TriggerItemPreDrawEvent(TElXTreeItem* Item);
	virtual void __fastcall TriggerOleTargetDragEvent(System::Uitypes::TDragState State, Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	virtual void __fastcall TriggerOleTargetDropEvent(Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	virtual void __fastcall TriggerOleDragStartEvent(_di_IDataObject &dataObj, _di_IDropSource &dropSource, Eldragdrop::TDragTypes &dwOKEffects);
	virtual void __fastcall TriggerOleDragFinishEvent(Eldragdrop::TDragType dwEffect, HRESULT Result);
	virtual TElXTreeItem* __fastcall GetTopItem(void);
	virtual void __fastcall SetTopItem(TElXTreeItem* Item);
	virtual void __fastcall Loaded(void);
	Eltreeinplaceeditors::TSortTypes __fastcall SectionTypeToSortType(Elheader::TElFieldType SectionType);
	virtual void __fastcall TriggerSortBegin(void);
	virtual void __fastcall TriggerSortEnd(void);
	virtual TElXTreeView* __fastcall CreateView(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall StartDelayedFocus(TElXTreeItem* FocusItemToReport);
	void __fastcall StopDelayedFocus(void);
	void __fastcall OnDelayTimer(System::TObject* Sender);
	virtual void __fastcall DoAfterSelectionChange(void);
	void __fastcall SetDragRectAcceptColor(const System::Uitypes::TColor Value);
	void __fastcall SetDragRectDenyColor(System::Uitypes::TColor Value);
	void __fastcall SetDragTrgDrawMode(Eltreeinplaceeditors::TDragTargetDraw Value);
	void __fastcall SetAdjustInplaceEditorPosition(bool aValue);
	int __fastcall GetVisibleRowCount(void);
	void __fastcall DoSetDragTrgDrawMode(Eltreeinplaceeditors::TDragTargetDraw Value, bool RedrawItem);
	DYNAMIC void __fastcall DoEndDrag(System::TObject* Target, int X, int Y);
	void __fastcall UpdateDiffItems(void);
	void __fastcall UpdateAllItems(void);
	void __fastcall SlowCompareItems(TElXTreeItem* Item1, TElXTreeItem* Item2, Elheader::TElHeaderSection* Section, int &Result);
	void __fastcall TriggerVirtualPropsNeeded(TElXTreeItem* Item, Eltreeinplaceeditors::TElVirtPropTypes PropTypes, TElXTreeItemStaticDataEx* Value);
	virtual void __fastcall TriggerVirtualHintNeeded(TElXTreeItem* Item, Lmdtypes::TLMDString &Hint);
	virtual void __fastcall TriggerVirtualValueNeeded(TElXTreeItem* Item, int SectionIndex, int VarType, System::Variant &Value);
	virtual void __fastcall TriggerTryEditEvent(TElXTreeItem* Item, int SectionIndex, Elheader::TElFieldType &CellType, bool &CanEdit);
	virtual void __fastcall TriggerInplaceEditorNeeded(TElXTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	virtual Eltreeinplaceeditors::TElTreeInplaceManager* __fastcall CreateInplaceManager(void);
	virtual void __fastcall DoEndEditItem(TElXTreeItem* Item, Elheader::TElHeaderSection* Section, bool Canceled);
	virtual void __fastcall VertScrollHitTestTransfer(System::TObject* Sender, int X, int Y, Elsbctrl::TElScrollBarPart &Part, bool &DefaultTest);
	virtual void __fastcall HorzScrollHitTestTransfer(System::TObject* Sender, int X, int Y, Elsbctrl::TElScrollBarPart &Part, bool &DefaultTest);
	void __fastcall SetVertDivLinesColor(System::Uitypes::TColor Value);
	void __fastcall SetCheckBoxSize(int Value);
	TElXTreeItem* __fastcall GetTrackItem(void);
	bool __fastcall GetDragging(void);
	void __fastcall SetShowLeafButton(bool Value);
	void __fastcall SetLeafPicture(Vcl::Graphics::TBitmap* Value);
	void __fastcall MouseWheelTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall MouseWheelDownTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall MouseWheelUpTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall FitMostChildren(TElXTreeItem* Item);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	int __fastcall GetCheckBoxSize(void);
	Vcl::Menus::TPopupMenu* __fastcall GetHeaderPopupMenu(void);
	void __fastcall SetHeaderPopupMenu(Vcl::Menus::TPopupMenu* Value);
	void __fastcall SetHeaderFont(Vcl::Graphics::TFont* Value);
	void __fastcall SetHeaderUseTreeFont(bool Value);
	void __fastcall HeaderFontChanged(System::TObject* Sender);
	bool __fastcall IsStripedColorStored(void);
	bool __fastcall IsOwnerDrawMaskStored(void);
	HIDESBASE MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall ELSettingChange(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall SetSortUseCase(bool Value);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetDblClickMode(Eltreeinplaceeditors::TElDblClickMode Value);
	Vcl::Graphics::TBitmap* __fastcall GetPlusPicture(void);
	Vcl::Graphics::TBitmap* __fastcall GetLeafPicture(void);
	Vcl::Graphics::TBitmap* __fastcall GetMinusPicture(void);
	Vcl::Graphics::TBitmap* __fastcall GetCheckBoxGlyph(void);
	Vcl::Graphics::TBitmap* __fastcall GetRadioButtonGlyph(void);
	void __fastcall OnCheckSignChange(System::TObject* Sender);
	MESSAGE void __fastcall WMUpdateSBFrame(Winapi::Messages::TMessage &Message);
	HIDESBASE void __fastcall SetDoubleBuffered(bool Value);
	void __fastcall SetHighlightAlphaLevel(int Value);
	void __fastcall ReadRightAlignedTree(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DataCacheAllocate(void);
	void __fastcall DataCacheDeallocate(void);
	void __fastcall DataCacheClear(void);
	void __fastcall SetDataCacheSize(int Value);
	TElXTreeItemStaticDataEx* __fastcall CreateDataCacheItem(void);
	void __fastcall CacheItem(TElXTreeItem* Item, int MinInCache);
	virtual Lmdtypes::TLMDString __fastcall GetIncSearchColumnText(TElXTreeItem* Item);
	void __fastcall ResetAllItemsHeight(void);
	void __fastcall ResetVisItemsHeight(void);
	void __fastcall ReadScrollTracking(System::Classes::TReader* Reader);
	void __fastcall ReadExpandOnDblClick(System::Classes::TReader* Reader);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	void __fastcall SetCheckBoxFlat(bool Value);
	void __fastcall SetSortColumnColor(System::Uitypes::TColor Value);
	void __fastcall SetCellStyle(Elxtreecell::TElXCellStyle* Value);
	Elxtreecell::TElXCellStyle* __fastcall GetCellStyle(void);
	__property bool ForceAlign = {read=FForceAlign, write=SetForeceAlign, default=0};
	__property bool RowCheck = {read=FRowCheck, write=SetRowCheck, default=0};
	__property Elxtreecell::TElXCellStyle* Style = {read=GetCellStyle, write=SetCellStyle};
	__property System::Uitypes::TColor TextColor = {read=FTextColor, write=SetTextColor, default=-16777208};
	__property System::Uitypes::TColor BackGroundColor = {read=FBackGroundColor, write=SetBackGroundColor, default=-16777211};
	__property System::Uitypes::TColor CurTextColor = {read=FCurTextColor, write=FCurTextColor, nodefault};
	__property bool ShowButtons = {read=FShowButtons, write=SetShowButtons, default=1};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property bool ShowLines = {read=FShowLines, write=SetShowLines, default=1};
	__property bool ShowImages = {read=FShowImages, write=SetShowImages, default=1};
	__property bool ShowRoot = {read=FShowRoot, write=SetShowRoot, default=0};
	__property Eltreeinplaceeditors::THintModes LineHintMode = {read=FLineHintMode, write=FLineHintMode, default=1};
	__property System::Uitypes::TColor LineHintColor = {read=FLineHintColor, write=FLineHintColor, default=-16777211};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, default=0};
	__property bool HideHintOnTimer = {read=FHideHintOnTimer, write=FHideHintOnTimer, default=0};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* Images2 = {read=FImages2, write=SetImages2};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaForImages, write=SetAlphaForImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages2 = {read=FAlphaForImages2, write=SetAlphaForImages2};
	__property bool ChangeStateImage = {read=FChangeStateImage, write=SetChangeStateImage, default=0};
	__property bool ShowColumns = {read=FShowColumns, write=SetShowColumns, default=0};
	__property Eltreeinplaceeditors::TDragTargetDraw DragTrgDrawMode = {read=FDragTrgDrawMode, write=SetDragTrgDrawMode, default=2};
	__property bool DraggableSections = {read=GetDraggableSections, write=SetDraggableSections, default=0};
	__property Eltreeinplaceeditors::TSTSelModes SelectionMode = {read=FSelectionMode, write=FSelectionMode, default=1};
	__property bool DoInplaceEdit = {read=FDoInplaceEdit, write=SetDoInplaceEdit, default=1};
	__property bool VerticalLines = {read=FVerticalLines, write=SetVerticalLines, default=0};
	__property bool BarStyleVerticalLines = {read=FBarStyleVerticalLines, write=SetBarStyleVerticalLines, default=0};
	__property bool HorizontalLines = {read=FHorizontalLines, write=SetHorizontalLines, default=0};
	__property bool HorzScrollTracking = {read=FHorzScrollTracking, write=FHorzScrollTracking, default=0};
	__property bool VertScrollTracking = {read=FVertScrollTracking, write=FVertScrollTracking, default=0};
	__property bool HotTrack = {read=FHotTrack, write=FHotTrack, default=1};
	__property bool RowSelect = {read=FRowSelect, write=SetRowSelect, default=1};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=1};
	__property int MultiSelectLevel = {read=FMultiSelectLevel, write=SetMultiSelectLevel, default=-1};
	__property int LineHeight = {read=FLineHeight, write=SetLineHeight, nodefault};
	__property bool AutoLineHeight = {read=FAutoLineHeight, write=SetAutoLineHeight, default=1};
	__property bool AutoLineVisibleOnly = {read=FAutoLineVisibleOnly, write=SetAutoLineVisibleOnly, default=0};
	__property bool HeaderHotTrack = {read=FHeaderHotTrack, write=SetHeaderHotTrack, default=1};
	__property int HeaderRowCount = {read=GetHeaderRowCount, write=SetHeaderRowCount, default=1};
	__property int HeaderHeight = {read=GetHeaderHeight, write=SetHeaderHeight, nodefault};
	__property int MainTreeColumn = {read=FMainTreeColumn, write=SetMainTreeColumn, default=0};
	__property bool OwnerDrawByColumn = {read=FOwnerDrawByColumn, write=FOwnerDrawByColumn, default=1};
	__property Lmdtypes::TLMDString OwnerDrawMask = {read=FOwnerDrawMask, write=FOwnerDrawMask, stored=IsOwnerDrawMaskStored};
	__property bool DragAllowed = {read=FDragAllowed, write=FDragAllowed, default=0};
	__property Eltreeinplaceeditors::TSortDirs SortDir = {read=FSortDir, write=FSortDir, default=0};
	__property Eltreeinplaceeditors::TSortModes SortMode = {read=FSortMode, write=SetSortMode, default=0};
	__property int SortSection = {read=FSortSection, write=SetSortSection, default=0};
	__property Eltreeinplaceeditors::TSortTypes SortType = {read=FSortType, write=FSortType, default=1};
	__property bool HideHintOnMove = {read=FHideHintOnMove, write=FHideHintOnMove, default=1};
	__property bool MoveColumnOnDrag = {read=GetMoveColumnOnDrag, write=SetMoveColumnOnDrag, default=0};
	__property bool HideHorzScrollBar = {read=FHideHorzScrollBar, write=SetHideHorzScrollBar, default=0};
	__property bool HideVertScrollBar = {read=FHideVertScrollBar, write=SetHideVertScrollBar, default=0};
	__property Elscrollbar::TElScrollBarStyles* HorzScrollBarStyles = {read=FHorzScrollBarStyle, write=SetHorzScrollBarStyle, stored=true};
	__property Elscrollbar::TElScrollBarStyles* VertScrollBarStyles = {read=FVertScrollBarStyle, write=SetVertScrollBarStyle, stored=true};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, default=2};
	__property Vcl::Imglist::TCustomImageList* HeaderImages = {read=GetHeaderImages, write=SetHeaderImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForHeaderImages = {read=GetAlphaHeaderImages, write=SetAlphaHeaderImages};
	__property Eltreeinplaceeditors::TDragImgMode DragImageMode = {read=FDragImageMode, write=FDragImageMode, default=0};
	__property System::UnicodeString StoragePath = {read=FStoragePath, write=FStoragePath};
	__property Elini::TElIniFile* Storage = {read=FStorage, write=SetStorage};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImageForm, write=SetImageForm};
	__property Elimgfrm::TElImageForm* HeaderImageForm = {read=GetHeaderImageForm, write=SetHeaderImageForm};
	__property bool ShowCheckBoxes = {read=FShowCheckBoxes, write=SetShowCheckBoxes, default=0};
	__property Vcl::Graphics::TBitmap* PlusPicture = {read=GetPlusPicture, write=SetPlusPicture};
	__property Vcl::Graphics::TBitmap* MinusPicture = {read=GetMinusPicture, write=SetMinusPicture};
	__property bool CustomPlusMinus = {read=FCustomPlusMinus, write=SetCustomPlusMinus, default=0};
	__property int SelectColumn = {read=FSelectColumn, write=SetSelectColumn, default=-1};
	__property bool AutoExpand = {read=FAutoExpand, write=SetAutoExpand, default=0};
	__property bool AutoLookup = {read=FAutoLookup, write=FAutoLookup, default=0};
	__property Eltreeinplaceeditors::TElDragType DragType = {read=FDragType, write=SetDragType, default=1};
	__property bool FullRowSelect = {read=FFullRowSelect, write=FFullRowSelect, default=1};
	__property bool AlwaysKeepSelection = {read=FAlwaysKeepSelection, write=FAlwaysKeepSelection, default=1};
	__property bool AlwaysKeepFocus = {read=FAlwaysKeepFocus, write=FAlwaysKeepFocus, default=0};
	__property bool StickyHeaderSections = {read=GetStickyHeaderSections, write=SetStickyHeaderSections, default=0};
	__property bool BarStyle = {read=FBarStyle, write=SetBarStyle, default=0};
	__property bool DrawFocusRect = {read=FDrawFocusRect, write=SetDrawFocusRect, default=1};
	__property bool DeselectChildrenOnCollapse = {read=FDeselectChildrenOnCollapse, write=FDeselectChildrenOnCollapse, default=0};
	__property System::Uitypes::TColor HorzDivLinesColor = {read=FHorzDivLinesColor, write=SetHorzDivLinesColor, default=-16777201};
	__property System::Uitypes::TColor LinesColor = {read=FLinesColor, write=SetLinesColor, default=-16777201};
	__property Vcl::Graphics::TPenStyle LinesStyle = {read=FLinesStyle, write=SetLinesStyle, default=2};
	__property System::WideChar PathSeparator = {read=FPathSeparator, write=FPathSeparator, default=92};
	__property bool RightAlignedView = {read=FRightAlignedView, write=SetRightAlignedView, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool RightAlignedText = {read=FRightAlignedText, write=SetRightAlignedText, default=0};
	__property bool FilteredVisibility = {read=FFilteredVisibility, write=SetFilteredVisibility, default=0};
	__property bool UnderlineTracked = {read=FUnderlineTracked, write=SetUnderlineTracked, default=1};
	__property bool CustomCheckboxes = {read=FCustomCheckboxes, write=SetCustomCheckboxes, default=0};
	__property Vcl::Graphics::TBitmap* CheckBoxGlyph = {read=GetCheckBoxGlyph, write=SetCheckBoxGlyph};
	__property Vcl::Graphics::TBitmap* RadioButtonGlyph = {read=GetRadioButtonGlyph, write=SetRadioButtonGlyph};
	__property bool ScrollbarOpposite = {read=FScrollbarOpposite, write=SetScrollbarOpposite, default=0};
	__property bool ShowRootButtons = {read=FShowRootButtons, write=SetShowRootButtons, default=1};
	__property bool ShowEmptyImages = {read=FShowEmptyImages, write=SetShowEmptyImages, default=0};
	__property bool ShowEmptyImages2 = {read=FShowEmptyImages2, write=SetShowEmptyImages2, default=0};
	__property bool LockHeaderHeight = {read=GetLockHeaderHeight, write=SetLockHeaderHeight, default=0};
	__property bool AutoResizeColumns = {read=FAutoResizeColumns, write=FAutoResizeColumns, default=1};
	__property System::Uitypes::TColor HeaderActiveFilterColor = {read=GetHeaderActiveFilterColor, write=SetHeaderActiveFilterColor, default=0};
	__property System::Uitypes::TColor HeaderFilterColor = {read=GetHeaderFilterColor, write=SetHeaderFilterColor, default=-16777198};
	__property bool HeaderFlat = {read=GetHeaderFlat, write=SetHeaderFlat, default=0};
	__property bool HeaderWrapCaptions = {read=GetHeaderWrapCaptions, write=SetHeaderWrapCaptions, default=0};
	__property bool FlatFocusedScrollbars = {read=FFlatFocusedScrollbars, write=SetFlatFocusedScrollbars, default=1};
	__property System::Uitypes::TColor HideSelectColor = {read=FHideSelectColor, write=SetHideSelectColor, default=-16777201};
	__property System::Uitypes::TColor FocusedSelectColor = {read=FFocusedSelectColor, write=SetFocusedSelectColor, default=-16777203};
	__property System::Uitypes::TColor FocusedSelectTextColor = {read=FFocusedSelectTextColor, write=SetFocusedSelectTextColor, default=-16777202};
	__property System::Uitypes::TColor HideSelectTextColor = {read=FHideSelectTextColor, write=SetHideSelectTextColor, default=-16777200};
	__property bool UseCustomScrollBars = {read=FUseCustomScrollBars, write=SetUseCustomScrollBars, default=1};
	__property bool RowHotTrack = {read=FRowHotTrack, write=SetRowHotTrack, default=0};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property int ItemIndent = {read=FItemIndent, write=SetItemIndent, default=17};
	__property System::Uitypes::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, default=0};
	__property System::Uitypes::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, default=0};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, default=64};
	__property System::Uitypes::TCursor Cursor = {read=GetCursor, write=SetCursor, default=0};
	__property bool HeaderInvertSortArrows = {read=GetHeaderInvertSortArrows, write=SetHeaderInvertSortArrows, default=0};
	__property bool MoveFocusOnCollapse = {read=FMoveFocusOnCollapse, write=SetMoveFocusOnCollapse, default=0};
	__property System::Uitypes::TScrollStyle ForcedScrollBars = {read=FForcedScrollBars, write=SetForcedScrollBars, default=0};
	__property bool PlusMinusTransparent = {read=FPlusMinusTransparent, write=SetPlusMinusTransparent, default=0};
	__property Lmdtypes::TLMDString Hint = {read=GetHint, write=SetHint};
	__property System::Uitypes::TColor DragRectAcceptColor = {read=FDragRectAcceptColor, write=SetDragRectAcceptColor, default=32768};
	__property System::Uitypes::TColor DragRectDenyColor = {read=FDragRectDenyColor, write=SetDragRectDenyColor, default=255};
	__property int DragExpandDelay = {read=FDragExpandDelay, write=FDragExpandDelay, default=500};
	__property int IncrementalSearchTimeout = {read=FIncrementalSearchTimeout, write=FIncrementalSearchTimeout, default=500};
	__property bool IncrementalSearch = {read=FIncrementalSearch, write=FIncrementalSearch, default=0};
	__property bool IncrementalSearchSelectItem = {read=FIncrementalSearchSelectItem, write=FIncrementalSearchSelectItem, default=0};
	__property bool AdjustMultilineHeight = {read=FAdjustMultilineHeight, write=SetAdjustMultilineHeight, default=1};
	__property bool ExpandOnDragOver = {read=FExpandOnDragOver, write=FExpandOnDragOver, default=0};
	__property System::Uitypes::TCursor DragCursor = {read=GetDragCursor, write=SetDragCursor, default=-12};
	__property bool UseSystemHintColors = {read=FUseSystemHintColors, write=FUseSystemHintColors, default=0};
	__property System::Uitypes::TColor HeaderColor = {read=GetHeaderColor, write=SetHeaderColor, default=-16777201};
	__property int ChangeDelay = {read=FChangeDelay, write=FChangeDelay, default=500};
	__property bool RightClickSelect = {read=FRightClickSelect, write=FRightClickSelect, default=1};
	__property System::Uitypes::TColor StripedOddColor = {read=FStripedOddColor, write=SetStripedOddColor, stored=IsStripedColorStored, nodefault};
	__property System::Uitypes::TColor StripedEvenColor = {read=FStripedEvenColor, write=SetStripedEvenColor, stored=IsStripedColorStored, nodefault};
	__property bool StripedItems = {read=FStripedItems, write=SetStripedItems, default=0};
	__property TInplaceEditorNeededXEvent OnInplaceEditorNeeded = {read=FOnInplaceEditorNeeded, write=FOnInplaceEditorNeeded};
	__property bool QuickEditMode = {read=FQuickEditMode, write=FQuickEditMode, default=0};
	__property Elheader::TElFieldType MainTextType = {read=FMainTextType, write=FMainTextType, default=1};
	__property Eltreeinplaceeditors::TElHintType HintType = {read=FHintType, write=FHintType, default=2};
	__property Elsbctrl::TElScrollHitTestEvent OnVertScrollHitTest = {read=FOnVertScrollHitTest, write=FOnVertScrollHitTest};
	__property Elsbctrl::TElScrollHitTestEvent OnHorzScrollHitTest = {read=FOnHorzScrollHitTest, write=FOnHorzScrollHitTest};
	__property bool MouseFrameVisible = {read=FMouseFrameVisible, write=FMouseFrameVisible, default=1};
	__property bool MouseFrameSelect = {read=FMouseFrameSelect, write=FMouseFrameSelect, default=1};
	__property System::Uitypes::TColor VertDivLinesColor = {read=FVertDivLinesColor, write=SetVertDivLinesColor, default=-16777201};
	__property bool AdjustInplaceEditorPosition = {read=FAdjustInplaceEditorPosition, write=SetAdjustInplaceEditorPosition, nodefault};
	__property TElXOnItemChangeEvent OnItemChange = {read=FOnItemChange, write=FOnItemChange};
	__property TElXOnCellChangeEvent OnCellChange = {read=FOnCellChange, write=FOnCellChange};
	__property TElXOnItemDrawEvent OnItemDraw = {read=FOnItemDraw, write=FOnItemDraw};
	__property TElXOnCellDrawEvent OnCellDraw = {read=FOnCellDraw, write=FOnCellDraw};
	__property TElXOnItemCheckedEvent OnItemChecked = {read=FOnItemChecked, write=FOnItemChecked};
	__property TElXOnItemCheckStateChangingEvent OnItemCheckStateChanging = {read=FOnItemCheckStateChanging, write=FOnItemCheckStateChanging};
	__property TElXOnItemExpandEvent OnItemExpand = {read=FOnItemExpand, write=FOnItemExpand};
	__property TElXOnItemExpandEvent OnItemCollapse = {read=FOnItemCollapse, write=FOnItemCollapse};
	__property TElXOnItemExpanding OnItemExpanding = {read=FOnItemExpanding, write=FOnItemExpanding};
	__property TElXOnItemExpanding OnItemCollapsing = {read=FOnItemCollapsing, write=FOnItemCollapsing};
	__property TElXScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property TElXOnItemExpandEvent OnItemDeletion = {read=FOnItemDelete, write=FOnItemDelete};
	__property TElXOnItemExpandEvent OnItemCreated = {read=FOnItemCreated, write=FOnItemCreated};
	__property TElXCellEvent OnCellDeletion = {read=FOnCellDeletion, write=FOnCellDeletion};
	__property TElXTreeChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property System::Classes::TNotifyEvent OnItemFocused = {read=FOnItemFocused, write=FOnItemFocused};
	__property TElXOnShowHintEvent OnShowLineHint = {read=FOnShowHint, write=FOnShowHint};
	__property TElXOnCompareItems OnCompareItems = {read=FOnCompareItems, write=FOnCompareItems};
	__property TElXOnPicDrawEvent OnItemPicDraw = {read=FOnItemPicDraw, write=FOnItemPicDraw};
	__property TElXOnPicDrawEvent OnItemPicDraw2 = {read=FOnItemPicDraw2, write=FOnItemPicDraw2};
	__property TElXOnCellPicDrawEvent OnCellPicDraw = {read=FOnCellPicDraw, write=FOnCellPicDraw};
	__property TElXHotTrackEvent OnHotTrack = {read=FOnHotTrack, write=FOnHotTrack};
	__property TElXCanDragEvent OnCanDrag = {read=GetCanDrag, write=SetCanDrag};
	__property TElXTryEditEvent OnTryEdit = {read=FOnTryEdit, write=FOnTryEdit};
	__property TElXOnEndEditEvent OnEndEditItem = {read=FOnEndEdit, write=FOnEndEdit};
	__property TElXItemSaveEvent OnItemSave = {read=FOnItemSave, write=FOnItemSave};
	__property TElXItemSaveEvent OnItemLoad = {read=FOnItemLoad, write=FOnItemLoad};
	__property TElXItemSelChangeEvent OnItemSelectedChange = {read=FOnItemSelectedChange, write=FOnItemSelectedChange};
	__property TElXCellStyleSaveEvent OnCellStyleSave = {read=FOnSave, write=FOnSave};
	__property TElXCellStyleSaveEvent OnCellStyleLoad = {read=FOnLoad, write=FOnLoad};
	__property System::Classes::TNotifyEvent OnSortBegin = {read=FOnSortBegin, write=FOnSortBegin};
	__property System::Classes::TNotifyEvent OnSortEnd = {read=FOnSortEnd, write=FOnSortEnd};
	__property System::Classes::TNotifyEvent OnHeaderResize = {read=FOnHeaderResize, write=FOnHeaderResize};
	__property Elheader::TElHeaderLookupEvent OnHeaderLookup = {read=FOnHeaderLookup, write=FOnHeaderLookup};
	__property Elheader::TElHeaderLookupDoneEvent OnHeaderLookupDone = {read=FOnHeaderLookupDone, write=FOnHeaderLookupDone};
	__property Elxheader::TElXHeaderSectionEvent OnHeaderSectionExpand = {read=FOnHeaderSectionExpand, write=FOnHeaderSectionExpand};
	__property Elxheader::TElXHeaderSectionEvent OnHeaderSectionCollapse = {read=FOnHeaderSectionCollapse, write=FOnHeaderSectionCollapse};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderSectionAutoSize = {read=FOnSectionAutoSize, write=FOnSectionAutoSize};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderColumnResize = {read=FOnColumnResize, write=FOnColumnResize};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderColumnClick = {read=FOnColumnClick, write=FOnColumnClick};
	__property TElXColumnMoveEvent OnHeaderColumnMove = {read=FOnHeaderColumnMove, write=FOnHeaderColumnMove};
	__property Elxheader::TElXSectionRedrawEvent OnHeaderColumnDraw = {read=FOnColumnDraw, write=FOnColumnDraw};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderSectionFilterCall = {read=FOnSectionFilterCall, write=FOnSectionFilterCall};
	__property Elheader::TMeasureSectionEvent OnHeaderSectionMeasure = {read=FOnHeaderSectionMeasure, write=FOnHeaderSectionMeasure};
	__property Elxheader::TElXHeaderSectionCellEvent OnHeaderSectionCellClick = {read=FOnHeaderSectionCellClick, write=FOnHeaderSectionCellClick};
	__property TElXApplyVisFilterEvent OnApplyVisFilter = {read=FOnApplyVisFilter, write=FOnApplyVisFilter};
	__property TElXTreeItemPostDrawEvent OnItemPostDraw = {read=FOnItemPostDraw, write=FOnItemPostDraw};
	__property TElXMeasureItemPartEvent OnMeasureItemPart = {read=FOnMeasureItemPart, write=FOnMeasureItemPart};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnHTMLImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnHTMLImageNeededEx = {read=FOnImageNeededEx, write=FOnImageNeededEx};
	__property Lmdhtmlunit::TLMDHTMLControlPositionNeededEvent OnAdjustControlPosition = {read=FOnAdjustControlPosition, write=FOnAdjustControlPosition};
	__property Lmdhtmlunit::TLMDHTMLControlCreatedEvent OnControlCreated = {read=FOnControlCreated, write=FOnControlCreated};
	__property Lmdhtmlunit::TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TElHTMLLinkOverEvent OnLinkOver = {read=FOnLinkOver, write=FOnLinkOver};
	__property System::Uitypes::TCursor LinkCursor = {read=FLinkCursor, write=FLinkCursor, default=-21};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Vcl::Controls::TDragDropEvent OnDragDrop = {read=FOnDrop, write=FOnDrop};
	__property Vcl::Controls::TDragOverEvent OnDragOver = {read=FOnOver, write=FOnOver};
	__property System::Classes::TNotifyEvent OnEnter = {read=FOnEnter, write=FOnEnter};
	__property System::Classes::TNotifyEvent OnExit = {read=FOnExit, write=FOnExit};
	__property Vcl::Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property Vcl::Controls::TKeyPressEvent OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property Vcl::Controls::TKeyEvent OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property Vcl::Controls::TStartDragEvent OnStartDrag = {read=FOnStartDrag, write=FOnStartDrag};
	__property Eldragdrop::TTargetDragEvent OnOleTargetDrag = {read=FOnOleTargetDrag, write=FOnOleTargetDrag};
	__property Eldragdrop::TTargetDropEvent OnOleTargetDrop = {read=FOnOleTargetDrop, write=FOnOleTargetDrop};
	__property TElXOleDragStartEvent OnOleDragStart = {read=FOnOleDragStart, write=FOnOleDragStart};
	__property TElXOleDragFinishEvent OnOleDragFinish = {read=FOnOleDragFinish, write=FOnOleDragFinish};
	__property Elsbctrl::TElScrollDrawPartEvent OnHorzScrollDrawPart = {read=FOnHorzScrollDrawPart, write=FOnHorzScrollDrawPart};
	__property Elsbctrl::TElScrollHintNeededEvent OnHorzScrollHintNeeded = {read=FOnHorzScrollHintNeeded, write=FOnHorzScrollHintNeeded};
	__property Elsbctrl::TElScrollDrawPartEvent OnVertScrollDrawPart = {read=FOnVertScrollDrawPart, write=FOnVertScrollDrawPart};
	__property Elsbctrl::TElScrollHintNeededEvent OnVertScrollHintNeeded = {read=FOnVertScrollHintNeeded, write=FOnVertScrollHintNeeded};
	__property Vcl::Controls::TMouseEvent OnHeaderMouseDown = {read=FOnHeaderMouseDown, write=FOnHeaderMouseDown};
	__property System::Classes::TNotifyEvent OnAfterSelectionChange = {read=FOnAfterSelectionChange, write=FOnAfterSelectionChange};
	__property TElXOnItemExpandEvent OnItemPreDraw = {read=FOnItemPreDraw, write=FOnItemPreDraw};
	__property TElXTreeItemDragTargetEvent OnDragTargetChange = {read=FOnDragTargetChange, write=FOnDragTargetChange};
	__property int LineHintTimeout = {read=FLineHintTimeout, write=SetLineHintTimeout, default=3000};
	__property bool VerticalLinesLong = {read=FVerticalLinesLong, write=SetVerticalLinesLong, default=1};
	__property int DefaultSectionWidth = {read=GetDefaultSectionWidth, write=SetDefaultSectionWidth, default=120};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Eltreeinplaceeditors::TLineHintType LineHintType = {read=FLineHintType, write=FLineHintType, default=2};
	__property TElXVirtualPropsNeededEvent OnVirtualPropsNeeded = {read=FOnVirtualPropsNeeded, write=FOnVirtualPropsNeeded};
	__property TElXVirtualTextNeededEvent OnVirtualTextNeeded = {read=FOnVirtualTextNeeded, write=FOnVirtualTextNeeded};
	__property TElXVirtualTextNeededEvent OnUserCellTextNeeded = {read=FOnUserCellTextNeeded, write=FOnUserCellTextNeeded};
	__property Eltreeinplaceeditors::TVirtualityLevel VirtualityLevel = {read=FVirtualityLevel, write=SetVirtualityLevel, default=0};
	__property TElXVirtualHintNeededEvent OnVirtualHintNeeded = {read=FOnVirtualHintNeeded, write=FOnVirtualHintNeeded};
	__property TElXVirtualValueNeededEvent OnVirtualValueNeeded = {read=FOnVirtualValueNeeded, write=FOnVirtualValueNeeded};
	__property TElXVirtualStyleNeededEvent OnVirtualStyleNeeded = {read=FOnVirtualStyleNeeded, write=FOnVirtualStyleNeeded};
	__property int CheckBoxSize = {read=GetCheckBoxSize, write=SetCheckBoxSize, default=15};
	__property int DragScrollInterval = {read=FDragScrollInterval, write=FDragScrollInterval, default=100};
	__property bool ShowLeafButton = {read=FShowLeafButton, write=SetShowLeafButton, nodefault};
	__property Vcl::Graphics::TBitmap* LeafPicture = {read=GetLeafPicture, write=SetLeafPicture};
	__property bool ExplorerEditMode = {read=FExplorerEditMode, write=FExplorerEditMode, default=0};
	__property bool IgnoreEnabled = {read=FIgnoreEnabled, write=FIgnoreEnabled, default=0};
	__property int InplaceEditorDelay = {read=FInplaceEditorDelay, write=FInplaceEditorDelay, default=500};
	__property Vcl::Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont, stored=IsHeaderFontStored};
	__property bool HeaderUseTreeFont = {read=FHeaderUseTreeFont, write=SetHeaderUseTreeFont, default=1};
	__property bool KeepSelectionWithinLevel = {read=FKeepSelectionWithinLevel, write=FKeepSelectionWithinLevel, default=0};
	__property bool AutoCollapse = {read=FAutoCollapse, write=FAutoCollapse, default=0};
	__property bool SortUseCase = {read=FSortUseCase, write=SetSortUseCase, default=1};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property Eltreeinplaceeditors::TElDblClickMode DblClickMode = {read=FDblClickMode, write=SetDblClickMode, default=1};
	__property int HighlightAlphaLevel = {read=FHighlightAlphaLevel, write=SetHighlightAlphaLevel, default=255};
	__property int DataCacheSize = {read=FDataCacheSize, write=SetDataCacheSize, default=200};
	__property Eltreeinplaceeditors::TElIncSearchScope IncrementalSearchScope = {read=FIncrementalSearchScope, write=FIncrementalSearchScope, default=0};
	__property Eltreeinplaceeditors::TElIncSearchColumn IncrementalSearchColumn = {read=FIncrementalSearchColumn, write=FIncrementalSearchColumn, default=0};
	__property bool CheckBoxFlat = {read=FCheckBoxFlat, write=SetCheckBoxFlat, default=0};
	__property bool HorzArrowsScroll = {read=FHorzArrowsScroll, write=FHorzArrowsScroll, default=0};
	__property System::Uitypes::TColor SortColumnColor = {read=FSortColumnColor, write=SetSortColumnColor, default=536870911};
	__property int FixedTopRowNum = {read=FFixedTopRowNum, write=SetFixedTopRowNum, nodefault};
	__property int FixedBottomRowNum = {read=FFixedBottomRowNum, write=SetFixedBottomRowNum, nodefault};
	__property int FixedBottomRowsHeight = {read=GetFixedBottomRowsHeight, nodefault};
	__property int FixedColNum = {read=GetFixedColNum, write=SetFixedColNum, nodefault};
	void __fastcall CascadAutoSizeColumn(int SectionIndex, bool NotAutoSizeOnly, bool VisOnly);
	__property TElXTreeHeader* Header = {read=FHeader};
	void __fastcall SetNotRaiseForBarStyle(bool value);
	__property System::Classes::TNotifyEvent OnCtlClick = {read=FOnCtlClick, write=FOnCtlClick};
	__property System::Classes::TNotifyEvent OnCtlDblClick = {read=FOnCtlDblClick, write=FOnCtlDblClick};
	__property Vcl::Controls::TMouseEvent OnCtlMouseDown = {read=FOnCtlMouseDown, write=FOnCtlMouseDown};
	__property Vcl::Controls::TMouseMoveEvent OnCtlMouseMove = {read=FOnCtlMouseMove, write=FOnCtlMouseMove};
	__property Vcl::Controls::TMouseEvent OnCtlMouseUp = {read=FOnCtlMouseUp, write=FOnCtlMouseUp};
	
public:
	__fastcall virtual TCustomElXTree(System::Classes::TComponent* AOwner);
	__fastcall TCustomElXTree(System::Classes::TComponent* AOwner, TElXTreeItemClass ItemClass);
	void __fastcall DoInCreate(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElXTree(void);
	__property Font = {stored=IsFontStored};
	virtual void __fastcall Update(void);
	bool __fastcall SetByFullName(Lmdtypes::TLMDString FullName, System::WideChar Separator, TElXTreeItem* StartItem = (TElXTreeItem*)(0x0));
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall FullCollapse(void);
	virtual void __fastcall FullExpand(void);
	DYNAMIC bool __fastcall CanFocus(void);
	virtual Vcl::Controls::TDragImageList* __fastcall GetDragImages(void);
	DYNAMIC bool __fastcall Focused(void);
	virtual System::Types::TRect __fastcall GetItemRect(int ItemIndex);
	virtual TElXTreeItem* __fastcall GetItemAtY(int Y);
	virtual TElXTreeItem* __fastcall GetItemAt(int X, int Y, Eltreeinplaceeditors::TSTItemPart &ItemPart, int &HitColumn);
	virtual void __fastcall MeasureCell(TElXTreeItem* Item, int ColumnNum, int MaxWidth, System::Types::TPoint &Size);
	virtual TElXTreeItem* __fastcall GetNextSelected(TElXTreeItem* Prev);
	TElXTreeItem* __fastcall GetNextChecked(TElXTreeItem* aStartItem = (TElXTreeItem*)(0x0), bool aIterateBackward = false, bool aCheckStartItem = true, bool aSubItemsOnly = false, bool aVisibleOnly = false, bool aCountCollapsed = false, bool aMakeFoundVisible = true, bool aMakeFoundSelected = true, bool aMakeFoundFocused = true);
	int __fastcall GetCheckedCount(TElXTreeItem* aStartItem = (TElXTreeItem*)(0x0), bool aCheckStartItem = true, bool aSubItemsOnly = false, bool aVisibleOnly = false, bool aCountCollapsed = false);
	virtual void __fastcall MakeColVisible(int aColIndex);
	__property System::Uitypes::TColor TrackColor = {read=FTrackColor, write=SetTrackColor, default=-16777203};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	virtual void __fastcall AllSelected(Lmdobjectlist::TLMDObjectList* SelectedItems);
	virtual void __fastcall SelectAll(bool ASelectWithCells = false);
	virtual void __fastcall InvertSelection(void);
	virtual void __fastcall SelectAllEx(bool IncludeHidden);
	virtual void __fastcall InvertSelectionEx(bool IncludeHidden);
	virtual void __fastcall DeselectAll(bool Notification = true);
	virtual void __fastcall DeselectAllEx(bool IncludeHidden);
	virtual void __fastcall SelectRange(TElXTreeItem* FromItem, TElXTreeItem* ToItem);
	virtual void __fastcall SelectRange2(TElXTreeItem* FromItem, TElXTreeItem* ToItem, bool SelectDisabled, bool SelectCollapsedChildren);
	virtual void __fastcall SelectRange3(TElXTreeItem* FromItem, TElXTreeItem* ToItem, int StartCol, int EndCol, bool SelectDisabled, bool SelectCollapsedChildren, bool Selected);
	virtual void __fastcall SelectRangeEx(TElXTreeItem* FromItem, TElXTreeItem* ToItem, bool IncludeHidden);
	virtual void __fastcall SelectRangeEx2(TElXTreeItem* FromItem, TElXTreeItem* ToItem, bool IncludeHidden, bool SelectDisabled, bool SelectCollapsedChildren);
	virtual void __fastcall SelectRangeEx3(TElXTreeItem* FromItem, TElXTreeItem* ToItem, int StartCol, int EndCol, bool IncludeHidden, bool SelectDisabled, bool SelectCollapsedChildren, bool Selected);
	virtual void __fastcall Sort(bool recursive);
	virtual void __fastcall Save(void);
	virtual void __fastcall Restore(void);
	void __fastcall EnsureVisible(TElXTreeItem* Item);
	void __fastcall EnsureVisibleBottom(TElXTreeItem* Item);
	void __fastcall EnsureVisibleEx(TElXTreeItem* Item, bool Expande);
	void __fastcall EnsureVisibleBottomEx(TElXTreeItem* Item, bool Expande);
	bool __fastcall IsEditing(void);
	virtual void __fastcall EditItem(TElXTreeItem* Item, int SectionNum);
	void __fastcall EndEdit(bool ByCancel);
	virtual void __fastcall SaveStringsToStream(System::Classes::TStream* Stream);
	TElXTreeItem* __fastcall GetNodeAt(int X, int Y);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual bool __fastcall IsInView(TElXTreeItem* Item);
	virtual int __fastcall MeasureColumnWidth(int ColumnNum, bool VisibleOnly);
	int __fastcall IndexInView(TElXTreeItem* Item);
	void __fastcall AllSelectedEx(Lmdobjectlist::TLMDObjectList* SelectedItems, bool Order);
	void __fastcall AddSortSection(int Index, bool ReSort);
	void __fastcall RemoveSortSection(int Index, bool ReSort);
	void __fastcall ClearSortList(bool ReSort);
	void __fastcall AutoSizeAllColumns(void);
	void __fastcall AutoSizeColumn(int SectionIndex);
	void __fastcall AutoSizeAllColumnsEx(bool VisibleOnly);
	void __fastcall AutoSizeColumnEx(int SectionIndex, bool VisibleOnly);
	virtual bool __fastcall MeasureCellText(TElXTreeItem* Item, int ColumnNum, int MaxWidth, System::Types::TPoint &Size);
	void __fastcall ResetUpdateCounter(void);
	virtual void __fastcall TriggerVirtualStyleNeeded(TElXTreeItem* Item, int SectionIndex, Elxtreecell::TElXCellStyle* Style);
	virtual void __fastcall TriggerVirtualTextNeeded(TElXTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);
	virtual void __fastcall TriggerUserCellTextNeeded(TElXTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);
	Vcl::Controls::TControl* __fastcall GetHTMLControlByName(Lmdtypes::TLMDString aControlName);
	__property Lmdobjectlist::TLMDObjectList* SortSections = {read=FSortSections};
	__property bool HideFocusRect = {read=FHideFocusRect, write=SetHideFocusRect, default=0};
	__property int GutterWidth = {read=GetGutterWidth, write=SetGutterWidth, nodefault};
	__property Lmdtypes::TLMDString GutterText = {read=GetGutterText, write=SetGutterText};
	__property bool ColumnSizeUpdate = {read=FColumnSizeUpdate, write=FColumnSizeUpdate, nodefault};
	__property int TopIndex = {read=FTopIndex, write=SetTopIndex, nodefault};
	__property int UpdateCount = {read=FUpdateCount, nodefault};
	__property bool MouseOver = {read=FMouseOver, nodefault};
	__property int BottomIndex = {read=FBottomIndex, nodefault};
	__property bool IsUpdating = {read=GetUpdating, write=SetUpdating, nodefault};
	__property TElXTreeItems* Items = {read=FItems, write=SetItems};
	__property TElXTreeItem* ItemFocused = {read=GetFocused, write=SetFocused};
	__property int SelectedCount = {read=GetSelCount, nodefault};
	__property bool FireFocusEvents = {read=GetFireFocusEvents, write=SetFireFocusEvents, default=1};
	__property TElXTreeItem* Selected = {read=GetSelected, write=SetSelected};
	__property int HitColumn = {read=GetHitColumn, nodefault};
	__property TElXTreeItem* TopItem = {read=GetTopItem, write=SetTopItem};
	__property Vcl::Controls::TDragObject* DragObject = {read=FDragObject};
	__property TElXTreeView* View = {read=FView};
	__property bool HorzScrollBarVisible = {read=FHorzScrollBarVisible, nodefault};
	__property bool VertScrollBarVisible = {read=FVertScrollBarVisible, nodefault};
	__property int VisibleRowCount = {read=GetVisibleRowCount, nodefault};
	__property TElXTreeItem* DropTarget = {read=GetDropTarget};
	__property Elscrollbar::TElScrollBar* HScrollBar = {read=FHScrollBar};
	__property Elscrollbar::TElScrollBar* VScrollBar = {read=FVScrollBar};
	__property TElXTreeItem* TrackItem = {read=GetTrackItem};
	__property int SortSectionToCompare = {read=FSortSectionToCompare, nodefault};
	__property System::Uitypes::TColor CurBackGroundColor = {read=FCurBackGroundColor, write=FCurBackGroundColor, nodefault};
	__property Elxheader::TElXHeaderSections* HeaderSections = {read=GetHeaderSections, write=SetHeaderSections};
	__property bool BarStyleNotRaise = {read=FNotRaiseForBarStyle, write=SetNotRaiseForBarStyle, default=0};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	__property bool UseThemeForSelection = {read=FUseThemeForSelection, write=SetUseThemeForSelection, default=0};
	
__published:
	__property int LeftPosition = {read=FLeftPosition, write=SetLeftPosition, default=0};
	__property Lmdgraph::TLMDVerticalAlign PlusPosition = {read=GetPlusPosition, write=SetPlusPosition, default=0};
	__property Vcl::Controls::TBevelKind BevelKind = {read=FBevelKindDummy, write=FBevelKindDummy, stored=false, default=0};
	__property Vcl::Menus::TPopupMenu* HeaderPopupMenu = {read=GetHeaderPopupMenu, write=SetHeaderPopupMenu};
	__property bool DoubleBuffered = {read=FDoubleBuffered, write=SetDoubleBuffered, default=1};
	__property bool DoubleBufferedOnResize = {read=FDoubleBufferedOnResize, write=FDoubleBufferedOnResize, default=1};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777201};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElXTree(HWND ParentWindow) : Eltreeinplaceeditors::TElTreeAncestor(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElXTree : public TCustomElXTree
{
	typedef TCustomElXTree inherited;
	
public:
	__property UpdateCount;
	__property UseXPThemes;
	
__published:
	__property ForceAlign = {default=0};
	__property UseThemeForSelection = {default=0};
	__property OnCanDrag;
	__property Header;
	__property ActiveBorderType = {default=1};
	__property DragCursor = {default=-12};
	__property Align = {default=0};
	__property AlwaysKeepFocus = {default=0};
	__property AlwaysKeepSelection = {default=1};
	__property AutoCollapse = {default=0};
	__property AutoExpand = {default=0};
	__property AutoLineHeight = {default=1};
	__property AutoLineVisibleOnly = {default=0};
	__property AutoLookup = {default=0};
	__property AutoResizeColumns = {default=1};
	__property Anchors = {default=3};
	__property Constraints;
	__property Style;
	__property DockOrientation = {default=0};
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered = {default=1};
	__property DragKind = {default=0};
	__property DefaultSectionWidth = {default=120};
	__property AdjustMultilineHeight = {default=1};
	__property Background;
	__property BackgroundType = {default=2};
	__property BarStyle = {default=0};
	__property BarStyleNotRaise = {default=0};
	__property BarStyleVerticalLines = {default=0};
	__property BorderStyle = {default=1};
	__property BorderSides = {default=15};
	__property ChangeDelay = {default=500};
	__property ChangeStateImage = {default=0};
	__property CheckBoxFlat = {default=0};
	__property CheckBoxGlyph;
	__property CheckBoxSize = {default=15};
	__property Ctl3D;
	__property Color = {default=-16777211};
	__property Cursor = {default=0};
	__property CustomCheckboxes = {default=0};
	__property CustomPlusMinus = {default=0};
	__property DeselectChildrenOnCollapse = {default=0};
	__property DblClickMode = {default=1};
	__property DoInplaceEdit = {default=1};
	__property DragAllowed = {default=0};
	__property DragExpandDelay = {default=500};
	__property DraggableSections = {default=0};
	__property DrawFocusRect = {default=1};
	__property DragImageMode = {default=0};
	__property DragRectAcceptColor = {default=32768};
	__property DragRectDenyColor = {default=255};
	__property DragScrollInterval = {default=100};
	__property DragTrgDrawMode = {default=2};
	__property DragType = {default=1};
	__property Enabled = {default=1};
	__property ExpandOnDragOver = {default=0};
	__property ExplorerEditMode = {default=0};
	__property FilteredVisibility = {default=0};
	__property Flat = {default=0};
	__property FlatFocusedScrollbars = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property ForcedScrollBars = {default=0};
	__property Font = {stored=IsFontStored};
	__property FullRowSelect = {default=1};
	__property GradientStartColor = {default=0};
	__property GradientEndColor = {default=0};
	__property GradientSteps = {default=64};
	__property HeaderActiveFilterColor = {default=0};
	__property HeaderColor = {default=-16777201};
	__property HeaderHeight;
	__property HeaderRowCount = {default=1};
	__property HeaderHotTrack = {default=1};
	__property HeaderInvertSortArrows = {default=0};
	__property HeaderSections;
	__property HeaderFilterColor = {default=-16777198};
	__property HeaderFlat = {default=0};
	__property HeaderFont;
	__property HeaderUseTreeFont = {default=1};
	__property HeaderImages;
	__property AlphaForHeaderImages;
	__property HeaderWrapCaptions = {default=0};
	__property HideFocusRect = {default=0};
	__property HideHintOnTimer = {default=0};
	__property HideHintOnMove = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HideSelection = {default=0};
	__property HighlightAlphaLevel = {default=255};
	__property HorizontalLines = {default=0};
	__property HideHorzScrollBar = {default=0};
	__property HideVertScrollBar = {default=0};
	__property Hint;
	__property HintType = {default=2};
	__property HorzArrowsScroll = {default=0};
	__property HorzDivLinesColor = {default=-16777201};
	__property HorzScrollBarStyles;
	__property IgnoreEnabled = {default=0};
	__property HeaderImageForm;
	__property ImageForm;
	__property Images;
	__property Images2;
	__property AlphaForImages;
	__property AlphaForImages2;
	__property InactiveBorderType = {default=3};
	__property IncrementalSearch = {default=0};
	__property IncrementalSearchScope = {default=0};
	__property IncrementalSearchColumn = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property IncrementalSearchSelectItem = {default=0};
	__property InplaceEditorDelay = {default=500};
	__property ItemIndent = {default=17};
	__property Items;
	__property KeepSelectionWithinLevel = {default=0};
	__property LeafPicture;
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property LineHeight;
	__property LinesColor = {default=-16777201};
	__property LinesStyle = {default=2};
	__property LineHintColor = {default=-16777211};
	__property LineHintMode = {default=1};
	__property LineHintTimeout = {default=3000};
	__property LineHintType = {default=2};
	__property LockHeaderHeight = {default=0};
	__property MainTextType = {default=1};
	__property MainTreeColumn = {default=0};
	__property MinusPicture;
	__property MoveColumnOnDrag = {default=0};
	__property MoveFocusOnCollapse = {default=0};
	__property MouseFrameSelect = {default=1};
	__property MouseFrameVisible = {default=1};
	__property MultiSelect = {default=1};
	__property MultiSelectLevel = {default=-1};
	__property OwnerDrawByColumn = {default=1};
	__property OwnerDrawMask = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PathSeparator = {default=92};
	__property PlusMinusTransparent = {default=0};
	__property PlusPicture;
	__property PopupMenu;
	__property QuickEditMode = {default=0};
	__property RadioButtonGlyph;
	__property RightAlignedText = {default=0};
	__property RightAlignedView = {default=0};
	__property RightClickSelect = {default=1};
	__property RowCheck = {default=0};
	__property RowHotTrack = {default=0};
	__property RowSelect = {default=1};
	__property ScrollbarOpposite = {default=0};
	__property HorzScrollTracking = {default=0};
	__property VertScrollTracking = {default=0};
	__property SelectColumn = {default=-1};
	__property ShowButtons = {default=1};
	__property ShowColumns = {default=0};
	__property ShowCheckBoxes = {default=0};
	__property ShowEmptyImages = {default=0};
	__property ShowEmptyImages2 = {default=0};
	__property ShowHint;
	__property ShowImages = {default=1};
	__property ShowLeafButton;
	__property ShowLines = {default=1};
	__property ShowRoot = {default=0};
	__property ShowRootButtons = {default=1};
	__property SelectionMode = {default=1};
	__property SortColumnColor = {default=536870911};
	__property SortDir = {default=0};
	__property SortMode = {default=0};
	__property SortSection = {default=0};
	__property SortType = {default=1};
	__property Storage;
	__property StoragePath = {default=0};
	__property SortUseCase = {default=1};
	__property StickyHeaderSections = {default=0};
	__property StripedOddColor;
	__property StripedEvenColor;
	__property StripedItems = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property HotTrack = {default=1};
	__property TrackColor = {default=-16777203};
	__property UnderlineTracked = {default=1};
	__property UseCustomScrollBars = {default=1};
	__property VertDivLinesColor = {default=-16777201};
	__property VerticalLines = {default=0};
	__property VerticalLinesLong = {default=1};
	__property VertScrollBarStyles;
	__property VirtualityLevel = {default=0};
	__property Visible = {default=1};
	__property UseSystemHintColors = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TextColor = {default=-16777208};
	__property BackGroundColor = {default=-16777211};
	__property OnScroll;
	__property OnHeaderColumnClick;
	__property OnHeaderColumnDraw;
	__property OnHeaderColumnResize;
	__property OnHeaderColumnMove;
	__property OnHeaderLookup;
	__property OnHeaderLookupDone;
	__property OnHeaderResize;
	__property OnHeaderSectionExpand;
	__property OnHeaderSectionCollapse;
	__property OnHeaderSectionFilterCall;
	__property OnHeaderSectionAutoSize;
	__property OnHeaderSectionMeasure;
	__property OnHeaderSectionCellClick;
	__property OnHorzScrollDrawPart;
	__property OnHorzScrollHintNeeded;
	__property OnEditKeyDown;
	__property OnAfterSelectionChange;
	__property OnApplyVisFilter;
	__property OnChanging;
	__property OnDragTargetChange;
	__property OnItemChange;
	__property OnCellChange;
	__property OnItemPreDraw;
	__property OnItemDraw;
	__property OnCellDraw;
	__property OnResize;
	__property OnTryEdit;
	__property OnInplaceEditorNeeded;
	__property OnEndEditItem;
	__property OnItemChecked;
	__property OnItemCheckStateChanging;
	__property OnItemExpand;
	__property OnItemCollapse;
	__property OnItemExpanding;
	__property OnItemCollapsing;
	__property OnItemDeletion;
	__property OnItemCreated;
	__property OnItemFocused;
	__property OnShowLineHint;
	__property OnCompareItems;
	__property OnItemPicDraw;
	__property OnItemPicDraw2;
	__property OnCellPicDraw;
	__property OnItemPostDraw;
	__property OnHotTrack;
	__property OnMeasureItemPart;
	__property OnSortBegin;
	__property OnSortEnd;
	__property OnItemSave;
	__property OnItemLoad;
	__property OnItemSelectedChange;
	__property OnCellStyleSave;
	__property OnCellStyleLoad;
	__property OnCellDeletion;
	__property OnVertScrollDrawPart;
	__property OnVertScrollHintNeeded;
	__property OnHTMLImageNeeded;
	__property OnHTMLImageNeededEx;
	__property OnLinkClick;
	__property OnLinkOver;
	__property LinkCursor = {default=-21};
	__property LinkColor = {default=16711680};
	__property LinkStyle = {default=4};
	__property OnUserCellTextNeeded;
	__property OnVirtualPropsNeeded;
	__property OnVirtualTextNeeded;
	__property OnVirtualHintNeeded;
	__property OnVirtualValueNeeded;
	__property OnVirtualStyleNeeded;
	__property OnHeaderMouseDown;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property OnOleTargetDrag;
	__property OnOleTargetDrop;
	__property OnOleDragStart;
	__property OnOleDragFinish;
	__property OnAdjustControlPosition;
	__property OnControlCreated;
	__property OnTagFound;
	__property OnCtlClick;
	__property OnCtlDblClick;
	__property OnCtlMouseDown;
	__property OnCtlMouseMove;
	__property OnCtlMouseUp;
	__property FixedTopRowNum;
	__property FixedBottomRowNum;
	__property FixedColNum;
	__property GutterWidth;
	__property GutterText = {default=0};
public:
	/* TCustomElXTree.Create */ inline __fastcall virtual TElXTree(System::Classes::TComponent* AOwner) : TCustomElXTree(AOwner) { }
	/* TCustomElXTree.CreateClass */ inline __fastcall TElXTree(System::Classes::TComponent* AOwner, TElXTreeItemClass ItemClass) : TCustomElXTree(AOwner, ItemClass) { }
	/* TCustomElXTree.Destroy */ inline __fastcall virtual ~TElXTree(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXTree(HWND ParentWindow) : TCustomElXTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElXTreeDragObject : public Vcl::Controls::TDragControlObject
{
	typedef Vcl::Controls::TDragControlObject inherited;
	
public:
	virtual void __fastcall Finished(System::TObject* Target, int X, int Y, bool Accepted);
	virtual System::Uitypes::TCursor __fastcall GetDragCursor(bool Accepted, int X, int Y);
	__fastcall virtual ~TElXTreeDragObject(void);
public:
	/* TBaseDragControlObject.Create */ inline __fastcall virtual TElXTreeDragObject(Vcl::Controls::TControl* AControl) : Vcl::Controls::TDragControlObject(AControl) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 tisExpanded = System::Int8(0x8);
static const System::Int8 tisCut = System::Int8(0x4);
static const System::Int8 tisBold = System::Int8(0x10);
static const System::Int8 tisItalic = System::Int8(0x20);
static const System::Int8 tisUnderlined = System::Int8(0x40);
static const System::Byte tisStrikeout = System::Byte(0x80);
static const System::Int8 ibfParentColors = System::Int8(0x1);
static const System::Int8 ibfParentStyle = System::Int8(0x2);
static const System::Int8 ibfSuppressLines = System::Int8(0x4);
static const System::Int8 ibfForceButtons = System::Int8(0x20);
static const System::Int8 ibfStrikedOutLine = System::Int8(0x40);
static const System::Byte ibfDrawHLine = System::Byte(0x80);
static const System::Word ibfWholeLine = System::Word(0x100);
static const System::Word ibfAllowEdit = System::Word(0x200);
static const System::Word ibfUseBackGroundColor = System::Word(0x400);
static const System::Word ibfUseOwnerStyle = System::Word(0x1000);
static const int ibfSuppressButtons = int(0x10000);
static const int ibfCheckBoxEnabled = int(0x20000);
static const int ibfShowCheckBox = int(0x40000);
static const int ibfHintIsHTML = int(0x400000);
static const int ibfWordWrap = int(0x4000000);
static const System::Int8 ibfImageDrawn = System::Int8(0x8);
static const System::Int8 ibfImageDrawn2 = System::Int8(0x10);
static const System::Word ibfDeleting = System::Word(0x800);
static const System::Word ibfMultiline = System::Word(0x2000);
static const System::Word ibfHidden = System::Word(0x4000);
static const System::Word ibfEnabled = System::Word(0x8000);
static const int ibfIsHTML = int(0x80000);
static const int ibfOwnerHeight = int(0x100000);
static const int ibfRec = int(0x200000);
static const int ibfFocused = int(0x1000000);
static const int ibfExpanded = int(0x2000000);
static const System::Word TM_CLOSEINPLACEEDITOR = System::Word(0xf13);
static const System::Int8 FDivLineWidth = System::Int8(0x1);
static const System::Int8 CheckMargin = System::Int8(0x2);
static const System::Int8 CheckBoxSize = System::Int8(0xf);
static const System::Word crDragSingleNo = System::Word(0x4e21);
static const System::Word crDragSingleMove = System::Word(0x4e22);
static const System::Word crDragSingleCopy = System::Word(0x4e23);
extern DELPHI_PACKAGE System::StaticArray<int, 2> MultiLineFlags;
extern DELPHI_PACKAGE System::StaticArray<System::StaticArray<int, 2>, 2> WordWrapFlags;
extern DELPHI_PACKAGE System::StaticArray<int, 2> MultiLineEllipseFlags;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* LeafBmp;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* PlusBmp;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* MinusBmp;
extern DELPHI_PACKAGE bool __fastcall CheckIfItemIsChecked(TElXTreeItem* Item, void * SearchDetails);
}	/* namespace Elxtree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELXTREE)
using namespace Elxtree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElxtreeHPP
