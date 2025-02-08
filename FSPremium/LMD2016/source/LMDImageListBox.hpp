// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDImageListBox.pas' rev: 31.00 (Windows)

#ifndef LmdimagelistboxHPP
#define LmdimagelistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomListBox.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdimagelistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDImageListBox;
class DELPHICLASS TLMDLabeledImageListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDImageListBox : public Lmdcustomimagelistbox::TLMDCustomImageListBox
{
	typedef Lmdcustomimagelistbox::TLMDCustomImageListBox inherited;
	
public:
	__property Count;
	
__published:
	__property GlyphNumber = {default=1};
	__property GlyphColumn = {default=0};
	__property ItemIndex;
	__property ImageList;
	__property ListIndex = {default=0};
	__property Items;
	__property Layout;
	__property ImagesOnly = {default=0};
	__property MultiLine = {default=0};
	__property Margin = {default=1};
	__property Columns = {default=0};
	__property LargeTextOptions = {default=0};
	__property VerticalScrollBar = {default=1};
	__property HorzGridColor = {default=12632256};
	__property HorzGridStyle = {default=0};
	__property HorzGridLine = {default=0};
	__property EditOptions = {default=0};
	__property OnEditShow;
	__property OnEditMeasure;
	__property OnEditChange;
	__property OnEditHide;
	__property AutoComplete = {default=1};
	__property VirtualMode = {default=0};
	__property OnData;
	__property OnDataObject;
	__property OnDataFind;
public:
	/* TLMDCustomImageListBox.Create */ inline __fastcall virtual TLMDImageListBox(System::Classes::TComponent* AOwner) : Lmdcustomimagelistbox::TLMDCustomImageListBox(AOwner) { }
	/* TLMDCustomImageListBox.Destroy */ inline __fastcall virtual ~TLMDImageListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDImageListBox(HWND ParentWindow) : Lmdcustomimagelistbox::TLMDCustomImageListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledImageListBox : public TLMDImageListBox
{
	typedef TLMDImageListBox inherited;
	
public:
	__fastcall virtual TLMDLabeledImageListBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomImageListBox.Destroy */ inline __fastcall virtual ~TLMDLabeledImageListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledImageListBox(HWND ParentWindow) : TLMDImageListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdimagelistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIMAGELISTBOX)
using namespace Lmdimagelistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdimagelistboxHPP
