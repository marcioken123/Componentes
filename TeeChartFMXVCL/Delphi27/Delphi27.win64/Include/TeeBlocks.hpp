// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeBlocks.pas' rev: 34.00 (Windows)

#ifndef TeeblocksHPP
#define TeeblocksHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.CheckLst.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <System.TypInfo.hpp>
#include <System.Variants.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeGLCanvas.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeGLSLShaders.hpp>
#include <VCLTee.OpenGL2.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeblocks
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBlockPicture;
class DELPHICLASS TTile;
class DELPHICLASS TRotationXYZ;
class DELPHICLASS TBlockTexture;
class DELPHICLASS TBlockBorder;
struct TRGBAlpha;
class DELPHICLASS TBlockFormat;
class DELPHICLASS TBlockActionItem;
class DELPHICLASS TBlockActions;
class DELPHICLASS TBlockBounds;
class DELPHICLASS TCustomBlock;
class DELPHICLASS TCubeSides;
class DELPHICLASS TCubeBlock;
class DELPHICLASS TCustomCoverBlock;
class DELPHICLASS TBlockEdge;
class DELPHICLASS TCylinderBlock;
class DELPHICLASS TEllipseBlock;
class DELPHICLASS TTeeTextBlock;
class DELPHICLASS TConeBlock;
class DELPHICLASS TLightBlock;
class DELPHICLASS TTetrahedronBlock;
class DELPHICLASS TTorusBlock;
class DELPHICLASS TEllipsoidBlock;
class DELPHICLASS TSphereBlock;
class DELPHICLASS TTubeBlock;
class DELPHICLASS TBeveledCubeBlock;
class DELPHICLASS TSliceEdges;
class DELPHICLASS TPieSliceBlock;
class DELPHICLASS TRectangleCorners;
class DELPHICLASS TRectangleSides;
class DELPHICLASS TRectangleBlock;
class DELPHICLASS TGradientBlock;
class DELPHICLASS TObjectProperties;
class DELPHICLASS TCustomObjectBlock;
class DELPHICLASS TObjectBlock;
class DELPHICLASS TObjectBlockHandle;
class DELPHICLASS TPyramidBlock;
class DELPHICLASS TPointXYZColor;
class DELPHICLASS TTriangleBlock;
class DELPHICLASS TBlockList;
class DELPHICLASS TAnimateItem;
class DELPHICLASS TAnimates;
struct TBlockShadows;
class DELPHICLASS TBlocks;
class DELPHICLASS TBlockClasses;
struct TPointSinCos;
class DELPHICLASS TMakerSystem;
struct TBounds;
class DELPHICLASS TActionEvent;
class DELPHICLASS TMakerEvents;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBlockPicture : public Vcl::Graphics::TPicture
{
	typedef Vcl::Graphics::TPicture inherited;
	
private:
	bool IBadFile;
	System::Classes::TThread* ILoadThread;
	void __fastcall TryLoad(const System::UnicodeString ParentSource, const System::UnicodeString Source);
	
protected:
	System::UnicodeString LoadedSource;
	
public:
	__classmethod Vcl::Graphics::TGraphicClass __fastcall FileGraphicClass(const System::UnicodeString FileName);
	__classmethod Vcl::Graphics::TGraphic* __fastcall LoadGraphicResource(const System::UnicodeString FileName);
	void __fastcall LoadFromURL(const System::UnicodeString URL);
public:
	/* TPicture.Create */ inline __fastcall TBlockPicture() : Vcl::Graphics::TPicture() { }
	/* TPicture.Destroy */ inline __fastcall virtual ~TBlockPicture() { }
	
};


class PASCALIMPLEMENTATION TTile : public Vcltee::Tecanvas::TPointXYZFloat
{
	typedef Vcltee::Tecanvas::TPointXYZFloat inherited;
	
private:
	Vcltee::Tecanvas::TPointXYZFloat* FOffset;
	Vcltee::Tecanvas::TPointXYZFloat* __fastcall GetOffset();
	void __fastcall SetOffset(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	
public:
	__fastcall virtual ~TTile();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TPointXYZFloat* Offset = {read=GetOffset, write=SetOffset};
public:
	/* TPointXYZFloat.Create */ inline __fastcall virtual TTile(Vcltee::Tecanvas::TVisualBlock* const AOwner, const double AValue, const System::Classes::TNotifyEvent ChangedEvent) : Vcltee::Tecanvas::TPointXYZFloat(AOwner, AValue, ChangedEvent) { }
	
};


typedef System::Math::Vectors::TPoint3D __fastcall (__closure *TOnGetPointXYZ)(void);

class PASCALIMPLEMENTATION TRotationXYZ : public Vcltee::Tecanvas::TPointXYZFloat
{
	typedef Vcltee::Tecanvas::TPointXYZFloat inherited;
	
private:
	Vcltee::Tecanvas::TPointXYZFloat* FCenter;
	bool FFaceToViewer;
	Vcltee::Tecanvas::TPointXYZFloat* __fastcall GetCenter();
	System::Math::Vectors::TPoint3D __fastcall GetPoint();
	void __fastcall SetCenter(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetFaceToViewer(const bool Value);
	
protected:
	TOnGetPointXYZ FOnGet;
	
public:
	__fastcall virtual ~TRotationXYZ();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TPointXYZFloat* Center = {read=GetCenter, write=SetCenter};
	__property bool FaceToViewer = {read=FFaceToViewer, write=SetFaceToViewer, default=0};
public:
	/* TPointXYZFloat.Create */ inline __fastcall virtual TRotationXYZ(Vcltee::Tecanvas::TVisualBlock* const AOwner, const double AValue, const System::Classes::TNotifyEvent ChangedEvent) : Vcltee::Tecanvas::TPointXYZFloat(AOwner, AValue, ChangedEvent) { }
	
};


class PASCALIMPLEMENTATION TBlockTexture : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FAlpha;
	bool FAlphaInvert;
	TBlockPicture* FPicture;
	System::UnicodeString FPictureLink;
	double FRotation;
	Vcl::Graphics::TGraphic* IAlphaBitmap;
	System::Classes::TNotifyEvent IChanged;
	TBlockFormat* IFormat;
	bool ISharedPicture;
	System::Types::TPoint ITextureSize;
	void __fastcall Changed(System::TObject* Sender);
	void __fastcall CheckPicTransp();
	TBlockPicture* __fastcall GetPicture();
	Vcltee::Tecanvas::TPointXYZFloat* __fastcall GetScale();
	Vcltee::Tecanvas::TPointXYZFloat* __fastcall GetTranslate();
	bool __fastcall IsPictureStored();
	bool __fastcall IsRotationStored();
	TBlockFormat* __fastcall OtherHasSamePictureLink(bool SharedOnly);
	void __fastcall SetAlpha(const bool Value);
	void __fastcall SetAlphaInvert(const bool Value);
	void __fastcall SetPicture(TBlockPicture* const Value);
	void __fastcall SetPictureLink(const System::UnicodeString Value);
	void __fastcall SetRotation(const double Value);
	void __fastcall SetScale(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetTranslate(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetTransp(const bool Value);
	void __fastcall TryFreePicture();
	
protected:
	Vcltee::Tecanvas::TPointXYZFloat* FScale;
	Vcltee::Tecanvas::TPointXYZFloat* FTranslate;
	bool FTransp;
	bool __fastcall HasTexture();
	void __fastcall SetAutomatic(bool Value);
	void __fastcall SetEmbeddedPicture();
	
public:
	__fastcall TBlockTexture();
	__fastcall virtual ~TBlockTexture();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall AssignPicture(Vcl::Graphics::TPicture* const Value);
	void __fastcall Coord(const float X, const float Y);
	
__published:
	__property bool AlphaInvert = {read=FAlphaInvert, write=SetAlphaInvert, default=0};
	__property TBlockPicture* Picture = {read=GetPicture, write=SetPicture, stored=IsPictureStored};
	__property bool PictureAlpha = {read=FAlpha, write=SetAlpha, default=0};
	__property System::UnicodeString PictureLink = {read=FPictureLink, write=SetPictureLink};
	__property bool PictureTransparent = {read=FTransp, write=SetTransp, default=0};
	__property double Rotation = {read=FRotation, write=SetRotation, stored=IsRotationStored};
	__property Vcltee::Tecanvas::TPointXYZFloat* Scale = {read=GetScale, write=SetScale};
	__property Vcltee::Tecanvas::TPointXYZFloat* Translate = {read=GetTranslate, write=SetTranslate};
};


class PASCALIMPLEMENTATION TBlockBorder : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Uitypes::TColor FColor;
	Vcl::Graphics::TPenStyle FStyle;
	System::Byte FTransp;
	bool FVisible;
	int FWidth;
	bool IDefaultVisible;
	TBlockFormat* IOwner;
	void __fastcall Changed();
	bool __fastcall IsVisibleStored();
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetStyle(const Vcl::Graphics::TPenStyle Value);
	void __fastcall SetTransp(const System::Byte Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	System::Classes::TNotifyEvent IChanged;
	void __fastcall InitVisible(const bool Value);
	
public:
	__fastcall TBlockBorder();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=0};
	__property Vcl::Graphics::TPenStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::Byte Transparency = {read=FTransp, write=SetTransp, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, stored=IsVisibleStored, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBlockBorder() { }
	
};


struct DECLSPEC_DRECORD TRGBAlpha
{
public:
	System::Byte Red;
	System::Byte Green;
	System::Byte Blue;
	System::Byte Alpha;
};


class PASCALIMPLEMENTATION TBlockFormat : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TBlockBorder* FBorder;
	bool FBright;
	System::Uitypes::TColor FColor;
	bool FDrawInside;
	bool FParentTexture;
	int FShininess;
	bool FSolid;
	TBlockTexture* FTexture;
	System::Byte FTransparency;
	System::Classes::TNotifyEvent IChanged;
	float IOldShin;
	bool IRotatedTexture;
	bool ITextureEnabled;
	bool IWasMultiSample;
	void __fastcall CheckBlend();
	TBlockBorder* __fastcall GetBorder();
	void __fastcall SetBorder(TBlockBorder* const Value);
	void __fastcall SetBright(const bool Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetDrawInside(const bool Value);
	void __fastcall SetParentTexture(const bool Value);
	void __fastcall SetShininess(const int Value);
	void __fastcall SetSolid(const bool Value);
	void __fastcall SetTexture(TBlockTexture* const Value);
	void __fastcall SetTransparency(const System::Byte Value);
	
protected:
	System::Uitypes::TColor ICurrentColor;
	TCustomBlock* IOwner;
	System::Classes::TNotifyEvent OnColorChanged;
	void __fastcall ConcavePolygon(int &AList, const System::Math::Vectors::TPoint3D *P, const int P_High, bool Invert = false);
	void __fastcall ConvexPolygon(int &AList, const System::Math::Vectors::TPoint3D *Points, const int Points_High, bool Invert = false);
	void __fastcall DoSetBrush();
	void __fastcall FinishPen();
	System::Uitypes::TColor __fastcall GetRealColor();
	void __fastcall FinishTransparency(const int Value);
	void __fastcall InitTransparency(const System::Byte Value);
	bool __fastcall InternalPreparePen();
	void __fastcall PolylineList(/* out */ int &AList, const Vcltee::Tecanvas::TPoint3DArray P);
	void __fastcall PrepareColor(const System::Uitypes::TColor AColor)/* overload */;
	void __fastcall PrepareColor()/* overload */;
	void __fastcall Start();
	void __fastcall Finish();
	bool __fastcall PreparePen();
	void __fastcall SetDirectColor(const System::Uitypes::TColor AColor);
	
public:
	__fastcall TBlockFormat(TCustomBlock* AOwner);
	__fastcall virtual ~TBlockFormat();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod TRGBAlpha __fastcall ColorToGL(const System::Uitypes::TColor AColor);
	__property TCustomBlock* Block = {read=IOwner};
	
__published:
	__property TBlockBorder* Border = {read=GetBorder, write=SetBorder};
	__property bool Bright = {read=FBright, write=SetBright, default=0};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=536870912};
	__property bool ParentTexture = {read=FParentTexture, write=SetParentTexture, default=1};
	__property int Shininess = {read=FShininess, write=SetShininess, default=0};
	__property bool Solid = {read=FSolid, write=SetSolid, default=1};
	__property TBlockTexture* Texture = {read=FTexture, write=SetTexture};
	__property System::Byte Transparency = {read=FTransparency, write=SetTransparency, default=0};
	__property bool VisibleInterior = {read=FDrawInside, write=SetDrawInside, default=0};
};


class PASCALIMPLEMENTATION TBlockActionItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Classes::TStrings* FActions;
	System::UnicodeString FTrigger;
	void __fastcall SetActions(System::Classes::TStrings* const Value);
	void __fastcall SetTrigger(const System::UnicodeString Value);
	
public:
	__fastcall virtual TBlockActionItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TBlockActionItem();
	void __fastcall Add(const System::UnicodeString Action);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Classes::TStrings* Actions = {read=FActions, write=SetActions};
	__property System::UnicodeString Trigger = {read=FTrigger, write=SetTrigger};
};


class PASCALIMPLEMENTATION TBlockActions : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TBlockActionItem* operator[](int Index) { return this->Action[Index]; }
	
private:
	TBlockActionItem* __fastcall Get(int Index);
	void __fastcall Put(int Index, TBlockActionItem* const Value);
	
public:
	static int __fastcall ActionToIndex(const System::UnicodeString Action);
	HIDESBASE TBlockActionItem* __fastcall Add(System::UnicodeString Trigger);
	TBlockActionItem* __fastcall OfEvent(System::UnicodeString AEvent);
	__property TBlockActionItem* Action[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TBlockActions(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TBlockActions() { }
	
};


class PASCALIMPLEMENTATION TBlockBounds : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TCustomBlock* IBlock;
	double __fastcall GetLeft();
	double __fastcall GetRight();
	double __fastcall GetTop();
	double __fastcall GetBottom();
	double __fastcall GetFront();
	double __fastcall GetBack();
	void __fastcall SetLeft(const double Value);
	void __fastcall SetRight(const double Value);
	void __fastcall SetTop(const double Value);
	void __fastcall SetBottom(const double Value);
	void __fastcall SetFront(const double Value);
	void __fastcall SetBack(const double Value);
	
__published:
	__property double Left = {read=GetLeft, write=SetLeft};
	__property double Right = {read=GetRight, write=SetRight};
	__property double Top = {read=GetTop, write=SetTop};
	__property double Bottom = {read=GetBottom, write=SetBottom};
	__property double Front = {read=GetFront, write=SetFront};
	__property double Back = {read=GetBack, write=SetBack};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBlockBounds() { }
	
public:
	/* TObject.Create */ inline __fastcall TBlockBounds() : System::Classes::TPersistent() { }
	
};


typedef void __fastcall (__closure *TNotifyBlockEvent)(TCustomBlock* const Sender);

class PASCALIMPLEMENTATION TCustomBlock : public Vcltee::Tecanvas::TVisualBlock
{
	typedef Vcltee::Tecanvas::TVisualBlock inherited;
	
private:
	TBlockActions* FActions;
	TBlockBounds* FBounds;
	System::Uitypes::TCursor FCursor;
	TBlockFormat* FFormat;
	TRotationXYZ* FRotation;
	Vcltee::Tecanvas::TPointXYZFloat* FScale;
	TTile* FTile;
	System::UnicodeString FTitle;
	bool FVisible;
	bool IShown;
	bool IsObjectBlock;
	Vcl::Controls::TMouseEvent FOnClick;
	TNotifyBlockEvent FOnDragging;
	TNotifyBlockEvent FOnShow;
	void __fastcall CheckOnShow();
	TBlockActions* __fastcall GetActions();
	int __fastcall GetBlockIndex();
	TBlockBounds* __fastcall GetBounds();
	System::Uitypes::TCursor __fastcall GetCursor();
	TRotationXYZ* __fastcall GetRotation();
	Vcltee::Tecanvas::TPointXYZFloat* __fastcall GetScale();
	TTile* __fastcall GetTile();
	bool __fastcall IsActionsStored();
	void __fastcall SetActions(TBlockActions* const Value);
	void __fastcall SetCursor(const System::Uitypes::TCursor Value);
	void __fastcall SetBlockIndex(int AIndex);
	void __fastcall SetBlockBounds(TBlockBounds* const Value);
	void __fastcall SetFormat(TBlockFormat* const Value);
	void __fastcall SetRotation(TRotationXYZ* const Value);
	void __fastcall SetScale(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetTile(TTile* const Value);
	void __fastcall SetTitle(const System::UnicodeString Value);
	
protected:
	TBlocks* IBlocks;
	Vcltee::Teeglcanvas::TGLCanvas* ICanvas;
	System::TObject* IData;
	bool IPicking;
	void __fastcall DefaultTransform();
	DYNAMIC TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	void __fastcall Dragged();
	DYNAMIC void __fastcall DrawSelected();
	void __fastcall GetRotationCenter(/* out */ float &AX, /* out */ float &AY, /* out */ float &AZ, bool AddParents);
	System::Math::Vectors::TPoint3D __fastcall InternalProjectPoint(const Vcltee::Opengl2::THomogeneousDblMatrix &Matrix, const float X, const float Y, const float Z);
	void __fastcall InternalTransform();
	void __fastcall ModelMatrix(/* out */ Vcltee::Opengl2::THomogeneousDblMatrix &AMatrix);
	System::UnicodeString __fastcall TitleOrName();
	virtual void __fastcall StartTransform();
	void __fastcall EndTransform();
	int __fastcall CreateNewList();
	void __fastcall DeleteList(int &AList);
	virtual void __fastcall DeleteLists();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner();
	bool __fastcall HasActions(System::UnicodeString AEvent = System::UnicodeString());
	bool __fastcall HasRotation();
	bool __fastcall HasScale();
	bool __fastcall HasTile();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall SetBlocks(TBlocks* const Value);
	virtual void __fastcall SetFormatting(Vcltee::Tecanvas::TTeePen* const APen, Vcltee::Tecanvas::TTeeBrush* const ABrush, bool SetBrushImage, System::Uitypes::TColor AColor, System::Byte ATransparency);
	DYNAMIC void __fastcall PrepareForGallery();
	DYNAMIC void __fastcall SetParentComponent(System::Classes::TComponent* AParent);
	virtual bool __fastcall ShouldDraw(bool After = false);
	bool __fastcall ShouldDrawInterior();
	virtual void __fastcall SetVisible(const bool Value);
	DYNAMIC bool __fastcall UsesDepth();
	
public:
	__fastcall virtual TCustomBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual bool __fastcall BoundingBox(/* out */ System::Math::Vectors::TPoint3D &AMin, /* out */ System::Math::Vectors::TPoint3D &AMax);
	void __fastcall CalcBounds(System::Math::Vectors::TPoint3D &AMin, System::Math::Vectors::TPoint3D &AMax);
	virtual void __fastcall Clear();
	TCustomBlock* __fastcall Clicked(int X, int Y);
	TCustomBlock* __fastcall Clone();
	virtual void __fastcall Draw() = 0 ;
	void __fastcall DrawBlock(TBlocks* AItems)/* overload */;
	virtual void __fastcall DrawBlock()/* overload */;
	virtual Vcl::Controls::TControl* __fastcall Editor(System::Classes::TComponent* const AOwner, bool Embeddable = false);
	void __fastcall InitTitle(const System::UnicodeString Prefix);
	void __fastcall Move(const float AX, const float AY, const float AZ);
	System::Math::Vectors::TPoint3D __fastcall ProjectPoint(const float X, const float Y, const float Z);
	virtual void __fastcall Repaint();
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent();
	DYNAMIC bool __fastcall HasParent();
	__property int Index = {read=GetBlockIndex, write=SetBlockIndex, nodefault};
	__property TBlocks* Parent = {read=IBlocks, write=SetBlocks};
	
__published:
	__property TBlockActions* Actions = {read=GetActions, write=SetActions, stored=IsActionsStored};
	__property TBlockBounds* Bounds = {read=GetBounds, write=SetBlockBounds, stored=false};
	__property System::Uitypes::TCursor Cursor = {read=GetCursor, write=SetCursor, default=0};
	__property TBlockFormat* Format = {read=FFormat, write=SetFormat};
	__property TRotationXYZ* Rotation = {read=GetRotation, write=SetRotation};
	__property Vcltee::Tecanvas::TPointXYZFloat* Scale = {read=GetScale, write=SetScale};
	__property TTile* Tile = {read=GetTile, write=SetTile};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Vcl::Controls::TMouseEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TNotifyBlockEvent OnDragging = {read=FOnDragging, write=FOnDragging};
	__property TNotifyBlockEvent OnShow = {read=FOnShow, write=FOnShow};
};


class PASCALIMPLEMENTATION TCubeSides : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool IAnyUsed;
	TCustomBlock* IOwner;
	bool __fastcall AllVisible();
	TBlockFormat* __fastcall CreateFormat();
	void __fastcall FormatChanged(System::TObject* Sender);
	void __fastcall FreeAndCheck(TBlockFormat* &ASide);
	TBlockFormat* __fastcall GetLeft();
	TBlockFormat* __fastcall GetTop();
	TBlockFormat* __fastcall GetRight();
	TBlockFormat* __fastcall GetBottom();
	TBlockFormat* __fastcall GetBack();
	TBlockFormat* __fastcall GetFront();
	bool __fastcall IsLeftStored();
	bool __fastcall IsTopStored();
	bool __fastcall IsRightStored();
	bool __fastcall IsBottomStored();
	bool __fastcall IsBackStored();
	bool __fastcall IsFrontStored();
	void __fastcall SetLeft(TBlockFormat* const Value);
	void __fastcall SetTop(TBlockFormat* const Value);
	void __fastcall SetRight(TBlockFormat* const Value);
	void __fastcall SetBottom(TBlockFormat* const Value);
	void __fastcall SetBack(TBlockFormat* const Value);
	void __fastcall SetFront(TBlockFormat* const Value);
	
protected:
	TBlockFormat* FLeft;
	TBlockFormat* FTop;
	TBlockFormat* FRight;
	TBlockFormat* FBottom;
	TBlockFormat* FBack;
	TBlockFormat* FFront;
	
public:
	__fastcall TCubeSides(TCustomBlock* AOwner);
	__fastcall virtual ~TCubeSides();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	TBlockFormat* __fastcall SideOf(int Index);
	
__published:
	__property TBlockFormat* Left = {read=GetLeft, write=SetLeft, stored=IsLeftStored};
	__property TBlockFormat* Top = {read=GetTop, write=SetTop, stored=IsTopStored};
	__property TBlockFormat* Right = {read=GetRight, write=SetRight, stored=IsRightStored};
	__property TBlockFormat* Bottom = {read=GetBottom, write=SetBottom, stored=IsBottomStored};
	__property TBlockFormat* Back = {read=GetBack, write=SetBack, stored=IsBackStored};
	__property TBlockFormat* Front = {read=GetFront, write=SetFront, stored=IsFrontStored};
};


class PASCALIMPLEMENTATION TCubeBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	TCubeSides* FSides;
	int IListPen;
	void __fastcall SetSides(TCubeSides* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	
public:
	__fastcall virtual TCubeBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCubeBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property TCubeSides* Sides = {read=FSides, write=SetSides};
};


class PASCALIMPLEMENTATION TCustomCoverBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	TBlockFormat* __fastcall Get1();
	TBlockFormat* __fastcall Get2();
	void __fastcall Set1(TBlockFormat* const Value);
	void __fastcall Set2(TBlockFormat* const Value);
	
protected:
	TBlockFormat* FBrush1;
	TBlockFormat* FBrush2;
	
public:
	__fastcall virtual ~TCustomCoverBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall HasBrush1();
	bool __fastcall HasBrush2();
	
__published:
	__property TBlockFormat* Brush1 = {read=Get1, write=Set1, stored=HasBrush1};
	__property TBlockFormat* Brush2 = {read=Get2, write=Set2, stored=HasBrush2};
public:
	/* TCustomBlock.Create */ inline __fastcall virtual TCustomCoverBlock(System::Classes::TComponent* AOwner) : TCustomBlock(AOwner) { }
	
};


enum DECLSPEC_DENUM TBlockEdgeStyle : unsigned char { resRound, resBevel };

class PASCALIMPLEMENTATION TBlockEdge : public Vcltee::Tecanvas::TPointXYFloat
{
	typedef Vcltee::Tecanvas::TPointXYFloat inherited;
	
private:
	int FSlices;
	TBlockEdgeStyle FStyle;
	bool __fastcall Active();
	void __fastcall SetSlices(const int Value);
	void __fastcall SetStyle(const TBlockEdgeStyle Value);
	
public:
	__fastcall virtual TBlockEdge(Vcltee::Tecanvas::TVisualBlock* const AOwner, const float AValue, const System::Classes::TNotifyEvent CanvasChanged);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int Slices = {read=FSlices, write=SetSlices, default=16};
	__property TBlockEdgeStyle Style = {read=FStyle, write=SetStyle, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBlockEdge() { }
	
};


class PASCALIMPLEMENTATION TCylinderBlock : public TCustomCoverBlock
{
	typedef TCustomCoverBlock inherited;
	
private:
	int FAngle;
	TBlockEdge* FBottomEdge;
	int FSlices;
	int FStacks;
	int FStartAngle;
	TBlockEdge* FTopEdge;
	int ICoverList1;
	int ICoverList2;
	TBlockFormat* ICurrentFormat;
	int IList;
	int IListCover;
	Vcltee::Tecanvas::TPoint3DArray IStackData;
	void __fastcall Changed(System::TObject* Sender);
	TBlockFormat* __fastcall GetCover();
	void __fastcall SetAngle(const int Value);
	void __fastcall SetBottomEdge(TBlockEdge* const Value);
	void __fastcall SetCover(TBlockFormat* const Value);
	void __fastcall SetSlices(const int Value);
	void __fastcall SetStacks(const int Value);
	void __fastcall SetStartAngle(const int Value);
	void __fastcall SetTopEdge(TBlockEdge* const Value);
	
protected:
	TBlockFormat* FBrushCover;
	float IConeX;
	float IConeY;
	Vcltee::Tecanvas::TFloatPoint ICoverHole;
	bool IHideCovers;
	virtual void __fastcall DeleteLists();
	DYNAMIC TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TCylinderBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCylinderBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	bool __fastcall HasBrushCover();
	
__published:
	__property int Angle = {read=FAngle, write=SetAngle, default=360};
	__property TBlockEdge* BottomEdge = {read=FBottomEdge, write=SetBottomEdge};
	__property TBlockFormat* BrushCover = {read=GetCover, write=SetCover};
	__property int Slices = {read=FSlices, write=SetSlices, default=32};
	__property int Stacks = {read=FStacks, write=SetStacks, default=1};
	__property int StartAngle = {read=FStartAngle, write=SetStartAngle, default=0};
	__property TBlockEdge* TopEdge = {read=FTopEdge, write=SetTopEdge};
};


class PASCALIMPLEMENTATION TEllipseBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	int FSlices;
	int IListSolid;
	int IListBorder;
	void __fastcall SetSlices(const int Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TEllipseBlock(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property int Slices = {read=FSlices, write=SetSlices, default=90};
public:
	/* TCustomBlock.Destroy */ inline __fastcall virtual ~TEllipseBlock() { }
	
};


class PASCALIMPLEMENTATION TTeeTextBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	System::Classes::TAlignment FAlign;
	Vcltee::Tecanvas::TTeeFont* FFont;
	Vcltee::Tecanvas::TTeeFontStyle FFontStyle;
	System::Classes::TStrings* FLines;
	Vcltee::Teeanimate::TPropertyLink* FLink;
	System::UnicodeString FLinkFormat;
	bool IChanged;
	bool IExtentOk;
	int IFont;
	System::UnicodeString ILinkText;
	System::Types::TPoint ITextExtent;
	void __fastcall ColorChanged(System::TObject* Sender);
	System::Variant __fastcall DoGetPropValue(System::TObject* AInstance, const System::UnicodeString AProp);
	System::UnicodeString __fastcall GetText();
	void __fastcall SetAlign(const System::Classes::TAlignment Value);
	void __fastcall SetFont(Vcltee::Tecanvas::TTeeFont* const Value);
	void __fastcall SetFontStyle(const Vcltee::Tecanvas::TTeeFontStyle Value);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	void __fastcall SetLink(Vcltee::Teeanimate::TPropertyLink* const Value);
	void __fastcall SetLinkFormat(const System::UnicodeString Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall TextChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall DeleteLists();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TTeeTextBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeTextBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	
__published:
	__property System::Classes::TAlignment Alignment = {read=FAlign, write=SetAlign, default=0};
	__property Vcltee::Tecanvas::TTeeFont* Font = {read=FFont, write=SetFont};
	__property Vcltee::Tecanvas::TTeeFontStyle FontStyle = {read=FFontStyle, write=SetFontStyle, default=0};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property System::UnicodeString LinkFormat = {read=FLinkFormat, write=SetLinkFormat};
	__property Vcltee::Teeanimate::TPropertyLink* LinkText = {read=FLink, write=SetLink};
};


class PASCALIMPLEMENTATION TConeBlock : public TCylinderBlock
{
	typedef TCylinderBlock inherited;
	
private:
	Vcltee::Tecanvas::TPointXYFloat* FConeSize;
	void __fastcall ConeSizeChanged(System::TObject* Sender);
	void __fastcall SetConeSize(Vcltee::Tecanvas::TPointXYFloat* const Value);
	
protected:
	DYNAMIC TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TConeBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TConeBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property Vcltee::Tecanvas::TPointXYFloat* ConeSize = {read=FConeSize, write=SetConeSize};
	__property Stacks = {default=32};
};


class PASCALIMPLEMENTATION TLightBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	System::Uitypes::TColor FDiffuse;
	bool FFixed;
	System::Uitypes::TColor FSpecular;
	int FSpot;
	int FSpotExp;
	bool FUseDirection;
	TConeBlock* ILamp;
	bool __fastcall GetShowLamp();
	void __fastcall SetDiffuse(const System::Uitypes::TColor Value);
	void __fastcall SetFixed(const bool Value);
	void __fastcall SetShowLamp(const bool Value);
	void __fastcall SetSpecular(const System::Uitypes::TColor Value);
	void __fastcall SetSpot(const int Value);
	void __fastcall SetSpotExp(const int Value);
	void __fastcall SetUseDirection(const bool Value);
	
protected:
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TLightBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLightBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual bool __fastcall BoundingBox(/* out */ System::Math::Vectors::TPoint3D &AMin, /* out */ System::Math::Vectors::TPoint3D &AMax);
	virtual void __fastcall Draw();
	__classmethod void __fastcall GLColor(const System::Uitypes::TColor AColor, Vcltee::Teeglcanvas::GLMat &Value);
	void __fastcall InitLight();
	
__published:
	__property System::Uitypes::TColor Diffuse = {read=FDiffuse, write=SetDiffuse, default=16777215};
	__property bool Fixed = {read=FFixed, write=SetFixed, default=0};
	__property bool ShowLamp = {read=GetShowLamp, write=SetShowLamp, default=1};
	__property System::Uitypes::TColor Specular = {read=FSpecular, write=SetSpecular, default=16777215};
	__property int Spot = {read=FSpot, write=SetSpot, default=45};
	__property int SpotExponent = {read=FSpotExp, write=SetSpotExp, default=14};
	__property bool UseDirection = {read=FUseDirection, write=SetUseDirection, default=1};
};


class PASCALIMPLEMENTATION TTetrahedronBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
public:
	virtual void __fastcall Draw();
public:
	/* TCustomBlock.Create */ inline __fastcall virtual TTetrahedronBlock(System::Classes::TComponent* AOwner) : TCustomBlock(AOwner) { }
	/* TCustomBlock.Destroy */ inline __fastcall virtual ~TTetrahedronBlock() { }
	
};


class PASCALIMPLEMENTATION TTorusBlock : public TCustomCoverBlock
{
	typedef TCustomCoverBlock inherited;
	
private:
	Vcltee::Tecanvas::TPointXYFloat* FRadius;
	int FRings;
	int FSides;
	double FStartAngle;
	double FTotalAngle;
	int IList;
	int IListSide1;
	int IListSide2;
	void __fastcall RadiusChanged(System::TObject* Sender);
	void __fastcall SetRings(const int Value);
	void __fastcall SetSides(const int Value);
	void __fastcall SetStartAngle(const double Value);
	void __fastcall SetTotalAngle(const double Value);
	void __fastcall SetRadius(Vcltee::Tecanvas::TPointXYFloat* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TTorusBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTorusBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	
__published:
	__property Vcltee::Tecanvas::TPointXYFloat* Radius = {read=FRadius, write=SetRadius};
	__property int Rings = {read=FRings, write=SetRings, default=30};
	__property int Sides = {read=FSides, write=SetSides, default=20};
	__property double StartAngle = {read=FStartAngle, write=SetStartAngle};
	__property double TotalAngle = {read=FTotalAngle, write=SetTotalAngle};
};


class PASCALIMPLEMENTATION TEllipsoidBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	double FEccentricity;
	int FSides;
	int FStacks;
	double FTotal;
	double FTotalAngle;
	int IListSphere;
	int IListCover;
	TBlockFormat* __fastcall GetCover();
	bool __fastcall IsTotalStored();
	void __fastcall SetCover(TBlockFormat* const Value);
	void __fastcall SetEccentricity(const double Value);
	void __fastcall SetSides(const int Value);
	void __fastcall SetStacks(const int Value);
	void __fastcall SetTotal(const double Value);
	void __fastcall SetTotalAngle(const double Value);
	
protected:
	TBlockFormat* FCover;
	virtual void __fastcall DeleteLists();
	DYNAMIC TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TEllipsoidBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TEllipsoidBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	bool __fastcall HasCover();
	
__published:
	__property TBlockFormat* Cover = {read=GetCover, write=SetCover};
	__property double Eccentricity = {read=FEccentricity, write=SetEccentricity};
	__property int Sides = {read=FSides, write=SetSides, default=32};
	__property int Stacks = {read=FStacks, write=SetStacks, default=32};
	__property double Total = {read=FTotal, write=SetTotal, stored=IsTotalStored};
	__property double TotalAngle = {read=FTotalAngle, write=SetTotalAngle};
};


class PASCALIMPLEMENTATION TSphereBlock : public TEllipsoidBlock
{
	typedef TEllipsoidBlock inherited;
	
private:
	double __fastcall GetRadius();
	void __fastcall SetRadius(const double Value);
	
public:
	__fastcall virtual TSphereBlock(System::Classes::TComponent* AOwner);
	
__published:
	__property double Radius = {read=GetRadius, write=SetRadius};
public:
	/* TEllipsoidBlock.Destroy */ inline __fastcall virtual ~TSphereBlock() { }
	
};


class PASCALIMPLEMENTATION TTubeBlock : public TConeBlock
{
	typedef TConeBlock inherited;
	
private:
	TBlockFormat* FTube;
	void __fastcall SetTube(TBlockFormat* const Value);
	
public:
	__fastcall virtual TTubeBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTubeBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property Stacks = {default=1};
	__property TBlockFormat* Tube = {read=FTube, write=SetTube};
};


enum DECLSPEC_DENUM TBevelCubeStyle : unsigned char { bsRound, bsBevel, bsCut };

enum DECLSPEC_DENUM TBevelSizeStyle : unsigned char { bsPercentMin, bsPercent };

class PASCALIMPLEMENTATION TBeveledCubeBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	Vcltee::Tecanvas::TPointXYZFloat* FBevelSize;
	TBevelSizeStyle FBevelSizeStyle;
	int FCurvePoints;
	bool FCurveRound;
	TBevelCubeStyle FStyle;
	int IList;
	int IListBorder;
	void __fastcall BevelChanged(System::TObject* Sender);
	void __fastcall SetBevelSize(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetBevelSizeStyle(const TBevelSizeStyle Value);
	void __fastcall SetCurvePoints(const int Value);
	void __fastcall SetCurveRound(const bool Value);
	void __fastcall SetStyle(const TBevelCubeStyle Value);
	
protected:
	virtual void __fastcall DeleteLists();
	
public:
	__fastcall virtual TBeveledCubeBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBeveledCubeBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property Vcltee::Tecanvas::TPointXYZFloat* BevelSize = {read=FBevelSize, write=SetBevelSize};
	__property TBevelSizeStyle BevelSizeStyle = {read=FBevelSizeStyle, write=SetBevelSizeStyle, default=0};
	__property int CurvePoints = {read=FCurvePoints, write=SetCurvePoints, default=8};
	__property bool CurveRound = {read=FCurveRound, write=SetCurveRound, default=1};
	__property TBevelCubeStyle Style = {read=FStyle, write=SetStyle, default=0};
};


class PASCALIMPLEMENTATION TSliceEdges : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TBlockEdge* FInnerBottom;
	TBlockEdge* FInnerTop;
	TBlockEdge* FOuterBottom;
	TBlockEdge* FOuterTop;
	void __fastcall SetInnerBottom(TBlockEdge* const Value);
	void __fastcall SetInnerTop(TBlockEdge* const Value);
	void __fastcall SetOuterBottom(TBlockEdge* const Value);
	void __fastcall SetOuterTop(TBlockEdge* const Value);
	
public:
	__fastcall TSliceEdges(TCustomBlock* AOwner, System::Classes::TNotifyEvent Changed);
	__fastcall virtual ~TSliceEdges();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TBlockEdge* InnerBottom = {read=FInnerBottom, write=SetInnerBottom};
	__property TBlockEdge* InnerTop = {read=FInnerTop, write=SetInnerTop};
	__property TBlockEdge* OuterBottom = {read=FOuterBottom, write=SetOuterBottom};
	__property TBlockEdge* OuterTop = {read=FOuterTop, write=SetOuterTop};
};


class PASCALIMPLEMENTATION TPieSliceBlock : public TCustomCoverBlock
{
	typedef TCustomCoverBlock inherited;
	
private:
	double FAngle;
	double FStacks;
	double FDonutPercent;
	TSliceEdges* FEdges;
	double FStartAngle;
	int IList;
	int IListSide1;
	int IListSide2;
	int IListPenSide1;
	int IListPenSide2;
	Vcltee::Tecanvas::TPointXYFloat* FInnerSize;
	void __fastcall DataChanged(System::TObject* Sender);
	bool __fastcall IsStacksStored();
	void __fastcall SetAngle(const double Value);
	void __fastcall SetStacks(const double Value);
	void __fastcall SetDonut(const double Value);
	void __fastcall SetEdges(TSliceEdges* const Value);
	void __fastcall SetStartAngle(const double Value);
	void __fastcall SetInnerSize(Vcltee::Tecanvas::TPointXYFloat* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TPieSliceBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPieSliceBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property double Angle = {read=FAngle, write=SetAngle};
	__property double DonutPercent = {read=FDonutPercent, write=SetDonut};
	__property TSliceEdges* Edges = {read=FEdges, write=SetEdges};
	__property Vcltee::Tecanvas::TPointXYFloat* InnerSize = {read=FInnerSize, write=SetInnerSize};
	__property double Stacks = {read=FStacks, write=SetStacks, stored=IsStacksStored};
	__property double StartAngle = {read=FStartAngle, write=SetStartAngle};
};


class PASCALIMPLEMENTATION TRectangleCorners : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Uitypes::TColor FLeftTop;
	System::Uitypes::TColor FRightTop;
	System::Uitypes::TColor FLeftBottom;
	System::Uitypes::TColor FRightBottom;
	TRectangleBlock* IOwner;
	void __fastcall SetLeftTop(const System::Uitypes::TColor Value);
	void __fastcall SetRightTop(const System::Uitypes::TColor Value);
	void __fastcall SetLeftBottom(const System::Uitypes::TColor Value);
	void __fastcall SetRightBottom(const System::Uitypes::TColor Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor LeftTop = {read=FLeftTop, write=SetLeftTop, default=536870912};
	__property System::Uitypes::TColor RightTop = {read=FRightTop, write=SetRightTop, default=536870912};
	__property System::Uitypes::TColor LeftBottom = {read=FLeftBottom, write=SetLeftBottom, default=536870912};
	__property System::Uitypes::TColor RightBottom = {read=FRightBottom, write=SetRightBottom, default=536870912};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRectangleCorners() { }
	
public:
	/* TObject.Create */ inline __fastcall TRectangleCorners() : System::Classes::TPersistent() { }
	
};


class PASCALIMPLEMENTATION TRectangleSides : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Uitypes::TColor FLeft;
	System::Uitypes::TColor FRight;
	System::Uitypes::TColor FTop;
	System::Uitypes::TColor FBottom;
	TRectangleBlock* IOwner;
	void __fastcall SetLeft(const System::Uitypes::TColor Value);
	void __fastcall SetRight(const System::Uitypes::TColor Value);
	void __fastcall SetTop(const System::Uitypes::TColor Value);
	void __fastcall SetBottom(const System::Uitypes::TColor Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor Left = {read=FLeft, write=SetLeft, default=536870912};
	__property System::Uitypes::TColor Right = {read=FRight, write=SetRight, default=536870912};
	__property System::Uitypes::TColor Top = {read=FTop, write=SetTop, default=536870912};
	__property System::Uitypes::TColor Bottom = {read=FBottom, write=SetBottom, default=536870912};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRectangleSides() { }
	
public:
	/* TObject.Create */ inline __fastcall TRectangleSides() : System::Classes::TPersistent() { }
	
};


class PASCALIMPLEMENTATION TRectangleBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	System::Uitypes::TColor FCenter;
	TRectangleCorners* FCorners;
	TRectangleSides* FSides;
	bool IAnyCorner;
	bool IAnySide;
	int IList;
	int IListFlat;
	int IListPen;
	void __fastcall ChangedCorner();
	void __fastcall ChangedSide();
	void __fastcall SetCenter(const System::Uitypes::TColor Value);
	void __fastcall SetCorners(TRectangleCorners* const Value);
	void __fastcall SetSides(TRectangleSides* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	DYNAMIC bool __fastcall UsesDepth();
	
public:
	__fastcall virtual TRectangleBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRectangleBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property System::Uitypes::TColor Center = {read=FCenter, write=SetCenter, default=536870912};
	__property TRectangleCorners* Corners = {read=FCorners, write=SetCorners};
	__property TRectangleSides* Sides = {read=FSides, write=SetSides};
};


class PASCALIMPLEMENTATION TGradientBlock : public TRectangleBlock
{
	typedef TRectangleBlock inherited;
	
private:
	Vcltee::Tecanvas::TTeeGradient* FGradient;
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall GradientChanged(System::TObject* Sender);
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	
protected:
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual ~TGradientBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
public:
	/* TRectangleBlock.Create */ inline __fastcall virtual TGradientBlock(System::Classes::TComponent* AOwner) : TRectangleBlock(AOwner) { }
	
};


class PASCALIMPLEMENTATION TObjectProperties : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	TBlocks* IBlocks;
	TCustomBlock* IOwner;
	HIDESBASE System::UnicodeString __fastcall GetValue(const System::UnicodeString AName);
	HIDESBASE void __fastcall SetValue(const System::UnicodeString AName, const System::UnicodeString AValue);
	
public:
	System::UnicodeString __fastcall PropertyValue(const System::UnicodeString AName);
	int __fastcall IndexOfProperty(const System::UnicodeString AName);
	__property TBlocks* Blocks = {read=IBlocks};
	__property System::UnicodeString Value[const System::UnicodeString Name] = {read=GetValue, write=SetValue};
public:
	/* TStringList.Create */ inline __fastcall TObjectProperties()/* overload */ : System::Classes::TStringList() { }
	/* TStringList.Create */ inline __fastcall TObjectProperties(bool OwnsObjects)/* overload */ : System::Classes::TStringList(OwnsObjects) { }
	/* TStringList.Create */ inline __fastcall TObjectProperties(System::WideChar QuoteChar, System::WideChar Delimiter)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter) { }
	/* TStringList.Create */ inline __fastcall TObjectProperties(System::WideChar QuoteChar, System::WideChar Delimiter, System::Classes::TStringsOptions Options)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter, Options) { }
	/* TStringList.Create */ inline __fastcall TObjectProperties(System::Types::TDuplicates Duplicates, bool Sorted, bool CaseSensitive)/* overload */ : System::Classes::TStringList(Duplicates, Sorted, CaseSensitive) { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TObjectProperties() { }
	
};


class PASCALIMPLEMENTATION TCustomObjectBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
public:
	TCustomBlock* operator[](int Index) { return this->Item[Index]; }
	
private:
	TBlocks* FItems;
	TObjectProperties* FProperties;
	System::Math::Vectors::TPoint3D IBoundsMin;
	System::Math::Vectors::TPoint3D IBoundsMax;
	bool IPropsReady;
	TCustomBlock* __fastcall Get(int Index);
	TBlocks* __fastcall GetItems();
	TObjectProperties* __fastcall GetProperties();
	bool __fastcall ItemsStored();
	void __fastcall SetItems(TBlocks* const Value);
	void __fastcall SetProperties(TObjectProperties* const Value);
	
protected:
	System::UnicodeString FLink;
	TCustomBlock* FLinkBlock;
	System::UnicodeString __fastcall CompleteLinkFile();
	virtual void __fastcall DeleteLists();
	virtual void __fastcall DoDrawItems();
	virtual void __fastcall StartTransform();
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner();
	bool __fastcall ItemsReady();
	virtual void __fastcall LoadItems(const System::UnicodeString ASource, const System::UnicodeString AFile);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC bool __fastcall SaveChildren();
	virtual void __fastcall SetBlocks(TBlocks* const Value);
	virtual void __fastcall SetLink(const System::UnicodeString Value);
	void __fastcall SetLinkBlock(TCustomBlock* const Value);
	
public:
	__fastcall virtual TCustomObjectBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomObjectBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual bool __fastcall BoundingBox(/* out */ System::Math::Vectors::TPoint3D &AMin, /* out */ System::Math::Vectors::TPoint3D &AMax);
	virtual void __fastcall Clear();
	virtual void __fastcall Draw();
	virtual bool __fastcall HasContents();
	__property TCustomBlock* Item[int Index] = {read=Get/*, default*/};
	__property TBlocks* Items = {read=GetItems, write=SetItems, stored=ItemsStored};
	__property TCustomBlock* LinkBlock = {read=FLinkBlock, write=SetLinkBlock};
	__property System::UnicodeString LinkFile = {read=FLink, write=SetLink};
	__property TObjectProperties* Properties = {read=GetProperties, write=SetProperties};
};


class PASCALIMPLEMENTATION TObjectBlock : public TCustomObjectBlock
{
	typedef TCustomObjectBlock inherited;
	
__published:
	__property Items;
	__property LinkBlock;
	__property LinkFile = {default=0};
	__property Properties;
public:
	/* TCustomObjectBlock.Create */ inline __fastcall virtual TObjectBlock(System::Classes::TComponent* AOwner) : TCustomObjectBlock(AOwner) { }
	/* TCustomObjectBlock.Destroy */ inline __fastcall virtual ~TObjectBlock() { }
	
};


_DECLARE_METACLASS(System::TMetaClass, TBlockClass);

class PASCALIMPLEMENTATION TObjectBlockHandle : public TObjectBlock
{
	typedef TObjectBlock inherited;
	
public:
	TBlockClass HandleClass;
	Vcltee::Tecanvas::TPoint3DArray Locations;
	__fastcall virtual ~TObjectBlockHandle();
	TCustomBlock* __fastcall AddHandle(const System::Math::Vectors::TPoint3D &ALocation, const System::UnicodeString DragAction, const System::UnicodeString LeftClickAction = System::UnicodeString())/* overload */;
	TCustomBlock* __fastcall AddHandle(const float x, const float y, const float z, const System::UnicodeString DragAction, const System::UnicodeString LeftClickAction = System::UnicodeString())/* overload */;
public:
	/* TCustomObjectBlock.Create */ inline __fastcall virtual TObjectBlockHandle(System::Classes::TComponent* AOwner) : TObjectBlock(AOwner) { }
	
};


class PASCALIMPLEMENTATION TPyramidBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	Vcltee::Tecanvas::TPointXYFloat* FSide1;
	Vcltee::Tecanvas::TPointXYFloat* FSide2;
	int IList;
	void __fastcall Changed(System::TObject* Sender);
	void __fastcall SetSide1(Vcltee::Tecanvas::TPointXYFloat* const Value);
	void __fastcall SetSide2(Vcltee::Tecanvas::TPointXYFloat* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TPyramidBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPyramidBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property Vcltee::Tecanvas::TPointXYFloat* Side1 = {read=FSide1, write=SetSide1};
	__property Vcltee::Tecanvas::TPointXYFloat* Side2 = {read=FSide2, write=SetSide2};
};


class PASCALIMPLEMENTATION TPointXYZColor : public Vcltee::Tecanvas::TPointXYZFloat
{
	typedef Vcltee::Tecanvas::TPointXYZFloat inherited;
	
private:
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	
protected:
	System::Uitypes::TColor FColor;
	
public:
	__fastcall virtual TPointXYZColor(Vcltee::Tecanvas::TVisualBlock* const AOwner, const double AValue, const System::Classes::TNotifyEvent ChangedEvent);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=536870912};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPointXYZColor() { }
	
};


class PASCALIMPLEMENTATION TTriangleBlock : public TCustomBlock
{
	typedef TCustomBlock inherited;
	
private:
	TPointXYZColor* FPoint0;
	TPointXYZColor* FPoint1;
	TPointXYZColor* FPoint2;
	int IList;
	void __fastcall ChangedPoint(System::TObject* Sender);
	void __fastcall SetPoint0(TPointXYZColor* const Value);
	void __fastcall SetPoint1(TPointXYZColor* const Value);
	void __fastcall SetPoint2(TPointXYZColor* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TTriangleBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTriangleBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property TPointXYZColor* Point0 = {read=FPoint0, write=SetPoint0};
	__property TPointXYZColor* Point1 = {read=FPoint1, write=SetPoint1};
	__property TPointXYZColor* Point2 = {read=FPoint2, write=SetPoint2};
};


class PASCALIMPLEMENTATION TBlockList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	TCustomBlock* operator[](int Index) { return this->Block[Index]; }
	
private:
	bool IKeepBlocks;
	HIDESBASE TCustomBlock* __fastcall Get(int Index);
	HIDESBASE void __fastcall Put(int Index, TCustomBlock* const Value);
	
public:
	virtual void __fastcall Clear();
	bool __fastcall Exists(const System::UnicodeString ATitle);
	void __fastcall FreeAll();
	HIDESBASE TCustomBlock* __fastcall Last();
	__property TCustomBlock* Block[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TBlockList() { }
	
public:
	/* TObject.Create */ inline __fastcall TBlockList() : System::Classes::TList() { }
	
};


class PASCALIMPLEMENTATION TAnimateItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcltee::Teeanimate::TTeeAnimate* FAnimate;
	System::UnicodeString FDesc;
	bool FPlayOnLoad;
	System::Classes::TStrings* IList;
	void __fastcall AnimateDestroyed(System::TObject* Sender);
	Vcltee::Teeanimate::TTeeAnimate* __fastcall GetAnimate();
	int __fastcall GetAnimationCount();
	Vcltee::Teeanimate::TAnimations* __fastcall GetAnimations();
	System::Classes::TStrings* __fastcall GetList();
	bool __fastcall GetLoop();
	System::Classes::TNotifyEvent __fastcall GetOnStop();
	bool __fastcall GetPlaying();
	int __fastcall GetSpeed();
	void __fastcall SetAnimations(Vcltee::Teeanimate::TAnimations* const Value);
	void __fastcall SetDesc(const System::UnicodeString Value);
	void __fastcall SetList(System::Classes::TStrings* const Value);
	void __fastcall SetLoop(const bool Value);
	void __fastcall SetOnStop(const System::Classes::TNotifyEvent Value);
	void __fastcall SetPlaying(const bool Value);
	void __fastcall SetSpeed(const int Value);
	
public:
	__fastcall virtual ~TAnimateItem();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Vcltee::Teeanimate::TTeeAnimate* Animate = {read=GetAnimate};
	__property int AnimationCount = {read=GetAnimationCount, nodefault};
	
__published:
	__property Vcltee::Teeanimate::TAnimations* Animations = {read=GetAnimations, write=SetAnimations, stored=false};
	__property System::UnicodeString Description = {read=FDesc, write=SetDesc};
	__property System::Classes::TStrings* List = {read=GetList, write=SetList};
	__property bool Loop = {read=GetLoop, write=SetLoop, default=0};
	__property bool Playing = {read=GetPlaying, write=SetPlaying, stored=false, nodefault};
	__property bool PlayOnLoad = {read=FPlayOnLoad, write=FPlayOnLoad, default=0};
	__property int Speed = {read=GetSpeed, write=SetSpeed, default=60};
	__property System::Classes::TNotifyEvent OnStop = {read=GetOnStop, write=SetOnStop};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TAnimateItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	
};


class PASCALIMPLEMENTATION TAnimates : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TAnimateItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	Vcltee::Teeprocs::TCustomTeePanel* IParent;
	void __fastcall FinishedLoading(const System::UnicodeString ASource);
	TAnimateItem* __fastcall Get(int Index);
	void __fastcall Put(int Index, TAnimateItem* const Value);
	
protected:
	void __fastcall PrepareList();
	
public:
	HIDESBASE TAnimateItem* __fastcall Add();
	TAnimateItem* __fastcall IndexOf(System::UnicodeString ADescription);
	__property TAnimateItem* Item[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TAnimates(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAnimates() { }
	
};


struct DECLSPEC_DRECORD TBlockShadows
{
public:
	System::Uitypes::TColor Color;
	bool Smooth;
	int SmoothSize;
	Vcltee::Tecanvas::TTeeTransparency Transparency;
	bool Visible;
};


class PASCALIMPLEMENTATION TBlocks : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	TCustomBlock* operator[](int Index) { return this->Block[Index]; }
	
private:
	TAnimates* FAnimates;
	TBlocks* FDrawBlocks;
	System::Classes::TStrings* FEvents;
	bool FHideBorders;
	bool FHideTextures;
	TObjectProperties* FProperties;
	Teeglslshaders::TProgramShader* IProgramShader;
	System::Classes::TNotifyEvent FOnItemsChanged;
	System::Classes::TNotifyEvent FOnLoaded;
	bool IAutoPlayDone;
	Vcltee::Teeprocs::TCustomTeePanel* IParent;
	System::Byte ITransparency;
	System::UnicodeString __fastcall CheckFileExtension(System::UnicodeString &FileName);
	void __fastcall CreateBlockRuntime(System::Classes::TReader* Reader, System::Classes::TComponentClass ComponentClass, System::Classes::TComponent* &Component);
	void __fastcall FinishedLoading();
	TCustomBlock* __fastcall Get(int Index);
	TAnimates* __fastcall GetAnimates();
	TBlockList* __fastcall GetCurrentParents();
	System::Classes::TStrings* __fastcall GetEvents();
	TObjectProperties* __fastcall GetProperties();
	Teeglslshaders::TProgramShader* __fastcall GetProgramShader();
	bool __fastcall GetShaderEnabled();
	__classmethod System::UnicodeString __fastcall GetLibraryPath();
	System::UnicodeString __fastcall GetterLibraryPath();
	TCustomBlock* __fastcall InternalClicked(int X, int Y, TCustomBlock* ABlock, bool IncludeObjects, bool IncludeSubObjects)/* overload */;
	void __fastcall Put(int Index, TCustomBlock* const Value);
	void __fastcall ReaderError(System::Classes::TReader* Reader, const System::UnicodeString Message, bool &Handled);
	bool __fastcall RecursiveContains(TCustomBlock* const Value);
	void __fastcall SetAnimates(TAnimates* const Value);
	void __fastcall SetEvents(System::Classes::TStrings* const Value);
	void __fastcall SetHideBorders(const bool Value);
	void __fastcall SetHideTextures(const bool Value);
	void __fastcall SetLibraryPath(const System::UnicodeString Value);
	void __fastcall SetParent(Vcltee::Teeprocs::TCustomTeePanel* APanel);
	void __fastcall SetProperties(TObjectProperties* const Value);
	void __fastcall SetShaderEnabled(const bool Value);
	void __fastcall TryLoad(const System::UnicodeString ParentSource, const System::UnicodeString Source);
	
protected:
	System::UnicodeString FCurrentSource;
	System::Classes::TNotifyEvent FOnRemoved;
	TBlockList* ICurrentParents;
	bool IDrawingReflection;
	TCustomBlock* IFloor;
	int ILightNum;
	TBlockList* IList;
	System::Classes::TThread* ILoadThread;
	int IMaxLights;
	TCustomObjectBlock* IObject;
	bool IOldAntiAlias;
	System::Classes::TList* ITranspBlocks;
	int IUseCursor;
	Vcltee::Teeglcanvas::TGLCanvas* ICanvas;
	void __fastcall InitLights();
	void __fastcall DrawAfter();
	__classmethod void __fastcall DoDrawItem(TCustomBlock* ABlock);
	void __fastcall ItemsChanged(TCustomBlock* ABlock);
	void __fastcall DeleteLists();
	TCustomBlock* __fastcall DoFindName(System::UnicodeString &AName);
	int __fastcall DoPicking();
	void __fastcall DoSetProperty(TCustomBlock* SenderBlock, System::UnicodeString Exp);
	void __fastcall FixAnimationsLoaded();
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner();
	bool __fastcall HasEvents();
	System::Variant __fastcall InternalGetPropValue(System::UnicodeString Exp);
	bool __fastcall IsAnimatesStored();
	__classmethod bool __fastcall IsBooleanProperty(const System::Typinfo::PPropInfo Prop);
	void __fastcall PreparePicking(int X, int Y);
	void __fastcall ResetShown();
	__property bool ShaderEnabled = {read=GetShaderEnabled, write=SetShaderEnabled, nodefault};
	void __fastcall SetBlockName(TCustomBlock* ABlock);
	__property System::Classes::TNotifyEvent OnItemsChanged = {read=FOnItemsChanged, write=FOnItemsChanged};
	__property System::Classes::TNotifyEvent OnLoaded = {read=FOnLoaded, write=FOnLoaded};
	__property Teeglslshaders::TProgramShader* ProgramShader = {read=GetProgramShader};
	
public:
	TBlockShadows Shadows;
	__fastcall virtual TBlocks(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBlocks();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	TCustomBlock* __fastcall Add(TCustomBlock* ABlock);
	bool __fastcall CalcBounds(System::Math::Vectors::TPoint3D &AMin, System::Math::Vectors::TPoint3D &AMax);
	__classmethod void __fastcall CheckLibraryPath(const System::UnicodeString SubFolder, System::UnicodeString &AFile);
	void __fastcall Clear();
	TCustomBlock* __fastcall ClickedBlock(int X, int Y, bool IncludeObjects = false, bool IncludeSubObjects = true)/* overload */;
	TCustomBlock* __fastcall ClickedBlock(TCustomBlock* ABlock, int X, int Y)/* overload */;
	TCustomBlock* __fastcall CloneBlock(TCustomBlock* ABlock);
	int __fastcall Count();
	__classmethod System::TObject* __fastcall DoGetObjectProp(System::TObject* AInst, const System::UnicodeString AProp);
	void __fastcall Draw(bool Picking = false);
	bool __fastcall Exists(const System::UnicodeString ATitle);
	bool __fastcall HasAnimations();
	bool __fastcall HasProperties();
	TCustomBlock* __fastcall Find(System::UnicodeString &AName, bool UseTitle = false, bool SubObjects = false);
	TCustomBlock* __fastcall FindByName(const System::UnicodeString AName);
	TCustomBlock* __fastcall FindByTitle(const System::UnicodeString ATitle, bool SubObjects = false);
	int __fastcall IndexOf(TCustomBlock* ABlock);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromURL(const System::UnicodeString URL);
	__classmethod System::Classes::TStream* __fastcall LoadURLStream(const System::UnicodeString URL, /* out */ System::UnicodeString &ErrorSt);
	__classmethod System::UnicodeString __fastcall ParseFileName(const System::UnicodeString FolderName, const System::UnicodeString FileName);
	HIDESBASE void __fastcall Remove(TCustomBlock* ABlock);
	void __fastcall RemoveTexture(Vcl::Graphics::TGraphic* AGraphic)/* overload */;
	void __fastcall RemoveTexture(Vcl::Graphics::TPicture* Picture)/* overload */;
	void __fastcall Repaint();
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	void __fastcall SaveToStream(System::Classes::TStream* Stream, bool Sign = false);
	__property TCustomBlock* Block[int Index] = {read=Get, write=Put/*, default*/};
	__property TBlockList* CurrentParents = {read=GetCurrentParents};
	__property System::UnicodeString CurrentSource = {read=FCurrentSource};
	__property TBlocks* DrawBlocks = {read=FDrawBlocks};
	__property bool HideBorders = {read=FHideBorders, write=SetHideBorders, default=1};
	__property bool HideTextures = {read=FHideTextures, write=SetHideTextures, default=0};
	__property System::UnicodeString LibraryPath = {read=GetterLibraryPath, write=SetLibraryPath};
	__property Vcltee::Teeprocs::TCustomTeePanel* Parent = {read=IParent, write=SetParent};
	__property System::Classes::TNotifyEvent OnRemoved = {read=FOnRemoved, write=FOnRemoved};
	
__published:
	__property TAnimates* Animates = {read=GetAnimates, write=SetAnimates, stored=IsAnimatesStored};
	__property System::Classes::TStrings* Events = {read=GetEvents, write=SetEvents, stored=HasEvents};
	__property TObjectProperties* Properties = {read=GetProperties, write=SetProperties, stored=HasProperties};
};


class PASCALIMPLEMENTATION TBlockClasses : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	TBlockClass operator[](int Index) { return this->BlockClass[Index]; }
	
private:
	HIDESBASE TBlockClass __fastcall Get(int Index);
	
public:
	__classmethod System::UnicodeString __fastcall BlockDescription(const System::UnicodeString AClass);
	__classmethod System::Classes::TStringList* __fastcall Sorted();
	__property TBlockClass BlockClass[int Index] = {read=Get/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TBlockClasses() { }
	
public:
	/* TObject.Create */ inline __fastcall TBlockClasses() : System::Classes::TList() { }
	
};


struct DECLSPEC_DRECORD TPointSinCos
{
public:
	float X;
	float Y;
};


class PASCALIMPLEMENTATION TMakerSystem : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::TDateTime __fastcall GetNow();
	double __fastcall GetRandom();
	
public:
	__property System::TDateTime Now = {read=GetNow};
	__property double Random = {read=GetRandom};
public:
	/* TComponent.Create */ inline __fastcall virtual TMakerSystem(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TMakerSystem() { }
	
};


struct DECLSPEC_DRECORD TBounds
{
public:
	System::Math::Vectors::TPoint3D Min;
	System::Math::Vectors::TPoint3D Max;
};


typedef void __fastcall (*TActionEventProc)(void);

class PASCALIMPLEMENTATION TActionEvent : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString ID;
	System::UnicodeString Path;
	TActionEventProc Event;
public:
	/* TObject.Create */ inline __fastcall TActionEvent() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TActionEvent() { }
	
};


class PASCALIMPLEMENTATION TMakerEvents : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	void __fastcall AddEvent(const System::UnicodeString ActionID, const System::UnicodeString ActionPath);
	System::UnicodeString __fastcall IDToPath(const System::UnicodeString ID);
	System::UnicodeString __fastcall PathToID(const System::UnicodeString Path);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TMakerEvents() { }
	
public:
	/* TObject.Create */ inline __fastcall TMakerEvents() : System::Classes::TList() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TBlockClasses* BlockClasses;
extern DELPHI_PACKAGE bool TeeNoThreads;
static const double TwoPi = 6.283185E+00;
static const double HalfPi = 1.570796E+00;
#define TeeMakerKey L"Software\\Steema Software\\TeeMaker"
#define TeeMakerLibraryTag L"$(TEEMAKER)\\"
static const System::Word CM_BLOCKBIRTH = System::Word(0x4e20);
extern DELPHI_PACKAGE TMakerSystem* MakerSystem;
extern DELPHI_PACKAGE TMakerEvents* MakerEvents;
extern DELPHI_PACKAGE void __fastcall TeeMakerWriteRegistry(const System::UnicodeString AKey, const System::UnicodeString AName, const System::UnicodeString AValue);
extern DELPHI_PACKAGE System::UnicodeString __fastcall TeeMakerReadRegistry(const System::UnicodeString AKey, const System::UnicodeString AName, const System::UnicodeString ADefault);
extern DELPHI_PACKAGE System::UnicodeString __fastcall RemoveFileExtension(const System::UnicodeString FileName);
extern DELPHI_PACKAGE void __fastcall RegisterBlock(TBlockClass BlockClass);
extern DELPHI_PACKAGE void __fastcall RegisterBlocks(TBlockClass const *BlockClasses, const int BlockClasses_High);
extern DELPHI_PACKAGE System::UnicodeString __fastcall RemoveAmpersand(const System::UnicodeString S);
extern DELPHI_PACKAGE System::UnicodeString __fastcall RemoveTrailingSlash(const System::UnicodeString S);
extern DELPHI_PACKAGE void __fastcall SplitValue(const System::UnicodeString Value, System::UnicodeString &ALeft, System::UnicodeString &ARight);
extern DELPHI_PACKAGE int __fastcall LastPosOf(const System::WideChar ASub, const System::UnicodeString AStr);
extern DELPHI_PACKAGE double __fastcall AngleOf(const Vcltee::Tecanvas::TFloatPoint &P0, const Vcltee::Tecanvas::TFloatPoint &P1, const Vcltee::Tecanvas::TFloatPoint &P2);
extern DELPHI_PACKAGE _POINTFLOAT __fastcall PointFloat(const System::Types::TPoint &P)/* overload */;
extern DELPHI_PACKAGE _POINTFLOAT __fastcall PointFloat(const float aX, const float aY)/* overload */;
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall PointFloat(const float aX, const float aY, const float aZ)/* overload */;
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall PointFloat(const System::Types::TPoint &P, const float aZ)/* overload */;
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall PointFloat(const Vcltee::Tecanvas::TPoint3D &P, const float aZ)/* overload */;
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall CalculateNormal(const System::Math::Vectors::TPoint3D &A, const System::Math::Vectors::TPoint3D &B, const System::Math::Vectors::TPoint3D &C);
extern DELPHI_PACKAGE bool __fastcall IsColorProperty(System::TObject* AObject, const System::UnicodeString AName);
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall AddPoints(const System::Math::Vectors::TPoint3D &A, const System::Math::Vectors::TPoint3D &B)/* overload */;
extern DELPHI_PACKAGE TBounds __fastcall AddPoints(const TBounds &Bounds, const System::Math::Vectors::TPoint3D &Value)/* overload */;
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall AddMultiply(const System::Math::Vectors::TPoint3D &A, const System::Math::Vectors::TPoint3D &B, const double Value);
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall AbsSubtract(const System::Math::Vectors::TPoint3D &A, const System::Math::Vectors::TPoint3D &B);
extern DELPHI_PACKAGE double __fastcall MaxValue(const System::Math::Vectors::TPoint3D &P);
extern DELPHI_PACKAGE double __fastcall MinValue(const System::Math::Vectors::TPoint3D &P);
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall Subtract(const System::Math::Vectors::TPoint3D &A, const System::Math::Vectors::TPoint3D &B);
extern DELPHI_PACKAGE System::Math::Vectors::TPoint3D __fastcall Center(const System::Math::Vectors::TPoint3D &A, const System::Math::Vectors::TPoint3D &B);
}	/* namespace Teeblocks */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEBLOCKS)
using namespace Teeblocks;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeblocksHPP
