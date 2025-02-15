{***************************************************************************}
{ Scripter Studio demo                                                      }
{ for Delphi & C++Builder                                                   }
{ version 2.0                                                               }
{                                                                           }
{ written by Automa / TMS Software                                          }
{            copyright � 1997 - 2002                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of TMS software.                                    }
{***************************************************************************}

unit fMain;

interface

{$I AScript.Inc}

uses
  Windows, Messages, SysUtils,
  {$IFDEF DELPHI6_LVL} Variants,{$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, atScript, comobj, DB, DBTables, Mask, DBCtrls,
  ExtCtrls, Grids, DBGrids, FormScript, atPascal, AdvMemo, Advmps;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DataSource1: TDataSource;
    Table1: TTable;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    atPascalFormScripter1: TatPascalFormScripter;
    AdvMemo1: TAdvMemo;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StSetValue;
    procedure StAppend;
    procedure StPost;
    procedure StGetCurrentDir;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  with atPascalFormScripter1.AddDelphiClass(TDBEdit) do
    AddMethod('SetValue',1,tkNone,nil,StSetValue);

  with atPascalFormScripter1.SystemLibrary do
  begin
    AddMethod('Append',0,tkNone,nil,StAppend);
    AddMethod('Post',0,tkNone,nil,StPost);
    AddMethod('GetCurrentDir',0,tkString,nil,StGetCurrentDir);
  end;

  atPascalFormScripter1.SourceCode.Assign(advmemo1.lines);
  atPascalFormScripter1.Execute(null);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Table1.DatabaseName := GetCurrentDir;
  Table1.TableName := 'orders.db';
  Table1.Active := True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 dbedit1.EditText := '233';
end;

procedure TForm1.StSetValue;
begin
   TDBEdit(atPascalFormScripter1.CurrentObject).EditText := atPascalFormScripter1.GetInputArgAsString(0);
end;

procedure TForm1.StAppend;
begin
  Table1.Append;
end;

procedure TForm1.StPost;
begin
  Table1.Post;
end;

procedure TForm1.StGetCurrentDir;
begin
  atPascalFormScripter1.ReturnOutputArg(GetCurrentDir);
end;

end.
