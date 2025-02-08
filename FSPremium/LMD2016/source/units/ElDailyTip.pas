unit ElDailyTip;
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

ElDailyTip unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Math, TypInfo, Graphics,
  ExtCtrls,  Types, StdCtrls,  

  LMDElConst, LMDHTMLUnit, LMDTypes,

  ElPopBtn, ElBtnCtl, ElStrPool,
  ElStyleMan, ElXPThemedControl, ElComponent, ElHTMLLbl, ElCheckCtl,
  ElCLabel, ElLabel;

type
  TElDailyTipForm = class(TForm)
    OkBtn : TElPopupButton;
    NextBtn : TElPopupButton;
    Panel1 : TPanel;
    Panel2 : TPanel;
    Image1 : TImage;
    Panel3 : TPanel;
    Panel4 : TPanel;
    TipCaptionLabel: TElLabel;
    Panel5 : TPanel;
    TipNumLabel : TElLabel;
    TipText: TElHTMLLabel;
    NextTimeCB: TElCheckBox;
    procedure NextBtnClick(Sender : TObject);
  private
    MinNum,
      CurNum,
      MaxNum : integer;
    FStringPool : TElstringPool;
  public
    { Public declarations }
  end;

  TElDailyTipDialog = class(TElBaseDlgComponent)
  private
    FCaption: TLMDString;
    FOnBeforeShow  : TNotifyEvent;
    FShowNextTime : Boolean;
    FStartID : Integer;
    FEndID : Integer;
    FShowTipNumber : boolean;
    FStringPool    : TElStringPool;
    FIsHTML        : boolean;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FLinkColor: TColor;
    FLinkStyle: TFontStyles;
    procedure SetStringPool(newValue : TElstringPool);
    procedure SetStartID(newValue : Integer);
    procedure SetEndID(newValue : Integer);
    procedure SetIsHTML(newValue : boolean);
  protected
    FUseXPThemes: Boolean;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    public
    function Execute:Boolean;override;
    constructor Create(AOwner : TComponent); override;
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    published
    property ShowNextTime : Boolean read FShowNextTime write FShowNextTime;
    property StartID : Integer read FStartID write SetStartID default 10001;
    property EndID : Integer read FEndID write SetEndID default 10001;
    property ShowTipNumber : boolean read FShowTipNumber write FShowTipNumber default true;
    property StringPool : TElStringPool read FStringPool write SetStringPool;
    property Caption: TLMDString read FCaption write FCaption;
    property IsHTML : boolean read FIsHTML write SetIsHTML;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnBeforeShow     : TNotifyEvent read FOnBeforeShow write FOnBeforeShow;
    property LinkColor: TColor read FLinkColor write SetLinkColor;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property UseXPThemes: Boolean read FUseXPThemes write FUseXPThemes default true;
  end;

var
  ElDailyTipForm : TElDailyTipForm;

implementation
{$ifndef LMDCOMP10}
uses
  LMDGraph, ElCaption;
{$endif}

procedure TElDailyTipDialog.SetIsHTML(newValue : boolean);
begin
  FIsHTmL := newValue;
end;

procedure TElDailyTipDialog.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FStringPool then StringPool := nil;
  end;
end;

procedure TElDailyTipDialog.SetStringPool(newValue : TElstringPool);
begin
  if FStringPool <> newValue then
  begin
    if FStringPool <> nil then
      if not (csDestroying in FStringPool.ComponentState) then
        FStringPool.RemoveFreeNotification(Self);
    FStringPool := NewValue;
    if FStringPool <> nil then FStringPool.FreeNotification(Self);
  end;
end;

constructor TElDailyTipDialog.Create(AOwner : TComponent);
begin
  inherited;
  FStartID := 10001;
  FEndID := 10001;
  FShowTipNumber := true;
  FUseXPThemes := true;
end; {Create}

procedure TElDailyTipDialog.SetStartID(newValue : Integer);
begin
  if (FStartID <> newValue) and (newValue >= 0) then
  begin
    FStartID := newValue;
  end; {if}
end; {SetStartID}

procedure TElDailyTipDialog.SetEndID(newValue : Integer);
begin
  if (FEndID <> newValue) and (newValue >= FStartID) then
  begin
    FEndID := newValue;
  end; {if}
end; {SetEndID}

function TElDailyTipDialog.Execute:Boolean;
var
  i : integer;
  PropInfo   : PPropInfo;
  {$ifndef LMDCOMP10}
  FFormCaption : TElFormCaption;
  {$endif}
begin
  result:=false;
  ElDailyTipForm := TElDailyTipForm.Create(nil);
  Randomize;
  try
    with ElDailyTipForm do
    begin
      if Length(FCaption) > 0 then
        Caption := FCaption
      else
        Caption := SLMDTipOfTheDay;
      TipCaptionLabel.Caption := SLMDDidYouKnow;
      NextTimeCB.Caption := SLMDShowTipsAtStartup;
      NextBtn.Caption := SLMDNextTip;
      OkBtn.Caption := SLMDClose;

      if Assigned(Self.FStringPool) then
      begin
        MinNum := 0;
        MaxNum := Self.FStringPool.Items.Count - 1;
      end
      else
      begin
        MinNum := Min(FStartID, FEndID);
        MaxNum := Max(FStartID, FEndID);
      end;
      CurNum := MinNum + Random(MaxNum - MinNum);
      TipNumLabel.Caption := Format('Tip #%d', [CurNum - MinNum + 1]);
      TipNumLabel.Visible := FShowTipNumber;
      if Assigned(Self.FStringPool) then
         TipText.Caption := Self.FStringPool.Items[CurNum]
      else
        TipText.Caption := LoadStr(CurNum);
        TipText.IsHTML     := IsHTML;
      TipText.LinkColor  := LinkColor;
      TipText.LinkStyle  := LinkStyle;
      TipText.OnLinkClick := FOnLinkClick;
      TipText.OnImageNeeded := FOnImageNeeded;
      NextTimeCB.Checked := FShowNextTime;
      FStringPool := Self.FStringPool;
      {$ifndef LMDCOMP10}
      if Length(FCaption) > 0 then
      begin
        FFormCaption := TElFormCaption.Create(ElDailyTipForm);
        FFormCaption.Texts.Add.Caption := FCaption;
        FFormCaption.Active := TRUE;
        FFormCaption.BackgroundType := bgtColorFill;
        FFormCaption.ActiveLeftColor := clActiveCaption;
        FFormCaption.ActiveRightColor := clActiveCaption;
        FFormCaption.InActiveLeftColor := clInActiveCaption;
        FFormCaption.InActiveRightColor := clInActiveCaption;
      end;
      {$endif}

      for i := 0 to ComponentCount - 1 do
      begin
        PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
        if PropInfo <> nil then
          SetObjectProp(Components[i], PropInfo, Self.StyleManager);
        PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
        if PropInfo <> nil then
          SetStrProp(Components[i], PropInfo, Self.StyleName);
      end;
      for i := 0 to ComponentCount - 1 do
      begin
        PropInfo := TypInfo.GetPropInfo(Components[i].ClassInfo, 'UseXPThemes');
        if PropInfo <> nil then
          SetOrdProp(Components[i], PropInfo, Ord(UseXPThemes));
      end;

      if assigned(FOnBeforeShow) then FOnBeforeShow(ElDailyTipForm);
      if ShowModal=mrOK then
        begin
          FShowNextTime := NextTimeCB.Checked;
          result:=true;
        end;
    end; // with
  finally
    ElDailyTipForm.Free;
  end;
end; {Execute}

procedure TElDailyTipDialog.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkColor }

procedure TElDailyTipDialog.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkStyle }

procedure TElDailyTipDialog.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) then
    if not (csDestroying in FStyleManager.ComponentState) then
      FStyleManager.RemoveFreeNotification(Self);
    FStyleManager := Value;
    if FStyleManager <> nil then
      FStyleManager.FreeNotification(Self);
  end;
end;

procedure TElDailyTipDialog.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    FStyleName := Value;
end;

{$R *.DFM}

procedure TElDailyTipForm.NextBtnClick(Sender : TObject);
begin
  Inc(CurNum);
  if CurNum > MaxNum then CurNum := MinNum;
  if Assigned(FStringPool) then
    TipText.Caption := FStringPool.Items[CurNum]
  else
    TipText.Caption := LoadStr(CurNum);
    TipNumLabel.Caption := Format('Tip #%d', [CurNum - MinNum + 1]);
end;

end.
