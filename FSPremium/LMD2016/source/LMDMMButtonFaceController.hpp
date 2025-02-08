// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMMButtonFaceController.pas' rev: 31.00 (Windows)

#ifndef LmdmmbuttonfacecontrollerHPP
#define LmdmmbuttonfacecontrollerHPP

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
#include <LMDCont.hpp>
#include <LMDBaseController.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmmbuttonfacecontroller
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMMButtonFaceController;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMMButtonFaceController : public Lmdbasecontroller::TLMDBaseController
{
	typedef Lmdbasecontroller::TLMDBaseController inherited;
	
private:
	Lmdbuttonbase::TLMDButtonFace* FButtonFace;
	Vcl::Imglist::TCustomImageList* FButtonFaceImageList;
	Vcl::Imglist::TChangeLink* FButtonFaceChangeLink;
	Lmdbuttonbase::TLMDButtonFaceIndices FButtonFaceIndices;
	System::Uitypes::TColor FTransCol;
	void __fastcall SetButtonFaceImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetButtonFaceIndex(Lmdbuttonbase::TLMDButtonState Index, Lmdbuttonbase::TLMDButtonFaceIndex aValue);
	Lmdbuttonbase::TLMDButtonFaceIndex __fastcall GetButtonFaceIndex(Lmdbuttonbase::TLMDButtonState Index);
	void __fastcall ReadIndexIdent(System::Classes::TStream* S);
	void __fastcall WriteIndexIdent(System::Classes::TStream* S);
	void __fastcall ButtonFaceReadIdent(System::Classes::TReader* Reader);
	void __fastcall ButtonFaceWriteIdent(System::Classes::TWriter* Writer);
	void __fastcall ReadTransColIdent(System::Classes::TStream* S);
	void __fastcall WriteTransColIdent(System::Classes::TStream* S);
	bool __fastcall ButtonFaceCheckCont(void);
	bool __fastcall ButtonFaceHasControl(void);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDMMButtonFaceController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDMMButtonFaceController(void);
	void __fastcall GetButtonFaceIndices(Lmdbuttonbase::TLMDButtonFaceIndices &aValue);
	void __fastcall SetButtonFaceIndices(const Lmdbuttonbase::TLMDButtonFaceIndices &aValue);
	void __fastcall SetTransCol(void);
	void __fastcall Synchronize(bool aValue = false);
	__property Lmdbuttonbase::TLMDButtonFaceIndex ButtonFaceIndex[Lmdbuttonbase::TLMDButtonState index] = {read=GetButtonFaceIndex, write=SetButtonFaceIndex};
	
__published:
	__property Lmdbuttonbase::TLMDButtonFace* ButtonFace = {read=FButtonFace, write=FButtonFace};
	__property Vcl::Imglist::TCustomImageList* ButtonFaceImageList = {read=FButtonFaceImageList, write=SetButtonFaceImageList, stored=ButtonFaceHasControl};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmmbuttonfacecontroller */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMMBUTTONFACECONTROLLER)
using namespace Lmdmmbuttonfacecontroller;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmmbuttonfacecontrollerHPP
