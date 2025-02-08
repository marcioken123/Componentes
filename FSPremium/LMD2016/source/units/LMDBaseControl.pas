unit LMDBaseControl;
{$I lmdcmps.inc}

{
  ##############################################################################
  # Author:     LMD Innovative ()
  # Created:    1996
  # Description:  Unit is deprecated!
  #     Please remove it from you (header) file interfaces
  # State:    release
  # Comments:
  ##############################################################################
}
interface
uses
  Classes, Controls, Menus, Messages,
  intfLMDBase, LMDClass, LMDTypes ;

type
  {-------------------- TLMDBaseControl ---------------------------------------}
  TLMDBaseControl = class(TGraphicControl, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FOnMouseEnter,
    FOnMouseExit:TNotifyEvent;
    //FOnResize: TNotifyEvent;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure DrawDashedFrame;
    procedure FillControl;
    function GetEmpty: Boolean; virtual;
    procedure MouseEnter; virtual;
    procedure MouseExit; virtual;
    procedure Paint; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;virtual;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit: TNotifyEvent read FOnMouseExit write FOnMouseExit;
    //property OnResize: TNotifyEvent read FOnResize write FOnResize;
  end;

implementation
uses
  Graphics{$IFDEF LMD_DEBUGTRACE},Windows, Dialogs;{$I C2.INC}{$ELSE};{$ENDIF}
{******************* Class TLMDBaseControl ************************************}
{------------------------- Private --------------------------------------------}
procedure TLMDBaseControl.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  // 6.11
  if csDesigning in ComponentState then exit;
  // --
  MouseEnter;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  // 6.11
  if csDesigning in ComponentState then exit;
  // --
  MouseExit;
end;
{------------------------- Protected ------------------------------------------}
procedure TLMDBaseControl.DrawDashedFrame;
begin
  with Canvas do
    begin
      Pen.Color:= clBlack;
      Pen.Width:= 1;
      Pen.Style:= psDash;
      Pen.Mode:= pmCopy;
      Brush.Style:= bsClear;
      Rectangle(0, 0, Width, Height);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseControl.FillControl;
begin
  with Canvas do
    begin
      Brush.Style:= bsSolid;
      Brush.Color:= Color;
      pen.Style:= psClear;
      FillRect(ClientRect);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseControl.GetEmpty: Boolean;
begin
  result:= True;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseControl.MouseEnter;
begin
  if not Enabled then exit; //JH, 30.03.01
  if Assigned(FOnMouseEnter) then FOnMouseEnter(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseControl.MouseExit;
begin
  if not Enabled then exit; //JH, 30.03.01
  if Assigned(FOnMouseExit) then FOnMouseExit(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseControl.Paint;
begin
  if (csDesigning in ComponentState) then DrawDashedFrame;
end;

{------------------------- Public----------------------------------------------}
constructor TLMDBaseControl.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseControl.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDBaseControl.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}

end.
