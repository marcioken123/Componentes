//---------------------------------------------------------------------------

#ifndef EditorsStylesDemoStylesPaletteH
#define EditorsStylesDemoStylesPaletteH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxContainer.hpp"
#include "cxControls.hpp"
#include "cxEdit.hpp"
#include "cxMemo.hpp"
#include "cxPropertiesStore.hpp"
#include "cxTextEdit.hpp"
#include "EditorsStylesDemoBase.h"
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include "cxCheckComboBox.hpp"
#include "cxCheckListBox.hpp"
#include "cxColorComboBox.hpp"
#include "cxDropDownEdit.hpp"
#include "cxFontNameComboBox.hpp"
#include "cxGroupBox.hpp"
#include "cxHeader.hpp"
#include "cxLabel.hpp"
#include "cxMaskEdit.hpp"
#include "cxProgressBar.hpp"
#include "cxRadioGroup.hpp"
#include "cxSpinButton.hpp"
#include "cxSpinEdit.hpp"
#include "cxTrackBar.hpp"
#include <ImgList.hpp>
#include "Graphics.hpp"
#include <ComCtrls.hpp>
#include "cxCalc.hpp"
#include "cxCalendar.hpp"
#include "cxCheckBox.hpp"
#include "cxClasses.hpp"
#include "cxEditRepositoryItems.hpp"
#include "cxExtEditRepositoryItems.hpp"
#include "cxGrid.hpp"
#include "cxGridCustomTableView.hpp"
#include "cxGridCustomView.hpp"
#include "cxGridLevel.hpp"
#include "cxGridTableView.hpp"
#include "cxStyles.hpp"
//---------------------------------------------------------------------------
enum TValueColumnType {vctBorderColor, vctBorderStyle, vctColor,
  vctTextColor, vctTextStyle};

class TEditorsStylesDemoStylesPaletteFrame : public TEditorsStylesDemoBaseFrame
{
__published:	// IDE-managed Components
  TcxGroupBox *gbEditors;
  TcxProgressBar *cxProgressBar;
  TcxTrackBar *cxTrackBar;
  TcxCheckListBox *cxCheckListBox;
  TcxColorComboBox *cxColorComboBox;
  TcxCheckComboBox *cxCheckComboBox;
  TcxFontNameComboBox *cxFontNameComboBox;
  TcxLabel *cxCoolLabel;
  TcxLabel *lbCheckListBox;
  TcxLabel *lbFontNameComboBox;
  TcxLabel *lbDateEdit;
  TcxLabel *lbTrackBar;
  TcxLabel *lbProgressBar;
  TcxLabel *lbSpinEdit;
  TcxLabel *lbCalcEdit;
  TcxLabel *lbColorComboBox;
  TcxCalcEdit *cxCalcEdit;
  TcxDateEdit *cxDateEdit;
  TcxLabel *lbCheckComboBox;
  TcxSpinEdit *cxSpinEdit;
  TcxCheckBox *cbDisableEditors;
  TcxGroupBox *pnlStyle;
  TcxGrid *Grid;
  TcxGridTableView *tvStyles;
  TcxGridColumn *clnStyleCategory;
  TcxGridColumn *clnStyleValueName;
  TcxGridColumn *clnStyleValue;
  TcxGridLevel *lvStyles;
  TcxLabel *cxLabel1;
  TPanel *Panel;
  TcxRadioGroup *rgColorPalette;
  TcxRadioGroup *rgLookAndFeel;
  TImageList *ilForegroundBitmaps;
  TImageList *ilCheckGlyphs;
  TcxEditRepository *cxEditRepository1;
  TcxEditRepositoryImageComboBoxItem *eriBorderStyle;
  TcxEditRepositoryColorComboBox *eriColor;
  TcxEditRepositoryCheckComboBox *eriTextStyle;
  TcxStyleRepository *cxStyleRepository1;
  TcxStyle *cxStyle1;
  void __fastcall rgStylesPropertiesChange(TObject *Sender);
  void __fastcall rgLookAndFeelPropertiesChange(TObject *Sender);
  void __fastcall cxTrackBarPropertiesDrawThumb(TObject *Sender,
          TcxCanvas *ACanvas, const TRect &ARect);
  void __fastcall cxTrackBarPropertiesGetThumbRect(TObject *Sender,
          TRect &ARect);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall clnStyleValueGetProperties(
          TcxCustomGridTableItem *Sender, TcxCustomGridRecord *ARecord,
          TcxCustomEditProperties *&AProperties);
  void __fastcall StyleValueColumnPropertiesEditValueChanged(TObject *Sender);
  void __fastcall cbDisableEditorsClick(TObject *Sender);
private:	// User declarations
  Graphics::TBitmap* FBitmap;
  void __fastcall SetProgressBarBitmap(TcxStyleSheetType AStyleSheetType, TcxProgressBar* AProgressBar);
  void __fastcall AdjustTrackBarThumb(TcxStyleSheetType AStyleSheetType, TcxTrackBar* ATrackBar, Graphics::TBitmap* ABitmap);
  void __fastcall AdjustCheckListGlyphs(TcxStyleSheetType AStyleSheetType, TcxCheckListBox* ACheckListBox);
  int __fastcall GetStyleStartRecordIndex(TcxContainerStateItem AStyleState);
  TcxContainerStateItem __fastcall GetStyleStateByRecordIndex(int ARecordIndex);
  Variant __fastcall  GetStyleValue(TcxCustomContainerStyle *AStyle,
    TValueColumnType AValueColumnType);
  void __fastcall SetStyleValue(TcxCustomContainerStyle *AStyle,
    TValueColumnType AValueColumnType, Variant Value);
  void __fastcall InitRecords();
  void __fastcall InitStyleRecords(TcxCustomContainerStyle *AStyle);
  void __fastcall InitStylesView(TcxEditStyleController *AStyleController);
public:		// User declarations
  __fastcall TEditorsStylesDemoStylesPaletteFrame(TComponent* Owner);
  __fastcall ~TEditorsStylesDemoStylesPaletteFrame();
  void ChangeDisplayStyle(TcxStyleSheetType ADisplayStyle);
  String __fastcall Name();
  String __fastcall BriefName();
  String Description();
  String StylesIniPath();
};
//---------------------------------------------------------------------------
extern PACKAGE TEditorsStylesDemoStylesPaletteFrame *EditorsStylesDemoStylesPaletteFrame;
//---------------------------------------------------------------------------
#endif
