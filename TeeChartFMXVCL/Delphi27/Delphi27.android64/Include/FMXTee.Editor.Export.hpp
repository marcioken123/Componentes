// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Export.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_ExportHPP
#define Fmxtee_Editor_ExportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Memo.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.ScrollBox.hpp>
#include <FMX.EditBox.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.ComboEdit.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.RadioGroup.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Export
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeExportFormat;
class DELPHICLASS TExportEditor;
class DELPHICLASS TTeeExportFormats;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeExportFormat : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	int Tag;
	int FFilterIndex;
	__classmethod Fmx::Listbox::TListBoxItem* __fastcall AddItem(Fmx::Listbox::TListBox* const AList, const System::UnicodeString AText, TTeeExportFormat* const AFormat);
	__classmethod virtual void __fastcall AddSubFormats(Fmxtee::Procs::TCustomTeePanel* const APanel, Fmx::Listbox::TListBox* const AList, int &FilterIndex);
	void __fastcall CheckSize()/* overload */;
	void __fastcall CheckSize(int Width, int Height)/* overload */;
	Fmx::Forms::TForm* __fastcall CreateProperties(const System::UnicodeString AFormClass);
	virtual void __fastcall DoCopyToClipboard() = 0 ;
	
public:
	Fmxtee::Procs::TCustomTeePanel* Panel;
	int Height;
	int Width;
	__fastcall virtual TTeeExportFormat();
	void __fastcall CopyToClipboard();
	virtual System::UnicodeString __fastcall Description() = 0 ;
	virtual Fmx::Forms::TForm* __fastcall Editor(System::Classes::TComponent* AOwner);
	virtual System::UnicodeString __fastcall FileExtension();
	virtual __classmethod System::UnicodeString __fastcall FileFilter() = 0 ;
	virtual int __fastcall FileFilterIndex();
	virtual void __fastcall IncFileFilterIndex(int &FilterIndex);
	void __fastcall SaveToFile(const System::UnicodeString FileName)/* overload */;
	void __fastcall SaveToFile(const System::UnicodeString FileName, Fmx::Forms::TForm* const AOptions)/* overload */;
	__classmethod void __fastcall SaveToFile(Fmxtee::Procs::TCustomTeePanel* const APanel, const System::UnicodeString FileName)/* overload */;
	__classmethod virtual void __fastcall SaveToFile(Fmxtee::Procs::TCustomTeePanel* APanel, const System::UnicodeString FileName, Fmx::Forms::TForm* const AOptions, int AWidth, int AHeight)/* overload */;
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream) = 0 /* overload */;
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream, Fmx::Forms::TForm* const AOptions)/* overload */;
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTeeExportFormat() { }
	
};


class PASCALIMPLEMENTATION TExportEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
	
private:
	typedef System::DynamicArray<TTeeExportFormat*> _TExportEditor__1;
	
	
__published:
	Fmx::Tabcontrol::TTabControl* PageControlType;
	Fmx::Tabcontrol::TTabItem* TabPicture;
	Fmx::Stdctrls::TSplitter* SplitPic;
	Fmx::Stdctrls::TGroupBox* RGFormat;
	Fmx::Listbox::TListBox* LBFormat;
	Fmx::Tabcontrol::TTabControl* PageOptions;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabSize;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* LabelPicSize;
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Spinbox::TSpinBox* UDHeight;
	Fmx::Stdctrls::TCheckBox* CBAspect;
	Fmx::Stdctrls::TCheckBox* CBPicSize;
	Fmx::Tabcontrol::TTabItem* TabNative;
	Fmx::Stdctrls::TLabel* LabelSize;
	Fmx::Stdctrls::TCheckBox* CBNativeData;
	Fmx::Stdctrls::TCheckBox* CBFileSize;
	Fmx::Stdctrls::TButton* BViewNative;
	Fmx::Tabcontrol::TTabItem* TabData;
	Fmx::Stdctrls::TPanel* Panel4;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Stdctrls::TPanel* Panel5;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBSeries;
	Fmx::Stdctrls::TCheckBox* CBDataPreview;
	Fmx::Stdctrls::TPanel* Panel3;
	Fmx::Tabcontrol::TTabControl* PageDataOptions;
	Fmx::Tabcontrol::TTabItem* TabInclude;
	Fmx::Stdctrls::TCheckBox* CBIndex;
	Fmx::Stdctrls::TCheckBox* CBLabels;
	Fmx::Stdctrls::TCheckBox* CBHeader;
	Fmx::Stdctrls::TCheckBox* CBColors;
	Fmx::Tabcontrol::TTabItem* TabDataOptions;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* LabelEncoding;
	Fmx::Stdctrls::TLabel* LabelXML;
	Fmx::Listbox::TComboBox* CBDelim;
	Fmx::Edit::TEdit* ECustom;
	Fmx::Edit::TEdit* EQuotes;
	Fmx::Listbox::TComboBox* CBEncoding;
	Fmx::Listbox::TComboBox* CBXMLEncoding;
	Fmx::Stdctrls::TPanel* PanelPreview;
	Fmx::Memo::TMemo* MemoData;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TButton* BCopy;
	Fmx::Stdctrls::TButton* BSave;
	Fmx::Stdctrls::TPanel* PanelClose;
	Fmx::Stdctrls::TButton* BClose;
	Fmx::Stdctrls::TButton* BPreview;
	Fmxtee::Radiogroup::TRadioGroup* RGNativeFormat;
	Fmxtee::Radiogroup::TRadioGroup* RGDataFormat;
	Fmx::Dialogs::TSaveDialog* SaveDialogPicture;
	Fmx::Dialogs::TSaveDialog* SaveDialogNative;
	Fmx::Dialogs::TSaveDialog* SaveDialogData;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Stdctrls::TCheckBox* CBUseSeriesFormat;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TButton* BFormat;
	Fmx::Comboedit::TComboEdit* SeriesValueFormat;
	Fmx::Stdctrls::TRadioButton* RBJSON;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall PageControlTypeChange(System::TObject* Sender);
	void __fastcall PageOptionsChange(System::TObject* Sender);
	void __fastcall BViewNativeClick(System::TObject* Sender);
	void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall CBDelimChange(System::TObject* Sender);
	void __fastcall CBXMLEncodingChange(System::TObject* Sender);
	void __fastcall BCopyClick(System::TObject* Sender);
	void __fastcall BSaveClick(System::TObject* Sender);
	void __fastcall BPreviewClick(System::TObject* Sender);
	void __fastcall LBFormatChange(System::TObject* Sender);
	void __fastcall RGTextFormatChange(System::TObject* Sender);
	void __fastcall RGDataFormatChange(System::TObject* Sender);
	void __fastcall UDHeightChangeTracking(System::TObject* Sender);
	void __fastcall CBNativeDataChange(System::TObject* Sender);
	void __fastcall CBFileSizeChange(System::TObject* Sender);
	void __fastcall CBDataPreviewChange(System::TObject* Sender);
	void __fastcall CBIndexChange(System::TObject* Sender);
	void __fastcall CBLabelsChange(System::TObject* Sender);
	void __fastcall CBHeaderChange(System::TObject* Sender);
	void __fastcall CBColorsChange(System::TObject* Sender);
	void __fastcall CBUseSeriesFormatChange(System::TObject* Sender);
	void __fastcall BFormatClick(System::TObject* Sender);
	void __fastcall SeriesValueFormatChangeTracking(System::TObject* Sender);
	void __fastcall CBPicSizeChange(System::TObject* Sender);
	void __fastcall ECustomTyping(System::TObject* Sender);
	void __fastcall EQuotesTyping(System::TObject* Sender);
	
private:
	Fmxtee::Chart::TCustomChart* Chart;
	bool ChangingSize;
	Fmx::Forms::TCommonCustomForm* FLastForm;
	float IAspect;
	_TExportEditor__1 IFormats;
	bool __fastcall CanChangeSize();
	void __fastcall CheckFileSize();
	System::UnicodeString __fastcall CreateTempFile();
	void __fastcall EnableButtons();
	int __fastcall GetDataFilterIndex();
	System::UnicodeString __fastcall GetNativeExtension();
	System::UnicodeString __fastcall GetNativeFilter();
	System::WideChar __fastcall GetSeparator();
	TTeeExportFormat* __fastcall GuessPictureFormat(const System::UnicodeString FileName);
	System::UnicodeString __fastcall NativeAsString();
	bool __fastcall NativeAsText();
	TTeeExportFormat* __fastcall PictureFormat();
	void __fastcall RefreshChart(Fmxtee::Chart::TCustomChart* AChart);
	void __fastcall SaveDataToFile(const System::UnicodeString FileName);
	void __fastcall SaveNativeToFile(const System::UnicodeString FileName);
	void __fastcall SavePictureToFile(const System::UnicodeString FileName);
	System::Sysutils::TEncoding* __fastcall SelectedEncoding();
	void __fastcall TryPreviewData();
	
protected:
	Fmxtee::Procs::TTeeExportData* __fastcall CreateData();
	System::Classes::TStream* __fastcall CreateNativeStream();
	void __fastcall DoSaveNativeToFile(const System::UnicodeString FileName, bool IncludeData);
	bool __fastcall ExistData();
	
public:
	System::UnicodeString DataFilter;
	System::UnicodeString InitDir;
	System::UnicodeString NativeExtension;
	System::UnicodeString NativeFilter;
	__classmethod TExportEditor* __fastcall CreateEditor(System::Classes::TComponent* AOwner, Fmxtee::Chart::TCustomChart* AChart);
	__classmethod void __fastcall Edit(System::Classes::TComponent* AOwner, Fmxtee::Chart::TCustomChart* AChart);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TExportEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TExportEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TExportEditor() { }
	
};


_DECLARE_METACLASS(System::TMetaClass, TTeeExportFormatClass);

class PASCALIMPLEMENTATION TTeeExportFormats : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TTeeExportFormatClass> _TTeeExportFormats__1;
	
	
public:
	TTeeExportFormatClass operator[](int Index) { return this->Format[Index]; }
	
private:
	_TTeeExportFormats__1 IList;
	TTeeExportFormatClass __fastcall Get(int Index);
	
public:
	__fastcall virtual ~TTeeExportFormats();
	__classmethod void __fastcall RegisterFormat(TTeeExportFormatClass AFormat);
	__classmethod void __fastcall UnRegisterFormat(TTeeExportFormatClass AFormat);
	void __fastcall Add(TTeeExportFormatClass AFormat);
	int __fastcall Count();
	void __fastcall Remove(TTeeExportFormatClass AFormat);
	__property TTeeExportFormatClass Format[int Index] = {read=Get/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TTeeExportFormats() : System::TObject() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TTeeExportFormats* __fastcall TeeExportFormats(void);
}	/* namespace Export */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_EXPORT)
using namespace Fmxtee::Editor::Export;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR)
using namespace Fmxtee::Editor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Editor_ExportHPP
