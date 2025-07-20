// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeRoundRect.pas' rev: 34.00 (Windows)

#ifndef TeeroundrectHPP
#define TeeroundrectHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeroundrect
{
//-- forward type declarations -----------------------------------------------
struct TRoundPoints;
class DELPHICLASS TRoundCorners;
class DELPHICLASS TRoundRectBlock;
class DELPHICLASS TImageBlock;
class DELPHICLASS TRoundRectEditor;
class DELPHICLASS THole;
class DELPHICLASS THoleBlock;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TRoundPoints
{
	
private:
	typedef System::DynamicArray<float> _TRoundPoints__1;
	
	
public:
	Vcltee::Tecanvas::TPoint3DArray Points;
	Vcltee::Tecanvas::TPoint3DArray Normals;
	_TRoundPoints__1 TextureCoords;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION TRoundCorners : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Teeblocks::TBlockEdge* FLeftBottom;
	Teeblocks::TBlockEdge* FLeftTop;
	System::Classes::TNotifyEvent FOnChanged;
	Teeblocks::TBlockEdge* FRightBottom;
	Teeblocks::TBlockEdge* FRightTop;
	void __fastcall CornerChanged(System::TObject* Sender);
	_POINTFLOAT __fastcall GetRoundSize();
	int __fastcall GetSlices();
	void __fastcall SetLeftBottom(Teeblocks::TBlockEdge* const Value);
	void __fastcall SetLeftTop(Teeblocks::TBlockEdge* const Value);
	void __fastcall SetRightBottom(Teeblocks::TBlockEdge* const Value);
	void __fastcall SetRightTop(Teeblocks::TBlockEdge* const Value);
	void __fastcall SetRoundSize(const _POINTFLOAT &Value);
	void __fastcall SetSlices(const int Value);
	double __fastcall GetRoundHeight();
	void __fastcall SetRoundHeight(const double Value);
	double __fastcall GetRoundWidth();
	void __fastcall SetRoundWidth(const double Value);
	
protected:
	Teeblocks::TCustomBlock* IOwner;
	void __fastcall CalcPoints(const float AWidth, const float ADepth, TRoundPoints &P);
	void __fastcall FreePoints(TRoundPoints &P);
	
public:
	__fastcall TRoundCorners(Teeblocks::TCustomBlock* AOwner, const float ASize);
	__fastcall virtual ~TRoundCorners();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property _POINTFLOAT RoundSize = {read=GetRoundSize, write=SetRoundSize};
	
__published:
	__property Teeblocks::TBlockEdge* LeftBottom = {read=FLeftBottom, write=SetLeftBottom};
	__property Teeblocks::TBlockEdge* LeftTop = {read=FLeftTop, write=SetLeftTop};
	__property Teeblocks::TBlockEdge* RightBottom = {read=FRightBottom, write=SetRightBottom};
	__property Teeblocks::TBlockEdge* RightTop = {read=FRightTop, write=SetRightTop};
	__property double RoundHeight = {read=GetRoundHeight, write=SetRoundHeight, stored=false};
	__property double RoundWidth = {read=GetRoundWidth, write=SetRoundWidth, stored=false};
	__property int Slices = {read=GetSlices, write=SetSlices, default=16};
	__property System::Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=FOnChanged};
};


class PASCALIMPLEMENTATION TRoundRectBlock : public Teeblocks::TCustomCoverBlock
{
	typedef Teeblocks::TCustomCoverBlock inherited;
	
private:
	TRoundCorners* FCorners;
	int IList;
	int IListCover1;
	int IListCover2;
	int IListPen1;
	int IListPen2;
	TRoundPoints IPoints;
	void __fastcall CornersChanged(System::TObject* Sender);
	void __fastcall DrawSides(const TRoundPoints &P, bool Invert = false);
	void __fastcall SetCorners(TRoundCorners* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC Teeblocks::TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TRoundRectBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRoundRectBlock();
	virtual void __fastcall Draw();
	
__published:
	__property TRoundCorners* Corners = {read=FCorners, write=SetCorners};
};


class PASCALIMPLEMENTATION TImageBlock : public TRoundRectBlock
{
	typedef TRoundRectBlock inherited;
	
protected:
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TImageBlock(System::Classes::TComponent* AOwner);
public:
	/* TRoundRectBlock.Destroy */ inline __fastcall virtual ~TImageBlock() { }
	
};


class PASCALIMPLEMENTATION TRoundRectEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label41;
	Vcl::Stdctrls::TLabel* LabelRoundWidth;
	Vcl::Stdctrls::TLabel* Label43;
	Vcl::Stdctrls::TLabel* LabelRoundHeight;
	Vcl::Stdctrls::TLabel* Label67;
	Vcl::Stdctrls::TScrollBar* BlockRoundWidth;
	Vcl::Stdctrls::TScrollBar* BlockRoundHeight;
	Vcl::Extctrls::TRadioGroup* RGCorner;
	Vcltee::Tecanvas::TComboFlat* BlockCornerStyle;
	Vcl::Stdctrls::TScrollBar* BlockRoundSlices;
	Vcl::Stdctrls::TCheckBox* ChangeAll;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall RGCornerClick(System::TObject* Sender);
	void __fastcall BlockRoundWidthChange(System::TObject* Sender);
	void __fastcall BlockRoundHeightChange(System::TObject* Sender);
	void __fastcall BlockCornerStyleChange(System::TObject* Sender);
	void __fastcall BlockRoundSlicesChange(System::TObject* Sender);
	void __fastcall ChangeAllClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	bool IModifying;
	Teeblocks::TBlockEdge* __fastcall CurrentCorner();
	
public:
	TRoundCorners* Corners;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRoundRectEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRoundRectEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRoundRectEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRoundRectEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


enum DECLSPEC_DENUM THoleStyle : unsigned char { hsRoundRect, hsSquare };

class PASCALIMPLEMENTATION THole : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcltee::Tecanvas::TPointXYFloat* FCenter;
	TRoundCorners* FCorners;
	Teeblocks::TBlockFormat* FFormat;
	Vcltee::Tecanvas::TPointXYFloat* FSize;
	THoleStyle FStyle;
	Teeblocks::TCustomBlock* IOwner;
	void __fastcall DataChanged(System::TObject* Sender);
	void __fastcall SetCenter(Vcltee::Tecanvas::TPointXYFloat* const Value);
	void __fastcall SetCorners(TRoundCorners* const Value);
	void __fastcall SetFormat(Teeblocks::TBlockFormat* const Value);
	void __fastcall SetSize(Vcltee::Tecanvas::TPointXYFloat* const Value);
	void __fastcall SetStyle(const THoleStyle Value);
	
public:
	__fastcall THole(Teeblocks::TCustomBlock* AOwner);
	__fastcall virtual ~THole();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TPointXYFloat* Center = {read=FCenter, write=SetCenter};
	__property TRoundCorners* Corners = {read=FCorners, write=SetCorners};
	__property Teeblocks::TBlockFormat* Format = {read=FFormat, write=SetFormat};
	__property Vcltee::Tecanvas::TPointXYFloat* Size = {read=FSize, write=SetSize};
	__property THoleStyle Style = {read=FStyle, write=SetStyle, default=0};
};


class PASCALIMPLEMENTATION THoleBlock : public TRoundRectBlock
{
	typedef TRoundRectBlock inherited;
	
private:
	THole* FHole;
	int IListSides;
	void __fastcall SetHole(THole* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC Teeblocks::TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual THoleBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~THoleBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property THole* Hole = {read=FHole, write=SetHole};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeroundrect */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEROUNDRECT)
using namespace Teeroundrect;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeroundrectHPP
