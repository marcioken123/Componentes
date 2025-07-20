// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeMapNavigator.pas' rev: 34.00 (Windows)

#ifndef TreemapnavigatorHPP
#define TreemapnavigatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treemapnavigator
{
//-- forward type declarations -----------------------------------------------
struct TTeeSize;
class DELPHICLASS TTreeNavigator;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TTeeSize
{
public:
	int Width;
	int Height;
};


enum DECLSPEC_DENUM TNavigatorQuality : unsigned char { nqNormal, nqLow, nqHigh, nqHighest };

class PASCALIMPLEMENTATION TTreeNavigator : public Teetree::TTree
{
	typedef Teetree::TTree inherited;
	
private:
	bool FClickToNavigate;
	System::Classes::TNotifyEvent FOnSelectionMoved;
	TNavigatorQuality FQuality;
	bool FScrollOutside;
	Teetree::TTree* FTree;
	bool IRefreshing;
	bool IRepositioning;
	Teetree::TTreeNodeShape* ITool;
	void __fastcall CreateSelector();
	Teetree::TTreeNodeShape* __fastcall GetSelector();
	void __fastcall MovingShape(Teetree::TTreeNodeShape* Sender, int &DeltaX, int &DeltaY);
	void __fastcall SetQuality(const TNavigatorQuality Value);
	void __fastcall SetScrollOutside(const bool Value);
	void __fastcall SetTree(Teetree::TTree* const Value);
	void __fastcall VerifyInsideBounds();
	
protected:
	DYNAMIC void __fastcall Click();
	virtual void __fastcall InternalDraw(const System::Types::TRect &UserRectangle);
	virtual void __fastcall Loaded();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall PrepareTree();
	DYNAMIC void __fastcall Resize();
	
public:
	bool AutoBorderSize;
	__fastcall virtual TTreeNavigator(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTreeNavigator();
	void __fastcall RefreshTreeMap();
	void __fastcall Reposition();
	__property Teetree::TTreeNodeShape* Selector = {read=GetSelector};
	float __fastcall TotalBoundsRatio();
	TTeeSize __fastcall TotalSize();
	
__published:
	__property bool ClickToNavigate = {read=FClickToNavigate, write=FClickToNavigate, default=1};
	__property TNavigatorQuality Quality = {read=FQuality, write=SetQuality, default=0};
	__property bool ScrollOutside = {read=FScrollOutside, write=SetScrollOutside, default=0};
	__property Teetree::TTree* Tree = {read=FTree, write=SetTree};
	__property System::Classes::TNotifyEvent OnSelectionMoved = {read=FOnSelectionMoved, write=FOnSelectionMoved};
public:
	/* TWinControl.CreateParented */ inline __fastcall TTreeNavigator(HWND ParentWindow) : Teetree::TTree(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treemapnavigator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEMAPNAVIGATOR)
using namespace Treemapnavigator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreemapnavigatorHPP
