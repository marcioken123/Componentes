unit Unit6a;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Cabinet, ComCtrls;

type
  TForm2 = class(TForm)
    CabDecompressor1: TCabDecompressor;
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    CabDecompressor2: TCabDecompressor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CabDecompressor1StatusChange(bytesprocessed,
      totalbytes: Integer);
    procedure CabDecompressor2StatusChange(bytesprocessed,
      totalbytes: Integer);
    procedure CabDecompressor1AfterCopyFile(afilename: String;
      execute: Boolean);
    procedure CabDecompressor1CloseFile(FileName: String;
      fhandle: Integer);
    procedure CabDecompressor1OpenFile(FileName: String;
      filehandle: Integer; mode: Word);
    procedure CabDecompressor1ReadFile(FileName: String; filehandle,
      bytesread: Integer);
    procedure CabDecompressor1SeekFile(FileName: String; filehandle,
      distance, seektype: Integer);
    procedure CabDecompressor1WriteFile(FileName: String; filehandle,
      byteswritten: Integer);
    procedure CabDecompressor1BeforeCopyFile(var Filename: String;
      overwrite: Boolean);
    procedure CabDecompressor1BeginDecompression;
    procedure CabDecompressor1EndDecompression;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.Button1Click(Sender: TObject);
begin
 if not(cabdecompressor1.Processing) then
  begin
   memo1.clear;
   cabdecompressor1.CabPathName:='C:\cdidxtmp\setb.cab';
   cabdecompressor1.TargetPath:='C:\cdidxtmp\yp1\';
   CabDecompressor1.SelectByWildCard('p*.exe');
   CabDecompressor1.Decompress;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
 i:integer;
begin
 if not(cabdecompressor2.Processing) then
  begin
   memo1.clear;
   cabdecompressor2.CabPathName:='C:\cdidxtmp\setb.cab';
   cabdecompressor2.TargetPath:='C:\cdidxtmp\yp2\';
   for i:=0 to CabDecompressor2.FileCount-1 do
    begin
     CabDecompressor2.Files[i].Select:=true;
    end;
    CabDecompressor2.Decompress;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
 cabdecompressor1.Abort;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
 cabdecompressor2.Abort;
end;

procedure TForm2.CabDecompressor1StatusChange(bytesprocessed,
  totalbytes: Integer);
begin
 progressbar1.Position:=bytesprocessed;
 progressbar1.Max:=totalbytes;
 if bytesprocessed=totalbytes then
  progressbar1.position:=0;

end;

procedure TForm2.CabDecompressor2StatusChange(bytesprocessed,
  totalbytes: Integer);
begin
 progressbar2.Position:=bytesprocessed;
 progressbar2.Max:=totalbytes;
 if bytesprocessed=totalbytes then
  progressbar2.position:=0;
end;

procedure TForm2.CabDecompressor1AfterCopyFile(afilename: String;
  execute: Boolean);
begin
 memo1.lines.add('Copy File: '+ afilename);
 //cabdecompressor1.Files[0].Select
end;

procedure TForm2.CabDecompressor1CloseFile(FileName: String;
  fhandle: Integer);
begin
 memo1.lines.add('Close File: '+ filename);
end;

procedure TForm2.CabDecompressor1OpenFile(FileName: String;
  filehandle: Integer; mode: Word);
begin
 memo1.lines.add('Open File: '+ filename);
end;

procedure TForm2.CabDecompressor1ReadFile(FileName: String; filehandle,
  bytesread: Integer);
begin
 memo1.lines.add('Read File: '+ filename);
end;

procedure TForm2.CabDecompressor1SeekFile(FileName: String; filehandle,
  distance, seektype: Integer);
begin
 memo1.lines.add('Seek File: '+ filename);
end;

procedure TForm2.CabDecompressor1WriteFile(FileName: String; filehandle,
  byteswritten: Integer);
begin
 memo1.lines.add('Write File: '+ filename);
end;

procedure TForm2.CabDecompressor1BeforeCopyFile(var Filename: String;
  overwrite: Boolean);
begin
 if overwrite=false then
  memo1.lines.add('Before Copy File: '+ filename)
 else
  memo1.lines.add('Before OverWrite File: '+ filename);
end;

procedure TForm2.CabDecompressor1BeginDecompression;
begin
 memo1.lines.add('Begin Decompression');
end;

procedure TForm2.CabDecompressor1EndDecompression;
begin
 memo1.lines.add('End Decompression');
end;

end.
