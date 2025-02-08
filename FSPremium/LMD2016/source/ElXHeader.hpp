// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElXHeader.pas' rev: 31.00 (Windows)

#ifndef ElxheaderHPP
#define ElxheaderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Math.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElVCLUtils.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElHeader.hpp>
#include <ElXTreeCell.hpp>
#include <LMDObjectList.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDSysIn.hpp>
#include <LMDTypes.hpp>
#include <LMDBmp.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDProcs.hpp>
#include <LMDFiles.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <ElImgFrm.hpp>
#include <Vcl.Menus.hpp>
#include <ElIni.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elxheader
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElXHeaderSection;
class DELPHICLASS TElXHeaderSections;
class DELPHICLASS TElXCustomHeader;
class DELPHICLASS TElXHeaderCell;
class DELPHICLASS TElXHeaderCellRow;
class DELPHICLASS TElXHeader;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TElXHeaderSectionEvent)(TElXCustomHeader* Sender, TElXHeaderSection* Section);

typedef void __fastcall (__closure *TElXHeaderSectionCellEvent)(TElXCustomHeader* Sender, TElXHeaderSection* Section, TElXHeaderCell* Cell);

typedef void __fastcall (__closure *TMeasureXSectionEvent)(System::TObject* Sender, TElXHeaderSection* Section, System::Types::TPoint &Size);

typedef void __fastcall (__closure *TElXSectionRedrawEvent)(TElXCustomHeader* Sender, Vcl::Graphics::TCanvas* Canvas, TElXHeaderSection* Section, const System::Types::TRect &R, bool Pressed);

typedef void __fastcall (__closure *TElXSectionCellDrawEvent)(TElXCustomHeader* Sender, Vcl::Graphics::TCanvas* Canvas, TElXHeaderSection* Section, TElXHeaderCell* Cell, const System::Types::TRect &R, bool Pressed);

typedef void __fastcall (__closure *TElXSectionMoveEvent)(TElXCustomHeader* Sender, TElXHeaderSection* Section, int OldPos, int NewPos);

typedef void __fastcall (__closure *TElXSectionResizingEvent)(TElXCustomHeader* Sender, TElXHeaderSection* Section, Elheader::TElHResizingStates State, int Width);

typedef void __fastcall (__closure *TXSectionChangeEvent)(TElXCustomHeader* Sender, TElXHeaderSection* Section, Elheader::TSectionChangeMode Change);

typedef void __fastcall (__closure *TElXHeaderLookupEvent)(System::TObject* Sender, TElXHeaderSection* Section, Lmdtypes::TLMDString &Text);

typedef void __fastcall (__closure *TElXHeaderLookupDoneEvent)(System::TObject* Sender, TElXHeaderSection* Section, Lmdtypes::TLMDString Text, bool Accepted);

typedef void __fastcall (__closure *TXPictureNeededEvent)(TElXCustomHeader* Sender, TElXHeaderSection* Section, int &ImageIndex);

class PASCALIMPLEMENTATION TElXHeaderSection : public Elheader::TElHeaderSection
{
	typedef Elheader::TElHeaderSection inherited;
	
private:
	int FTrackedCellIndx;
	
protected:
	TElXHeaderSections* FSections;
	int FClickedCellIndx;
	int FSortedCellIndx;
	HIDESBASE void __fastcall SetParentSection(TElXHeaderSection* newValue);
	HIDESBASE TElXHeaderSection* __fastcall GetParentSection(void);
	int __fastcall GetCellIndexByY(int AY);
	virtual int __fastcall GetIndex(void);
	virtual void __fastcall SetIndex(int Value);
	virtual int __fastcall GetPosition(void);
	virtual Lmdtypes::TLMDString __fastcall GetText(void);
	virtual void __fastcall SetText(Lmdtypes::TLMDString value);
	virtual void __fastcall SetSortMode(Elheader::TElSSortMode value);
	TElXHeaderCell* __fastcall GetCell(int ARowIndex);
	virtual void __fastcall SetAlignment(Elheader::TElSAlignment value);
	
public:
	virtual void __fastcall UpdateSection(void);
	__fastcall TElXHeaderSection(TElXCustomHeader* AOwner, TElXHeaderSections* ASections);
	__fastcall virtual ~TElXHeaderSection(void);
	__property TElXHeaderCell* Cell[int ARowIndex] = {read=GetCell};
	
__published:
	__property TElXHeaderSection* ParentSection = {read=GetParentSection, write=SetParentSection};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXHeaderSections : public Elheader::TElHeaderSections
{
	typedef Elheader::TElHeaderSections inherited;
	
public:
	TElXHeaderSection* operator[](int Index) { return this->Item[Index]; }
	
protected:
	bool FIgnoreGutterState;
	virtual System::UnicodeString __fastcall GetSectionsOrder(void);
	virtual void __fastcall SetSectionsOrder(System::UnicodeString newValue);
	int __fastcall GetCellIndex(Elxtreecell::TElXCustomTreeCell* ACell);
	virtual int __fastcall GetCount(void);
	virtual Elheader::TElHeaderSection* __fastcall GetSection(int AIndex);
	virtual void __fastcall SetSection(int index, Elheader::TElHeaderSection* Section);
	virtual TElXHeaderSection* __fastcall GetXSection(int AIndex);
	virtual void __fastcall SetXSection(int index, TElXHeaderSection* Section);
	virtual Elheader::TElHeaderSection* __fastcall GetSectionByPos(int index);
	virtual TElXHeaderSection* __fastcall GetXSectionByPos(int index);
	virtual void __fastcall IntReadData(System::Classes::TStream* Stream, bool ClearCurrent);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall CellsReadData(System::Classes::TStream* Stream);
	virtual void __fastcall CellsWriteData(System::Classes::TStream* Stream);
	Lmdobjectlist::TLMDObjectList* __fastcall GetSectionList(void);
	TElXHeaderSection* __fastcall GetCustomHeaderSection(int AIndex);
	__property Lmdobjectlist::TLMDObjectList* SectionList = {read=GetSectionList};
	void __fastcall CheckJoin(int Index);
	virtual void __fastcall MoveXSection(TElXHeaderSection* ASection, int ANewPos);
	
public:
	virtual void __fastcall Clear(void);
	virtual void __fastcall SaveToFile(Lmdtypes::TLMDString FileName);
	virtual void __fastcall LoadFromFile(Lmdtypes::TLMDString FileName);
	__fastcall virtual ~TElXHeaderSections(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* source);
	HIDESBASE TElXHeaderSection* __fastcall AddSection(void);
	virtual Elheader::TElHeaderSection* __fastcall CreateSection(void);
	virtual Elheader::TElHeaderSection* __fastcall InsertSection(int AColumnIndex);
	virtual void __fastcall ClearSorting(void);
	virtual void __fastcall MoveSection(Elheader::TElHeaderSection* ASection, int ANewPos);
	__property TElXHeaderSection* Sections[int AIndex] = {read=GetCustomHeaderSection};
	__property TElXHeaderSection* ItemByPos[int Index] = {read=GetXSectionByPos};
	__property TElXHeaderSection* Item[int Index] = {read=GetXSection, write=SetXSection/*, default*/};
	virtual void __fastcall DeleteSection(Elheader::TElHeaderSection* Section);
public:
	/* TElHeaderSections.Create */ inline __fastcall TElXHeaderSections(Elheader::TCustomElHeader* AOwner) : Elheader::TElHeaderSections(AOwner) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElXCustomHeader : public Elheader::TCustomElHeader
{
	typedef Elheader::TCustomElHeader inherited;
	
protected:
	int FSectionOffset;
	Lmdobjectlist::TLMDObjectList* FRowsList;
	TMeasureXSectionEvent FOnMeasureSection;
	TElXHeaderSectionEvent FOnFilterCall;
	TElXSectionResizingEvent FOnSectionResizing;
	TXPictureNeededEvent FOnPictureNeeded;
	TElXHeaderSectionEvent FOnSectionClick;
	TElXSectionRedrawEvent FOnSectionDraw;
	TElXSectionCellDrawEvent FOnSectionCellPostDraw;
	TElXSectionCellDrawEvent FOnSectionCellDraw;
	TElXHeaderSectionEvent FOnSectionResize;
	TElXHeaderSectionEvent FOnSectionDelete;
	TElXSectionMoveEvent FOnSectionMove;
	TElXSectionMoveEvent FOnSectionReindex;
	TElXHeaderSectionEvent FOnVisibleChange;
	TXSectionChangeEvent FOnSectionChange;
	TElXHeaderSectionEvent FOnSectionCreate;
	TElXHeaderLookupEvent FOnHeaderLookup;
	TElXHeaderLookupDoneEvent FOnHeaderLookupDone;
	TElXHeaderSectionEvent FOnSectionExpand;
	TElXHeaderSectionEvent FOnSectionCollapse;
	TElXHeaderSectionEvent FOnSectionAutoSize;
	TElXHeaderSectionCellEvent FOnSectionCellClick;
	int FRowHeight;
	int FDelSectionNum;
	int FAddedSectionNum;
	virtual void __fastcall CancelOldRightAlignedOrder(void);
	int __fastcall SectionOffset(void);
	virtual void __fastcall SetFixedColNum(int Value);
	virtual int __fastcall GetFixedColNum(void);
	virtual TElXHeaderCellRow* __fastcall CreateHeaderCellRow(void);
	virtual Elheader::TElHeaderSections* __fastcall CreateSections(void);
	virtual void __fastcall SetRowHeight(int Value);
	HIDESBASE void __fastcall GetDragImage(int XPos, int YPos);
	virtual void __fastcall TriggerSectionAutoSizeEvent(Elheader::TElHeaderSection* Section);
	TElXHeaderSection* __fastcall GetPressedItem(void);
	bool __fastcall GetPressed(void);
	TElXHeaderSection* __fastcall GetDropSrc(void);
	TElXHeaderSection* __fastcall GetDropTrg(void);
	TElXHeaderSection* __fastcall GetTrackSection(void);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaImages(void);
	Lmdhtmlunit::TLMDHTMLRender* __fastcall GetRender(void);
	TElXHeaderCellRow* __fastcall GetItem(int AIndex);
	virtual void __fastcall SetRowCount(const int AValue);
	int __fastcall GetRowCount(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall RedrawSection(Vcl::Graphics::TCanvas* ACanvas, Elheader::TElHeaderSection* ASection, const System::Types::TRect &AR, int AxHOffs, bool ADithered);
	virtual void __fastcall RedrawSectionCell(Vcl::Graphics::TCanvas* ACanvas, Elheader::TElHeaderSection* ASection, const System::Types::TRect &AR, int AxHOffs, bool ADithered, int ARowIndex);
	System::Types::TRect __fastcall GetXSectionRect(int AItemNum, int SectionPos);
	virtual System::Types::TRect __fastcall GetDragSectionRect(int SectionPos);
	virtual void __fastcall RedrawSections(void);
	virtual void __fastcall InvalidateRight(int AValue);
	TElXHeaderSections* __fastcall GetSections(void);
	HIDESBASE void __fastcall SetSections(TElXHeaderSections* const Value);
	HIDESBASE bool __fastcall InResizeArea(int AX, int AY, TElXHeaderSection* &AHitSection);
	virtual void __fastcall IntLButtonDown(short XPos, short YPos);
	virtual void __fastcall IntLButtonUp(short XPos, short YPos);
	virtual void __fastcall IntMouseMove(short XPos, short YPos);
	virtual void __fastcall DoSectionMove(Elheader::TElHeaderSection* Section, int OldPos, int NewPos);
	virtual void __fastcall DoSectionReindex(Elheader::TElHeaderSection* Section, int OldIndex, int NewIndex);
	virtual void __fastcall DoSectionClick(Elheader::TElHeaderSection* Section);
	virtual void __fastcall DoSectionDraw(Vcl::Graphics::TCanvas* Canvas, Elheader::TElHeaderSection* Section, const System::Types::TRect &R, bool Pressed);
	virtual void __fastcall DoSectionCellDraw(Vcl::Graphics::TCanvas* Canvas, TElXHeaderSection* Section, TElXHeaderCell* Cell, const System::Types::TRect &R, bool Pressed);
	virtual void __fastcall DoSectionResize(Elheader::TElHeaderSection* Section);
	virtual void __fastcall DoNotifySectionChange(Elheader::TElHeaderSection* Section, Elheader::TSectionChangeMode Change);
	virtual void __fastcall DoSectionCreate(Elheader::TElHeaderSection* Section);
	virtual void __fastcall DoSectionDelete(Elheader::TElHeaderSection* Section);
	virtual void __fastcall DoVisChanged(Elheader::TElHeaderSection* Section);
	virtual void __fastcall DoSectionLookupEvent(Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text);
	virtual void __fastcall DoSectionLookupDoneEvent(Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString Text, bool Accepted);
	virtual void __fastcall DoSectionExpandEvent(Elheader::TElHeaderSection* Section);
	virtual void __fastcall DoSectionCollapseEvent(Elheader::TElHeaderSection* Section);
	virtual void __fastcall DoSectionCellClick(TElXHeaderSection* Section, TElXHeaderCell* Cell);
	virtual void __fastcall DoSectionCellPostDraw(Vcl::Graphics::TCanvas* Canvas, TElXHeaderSection* Section, TElXHeaderCell* Cell, const System::Types::TRect &R, bool Pressed);
	virtual void __fastcall RecheckMasterCells(void);
	virtual void __fastcall DoSectionResizing(Elheader::TElHeaderSection* Section, Elheader::TElHResizingStates State, int NewWidth);
	virtual void __fastcall TriggerFilterCallEvent(Elheader::TElHeaderSection* Section);
	virtual void __fastcall TriggerMeasureSectionEvent(Elheader::TElHeaderSection* Section, System::Types::TPoint &Size);
	virtual int __fastcall DoGetPicture(Elheader::TElHeaderSection* Section);
	virtual int __fastcall GetResizableWidth(void);
	virtual void __fastcall AdjustHeaderHeight(void);
	
public:
	__fastcall virtual TElXCustomHeader(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElXCustomHeader(void);
	__property TElXHeaderSections* Sections = {read=GetSections, write=SetSections};
	virtual System::Types::TRect __fastcall GetSectionRect(int SectionNum);
	virtual void __fastcall Loaded(void);
	virtual int __fastcall MeasureSectionWidth(Elheader::TElHeaderSection* Section, System::PInteger TextWidth, System::PInteger SectionHeight);
	virtual int __fastcall CalcHeaderHeight(void);
	__property Lmdobjectlist::TLMDObjectList* RowsList = {read=FRowsList};
	__property int RowCount = {read=GetRowCount, write=SetRowCount, default=1};
	__property TElXHeaderCellRow* Rows[int AIndex] = {read=GetItem};
	__property TElXHeaderSection* PressedSection = {read=GetPressedItem};
	__property bool Pressed = {read=GetPressed, nodefault};
	__property TElXHeaderSection* DropSrc = {read=GetDropSrc};
	__property TElXHeaderSection* DropTrg = {read=GetDropTrg};
	__property TElXHeaderSection* TrackSection = {read=GetTrackSection};
	__property Vcl::Imglist::TCustomImageList* AlphaImages = {read=GetAlphaImages};
	__property Lmdhtmlunit::TLMDHTMLRender* HTMLRender = {read=GetRender};
	__property TElXHeaderSectionEvent OnSectionAutoSize = {read=FOnSectionAutoSize, write=FOnSectionAutoSize};
	__property TElXHeaderSectionEvent OnSectionClick = {read=FOnSectionClick, write=FOnSectionClick};
	__property TElXSectionCellDrawEvent OnSectionCellPostDraw = {read=FOnSectionCellPostDraw, write=FOnSectionCellPostDraw};
	__property TElXSectionCellDrawEvent OnSectionCellDraw = {read=FOnSectionCellDraw, write=FOnSectionCellDraw};
	__property TElXSectionRedrawEvent OnSectionDraw = {read=FOnSectionDraw, write=FOnSectionDraw};
	__property TElXHeaderSectionEvent OnSectionResize = {read=FOnSectionResize, write=FOnSectionResize};
	__property TElXSectionResizingEvent OnSectionResizing = {read=FOnSectionResizing, write=FOnSectionResizing};
	__property TMeasureXSectionEvent OnMeasureSection = {read=FOnMeasureSection, write=FOnMeasureSection};
	__property TElXHeaderSectionEvent OnFilterCall = {read=FOnFilterCall, write=FOnFilterCall};
	__property TXPictureNeededEvent OnPictureNeeded = {read=FOnPictureNeeded, write=FOnPictureNeeded};
	__property TElXHeaderSectionEvent OnSectionDelete = {read=FOnSectionDelete, write=FOnSectionDelete};
	__property TElXSectionMoveEvent OnSectionMove = {read=FOnSectionMove, write=FOnSectionMove};
	__property TElXSectionMoveEvent OnSectionReindex = {read=FOnSectionReindex, write=FOnSectionReindex};
	__property TElXHeaderSectionEvent OnSectionShowHide = {read=FOnVisibleChange, write=FOnVisibleChange};
	__property TXSectionChangeEvent OnSectionChange = {read=FOnSectionChange, write=FOnSectionChange};
	__property TElXHeaderSectionEvent OnSectionCreate = {read=FOnSectionCreate, write=FOnSectionCreate};
	__property TElXHeaderLookupEvent OnHeaderLookup = {read=FOnHeaderLookup, write=FOnHeaderLookup};
	__property TElXHeaderLookupDoneEvent OnHeaderLookupDone = {read=FOnHeaderLookupDone, write=FOnHeaderLookupDone};
	__property TElXHeaderSectionEvent OnSectionExpand = {read=FOnSectionExpand, write=FOnSectionExpand};
	__property TElXHeaderSectionEvent OnSectionCollapse = {read=FOnSectionCollapse, write=FOnSectionCollapse};
	__property TElXHeaderSectionCellEvent OnSectionCellClick = {read=FOnSectionCellClick, write=FOnSectionCellClick};
	__property int RowHeight = {read=FRowHeight, write=SetRowHeight, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXCustomHeader(HWND ParentWindow) : Elheader::TCustomElHeader(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXHeaderCell : public Elxtreecell::TElXBaseCell
{
	typedef Elxtreecell::TElXBaseCell inherited;
	
protected:
	TElXHeaderCellRow* FOwner;
	bool FDithered;
	int FXOffset;
	TElXHeaderSection* FHeaderSection;
	int FLeft;
	int FWidth;
	int FTag;
	Elheader::TElSAlignment FAlignment;
	virtual System::Classes::TPersistent* __fastcall GetHeaderSection(void);
	virtual Lmdtypes::TLMDString __fastcall GetText(void);
	virtual int __fastcall GetIndex(void);
	virtual int __fastcall GetLeft(void);
	virtual int __fastcall GetWidth(void);
	virtual int __fastcall GetHeight(void);
	virtual void __fastcall SetText(const Lmdtypes::TLMDString AText);
	TElXHeaderCell* __fastcall GetJointCellMaster(void);
	virtual int __fastcall GetRowIndex(void);
	int __fastcall GetBottom(void);
	int __fastcall GetTop(void);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall WriteToStream(System::Classes::TStream* Stream);
	void __fastcall SetAlignment(Elheader::TElSAlignment value);
	
public:
	__fastcall TElXHeaderCell(TElXHeaderCellRow* AOwner, TElXHeaderSection* AHeaderSection);
	virtual void __fastcall Paint(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall Join(int ARowCount, int AColumnCount);
	virtual void __fastcall Split(void);
	virtual void __fastcall SmartSplit(void);
	__property int RowIndex = {read=GetRowIndex, nodefault};
	__property TElXHeaderSection* HeaderSection = {read=FHeaderSection};
	__property bool Dithered = {read=FDithered, write=FDithered, nodefault};
	__property int Left = {read=GetLeft, nodefault};
	__property int Top = {read=GetTop, nodefault};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property int Bottom = {read=GetBottom, nodefault};
	__property TElXHeaderCellRow* Owner = {read=FOwner, write=FOwner};
	__property int Height = {read=GetHeight, nodefault};
	__property int Width = {read=GetWidth, nodefault};
	__property Elheader::TElSAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Index;
	__property Text = {default=0};
	__property JointCellRole;
	__property JointRowCount;
	__property JointColumnCount;
	__property TElXHeaderCell* JointCellMaster = {read=GetJointCellMaster};
public:
	/* TElXBaseCell.Destroy */ inline __fastcall virtual ~TElXHeaderCell(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElXHeaderCellRow : public Elxtreecell::TElXBaseCellRow
{
	typedef Elxtreecell::TElXBaseCellRow inherited;
	
public:
	TElXHeaderCell* operator[](int AIndex) { return this->Cell[AIndex]; }
	
protected:
	TElXCustomHeader* FOwner;
	int FComplexHeight;
	int __fastcall CellOffset(void);
	HIDESBASE virtual TElXHeaderCell* __fastcall GetCell(int AIndex);
	virtual int __fastcall IntGetCount(void);
	void __fastcall SplitCells(void);
	TElXHeaderCell* __fastcall CreateCell(TElXHeaderSection* AHeaderSection);
	virtual int __fastcall GetHeight(void);
	virtual void __fastcall SetHeight(int newValue);
	virtual int __fastcall GetRowIndex(void);
	TElXCustomHeader* __fastcall GetHeader(void);
	
public:
	__fastcall virtual TElXHeaderCellRow(TElXCustomHeader* AOwner);
	__fastcall virtual ~TElXHeaderCellRow(void);
	virtual TElXHeaderCell* __fastcall InsertCell(int AIndex, TElXHeaderSection* AHeaderSection, bool Convert = true);
	HIDESBASE virtual int __fastcall IndexOf(TElXHeaderCell* ACell);
	virtual void __fastcall Delete(int AIndex);
	__property TElXHeaderCell* Cell[int AIndex] = {read=GetCell/*, default*/};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property int RowIndex = {read=GetRowIndex, nodefault};
	__property Count;
};


class PASCALIMPLEMENTATION TElXHeader : public TElXCustomHeader
{
	typedef TElXCustomHeader inherited;
	
__published:
	__property RowCount = {default=1};
	__property RowHeight;
	__property Owner;
	__property ActiveFilterColor = {default=0};
	__property AllowDrag = {default=1};
	__property Align = {default=1};
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
	__property Sections;
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
	__property OnSectionResizing;
	__property OnMeasureSection;
	__property OnSectionClick;
	__property OnSectionResize;
	__property OnSectionDraw;
	__property OnSectionDelete;
	__property OnSectionMove;
	__property OnSectionShowHide;
	__property OnPictureNeeded;
	__property OnSectionChange;
	__property OnSectionCreate;
	__property OnSectionExpand;
	__property OnSectionCollapse;
	__property OnHeaderLookup;
	__property OnHeaderLookupDone;
	__property OnSectionCellClick;
	__property OnSectionCellDraw;
	__property OnSectionCellPostDraw;
	__property OnHTMLImageNeeded;
	__property OnHTMLImageNeededEx;
	__property OnSectionAutoSize;
	__property OnFilterCall;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TElXCustomHeader.Create */ inline __fastcall virtual TElXHeader(System::Classes::TComponent* AOwner) : TElXCustomHeader(AOwner) { }
	/* TElXCustomHeader.Destroy */ inline __fastcall virtual ~TElXHeader(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXHeader(HWND ParentWindow) : TElXCustomHeader(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elxheader */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELXHEADER)
using namespace Elxheader;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElxheaderHPP
