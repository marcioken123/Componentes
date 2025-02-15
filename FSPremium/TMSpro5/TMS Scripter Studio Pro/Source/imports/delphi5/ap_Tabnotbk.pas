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
unit ap_Tabnotbk;

interface

uses
  Windows,
  Classes,
  Stdctrls,
  Forms,
  Messages,
  Graphics,
  Controls,
  ComCtrls,
  Tabnotbk,
  atScript;

{$WARNINGS OFF}

type
  TatTabnotbkLibrary = class(TatScripterLibrary)
    procedure __TTabPageCreate(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookCreate(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookDestroy(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookGetIndexForPage(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookTabFontChanged(AMachine: TatVirtualMachine);
    procedure __GetTTabbedNotebookTopFont(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TTabPageClass = class of TTabPage;
  TTabbedNotebookClass = class of TTabbedNotebook;

  TatTabnotbkDispatcher = class(TatEventDispatcher)
  private
    procedure __TPageChangeEvent( Sender: TObject;  NewTab: Integer; var AllowChange: Boolean);
  end;


implementation



procedure TatTabnotbkLibrary.__TTabPageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabPageClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabnotbkLibrary.__TTabbedNotebookCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabbedNotebookClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabnotbkLibrary.__TTabbedNotebookDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabbedNotebook(CurrentObject).Destroy;
  end;
end;

procedure TatTabnotbkLibrary.__TTabbedNotebookGetIndexForPage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabbedNotebook(CurrentObject).GetIndexForPage(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabnotbkLibrary.__TTabbedNotebookTabFontChanged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabbedNotebook(CurrentObject).TabFontChanged(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatTabnotbkLibrary.__GetTTabbedNotebookTopFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTabbedNotebook(CurrentObject).TopFont));
  end;
end;

procedure TatTabnotbkDispatcher.__TPageChangeEvent( Sender: TObject;  NewTab: Integer; var AllowChange: Boolean);
var
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TPageChangeEvent(BeforeCall)(Sender,NewTab,AllowChange);
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,NewTab,AllowChangeTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TPageChangeEvent(AfterCall)(Sender,NewTab,AllowChange);
  end;
end;

procedure TatTabnotbkLibrary.Init;
begin
  With Scripter.DefineClass(TTabPage) do
  begin
    DefineMethod('Create',1,tkClass,TTabPage,__TTabPageCreate,true,0);
  end;
  With Scripter.DefineClass(TTabbedNotebook) do
  begin
    DefineMethod('Create',1,tkClass,TTabbedNotebook,__TTabbedNotebookCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTabbedNotebookDestroy,false,0);
    DefineMethod('GetIndexForPage',1,tkInteger,nil,__TTabbedNotebookGetIndexForPage,false,0);
    DefineMethod('TabFontChanged',1,tkNone,nil,__TTabbedNotebookTabFontChanged,false,0);
    DefineProp('TopFont',tkClass,__GetTTabbedNotebookTopFont,nil,TFont,false,0);
  end;
  DefineEventAdapter(TypeInfo(TPageChangeEvent), TatTabnotbkDispatcher, @TatTabnotbkDispatcher.__TPageChangeEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('CM_TABFONTCHANGED',CM_TABFONTCHANGED);
  end;
end;

class function TatTabnotbkLibrary.LibraryName: string;
begin
  result := 'Tabnotbk';
end;

initialization
  RegisterScripterLibrary(TatTabnotbkLibrary, True);

{$WARNINGS ON}

end.

