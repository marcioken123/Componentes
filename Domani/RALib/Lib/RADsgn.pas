{***********************************************************
                R&A Library
       Copyright (C) 1996-98 R&A

       description : routines for design-time

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit RADsgn;

interface

uses
  Windows, Messages, Forms, Controls, Graphics, SysUtils, Classes,
  DsgnIntf, RADsgnIntf;


implementation


procedure DrawDesignFrame(Canvas : TCanvas; Rect : TRect);
begin
  if Canvas.Handle <> 0 then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := clGray;
    Canvas.Pen.Style := psDot;
    Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  end;
end;

{$IFDEF RA_D4H}
type
  TMyComponent = class(TComponent);

procedure GetDesigner(Self: TPersistent; out Result: IDesignerNotify);
var
  Temp: TPersistent;
begin
  Result := nil;
  if Self = nil then Exit;
  Temp := TMyComponent(Self).GetOwner;
  if Temp = nil then
  begin
    if (Self is TComponent) and (csDesigning in TComponent(Self).ComponentState) then
      TMyComponent(Self).QueryInterface(IDesignerNotify, Result);
  end
  else
  begin
    if (Self is TComponent) and
      not (csDesigning in TComponent(Self).ComponentState) then Exit;
    GetDesigner(Temp, Result);
  end;
end;

procedure DesignerNotify(Self, Item: TComponent; Operation: TOperation);
var
  Designer: IDesignerNotify;
begin
  if csDesigning in Self.ComponentState then
  begin
    GetDesigner(Self, Designer);
    if Designer <> nil then
      Designer.Notification(Item, Operation);
  end;    
end;

procedure DesignerModified(Self : TComponent);
var
  Designer: IDesignerNotify;
begin
  if csDesigning in Self.ComponentState then
  begin
    GetDesigner(Self, Designer);
    if Designer <> nil then
      Designer.Modified;
  end;
end;

procedure DesignerSelectComponent(Self : TComponent);
var
  Designer: IDesignerNotify;
  Designer1: IFormDesigner;
begin
  if csDesigning in Self.ComponentState then
  begin
    GetDesigner(Self, Designer);
    if (Designer <> nil) then
    begin
      Designer.QueryInterface(IFormDesigner, Designer1);
      if Designer1 <> nil then
        Designer1.SelectComponent(Self);
    end;
  end;
end;

{$ELSE}

function GetDesigner(Self : TComponent) : TDesigner;
begin
  Result := nil;
  while (Self <> nil) and not (Self is TForm) and (Self.Owner <> nil) do
    Self := Self.Owner;
  if Self is TForm then
    Result := (Self as TForm).Designer;
end;

procedure DesignerNotify(Self, Item: TComponent; Operation: TOperation);
var
  Designer: TDesigner;
begin
  if csDesigning in Self.ComponentState then
  begin
    Designer := GetDesigner(Self);
    if Designer <> nil then
      Designer.Notification(Item, Operation);
  end;
end;

procedure DesignerModified(Self : TComponent);
var
  Designer : TDesigner;
begin
  if csDesigning in Self.ComponentState then
  begin
    Designer := GetDesigner(Self);
    if Designer <> nil then Designer.Modified;
  end;
end;

procedure DesignerSelectComponent(Self : TComponent);
var
  Designer : TDesigner;
begin
  if csDesigning in Self.ComponentState then
  begin
    Designer := GetDesigner(Self);
    if (Designer is TFormDesigner) then
      (Designer as TFormDesigner).SelectComponent(Self);
  end;
end;

{$ENDIF}


initialization
  DrawDesignFrameProc := DrawDesignFrame;
  DesignerNotifyProc := DesignerNotify;
  DesignerModifiedProc := DesignerModified;
  DesignerSelectComponentProc := DesignerSelectComponent;
end.
