unit LMDTextEditDlg;
{$I lmdcmps.INC}

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

LMDTextEditDlg unit (JH)
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Graphics,
  Forms,
  Controls,
  LMDBaseDialog;

type
  TLMDTextEditDlgOption = (teSave, teLoad, teModify, teStatistics, tePrint, teSearch, teFont, teLines,
                           teMenu, teAlignment, teToolbar, teStatusBar, teBottomPanel);
  TLMDTextEditDlgOptions = set of TLMDTextEditDlgOption;

const
  LMDTextEditDlgOptionsDefault=[teSave, teLoad, teSearch, teModify, teBottomPanel];

type

  TLMDTextEditDlg = class (TLMDBaseDialog)
  private
    FFilter,
    FFilename  : String;
    FLines     : TStrings;
    FLined,
    FAlways,
    FWordWrap  : Boolean;
    FFont      : TFont;
    FOptions   : TLMDTextEditDlgOptions;

    function GetText: String;
    procedure SetFont (aValue : TFont);
    procedure SetLines (aValue : TStrings);
    procedure SetText(const Value: String);
  protected
    function BaseExecute2(aForm, aParentForm:TForm; defCaption:String):TModalResult;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    function ExecuteEnh (aParentForm : TForm):Boolean;
    function Execute:Boolean; override;
    property CtlXP; // compatibility
  published
    property About;
    property CaptionFill;
    property CaptionTitle;
    property Colors;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property Lines : TStrings read FLines write SetLines;
    property Effect;
    property FileName : String read FFilename write FFilename;
    property FileFilter : String read FFilter write FFilter;
    property Text : String read GetText write SetText stored false;
    property Options : TLMDTextEditDlgOptions read FOptions write FOptions default LMDTextEditDlgOptionsDefault;
    property Position;
    property RelatePos;
    property WordWrap : Boolean read FWordWrap write FWordWrap default true;
    property Lined : Boolean read FLined write FLined default false;
    property Font : TFont read FFont write SetFont;
    property ThemeMode; // 9.0
    property ThemeGlobalMode;    
    // 7.0.61
    property AlwaysReturnText:Boolean read FAlways write FAlways default false;
    property CustomButton;
    {Events}
    property OnCustomize;
    property OnCustomClick;
  end;

implementation

uses
  Windows, SysUtils,
  LMDFormStyler, LMDConst, LMDClass, LMDGraph, LMDUtils, LMDCustomMemo,
  LMDTextEditor, LMDStrings, LMDRTLConst, LMDThemes;

{ ************************ class TLMDTextEditDlg ****************************** }
{ ------------------------------- private ------------------------------------ }
function TLMDTextEditDlg.GetText: String;
begin
  result:=FLines.Text;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDTextEditDlg.SetFont (aValue : TFont);
begin
  FFont.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextEditDlg.SetLines (aValue : TStrings);
begin
  FLines.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextEditDlg.SetText(const Value: String);
begin
  FLines.Text:=Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextEditDlg.BaseExecute2(aForm, aParentForm:TForm; defCaption:String):TModalResult;
var
  aRect:TRect;
begin
  FOpenedDlg:=aForm;

  with TLMDFrmTextEditor(aForm) do
    begin
      if CustomButton<>'' then
        begin
          btnCustom.Caption:=CustomButton;
          btnCustom.Visible:=True;
          if Assigned(OnCustomClick) then btnCustom.OnClick:=OnCustomClick;
        end;
        fs.Enabled:=CaptionFill;
        if CaptionFill then fs.Colors:=Colors;
        fs.Options:=fs.Options+[fsCheckSystemGradient];
      end;

   if Length(CaptionTitle)>0 then aForm.Caption:=CaptionTitle else aForm.Caption:=defCaption;

   LMDSetThemeMode(aForm, ThemeMode);

   DoCustomize(aForm);

   if csDesigning in ComponentState then
     aRect:=LMDDlgGetTargetRect(brScreenWorkArea)
   else
     If Assigned(aParentForm) then
        aRect:=aParentForm.BoundsRect
     else
       aRect:=LMDDlgGetTargetRect(RelatePos);

   LMDPositionWindow(aForm.Handle, aRect, Position, false);

   case Effect of
     deExplode:LMDExplodeForm(aForm);
     deExplodeExt:LMDExplodeForm2(aForm);
   end;

   result:=aForm.ShowModal;
   // 7.03
   FOpenedDlg := nil; //dialog no longer available
   // -----
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDTextEditDlg.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FOptions := LMDTextEditDlgOptionsDefault;
  FFilter := 'ASCII (*.txt)|*.txt|Pascal (*.pas)|*.pas';
  FFont := TFont.Create;
  FWordWrap := true;
  FLined := false;
  FLines := TStringList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextEditDlg.Destroy;
begin
  FreeAndNil(FLines);
  FreeAndNil(FFont);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextEditDlg.Execute : Boolean;
begin
  result := ExecuteEnh (nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextEditDlg.ExecuteEnh (aParentForm : TForm):Boolean;
var
  textEditor : TLMDfrmTextEditor;

begin
  textEditor := TLMDfrmTextEditor.Create(nil);
  with textEditor do
    try
      pnlBottom.Visible:=teBottomPanel in FOptions;
      StatusBar.Visible:=teStatusBar in FOptions;
      save.Visible := teSave in FOptions;
      save1.Visible := save.Visible;
      open.Visible := teLoad in FOptions;
      open1.Visible := open.Visible;
      print.Visible := tePrint in FOptions;
      print1.Visible := print.Visible;
      statistics.Visible := teStatistics in FOptions;
      n6.Visible:=statistics.Visible;
      statistics1.Visible := statistics.Visible;
      search.Visible := teSearch in FOptions;
      search2.Visible := search.Visible;

      fontbtn.Visible :=teFont in FOptions;
      font1.Visible := fontbtn.Visible;
      lines.Visible := teLines in FOptions;
      lined1.Visible := lines.Visible;

      AlignLeft.Visible := teAlignment in FOptions;
      AlignCenter.Visible := AlignLeft.Visible;
      AlignRight.Visible := AlignLeft.Visible;

      replace.Visible := teModify in FOptions;
      cut.Visible := replace.Visible;
      paste.Visible := replace.Visible;
      clear.Visible := replace.Visible;
      undo.Visible := replace.Visible;
      redo.Visible := replace.Visible;

      replace1.Visible := replace.Visible;
      cut1.Visible := replace.Visible;
      paste1.Visible := replace.Visible;
      clear1.Visible := replace.Visible;
      undo1.Visible := replace.Visible;
      redo1.Visible := replace.Visible;

      Memo.ReadOnly := not replace.Visible;

      if ImageList<>nil then
        begin
          b.ImageList:=ImageList;
          b.ListIndex:=ListIndex;
          b.ImageIndex:=ImageIndex;
          b.FillObject.Style:=sfBitmapList;
          Memo.Transparent := true;
        end;

      OpenDialog.Filter := FFilter;
      SaveDialog.Filter := FFilter;

      Memo.WordWrap := FWordWrap;
      wordwrap1.Checked := FWordWrap;
      Memo.Font.Assign (FFont);
      Memo.Lined := FLined;
      Memo.ScrollBars := skAuto;

      if not (teMenu in FOptions) then
        begin
          file1.Visible := false;
          edit1.Visible := false;
          options1.Visible := false;
        end;

      if not (teToolbar in FOptions) then
        begin
          toolBar.Visible := false;
        end;

      if FFilename <> '' then
        Memo.LoadFromFile (FFilename)
      else
        Memo.Text := Text;

      result := (BaseExecute2 (textEditor, aParentForm, IDS_TEXTEDITORCAPTION)=mrOK);
      if result or FAlways then
        SetText(Memo.Text);
  finally
    textEditor.Free;
  end;
end;

end.
