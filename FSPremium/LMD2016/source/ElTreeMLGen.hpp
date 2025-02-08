// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeMLGen.pas' rev: 31.00 (Windows)

#ifndef EltreemlgenHPP
#define EltreemlgenHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.Math.hpp>
#include <Vcl.ImgList.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <LMDMlGen.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreemlgen
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeMLGenerator;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TMLTreeGenOwnerDrawEvent)(System::TObject* Sender, Eltree::TElTreeItem* Item, int SectionIndex, const System::Types::TRect &MaxRect, System::UnicodeString &ReplacementString);

typedef void __fastcall (__closure *TMLTreeGenImageEvent)(System::TObject* Sender, Vcl::Imglist::TCustomImageList* ImageList, int ImageIndex, System::UnicodeString &ReplacementString);

typedef void __fastcall (__closure *TMlTreeGenItemGenerateEvent)(System::TObject* Sender, Eltree::TElTreeItem* Item, bool &Generate);

typedef void __fastcall (__closure *TMlTreeGenItemGeneratedEvent)(System::TObject* Sender, Eltree::TElTreeItem* Item);

class PASCALIMPLEMENTATION TElTreeMLGenerator : public Lmdmlgen::TLMDCustomMLGen
{
	typedef Lmdmlgen::TLMDCustomMLGen inherited;
	
private:
	TMLTreeGenImageEvent FOnImage;
	
protected:
	bool FBusy;
	Eltree::TElTreeItem* FCurItem;
	int FCurItemIdx;
	Elheader::TElHeaderSection* FCurSection;
	int FCurSectionIdx;
	bool FGenerateColumns;
	bool FGenerateHeader;
	bool FGenerateHiddenItems;
	bool FGenerateImages;
	bool FGenerateInvisibleItems;
	bool FHeaderOnEveryPage;
	int FItemsPerPage;
	int FLastItemIdx;
	int FLastSectionIdx;
	TMlTreeGenItemGenerateEvent FOnItemGenerate;
	TMlTreeGenItemGeneratedEvent FOnItemGenerated;
	TMLTreeGenOwnerDrawEvent FOnOwnerDraw;
	int FRelItemIdx;
	int FRelSectionIdx;
	Eltree::TCustomElTree* FTree;
	Eltree::TElCellStyle* VirtStyle;
	virtual void __fastcall AfterExecute(void);
	virtual void __fastcall BeforeExecute(void);
	System::UnicodeString __fastcall BuildTree(Eltree::TElTreeItem* Item);
	System::UnicodeString __fastcall DrawCell(Eltree::TElTreeItem* Item, int SectionIndex);
	System::UnicodeString __fastcall DrawHeaderSection(int SectionIndex);
	virtual void __fastcall IfFound(System::UnicodeString IfName, Lmdmlgen::TLMDStringParameters* TagParameters, bool &ResultValue);
	virtual void __fastcall IsTag(System::UnicodeString TagName, bool &IsTag);
	virtual void __fastcall LoopIteration(int LoopNumb, System::UnicodeString LoopName, Lmdmlgen::TLMDStringParameters* TagParameters, bool &LoopDone);
	virtual void __fastcall MacroFound(System::UnicodeString MacroName, Lmdmlgen::TLMDStringParameters* TagParameters, System::UnicodeString &MacroResult, bool &UseTranslationTable);
	void __fastcall SetGenerateColumns(bool Value);
	void __fastcall SetGenerateHeader(bool Value);
	void __fastcall SetGenerateHiddenItems(bool Value);
	void __fastcall SetGenerateInvisibleItems(bool Value);
	void __fastcall SetHeaderOnEveryPage(bool Value);
	void __fastcall SetItemsPerPage(int Value);
	void __fastcall SetTree(Eltree::TCustomElTree* Value);
	virtual void __fastcall TagFound(System::UnicodeString Tag, const bool TagClosed, Lmdmlgen::TLMDStringParameters* TagParameters);
	virtual void __fastcall TriggerImageEvent(Vcl::Imglist::TCustomImageList* ImageList, int ImageIndex, System::UnicodeString &ReplacementString);
	virtual void __fastcall TriggerItemGeneratedEvent(Eltree::TElTreeItem* Item);
	virtual void __fastcall TriggerItemGenerateEvent(Eltree::TElTreeItem* Item, bool &Generate);
	virtual void __fastcall TriggerOwnerDrawEvent(Eltree::TElTreeItem* Item, int SectionIndex, const System::Types::TRect &MaxRect, System::UnicodeString &ReplacementString);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TElTreeMLGenerator(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeMLGenerator(void);
	__property Eltree::TElTreeItem* CurrentItem = {read=FCurItem};
	__property Elheader::TElHeaderSection* CurrentSection = {read=FCurSection};
	virtual void __fastcall Execute(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
	__property bool GenerateColumns = {read=FGenerateColumns, write=SetGenerateColumns, nodefault};
	__property bool GenerateHeader = {read=FGenerateHeader, write=SetGenerateHeader, default=1};
	__property bool GenerateHiddenItems = {read=FGenerateHiddenItems, write=SetGenerateHiddenItems, nodefault};
	__property bool GenerateInvisibleItems = {read=FGenerateInvisibleItems, write=SetGenerateInvisibleItems, nodefault};
	__property bool HeaderOnEveryPage = {read=FHeaderOnEveryPage, write=SetHeaderOnEveryPage, nodefault};
	__property int ItemsPerPage = {read=FItemsPerPage, write=SetItemsPerPage, default=0};
	__property OnAfterExecute;
	__property OnBeforeExecute;
	__property OnIfFound;
	__property TMLTreeGenImageEvent OnImage = {read=FOnImage, write=FOnImage};
	__property TMlTreeGenItemGenerateEvent OnItemGenerate = {read=FOnItemGenerate, write=FOnItemGenerate};
	__property TMlTreeGenItemGeneratedEvent OnItemGenerated = {read=FOnItemGenerated, write=FOnItemGenerated};
	__property OnLoopIteration;
	__property OnMacroFound;
	__property TMLTreeGenOwnerDrawEvent OnOwnerDraw = {read=FOnOwnerDraw, write=FOnOwnerDraw};
	__property OnPageBegin;
	__property OnPageEnd;
	__property OnTagFound;
	__property OnWriteString;
	__property TagPrefix = {default=0};
	__property Template;
	__property Eltree::TCustomElTree* Tree = {read=FTree, write=SetTree};
public:
	/* TLMDBaseMLGen.CreateFrom */ inline __fastcall TElTreeMLGenerator(Lmdmlgen::TLMDBaseMLGen* AOwner) : Lmdmlgen::TLMDCustomMLGen(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreemlgen */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREEMLGEN)
using namespace Eltreemlgen;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreemlgenHPP
