unit LMDInputDlg;
{$I lmdcmps.inc}

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

LMDInputDlg unit (JH, RM)
-------------------------

Dialog providing one or two edit fields

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Classes, Graphics,
  LMDBaseDialog;

type
  TLMDInputDlgOption=(idoAddEdit, idoMaskEdit1, idoMaskEdit2, idoPWEdit1, idoPWEdit2, idoChangeEvents);
  TLMDInputDlgOptions=set of TLMDInputDlgOption;

  TLMDInputDlg = class (TLMDBaseDialog)
  private
    FDefaultSelected: Boolean;
    FWidth,
    FMaxLength      : Integer;
    FPasswordChar   : Char;
    FReturnValue,
    FReturnValue2,
    FDefault,
    FPrompt         : String;
    FPromptFont     : TFont;
    FOnEditChange: TNotifyEvent;
    FMultilinePrompt: boolean;
    procedure DoChange(Sender:TObject);
  protected
    function DoShowDialog(const Caption, Prompt, DefaultValue: String; Main : TForm; idOptions:TLMDInputDlgOptions=[]; const MaskValue:String=''; const Prompt2:String=''; const DefaultValue2:String='') : Boolean;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    function ShowDialog (const Caption, Prompt, DefaultValue : String; Main:TForm=nil) : Boolean;
    function Execute:Boolean;override;
    function ExecuteEnh(aForm:TForm):Boolean;
    function InputQuery (const ACaption, APrompt : String; var Value : String) : Boolean;
    function InputQueryMask (const ACaption, APrompt, AMask : String; var Value : String) : Boolean;
    function InputQueryEx(const ACaption, APrompt1, APrompt2: String; var Value1, Value2: String; idOptions:TLMDInputDlgOptions=[]; const  AMask: String=''): Boolean;
    function InputBox (const ACaption, APrompt, ADefault: String): String;
    property Value : String read FReturnValue;
    property CtlXP; // compatibility
  published
    property About;
    property CaptionFill;
    property CaptionTitle;
    property Colors;
    property CustomButton;
    property DefaultValue : String read FDefault write FDefault;
    property DefaultSelected: Boolean read FDefaultSelected write FDefaultSelected default false;
    property Effect;
    property Hints;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property MaxLength : Integer read FMaxLength write FMaxLength default 0;
    property MultilinePrompt: boolean read FMultilinePrompt write FMultilinePrompt default false;
    property PasswordChar : Char read FPasswordChar write FPasswordChar default #0;
    property Width: Integer read FWidth write FWidth default -1;
    property Position;
    property Prompt : String read FPrompt write FPrompt;
    property PromptFont : TFont read FPromptFont write FPromptFont;
    property RelatePos;
    property ShowHints;
    property ThemeMode;
    property ThemeGlobalMode;    
    property OnCustomClick;
    property OnCustomize;

    property OnEditChange:TNotifyEvent read FOnEditChange write FOnEditChange;
  end;

implementation

uses
  StdCtrls, Controls,
  LMDConst, LMDSimpleLabel, LMDBack, LMDFormStyler, LMDButton,
  LMDCustomMaskEdit, LMDMaskEdit;

{***************************** Object TLMDInputDlg ****************************}
{--------------------------------- private ------------------------------------}
procedure TLMDInputDlg.DoChange(Sender: TObject);
begin
  if not Assigned(FOpenedDlg) then exit;
  if Assigned(FOnEditChange) then FOnEditChange(FOpenedDlg);
end;

{ ------------------------------- protected ---------------------------------- }
function TLMDInputDlg.DoShowDialog(const Caption, Prompt, DefaultValue: String; Main : TForm; idOptions:TLMDInputDlgOptions=[]; const MaskValue:String=''; const Prompt2:String=''; const DefaultValue2:String='') : Boolean;
var
  tmpc   : String;
  id     : TForm;
  input,
  input2 : TLMDMaskEdit;
  custom,
  ok,
  cancel : TLMDButton;
  promptL,
  promptL2: TLMDSimpleLabel;
  fs     : TLMDFormStyler;
  b      : TLMDBack;
  bw,
  w,
  h,
  i      : Integer;

  function theGreater (i1, i2 : Integer) : Integer;
  begin
    result := i1;
    if i2 > i1 then
      result := i2;
  end;

begin
  result := false;
  if Caption='' then
    tmpc:=IDS_INPUTCAPTION
  else
    tmpc:=Caption;

  id := TForm.Create(nil);
  try
    with id do
      begin
        h := 130+ (Ord(idoAddEdit in idOptions)*30) ;
        if FWidth <> -1 then
          w := FWidth
        else
          w := 300;

        BorderStyle:=bsDialog;
        Font.Color:=clWindowText;
        Font.Name:='MS Sans Serif';
        Font.Height:=-11;
        Position:=poDefault;
        PixelsPerInch:=96;
        Height := h;

        //get needed btn size
        bw := 80;

        bw := theGreater (bw, Canvas.TextWidth (IDS_CANCEL) + 6);
        bw := theGreater (bw, Canvas.TextWidth (CustomButton) + 6);

        //get space needed by buttons
        if CustomButton <> '' then
          i := 3 * (bw + 5)
        else
          i := 2 * (bw + 5);

        if i > w then w := i + 10;

        //set form width
        Width := w;

        i := (w - i) div 2;

        //Prompt line
        promptL := TLMDSimpleLabel.Create (id);
        with promptL do
          begin
            Name:='label1';
            Parent:=id;
            Left:= 10;
            Top:=10;
            Caption:=Prompt;
            Font.Assign(PromptFont);

            if MultilinePrompt then
            begin
              h := Height;
              Multiline := true;
              Width := w - 30;
              id.Height := id.Height + promptL.Height - h*2;
            end;
          end;

        ok:=TLMDButton.Create(id);
        with ok do
          begin
            Name := 'btnOk';
            Parent:=id;
            Width:=bw;
            Height:=24;
            Left:=i;
            Top:=id.ClientHeight-30; //changed JH, from := h-55, failed on XP
            ModalResult:=mrOK;
            Caption:='OK';
            Default:=True;
            TabOrder:=0;
          end;

        i := ok.Left + ok.Width;

        cancel:=TLMDButton.Create(id);
        with cancel do
          begin
            Name := 'btnCancel';
            Parent:=id;
            Width:=bw;
            Height:=24;
            Left:=i + 5;
            Top:=ok.Top;
            ModalResult:=mrCancel;
            Caption:=IDS_CANCEL;
            Cancel:=True;
            TabOrder:=1;
          end;

        i := cancel.Left + cancel.Width;

        custom:=TLMDButton.Create(id);
        with custom do
          begin
            Name := 'Custom';
            Parent:=id;
            Width:=bw;
            Height:=24;
            Left:=i + 5;
            Top:=ok.Top;
            TabOrder:=2;
          end;

        // 1st edit field, always available
        // --------------------------------
        input := TLMDMaskEdit.Create (id);
        with input do
          begin
            Parent := id;
            Name := 'edit1';
            Left := 10;
            Top := promptL.Top + promptL.Height + 2;
            Width := w - 30;
            TabOrder := 0;
            if idoMaskEdit1 in idOptions then
              begin
                MaskType:=meMask;
                Mask:=MaskValue;
              end
            else
              begin
                MaskType:=meNone;
                if ([idoAddEdit, idoPWEdit1]*idOptions<>[]) or
                    (not (idoAddEdit in idOptions)) then
                  PasswordChar := FPasswordChar;
              end;
            Text := DefaultValue;
            MaxLength := FMaxLength;
            if (idoChangeEvents in idOptions) then
              OnChange:=DoChange;
            if FDefaultSelected then
              begin
                // RM 21-Oct-2002
                input.CurrentChar:=Length(Text)+1;
                // --------------
                SelectAll;
              end;
          end;

        // 2nd edit field, idoAddEditField flag must be set
        // -------------------------------------------------
        input2 := nil;
        if idoAddEdit in idOptions then
          begin
            promptL2 := TLMDSimpleLabel.Create (id);
            with promptL2 do
              begin
                Name:='label2';
                Parent:=id;
                Left:= 10;
                Top:=input.BoundsRect.Bottom+6;
                Caption:=Prompt2;
              end;

            input2 := TLMDMaskEdit.Create (id);
            with input2 do
              begin
                Parent := id;
                Name := 'edit2';
                Left := 10;
                Top := promptL2.BoundsRect.Bottom + 2;
                Width := w - 30;
                TabOrder := 1;
                if idoMaskEdit2 in idOptions then
                  begin
                    MaskType:=meMask;
                    Mask:=MaskValue;
                  end
                else
                  begin
                    MaskType:=meNone;
                    if (idoPWEdit2 in idOptions) then
                      begin
                        PasswordChar := FPasswordChar;
                        if PasswordChar=#0 then PasswordChar:='*';
                      end;
                  end;
                Text := DefaultValue2;
                MaxLength := FMaxLength;
                if (idoChangeEvents in idOptions) then
                  OnChange:=DoChange;
              end;
          end;

        if ShowHints and (Hints.Count>0) then
          begin
            ShowHint:=True;
            ok.Hint:=Hints[0];
            if Hints.Count>1 then cancel.Hint:=Hints[1];
            if Hints.Count>2 then input.Hint:=Hints[2];
            if Hints.Count>3 then custom.Hint:=Hints[3];
            if Assigned(input2) and (Hints.Count>3) then
              custom.Hint:=Hints[4];
          end;

        fs:=TLMDFormStyler.Create(id);
        fs.Enabled:=False;

        b:=TLMDBack.Create(id);
        b.Enabled:=False;
      end;

      FOpenedDlg:=id;
      if (idoChangeEvents in idOptions) then DoChange(self);

      if BaseExecute(id, Main, Custom,  fs, b, tmpc)=mrOK then
        begin
          result := true;
          FReturnValue := input.Text;
          if (idoAddEdit in idOptions) and Assigned(input2) then
            FReturnValue2:=input2.Text;
        end
      else
        begin
          FReturnValue := '';
          FReturnValue2 := '';
        end;
  finally
    //free all
    id.Free;
  end;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDInputDlg.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FPasswordChar := #0;
  FMaxLength := 0;
  FWidth := -1;
  FPromptFont := TFont.Create;
  FMultilinePrompt := false;
end;

{------------------------------------------------------------------------------}
function TLMDInputDlg.ShowDialog (const Caption, Prompt, DefaultValue : String; Main : TForm=nil) : Boolean;
begin
  result:=DoShowDialog(Caption, Prompt, DefaultValue, Main);
end;

{ ---------------------------------------------------------------------------- }
function TLMDInputDlg.Execute:Boolean;
begin
  result := ExecuteEnh (nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDInputDlg.ExecuteEnh(aForm:TForm):Boolean;
begin
  result := ShowDialog (CaptionTitle, FPrompt, FDefault, aForm);
end;

{ ---------------------------------------------------------------------------- }
function TLMDInputDlg.InputQuery (const ACaption, APrompt : String; var Value : String) : Boolean;
begin
  result := ShowDialog (ACaption, APrompt, Value);
  if not result then exit;
  Value := FReturnValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDInputDlg.InputBox (const ACaption, APrompt, ADefault: String): String;
begin
  if ShowDialog (ACaption, APrompt, ADefault) then
    result := FReturnValue
  else
    result := ADefault;
end;

{ ---------------------------------------------------------------------------- }
function TLMDInputDlg.InputQueryMask(const ACaption, APrompt, AMask: String; var Value: String): Boolean;
begin
  result:=DoShowDialog(ACaption, APrompt, Value, nil, [idoMaskEdit1], AMask);
  if not result then exit;
  Value:=FReturnValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDInputDlg.InputQueryEx(const ACaption, APrompt1, APrompt2: String; var Value1, Value2: String; idOptions:TLMDInputDlgOptions=[]; const  AMask: String=''): Boolean;
begin
  result:=DoShowDialog(ACaption, APrompt1, Value1, nil, idOptions, AMask, APrompt2, Value2);
  if not result then exit;
  Value1:=FReturnValue; Value2:=FReturnValue2;
end;

destructor TLMDInputDlg.Destroy;
begin
  FPromptFont.Free;
  inherited;
end;

end.
