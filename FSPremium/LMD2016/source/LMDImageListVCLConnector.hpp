// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDImageListVCLConnector.pas' rev: 31.00 (Windows)

#ifndef LmdimagelistvclconnectorHPP
#define LmdimagelistvclconnectorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDBase.hpp>
#include <LMDBaseController.hpp>
#include <LMDImageList.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <System.ImageList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdimagelistvclconnector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDImageListVCLConnector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDImageListVCLConnector : public Vcl::Imglist::TCustomImageList
{
	typedef Vcl::Imglist::TCustomImageList inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdimagelist::TLMDImageList* FImageList;
	int FListIndex;
	System::Byte FUpdateCount;
	Vcl::Imglist::TChangeLink* FChangeLink;
	bool FMasked;
	void __fastcall SetImageList(Lmdimagelist::TLMDImageList* aValue);
	void __fastcall SetListIndex(const int aValue);
	HIDESBASE void __fastcall ReadLeft(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall ReadTop(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteLeft(System::Classes::TWriter* Writer);
	HIDESBASE void __fastcall WriteTop(System::Classes::TWriter* Writer);
	void __fastcall SetMasked(const bool Value);
	
protected:
	HIDESBASE void __fastcall BeginUpdate(void);
	HIDESBASE void __fastcall EndUpdate(bool repaint = false);
	HIDESBASE void __fastcall CopyImages(Lmdimagelist::TLMDImageList* aList, int aIndex);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ImageListChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDImageListVCLConnector(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDImageListVCLConnector(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Change(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property bool Masked = {read=FMasked, write=SetMasked, default=1};
	__property Lmdimagelist::TLMDImageList* ImageList = {read=FImageList, write=SetImageList};
	__property int ListIndex = {read=FListIndex, write=SetListIndex, default=0};
	__property OnChange;
public:
	/* TCustomImageList.CreateSize */ inline __fastcall TLMDImageListVCLConnector(int AWidth, int AHeight) : Vcl::Imglist::TCustomImageList(AWidth, AHeight) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdimagelistvclconnector */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIMAGELISTVCLCONNECTOR)
using namespace Lmdimagelistvclconnector;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdimagelistvclconnectorHPP
