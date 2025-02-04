unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Cabinet, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    CabCompressor1: TCabCompressor;
    Button1: TButton;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    Memo2: TMemo;
    Button3: TButton;
    Button4: TButton;
    ProgressBar2: TProgressBar;
    Edit1: TEdit;
    Edit2: TEdit;
    CabCompressor2: TCabCompressor;
    procedure Button1Click(Sender: TObject);
    procedure CabCompressor1CloseFile(FileName: String; fhandle: Integer);
    procedure CabCompressor1DeleteFile(FileName: String);
    procedure CabCompressor1GetTempFile(FileName: String);
    procedure CabCompressor1PlaceFile(FileName: String);
    procedure CabCompressor1ReadFile(FileName: String; filehandle,
      bytesread: Integer);
    procedure CabCompressor1SeekFile(FileName: String; filehandle,
      distance, seektype: Integer);
    procedure CabCompressor1WriteFile(FileName: String; filehandle,
      byteswritten: Integer);
    procedure CabCompressor1StatusChange(bytescompressed,
      totalbytes: Integer);
    procedure Button2Click(Sender: TObject);
    procedure CabCompressor2PlaceFile(FileName: String);
    procedure CabCompressor2StatusChange(bytescompressed,
      totalbytes: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CabCompressor2CloseFile(FileName: String; fhandle: Integer);
    procedure CabDecompressor1StatusChange(bytesprocessed,
      totalbytes: Integer);
    procedure CabDecompressor1AfterCopyFile(afilename: String;
      execute: Boolean);
    procedure CabCompressor1OpenFile(FileName: String; filehandle: Integer;
      mode: Word);
    procedure CabCompressor1GetNextCab(var CabinetName, DiskName: String);
    procedure CabCompressor1BeginCompression;
    procedure CabCompressor1EndCompression;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 if not(cabcompressor1.Processing) then
  begin
   memo1.clear;
   cabcompressor1.ClearFiles;
   cabcompressor1.Cabsize:=200000000;
   cabcompressor1.CabPathName:='C:\cdidxtmp\setb.cab';
   cabcompressor1.Addfile('C:\cdidxtmp\p*.exe','',true);
   cabcompressor1.compress;
  end;
end;


procedure TForm1.CabCompressor1CloseFile(FileName: String;
  fhandle: Integer);
begin
 memo1.Lines.Add('Close-'+FileName);
end;

procedure TForm1.CabCompressor1DeleteFile(FileName: String);
begin
 memo1.Lines.Add('Delete-'+FileName);
end;

procedure TForm1.CabCompressor1GetTempFile(FileName: String);
begin
 memo1.Lines.Add('Temporary file-'+FileName);
end;


procedure TForm1.CabCompressor1PlaceFile(FileName: String);
begin
 memo1.Lines.Add('PlaceFile-'+FileName);
end;

procedure TForm1.CabCompressor1ReadFile(FileName: String; filehandle,
  bytesread: Integer);
begin
 edit2.text:=inttostr(strtoint(edit2.text)+bytesread);
end;

procedure TForm1.CabCompressor1SeekFile(FileName: String; filehandle,
  distance, seektype: Integer);
begin
 memo1.Lines.Add('SeekFile-'+FileName);
end;

procedure TForm1.CabCompressor1WriteFile(FileName: String; filehandle,
  byteswritten: Integer);
begin
 edit1.text:=inttostr(strtoint(edit1.text)+byteswritten)
end;

procedure TForm1.CabCompressor1StatusChange(bytescompressed,
  totalbytes: Integer);
begin
 progressbar1.Position:=bytescompressed;
 progressbar1.Max:=totalbytes;
 if bytescompressed=totalbytes then
  progressbar1.position:=0;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 cabcompressor1.abort;
end;

procedure TForm1.CabCompressor2PlaceFile(FileName: String);
begin
 memo2.Lines.Add('PlaceFile-'+FileName);
end;

procedure TForm1.CabCompressor2StatusChange(bytescompressed,
  totalbytes: Integer);
begin
 progressbar2.Position:=bytescompressed;
 progressbar2.Max:=totalbytes;
 if bytescompressed=totalbytes then
  progressbar2.position:=0;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 if not(cabcompressor2.Processing) then
  begin
   memo2.clear;
   cabcompressor2.ClearFiles;
   cabcompressor2.Cabsize:=9000000;
   cabcompressor2.CabPathName:='C:\cdidxtmp\seta.cab';
   //cabcompressor1.CompressionParameters.Compression:=ctLzx;
   //cabcompressor1.CompressionParameters.LzxLevel:=21;
   cabcompressor2.Addfile('C:\cdidxtmp\*.dcu','',true);
   cabcompressor2.compress;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 cabcompressor2.abort;
end;

procedure TForm1.CabCompressor2CloseFile(FileName: String;
  fhandle: Integer);
begin
 memo2.Lines.Add('Close-'+FileName);
end;


procedure TForm1.CabDecompressor1StatusChange(bytesprocessed,
  totalbytes: Integer);
begin
 progressbar2.max:=totalbytes;
 progressbar2.position:=bytesprocessed;
end;

procedure TForm1.CabDecompressor1AfterCopyFile(afilename: String;
  execute: Boolean);
begin
 memo2.lines.add('File Added: '+afilename);
end;

procedure TForm1.CabCompressor1OpenFile(FileName: String;
  filehandle: Integer; mode: Word);
begin
 memo1.Lines.Add('OpenFile-'+FileName);
end;


procedure TForm1.CabCompressor1GetNextCab(var CabinetName,
  DiskName: String);
begin
 memo1.Lines.Add('NextCabinet-'+CabinetName+'NextDisk-'+DiskName);
end;

procedure TForm1.CabCompressor1BeginCompression;
begin
 memo1.lines.add('Begin Compression');
end;

procedure TForm1.CabCompressor1EndCompression;
begin
 memo1.lines.add('End Compression');
end;

end.

