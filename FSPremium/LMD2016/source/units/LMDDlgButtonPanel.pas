unit LMDDlgButtonPanel;
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

LMDDlgButtonPanel unit (RM)
---------------------------

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Classes, Controls,
  LMDSimplePanel,
  LMDBase;

type
  TLMDDlgButtonAlign=(baTopLeft, baRightBottom, baCenter);
  TLMDDlgButtonOption=(boAttachBtnHelp,  // integrate a simple Help (-> HelpContext ID) event
                       boCheckBtnTag);   // allow individual gap settings using
  TLMDDlgButtonOptions=set of TLMDDlgButtonOption;

const
  def_BtnOptions=[boAttachBtnHelp, boCheckBtnTag];

type
  TLMDDlgButtonPanel = class(TLMDSimplePanel)
  private
    FBtnGap,
    FBtnMargin:Byte;
    FBtnAlign:TLMDDlgButtonAlign;
    FOptions:TLMDDlgButtonOptions;
    procedure SetButtonAlign(aValue:TLMDDlgButtonAlign);
    procedure SetButtonGap(aValue:Byte);
    procedure SetButtonMargin(aValue:Byte);
    procedure SetOptions(aValue:TLMDDlgButtonOptions);
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Loaded;override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoHelpClick(Sender:TObject);
    procedure EndUpdate(aValue:Boolean);override;
  published
    property Align;
    property BtnAlign:TLMDDlgButtonAlign read FBtnAlign write SetButtonAlign default baTopLeft;
    property BtnGap:Byte read FBtnGap write SetButtonGap default 10;
    property BtnMargin:Byte read FBtnMargin write SetButtonMargin default 10;
    property BtnOptions:TLMDDlgButtonOptions read FOptions write SetOptions default def_BtnOptions;
  end;

implementation

uses

  Forms,
  stdctrls
  ;
{********************** Class TLMDDlgButtonPanel ******************************}
{------------------------- Private --------------------------------------------}
procedure TLMDDlgButtonPanel.SetButtonAlign(aValue:TLMDDlgButtonAlign);
begin
  if aValue<>FBtnAlign then
    begin
      FBtnAlign:=aValue;
      ReAlign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonPanel.SetButtonGap(aValue:Byte);
begin
  if aValue<>FBtnGap then
    begin
      FBtnGap:=aValue;
      ReAlign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonPanel.SetButtonMargin(aValue:Byte);
begin
  if aValue<>FBtnMargin then
    begin
      FBtnMargin:=aValue;
      ReAlign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonPanel.SetOptions(aValue:TLMDDlgButtonOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      ReAlign;
    end;
end;

{------------------------------ Protected -------------------------------------}
procedure TLMDDlgButtonPanel.AdjustClientRect(var Rect: TRect);
begin
  Rect:=BeveledRect;
  inherited AdjustClientRect(Rect);
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonPanel.AlignControls(AControl: TControl; var Rect: TRect);
var
  Btns:TList;
  i, j, wi, cwi, cp:Integer;
  horz:Boolean;
  aRect:TRect;

begin
  inherited AlignControls(aControl, Rect);
  if isUpdating then exit;
  aRect:=BeveledRect;

  Btns:=TList.Create;
  try
    wi:=0;cp:=0;
    // Count all Button Controls
    horz:=not (Align in [alRight, alLeft]);
    for i:=0 to Pred(ControlCount) do
      if (Controls[I] is TButton) then
        if (TButton(Controls[i]).Visible) or (csDesigning in ComponentState) then  // at Designtime we show all buttons
          begin
            j:=Btns.Add(Controls[i]);
            if horz then
              Inc(wi, TButton(Btns[j]).Width)
            else
              Inc(wi, TButton(Btns[j]).Height);
            if boCheckBtnTag in FOptions then
              Inc(wi, integer(TButton(Btns[j]).Tag));
          end;
    if Btns.Count>0 then
      Inc(wi,FBtnGap*Pred(Btns.Count));

    if horz then
      begin
        case FBtnAlign of
          baTopLeft:cp:=aRect.Left+FBtnMargin;
          baRightBottom:cp:=aRect.Right-wi-FBtnMargin;
          baCenter: cp:=aRect.Left+((aRect.Right-aRect.Left)-wi) Div 2;
        end;
        cwi:=aRect.Bottom-aRect.Top;
        for i:=0 to Pred(Btns.Count) do
          with TButton(Btns[i]) do
            begin
              if boCheckBtnTag in FOptions then Inc(cp, integer(Tag));
              Left:=cp;
              Top:=aRect.Top+(cwi-Height) Div 2;
              Inc(cp, Width+FBtnGap);
            end
      end
    else
      begin
        case FBtnAlign of
          baTopLeft:cp:=aRect.Top+FBtnMargin;
          baRightBottom:cp:=aRect.Bottom-wi-FBtnMargin;
          baCenter:cp:=aRect.Top+((aRect.Bottom-aRect.Top)-wi) Div 2;
        end;
        cwi:=aRect.Right-aRect.Left;
        for i:=0 to Pred(Btns.Count) do
          with TButton(Btns[i]) do
            begin
              if boCheckBtnTag in FOptions then Inc(cp, integer(Tag));
              Top:=cp;
              Left:=aRect.Left+(cwi-Width) Div 2;
              Inc(cp, Height+FBtnGap);
            end;
        end;
  finally
    Btns.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonPanel.Loaded;
var
  i:Integer;
begin
  inherited Loaded;
  // check available buttons, if no Event is added to Help Button, add it.
  if boAttachBtnHelp in FOptions then
    for i:=0 to Pred(ControlCount) do
      if (Controls[I] is TButton) then
        with TButton(Controls[i]) do
          if (ModalResult=mrNone) and (Pos('Help', Name)>0) then
            begin
              OnClick:=DoHelpClick;
              exit;
            end;

end;

{---------------------------- Public ------------------------------------------}
constructor TLMDDlgButtonPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBtnMargin:=10;
  FBtnGap:=10;
  FOptions:=def_BtnOptions;
end;

{------------------------------------------------------------------------------}
destructor TLMDDlgButtonPanel.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonPanel.DoHelpClick(Sender:TObject);
begin
  Application.HelpContext(TWinControl(Owner).HelpContext);
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonPanel.EndUpdate(aValue:Boolean);
begin
  inherited EndUpdate(false);
  if aValue then
    ReAlign;
end;

end.
