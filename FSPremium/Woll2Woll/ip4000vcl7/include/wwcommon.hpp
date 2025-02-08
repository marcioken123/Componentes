// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwcommon.pas' rev: 6.00

#ifndef WwcommonHPP
#define WwcommonHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Registry.hpp>	// Pascal unit
#include <BDE.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <wwstorep.hpp>	// Pascal unit
#include <Wwlocate.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwcommon
{
//-- type declarations -------------------------------------------------------
typedef AnsiString wwSmallString;

//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwcommon)
#define WW_DB_COMBO "Combo"
#define WW_DB_LOOKUP_COMBO "LookupCombo"
#define WW_DB_EDIT "CustomEdit"
#define WW_DB_RICHEDIT "RichEdit"
extern PACKAGE Wwtypes::TwwInvalidValueEvent __fastcall wwGetOnInvalidValue(Db::TDataSet* DataSet);
extern PACKAGE Wwtypes::TwwPerformSearchEvent __fastcall wwGetOnPerformCustomSearch(Classes::TComponent* Component);
extern PACKAGE System::TMethod __fastcall wwGetCalcCellColorsEvent(Controls::TWinControl* Grid);
extern PACKAGE Classes::TComponent* __fastcall wwGetPictureControl(Classes::TComponent* Control, Db::TDataSet* DataSet = (Db::TDataSet*)(0x0));
extern PACKAGE Classes::TComponent* __fastcall wwGetControlTypeControl(Classes::TComponent* Control, Db::TDataSet* DataSet = (Db::TDataSet*)(0x0));
extern PACKAGE Classes::TStrings* __fastcall wwGetStrings(Classes::TComponent* Component, AnsiString PropertyName);
extern PACKAGE Classes::TStrings* __fastcall wwGetPictureMasks(Classes::TComponent* DataSet);
extern PACKAGE Classes::TStrings* __fastcall wwGetControlType(Classes::TComponent* dataSet);
extern PACKAGE int __fastcall wwGetCommandType(Db::TDataSet* DataSet);
extern PACKAGE int __fastcall wwGetDatabaseCursorType(Db::TDataSet* DataSet);
extern PACKAGE bool __fastcall wwSetDatabaseCursorType(Db::TDataSet* DataSet, int val);
extern PACKAGE bool __fastcall wwSetDatabaseMaxRecords(Db::TDataSet* DataSet, int val);
extern PACKAGE bool __fastcall wwGetValidateWithMask(Db::TDataSet* dataSet);
extern PACKAGE bool __fastcall wwGetControlInfoInDataSet(Classes::TComponent* component);
extern PACKAGE bool __fastcall wwGetPictureMaskFromDataSet(Classes::TComponent* Component);
extern PACKAGE Classes::TStrings* __fastcall wwGetLookupFields(Db::TDataSet* dataSet);
extern PACKAGE Classes::TStrings* __fastcall wwGetLookupLinks(Db::TDataSet* dataSet);
extern PACKAGE AnsiString __fastcall wwDataSetGetLinks(Db::TDataSet* dataSet, AnsiString lookupFieldName);
extern PACKAGE AnsiString __fastcall wwDataSetGetDisplayField(Db::TDataSet* dataSet, AnsiString lookupFieldName);
extern PACKAGE AnsiString __fastcall wwGetDatabaseName(Db::TDataSet* dataSet);
extern PACKAGE Classes::TComponent* __fastcall wwGetConnection(Db::TDataSet* dataSet);
extern PACKAGE AnsiString __fastcall wwGetConnectionString(Db::TDataSet* dataSet);
extern PACKAGE Classes::TComponent* __fastcall wwGetIBDatabase(Db::TDataSet* dataSet);
extern PACKAGE bool __fastcall wwSetIBDatabase(Db::TDataSet* Dataset, Classes::TComponent* db);
extern PACKAGE bool __fastcall wwGetAlwaysTransparent(Controls::TControl* ctrl);
extern PACKAGE AnsiString __fastcall wwGetTableName(Db::TDataSet* dataSet);
extern PACKAGE bool __fastcall wwDataSetIsValidField(Classes::TComponent* dataset, AnsiString fieldName);
extern PACKAGE void __fastcall wwDataSetUpdateFieldProperties(Db::TDataSet* dataSet, Classes::TStrings* selected);
extern PACKAGE bool __fastcall wwDataSet(Db::TDataSet* dataSet);
extern PACKAGE void __fastcall wwDebug(AnsiString s);
extern PACKAGE bool __fastcall wwDataSetLookupDisplayField(Db::TField* curField, AnsiString &LookupValue, Db::TField* &DisplayField);
extern PACKAGE bool __fastcall wwDoLookupTable(Dbtables::TTable* ALookupTable, Db::TDataSet* DataSet, Classes::TStrings* links);
extern PACKAGE bool __fastcall wwisNonBDEField(Db::TField* thisField);
extern PACKAGE bool __fastcall wwisNonPhysicalField(Db::TField* thisField);
extern PACKAGE void __fastcall wwConvertFieldToParam(Db::TField* OtherField, Db::TParam* &AFilterParam, char * AFilterFieldBuffer);
extern PACKAGE Db::TField* __fastcall wwDataSet_GetFilterLookupField(Db::TDataSet* dataSet, Db::TField* curfield, const System::TMethod &AMethod);
extern PACKAGE bool __fastcall wwSetLookupField(Db::TDataSet* dataSet, Db::TField* linkedField);
extern PACKAGE void __fastcall wwDataSetDoOnCalcFields(Db::TDataSet* dataSet, Classes::TStrings* FLookupFields, Classes::TStrings* FLookupLinks, Classes::TList* lookupTables);
extern PACKAGE bool __fastcall wwDataSetSyncLookupTable(Db::TDataSet* dataSet, Db::TDataSet* AlookupTable, AnsiString lookupFieldName, AnsiString &fromField);
extern PACKAGE void __fastcall wwDataSet_GetControl(Classes::TComponent* dataSet, AnsiString AFieldName, AnsiString &AControlType, AnsiString &AParameters);
extern PACKAGE void __fastcall wwDataSetRemoveObsolete(Classes::TComponent* dataSet, Classes::TStrings* FLookupFields, Classes::TStrings* FLookupLinks, Classes::TStrings* FControlType);
extern PACKAGE void __fastcall wwDataSet_SetControl(Classes::TComponent* dataSet, AnsiString AFieldName, AnsiString AComponentType, AnsiString AParameters);
extern PACKAGE bool __fastcall wwFieldIsValidValue(Db::TField* fld, AnsiString key);
extern PACKAGE bool __fastcall wwFieldIsValidLocateValue(Db::TField* fld, AnsiString key);
extern PACKAGE bool __fastcall wwIsValidValue(Db::TFieldType FldType, AnsiString key);
extern PACKAGE bool __fastcall wwTableFindNearest(Db::TDataSet* dataSet, AnsiString key, int FieldNo);
extern PACKAGE void __fastcall wwTableChangeIndex(Db::TDataSet* dataSet, Db::TIndexDef* a_indexItem);
extern PACKAGE AnsiString __fastcall wwGetAlias(AnsiString aliasName);
extern PACKAGE bool __fastcall wwSaveAnswerTable(Dbtables::TDBDataSet* ADataSet, Bde::hDBICur AHandle, AnsiString tableName);
extern PACKAGE bool __fastcall wwInPaintCopyState(Controls::TControlState ControlState);
extern PACKAGE void __fastcall wwPlayKeystroke(HWND Handle, Word VKChar, Word VKShift);
extern PACKAGE void __fastcall wwClearAltChar(void);
extern PACKAGE char * __fastcall wwGetQueryText(Classes::TStrings* tempQBE, bool Sql);
extern PACKAGE bool __fastcall wwMemAvail(int memSize);
extern PACKAGE void __fastcall wwPictureByField(Classes::TComponent* DataSet, AnsiString FieldName, bool FromTable, AnsiString &Mask, bool &AutoFill, bool &UsePictureMask);
extern PACKAGE void __fastcall wwDataModuleChanged(Classes::TComponent* temp);
extern PACKAGE void __fastcall wwSetPictureMask(Classes::TComponent* dataSet, AnsiString AFieldName, AnsiString AMask, bool AutoFill, bool UsePictureMask, bool SetMask, bool SetAutoFill, bool SetUsePictureMask);
extern PACKAGE AnsiString __fastcall wwGetFieldNameFromTitle(Db::TDataSet* DataSet, AnsiString fieldTitle);
extern PACKAGE int __fastcall wwGetListIndex(Classes::TStrings* list, AnsiString itemName);
extern PACKAGE Forms::TCustomForm* __fastcall wwGetOwnerForm(Classes::TComponent* component);
extern PACKAGE Classes::TComponent* __fastcall wwGetOwnerFrameOrForm(Classes::TComponent* component);
extern PACKAGE bool __fastcall isWWEditControl(AnsiString pname);
extern PACKAGE void __fastcall wwDrawGlyph(Graphics::TBitmap* Bitmap, Graphics::TCanvas* Canvas, const Types::TRect &R, Buttons::TButtonState State, bool Enabled, bool Transparent, bool FlatButtonTransparent, Controls::TControlState ControlState);
extern PACKAGE void __fastcall wwDrawEllipsis(Graphics::TCanvas* Canvas, const Types::TRect &R, Buttons::TButtonState State, bool Enabled, bool Transparent, bool FlatButtonTransparent, Controls::TControlState ControlState);
extern PACKAGE void __fastcall wwDrawDropDownArrow(Graphics::TCanvas* Canvas, const Types::TRect &R, Buttons::TButtonState State, bool Enabled, Controls::TControlState ControlState);
extern PACKAGE bool __fastcall wwHasIndex(Db::TDataSet* ADataSet);
extern PACKAGE bool __fastcall wwIsTableQuery(Db::TDataSet* ADataSet);
extern PACKAGE AnsiString __fastcall wwPdxPictureMask(Db::TDataSet* ADataSet, AnsiString AFieldName);
extern PACKAGE void __fastcall wwFixMouseDown(void);
extern PACKAGE void __fastcall wwValidatePictureFields(Db::TDataSet* ADataSet, Wwtypes::TwwInvalidValueEvent FOnInvalidValue);
extern PACKAGE bool __fastcall wwDataSetFindRecord(Db::TDataSet* DataSet, AnsiString KeyValue, AnsiString LookupField, Wwlocate::TwwLocateMatchType MatchType, bool caseSensitive);
extern PACKAGE bool __fastcall wwValidFilterableFieldType(Db::TFieldType ADataType);
extern PACKAGE void __fastcall wwALinkHelp(HWND Handle, AnsiString ALink);
extern PACKAGE void __fastcall wwHelp(HWND Handle, char * HelpTopic);
extern PACKAGE bool __fastcall wwIsValidChar(Word key);
extern PACKAGE void __fastcall wwDataSet_SetLookupLink(Db::TDataSet* dataSet, AnsiString FldName, AnsiString DatabaseName, AnsiString TableName, AnsiString DisplayFld, AnsiString IndexFieldNames, AnsiString Links, char useExtension);
extern PACKAGE void __fastcall wwDataSetUpdateSelected(Db::TDataSet* dataSet, Classes::TStrings* selected);
extern PACKAGE bool __fastcall wwFindSelected(Classes::TStrings* selected, AnsiString FieldName, int &index);
extern PACKAGE int __fastcall wwAdjustPixels(int PixelSize, int PixelsPerInch);
extern PACKAGE void __fastcall wwSetOnFilterEnabled(Db::TDataSet* dataset, bool val);
extern PACKAGE Wwtypes::TwwOnFilterOptions __fastcall wwGetOnFilterOptions(Db::TDataSet* dataset);
extern PACKAGE bool __fastcall wwProcessEscapeFilterEvent(Db::TDataSet* dataset);
extern PACKAGE int __fastcall wwmax(int x, int y);
extern PACKAGE int __fastcall wwmin(int x, int y);
extern PACKAGE int __fastcall wwDataSetCompareBookmarks(Db::TDataSet* DataSet, void * Bookmark1, void * Bookmark2);
extern PACKAGE bool __fastcall wwIsClass(TMetaClass* ClassType, const AnsiString Name);
extern PACKAGE Types::TRect __fastcall wwGetWorkingRect();
extern PACKAGE bool __fastcall wwApplyPictureMask(Stdctrls::TCustomEdit* Control, AnsiString PictureMask, bool AutoFill, char &Key);
extern PACKAGE bool __fastcall wwValidPictureValue(Stdctrls::TCustomEdit* Control, AnsiString PictureMask);
extern PACKAGE bool __fastcall wwSetControlDataSet(Classes::TComponent* ctrl, Db::TDataSet* DataSet, AnsiString PropertyName);
extern PACKAGE bool __fastcall wwSetControlDataSource(Controls::TControl* ctrl, Db::TDataSource* ds);
extern PACKAGE bool __fastcall wwSetControlDataField(Controls::TControl* ctrl, AnsiString df);
extern PACKAGE AnsiString __fastcall wwGetControlDataField(Controls::TControl* ctrl);
extern PACKAGE Db::TDataSource* __fastcall wwGetControlDataSource(Classes::TComponent* ctrl);
extern PACKAGE Db::TDataSource* __fastcall wwGetControlMasterSource(Classes::TComponent* ctrl);
extern PACKAGE bool __fastcall wwSetBoolean(Classes::TComponent* ctrl, AnsiString PropertyName, bool val);
extern PACKAGE bool __fastcall wwSetRequestLive(Db::TDataSet* ctrl, bool val);
extern PACKAGE bool __fastcall wwSetReadOnly(Controls::TControl* ctrl, bool val);
extern PACKAGE bool __fastcall wwSetBorder(Controls::TControl* ctrl, bool val);
extern PACKAGE bool __fastcall wwGetBorder(Controls::TControl* ctrl);
extern PACKAGE bool __fastcall wwSetParamCheck(Db::TDataSet* ctrl, bool val);
extern PACKAGE bool __fastcall wwGetWantReturns(Controls::TControl* ctrl);
extern PACKAGE bool __fastcall wwGetParamCheck(Db::TDataSet* ctrl);
extern PACKAGE bool __fastcall wwSetConnection(Db::TDataSet* ctrl, Classes::TComponent* Connection);
extern PACKAGE bool __fastcall wwSetConnectionString(Db::TDataSet* ctrl, AnsiString df);
extern PACKAGE bool __fastcall wwSetDatabaseName(Db::TDataSet* ctrl, AnsiString df);
extern PACKAGE bool __fastcall wwSetString(Classes::TComponent* ctrl, AnsiString PropertyName, AnsiString s);
extern PACKAGE bool __fastcall wwSetSessionName(Db::TDataSet* ctrl, AnsiString df);
extern PACKAGE AnsiString __fastcall wwGetSessionName(Db::TDataSet* dataSet);
extern PACKAGE AnsiString __fastcall wwGetControlPictureMask(Stdctrls::TCustomEdit* ctrl);
extern PACKAGE void __fastcall wwSetControlPictureMask(Stdctrls::TCustomEdit* ctrl, AnsiString PictureMask);
extern PACKAGE bool __fastcall wwGetControlAutoFill(Stdctrls::TCustomEdit* ctrl);
extern PACKAGE void __fastcall wwSetControlAutoFill(Stdctrls::TCustomEdit* ctrl, bool AutoFill);
extern PACKAGE AnsiString __fastcall wwGetSQLWord(AnsiString s, int &APos);
extern PACKAGE bool __fastcall wwSetSQLProp(Db::TDataSet* ctrl, Classes::TStrings* sql, AnsiString PropName);
extern PACKAGE bool __fastcall wwSetParamsProp(Db::TDataSet* ctrl, Db::TParams* Params);
extern PACKAGE Db::TParams* __fastcall wwGetParamsProp(Db::TDataSet* ctrl);
extern PACKAGE bool __fastcall wwIsSingleLineEdit(HDC AHandle, const Types::TRect &Rect, int Flags);
extern PACKAGE int __fastcall wwCallbackMemoRead(Dbtables::TBDEDataSet* DataSet, void * FFilterBuffer, void *Buffer, Db::TField* curField, int Count);
extern PACKAGE bool __fastcall wwIsRichEditField(Db::TField* Field, bool ExamineData);
extern PACKAGE void __fastcall RichEditTextToPlainText(Controls::TWinControl* Owner, char * MemoBuffer, unsigned &numRead, Comctrls::TRichEdit* &RichEditControl, Classes::TMemoryStream* &MemoryStream);
extern PACKAGE void __fastcall wwDrawFocusRect(Graphics::TCanvas* ACanvas, const Types::TRect &ARect);
extern PACKAGE bool __fastcall UpdatedVCL4Version(void);
extern PACKAGE bool __fastcall wwIsCustomEditCell(Classes::TComponent* Component, Classes::TComponent* ownerForm, Db::TField* curField, Controls::TWinControl* &customEdit);
extern PACKAGE bool __fastcall IsInGrid(Controls::TWinControl* dtp);
extern PACKAGE bool __fastcall IsInGridPaint(Controls::TWinControl* dtp);
extern PACKAGE bool __fastcall IsInwwObjectViewPaint(Controls::TWinControl* control);
extern PACKAGE bool __fastcall IsInwwGridPaint(Controls::TWinControl* control);
extern PACKAGE bool __fastcall IsInwwObjectView(Controls::TWinControl* control);
extern PACKAGE void __fastcall wwDottedLine(Graphics::TCanvas* Canvas, const Types::TPoint &p1, const Types::TPoint &p2);
extern PACKAGE void __fastcall wwSetTableIndex(Db::TDataSet* DataSet, AnsiString FieldName);
extern PACKAGE void __fastcall wwWriteTextLinesT(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, int DX, int DY, char * S, Classes::TAlignment Alignment, Wwtypes::TwwWriteTextOptions WriteOptions);
extern PACKAGE int __fastcall wwRectWidth(const Types::TRect &Rect);
extern PACKAGE int __fastcall wwRectHeight(const Types::TRect &Rect);
extern PACKAGE void __fastcall wwDisableParentClipping(Controls::TWinControl* Parent);
extern PACKAGE bool __fastcall wwIsDesigning(Controls::TControl* control);
extern PACKAGE bool __fastcall wwHaveVisibleChild(Controls::TWinControl* ac);
extern PACKAGE int __fastcall wwGetEventShift(Classes::TShiftState Shift);
extern PACKAGE int __fastcall wwlimit(int val, int x, int y);
extern PACKAGE void __fastcall wwClearControls(Classes::TComponent* Component);
extern PACKAGE void __fastcall wwcopyToClipBoard(const AnsiString str, const AnsiString htmlStr = "");
extern PACKAGE int __fastcall wwGetOrdProp(Classes::TPersistent* Component, AnsiString PropName);
extern PACKAGE bool __fastcall wwGetEditCalculated(Controls::TControl* ctrl);
extern PACKAGE bool __fastcall wwUseThemes(Controls::TControl* Control);

}	/* namespace Wwcommon */
using namespace Wwcommon;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwcommon
