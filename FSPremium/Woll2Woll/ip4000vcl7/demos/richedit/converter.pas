unit converter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, wwriched, activex,
  wwrtfconverter;

type
  TRTFImportExportForm = class(TForm)
    wwDBRichEdit1: TwwDBRichEdit;
    OpenButton: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveButton: TButton;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    procedure OpenButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    LastFormat: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RTFImportExportForm: TRTFImportExportForm;

implementation

{$R *.dfm}

procedure TRTFImportExportForm.OpenButtonClick(Sender: TObject);
var importRCL: TwwRtfConverterlist;
begin
	ImportRcl := TwwRtfConverterList.create(True);

  try
   	 OpenDialog1.InitialDir := '';
     OpenDialog1.Filter := 'Rich Text Format (*.rtf)|*.rtf|';
     OpenDialog1.Filter := OpenDialog1.Filter + ImportRcl.FilterList;

     OpenDialog1.Title := 'Import';
     if ( not OpenDialog1.Execute) then exit;

     statusbar1.Panels[0].text:= OpenDialog1.FileName;
     if OpenDialog1.FilterIndex=1 then
     begin
        statusbar1.Panels[1].Text:= 'Rich Text Format';
        wwdbRichEdit1.lines.LoadFromFile(OpenDialog1.FileName);
        exit;
     end;

     statusbar1.Panels[1].Text:= ImportRCL.Description[OpenDialog1.FilterIndex-2];
     LastFormat:= ImportRCL.FormatClass[OpenDialog1.FilterIndex-2];

     try
        wwdbrichedit1.Import(
          ImportRCL.FormatClass[OpenDialog1.FilterIndex-2],
          OpenDialog1.FileName)
     except
        On E: EwwRTFError do begin
            Showmessage(E.message +
                        ' ErrorCode:' + inttostr(e.ErrorCode));
        end;
     end;
  finally
     ImportRCL.Free;
  end;

end;

procedure TRTFImportExportForm.SaveButtonClick(Sender: TObject);
var
  exportRCL: TwwRtfConverterlist;
  i: integer;
begin
	exportRcl := TwwRtfConverterList.create(False);

  try
  	SaveDialog1.InitialDir := '';
    SaveDialog1.Filter := 'Rich Text Format (*.rtf)|*.rtf|';
	  SaveDialog1.Filter := SaveDialog1.Filter + ExportRcl.FilterList;
  	SaveDialog1.Title := 'Export';

    SaveDialog1.FileName:= Statusbar1.Panels[0].text;
    for i:= 0 to ExportRCL.LibPath.count-1 do
    begin
       if ExportRCL.FormatClass[i] = LastFormat then begin
          SaveDialog1.FilterIndex:= i+2;
          break;
       end
    end;

	  if ( not SaveDialog1.Execute) then exit;

    statusbar1.Panels[0].text:= SaveDialog1.FileName;

    if SaveDialog1.FilterIndex=1 then
    begin
       statusbar1.Panels[1].Text:= 'Rich Text Format';
       wwdbRichEdit1.lines.SaveToFile(SaveDialog1.FileName);
       exit;
    end;

    statusbar1.Panels[1].Text:= ExportRCL.Description[SaveDialog1.FilterIndex-2];

    try
       wwdbrichedit1.export(
         ExportRCL.FormatClass[SaveDialog1.FilterIndex-2],
         SaveDialog1.FileName);
    except
      On E: EwwRTFError do begin
          Showmessage(E.message +
                      ' ErrorCode:' + inttostr(e.ErrorCode));
      end;
    end;

  finally
    ExportRCL.Free;
  end

end;

end.
