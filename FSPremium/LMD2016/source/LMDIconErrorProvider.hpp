// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIconErrorProvider.pas' rev: 31.00 (Windows)

#ifndef LmdiconerrorproviderHPP
#define LmdiconerrorproviderHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDVldBase.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdiconerrorprovider
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDIconErrorProvider;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDIconErrorProvider : public Lmdvldbase::TLMDCustomErrorProvider
{
	typedef Lmdvldbase::TLMDCustomErrorProvider inherited;
	
protected:
	System::Classes::TList* FControlPaintBoxList;
	Vcl::Graphics::TBitmap* FErrorIcon;
	System::Uitypes::TAnchorKind FErrorIconPosition;
	int FErrorIconDistance;
	void __fastcall SetErrorIcon(Vcl::Graphics::TBitmap* const Value);
	void __fastcall PaintBox_Paint(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoDisplayError(Lmdvldbase::_di_ILMDValidatedControl control, System::UnicodeString ErrorMsg, int ErrorLevel);
	
public:
	__fastcall virtual TLMDIconErrorProvider(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDIconErrorProvider(void);
	
__published:
	__property Vcl::Graphics::TBitmap* ErrorIcon = {read=FErrorIcon, write=SetErrorIcon};
	__property System::Uitypes::TAnchorKind ErrorIconPosition = {read=FErrorIconPosition, write=FErrorIconPosition, default=2};
	__property int ErrorIconDistance = {read=FErrorIconDistance, write=FErrorIconDistance, default=10};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdiconerrorprovider */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDICONERRORPROVIDER)
using namespace Lmdiconerrorprovider;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdiconerrorproviderHPP
