unit LMDMsg;
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

LMDMsg unit (JH)
----------------

ToDo
----
* HTML Support
* SoundMap support

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ImgList,
  LMDButtonBase, LMDGraph, LMDFormA, LMDClass, LMDBase, LMDWaveList, LMDCustomImageList,
  LMDBaseController, LMDGlyphTextLayout, LMD3DCaption, LMDContainerComponent;

type

  TLMDBoxPosition = TLMDDlgPosition;

  TLMDMessageBoxDlg = class(TLMDContainerComponent)
  private
    FCaption3D,
    FMessageF3D   : TLMD3DCaption;
    FButtonFont,
    FCaptionFont,
    FMessageFont  : TFont;
    FMessageAlign : TLMDGlyphTextLayout;

    FShowAgainBox,
    FShowAgain,
    FFillCaption,
    FPlayWave,
    FParentShowHint,
    FCtlXP,
    FCustomGlyph  : Boolean;
    FCaptionTitle : String;
    FShowAgainOffsetX,
    FShowAgainOffsetY,
    FCustomGlyphImageIndex,
    FCustomGlyphListIndex : Integer;
    FCustomGlyphImageList : TCustomImageList;
    FHints,
    FButtonTitles : TStringList;
    FWaveList     : TLMDWaveList;
    FDlgType      : TMsgDlgType;
    FButtons      : TMsgDlgButtons;
    FColors,
    FWaveListIndex,
    FHeight,
    FWidth,
    FLeft,
    FTop          : Integer;
    FColor:TColor;
    FPosition     : TLMDDlgPosition;
    FButtonsStyle : TLMDUserButtonStyle;
    FButtonStyle  : TLMDNormalButtonStyle;
    FBoxRel       : TLMDDlgPosRel;
    FWaveChangeLink:TLMDChangeLink;
    FChangeLink   : TChangeLink;
    FOnCustomize,
    FOnHelpClick  : TNotifyEvent;
    FCaptionAlignment : TAlignment;

    procedure SetFont (index : Integer;aValue : TFont);
    procedure SetFont3D (index : Integer;aValue : TLMD3DCaption);
    procedure SetCaptionTitle (const aValue : String);
    procedure SetStringList (index : integer; aValue : TStringList);
    procedure SetCustomGlyphImageList (aValue : TCustomImageList);
    procedure SetCustomGlyphListIndex (aValue : Integer);
    procedure SetCustomGlyphImageIndex (aValue : Integer);
    procedure SetWaveList (aValue : TLMDWaveList);
    procedure SetButtons (aValue : TMsgDlgButtons);
    procedure SetInteger(index : Integer; aValue : Integer);
    procedure SetBoxPos (aValue : TLMDDlgPosition);
    procedure SetAlignment (aValue : TLMDGlyphTextLayout);
    procedure SetBool (index : Integer; aValue : Boolean);
    procedure SetBoxRel (aValue : TLMDDlgPosRel);

    procedure GetCustomGlyphIMLChange(Sender:TObject);
    //function CustomGlyphIMLEmpty:Boolean;
    procedure GetWaveListChange(Sender:TObject);
    function WaveListEmpty:Boolean;

    procedure ReadIdent(Reader:TReader);
    procedure ReadStyle(Reader:TReader);  // 7.00.60
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;

    procedure GetHelpClick(Sender : TObject);
    procedure DoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnShowAgain (Sender : TObject);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    // 7.12
    procedure Notification(AComponent: TComponent;  Operation: TOperation);override;
    // 7.00.60
    function UseXP:Boolean;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;

    function Execute(Caption,
                       MessageTxt: String;
                       const Params : array of const;
                       Buttons   : TMsgDlgButtons = [];
                       Kind      : Integer = -1;
                       HelpCtx: Longint = -1;
                       X: Integer = -1;
                       Y: Integer = -1;
                       DefaultBtn: Integer = 0) : TModalResult;{$ifdef LMDCOMP14}overload;{$endif}

    {$ifdef LMDCOMP14}
    function Execute(Caption,
                     MessageTxt: String;
                     Buttons   : TMsgDlgButtons = [];
                     Kind      : Integer = -1;
                     HelpCtx: Longint = -1;
                     X: Integer = -1;
                     Y: Integer = -1;
                     DefaultBtn: Integer = 0) : TModalResult; overload;
    {$endif}
    function ExecuteWithDefaults(const MessageTxt: String;
                     const Caption: String = '';
                     Buttons   : TMsgDlgButtons = [];
                     Kind      : Integer = -1;
                     HelpCtx: Longint = -1;
                     X: Integer = -1;
                     Y: Integer = -1;
                     DefaultBtn: Integer = 0) : TModalResult;
    function ShowMessage (const MessageTxt : String):Integer;
    function MessageDlg (const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons; HelpCtx: Longint): Word;
    function MessageDlgPos(const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons;
                           HelpCtx: Longint; X, Y: Integer): Word;
    procedure ShowMessageFmt(const Msg: string; const Params: array of const);

    function MessageBox(Text, Caption: PChar; Flags: Longint): Integer; overload;
    function MessageBox(Text, Caption: PChar): Integer; overload;
    function MessageBox(Text : PChar; Flags: Longint): Integer; overload;
    function MessageBox(Text : PChar): Integer; overload;

    // obsolete from 7.00.60 on
    property ButtonStyle : TLMDNormalButtonStyle read FButtonStyle write FButtonStyle default nbsAutoDetect;
  published
    // 7.00.60
    property CtlXP:Boolean read FCtlXP write FCtlXP default true;
    property OnCustomize:TNotifyEvent read FOnCustomize write FOnCustomize;
    property ButtonsStyle:TLMDUserButtonStyle read FButtonsStyle write FButtonsStyle default ubsWin40;
    property ShowAgainOffsetX:Integer read FShowAgainOffsetX write FShowAgainOffsetX default 0;
    property ShowAgainOffsetY:Integer read FShowAgainOffsetY write FShowAgainOffsetY default 0;

    // -------
    property MessageFont3D : TLMD3DCaption index 0 read FMessageF3D write SetFont3D;
    property CaptionFont3D : TLMD3DCaption index 1 read FCaption3D write SetFont3D;
    property MessageAlignment : TLMDGlyphTextLayout read FMessageAlign write SetAlignment;
    property MessageFont : TFont index 0 read FMessageFont write SetFont;
    property CaptionFont : TFont index 1 read FCaptionFont write SetFont;
    property Color:TColor read FColor write FColor default clBtnFace;
    property ButtonFont : TFont index 2 read FButtonFont write SetFont;
    property CaptionTitle : String read FCaptionTitle write SetCaptionTitle;
    property CaptionAlignment : TAlignment read FCaptionAlignment write FCaptionAlignment default taLeftJustify;
    property ButtonTitles : TStringList index 0 read FButtonTitles write SetStringList;
    property Hints : TStringList index 1 read FHints write SetStringList;
    property CustomGlyphImageList : TCustomImageList read FCustomGlyphImageList write SetCustomGlyphImageList;
    property CustomGlyphListIndex : Integer read FCustomGlyphListIndex write SetCustomGlyphListIndex;
    property CustomGlyphImageIndex : Integer read FCustomGlyphImageIndex write SetCustomGlyphImageIndex;
    property CustomGlyph : Boolean index 1 read FCustomGlyph write SetBool default false;
    property Buttons : TMsgDlgButtons read FButtons write SetButtons default [mbOK];
    property BoxLeft : Integer index 0 read FLeft write SetInteger default 0;
    property BoxTop : Integer index 1 read FTop write SetInteger default 0;
    property BoxWidth : Integer index 2 read FWidth write SetInteger default 0;
    property BoxHeight : Integer index 3 read FHeight write SetInteger default 0;
    property ShowHints : Boolean index 0 read FParentShowHint write SetBool default false;
    property Position : TLMDDlgPosition read FPosition write SetBoxPos default bpCenter;
    property RelatePos : TLMDDlgPosRel read FBoxRel write SetBoxRel default brScreen;
    property PlayWave : Boolean index 2 read FPlayWave write SetBool default false;
    property ShowAgain : Boolean read FShowAgain write FShowAgain default true;
    property ShowAgainBox : Boolean read FShowAgainBox write FShowAgainBox default false;
    property CaptionFill : Boolean index 3 read FFillCaption write SetBool default false;
    property Colors : Integer index 5 read FColors write SetInteger default 32;
    property DlgType : TMsgDlgType read FDlgType write FDlgType default mtCustom;
    property ImageList;
    property ListIndex;
    property ImageIndex;
    property WaveList : TLMDWaveList read FWaveList write SetWaveList;
    property WaveIndex : Integer index 4 read FWaveListIndex write SetInteger default 0;
    property About;
    property OnHelpClick : TNotifyEvent read FOnHelpClick write FOnHelpClick;
  end;

  function LMDExecuteMsg (const Caption,
                          MessageTxt: String; const Params : array of const;
                          Buttons   : TMsgDlgButtons;
                          Kind      : Integer;
                          HelpCtx: Longint;
                          X, Y, DefaultBtn: Integer) : TModalResult;

  procedure LMDShowMessage (const MessageTxt : String);
  function LMDMessageDlg (const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons; HelpCtx: Longint): Word;
  function LMDMessageDlgPos(const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons;
                                  HelpCtx: Longint; X, Y: Integer): Word;
  procedure LMDShowMessageFmt(const Msg: string; const Params: array of const);

  function LMDMessageBox(Text, Caption: PChar; Flags: Longint): Integer;

implementation

uses
  Buttons, ExtCtrls, Consts,
  LMDConst, LMDCont, LMDUtils, LMDProcs, LMDGraphUtils, LMDBitmapList, LMDCheckBox,
  LMDButton, LMDGlyphLabel, LMDFormStyler, LMDSimplePanel, LMDBackPanel;

{ ********************* class TLMDMessageBoxDlg ****************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDMessageBoxDlg.SetBoxRel (aValue : TLMDDlgPosRel);
begin
  if aValue <> FBoxRel then
    FBoxRel := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetBool (index : Integer; aValue : Boolean);
begin
  case index of
    0 : if aValue <> FParentShowhint then
          FParentShowHint := aValue;
    1 : if aValue <> FCustomGlyph then
          FCustomGlyph := aValue;
    2 : if aValue <> FPlayWave then
          FPlayWave := aValue;
    3 : if aValue <> FFillCaption then
          FFillCaption := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetAlignment (aValue : TLMDGlyphTextLayout);
begin
  FMessageAlign.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetBoxPos (aValue : TLMDDlgPosition);
begin
  if aValue <> FPosition then
    begin
      FPosition := aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetInteger(index : Integer; aValue : Integer);
begin
  case index of
    0 : if aValue <> FLeft then
          begin
            FLeft := aValue;
          end;
    1 : if aValue <> FTop then
          begin
            FTop := aValue;
          end;
    2 : if aValue <> FWidth then
          begin
            FWidth := aValue;
          end;
    3 : if aValue <> FHeight then
          begin
            FHeight := aValue;
          end;
    4 : if (aValue <> FWaveListIndex) and (aValue > -1) then
          begin
            FWaveListIndex := aValue;
            if FWaveList<>nil then GetWaveListChange(nil);
          end;
    5 : if aValue <> FColors then
          FColors := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetButtons (aValue : TMsgDlgButtons);
begin
  if aValue <> FButtons then
    begin
      FButtons := aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetWaveList (aValue : TLMDWaveList);
begin
  if FWaveList<>nil then
    FWaveList.UnRegisterChanges(FWaveChangeLink);
  FWaveList:=aValue;
  if FWaveList<>nil then
    begin
      FWaveList.RegisterChanges(FWaveChangeLink);
      FWaveList.FreeNotification(Self);
    end;
  GetWaveListChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetCaptionTitle (const aValue : String);
begin
  if aValue <> FCaptionTitle then
    begin
      FCaptionTitle := aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetStringList (index : integer; aValue : TStringList);
begin
  case index of
    0 : FButtonTitles.Assign (aValue);
    1 : FHints.Assign (aValue);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetCustomGlyphImageList (aValue : TCustomImageList);
begin
  if FCustomGlyphImageList<>nil then
    FCustomGlyphImageList.UnRegisterChanges(FChangeLink);
  FCustomGlyphImageList:=aValue;
  if FCustomGlyphImageList<>nil then
    begin
      FCustomGlyphImageList.RegisterChanges(FChangeLink);
      FCustomGlyphImageList.FreeNotification(Self);
    end;
  GetCustomGlyphIMLChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetCustomGlyphListIndex (aValue : Integer);
begin
  if (aValue <> FCustomGlyphListIndex) and (aValue > -1) then
    begin
      FCustomGlyphListIndex := aValue;
      if FCustomGlyphImageList<>nil then
        GetCustomGlyphIMLChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetCustomGlyphImageIndex (aValue : Integer);
begin
  if (aValue <> FCustomGlyphImageIndex) and (aValue > -1) then
    begin
      FCustomGlyphImageIndex := aValue;
      if FCustomGlyphImageList<>nil then
        GetCustomGlyphIMLChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.GetCustomGlyphIMLChange(Sender:TObject);
begin
  GetChange(sender);
end;
{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.GetWaveListChange(Sender:TObject);
begin
  GetChange(sender);
end;

{------------------------------------------------------------------------------}
{function TLMDMessageBoxDlg.CustomGlyphIMLEmpty:Boolean;
begin
  result:=not ((FCustomGlyphImageList<>nil) and FCustomGlyphImageList.IsValidItem(FCustomGlyphListIndex,
                                                                                  FCustomGlyphImageIndex));
end;

{------------------------------------------------------------------------------}
function TLMDMessageBoxDlg.WaveListEmpty:Boolean;
begin
  result:=not ((FWaveList<>nil) and (FWaveListIndex < FWaveList.Count));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetFont (index : Integer;aValue : TFont);
begin
  case index of
    0 : FMessageFont.Assign (aValue);
    1 : FCaptionFont.Assign (aValue);
    2 : FButtonFont.Assign (aValue);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.SetFont3D (index : Integer;aValue : TLMD3DCaption);
begin
  case index of
    0 : FMessageF3D.Assign (aValue);
    1 : FCaption3D.Assign (aValue);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageBoxDlg.ReadIdent(Reader:TReader);
begin
  SetCustomGlyphImageList(LMDReadGlobalIdent(Reader));
{  SetWaveList(LMDReadGlobalIdent(Reader));}
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageBoxDlg.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FCustomGlyphImageList);
{  LMDWriteGlobalIdent(Writer, FWaveList);}
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageBoxDlg.ReadStyle(Reader:TReader);
var
  s: String;
  i: TLMDNormalButtonStyle;
begin
  s := Reader.ReadIdent;
  if s='nbsAutoDetect' then
    FButtonsStyle:=ubsWin40
  else
    for i := Low(TLMDNormalButtonStyle) to High(TLMDNormalButtonStyle) do
      if s = TLMDNormalBtnStyleString[i] then
        FButtonsStyle := TLMDUserButtonStyle (Ord(i));
end;

{------------------------------------------------------------------------------}
function TLMDMessageBoxDlg.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FCustomGlyphImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageBoxDlg.GetHelpClick(Sender : TObject);
begin
  if Assigned (FOnHelpClick) then FOnHelpClick(Sender);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.DoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then TForm(Sender).ModalResult:=mrCancel;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.OnShowAgain (Sender : TObject);
begin
  FShowAgain := not TLMDCheckBox (Sender).Checked;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDMessageBoxDlg.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
  Filer.DefineProperty('ButtonStyle', ReadStyle, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageBoxDlg.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    begin
      if (aComponent=FWaveList) then SetWaveList(nil);
      if (aComponent=FCustomGlyphImageList) then SetCustomGlyphImageList(nil);
    end;
end ;
{ ---------------------------------------------------------------------------- }
function TLMDMessageBoxDlg.UseXP: Boolean;
begin
  result := false;
  if LMDApplication.UseXPThemes then
    result:=FCtlXP;
end;

{---------------------------------- public ------------------------------------}
constructor TLMDMessageBoxDlg.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  LMDApplication.MsgBox := self;

  FMessageF3D := TLMD3DCaption.Create;
  FMessageF3D.OnChange := GetChange;

  FCaption3D := TLMD3DCaption.Create;
  FCaption3D.OnChange := GetChange;

  FCaptionFont  := TFont.Create;
  FCaptionFont.OnChange := GetChange;

  FButtonFont := TFont.Create;
  FButtonFont.OnChange := GetChange;

  FMessageFont  := TFont.Create;
  FMessageFont.OnChange := GetChange;

  FMessageAlign := TLMDGlyphTextLayout.Create;
  FMessageAlign.OnChange := GetChange;

  FCustomGlyph  := false;
  FCustomGlyphImageIndex := 0;
  FCustomGlyphListIndex := 0;
  FCustomGlyphImageList := nil;
  FWaveList := nil;

  FButtonTitles := TStringList.Create;
  FButtonTitles.OnChange := GetChange;

  FHints := TStringList.Create;
  FHints.OnChange := GetChange;
  FParentShowHint := false;
  FPlayWave := false;
  FCaptionAlignment := taLeftJustify;

  FFillCaption := false;

  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetCustomGlyphIMLChange;

  FWaveChangeLink:=TLMDChangeLink.Create;
  FWaveChangeLink.OnChange:=GetWaveListChange;

  FBoxRel := brScreen;
  FPosition := bpCenter;
  FDlgType := mtCustom;

  // 7.00.60
  FCtlXP:=True;
  FButtonsStyle:=ubsWin40;
  // ----
  FButtons := [mbOK];
  FLeft := 0;
  FTop := 0;
  FColors := 32;
  FColor:=clBtnFace;
  FShowAgain:=true;
  FShowAgainBox:=false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDMessageBoxDlg.Destroy;
begin
  LMDApplication.MsgBox := nil;

  FWaveChangeLink.OnChange:=nil;
  FreeAndNil(FWaveChangeLink);

  FChangeLink.OnChange:=nil;
  FreeAndNil(FChangeLink);

  FHints.OnChange := nil;
  FreeAndNil(FHints);

  FButtonTitles.OnChange := nil;
  FreeAndNil(FButtonTitles);

  FButtonFont.OnChange := nil;
  FreeAndNil(FButtonFont);

  FCaptionFont.OnChange := nil;
  FreeAndNil(FCaptionFont);

  FCaption3D.OnChange := nil;
  FreeAndNil(FCaption3D);

  FMessageFont.OnChange := nil;
  FreeAndNil(FMessageFont);

  FMessageF3D.OnChange := nil;
  FreeAndNil(FMessageF3D);

  FMessageAlign.OnChange := nil;
  FreeAndNil(FMessageAlign);

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDMessageBoxDlg.Execute(Caption,
                       MessageTxt: String;
                       const Params : array of const;
                       Buttons   : TMsgDlgButtons = [];
                       Kind      : Integer = -1;
                       HelpCtx: Longint = -1;
                       X: Integer = -1;
                       Y: Integer = -1;
                       DefaultBtn: Integer = 0) : TModalResult;
const
  BD = 5;
  BW = 75+BD;
var
  Form : TForm;
  fs   : TLMDFormStyler;
  aRect : TRect;
  ts : TLMDGlyphLabel;
  sp : TLMDSimplePanel;
  b  : TLMDBackPanel;
  bi : TMsgDlgBtn;  // 7.01, RM
  BtnCount,
  i,

  lb : Integer;
  FIcon : TIcon;
  timg : TBitmap;
  tlimg : TLMDBitmapList;
  mw, mh : integer;
  sab : TLMDCheckBox;

  function GetButtonCaption (nr : Integer; const std : String) : String;
  begin
    if (nr < FButtonTitles.Count) and (FButtonTitles[nr]<>'') then
      result := FButtonTitles.Strings[nr]
    else
      result := std;
  end;

  function getHint (nr : Integer) : String;
  begin
    if (nr < FHints.Count) and (FHints[nr]<>'') then
      result := FHints.Strings[nr]
    else
      result := '';
  end;

  procedure createButton (btntype: TMsgDlgBtn; res : TModalResult; const capt : String);
  var
    b : TLMDButton;
  begin
    b := TLMDButton.Create(form);
    with b do
      begin
        Parent := sp;
        if BtnCount = DefaultBtn then
          begin
            Default := true;
            Form.ActiveControl := b;
          end;
        if capt = SHelpButton then
          OnClick := GetHelpClick;
        Caption := getButtonCaption (ord(btntype),capt);
        Hint := getHint(ord(btntype));
        Inc(BtnCount);
        ShowHint := FParentShowHint;
        Font.Assign (FButtonFont);
        Color:=clBtnFace;
        ModalResult := res;

        // 7.00.60
        CtlXP:=UseXP;
        ButtonStyle:=FButtonsStyle;
        // ------------

        Width := BW-BD;
        SetBounds (lb+BD, 10, Width, Height);
        Inc (lb, Width+BD);
      end;
  end;

begin
  tlimg:=nil;

  if kind = -1 then
    kind := Ord(FdlgType);
  { check parameters }
  if buttons = [] then
    buttons := FButtons;

  if Caption = '' then
    begin
      if FCaptionTitle = '' then
        Caption := Application.Title
      else
        Caption := FCaptionTitle;
    end;

  { create the form }
  Form := TForm.Create (nil);
  Form.Color:=FColor;

  // 7.00.60
  Form.KeyPreview:=True;
  Form.OnKeyDown:=DoKeyDown;

  { make it unvisible }
  Form.Visible := False;
  // 7.01
  {$IFDEF LMDCOMP9}
  Form.Position:=poDesigned;
  {$ENDIF}

  { place to insert next button }
  lb := 0;
  { ButtonCounter for testing DefaultButton }
  BtnCount := 0;
  try
    { create and initialize FormStyler }
    fs := TLMDFormStyler.Create(Form);
    fs.Enabled := False;
    fs.Options := [fsAdjustRect, fsUseDefaultFont, fsUseFormCaption];
    fs.Colors := FColors;
    fs.Font.Assign (FCaptionFont);
    fs.Font3D.Assign (FCaption3D);
    fs.Alignment := FCaptionAlignment;

    b := TLMDBackPanel.Create (form);
    with b do
      begin
{        Enabled := False;}
        ParentColor:=True;
        Parent := Form;
        Align := alClient;
        ImageList := self.ImageList;
        ListIndex := self.ListIndex;
        ImageIndex := self.ImageIndex;
      end;

    { set form Caption }
    Form.Caption := Caption;

    { set BorderStyle to dialog }
    Form.BorderStyle := bsDialog;
    { never Scale }
    Form.Scaled := False;
    Form.ShowHint := FParentShowhint;

    { set to a big size }
    Form.Height := Screen.Height; { set formsize to maximum }
    Form.Width  := Screen.Width;

{    if (FWidth = 0) and { wordwrap }

    if not FCustomGlyph then
      begin
        timg := TBitmap.Create;
        tlimg := TLMDBitmapList.Create (form);
        if {TMsgDlgType}(kind) <> 4{mtCustom} then
          with timg do
           begin
             FIcon := TIcon.Create;
             try
               case {TMsgDlgType}(kind) of
                 0{mtWarning}     : FIcon.Handle := LoadIcon (0,IDI_EXCLAMATION);
                 1{mtError}       : FIcon.Handle := LoadIcon (0,IDI_HAND);
                 2{mtInformation} : FIcon.Handle := LoadIcon (0,IDI_ASTERISK);
                 3{mtConfirmation}: FIcon.Handle := LoadIcon (0,IDI_QUESTION);
               end;
               LMDIcon2Bitmap (FIcon, timg, form.color);
             finally
               FIcon.Free;
             end;
          end;
         tlimg.Insert(0, nil);
         tlimg[0].Bitmap.Assign(timg);

         timg.Free;

      end;

    { create MessageLabel }
    ts := TLMDGlyphLabel.Create (Form);
    with ts do
      begin
        Parent := b;
        Left := 0;
        Top := 0;

        Font.Assign (FMessageFont);
        // explicitely setting again
        Font.Charset:=FMessageFont.Charset;

        Font3D.Assign (FMessageF3D);
        if Length(Params)>0 then
          Caption := Format (MessageTxt, Params)
        // 7.01
        else
          Caption := MessageTxt;

        Multiline := True;
        Transparent := True;

        ShowHint := FParentShowHint;
        Hint := getHint (Ord(High(TMsgDlgBtn))+1);
        { align the label }
        Alignment.Assign(FMessageAlign);

        if FCustomGlyph then
          begin
            ImageList := FCustomGlyphImageList;
            ListIndex := FCustomGlyphListIndex;
            ImageIndex := FCustomGlyphImageIndex;
          end
        else
          begin
            ImageList := tlimg;
            ListIndex := 0;
            ImageIndex := 0;
          end;

        // 7.00.60 do some better default settings
        Alignment.OffsetY:=Alignment.OffsetY+3;
        Alignment.OffsetX:=Alignment.OffsetX+10;
        if not IMLEmpty then
          begin
            Alignment.Spacing:=Alignment.Spacing+4;
          end;

        AutoSize := True;

        mw := ts.Width+2*Alignment.OffsetX; { set form size to width of label }

        mh := ts.Height+GetSystemMetrics(SM_CYCAPTION)+10; { set form height to height of label }
        Align := alClient;
        AutoSize := False;
      end;

    { if a button exists }
    if Buttons <> [] then
      begin
        { create a button - panel }
        sp := TLMDSimplePanel.Create (Form);
        with sp do
          begin
            Parent := b;
            ParentColor:=True;
            Transparent := True;
            sp.Align := alBottom;
            sp.top := mh; {Form.Height-60;}
            sp.Height:=47;
          end;
         { if not fixed height increase height for buttons }
      end;

    { get button widths }
    i := 0;
    // 7.01 RM
    for bi:=Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if bi in Buttons then Inc(i);
    // --

    if FShowAgainBox and Assigned(sp) then  // 7.00.60, if buttons empty -> No ShowAgainBox as well
      begin
        sab := TLMDCheckBox.Create (Form);
        with sab do
          begin
            sab.Parent := sp;
            sab.AutoSize := false;
            sab.Caption := IDS_DONTSHOWAGAIN;
            sab.Left := ts.Alignment.OffsetX+FShowAgainOffsetX;
            sab.Top := 50+FShowAgainOffsetY;
            sab.Checked := not FShowAgain;
            sab.Transparent := true;
            sab.Flat:=true;
            sab.OnClick := OnShowAgain;
            sab.CtlXP:=UseXP;
            sab.AutoSize := true;

            if sab.Width + sab.Left+4 > mw then
              mw := sab.Width +2*sab.Left+7;
            sp.Height := sp.Height+ sab.height+6+FShowAgainOffsetY;
          end;
      end;

    if Assigned(sp) then
      mh := mh + sp.Height; { increase the form height for buttons }
    { if more buttons than form width }
    if mw < 20 + i* BW then
      mw := 20 + i* BW+6;

{    if mh > Form.Height then} Form.Height := mh;
{    if mw > Form.Width then} Form.Width := mw;

    { set form size if it is not calculated }
    if FWidth <> 0 then
      Form.Width := FWidth+4;

    if FHeight <> 0 then
      Form.Height := FHeight+20;

    { center buttons }
    lb := (Form.Width - (i*BW)) div 2 - BD;
    { create Default Buttons }

    //JH, April 2001 changed creation order of buttons
    if mbYes In Buttons then
      createButton (mbYes, mrYes,SYesButton);
    if mbNo In Buttons then
      createButton (mbNo, mrNo,SNoButton);
    if mbOK In Buttons then
      createButton (mbOK, mrOk,SOKButton);
    if mbCancel In Buttons then
      createButton (mbCancel, mrCancel,SCancelButton);
    if mbAbort In Buttons then
      createButton (mbAbort, mrAbort,SAbortButton);
    if mbRetry In Buttons then
      createButton (mbRetry, mrRetry,SRetryButton);
    if mbIgnore In Buttons then
      createButton (mbIgnore, mrIgnore,SIgnoreButton);
    if mbAll In Buttons then
      createButton (mbAll, mrAll,SAllButton);
    if mbNoToAll In Buttons then
      createButton (mbNoToAll, mrNoToAll,SMsgDlgNoToAll);
    if mbYesToAll In Buttons then
      createButton (mbYesToAll, mrYesToAll,SMsgDlgYesToAll);
    if mbHelp In Buttons then
      createButton (mbHelp, mrNone,SHelpButton);

    { Set Form to proper Pos0ition }
    if csDesigning in ComponentState then
      aRect:=LMDDlgGetTargetRect(brScreen)
    else
      aRect:=LMDDlgGetTargetRect(FBoxRel);

    if FPosition=bpCustom then
      begin
        aRect.Left:=aRect.Left+FLeft;
        aRect.Top:=aRect.Top+FTop;
      end;

    LMDPositionWindow(Form.Handle, aRect, FPosition, True);

    { Enable formstyler if wanted }
    fs.Enabled := FFillCaption;
    fs.Options:=fs.Options+[fsCheckSystemGradient];

    { play wave }
    if FPlayWave and not WaveListEmpty then
      FWaveList.Items[FWaveListIndex].Wave.Play;

    if Assigned(FOnCustomize) then
      FOnCustomize(Form);

    { show form and get descicion }
    result := Form.ShowModal;
  finally
    if tlimg <> nil then
      tlimg.Free;
    Form.Free;
  end;
end;

{$ifdef LMDCOMP14}
{ ---------------------------------------------------------------------------- }
function TLMDMessageBoxDlg.Execute(Caption,
                     MessageTxt: String;
                     Buttons   : TMsgDlgButtons = [];
                     Kind      : Integer = -1;
                     HelpCtx: Longint = -1;
                     X: Integer = -1;
                     Y: Integer = -1;
                     DefaultBtn: Integer = 0) : TModalResult;
begin
  Result := Execute(Caption, MessageTxt, Buttons, Kind, HelpCtx, X, Y, DefaultBtn);
end;
{$endif}

{ ---------------------------------------------------------------------------- }
function TLMDMessageBoxDlg.ExecuteWithDefaults(const MessageTxt: String;
                     const Caption: String = '';
                     Buttons   : TMsgDlgButtons = [];
                     Kind      : Integer = -1;
                     HelpCtx: Longint = -1;
                     X: Integer = -1;
                     Y: Integer = -1;
                     DefaultBtn: Integer = 0) : TModalResult;
begin
  Result := Execute(Caption, MessageTxt, [], Buttons, Kind, HelpCtx, X, Y, DefaultBtn);
end;

{ ---------------------------------------------------------------------------- }
function TLMDMessageBoxDlg.ShowMessage (const MessageTxt : String):Integer;
begin
  Execute ('', MessageTxt, [], [mbOk], Ord(FDlgType), -1, -1, -1, 0);
  result:=1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDMessageBoxDlg.MessageDlg (const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons;
                                             HelpCtx: Longint): Word;
begin
  result := Execute ('', Msg, [], AButtons, Ord(AType), HelpCtx, -1, -1, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDMessageBoxDlg.MessageDlgPos(const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons;
                                               HelpCtx: Longint; X, Y: Integer): Word;
begin
  result := Execute ('', Msg, [], AButtons, Ord(AType), HelpCtx, x, y, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMessageBoxDlg.ShowMessageFmt(const Msg: string; const Params: array of const);
begin
  Execute ('', Msg, Params, [mbOk], Ord(FDlgType), -1, -1, -1, 0);
end;

{ ---------------------------------------------------------------------------- }

function TLMDMessageBoxDlg.MessageBox(Text, Caption: PChar; Flags: Longint): Integer;

var
  res : TModalResult;
  but : TMsgDlgButtons;
  typ : TMsgDlgType;
  DefBtn : Integer;
begin
  result:=0;
  but := [];

  // 7.0 -> correct order for flag test
  if (MB_OKCANCEL and flags) = MB_OKCANCEL then but:=[mbOk, mbCancel];
  if (MB_ABORTRETRYIGNORE and flags) = MB_ABORTRETRYIGNORE then but := [mbAbort, mbRetry, mbIgnore];
  if (MB_YESNOCANCEL and flags) = MB_YESNOCANCEL then but := [mbYes, mbNo, mbCancel];
  if (MB_YESNO and flags) = MB_YESNO then but := [mbYes, mbNo];
  if (MB_RETRYCANCEL and flags) = MB_RETRYCANCEL then but := [mbRetry, mbCancel];
  if but=[] then but:=[mbOK];

  // dialog type
  typ := FDlgType;
  if ((MB_ICONEXCLAMATION and flags) = MB_ICONEXCLAMATION) or
     ((MB_ICONWARNING and flags) = MB_ICONWARNING) then
    typ := mtWarning;
  if (MB_ICONQUESTION and flags) = MB_ICONQUESTION then
    typ := mtConfirmation;
  if ((MB_ICONSTOP and flags) = MB_ICONSTOP) or ((MB_ICONERROR and flags) = MB_ICONERROR)
     or ((MB_ICONHAND and flags) = MB_ICONHAND) then
    typ := mtError;
  if ((MB_ICONINFORMATION and flags) = MB_ICONINFORMATION) or
     ((MB_ICONASTERISK and flags) = MB_ICONASTERISK) then
    typ:=mtInformation;

  DefBtn := 0;
  if (MB_DEFBUTTON2 and flags) = MB_DEFBUTTON2 then
    DefBtn := 1;
  if (MB_DEFBUTTON3 and flags) = MB_DEFBUTTON3 then
    DefBtn := 2;
  if (MB_DEFBUTTON4 and flags) = MB_DEFBUTTON4 then
    DefBtn := 3;

  res := Execute (StrPas(Caption), StrPas(Text), [0], but, Ord(typ), -1, -1, -1, DefBtn);

  case res of
    mrOk     : result := IDOK;
    mrCancel : result := IDCANCEL;
    mrIgnore : result := IDIGNORE;
    mrRetry  : result := IDRETRY;
    mrYes    : result := IDYES;
    mrNo     : result := IDNO;
    mrAbort  : result := IDABORT;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDMessageBoxDlg.MessageBox(Text, Caption: PChar): Integer;

begin
  result := MessageBox (Text, Caption, 0);
end;

function TLMDMessageBoxDlg.MessageBox(Text:PChar; Flags: Longint): Integer;
begin
  result := MessageBox (Text, int_Ref(''), Flags);
end;

{ ---------------------------------------------------------------------------- }

function TLMDMessageBoxDlg.MessageBox (Text:PChar): Integer;
begin
  result := MessageBox (Text, int_Ref(''), 0);
end;

{ ---------------------------------------------------------------------------- }
function LMDExecuteMsg (const Caption,
                        MessageTxt: String; const Params : array of const;
                        Buttons   : TMsgDlgButtons;
                        Kind      : Integer;
                        HelpCtx: Longint;
                        X, Y, DefaultBtn: Integer) : TModalResult;
begin
  if LMDApplication.MsgBox is TLMDMessageBoxDlg then
    result := TLMDMessageBoxDlg(LMDApplication.MsgBox).Execute (Caption, MessageTxt, Params, Buttons, Kind,
                                                                HelpCtx, X, Y, DefaultBtn)
  else
    result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDShowMessage (const MessageTxt : String);
begin
  if LMDApplication.MsgBox is TLMDMessageBoxDlg then
    TLMDMessageBoxDlg(LMDApplication.MsgBox).ShowMessage (MessageTxt)
  else
    ShowMessage (MessageTxt);
end;

{ ---------------------------------------------------------------------------- }
function LMDMessageDlg (const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons; HelpCtx: Longint): Word;
begin
  if LMDApplication.MsgBox is TLMDMessageBoxDlg then
    result := TLMDMessageBoxDlg(LMDApplication.MsgBox).MessageDlg (Msg, AType, AButtons, HelpCtx)
  else
    result := MessageDlg (Msg, AType, AButtons, HelpCtx)
end;

{ ---------------------------------------------------------------------------- }
function LMDMessageDlgPos(const Msg: string; AType: TMsgDlgType; AButtons: TMsgDlgButtons;
                                HelpCtx: Longint; X, Y: Integer): Word;
begin
  if LMDApplication.MsgBox is TLMDMessageBoxDlg then
    result := TLMDMessageBoxDlg(LMDApplication.MsgBox).MessageDlgPos (Msg, AType, Abuttons, HelpCtx, x, y)
  else
    result := MessageDlgPos (Msg, AType, Abuttons, HelpCtx, x, y);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDShowMessageFmt(const Msg: string; const Params: array of const);
begin
  if LMDApplication.MsgBox is TLMDMessageBoxDlg then
    TLMDMessageBoxDlg(LMDApplication.MsgBox).ShowMessageFmt (Msg, Params)
  else
    ShowMessageFmt (Msg, Params);
end;

{ ---------------------------------------------------------------------------- }

function LMDMessageBox(Text, Caption: PChar; Flags: Longint): Integer;

begin
  if LMDApplication.MsgBox is TLMDMessageBoxDlg then
    result := TLMDMessageBoxDlg(LMDApplication.MsgBox).MessageBox (Text, Caption, Flags)
  else
    result := Application.MessageBox (Text, Caption, Flags)
end;

end.
