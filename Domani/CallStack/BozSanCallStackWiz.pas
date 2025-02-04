unit BozSanCallStackWiz;

interface

uses
	ToolsAPI, Menus, WizardFunction, SysUtils, Classes;

type
  TBozSanCallStackWizard = class(TNotifierObject, IUnknown, IOTANotifier,
  		IOTAMenuWizard, IOTAWizard)
  private
    FMenu: TMainMenu;
    FMiAddCallStack,
    FMiDelCallStack,
    FMiSanBoz: TMenuItem;

    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    function GetMenuText: String;

    { Launch the AddIn }
    procedure Execute;
    procedure AddCallStack(Sender: TObject);
    procedure DelCallStack(Sender: TObject);

    procedure AddDelCallStack(const bAdd: Boolean);
  protected
  public
    constructor Create;
    destructor Destroy; override;

  end;

procedure Register;

implementation

uses
    BozSanCallStackUnitList, Controls, ComCtrls, BozSanAddCallStack;

{ TBozSanCallStackWizard }
procedure Register;
begin
    RegisterPackageWizard(TBozSanCallStackWizard.Create);
end;

procedure TBozSanCallStackWizard.AddCallStack(Sender: TObject);
begin
    AddDelCallStack(True);
end;

procedure TBozSanCallStackWizard.AddDelCallStack(const bAdd: Boolean);
var
    FormUnitList: TFormUnitList;
    i, iMod: Integer;
    s: String;
    OTAModuleServices: IOTAModuleServices;
    Module: IOTAModule;
    bIsOpen: Boolean;
    Project: IOTAProject;
begin
    FormUnitList := NIL;
    try
        FormUnitList := TFormUnitList.Create(NIL);
        if FormUnitList.ShowModal = mrOk then
            begin
            Project := GetActiveProject;
            OTAModuleServices := BorlandIDEServices as IOTAModuleServices;
            OTAModuleServices.SaveAll;
            for i := 0 to FormUnitList.LvUnits.Items.Count - 1 do
                if FormUnitList.LvUnits.Items[i].Checked then
                    begin
                    s := FormUnitList.LvUnits.Items[i].SubItems[0];
                    Module := OTAModuleServices.FindModule(s);
                    bIsOpen := Module <> NIL;
                    if bIsOpen then
                        Module.CloseModule(TRUE);
                    if bAdd then
                        AddCallStackFuncToUnit(s)
                    else
                        DeleteCallStack(s);
                    if bIsOpen then
                        begin

                        iMod := 0;
                        while (iMod < Project.GetModuleCount) do
                            if compareText(Project.GetModule(iMod).FileName, s) <> 0 then
                                Inc(iMod)
                            else
                                begin
                                Module := Project.GetModule(iMod).OpenModule;
                                Module.ModuleFileEditors[0].Show;
                                break;
                                end;

                        end;
                    end;
            end;
    finally
        if Assigned(FormUnitList) then
            FormUnitList.Release;
    end;
end;

constructor TBozSanCallStackWizard.Create;
begin
	inherited Create;
    FMenu := (BorlandIDEServices as INTAServices40).MainMenu;
    if FMenu = NIL then exit;
    FMiSanBoz := TMenuItem.Create(NIL);
    FMenu.Items.Add(FMiSanBoz);
    FMiSanBoz.Caption := 'SánBoz';

    FMiAddCallStack := AddMenuItem('Add CallStack', AddCallStack, FMiSanBoz);
    FMiDelCallStack := AddMenuItem('Del CallStack', DelCallStack, FMiSanBoz);
end;

procedure TBozSanCallStackWizard.DelCallStack(Sender: TObject);
begin
    AddDelCallStack(FALSE);
end;

destructor TBozSanCallStackWizard.Destroy;
begin
    FreeAndNIL(FMiAddCallStack);
    FreeAndNIL(FMiDelCallStack);
    FreeAndNIL(FMiSanBoz);
    inherited Destroy;
end;

procedure TBozSanCallStackWizard.Execute;
begin

end;

function TBozSanCallStackWizard.GetIDString: string;
begin
    Result := 'Wizard.SanBoz.CallStack'
end;

function TBozSanCallStackWizard.GetMenuText: String;
begin
	Result := 'SanBoz CallStack';
end;

function TBozSanCallStackWizard.GetName: string;
begin
	Result := 'SanBozCallStack';
end;

function TBozSanCallStackWizard.GetState: TWizardState;
begin
	Result := [wsEnabled, wsChecked];
end;

end.
