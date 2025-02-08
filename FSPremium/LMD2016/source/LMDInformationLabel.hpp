// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInformationLabel.pas' rev: 31.00 (Windows)

#ifndef LmdinformationlabelHPP
#define LmdinformationlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <LMDSysIn.hpp>
#include <LMDCustomStatusBar.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBevel.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinformationlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDInformationLabel;
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString TLMDNumberFormat;

class PASCALIMPLEMENTATION TLMDInformationLabel : public Lmdbaselabel::TLMDBaseLabel
{
	typedef Lmdbaselabel::TLMDBaseLabel inherited;
	
private:
	Lmdsysin::TLMDInfoType FInfo;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	int FDivide;
	Lmdclass::TLMDDateTimeFormat FDateTimeFormat;
	System::UnicodeString FNumberFormat;
	System::UnicodeString FKeySet;
	bool timerinv;
	bool FStandartCaption;
	Lmdbevel::TLMDBevel* FBevel;
	System::Int8 FDB;
	System::Int8 FTabs;
	System::Word FIntervall;
	Lmdclass::TLMDTimer* FTimerID;
	bool FUseGlobalTimer;
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetInfo(Lmdsysin::TLMDInfoType aValue);
	void __fastcall SetTabs(System::Int8 aValue);
	void __fastcall SetDB(System::Int8 aValue);
	void __fastcall SetDevide(int aValue);
	void __fastcall SetDateTimeFormat(Lmdclass::TLMDDateTimeFormat aValue);
	void __fastcall SetNumberFormat(System::UnicodeString aValue);
	void __fastcall SetStandartCaption(bool aValue);
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetUseGlobalTimer(const bool Value);
	void __fastcall GetTimer(System::TObject* Sender);
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetStatusControl(void);
	bool __fastcall ReturnCaption(System::UnicodeString &s);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDInformationLabel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDInformationLabel(void);
	virtual void __fastcall CorrectBounds(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Lmdsysin::TLMDInfoType Info = {read=FInfo, write=SetInfo, nodefault};
	__property AutoSize = {index=0, default=1};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Font;
	__property System::Int8 InsertTabs = {read=FTabs, write=SetTabs, default=1};
	__property int DividerValue = {read=FDivide, write=SetDevide, default=0};
	__property bool UseStandardCaption = {read=FStandartCaption, write=SetStandartCaption, default=1};
	__property System::Int8 InsertColon = {read=FDB, write=SetDB, default=-1};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Lmdclass::TLMDDateTimeFormat DateTimeFormat = {read=FDateTimeFormat, write=SetDateTimeFormat};
	__property System::UnicodeString NumberFormat = {read=FNumberFormat, write=SetNumberFormat};
	__property Alignment = {default=0};
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property Enabled = {default=1};
	__property Transparent = {default=1};
	__property ParentFont = {default=1};
	__property ParentColor = {default=1};
	__property Hint = {default=0};
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property ShowAccelChar = {index=2, default=1};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=SetUseGlobalTimer, default=0};
	__property Visible = {default=1};
	__property Cursor = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinformationlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINFORMATIONLABEL)
using namespace Lmdinformationlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinformationlabelHPP
