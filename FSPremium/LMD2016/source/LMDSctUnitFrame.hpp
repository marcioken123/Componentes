// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctUnitFrame.pas' rev: 31.00 (Windows)

#ifndef LmdsctunitframeHPP
#define LmdsctunitframeHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Menus.hpp>
#include <ToolsAPI.hpp>
#include <LMDXML.hpp>
#include <LMDSctImporterFileUtils.hpp>
#include <LMDSctImporterTree.hpp>
#include <LMDSctImporterUnitDoc.hpp>
#include <LMDSctDialects.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctunitframe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDUnitFrame;
class DELPHICLASS TLMDIDEModuleNotifier;
class DELPHICLASS TLMDUnitDocNotifier;
class DELPHICLASS TLMDUnitDocSourceProvider;
__interface ILMDUnitFrameTraits;
typedef System::DelphiInterface<ILMDUnitFrameTraits> _di_ILMDUnitFrameTraits;
class DELPHICLASS TLMDUnitFrame;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDUnitFrame : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDUnitFrame(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDUnitFrame(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDUnitFrame(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDUnitFrame(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDUnitFrame(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDUnitFrame(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDUnitFrame(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDUnitFrame(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDUnitFrame(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDUnitFrame(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDUnitFrame(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDUnitFrame(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDUnitFrame(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEModuleNotifier : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	TLMDUnitFrame* FFrame;
	
protected:
	void __fastcall AfterSave(void);
	void __fastcall BeforeSave(void);
	void __fastcall Destroyed(void);
	void __fastcall Modified(void);
	bool __fastcall CheckOverwrite(void);
	void __fastcall ModuleRenamed(const System::UnicodeString NewName);
	
public:
	__fastcall TLMDIDEModuleNotifier(TLMDUnitFrame* AFrame);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDIDEModuleNotifier(void) { }
	
private:
	void *__IOTAModuleNotifier;	// Toolsapi::IOTAModuleNotifier 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F17A7BCE-E07D-11D1-AB0B-00C04FB16FB3}
	operator Toolsapi::_di_IOTAModuleNotifier()
	{
		Toolsapi::_di_IOTAModuleNotifier intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAModuleNotifier*(void) { return (Toolsapi::IOTAModuleNotifier*)&__IOTAModuleNotifier; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F17A7BCF-E07D-11D1-AB0B-00C04FB16FB3}
	operator Toolsapi::_di_IOTANotifier()
	{
		Toolsapi::_di_IOTANotifier intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTANotifier*(void) { return (Toolsapi::IOTANotifier*)&__IOTAModuleNotifier; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitDocNotifier : public Lmdsctimporterunitdoc::ILMDUnitDocNotifier
{
	typedef Lmdsctimporterunitdoc::ILMDUnitDocNotifier inherited;
	
private:
	TLMDUnitFrame* FFrame;
	
public:
	__fastcall TLMDUnitDocNotifier(TLMDUnitFrame* AFrame);
	virtual void __fastcall Modified(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender);
	virtual void __fastcall AnalizeProgress(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender, int ADeclsCount, int AAnalizedCount);
	virtual bool __fastcall PreprocessUsedUnit(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender, const System::UnicodeString AUnitName, /* out */ System::UnicodeString &AUSUPath);
	virtual void __fastcall UsedElemReferenced(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender, const System::UnicodeString AUnitName, const System::UnicodeString AElemFullName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUnitDocNotifier(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitDocSourceProvider : public Lmdsctimporterunitdoc::ILMDUnitDocSourceProvider
{
	typedef Lmdsctimporterunitdoc::ILMDUnitDocSourceProvider inherited;
	
private:
	TLMDUnitFrame* FFrame;
	
protected:
	virtual System::UnicodeString __fastcall GetSource(void);
	
public:
	__fastcall TLMDUnitDocSourceProvider(TLMDUnitFrame* AFrame);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUnitDocSourceProvider(void) { }
	
};

#pragma pack(pop)

__interface ILMDUnitFrameTraits  : public System::IInterface 
{
	virtual void __fastcall UpdateCaption(void) = 0 ;
	virtual void __fastcall OpenUsedUnit(const System::UnicodeString AUnitName) = 0 ;
	virtual bool __fastcall UseExternalMessageView(void) = 0 ;
	virtual void __fastcall BeginImporting(void) = 0 ;
	virtual void __fastcall ImportingProgress(int AProgress) = 0 ;
	virtual void __fastcall EndImporting(bool ASucceded) = 0 ;
};

class PASCALIMPLEMENTATION TLMDUnitFrame : public Vcl::Forms::TFrame
{
	typedef Vcl::Forms::TFrame inherited;
	
__published:
	Vcl::Controls::TImageList* TreeImages;
	Vcl::Controls::TImageList* StateImages;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Controls::TImageList* ActionImages;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Extctrls::TPanel* DocErrorsPanel;
	Vcl::Stdctrls::TListBox* DocErrorsListBox;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TListBox* NodeErrorsListBox;
	Vcl::Extctrls::TPanel* MainPanel;
	Vcl::Comctrls::TTreeView* TreeView;
	Vcl::Comctrls::TProgressBar* ProgressBar;
	Vcl::Actnlist::TActionList* ActionList;
	Vcl::Actnlist::TAction* CheckAllAction;
	Vcl::Actnlist::TAction* UncheckAllAction;
	Vcl::Actnlist::TAction* OptionsAction;
	Vcl::Menus::TPopupMenu* PopupMenu;
	Vcl::Menus::TMenuItem* CheckAll1;
	Vcl::Menus::TMenuItem* UncheckAll1;
	Vcl::Menus::TMenuItem* Options1;
	Vcl::Actnlist::TAction* CheckAction;
	Vcl::Actnlist::TAction* UncheckAction;
	Vcl::Actnlist::TAction* UncheckUnsopportedAction;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* Uncheckallwitherrors1;
	Vcl::Actnlist::TAction* ExpandAction;
	Vcl::Actnlist::TAction* CollapseAction;
	Vcl::Menus::TMenuItem* Expand1;
	Vcl::Menus::TMenuItem* Collapse1;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Comctrls::TStatusBar* StatusBar;
	Vcl::Actnlist::TAction* ExpandAllAction;
	Vcl::Actnlist::TAction* CollapseAllAction;
	Vcl::Menus::TMenuItem* ExpandAll1;
	Vcl::Menus::TMenuItem* CollapseAll1;
	Vcl::Actnlist::TAction* GenerateAction;
	Vcl::Menus::TMenuItem* N4;
	Vcl::Comctrls::TToolButton* ToolButton7;
	Vcl::Extctrls::TPanel* DetailsPanel;
	Vcl::Extctrls::TSplitter* Splitter3;
	Vcl::Stdctrls::TGroupBox* DetailsGroupBox;
	Vcl::Stdctrls::TMemo* ToStringMemo;
	Vcl::Extctrls::TPanel* ConstDetails;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* ConstTypeEdit;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Extctrls::TSplitter* DocErrorsSplitter;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Actnlist::TAction* SetConstTypeAction;
	Vcl::Menus::TMenuItem* Setconstantstype1;
	Vcl::Actnlist::TAction* ApplyHintsAction;
	Vcl::Menus::TMenuItem* Applyallhints1;
	void __fastcall TreeViewGetImageIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall DocErrorsListBoxDblClick(System::TObject* Sender);
	void __fastcall TreeViewClick(System::TObject* Sender);
	void __fastcall TreeViewChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeViewDblClick(System::TObject* Sender);
	void __fastcall CheckAllActionUpdate(System::TObject* Sender);
	void __fastcall CheckAllActionExecute(System::TObject* Sender);
	void __fastcall UncheckAllActionUpdate(System::TObject* Sender);
	void __fastcall UncheckAllActionExecute(System::TObject* Sender);
	void __fastcall OptionsActionUpdate(System::TObject* Sender);
	void __fastcall OptionsActionExecute(System::TObject* Sender);
	void __fastcall CheckActionUpdate(System::TObject* Sender);
	void __fastcall CheckActionExecute(System::TObject* Sender);
	void __fastcall UncheckActionUpdate(System::TObject* Sender);
	void __fastcall UncheckActionExecute(System::TObject* Sender);
	void __fastcall UncheckUnsopportedActionUpdate(System::TObject* Sender);
	void __fastcall UncheckUnsopportedActionExecute(System::TObject* Sender);
	void __fastcall ExpandActionUpdate(System::TObject* Sender);
	void __fastcall ExpandActionExecute(System::TObject* Sender);
	void __fastcall CollapseActionUpdate(System::TObject* Sender);
	void __fastcall CollapseActionExecute(System::TObject* Sender);
	void __fastcall ExpandAllActionUpdate(System::TObject* Sender);
	void __fastcall ExpandAllActionExecute(System::TObject* Sender);
	void __fastcall CollapseAllActionUpdate(System::TObject* Sender);
	void __fastcall CollapseAllActionExecute(System::TObject* Sender);
	void __fastcall GenerateActionUpdate(System::TObject* Sender);
	void __fastcall GenerateActionExecute(System::TObject* Sender);
	void __fastcall ConstTypeEditChange(System::TObject* Sender);
	void __fastcall TreeViewChanging(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowChange);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall TreeViewKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall ToStringMemoKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SetConstTypeActionUpdate(System::TObject* Sender);
	void __fastcall SetConstTypeActionExecute(System::TObject* Sender);
	void __fastcall ApplyHintsActionUpdate(System::TObject* Sender);
	void __fastcall ApplyHintsActionExecute(System::TObject* Sender);
	
private:
	Toolsapi::_di_IOTASourceEditor FEditor;
	_di_ILMDUnitFrameTraits FTraits;
	Toolsapi::_di_IOTAModuleNotifier FIDENotifier;
	int FIDENotifierIdx;
	Lmdsctimporterunitdoc::TLMDUnitDocument* FDocument;
	Lmdsctimporterunitdoc::ILMDUnitDocNotifier* FDocNotifier;
	Lmdsctimporterunitdoc::ILMDUnitDocSourceProvider* FSourceProvider;
	Lmdsctimportertree::TLMDPasNamedNode* FDetailsNode;
	System::Classes::TStringList* FExpandedNodes;
	System::UnicodeString FSelectedNode;
	System::UnicodeString FTopNode;
	bool FUpdatingDetails;
	bool FImporting;
	MESSAGE void __fastcall WMInitialParse(Winapi::Messages::TMessage &M);
	void __fastcall SetTraits(const _di_ILMDUnitFrameTraits Value);
	System::UnicodeString __fastcall GetNodeVisualPath(Vcl::Comctrls::TTreeNode* ANode);
	
protected:
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall DestroyHandle(void);
	void __fastcall FillTree(void);
	Vcl::Comctrls::TTreeNode* __fastcall AddTreeNode(Vcl::Comctrls::TTreeNode* AParent, const System::UnicodeString S, Lmdsctimportertree::TLMDPasNamedNode* AData);
	int __fastcall GetNodeImage(Lmdsctimportertree::TLMDPasTreeNode* APasNode);
	void __fastcall SaveExpandedState(void);
	void __fastcall RestoreExpandedState(void);
	Vcl::Comctrls::TTreeNode* __fastcall GetViewNode(Lmdsctimportertree::TLMDPasTreeNode* APasNode);
	Lmdsctimportertree::TLMDPasTreeNode* __fastcall GetPasNode(Vcl::Comctrls::TTreeNode* AViewNode);
	void __fastcall UpdateTreeStates(void);
	void __fastcall UpdateNodeState(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall UpdateTree(void);
	void __fastcall UpdateNodeErrors(void);
	void __fastcall UpdateStatusBar(void);
	void __fastcall UpdateDetails(void);
	void __fastcall UpdateCaption(void);
	void __fastcall UpdateAll(void);
	void __fastcall FlushDetails(void);
	void __fastcall ReportDocMessages(void);
	bool __fastcall Parse(void);
	bool __fastcall Analize(bool GenWrapperFile);
	void __fastcall CheckAll(bool AIsCheck);
	void __fastcall UncheckAllUnsupported(void);
	void __fastcall SetStatusText(const System::UnicodeString S);
	void __fastcall SetStateText(const System::UnicodeString S);
	
public:
	__fastcall TLMDUnitFrame(System::Classes::TComponent* AOwner, Toolsapi::_di_IOTASourceEditor AEditor);
	__fastcall virtual ~TLMDUnitFrame(void);
	void __fastcall Select(Lmdsctimportertree::TLMDPasTreeNode* ANode)/* overload */;
	void __fastcall QueryInitialParse(void);
	__property Toolsapi::_di_IOTASourceEditor Editor = {read=FEditor};
	__property _di_ILMDUnitFrameTraits Traits = {read=FTraits, write=SetTraits};
	__property Lmdsctimporterunitdoc::TLMDUnitDocument* Document = {read=FDocument};
	__property Caption = {default=0};
	__classmethod TLMDUnitFrame* __fastcall FindWizard(Toolsapi::_di_IOTASourceEditor AEditor);
	__classmethod TLMDUnitFrame* __fastcall GetWizard(Toolsapi::_di_IOTASourceEditor AEditor);
	__classmethod void __fastcall CloseAllWizards();
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDUnitFrame(HWND ParentWindow) : Vcl::Forms::TFrame(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_INITIALPARSE = System::Word(0x401);
}	/* namespace Lmdsctunitframe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTUNITFRAME)
using namespace Lmdsctunitframe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctunitframeHPP
