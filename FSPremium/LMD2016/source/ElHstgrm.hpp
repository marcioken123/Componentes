﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElHstgrm.pas' rev: 31.00 (Windows)

#ifndef ElhstgrmHPP
#define ElhstgrmHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDProcs.hpp>
#include <ElImgFrm.hpp>
#include <ElVCLUtils.hpp>
#include <ElCGControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elhstgrm
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THistoBuffer;
class DELPHICLASS TElHistogram;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<int, 16384> THistoBuf;

typedef THistoBuf *PHistoBuf;

enum DECLSPEC_DENUM THistoDoubleMode : unsigned char { hdmCumulative, hdmHSplitOppositeIn, hdmHSplitOppositeOut, hdmHSplitSingle, hdmVSplitOpposite, hdmVSplitSingle };

#pragma pack(push,4)
class PASCALIMPLEMENTATION THistoBuffer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	THistoBuf *FBuf;
	int FBufSize;
	int FElements;
	TElHistogram* FOwner;
	void __fastcall SetBufSize(int newValue);
	
public:
	__fastcall THistoBuffer(void);
	__fastcall virtual ~THistoBuffer(void);
	void __fastcall Add(int aValue);
	int __fastcall Average(int aSamples);
	void __fastcall Clear(void);
	void __fastcall Push(int aValue);
	__property int BufSize = {read=FBufSize, write=SetBufSize, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElHistogram : public Elcgcontrol::TElCustomGraphicControl
{
	typedef Elcgcontrol::TElCustomGraphicControl inherited;
	
private:
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	Vcl::Graphics::TBitmap* Bitmap;
	System::Uitypes::TColor FBgColor;
	THistoBuffer* FBuffer;
	THistoBuffer* FBuffer2;
	System::Uitypes::TColor FColor2;
	THistoDoubleMode FDoubleMode;
	THistoBuffer* FExtBuffer;
	THistoBuffer* FExtBuffer2;
	System::Uitypes::TColor FGrColor;
	bool FHGrid;
	int FScale;
	bool FShowZeroValues;
	bool FSmooth;
	bool FUseBuffer2;
	bool FVGrid;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	int __fastcall GetBufferSize(void);
	bool __fastcall GetTransparent(void);
	void __fastcall SetBgColor(System::Uitypes::TColor aValue);
	void __fastcall SetBufferSize(int newValue);
	void __fastcall SetColor2(System::Uitypes::TColor Value);
	void __fastcall SetDoubleMode(THistoDoubleMode Value);
	void __fastcall SetGrColor(System::Uitypes::TColor aValue);
	void __fastcall SetHGrid(bool aValue);
	void __fastcall SetScale(int aValue);
	void __fastcall SetShowZeroValues(bool newValue);
	void __fastcall SetSmooth(bool aValue);
	void __fastcall SetTransparent(bool newValue);
	void __fastcall SetUseBuffer2(bool Value);
	void __fastcall SetVGrid(bool aValue);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle newValue);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TElHistogram(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElHistogram(void);
	__property THistoBuffer* Buffer = {read=FBuffer};
	__property THistoBuffer* Buffer2 = {read=FBuffer2};
	__property THistoBuffer* ExternalBuffer = {read=FExtBuffer, write=FExtBuffer};
	__property THistoBuffer* ExternalBuffer2 = {read=FExtBuffer2, write=FExtBuffer2};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property System::Uitypes::TColor BgColor = {read=FBgColor, write=SetBgColor, default=0};
	__property int BufferSize = {read=GetBufferSize, write=SetBufferSize, default=16384};
	__property Color = {default=16776960};
	__property System::Uitypes::TColor Color2 = {read=FColor2, write=SetColor2, default=65280};
	__property Constraints;
	__property DockOrientation;
	__property THistoDoubleMode DoubleMode = {read=FDoubleMode, write=SetDoubleMode, default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Floating;
	__property System::Uitypes::TColor GridColor = {read=FGrColor, write=SetGrColor, default=12632256};
	__property Height = {default=30};
	__property bool HGrid = {read=FHGrid, write=SetHGrid, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property int Scale = {read=FScale, write=SetScale, default=4096};
	__property ShowHint;
	__property bool ShowZeroValues = {read=FShowZeroValues, write=SetShowZeroValues, default=0};
	__property bool Smooth = {read=FSmooth, write=SetSmooth, default=0};
	__property bool Transparent = {read=GetTransparent, write=SetTransparent, default=0};
	__property bool UseBuffer2 = {read=FUseBuffer2, write=SetUseBuffer2, default=0};
	__property bool VGrid = {read=FVGrid, write=SetVGrid, default=0};
	__property Visible = {default=1};
	__property Width = {default=100};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word HISTOBUFFERSIZE = System::Word(0x4000);
}	/* namespace Elhstgrm */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELHSTGRM)
using namespace Elhstgrm;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElhstgrmHPP
