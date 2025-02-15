{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright � 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_DBPWDlg;

interface

uses
  Windows,
  Classes,
  Graphics,
  Forms,
  Controls,
  StdCtrls,
  DBPWDlg,
  atScript;

{$WARNINGS OFF}

type
  TatDBPWDlgLibrary = class(TatScripterLibrary)
    procedure __TPasswordDialogEditChange(AMachine: TatVirtualMachine);
    procedure __TPasswordDialogAddButtonClick(AMachine: TatVirtualMachine);
    procedure __TPasswordDialogRemoveButtonClick(AMachine: TatVirtualMachine);
    procedure __TPasswordDialogRemoveAllButtonClick(AMachine: TatVirtualMachine);
    procedure __TPasswordDialogOKButtonClick(AMachine: TatVirtualMachine);
    procedure __PasswordDialog(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TPasswordDialogClass = class of TPasswordDialog;



implementation



procedure TatDBPWDlgLibrary.__TPasswordDialogEditChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPasswordDialog(CurrentObject).EditChange(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBPWDlgLibrary.__TPasswordDialogAddButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPasswordDialog(CurrentObject).AddButtonClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBPWDlgLibrary.__TPasswordDialogRemoveButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPasswordDialog(CurrentObject).RemoveButtonClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBPWDlgLibrary.__TPasswordDialogRemoveAllButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPasswordDialog(CurrentObject).RemoveAllButtonClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBPWDlgLibrary.__TPasswordDialogOKButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPasswordDialog(CurrentObject).OKButtonClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBPWDlgLibrary.__PasswordDialog(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DBPWDlg.PasswordDialog(TComponent(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBPWDlgLibrary.Init;
begin
  With Scripter.DefineClass(TPasswordDialog) do
  begin
    DefineMethod('EditChange',1,tkNone,nil,__TPasswordDialogEditChange,false,0);
    DefineMethod('AddButtonClick',1,tkNone,nil,__TPasswordDialogAddButtonClick,false,0);
    DefineMethod('RemoveButtonClick',1,tkNone,nil,__TPasswordDialogRemoveButtonClick,false,0);
    DefineMethod('RemoveAllButtonClick',1,tkNone,nil,__TPasswordDialogRemoveAllButtonClick,false,0);
    DefineMethod('OKButtonClick',1,tkNone,nil,__TPasswordDialogOKButtonClick,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('PasswordDialog',1,tkVariant,nil,__PasswordDialog,false,0);
  end;
end;

class function TatDBPWDlgLibrary.LibraryName: string;
begin
  result := 'DBPWDlg';
end;

initialization
  RegisterScripterLibrary(TatDBPWDlgLibrary, True);

{$WARNINGS ON}

end.

