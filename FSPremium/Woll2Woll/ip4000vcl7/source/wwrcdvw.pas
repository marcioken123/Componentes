unit wwrcdvw;
{
//
// Components : TwwRecordViewDialog
//
// Copyright (c) 1997-2001 by Woll2Woll Software
//
// 7/19/97 - Don't show cancel button in memodialog if readonly
// 7/21/97 - Assign memo fields displaylabel property to memodialog caption
// 7/29/97 - Limit length to field size for auto-created TwwDBEdits
// 1/24/98 - Set label's focus control to control for field
// 8/27/98 - Support TDBImage for ftGraphic fields
// 9/25/98 - MaximizeMemoWidth property now maximizes all blob types
// 10/12/98 - Hadn't checked if nil and got AV's.  -ksw (10/12/98)
// 1/31/99  - Avoid access violation on keydown whenAll fields are reaonly
// 4/9/99 - Resize navigator
// 4/27/99 - Memo fields should not be maximized if rvoMaximizeMemoWidth is false
// 5/19/99 - Memo fields should not be maximized if rvoMaximizeMemoWidth is false (Vertical Display )
// 5/20/99 - Recognize width change in OnAfterCreateControl event
// 6/4/99 -  Honor ReadOnly in checkbox
// 10/5/2000  Fix design-time delete problem with record-view component
// 4/22/02 - Honor OnEnter and OnExit in checkboxes
}

interface

{$i wwIfDef.pas}

uses classes, messages, db, dbtables, forms, wwdbedit, wwdatsrc, stdctrls, extctrls, controls,
     wwcommon, dbctrls, winprocs, wintypes, graphics, wwstr, wwtypes, dialogs, menus,
     sysutils,wwintl, buttons, typinfo, wwmemo, wwDBNavigator,
     wwriched, wwdblook, wwDBDateTimePicker, wwDialog,
     wwframe, wwradiogroup;

type
  TwwRecordViewForm = class(TForm)
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    Deactivated: boolean;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    { Public declarations }
     DlgComponent: TComponent;
     RecordPanel, NavigatorPanel, ButtonPanel: TPanel;
     Navigator: TwwDBNavigator;  { -ksw (6/17/98) }
     ScrollBox: TScrollBox;
  end;


  TwwRecordViewStyle = (rvsVertical, rvsHorizontal);
  TwwRecordViewOption = (rvoHideReadOnly, rvoHideCalculated, rvoHideNavigator, rvoUseCustomControls,
                         rvoShortenEditBox, rvoModalForm, rvoStayOnTopForm, rvoConsistentEditWidth,
                         rvoEnterToTab, rvoConfirmCancel,
                         rvoCloseIsCancel, rvoMaximizeMemoWidth,
                         rvoSetControlMinWidth, rvoUseDateTimePicker,
                         rvoLabelsBeneathControl);
  TwwRecordViewOptions = Set of TwwRecordViewOption;

  TwwRecordViewControlOption = (rvcTransparentLabels,
                         rvcTransparentButtons, rvcFlatButtons);
  TwwRecordViewControlOptions = Set of TwwRecordViewControlOption;

  TwwRecordViewOKCancelOption = (rvokShowOKCancel, rvokAutoPostRec, rvokAutoCancelRec);
  TwwRecordViewOKCancelOptions = Set of TwwRecordViewOKCancelOption;

  TwwCloseAction = (rvcOK,rvcCancel,rvcControlMenuClose);
  TwwCloseActions = Set of TwwCloseAction;
  TwwCancelEvent = Procedure(Form: TForm; var CanClose: boolean) of object;

  TwwOnBeforeCreateControlEvent =
     procedure(Form: TwwRecordViewForm; curField: TField; var Accept: boolean) of object;
  TwwOnAfterCreateControlEvent =
     procedure(Form: TwwRecordViewForm; curField: TField; Control: TControl) of object;
  TwwOnSetControlEffectsEvent =
     procedure(Form: TwwRecordViewForm; curField: TField; Control: TControl;
        Frame: TwwEditFrame; ButtonEffects: TwwButtonEffects) of object;
  TwwOnInitFormEvent = procedure(Form: TwwRecordViewForm) of object;
  TwwRecordCustomPaintEvent = procedure(Sender: TScrollBox; Canvas: TCanvas) of object;

  TwwMargin = class(TPersistent)
  private
     FBottomOffset, FTopOffset, FLeftOffset, FRightOffset: integer;
     procedure SetLeftOffset(val: integer);
     procedure SetRightOffset(val: integer);
     procedure SetTopOffset(val: integer);
     procedure SetBottomOffset(val: integer);
  public
     Owner: TComponent;

  published
     property BottomOffset: integer read FBottomOffset write SetBottomOffset
        default 5;
     property TopOffset: integer read FTopOffset write SetTopOffset
        default 5;
     property LeftOffset: integer read FLeftOffset write SetLeftOffset
        default 5;
     property RightOffset: integer read FRightOffset write SetRightOffset
        default 5;
  end;

  TwwVertEditSpacing = class(TPersistent)
  private
     FBetweenLabelEdit, FBetweenRow: integer;
     procedure SetBetweenLabelEdit(val: integer);
     procedure SetBetweenRow(val: integer);
  public
     Owner: TComponent;
  published
     property BetweenLabelEdit: integer read FBetweenLabelEdit write SetBetweenLabelEdit
          default 5;
     property BetweenRow: integer read FBetweenRow write SetBetweenRow
          default 2;
  end;

  TwwHorzEditSpacing = class(TPersistent)
  private
     FBetweenLabelEdit, FBetweenEditsInRow, FBetweenRow, FLabelIndent: integer;
     procedure SetBetweenEditsInRow(val: integer);
     procedure SetBetweenLabelEdit(val: integer);
     procedure SetBetweenRow(val: integer);
     procedure SetLabelIndent(val: integer);
  public
     Owner: TComponent;
  published
     property BetweenEditsInRow: integer read FBetweenEditsInRow write SetBetweenEditsInRow
          default 5;
     property BetweenLabelEdit: integer read FBetweenLabelEdit write SetBetweenLabelEdit
          default 1;
     property BetweenRow: integer read FBetweenRow write SetBetweenRow
          default 2;
     property LabelIndent: integer read FLabelIndent write SetLabelIndent
          default 1;
  end;

  TwwEditSpacing = class(TPersistent)
  private
     FHorizontalView: TwwHorzEditSpacing;
     FVerticalView: TwwVertEditSpacing;
  public
     destructor Destroy; override;
  published
     property HorizontalView: TwwHorzEditSpacing read FHorizontalView write FHorizontalView;
     property VerticalView: TwwVertEditSpacing read FVerticalView write FVerticalView;
  end;

{  TwwFormPosition = class(TPersistent)
  private
     FLeft, FTop: integer;
     FWidth, FHeight: integer;
  published
     property Left: integer read FLeft write FLeft;
     property Top: integer read FTop write FTop;
     property Width: integer read FWidth write FWidth;
     property Height: integer read FHeight write FHeight;
  end;
}
  TwwRecordViewDialog= class(TwwCustomDialog)
  private
     FOldNavParent: TWinControl;
     FSelected: TStrings;
     FUseTFields: boolean;
     FControlList: TList;
     FLabelList: TList;
     FEditSpacing: TwwEditSpacing;
     FMargin: TwwMargin;
     FFormPosition: TwwFormPosition;
     FBorderStyle: TFormBorderStyle;
     FDataLink: TDataLink;
     FOptions: TwwRecordViewOptions;
     FControlOptions: TwwRecordViewControlOptions;
     FOKCancelOptions: TwwRecordViewOKCancelOptions;
     FFont: TFont;
     FLabelFont: TFont;
     FOnBeforeCreateControl: TwwOnBeforeCreateControlEvent;
     FOnAfterCreateControl: TwwOnAfterCreateControlEvent;
     FOnSetControlEffects: TwwOnSetControlEffectsEvent;
     FOnInitDialog: TwwOnInitFormEvent;
     FOnCloseDialog: TwwOnInitFormEvent;
     FOnResizeDialog: TwwOnInitFormEvent;
//     FOnBeforePaint: TwwRecordCustomPaintEvent;
     FCaption: string;
     FReadOnlyColor: TColor;
     FStyle: TwwRecordViewStyle;
     FMenu: TMainMenu;
//     FNavigatorVisibleButtons: TButtonSet;
     FNavigatorButtons: TwwNavButtonNavStylesEx;
     FNavigatorFlat: boolean;
     FNavigator: TwwDBNavigator; { -ksw (6/17/98) }
     FOnCancelWarning: TwwCancelEvent;
     FLinesPerMemoControl: integer;

     EditStartOffset: integer;
     FormWidth, FormHeight: integer; { Scrollable range }
     CloseAction: TwwCloseAction;
     CustomControlList: TList;

     FControlType: TStrings;
     FControlInfoInDataset: boolean;
     FPictureMasks: TStrings;
     FPictureMaskFromDataSet: boolean;
     FDefaultEditFrame: TwwEditFrame;

     CurLabel: TLabel;

     procedure SetNavParent(NewParent: TWinControl; SaveOld: Boolean);
     procedure SetDataSource(value : TDataSource);
     Function GetDataSource: TDataSource;
     Procedure SetLabelFont(val: TFont);
     Procedure SetFont(val: TFont);
     procedure SetNavigator(Value: TwwDBNavigator);
     Function ShowField(field: TField; curFieldReadOnly: boolean): boolean;
     procedure FormShow(Sender: TObject);
     procedure FormResize(Sender: TObject);
     Procedure CreateMainMenu(Form: TwwRecordViewForm; mm: TMainMenu);
     procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
     procedure FormClose(Sender: TObject; var Action: TCloseAction);
     Procedure AddCustomControl(CustomEdit: TWinControl);
     Function IsModified: boolean;
     function IsCheckBox(curField: TField; var checkboxOn, checkboxOff: string): boolean;
     procedure SetPictureMasks(val: TStrings);
     procedure SetControlType(val: TStrings);
     procedure InitPictureMask(EditControl: TWinControl; curField: TField);
  protected
     function IsSingleLineEditControl(EditControl: TWinControl): boolean; virtual;
     procedure DoOnBeforeCreateControl(form: TwwRecordViewForm; curField: TField; var accept: boolean); virtual;
     procedure DoOnAfterCreateControl(form: TwwRecordViewForm; curField: TField; Control: TControl); virtual;
     procedure DoSetControlEffects(form: TwwRecordViewForm; curfield: TField;
       control: TControl; Frame: TwwEditFrame; ButtonEffects: TwwButtonEffects); virtual;

     procedure DoInitDialog(Form: TwwRecordViewForm); virtual;
     procedure DoCloseDialog(Form: TwwRecordViewForm); virtual;
     procedure Notification(AComponent: TComponent;
       Operation: TOperation); override;
     Procedure DisplayVertical;
     Procedure DisplayHorizontal;
     Procedure DoCancelWarning(var CanClose: boolean); virtual;

     procedure SetNavigatorVisibleButtons(Value: TButtonSet);
     function HasFrame(Control: TWinControl): boolean;
     function HasButtonEffects(Control: TWinControl): boolean;
     function IsControlModified(Control: TWinControl): boolean;
//     procedure DefineProperties(Filer: TFiler); override;
//     procedure NavVisButtonsReadProc(Reader: TReader);
//     procedure NavVisButtonsWriteProc(Writer: TWriter);
  public
     OKBtn: TButton;
     CancelBtn: TButton;
     RecordViewForm: TwwRecordViewForm;
     Patch: Variant;

     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
     function GetPrimaryDataSet: TDataSet; override;
     Function Execute: boolean; override;
     procedure OKBtnClick(Sender: TObject); virtual;
     procedure CancelBtnClick(Sender: TObject); virtual;
  published
     property ControlType : TStrings read FControlType write SetControlType;
     property ControlInfoInDataset: boolean
            read FControlInfoInDataset write FControlInfoInDataSet default True;
     property PictureMaskFromDataSet: boolean
             read FPictureMaskFromDataSet write FPictureMaskFromDataSet default True;
     property PictureMasks: TStrings read FPictureMasks write SetPictureMasks;
     property EditFrame: TwwEditFrame read FDefaultEditFrame write FDefaultEditFrame;
     property DataSource: TDataSource read GetDataSource write SetDataSource;
     property EditSpacing: TwwEditSpacing read FEditSpacing write FEditSpacing;
     property Margin: TwwMargin read FMargin write FMargin;
     property BorderStyle: TFormBorderStyle read FBorderStyle write FBorderStyle default bsSizeable;
     property FormPosition: TwwFormPosition read FFormPosition write FFormPosition;
     property NavigatorButtons: TwwNavButtonNavStylesEx read FNavigatorButtons write FNavigatorButtons;
     property NavigatorVisibleButtons: TButtonSet write SetNavigatorVisibleButtons stored False;
//              write FNavigatorVisibleButtons
//              default [nbFirst,nbPrior,nbNext,nbLast,nbinsert,
//                        nbDelete,nbEdit,nbPost,nbCancel,nbRefresh];
     property Style : TwwRecordViewStyle read FStyle write FStyle default rvsVertical;
     property Options: TwwRecordViewOptions read FOptions write FOptions
              default [rvoShortenEditBox, rvoUseCustomControls,
                       rvoModalForm, rvoConfirmCancel, rvoCloseIsCancel,
                       rvoMaximizeMemoWidth, rvoUseDateTimePicker];
     property ControlOptions: TwwRecordViewControlOptions read FControlOptions write FControlOptions;
     property OKCancelOptions: TwwRecordViewOKCancelOptions read FOKCancelOptions write FOKCancelOptions
              default [rvokShowOKCancel, rvokAutoPostRec, rvokAutoCancelRec];
     property LabelFont: TFont read FlabelFont write SetLabelFont;
     property Font: TFont read FFont write SetFont;
     property OnBeforeCreateControl: TwwOnBeforeCreateControlEvent
              read FOnBeforeCreateControl write FOnBeforeCreateControl;
     property OnAfterCreateControl: TwwOnAfterCreateControlEvent
              read FOnAfterCreateControl write FOnAfterCreateControl;
     property OnSetControlEffects: TwwOnSetControlEffectsEvent
              read FOnSetControlEffects write FOnSetControlEffects;
//     property OnBeforePaint : TwwRecordCustomPaintEvent read FOnBeforePaint write FOnBeforePaint;
     property OnInitDialog: TwwOnInitFormEvent read FOnInitDialog write FOnInitDialog;
     property OnCloseDialog: TwwOnInitFormEvent read FOnCloseDialog write FOnCloseDialog;
     property OnResizeDialog: TwwOnInitFormEvent read FOnResizeDialog write FOnResizeDialog;
     property Caption: string read FCaption write FCaption;
     property ReadOnlyColor: TColor read FReadOnlyColor write FReadOnlyColor default clInactiveCaptionText;
     property Menu: TMainMenu read FMenu write FMenu;
     property Selected: TStrings read FSelected write FSelected;
     property NavigatorFlat: boolean read FNavigatorFlat write FNavigatorFlat default False;
     property Navigator: TwwDBNavigator read FNavigator write SetNavigator;
     property OnCancelWarning: TwwCancelEvent read FOnCancelWarning write FOnCancelWarning;
     property LinesPerMemoControl: integer read FLinesPerMemoControl write FLinesPerMemoControl default 2;
  end;

  TwwDBCheckBox =class(TDBCheckBox)
  protected
     procedure DoEnter; override;
     procedure DoExit; override;
  public
     LabelControl: TLabel;
  end;

  TwwLabel =class(TLabel)
  protected
     procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  end;

  TwwDBMemo = class(TDBMemo)
    protected
     procedure KeyDown(var key: word; shift: TShiftState); override;
  end;

  TwwDBEditMemo = class(TwwDBCustomEdit)
    public
     constructor Create(AOwner: TComponent); override;
     procedure KeyDown(var key: word; shift: TShiftState); override;
    published
     property AutoSize;
     property BorderStyle;
     property DataField;
     property DataSource;
     property Frame;
  end;

  TwwCustomControlItem=class
     control: TWinControl;
     Left, Top, Width, Height: integer;
     OldParent: TWinControl;
     OldVisible: boolean;
     ButtonFlat, ButtonTransparent: boolean;
  end;

{  function wwIsCustomEditCell(
        Component: TComponent;
        ownerForm: TComponent;
        curField: TField;
        var customEdit: TCustomEdit) : boolean;
}
  function wwIsCheckBox(Component: TComponent;
    curField: TField; var checkboxOn, checkboxOff: string): boolean;

var
  wwRecordViewForm: TwwRecordViewForm;

implementation

uses
  {$ifdef wwDelphi6Up}
  variants,
  {$endif}
 wwdbgrid;
 
const Spacing=13;
      FixedEditWidthConst=20;

{$R *.DFM}

type

{TwwRecordViewScrollbox = class(TScrollBox)
  private
    Dialog: TwwRecordViewDialog;
    FCanvas: TControlCanvas;
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  public
    destructor Destroy; override;
end;
}

TwwMemoDialogPopup = class(TwwMemoDialog)
  private
     Field: TField;
  protected
     procedure DoInitDialog; override;
  public
     MemoControl: TCustomEdit; //wwDBMemo;
end;

procedure TwwDBMemo.KeyDown(var key: word; shift: TShiftState);
var curField: TField;
begin
   inherited; {9/27/98 }

   if (key=vk_f2) then begin
      curField:= datasource.dataset.findField(datafield);
      if curField<>Nil then begin
         with TwwMemoDialogPopup.create(self) do begin
            Field:= curField;
            datasource:= self.datasource;
            dataField:= curfield.fieldName;
            caption:= dataField;
            MemoControl:= Self;

            {7/19/97 - Don't show cancel button in memodialog if readonly }
            if curfield.readonly or
               ((curfield.dataset is TTable) and (curField.dataset as TTable).readonly) then
               MemoAttributes:= MemoAttributes + [mViewOnly];

            if modified then
               curfield.assign(self.Lines); {Flush to tfield }
            Execute;
            Free;
         end;
         key:= 0;
      end
   end

end;

constructor TwwDBEditMemo.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   AutoSize:= False;
   WantReturns := True;
   WordWrap:= True;
   AutoSelect:= False;
end;

procedure TwwDBEditMemo.KeyDown(var key: word; shift: TShiftState);
var curField: TField;
begin
   inherited; {9/27/98 }

   if (key=vk_f2) then begin

      curField:= datasource.dataset.findField(datafield);
      if curField<>Nil then begin
         with TwwMemoDialogPopup.create(self) do begin
            datasource:= self.datasource;
            dataField:= curfield.fieldName;
            caption:= dataField;
            MemoControl:= Self;
            Field:= curField;

            {7/19/97 - Don't show cancel button in memodialog if readonly }
            if curfield.readonly or
               ((curfield.dataset is TTable) and (curField.dataset as TTable).readonly) then
               MemoAttributes:= MemoAttributes + [mViewOnly];

            if modified then
               UpdateRecord;
            Execute;
            Free;
         end;
         key:= 0;
      end
   end

end;

procedure TwwMemoDialogPopup.DoInitDialog;
begin
   Form.Memo.selStart:= MemoControl.selStart;
   Form.Memo.Font.Assign(TEdit(MemoControl).Font);
//   Form.Caption := MemoControl.Field.DisplayLabel; {7/21/97}
   Form.Caption := Field.DisplayLabel; {7/21/97}
end;

function wwIsCheckBox(Component: TComponent;
    curField: TField; var checkboxOn, checkboxOff: string): boolean;
var fldName: string;
    i: integer;
    parts : TStrings;
    controlType: TStrings;
begin
   result:= False;
   fldName:= curField.fieldName;
   parts:= TStringList.create;

   controlType:= nil; { 6/22/99 - ADO datasets store in component, not dataset }
   if wwGetControlInfoInDataSet(Component) then
      controlType:= wwGetControlType(curfield.dataset);
   if controlType=nil then
      controlType:= wwGetControlType(Component);

   for i:= 0 to ControlType.count-1 do begin
      strBreakapart(controlType[i], ';', parts);
      if parts.count<4 then continue;
      if parts[0]<>fldName then continue;
      if parts[1]='CheckBox' then begin
         CheckBoxOn:= parts[2];
         CheckBoxOff:= parts[3];
         result:= True;
         break;
      end
   end;

   parts.free;
end;


constructor TwwRecordViewDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Patch:= VarArrayCreate([0, 0], varVariant);
  Patch[0]:= False; { Set to True to preserve old behavior of ignoreing maximizememowidth with vertical display}

  FDataLink:= TDataLink.create;
  FEditSpacing:= TwwEditSpacing.create;
  with FEditSpacing do begin
     VerticalView:= TwwVertEditSpacing.create;
     VerticalView.BetweenRow:= 2;
     VerticalView.BetweenLabelEdit:= 5;
     VerticalView.Owner:= nil;
     HorizontalView:= TwwHorzEditSpacing.create;
     HorizontalView.BetweenRow:= 2;
     HorizontalView.BetweenLabelEdit:= 1;
     HorizontalView.BetweenEditsInRow:= 5;
     HorizontalView.LabelIndent:= 1;
     HorizontalView.Owner:= nil;
  end;

  FMargin:= TwwMargin.create;
  with FMargin do begin
     LeftOffset:= 5;
     RightOffset:=5;
     TopOffset:= 5;
     BottomOffset:=5;
     Owner:= nil;
  end;

  FFormPosition:= TwwFormPosition.create;
  with FFormPosition do begin
     Left:= 0;  { Auto-center }
     Top:= 0;   { Auto-center }
     Width:= 0;  { Auto-size }
     Height:= 0; { Auto-size }
  end;

  FOptions:= [rvoShortenEditBox, rvoUseCustomControls, rvoModalForm, rvoConfirmCancel,
              rvoCloseIsCancel, rvoMaximizeMemoWidth, rvoUseDateTimePicker];
  FOKCancelOptions:= [rvokShowOKCancel, rvokAutoPostRec, rvokAutoCancelRec];
  FFont := TFont.Create;
  FLabelFont:= TFont.create;
  FControlList:= TList.create;
  FLabelList:= TList.create;
  FCaption:= 'Record View';
  FReadOnlyColor:= clInactiveCaptionText;
  FStyle:= rvsVertical;
  FSelected:= TStringList.create;
  FUseTFields:= False;
  FNavigatorFlat := True;
//  FNavigatorVisibleButtons:= [nbFirst,nbPrior,nbNext,nbLast,
//                              nbInsert,nbDelete,nbEdit,nbPost,
//                              nbCancel,nbRefresh];
  FNavigatorButtons := [nbsFirst, nbsPrior, nbsNext, nbsLast,
    nbsInsert, nbsDelete, nbsEdit, nbsPost, nbsCancel, nbsRefresh,
    nbsNextPage, nbsPriorPage, nbsSaveBookmark, nbsRestoreBookmark];
  CloseAction := rvcControlMenuClose;
  CustomControlList:= TList.create;
  BorderStyle:= bsSizeable;

  FControlType:= TStringList.create;
  FControlInfoInDataset:= True;
  FPictureMasks:= TStringList.create;
  FPictureMaskFromDataSet:= True;

  FLinesPerMemoControl:= 2;
  FDefaultEditFrame:= TwwEditFrame.create(self);
end;

destructor TwwEditSpacing.Destroy;
begin
  FHorizontalView.Free;
  FVerticalView.Free;
  inherited destroy;
end;

destructor TwwRecordViewDialog.Destroy;
var i: integer;
begin
  FDefaultEditFrame.Free;
  if not (csDestroying in Application.ComponentState) then
     RecordViewForm.Free;
  RecordViewForm:= Nil;
  FDataLink.free;
  FDataLink:= nil;
  FEditSpacing.Free;
  FMargin.Free;
  FFormPosition.Free;
  FFont.Free;
  FLabelFont.Free;
  FControlList.Free;
  FLabelList.Free;
  FSelected.Free;
  for i:= 0 to CustomControlList.count-1 do TwwCustomControlItem(CustomControlList[i]).Free;
  CustomControlList.Free;
  CustomControlList:= nil; // 10/5/00
  FControlType.Free;
  FPictureMasks.Free;

  inherited destroy;
end;

procedure TwwRecordViewDialog.SetDataSource(value : TDataSource);
begin
   FDataLink.dataSource:= value;
end;

Function TwwRecordViewDialog.getDataSource: TDataSource;
begin
   Result:= FdataLink.dataSource as TDataSource;
end;

procedure TwwRecordViewDialog.setFont(val: TFont);
begin
    FFont.assign(Val);
end;

procedure TwwRecordViewDialog.setLabelFont(val: TFont);
begin
    FLabelFont.assign(Val);
end;

Function TwwRecordViewDialog.ShowField(field: TField; curFieldReadOnly: boolean): boolean;
begin
   if field=nil then result:= False
   else if (rvoHideReadOnly in Options) and curFieldReadOnly then result:= False
   else if (rvoHideCalculated in Options) and field.calculated then result:= False
   else result:= True;
end;

procedure TwwRecordViewDialog.FormShow(Sender: TObject);
var i: integer;
begin
   if (rvoLabelsBeneathControl in Options) and (Style=rvsHorizontal) then
   begin
      for i:= 0 to FControlList.count-1 do begin
         curLabel:= TLabel(FLabelList[i]);
         curLabel.top:=
           TControl(FControlList[i]).Top +
           TControl(FControlList[i]).height +
               EditSpacing.HorizontalView.BetweenLabelEdit-1;
     end;
   end;

   DoInitDialog(Sender as TwwRecordViewForm);

   Screen.cursor:= crDefault;
end;

function TwwRecordViewDialog.IsControlModified(Control: TWinControl): boolean;
begin
   result:= SendMessage(Control.Handle, EM_GETMODIFY, 0, 0)=1;
end;

procedure TwwRecordViewForm.KeyDown(var Key: Word; Shift: TShiftState);
var Dlg: TwwRecordViewDialog;

  Function GetWantReturns(Control: TControl): boolean;
  var PropInfo: PPropInfo;
  begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(Control.ClassInfo,'WantReturns');
   if PropInfo<>Nil then
      result:= Boolean(GetOrdProp(Control, PropInfo))
   else if Control is TCustomMemo then
      result:= TMemo(Control).wantReturns
   else if Control is TwwDBEditMemo then
      result:= TwwDBEditMemo(Control).wantReturns;
  end;

  Function GetWantTabs(Control: TControl): boolean;
  var PropInfo: PPropInfo;
  begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(Control.ClassInfo,'WantTabs');
   if PropInfo<>Nil then
      result:= Boolean(GetOrdProp(Control, PropInfo))
  end;

begin
  inherited KeyDown(Key, Shift);

  if ssAlt in Shift then exit;

  Dlg:= DlgComponent as TwwRecordViewDialog;

  if  ((ssCtrl in Shift) and (key=vk_return)) and (rvoModalForm in Dlg.Options) and
      (not (rvoEnterToTab in Dlg.Options)) then
  begin
     ModalResult:= mrOK;
  end;

  if ActiveControl=Nil then exit; { 1/31/99  - All fields reaonly so no active control }

  if Key=27 then begin
     TwwCheatCastKeyDown(ActiveControl).KeyDown(Key, Shift);
     if (Key=27) then begin
        Key:= 0;
        if (ActiveControl is TWinControl) and Dlg.IsControlModified(ActiveControl) then exit
        else begin
          ModalResult:= mrCancel;
          Dlg.CloseAction := rvcCancel;
        end
     end
  end
  else if (not GetWantReturns(ActiveControl) and (key=vk_return) and (rvoEnterToTab in Dlg.Options))
      or (not GetWantTabs(ActiveControl) and (key=vk_tab)) then
  begin
     if ssShift in Shift then
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0)
     else
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
     key:= 0;
  end;

end;

procedure TwwRecordViewDialog.DoSetControlEffects(form: TwwRecordViewForm; curfield: TField;
   control: TControl; Frame: TwwEditFrame; ButtonEffects: TwwButtonEffects);
begin
   if Assigned(FOnSetControlEffects) then
      FOnSetControlEffects(form, curfield, control, Frame, ButtonEffects);
end;

procedure TwwRecordViewDialog.DoOnAfterCreateControl(
    form: TwwRecordViewForm; curField: TField; Control: TControl);
var ButtonEffects: TwwButtonEffects;
    Frame: TwwEditFrame;
//    OldHeight: integer;

 procedure UpdatePositions;
 begin
   if (style=rvshorizontal) then begin
      if (Control is TwwRadioGroup) and TwwRadioGroup(Control).ShowGroupCaption then
      begin
         curLabel.visible:= False;
         control.top:= curlabel.top;
         TwwRadioGroup(control).caption:= curlabel.caption;
      end;
      if (rvoLabelsBeneathControl in Options) then
      begin
         if not (control is TLabel) then
         begin
            control.top:= curLabel.Top;
            curLabel.Top:=
              control.top + control.Height + EditSpacing.HorizontalView.BetweenLabelEdit-1;
         end
      end;
   end;
 end;

begin
   ButtonEffects:= TwwButtonEffects.Get(Control);
   Frame:= TwwEditFrame.Get(Control);
   if not (control is TLabel) then FLabelList.add(curLabel);

   try
     if ButtonEffects<>nil then with buttoneffects do begin
        transparent:= rvcTransparentButtons in ControlOptions;
        flat:= rvcFlatButtons in ControlOptions;
     end;
     if Frame<>nil then Frame.Assign(EditFrame);

     if (Frame<>nil) then
        DoSetControlEffects(form, curfield, control, Frame, ButtonEffects);

//     OldHeight:= Control.Height;
     if Assigned(FOnAfterCreateControl) then
        FOnAfterCreateControl(form, curfield, control);
     UpdatePositions;
   finally
   end

end;

procedure TwwRecordViewDialog.DoOnBeforeCreateControl(
    form: TwwRecordViewForm; curField: TField; var accept: boolean);
begin
   if Assigned(FOnBeforeCreateControl) then
      FOnBeforeCreateControl(form, curfield, accept);
end;

Procedure TwwRecordViewDialog.DoInitDialog(form: TwwRecordViewForm);
begin
   if Assigned(FOnInitDialog) then OnInitDialog(Form);
end;

Procedure TwwRecordViewDialog.DoCancelWarning(var CanClose: boolean);
begin
   if Assigned(FOnCancelWarning) then FOnCancelWarning(RecordViewForm, CanClose);
end;

Procedure TwwRecordViewDialog.DoCloseDialog(form: TwwRecordViewForm);
begin
   if Assigned(FOnCloseDialog) then OnCloseDialog(Form);
end;


Procedure TwwRecordViewDialog.AddCustomControl(CustomEdit: TWinControl);
var customItem: TwwCustomControlItem;
    buttonEffects: TwwButtonEffects;
begin
   customItem:= TwwCustomControlItem.create;
   with customItem do begin
      Control:= CustomEdit;
      Left:= CustomEdit.Left;
      Width:= CustomEdit.Width;
      Top:= CustomEdit.Top;
      Height:= CustomEdit.Height;
      ButtonEffects:= TwwButtonEffects.get(customEdit);
      if ButtonEffects<>nil then begin
         ButtonFlat:= buttoneffects.Flat;
         ButtonTransparent:= buttoneffects.Transparent;
      end;
      OldParent:= CustomEdit.Parent;
      OldVisible:= customEdit.visible;
   end;
   CustomControlList.add(customItem);
end;

function TwwRecordViewDialog.IsCheckBox(curField: TField; var checkboxOn, checkboxOff: string): boolean;
var fldName: string;
    i: integer;
    parts : TStrings;
    controlType: TStrings;
begin
   result:= False;
   fldName:= curField.fieldName;
   parts:= TStringList.create;

   controlType:= nil; { 6/22/99 - ADO datasets store in component, not dataset }
   if wwGetControlInfoInDataSet(self) then
      controlType:= wwGetControlType(curfield.dataset);
   if controlType=nil then
      controlType:= wwGetControlType(self);
      
   for i:= 0 to ControlType.count-1 do begin
      strBreakapart(controlType[i], ';', parts);
      if parts.count<4 then continue;
      if parts[0]<>fldName then continue;
      if parts[1]='CheckBox' then begin
	 CheckBoxOn:= parts[2];
	 CheckBoxOff:= parts[3];
	 result:= True;
	 break;
      end
   end;

   parts.free;
end;

function TwwRecordViewDialog.HasFrame(Control: TWinControl): boolean;
var frame: TwwEditFrame;
begin
    frame:= TwwEditFrame.Get(Control);
    result:= (frame<>nil) and frame.enabled;
end;

function TwwRecordViewDialog.HasButtonEffects(Control: TWinControl): boolean;
begin
    result:= TwwButtonEffects.Get(Control)<>nil;
end;

procedure TwwRecordViewDialog.InitPictureMask(EditControl: TWinControl; curField: TField);
var tempMask: string;
    tempAutoFill, tempUsePictureMask: boolean;
begin
   if (EditControl is TwwDBCustomEdit) then
   begin
      wwPictureByField(wwGetPictureControl(self), curField.FieldName, True,
         tempMask, tempAutoFill, tempUsePictureMask);
      with TwwDBCustomEdit(EditControl).Picture do
      begin
         PictureMaskFromDataSet:= False;
         PictureMask:= tempMask;
         AutoFill:=tempAutoFill;
         AllowInvalidExit:= False;
      end;
   end
end;


Procedure TwwRecordViewDialog.DisplayVertical;
var
    LabelWidth, MaxLabelWidth, MaxEditWidth: integer;
    APos, i, numFields: integer;
    curFieldDisplayWidth: integer;
    curFieldDisplayLabel: wwSmallString;
    curFieldReadOnly: boolean;
    curField: TField;
    curLabel: Tlabel;
    customEdit: TWinControl;
    checkbox: TwwDBCheckBox;
    NavigatorWidth: integer;
    ButtonPanelHeight: integer;
    EditHeight: integer;
    FixedEditWidth: integer;
    accept: boolean;
    PrevTop: integer;
    ARect: TRect;
    checkboxOn, checkboxOff: wwSmallString;
    editControl: TWinControl;
    ShowingVertScrollBar: boolean;

    Function CreateEditControl(EditControl: TWinControl): boolean;
    var TempWidth: integer;
        ControlPositionLeft, ControlPositionTop,
        ControlPositionHeight: integer;
        OldWidth: integer;
    begin
        result:= False;

        with EditControl do begin
           curLabel.FocusControl:= EditControl;
           parent:= RecordViewForm.Scrollbox;
           if not wwSetControlDataSource(EditControl, self.datasource) then exit;
           if not wwSetControlDataField(EditControl, curField.fieldName) then exit;

           if curFieldReadonly or curField.calculated then
           begin
              TEdit(EditControl).color:= ReadOnlyColor;
              EditControl.tabStop:= False;
           end;

           if EditControl is TwwDBEdit then
           begin
              if curField is TStringField then  {7/29/97 - Limit length to field size }
                 if curField.editmask='' then // 9/9/02
                    TEdit(EditControl).maxlength:= curField.Size;
           end;

           { 5/19/99 - Memo fields should not be maximized if rvoMaximizeMemoWidth is false }
           TempWidth:= (curFieldDisplayWidth+1) * RecordViewForm.Canvas.TextWidth('0') + 3;
           if not isSingleLineEditControl(EditControl) then
           begin
              if (Patch[0]) or (rvoMaximizeMemoWidth in Options) then
                 TempWidth:= RecordViewForm.width - EditStartOffset - (Margin.RightOffset + FixedEditWidthConst);
           end;

{           if isSingleLineEditControl(EditControl) then
           begin
              TempWidth:= (curFieldDisplayWidth+1) * RecordViewForm.Canvas.TextWidth('0') + 3;
           end
           else begin
              TempWidth:= RecordViewForm.width - EditStartOffset - (Margin.RightOffset + FixedEditWidthConst);
           end;
}

           if EditControl is TwwDBDateTimePicker then
           begin
              TempWidth:=
                    TempWidth + TwwDBDateTimePicker(EditControl).Button.Width
           end
           else if (EditControl is TCustomMemo) and (rvoEnterToTab in Options) then
                  TMemo(EditControl).WantReturns := False
           else if (EditControl is TwwDBEditMemo) and (rvoEnterToTab in Options) then
                  TwwDBEditMemo(EditControl).WantReturns := False;

           if rvoShortenEditBox in Options then begin
              if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
           end;
           if rvoConsistentEditWidth in Options then begin
              if TempWidth<FixedEditWidth then TempWidth:= FixedEditWidth;
           end;

           ControlPositionLeft:= EditStartOffset; {EditPosition.LeftOffset + LabelWidth + 5;}
           ControlPositionTop:= PrevTop;

           if IsSingleLineEditControl(EditControl) then
              ControlPositionHeight:= EditControl.Height
           else
              ControlPositionHeight:=
                 RecordViewForm.Canvas.TextHeight('0') * LinesPerMemoControl + 8; {2 lines of Memo}
           if CurFieldReadOnly then enabled:=False;
           InitPictureMask(EditControl, curfield);

       end;

       EditControl.Left:= ControlPositionLeft;
       EditControl.Top:= ControlPositionTop;
       EditControl.Height:= ControlPositionHeight;

       FControlList.add(EditControl);

       OldWidth:= EditControl.Width; { 5/20/99 - Respect width change }
       DoOnAfterCreateControl(RecordViewForm, curField, EditControl);
       if EditControl.Width<>OldWidth then TempWidth:= EditControl.Width; { 10/22/98 }

       if rvoShortenEditBox in Options then begin
          if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
       end;

       if rvoConsistentEditWidth in Options then begin
          if TempWidth<FixedEditWidth then TempWidth:= FixedEditWidth; //!!
       end;

       EditControl.Width:= TempWidth;

       MaxEditWidth:= wwmax(MaxEditWidth, tempWidth);
       PrevTop:= Prevtop + EditControl.Height + EditSpacing.VerticalView.BetweenRow;
       EditHeight := EditControl.Height;

       result:= True;
    end;

begin
   PrevTop:= Margin.TopOffset;
   with RecordViewForm do begin
      if not (rvoHideNavigator in Options) then NavigatorWidth:= Navigator.width
      else NavigatorWidth:= 0;

      if (rvokShowOKCancel in OKCancelOptions) then
      begin
        ButtonPanelHeight:= ButtonPanel.Height;
      end
      else
      begin
        ButtonPanelHeight:= 0;
      end;

      if FuseTFields or (selected.count=0) then numFields:= DataSource.DataSet.FieldCount
      else numFields:= Selected.count;

      MaxLabelWidth:= 0;
      Canvas.Font := LabelFont;
      for i:= 0 to numFields-1 do begin
         if (Selected.count=0) or FuseTFields then begin
            curField:= DataSource.dataset.fields[i];
            curFieldDisplayLabel:= curField.DisplayLabel;
            curFieldReadOnly:= curfield.ReadOnly;
         end
         else begin
            APos:= 1;
            curField:= DAtaSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield<>nil then begin
               strGetToken(Selected[i], #9, APos);
               curFieldDisplayLabel:= strGetToken(Selected[i], #9, APos);  { 6/4/97}
               curFieldReadOnly := (strGetToken(Selected[i], #9, APos) = 'T');
            end
         end;
         if not ShowField(curfield, curFieldReadOnly) then continue;
         MaxLabelWidth:= wwMax(MaxLabelWidth,
                           Canvas.TextWidth(curFieldDisplayLabel));
      end;

      LabelWidth:= MaxLabelWidth;
      Canvas.Font := Font;
            { Limit form length }
      EditStartOffset:= Margin.LeftOffset + labelWidth + EditSpacing.VerticalView.BetweenLabelEdit;

      { Compute desired form length }
      MaxEditWidth:= 0;
      curFieldDisplayWidth:= 0;

      for i:= 0 to numFields-1 do begin
         if (Selected.count=0) or FuseTFields then
         begin
            curField:= DAtaSource.dataset.fields[i];
            curFieldDisplayWidth:= curField.DisplayWidth;
            curFieldReadOnly:= curField.ReadOnly;
         end
         else begin
            APos:= 1;
            curField:= DAtaSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield<>nil then
            begin
               curFieldDisplayWidth:= strToInt(strGetToken(Selected[i], #9, APos));
               strGetToken(Selected[i], #9, APos); { Display label }
               curFieldReadOnly := (strGetToken(Selected[i], #9, APos) = 'T')
            end
         end;
         if not ShowField(curfield, curFieldReadOnly) then continue;

         MaxEditWidth:= wwmax(MaxEditWidth,
               (CurFieldDisplayWidth+1) * Canvas.TextWidth('0') + 3);
      end;


      ARect := wwGetWorkingRect;

      if FormPosition.Width>0 then
         FormWidth:= wwMax(FormPosition.Width, NavigatorWidth + (FixedEditWidthConst-6) + Margin.RightOffset)
      else begin
         FormWidth:= RecordPanel.Left + ScrollBox.left + EditStartOffset + MaxEditWidth +
                  (FixedEditWidthConst-6) + Margin.RightOffset;
         FormWidth:= wwMax(FormWidth, NavigatorWidth + (FixedEditWidthConst-6) + Margin.RightOffset);
      end;

      Width:= wwmin(FormWidth, (ARect.Right-ARect.Left)-((FixedEditWidthConst-6) + Margin.RightOffset));

      MaxEditWidth:= 0;
      EditHeight:= 8;

      FixedEditWidth:= RecordViewForm.width - (EditStartOffset + (FixedEditWidthConst + Margin.RightOffset));

      for i:= 0 to numFields-1 do begin
         if (Selected.count=0) or FuseTFields then
         begin
            curField:= DAtaSource.dataset.fields[i];
            curFieldDisplayWidth:= curField.displayWidth;
            curFieldDisplayLabel:= curField.displayLabel;
            curFieldReadOnly:= curField.readonly;
         end
         else begin
            APos:= 1;
            curField:= DAtaSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield<>nil then begin
               curFieldDisplayWidth:= strToInt(strGetToken(Selected[i], #9, APos));
               curFieldDisplayLabel:= strGetToken(Selected[i], #9, APos);  { 6/4/97}
               curFieldReadOnly :=strGetToken(Selected[i], #9, APos) = 'T'
            end
         end;
         if not ShowField(curfield, curFieldReadOnly) then continue;

         accept:= True;
         DoOnBeforeCreateControl(RecordViewForm, curField, accept);
         if not accept then continue;

         if (rvoUseCustomControls in Options) and
            IsCheckbox(curField, checkboxOn, checkboxOff) then
            curLabel:= TwwLabel.create(Scrollbox)
         else
            curLabel:= TLabel.create(Scrollbox);
         self.curlabel:= curlabel;

         with curLabel do begin
            parent:= ScrollBox;
            font:= self.labelFont;
            { Move caption assigment before left assignment for bidi support }
            Caption:= strReplaceChar(curfieldDisplayLabel, '~', ' ');
            left:= Margin.LeftOffset;
            if (rvoUseCustomControls in Options) and
               IsCheckbox(curField, checkboxOn, checkboxOff) then
            begin
               Top:= PrevTop + 1
            end
            else
               Top:= PrevTop + 4;

            AutoSize:= False;
            Width:= LabelWidth;
            alignment:= taRightJustify;
         end;

         if rvcTransparentLabels in ControlOptions then curLabel.transparent:= true;
         DoOnAfterCreateControl(RecordViewForm, curField, curLabel);

         if (rvoUseCustomControls in Options) and
            IsCheckbox(curField, checkboxOn, checkboxOff) then
         begin
            checkbox:= TwwDBCheckBox.create(ScrollBox);
            checkbox.LabelControl:= curLabel;
            curLabel.FocusControl:= checkBox;
            with checkbox do begin
               parent:= ScrollBox;
               datasource:= self.DataSource;
               datafield:= curfield.fieldName;
               left:= EditStartOffset; {EditPosition.LeftOffset + LabelWidth + 5;}
               Top:= PrevTop;
               caption:= '';
               valueChecked:= checkboxOn;
               valueUnchecked:= checkboxOff;
               Width:= 17;
               if curFieldReadonly or Field.calculated then
               begin
                  tabStop:= False;
               end;
            end;
            DoOnAfterCreateControl(RecordViewForm, curField, checkbox);

            MaxEditWidth:= wwmax(MaxEditWidth, checkbox.Width);
            PrevTop:= Prevtop + checkbox.Height + EditSpacing.VerticalView.BetweenRow;
            EditHeight:= checkbox.Height;

         end
         else if (rvoUseCustomControls in Options) and
            wwIsCustomEditCell(self, wwGetOwnerFrameOrForm(self), curField, customEdit) then
         with TEdit(CustomEdit) do begin

            { Save previous position and restore when dialog is closed }
            AddCustomControl(CustomEdit);
            curLabel.FocusControl:= CustomEdit;

            parent:= ScrollBox;
            visible:= True;
            if not wwSetControlDataSource(customEdit, datasource) then continue;
            if not wwSetControlDataField(customEdit, curField.fieldName) then continue;
            if CustomEdit is TwwDBCustomLookupCombo then
            begin
               if not (curField.calculated or curfield.lookup) then
                  TwwDBLookupCombo(CustomEdit).RefreshDisplay;
            end;
            Ctl3d:= True;

            if not HasFrame(customEdit) then BorderStyle:= bsSingle;

            left:= EditStartOffset;
            top:= PrevTop;

            if (wwisclass(customedit.classtype,'TwwCustomRichEdit')) then begin
{               Height:= Canvas.TextHeight('0')*2+8;}
               Width:= RecordViewForm.width - EditStartOffset - (FixedEditWidthConst + Margin.RightOffset);
            end
            else
            begin
               Width:= (curFieldDisplayWidth+1) * Canvas.TextWidth('0') + 3;
               if (Width < Canvas.TextWidth(curFieldDisplayLabel)) and (rvoSetControlMinWidth in Options) then
                  Width:= Canvas.TextWidth(curFieldDisplayLabel) + 1;
            end;

            if rvoShortenEditBox in Options then begin
               if Width>FixedEditWidth then Width:= FixedEditWidth;
            end;
            if rvoConsistentEditWidth in Options then begin
               if Width<FixedEditWidth then Width:= FixedEditWidth;
            end;
            TEdit(CustomEdit).HandleNeeded;
            FControlList.add(CustomEdit);
            DoOnAfterCreateControl(RecordViewForm, curField, customEdit);

            if rvoShortenEditBox in Options then begin
               if customEdit.Width>FixedEditWidth then
                  customEdit.Width:= FixedEditWidth;
            end;
            if rvoConsistentEditWidth in Options then begin
               if customEdit.Width<FixedEditWidth then customEdit.Width:= FixedEditWidth;
            end;
            MaxEditWidth:= wwmax(MaxEditWidth, customEdit.Width);
            PrevTop:= Prevtop + customEdit.Height + EditSpacing.VerticalView.BetweenRow;
            EditHeight:= customEdit.Height;
         end
         else if (curField is TDateTimeField) and
                 (rvoUseDateTimePicker in Options) then
         begin
            EditControl:= TwwDBDateTimePicker.create(ScrollBox);
            if not CreateEditControl(EditControl) then continue;
         end
         else if wwIsRichEditField(curField, True) then begin
            EditControl:= TwwDBRichEdit.create(ScrollBox);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (curField.dataType = ftMemo) then begin
            if EditFrame.IsFrameEffective then
               EditControl:= TwwDBEditMemo.create(ScrollBox)
            else
               EditControl:= TwwDBMemo.create(ScrollBox);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (curField.dataType = ftGraphic) then
         begin { 8/27/98 - Support images }
            editControl:= TDBImage.create(ScrollBox);
            if not CreateEditControl(EditControl) then continue;
         end
         else begin
            EditControl:= TwwDBEdit.create(Scrollbox);
            EditControl.controlStyle:= EditControl.ControlStyle + [csNoDesignVisible];
            if not CreateEditControl(EditControl) then continue;
         end
      end;

      CreateMainMenu(RecordViewForm, self.menu);
      PrevTop := PrevTop + Margin.BottomOffset - EditSpacing.VerticalView.BetweenRow;

      FormHeight:= (PrevTop  + RecordPanel.Top)+ 21+getsystemmetrics(SM_CYCAPTION) + ButtonPanelHeight;

      if (self.menu<>nil) and (BorderStyle<>bsDialog) then
         FormHeight:= FormHeight +  GetSystemMetrics(SM_CYMENU);
      if FormPosition.height>0 then Height:= wwMin(FormPosition.Height, FormHeight)
      else Height:= FormHeight;

      { Adjust width/height based on visibility of scrollbars }
      if Height>ARect.Bottom-ARect.Top-12 then
      begin
         Height:= ARect.Bottom-ARect.Top-12;
         {$ifdef wwDelphi4Up}
         ShowingVertScrollBar:= True;
         {$else}
         ShowingVertScrollBar:= False;
         {$endif}
      end
      else ShowingVertScrollBar:= False;

      ScrollBox.VertScrollBar.Margin:= 6;
      ScrollBox.VertScrollBar.Increment:= EditHeight + EditSpacing.VerticalView.BetweenRow;
      ScrollBox.VertScrollBar.Range := PrevTop;
      if (RecordPanel.Height-12)<PrevTop then Width:= Width + GetSystemMetrics(SM_CXHThumb);

      FormWidth:= RecordPanel.Left + ScrollBox.left + EditStartOffset + MaxEditWidth +
                  (FixedEditWidthConst-6) + Margin.RightOffset;
      if Width>ARect.Right-ARect.Left then Width:= ARect.Right-ARect.Left;

      if Width<FormWidth then
         Height:= Height + GetSystemMetrics(SM_CYVThumb);
      ScrollBox.HorzScrollBar.Margin:= 6;
      if (rvoConsistentEditWidth in Options) then
         ScrollBox.HorzScrollBar.Range := MaxEditWidth
      else
         ScrollBox.HorzScrollBar.Range := EditStartOffset + MaxEditWidth + Margin.RightOffset;

      if ShowingVertScrollBar then
         ScrollBox.HorzScrollBar.Range:=
            ScrollBox.HorzScrollBar.Range - GetSystemMetrics(SM_CXHThumb);

      if (rvokShowOKCancel in OKCancelOptions) then begin
         ButtonPanel.Width := Width;
         OKBtn.Left:= (ButtonPanel.Width - 10) - ((OKBtn.Width + Spacing) * 2);
         CancelBtn.Left:= (ButtonPanel.Width-10) - ((OKBtn.Width + Spacing) * 1);
      end;
   end
end;


{*****************************************************}

Procedure TwwRecordViewDialog.DisplayHorizontal;
var
    OrigMaxEditWidth, MaxEditWidth: integer;
    APos, i, numFields: integer;
    curFieldDisplayWidth: integer;

    curFieldEditWidth: integer;
    curFieldLabelWidth: integer;
    curFieldDisplayLabel: wwSmallString;
    curFieldReadOnly: boolean;
    RealMaxLineWidth, MaxLineWidth,curLineWidth: integer;
    LastEditHeight:integer;
    LastLabelHeight:integer;
    ARect:TRect;

    curField: TField;
    curLabel: Tlabel;
    customEdit: TWinControl;
    checkbox: TwwDBCheckBox;
    NavigatorWidth: integer;
    ButtonPanelHeight: integer;
    EditHeight: integer;
    FixedEditWidth: integer;
    accept: boolean;
    PrevTop: integer;
    checkboxOn, checkboxOff: wwSmallString;
    editControl: TWinControl; //CustomEdit;
    ShowingVertScrollBar: boolean;

    Function CreateEditControl(EditControl: TWinControl): boolean;
    var TempWidth: integer;
        ControlPositionLeft, ControlPositionTop,
        ControlPositionHeight: integer;
        OldWidth: integer;
    begin
        result:= False;

        with EditControl do begin
           curLabel.FocusControl:= EditControl;
           parent:= RecordViewForm.Scrollbox;
           if not wwSetControlDataSource(EditControl, self.datasource) then exit;
           if not wwSetControlDataField(EditControl, curField.fieldName) then exit;

           if curFieldReadonly or curField.calculated then
           begin
              TEdit(EditControl).color:= ReadOnlyColor;
              EditControl.tabStop:= False;
           end;

           if EditControl is TwwDBEdit then
           begin
              if curField is TStringField then  {7/29/97 - Limit length to field size }
                 if curField.editmask='' then // 9/9/02
                    TEdit(EditControl).maxlength:= curField.Size;
           end;

           { 4/27/99 - Memo fields should not be maximized if rvoMaximizeMemoWidth is false }
           TempWidth:= (curFieldDisplayWidth+1) * RecordViewForm.Canvas.TextWidth('0') + 3;
           if not isSingleLineEditControl(EditControl) then
           begin
              if (rvoMaximizeMemoWidth in Options) then
                 TempWidth:= RecordViewForm.width - EditStartOffset - (Margin.RightOffset + FixedEditWidthConst);
           end;

           if EditControl is TwwDBDateTimePicker then
           begin
              TempWidth:=
                    TempWidth + TwwDBDateTimePicker(EditControl).Button.Width
           end
           else if (EditControl is TCustomMemo) and (rvoEnterToTab in Options) then
               TMemo(EditControl).WantReturns := False
           else if (EditControl is TwwDBEditMemo) and (rvoEnterToTab in Options) then
               TwwDBEditMemo(EditControl).WantReturns := False;

           if rvoShortenEditBox in Options then begin
              if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
           end;
           if rvoConsistentEditWidth in Options then begin
              if TempWidth<FixedEditWidth then TempWidth:= FixedEditWidth;
           end;

           ControlPositionLeft:= EditStartOffset+curLineWidth;
           ControlPositionTop:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+curlabel.Height;

           if IsSingleLineEditControl(EditControl) then
              ControlPositionHeight:= EditControl.Height
           else begin
              if (rvoMaximizeMemoWidth in Options) then
              begin
                 ControlPositionLeft:= EditStartOffset;
                 ControlPositionTop:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+curlabel.Height;
                 TempWidth:= wwMax(OrigMaxEditWidth, FixedEditWidth)
              end;

              ControlPositionHeight:=
                 RecordViewForm.Canvas.TextHeight('0') * LinesPerMemoControl + 8; {2 lines of Memo}
           end;
           if CurFieldReadOnly then enabled:=False;
       end;

       EditControl.Left:= ControlPositionLeft;
       EditControl.Top:= ControlPositionTop;
       EditControl.Height:= ControlPositionHeight;

       FControlList.add(EditControl);

       OldWidth:= EditControl.Width; { 5/20/99 - Respect width change }
       DoOnAfterCreateControl(RecordViewForm, curField, EditControl);
       if EditControl.Width<>OldWidth then TempWidth:= EditControl.Width; { 10/22/98 }

       if rvoShortenEditBox in Options then begin
          if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
       end;

       if rvoConsistentEditWidth in Options then begin
          if TempWidth<FixedEditWidth then TempWidth:= FixedEditWidth; //!!
       end;

       if (TempWidth < curlabel.width) and (rvoSetControlMinWidth in Options) then
           TempWidth:= curlabel.width + 1;
       EditControl.Width:= TempWidth;

       curFieldEditWidth := EditControl.Width;
       MaxEditWidth:= wwmax(MaxEditWidth, tempWidth);
       LastEditHeight := wwMax(LastEditHeight,EditControl.Height);

       InitPictureMask(EditControl, curfield);

       result:= True;
    end;


begin
   PrevTop:= Margin.TopOffset;
   with RecordViewForm do begin
      if not (rvoHideNavigator in Options) then NavigatorWidth:= Navigator.width
      else NavigatorWidth:= 0;

      if (rvokShowOKCancel in OKCancelOptions) then
      begin
        ButtonPanelHeight:= ButtonPanel.Height;
      end
      else
      begin
        ButtonPanelHeight:= 0;
      end;

      if FuseTFields or (selected.count=0) then numFields:= DataSource.DataSet.FieldCount
      else numFields:= Selected.count;

      Canvas.Font := Font;

      { Compute desired form length }
      MaxEditWidth:= 0;
      RealMaxLineWidth:= 0;
      curFieldDisplayWidth:= 0;

      for i:= 0 to numFields-1 do begin
         curFieldReadOnly:= False;
         if (Selected.count=0) or FuseTFields then
         begin
            curField:= DAtaSource.dataset.fields[i];
            curFieldDisplayWidth:= curField.DisplayWidth;
            curFieldReadOnly:= curfield.ReadOnly;
         end
         else begin
            APos:= 1;
            curField:= DAtaSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield<>nil then
            begin
               curFieldDisplayWidth:= strToInt(strGetToken(Selected[i], #9, APos));
               strGetToken(Selected[i], #9, APos); { Display label }
               curFieldReadOnly := (strGetToken(Selected[i], #9, APos) = 'T');
            end
         end;
         if not ShowField(curfield, curFieldReadOnly) then continue;

         MaxEditWidth:= wwmax(MaxEditWidth,
               (CurFieldDisplayWidth+1) * Canvas.TextWidth('0') + 3);
      end;
      OrigMaxEditWidth:= MaxEditWidth;

      { Limit form length }
      EditStartOffset:= Margin.LeftOffset;

      if FormPosition.Width>0 then
         FormWidth:= wwMax(FormPosition.Width, NavigatorWidth + (FixedEditWidthConst-6) + Margin.RightOffset)
      else begin
         FormWidth:= RecordPanel.Left + ScrollBox.left + EditStartOffset + MaxEditWidth +
                  (FixedEditWidthConst-6) + Margin.RightOffset;
         FormWidth:= wwMax(FormWidth, NavigatorWidth + (FixedEditWidthConst-6) + Margin.RightOffset);
         FormWidth:= wwMax(FormWidth,400);
      end;

      ARect := wwGetWorkingRect;

      Width:= wwmin(FormWidth, (ARect.Right-ARect.Left)-((FixedEditWidthConst-6) + Margin.RightOffset));

      MaxEditWidth:= 0;

      lastEditHeight := 0;
      lastLabelHeight := 0;
      CurLineWidth:= 0;

      FixedEditWidth:= RecordViewForm.width - RecordViewForm.ScrollBox.left  { 6/16/97 - Substract scrollbox.left }
                      - (EditStartOffset + (FixedEditWidthConst + Margin.RightOffset));
      MaxLineWidth:= FixedEditWidth;

      for i:= 0 to numFields-1 do begin
         APos:= 1;
         curFieldReadOnly:= False;
         if (Selected.count=0) or FUseTFields then
         begin
            curField:= DAtaSource.dataset.fields[i];
            curFieldDisplayWidth:= curfield.DisplayWidth;
            curFieldDisplayLabel:= curField.displayLabel;
            curFieldReadOnly:= curField.ReadOnly;
         end
         else begin
            curField:= DAtaSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield = nil then begin
               {NEW LINE}
               curLineWidth := 0;
               PrevTop := PrevTop + EditSpacing.HorizontalView.BetweenLabelEdit+
                          LastEditHeight + EditSpacing.HorizontalView.BetweenRow +
                          LastLabelHeight;{New Top Value}
               LastEditHeight := 0;
               continue;
            end
            else begin
               curFieldDisplayWidth:= strToInt(strGetToken(Selected[i], #9, APos));
               curFieldDisplayLabel:= strGetToken(Selected[i], #9, APos);
               curFieldReadOnly := (strGetToken(Selected[i], #9, APos) = 'T');
            end
         end;

         if not ShowField(curfield, curFieldReadOnly) then continue;

         Canvas.Font := LabelFont;
         curFieldLabelWidth := (Canvas.TextWidth(curFieldDisplayLabel));
         Canvas.Font := Font;

         if (rvoMaximizeMemoWidth in Options) and
            ((wwIsCustomEditCell(self, wwGetOwnerFrameOrForm(self), curField, customEdit) and
             wwisclass(customedit.classtype,'TwwCustomRichEdit'))
             or (curField is TBlobField)) then { 9/25/98 }
            curFieldEditWidth:= FixedEditWidth
         else
            curFieldEditWidth:= (curFieldDisplayWidth+1) * Canvas.TextWidth('0') + 3;

         if (curlineWidth > 0) and
            (curLineWidth + EditSpacing.HorizontalView.BetweenEditsInRow +
             wwmax(curFieldEditWidth,curFieldLabelWidth+EditSpacing.HorizontalView.LabelIndent) > MaxLineWidth) then
         begin
            {Won't fit on current line so go to next line}
            curLineWidth := 0;
            PrevTop := PrevTop + EditSpacing.HorizontalView.BetweenLabelEdit +
                       EditSpacing.HorizontalView.BetweenRow + LastEditHeight + LastLabelHeight;{New Top Value}
            LastEditHeight := 0;
         end;

         accept:= True;
         DoOnBeforeCreateControl(RecordViewForm, curField, accept);
         if not accept then continue;

         if (rvoUseCustomControls in Options) and
            IsCheckbox(curField, checkboxOn, checkboxOff) then
            curLabel:= TwwLabel.create(Scrollbox)
         else
            curLabel:= TLabel.create(Scrollbox);
         self.curlabel:= curlabel;
         with curLabel do begin
            parent:= ScrollBox;
            font:= self.labelFont;
            { Move caption assigment before left assignment for bidi support }
            Caption:= strReplaceChar(curfieldDisplayLabel, '~', ' ');
            left:= Margin.LeftOffset+ CurLineWidth+EditSpacing.HorizontalView.LabelIndent;
            Top:= PrevTop;
            AutoSize:= False;
            Width:= Canvas.TextWidth(curFieldDisplayLabel);
            alignment:= taLeftJustify;
         end;

         if rvcTransparentLabels in ControlOptions then curLabel.transparent:= true;
         DoOnAfterCreateControl(RecordViewForm, curField, curLabel);

         LastLabelHeight := curLabel.height;
         curFieldLabelWidth := curlabel.width+EditSpacing.HorizontalView.LabelIndent;

         if (rvoUseCustomControls in Options) and
            IsCheckbox(curField, checkboxOn, checkboxOff) then
         begin
            checkbox:= TwwDBCheckBox.create(ScrollBox);
            checkbox.LabelControl:= curLabel;
            curLabel.FocusControl:= checkBox;
            with checkbox do begin
               parent:= ScrollBox;
               datasource:= self.DataSource;
               datafield:= curfield.fieldName;
               left:= EditStartOffset+curLineWidth;
               Top:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+ curlabel.Height;
               caption:= '';
               valueChecked:= checkboxOn;
               valueUnchecked:= checkboxOff;
               Width:= 17;
               if curFieldReadonly or Field.calculated then
               begin
                  tabStop:= False;
               end;
            end;
            FControlList.add(Checkbox);
            DoOnAfterCreateControl(RecordViewForm, curField, checkbox);

            curFieldEditWidth := checkbox.Width;
            MaxEditWidth:= wwmax(MaxEditWidth, checkbox.Width);
            LastEditHeight:= wwMax(LastEditHeight,checkbox.Height);
            Checkbox.Height:= LastEditHeight;
         end
         else if (rvoUseCustomControls in Options) and
            wwIsCustomEditCell(self, wwGetOwnerFrameOrForm(self), curField, customEdit) then
         with TEdit(CustomEdit) do begin
            AddCustomControl(CustomEdit);
            curLabel.FocusControl:= CustomEdit;  { 1/24/98 }

            parent:= ScrollBox;
            visible:= True;
            if not wwSetControlDataSource(customEdit, datasource) then continue;
            if not wwSetControlDataField(customEdit, curField.fieldName) then continue;
            if CustomEdit is TwwDBCustomLookupCombo then
            begin
               if not (curField.calculated or curfield.lookup) then
                  TwwDBLookupCombo(CustomEdit).RefreshDisplay;
            end;
            Ctl3d:= True;
            if not HasFrame(customEdit) then BorderStyle:= bsSingle;
            left:= EditStartOffset+curLineWidth;
            top:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+curlabel.Height;

            if (customEdit is TwwRadioGroup) and TwwRadioGroup(CustomEdit).ShowGroupCaption then
            begin
               LastLabelHeight := 0;
            end;
            if wwIsClass(customedit.classtype,'TwwCustomRichEdit') and
               (rvoMaximizeMemoWidth in Options) then
               Width:= wwMax(OrigMaxEditWidth, FixedEditWidth)
            else begin
               Width:= (curFieldDisplayWidth+1) * Canvas.TextWidth('0') + 3;
               if (Width < curlabel.width) and (rvoSetControlMinWidth in Options) then
                  Width:= curlabel.width + 1;
            end;

            if rvoShortenEditBox in Options then begin
               if Width>FixedEditWidth then Width:= FixedEditWidth;
            end;

            TEdit(CustomEdit).HandleNeeded;
            FControlList.add(CustomEdit);

            DoOnAfterCreateControl(RecordViewForm, curField, customEdit);

            curFieldEditWidth := customEdit.Width;
            MaxEditWidth:= wwmax(MaxEditWidth, customEdit.Width);
            LastEditHeight:= wwMax(LastEditHeight,customEdit.Height);
         end
         else if (curField is TDateTimeField) and
                 (rvoUseDateTimePicker in Options) then
         begin
            EditControl:= TwwDBDateTimePicker.create(ScrollBox);
            if not CreateEditControl(EditControl) then continue;
         end
         else if wwIsRichEditField(curField, True) then begin
            EditControl:= TwwDBRichEdit.create(ScrollBox);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (curField.dataType = ftMemo) then begin
            if EditFrame.IsFrameEffective then
               EditControl:= TwwDBEditMemo.create(ScrollBox)
            else
               EditControl:= TwwDBMemo.create(ScrollBox);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (curField.dataType = ftGraphic) then
         begin { 8/27/98 - Support images }
            editControl:= TDBImage.create(ScrollBox);
            if not CreateEditControl(EditControl) then continue;
         end
         else begin
            EditControl:= TwwDBEdit.create(Scrollbox);
            EditControl.controlStyle:= EditControl.ControlStyle + [csNoDesignVisible];
            if not CreateEditControl(EditControl) then continue;
         end;
         curLineWidth := curLineWidth + wwmax(curFieldEditWidth,curFieldLabelWidth)+
                         EditSpacing.HorizontalView.BetweenEditsInRow;
         realMaxLineWidth:= wwmax(realMaxLineWidth, curLineWidth - EditSpacing.HorizontalView.BetweenEditsInRow);
      end;

      CreateMainMenu(RecordViewForm, self.menu);
      PrevTop := PrevTop + EditSpacing.HorizontalView.BetweenLabelEdit +
                 LastEditHeight + LastLabelHeight + Margin.BottomOffset; {New Top Value}

      EditHeight := LastEditHeight;

      FormHeight:= (PrevTop  + RecordPanel.Top)+ 21+getsystemmetrics(SM_CYCAPTION) + ButtonPanelHeight;

      if (self.menu<>nil) and (BorderStyle<>bsDialog) then
         FormHeight:= FormHeight +  GetSystemMetrics(SM_CYMENU);
      if FormPosition.height>0 then Height:= wwMin(FormPosition.Height, FormHeight)
      else Height:= FormHeight;

      { Adjust width/height based on visibility of scrollbars }
      if Height>ARect.Bottom-ARect.Top-12 then
      begin
         Height:= ARect.Bottom-ARect.Top-12;
         {$ifdef wwDelphi4Up}
         ShowingVertScrollBar:= True;
         {$else}
         ShowingVertScrollBar:= False;
         {$endif}
      end
      else ShowingVertScrollBar:= False;
      ScrollBox.VertScrollBar.Margin:= 6;
      ScrollBox.VertScrollBar.Increment:= EditHeight + EditSpacing.HorizontalView.BetweenRow;
      ScrollBox.VertScrollBar.Range := PrevTop;
      if (RecordPanel.Height-12)<PrevTop then Width:= Width + GetSystemMetrics(SM_CXHThumb);

      FormWidth:= RecordPanel.Left + ScrollBox.left + EditStartOffset + RealMaxLineWidth +
                  (FixedEditWidthConst-6) + Margin.RightOffset;
      if Width>ARect.Right-ARect.Left then Width:= ARect.Right-ARect.Left;

      if Width<FormWidth then
         Height:= Height + GetSystemMetrics(SM_CYVThumb)
      else begin
         Width:= FormWidth; { shrink form to reduce space at the right }
         if (RecordPanel.Height-12)<PrevTop then
            Width:= Width + GetSystemMetrics(SM_CXHThumb);
      end;
      ScrollBox.HorzScrollBar.Margin:= 6;
      ScrollBox.HorzScrollBar.Range := EditStartOffset + MaxEditWidth + Margin.RightOffset;

      if ShowingVertScrollBar then
         ScrollBox.HorzScrollBar.Range:=
            ScrollBox.HorzScrollBar.Range - GetSystemMetrics(SM_CXHThumb);

      if (rvokShowOKCancel in OKCancelOptions) then begin
        ButtonPanel.Width := Width;
        OKBtn.Left:= (ButtonPanel.Width - 10) - ((OKBtn.Width + Spacing) * 2);
        CancelBtn.Left:= (ButtonPanel.Width-10) - ((OKBtn.Width + Spacing) * 1);
      end;
   end;

end;

{*****************************************************}

procedure TwwRecordViewDialog.SetNavParent(NewParent: TWinControl; SaveOld: Boolean);
begin
  FNavigator.Visible := SaveOld;
  if SaveOld then begin
    FOldNavParent := FNavigator.Parent;
//    FNavigator.SetDesigning(False);
  end else begin
//    if FNavigator.Owner <> nil then FNavigator.SetDesigning(csDesigning in FNavigator.Owner.ComponentState);
    FNavigator.Parent := NewParent;
  end;
end;

Function TwwRecordViewDialog.Execute: boolean;
var ARect:TRect;
    bottompad:integer;
    i: integer;
begin
   Result := false;
   if (datasource=nil) or (datasource.dataset=nil) then begin
      MessageDlg('DataSource or DataSource.DataSet not defined.', mtWarning, [mbok], 0);
      exit;
   end;

   if not (datasource.dataset.active) then begin
      MessageDlg('DataSet must be active.', mtWarning, [mbok], 0);
      exit;
   end;

   CloseAction := rvcControlMenuClose;

   if RecordViewForm<>Nil then
   begin
      RecordViewForm.show;
      exit;
   end
   else begin
      RecordViewForm:= TwwRecordViewForm.create(Application);
      RecordViewForm.BorderStyle:= BorderStyle;
      RecordViewForm.DlgComponent:= self;
   end;

   FControlList.clear;
   FLabelList.clear;

   with RecordViewForm do begin
      Caption:= self.caption;

      Font.Assign(self.font);
      KeyPreview:= True;
{      OnKeyDown:= FormKeyDown;}
      OnShow:= FormShow;
      OnClose:= FormClose;
      OnCloseQuery:=FormCloseQuery;

      if not (rvoHideNavigator in Options) then begin
         NavigatorPanel:= TPanel.create(RecordViewForm);
         with NavigatorPanel do begin
           Parent:= RecordViewForm;
           Left := 0;
           Top := 0;
           Align := alTop;
           TabOrder := 0;
         end;
         if FNavigator <> nil then begin
           Navigator := FNavigator;        // -ksw (6/17/98)
           SetNavParent(NavigatorPanel, True);
         end else begin
           Navigator := TwwDBNavigator.create(NavigatorPanel); // -ksw (6/17/98)
           Navigator.AutoSizeStyle := asNone;
           Navigator.ShowHint:= True;
           Navigator.Flat:= NavigatorFlat;
           Navigator.VisibleButtons := FNavigatorButtons;
         end;
         with Navigator do begin
           Parent := NavigatorPanel;    {!!!!! Changed from RecordViewForm}

           Left := 8;
           Top := 8;
//           Width := 240;
           Height := 25;
           DataSource := self.DataSource;
           TabOrder := 0;
           {$ifdef wwDelphi3Up}
           if Flat then begin
              Top:= 1;
              NavigatorPanel.height:= height+2;
           end
           {$endif}
         end;
      end
      else begin
      end;

      RecordPanel:= TPanel.create(RecordViewForm);
      with RecordPanel do begin
         parent:= RecordViewForm;
         Left := 0;
         Top := 41;
         Align := alClient;
         BevelInner := bvLowered;
         BorderWidth := 4;
         Caption := '';
         TabOrder := 1;
         Name:= 'RecordPanel';
         visible:= True;
      end;


      if (rvokShowOKCancel in OKCancelOptions) then begin
         ButtonPanel:= TPanel.create(RecordViewForm);
         with ButtonPanel do begin
            parent:= RecordViewForm;
            Left := 0;
            Top := 0;
            Align := alBottom;
            Name:= 'UserPanel';
            Caption := '';
            TabOrder := 0;
            visible:= True;

            OkBtn:= TButton(wwCreateCommonButton(RecordViewForm, bkOK));
            OKBtn.Default:= not (rvoEnterToTab in Options);
            OkBtn.parent:= ButtonPanel;
            OKBtn.visible:= True;
            OKBtn.OnClick := OKBtnClick;
            OKBtn.TabStop:= False;

            CancelBtn:= TButton(wwCreateCommonButton(RecordViewForm, bkCancel));
            CancelBtn.Parent := ButtonPanel;
            CancelBtn.visible:= True;
            CancelBtn.OnClick := CancelBtnClick;
            CancelBtn.TabStop:= False;
            CancelBtn.Cancel:= False; { Allows Escape to be processed }

            bottomPad := 1 + GetSystemMetrics(SM_CYDLGFRAME)*2 +8 +1;  {Win95 fix }
            Height := OkBtn.Top + OkBtn.height + BottomPad;

            OkBtn.Top := GetSystemMetrics(SM_CYDLGFRAME) + 5;
            CancelBtn.Top := GetSystemMetrics(SM_CYDLGFRAME) +5;
         end;
      end;

      ScrollBox:= TScrollBox.create(RecordPanel);
//      TwwRecordViewScrollBox(ScrollBox).Dialog:= self;

      with ScrollBox do begin
         parent:= RecordPanel;
         Left := 6;
         Top := 6;
         Align := alClient;
         AutoScroll := False;
         BorderStyle := bsNone;
         TabOrder := 0;
         visible:= True;
      end;

      if (Style = rvsVertical) then
         DisplayVertical
      else
         DisplayHorizontal;

      { 5/21/97 - Reset modified flag to False }
      for i:= 0 to FControlList.count-1 do begin
         if (TWinControl(FControlList.items[i]) is TWinControl) then { 8/27/98 }
            TCustomEdit(FControlList.items[i]).Modified := False;
      end;

      { Position form on screen }
      ARect := wwGetWorkingRect;

      if FormPosition.Left>0 then Left:= FormPosition.Left
      else Left:= ARect.Left+(((ARect.Right-ARect.Left) - RecordViewForm.Width) div 2);

      if FormPosition.Top>0 then Top:= FormPosition.Top
      else Top:= ARect.Top+ (((ARect.Bottom-ARect.Top)-RecordViewForm.height) div 2);

      if (NavigatorPanel<>Nil) and (Navigator<>Nil) then { 7/28/98 }
         Navigator.width:= NavigatorPanel.Width - 10;

      OnResize:= FormResize;

      if rvoModalForm in Options then begin
         result:= ShowModal=mrOK;
         if FNavigator <> nil then SetNavParent(FOldNavParent, False);
         Free;
      end
      else begin
         Show;
         ModalResult := mrCancel;
         result:= True;
      end;
   end;
end;

procedure TwwRecordViewDialog.FormClose(Sender: TObject; var Action: TCloseAction);
var i: integer;
    customEdit: TWinControl;
    customItem: TwwCustomControlItem;
begin
   if (Sender is TForm) then
      try
         DoCloseDialog(Sender as TwwRecordViewForm);
      except
         Action:= caNone;
         exit;
      end;

   if (Sender is TForm) then with (Sender as TForm) do begin
      if (rvokAutoCancelRec in OKCancelOptions) and (ModalResult = mrCancel) then
      begin
         DataSource.DataSet.Cancel;
      end
      else begin
         if (ActiveControl is TWinControl) then ActiveControl.Perform(CM_Exit,0,0);
         if (rvokAutoPostRec in OKCancelOptions) and (ModalResult = mrOK) then
         begin
            Datasource.Dataset.CheckBrowseMode
         end
      end;
      Menu:= Nil;
   end;

   if not (rvoModalForm in Options) then
   begin
     if FNavigator <> nil then SetNavParent(FOldNavParent, False);
     Action:= caFree;
   end;

   for i:= 0 to CustomControlList.count-1 do begin

      customItem:= TwwCustomControlItem(CustomControlList[i]);
      customEdit:= customItem.control;
      if customEdit.parent<>RecordViewform.ScrollBox then continue;

      customEdit.visible:= False;
      customEdit.parent:= customItem.OldParent; //wwGetOwnerForm(self);
      customEdit.left:= customItem.left;
      customEdit.Top:= customItem.Top;
      customEdit.Width:= customItem.Width;
      customEdit.Height:= customItem.Height;
      if (not (csDesigning in ComponentState)) then
      begin
         if wwIsClass(customEdit.parent.classType, 'TwwDBGrid') then
         begin
            TEdit(customEdit).ctl3d:= False;
            TEdit(customEdit).BorderStyle:= bsNone;
            if HasButtonEffects(customEdit) then
            begin
               TwwButtonEffects.Get(customEdit).Transparent:= customItem.ButtonTransparent;
               TwwButtonEffects.Get(customEdit).Flat:= customItem.ButtonFlat;
            end
         end
      end
   end;

   // Previously not release
   for i:= 0 to CustomControlList.count-1 do TwwCustomControlItem(CustomControlList[i]).Free;
   CustomControlList.Clear;

   RecordViewForm:= nil;

end;

procedure TwwRecordViewDialog.FormResize(Sender: TObject);
var i :integer;
    FixedEditWidth: integer;
    minwidth:integer;
begin
   if (rvoConsistentEditWidth in Options) and (Style=rvsVertical) then begin
     FixedEditWidth:= (Sender as TForm).width - (EditStartOffset + FixedEditWidthConst + Margin.RightOffset);
     if (Sender as TForm).Height < FormHeight then
        dec(FixedEditWidth, GetSystemMetrics(SM_CXHThumb));
     for i:= 0 to FControlList.count-1 do begin
        TEdit(FControlList.items[i]).width:= FixedEditWidth;
     end;
   end;

   if (rvokShowOKCancel in OKCancelOptions) then begin
      minWidth:= OkBtn.width + CancelBtn.width + 2*Spacing + 5;

      OKBtn.Left:= ((Sender as TForm).Width - 10) - ((OKBtn.Width + spacing) * 2);
      CancelBtn.Left:= ((Sender as TForm).Width - 10) - ((OKBtn.Width + Spacing) * 1);

      if ((Sender as TForm).width -10 < minWidth) then begin
         OkBtn.Left:= 5;
         CancelBtn.Left := OkBtn.Width + 5 + Spacing;
      end;
   end;
   with RecordViewForm do
     if (NavigatorPanel<>Nil) and (Navigator<>Nil) then { 4/9/99 - Resize navigator}
        Navigator.width:= NavigatorPanel.Width - 10;

   if Assigned(FOnResizeDialog) then FOnResizeDialog(RecordViewForm);
end;

procedure TwwRecordViewDialog.OKBtnClick(Sender: TObject);
begin
   CloseAction := rvcOK;
   RecordViewForm.ModalResult:=mrOK;
   RecordViewForm.Close;
end;

procedure TwwRecordViewDialog.CancelBtnClick(Sender: TObject);
begin
   CloseAction := rvcCancel;
   RecordViewForm.ModalResult:=mrCancel;
   RecordViewForm.Close;
end;

Procedure TwwRecordViewDialog.CreateMainMenu(
   Form: TwwRecordViewForm; mm: TMainMenu);
begin
   if (mm=nil) or (mm.items.count=0) then exit;
   Form.Menu:= mm;
end;


procedure TwwRecordViewDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
var j: integer;
   customItem: TwwCustomControlItem;
begin

  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil

  else if (Operation=opRemove) and (Menu=AComponent) then
  begin
     Menu:= nil;

     with wwGetOwnerForm(Self) do begin
        if (Designer<>Nil) then begin
           Designer.Notification(AComponent, Operation);
        end
     end
  end
  else if (Operation = opRemove) and (AComponent = FNavigator) then
    FNavigator := nil;

  { 3/5/98 - OldParent is destroyed so reset oldparent value }
  if (Operation = opRemove) and (CustomControlList<>nil) then // 10/5/00 - Fix design-time delete problem
  begin
     for j:= CustomControlList.count-1 downto 0 do begin { 9/18/98 - Scan backwards }
//     for j:= 0 to CustomControlList.count-1 do begin
         customItem:= TwwCustomControlItem(CustomControlList[j]);
         if AComponent = customItem.oldParent then
         begin
            customItem.oldParent:= (self.owner as TWinControl);
         end
     end
  end

end;


Function TwwRecordViewDialog.IsModified: boolean;
var i: integer;
begin
   result := false;
   for i:= 0 to FControlList.count-1 do begin
      if not (TWinControl(FControlList.items[i]) is TWinControl) then
         continue; {8/27/98 }
      if IsControlModified(FControlList.Items[i]) then
         result:= True;
//      if (TWinControl(FControlList.items[i]).Modified) then
//         result := True;
   end;
end;

procedure TwwRecordViewDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var answer: integer;
begin
   if CloseAction=rvcControlMenuClose then begin
      if not (rvoCloseIsCancel in Options) then RecordViewForm.ModalResult:= mrOK;
   end
   else if CloseAction=rvcOK then begin
      RecordViewForm.ModalResult:= mrOK;
      exit;
   end;

   if RecordViewForm.ModalResult=mrOK then exit;

   if ((IsModified) or
        { 5/27/97 - Confirm cancel if record was changed before entering dialog}
       (rvokAutoCancelRec in OKCancelOptions) and (DataSource.DataSet.state<>dsBrowse))
      and (rvoConfirmCancel in Options) then
   begin
      if Assigned(FOnCancelWarning) then
         DoCancelWarning(CanClose)
      else begin
         answer:= MessageDlg(wwInternational.UserMessages.RecordViewExitWarning,
               mtConfirmation, [mbYes, mbNo, mbCancel], 0);

         if (answer = mrYes) then begin
            RecordViewForm.ModalResult:= mrOK;
         end
         else if (answer = mrNo) then begin
            RecordViewForm.ModalResult:= mrCancel;
         end
         else CanClose:= False;
      end
   end
   else RecordViewForm.ModalResult:= mrCancel;

end;

procedure TwwRecordViewForm.FormDeactivate(Sender: TObject);
var WinAttribute: HWnd;
begin
   if (DlgComponent<>Nil) and (rvoStayOnTopForm in (DlgComponent as TwwRecordViewDialog).Options) then
   begin
      WinAttribute:= HWND_TOPMOST;
      SetWindowPos(Handle, WinAttribute, 0, 0, 0, 0,
        SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      if ActiveControl<>nil then
         ActiveControl.invalidate;  { Windows redraw bug for focused control }
      Deactivated:= True;
   end
end;

procedure TwwRecordViewForm.FormActivate(Sender: TObject);
var WinAttribute: HWnd;
begin
   if Deactivated then begin
      WinAttribute:= HWND_NOTOPMOST;
      SetWindowPos(Handle, WinAttribute, 0, 0, 0, 0,
        SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      Deactivated:= False;
   end
end;

procedure TwwLabel.WMPaint(var Message: TWMPaint);
var ARect: TRect;
begin
   inherited;
   if (FocusControl<>Nil) and FocusControl.Focused then
   begin
      ARect := GetClientRect;
      Canvas.Pen.Color:= clGray;
      Canvas.Pen.Width:= 1;
      Canvas.Pen.Style:= psDot;
      Canvas.Polygon([Point(ARect.Left, ARect.Top), Point(ARect.Left, ARect.Bottom-1),
                      Point(ARect.Right-1, ARect.Bottom-1), Point(ARect.Right-1, ARect.Top)]);
{      Canvas.Brush.Color:= clBlack;
      Canvas.Brush.Style:= bsVertical;
      Canvas.FrameRect(ARect);}
   end
end;


procedure TwwDBCheckBox.DoEnter;
begin
   inherited DoEnter; // 4/22/02
   labelControl.invalidate;
end;

procedure TwwDBCheckBox.DoExit;
begin
   inherited DoExit; // 4/22/02
   labelControl.invalidate;
end;

procedure NotifyOwnerWindow(AOwner: TComponent);
type sizetype = record
       x: word;
       y: word;
     end;
var point: sizetype;
begin
   if AOwner=nil then exit;

   if (csLoading in AOwner.ComponentState) then exit;
   if not (csDesigning in AOwner.ComponentState) then exit;
   
   if AOwner is TWinControl then with (AOwner as TWiNControl) do
   begin
      if not Showing then exit;

      point.x:= width;
      point.y:= height;
      SendMessage(handle, WM_SIZE, SIZE_RESTORED,
         longint(point));
   end
end;

procedure TwwMargin.SetLeftOffset(val: integer);
begin
   FLeftOffset:= val;
   NotifyOwnerWindow(Owner);
end;
procedure TwwMargin.SetRightOffset(val: integer);
begin
   FRightOffset:= val;
   NotifyOwnerWindow(Owner);
end;
procedure TwwMargin.SetTopOffset(val: integer);
begin
   FTopOffset:= val;
   NotifyOwnerWindow(Owner);
end;
procedure TwwMargin.SetBottomOffset(val: integer);
begin
   FBottomOffset:= val;
   NotifyOwnerWindow(Owner);
end;

procedure TwwHorzEditSpacing.SetBetweenEditsInRow(val: integer);
begin
   FBetweenEditsInRow:= val;
   NotifyOwnerWindow(Owner);
end;

procedure TwwHorzEditSpacing.SetBetweenLabelEdit(val: integer);
begin
   FBetweenLabelEdit:= val;
   NotifyOwnerWindow(Owner);
end;

procedure TwwHorzEditSpacing.SetBetweenRow(val: integer);
begin
   FBetweenRow:= val;
   NotifyOwnerWindow(Owner);
end;

procedure TwwHorzEditSpacing.SetLabelIndent(val: integer);
begin
   FLabelIndent:= val;
   NotifyOwnerWindow(Owner);
end;

procedure TwwVertEditSpacing.SetBetweenLabelEdit(val: integer);
begin
   FBetweenLabelEdit:= val;
   NotifyOwnerWindow(Owner);
end;

procedure TwwVertEditSpacing.SetBetweenRow(val: integer);
begin
   FBetweenRow:= val;
   NotifyOwnerWindow(Owner);
end;

procedure TwwRecordViewDialog.SetNavigator(Value: TwwDBNavigator);
begin
  if FNavigator <> Value then
  begin
    FNavigator := Value;
    if FNavigator <> nil then FNavigator.Visible := False;  // Hadn't checked if nil and got AV's.  -ksw (10/12/98)
  end;
end;

function TwwRecordViewDialog.GetPrimaryDataSet: TDataSet;
begin
  if DataSource = nil then result := nil else result := DataSource.DataSet;
end;

function TwwRecordViewDialog.IsSingleLineEditControl(EditControl: TWinControl): boolean;
begin
   result:= ((EditControl is TwwDBEdit) or (EditControl is TwwDBDateTimePicker));
end;

procedure TwwRecordViewDialog.SetNavigatorVisibleButtons(Value: TButtonSet);
var i: TNavigateBtn;
begin
  Exit;
  FNavigatorButtons := [];
  for i := Low(TNavigateBtn) to High(TNavigateBtn) do
    if i in Value then Include(FNavigatorButtons, TwwNavButtonNavStyle(i));
end;

procedure TwwRecordViewDialog.SetPictureMasks(val: TStrings);
begin
   FPictureMasks.assign(val);
end;

procedure TwwRecordViewDialog.SetControlType(val: TStrings);
begin
   ControlType.assign(val);
end;


{
procedure TwwRecordViewDialog.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('NavigatorVisibleButtons', NavVisButtonsReadProc,
    NavVisButtonsWriteProc, False);
end;

procedure TwwRecordViewDialog.NavVisButtonsReadProc(Reader: TReader);
  function ReadSet: TButtonSet;
  var EnumName: string;
  begin
    Result := [];
    while True do
    begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(Result, TNavigateBtn(GetEnumValue(TypeInfo(TNavigateBtn), EnumName)));
    end;
  end;
var AButtonSet: TButtonSet;
    i: TNavigateBtn;
begin
  AButtonSet := ReadSet;
  for i := Low(TNavigateBtn) to High(TNavigateBtn) do
    if i in AButtonSet then Include(FNavigatorButtons, TwwNavButtonNavStyleEx(i));
end;

procedure TwwRecordViewDialog.NavVisButtonsWriteProc(Writer: TWriter);
begin
  // Do Nothing (Property only used for streaming in)
end;
}
(*
procedure TwwRecordViewScrollBox.WMPaint(var Message: TWMPaint);
{var tempBitmap: TBitmap;
    UpdateRect: TRect;
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;
}
begin
{
   GetUpdateRect(Handle, UpdateRect, False);
   if (UpdateRect.Top=0) and (UpdateRect.Bottom=0) and
      (UpdateRect.Left=0) and (UpdateRect.Right=0) then
      UpdateRect:= FCanvas.ClipRect;
}
   inherited;

{   if Assigned((Dialog as TwwRecordViewDialog).FOnBeforePaint) then
   begin
      CanvasNeeded;
      FCanvas.Handle:= message.DC;
      tempBitmap:= TBitmap.create;
      tempBitmap.Width:= Width;
      tempBitmap.Height:= Height;

      tempBitmap.Canvas.CopyRect(UpdateRect, FCanvas, UpdateRect);
      (Dialog as TwwRecordViewDialog).FOnBeforePaint(self, tempBitmap.Canvas);
      FCanvas.CopyRect(UpdateRect, tempBitmap.Canvas, UpdateRect);
      FCanvas.Handle:= 0;
      tempBitmap.Free;
   end;
}
{
   tempBitmap:= TBitmap.create;
   tempBitmap.width:= Width;
   tempBitmap.height := height;
   tempBitmap.Canvas.Handle:= message.dc;
   tempBitmap.canvas.brush.color:= color;
   tempBitmap.Canvas.FillRect(ClientRect);
   if Assigned((Dialog as TwwRecordViewDialog).FOnBeforePaint) then
   begin
      (Dialog as TwwRecordViewDialog).FOnBeforePaint(tempBitmap.Canvas);
   end;
   tempBitmap.Free;
}
end;

destructor TwwRecordViewScrollBox.Destroy;
begin
   inherited;
   FCanvas.Free;
end;
*)
end.

