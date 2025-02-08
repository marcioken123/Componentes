unit wwprpds;
{
//
// Components : Property Editors
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
}

interface

{$i wwIfDef.pas}

Uses
     db, wwTable, sysutils,
     {$ifdef wwdelphi6up}
     designintf, designeditors,
     {$else}
     dsgnintf,
     {$endif}
     classes, dbtables, wwstr, wwQuery, typinfo, wwstorep,
     wwcommon, dialogs,
     {$ifdef wwDelphi3Up}
     forms,
     {$endif}
     wwQBE;
type
  TwwDataSetProperty = class(TComponentProperty)
    procedure GetValues(Proc : TGetStrProc); override;
    procedure wwGetStrProc(const s: string);
  end;


implementation

{$ifdef win32}
type PGetStrProc = ^TGetStrProc;
{
TwwDesigner = class(TFormDesigner)
public
   procedure wwGetStrProc(const s: string);
end;
}
var MyProc: TGetStrProc;

procedure TwwDataSetProperty.wwGetStrProc(const s: string);
var Component: TComponent;
begin
  component:= Designer.GetComponent(s);
  if (Component is TDataSet) and wwDataSet(Component as TDataSet)
    and (Component.Name <> '') then
  MyProc(s);
end;
{$endif}

procedure TwwDataSetProperty.GetValues(Proc : TGetStrProc);
  {$ifndef win32}
  var
  I: Integer;
  ownerComponent, Component: TComponent;
  {$endif}
begin
  {$ifdef win32}
  MyProc:= Proc;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TDataSet)), wwGetStrProc);
  {$else}
  ownerComponent:= (GetComponent(0).Owner);
  if ownerComponent = nil then exit;

  for I := 0 to ownerComponent.ComponentCount - 1 do
  begin
    Component := ownerComponent.Components[I];
    if (Component is TDataSet) and wwDataSet(Component as TDataSet)
       and (Component.Name <> '') then
      Proc(Component.Name);
  end;
  {$endif}

end;

end.
