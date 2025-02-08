unit LMDFxAniDesignerForm;
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

LMDFxEffect unit (RM, AH)
------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  Dialogs, SysUtils,
  LMDFxEffect, LMDFxBitmap, LMDFxAnimation;

type

 { TLMDFxAnimationDesignerForm - designer form }
  { ********************* class TLMDFxAnimationDesignerForm ****************** }
  TLMDFxAnimationDesignerForm = class(TForm)
  private
    FAniCombo: TComboBox;
    FPreviewButton: TButton;
    FPreviewBox: TGroupBox;
    FPreviewPaint: TPaintBox;
    FSettingBox: TGroupBox;
    FDirectionCombo: TComboBox;
    FTimeEdit: TComboBox;
    FResEdit: TComboBox;
    FTileEdit: TComboBox;
    FBitmap: TImage;
    FBitmapDialog: TOpenDialog;
    FUpdating: boolean;
    FAnimationItem: TLMDFxAnimation;
    FSourceImage, FDestImage: TLMDFxBitmap;
    procedure BuildAniList;
    procedure DoAniComboChange(Sender: TObject);
    procedure DoPreviewPaint(Sender: TObject);
    procedure DoExecute(Sender: TObject);
    procedure DoTimeChange(Sender: TObject);
    procedure DoDirectionChange(Sender: TObject);
    procedure DoBitmapChange(Sender: TObject);
    procedure DoBitmapButtonClick(Sender: TObject);
    procedure UpdateAnimation;
    procedure UpdateControls;
    //procedure SetEnabled;
  public
    constructor CreateDesigner(const aButtonsExt:Boolean=false); virtual;
    destructor Destroy; override;
  end;

function LMDFxShowDesignerForm(const AAnimationItem: TLMDFxAnimation):TModalResult;overload;
function LMDFxShowDesignerForm(const AAnimationItem: TLMDFxAnimation; const aCaption:String; OkCancelButtons:Boolean; NotifyProc:TNotifyEvent=nil):TModalResult;overload;

implementation
uses
  Types, Consts,
  LMDFxUtils, LMDFxConsts;

{ -----------------------------------------------------------------------------}
function LMDFxShowDesignerForm(const AAnimationItem: TLMDFxAnimation; const aCaption:String; OkCancelButtons:Boolean; NotifyProc:TNotifyEvent=nil):TModalResult;
var
  DesignerForm: TLMDFxAnimationDesignerForm;
  tmpA: TLMDFxAnimation;
begin
  tmpA:=TLMDFxAnimation.Create(nil);
  try
    DesignerForm := TLMDFxAnimationDesignerForm.CreateDesigner(OkCancelButtons);
    tmpA.Assign(AANimationItem);
    try
      DesignerForm.FAnimationItem := tmpA; //AAnimationItem;
      if aCaption='' then
        DesignerForm.Caption := sLMDFxDlgCaption
      else
        DesignerForm.Caption:=aCaption;

      DesignerForm.BuildAniList;
      DesignerForm.UpdateControls;

      if Assigned(NotifyProc) then
        NotifyProc(DesignerForm);

      result:=DesignerForm.ShowModal;
      if result=mrOK then
        AAnimationItem.Assign(tmpA);
    finally
      DesignerForm.Free;
    end;
  finally
    tmpA.Free;
  end;
end;

{ -----------------------------------------------------------------------------}
function LMDFxShowDesignerForm(const AAnimationItem: TLMDFxAnimation):TModalResult;
begin
  result:=LMDFxShowDesignerForm(AAnimationItem, '',false);
end;

{ ********************* class TLMDFxAnimationDesignerForm ******************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFxAnimationDesignerForm.BuildAniList;
var
  i: integer;
begin
  { Build AniCombo }
  FAniCombo.Items.Clear;
  FAniCombo.Items.Add(SRandomSelection);
  FAniCombo.Items.Add(SBitmap);
  for i := 0 to ProcList.Count - 1 do
    FAniCombo.Items.Add(TLMDFxProcItem(ProcList.Items[i]).Name);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.DoAniComboChange(Sender: TObject);
begin
  if (FAnimationItem <> nil) and (FAniCombo.ItemIndex >= 0) then
    begin
      FAnimationItem.Effect := FAniCombo.Items[FAniCombo.ItemIndex];
      //SetEnabled;
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.DoPreviewPaint(Sender: TObject);
begin
  FSourceImage.Draw(FPreviewPaint.Canvas, 0, 0);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.DoExecute(Sender: TObject);
begin
  FPreviewButton.Enabled := false;
  try
    with FAnimationItem do
      begin
        SourceImage := FSourceImage;
        DestImage := FDestImage;
        ExecuteImage(FPreviewPaint.Canvas, 0, 0);
      end;
  finally
    FPreviewButton.Enabled := true;
  end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.DoTimeChange(Sender: TObject);
begin
  UpdateAnimation;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.DoDirectionChange(Sender: TObject);
begin
  UpdateAnimation;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.DoBitmapChange(Sender: TObject);
begin
  UpdateAnimation;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.DoBitmapButtonClick(Sender: TObject);
begin
  if FBitmapDialog.Execute then
    begin
      FBitmap.Picture.LoadFromFile(FBitmapDialog.FileName);
      FBitmap.Invalidate;
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.UpdateAnimation;
begin
  if FUpdating then Exit;

  FAnimationItem.Effect := FAniCombo.Items[FAniCombo.ItemIndex];
  FAnimationItem.Time := StrToInt(FTimeEdit.Text);
  FAnimationItem.Rotation := TLMDFxRotation(FDirectionCombo.ItemIndex);
  FAnimationItem.Resolution := StrToInt(FResEdit.Text);
  FAnimationItem.TileCount := StrToInt(FTileEdit.Text);
  FAnimationItem.Bitmap.Assign(FBitmap.Picture);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAnimationDesignerForm.UpdateControls;
begin
  FUpdating := true;
  try
    FAniCombo.ItemIndex := FAniCombo.Items.IndexOf(FAnimationItem.Effect);
    FTimeEdit.ItemIndex := FTimeEdit.Items.IndexOf(IntToStr(FAnimationItem.Time));
    FDirectionCombo.ItemIndex := Integer(FAnimationItem.Rotation);
    FResEdit.ItemIndex := FResEdit.Items.IndexOf(IntToStr(FAnimationItem.Resolution));
    FTileEdit.ItemIndex := FTileEdit.Items.IndexOf(IntToStr(FAnimationItem.TileCount));
    FBitmap.Picture.Assign(FAnimationItem.Bitmap);

    //SetEnabled;
  finally
    FUpdating := false;
  end;
end;

{ -----------------------------------------------------------------------------}
{procedure TLMDFxAnimationDesignerForm.SetEnabled;
begin
  if FAnimationItem = nil then Exit;

{  with FAnimationItem.ationProcItem do
  begin
    FTileEdit.Enabled := CanTileCountChanged;
    FResEdit.Enabled := CanResolutionChanged;
    FDirectionCombo.Enabled := CanDirectionChanged;
  end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxAnimationDesignerForm.CreateDesigner(const aButtonsExt:Boolean=false);
var
  R, TextR: TRect;
  B: TBitmap;
  i: integer;
begin
  inherited CreateNew(Application);
  BorderStyle := TFormBorderStyle(3); { bsDialog }
  Position := poScreenCenter;
  Width := 400;
  Height := 350;
  { Create controls }

  with TLabel.Create(Self) do
    begin
      Parent := Self;
      Visible := true;
      Left := 8;
      Top := 8;
      Width := 49;
      Height := 13;
      Caption := sLMDFxDlgLabelAnimation;
    end;

  FAniCombo := TComboBox.Create(Self);
  with FAniCombo do
    begin
      Parent := Self;
      Visible := true;
      Left := 8;
      Top := 26;
      Width := 375;
      Height := 21;
      DropDownCount := 14;
      Style := csDropDownList;
      ItemHeight := 13;
      TabOrder := 0;
      OnChange := DoAniComboChange;
    end;

  FPreviewBox := TGroupBox.Create(Self);
  with FPreviewBox do
    begin
      Parent := Self;
      Visible := true;
      Left := 8;
      Top := 58;
      Width := 181;
      Height := 225;
      Caption := sLMDFxDlgLabelPreview;
      TabOrder := 1;

      FPreviewPaint := TPaintBox.Create(Self);
      with FPreviewPaint do
        begin
          Parent := FPreviewBox;
          Visible := true;
          Left := 8;
          Top := 18;
          Width := 165;
          Height := 145;
          OnPaint := DoPreviewPaint;
        end;

      FPreviewButton := TButton.Create(Self);
      with FPreviewButton do
        begin
          Parent := FPreviewBox;
          Visible := true;
          Left := 53;
          Top := 180;
          Width := 75;
          Height := 25;
          Caption := sLMDFxDlgLabelExecute;
          TabOrder := 0;
          OnClick := DoExecute;
        end;
    end;

  FSettingBox := TGroupBox.Create(Self);
  with FSettingBox do
    begin
      Parent := Self;
      Visible := true;
      Left := 194;
      Top := 58;
      Width := 189;
      Height := 225;
      Caption := sLMDFxDlgLabelSettings;
      TabOrder := 2;

      with TLabel.Create(Self) do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 10;
          Top := 62;
          Width := 45;
          Height := 13;
          Caption := sLMDFxDlgLabelRotation;
        end;

      with TLabel.Create(Self) do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 10;
          Top := 106;
          Width := 53;
          Height := 13;
          Caption := sLMDFxDlgLabelResolution;
        end;

      with TLabel.Create(Self) do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 10;
          Top := 18;
          Width := 48;
          Height := 13;
          Caption := sLMDFxDlgLabelTime;
        end;

      with TLabel.Create(Self) do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 106;
          Top := 106;
          Width := 51;
          Height := 13;
          Caption := sLMDFxDlgLabelTile;
        end;

      with TLabel.Create(Self) do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 10;
          Top := 152;
          Width := 48;
          Height := 13;
          Caption := sLMDFxDlgLabelBitmap;
        end;

      FTimeEdit := TComboBox.Create(Self);
      with FTimeEdit do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 10;
          Top := 34;
          Width := 169;
          Height := 22;

          Style := csDropDownList;
          Items.Clear;
          for i := 3 to 300 do
            Items.Add(IntToStr(i * 50));
          ItemIndex := 10;

          TabOrder := 3;
          OnChange := DoTimeChange;
        end;

      FDirectionCombo := TComboBox.Create(Self);
      with FDirectionCombo do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 10;
          Top := 78;
          Width := 169;
          Height := 21;
          Style := csDropDownList;
          TabOrder := 15;
          Items.Text:=sLMDFxDlgComboRotation;
          OnChange := DoDirectionChange;
        end;

      FResEdit := TComboBox.Create(Self);
      with FResEdit do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 10;
          Top := 122;
          Width := 83;
          Height := 22;

          Style := csDropDownList;
          Items.Clear;
          for i := 1 to 20 do
            Items.Add(IntToStr(i));
          ItemIndex := 0;

          TabOrder := 7;
          OnChange := DoTimeChange;
        end;

      FTileEdit := TComboBox.Create(Self);
      with FTileEdit do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 106;
          Top := 122;
          Width := 73;
          Height := 22;

          Style := csDropDownList;
          Items.Clear;
          for i := 1 to 20 do
            Items.Add(IntToStr(i));
          ItemIndex := 0;

          TabOrder := 8;
          OnChange := DoTimeChange;
        end;

      with TButton.Create(Self) do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 10;
          Top := 174;
          Width := 54;
          Height := 22;
          Taborder:=9;
          Caption := sLMDFxDlgBrowseCaption;
          OnClick := DoBitmapButtonClick;
        end;

      FBitmap := TImage.Create(Self);
      with FBitmap do
        begin
          Parent := FSettingBox;
          Visible := true;
          Left := 69;
          Top := 152;
          Width := 110;
          Height := 62;
          Stretch := true;
          Picture.OnChange := DoBitmapChange;
        end;
    end;

  FBitmapDialog := TOpenDialog.Create(Self);
  with FBitmapDialog do
    begin
      DefaultExt := GraphicExtension(TGraphic);
      Filter := GraphicFilter(TGraphic);
    end;

  if aButtonsExt then
    begin
      with TButton.Create(Self) do
        begin
          Parent := Self;
          Visible := true;
          Left := 228;
          Top := 288;
          Width := 75;
          Height := 25;
          Caption:=SOKButton;
          ModalResult := mrOk;
          TabOrder := 10;
        end;

      with TButton.Create(Self) do
        begin
          Parent := Self;
          Visible := true;
          Left := 308;
          Top := 288;
          Width := 75;
          Height := 25;
          Cancel:=True;
          Caption := SCancelButton;
          ModalResult := mrCancel;
          TabOrder := 11;
        end;
    end
  else
    with TButton.Create(Self) do
      begin
        Parent := Self;
        Visible := true;
        Left := 159;
        Top := 288;
        Width := 75;
        Height := 25;
        Caption := SOKButton;
        ModalResult := mrOk;
        TabOrder := 10;
      end;

  { Initialize properties }
  R := Rect(10, 10, FPreviewPaint.Width - 10, FPreviewPaint.Height - 10);

  B := TBitmap.Create;
  try
    B.Width := FPreviewPaint.Width;
    B.Height := FPreviewPaint.Height;

    FSourceImage := TLMDFxBitmap.Create;

    with FSourceImage do
      begin
        SetSize(FPreviewPaint.Width, FPreviewPaint.Height);
        with B.Canvas do
          begin
            Brush.Color := clWhite;
            Rectangle(0, 0, B.Width, B.Height);
            Font.Name := 'Arial';
            Font.Size := 34;
            Font.Style := [fsBold];
            Font.Color := clBlue;
            TextR := Rect(0, 0, TextWidth('BACK'), TextHeight('BACK'));
            RectCenter(TextR, R);
            TextOut(TextR.Left, TextR.Top, 'BACK');
          end;
        Assign(b);
      end;

    FDestImage := TLMDFxBitmap.Create;
    with FDestImage do
      begin
        SetSize(FPreviewPaint.Width, FPreviewPaint.Height);
        with B.Canvas do
          begin
            Brush.Color := clBlue;
            Rectangle(0, 0, B.Width, B.Height);
            Font.Name := 'Arial';
            Font.Size := 34;
            Font.Style := [fsBold];
            Font.Color := clYellow;
            TextR := Rect(0, 0, TextWidth('FORE'), TextHeight('FORE'));
            RectCenter(TextR, R);
            TextOut(TextR.Left, TextR.Top, 'FORE');
          end;
        Assign(B);
      end;
    finally
      B.Free;
    end;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDFxAnimationDesignerForm.Destroy;
begin
  FreeAndNil(FDestImage);
  FreeAndNil(FSourceImage);
  inherited Destroy;
end;

end.

