// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeMakerEditor.pas' rev: 34.00 (Windows)

#ifndef TeemakereditorHPP
#define TeemakereditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <VCLTee.OpenGL2.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.CheckLst.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Grids.hpp>
#include <System.Math.hpp>
#include <System.TypInfo.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeJPEG.hpp>
#include <VCLTee.TeeGIF.hpp>
#include <VCLTee.TeePNG.hpp>
#include <VCLTee.TeeComma.hpp>
#include <VCLTee.TeeOpenGL.hpp>
#include <VCLTee.TeeGLEditor.hpp>
#include <VCLTee.TeeGLCanvas.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeEdiFont.hpp>
#include <VCLTee.TeeBrushDlg.hpp>
#include <VCLTee.TeeEdiPane.hpp>
#include <VCLTee.TeeBackImage.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeAnimateEditor.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <TeeAnimationGallery.hpp>
#include <VCLTee.TeeExport.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeeStore.hpp>
#include <VCLTee.TeeURL.hpp>
#include <TeeBlockEditor.hpp>
#include <VCLTee.TeeStringsEditor.hpp>
#include <TeeMakerControl.hpp>
#include <TeeRevolution.hpp>
#include <TeeRevolutionEditor.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <TeeMakerLibrary.hpp>
#include <TeeColorPalette.hpp>
#include <VCLTee.TeeDraw3D.hpp>
#include <TeeExtruded.hpp>
#include <TeeKinematics.hpp>
#include <TeeCamera.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teemakereditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMakerTab;
class DELPHICLASS TMakerDropBackup;
class DELPHICLASS TMakerEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMakerTab : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Teemakercontrol::TMaker* Maker;
	Vcl::Comctrls::TTabSheet* Tab;
	bool Dirty;
	System::UnicodeString FileName;
	System::UnicodeString URLName;
	bool URLLoaded;
	Vcl::Controls::TAlign OldAlign;
	bool OldBoundingBox;
	System::Types::TRect OldBounds;
	Vcl::Controls::TWinControl* OldParent;
	Vcl::Menus::TPopupMenu* OldPopup;
	System::Classes::TNotifyEvent Old_OnAfterDraw;
	System::Classes::TNotifyEvent Old_OnBeforeDraw;
	System::Classes::TNotifyEvent Old_OnDragging;
	System::Classes::TNotifyEvent Old_OnClick;
	Vcl::Controls::TMouseEvent Old_OnClicked;
	System::Classes::TNotifyEvent Old_OnDblClick;
	Vcl::Controls::TDragOverEvent Old_OnDragOver;
	Vcl::Controls::TDragDropEvent Old_OnDragDrop;
	Vcl::Controls::TEndDragEvent Old_OnEndDrag;
	Vcl::Controls::TMouseEvent Old_OnMouseDown;
	Vcl::Controls::TMouseMoveEvent Old_OnMouseMove;
	Teemakercontrol::TLoadMakerEvent Old_OnDoLoad;
public:
	/* TObject.Create */ inline __fastcall TMakerTab() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TMakerTab() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TMakerDropBackup : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool Active;
	System::UnicodeString PictureLink;
	Teeblocks::TCustomBlock* Block;
	System::Uitypes::TColor Color;
	bool IsBlock;
	bool IsTexture;
	bool IsMaker;
	Teeblocks::TBlockTexture* Texture;
	Vcl::Graphics::TPicture* Picture;
	
public:
	__fastcall virtual ~TMakerDropBackup();
	void __fastcall Restore(Teemakercontrol::TMaker* Maker);
public:
	/* TObject.Create */ inline __fastcall TMakerDropBackup() : System::TObject() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TMakerEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
	
private:
	typedef System::DynamicArray<TMakerTab*> _TMakerEditor__1;
	
	
__published:
	Vcltee::Teecomma::TTeeCommander* TeeCommander1;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Comctrls::TPageControl* PageEditor;
	Vcl::Comctrls::TTabSheet* TabBlocks;
	Vcl::Extctrls::TPanel* PanelTree;
	Vcl::Extctrls::TPanel* PanelEditor;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TButton* BAdd;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Extctrls::TSplitter* SplitterEditor;
	Vcl::Menus::TMainMenu* MainMenu1;
	Vcl::Menus::TMenuItem* File1;
	Vcl::Menus::TMenuItem* Edit7;
	Vcl::Menus::TMenuItem* View1;
	Vcl::Menus::TMenuItem* New1;
	Vcl::Menus::TMenuItem* Open1;
	Vcl::Menus::TMenuItem* Save1;
	Vcl::Menus::TMenuItem* Saveas1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Exit1;
	Vcl::Menus::TMenuItem* Resetview1;
	Vcl::Menus::TMenuItem* Borders1;
	Vcl::Menus::TMenuItem* Textures1;
	Vcl::Menus::TMenuItem* Smooth1;
	Vcl::Menus::TMenuItem* N4;
	Vcl::Menus::TMenuItem* View3DAxes;
	Vcl::Comctrls::TStatusBar* StatusBar1;
	Vcl::Menus::TMenuItem* N6;
	Vcl::Menus::TMenuItem* Duplicate1;
	Vcl::Menus::TMenuItem* Insert1;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* Duplicate2;
	Vcl::Menus::TMenuItem* Savetoexternal1;
	Vcl::Menus::TMenuItem* Delete2;
	Vcl::Menus::TMenuItem* Boundingbox1;
	Vcl::Menus::TMenuItem* Locallight1;
	Vcl::Menus::TMenuItem* AntiAlias1;
	Vcl::Menus::TMenuItem* Gradient1;
	Vcl::Menus::TMenuItem* Backimage1;
	Vcl::Menus::TMenuItem* EditLink;
	Vcl::Menus::TMenuItem* Tools1;
	Vcl::Menus::TMenuItem* Animations1;
	Vcl::Extctrls::TPanel* PanelBig;
	Vcl::Extctrls::TSplitter* SplitterAnim;
	Vcl::Comctrls::TTreeView* TreeBlocks;
	Vcl::Extctrls::TImage* ImageOpen;
	Vcl::Menus::TMenuItem* Options1;
	Vcl::Menus::TMenuItem* EditMode1;
	Vcl::Menus::TMenuItem* Editor1;
	Vcl::Menus::TMenuItem* N9;
	Vcl::Menus::TMenuItem* Reopen1;
	Vcl::Menus::TMenuItem* Open2;
	Vcl::Comctrls::TTabSheet* TabLibrary;
	Vcl::Menus::TMenuItem* N10;
	Vcl::Menus::TMenuItem* Source1;
	Vcl::Menus::TMenuItem* N11;
	Vcl::Menus::TMenuItem* Print1;
	Vcl::Menus::TMenuItem* Export1;
	Vcl::Extctrls::TSplitter* SplitterTree;
	Vcl::Menus::TMenuItem* TextureQuality1;
	Vcl::Controls::TImageList* Images;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* BlockCustomEdit;
	Vcl::Menus::TMenuItem* Wireframe1;
	Vcl::Comctrls::TTabSheet* TabExtras;
	Vcl::Stdctrls::TButton* ButtonNewFolder;
	Vcl::Menus::TMenuItem* Makelocalcopy1;
	Vcl::Stdctrls::TCheckBox* CBAutoPlay;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Buttons::TSpeedButton* SBMute;
	Vcl::Stdctrls::TButton* BChange;
	Vcl::Comctrls::TPageControl* PageExtras;
	Vcl::Comctrls::TTabSheet* TabFloor;
	Vcl::Comctrls::TTabSheet* TabOther;
	Vcl::Comctrls::TTabSheet* TabCamera;
	Vcl::Menus::TMenuItem* exturesfolder1;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabLinks;
	Vcl::Comctrls::TTreeView* TreeLinks;
	Vcl::Comctrls::TTabSheet* TabEffects;
	Vcl::Comctrls::TPageControl* PageEffects;
	Vcl::Comctrls::TTabSheet* TabSheet8;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TButtonColor* BFogColor;
	Vcl::Stdctrls::TScrollBar* SBFogDensity;
	Vcl::Stdctrls::TCheckBox* CBFogEnabled;
	Vcl::Stdctrls::TScrollBar* SBFogStart;
	Vcl::Stdctrls::TScrollBar* SBFogEnd;
	Vcltee::Tecanvas::TComboFlat* CBFogStyle;
	Vcl::Stdctrls::TCheckBox* CBFogNicest;
	Vcl::Comctrls::TTabSheet* TabSheet6;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TCheckBox* CBShadows;
	Vcl::Stdctrls::TScrollBar* ShadowColor;
	Vcl::Stdctrls::TScrollBar* ShadowTransp;
	Vcl::Menus::TMenuItem* Shadows1;
	Vcl::Comctrls::TTabSheet* TabColors;
	Vcl::Menus::TMenuItem* Events1;
	Vcl::Menus::TMenuItem* Link1;
	Vcl::Menus::TMenuItem* Gotolink1;
	Vcl::Menus::TMenuItem* Doublebuffer1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TListBox* TreePictures;
	Vcl::Menus::TMenuItem* ReopenDummy;
	Vcl::Menus::TMenuItem* Object1;
	Vcl::Menus::TMenuItem* Properties1;
	Vcl::Menus::TMenuItem* N5;
	Vcl::Buttons::TSpeedButton* SBLight;
	Vcltee::Tecanvas::TComboFlat* ComboNavigate;
	Vcl::Buttons::TSpeedButton* SBRotateBlock;
	Vcl::Buttons::TSpeedButton* SBMoveBlock;
	Vcl::Buttons::TSpeedButton* SBSizeBlock;
	Vcl::Menus::TMenuItem* Rename1;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Stdctrls::TButton* BChangePic;
	Vcl::Stdctrls::TButton* BViewPic;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Stdctrls::TButton* BViewObject;
	Vcl::Comctrls::TTabSheet* TabLighting;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Extctrls::TPanel* Panel7;
	Vcl::Stdctrls::TLabel* LCachedFonts;
	Vcl::Stdctrls::TListBox* ListFonts;
	Vcl::Comctrls::TTabSheet* TabBack;
	Vcl::Menus::TMenuItem* N7;
	Vcl::Menus::TMenuItem* Close1;
	Vcl::Menus::TMenuItem* CloseAll1;
	Vcl::Menus::TPopupMenu* PopupTabs;
	Vcl::Menus::TMenuItem* Closetab1;
	Vcl::Menus::TMenuItem* Newtab1;
	Vcl::Menus::TMenuItem* ReplaceItem;
	Vcl::Menus::TMenuItem* VerticalSync1;
	Vcl::Comctrls::TTabSheet* TabAdvanced;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TScrollBar* ScrollBar1;
	Vcl::Stdctrls::TScrollBar* ScrollBar2;
	Vcl::Stdctrls::TCheckBox* CBThreading;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TCheckBox* CBClickToFocus;
	Vcl::Stdctrls::TLabel* LShadowTransp;
	Vcl::Stdctrls::TLabel* Label25;
	Vcl::Extctrls::TShape* ShapeShadowColor;
	Vcl::Menus::TMenuItem* FullScreen1;
	Vcl::Stdctrls::TButton* BDelete;
	Vcl::Stdctrls::TCheckBox* CBShadowSmooth;
	Vcl::Extctrls::TPanel* Panel8;
	Vcl::Stdctrls::TListBox* LBCameras;
	Vcl::Extctrls::TPanel* PanelCamera;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* Panel10;
	Vcl::Buttons::TSpeedButton* SBAddCamera;
	Vcl::Buttons::TSpeedButton* SBRemoveCamera;
	Vcl::Stdctrls::TButton* BRenameCamera;
	Vcl::Menus::TMenuItem* Blocks1;
	Vcl::Menus::TMenuItem* SourceMaker1;
	Vcl::Menus::TMenuItem* Rename2;
	Vcl::Menus::TMenuItem* Replace1;
	Vcl::Stdctrls::TCheckBox* CBFPS;
	Vcl::Extctrls::TPanel* Panel9;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label22;
	Vcl::Stdctrls::TLabel* Label21;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TLabel* LReflection;
	Vcl::Stdctrls::TLabel* LReflectDist;
	Vcl::Stdctrls::TScrollBar* SBReflection;
	Vcl::Stdctrls::TScrollBar* SBReflectDistance;
	Vcltee::Tecanvas::TComboFlat* LimitFloor;
	Vcl::Stdctrls::TEdit* EDefFloorTexture;
	Vcl::Stdctrls::TCheckBox* CBTransp3D;
	Vcl::Extctrls::TPanel* Panel11;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Buttons::TSpeedButton* SBEditMode;
	Vcl::Menus::TMenuItem* Kinematics1;
	Vcl::Comctrls::TTabSheet* TabSheet5;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TLabel* LSpeed;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label26;
	Vcl::Extctrls::TRadioGroup* RGNavigate;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TLabel* Label16;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TLabel* Joy1X;
	Vcl::Stdctrls::TLabel* Joy1Y;
	Vcl::Stdctrls::TLabel* Joy1Z;
	Vcl::Stdctrls::TCheckBox* CBUseJoystick1;
	Vcl::Stdctrls::TScrollBar* CameraInertia;
	Vcltee::Tecanvas::TComboFlat* CBMouseWheel;
	Vcl::Stdctrls::TEdit* EWalkSpeed;
	Vcl::Comctrls::TUpDown* UDWalkSpeed;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcltee::Tecanvas::TComboFlat* CBAnaglyph;
	Vcl::Stdctrls::TLabel* Label20;
	Vcl::Stdctrls::TScrollBar* SBAnaglyphDistance;
	Vcl::Extctrls::TPanel* Panel12;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Comctrls::TTrackBar* TBAmbientLight;
	Vcl::Stdctrls::TLabel* LAmbientLight;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* ESmoothSize;
	Vcl::Comctrls::TUpDown* UDSmoothSize;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall BAddClick(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall BDupliClick(System::TObject* Sender);
	void __fastcall Orderbyname1Click(System::TObject* Sender);
	void __fastcall NoOrder1Click(System::TObject* Sender);
	void __fastcall CBFilterChange(System::TObject* Sender);
	void __fastcall Saveas1Click(System::TObject* Sender);
	void __fastcall New1Click(System::TObject* Sender);
	void __fastcall Open1Click(System::TObject* Sender);
	void __fastcall Exit1Click(System::TObject* Sender);
	void __fastcall Save1Click(System::TObject* Sender);
	void __fastcall Resetview1Click(System::TObject* Sender);
	void __fastcall Borders1Click(System::TObject* Sender);
	void __fastcall Textures1Click(System::TObject* Sender);
	void __fastcall Smooth1Click(System::TObject* Sender);
	void __fastcall View3DAxesClick(System::TObject* Sender);
	void __fastcall Duplicate1Click(System::TObject* Sender);
	void __fastcall Insert1Click(System::TObject* Sender);
	void __fastcall Delete1Click(System::TObject* Sender);
	void __fastcall Duplicate2Click(System::TObject* Sender);
	void __fastcall Savetoexternal1Click(System::TObject* Sender);
	void __fastcall Copy1Click(System::TObject* Sender);
	void __fastcall Paste1Click(System::TObject* Sender);
	void __fastcall Delete2Click(System::TObject* Sender);
	void __fastcall Edit7Click(System::TObject* Sender);
	void __fastcall Boundingbox1Click(System::TObject* Sender);
	void __fastcall Locallight1Click(System::TObject* Sender);
	void __fastcall AntiAlias1Click(System::TObject* Sender);
	void __fastcall Gradient1Click(System::TObject* Sender);
	void __fastcall Backimage1Click(System::TObject* Sender);
	void __fastcall EditLinkClick(System::TObject* Sender);
	void __fastcall BEditLinkClick(System::TObject* Sender);
	void __fastcall Animations1Click(System::TObject* Sender);
	void __fastcall TreeBlocksEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall TreeBlocksChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall EditMode1Click(System::TObject* Sender);
	void __fastcall Editor1Click(System::TObject* Sender);
	void __fastcall Open2Click(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall TreeLinksChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall SBRotateBlockClick(System::TObject* Sender);
	void __fastcall SBMoveBlockClick(System::TObject* Sender);
	void __fastcall Source1Click(System::TObject* Sender);
	void __fastcall Print1Click(System::TObject* Sender);
	void __fastcall Export1Click(System::TObject* Sender);
	void __fastcall SBSizeBlockClick(System::TObject* Sender);
	void __fastcall TeeCommander1SetLabel(Vcltee::Teecomma::TTeeCommander* Sender, System::UnicodeString &Text);
	void __fastcall TextureQuality1Click(System::TObject* Sender);
	void __fastcall TreeBlocksGetImageIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeBlocksGetSelectedIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeBlocksDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall TreeBlocksDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall BlockCustomEditClick(System::TObject* Sender);
	void __fastcall Wireframe1Click(System::TObject* Sender);
	void __fastcall ScrollBar1Change(System::TObject* Sender);
	void __fastcall ScrollBar2Change(System::TObject* Sender);
	void __fastcall SBReflectionChange(System::TObject* Sender);
	void __fastcall SBFogDensityChange(System::TObject* Sender);
	void __fastcall CBFogEnabledClick(System::TObject* Sender);
	void __fastcall BFogColorClick(System::TObject* Sender);
	void __fastcall SBFogStartChange(System::TObject* Sender);
	void __fastcall SBFogEndChange(System::TObject* Sender);
	void __fastcall CBFogStyleChange(System::TObject* Sender);
	void __fastcall ButtonNewFolderClick(System::TObject* Sender);
	void __fastcall TreeBlocksDblClick(System::TObject* Sender);
	void __fastcall Makelocalcopy1Click(System::TObject* Sender);
	void __fastcall CBAutoPlayClick(System::TObject* Sender);
	void __fastcall SBMuteClick(System::TObject* Sender);
	void __fastcall TreeBlocksKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall TreeBlocksAdvancedCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages, bool &DefaultDraw);
	void __fastcall BChangeClick(System::TObject* Sender);
	void __fastcall SBReflectDistanceChange(System::TObject* Sender);
	void __fastcall CBShadowsClick(System::TObject* Sender);
	void __fastcall ShadowColorChange(System::TObject* Sender);
	void __fastcall ShadowTranspChange(System::TObject* Sender);
	void __fastcall CBFogNicestClick(System::TObject* Sender);
	void __fastcall SBLightClick(System::TObject* Sender);
	void __fastcall RGNavigateClick(System::TObject* Sender);
	void __fastcall PageExtrasChange(System::TObject* Sender);
	void __fastcall exturesfolder1Click(System::TObject* Sender);
	void __fastcall CBThreadingClick(System::TObject* Sender);
	void __fastcall CBUseJoystick1Click(System::TObject* Sender);
	void __fastcall PageEditorChange(System::TObject* Sender);
	void __fastcall CBAnaglyphChange(System::TObject* Sender);
	void __fastcall Shadows1Click(System::TObject* Sender);
	void __fastcall SBAnaglyphDistanceChange(System::TObject* Sender);
	void __fastcall TreeBlocksMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall PopupMenu1Popup(System::TObject* Sender);
	void __fastcall Events1Click(System::TObject* Sender);
	void __fastcall Reopen1Click(System::TObject* Sender);
	void __fastcall ComboURLDropDown(System::TObject* Sender);
	void __fastcall Link1Click(System::TObject* Sender);
	void __fastcall Gotolink1Click(System::TObject* Sender);
	void __fastcall Doublebuffer1Click(System::TObject* Sender);
	void __fastcall LimitFloorChange(System::TObject* Sender);
	void __fastcall File1Click(System::TObject* Sender);
	void __fastcall Properties1Click(System::TObject* Sender);
	void __fastcall ComboNavigateChange(System::TObject* Sender);
	void __fastcall Rename1Click(System::TObject* Sender);
	void __fastcall TreePicturesDblClick(System::TObject* Sender);
	void __fastcall BChangePicClick(System::TObject* Sender);
	void __fastcall TreePicturesClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall BViewPicClick(System::TObject* Sender);
	void __fastcall BViewObjectClick(System::TObject* Sender);
	void __fastcall CameraInertiaChange(System::TObject* Sender);
	void __fastcall CBClickToFocusClick(System::TObject* Sender);
	void __fastcall Close1Click(System::TObject* Sender);
	void __fastcall CloseAll1Click(System::TObject* Sender);
	void __fastcall Closetab1Click(System::TObject* Sender);
	void __fastcall PopupTabsPopup(System::TObject* Sender);
	void __fastcall Newtab1Click(System::TObject* Sender);
	void __fastcall CBMouseWheelChange(System::TObject* Sender);
	void __fastcall ReplaceItemClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall X1Click(System::TObject* Sender);
	void __fastcall VerticalSync1Click(System::TObject* Sender);
	void __fastcall FullScreen1Click(System::TObject* Sender);
	void __fastcall CBShadowSmoothClick(System::TObject* Sender);
	void __fastcall LBCamerasClick(System::TObject* Sender);
	void __fastcall SBAddCameraClick(System::TObject* Sender);
	void __fastcall SBRemoveCameraClick(System::TObject* Sender);
	void __fastcall SourceMaker1Click(System::TObject* Sender);
	void __fastcall Rename2Click(System::TObject* Sender);
	void __fastcall BRenameCameraClick(System::TObject* Sender);
	void __fastcall Replace1Click(System::TObject* Sender);
	void __fastcall CBFPSClick(System::TObject* Sender);
	void __fastcall CBTransp3DClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall SBEditModeClick(System::TObject* Sender);
	void __fastcall EWalkSpeedChange(System::TObject* Sender);
	void __fastcall Kinematics1Click(System::TObject* Sender);
	void __fastcall TBAmbientLightChange(System::TObject* Sender);
	void __fastcall ESmoothSizeChange(System::TObject* Sender);
	
private:
	Vcl::Buttons::TSpeedButton* ButtonOpen;
	System::Classes::TStrings* IHistory;
	Teecolorpalette::TColorPalette* IColorPalette;
	Teeblockeditor::TBlockEditor* IFloorEditor;
	Vcl::Controls::TDragOverEvent IOnDragOver;
	Vcl::Controls::TDragDropEvent IOnDragDrop;
	TMakerDropBackup* IDropBackup;
	Teeblocks::TObjectBlock* IExtraBlocks;
	Teeblocks::TObjectBlockHandle* IMoveBlocks;
	Teeblocks::TObjectBlockHandle* ISizeBlocks;
	Teeblocks::TObjectBlockHandle* IRotateBlocks;
	Teeblocks::TObjectBlockHandle* IDesignHandles;
	Teeblocks::TObjectBlockHandle* ILightLamps;
	void __fastcall ActivateAnimEditor(Teemakercontrol::TMaker* const AMaker);
	void __fastcall AddAnimates(Teeblocks::TAnimates* const Animates);
	void __fastcall AddBlock(Vcl::Comctrls::TTreeNode* ParentNode, Teeblocks::TCustomBlock* const ABlock);
	void __fastcall AddExtraBlocks(const System::UnicodeString HelpText);
	void __fastcall AddMaker(Teemakercontrol::TMaker* const AMaker);
	void __fastcall AddNewMaker();
	void __fastcall AnimateGallery(System::TObject* Sender, /* out */ Vcltee::Teeanimate::TTeeAnimation* &Animation, Vcltee::Teeanimate::TTeeAnimation* const AParent);
	void __fastcall AnimateGetName(Vcltee::Teeanimate::TTeeAnimation* const Animation, /* out */ System::UnicodeString &S);
	void __fastcall AnimateHide(System::TObject* Sender);
	void __fastcall AnimateModified(System::TObject* Sender);
	void __fastcall AnimateSelected(System::TObject* Sender, /* out */ Vcltee::Teeanimate::TTeeAnimation* &Animation);
	void __fastcall AnimationAddGroup(System::TObject* Sender);
	void __fastcall AnimationChangeGroup(System::TObject* Sender);
	void __fastcall AnimationRemoveGroup(System::TObject* Sender);
	void __fastcall AnimationRenameGroup(System::TObject* Sender);
	void __fastcall BlockCollision(Teekinematics::TMovement* Sender, Teeblocks::TCustomBlock* const ABlock, Teeblocks::TCustomBlock* &ACollided, System::Math::Vectors::TPoint3D &APoint);
	Teeblocks::TCustomBlock* __fastcall BlockUnderMouse();
	void __fastcall BlocksLoaded(System::TObject* Sender);
	void __fastcall BlocksItemsChanged(System::TObject* Sender);
	void __fastcall CameraChanged(System::TObject* Sender);
	void __fastcall CheckColors();
	void __fastcall CheckLights();
	void __fastcall ClearBlocks(bool ClearCurrent = false);
	void __fastcall ColorPaletteChanged(System::TObject* Sender);
	void __fastcall CopySelectedBlocks(Teeblocks::TBlocks* const Collection);
	Teemakercontrol::TMaker* __fastcall CreateTempMaker();
	Teeblocks::TAnimateItem* __fastcall CurrentAnimate();
	void __fastcall DeleteNodeAndBlock(Vcl::Comctrls::TTreeNode* const Node);
	void __fastcall DeleteSelectedBlocks();
	void __fastcall DisableBlockButtons();
	void __fastcall DoDragDrop(System::TObject* Source, int X, int Y, bool SetDirty = true);
	void __fastcall DoLoad(System::Classes::TStrings* const Strings)/* overload */;
	bool __fastcall DoSaveDialog(TMakerTab* const AMakerTab);
	bool __fastcall DragFromPalette(System::TObject* Source);
	bool __fastcall DragObject(System::TObject* Source);
	void __fastcall EditorDirty(System::TObject* Sender);
	void __fastcall EditPanel(System::TObject* Sender);
	void __fastcall EditorSetAnimate(Teemakercontrol::TMaker* const AMaker);
	System::UnicodeString __fastcall FileNameOrURLName();
	void __fastcall FillBlockList();
	void __fastcall FinishLoad(System::UnicodeString AName);
	void __fastcall FinishSetup();
	bool __fastcall HasCurrentMaker();
	void __fastcall ListAnimDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall ListAnimDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	Teeblocks::TCustomObjectBlock* __fastcall LoadNewObjectFile(const System::UnicodeString APath, const System::UnicodeString AFile, const System::UnicodeString AExt);
	void __fastcall Maker1AfterDraw(System::TObject* Sender);
	void __fastcall Maker1BeforeDraw(System::TObject* Sender);
	void __fastcall Maker1Click(System::TObject* Sender);
	void __fastcall Maker1Clicked(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Maker1DblClick(System::TObject* Sender);
	void __fastcall Maker1DoLoad(Teemakercontrol::TMaker* Sender, const System::UnicodeString FileName);
	void __fastcall Maker1DragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall Maker1DragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall Maker1EndDrag(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall Maker1MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	bool __fastcall InDesignTime();
	bool __fastcall IsMakerFile(const System::UnicodeString FileName);
	void __fastcall LibraryAddObject(System::TObject* Sender);
	void __fastcall LibraryClickObject(System::TObject* Sender);
	void __fastcall LibraryOpenObject(System::TObject* Sender);
	void __fastcall LoadNewMaker(const System::UnicodeString AFileName);
	Vcl::Comctrls::TTreeNode* __fastcall NodeOfBlock(Teeblocks::TCustomBlock* const ABlock);
	System::Classes::TComponent* __fastcall NewBlockOwner();
	void __fastcall RefreshAnimEditor();
	void __fastcall RefreshLocation(Teeblocks::TCustomBlock* const Sender);
	void __fastcall RefreshRotation(Teeblocks::TCustomBlock* const Sender);
	void __fastcall RefreshSize(Teeblocks::TCustomBlock* const Sender);
	void __fastcall RemoveExtraBlocks();
	void __fastcall RemoveMaker(int Index);
	void __fastcall ReplaceBlock(Teeblocks::TCustomBlock* const OldBlock, Teeblocks::TCustomBlock* const NewBlock);
	bool __fastcall SaveBlocksToFile(Teemakercontrol::TMaker* const AMaker, const System::UnicodeString FileName);
	Teeblocks::TCustomBlock* __fastcall SelectedLibraryBlock();
	void __fastcall SetBoundTitle();
	void __fastcall SetCamera(Teecamera::TMakerCamera* const ACamera);
	void __fastcall SetExtraPositions();
	void __fastcall SetMainCaption(System::UnicodeString Text);
	void __fastcall SetNewBlockLocation(Teeblocks::TCustomBlock* const ABlock, int X, int Y);
	void __fastcall ShowHideAnimEditor(bool DoShow);
	void __fastcall ShowHideEditor(bool DoShow);
	void __fastcall ShowHideSaveButton(bool DoShow);
	void __fastcall UnmarkDirty(TMakerTab* const AMakerTab = (TMakerTab*)(0x0));
	void __fastcall UpdateCameraData(Teemakercontrol::TMaker* const AMaker);
	void __fastcall UpdateNavigate(Teemakercontrol::TMaker* const AMaker);
	void __fastcall ViewSource(System::Classes::TStream* const AStream);
	MESSAGE void __fastcall WMDROPFILES(Winapi::Messages::TWMDropFiles &Message);
	
protected:
	_TMakerEditor__1 Makers;
	Teeblocks::TBlocks* MakerClipboard;
	Vcl::Comctrls::TPageControl* PageMakers;
	bool CanAddFirstEmptyMaker;
	Teekinematics::TKinematics* Kinematics;
	Teeanimateeditor::TTeeAnimateEditor* IAnimEditor;
	int IAnimEditorHeight;
	Teeblocks::TCustomBlock* IAnimGalleryBlock;
	Vcltee::Teeedipane::TFormTeePanel* IBackEditor;
	Teeblockeditor::TBlockEditor* IBlockEditor;
	Teecamera::TCameraEditor* ICameraEditor;
	Vcltee::Teegleditor::TFormTeeGLEditor* IGLEditor;
	Teekinematics::TKinematicsEditor* IKinematics;
	Teemakerlibrary::TMakerLibrary* ILibrary;
	System::UnicodeString IHome;
	bool IModifying;
	bool WasAnimations;
	bool WasEditor;
	bool WasKinematics;
	virtual void __fastcall ActivateMaker(Teemakercontrol::TMaker* const AMaker);
	Teeblocks::TCustomBlock* __fastcall AddNewBlockGallery();
	virtual void __fastcall AddReopen(System::UnicodeString AName);
	virtual void __fastcall CheckReopen();
	Teeblocks::TCustomBlock* __fastcall Current();
	Teemakercontrol::TMaker* __fastcall CurrentMaker();
	TMakerTab* __fastcall CurrentMakerTab();
	void __fastcall DoAddClick(Teeblocks::TCustomBlock* const ABlock, const System::UnicodeString ATitle, Vcl::Comctrls::TTreeNode* ParentNode = (Vcl::Comctrls::TTreeNode*)(0x0), bool FindParentNode = true, bool SelectAdded = true);
	void __fastcall DoLoad(const System::UnicodeString AFile, bool AddToHistory = true)/* overload */;
	bool __fastcall DoSave(bool AskToSave = false, TMakerTab* AMakerTab = (TMakerTab*)(0x0));
	void __fastcall FinishAdd(Teeblocks::TCustomBlock* const NewBlock);
	void __fastcall InitFirstMaker();
	virtual void __fastcall Maker1MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MarkDirty();
	void __fastcall PageMakersChange(System::TObject* Sender);
	void __fastcall SetAntiAlias(bool Value);
	void __fastcall SetEditMode(bool Value);
	
public:
	__fastcall virtual TMakerEditor(System::Classes::TComponent* const AOwner, Teemakercontrol::TMaker* const AMaker);
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* const AOwner, Teemakercontrol::TMaker* const AMaker)/* overload */;
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* const AOwner, const System::UnicodeString FileName)/* overload */;
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* const AOwner, Teeblocks::TCustomObjectBlock* const ABlock)/* overload */;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMakerEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMakerEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMakerEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMakerEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemakereditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEMAKEREDITOR)
using namespace Teemakereditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeemakereditorHPP
