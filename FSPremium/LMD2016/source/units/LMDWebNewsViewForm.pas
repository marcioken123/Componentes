unit LMDWebNewsViewForm;
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

LMDWebNewsViewForm unit (DD)
----------------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, ImgList, Controls, ComCtrls, ToolWin, Classes, ExtCtrls, Messages,
  LMDNews, LMDWebXML;

type
  TLMDOnNewsEvent = procedure(Sender:TObject;Item: TLMDXMLTag; const szURL: string) of object;

  TLMDWebNewsViewForm_ = class(TForm)
    Panel: TPanel;
    StatusBar: TStatusBar;
    Animate: TAnimate;
    NewsTreeView: TTreeView;
    ToolBar: TToolBar;
    GetNewsButton: TToolButton;
    HelpButton: TToolButton;
    PropertiesButton: TToolButton;
    ImageList1: TImageList;
    procedure FormShow(Sender: TObject);
    procedure LMDWebNewsComplete(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NewsTreeViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NewsTreeViewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GetNewsButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure PropertiesButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NewsTreeViewExit(Sender: TObject);
  protected
    procedure AddToTree(Node: TTreeNode; Tags: TLMDXMLTags);
  private
    FHint: String;
    aNews: TLMDWebNews;
    FOldEvent : TNotifyEvent;
    FOnNewsClick: TLMDOnNewsEvent;
    FOnNewsHint:TNotifyEvent;
    FOnGetNewsClick: TNotifyEvent;
    FOnHelpClick: TNotifyEvent;
    FOnPropertiesClick: TNotifyEvent;
    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure FireURL(Item: TLMDXMLTag; const URL: string);
  public
    LMDWebNews : TLMDWebNews;
    ImageList  : TImageList;
    bLoading   : Boolean;
    procedure BuildTreeView;
    procedure OnClick(Sender:TObject;Item: TLMDXMLTag; const szURL: string);
    procedure OnHit(Sender:TObject);
    procedure UpdateOnShow(News: TLMDWebNews; Images: TImageList);
    property NewsHint:String read FHint;
  published
    property OnNewsClick: TLMDOnNewsEvent read FOnNewsClick write FOnNewsClick;
    property OnNewsHint: TNotifyEvent read FOnNewsHint write FOnNewsHint;
    property OnGetNewsClick: TNotifyEvent read FOnGetNewsClick write FOnGetNewsClick;
    property OnHelpClick: TNotifyEvent read FOnHelpClick write FOnHelpClick;
    property OnPropertiesClick: TNotifyEvent read FOnPropertiesClick write FOnPropertiesClick;
  end;

implementation

uses
  Variants, ShellAPI, Windows, SysUtils,
  LMDWebBase;

{$R *.DFM}

procedure TLMDWebNewsViewForm_.FormShow(Sender: TObject);
begin
  Animate.Visible := bLoading;
  Animate.Active := bLoading;
  UpdateOnShow(LMDWebNews, ImageList);
  OnNewsClick := OnClick;
  OnNewsHint := OnHit;
  FOldEvent := LMDWebNews.OnComplete;
  if bLoading then
  begin
    NewsTreeView.Tag := -1;
    LMDWebNews.OnComplete := LMDWebNewsComplete;
    Animate.BringToFront;
    LMDWebNews.CheckNews;
  end
  else
  begin
    Animate.SendToBack;
    Caption := LMDWebNews.Caption;
  end;
end;

procedure TLMDWebNewsViewForm_.LMDWebNewsComplete(Sender: TObject);
begin
  Caption := LMDWebNews.Caption;
  BuildTreeView;
  Animate.Visible := False;
  Animate.Active := False;
  Animate.SendToBack;
  if Assigned(FOldEvent) then
    FOldEvent(LMDWebNews);
  NewsTreeView.Tag := 0;
end;

procedure TLMDWebNewsViewForm_.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LMDWebNews.StopProcessing;
  LMDWebNews.OnComplete := FOldEvent;
end;

procedure TLMDWebNewsViewForm_.OnClick(Sender:TObject;Item: TLMDXMLTag;
  const szURL: string);
begin
  ShellExecute(0, nil, Pchar(szURL), nil,nil, SW_SHOW);
end;

procedure TLMDWebNewsViewForm_.OnHit(Sender:TObject);
begin
  StatusBar.SimpleText := NewsHint;
end;

{-----------------------------------------------------------------------------}
procedure TLMDWebNewsViewForm_.AddToTree(Node: TTreeNode;
  Tags: TLMDXMLTags);
var
  i:     integer;
  iImg:  integer;
  szTmp: string;
  TI:    TTreeNode;
begin
  for i := 0 to Tags.Count - 1 do
  begin
    if Node = nil then
      TI := NewsTreeView.Items.Add(nil, Tags[i].Text)
    else
      TI := NewsTreeView.Items.AddChild(Node, Tags[i].Text);
    szTmp := Tags[i].Attributes.Values[LNEWS_IMAGE];
    iImg  := -1;
    if szTmp <> '' then
      try
        iImg := StrToInt(szTmp);
      except
      end;
    TI.ImageIndex := iImg;
    szTmp         := Tags[i].Attributes.Values[LNEWS_SEL_IMAGE];
    if szTmp <> '' then
      try
        iImg := StrToInt(szTmp);
      except
      end;
    TI.SelectedIndex := iImg;
    TI.Data          := Tags[i];
    AddToTree(TI, Tags[i].SubTags);
    TI.Expand(True);
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDWebNewsViewForm_.BuildTreeView;
begin
  NewsTreeView.Items.Clear;
  NewsTreeView.Items.BeginUpdate;
  try
    AddToTree(nil, aNews.News);
  finally
    NewsTreeView.Items.EndUpdate;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDWebNewsViewForm_.UpdateOnShow(News: TLMDWebNews; Images: TImageList);
begin
  aNews := News;
  if Images <> nil then
    NewsTreeView.Images := Images;
  BuildTreeView;
end;

{-----------------------------------------------------------------------------}
procedure TLMDWebNewsViewForm_.FireURL(Item: TLMDXMLTag; const URL: string);
var
  szTmp: string;
begin
  if  URL <> '' then
    szTmp := URL
  else
    szTmp := Item.Attributes.Values[LNEWS_URL];

  if  (szTmp <> '') and Assigned(FOnNewsClick) then
    FOnNewsClick(self, Item, szTmp);
end;

{-----------------------------------------------------------------------------}
procedure TLMDWebNewsViewForm_.NewsTreeViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node:  TTreeNode;
begin
  if Button<>mbLeft then
    exit;
  if htOnItem in NewsTreeView.GetHitTestInfoAt(X, Y) then
  begin
    Node := NewsTreeView.GetNodeAt(X, Y);
    if Node <> nil then
      FireURL(TLMDXMLTag(Node.Data), '');
  end;
end;

procedure TLMDWebNewsViewForm_.NewsTreeViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  szTmp: string;
  Node:  TTreeNode;
begin
  if NewsTreeView.Tag = -1 then exit; // Lock

  if  htOnItem in NewsTreeView.GetHitTestInfoAt(X, Y) then
    Node := NewsTreeView.GetNodeAt(X,Y)
  else
    Node := nil;

  szTmp:='';
  if Node<>nil then
    szTmp := TLMDXMLTag(Node.Data).Attributes.Values[LNEWS_URL];
  if szTmp<>FHint then
    begin
      FHint:=szTmp;
      if Assigned(FOnNewsHint) then FOnNewsHint(self);
    end;
end;

procedure TLMDWebNewsViewForm_.GetNewsButtonClick(Sender: TObject);
begin
  if Assigned(FOnGetNewsClick) then FOnGetNewsClick(Sender);
end;

procedure TLMDWebNewsViewForm_.HelpButtonClick(Sender: TObject);
begin
  if Assigned(FOnHelpClick) then FOnHelpClick(Sender);
end;

procedure TLMDWebNewsViewForm_.PropertiesButtonClick(Sender: TObject);
begin
  if Assigned(FOnPropertiesClick) then FOnPropertiesClick(Sender);
end;

procedure TLMDWebNewsViewForm_.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then
  begin
    NewsTreeView.Tag := -1;
    LMDWebNews.OnComplete := LMDWebNewsComplete;
    Animate.BringToFront;
    LMDWebNews.CheckNews;
  end
  else
  if  (Key = VK_ESCAPE) and (Shift = [])  then
    Close
  else
  if  (Key = VK_RETURN) and Assigned(NewsTreeView.Selected) then
    FireURL(TLMDXMLTag(NewsTreeView.Selected.Data), '');
end;

procedure TLMDWebNewsViewForm_.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo);
begin
  inherited;

  with Msg.MinMaxInfo.ptMinTrackSize do
  begin
    x := self.Constraints.MinWidth;
    y := self.Constraints.MinHeight;
  end;
end;

procedure TLMDWebNewsViewForm_.NewsTreeViewExit(Sender: TObject);
begin
  FHint:='';
  if Assigned(FOnNewsHint) then FOnNewsHint(self);
end;

end.
