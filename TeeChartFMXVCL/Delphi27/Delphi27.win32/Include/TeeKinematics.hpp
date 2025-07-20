// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeKinematics.pas' rev: 34.00 (Windows)

#ifndef TeekinematicsHPP
#define TeekinematicsHPP

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
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeMakerControl.hpp>
#include <TeePointEditor.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teekinematics
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMaterial;
class DELPHICLASS TMovement;
class DELPHICLASS TGravity;
class DELPHICLASS TMovements;
class DELPHICLASS TRotationLimits;
class DELPHICLASS TJoint;
class DELPHICLASS TJoints;
class DELPHICLASS TKinematics;
class DELPHICLASS TKinematicsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMaterial : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	double FFriction;
	double FDensity;
	double FBounce;
	
public:
	__fastcall TMaterial();
	
__published:
	__property double Bounce = {read=FBounce, write=FBounce};
	__property double Density = {read=FDensity, write=FDensity};
	__property double Friction = {read=FFriction, write=FFriction};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMaterial() { }
	
};


class PASCALIMPLEMENTATION TMovement : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	double FAccel;
	Teeblocks::TCustomBlock* FBlock;
	Vcltee::Tecanvas::TPointXYZFloat* FCenter;
	Vcltee::Teeanimate::TPropertyLink* FCenterLink;
	bool FCircular;
	Vcltee::Tecanvas::TPointXYZFloat* FDirection;
	TMaterial* FMaterial;
	Vcltee::Tecanvas::TPointXYZFloat* FRadius;
	double FSpeed;
	double Angle;
	System::Classes::TComponent* IOwner;
	System::Math::Vectors::TPoint3D __fastcall CenterPoint();
	Vcltee::Teeanimate::TPropertyLink* __fastcall GetCenterLink();
	bool __fastcall HasLink(Vcltee::Teeanimate::TPropertyLink* ALink);
	void __fastcall SetCenter(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetCenterLink(Vcltee::Teeanimate::TPropertyLink* const Value);
	void __fastcall SetDirection(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetRadius(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetMaterial(TMaterial* const Value);
	
public:
	__fastcall virtual TMovement(System::Classes::TCollection* ACollection);
	__fastcall virtual ~TMovement();
	
__published:
	__property double Acceleration = {read=FAccel, write=FAccel};
	__property Teeblocks::TCustomBlock* Block = {read=FBlock, write=FBlock};
	__property TMaterial* Material = {read=FMaterial, write=SetMaterial};
	__property Vcltee::Tecanvas::TPointXYZFloat* Center = {read=FCenter, write=SetCenter};
	__property Vcltee::Teeanimate::TPropertyLink* CenterLink = {read=GetCenterLink, write=SetCenterLink};
	__property bool Circular = {read=FCircular, write=FCircular, default=0};
	__property Vcltee::Tecanvas::TPointXYZFloat* Direction = {read=FDirection, write=SetDirection};
	__property Vcltee::Tecanvas::TPointXYZFloat* Radius = {read=FRadius, write=SetRadius};
	__property double Speed = {read=FSpeed, write=FSpeed};
};


class PASCALIMPLEMENTATION TGravity : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	double FAccel;
	bool FEnabled;
	TMovements* IBlocks;
	bool __fastcall IsAccelStored();
	void __fastcall SetAccel(const double Value);
	
public:
	__fastcall TGravity();
	__fastcall virtual ~TGravity();
	
__published:
	__property double Acceleration = {read=FAccel, write=SetAccel, stored=IsAccelStored};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
};


typedef void __fastcall (__closure *TCollisionEvent)(TMovement* Sender, Teeblocks::TCustomBlock* const ABlock, Teeblocks::TCustomBlock* &ACollided, System::Math::Vectors::TPoint3D &APoint);

class PASCALIMPLEMENTATION TMovements : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TMovement* operator[](int Index) { return this->Item[Index]; }
	
private:
	bool FCollisions;
	bool FEnabled;
	TGravity* FGravity;
	TCollisionEvent FOnCollision;
	Teemakercontrol::TMaker* IMaker;
	TKinematics* IKinematics;
	TMovement* __fastcall Get(int Index);
	void __fastcall Process(bool AutoSpeed = false);
	void __fastcall Put(int Index, TMovement* const Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetGravity(TGravity* const Value);
	
public:
	__fastcall TMovements(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMovements();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	TMovement* __fastcall AddMovement();
	void __fastcall DrawDirections();
	__property Teemakercontrol::TMaker* Maker = {read=IMaker, write=IMaker};
	__property TMovement* Item[int Index] = {read=Get, write=Put/*, default*/};
	
__published:
	__property bool Collisions = {read=FCollisions, write=FCollisions, default=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property TGravity* Gravity = {read=FGravity, write=SetGravity};
	__property TCollisionEvent OnCollision = {read=FOnCollision, write=FOnCollision};
};


class PASCALIMPLEMENTATION TRotationLimits : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	double FMinX;
	double FMaxX;
	double FMinZ;
	double FMinY;
	double FMaxZ;
	double FMaxY;
	
public:
	__fastcall TRotationLimits();
	
__published:
	__property double MinX = {read=FMinX, write=FMinX};
	__property double MaxX = {read=FMaxX, write=FMaxX};
	__property double MinY = {read=FMinY, write=FMinY};
	__property double MaxY = {read=FMaxY, write=FMaxY};
	__property double MinZ = {read=FMinZ, write=FMinZ};
	__property double MaxZ = {read=FMaxZ, write=FMaxZ};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRotationLimits() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TJoint : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Teeblocks::TCustomBlock* FBlock;
	Teeblocks::TCustomBlock* FParent;
	Vcltee::Tecanvas::TPointXYZFloat* FParentPosition;
	Vcltee::Tecanvas::TPointXYZFloat* FPosition;
	TRotationLimits* FLimits;
	TRotationLimits* __fastcall GetLimits();
	System::Math::Vectors::TPoint3D __fastcall GetRotation();
	void __fastcall SetBlock(Teeblocks::TCustomBlock* const Value);
	void __fastcall SetLimits(TRotationLimits* const Value);
	void __fastcall SetPosition(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetParentPosition(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	
public:
	__fastcall virtual TJoint(System::Classes::TCollection* AOwner);
	__fastcall virtual ~TJoint();
	
__published:
	__property Teeblocks::TCustomBlock* Block = {read=FBlock, write=SetBlock};
	__property Teeblocks::TCustomBlock* Parent = {read=FParent, write=FParent};
	__property Vcltee::Tecanvas::TPointXYZFloat* ParentPosition = {read=FParentPosition, write=SetParentPosition};
	__property Vcltee::Tecanvas::TPointXYZFloat* Position = {read=FPosition, write=SetPosition};
	__property TRotationLimits* RotationLimits = {read=GetLimits, write=SetLimits};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJoints : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TJoint* operator[](int Index) { return this->Item[Index]; }
	
private:
	TJoint* __fastcall Get(int Index);
	void __fastcall Put(int Index, TJoint* const Value);
	
public:
	TJoint* __fastcall AddJoint();
	void __fastcall Process();
	__property TJoint* Item[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TJoints(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TJoints() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TKinematics : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TJoints* FJoints;
	TMovements* FMovements;
	void __fastcall SetJoints(TJoints* const Value);
	void __fastcall SetMovements(TMovements* const Value);
	void __fastcall Timer(System::TObject* Sender);
	void __fastcall TryToEnable();
	
public:
	__fastcall TKinematics(Teemakercontrol::TMaker* AMaker);
	__fastcall virtual ~TKinematics();
	
__published:
	__property TJoints* Joints = {read=FJoints, write=SetJoints};
	__property TMovements* Movements = {read=FMovements, write=SetMovements};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TKinematicsEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TCheckBox* CBEnableGravity;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EAccelGravity;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TCheckBox* CBCollisions;
	Vcl::Stdctrls::TListBox* ListMoves;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Buttons::TSpeedButton* SBAdd;
	Vcl::Buttons::TSpeedButton* SBRemove;
	Vcl::Stdctrls::TCheckBox* CBEnabled;
	Vcl::Stdctrls::TListBox* ListJoints;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Buttons::TSpeedButton* SBAddJoint;
	Vcl::Buttons::TSpeedButton* SBRemoveJoint;
	Vcl::Comctrls::TPageControl* PageJoints;
	Vcl::Comctrls::TTabSheet* TabJointBlock;
	Vcl::Comctrls::TTabSheet* TabJointParent;
	Vcl::Comctrls::TTabSheet* TabSheet6;
	Vcl::Stdctrls::TGroupBox* GroupX;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Comctrls::TTrackBar* TBXMin;
	Vcl::Comctrls::TTrackBar* TBXMax;
	Vcl::Stdctrls::TLabel* LXMin;
	Vcl::Stdctrls::TLabel* LXMax;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* LYMin;
	Vcl::Stdctrls::TLabel* LYMax;
	Vcl::Comctrls::TTrackBar* TBYMin;
	Vcl::Comctrls::TTrackBar* TBYMax;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TLabel* LZMin;
	Vcl::Stdctrls::TLabel* LZMax;
	Vcl::Comctrls::TTrackBar* TBZMin;
	Vcl::Comctrls::TTrackBar* TBZMax;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* LabelParentBlock;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* LabelBlock;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Comctrls::TTabSheet* TabDirection;
	Vcl::Comctrls::TTabSheet* TabCircular;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* ESpeed;
	Vcl::Comctrls::TUpDown* UDSpeed;
	Vcl::Stdctrls::TEdit* EAccel;
	Vcl::Comctrls::TUpDown* UDAccel;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* EBounce;
	Vcl::Comctrls::TUpDown* UDBounce;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TCheckBox* CBCircular;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Comctrls::TPageControl* PageControl3;
	Vcl::Comctrls::TTabSheet* TabCenter;
	Vcl::Comctrls::TTabSheet* TabSheet7;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TButton* BClearCenterLink;
	Vcl::Stdctrls::TLabel* LCenterLink;
	Vcl::Stdctrls::TMemo* Memo1;
	Vcl::Comctrls::TTabSheet* TabRadius;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TEdit* EFriction;
	Vcl::Comctrls::TUpDown* UDFriction;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TEdit* EDensity;
	Vcl::Comctrls::TUpDown* UDDensity;
	void __fastcall CBEnableGravityClick(System::TObject* Sender);
	void __fastcall EAccelGravityChange(System::TObject* Sender);
	void __fastcall CBCollisionsClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ListMovesClick(System::TObject* Sender);
	void __fastcall ESpeedChange(System::TObject* Sender);
	void __fastcall EAccelChange(System::TObject* Sender);
	void __fastcall SBRemoveClick(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	void __fastcall CBEnabledClick(System::TObject* Sender);
	void __fastcall TBXMinChange(System::TObject* Sender);
	void __fastcall TBXMaxChange(System::TObject* Sender);
	void __fastcall TBYMinChange(System::TObject* Sender);
	void __fastcall TBYMaxChange(System::TObject* Sender);
	void __fastcall TBZMinChange(System::TObject* Sender);
	void __fastcall TBZMaxChange(System::TObject* Sender);
	void __fastcall ListJointsClick(System::TObject* Sender);
	void __fastcall SBAddJointClick(System::TObject* Sender);
	void __fastcall SBRemoveJointClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall EBounceChange(System::TObject* Sender);
	void __fastcall CBCircularClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall BClearCenterLinkClick(System::TObject* Sender);
	void __fastcall EFrictionChange(System::TObject* Sender);
	void __fastcall EDensityChange(System::TObject* Sender);
	
private:
	TMovements* Movements;
	TKinematics* Kinematics;
	Teepointeditor::TPointEditor* IDirection;
	Teepointeditor::TPointEditor* ICircular;
	Teepointeditor::TPointEditor* IRadius;
	Teepointeditor::TPointEditor* IPosition;
	Teepointeditor::TPointEditor* IParentPosition;
	TJoint* __fastcall Joint();
	TMovement* __fastcall Movement();
	void __fastcall SetLinkLabel(Vcl::Stdctrls::TLabel* ALabel, Vcltee::Teeanimate::TPropertyLink* ALink);
	
public:
	void __fastcall RefreshKinematics(TKinematics* Value);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKinematicsEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKinematicsEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKinematicsEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TKinematicsEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define BlockAction_KinematicsCollision L"11"
extern DELPHI_PACKAGE Teeblocks::TCustomBlock* __fastcall Collide(Teeblocks::TCustomBlock* const ABlock, System::Math::Vectors::TPoint3D &ANewLocation);
}	/* namespace Teekinematics */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEKINEMATICS)
using namespace Teekinematics;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeekinematicsHPP
