// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Animations.Gallery.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Animations_GalleryHPP
#define Fmxtee_Animations_GalleryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Rtti.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Tools.Gallery.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMX.Objects.hpp>
#include <FMXTee.Animations.Tools.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Animations
{
namespace Gallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnimationsGallery;
//-- type declarations -------------------------------------------------------
_DECLARE_METACLASS(System::TMetaClass, TTeeAnimationToolClass);

class PASCALIMPLEMENTATION TAnimationsGallery : public Fmxtee::Tools::Gallery::TToolsGallery
{
	typedef Fmxtee::Tools::Gallery::TToolsGallery inherited;
	
__published:
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
protected:
	Fmxtee::Tools::Gallery::TTeeToolType* IAnimType;
	virtual bool __fastcall FilterTool(int Index);
	virtual void __fastcall FillTools();
	
public:
	static Fmxtee::Tools::Gallery::TToolsGalleryHook GalleryHook;
	__classmethod TTeeAnimationToolClass __fastcall Choose(System::Classes::TComponent* const AOwner, /* out */ System::UnicodeString &ASelected);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAnimationsGallery(System::Classes::TComponent* AOwner) : Fmxtee::Tools::Gallery::TToolsGallery(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAnimationsGallery(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Tools::Gallery::TToolsGallery(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAnimationsGallery() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Gallery */
}	/* namespace Animations */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_ANIMATIONS_GALLERY)
using namespace Fmxtee::Animations::Gallery;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_ANIMATIONS)
using namespace Fmxtee::Animations;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Animations_GalleryHPP
