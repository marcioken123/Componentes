unit LMDRTFActions;
{$I LMDCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDRTFActions unit (RM)
-----------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, ActnList, Dialogs, Graphics, Controls,
  LMDRTFRichEdit {$IFDEF LMDCOMP17}, System.Actions{$ENDIF};

const
  sDefaultFilter='Rich Text files (*.rtf)|*.rtf|Text Files (*.txt)|*.txt|All Files (*.*)|*.*';

type
  TLMDAllowExecuteEvent = procedure(Sender: TObject; var Allow: Boolean) of object;

{ **************************  TLMDRichBaseEditAction  ************************* }
  TLMDRichEditAction = class(TAction)
  private
    FControl: TLMDCustomRichEdit;
    FOnAllowExecute: TLMDAllowExecuteEvent;
    FOnAfterExecute: TNotifyEvent;
    procedure SetControl(Value: TLMDCustomRichEdit);
  protected
    procedure AfterExecute; virtual;
    function  AllowExecute: Boolean; virtual;
    function GetControl(Target: TObject): TLMDCustomRichEdit; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function  IsEnabled(Target: TObject): Boolean; virtual;
    function  CanChange(Target: TObject): Boolean;
    function  HasData(Target: TObject): Boolean;
    function  HasSelected(Target: TObject): Boolean;
    function  vExecuteTarget(RichEdit: TLMDCustomRichEdit): Boolean; virtual;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
    property Control: TLMDCustomRichEdit read FControl write SetControl;
  published
    property OnAllowExecute: TLMDAllowExecuteEvent read FOnAllowExecute write FOnAllowExecute;
    property OnAfterExecute: TNotifyEvent read FOnAfterExecute write FOnAfterExecute;
  end;

  TLMDRichEditActionClass = class of TLMDRichEditAction;

{ **************************  TLMDRichEditOutTo  ************************** }
  TLMDRichEditOutTo = class(TLMDRichEditAction)
  private
  protected
  public
    procedure UpdateTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditActionEdit  ********************* }
  TLMDRichEditBaseEditAction = class(TLMDRichEditAction)
  private
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
  end;

{ **************************  TLMDRichEditNew  **************************** }
  TLMDRichEditNew = class(TLMDRichEditAction)
  protected
    function  vExecuteTarget(RichEdit: TLMDCustomRichEdit): Boolean; override;
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

{ **************************  TLMDRichEditLoad  *************************** }
  TLMDRichEditLoad = class(TLMDRichEditAction)
  private
    FDefaultExt: string;
    FFilter: string;
    FInitialDir: string;
    FOptions: TOpenOptions;
    FTitle: string;
    function IsCustom:Boolean;
  protected
    function  vExecuteTarget(RichEdit: TLMDCustomRichEdit): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property DefaultExt: string read FDefaultExt write FDefaultExt;
    property Filter: string read FFilter write FFilter stored IsCustom;
    property InitialDir: string read FInitialDir write FInitialDir;
    property Options: TOpenOptions read FOptions write FOptions;
    property Title: string read FTitle write FTitle;
  end;

  TLMDRichEditSaveEvent=procedure(Sender:TObject; Target:TObject; var Saved:Boolean) of object;

  { **************************  TLMDRichEditSave  *************************** }
  TLMDRichEditSave = class(TLMDRichEditOutTo)
  private
    FSaved: Boolean;
    FOnUnNamedFile:TLMDRichEditSaveEvent;
  protected
    //function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    property  Saved: Boolean read FSaved;
  published
    property OnUnknownFilename:TLMDRichEditSaveEvent read FOnUnNamedFile write FOnUnNamedFile;
  end;

{ **************************  TLMDRichEditSaveAs  *************************** }
  TLMDRichEditSaveAs = class(TLMDRichEditLoad)
  private
    FSaved:Boolean;
  protected
    //function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    property Saved:Boolean read FSaved;
  end;

  TFindDialogClass=class of TFindDialog;

  { **************************  TLMDRichEditFind  **************************** }
  TLMDRichEditFind = class(TLMDRichEditAction)
  private
    FDialog:TFindDialog;
    FDlgOnShow,
    FDlgOnClose:TNotifyEvent;
    FRichEdit: TLMDCustomRichEdit;
    DialogClass:TFindDialogClass;
    procedure DoFindReplace(Sender: TObject);
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property OnDlgClose:TNotifyEvent read FDlgOnClose write FDlgOnClose;
    property OnDlgShow:TNotifyEvent read FDlgOnShow write FDlgOnShow;
  end;

  { **************************  TLMDRichEditReplace  ************************* }
  TLMDRichEditReplace = class(TLMDRichEditFind)
  public
    constructor Create(aOwner: TComponent); override;
  end;

{ **************************  TLMDRichEditParagraph  ************************ }
  TLMDRichEditParagraph = class(TLMDRichEditBaseEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditParaAlign  ************************ }
  TLMDRichEditParaAlign = class(TLMDRichEditBaseEditAction)
  private
    FAlignment: TLMDParaAlignment;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property Alignment: TLMDParaAlignment read FAlignment write FAlignment default paLeftJustify;
  end;

{ **************************  TLMDRichEditParaAlignLeft  ******************** }
  TLMDRichEditParaAlignLeft = class(TLMDRichEditParaAlign)
  public
    constructor Create(aOwner: TComponent); override;
  end;

{ **************************  TLMDRichEditParaAlignCenter  ****************** }
  TLMDRichEditParaAlignCenter = class(TLMDRichEditParaAlign)
  public
    constructor Create(aOwner: TComponent); override;
  end;

{ **************************  TLMDRichEditParaAlignRight  ******************* }
  TLMDRichEditParaAlignRight = class(TLMDRichEditParaAlign)
  public
    constructor Create(aOwner: TComponent); override;
  end;

{ **************************  TLMDRichEditNumbering  ************************ }
  TLMDRichEditNumbering = class(TLMDRichEditBaseEditAction)
  private
    FFirstIndent,
    FLeftIndent:Integer;
    FNumbering: TLMDNumbering;
    FNumberingStyle: TLMDNumberingStyle;
    FNumberingStart: LongInt;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property Numbering: TLMDNumbering read FNumbering write FNumbering;
    property NumberingStyle: TLMDNumberingStyle read FNumberingStyle write FNumberingStyle;
    property NumberingStart: LongInt read FNumberingStart write FNumberingStart default 1;
    property FirstIndent:Integer read FFirstIndent write FFirstIndent default -10;
    property LeftIndent:Integer read FLeftIndent write FLeftIndent default 10;
  end;

{ **************************  TLMDRichEditNumberingBullet  ****************** }
  TLMDRichEditNumberingBullet = class(TLMDRichEditNumbering)
  public
    constructor Create(aOwner: TComponent); override;
  end;

{ **************************  TLMDRichEditNumberingArabicNumbers  *********** }
  TLMDRichEditNumberingArabicNumbers = class(TLMDRichEditNumbering)
  public
    constructor Create(aOwner: TComponent); override;
  end;
  { **************************  TLMDRichEditTextAttributes  ******************* }
  TLMDRichEditTextAttributes = class(TLMDRichEditBaseEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditTextFontStyle  ******************** }
  TLMDRichEditTextFontStyle = class(TLMDRichEditBaseEditAction)
  protected
    function  FontStyle: TFontStyles; virtual;
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditTextBold  ************************* }
  TLMDRichEditTextBold = class(TLMDRichEditTextFontStyle)//TLMDRichEditBaseEditAction)
  protected
    function  FontStyle: TFontStyles; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

{ **************************  TLMDRichEditTextItalic  *********************** }
  TLMDRichEditTextItalic = class(TLMDRichEditTextFontStyle)//TLMDRichEditBaseEditAction)
  protected
    function  FontStyle: TFontStyles; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

{ **************************  TLMDRichEditTextUnderline  ******************** }
  TLMDRichEditTextUnderline = class(TLMDRichEditBaseEditAction)
  private
    FUnderlineType: TLMDUnderlineType;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property UnderlineType: TLMDUnderlineType read FUnderlineType write FUnderlineType default utSolid;
  end;

{ **************************  TLMDRichEditTextSubscript  ******************** }
  TLMDRichEditTextSubscript = class(TLMDRichEditBaseEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditTextSuperscript  ****************** }
  TLMDRichEditTextSuperscript = class(TLMDRichEditBaseEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditUndo  ***************************** }
  TLMDRichEditUndo = class(TLMDRichEditBaseEditAction)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditRedo  ***************************** }
  TLMDRichEditRedo = class(TLMDRichEditBaseEditAction)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditPrint  ***************************** }
  TLMDRichEditPrint = class(TLMDRichEditOutTo)
  private
    FShowDialog:Boolean;
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property ShowDialog:Boolean read FShowDialog write FShowDialog default false;
  end;

{ **************************  TLMDRichEditPreview  ************************** }
  TLMDRichEditPreview = class(TLMDRichEditOutTo)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ **************************  TLMDRichEditPageSetting  ********************** }
  TLMDRichEditPageSetting = class(TLMDRichEditOutTo)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditCut  **************************** }
  TLMDRichEditCut = class(TLMDRichEditBaseEditAction)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditCopy  *************************** }
  TLMDRichEditCopy = class(TLMDRichEditAction)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditPaste  ************************** }
  TLMDRichEditPaste = class(TLMDRichEditBaseEditAction)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditInsertObject  ******************* }
  TLMDRichEditInsertObject = class(TLMDRichEditBaseEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditObjectProperties  *************** }
  TLMDRichEditObjectProperties = class(TLMDRichEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditPasteSpecial  ******************* }
  TLMDRichEditPasteSpecial = class(TLMDRichEditBaseEditAction)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditSelectAll  ********************** }
  TLMDRichEditSelectAll = class(TLMDRichEditAction)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditDelete  ************************* }
  TLMDRichEditDelete = class(TLMDRichEditBaseEditAction)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditIndent  ************************* }
  TLMDRichEditIndent = class(TLMDRichEditBaseEditAction)
  private
    FIndent: integer;
    procedure SetIndent(V: integer);
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property  IndentValue: integer read FIndent write SetIndent default 10;
  end;

{ ****************************  TLMDRichEditUnindent  *********************** }
  TLMDRichEditUnindent = class(TLMDRichEditIndent)
  protected
    function  IsEnabled(Target: TObject): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditInsertChar  ********************** }
  TLMDRichEditInsertChar = class(TLMDRichEditBaseEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditInsertDateTime  ****************** }
  TLMDRichEditInsertDateTime = class(TLMDRichEditBaseEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRichEditStatistics  ********************** }
  TLMDRichEditStatistics = class(TLMDRichEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ ****************************  TLMDRTFSupportedAction  ********************** }
  TLMDRTFSupportedAction = class(TList)
  public
    constructor Create;
    destructor Destroy; override;
    function ClassName(Index: Integer): ShortString;
    function GetAction(Index: Integer): TLMDRichEditAction;
  end;

implementation

uses
  Clipbrd, Windows, SysUtils,
  LMDRTFConst;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{ ****************************  TLMDRichEditAction  *********************** }
{ ------------------------------------------------------------------------- }

function TLMDRichEditAction.GetControl(Target: TObject): TLMDCustomRichEdit;
begin
  Result:= Target as TLMDCustomRichEdit;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result:= ((Control <> nil) and (Target = Control) or
    (Control = nil) and (Target is TLMDCustomRichEdit)) and
    TLMDCustomRichEdit(Target).Focused;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Control) then Control:= nil;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditAction.UpdateTarget(Target: TObject);
begin
  Enabled := IsEnabled(Target);
end;

{ ------------------------------------------------------------------------- }
function  TLMDRichEditAction.IsEnabled(Target: TObject): Boolean;
begin
  Result := True;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichEditAction.SetControl(Value: TLMDCustomRichEdit);
begin
  if Value <> FControl then
    begin
      FControl:= Value;
      if Assigned(Value)  then Value.FreeNotification(Self);
    end;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditAction.CanChange(Target: TObject): Boolean;
var
  Ctrl: TLMDCustomRichEdit;
begin
  if  (Target is TLMDCustomRichEdit)  then
    begin
      Ctrl := TLMDCustomRichEdit(Target);

      Result := NOT Ctrl.ReadOnly and Ctrl.Focused
        {and not Ctrl.SelAttributes.Protected};
    end
  else
    Result := False;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditAction.HasData(Target: TObject): Boolean;
var
  Ctrl: TLMDCustomRichEdit;
begin
  Ctrl := GetControl(Target);
  Result := Assigned(Ctrl) and (Ctrl.Lines.Count > 0);
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditAction.HasSelected(Target: TObject): Boolean;
var
  Ctrl: TLMDCustomRichEdit;
begin
  Ctrl := GetControl(Target);
  Result := Assigned(Ctrl) and (Ctrl.SelLength > 0);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditAction.AfterExecute;
begin
  if  Assigned(FOnAfterExecute) then
    FOnAfterExecute(self);
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditAction.AllowExecute: Boolean;
begin
  Result := Enabled;
  if  Assigned(FOnAllowExecute) then
    FOnAllowExecute(self, Result);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditAction.ExecuteTarget(Target: TObject);
var
  Ctrl: TLMDCustomRichEdit;
begin
  Ctrl := GetControl(Target);
  if  Assigned(Ctrl) and AllowExecute and vExecuteTarget(Ctrl)  then
    AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditAction.vExecuteTarget(RichEdit: TLMDCustomRichEdit): Boolean;
begin
  Result := False;
end;

{ **************************  TLMDRichEditOutTo  ************************** }

procedure TLMDRichEditOutTo.UpdateTarget(Target: TObject);
begin
  Enabled := IsEnabled(Target) {and HasData(Target)};
end;

{ ****************************  TLMDRichEditBaseEditAction  ******************* }
(*
procedure TLMDRichEditBaseEditAction.UpdateTarget(Target: TObject);
begin
//  inherited ;
  Enabled := {CanChange(Target) and }IsEnabled(Target);
end;
*)
{ ------------------------------------------------------------------------- }

function  TLMDRichEditBaseEditAction.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and CanChange(Target);
end;

{ ------------------------------------------------------------------------- }

{ ****************************  TLMDRichEditNew  ************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDRichEditNew.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Caption:= IDRTF_ANEW;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }
function  TLMDRichEditNew.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target);
   // and {(HasData(Target) or} GetControl(Target).Modified;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditNew.vExecuteTarget(RichEdit: TLMDCustomRichEdit): Boolean;
begin
  RichEdit.Clear;
  RichEdit.Title:='';
  RichEdit.Modified:=False;
  Result := True;
end;

{ ****************************  TLMDRichEditLoad  ************************* }
{ ------------------------------------------------------------------------- }
function TLMDRichEditLoad.IsCustom: Boolean;
begin
  result:=FFilter<>sDefaultFilter;
end;

{ ------------------------------------------------------------------------- }
constructor TLMDRichEditLoad.Create(aOwner: TComponent);
begin
  inherited;
  DefaultExt:= 'rtf';
  Filter:=sDefaultFilter;
  InitialDir:= '';
  Options:= [{ofHideReadOnly, }ofEnableSizing];
  Title:= '';
  Caption:= IDRTF_AOPEN;
  Hint:= Caption;
end;

{------------------------------------------------------------------------------}
function  TLMDRichEditLoad.vExecuteTarget(RichEdit: TLMDCustomRichEdit): Boolean;
//procedure TLMDRichEditLoad.ExecuteTarget(Target: TObject);
begin
  Result := False;
  with TOpenDialog.Create(nil) do
    begin
      try
        DefaultExt:= FDefaultExt;
        Filter:= FFilter;
        InitialDir:= FInitialDir;
        Options:= FOptions;
        Title:= FTitle;
        if Execute then
          begin
            RichEdit.Clear;
            RichEdit.Lines.LoadFromFile(FileName);
            RichEdit.Title:= FileName;
            RichEdit.ReadOnly:= ofReadOnly in Options;
//            RichEdit.Paragraph.ClearToDefaults;
            RichEdit.Modified := False;
            Result := True;
          end;
      finally
        Free;
      end;
    end;
end;

{ ****************************  TLMDRichEditSave  ************************* }
{ ------------------------------------------------------------------------- }
constructor TLMDRichEditSave.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ASAVE;
  Hint:= Caption;
  FSaved := False;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichEditSave.ExecuteTarget(Target: TObject);
begin
  FSaved := False;
  if GetControl(Target).Title <> '' then
    begin
      GetControl(Target).Lines.SaveToFile(GetControl(Target).Title);
      GetControl(Target).Modified:=false;
      if Assigned(GetControl(Target).OnChange) then
         GetControl(Target).OnChange(GetControl(Target));
      FSaved := True;
    end
  else
    if Assigned(FOnUnNamedFile) then
      begin
        FonUnNamedFile(self, Target, FSaved);
        AfterExecute;
      end
    else
      with TSaveDialog.Create(nil) do
        begin
          try
            DefaultExt:= 'rtf';
            Filter:=sDefaultFilter;
            FileName:= GetControl(Target).Title;
            if Execute then
              begin
                GetControl(Target).Lines.SaveToFile(FileName);
                GetControl(Target).Title:= FileName;
                GetControl(Target).Modified:=false;
                FSaved := True;
                AfterExecute;
              end;
          finally
            Free;
          end;
        end;
end;

{ ------------------------------------------------------------------------- }
{function  TLMDRichEditSave.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and GetControl(Target).Modified;
end;

{ ****************************  TLMDRichEditSaveAs  *********************** }
{ ------------------------------------------------------------------------- }
constructor TLMDRichEditSaveAs.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ASAVEAS;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditSaveAs.ExecuteTarget(Target: TObject);
begin
  FSaved:=False;
  with TSaveDialog.Create(nil) do
    begin
      try
        DefaultExt:= FDefaultExt;
        Filter:= FFilter;
        InitialDir:= FInitialDir;
        Options:= FOptions;
        Title:= FTitle;

        FileName:= GetControl(Target).Title;
        if FileName='' then
          Filename:=IDRTF_DOCUMENT+'.'+DefaultExt;

        if Execute then
          begin
            GetControl(Target).Title:= FileName;
            GetControl(Target).Lines.SaveToFile(FileName);
            GetControl(Target).Modified:=false;
            FSaved:=True;
            AfterExecute;
          end;
      finally
        Free;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }

{function  TLMDRichEditSaveAs.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and HasData(Target);
end;

{ ****************************  TLMDRichEditParagraph  ******************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditParagraph.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_APARAGRAPH;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditParagraph.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).Paragraph.ParagraphDialog;
  AfterExecute;
end;

{ ***********************  TLMDRichEditTextAttributes  ******************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditTextAttributes.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AFONT;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextAttributes.ExecuteTarget(Target: TObject);
begin
  if  not CanChange(Target)  then
    begin
      UpdateTarget(Target);
      exit;
    end;

  if  GetControl(Target).SelAttributes.TextAttributesDialog then
    AfterExecute;
end;

{ ***********************  TLMDRichEditTextFontStyle  ********************* }
{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextFontStyle.ExecuteTarget(Target: TObject);
  var
    Ctrl: TLMDCustomRichEdit;
    Attr: TLMDTextAttributes;
    St: TFontStyles;
begin
  if  not CanChange(Target)  then
    begin
      UpdateTarget(Target);
      exit;
    end;

  Ctrl := GetControl(Target);
  Attr := Ctrl.SelAttributes;
  St := Attr.Style;

  if (FontStyle * St) = []  then
    Attr.Style := St + FontStyle
  else
    Attr.Style := St - FontStyle;

  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextFontStyle.UpdateTarget(Target: TObject);
  var
    Ctrl: TLMDCustomRichEdit;
begin
  inherited;

  Ctrl := GetControl(Target);
  Checked := Assigned(Ctrl) and ((FontStyle * Ctrl.SelAttributes.Style) <> []);
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditTextFontStyle.FontStyle: TFontStyles;
begin
  Result := [];
end;

{ ***********************  TLMDRichEditTextBold  ************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditTextBold.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ABOLD;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditTextBold.FontStyle: TFontStyles;
begin
  Result := [fsBold];
end;

{ ***********************  TLMDRichEditTextItalic  ************************ }

constructor TLMDRichEditTextItalic.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AITALIC;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditTextItalic.FontStyle: TFontStyles;
begin
  Result := [fsItalic];
end;

{ ***********************  TLMDRichEditTextUnderline  ********************* }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditTextUnderline.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AUNDERLINE;
  Hint:= Caption;
  FUnderlineType:= utSolid;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextUnderline.ExecuteTarget(Target: TObject);
begin
  if  not CanChange(Target)  then
    begin
      UpdateTarget(Target);
      exit;
    end;

  if GetControl(Target).SelAttributes.UnderlineType <> FUnderlineType then
    GetControl(Target).SelAttributes.UnderlineType:= FUnderlineType
  else
    GetControl(Target).SelAttributes.UnderlineType:= utNone;

  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextUnderline.UpdateTarget(Target: TObject);
begin
  inherited;
  Checked:= GetControl(Target).SelAttributes.UnderlineType = FUnderlineType
end;

{ ***********************  TLMDRichEditTextSubscript  ********************* }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditTextSubscript.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ASUBSCRIPT;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextSubscript.ExecuteTarget(Target: TObject);
begin
  if  not CanChange(Target)  then
    begin
      UpdateTarget(Target);
      exit;
    end;

  if (GetControl(Target).SelLength > 0) then
    if GetControl(Target).SelAttributes.SubscriptStyle <> ssSubscript then
      GetControl(Target).SelAttributes.SubscriptStyle:= ssSubscript
    else
      GetControl(Target).SelAttributes.SubscriptStyle:= ssNone
  else if GetControl(Target).DefAttributes.SubscriptStyle <> ssSubscript then
    GetControl(Target).DefAttributes.SubscriptStyle:= ssSubscript
  else
    GetControl(Target).DefAttributes.SubscriptStyle:= ssNone;

  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextSubscript.UpdateTarget(Target: TObject);
  var
    Ctrl: TLMDCustomRichEdit;
begin
  inherited ;
  Ctrl := GetControl(Target);

  if  Assigned(Ctrl)  then
    Checked := (Ctrl.SelAttributes.SubscriptStyle = ssSubscript);
end;

{ ***********************  TLMDRichEditTextSuperscript  ******************* }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditTextSuperscript.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ASUPERSCRIPT;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextSuperscript.ExecuteTarget(Target: TObject);
begin
  if  not CanChange(Target)  then
    begin
      UpdateTarget(Target);
      exit;
    end;

  if (GetControl(Target).SelLength > 0) then
    if GetControl(Target).SelAttributes.SubscriptStyle <> ssSuperscript then
      GetControl(Target).SelAttributes.SubscriptStyle:= ssSuperscript
    else
      GetControl(Target).SelAttributes.SubscriptStyle:= ssNone
  else if GetControl(Target).DefAttributes.SubscriptStyle <> ssSuperscript then
    GetControl(Target).DefAttributes.SubscriptStyle:= ssSuperscript
  else
    GetControl(Target).DefAttributes.SubscriptStyle:= ssNone;

  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditTextSuperscript.UpdateTarget(Target: TObject);
  var
    Ctrl: TLMDCustomRichEdit;
begin
  inherited ;
  Ctrl := GetControl(Target);

  if  Assigned(Ctrl)  then
    Checked := (Ctrl.SelAttributes.SubscriptStyle = ssSuperscript);
end;

{ ***********************  TLMDRichEditTextUndo  ************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditUndo.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AUNDO;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditUndo.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).Undo;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditUndo.IsEnabled(Target: TObject): Boolean;
begin
  Result :=  inherited IsEnabled(Target) and GetControl(Target).CanUndo;
end;

{ ***********************  TLMDRichEditTextRedo  ************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditRedo.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AREDO;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditRedo.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).Redo;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditRedo.IsEnabled(Target: TObject): Boolean;
begin
  Result :=  inherited IsEnabled(Target) and GetControl(Target).CanRedo;
end;

{ ***********************  TLMDRichEditPrint  ***************************** }
{ ------------------------------------------------------------------------- }
constructor TLMDRichEditPrint.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_APRINT;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditPrint.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target)
    and (GetControl(Target).Mode = edModePrinterSupport);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditPrint.ExecuteTarget(Target: TObject);
//var
//  i:Integer;
begin
  if not FShowDialog then
    GetControl(Target).Print(GetControl(Target).Title)
  else
    with TPrintDialog.Create(nil) do
      try
        if Execute then
          //for i:=0 to Copies-1 do
            GetControl(Target).Print(GetControl(Target).Title);
      finally
        Free;
      end;
  AfterExecute;
end;

{ ***********************  TLMDRichEditPreview  *************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditPreview.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_APREVIEW;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditPreview.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target)
    and (GetControl(Target).Mode = edModePrinterSupport);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditPreview.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).PreviewDialog;
  AfterExecute;
end;

{ **************************  TLMDRichEditPageSetting  ********************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditPageSetting.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_APAGESETTINGS;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditPageSetting.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target)
    and (GetControl(Target).Mode = edModePrinterSupport);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditPageSetting.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).PagePropertiesDialog;
  AfterExecute;
end;

{ ***********************  TLMDRichEditInsertObject  ********************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditInsertObject.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AINSERTOBJ;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditInsertObject.ExecuteTarget(Target: TObject);
begin
  if  GetControl(Target).InsertObjectDialog then
    AfterExecute;
end;

{ ***********************  TLMDRichEditObjectProperties  ****************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditObjectProperties.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AOBJPROPS;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditObjectProperties.ExecuteTarget(Target: TObject);
begin
  if  GetControl(Target).ObjectPropertiesDialog then
    AfterExecute;
end;

{ ***********************  TLMDRichEditCopy  ****************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditCopy.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ACOPY;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditCopy.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and HasSelected(Target);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditCopy.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).CopyToClipboard;
  AfterExecute;
end;

{ ***********************  TLMDRichEditCut  ******************************* }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditCut.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ACUT;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditCut.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and HasSelected(Target);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditCut.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).CutToClipboard;
  AfterExecute;
end;

{ ***********************  TLMDRichEditPaste  ***************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditPaste.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_APASTE;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditPaste.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).PasteFromClipboard;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditPaste.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and Clipboard.HasFormat(CF_TEXT);
end;

{ ***********************  TLMDRichEditPasteSpecial  ********************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditPasteSpecial.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_APASTESPECIAL;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditPasteSpecial.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).PasteSpecialDialog;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditPasteSpecial.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and Clipboard.HasFormat(CF_TEXT);
end;

{ ***********************  TLMDRichEditSelectAll  ************************* }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditSelectAll.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ASELECTALL;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditSelectAll.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).SelectAll;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditSelectAll.IsEnabled(Target: TObject): Boolean;
begin
  Result := HasData(Target);
end;

{ ***********************  TLMDRichEditDelete  **************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditDelete.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ADELETE;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditDelete.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).ClearSelection;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditDelete.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and (GetControl(Target).SelLength > 0);
end;

{ ***********************  TLMDRichEditParaAlign  ************************* }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditParaAlign.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AALIGN;
  FAlignment:= paLeftJustify;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditParaAlign.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).Paragraph.Alignment:= FAlignment;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditParaAlign.UpdateTarget(Target: TObject);
begin
  inherited;
  Checked:= Assigned(GetControl(Target)) and
    (GetControl(Target).Paragraph.Alignment = FAlignment);
end;

{ ***********************  TLMDRichEditIndent  **************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditIndent.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AINCREASEINDENT;
  Hint:= Caption;
  FIndent := 10;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditIndent.ExecuteTarget(Target: TObject);
begin
  with  GetControl(Target).Paragraph do
    LeftIndent := LeftIndent + IndentValue;

  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditIndent.SetIndent(V: integer);
begin
  FIndent := V;
end;

{ ***********************  TLMDRichEditUnindent  ************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditUnindent.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ADECREASEINDENT;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditUnindent.ExecuteTarget(Target: TObject);
begin
  with  GetControl(Target).Paragraph do
    LeftIndent := LeftIndent - IndentValue;

  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditUnindent.IsEnabled(Target: TObject): Boolean;
var
  L, F: integer;
begin
  Result := inherited IsEnabled(Target);

  if  Result  then
    with GetControl(Target).Paragraph do
     begin
        F := FirstIndent;
        L := LeftIndent;
        Result := (L > 0) and ((F + L) > 0);
      end;
end;

{ ***********************  TLMDRichEditNumbering  ************************* }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditNumbering.Create(aOwner: TComponent);
begin
  inherited;
  FFirstIndent:=-10;
  FLeftIndent:=10;
  Caption:= IDRTF_ANUMBERING;
  Hint:= Caption;
  FNumberingStart:= 1;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditNumbering.ExecuteTarget(Target: TObject);
begin
  inherited;
  if GetControl(Target).Paragraph.Numbering <> FNumbering then
    GetControl(Target).Paragraph.Numbering:= FNumbering
  else
    GetControl(Target).Paragraph.Numbering:= nsNone;
  GetControl(Target).Paragraph.NumberingStyle:= FNumberingStyle;
  GetControl(Target).Paragraph.NumberingStart:= FNumberingStart;
  GetControl(Target).Paragraph.LeftIndent:= FLeftIndent;
  GetControl(Target).Paragraph.FirstIndent:= FFirstIndent;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditNumbering.UpdateTarget(Target: TObject);
begin
  inherited;
  Checked:= Assigned(GetControl(Target)) and
    (GetControl(Target).Paragraph.Numbering = FNumbering);
end;

{ ***********************  TLMDRichEditFind  ****************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditFind.Create(aOwner: TComponent);
begin
  inherited;
  DialogClass:=TFindDialog;
  Caption:= IDRTF_AFIND;
  Hint:= Caption;
  FDialog:= nil;
end;

{ ------------------------------------------------------------------------- }

destructor TLMDRichEditFind.Destroy;
begin
  FDialog.Free;
  inherited;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditFind.ExecuteTarget(Target: TObject);
var
  OldSelStart: integer;
begin
  FRichEdit:= GetControl(Target);

  OldSelStart := FRichEdit.SelStart;

  if  not Assigned(FDialog) then
    begin
      FDialog:= DialogClass{TFindDialog}.Create(nil);
      FDialog.OnFind:= DoFindReplace;
      If FDialog is TReplaceDialog then
        TReplaceDialog(FDialog).OnReplace:=DoFindReplace;
    end;

  // set highlighted text as FindText
  if (FRichEdit.SelText<>'') and (FDialog.FindText='') then
    FDialog.FindText:=Trim(FRichEdit.SelText);

  if Assigned(FDlgOnShow) then
    FDlgOnShow(FDialog);
  FDialog.Execute;
  if Assigned(FDlgOnClose) then
    FDlgOnClose(FDialog);

  if  OldSelStart <> FRichEdit.SelStart then
    AfterExecute;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRichEditFind.IsEnabled(Target: TObject): Boolean;
begin
  Result := inherited IsEnabled(Target) and HasData(Target);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichEditFind.DoFindReplace(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
  Opt: TLMDSearchTypes;
  Counter:Integer;
begin
  Counter:=0;
  with FRichEdit do
    begin
      // Options
      Opt:= [];
      if frDown in FDialog.Options then
        begin
          Opt:= Opt + [stSearchDown];
          StartPos:=SelStart;
          if (SelLength<>0) and (frFindNext in FDialog.Options) then
            Inc(StartPos, SelLength);
          ToEnd:= Length(Text) - StartPos;
        end
      else
        begin
          StartPos:=SelStart;
          ToEnd:=-StartPos;
        end;

      if frMatchCase in FDialog.Options then Opt:= Opt + [stMatchCase];
      if frWholeWord in FDialog.Options then Opt:= Opt + [stWholeWord];

      if frFindNext in FDialog.Options then
        begin
          FoundAt:= FindTextExt(FDialog.FindText, StartPos, ToEnd, Opt);
          if FoundAt <> -1 then
            begin
              SetFocus;
              SelStart:= FoundAt;
              SelLength:= Length(FDialog.FindText);
            end
          else
            MessageDlg(IDRTF_FR_NOTFOUND, mtInformation, [mbOK], 0);
        end
      else
        while true do
          begin
            FoundAt:=ReplaceTextExt(FDialog.FindText, TReplaceDialog(FDialog).ReplaceText, StartPos, ToEnd, Opt);
            if FoundAt <> -1 then
              begin
                if not (frReplaceAll in FDialog.Options) then
                  begin
                    //SetFocus;
                    SelStart:= FoundAt;
                    SelLength:= Length(TReplaceDialog(FDialog).ReplaceText);
                    break;
                  end
                else
                  Inc(Counter);
              end
            else
              begin
                if (frReplaceAll in FDialog.Options) and (Counter>0) then
                  begin
                    MessageDlg(Format(IDRTF_FR_REPLACED, [Counter]), mtInformation, [mbOK], 0);
                  end
                else
                  begin
                    MessageDlg(IDRTF_FR_NOTFOUND, mtInformation, [mbOK], 0);
                  end;
                break;
              end;
          end;
    end;
end;

{ ************************** TLMDRichEditReplace ******************************}
{------------------------------------------------------------------------------}
constructor TLMDRichEditReplace.Create(aOwner: TComponent);
begin
  inherited;
  DialogClass:=TReplaceDialog;
  FDialog:=nil;
  Caption:= IDRTF_AREPLACE;
  Hint:= Caption;
end;

{ ***********************  TLMDRichEditInsertChar  ************************ }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditInsertChar.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_AINSERTCHAR;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditInsertChar.ExecuteTarget(Target: TObject);
begin
  inherited;
  if  GetControl(Target).InsertCharDialog then
    AfterExecute;
end;

{ ***********************  TLMDRichEditInsertDateTime  ******************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditInsertDateTime.Create(aOwner: TComponent);
begin
  inherited ;
  Caption:= IDRTF_AINSERTDATETIME;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditInsertDateTime.ExecuteTarget(Target: TObject);
begin
  inherited;
  if  GetControl(Target).InsertDateTimeDialog then
    AfterExecute;
end;

{ ***********************  TLMDRichEditStatistics  ************************ }
{ ------------------------------------------------------------------------- }

constructor TLMDRichEditStatistics.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDRTF_ASTATISTICS;
  Hint:= Caption;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditStatistics.ExecuteTarget(Target: TObject);
begin
  inherited;
  GetControl(Target).StatisticsDialog;
  AfterExecute;
end;

{ ------------------------------------------------------------------------- }

constructor TLMDRichEditParaAlignLeft.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Alignment:= paLeftJustify;
end;

{ ------------------------------------------------------------------------- }

constructor TLMDRichEditParaAlignCenter.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Alignment:= paCenter;
end;

{ ------------------------------------------------------------------------- }

constructor TLMDRichEditParaAlignRight.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Alignment:= paRightJustify;
end;

{ ------------------------------------------------------------------------- }

constructor TLMDRichEditNumberingBullet.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Numbering := nsBullet;
end;

{ ------------------------------------------------------------------------- }

constructor TLMDRichEditNumberingArabicNumbers.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Numbering := nsArabicNumbers;
end;

{ ------------------------------------------------------------------------- }

constructor TLMDRTFSupportedAction.Create;
  procedure AddActions(const Actions: array of TContainedActionClass);
  var
    i: integer;
  begin
    for i := Low(Actions) to High(Actions) do
    begin
      Add(Actions[i].Create(nil));
    end;
  end;
begin
  inherited Create;
  AddActions([TLMDRichEditNew, TLMDRichEditLoad, TLMDRichEditSave,
    TLMDRichEditSaveAs, TLMDRichEditParagraph, TLMDRichEditTextAttributes,
    TLMDRichEditTextBold, TLMDRichEditTextItalic, TLMDRichEditTextUnderline,
    TLMDRichEditUndo, TLMDRichEditRedo, TLMDRichEditFind,
    TLMDRichEditParaAlign, TLMDRichEditNumbering, TLMDRichEditPrint,
    TLMDRichEditPreview, TLMDRichEditTextSubscript, TLMDRichEditTextSuperscript,
    TLMDRichEditCut, TLMDRichEditCopy, TLMDRichEditPaste,
    TLMDRichEditInsertObject, TLMDRichEditObjectProperties,
    TLMDRichEditPasteSpecial, TLMDRichEditSelectAll, TLMDRichEditDelete,
    TLMDRichEditIndent, TLMDRichEditUnindent, TLMDRichEditStatistics,
    TLMDRichEditInsertDateTime, TLMDRichEditInsertChar, TLMDRichEditReplace,
    TLMDRichEditPageSetting]);
end;

{ ------------------------------------------------------------------------- }
destructor TLMDRTFSupportedAction.Destroy;
var
  i: integer;
begin
  for i := Count - 1 downto 0 do
    TObject(Items[i]).Free;

  inherited Destroy;
end;

{ ------------------------------------------------------------------------- }

function TLMDRTFSupportedAction.ClassName(Index: Integer): ShortString;
begin
  Result := AnsiString(TObject(Self[Index]).ClassName);
end;

{ ------------------------------------------------------------------------- }

function TLMDRTFSupportedAction.GetAction(Index: Integer): TLMDRichEditAction;
begin
  Result := TLMDRichEditAction(Self[Index]);
end;

{ ------------------------------------------------------------------------- }

initialization
{$IFDEF LMD_DEBUGTRACE}
  {$I C1.INC}
{$ENDIF}
finalization

end.
