// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeMakerControl.pas' rev: 34.00 (Windows)

#ifndef TeemakercontrolHPP
#define TeemakercontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <Winapi.MMSystem.hpp>
#include <VCLTee.OpenGL2.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeOpenGL.hpp>
#include <TeeBlocks.hpp>
#include <TeeCamera.hpp>
#include <TeeGLSLShaders.hpp>
#include <System.UITypes.hpp>
#include <System.Math.Vectors.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teemakercontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFogBlock;
class DELPHICLASS TJoystick;
class DELPHICLASS TNavigate;
class DELPHICLASS TMakerFloor;
class DELPHICLASS TMakerOptions;
struct TDragBlockInfo;
class DELPHICLASS TMaker;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TFogStyle : unsigned char { fsLinear, fsExp, fsExp2 };

class PASCALIMPLEMENTATION TFogBlock : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Uitypes::TColor FColor;
	
public:
	double Density;
	TFogStyle Style;
	double StartPos;
	double EndPos;
	bool Fast;
	bool Enabled;
	__fastcall TFogBlock();
	void __fastcall Setup();
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, default=8421504};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TFogBlock() { }
	
};


class PASCALIMPLEMENTATION TJoystick : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FActive;
	tagJOYCAPSW ICaps;
	bool ICapsOk;
	System::Byte IJoyID;
	Vcl::Controls::TWinControl* IOwner;
	bool IPresent;
	void __fastcall CheckCaps();
	bool __fastcall GetPresent();
	void __fastcall SetActive(const bool Value);
	
public:
	System::Math::Vectors::TPoint3D Position;
	__fastcall TJoystick(Vcl::Controls::TWinControl* AOwner, System::Byte JoystickID);
	__property bool Present = {read=GetPresent, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJoystick() { }
	
};


enum DECLSPEC_DENUM TNavigateMode : unsigned char { nmObserve, nmWalk, nmFly, nmExplore };

enum DECLSPEC_DENUM TWheelAction : unsigned char { waNone, waZoom };

class PASCALIMPLEMENTATION TNavigate : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TJoystick* FJoy1;
	int FInertia;
	TNavigateMode FMode;
	float FWalkSpeed;
	TWheelAction FWheel;
	int FOldX;
	int FOldY;
	float IDifX;
	float IDifY;
	bool FDragging;
	System::Uitypes::TMouseButton IMouseButton;
	TMaker* IOwner;
	bool IDragged;
	bool IMovingRotating;
	System::Classes::TShiftState IShift;
	void __fastcall CheckPendingInertia();
	void __fastcall DoMove(const double MoveDelta);
	void __fastcall DoMouseMove(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall DoMouseWheel(int WheelDelta);
	void __fastcall DoRotate(int X, int Y, System::Classes::TShiftState Shift);
	void __fastcall DoRotation(const double IDifX, const double IDifY);
	bool __fastcall FlyEnabled(const Vcltee::Teeanimate::TTimerEvent &Sender);
	void __fastcall ForceInvalidate();
	TJoystick* __fastcall GetJoy1();
	bool __fastcall HasPendingInertia();
	bool __fastcall IsWalkSpeedStored();
	void __fastcall SetJoystick1(TJoystick* const Value);
	void __fastcall SetMode(const TNavigateMode Value);
	void __fastcall TimerFly(System::TObject* Sender);
	
protected:
	bool __fastcall IsPanning();
	
public:
	bool AllowRotationX;
	bool AllowRotationY;
	double FlySpeed;
	__fastcall TNavigate(TMaker* AOwner);
	__fastcall virtual ~TNavigate();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Math::Vectors::TPoint3D __fastcall MouseToLocation(const float AX, const float AY);
	__property bool Dragging = {read=FDragging, write=FDragging, nodefault};
	
__published:
	__property TJoystick* Joystick1 = {read=GetJoy1, write=SetJoystick1};
	__property TNavigateMode Mode = {read=FMode, write=SetMode, default=0};
	__property TWheelAction MouseWheel = {read=FWheel, write=FWheel, default=1};
	__property int RotateInertia = {read=FInertia, write=FInertia, default=30};
	__property float WalkSpeed = {read=FWalkSpeed, write=FWalkSpeed, stored=IsWalkSpeedStored};
};


enum DECLSPEC_DENUM TMakerLimitFloor : unsigned char { lfAuto, lfYes, lfNo };

class PASCALIMPLEMENTATION TMakerFloor : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FDistance;
	TMakerLimitFloor FLimit;
	System::Byte FReflection;
	Teeblocks::TRectangleBlock* IFloor;
	Teeblocks::TBlockFormat* __fastcall GetFormat();
	Teeblocks::TRotationXYZ* __fastcall GetRotation();
	Vcltee::Tecanvas::TPointXYZFloat* __fastcall GetSize();
	Teeblocks::TTile* __fastcall GetTile();
	bool __fastcall GetVisible();
	void __fastcall InitDefaults();
	void __fastcall SetDistance(const int Value);
	void __fastcall SetFormat(Teeblocks::TBlockFormat* const Value);
	void __fastcall SetLimit(const TMakerLimitFloor Value);
	void __fastcall SetReflection(const System::Byte Value);
	void __fastcall SetRotation(Teeblocks::TRotationXYZ* const Value);
	void __fastcall SetSize(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetTile(Teeblocks::TTile* const Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TMakerFloor(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMakerFloor();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod System::UnicodeString __fastcall DefaultTexture();
	__property Teeblocks::TRectangleBlock* Block = {read=IFloor};
	
__published:
	__property int Distance = {read=FDistance, write=SetDistance, default=0};
	__property Teeblocks::TBlockFormat* Format = {read=GetFormat, write=SetFormat};
	__property TMakerLimitFloor Limit = {read=FLimit, write=SetLimit, default=0};
	__property System::Byte Reflection = {read=FReflection, write=SetReflection, default=20};
	__property Teeblocks::TRotationXYZ* Rotation = {read=GetRotation, write=SetRotation};
	__property Vcltee::Tecanvas::TPointXYZFloat* Size = {read=GetSize, write=SetSize};
	__property Teeblocks::TTile* Tile = {read=GetTile, write=SetTile};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
};


enum DECLSPEC_DENUM TAnaglyph : unsigned char { haNone, haRedCyan, haCyanRed };

class PASCALIMPLEMENTATION TMakerOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FBoundingBox;
	Teecamera::TMakerCameras* FCameras;
	bool FClickToFocus;
	bool FDrawShadows;
	TMakerFloor* FFloor;
	TNavigate* FNavigate;
	bool FSelectMode;
	bool FShowLightLamps;
	bool FView3DAxes;
	TMaker* IMaker;
	void __fastcall CheckLimits();
	void __fastcall DrawAnaglyph();
	void __fastcall DrawAxes();
	void __fastcall DrawBlurShadows();
	bool __fastcall GetHideBorders();
	bool __fastcall GetUseThreads();
	bool __fastcall IsCamerasStored();
	void __fastcall SetBoundingBox(const bool Value);
	void __fastcall SetCameras(Teecamera::TMakerCameras* const Value);
	void __fastcall SetDrawShadows(const bool Value);
	void __fastcall SetFloor(TMakerFloor* const Value);
	void __fastcall SetHideBorders(const bool Value);
	void __fastcall SetNavigate(TNavigate* const Value);
	void __fastcall SetShowLightLamps(const bool Value);
	void __fastcall SetUseThreads(const bool Value);
	void __fastcall SetView3DAxes(const bool Value);
	
protected:
	void __fastcall AfterDraw();
	void __fastcall BeforeDraw();
	void __fastcall DrawBoundingBox(Teeblocks::TCustomBlock* const ABlock, const System::Uitypes::TColor AColor, bool DrawCoords);
	void __fastcall DrawReflection(TMakerFloor* const AReflect);
	
public:
	TAnaglyph Anaglyph;
	int AnaglyphDistance;
	TFogBlock* Fog;
	Teeblocks::TBlocks* SelectModeBlocks;
	bool ShowBoundPositions;
	System::UnicodeString BoundTitle;
	__fastcall TMakerOptions(Teeblocks::TBlocks* ABlocks);
	__fastcall virtual ~TMakerOptions();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool BoundingBox = {read=FBoundingBox, write=SetBoundingBox, default=0};
	__property Teecamera::TMakerCameras* Cameras = {read=FCameras, write=SetCameras, stored=IsCamerasStored};
	__property bool ClickToFocus = {read=FClickToFocus, write=FClickToFocus, default=1};
	__property bool DrawShadows = {read=FDrawShadows, write=SetDrawShadows, default=0};
	__property TMakerFloor* Floor = {read=FFloor, write=SetFloor};
	__property bool HideBorders = {read=GetHideBorders, write=SetHideBorders, default=1};
	__property TNavigate* Navigate = {read=FNavigate, write=SetNavigate};
	__property bool SelectMode = {read=FSelectMode, write=FSelectMode, default=0};
	__property bool ShowLightLamps = {read=FShowLightLamps, write=SetShowLightLamps, default=0};
	__property bool UseThreads = {read=GetUseThreads, write=SetUseThreads, default=0};
	__property bool View3DAxes = {read=FView3DAxes, write=SetView3DAxes, default=0};
};


typedef void __fastcall (__closure *TLoadMakerEvent)(TMaker* Sender, const System::UnicodeString FileName);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TDragBlockInfo
{
public:
	bool CheckMinMax;
	bool HasMin;
	bool HasMax;
	bool Invert;
	bool IsWheel;
	double MaxDrag;
	double MinDrag;
	bool PreDragging;
	System::Typinfo::TPropInfo *Prop;
	System::TObject* Target;
	Teeblocks::TCustomBlock* Source;
	System::UnicodeString Action;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TBlockEvent)(Teeblocks::TCustomBlock* Sender, const System::UnicodeString Event);

class PASCALIMPLEMENTATION TMaker : public Vcltee::Teeprocs::TCustomTeePanelExtended
{
	typedef Vcltee::Teeprocs::TCustomTeePanelExtended inherited;
	
private:
	Teeblocks::TBlocks* FBlocks;
	System::Classes::TNotifyEvent FOnBeforeDraw;
	TBlockEvent FOnBlockEvent;
	Vcl::Controls::TMouseEvent FOnClickedBlock;
	TLoadMakerEvent FOnDoLoad;
	Teeblocks::TCustomBlock* FCurrentOver;
	TMakerOptions* FOptions;
	Teeglslshaders::TProgramShader* FShader;
	Vcltee::Teeopengl::TTeeOpenGL* FTeeOpenGL;
	Teeblocks::TCustomBlock* FUnderMouse;
	Teeblocks::TCustomBlock* Current;
	TDragBlockInfo IDrag;
	unsigned IFrame;
	unsigned ILastTime;
	unsigned IFPS;
	System::UnicodeString IBlockToLoad;
	System::Types::TPoint OldPos;
	Teeblocks::TCustomBlock* __fastcall BlockParentWithAction(const System::UnicodeString AEvent, Teeblocks::TCustomBlock* ABlock);
	void __fastcall CanvasProjection(System::TObject* Sender);
	void __fastcall DoDragProp(int DeltaX, int DeltaY);
	void __fastcall ExploreCurrent();
	Teeblocks::TBlocks* __fastcall NewBlocks();
	Teeblocks::TAnimates* __fastcall GetAnimates();
	void __fastcall SetAnimates(Teeblocks::TAnimates* const Value);
	System::Classes::TStrings* __fastcall GetEvents();
	Teeblocks::TObjectProperties* __fastcall GetProperties();
	bool __fastcall HasEvents();
	bool __fastcall HasProperties();
	bool __fastcall IsAnimatesStored();
	void __fastcall SetEvents(System::Classes::TStrings* const Value);
	void __fastcall SetProperties(Teeblocks::TObjectProperties* const Value);
	bool __fastcall OnGetPicBits(Vcl::Graphics::TGraphic* AGraphic, System::Sysutils::PByteArray &Bits);
	void __fastcall OpenGLInit(System::TObject* Sender);
	void __fastcall ProcessEvent(Teeblocks::TCustomBlock* const ABlock, System::UnicodeString Action);
	void __fastcall RemovedBlock(System::TObject* Sender);
	Teeblocks::TCustomBlock* __fastcall SelectedClickedBlock(int X, int Y, bool SubObjects = false);
	void __fastcall SetCurrentOver(Teeblocks::TCustomBlock* const Value);
	void __fastcall SetOptions(TMakerOptions* const Value);
	void __fastcall SetSelected(Teeblocks::TCustomBlock* const Value);
	void __fastcall SetUnderMouse(Teeblocks::TCustomBlock* const Value);
	void __fastcall UpdatePosition(const float ADelta);
	
protected:
	MESSAGE void __fastcall CMBlockBirth(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall DoContextPopup(const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall DoInitDrag(int X, int Y);
	virtual void __fastcall InternalDraw(const System::Types::TRect &UserRectangle);
	void __fastcall DeleteAllLists();
	virtual void __fastcall Loaded();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall WriteState(System::Classes::TWriter* Writer);
	MESSAGE void __fastcall JoyButtonDown(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall JoyButtonUp(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall JoyMove(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall JoyZMove(Winapi::Messages::TMessage &Message);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	DYNAMIC void __fastcall DragCanceled();
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__property TDragBlockInfo DragInfo = {read=IDrag};
	bool __fastcall ParentIsSelected(Teeblocks::TCustomBlock* ABlock);
	void __fastcall ProcessTimerAction(System::TObject* Sender);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	__property Teeblocks::TCustomBlock* BlockUnderMouse = {read=FUnderMouse, write=SetUnderMouse};
	__property Teeblocks::TCustomBlock* CurrentOver = {read=FCurrentOver, write=SetCurrentOver};
	__property System::Types::TPoint DragPosition = {read=OldPos, write=OldPos};
	
public:
	bool RepaintMonitor;
	__fastcall virtual TMaker(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMaker();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Teeblocks::TCustomBlock* __fastcall DoBlockAction(Teeblocks::TCustomBlock* const ABlock, System::UnicodeString AEvent);
	HIDESBASE void __fastcall DoKeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall DoSingleAction(Teeblocks::TCustomBlock* const ABlock, System::UnicodeString AAction);
	DYNAMIC void __fastcall DrawPanelBevels(const System::Types::TRect &Rect);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	__property Vcltee::Teeopengl::TTeeOpenGL* Render = {read=FTeeOpenGL};
	__property Teeblocks::TCustomBlock* Selected = {read=Current, write=SetSelected};
	
__published:
	__property BackImage;
	__property BackImageMode = {default=0};
	__property Gradient;
	__property OnAfterDraw;
	__property BufferedDisplay = {default=1};
	__property View3D = {default=1};
	__property View3DOptions;
	__property Align = {default=0};
	__property Color = {default=16777215};
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property DragKind = {default=0};
	__property Locked = {default=0};
	__property Teeblocks::TAnimates* Animates = {read=GetAnimates, write=SetAnimates, stored=IsAnimatesStored};
	__property System::Classes::TStrings* Events = {read=GetEvents, write=SetEvents, stored=HasEvents};
	__property Teeblocks::TObjectProperties* Properties = {read=GetProperties, write=SetProperties, stored=HasProperties};
	__property Teeblocks::TBlocks* Blocks = {read=FBlocks};
	__property TMakerOptions* Options = {read=FOptions, write=SetOptions};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDrag;
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnGesture;
	__property System::Classes::TNotifyEvent OnBeforeDraw = {read=FOnBeforeDraw, write=FOnBeforeDraw};
	__property TBlockEvent OnBlockEvent = {read=FOnBlockEvent, write=FOnBlockEvent};
	__property Vcl::Controls::TMouseEvent OnClickedBlock = {read=FOnClickedBlock, write=FOnClickedBlock};
	__property TLoadMakerEvent OnDoLoad = {read=FOnDoLoad, write=FOnDoLoad};
public:
	/* TWinControl.CreateParented */ inline __fastcall TMaker(HWND ParentWindow) : Vcltee::Teeprocs::TCustomTeePanelExtended(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemakercontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEMAKERCONTROL)
using namespace Teemakercontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeemakercontrolHPP
