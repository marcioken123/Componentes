// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uedituserform.pas' rev: 21.00

#ifndef UedituserformHPP
#define UedituserformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uedituserform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmEditUser;
class PASCALIMPLEMENTATION TfrmEditUser : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* Label1;
	Dbctrls::TDBEdit* txtUsername;
	Stdctrls::TLabel* Label2;
	Dbctrls::TDBEdit* txtFullName;
	Stdctrls::TLabel* Label3;
	Dbctrls::TDBEdit* txtPassword;
	Stdctrls::TLabel* Label4;
	Stdctrls::TEdit* txtPasswordVerify;
	Dbctrls::TDBCheckBox* cbEnabled;
	Stdctrls::TLabel* Label5;
	Stdctrls::TLabel* Label6;
	Dbctrls::TDBText* labAccessCount;
	Dbctrls::TDBText* labCreatedDate;
	Buttons::TBitBtn* btnOK;
	Buttons::TBitBtn* btnCancel;
	Db::TDataSource* dsUsers;
	Stdctrls::TLabel* Label7;
	Dbctrls::TDBText* labLastAccess;
	Extctrls::TImage* Image1;
	void __fastcall btnOKClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmEditUser(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmEditUser(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmEditUser(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmEditUser(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uedituserform */
using namespace Uedituserform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UedituserformHPP
