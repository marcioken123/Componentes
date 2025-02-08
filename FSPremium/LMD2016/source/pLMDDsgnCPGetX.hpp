// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDDsgnCPGetX.pas' rev: 31.00 (Windows)

#ifndef PlmddsgncpgetxHPP
#define PlmddsgncpgetxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ImgList.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Forms.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDBitmapList.hpp>
#include <LMDGenericList.hpp>
#include <LMDStringList.hpp>
#include <LMDImageList.hpp>
#include <LMDWave.hpp>
#include <LMDWaveList.hpp>
#include <LMDPNGImage.hpp>
#include <Vcl.Imaging.pngimage.hpp>
#include <LMDGraphicList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmddsgncpgetx
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPathItemType : unsigned char { piBitmap, piWave, piText, piGeneric, piAVI };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDCPEditGraphicList(Lmdgraphiclist::TLMDGraphicList* aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPEditPNGList(Lmdpngimagelist::TLMDPNGImageList* aValue);
extern DELPHI_PACKAGE void __fastcall LMDSaveListPath(Lmdcustomcontainer::TLMDListItemClassType typ, const System::UnicodeString aValue);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDRestoreListPath(Lmdcustomcontainer::TLMDListItemClassType typ);
extern DELPHI_PACKAGE void __fastcall LMDSaveItemPath(TLMDPathItemType typ, const System::UnicodeString aValue);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDRestoreItemPath(const TLMDPathItemType typ);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDCPGetFilter(Lmdcustomcontainer::TLMDListItemClassType aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetGenericList(Lmdgenericlist::TLMDGenericList* aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetStringList(Lmdstringlist::TLMDStringList* aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetBitmapList(Lmdbitmaplist::TLMDBitmapList* aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetImageList(Lmdimagelist::TLMDImageList* aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetWaveList(Lmdwavelist::TLMDWaveList* aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetIMLExt(Designintf::_di_IDesigner FDesigner, Vcl::Imglist::TCustomImageList* &aValue, System::Word &ListIndex, System::Word &ItemIndex);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetIML(Vcl::Imglist::TCustomImageList* aValue, System::Word &ListIndex, System::Word &ItemIndex);
extern DELPHI_PACKAGE bool __fastcall LMDCPIMLAddItemsDlg(Lmdcustomimagelist::TLMDCustomImageList* src, Lmdcustomimagelist::TLMDCustomImageList* target, int MainIndex);
extern DELPHI_PACKAGE bool __fastcall LMDCPIMLAddItemsFromFile(const System::UnicodeString srcName, Lmdcustomimagelist::TLMDCustomImageList* Target, int MainIndex)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDCPIMLAddItemsFromFile(const System::UnicodeString srcName, Lmdimagelist::TLMDImageListItem* Target)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDCPGetWave(Lmdwave::TLMDWave* aWave);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetPNG(Lmdpngimage::TLMDPNGObject* aBitmap);
}	/* namespace Plmddsgncpgetx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDDSGNCPGETX)
using namespace Plmddsgncpgetx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmddsgncpgetxHPP
