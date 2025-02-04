{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       description : TStrings property editor

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit fRAFDStringsEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  StdCtrls, TypInfo, DsgnIntf;

type

  TStringsProperty = class(TClassProperty)
  private
    Strings: TStrings;
  public
    procedure Edit; override;
   // function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TStringsEditor = class(TForm)
    Memo1: TMemo;
    bOk: TButton;
    bCancel: TButton;
    bCodeEditor: TButton;
    procedure bCodeEditorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FStringsProperty: TStringsProperty;
  end;

implementation

uses RAFD, RAFDDesigner, RAFDCompat;

{$R *.DFM}

{
function TStringsProperty.GetValue: string;
begin
  Result := '(TStrings)';
end;
}

function TStringsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly, paDialog];
end;

procedure TStringsProperty.Edit;
begin
 { if Strings allready edited in editor window then exit }
 {$IFDEF RA_D3}
  if (Designer as TRAFormDesigner).FileEditor.
    ActivateStrings(GetComponent(0), Strings, GetPropInfo) then Exit;
 {$ELSE}
  if (ExtractFormDesigner(Designer) as TRAFormDesigner).FileEditor.
    ActivateStrings(GetComponent(0), Strings, GetPropInfo) then Exit;
 {$ENDIF}

  with TStringsEditor.Create(Application) do
    try
      FStringsProperty := Self;
      Strings := TStrings(GetOrdValue);
      Memo1.Lines := Strings;
      if ShowModal = mrOk then
      begin
        Strings.Assign(Memo1.Lines);
        Modified;
      end;
    finally { wrap up }
      Free;
    end;    { try/finally }
end;

procedure TStringsEditor.bCodeEditorClick(Sender: TObject);
begin
 {$IFDEF RA_D3}
  (FStringsProperty.Designer as TRAFormDesigner).
 {$ELSE}
  (ExtractFormDesigner(FStringsProperty.Designer) as TRAFormDesigner).
 {$ENDIF}
   FileEditor.EditStrings(
    FStringsProperty.GetComponent(0), FStringsProperty.Strings,
    FStringsProperty.GetPropInfo, Memo1.Lines);
  ModalResult := mrCancel;
end;

procedure TStringsEditor.FormCreate(Sender: TObject);
begin
  Caption := ResStr(deStringsEditor, Caption);
  bCodeEditor.Caption := ResStr(deCodeEditor, bCodeEditor.Caption);
  bOk.Caption := ResStr(deOk, bOk.Caption);
  bCancel.Caption := ResStr(deCancel, bCancel.Caption);
end;

end.
