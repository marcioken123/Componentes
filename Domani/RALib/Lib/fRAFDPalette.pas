{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       form        : TRAFDPalette
       description : Component palette

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit fRAFDPalette;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Buttons, RAComponentPanel,
  DsgnIntf, RARegAuto, RAButtons;

type
  TRAFDPalette = class(TForm)
    TabControl: TTabControl;
    Palette: TRAComponentPanel;
    RegAuto1: TRegAuto;
    RACaptionButton1: TRACaptionButton;
    RACaptionButton2: TRACaptionButton;
    procedure FormCreate(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure PaletteClick(Sender: TObject; Button: Integer);
    procedure RACaptionButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RACaptionButton2Click(Sender: TObject);
  private
    Minim: Boolean;
    procedure WMGetMinMaxInfo(var M : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    procedure UpdatePalette;
  end;

  procedure Show;
  procedure Close;
  procedure ResetButton;
  function GetControl: TControl;
  procedure HideFromWin;
  procedure UpdatePalette;

  function NoIcon(AComponent: TComponent): Boolean;

var
  ButtonDown: Boolean = False;
  ComponentClass: TComponentClass;
 // ActiveModule: HModule; { moved to RAFD unit }  

implementation

uses RAUtils, RAFDDesigner, RAFD;

{$R *.DFM}

type

  TPaletteEntry = class
  private
    Module: HModule;
    Page: string;
    ComponentClass: TComponentClass;
    constructor Create;
    destructor Destroy; override;
  end;

var
  RegComponentList: TList;
  RegNoIconList: TList;

procedure Show;
var
  Form: TForm;
begin
  Form := FindFormByClass(TRAFDPalette);
  if Form = nil then
    Form := TRAFDPalette.Create(Application);
  Form.Show;
  ButtonDown := False;
end;

procedure Close;
var
  Form: TForm;
begin
  Form := FindFormByClass(TRAFDPalette);
  if Form <> nil then
    Form.Free;
end;

function GetControl: TControl;
var
  Form: TRAFDPalette;
begin
  Form := FindFormByClass(TRAFDPalette) as TRAFDPalette;
  if Form = nil then
    Form := TRAFDPalette.Create(Application);
	Result := Form.TabControl;
  ButtonDown := False;
end;

procedure HideFromWin;
var
  Form: TRAFDPalette;
begin
  Form := FindFormByClass(TRAFDPalette) as TRAFDPalette;
  if Form = nil then Exit;
	Form.TabControl.Parent := Form;
  ButtonDown := False;
end;

procedure ResetButton;
var
  Form: TRAFDPalette;
begin
  Form := FindFormByClass(TRAFDPalette) as TRAFDPalette;
  if Form = nil then Exit;
  ButtonDown := False;
  Form.Palette.SetMainButton;
end;

procedure UpdatePalette;
var
  Form: TRAFDPalette;
begin
  Form := FindFormByClass(TRAFDPalette) as TRAFDPalette;
  if Form <> nil then
    Form.UpdatePalette;
end;


procedure LoadComponentBitmap(Component: TComponent; Bitmap: TBitmap);
var
  i: integer;
begin
	for i := 0 to RegComponentList.Count - 1 do
		with TPaletteEntry(RegComponentList[i]) do
  		if Cmp(Component.ClassName, ComponentClass.ClassName) then
  		begin
  			try
  				Bitmap.LoadFromResourceName(Module, ComponentClass.ClassName);
  			except
  				Bitmap.LoadFromResourceName(hInstance, DefaultComponentBitmap);
  			end;
        Exit;
  		end;
end;    { LoadComponentBitmap }

function ComponentRegistered(AComponentClass: TComponentClass): Boolean;
var
  i: integer;
begin
	for i := 0 to RegComponentList.Count - 1 do
		if TPaletteEntry(RegComponentList[i]).ComponentClass = AComponentClass then
    begin
      Result := True;
      Exit;
    end;
  Result := False;  
end;    { ComponentRegistered }

procedure RARegisterComponentsProc(const Page: string;
    ComponentClasses: array of TComponentClass);
var
  i: integer;
  PaletteEntry: TPaletteEntry;
begin
  for i := Low(ComponentClasses) to High(ComponentClasses) do    { Iterate }
    if not ComponentRegistered(ComponentClasses[i]) then
    begin
      PaletteEntry := TPaletteEntry.Create;
      PaletteEntry.Page := Page;
      PaletteEntry.ComponentClass := ComponentClasses[i];
      PaletteEntry.Module := ActiveModule;
      RegComponentList.Add(PaletteEntry);
      RegisterClasses([ComponentClasses[i]]);
    end;    { for }
end;

procedure RARegisterNonActiveXProc(ComponentClasses: array of TComponentClass;
  AxRegType: TActiveXRegType);
begin
  { stub }
end;

procedure RARegisterNoIconProc(ComponentClasses: array of TComponentClass);
var
  i: integer;
begin
  for i := Low(ComponentClasses) to High(ComponentClasses) do    { Iterate }
  begin
    RegNoIconList.Add(ComponentClasses[i]);
    RegisterClasses([ComponentClasses[i]]);
  end;
end;

function NoIcon(AComponent: TComponent): Boolean;
var
  i: Integer;
begin
  for i := 0 to RegNoIconList.Count - 1 do    { Iterate }
  begin
    if AComponent is TComponentClass(RegNoIconList[i]) then
    begin
      Result := True;
      Exit;
    end;
  end;    { for }
  Result := False;
end;

procedure RARegisterCustomModuleProc(Group: Integer;
    ComponentBaseClass: TComponentClass;
    CustomModuleClass: TCustomModuleClass);
begin
  { stub }
end;

procedure RAFreeCustomModulesProc(Group: Integer);
begin
  { stub }
end;

procedure RACreateVCLComObjectProc(Component: TComponent);
begin
  { stub }
end;

{ TPaletteEntry }
constructor TPaletteEntry.Create;
begin
end;    { Create }

destructor TPaletteEntry.Destroy;
begin
  inherited Destroy;
end;    { Destroy }

{ TRAFDPalette }
procedure TRAFDPalette.FormCreate(Sender: TObject);
begin
  Name := 'Palette';
  RegAuto1.RegPath := BaseRegKey;
  RAFDDesigner.LoadComponentBitmapProc := LoadComponentBitmap;
  UpdatePalette;
end;

procedure TRAFDPalette.UpdatePalette;
var
  i: integer;
begin
  TabControl.Tabs.Clear;
  for i := 0 to RegComponentList.Count - 1 do
  begin
    if TabControl.Tabs.IndexOf(TPaletteEntry(RegComponentList[i]).Page) = -1 then
      TabControl.Tabs.Add(TPaletteEntry(RegComponentList[i]).Page);
  end;
  TabControlChange(nil);
end;    { UpdatePalette }

procedure TRAFDPalette.TabControlChange(Sender: TObject);
var
  i: integer;
  Button: TSpeedButton;
  TabName: string;
  Num: Integer;
begin
  ButtonDown := False;
  Palette.FirstVisible := 0;
  if TabControl.TabIndex < 0 then Exit;
  TabName := TabControl.Tabs[TabControl.TabIndex];
  Num := 0;
	for i := 0 to RegComponentList.Count - 1 do
		if Cmp(TPaletteEntry(RegComponentList[i]).Page, TabName) then
      inc(Num);

  Palette.BeginUpdate;
  try
    Palette.ButtonCount := Num;
    Num := 0;
    for i := 0 to RegComponentList.Count - 1 do
    begin
      with TPaletteEntry(RegComponentList[i]) do
      if Cmp(Page, TabName) then
      begin
       // ComponentPanel.ButtonCount := ComponentPanel.ButtonCount + 1;
        Button := Palette.Buttons[Num];
        try
          Button.Glyph.LoadFromResourceName(Module, ComponentClass.ClassName);
  			except
  				Button.Glyph.LoadFromResourceName(hInstance, DefaultComponentBitmap);
  			end;
        Button.Hint := ComponentClass.ClassName;
        if (Length(Button.Hint) > 1) and (Button.Hint[1] = 'T') then
          Button.Hint := Copy(Button.Hint, 2, Length(Button.Hint));
        Button.Tag := Integer(RegComponentList[i]);
        inc(Num);
      end;
    end;
  finally { wrap up }
    Palette.EndUpdate;
  end;    { try/finally }
end;

procedure TRAFDPalette.PaletteClick(Sender: TObject;
  Button: Integer);
begin
  ButtonDown := Button > -1;
  if ButtonDown then
    ComponentClass := TPaletteEntry(Palette.Buttons[Button].Tag).ComponentClass;
end;

procedure TRAFDPalette.WMGetMinMaxInfo(var M : TWMGetMinMaxInfo);
begin
  inherited;
  if Visible then
  begin
    if Minim then
      M.MinMaxInfo^.ptMinTrackSize.Y := Height - ClientHeight + TabControl.Top
    else
      M.MinMaxInfo^.ptMinTrackSize.Y := Height - ClientHeight + TabControl.Top + TabControl.Height;
    M.MinMaxInfo^.ptMaxTrackSize.Y := M.MinMaxInfo^.ptMinTrackSize.Y;
    M.MinMaxInfo^.ptMinTrackSize.X := 80;
  end;
end;

procedure TRAFDPalette.RACaptionButton1Click(Sender: TObject);
begin
  Minim := not Minim;
  if ClientHeight = 0 then
    ClientHeight := TabControl.Top + TabControl.Height else
    ClientHeight := 0;
end;

procedure TRAFDPalette.FormResize(Sender: TObject);
begin
  TabControl.Width := ClientWidth;
end;

procedure TRAFDPalette.FormShow(Sender: TObject);
begin
  Height := TabControl.Top + TabControl.Height;
end;

procedure TRAFDPalette.RACaptionButton2Click(Sender: TObject);
begin
{  if TabControl.Parent = Self then
  begin
    Hide;
    TabControl.Align := alTop;
    TabControl.Parent := RAFDAppBuilder.pnlPalette;
  end
  else
  begin
    TabControl.Align := alNone;
    TabControl.Parent := Self;
  end; }
end;


initialization
  ActiveModule := hInstance;
  RegComponentList := TList.Create;
  RegNoIconList := TList.Create;
  RegisterComponentsProc := RARegisterComponentsProc;
  RegisterNonActiveXProc := RARegisterNonActiveXProc;
  RegisterNoIconProc := RARegisterNoIconProc;
  RegisterCustomModuleProc := RARegisterCustomModuleProc;
  FreeCustomModulesProc := RAFreeCustomModulesProc;
  CreateVCLComObjectProc := RACreateVCLComObjectProc;

finalization
  ClearList(RegComponentList);
  RegComponentList.Free;
  RegNoIconList.Free;
end.
