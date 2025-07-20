// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tree.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_TreeHPP
#define Fmxtee_TreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.Types.hpp>
#include <FMX.Memo.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Printer.hpp>
#include <FMX.Platform.hpp>
#include <FMX.Controls.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>
#include <System.Generics.Defaults.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomTree;
class DELPHICLASS TTreeStrings;
class DELPHICLASS TCustomTreeElement;
class DELPHICLASS TTreeShapeAutoPosition;
class DELPHICLASS TTreeShapeBrush;
class DELPHICLASS TTreeList;
class DELPHICLASS TNodeShapeList;
class DELPHICLASS TNodeConnectionList;
class DELPHICLASS TTreeConnectionList;
class DELPHICLASS TTreePicture;
class DELPHICLASS TTreeNodeShape;
class DELPHICLASS TConnectionArrowBrush;
struct TConnectionPoint;
class DELPHICLASS TConnectionPoints;
class DELPHICLASS TConnectionArrow;
class DELPHICLASS TConnectionArrowFrom;
class DELPHICLASS TConnectionArrowTo;
class DELPHICLASS TTreeConnectionPen;
class DELPHICLASS TConnectionFormat;
class DELPHICLASS TTreeConnection;
class DELPHICLASS TTreeSelectedPen;
class DELPHICLASS TTreeHiddenPen;
class DELPHICLASS TSelectedShapeList;
class DELPHICLASS TTreeCrossBoxPen;
class DELPHICLASS TTreeNodeCrossBox;
struct TTreeEvents;
class DELPHICLASS TTeeScrollBar;
class DELPHICLASS TTreeShapeList;
class DELPHICLASS TChildManager;
class DELPHICLASS TTreeExplorerAlignChild;
class DELPHICLASS TTeeHotTrackFont;
class DELPHICLASS TTreeHotTrack;
struct TTreeGlobal;
class DELPHICLASS TGridPen;
class DELPHICLASS TGridBigPen;
class DELPHICLASS TTreeGrid;
class DELPHICLASS TTreePageBorder;
class DELPHICLASS TTreePage;
class DELPHICLASS TCustomTreeShape;
class DELPHICLASS TPointItem;
class DELPHICLASS TPointCollection;
class DELPHICLASS TPolygonShape;
class DELPHICLASS TPolyLineShape;
class DELPHICLASS TImageShape;
class DELPHICLASS TTextShape;
class DELPHICLASS TTreeDragDrop;
class DELPHICLASS TTreeTextEditor;
class DELPHICLASS TTreeAfterDrawEvent;
struct TTreeZoomDefault;
class DELPHICLASS TImageList;
class DELPHICLASS TTree;
class DELPHICLASS TTreeClipboard;
class DELPHICLASS TTreeCustomPolygonShape;
class DELPHICLASS TImageLevels;
class DELPHICLASS TCustomTreeLink;
class DELPHICLASS TCustomPanelTreeLink;
class DELPHICLASS TTreeRuler;
class DELPHICLASS TTreeImagePool;
//-- type declarations -------------------------------------------------------
typedef TCustomTree TCustomTreePanel;

typedef void __fastcall (__closure *TTreeClick)(TCustomTree* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);

enum DECLSPEC_DENUM THorizTextAlign : unsigned char { htaCenter, htaLeft, htaRight };

class PASCALIMPLEMENTATION TTreeStrings : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	int FAngle;
	bool FClipText;
	THorizTextAlign FHorizAlign;
	int FHorizOffset;
	Fmxtee::Canvas::TTeeTransparency FTransparency;
	Fmxtee::Procs::TVertTextAlign FVertAlign;
	int FVertOffset;
	bool FVisible;
	TCustomTreeElement* IOwner;
	void __fastcall SetAngle(const int Value);
	void __fastcall SetClipText(const bool Value);
	void __fastcall SetHorizAlign(const THorizTextAlign Value);
	void __fastcall SetHorizOffset(const int Value);
	void __fastcall SetTransparency(const Fmxtee::Canvas::TTeeTransparency Value);
	void __fastcall SetVertAlign(const Fmxtee::Procs::TVertTextAlign Value);
	void __fastcall SetVertOffset(const int Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TTreeStrings();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int Angle = {read=FAngle, write=SetAngle, default=0};
	__property bool ClipText = {read=FClipText, write=SetClipText, default=0};
	__property THorizTextAlign HorizAlign = {read=FHorizAlign, write=SetHorizAlign, default=0};
	__property int HorizOffset = {read=FHorizOffset, write=SetHorizOffset, default=0};
	__property Fmxtee::Canvas::TTeeTransparency Transparency = {read=FTransparency, write=SetTransparency, default=0};
	__property Fmxtee::Procs::TVertTextAlign VertAlign = {read=FVertAlign, write=SetVertAlign, default=0};
	__property int VertOffset = {read=FVertOffset, write=SetVertOffset, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
public:
	/* TStringList.Destroy */ inline __fastcall virtual ~TTreeStrings() { }
	
};


class PASCALIMPLEMENTATION TCustomTreeElement : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::Uitypes::TCursor FCursor;
	void *FData;
	Fmxtee::Canvas::TTeeFont* FFont;
	System::TObject* FTagObject;
	System::UnicodeString FTextString;
	Fmxtee::Canvas::TTeeFont* __fastcall GetFont();
	TTreeStrings* __fastcall GetText();
	Fmxtee::Canvas::TTeeFont* __fastcall InternalFont();
	void __fastcall SetCursor(System::Uitypes::TCursor Value);
	void __fastcall SetFont(Fmxtee::Canvas::TTeeFont* const Value);
	void __fastcall SetHorizTextAlign(THorizTextAlign Value);
	void __fastcall SetVertTextAlign(Fmxtee::Procs::TVertTextAlign Value);
	System::UnicodeString __fastcall GetSimpleText();
	void __fastcall SetSimpleText(const System::UnicodeString Value);
	bool __fastcall IsFontStored();
	THorizTextAlign __fastcall GetHorizTextAlign();
	Fmxtee::Procs::TVertTextAlign __fastcall GetVertTextAlign();
	void __fastcall ReadHorizAlign(System::Classes::TReader* Reader);
	void __fastcall ReadVertAlign(System::Classes::TReader* Reader);
	
protected:
	TTreeStrings* FText;
	TCustomTree* FTree;
	virtual void __fastcall CanvasChanged(System::TObject* Sender);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner();
	void __fastcall InternalDrawHandles();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	void __fastcall SetBooleanProperty(bool &Variable, const bool Value);
	void __fastcall SetColorProperty(System::Uitypes::TAlphaColor &Variable, const System::Uitypes::TAlphaColor Value);
	void __fastcall SetDoubleProperty(double &Variable, const double Value);
	void __fastcall SetIntegerProperty(int &Variable, const int Value);
	DYNAMIC void __fastcall SetParentComponent(System::Classes::TComponent* AParent);
	void __fastcall SetText(TTreeStrings* const Value);
	virtual void __fastcall SetTree(TCustomTree* const Value);
	int __fastcall TextLinesCount();
	
public:
	__fastcall virtual ~TCustomTreeElement();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC void __fastcall DrawHandles();
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent();
	DYNAMIC bool __fastcall HasParent();
	void __fastcall Repaint();
	__property System::UnicodeString SimpleText = {read=GetSimpleText, write=SetSimpleText};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=0};
	__property void * Data = {read=FData, write=FData};
	__property Fmxtee::Canvas::TTeeFont* Font = {read=GetFont, write=SetFont, stored=IsFontStored};
	__property THorizTextAlign HorizTextAlign = {read=GetHorizTextAlign, write=SetHorizTextAlign, nodefault};
	__property System::TObject* TagObject = {read=FTagObject, write=FTagObject};
	__property TTreeStrings* Text = {read=GetText, write=SetText};
	__property TCustomTree* Tree = {read=FTree, write=SetTree, stored=false};
	__property Fmxtee::Procs::TVertTextAlign VertTextAlign = {read=GetVertTextAlign, write=SetVertTextAlign, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TCustomTreeElement(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	
};


typedef System::StaticArray<System::Types::TPointF, 16> TRoundRectanglePoint;

typedef Fmxtee::Canvas::TTeeGradient TShapeGradient;

typedef Fmxtee::Canvas::TTeePen TTreePen;

class PASCALIMPLEMENTATION TTreeShapeAutoPosition : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FNoLeft;
	bool FNoTop;
	System::Classes::TNotifyEvent IOnChange;
	bool __fastcall GetLeft();
	bool __fastcall GetTop();
	void __fastcall SetLeft(bool Value);
	void __fastcall SetTop(bool Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Left = {read=GetLeft, write=SetLeft, stored=false, nodefault};
	__property bool Top = {read=GetTop, write=SetTop, stored=false, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTreeShapeAutoPosition() { }
	
public:
	/* TObject.Create */ inline __fastcall TTreeShapeAutoPosition() : System::Classes::TPersistent() { }
	
};


typedef System::TMetaClass* TTreeConnectionClass;

typedef Fmxtee::Canvas::TTeeBrush TTreeBrush;

class PASCALIMPLEMENTATION TTreeShapeBrush : public Fmxtee::Canvas::TTeeBrush
{
	typedef Fmxtee::Canvas::TTeeBrush inherited;
	
public:
	__fastcall virtual TTreeShapeBrush(const System::Classes::TNotifyEvent Changed);
	
__published:
	__property Color = {default=-1};
public:
	/* TTeeBrush.Destroy */ inline __fastcall virtual ~TTreeShapeBrush() { }
	
};


typedef System::StaticArray<System::Types::TPointF, 100> TShapePoints;

typedef System::TMetaClass* TTreeNodeShapeClass;

typedef void __fastcall (__closure *TNodeListForEachProc)(TTreeNodeShape* Sender);

typedef System::StaticArray<void *, 134217727> TPointerList;

typedef TPointerList *PPointerList;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeList : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TPointerList *FList;
	int FCount;
	int FCapacity;
	int IDelta;
	
protected:
	void __fastcall SetCapacity(int NewCapacity);
	void __fastcall SetCount(int NewCount);
	int __fastcall Add(System::TObject* const Item);
	void __fastcall Clear();
	void __fastcall Delete(int Index);
	void __fastcall Exchange(int Index1, int Index2);
	void __fastcall Insert(int Index, System::TObject* const Item);
	void __fastcall Move(int CurIndex, int NewIndex);
	int __fastcall Remove(System::TObject* const Item);
	__property int Capacity = {read=FCapacity, write=SetCapacity, nodefault};
	__property PPointerList List = {read=FList};
	
public:
	__fastcall virtual ~TTreeList();
	__property int Count = {read=FCount, write=SetCount, nodefault};
	int __fastcall IndexOf(System::TObject* const Item);
public:
	/* TObject.Create */ inline __fastcall TTreeList() : System::TObject() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TNodeShapeList : public TTreeList
{
	typedef TTreeList inherited;
	
public:
	TTreeNodeShape* operator[](int Index) { return this->Items[Index]; }
	
private:
	TCustomTree* ITree;
	TTreeNodeShape* __fastcall GetShape(int Index);
	
public:
	HIDESBASE int __fastcall Add(TTreeNodeShape* const Node);
	TTreeNodeShape* __fastcall Clicked(int x, int y);
	TTreeNodeShape* __fastcall Find(const System::UnicodeString S, bool Partial = false);
	TTreeNodeShape* __fastcall FindObject(System::TObject* const Value);
	TTreeNodeShape* __fastcall First();
	void __fastcall ForEach(const TNodeListForEachProc Proc);
	TTreeNodeShape* __fastcall Last();
	void __fastcall Sort(bool AscendingOrder, bool IgnoreCase);
	__property TTreeNodeShape* Items[int Index] = {read=GetShape/*, default*/};
public:
	/* TTreeList.Destroy */ inline __fastcall virtual ~TNodeShapeList() { }
	
public:
	/* TObject.Create */ inline __fastcall TNodeShapeList() : TTreeList() { }
	
};

#pragma pack(pop)

typedef TNodeShapeList TTreeChildrenList;

typedef void __fastcall (__closure *TConnListForEachProc)(TTreeConnection* Sender);

typedef void __fastcall (__closure *TDeleteConnectionEvent)(TTreeConnection* Sender, bool &AllowDelete);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TNodeConnectionList : public TTreeList
{
	typedef TTreeList inherited;
	
public:
	TTreeConnection* operator[](int Index) { return this->Items[Index]; }
	
private:
	bool FVisible;
	TTreeConnection* __fastcall GetConnection(int Index);
	void __fastcall SetVisible(bool Value);
	
public:
	TTreeConnection* __fastcall Clicked(int x, int y);
	virtual bool __fastcall DeleteConnection(TTreeConnection* const AConnection);
	void __fastcall DeleteAllTo(TTreeNodeShape* const AShape);
	void __fastcall ForEach(const TConnListForEachProc Proc);
	TTreeConnection* __fastcall ToShape(TTreeNodeShape* const AShape);
	__property TTreeConnection* Items[int Index] = {read=GetConnection/*, default*/};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
public:
	/* TTreeList.Destroy */ inline __fastcall virtual ~TNodeConnectionList() { }
	
public:
	/* TObject.Create */ inline __fastcall TNodeConnectionList() : TTreeList() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TTreeShapeHandle : unsigned char { rcNone, rcLeftTop, rcRightBottom, rcLeftBottom, rcRightTop, rcLeft, rcTop, rcRight, rcBottom, rcCustom };

class PASCALIMPLEMENTATION TTreeConnectionList : public TNodeConnectionList
{
	typedef TNodeConnectionList inherited;
	
private:
	TTreeConnectionPen* FControlVector;
	TTreeShapeHandle FMagneticHandle;
	System::Types::TPointF FMagneticPos;
	TDeleteConnectionEvent FOnDeleting;
	TTreeConnection* FSelected;
	TCustomTree* ITree;
	void __fastcall DrawMagnetic();
	void __fastcall SetSelected(TTreeConnection* const Value);
	
public:
	__fastcall TTreeConnectionList();
	__fastcall virtual ~TTreeConnectionList();
	virtual bool __fastcall DeleteConnection(TTreeConnection* const AConnection);
	__property TTreeConnectionPen* ControlVector = {read=FControlVector, write=FControlVector};
	__property TTreeConnection* Selected = {read=FSelected, write=SetSelected};
	__property TDeleteConnectionEvent OnDeleting = {read=FOnDeleting, write=FOnDeleting};
};


enum DECLSPEC_DENUM TTreeNodeImageIndex : unsigned char { tiNone, tiFolderClose, tiFolderOpen, tiDesktop, tiMyPC, tiNetworkNei, tiFloppy3, tiRecycleBin, tiHardDisk, tiNetShare, tiComputer, tiWorld, tiFolderOpenClose, tiFolderCloseChecked, tiFolderCloseUnChecked, tiChecked, tiUnChecked, tiRadioChecked, tiRadioUnChecked, tiFolderRadioChecked, tiFolderRadioUnChecked };

enum DECLSPEC_DENUM TTreeNodeShapeShowCross : unsigned char { scAuto, scAlways, scNever };

typedef void __fastcall (__closure *TClickShapeEvent)(TTreeNodeShape* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);

typedef void __fastcall (__closure *TMouseShapeEvent)(TTreeNodeShape* Sender, System::Classes::TShiftState Shift, int X, int Y);

enum DECLSPEC_DENUM TTreeImageAlignment : unsigned char { iaAutomatic, iaLeftTop, iaRightBottom, iaLeftBottom, iaRightTop, iaLeft, iaTop, iaRight, iaBottom, iaCenter };

class PASCALIMPLEMENTATION TTreePicture : public Fmxtee::Canvas::TTeePicture
{
	typedef Fmxtee::Canvas::TTeePicture inherited;
	
private:
	bool __fastcall GetTransp();
	void __fastcall SetTransp(const bool Value);
	
__published:
	__property bool Transparent = {read=GetTransp, write=SetTransp, default=0};
public:
	/* TTeePicture.Destroy */ inline __fastcall virtual ~TTreePicture() { }
	
public:
	/* TPicture.Create */ inline __fastcall TTreePicture() : Fmxtee::Canvas::TTeePicture() { }
	
public:
	/* TBitmap.CreateFromStream */ inline __fastcall virtual TTreePicture(System::Classes::TStream* const AStream) : Fmxtee::Canvas::TTeePicture(AStream) { }
	/* TBitmap.CreateFromFile */ inline __fastcall virtual TTreePicture(const System::UnicodeString AFileName) : Fmxtee::Canvas::TTeePicture(AFileName) { }
	/* TBitmap.CreateFromBitmapAndMask */ inline __fastcall TTreePicture(Fmx::Graphics::TBitmap* const Bitmap, Fmx::Graphics::TBitmap* const Mask) : Fmxtee::Canvas::TTeePicture(Bitmap, Mask) { }
	
};


enum DECLSPEC_DENUM TTreeShapeStyle : unsigned char { tssRectangle, tssCircle, tssVertLine, tssHorizLine, tssLine, tssInvertLine, tssDiamond, tssTriangleTop, tssTriangleBottom, tssTriangleLeft, tssTriangleRight, tssRoundRectangle, tssCustom, tssChamfer };

class PASCALIMPLEMENTATION TTreeNodeShape : public TCustomTreeElement
{
	typedef TCustomTreeElement inherited;
	
private:
	System::Types::TRectF FAdjustedRect;
	bool FAutoSize;
	TTreeShapeAutoPosition* FAutoPosition;
	Fmxtee::Canvas::TTeePen* FBorder;
	TTreeShapeBrush* FBrush;
	Fmxtee::Canvas::TTeeGradient* FGradient;
	bool FGradientClip;
	TTreePicture* FImage;
	TTreeImageAlignment FImageAlignment;
	int FImageHeight;
	System::Types::TRectF FImageRect;
	int FImageWidth;
	TTreeNodeImageIndex FImageIndex;
	int FImageListIndex;
	int FRoundSize;
	Fmxtee::Canvas::TTeeShadow* FShadow;
	TTreeShapeStyle FStyle;
	Fmxtee::Canvas::TTeeTransparency FTransparency;
	bool FTransparent;
	bool FVisible;
	int FX0;
	int FY0;
	int FX1;
	int FY1;
	int FBrotherIndex;
	TNodeShapeList* FChildren;
	TNodeConnectionList* FConnections;
	bool FExpanded;
	TTreeNodeShape* FParent;
	TNodeShapeList* FParents;
	TTreeNodeShapeShowCross FShowCross;
	TClickShapeEvent FOnClick;
	TClickShapeEvent FOnDblClick;
	TMouseShapeEvent FOnMouseEnter;
	TMouseShapeEvent FOnMouseLeave;
	TMouseShapeEvent FOnMouseMove;
	int IImageHeight;
	int IImageWidth;
	bool IMouseInside;
	TTreeNodeShape* IParents0;
	void __fastcall ChangeTreeRecursive(TCustomTree* const NewTree);
	void __fastcall DoMove(int DeltaX, int DeltaY, bool AltShift);
	System::Types::TRectF __fastcall Get3DRectangle();
	TTreeShapeAutoPosition* __fastcall GetAutoPosition();
	System::Uitypes::TAlphaColor __fastcall GetBackColor();
	Fmxtee::Canvas::TTeePen* __fastcall GetBorder();
	bool __fastcall GetChecked();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	Fmxtee::Canvas::TTeeShadow* __fastcall GetShadow();
	void __fastcall GetTrianglePoints(const System::Types::TRectF &R, const float MidX, const float MidY, TShapePoints &P);
	TTreeShapeBrush* __fastcall InternalBrush();
	bool __fastcall InternalClipText();
	virtual void __fastcall InternalDrawShadow(const System::Types::TRectF &tmpR, Fmxtee::Canvas::TCanvas3D* const ACanvas, const TTreeShapeStyle tmpStyle);
	void __fastcall InternalDrawShape(const System::Types::TRectF &tmpR, Fmxtee::Canvas::TCanvas3D* const ACanvas, TTreeShapeStyle tmpStyle);
	Fmxtee::Canvas::TTeePen* __fastcall InternalPen();
	void __fastcall InternalSetImage(Fmxtee::Canvas::TPicture* const Value);
	int __fastcall InternalTextAngle();
	bool __fastcall IsSizeStored();
	bool __fastcall IsVisible();
	void __fastcall PositionChanged(System::TObject* Sender);
	void __fastcall SetAutoPosition(TTreeShapeAutoPosition* const Value);
	void __fastcall SetAutoSize(bool Value);
	void __fastcall SetBackColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetBorder(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetBrush(TTreeShapeBrush* const Value);
	void __fastcall SetImageAlignment(TTreeImageAlignment Value);
	void __fastcall SetImageHeight(int Value);
	void __fastcall SetImageWidth(int Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetGradientClip(bool Value);
	void __fastcall SetRoundSize(const int Value);
	void __fastcall SetShadow(Fmxtee::Canvas::TTeeShadow* const Value);
	void __fastcall SetStyle(const TTreeShapeStyle Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetX0(int Value);
	void __fastcall SetX1(int Value);
	void __fastcall SetY0(int Value);
	void __fastcall SetY1(int Value);
	int __fastcall GetHeight();
	int __fastcall GetWidth();
	void __fastcall SetHeight(const int Value);
	void __fastcall SetTransparency(const Fmxtee::Canvas::TTeeTransparency Value);
	void __fastcall SetWidth(const int Value);
	System::Uitypes::TAlphaColor __fastcall GetColor();
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetImageListIndex(const int Value);
	void __fastcall SetExpanded(bool Value);
	TTreeNodeShape* __fastcall GetPreviousBrother();
	TTreeNodeShape* __fastcall GetRoot();
	TTreeConnection* __fastcall InternalAddConnection(TTreeNodeShape* const AToShape);
	bool __fastcall IsImageStored();
	bool __fastcall IsPositionLeftStored();
	bool __fastcall IsPositionTopStored();
	void __fastcall RemoveChild(TTreeNodeShape* const AShape);
	void __fastcall SetImageIndex(TTreeNodeImageIndex Value);
	void __fastcall SetParent(TTreeNodeShape* const Value);
	void __fastcall SetShowCross(TTreeNodeShapeShowCross Value);
	int __fastcall GetX1();
	int __fastcall GetY1();
	TNodeShapeList* __fastcall GetChildNodes();
	TNodeConnectionList* __fastcall GetConnections();
	TNodeShapeList* __fastcall GetParents();
	void __fastcall SetBrotherIndex(const int Value);
	void __fastcall SetChecked(bool Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	bool __fastcall IsBorderStored();
	bool __fastcall IsBrushStored();
	bool __fastcall IsGradientStored();
	bool __fastcall IsShadowStored();
	bool __fastcall IsImageIndexStored();
	
protected:
	bool IAutoSized;
	bool FSelected;
	virtual void __fastcall CanvasChanged(System::TObject* Sender);
	void __fastcall ChangeAutoSize(bool Value);
	DYNAMIC void __fastcall DoClick(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int x, int y);
	DYNAMIC void __fastcall DoDrawHandle(TTreeShapeHandle Handle, int &x, int &y, bool &Draw);
	void __fastcall DrawGradient(const System::Types::TRectF &Rect, Fmxtee::Canvas::TCanvas3D* const ACanvas);
	void __fastcall DrawImage();
	void __fastcall DrawShape(const System::Types::TRectF &R);
	virtual void __fastcall DrawShapeCanvas(Fmxtee::Canvas::TCanvas3D* const ACanvas, const System::Types::TRectF &R);
	void __fastcall DrawSelectionFocus();
	void __fastcall DrawText(Fmxtee::Canvas::TCanvas3D* const ACanvas, System::Types::TRectF &R);
	void __fastcall RecalcImageSize();
	TTreeShapeBrush* __fastcall GetBrush();
	DYNAMIC void __fastcall GetConnectionTo(const float pX0, const float pY0, const float pX1, const float pY1, float &AX, float &AY);
	DYNAMIC TTreeNodeShape* __fastcall GetEditedShape();
	DYNAMIC System::Uitypes::TCursor __fastcall GetHandleCursor(int x, int y);
	int __fastcall GetRoundRectanglePoints(const System::Types::TRectF &R, TShapePoints &P);
	virtual int __fastcall GetShapePoints(const System::Types::TRectF &R, TShapePoints &P);
	bool __fastcall HasCheckBox();
	void __fastcall PictureChanged(System::TObject* Sender);
	System::Types::TRectF __fastcall RectTo3DCanvas(Fmxtee::Canvas::TCanvas3D* const ACanvas, const System::Types::TRectF &R);
	void __fastcall SetBounds(const System::Types::TRectF &R);
	void __fastcall SetCanvasFont(Fmxtee::Canvas::TCanvas3D* const ACanvas);
	void __fastcall SetImage(TTreePicture* const Value);
	virtual void __fastcall SetSelected(bool Value);
	virtual void __fastcall SetTree(TCustomTree* const Value);
	bool __fastcall ShouldDrawCross();
	bool __fastcall AutoPositionLeft();
	bool __fastcall AutoPositionTop();
	int __fastcall DoExpandCollapse(bool Value);
	void __fastcall DoMouseEnter(System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoMouseLeave(System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoMouseMove(System::Classes::TShiftState Shift, int X, int Y);
	int __fastcall RecursiveCountExpanded();
	
public:
	__fastcall virtual TTreeNodeShape(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTreeNodeShape();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall AssignFormat(TTreeNodeShape* const ANode);
	__property System::Types::TRectF AdjustedRectangle = {read=FAdjustedRect};
	System::Types::TRectF __fastcall Bounds();
	void __fastcall Clear();
	virtual bool __fastcall Clicked(const int x, const int y)/* overload */;
	virtual bool __fastcall Clicked(const float x, const float y)/* overload */;
	bool __fastcall ClickedImage(float x, float y)/* overload */;
	bool __fastcall ClickedImage(int x, int y)/* overload */;
	void __fastcall Collapse(bool Recursive);
	int __fastcall Count();
	virtual void __fastcall Draw();
	DYNAMIC void __fastcall DrawHandles();
	void __fastcall GetConnectionPos(TTreeNodeShape* const AShape, float &AX, float &AY);
	TTreePicture* __fastcall GetImage();
	Fmxtee::Canvas::TPicture* __fastcall GetPicture();
	DYNAMIC TTreeShapeHandle __fastcall GetResizingHandle(int x, int y);
	bool __fastcall InsideTreeBounds();
	virtual void __fastcall RecalcSize(Fmxtee::Canvas::TCanvas3D* const ACanvas);
	float __fastcall XCenter();
	float __fastcall YCenter();
	TTreeNodeShape* __fastcall Add(const System::UnicodeString AText);
	TTreeNodeShape* __fastcall AddBrother(const System::UnicodeString AText);
	TTreeNodeShape* __fastcall AddChild(const System::UnicodeString AText);
	TTreeNodeShape* __fastcall AddChildFirst(const System::UnicodeString AText);
	TTreeNodeShape* __fastcall AddChildObject(const System::UnicodeString AText, const void * Data);
	TTreeConnection* __fastcall AddConnection(TTreeNodeShape* const AToShape);
	TTreeConnection* __fastcall AddConnectionObject(TTreeNodeShape* const AToShape, const void * Data);
	void __fastcall BringToFront();
	System::Types::TPointF __fastcall CalcXYCross(TTreeNodeShape* const AParent);
	bool __fastcall CrossBoxClicked(int x, int y);
	bool __fastcall DoDraw();
	bool __fastcall HasChilds();
	bool __fastcall HasChildren();
	void __fastcall Hide();
	HIDESBASE TTreeNodeShape* __fastcall Insert(int Index, const System::UnicodeString AText);
	int __fastcall Level();
	float __fastcall MaxHeightExpandedChilds();
	float __fastcall MinHeightExpandedChilds();
	DYNAMIC void __fastcall MoveRelative(int OfsX, int OfsY, bool MoveChilds);
	void __fastcall ReCalcPositions(int ABrotherIndex);
	DYNAMIC void __fastcall Resize(TTreeShapeHandle ACorner, int DeltaX, int DeltaY);
	void __fastcall SaveToTextFile(const System::UnicodeString FileName);
	void __fastcall SelectChilds();
	void __fastcall SendToBack();
	void __fastcall Show();
	void __fastcall SortChildsText(bool AscendingOrder, bool IgnoreCase);
	void __fastcall Toogle _DEPRECATED_ATTRIBUTE0 ();
	void __fastcall Toggle();
	void __fastcall ToggleCheck();
	__property int BrotherIndex = {read=FBrotherIndex, write=SetBrotherIndex, nodefault};
	__property TNodeShapeList* Children = {read=GetChildNodes};
	__property TNodeShapeList* Childs = {read=GetChildNodes};
	__property TNodeConnectionList* Connections = {read=GetConnections};
	__property TNodeShapeList* Parents = {read=GetParents};
	__property TTreeNodeShape* PreviousBrother = {read=GetPreviousBrother};
	__property TTreeNodeShape* Root = {read=GetRoot};
	__property bool Selected = {read=FSelected, write=SetSelected, default=0};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property System::Types::TRectF ImageRect = {read=FImageRect};
	__property int Left = {read=FX0, write=SetLeft, nodefault};
	__property int Top = {read=FY0, write=SetTop, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
	
__published:
	__property TTreeShapeAutoPosition* AutoPosition = {read=GetAutoPosition, write=SetAutoPosition};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property System::Uitypes::TAlphaColor BackColor = {read=GetBackColor, write=SetBackColor, default=0};
	__property Fmxtee::Canvas::TTeePen* Border = {read=GetBorder, write=SetBorder, stored=IsBorderStored};
	__property TTreeShapeBrush* Brush = {read=GetBrush, write=SetBrush, stored=IsBrushStored};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property System::Uitypes::TAlphaColor Color = {read=GetColor, write=SetColor, default=-1};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient, stored=IsGradientStored};
	__property bool GradientClip = {read=FGradientClip, write=SetGradientClip, default=1};
	__property TTreePicture* Image = {read=GetImage, write=SetImage, stored=IsImageStored};
	__property TTreeImageAlignment ImageAlignment = {read=FImageAlignment, write=SetImageAlignment, default=0};
	__property int ImageHeight = {read=FImageHeight, write=SetImageHeight, default=0};
	__property int ImageWidth = {read=FImageWidth, write=SetImageWidth, default=0};
	__property int RoundSize = {read=FRoundSize, write=SetRoundSize, default=3};
	__property Fmxtee::Canvas::TTeeShadow* Shadow = {read=GetShadow, write=SetShadow, stored=IsShadowStored};
	__property TTreeShapeStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Fmxtee::Canvas::TTeeTransparency Transparency = {read=FTransparency, write=SetTransparency, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int X0 = {read=FX0, write=SetX0, stored=IsPositionLeftStored, nodefault};
	__property int X1 = {read=GetX1, write=SetX1, stored=IsSizeStored, nodefault};
	__property int Y0 = {read=FY0, write=SetY0, stored=IsPositionTopStored, nodefault};
	__property int Y1 = {read=GetY1, write=SetY1, stored=IsSizeStored, nodefault};
	__property Cursor = {default=0};
	__property Font;
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=0};
	__property TTreeNodeImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, nodefault};
	__property int ImageListIndex = {read=FImageListIndex, write=SetImageListIndex, default=-1};
	__property TTreeNodeShape* Parent = {read=FParent, write=SetParent};
	__property TTreeNodeShapeShowCross ShowCross = {read=FShowCross, write=SetShowCross, default=0};
	__property Text;
	__property TClickShapeEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TClickShapeEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property TMouseShapeEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property TMouseShapeEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property TMouseShapeEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
};


typedef void __fastcall (__closure *TExpandingCollapsingEvent)(TTreeNodeShape* Sender, bool &Expand);

enum DECLSPEC_DENUM TConnectionArrowStyle : unsigned char { casNone, casSolid, casLines, casSquare, casCircle, casDiamond };

class PASCALIMPLEMENTATION TConnectionArrowBrush : public Fmxtee::Canvas::TTeeBrush
{
	typedef Fmxtee::Canvas::TTeeBrush inherited;
	
__published:
	__property Color = {default=-16777216};
public:
	/* TTeeBrush.Create */ inline __fastcall virtual TConnectionArrowBrush(const System::Classes::TNotifyEvent OnChangeEvent) : Fmxtee::Canvas::TTeeBrush(OnChangeEvent) { }
	/* TTeeBrush.Destroy */ inline __fastcall virtual ~TConnectionArrowBrush() { }
	
};


enum DECLSPEC_DENUM TConnectionPointStyle : unsigned char { cpsAutoFrom, cpsAutoTo, cpsFromPercent, cpsToPercent, cpsFromRel, cpsToRel, cpsPrevious, cpsNext, cpsFixed };

struct DECLSPEC_DRECORD TConnectionPoint
{
public:
	TConnectionPointStyle XStyle;
	TConnectionPointStyle YStyle;
	float XValue;
	float YValue;
	float X;
	float Y;
};


typedef System::DynamicArray<TConnectionPoint> TConnectionPointArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TConnectionPoints : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TTreeConnection* IConnection;
	void __fastcall RemoveAuto();
	
public:
	TConnectionPointArray Item;
	int __fastcall Add(const System::Types::TPointF &P)/* overload */;
	int __fastcall Add(int Ax, int Ay)/* overload */;
	int __fastcall Add(TConnectionPointStyle AXStyle, int Ax, TConnectionPointStyle AYStyle, int Ay)/* overload */;
	int __fastcall AddFromPrevious(int XOffset, int YOffset);
	void __fastcall CalculatePosition(int Index);
	void __fastcall ChangeXStyle(int Index, TConnectionPointStyle AStyle);
	void __fastcall ChangeYStyle(int Index, TConnectionPointStyle AStyle);
	void __fastcall Clear();
	int __fastcall Clicked(int x, int y);
	int __fastcall Count();
	void __fastcall Delete(int Index);
	void __fastcall Insert(int Index, int x, int y);
	void __fastcall Move(int Index, int DeltaX, int DeltaY);
public:
	/* TObject.Create */ inline __fastcall TConnectionPoints() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TConnectionPoints() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TConnectionArrow : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FBorder;
	TConnectionArrowBrush* FBrush;
	int FSize;
	TConnectionArrowStyle FStyle;
	TTreeConnection* IOwner;
	System::Uitypes::TAlphaColor __fastcall GetBackColor();
	Fmxtee::Canvas::TTeePen* __fastcall GetBorder();
	TConnectionArrowBrush* __fastcall GetBrush();
	void __fastcall SetBorder(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetBrush(TConnectionArrowBrush* const Value);
	void __fastcall SetSize(int Value);
	void __fastcall SetStyle(const TConnectionArrowStyle Value);
	void __fastcall SetBackColor(const System::Uitypes::TAlphaColor Value);
	
public:
	__fastcall virtual TConnectionArrow(TTreeConnection* const AOwner);
	__fastcall virtual ~TConnectionArrow();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Draw(const TConnectionPoint &Point, int Angle);
	
__published:
	__property System::Uitypes::TAlphaColor BackColor = {read=GetBackColor, write=SetBackColor, default=0};
	__property Fmxtee::Canvas::TTeePen* Border = {read=GetBorder, write=SetBorder};
	__property TConnectionArrowBrush* Brush = {read=GetBrush, write=SetBrush};
	__property int Size = {read=FSize, write=SetSize, default=4};
	__property TConnectionArrowStyle Style = {read=FStyle, write=SetStyle, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TConnectionArrowFrom : public TConnectionArrow
{
	typedef TConnectionArrow inherited;
	
__published:
	__property Style = {default=0};
public:
	/* TConnectionArrow.Create */ inline __fastcall virtual TConnectionArrowFrom(TTreeConnection* const AOwner) : TConnectionArrow(AOwner) { }
	/* TConnectionArrow.Destroy */ inline __fastcall virtual ~TConnectionArrowFrom() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TConnectionArrowTo : public TConnectionArrow
{
	typedef TConnectionArrow inherited;
	
__published:
	__property Style = {default=1};
public:
	/* TConnectionArrow.Create */ inline __fastcall virtual TConnectionArrowTo(TTreeConnection* const AOwner) : TConnectionArrow(AOwner) { }
	/* TConnectionArrow.Destroy */ inline __fastcall virtual ~TConnectionArrowTo() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TTreeConnectionStyle : unsigned char { csAuto, csLine, csSides, csCurve, csInvertedSides };

class PASCALIMPLEMENTATION TTreeConnectionPen : public Fmxtee::Canvas::TTeePen
{
	typedef Fmxtee::Canvas::TTeePen inherited;
	
public:
	__fastcall TTreeConnectionPen(const System::Classes::TNotifyEvent OnChangeEvent);
	
__published:
	__property Color = {default=-8355712};
	__property SmallDots = {default=1};
	__property Style = {default=2};
public:
	/* TTeePen.Destroy */ inline __fastcall virtual ~TTreeConnectionPen() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TConnectionFormat : public Fmxtee::Procs::TTeeShape
{
	typedef Fmxtee::Procs::TTeeShape inherited;
	
__published:
	__property Visible = {default=0};
public:
	/* TTeeCustomShape.Create */ inline __fastcall virtual TConnectionFormat(Fmxtee::Procs::TCustomTeePanel* const AOwner)/* overload */ : Fmxtee::Procs::TTeeShape(AOwner) { }
	/* TTeeCustomShape.Destroy */ inline __fastcall virtual ~TConnectionFormat() { }
	
};

#pragma pack(pop)

typedef System::StaticArray<System::Types::TPointF, 100> TCurvePoints;

class PASCALIMPLEMENTATION TTreeConnection : public TCustomTreeElement
{
	typedef TCustomTreeElement inherited;
	
private:
	TConnectionArrowFrom* FArrowFrom;
	TConnectionArrowTo* FArrowTo;
	TTreeConnectionPen* FBorder;
	TConnectionFormat* FFormat;
	TConnectionPoints* FPoints;
	TTreeConnectionStyle FStyle;
	TTreeNodeShape* FFromShape;
	TTreeNodeShape* FToShape;
	TConnectionArrowFrom* __fastcall GetArrowFrom();
	TConnectionArrowTo* __fastcall GetArrowTo();
	TTreeConnectionPen* __fastcall GetBorder();
	TConnectionFormat* __fastcall GetFormat();
	TTreeNodeShape* __fastcall GetFromShape();
	TConnectionPoints* __fastcall GetPoints();
	TTreeConnectionStyle __fastcall GetStyle();
	TTreeNodeShape* __fastcall GetToShape();
	TConnectionArrow* __fastcall InternalArrowFrom();
	TConnectionArrowTo* __fastcall InternalArrowTo();
	bool __fastcall IsFormatStored();
	void __fastcall ReadPoints(System::Classes::TReader* Reader);
	void __fastcall SavePoints(System::Classes::TWriter* Writer);
	void __fastcall SetArrowFrom(TConnectionArrowFrom* const Value);
	void __fastcall SetArrowTo(TConnectionArrowTo* const Value);
	void __fastcall SetBorder(TTreeConnectionPen* const Value);
	void __fastcall SetFormat(TConnectionFormat* const Value);
	void __fastcall SetFromShape(TTreeNodeShape* const Value);
	void __fastcall SetStyle(const TTreeConnectionStyle Value);
	void __fastcall SetToShape(TTreeNodeShape* const Value);
	
protected:
	System::Types::TRectF IBounds;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall GetCurvePoints(TCurvePoints &P);
	void __fastcall InternalDraw();
	void __fastcall PrepareCanvas();
	virtual void __fastcall SetTree(TCustomTree* const Value);
	void __fastcall SetupPoints();
	
public:
	__fastcall virtual TTreeConnection(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTreeConnection();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall Clicked(int x, int y);
	int __fastcall ClickedSegment(int x, int y);
	bool __fastcall Draw();
	System::Types::TRectF __fastcall GetBounds();
	DYNAMIC void __fastcall DrawHandles();
	void __fastcall DrawText(int Angle);
	__property TConnectionPoints* Points = {read=GetPoints};
	bool __fastcall Visible();
	
__published:
	__property TConnectionArrowFrom* ArrowFrom = {read=GetArrowFrom, write=SetArrowFrom};
	__property TConnectionArrowTo* ArrowTo = {read=GetArrowTo, write=SetArrowTo};
	__property TTreeConnectionPen* Border = {read=GetBorder, write=SetBorder};
	__property Font;
	__property TConnectionFormat* Format = {read=GetFormat, write=SetFormat, stored=IsFormatStored};
	__property TTreeConnectionStyle Style = {read=GetStyle, write=SetStyle, default=0};
	__property Cursor = {default=0};
	__property TTreeNodeShape* FromShape = {read=GetFromShape, write=SetFromShape};
	__property TTreeNodeShape* ToShape = {read=GetToShape, write=SetToShape};
	__property Text;
};


typedef void __fastcall (__closure *TTreeNewShapeEvent)(TCustomTree* Sender, TTreeNodeShape* NewShape);

typedef void __fastcall (__closure *TTreeNewConnectionEvent)(TCustomTree* Sender, TTreeConnection* NewConnection);

class PASCALIMPLEMENTATION TTreeSelectedPen : public Fmxtee::Canvas::TTeePen
{
	typedef Fmxtee::Canvas::TTeePen inherited;
	
public:
	__fastcall TTreeSelectedPen(const System::Classes::TNotifyEvent OnChangeEvent);
	
__published:
	__property Color = {default=-256};
	__property SmallDots = {default=1};
	__property Style = {default=2};
public:
	/* TTeePen.Destroy */ inline __fastcall virtual ~TTreeSelectedPen() { }
	
};


class PASCALIMPLEMENTATION TTreeHiddenPen : public Fmxtee::Canvas::TTeePen
{
	typedef Fmxtee::Canvas::TTeePen inherited;
	
public:
	__fastcall TTreeHiddenPen(const System::Classes::TNotifyEvent OnChangeEvent);
	
__published:
	__property Visible = {default=0};
public:
	/* TTeePen.Destroy */ inline __fastcall virtual ~TTreeHiddenPen() { }
	
};


typedef TTreeHiddenPen TTreeSelectedUnFocusedPen;

typedef TTreeHiddenPen TTreeSelectedHandlesPen;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSelectedShapeList : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	TTreeNodeShape* operator[](int Index) { return this->Items[Index]; }
	
private:
	TTreeSelectedPen* FBorder;
	TTreeHiddenPen* FBorderUnFocused;
	System::Uitypes::TAlphaColor FColor;
	System::Uitypes::TAlphaColor FColorUnFocused;
	bool FFullRedraw;
	System::Uitypes::TAlphaColor FHandleColor;
	int FHandleSize;
	TTreeHiddenPen* FHandlePen;
	bool FScrollToView;
	bool FScrollToCenter;
	System::Classes::TShiftState FShiftState;
	System::Uitypes::TAlphaColor FTextColor;
	bool IFocused;
	TNodeShapeList* IList;
	TCustomTree* ITree;
	TTreeNodeShape* __fastcall GetShape(int Index);
	System::Uitypes::TAlphaColor __fastcall InternalColor();
	void __fastcall Repaint();
	void __fastcall SetBorder(TTreeSelectedPen* const Value);
	void __fastcall SetBorderUnFocused(TTreeHiddenPen* const Value);
	void __fastcall SetColor(System::Uitypes::TAlphaColor Value);
	void __fastcall SetColorUnFocused(System::Uitypes::TAlphaColor Value);
	void __fastcall SetTextColor(System::Uitypes::TAlphaColor Value);
	void __fastcall SetScrollToCenter(const bool Value);
	void __fastcall SetFullRedraw(const bool Value);
	void __fastcall SetHandlesPen(TTreeHiddenPen* const Value);
	void __fastcall SetHandleSize(const int Value);
	void __fastcall SetHandleColor(const System::Uitypes::TAlphaColor Value);
	System::UnicodeString __fastcall GetText();
	void __fastcall SetText(const System::UnicodeString Value);
	void * __fastcall GetData();
	void __fastcall SetData(const void * Value);
	
protected:
	void __fastcall InternalAdd(TTreeNodeShape* const AShape);
	
public:
	__fastcall TSelectedShapeList(TCustomTree* const ATree);
	__fastcall virtual ~TSelectedShapeList();
	virtual void __fastcall Assign(System::Classes::TPersistent* Value);
	void __fastcall Add(TTreeNodeShape* const AShape);
	void __fastcall Clear();
	int __fastcall Count();
	__property void * Data = {read=GetData, write=SetData};
	void __fastcall Delete();
	TTreeNodeShape* __fastcall First();
	void __fastcall ForEach(const TNodeListForEachProc Proc);
	void __fastcall Remove(TTreeNodeShape* const AShape);
	void __fastcall SelectAll();
	void __fastcall ToggleCheck();
	__property TNodeShapeList* Shapes = {read=IList};
	__property TTreeNodeShape* Items[int Index] = {read=GetShape/*, default*/};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	
__published:
	__property TTreeSelectedPen* Border = {read=FBorder, write=SetBorder};
	__property TTreeHiddenPen* BorderUnFocused = {read=FBorderUnFocused, write=SetBorderUnFocused};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, default=-16776961};
	__property System::Uitypes::TAlphaColor ColorUnFocused = {read=FColorUnFocused, write=SetColorUnFocused, default=-5658199};
	__property bool FullRedraw = {read=FFullRedraw, write=SetFullRedraw, default=0};
	__property System::Uitypes::TAlphaColor HandleColor = {read=FHandleColor, write=SetHandleColor, default=-16777216};
	__property int HandleSize = {read=FHandleSize, write=SetHandleSize, default=3};
	__property TTreeHiddenPen* HandlePen = {read=FHandlePen, write=SetHandlesPen};
	__property bool ScrollToView = {read=FScrollToView, write=FScrollToView, default=1};
	__property bool ScrollToCenter = {read=FScrollToCenter, write=SetScrollToCenter, default=0};
	__property System::Classes::TShiftState ShiftState = {read=FShiftState, write=FShiftState, default=1};
	__property System::Uitypes::TAlphaColor TextColor = {read=FTextColor, write=SetTextColor, default=-1};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTreeCrossBoxPen : public Fmxtee::Canvas::TTeePen
{
	typedef Fmxtee::Canvas::TTeePen inherited;
	
__published:
	__property Color = {default=-8355712};
	__property Width = {default=0};
public:
	/* TTeePen.Create */ inline __fastcall TTreeCrossBoxPen(const System::Classes::TNotifyEvent OnChangeEvent) : Fmxtee::Canvas::TTeePen(OnChangeEvent) { }
	/* TTeePen.Destroy */ inline __fastcall virtual ~TTreeCrossBoxPen() { }
	
};


typedef void __fastcall (__closure *TClickConnectionEvent)(TTreeConnection* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);

enum DECLSPEC_DENUM TTreeCrossBoxStyle : unsigned char { cbsSquare, cbsDiamond, cbsCircle };

enum DECLSPEC_DENUM TTreeCrossSignStyle : unsigned char { cssCross, cssTriangle };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeNodeCrossBox : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TTreeCrossBoxPen* FBorder;
	Fmxtee::Canvas::TTeeBrush* FBrush;
	int FClickTolerance;
	Fmxtee::Canvas::TTeePen* FSignPen;
	TTreeCrossSignStyle FSignStyle;
	int FSize;
	TTreeCrossBoxStyle FStyle;
	bool FVisible;
	TCustomTree* FTree;
	System::Uitypes::TAlphaColor __fastcall GetBackColor();
	void __fastcall SetBackColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetBorder(TTreeCrossBoxPen* const Value);
	void __fastcall SetBrush(Fmxtee::Canvas::TTeeBrush* const Value);
	void __fastcall SetSignPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetSignStyle(const TTreeCrossSignStyle Value);
	void __fastcall SetSize(int Value);
	void __fastcall SetStyle(const TTreeCrossBoxStyle Value);
	void __fastcall SetVisible(bool Value);
	
public:
	__fastcall TTreeNodeCrossBox(TCustomTree* const AOwner);
	__fastcall virtual ~TTreeNodeCrossBox();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Draw(const System::Types::TPointF &AtPoint, bool DrawExpanded);
	
__published:
	__property System::Uitypes::TAlphaColor BackColor = {read=GetBackColor, write=SetBackColor, default=0};
	__property TTreeCrossBoxPen* Border = {read=FBorder, write=SetBorder};
	__property Fmxtee::Canvas::TTeeBrush* Brush = {read=FBrush, write=SetBrush};
	__property int ClickTolerance = {read=FClickTolerance, write=FClickTolerance, default=0};
	__property Fmxtee::Canvas::TTeePen* SignPen = {read=FSignPen, write=SetSignPen};
	__property TTreeCrossSignStyle SignStyle = {read=FSignStyle, write=SetSignStyle, default=0};
	__property int Size = {read=FSize, write=SetSize, default=5};
	__property TTreeCrossBoxStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TNotifyShapeEvent)(TTreeNodeShape* Sender);

typedef void __fastcall (__closure *TNotifyConnectionEvent)(TTreeConnection* Sender);

typedef void __fastcall (__closure *TDeleteShapesEvent)(TSelectedShapeList* Sender, bool &AllowDelete);

typedef void __fastcall (__closure *TShowHintShapeEvent)(TCustomTree* Sender, TTreeNodeShape* Shape, System::UnicodeString &Text);

typedef void __fastcall (__closure *TTreeChangingEvent)(TCustomTree* Sender, TTreeNodeShape* Node, bool &Allow);

typedef void __fastcall (__closure *TMovingShapeEvent)(TTreeNodeShape* Sender, int &DeltaX, int &DeltaY);

typedef void __fastcall (__closure *TTreeResizingShape)(TTreeNodeShape* Sender, TTreeShapeHandle ACorner, int &DeltaX, int &DeltaY);

struct DECLSPEC_DRECORD TTreeEvents
{
public:
	System::Classes::TNotifyEvent FAfterDraw;
	System::Classes::TNotifyEvent FBeforeDraw;
	Fmx::Types::TMouseEvent FMouseDown;
	Fmx::Types::TMouseEvent FMouseUp;
	Fmx::Types::TMouseMoveEvent FMouseMove;
	TTreeChangingEvent FChanging;
	System::Classes::TNotifyEvent FCheckedShape;
	TTreeClick FClickBackGround;
	TClickConnectionEvent FClickConnection;
	TClickShapeEvent FClickShape;
	TClickConnectionEvent FDblClickConnection;
	TClickShapeEvent FDblClickShape;
	TDeleteShapesEvent FDeletingShapes;
	System::Classes::TNotifyEvent FDeletedShapes;
	TNotifyShapeEvent FExpandedCollapsed;
	TExpandingCollapsingEvent FExpandingCollapsing;
	TMovingShapeEvent FMovingShape;
	TMouseShapeEvent FMouseEnterShape;
	TMouseShapeEvent FMouseLeaveShape;
	TTreeResizingShape FResizingShape;
	TNotifyShapeEvent FSelectShape;
	TNotifyConnectionEvent FSelectConnection;
	TNotifyConnectionEvent FUnSelectConnection;
	TNotifyShapeEvent FUnSelectShape;
	System::Classes::TNotifyEvent FScroll;
	System::Classes::TNotifyEvent FZoom;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeScrollBar : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FAutomatic;
	bool FFlat;
	int FMin;
	int FMax;
	int FPageSize;
	bool FVisible;
	TCustomTree* ITree;
	int ICode;
	Fmx::Stdctrls::TScrollBar* IScroll;
	void __fastcall ScrollChanged(System::TObject* Sender);
	void __fastcall ChangeVisible(bool Value);
	void __fastcall DoCheckMinMax();
	int __fastcall GetPosition();
	void __fastcall InternalSetRange(bool Redraw);
	void __fastcall SetAutomatic(bool Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetMax(int Value);
	void __fastcall SetMin(int Value);
	void __fastcall SetPageSize(int Value);
	void __fastcall SetPosition(int Value);
	void __fastcall SetRange();
	void __fastcall SetScrollParams(int Offset);
	void __fastcall SetVisible(bool Value);
	
protected:
	void __fastcall CheckScroll(int AMin, int AMax, int AOffset, int ASize);
	bool __fastcall Vertical();
	
public:
	__fastcall TTeeScrollBar(TCustomTree* const ATree, bool IsHoriz);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property int Position = {read=GetPosition, nodefault};
	
__published:
	__property bool Automatic = {read=FAutomatic, write=SetAutomatic, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property int Max = {read=FMax, write=SetMax, default=1000};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int PageSize = {read=FPageSize, write=SetPageSize, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTeeScrollBar() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeShapeList : public TNodeShapeList
{
	typedef TNodeShapeList inherited;
	
private:
	bool FVisible;
	void __fastcall SetVisible(const bool Value);
	
public:
	TTreeNodeShape* __fastcall AddChild(TTreeNodeShape* const Node, const System::UnicodeString Text);
	void __fastcall Assign(TTreeShapeList* Source);
	void __fastcall SelectAll();
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
public:
	/* TTreeList.Destroy */ inline __fastcall virtual ~TTreeShapeList() { }
	
public:
	/* TObject.Create */ inline __fastcall TTreeShapeList() : TNodeShapeList() { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TTreeZoomedAreaEvent)(const System::Types::TRectF &R);

enum DECLSPEC_DENUM TTreeWheelNavigation : unsigned char { wnSelection, wnScrollVert, wnScrollHoriz, wnZoom, wnNone };

enum DECLSPEC_DENUM TTreeNavigation : unsigned char { tnExplorer, tnNearest, tnNone, tnCircularExplorer };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChildManager : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual System::Types::TPointF __fastcall CalcXYCross(TTreeNodeShape* const ANode, TTreeNodeShape* const AParent) = 0 ;
	virtual bool __fastcall DrawConnection(TTreeConnection* const AConnection) = 0 ;
	virtual int __fastcall XPosition(TTreeNodeShape* const ANode, int ABrotherIndex) = 0 ;
	virtual int __fastcall YPosition(TTreeNodeShape* const ANode, int ABrotherIndex) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TChildManager() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TChildManager() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeExplorerAlignChild : public TChildManager
{
	typedef TChildManager inherited;
	
private:
	int FCrossMargin;
	int FHorizMargin;
	int FTopPos;
	int FVertMargin;
	
protected:
	int ArrowToAngle;
	bool __fastcall AnyRootShouldDrawCross(TCustomTree* const Tree);
	
public:
	__fastcall TTreeExplorerAlignChild();
	virtual System::Types::TPointF __fastcall CalcXYCross(TTreeNodeShape* const ANode, TTreeNodeShape* const AParent);
	virtual bool __fastcall DrawConnection(TTreeConnection* const AConnection);
	virtual int __fastcall XPosition(TTreeNodeShape* const ANode, int ABrotherIndex);
	virtual int __fastcall YPosition(TTreeNodeShape* const ANode, int ABrotherIndex);
	__property int HorizMargin = {read=FHorizMargin, write=FHorizMargin, default=19};
	__property int TopPos = {read=FTopPos, write=FTopPos, default=2};
	__property int VertMargin = {read=FVertMargin, write=FVertMargin, default=1};
	__property int CrossMargin = {read=FCrossMargin, write=FCrossMargin, default=5};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTreeExplorerAlignChild() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTeeHotTrackFont : public Fmxtee::Canvas::TTeeFont
{
	typedef Fmxtee::Canvas::TTeeFont inherited;
	
__published:
	__property Style = {default=4};
public:
	/* TTeeFont.Create */ inline __fastcall TTeeHotTrackFont(System::Classes::TNotifyEvent ChangedEvent) : Fmxtee::Canvas::TTeeFont(ChangedEvent) { }
	/* TTeeFont.Destroy */ inline __fastcall virtual ~TTeeHotTrackFont() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeHotTrack : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FActive;
	Fmxtee::Canvas::TTeePen* FBorder;
	TTeeHotTrackFont* FFont;
	bool FHotLink;
	bool FUseBorder;
	bool FUseFont;
	TCustomTree* ITree;
	void __fastcall SetActive(const bool Value);
	void __fastcall SetBorder(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetFont(TTeeHotTrackFont* const Value);
	
public:
	__fastcall TTreeHotTrack(TCustomTree* const ATree);
	__fastcall virtual ~TTreeHotTrack();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Fmxtee::Canvas::TTeePen* Border = {read=FBorder, write=SetBorder};
	__property TTeeHotTrackFont* Font = {read=FFont, write=SetFont};
	__property bool HotLink = {read=FHotLink, write=FHotLink, default=1};
	__property bool UseBorder = {read=FUseBorder, write=FUseBorder, default=0};
	__property bool UseFont = {read=FUseFont, write=FUseFont, default=0};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TNotifyShapeEventStartEdit)(TTreeNodeShape* Shape, bool &AllowEditing);

typedef void __fastcall (__closure *TDragDropShapeEvent)(TCustomTree* Sender, TTreeNodeShape* Dragged, TTreeNodeShape* Parent);

struct DECLSPEC_DRECORD TTreeGlobal
{
public:
	Fmxtee::Canvas::TTeePen* Border;
	TTreeShapeBrush* Brush;
	TTreeConnection* Connection;
	System::Uitypes::TCursor Cursor;
	Fmxtee::Canvas::TTeeFont* Font;
	TTreeNodeShapeShowCross ShowCross;
	TTreeNodeImageIndex ImageIndex;
	bool Transparent;
	TChildManager* ChildManager;
	TTreeNodeShapeClass NodeClass;
	TTreeConnectionClass ConnectionClass;
};


class PASCALIMPLEMENTATION TGridPen : public TTreeHiddenPen
{
	typedef TTreeHiddenPen inherited;
	
__published:
	__property Color = {default=-4144960};
public:
	/* TTreeHiddenPen.Create */ inline __fastcall TGridPen(const System::Classes::TNotifyEvent OnChangeEvent) : TTreeHiddenPen(OnChangeEvent) { }
	
public:
	/* TTeePen.Destroy */ inline __fastcall virtual ~TGridPen() { }
	
};


class PASCALIMPLEMENTATION TGridBigPen : public TTreeHiddenPen
{
	typedef TTreeHiddenPen inherited;
	
__published:
	__property Color = {default=-8355712};
public:
	/* TTreeHiddenPen.Create */ inline __fastcall TGridBigPen(const System::Classes::TNotifyEvent OnChangeEvent) : TTreeHiddenPen(OnChangeEvent) { }
	
public:
	/* TTeePen.Destroy */ inline __fastcall virtual ~TGridBigPen() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeGrid : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TGridBigPen* FBigPen;
	int FBigStep;
	System::Uitypes::TAlphaColor FColor;
	TGridPen* FPen;
	int FHorizStep;
	int FVertStep;
	bool FVisible;
	TCustomTree* ITree;
	void __fastcall SetBigPen(TGridBigPen* const Value);
	void __fastcall SetBigStep(const int Value);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetHorizStep(const int Value);
	void __fastcall SetPen(TGridPen* const Value);
	void __fastcall SetStep(const int Value);
	void __fastcall SetVertStep(const int Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TTreeGrid(TCustomTree* const ATree);
	__fastcall virtual ~TTreeGrid();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property int HorizStep = {read=FHorizStep, write=SetHorizStep, default=10};
	
__published:
	__property TGridBigPen* BigPen = {read=FBigPen, write=SetBigPen};
	__property int BigStep = {read=FBigStep, write=SetBigStep, default=10};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, default=-8355712};
	__property TGridPen* Pen = {read=FPen, write=SetPen};
	__property int Step = {read=FHorizStep, write=SetStep, default=10};
	__property int VertStep = {read=FVertStep, write=SetVertStep, default=10};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTreePageBorder : public Fmxtee::Canvas::TTeePen
{
	typedef Fmxtee::Canvas::TTeePen inherited;
	
private:
	bool FPrint;
	
__published:
	__property Color = {default=-5658199};
	__property bool Print = {read=FPrint, write=FPrint, default=0};
public:
	/* TTeePen.Create */ inline __fastcall TTreePageBorder(const System::Classes::TNotifyEvent OnChangeEvent) : Fmxtee::Canvas::TTeePen(OnChangeEvent) { }
	/* TTeePen.Destroy */ inline __fastcall virtual ~TTreePageBorder() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreePage : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TTreePageBorder* FBorder;
	int FCount;
	int FHeight;
	int FPage;
	bool FUsePrinter;
	int FWidth;
	TCustomTree* ITree;
	bool __fastcall IsStored();
	int __fastcall InternalGetCount();
	int __fastcall GetCount();
	int __fastcall GetHeight();
	int __fastcall GetWidth();
	void __fastcall SetBorder(TTreePageBorder* const Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetPage(const int Value);
	void __fastcall SetUsePrinter(const bool Value);
	void __fastcall SetWidth(const int Value);
	
public:
	__fastcall TTreePage(TCustomTree* const ATree);
	__fastcall virtual ~TTreePage();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Refresh();
	__property int Count = {read=GetCount, nodefault};
	void __fastcall DrawBorder();
	__property int Page = {read=FPage, write=SetPage, default=1};
	
__published:
	__property TTreePageBorder* Border = {read=FBorder, write=SetBorder};
	__property int Height = {read=GetHeight, write=SetHeight, stored=IsStored, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, stored=IsStored, nodefault};
	__property bool UsePrinter = {read=FUsePrinter, write=SetUsePrinter, default=1};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomTreeShape : public TTreeNodeShape
{
	typedef TTreeNodeShape inherited;
	
public:
	__fastcall virtual TCustomTreeShape(System::Classes::TComponent* AOwner);
	
__published:
	__property ImageIndex = {default=0};
	__property Style = {default=12};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TCustomTreeShape() { }
	
};


typedef System::TMetaClass* TPolygonShapeClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPointItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FY;
	int FX;
	void __fastcall SetX(const int Value);
	void __fastcall SetY(const int Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	TPolygonShape* __fastcall Shape();
	
__published:
	__property int X = {read=FX, write=SetX, nodefault};
	__property int Y = {read=FY, write=SetY, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TPointItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TPointItem() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPointCollection : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TPointItem* operator[](int Index) { return this->Point[Index]; }
	
private:
	double __fastcall Area();
	System::Types::TPointF __fastcall Centroid();
	TPointItem* __fastcall GetPoint(int Index);
	void __fastcall SetPoint(int Index, TPointItem* const Value);
	
protected:
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Generics::Collections::TCollectionNotification Action);
	
public:
	HIDESBASE TPointItem* __fastcall Add();
	__property TPointItem* Point[int Index] = {read=GetPoint, write=SetPoint/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TPointCollection(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPointCollection() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TPolygonShape : public TCustomTreeShape
{
	typedef TCustomTreeShape inherited;
	
private:
	TPointCollection* FPoints;
	int FResizingHandle;
	bool IsPolyLine;
	void __fastcall InternalDraw(Fmxtee::Canvas::TCanvas3D* const ACanvas, const float OffsetX, const float OffsetY);
	void __fastcall SetPoints(TPointCollection* const Value);
	
protected:
	DYNAMIC System::Uitypes::TCursor __fastcall GetHandleCursor(int x, int y);
	virtual int __fastcall GetShapePoints(const System::Types::TRectF &R, TShapePoints &P);
	virtual void __fastcall Loaded();
	
public:
	__fastcall virtual TPolygonShape(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPolygonShape();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE TPointItem* __fastcall Add(int X, int Y);
	double __fastcall Area();
	System::Types::TPointF __fastcall Centroid();
	int __fastcall ClickedPoint(int x, int y);
	DYNAMIC void __fastcall DrawHandles();
	void __fastcall FillSample();
	DYNAMIC TTreeShapeHandle __fastcall GetResizingHandle(int x, int y);
	HIDESBASE TPointItem* __fastcall Insert(int Index, int X, int Y);
	DYNAMIC void __fastcall MoveRelative(int OfsX, int OfsY, bool MoveChilds);
	virtual void __fastcall RecalcSize(Fmxtee::Canvas::TCanvas3D* const ACanvas);
	DYNAMIC void __fastcall Resize(TTreeShapeHandle ACorner, int DeltaX, int DeltaY);
	
__published:
	__property TPointCollection* Points = {read=FPoints, write=SetPoints};
};


class PASCALIMPLEMENTATION TPolyLineShape : public TPolygonShape
{
	typedef TPolygonShape inherited;
	
public:
	__fastcall virtual TPolyLineShape(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Clicked(const float x, const float y)/* overload */;
public:
	/* TPolygonShape.Destroy */ inline __fastcall virtual ~TPolyLineShape() { }
	
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Clicked(const int x, const int y){ return TTreeNodeShape::Clicked(x, y); }
	
};


class PASCALIMPLEMENTATION TImageShape : public TTreeNodeShape
{
	typedef TTreeNodeShape inherited;
	
public:
	__fastcall virtual TImageShape(System::Classes::TComponent* AOwner);
	virtual void __fastcall RecalcSize(Fmxtee::Canvas::TCanvas3D* const ACanvas);
	
__published:
	__property ImageIndex = {default=4};
	__property ImageAlignment = {default=9};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TImageShape() { }
	
};


class PASCALIMPLEMENTATION TTextShape : public TTreeNodeShape
{
	typedef TTreeNodeShape inherited;
	
public:
	__fastcall virtual TTextShape(System::Classes::TComponent* AOwner);
	
__published:
	__property ImageIndex = {default=0};
	__property Transparent = {default=1};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTextShape() { }
	
};


typedef void __fastcall (__closure *TNewPolygonEvent)(TCustomTree* Sender, TPolygonShape* APolygon);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeDragDrop : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FAutomatic;
	bool FDragToRoot;
	bool FDragRoots;
	bool FFromOtherTree;
	bool FRemove;
	bool FToOtherTree;
	
public:
	bool AutoScroll;
	__fastcall TTreeDragDrop();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Automatic = {read=FAutomatic, write=FAutomatic, default=0};
	__property bool DragRoots = {read=FDragRoots, write=FDragRoots, default=1};
	__property bool DragToRoot = {read=FDragToRoot, write=FDragToRoot, default=1};
	__property bool FromOtherTree = {read=FFromOtherTree, write=FFromOtherTree, default=1};
	__property bool RemoveNodes = {read=FRemove, write=FRemove, default=1};
	__property bool ToOtherTree = {read=FToOtherTree, write=FToOtherTree, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTreeDragDrop() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TTreeTextEditorMode : unsigned char { tteKey, tteMouse, tteBoth };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeTextEditor : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	Fmx::Memo::TMemo* FMemo;
	TTreeTextEditorMode FMode;
	System::Uitypes::TMouseButton FMouse;
	System::Classes::TShortCut FShortCut;
	bool FUseNodeFont;
	bool FUseNodeFormat;
	bool FUseNodeSize;
	
public:
	__fastcall TTreeTextEditor();
	__fastcall virtual ~TTreeTextEditor();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Fmx::Memo::TMemo* Memo = {read=FMemo};
	
__published:
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property TTreeTextEditorMode Mode = {read=FMode, write=FMode, default=0};
	__property System::Uitypes::TMouseButton MouseButton = {read=FMouse, write=FMouse, default=0};
	__property System::Classes::TShortCut ShortCut = {read=FShortCut, write=FShortCut, default=113};
	__property bool UseNodeSize = {read=FUseNodeSize, write=FUseNodeSize, default=1};
	__property bool UseNodeFormat = {read=FUseNodeFormat, write=FUseNodeFormat, default=0};
	__property bool UseNodeFont = {read=FUseNodeFont, write=FUseNodeFont, default=0};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeAfterDrawEvent : public Fmxtee::Procs::TTeeEvent
{
	typedef Fmxtee::Procs::TTeeEvent inherited;
	
public:
	/* TObject.Create */ inline __fastcall TTreeAfterDrawEvent() : Fmxtee::Procs::TTeeEvent() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TTreeAfterDrawEvent() { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TTreeSortCompareEvent)(TTreeNodeShape* Node1, TTreeNodeShape* Node2, int &Compare);

typedef void __fastcall (__closure *TTreeAddingConnectionEvent)(TTreeNodeShape* Node1, TTreeNodeShape* Node2, bool &Add);

struct DECLSPEC_DRECORD TTreeZoomDefault
{
public:
	int ZoomPercent;
	int HorizOffset;
	int VertOffset;
};


class PASCALIMPLEMENTATION TImageList : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	virtual void __fastcall Change();
	
public:
	void __fastcall GetBitmap(int Index, Fmx::Graphics::TBitmap* const Bitmap);
	int __fastcall Count();
public:
	/* TComponent.Create */ inline __fastcall virtual TImageList(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TImageList() { }
	
};


class PASCALIMPLEMENTATION TCustomTree : public Fmxtee::Procs::TCustomTeePanelExtended
{
	typedef Fmxtee::Procs::TCustomTeePanelExtended inherited;
	
	
private:
	enum DECLSPEC_DENUM TPanDirection : unsigned char { pdUndecided, pdHorizontal, pdVertical, pdArbitrary };
	
	
public:
	TTreeNodeShape* operator[](int Index) { return this->Shape[Index]; }
	
private:
	bool FAllowDelete;
	bool FAllowResize;
	TTreeConnectionList* FConnections;
	TTreeNodeCrossBox* FCrossBox;
	bool FDesigning;
	TTreeDragDrop* FDragDrop;
	TTreeNodeShape* FDragged;
	TTreeGrid* FGrid;
	TTeeScrollBar* FHorzScroll;
	TTreeHotTrack* FHotTrack;
	TImageList* FImages;
	TTreeNavigation FNavigation;
	TTreePage* FPage;
	bool FReadOnly;
	TNodeShapeList* FRoots;
	System::Uitypes::TMouseButton FScrollMouse;
	TSelectedShapeList* FSelected;
	bool FSingleSelection;
	TTreeShapeList* FShapes;
	bool FShowHintShapes;
	bool FShowRootCross;
	bool FSnapToGrid;
	TTreeTextEditor* FTextEditor;
	TTeeScrollBar* FVertScroll;
	TTreeWheelNavigation FWheelNavigation;
	TTreeZoomDefault FZoomDefault;
	TTreeAddingConnectionEvent FOnAddingConn;
	System::Classes::TNotifyEvent FOnBeforeDraw;
	TTreeChangingEvent FOnChanging;
	System::Classes::TNotifyEvent FOnCheckedShape;
	TClickConnectionEvent FOnClickConnection;
	TClickShapeEvent FOnClickShape;
	TTreeClick FOnClickTree;
	TClickConnectionEvent FOnDblClickConnection;
	TClickShapeEvent FOnDblClickShape;
	TDeleteShapesEvent FOnDeletingShapes;
	System::Classes::TNotifyEvent FOnDeletedShapes;
	TDragDropShapeEvent FOnDragDropShape;
	TNotifyShapeEvent FOnExpandedCollapsed;
	TExpandingCollapsingEvent FOnExpandingCollapsing;
	TMovingShapeEvent FOnMovingShape;
	TMouseShapeEvent FOnMouseEnterShape;
	TMouseShapeEvent FOnMouseLeaveShape;
	TTreeNewConnectionEvent FOnNewConnection;
	TTreeNewShapeEvent FOnNewShape;
	TTreeResizingShape FOnResizingShape;
	TNotifyConnectionEvent FOnSelectConnection;
	TNotifyShapeEvent FOnSelectShape;
	TShowHintShapeEvent FOnShowHint;
	TTreeSortCompareEvent FOnSortCompare;
	TNotifyShapeEventStartEdit FOnStartEditing;
	TNotifyShapeEvent FOnStopEditing;
	TNotifyConnectionEvent FOnUnSelectConnection;
	TNotifyShapeEvent FOnUnSelectShape;
	int OriginalX;
	int OriginalY;
	TTreeShapeHandle FResizing;
	int FConnHandle;
	bool IEscapedConnecting;
	TTreeNodeShape* IShape1;
	TTreeNodeShape* IShape2;
	System::Types::TPointF IFromConnect;
	System::Types::TPointF IToConnect;
	TTreeNodeShape* IEditShape;
	bool IChangingMemo;
	bool IClearing;
	bool IScrolled;
	bool IEditing;
	System::Types::TPointF IPanPoint;
	TPanDirection IPanDirection;
	void __fastcall AutomaticScrollBars();
	bool __fastcall CanBeParentOf(TTreeNodeShape* const AParent, TTreeNodeShape* const AShape);
	HIDESBASE bool __fastcall Destroying();
	void __fastcall DrawConnecting(const float x, const float y, bool CheckPos);
	void __fastcall DrawPolygon();
	void __fastcall EditKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FinishDrag(TTreeNodeShape* const Target);
	void __fastcall FinishEditing(bool SetNewText);
	System::Uitypes::TAlphaColor __fastcall GetGridColor();
	int __fastcall GetGridStep();
	Fmx::Memo::TMemo* __fastcall GetMemo();
	TTreeNodeShape* __fastcall GetShape(int Index);
	void __fastcall GlobalFormatChanged(System::TObject* Sender);
	System::UnicodeString __fastcall InstanceName(TTreeNodeShape* const AShape);
	void __fastcall InternalWheel(bool IsDown);
	void __fastcall ReadGridColor(System::Classes::TReader* Reader);
	void __fastcall ReadGridStep(System::Classes::TReader* Reader);
	System::Types::TRectF __fastcall Rectangle2DPosition(const System::Types::TRectF &R);
	void __fastcall RemoveShape(TTreeNodeShape* const AShape);
	void __fastcall SelectedScroll();
	void __fastcall SetCrossBox(TTreeNodeCrossBox* const Value);
	void __fastcall SetDefaultCapacity();
	void __fastcall SetDesigningField(const bool Value);
	void __fastcall SetGrid(TTreeGrid* const Value);
	void __fastcall SetGridColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetGridStep(const int Value);
	void __fastcall SetHorzScrollBar(TTeeScrollBar* const Value);
	void __fastcall SetImages(TImageList* const Value);
	void __fastcall SetScrollParams();
	void __fastcall SetSelected(TSelectedShapeList* const Value);
	void __fastcall SetShape(int Index, TTreeNodeShape* const Value);
	void __fastcall SetSingleSelection(bool Value);
	void __fastcall SetTextEditor(TTreeTextEditor* const Value);
	void __fastcall SetVertScrollBar(TTeeScrollBar* const Value);
	void __fastcall View3DChangedZoom(int NewZoom);
	void __fastcall View3DScrolled(bool IsHoriz);
	void __fastcall SetAllowDelete(const bool Value);
	void __fastcall SetAllowResize(const bool Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetShowRootCross(const bool Value);
	void __fastcall SetHotTrack(TTreeHotTrack* const Value);
	void __fastcall SetPage(TTreePage* const Value);
	void __fastcall SetDragDrop(TTreeDragDrop* const Value);
	
protected:
	System::Types::TRectF IBounds;
	System::Types::TRectF IBounds2D;
	TImageLevels* IImageLevels;
	TPolygonShapeClass IPolygonMode;
	TPolygonShape* IPolygonShape;
	TNewPolygonEvent OnNewPolygon;
	bool IZoomPriority;
	void __fastcall ChangeSelection(TTreeNodeShape* const ANode);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DragEnd();
	virtual void __fastcall DragOver(const Fmx::Types::TDragObject &Data, const System::Types::TPointF &Point, Fmx::Types::TDragOperation &Operation);
	void __fastcall DoDraw();
	virtual int __fastcall DoExpandCollapse(TTreeNodeShape* const AShape, bool Value);
	void __fastcall DoSelectConnection(TTreeConnection* const AConnection);
	void __fastcall DrawDiamond(const System::Types::TRectF &R);
	void __fastcall DrawGrid();
	void __fastcall DrawHandle(TCustomTreeElement* const Node, const TTreeShapeHandle Handle, float x, float y);
	void __fastcall EndDrawHandles();
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner();
	virtual void __fastcall InternalDraw(const System::Types::TRectF &UserRectangle);
	virtual void __fastcall KeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall Loaded();
	virtual void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseMove(System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall PrepareDrawHandles();
	System::Types::TRectF __fastcall PrepareGrid(int &tmpH, int &tmpV);
	virtual void __fastcall DoBeginUpdate();
	virtual void __fastcall DoEndUpdate();
	virtual void __fastcall MouseWheel(System::Classes::TShiftState Shift, int WheelDelta, bool &Handled);
	virtual void __fastcall DoGesture(const Fmx::Types::TGestureEventInfo &EventInfo, bool &Handled);
	__property TTreeNodeShape* Dragged = {read=FDragged};
	
public:
	bool AssignParent;
	bool CreateConnections;
	bool NegativeCoordinates;
	bool NoOwnerShapes;
	bool ShowImages;
	bool ShowText;
	bool ZoomCentered;
	TTreeGlobal GlobalFormat;
	bool Connecting;
	TTreeZoomedAreaEvent OnZoomedArea;
	__fastcall virtual TCustomTree(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomTree();
	TTreeNodeShape* __fastcall AddCloneShape(TTreeNodeShape* const AShape);
	void __fastcall AddNewShape(TTreeNodeShape* const AShape, int X, int Y, const System::UnicodeString AText, TTreeNodeShape* const AParentShape);
	TTreeNodeShape* __fastcall AddShapeClass(int X, int Y, const System::UnicodeString AText, TTreeNodeShape* const AParentShape, const TTreeNodeShapeClass AClass);
	TTreeNodeShape* __fastcall AddShape(int X, int Y, const System::UnicodeString AText, TTreeNodeShape* const AParentShape);
	TTreeNodeShape* __fastcall AddRoot(const System::UnicodeString RootText);
	TTreeNodeShape* __fastcall AddRootObject(const System::UnicodeString AText, void * Data);
	TTreeNodeShape* __fastcall Add(int X, int Y, const System::UnicodeString Text, TTreeNodeShape* const Parent)/* overload */;
	TTreeNodeShape* __fastcall Add(const System::UnicodeString Text)/* overload */;
	TTreeNodeShape* __fastcall Add(const System::UnicodeString Text, TTreeNodeShape* const Parent)/* overload */;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall CenterInView(TTreeNodeShape* const Shape, bool Animated = true);
	void __fastcall ChangeManager(TChildManager* const NewManager);
	void __fastcall Clear();
	TTreeNodeShape* __fastcall ClickedShape(int x, int y);
	TTreeNodeShape* __fastcall CloneShape(TTreeNodeShape* const AShape);
	void __fastcall DeleteShape(TTreeNodeShape* const AShape);
	__property bool Editing = {read=IEditing, nodefault};
	System::UnicodeString __fastcall FindFreeName(TTreeNodeShape* const AShape);
	void __fastcall FullExpandCollapse(bool Expand);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	virtual System::Types::TRectF __fastcall GetRectangle();
	TTreeNodeShape* __fastcall LoadFromStrings(System::Classes::TStrings* const Strings);
	TTreeNodeShape* __fastcall LoadFromTextFile(const System::UnicodeString FileName);
	void __fastcall ProcessKey(System::Word Key, System::Classes::TShiftState Shift);
	void __fastcall SaveEvents(TTreeEvents &SavedEvents);
	void __fastcall SetEvents(const TTreeEvents &SavedEvents);
	void __fastcall SelectConnection(TTreeConnection* const AConnection);
	void __fastcall SetDesignTime(bool Value);
	HIDESBASE void __fastcall Sort(bool Ascending = true, bool IgnoreCase = true);
	TTreeConnection* __fastcall StartConnecting();
	void __fastcall StopConnecting();
	void __fastcall StartEditing(TTreeNodeShape* const AShape);
	void __fastcall StopEditing();
	void __fastcall ZoomRectangle(const System::Types::TRectF &R);
	void __fastcall ZoomFromCenter(int NewZoom, int X, int Y);
	void __fastcall ZoomSetHome()/* overload */;
	void __fastcall ZoomSetHome(const TTreeZoomDefault &ZoomParams)/* overload */;
	void __fastcall ZoomReset();
	__property bool AllowDelete = {read=FAllowDelete, write=SetAllowDelete, default=1};
	__property bool AllowResize = {read=FAllowResize, write=SetAllowResize, default=1};
	__property TTreeNodeShape* ConnectingShape1 = {read=IShape1};
	__property TTreeNodeShape* ConnectingShape2 = {read=IShape2};
	__property TTreeConnectionList* Connections = {read=FConnections};
	__property TTreeNodeCrossBox* CrossBox = {read=FCrossBox, write=SetCrossBox};
	__property bool Designing = {read=FDesigning, write=SetDesigningField, default=0};
	__property TTreeDragDrop* DragAndDrop = {read=FDragDrop, write=SetDragDrop};
	__property TTreeGrid* Grid = {read=FGrid, write=SetGrid};
	__property System::Uitypes::TAlphaColor GridColor = {read=GetGridColor, write=SetGridColor, default=0};
	__property int GridStep = {read=GetGridStep, write=SetGridStep, nodefault};
	__property TTreeHotTrack* HotTrack = {read=FHotTrack, write=SetHotTrack};
	__property TImageList* Images = {read=FImages, write=SetImages};
	__property Fmx::Memo::TMemo* InternalMemo = {read=GetMemo};
	__property TTreeShapeList* Items = {read=FShapes};
	__property TTreeNavigation Navigation = {read=FNavigation, write=FNavigation, default=0};
	__property TTreePage* Page = {read=FPage, write=SetPage};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property TNodeShapeList* Roots = {read=FRoots};
	__property bool Scrolled = {read=IScrolled, nodefault};
	__property System::Uitypes::TMouseButton ScrollMouseButton = {read=FScrollMouse, write=FScrollMouse, default=1};
	__property TSelectedShapeList* Selected = {read=FSelected, write=SetSelected};
	__property TTreeNodeShape* Shape[int Index] = {read=GetShape, write=SetShape/*, default*/};
	__property TTreeShapeList* Shapes = {read=FShapes};
	__property bool SingleSelection = {read=FSingleSelection, write=SetSingleSelection, default=1};
	__property bool ShowHintShapes = {read=FShowHintShapes, write=FShowHintShapes, default=1};
	__property bool ShowRootCross = {read=FShowRootCross, write=SetShowRootCross, default=1};
	__property bool SnapToGrid = {read=FSnapToGrid, write=FSnapToGrid, default=1};
	__property TTreeTextEditor* TextEditor = {read=FTextEditor, write=SetTextEditor};
	__property System::Types::TRectF TotalBounds = {read=IBounds};
	__property TTeeScrollBar* HorzScrollBar = {read=FHorzScroll, write=SetHorzScrollBar};
	__property TTeeScrollBar* VertScrollBar = {read=FVertScroll, write=SetVertScrollBar};
	__property TTreeWheelNavigation WheelNavigation = {read=FWheelNavigation, write=FWheelNavigation, default=0};
	__property BufferedDisplay = {default=1};
	__property TTreeAddingConnectionEvent OnAddingConnection = {read=FOnAddingConn, write=FOnAddingConn};
	__property System::Classes::TNotifyEvent OnBeforeDraw = {read=FOnBeforeDraw, write=FOnBeforeDraw};
	__property TTreeChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TTreeClick OnClickBackground = {read=FOnClickTree, write=FOnClickTree};
	__property TClickConnectionEvent OnClickConnection = {read=FOnClickConnection, write=FOnClickConnection};
	__property TClickShapeEvent OnClickShape = {read=FOnClickShape, write=FOnClickShape};
	__property System::Classes::TNotifyEvent OnCheckedShape = {read=FOnCheckedShape, write=FOnCheckedShape};
	__property OnDblClick;
	__property TClickConnectionEvent OnDblClickConnection = {read=FOnDblClickConnection, write=FOnDblClickConnection};
	__property TClickShapeEvent OnDblClickShape = {read=FOnDblClickShape, write=FOnDblClickShape};
	__property TDeleteShapesEvent OnDeletingShapes = {read=FOnDeletingShapes, write=FOnDeletingShapes};
	__property System::Classes::TNotifyEvent OnDeletedShapes = {read=FOnDeletedShapes, write=FOnDeletedShapes};
	__property TDragDropShapeEvent OnDragDropShape = {read=FOnDragDropShape, write=FOnDragDropShape};
	__property TNotifyShapeEvent OnExpandedCollapsed = {read=FOnExpandedCollapsed, write=FOnExpandedCollapsed};
	__property TExpandingCollapsingEvent OnExpandingCollapsing = {read=FOnExpandingCollapsing, write=FOnExpandingCollapsing};
	__property TMovingShapeEvent OnMovingShape = {read=FOnMovingShape, write=FOnMovingShape};
	__property TMouseShapeEvent OnMouseEnterShape = {read=FOnMouseEnterShape, write=FOnMouseEnterShape};
	__property TMouseShapeEvent OnMouseLeaveShape = {read=FOnMouseLeaveShape, write=FOnMouseLeaveShape};
	__property TTreeNewConnectionEvent OnNewConnection = {read=FOnNewConnection, write=FOnNewConnection};
	__property TTreeNewShapeEvent OnNewShape = {read=FOnNewShape, write=FOnNewShape};
	__property TTreeResizingShape OnResizingShape = {read=FOnResizingShape, write=FOnResizingShape};
	__property TNotifyConnectionEvent OnSelectConnection = {read=FOnSelectConnection, write=FOnSelectConnection};
	__property TNotifyShapeEvent OnSelectShape = {read=FOnSelectShape, write=FOnSelectShape};
	__property TShowHintShapeEvent OnShowHint = {read=FOnShowHint, write=FOnShowHint};
	__property TTreeSortCompareEvent OnSortCompare = {read=FOnSortCompare, write=FOnSortCompare};
	__property TNotifyShapeEventStartEdit OnStartEditing = {read=FOnStartEditing, write=FOnStartEditing};
	__property TNotifyShapeEvent OnStopEditing = {read=FOnStopEditing, write=FOnStopEditing};
	__property TNotifyConnectionEvent OnUnSelectConnection = {read=FOnUnSelectConnection, write=FOnUnSelectConnection};
	__property TNotifyShapeEvent OnUnSelectShape = {read=FOnUnSelectShape, write=FOnUnSelectShape};
	__property OnKeyDown;
};


class PASCALIMPLEMENTATION TTree : public TCustomTree
{
	typedef TCustomTree inherited;
	
__published:
	__property AllowDelete = {default=1};
	__property AllowPanning = {default=3};
	__property AllowResize = {default=1};
	__property AnimatedZoomSteps = {default=8};
	__property BackImage;
	__property BackImageMode = {default=0};
	__property BufferedDisplay = {default=1};
	__property CrossBox;
	__property Designing = {default=0};
	__property DragAndDrop;
	__property Gradient;
	__property Grid;
	__property HorzScrollBar;
	__property HotTrack;
	__property Images;
	__property Monochrome = {default=0};
	__property Page;
	__property PrintProportional = {default=1};
	__property ReadOnly = {default=0};
	__property ScrollMouseButton = {default=1};
	__property Selected;
	__property SingleSelection = {default=1};
	__property Shadow;
	__property ShowHintShapes = {default=1};
	__property ShowRootCross = {default=1};
	__property SnapToGrid = {default=1};
	__property TextEditor;
	__property VertScrollBar;
	__property View3DOptions;
	__property WheelNavigation = {default=0};
	__property Zoom;
	__property OnAddingConnection;
	__property OnAfterDraw;
	__property OnBeforeDraw;
	__property OnChanging;
	__property OnCheckedShape;
	__property OnClickBackground;
	__property OnClickConnection;
	__property OnClickShape;
	__property OnDblClickConnection;
	__property OnDblClickShape;
	__property OnDeletingShapes;
	__property OnDeletedShapes;
	__property OnExpandingCollapsing;
	__property OnExpandedCollapsed;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnMovingShape;
	__property OnMouseEnterShape;
	__property OnMouseLeaveShape;
	__property OnNewConnection;
	__property OnNewShape;
	__property OnResizingShape;
	__property OnSelectConnection;
	__property OnSelectShape;
	__property OnScroll;
	__property OnShowHint;
	__property OnSortCompare;
	__property OnStartEditing;
	__property OnStopEditing;
	__property OnUnSelectConnection;
	__property OnUnSelectShape;
	__property OnUndoZoom;
	__property OnZoom;
	__property Align = {default=0};
	__property BevelInner = {default=1};
	__property BevelOuter = {default=1};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property BorderStyle = {default=0};
	__property Color = {default=-1};
	__property DragMode = {default=0};
	__property Enabled;
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property Anchors;
	__property Locked = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragDropShape;
	__property OnDragOver;
	__property OnDragEnter;
	__property OnDragLeave;
	__property OnDragEnd;
	__property OnPainting;
	__property OnPaint;
	__property OnApplyStyleLookup;
	__property OnCanFocus;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
public:
	/* TCustomTree.Create */ inline __fastcall virtual TTree(System::Classes::TComponent* AOwner) : TCustomTree(AOwner) { }
	/* TCustomTree.Destroy */ inline __fastcall virtual ~TTree() { }
	
};


class PASCALIMPLEMENTATION TTreeClipboard : public TCustomTree
{
	typedef TCustomTree inherited;
	
private:
	TCustomTree* IsCut;
	
public:
	void __fastcall Copy(TCustomTree* const SourceTree);
	void __fastcall Cut(TCustomTree* const SourceTree);
	void __fastcall Paste(TCustomTree* const DestTree);
public:
	/* TCustomTree.Create */ inline __fastcall virtual TTreeClipboard(System::Classes::TComponent* AOwner) : TCustomTree(AOwner) { }
	/* TCustomTree.Destroy */ inline __fastcall virtual ~TTreeClipboard() { }
	
};


class PASCALIMPLEMENTATION TTreeCustomPolygonShape : public TCustomTreeShape
{
	typedef TCustomTreeShape inherited;
	
private:
	double FAngleOffset;
	void __fastcall SetAngleOffset(const double Value);
	
protected:
	int __fastcall GetPolygonPoints(int Sides, const System::Types::TRectF &R, TShapePoints &P);
	
__published:
	__property double AngleOffset = {read=FAngleOffset, write=SetAngleOffset};
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TTreeCustomPolygonShape(System::Classes::TComponent* AOwner) : TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTreeCustomPolygonShape() { }
	
};


class PASCALIMPLEMENTATION TImageLevels : public TImageList
{
	typedef TImageList inherited;
	
private:
	TCustomTree* FTree;
	System::StaticArray<Fmxtee::Canvas::TPicture*, 101> IPictures;
	Fmxtee::Canvas::TPicture* __fastcall NewPicture(const int Level);
	void __fastcall SetTree(TCustomTree* const Value);
	
protected:
	void __fastcall ClearPictures();
	Fmxtee::Canvas::TPicture* __fastcall GetPicture(int Level);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual ~TImageLevels();
	virtual void __fastcall Change();
	
__published:
	__property TCustomTree* Tree = {read=FTree, write=SetTree};
public:
	/* TComponent.Create */ inline __fastcall virtual TImageLevels(System::Classes::TComponent* AOwner) : TImageList(AOwner) { }
	
};


class PASCALIMPLEMENTATION TCustomTreeLink : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	TCustomTree* FTree;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetTree(TCustomTree* const Value);
	
__published:
	__property TCustomTree* Tree = {read=FTree, write=SetTree};
public:
	/* TComponent.Create */ inline __fastcall virtual TCustomTreeLink(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TCustomTreeLink() { }
	
};


class PASCALIMPLEMENTATION TCustomPanelTreeLink : public Fmx::Controls::TControl
{
	typedef Fmx::Controls::TControl inherited;
	
private:
	TCustomTree* FTree;
	virtual void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetTree(TCustomTree* const Value);
	
public:
	__fastcall virtual ~TCustomPanelTreeLink();
	__property TCustomTree* Tree = {read=FTree, write=SetTree};
public:
	/* TControl.Create */ inline __fastcall virtual TCustomPanelTreeLink(System::Classes::TComponent* AOwner) : Fmx::Controls::TControl(AOwner) { }
	
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};


enum DECLSPEC_DENUM TRulerUnits : unsigned char { ruPixels, ruCentimeters, ruInches };

typedef void __fastcall (__closure *TTreeRulerGetUnit)(TTreeRuler* Sender, int Pixel, System::UnicodeString &Text);

class PASCALIMPLEMENTATION TTreeRuler : public TCustomPanelTreeLink
{
	typedef TCustomPanelTreeLink inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FMarker;
	TTreeRulerGetUnit FOnGetUnit;
	bool FShowUnits;
	TRulerUnits FUnits;
	int IOldPos;
	bool __fastcall IsAlignLeft();
	bool __fastcall IsVerticalAlign();
	void __fastcall SetMarker(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetShowUnits(const bool Value);
	void __fastcall SetUnits(const TRulerUnits Value);
	virtual void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	System::UnicodeString __fastcall UnitsToStr(const int Pixels);
	
protected:
	virtual void __fastcall Paint();
	
public:
	__fastcall virtual TTreeRuler(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTreeRuler();
	void __fastcall DoMouseMove(int x, int y);
	
__published:
	__property Fmxtee::Canvas::TTeePen* Marker = {read=FMarker, write=SetMarker};
	__property bool ShowUnits = {read=FShowUnits, write=SetShowUnits, default=1};
	__property Tree;
	__property TRulerUnits Units = {read=FUnits, write=SetUnits, default=0};
	__property TTreeRulerGetUnit OnGetUnit = {read=FOnGetUnit, write=FOnGetUnit};
	__property OnKeyDown;
	__property OnKeyUp;
	__property Align = {default=0};
	__property DragMode = {default=0};
	__property Enabled;
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property Anchors;
	__property Locked = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDragEnter;
	__property OnDragLeave;
	__property OnDragEnd;
	__property OnPainting;
	__property OnPaint;
	__property OnApplyStyleLookup;
	__property OnCanFocus;
	__property OnResized;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
};


typedef void __fastcall (__closure *TTreeForEachCustomShapeProc)(const System::UnicodeString AGroup, const System::UnicodeString AName, TTreeNodeShapeClass AClass);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeImagePool : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<Fmxtee::Canvas::TPicture*> _TTreeImagePool__1;
	
	
public:
	Fmxtee::Canvas::TPicture* operator[](int Index) { return this->Image[Index]; }
	
private:
	_TTreeImagePool__1 FImages;
	Fmxtee::Canvas::TPicture* __fastcall GetImage(int Index);
	
public:
	__fastcall TTreeImagePool();
	__fastcall virtual ~TTreeImagePool();
	TTreeNodeImageIndex __fastcall Add(Fmxtee::Canvas::TPicture* const Picture)/* overload */;
	TTreeNodeImageIndex __fastcall Add(const System::UnicodeString FileName)/* overload */;
	int __fastcall Count();
	__property Fmxtee::Canvas::TPicture* Image[int Index] = {read=GetImage/*, default*/};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLoadTreeProc)(System::Classes::TReader* Reader, System::Classes::TStream* Stream);

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 TeeDefaultBoxSize = System::Int8(0x5);
static const System::Int8 TeeDefaultArrowSize = System::Int8(0x4);
static const System::Int8 TeeDefaultGridStep = System::Int8(0xa);
static const System::Word TeeDefaultMaxScroll = System::Word(0x3e8);
static const System::Int8 TeeDefaultMinScroll = System::Int8(0x0);
static const System::Int8 MaxShapePoints = System::Int8(0x64);
static const System::Int8 TeeTree_EditKey = System::Int8(0x71);
static const System::Int8 TeeTree_EscapeKey = System::Int8(0x1b);
static const System::Int8 TeeTree_HomeKey = System::Int8(0x24);
static const System::Int8 TeeTree_InsertKey = System::Int8(0x2d);
static const System::Int8 TeeTree_UpKey = System::Int8(0x26);
static const System::Int8 TeeTree_DownKey = System::Int8(0x28);
static const System::Int8 TeeTree_PriorKey = System::Int8(0x21);
static const System::Int8 TeeTree_NextKey = System::Int8(0x22);
static const System::Int8 TeeTree_RightKey = System::Int8(0x27);
static const System::Int8 TeeTree_LeftKey = System::Int8(0x25);
static const System::Int8 TeeTree_EndKey = System::Int8(0x23);
static const System::Int8 TeeTree_DeleteKey = System::Int8(0x2e);
static const System::Int8 TeeTree_ReturnKey = System::Int8(0xd);
static const System::Int8 TeeTree_SpaceKey = System::Int8(0x20);
static const System::Int8 TeeTree_F11Key = System::Int8(0x7a);
static const System::Int8 TreeDefaultImageHeight = System::Int8(0xd);
static const System::Int8 TreeDefaultImageWidth = System::Int8(0xf);
static const System::Int8 TreeHorizMarginDefault = System::Int8(0x13);
static const System::Int8 TreeVertMarginDefault = System::Int8(0x1);
static const System::Int8 TeeCrossBoxHorizMargin = System::Int8(0x5);
static const System::Int8 TeeTree_DefaultYPosition = System::Int8(0x2);
static const unsigned clWhite = unsigned(0xffffffff);
static const unsigned clBlack = unsigned(0xff000000);
static const unsigned clGray = unsigned(0xff808080);
static const unsigned clYellow = unsigned(0xffffff00);
static const unsigned clSilver = unsigned(0xffc0c0c0);
static const unsigned clRed = unsigned(0xffff0000);
static const unsigned clBlue = unsigned(0xff0000ff);
static const unsigned clGreen = unsigned(0xff008000);
#define TreeMsg_TeeExtension L"ttx"
#define TeeMsg_TreeFiles L"TeeTree v2 FMX files (*.ttx)|*.ttx"
#define TreeMsg_CannotSetShape L"Use the Tree property. Shapes property is read-only"
static const unsigned TeeHighLight = unsigned(0xff0000ff);
static const unsigned TeeHighLightUnfocused = unsigned(0xffa9a9a9);
static const unsigned TeeHighLightText = unsigned(0xffffffff);
static const System::Word TreeAllComponentPlatformIDs = System::Word(0x145f);
extern DELPHI_PACKAGE bool TeeTreeAnimatedScroll;
extern DELPHI_PACKAGE int TeeLineClickTolerance;
extern DELPHI_PACKAGE System::Uitypes::TCursor TeeConnectionCursor;
extern DELPHI_PACKAGE System::Uitypes::TCursor TeeConnectionPointCursor;
extern DELPHI_PACKAGE int TeePictureHorizMargin;
extern DELPHI_PACKAGE int TeePictureVertMargin;
extern DELPHI_PACKAGE int TeeTreeArrowMargin;
extern DELPHI_PACKAGE int TeeTextHorizMargin;
extern DELPHI_PACKAGE int TeeTextVertMargin;
extern DELPHI_PACKAGE int TeeTreeZ;
extern DELPHI_PACKAGE int TreePageScrollQuantity;
extern DELPHI_PACKAGE int TeeTreeDeleteKey;
extern DELPHI_PACKAGE int TreeListCapacity;
extern DELPHI_PACKAGE int TreeShapeListCapacity;
extern DELPHI_PACKAGE System::Generics::Collections::TList__1<void *>* TreeCustomShapes;
extern DELPHI_PACKAGE TTreeImagePool* TreeImagePool;
extern DELPHI_PACKAGE bool __fastcall Intersect(const System::Types::TRectF &R1, const System::Types::TRectF &R2);
extern DELPHI_PACKAGE void __fastcall SaveTreeToStream(TCustomTree* const Tree, System::Classes::TStream* const Stream);
extern DELPHI_PACKAGE void __fastcall SaveTreeToFile(TCustomTree* const Tree, const System::UnicodeString FileName);
extern DELPHI_PACKAGE void __fastcall LoadTreeFromStream(TCustomTree* &ATree, System::Classes::TStream* const AStream, TLoadTreeProc AProc)/* overload */;
extern DELPHI_PACKAGE void __fastcall LoadTreeFromStream(TCustomTree* &ATree, System::Classes::TStream* const AStream)/* overload */;
extern DELPHI_PACKAGE void __fastcall LoadTreeFromFile(TCustomTree* &ATree, const System::UnicodeString FileName, TLoadTreeProc AProc)/* overload */;
extern DELPHI_PACKAGE void __fastcall LoadTreeFromFile(TCustomTree* &ATree, const System::UnicodeString FileName)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LoadTreeFromFile(TCustomTree* &ATree)/* overload */;
extern DELPHI_PACKAGE System::Classes::TStream* __fastcall SaveTreeTextToStream(System::Classes::TStream* const Stream, TCustomTree* const Tree, TTreeNodeShape* const Node = (TTreeNodeShape*)(0x0));
extern DELPHI_PACKAGE void __fastcall SaveTreeToTextFile(TCustomTree* const Tree, const System::UnicodeString FileName)/* overload */;
extern DELPHI_PACKAGE void __fastcall SaveTreeToTextFile(TTreeNodeShape* const Node, const System::UnicodeString FileName)/* overload */;
extern DELPHI_PACKAGE void __fastcall UnRegisterCustomTreeShapes(TTreeNodeShapeClass const *AClass, const int AClass_High);
extern DELPHI_PACKAGE void __fastcall RegisterCustomTreeShape(const System::UnicodeString AGroup, const System::UnicodeString AName, const TTreeNodeShapeClass AClass);
extern DELPHI_PACKAGE void __fastcall TreeForEachCustomShape(const TTreeForEachCustomShapeProc ForEachProc);
}	/* namespace Tree */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TREE)
using namespace Fmxtee::Tree;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_TreeHPP
