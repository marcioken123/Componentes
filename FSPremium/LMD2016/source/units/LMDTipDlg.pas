unit LMDTipDlg;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
¨Ï by LMD Innovative
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

LMDTipDlg unit ()
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, StdCtrls, Forms,
  LMDButton, LMDCheckBox, LMDSimpleLabel, LMDBaseDialog;

type
  TLMDTipsDialogMode=(moNormal, moStart);

  TLMDTipDlg = class(TLMDBaseDialog)
    private
      FCaptionHeader:String;
      FCaptionHelp:String;
      FTips:TStringList;
      FFirst:Integer;
      FShowStart,
      FHide,
      FFirstFlag:Boolean;
      FMode:TLMDTipsDialogmode;
      FHelpContext:THelpContext;

      tiplabel: TLabel;
      showtips: TLMDCheckBox;
      tiptitle: TLabel;
      prev,
      next,
      //sl: TLMDSimpleLabel;
      ok, help: TLMDButton;

      Actualpos:Integer;
      Last:TStringList;
      show:Boolean;

      //CONDEV 20050613: for "ShowRandom" property
      FShowRandom : boolean;

      Procedure SetTips(aStrings:TStringList);
      Procedure SetTipsCount(aInt:Integer);
      function GetTipsCount:Integer;

      procedure nexttip(Sender: TObject);
      procedure lasttip(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure DoChange(Sender:TObject);
      procedure FormActivate(Sender: TObject);
      procedure helpClick(Sender: TObject);
      function GetListTip(index: Integer):String;
      procedure GetTip;
    public
      constructor Create(AOwner:TComponent);override;
      destructor Destroy;override;
      function Execute:Boolean;override;
      function ExecuteEnh(main:TForm; Mode:TLMDTipsDialogmode):Boolean;
      property CtlXP; // compatiblity
    published
      property About;
      property CaptionFill;
      property CaptionHeader:String read FCaptionHeader write FCaptionHeader;
      property CaptionHelp:String read FCaptionHelp write FCaptionHelp;
      property CaptionTitle;
      property Colors;
      property CustomButton;
      property Effect;
      property HideShowAtStart:Boolean read FHide write FHide default false;
      property FirstHintNumber:Integer read FFirst write FFirst default -1;
      property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
      property Hints;
      property ImageList;
      property ImageIndex;
      property ListIndex;
      property Mode:TLMDTipsDialogMode read FMode write FMode default moNormal;
      property Position;
      property RelatePos;
      property ShowAtStart:Boolean read FShowStart write FShowStart default false;
      property ShowHints;
      //CONDEV 20050613: "ShowRandom" property added
      property ShowRandom:Boolean read FShowRandom write FShowRandom default true;
      property Tips:TStringList read FTips write Settips;
      property TipsCount:Integer read GetTipsCount write SetTipsCount stored false;

      // 9.0
      property ThemeMode;
      property ThemeGlobalMode;      
      {Events}
      property OnCustomize;
      property OnCustomClick;
   end;

implementation

uses
  Windows, SysUtils, Controls, Dialogs, Graphics,
  LMDConst, LMDMain, LMDGraph, LMDBase, LMDFormStyler, LMDBack, LMDProcs,
  LMDNImage, LMDSimplePanel, LMDStrings;

{----------------------------  Private ----------------------------------------}
Procedure TLMDTipDlg.SetTips(aStrings:TStringList);
begin
  FTips.Assign(aStrings);
end;

{------------------------------------------------------------------------------}
Procedure TLMDTipDlg.SetTipsCount(aInt:Integer);
begin
end;

{------------------------------------------------------------------------------}
function TLMDTipDlg.GetTipsCount:Integer;
begin
  result:=FTips.Count;
end;

{------------------------------------------------------------------------------}
procedure TLMDTipDlg.DoChange(Sender: TObject);
begin
  FTips.OnChange:=nil;
  try
    LMDAnsiRemoveEmptyLines(FTips);
  finally
    FTips.OnChange:=DoChange;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTipDlg.FormActivate(Sender: TObject);
begin
  if not show then
    begin
      Gettip;
      prev.enabled:=(ActualPos>0);
      ok.SetFocus;
      show:=true;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTipDlg.FormDestroy(Sender: TObject);
begin
  Last.Free;
  Last:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDTipDlg.lasttip(Sender: TObject);
begin
  Dec(ActualPos);
  TipLabel.Caption:=GetListTip(StrToInt(last[ActualPos]));
  prev.enabled:=(ActualPos>0);
  next.enabled:=FTips.Count>(Actualpos+1);
end;

{------------------------------------------------------------------------------}
procedure TLMDTipDlg.helpClick(Sender: TObject);
begin
  Application.HelpContext(help.HelpContext);
end;

{------------------------------------------------------------------------------}
procedure TLMDTipDlg.nexttip(Sender: TObject);
begin
  GetTip;
end;

{------------------------------------------------------------------------------}
function TLMDTipDlg.GetListTip(Index:Integer):String;
begin
  if (index>=0) and (index<FTips.Count) then result:=FTips[index];
end;

{------------------------------------------------------------------------------}
procedure TLMDTipDlg.GetTip;
var
  nr,i:Integer;
  flag:boolean;

begin
  with Last do
    begin
      if Actualpos<Last.Count-1 then
        begin
          Inc(Actualpos);
          TipLabel.Caption :=GetListTip(StrToInt(Last[ActualPos]));
        end
       else
        begin
          if FFirstFlag then
            begin
              nr:=FFirst;
              FFirstFlag:=false;
            end
          else
            begin
              // 7.01.50
              nr:=-1;
              repeat
                if FShowRandom then
                  nr:=Random(FTips.Count)
                else
                  nr:=nr+1;
              // -------
                flag:=true;
                for i:=0 to Count-1 do
                  if IntToStr(nr)=Last[i] then
                    begin
                      Flag:=False;
                      Break;
                    end;
              until Flag;
            end;
          add(IntToStr(nr));
          TipLabel.Caption := GetListTip(nr);
          ActualPos:=Last.Count-1;
        end;

      prev.Enabled:=Actualpos>0;
      next.enabled:=FTips.count>(Actualpos+1);

   end;
end;

{---------------------------- Public ------------------------------------------}
constructor TLMDTipDlg.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  // 7.01.50
  FShowRandom:=true;
  // --------
  FTips:=TStringList.Create;
  FTips.OnChange:=DoChange;
  FHide:=false;
  FFirst:=-1;
end;

{------------------------------------------------------------------------------}
destructor TLMDTipDlg.Destroy;
begin
  FTips.OnChange:=nil;
  FreeAndNil(FTips);
  inherited destroy;
end;

{------------------------------------------------------------------------------}
function TLMDTipDlg.ExecuteEnh(main:TForm; Mode:TLMDTipsDialogmode):Boolean;
var
  TipForm  : TForm;
  mainpanel: TLMDSimplePanel;
  fs       : TLMDFormStyler;
  b        : TLMDBack;
  image    : TLMDNImage;

  custom,
  help     : TButton;
  //sl       : TLMDSimpleLabel;
  i        : Integer;

  function theGreater (i1, i2 : Integer) : Integer;
  begin
    result := i1;
    if i2 > i1 then
      result := i2;
  end;

begin

  result:=false;

  {Prufen, ob ubehaupt angezeigt werden mu©¬}
  if not (((Mode=moStart) and FShowStart) or (mode = moNormal)) then exit;

  If FTips.Count=0 then
    begin
      MessageDlg(IDS_TIPERROR, mtWarning, [mbOK],0);
      exit;
    end;

  FMode:=Mode;

  TipForm := TForm.Create(nil);
  with Tipform do
    try

      Font.Color:=clWindowText;
      BorderStyle:=bsDialog;
      Font.Name:='MS Sans Serif';
      Font.Height:=-11;
      Position:=poDefault;
      PixelsPerInch:=96;
      Scaled:=False;

      i := 80; //assumed button width

      i := theGreater (i, Canvas.TextWidth (IDS_TIPNEXT)+6);
      i := theGreater (i, Canvas.TextWidth (IDS_TIPPREV)+6);

      ok:=TLMDButton.Create(TipForm);
      with ok do
        begin
          Parent:=TipForm;
          Left:=417 - i;
          Top:=9;
          Width:=i;
          Height:=24;
          ModalResult:=1;
          Caption:='OK';
          Default:=True;
          Cancel:=True;
          TabOrder:=0;
        end;

      prev:=TLMDButton.Create(TipForm);
      with prev do
        begin
          Parent:=TipForm;
          Left:=417 - i;
          Top:=69;
          Width:=i;
          Height:=24;
          TabOrder:=2;
        end;

      showtips:=TLMDCheckBox.Create(TipForm);
      with showtips do
        begin
          Parent:=TipForm;
          Left:=5;
          Top:=202; //204-2 28.11.01
          Width:=300; //something large
          Height:=18;
          Flat := IsThemed;
          showtips.Caption:=IDS_SHOWATSTART;
          AutoSize := true;
          TabOrder:=5;
          State:=cbChecked;
          Transparent := True;
        end;

      self.next:=TLMDButton.Create(TipForm);
      with self.next do
        begin
          Parent:=TipForm;
          Left:=417 - i;
          Top:=42;
          Width:=i;
          Height:=24;
          TabOrder:=1;
        end;

      custom:=TLMDButton.Create(TipForm);
      with custom do
        begin
          Parent:=TipForm;
          Left:=417 - i;
          Top:=104;
          Width:=i;
          Height:=24;
          TabOrder:=3;
          Visible:=False;
        end;

      help:=TLMDButton.Create(TipForm);
      with help do
        begin
          Parent:=TipForm;
          Left:=417 - i;
          Top:=171;
          Width:=i;
          Height:=24;
          TabOrder:=4;
          Visible:=False;
        end;

      mainPanel:=TLMDSimplePanel.Create(TipForm);
      with mainPanel do
        begin
          Parent:=TipForm;
          Left:=5;
          Top:=8;
          Width:=417 - i - 12;
          Height:=187;
          Bevel.StyleOuter:=bvLowered;
          Bevel.WidthOuter:=2;
          Color:=14680063;
          TabOrder:=6
        end;

      tiptitle:=TLabel.Create(TipForm);
      with tiptitle do
        begin
          Parent:=mainPanel;
          Left:=38;
          Top:=22;
          Width:=5;
          Height:=16;
          Font.Style:=[fsBold];
          Font.Height:=-14;
          ShowAccelChar:=False;
          Transparent:=True;
        end;

      tipLabel:=TLabel.Create(TipForm);
      with tipLabel do
        begin
          Parent:=mainPanel;
          AutoSize:=False;
          Left:=38;
          Top:=49;
          Width:=mainPanel.Width - Left-30;
          Height:=134;
          Color:=14680063;
          ShowAccelChar:=False;
          Font.Height:=-12;
          Transparent:=True;
          WordWrap:=True;
        end;

      image:=TLMDNImage.Create(TipForm);
      with image do
        begin
          Parent:=mainPanel;
          Left:=5;
          Top:=7;
          Width:=30;
          Height:=40;
          Style:=sbAutoSize;
          TransparentStyle.Color:=clRed;
          TransparentStyle.Mode:=tpRestoreBack;
          image.Bitmap.LoadFromResourceName(HInstance, IDB_TIP);
          end;

      fs:=TLMDFormStyler.Create(TipForm);
      fs.Enabled:=False;

      b:=TLMDBack.Create(TipForm);
      b.Enabled:=False;
      {---}

      if FHelpContext>0 then
        with Help do
          begin
            Visible:=True;
            Caption:=FCaptionHelp;
            HelpContext:=FHelpContext;
          end;

      If (help.visible) and (length(FCaptionHelp)=0) then
        help.Caption:=IDS_HELP;

      //sl.Caption:=IDS_SHOWATSTART;
      //JH, 28.11.01 changed to showtips.Caption

      self.next.Caption:=IDS_TIPNEXT;
      prev.Caption:=IDS_TIPPREV;
      FFirstFlag:=(FFirst>-1) and (FFirst<FTips.Count);
      ShowTips.State := TCheckBoxState(FShowStart);

      {Header}
      If Length(FCaptionHeader)>0 then
        tiptitle.Caption:=FCaptionHeader
      else
        tiptitle.Caption:='Tip...';

      if ShowHints and (Hints.Count>0) then
        begin
          ShowHint:=True;
          ok.Hint:=Hints[0];
          if Hints.Count>1 then custom.Hint:=Hints[1];
          if Hints.Count>2 then self.next.Hint:=Hints[2];
          if Hints.Count>3 then prev.Hint:=Hints[3];
          if Hints.Count>4 then help.Hint:=Hints[4];
          if Hints.Count>5 then
            begin
              //sl.Hint:=Hints[5];
              showtips.Hint:=Hints[5];
            end;
        end;

      OnActivate:=FormActivate;
      OnDestroy:=FormDestroy;
      ActualPos:=0;
      self.show:=false;
      Last:=TStringList.Create;

{      sl.OnClick:=slClick;
      sl.OnDblClick:=slClick; JH 28.11.01}

      help.OnClick:=helpclick;
      prev.OnClick:=lastTip;
      self.next.OnClick:=nextTip;

      ClientWidth:=ok.Left+ok.Width+7;
      {----}

      if FHide then
        begin
          //sl.Visible:=False; JH 28.11.01
          showtips.visible:=false;
          Clientheight:=showtips.top;
        end
      else
        ClientHeight:=showtips.Top+showtips.Height+6;

      BaseExecute(TipForm, Main, Custom,  fs, b, 'Tips&Tricks '+Application.Title+ '...');
      if not Fhide then
        FShowStart:=showtips.State=cbChecked;
    finally
      TipForm.Free;
      self.show:=False;
    end;

end;

{------------------------------------------------------------------------------}
function TLMDTipDlg.Execute:Boolean;
begin
   result:=ExecuteEnh(nil, FMode);
end;

end.
