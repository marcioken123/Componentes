// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDContainerComponent.pas' rev: 31.00 (Windows)

#ifndef LmdcontainercomponentHPP
#define LmdcontainercomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDCont.hpp>
#include <LMDClass.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcontainercomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDContainerComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDContainerComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FImageList;
	int FIndex;
	int FListIndex;
	Vcl::Imglist::TChangeLink* FChangeLink;
	System::TObject* FUserData;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FThemeGlobalMode;
	void __fastcall SetCtlXP(const bool Value);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetIndex(int index, int aValue);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	bool __fastcall GetCtlXP(void);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	
protected:
	virtual void __fastcall DoThemeChange(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ImageIndex = {read=FIndex, write=SetIndex, index=0, default=0};
	__property int ListIndex = {read=FListIndex, write=SetIndex, index=1, default=0};
	__property System::TObject* UserData = {read=FUserData, write=FUserData};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool CtlXP = {read=GetCtlXP, write=SetCtlXP, default=1};
	
public:
	__fastcall virtual TLMDContainerComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDContainerComponent(void);
	bool __fastcall IsThemed(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcontainercomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCONTAINERCOMPONENT)
using namespace Lmdcontainercomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcontainercomponentHPP
