// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeEd.pas' rev: 34.00 (Windows)

#ifndef TreeedHPP
#define TreeedHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.ImgList.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeRecentFiles.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeInspector.hpp>
#include <TreeNavigator.hpp>
#include <VCLTee.TeeNavigator.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeed
{
//-- forward type declarations -----------------------------------------------
struct TTreeTagShape;
class DELPHICLASS TTreeUndoItem;
class DELPHICLASS TTreeUndo;
class DELPHICLASS TTreeEditor;
class DELPHICLASS TTreeEdit;
class DELPHICLASS TTreeEditorPanel;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TTreeTagShape
{
public:
	bool UseStyle;
	Teetree::TTreeShapeStyle Style;
	Teetree::TTreeNodeShapeClass AClass;
	Teetree::TTreeNodeShape* AInstance;
};
#pragma pack(pop)


typedef TTreeTagShape *PTreeTagShape;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeUndoItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Classes::TPersistent* FStore;
	void __fastcall StoreCopy();
	
public:
	System::Classes::TPersistent* Source;
	System::UnicodeString Text;
	__fastcall virtual ~TTreeUndoItem();
	void __fastcall Undo();
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TTreeUndoItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTreeUndo : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	HIDESBASE void __fastcall Add(System::Classes::TPersistent* ASource, const System::UnicodeString AText);
	TTreeUndoItem* __fastcall Last();
	void __fastcall Undo();
public:
	/* TCollection.Create */ inline __fastcall TTreeUndo(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TTreeUndo() { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TTreeClass;

class PASCALIMPLEMENTATION TTreeEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Menus::TPopupMenu* PopupNode;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Cut1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* BringtoFront1;
	Vcl::Menus::TMenuItem* SendtoBack1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* AddChild1;
	Vcl::Menus::TMenuItem* AddBrother1;
	Vcl::Menus::TMenuItem* N5;
	Vcl::Menus::TMenuItem* AddnewRoot2;
	Vcl::Menus::TMenuItem* Prune1;
	Vcl::Comctrls::TPageControl* PageTree;
	Vcl::Comctrls::TTabSheet* TabGeneral;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcltee::Teependlg::TButtonPen* BCrossBorder;
	Vcltee::Teependlg::TButtonPen* SignPenButton;
	Vcl::Stdctrls::TButton* Button6;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDCrossSize;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Stdctrls::TButton* BBackImage;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBImageStyle;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Menus::TMenuItem* Aligntogrid1;
	Vcl::Comctrls::TTabSheet* TabSheet5;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Buttons::TSpeedButton* SpeedButton2;
	Vcl::Comctrls::TStatusBar* StatusBar1;
	Vcl::Buttons::TSpeedButton* SpeedButton3;
	Vcl::Buttons::TSpeedButton* SpeedButton4;
	Vcl::Comctrls::TTabSheet* TabSheet6;
	Vcl::Stdctrls::TCheckBox* CBAllowZoom;
	Vcl::Stdctrls::TLabel* Label7;
	Vcltee::Tecanvas::TComboFlat* CBAllowScroll;
	Vcl::Stdctrls::TCheckBox* CBZoomAnimated;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TEdit* Edit3;
	Vcl::Comctrls::TUpDown* UpDown2;
	Vcl::Comctrls::TTabSheet* TabSheet7;
	Vcltee::Teependlg::TButtonPen* Button7;
	Vcl::Stdctrls::TCheckBox* CBSelectedColorDef;
	Vcl::Stdctrls::TCheckBox* CBSelectedTextDef;
	Vcl::Comctrls::TTabSheet* TabSheet8;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* CBHorizVisible;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TCheckBox* CBVertVisible;
	Vcl::Menus::TMainMenu* MainMenu1;
	Vcl::Menus::TMenuItem* File1;
	Vcl::Menus::TMenuItem* Edit4;
	Vcl::Menus::TMenuItem* View1;
	Vcl::Menus::TMenuItem* Insert1;
	Vcl::Menus::TMenuItem* Format1;
	Vcl::Menus::TMenuItem* Tools1;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TMenuItem* AboutTeeTree101;
	Vcl::Menus::TMenuItem* N4;
	Vcl::Menus::TMenuItem* TeeTree10HomePage1;
	Vcl::Menus::TMenuItem* wwwSteemacom1;
	Vcl::Menus::TMenuItem* New1;
	Vcl::Menus::TMenuItem* Open1;
	Vcl::Menus::TMenuItem* Saveas1;
	Vcl::Menus::TMenuItem* Close1;
	Vcl::Menus::TMenuItem* N6;
	Vcl::Menus::TMenuItem* Printpreview1;
	Vcl::Menus::TMenuItem* Print1;
	Vcl::Menus::TMenuItem* N7;
	Vcl::Menus::TMenuItem* Cut2;
	Vcl::Menus::TMenuItem* Copy2;
	Vcl::Menus::TMenuItem* Paste2;
	Vcl::Menus::TMenuItem* Delete2;
	Vcl::Menus::TMenuItem* Selectall1;
	Vcl::Menus::TMenuItem* N8;
	Vcl::Menus::TMenuItem* Search2;
	Vcl::Menus::TMenuItem* Zoom1;
	Vcl::Menus::TMenuItem* N1001;
	Vcl::Menus::TMenuItem* N751;
	Vcl::Menus::TMenuItem* N501;
	Vcl::Menus::TMenuItem* N251;
	Vcl::Menus::TMenuItem* N151;
	Vcl::Menus::TMenuItem* N101;
	Vcl::Menus::TMenuItem* N11;
	Vcl::Menus::TMenuItem* Connections1;
	Vcl::Menus::TMenuItem* Images1;
	Vcl::Menus::TMenuItem* Text1;
	Vcl::Menus::TMenuItem* Shapes1;
	Vcl::Menus::TMenuItem* Crossboxes1;
	Vcl::Menus::TMenuItem* Grid1;
	Vcl::Menus::TMenuItem* Child1;
	Vcl::Menus::TMenuItem* Brother1;
	Vcl::Menus::TMenuItem* Prunenode1;
	Vcl::Menus::TMenuItem* Linknodes1;
	Vcl::Menus::TMenuItem* Style1;
	Vcl::Menus::TMenuItem* Border1;
	Vcl::Menus::TMenuItem* Font1;
	Vcl::Menus::TMenuItem* Gradient1;
	Vcl::Menus::TMenuItem* Shadow1;
	Vcl::Menus::TMenuItem* Transparent1;
	Vcl::Menus::TMenuItem* RoundRectangle1;
	Vcl::Menus::TMenuItem* Rectangle2;
	Vcl::Menus::TMenuItem* Ellipse2;
	Vcl::Menus::TMenuItem* Triangle2;
	Vcl::Menus::TMenuItem* Line2;
	Vcl::Menus::TMenuItem* Diamond2;
	Vcl::Menus::TMenuItem* N15;
	Vcl::Menus::TMenuItem* NewRoot1;
	Vcl::Menus::TMenuItem* N2001;
	Vcl::Menus::TMenuItem* N51;
	Vcl::Menus::TMenuItem* Editortabs1;
	Vcl::Menus::TMenuItem* Left1;
	Vcl::Menus::TMenuItem* Top1;
	Vcl::Menus::TMenuItem* Right1;
	Vcl::Menus::TMenuItem* Bottom1;
	Vcl::Menus::TMenuItem* Horizontal1;
	Vcl::Menus::TMenuItem* Vertical1;
	Vcl::Menus::TMenuItem* Diagonal1;
	Vcl::Menus::TMenuItem* InvDiagonal1;
	Vcl::Menus::TMenuItem* N9;
	Vcl::Menus::TMenuItem* Help1;
	Vcl::Stdctrls::TCheckBox* CBVertAuto;
	Vcl::Menus::TMenuItem* Shapetabs1;
	Vcl::Comctrls::TTrackBar* TrackBarZoom;
	Vcl::Stdctrls::TCheckBox* CBHorizAuto;
	Vcl::Menus::TMenuItem* Export1;
	Vcl::Stdctrls::TCheckBox* CBBuffered;
	Vcl::Comctrls::TTabSheet* TabSheet10;
	Vcl::Stdctrls::TCheckBox* CBSnapGrid;
	Vcl::Stdctrls::TCheckBox* CBGrid;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Comctrls::TUpDown* UpDown3;
	Vcl::Stdctrls::TEdit* Edit5;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Stdctrls::TCheckBox* CBScrollToView;
	Vcltee::Teependlg::TButtonPen* Button3;
	Vcl::Stdctrls::TCheckBox* CBShowHint;
	Vcl::Stdctrls::TCheckBox* CBSingleSelect;
	Vcl::Menus::TMenuItem* Editortips1;
	Vcl::Menus::TMenuItem* N10;
	Vcl::Comctrls::TPageControl* PageShapes;
	Vcl::Comctrls::TTabSheet* TabSheet9;
	Vcl::Buttons::TSpeedButton* SpeedNormal;
	Vcl::Buttons::TSpeedButton* SpeedLink;
	Vcl::Menus::TMenuItem* NodeTheTree;
	Vcl::Extctrls::TPanel* PageNodes;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TCheckBox* CBAllowDelete;
	Vcl::Menus::TMenuItem* N12;
	Vcl::Menus::TMenuItem* AligntoGrid2;
	Vcl::Menus::TMenuItem* NewParent1;
	Vcl::Menus::TMenuItem* ShowNames1;
	Vcl::Menus::TMenuItem* Import1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Extctrls::TPanel* PanelToolButtons;
	Vcl::Buttons::TSpeedButton* ButtonNew;
	Vcl::Buttons::TSpeedButton* ButtonOpen;
	Vcl::Buttons::TSpeedButton* ButtonPrint;
	Vcl::Buttons::TSpeedButton* ButtonPrintPreview;
	Vcl::Buttons::TSpeedButton* ButtonSave;
	Vcl::Buttons::TSpeedButton* ButtonScroll;
	Vcl::Comctrls::TTabSheet* TabSheet12;
	Vcl::Stdctrls::TLabel* Label15;
	Vcltee::Teependlg::TButtonPen* BHandlePen;
	Vcl::Stdctrls::TEdit* EHandleSize;
	Vcl::Comctrls::TUpDown* UDHandleSize;
	Vcl::Extctrls::TPanel* PanelFont;
	Vcl::Buttons::TSpeedButton* FontBold;
	Vcl::Buttons::TSpeedButton* FontItalic;
	Vcl::Buttons::TSpeedButton* FontUnderline;
	Vcl::Buttons::TSpeedButton* FontStrike;
	Vcl::Buttons::TSpeedButton* FontLeftAlign;
	Vcl::Buttons::TSpeedButton* FontCenterAlign;
	Vcl::Buttons::TSpeedButton* FontRightAlign;
	Vcl::Extctrls::TShape* ShapeFontColor;
	Vcl::Buttons::TSpeedButton* SBOutline;
	Vcltee::Tecanvas::TComboFlat* ComboFonts;
	Vcltee::Tecanvas::TComboFlat* ComboFontSize;
	Vcl::Stdctrls::TEdit* EditFontInter;
	Vcl::Comctrls::TUpDown* UDFontInter;
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Menus::TMenuItem* N13;
	Vcl::Menus::TMenuItem* Fonttoolbar1;
	Vcl::Menus::TMenuItem* Statusbar2;
	Vcl::Stdctrls::TCheckBox* CBZoomCentered;
	Vcl::Menus::TMenuItem* Toolbar1;
	Vcl::Extctrls::TPanel* PanelToolbar;
	Vcl::Menus::TMenuItem* Reopen1;
	Vcl::Menus::TMenuItem* N14;
	Vcl::Stdctrls::TLabel* Label13;
	Vcltee::Tecanvas::TComboFlat* CBCrossStyle;
	Vcl::Stdctrls::TLabel* Label19;
	Vcltee::Tecanvas::TComboFlat* CBBevelInner;
	Vcl::Stdctrls::TLabel* Label20;
	Vcltee::Tecanvas::TComboFlat* CBBevelOuter;
	Vcl::Stdctrls::TCheckBox* CBBorder;
	Vcl::Extctrls::TPanel* PanelTree;
	Vcl::Menus::TMenuItem* Rulers1;
	Vcl::Menus::TMenuItem* Save1;
	Teetree::TTree* NodeTree;
	Vcl::Extctrls::TPanel* PanelNodes;
	Vcl::Extctrls::TPanel* PanelNodesInt;
	Vcl::Menus::TPopupMenu* PopupConn;
	Vcl::Menus::TMenuItem* Edit6;
	Vcl::Extctrls::TPanel* PanelShape;
	Vcl::Extctrls::TShape* ShapeBorderColor;
	Vcltee::Tecanvas::TComboFlat* ComboPenStyle;
	Vcl::Stdctrls::TScrollBar* BorderWidth;
	Vcl::Menus::TMenuItem* Bordertoolbar1;
	Vcl::Menus::TMenuItem* Delete3;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TShape* ShapeBrush;
	Vcltee::Tecanvas::TComboFlat* ComboBrush;
	Vcltee::Tecanvas::TComboFlat* ComboText;
	Vcl::Comctrls::TTabControl* TabControl1;
	Vcl::Menus::TPopupMenu* PopupNodeTree;
	Vcl::Menus::TMenuItem* Aligntoleft1;
	Vcl::Menus::TMenuItem* N16;
	Vcl::Menus::TMenuItem* Visible1;
	Vcl::Menus::TPopupMenu* PopupPoint;
	Vcl::Menus::TMenuItem* Delete4;
	Vcl::Stdctrls::TCheckBox* CBTransp;
	Vcl::Menus::TMenuItem* Addnewpoint1;
	Vcl::Menus::TMenuItem* N17;
	Vcl::Menus::TMenuItem* Addnewpoint2;
	Vcl::Menus::TMenuItem* N18;
	Vcl::Menus::TMenuItem* Color1;
	Vcl::Menus::TMenuItem* N19;
	Vcl::Menus::TMenuItem* Pattern1;
	Vcl::Menus::TMenuItem* ClipText1;
	Vcl::Stdctrls::TCheckBox* CBHotTrack;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBWheel;
	Vcl::Menus::TMenuItem* N20;
	Vcl::Menus::TMenuItem* Style2;
	Vcl::Menus::TMenuItem* Fixed1;
	Vcl::Menus::TMenuItem* Relativetostartnode1;
	Vcl::Menus::TMenuItem* Relativetoendnode1;
	Vcl::Menus::TMenuItem* AutoScroll1;
	Vcl::Menus::TMenuItem* N110;
	Vcl::Menus::TMenuItem* Sendbyemail1;
	Vcl::Extctrls::TTimer* Timer1;
	Vcl::Extctrls::TPanel* PanelTools;
	Vcltee::Tecanvas::TButtonColor* BHandleColor;
	Vcltee::Tecanvas::TButtonColor* BGridColor;
	Vcltee::Tecanvas::TButtonColor* BSelectedColor;
	Vcltee::Tecanvas::TButtonColor* BCrossColor;
	Vcltee::Tecanvas::TButtonColor* BSelectedText;
	Vcltee::Tecanvas::TButtonColor* BUnFocusedColor;
	Vcl::Extctrls::TPanel* PanelInspector;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Menus::TPopupMenu* PopupFormat;
	Vcl::Menus::TPopupMenu* PopupMenuPanel;
	Vcl::Menus::TMenuItem* PanelBackimage;
	Vcl::Menus::TMenuItem* MenuItem2;
	Vcl::Menus::TMenuItem* Lower1;
	Vcl::Menus::TMenuItem* Raise1;
	Vcl::Menus::TMenuItem* None1;
	Vcl::Menus::TMenuItem* PanelBorder;
	Vcl::Menus::TMenuItem* PanelColor;
	Vcl::Menus::TMenuItem* PanelGradient;
	Vcl::Menus::TMenuItem* Image1;
	Vcl::Menus::TMenuItem* HotTrack1;
	Vcl::Menus::TMenuItem* ShowHints1;
	Vcl::Menus::TMenuItem* Border2;
	Vcl::Menus::TMenuItem* Color2;
	Vcl::Menus::TMenuItem* Gradient2;
	Vcl::Menus::TMenuItem* Image2;
	Vcl::Menus::TMenuItem* Transparent2;
	Vcl::Menus::TMenuItem* Font2;
	Vcl::Menus::TMenuItem* Pattern2;
	Vcl::Extctrls::TTimer* TimerButton;
	Vcl::Menus::TMenuItem* Shadow2;
	Vcl::Menus::TMenuItem* Autosize1;
	Vcl::Menus::TMenuItem* Cliptext2;
	Vcl::Menus::TMenuItem* CrossBox1;
	Vcl::Menus::TMenuItem* Automatic1;
	Vcl::Menus::TMenuItem* Always1;
	Vcl::Menus::TMenuItem* Never1;
	Vcltee::Teependlg::TButtonPen* BGridPen;
	Vcltee::Teependlg::TButtonPen* BGridBigPen;
	Vcl::Menus::TPopupMenu* PopupConnFormat;
	Vcl::Menus::TMenuItem* Border3;
	Vcl::Menus::TMenuItem* Points1;
	Vcl::Menus::TMenuItem* Font3;
	Vcl::Buttons::TSpeedButton* ButtonZoomIn;
	Vcl::Buttons::TSpeedButton* ButtonZoomOut;
	Vcl::Stdctrls::TEdit* Edit7;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Menus::TMenuItem* Inspector1;
	Vcl::Buttons::TSpeedButton* SpeedButton5;
	Vcl::Buttons::TSpeedButton* SpeedButton6;
	Vcl::Buttons::TSpeedButton* SpeedButton7;
	Vcl::Buttons::TSpeedButton* SpeedButton8;
	Vcl::Menus::TMenuItem* Fromarrow1;
	Vcl::Menus::TMenuItem* ToArrow1;
	Vcl::Menus::TMenuItem* Text2;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcl::Stdctrls::TCheckBox* CBShowRulers;
	Vcl::Stdctrls::TCheckBox* CBRulersUnits;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TCheckBox* CBPrinterDefault;
	Vcl::Stdctrls::TEdit* EPageWidth;
	Vcl::Comctrls::TUpDown* UDPageWidth;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TEdit* EPageHeight;
	Vcl::Comctrls::TUpDown* UDPageHeight;
	Vcltee::Teependlg::TButtonPen* BPageBorder;
	Vcltee::Tecanvas::TButtonColor* ButtonColor1;
	Vcl::Stdctrls::TCheckBox* CBPrintPanel;
	Vcl::Menus::TMenuItem* Toolbars1;
	Vcl::Menus::TMenuItem* Style3;
	Vcl::Menus::TMenuItem* Automatic2;
	Vcl::Menus::TMenuItem* Line1;
	Vcl::Menus::TMenuItem* Sides1;
	Vcl::Menus::TMenuItem* Curve1;
	Vcl::Stdctrls::TCheckBox* CBPrintPageBorder;
	Vcl::Stdctrls::TCheckBox* CBScrollFlat;
	Vcltee::Tecanvas::TComboFlat* CBUnits;
	Vcl::Menus::TMenuItem* BackColor1;
	Vcl::Comctrls::TUpDown* UDZoom;
	Vcl::Stdctrls::TButton* BGradPanel;
	Vcl::Stdctrls::TCheckBox* CBTextEnabled;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBTextMode;
	Vcl::Stdctrls::TLabel* Label14;
	Vcltee::Tecanvas::TComboFlat* CBTextKey;
	Vcl::Stdctrls::TLabel* Label16;
	Vcltee::Tecanvas::TComboFlat* CBTextMouse;
	Vcl::Stdctrls::TCheckBox* CBTextSize;
	Vcl::Stdctrls::TCheckBox* CBTextFormat;
	Vcl::Extctrls::TRadioGroup* RadioGroup1;
	Vcl::Stdctrls::TCheckBox* CBTextFont;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Menus::TMenuItem* N21;
	Vcl::Menus::TMenuItem* Sizetogrid1;
	Vcl::Extctrls::TPaintBox* PaintBox1;
	Vcl::Menus::TMenuItem* N22;
	Vcl::Menus::TMenuItem* Copyaspicture1;
	Teetree::TTreeRuler* HorizRuler;
	Teetree::TTreeRuler* VertRuler;
	Vcl::Menus::TMenuItem* Automatic3;
	Vcltee::Teeinspector::TTeeInspector* TeeInspector1;
	Treenavigator::TTreePageNavigator* TreePageNavigator1;
	Vcl::Menus::TMenuItem* InvertedSides1;
	Vcl::Menus::TMenuItem* N24;
	Vcl::Menus::TMenuItem* Linestyle1;
	Vcl::Menus::TMenuItem* Sidesstyle1;
	Vcl::Menus::TMenuItem* Invertedsidesstyle1;
	Vcl::Menus::TMenuItem* Curve2;
	Vcl::Menus::TMenuItem* Automatic4;
	Vcl::Buttons::TSpeedButton* SBCloseInspector;
	Vcl::Buttons::TSpeedButton* SBCloseNodeTree;
	Vcl::Menus::TMenuItem* Shadow3;
	Vcl::Menus::TMenuItem* Chamfer1;
	Vcl::Stdctrls::TCheckBox* CBRender;
	void __fastcall BBackImageClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBGridClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall AddBrother1Click(System::TObject* Sender);
	void __fastcall AddChild1Click(System::TObject* Sender);
	void __fastcall BringtoFront1Click(System::TObject* Sender);
	void __fastcall Copy1Click(System::TObject* Sender);
	void __fastcall Cut1Click(System::TObject* Sender);
	void __fastcall Delete1Click(System::TObject* Sender);
	void __fastcall Edit1Click(System::TObject* Sender);
	void __fastcall Paste1Click(System::TObject* Sender);
	void __fastcall PopupNodePopup(System::TObject* Sender);
	void __fastcall SendtoBack1Click(System::TObject* Sender);
	void __fastcall CBImageStyleChange(System::TObject* Sender);
	void __fastcall AddnewRoot2Click(System::TObject* Sender);
	void __fastcall Prune1Click(System::TObject* Sender);
	void __fastcall Button6Click(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Aligntogrid1Click(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall SpeedButton3Click(System::TObject* Sender);
	void __fastcall SpeedButton4Click(System::TObject* Sender);
	void __fastcall CBAllowScrollChange(System::TObject* Sender);
	void __fastcall CBZoomAnimatedClick(System::TObject* Sender);
	void __fastcall CBAllowZoomClick(System::TObject* Sender);
	void __fastcall CBSelectedColorDefClick(System::TObject* Sender);
	void __fastcall CBSelectedTextDefClick(System::TObject* Sender);
	void __fastcall CBHorizVisibleClick(System::TObject* Sender);
	void __fastcall CBVertVisibleClick(System::TObject* Sender);
	void __fastcall AboutTeeTree101Click(System::TObject* Sender);
	void __fastcall TeeTree10HomePage1Click(System::TObject* Sender);
	void __fastcall wwwSteemacom1Click(System::TObject* Sender);
	void __fastcall New1Click(System::TObject* Sender);
	void __fastcall Printpreview1Click(System::TObject* Sender);
	void __fastcall Close1Click(System::TObject* Sender);
	void __fastcall Print1Click(System::TObject* Sender);
	void __fastcall Saveas1Click(System::TObject* Sender);
	void __fastcall Open1Click(System::TObject* Sender);
	void __fastcall Cut2Click(System::TObject* Sender);
	void __fastcall Copy2Click(System::TObject* Sender);
	void __fastcall Paste2Click(System::TObject* Sender);
	void __fastcall Delete2Click(System::TObject* Sender);
	void __fastcall Selectall1Click(System::TObject* Sender);
	void __fastcall Search2Click(System::TObject* Sender);
	void __fastcall N1001Click(System::TObject* Sender);
	void __fastcall N751Click(System::TObject* Sender);
	void __fastcall N501Click(System::TObject* Sender);
	void __fastcall N251Click(System::TObject* Sender);
	void __fastcall N151Click(System::TObject* Sender);
	void __fastcall N101Click(System::TObject* Sender);
	void __fastcall Child1Click(System::TObject* Sender);
	void __fastcall Brother1Click(System::TObject* Sender);
	void __fastcall Prunenode1Click(System::TObject* Sender);
	void __fastcall NewRoot1Click(System::TObject* Sender);
	void __fastcall Connections1Click(System::TObject* Sender);
	void __fastcall Images1Click(System::TObject* Sender);
	void __fastcall Grid1Click(System::TObject* Sender);
	void __fastcall Text1Click(System::TObject* Sender);
	void __fastcall Crossboxes1Click(System::TObject* Sender);
	void __fastcall Shapes1Click(System::TObject* Sender);
	void __fastcall Color1Click(System::TObject* Sender);
	void __fastcall Format1Click(System::TObject* Sender);
	void __fastcall Insert1Click(System::TObject* Sender);
	void __fastcall Gradient1Click(System::TObject* Sender);
	void __fastcall Border1Click(System::TObject* Sender);
	void __fastcall Font1Click(System::TObject* Sender);
	void __fastcall Shadow1Click(System::TObject* Sender);
	void __fastcall Style1Click(System::TObject* Sender);
	void __fastcall Transparent1Click(System::TObject* Sender);
	void __fastcall Edit4Click(System::TObject* Sender);
	void __fastcall N2001Click(System::TObject* Sender);
	void __fastcall N51Click(System::TObject* Sender);
	void __fastcall View1Click(System::TObject* Sender);
	void __fastcall Editortabs1Click(System::TObject* Sender);
	void __fastcall Zoom1Click(System::TObject* Sender);
	void __fastcall Line2Click(System::TObject* Sender);
	void __fastcall Triangle2Click(System::TObject* Sender);
	void __fastcall RoundRectangle1Click(System::TObject* Sender);
	void __fastcall Rectangle2Click(System::TObject* Sender);
	void __fastcall Ellipse2Click(System::TObject* Sender);
	void __fastcall Left1Click(System::TObject* Sender);
	void __fastcall Top1Click(System::TObject* Sender);
	void __fastcall Right1Click(System::TObject* Sender);
	void __fastcall Bottom1Click(System::TObject* Sender);
	void __fastcall Horizontal1Click(System::TObject* Sender);
	void __fastcall Vertical1Click(System::TObject* Sender);
	void __fastcall Diagonal1Click(System::TObject* Sender);
	void __fastcall InvDiagonal1Click(System::TObject* Sender);
	void __fastcall Diamond2Click(System::TObject* Sender);
	void __fastcall Linknodes1Click(System::TObject* Sender);
	void __fastcall Help1Click(System::TObject* Sender);
	void __fastcall CBVertAutoClick(System::TObject* Sender);
	void __fastcall SpeedLinkClick(System::TObject* Sender);
	void __fastcall PageShapesChange(System::TObject* Sender);
	void __fastcall SpeedNormalClick(System::TObject* Sender);
	void __fastcall Shapetabs1Click(System::TObject* Sender);
	void __fastcall TrackBarZoomChange(System::TObject* Sender);
	void __fastcall CBHorizAutoClick(System::TObject* Sender);
	void __fastcall Export1Click(System::TObject* Sender);
	void __fastcall CBBufferedClick(System::TObject* Sender);
	void __fastcall CBSnapGridClick(System::TObject* Sender);
	void __fastcall Edit5Change(System::TObject* Sender);
	void __fastcall Tools1Click(System::TObject* Sender);
	void __fastcall Edit3Change(System::TObject* Sender);
	void __fastcall CBScrollToViewClick(System::TObject* Sender);
	void __fastcall CBShowHintClick(System::TObject* Sender);
	void __fastcall CBSingleSelectClick(System::TObject* Sender);
	void __fastcall Editortips1Click(System::TObject* Sender);
	void __fastcall NodeTheTreeClick(System::TObject* Sender);
	void __fastcall NodeTreeSelectShape(Teetree::TTreeNodeShape* Sender);
	void __fastcall NodeTreeMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall CBAllowDeleteClick(System::TObject* Sender);
	void __fastcall NodeTreeDeletingShapes(Teetree::TSelectedShapeList* Sender, bool &AllowDelete);
	void __fastcall NodeTreeStopEditing(Teetree::TTreeNodeShape* Sender);
	void __fastcall NewParent1Click(System::TObject* Sender);
	void __fastcall AligntoGrid2Click(System::TObject* Sender);
	void __fastcall ShowNames1Click(System::TObject* Sender);
	void __fastcall Import1Click(System::TObject* Sender);
	void __fastcall ButtonNewClick(System::TObject* Sender);
	void __fastcall ButtonOpenClick(System::TObject* Sender);
	void __fastcall ButtonPrintClick(System::TObject* Sender);
	void __fastcall ButtonPrintPreviewClick(System::TObject* Sender);
	void __fastcall ButtonZoomInClick(System::TObject* Sender);
	void __fastcall ButtonScrollClick(System::TObject* Sender);
	void __fastcall EHandleSizeChange(System::TObject* Sender);
	void __fastcall ShapeFontColorMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Fonttoolbar1Click(System::TObject* Sender);
	void __fastcall Statusbar2Click(System::TObject* Sender);
	void __fastcall ComboFontsChange(System::TObject* Sender);
	void __fastcall ComboFontSizeChange(System::TObject* Sender);
	void __fastcall FontBoldClick(System::TObject* Sender);
	void __fastcall EditFontInterChange(System::TObject* Sender);
	void __fastcall SBOutlineClick(System::TObject* Sender);
	void __fastcall FontLeftAlignClick(System::TObject* Sender);
	void __fastcall CBZoomCenteredClick(System::TObject* Sender);
	void __fastcall Toolbar1Click(System::TObject* Sender);
	void __fastcall CBShowRulersClick(System::TObject* Sender);
	void __fastcall Rulers1Click(System::TObject* Sender);
	void __fastcall CBBevelInnerChange(System::TObject* Sender);
	void __fastcall CBBevelOuterChange(System::TObject* Sender);
	void __fastcall CBBorderClick(System::TObject* Sender);
	void __fastcall CBCrossStyleChange(System::TObject* Sender);
	void __fastcall Save1Click(System::TObject* Sender);
	void __fastcall NodeTreeUnSelectShape(Teetree::TTreeNodeShape* Sender);
	void __fastcall Edit6Click(System::TObject* Sender);
	void __fastcall ComboPenStyleChange(System::TObject* Sender);
	void __fastcall ShapeBorderColorMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall BorderWidthChange(System::TObject* Sender);
	void __fastcall ComboPenStyleDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall Bordertoolbar1Click(System::TObject* Sender);
	void __fastcall Delete3Click(System::TObject* Sender);
	void __fastcall ShapeBrushMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ComboBrushDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall ComboBrushChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall Visible1Click(System::TObject* Sender);
	void __fastcall Aligntoleft1Click(System::TObject* Sender);
	void __fastcall PageNodesMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ComboTextChange(System::TObject* Sender);
	void __fastcall Delete4Click(System::TObject* Sender);
	void __fastcall CBTranspClick(System::TObject* Sender);
	void __fastcall Addnewpoint1Click(System::TObject* Sender);
	void __fastcall Pattern1Click(System::TObject* Sender);
	void __fastcall ClipText1Click(System::TObject* Sender);
	void __fastcall CBHotTrackClick(System::TObject* Sender);
	void __fastcall CBWheelChange(System::TObject* Sender);
	void __fastcall PopupPointPopup(System::TObject* Sender);
	void __fastcall Fixed1Click(System::TObject* Sender);
	void __fastcall Relativetostartnode1Click(System::TObject* Sender);
	void __fastcall Relativetoendnode1Click(System::TObject* Sender);
	void __fastcall AutoScroll1Click(System::TObject* Sender);
	void __fastcall N110Click(System::TObject* Sender);
	void __fastcall Sendbyemail1Click(System::TObject* Sender);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall BGridColorClick(System::TObject* Sender);
	void __fastcall BSelectedColorClick(System::TObject* Sender);
	void __fastcall BSelectedTextClick(System::TObject* Sender);
	void __fastcall BUnFocusedColorClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall PopupMenuPanelPopup(System::TObject* Sender);
	void __fastcall PanelBackimageClick(System::TObject* Sender);
	void __fastcall Image1Click(System::TObject* Sender);
	void __fastcall None1Click(System::TObject* Sender);
	void __fastcall PanelBorderClick(System::TObject* Sender);
	void __fastcall PanelColorClick(System::TObject* Sender);
	void __fastcall PanelGradientClick(System::TObject* Sender);
	void __fastcall HotTrack1Click(System::TObject* Sender);
	void __fastcall ShowHints1Click(System::TObject* Sender);
	void __fastcall Transparent2Click(System::TObject* Sender);
	void __fastcall TimerButtonTimer(System::TObject* Sender);
	void __fastcall PopupFormatPopup(System::TObject* Sender);
	void __fastcall Border2Click(System::TObject* Sender);
	void __fastcall Color2Click(System::TObject* Sender);
	void __fastcall Font2Click(System::TObject* Sender);
	void __fastcall Gradient2Click(System::TObject* Sender);
	void __fastcall Image2Click(System::TObject* Sender);
	void __fastcall Pattern2Click(System::TObject* Sender);
	void __fastcall Autosize1Click(System::TObject* Sender);
	void __fastcall Cliptext2Click(System::TObject* Sender);
	void __fastcall Never1Click(System::TObject* Sender);
	void __fastcall Shadow2Click(System::TObject* Sender);
	void __fastcall PopupConnFormatPopup(System::TObject* Sender);
	void __fastcall Border3Click(System::TObject* Sender);
	void __fastcall Points1Click(System::TObject* Sender);
	void __fastcall Font3Click(System::TObject* Sender);
	void __fastcall ButtonSaveClick(System::TObject* Sender);
	void __fastcall ButtonZoomOutClick(System::TObject* Sender);
	void __fastcall Inspector1Click(System::TObject* Sender);
	void __fastcall SpeedButton5Click(System::TObject* Sender);
	void __fastcall SpeedButton7Click(System::TObject* Sender);
	void __fastcall PageTreeChange(System::TObject* Sender);
	void __fastcall Fromarrow1Click(System::TObject* Sender);
	void __fastcall ToArrow1Click(System::TObject* Sender);
	void __fastcall Text2Click(System::TObject* Sender);
	void __fastcall CBRulersUnitsClick(System::TObject* Sender);
	void __fastcall CBPrintPanelClick(System::TObject* Sender);
	void __fastcall BPageBorderClick(System::TObject* Sender);
	void __fastcall BHandleColorClick(System::TObject* Sender);
	void __fastcall BHandlePenClick(System::TObject* Sender);
	void __fastcall BGridPenClick(System::TObject* Sender);
	void __fastcall BGridBigPenClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall ButtonColor1Click(System::TObject* Sender);
	void __fastcall BCrossBorderClick(System::TObject* Sender);
	void __fastcall BCrossColorClick(System::TObject* Sender);
	void __fastcall SignPenButtonClick(System::TObject* Sender);
	void __fastcall CBPrinterDefaultClick(System::TObject* Sender);
	void __fastcall EPageWidthChange(System::TObject* Sender);
	void __fastcall EPageHeightChange(System::TObject* Sender);
	void __fastcall Curve1Click(System::TObject* Sender);
	void __fastcall CBPrintPageBorderClick(System::TObject* Sender);
	void __fastcall CBScrollFlatClick(System::TObject* Sender);
	void __fastcall CBUnitsChange(System::TObject* Sender);
	void __fastcall BackColor1Click(System::TObject* Sender);
	void __fastcall ComboFontSizeExit(System::TObject* Sender);
	void __fastcall UDZoomClick(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	void __fastcall CBTextEnabledClick(System::TObject* Sender);
	void __fastcall CBTextModeChange(System::TObject* Sender);
	void __fastcall CBTextKeyChange(System::TObject* Sender);
	void __fastcall CBTextMouseChange(System::TObject* Sender);
	void __fastcall CBTextSizeClick(System::TObject* Sender);
	void __fastcall CBTextFormatClick(System::TObject* Sender);
	void __fastcall CBTextFontClick(System::TObject* Sender);
	void __fastcall SBFontGradClick(System::TObject* Sender);
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall Copyaspicture1Click(System::TObject* Sender);
	void __fastcall ComboTextDropDown(System::TObject* Sender);
	void __fastcall Automatic3Click(System::TObject* Sender);
	void __fastcall Curve2Click(System::TObject* Sender);
	void __fastcall PopupConnPopup(System::TObject* Sender);
	void __fastcall SBCloseInspectorClick(System::TObject* Sender);
	void __fastcall PanelInspectorResize(System::TObject* Sender);
	void __fastcall SBCloseNodeTreeClick(System::TObject* Sender);
	void __fastcall Shadow3Click(System::TObject* Sender);
	void __fastcall Chamfer1Click(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBRenderClick(System::TObject* Sender);
	
private:
	Teerecentfiles::TRecentFiles* FRecentFiles;
	Teetree::TTreeClipboard* TreeClipboard;
	bool Creating;
	bool Deleting;
	Vcl::Controls::TAlign OldAlign;
	System::Uitypes::TAnchors OldAnchors;
	System::Types::TRect OldBounds;
	bool OldDesignState;
	System::Uitypes::TDragMode OldDragMode;
	bool OldGrid;
	System::Classes::TNotifyEvent OldDblClick;
	Teetree::TTreeEvents SavedEvents;
	bool Selecting;
	Vcl::Controls::TWinControl* OldParent;
	Vcl::Menus::TPopupMenu* OldPopup;
	bool OldDesigning;
	bool OldZoom;
	Vcltee::Teeprocs::TPanningMode OldPanning;
	bool OldVisible;
	System::Types::TPoint OldCursorPos;
	bool ComingFromDoubleClick;
	Teetree::TTreeNodeShape* __fastcall AddNewRoot();
	void __fastcall CheckPanelNodes();
	void __fastcall CheckPanelToolBar();
	void __fastcall CheckPanelTools();
	void __fastcall CheckSaveDialogFilter();
	void __fastcall ComboFontSizeKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall CreateNewTree();
	void __fastcall DoLoadTreeImage();
	void __fastcall DoZoom(int Value);
	void __fastcall EditConnectionPage(int NumPage);
	void __fastcall EnablePageControls();
	void __fastcall NodeTreeDragDrop(Teetree::TCustomTree* Sender, Teetree::TTreeNodeShape* Dragged, Teetree::TTreeNodeShape* Parent);
	void __fastcall UpdateNodeTree();
	System::Uitypes::TFontStyles __fastcall GetFontAttribute();
	Teetree::THorizTextAlign __fastcall GetFontAlign();
	int __fastcall GetFontSize();
	Teetree::TTreeNodeShape* __fastcall GetNodeTreeShape(Teetree::TTreeNodeShape* ANode);
	void __fastcall MainSetCaption();
	void __fastcall NodeTreeKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	System::UnicodeString __fastcall NodeTreeText(Teetree::TTreeNodeShape* ANode);
	void __fastcall RefreshStatusBar();
	void __fastcall ReopenFile(const System::UnicodeString FileName);
	void __fastcall ResetNodeTreeSelected();
	void __fastcall SaveOldTreeSettings();
	Vcltee::Tecanvas::TTeePen* __fastcall SelectedBorder();
	Teetree::TCustomTreeElement* __fastcall SelectedElement();
	void __fastcall SetPageControls();
	void __fastcall SetTreeProperties();
	void __fastcall SetTreeSettings();
	void __fastcall SpeedClick(System::TObject* Sender);
	void __fastcall SpeedPolygonClick(System::TObject* Sender);
	bool __fastcall TeeEditColor(System::Uitypes::TColor &Color);
	void __fastcall TheTreeAfterDraw(System::TObject* Sender);
	void __fastcall TheTreeDeletedShapes(System::TObject* Sender);
	void __fastcall TheTreeSelectShape(Teetree::TTreeNodeShape* Sender);
	void __fastcall TheTreeUnSelectShape(Teetree::TTreeNodeShape* Sender);
	void __fastcall TheTreeSelectConnection(Teetree::TTreeConnection* Sender);
	void __fastcall TheTreeUnSelectConnection(Teetree::TTreeConnection* Sender);
	void __fastcall TheTreeMovingShape(Teetree::TTreeNodeShape* Sender, int &DeltaX, int &DeltaY);
	void __fastcall TheTreeMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TheTreeMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TheTreeNewPolygon(Teetree::TCustomTree* Sender, Teetree::TPolygonShape* APolygon);
	void __fastcall TheTreeResizingShape(Teetree::TTreeNodeShape* Sender, Teetree::TTreeShapeHandle ACorner, int &DeltaX, int &DeltaY);
	void __fastcall TheTreeStopEditing(Teetree::TTreeNodeShape* Sender);
	void __fastcall TheTreeClickConnection(Teetree::TTreeConnection* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TheTreeDblClickConnection(Teetree::TTreeConnection* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TheTreeDblClickShape(Teetree::TTreeNodeShape* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TheTreeKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall TheTreeOnZoomedArea(const System::Types::TRect &R);
	void __fastcall TheTreeOnZoom(System::TObject* Sender);
	void __fastcall ChangeZoom(int Value);
	void __fastcall RefreshZoomLabel();
	void __fastcall ChangeStyle(Teetree::TTreeShapeStyle AStyle);
	void __fastcall SpeedDouble(System::TObject* Sender);
	void __fastcall AddNewShape(PTreeTagShape AClass, const System::Types::TRect &R);
	void __fastcall InternalAddShape(int AGroup, const System::UnicodeString AName, Teetree::TTreeNodeShapeClass AClass, bool UseStyle, Teetree::TTreeShapeStyle AStyle);
	PTreeTagShape __fastcall GetToolBarShape();
	void __fastcall InternalAddCustomShape(const System::UnicodeString AGroup, const System::UnicodeString AName, Teetree::TTreeNodeShapeClass AClass);
	void __fastcall TryPopup(Teetree::TCustomTree* ATree, int x, int y);
	void __fastcall ChangeAutoSize(Teetree::TTreeNodeShape* Sender);
	Vcl::Controls::TBevelCut __fastcall ChangeBevel(Vcl::Stdctrls::TComboBox* ACombo);
	void __fastcall ChangeBorderWidth(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeClipText(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeClipText2(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeFontColor(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangePointStyle(Teetree::TConnectionPointStyle AStyle);
	void __fastcall ChangeFont(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeFontAttrib(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeFontSize(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeFontAlign(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeGradient(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeImageIndex(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeInterChar(Teetree::TTreeNodeShape* Sender);
	void __fastcall ChangeTransparent(Teetree::TTreeNodeShape* Sender);
	void __fastcall DoAlignToGrid(Teetree::TTreeNodeShape* Sender);
	void __fastcall DoBringtoFront(Teetree::TTreeNodeShape* Sender);
	void __fastcall DoPrune(Teetree::TTreeNodeShape* Sender);
	void __fastcall DoSendToBack(Teetree::TTreeNodeShape* Sender);
	void __fastcall DoSelection(Teetree::TTreeNodeShape* Node, bool Select);
	void __fastcall DoSetOutLine(Teetree::TTreeNodeShape* Sender);
	void __fastcall DoEnableControls(Vcl::Controls::TWinControl* AContainer, bool IsEnable);
	void __fastcall SelectExpandNode(Teetree::TTreeNodeShape* Node, bool Select);
	void __fastcall SetBevelCombo(Vcl::Controls::TBevelCut ABevel, Vcl::Stdctrls::TComboBox* ACombo);
	void __fastcall SetBorderControls();
	void __fastcall SetFontControls();
	void __fastcall SetOtherControls();
	void __fastcall SetToolBars();
	void __fastcall RefreshRulers();
	
protected:
	System::UnicodeString CaptionFormat;
	System::UnicodeString CurrentFile;
	bool FModified;
	bool FSetting;
	TTreeUndo* TreeUndo;
	bool __fastcall CheckSave();
	void __fastcall DoSaveTree();
	void __fastcall DoTranslate();
	void __fastcall FillNodeTree();
	void __fastcall InternalSaveTree();
	void __fastcall LoadTree(const System::UnicodeString AFileName);
	DYNAMIC void __fastcall LoadTreeProc(System::Classes::TReader* Reader, System::Classes::TStream* Stream);
	void __fastcall ResetTree();
	void __fastcall SetInspectorProperties();
	DYNAMIC void __fastcall SetNewTreeSettings();
	void __fastcall TeeModified(bool YesNo = true);
	__classmethod virtual TTreeClass __fastcall TeeTreeClass();
	DYNAMIC void __fastcall WriteTreeToStream(System::Classes::TStream* AStream);
	
public:
	Teetree::TCustomTree* TheTree;
	bool PersistOptions;
	void __fastcall RegisterTreeShape(int AGroup, const System::UnicodeString AName, Teetree::TTreeShapeStyle AStyle);
	DYNAMIC void __fastcall LoadEditorParameters();
	DYNAMIC void __fastcall SaveEditorParameters();
	void __fastcall StopConnecting();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTreeEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTreeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTreeEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTreeEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef void __fastcall (*TTreeNotifyEvent)(TTreeEditor* Sender);

enum DECLSPEC_DENUM TTreeEditWindow : unsigned char { teInspector, teNodeTree, teToolbar, teToolShapes, teEditors, teFont, teFormat, teRulers, teStatus, teModeTabs, teMainMenu };

typedef System::Set<TTreeEditWindow, TTreeEditWindow::teInspector, TTreeEditWindow::teMainMenu> TTreeEditWindows;

class PASCALIMPLEMENTATION TTreeEdit : public Teetree::TCustomTreeLink
{
	typedef Teetree::TCustomTreeLink inherited;
	
private:
	TTreeEditWindows FHide;
	bool FMaximized;
	bool FPersist;
	Vcl::Forms::TPosition FPosition;
	System::UnicodeString FTitle;
	System::Classes::TNotifyEvent FOnClose;
	
public:
	__fastcall virtual TTreeEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall Execute();
	
__published:
	__property TTreeEditWindows Hide = {read=FHide, write=FHide, default=16};
	__property bool Maximized = {read=FMaximized, write=FMaximized, default=0};
	__property bool PersistOptions = {read=FPersist, write=FPersist, default=0};
	__property Vcl::Forms::TPosition Position = {read=FPosition, write=FPosition, default=1};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TTreeEdit() { }
	
};


class PASCALIMPLEMENTATION TTreeEditorPanel : public Teetree::TCustomPanelTreeLink
{
	typedef Teetree::TCustomPanelTreeLink inherited;
	
private:
	TTreeEditor* FEditor;
	TTreeEditWindows FHide;
	void __fastcall CreateEditor();
	TTreeEditor* __fastcall GetEditor();
	void __fastcall SetHide(TTreeEditWindows Value);
	
protected:
	virtual void __fastcall Loaded();
	virtual void __fastcall SetTree(Teetree::TCustomTree* const Value);
	
public:
	__fastcall virtual TTreeEditorPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTreeEditorPanel();
	void __fastcall PreviewMode();
	__property TTreeEditor* Editor = {read=GetEditor};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderStyle = {default=0};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777201};
	__property Enabled = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property TTreeEditWindows HideWindows = {read=FHide, write=SetHide, default=16};
	__property Tree;
public:
	/* TWinControl.CreateParented */ inline __fastcall TTreeEditorPanel(HWND ParentWindow) : Teetree::TCustomPanelTreeLink(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 sgStandard = System::Int8(0x0);
extern DELPHI_PACKAGE void __fastcall TreeLogoSetPicture(Vcl::Graphics::TPicture* APicture);
extern DELPHI_PACKAGE void __fastcall TeeShowTreeAbout(const System::UnicodeString BuildNumber);
extern DELPHI_PACKAGE void __fastcall TreePreview(System::Classes::TComponent* AOwner, Teetree::TCustomTree* Tree, bool PrintPanel = false);
extern DELPHI_PACKAGE void __fastcall ShowTreeExport(System::Classes::TComponent* AOwner, Teetree::TCustomTree* ATree);
extern DELPHI_PACKAGE void __fastcall LoadTreeChildsFromFile(Teetree::TTreeNodeShape* ANode, const System::UnicodeString AName);
extern DELPHI_PACKAGE void __fastcall EditTree(System::Classes::TComponent* AOwner, Teetree::TCustomTree* ATree);
extern DELPHI_PACKAGE void __fastcall EditTreeNoAbout(System::Classes::TComponent* AOwner, Teetree::TCustomTree* ATree);
extern DELPHI_PACKAGE void __fastcall EditTreeEvent(System::Classes::TComponent* AOwner, Teetree::TCustomTree* ATree, TTreeNotifyEvent AEvent);
extern DELPHI_PACKAGE void __fastcall CreateColorBitmap(Vcl::Menus::TMenuItem* Item, System::Uitypes::TColor AColor);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetTeeTreeHelpFile(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetTeeTreeUserHelpFile(void);
}	/* namespace Treeed */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEED)
using namespace Treeed;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeedHPP
