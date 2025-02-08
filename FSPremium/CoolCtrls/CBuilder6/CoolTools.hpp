// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolTools.pas' rev: 6.00

#ifndef CoolToolsHPP
#define CoolToolsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ImgList.hpp>	// Pascal unit
#include <ShellAPI.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <CoolPolygons.hpp>	// Pascal unit
#include <CoolLists.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <ShlObj.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <IniFiles.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <CoolUtils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Cooltools
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TDisplayResolution { dr640x480, dr800x600, dr1024x768, dr1152x864, dr1280x960, dr1280x1024, drError };
#pragma option pop

#pragma option push -b-
enum TColorMode { cm4bit, cm8bit, cm16bit, cm24bit, cm32bit, cmError };
#pragma option pop

#pragma option push -b-
enum TRestartWindows { rwForced, rwLogOff, rwPowerOff, rwReboot, rwShutdown };
#pragma option pop

#pragma option push -b-
enum TDisplayFrequency { df56Hertz, df60Hertz, df70Hertz, df72Hertz, df75Hertz, df85Hertz, df90Hertz, df100Hertz, df120Hertz, dfError };
#pragma option pop

class DELPHICLASS TCoolDesktop;
class PASCALIMPLEMENTATION TCoolDesktop : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	TRestartWindows FRestartType;
	TDisplayFrequency FDisplayFrequency;
	Classes::TNotifyEvent FOnDisplaySettingsChange;
	void __fastcall SetDisplayResolution(TDisplayResolution Value);
	TDisplayResolution __fastcall GetDisplayResolution(void);
	void __fastcall SetColorMode(TColorMode Value);
	TColorMode __fastcall GetColorMode(void);
	void __fastcall SetDisplayFrequency(TDisplayFrequency Value);
	TDisplayFrequency __fastcall GetDisplayFrequency(void);
	AnsiString __fastcall GetWindowsDirectoryValue();
	AnsiString __fastcall GetSystemDirectoryValue();
	AnsiString __fastcall GetCurrentDirectoryValue();
	AnsiString __fastcall GetDesktopDirectory();
	
public:
	__property AnsiString DesktopDirectory = {read=GetDesktopDirectory};
	__property AnsiString WindowsDirectory = {read=GetWindowsDirectoryValue};
	__property AnsiString SystemDirectory = {read=GetSystemDirectoryValue};
	__property AnsiString CurrentDirectory = {read=GetCurrentDirectoryValue};
	__fastcall virtual TCoolDesktop(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolDesktop(void);
	Classes::TStringList* __fastcall GetFileDirList(AnsiString FDirectory, AnsiString Filter, int Attr);
	Classes::TStringList* __fastcall GetDirList(AnsiString FDirectory, AnsiString Filter, int Attr);
	Classes::TStringList* __fastcall GetFileList(AnsiString FDirectory, AnsiString Filter, int Attr);
	Classes::TStringList* __fastcall GetFileNamesOnly(Classes::TStringList* AList);
	int __fastcall ColorModeToInt(TColorMode Value);
	TColorMode __fastcall IntToColorMode(int Value);
	TDisplayFrequency __fastcall IntToDisplayFrequency(int Value);
	int __fastcall DisplayFrequencyToInt(TDisplayFrequency Value);
	int __fastcall DisplayResolutionToWidth(TDisplayResolution Value);
	int __fastcall DisplayResolutionToHeight(TDisplayResolution Value);
	Classes::TStringList* __fastcall GetWindowsBitmaps(bool NamesOnly);
	void __fastcall SetWallpaper(AnsiString AWallpaper, bool ATiled);
	AnsiString __fastcall GetWallpaper();
	bool __fastcall GetWallpaperIsTile(void);
	Classes::TStringList* __fastcall GetPatterns(void);
	void __fastcall SetPattern(AnsiString APattern);
	AnsiString __fastcall GetPattern();
	Classes::TStringList* __fastcall GetShellFolders(void);
	void __fastcall SetFile(AnsiString AFileName, AnsiString AFolder, AnsiString AParam, AnsiString AName);
	void __fastcall SetDesktopFile(AnsiString AFileName, AnsiString AParam, AnsiString AName);
	void __fastcall SetFavoritesFile(AnsiString AFileName, AnsiString AParam, AnsiString AName);
	Classes::TStringList* __fastcall GetDesktopFiles(void);
	bool __fastcall DeleteDesktopFile(AnsiString AFileDesc);
	bool __fastcall OpenFile(AnsiString AFileName);
	void __fastcall SetStartupProgram(AnsiString ATitle, AnsiString ACmdLine, bool AOnce);
	void __fastcall DeleteStartupProgram(AnsiString ATitle, bool AIsOnce);
	void __fastcall RegisterFileType(AnsiString AExtension, AnsiString ATitle, AnsiString ACmdLine);
	void __fastcall UnRegisterFileType(AnsiString AExtension);
	bool __fastcall RestartWindows(void);
	bool __fastcall ExecuteApp(AnsiString FAppName, AnsiString FAppParams);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TDisplayFrequency DisplayFrequency = {read=GetDisplayFrequency, write=SetDisplayFrequency, default=4};
	__property TDisplayResolution DisplayResolution = {read=GetDisplayResolution, write=SetDisplayResolution, stored=false, nodefault};
	__property TColorMode ColorMode = {read=GetColorMode, write=SetColorMode, stored=false, nodefault};
	__property TRestartWindows RestartType = {read=FRestartType, write=FRestartType, default=4};
	__property Classes::TNotifyEvent OnDisplaySettingsChange = {read=FOnDisplaySettingsChange, write=FOnDisplaySettingsChange};
};


#pragma option push -b-
enum TLockerOption { loHideTaskBar, loHideStartBtn, loHideProgman, loPreventStartBtnExisting, loPreventAppClosing, loPreventAppMinimizing, loPreventCursorLoosing, loPreventSystemKeysWork, loAlwaysOnTopPosition, loTaskBarAutoHide };
#pragma option pop

typedef Set<TLockerOption, loHideTaskBar, loTaskBarAutoHide>  TLockerOptions;

class DELPHICLASS TCoolLocker;
class PASCALIMPLEMENTATION TCoolLocker : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	bool FEnabled;
	Extctrls::TTimer* FTimer;
	TLockerOptions FOptions;
	Coolutils::TWndHook* FWindowHook;
	Coolctrls::TCCAboutBox* FAboutBox;
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetOptions(TLockerOptions Value);
	void __fastcall TimeredAction(System::TObject* Sender);
	void __fastcall BeforeMessage(System::TObject* Sender, Messages::TMessage &Msg, bool &Handled);
	void __fastcall AfterMessage(System::TObject* Sender, Messages::TMessage &Msg, bool &Handled);
	void __fastcall ChangeControl(System::TObject* Sender);
	
protected:
	Coolctrls::TCoolForm* Form;
	virtual void __fastcall SetFlags(TLockerOptions Value);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TCoolLocker(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolLocker(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property TLockerOptions Options = {read=FOptions, write=SetOptions, nodefault};
};


#pragma option push -b-
enum TCaptureObject { coFile, coClipboard, coDevice };
#pragma option pop

#pragma option push -b-
enum TCaptureSize { csDefault, csCustom };
#pragma option pop

class DELPHICLASS TCoolCapture;
class PASCALIMPLEMENTATION TCoolCapture : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	TCaptureObject FCaptureObject;
	TCaptureSize FCaptureSize;
	unsigned FWindowHandle;
	#pragma pack(push, 1)
	Types::TRect FCaptureRect;
	#pragma pack(pop)
	
	#pragma pack(push, 1)
	Types::TRect FDeviceRect;
	#pragma pack(pop)
	
	unsigned FDeviceContext;
	Graphics::TBitmap* FBuffer;
	AnsiString FFileName;
	unsigned FZoomRatio;
	int FCopyMode;
	void __fastcall SetZoomRatio(unsigned Value);
	
public:
	__property Types::TRect CaptureRect = {read=FCaptureRect, write=FCaptureRect};
	__property Types::TRect DeviceRect = {read=FDeviceRect, write=FDeviceRect};
	__property unsigned DeviceContext = {read=FDeviceContext, write=FDeviceContext, nodefault};
	__property Graphics::TBitmap* Buffer = {read=FBuffer};
	__property unsigned WindowHandle = {read=FWindowHandle, write=FWindowHandle, default=0};
	__fastcall virtual TCoolCapture(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolCapture(void);
	void __fastcall Capture(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TCaptureObject CaptureObject = {read=FCaptureObject, write=FCaptureObject, default=1};
	__property TCaptureSize CaptureSize = {read=FCaptureSize, write=FCaptureSize, default=0};
	__property int CopyMode = {read=FCopyMode, write=FCopyMode, default=13369376};
	__property AnsiString FileName = {read=FFileName, write=FFileName};
	__property unsigned ZoomRatio = {read=FZoomRatio, write=SetZoomRatio, default=100};
};


#pragma option push -b-
enum TLoupeType { ltDynamic, ltStatic };
#pragma option pop

class DELPHICLASS TCoolLoupe;
class PASCALIMPLEMENTATION TCoolLoupe : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	bool FActive;
	TCoolCapture* FCoolCapture;
	unsigned FInterval;
	Extctrls::TTimer* FTimer;
	unsigned FZoomRatio;
	int FCopyMode;
	TLoupeType FLoupeType;
	#pragma pack(push, 1)
	Types::TPoint FLoupePosition;
	#pragma pack(pop)
	
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	Controls::TMouseMoveEvent FOnTotalMouseMove;
	void __fastcall SetActive(bool Value);
	void __fastcall SetInterval(unsigned Value);
	void __fastcall SetZoomRatio(unsigned Value);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall TimerEvent(System::TObject* Sender);
	void __fastcall UpdateTimer(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	
public:
	__property Types::TPoint LoupePosition = {read=FLoupePosition, write=FLoupePosition};
	__fastcall virtual TCoolLoupe(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolLoupe(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property int CopyMode = {read=FCopyMode, write=FCopyMode, default=13369376};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=100};
	__property TLoupeType LoupeType = {read=FLoupeType, write=FLoupeType, default=0};
	__property unsigned ZoomRatio = {read=FZoomRatio, write=SetZoomRatio, default=100};
	__property Controls::TMouseMoveEvent OnTotalMouseMove = {read=FOnTotalMouseMove, write=FOnTotalMouseMove};
	__property Align  = {default=0};
	__property AutoSize  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentShowHint  = {default=1};
	__property ShowHint ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
};


class DELPHICLASS TCoolLoupePolygones;
class PASCALIMPLEMENTATION TCoolLoupePolygones : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FActive;
	TCoolLoupe* FCoolLoupe;
	Coolpolygons::TPolygones* FPolygones;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	Controls::TMouseMoveEvent FOnTotalMouseMove;
	void __fastcall SetActive(bool Value);
	void __fastcall SetCopyMode(int Value);
	int __fastcall GetCopyMode(void);
	void __fastcall SetInterval(unsigned Value);
	unsigned __fastcall GetInterval(void);
	void __fastcall SetZoomRatio(unsigned Value);
	unsigned __fastcall GetZoomRatio(void);
	TLoupeType __fastcall GetLoupeType(void);
	void __fastcall SetLoupeType(TLoupeType Value);
	Types::TPoint __fastcall GetLoupePosition();
	void __fastcall SetLoupePosition(const Types::TPoint &Value);
	void __fastcall SetPolygones(Coolpolygons::TPolygones* Value);
	void __fastcall SetPolyRegiones(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ApplyPolygones(void);
	virtual void __fastcall Paint(void);
	
public:
	__property Types::TPoint LoupePosition = {read=GetLoupePosition, write=SetLoupePosition};
	__fastcall virtual TCoolLoupePolygones(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolLoupePolygones(void);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property int CopyMode = {read=GetCopyMode, write=SetCopyMode, default=13369376};
	__property unsigned Interval = {read=GetInterval, write=SetInterval, default=100};
	__property TLoupeType LoupeType = {read=GetLoupeType, write=SetLoupeType, default=0};
	__property Coolpolygons::TPolygones* Polygones = {read=FPolygones, write=SetPolygones};
	__property unsigned ZoomRatio = {read=GetZoomRatio, write=SetZoomRatio, default=100};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Controls::TMouseMoveEvent OnTotalMouseMove = {read=FOnTotalMouseMove, write=FOnTotalMouseMove};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolLoupePolygones(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


struct TWindowInfo;
typedef TWindowInfo *PWindowInfo;

#pragma pack(push, 1)
struct TWindowInfo
{
	char wTitle[256];
	char wClassName[256];
	unsigned wHandle;
	int wStyle;
	int wExStyle;
	Types::TRect wWindowRect;
	Types::TRect wClientRect;
	bool wEnabled;
	bool wVisible;
	bool wMaximized;
	bool wMinimized;
} ;
#pragma pack(pop)

class DELPHICLASS TCoolWindowsInformant;
class PASCALIMPLEMENTATION TCoolWindowsInformant : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	PWindowInfo operator[](int Index) { return Window[Index]; }
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Classes::TList* FWinList;
	unsigned FHandle;
	unsigned FParentHandle;
	unsigned FInterval;
	bool FTimered;
	Classes::TNotifyEvent FOnWindowsUpdating;
	Classes::TNotifyEvent FOnWindowsUpdated;
	int __fastcall GetCount(void);
	PWindowInfo __fastcall GetWindow(int Index);
	void __fastcall SetTimered(bool Value);
	void __fastcall SetInterval(unsigned Value);
	void __fastcall ClearList(void);
	void __fastcall UpdateTimer(void);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	virtual void __fastcall Loaded(void);
	
public:
	__property int Count = {read=GetCount, nodefault};
	__property unsigned ParentHandle = {read=FParentHandle, write=FParentHandle, default=0};
	__property PWindowInfo Window[int Index] = {read=GetWindow/*, default*/};
	__fastcall virtual TCoolWindowsInformant(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolWindowsInformant(void);
	void __fastcall UpdateWindows(void);
	void __fastcall CertainWindowInfo(unsigned AHandle, PWindowInfo &AInfo);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=1000};
	__property bool Timered = {read=FTimered, write=SetTimered, default=0};
	__property Classes::TNotifyEvent OnWindowsUpdating = {read=FOnWindowsUpdating, write=FOnWindowsUpdating};
	__property Classes::TNotifyEvent OnWindowsUpdated = {read=FOnWindowsUpdated, write=FOnWindowsUpdated};
};


class DELPHICLASS TCoolTrayIcon;
class PASCALIMPLEMENTATION TCoolTrayIcon : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	bool FActive;
	bool FAnimated;
	unsigned FHandle;
	Graphics::TIcon* FIcon;
	AnsiString FToolTip;
	Imglist::TChangeLink* FImageChangeLink;
	Controls::TImageList* FIcons;
	unsigned FInterval;
	int FIconIndex;
	Menus::TPopupMenu* FPopupMenu;
	bool FOwnerDrawMenu;
	bool FPreview;
	Controls::TMouseEvent FOnMouseUp;
	Controls::TMouseEvent FOnMouseDown;
	Controls::TMouseEvent FOnDoubleClick;
	void __fastcall SetActive(bool Value);
	void __fastcall SetAnimated(bool Value);
	void __fastcall SetIcon(Graphics::TIcon* Value);
	void __fastcall SetToolTip(AnsiString Value);
	void __fastcall SetIcons(Controls::TImageList* Value);
	void __fastcall SetInterval(unsigned Value);
	void __fastcall SetPopupMenu(Menus::TPopupMenu* Value);
	void __fastcall SetPreview(bool Value);
	bool __fastcall GetPreview(void);
	void __fastcall IconChange(System::TObject* Sender);
	void __fastcall IconsChange(System::TObject* Sender);
	void __fastcall UpdateTimer(void);
	void __fastcall UpdateIcon(void);
	void __fastcall ModifyIcon(Graphics::TIcon* AIcon);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button);
	DYNAMIC void __fastcall DoubleClick(Controls::TMouseButton Button);
	
public:
	__property bool Preview = {read=GetPreview, write=SetPreview, nodefault};
	__fastcall virtual TCoolTrayIcon(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolTrayIcon(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property bool Animated = {read=FAnimated, write=SetAnimated, default=0};
	__property Graphics::TIcon* Icon = {read=FIcon, write=SetIcon};
	__property Controls::TImageList* Icons = {read=FIcons, write=SetIcons};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=200};
	__property bool OwnerDrawMenu = {read=FOwnerDrawMenu, write=FOwnerDrawMenu, default=0};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property AnsiString ToolTip = {read=FToolTip, write=SetToolTip};
	__property Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property Controls::TMouseEvent OnDoubleClick = {read=FOnDoubleClick, write=FOnDoubleClick};
};


#pragma option push -b-
enum TInstanceAction { iaStartNew, iaSwitchToPrevious, iaCloseAll };
#pragma option pop

class DELPHICLASS TCoolInstancesChecker;
class PASCALIMPLEMENTATION TCoolInstancesChecker : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	int FInstanceID;
	TInstanceAction FInstanceAction;
	void __fastcall InstancesCheck(void);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TCoolInstancesChecker(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolInstancesChecker(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TInstanceAction InstanceAction = {read=FInstanceAction, write=FInstanceAction, default=1};
};


class DELPHICLASS TCoolDisksInformant;
class PASCALIMPLEMENTATION TCoolDisksInformant : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Classes::TStringList* FDrives;
	AnsiString FDrive;
	void __fastcall SetDrive(AnsiString Value);
	Classes::TStringList* __fastcall GetDrives(void);
	Filectrl::TDriveType __fastcall GetDriveType(void);
	AnsiString __fastcall GetDriveTypeStr();
	__int64 __fastcall GetTotalBytes(void);
	__int64 __fastcall GetFreeBytes(void);
	AnsiString __fastcall GetVolumeName();
	void __fastcall SetVolumeName(AnsiString Value);
	AnsiString __fastcall GetFileSystemName();
	
public:
	__property Classes::TStringList* Drives = {read=GetDrives};
	__property Filectrl::TDriveType DriveType = {read=GetDriveType, nodefault};
	__property AnsiString DriveTypeStr = {read=GetDriveTypeStr};
	__property __int64 TotalBytes = {read=GetTotalBytes};
	__property __int64 FreeBytes = {read=GetFreeBytes};
	__property AnsiString FileSystemName = {read=GetFileSystemName};
	__fastcall virtual TCoolDisksInformant(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolDisksInformant(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property AnsiString Drive = {read=FDrive, write=SetDrive};
	__property AnsiString VolumeName = {read=GetVolumeName, write=SetVolumeName};
};


class DELPHICLASS TCoolAnimate;
class PASCALIMPLEMENTATION TCoolAnimate : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	bool FActive;
	unsigned FHandle;
	Coolctrls::TCoolChangeLink* FCoolImageChangeLink;
	Coolctrls::TCoolImages* FCoolImages;
	unsigned FInterval;
	int FImageIndex;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	bool FTransparent;
	void __fastcall SetActive(bool Value);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetInterval(unsigned Value);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall UpdateTimer(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	
public:
	__fastcall virtual TCoolAnimate(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolAnimate(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=200};
	__property bool Transparent = {read=FTransparent, write=FTransparent, default=0};
	__property Align  = {default=0};
	__property AutoSize  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentShowHint  = {default=1};
	__property ShowHint ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
};


#pragma option push -b-
enum TAnimateEffect { aeStripesDown, aeStripesUp, aeStripesLeft, aeStripesRight, aeStripesTBCenter, aeStripesLRCenter, aeStripesCenterTB, aeStripesCenterLR, aeStripesPartsHz, aeStripesPartsVt };
#pragma option pop

typedef void __fastcall (__closure *TAnimationEvent)(System::TObject* Sender, int Index, bool &DoContinue);

class DELPHICLASS TAnimateThread;
class PASCALIMPLEMENTATION TAnimateThread : public Classes::TThread 
{
	typedef Classes::TThread inherited;
	
private:
	#pragma pack(push, 1)
	Types::TRect R;
	#pragma pack(pop)
	
	TAnimateEffect FEffect;
	Graphics::TBitmap* FSourceBmp;
	Graphics::TBitmap* FDestBmp;
	unsigned FHandle;
	Graphics::TCanvas* FCanvas;
	bool FExclusive;
	void __fastcall CopyRect(void);
	void __fastcall DoTopToBottom(void);
	void __fastcall DoBottomToTop(void);
	void __fastcall DoLeftToRight(void);
	void __fastcall DoRightToLeft(void);
	void __fastcall DoTopBottomToCenter(void);
	void __fastcall DoLeftRightToCenter(void);
	void __fastcall DoCenterToTopBottom(void);
	void __fastcall DoCenterToLeftRight(void);
	void __fastcall DoPartsHorizontally(void);
	void __fastcall DoPartsVertically(void);
	
protected:
	bool __fastcall ReasonToStop(void);
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TAnimateThread(unsigned Handle, Graphics::TBitmap* SourceBmp, Graphics::TBitmap* DestBmp, TAnimateEffect Effect, Graphics::TCanvas* Canvas, bool Exclusive);
	__fastcall virtual ~TAnimateThread(void);
};


class DELPHICLASS TCoolAnimateEffects;
class PASCALIMPLEMENTATION TCoolAnimateEffects : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	bool FActive;
	TAnimateEffect FAnimateEffect;
	Coolctrls::TCoolImages* FCoolImages;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	unsigned FHandle;
	int FImageIndex;
	Graphics::TBitmap* FBackground;
	bool FExclusive;
	TAnimateThread* FThread;
	TAnimationEvent FOnAnimationStart;
	TAnimationEvent FOnAnimationEnd;
	void __fastcall SetActive(bool Value);
	void __fastcall SetAnimateEffect(TAnimateEffect Value);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall BackgroundChange(System::TObject* Sender);
	void __fastcall StartProcess(void);
	void __fastcall EndProcess(void);
	void __fastcall UpdateTimer(void);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	
public:
	__fastcall virtual TCoolAnimateEffects(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolAnimateEffects(void);
	void __fastcall FillTheControl(Graphics::TColor AColor);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property TAnimateEffect AnimateEffect = {read=FAnimateEffect, write=SetAnimateEffect, default=0};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property bool Exclusive = {read=FExclusive, write=FExclusive, default=0};
	__property TAnimationEvent OnAnimationStart = {read=FOnAnimationStart, write=FOnAnimationStart};
	__property TAnimationEvent OnAnimationEnd = {read=FOnAnimationEnd, write=FOnAnimationEnd};
	__property Align  = {default=0};
	__property AutoSize  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Constraints ;
	__property Color  = {default=-2147483643};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentShowHint  = {default=1};
	__property ShowHint ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
};


#pragma option push -b-
enum TEffectTarget { etForm, etApplication };
#pragma option pop

typedef Set<TEffectTarget, etForm, etApplication>  TEffectTargets;

#pragma option push -b-
enum TEffectKind { ekCaptionScrolling, ekCaptionBlinking, ekBlinking };
#pragma option pop

class DELPHICLASS TCoolCaptionEffects;
class PASCALIMPLEMENTATION TCoolCaptionEffects : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	int FFormScrollBy;
	int FAppScrollBy;
	bool FFormReverse;
	bool FAppReverse;
	AnsiString FFormCaption;
	AnsiString FApplicationTitle;
	Extctrls::TTimer* FTimer;
	Forms::TCustomForm* FForm;
	bool FActive;
	unsigned FInterval;
	TEffectTargets FEffectTargets;
	TEffectKind FEffectKind;
	void __fastcall SetActive(bool Value);
	void __fastcall SetInterval(unsigned Value);
	void __fastcall SetEffectKind(TEffectKind Value);
	void __fastcall SetEffectTargets(TEffectTargets Value);
	void __fastcall ScrollFormCaption(void);
	void __fastcall ScrollApplicationTitle(void);
	void __fastcall TimerAction(System::TObject* Sender);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TCoolCaptionEffects(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolCaptionEffects(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property TEffectTargets EffectTargets = {read=FEffectTargets, write=SetEffectTargets, default=1};
	__property TEffectKind EffectKind = {read=FEffectKind, write=SetEffectKind, default=0};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=200};
};


#pragma option push -b-
enum TShadowOrientation { soLeftTop, soRightTop, soLeftBottom, soRightBottom };
#pragma option pop

class DELPHICLASS TCoolShadow;
class PASCALIMPLEMENTATION TCoolShadow : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	TShadowOrientation FShadowOrientation;
	Controls::TControl* FShadowControl;
	int FShadowSize;
	void __fastcall SetShadowOrientation(TShadowOrientation Value);
	void __fastcall SetShadowControl(Controls::TControl* Value);
	void __fastcall SetShadowSize(int Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ApplyShadow(void);
	
public:
	__fastcall virtual TCoolShadow(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolShadow(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TShadowOrientation ShadowOrientation = {read=FShadowOrientation, write=SetShadowOrientation, default=3};
	__property Controls::TControl* ShadowControl = {read=FShadowControl, write=SetShadowControl, default=0};
	__property int ShadowSize = {read=FShadowSize, write=SetShadowSize, default=10};
	__property Color  = {default=-2147483632};
	__property ParentColor  = {default=1};
	__property ParentShowHint  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
};


typedef void __fastcall (__closure *TBufferFillEvent)(System::TObject* Sender, AnsiString Buffer);

typedef void __fastcall (__closure *TKeyEventEx)(System::TObject* Sender, Word &Key, Classes::TShiftState Shift, bool &Handled);

typedef void __fastcall (__closure *TKeyPressEventEx)(System::TObject* Sender, char &Key, bool &Handled);

#pragma option push -b-
enum TMonitorMessage { mmKeyDown, mmKeyUp, mmKeyPress };
#pragma option pop

class DELPHICLASS TCoolKeyboardSpy;
class PASCALIMPLEMENTATION TCoolKeyboardSpy : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	bool FActive;
	TKeyEventEx FOnKeyDown;
	TKeyEventEx FOnKeyUp;
	TKeyPressEventEx FOnKeyPress;
	TBufferFillEvent FOnBufferFill;
	TBufferFillEvent FOnTimeOut;
	TMonitorMessage FMonitorMessage;
	bool FBuffering;
	AnsiString FBuffer;
	char FStartChar;
	char FFinalChar;
	Word FStartKey;
	Word FFinalKey;
	Extctrls::TTimer* FTimer;
	unsigned __fastcall GetTimeOut(void);
	void __fastcall SetTimeOut(unsigned Value);
	void __fastcall TimerTimeOut(System::TObject* Sender);
	
protected:
	virtual void __fastcall AppMessage(tagMSG &Msg, bool &Handled);
	
public:
	__property bool Buffering = {read=FBuffering, nodefault};
	__fastcall virtual TCoolKeyboardSpy(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolKeyboardSpy(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=FActive, default=1};
	__property TMonitorMessage MonitorMessage = {read=FMonitorMessage, write=FMonitorMessage, default=0};
	__property unsigned TimeOut = {read=GetTimeOut, write=SetTimeOut, default=0};
	__property char StartChar = {read=FStartChar, write=FStartChar, nodefault};
	__property char FinalChar = {read=FFinalChar, write=FFinalChar, nodefault};
	__property Word StartKey = {read=FStartKey, write=FStartKey, nodefault};
	__property Word FinalKey = {read=FFinalKey, write=FFinalKey, nodefault};
	__property TKeyEventEx OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property TKeyEventEx OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
	__property TKeyPressEventEx OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property TBufferFillEvent OnBufferFill = {read=FOnBufferFill, write=FOnBufferFill};
	__property TBufferFillEvent OnTimeOut = {read=FOnTimeOut, write=FOnTimeOut};
};


class DELPHICLASS TMemoryStreamEx;
class PASCALIMPLEMENTATION TMemoryStreamEx : public Classes::TMemoryStream 
{
	typedef Classes::TMemoryStream inherited;
	
public:
	void __fastcall WriteInteger(int Value);
	int __fastcall ReadInteger(void);
	void __fastcall WriteBoolean(bool Value);
	bool __fastcall ReadBoolean(void);
	void __fastcall WriteString(AnsiString Value)/* overload */;
	void __fastcall WriteString(const char * Value, const int Value_Size)/* overload */;
	AnsiString __fastcall ReadString();
public:
	#pragma option push -w-inl
	/* TMemoryStream.Destroy */ inline __fastcall virtual ~TMemoryStreamEx(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TMemoryStreamEx(void) : Classes::TMemoryStream() { }
	#pragma option pop
	
};


class DELPHICLASS TCoolClipboardComponent;
class PASCALIMPLEMENTATION TCoolClipboardComponent : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	bool __fastcall ClearClipboard(void);
	void __fastcall SaveClipboardToStream(TMemoryStreamEx* Stream, int Format);
	void __fastcall SaveClipboardToFile(AnsiString FileName);
	void __fastcall LoadClipboardFromStream(TMemoryStreamEx* Stream);
	void __fastcall LoadClipboardFromFile(AnsiString FileName);
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TCoolClipboardComponent(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TCoolClipboardComponent(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolClipboardViewer;
class PASCALIMPLEMENTATION TCoolClipboardViewer : public Forms::TScrollBox 
{
	typedef Forms::TScrollBox inherited;
	
private:
	HWND FNextWnd;
	Classes::TComponent* FCurrentViewer;
	Classes::TNotifyEvent FOnChange;
	Coolctrls::TCCAboutBox* FAboutBox;
	Classes::TComponent* __fastcall CreateCurrentViewerComponent(TMetaClass* MyClass);
	void __fastcall FreeCurrentViewerComponent(void);
	void __fastcall RegisterClipboardViewer(void);
	void __fastcall UnregisterClipboardViewer(void);
	void __fastcall CenterControl(Controls::TControl* Control);
	MESSAGE void __fastcall WMDrawClipboard(Messages::TMessage &Message);
	MESSAGE void __fastcall WMChangeCBChain(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWindowHandle(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall PaintContent(void);
	
public:
	bool __fastcall ClearClipboard(void);
	void __fastcall SaveClipboardToStream(TMemoryStreamEx* Stream, int Format);
	void __fastcall SaveClipboardToFile(AnsiString FileName);
	void __fastcall LoadClipboardFromStream(TMemoryStreamEx* Stream);
	void __fastcall LoadClipboardFromFile(AnsiString FileName);
	__fastcall virtual TCoolClipboardViewer(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolClipboardViewer(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Color  = {default=-2147483643};
	__property ParentColor  = {default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolClipboardViewer(HWND ParentWindow) : Forms::TScrollBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolTransparentArea;
class PASCALIMPLEMENTATION TCoolTransparentArea : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	bool FActive;
	Coolpolygons::TPolygones* FPolygones;
	void __fastcall SetActive(bool Value);
	void __fastcall SetPolygones(Coolpolygons::TPolygones* Value);
	unsigned __fastcall GetHandle(void);
	void __fastcall SetPolyRegiones(void);
	
protected:
	virtual void __fastcall ApplyPolygones(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	
public:
	__property unsigned Handle = {read=GetHandle, nodefault};
	__fastcall virtual TCoolTransparentArea(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolTransparentArea(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Coolpolygons::TPolygones* Polygones = {read=FPolygones, write=SetPolygones};
};


class DELPHICLASS TSearchFileThread;
class PASCALIMPLEMENTATION TSearchFileThread : public Classes::TThread 
{
	typedef Classes::TThread inherited;
	
private:
	AnsiString FStringToSearch;
	AnsiString FFileName;
	bool FCaseSensitive;
	bool FStringFound;
	Classes::TNotifyEvent FOnStartProcess;
	Classes::TNotifyEvent FOnEndProcess;
	bool __fastcall IsStringFound(void);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__property bool StringFound = {read=FStringFound, nodefault};
	__property AnsiString FileName = {read=FFileName};
	__property AnsiString StringToSearch = {read=FStringToSearch};
	__property bool CaseSensitive = {read=FCaseSensitive, nodefault};
	__property Classes::TNotifyEvent OnStartProcess = {read=FOnStartProcess, write=FOnStartProcess};
	__property Classes::TNotifyEvent OnEndProcess = {read=FOnEndProcess, write=FOnEndProcess};
	__fastcall TSearchFileThread(AnsiString AFileName, AnsiString AStringToSearch, bool ACaseSensitive);
public:
	#pragma option push -w-inl
	/* TThread.Destroy */ inline __fastcall virtual ~TSearchFileThread(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSearchScope { ssCurrentFolderOnly, ssIncludeSubFolders };
#pragma option pop

typedef void __fastcall (__closure *TProcessEvent)(System::TObject* Sender, AnsiString CurName);

class DELPHICLASS TSearchFolderThread;
class PASCALIMPLEMENTATION TSearchFolderThread : public Classes::TThread 
{
	typedef Classes::TThread inherited;
	
private:
	AnsiString FStringToSearch;
	AnsiString FFolderName;
	AnsiString FFileMask;
	Classes::TStringList* FValidFiles;
	bool FCaseSensitive;
	TSearchScope FSearchScope;
	bool FFileNamesOnly;
	TProcessEvent FOnFileProcess;
	TProcessEvent FOnFolderProcess;
	TProcessEvent FOnFileFound;
	Classes::TNotifyEvent FOnStartProcess;
	Classes::TNotifyEvent FOnEndProcess;
	void __fastcall ProcessFolder(AnsiString DirName);
	bool __fastcall IsStringFound(AnsiString FileName);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__property bool CaseSensitive = {read=FCaseSensitive, nodefault};
	__property Classes::TStringList* ValidFiles = {read=FValidFiles};
	__property AnsiString FolderName = {read=FFolderName};
	__property AnsiString FileMask = {read=FFileMask};
	__property bool FileNamesOnly = {read=FFileNamesOnly, write=FFileNamesOnly, nodefault};
	__property TSearchScope SearchScope = {read=FSearchScope, write=FSearchScope, default=0};
	__property AnsiString StringToSearch = {read=FStringToSearch};
	__property TProcessEvent OnFileProcess = {read=FOnFileProcess, write=FOnFileProcess};
	__property TProcessEvent OnFolderProcess = {read=FOnFolderProcess, write=FOnFolderProcess};
	__property TProcessEvent OnFileFound = {read=FOnFileFound, write=FOnFileFound};
	__property Classes::TNotifyEvent OnStartProcess = {read=FOnStartProcess, write=FOnStartProcess};
	__property Classes::TNotifyEvent OnEndProcess = {read=FOnEndProcess, write=FOnEndProcess};
	__fastcall TSearchFolderThread(AnsiString AFolderName, AnsiString AFileMask, AnsiString AStringToSearch, bool ACaseSensitive, TSearchScope ASearchScope, bool AFileNamesOnly);
	__fastcall virtual ~TSearchFolderThread(void);
};


class DELPHICLASS TCoolFileFinder;
class PASCALIMPLEMENTATION TCoolFileFinder : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	AnsiString FStringToSearch;
	AnsiString FFolderName;
	AnsiString FFileMask;
	bool FCaseSensitive;
	TSearchScope FSearchScope;
	bool FFileNamesOnly;
	TProcessEvent FOnFileProcess;
	TProcessEvent FOnFolderProcess;
	TProcessEvent FOnFileFound;
	Classes::TNotifyEvent FOnStartProcess;
	Classes::TNotifyEvent FOnEndProcess;
	
public:
	__fastcall virtual TCoolFileFinder(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolFileFinder(void);
	virtual bool __fastcall Execute(bool WaitForEnd);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool CaseSensitive = {read=FCaseSensitive, write=FCaseSensitive, default=0};
	__property AnsiString FolderName = {read=FFolderName, write=FFolderName};
	__property AnsiString FileMask = {read=FFileMask, write=FFileMask};
	__property bool FileNamesOnly = {read=FFileNamesOnly, write=FFileNamesOnly, default=0};
	__property TSearchScope SearchScope = {read=FSearchScope, write=FSearchScope, default=0};
	__property AnsiString StringToSearch = {read=FStringToSearch, write=FStringToSearch};
	__property TProcessEvent OnFileProcess = {read=FOnFileProcess, write=FOnFileProcess};
	__property TProcessEvent OnFolderProcess = {read=FOnFolderProcess, write=FOnFolderProcess};
	__property TProcessEvent OnFileFound = {read=FOnFileFound, write=FOnFileFound};
	__property Classes::TNotifyEvent OnStartProcess = {read=FOnStartProcess, write=FOnStartProcess};
	__property Classes::TNotifyEvent OnEndProcess = {read=FOnEndProcess, write=FOnEndProcess};
};


//-- var, const, procedure ---------------------------------------------------
static const Word CM_THREADOVER = 0xb1f4;

}	/* namespace Cooltools */
using namespace Cooltools;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolTools
