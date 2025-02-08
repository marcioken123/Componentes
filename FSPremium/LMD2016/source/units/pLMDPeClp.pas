unit pLMDPeClp;
{$I lmdcmps.inc}
interface

uses
  Windows, Classes, Graphics, Forms, Controls, Dialogs, Buttons,
  DesignIntf, DesignEditors, VCLEditors, StdCtrls, ExtCtrls,
  LMDClass, LMDObj, LMDUtils;

type
  TlmdClipEditorDlg = class(TForm)
    Load: TButton;
    Save: TButton;
    FileDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Clear: TButton;
    Cancel: TBitBtn;
    OK: TBitBtn;
    Shape1: TShape;
    Shape2: TShape;
    test: TButton;
    Label2: TLabel;
    Label1: TLabel;
    breite: TLabel;
    hoehe: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    rows: TComboBox;
    cols: TComboBox;
    lbitmap: TButton;
    sbitmap: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure testClick(Sender: TObject);
    procedure SavePClick(Sender: TObject);
    procedure LoadPClick(Sender: TObject);
  private
    FClip: TLMDClip;
    procedure SetClip(aValue:TLMDClip);
  public
    Procedure SetLabels;
    property Clip:TLMDClip read FClip write SetClip;
  end;

  {-----------------------------------------------------------------------}
  Ttester = class(TForm)
    OK: TBitBtn;
    pic: TImage;
    spul: TButton;
    spul1: TButton;
    Label2: TLabel;
    pos: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure spulClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FClip:TLMDClip;
    FShow:Boolean;
    FPos, FAll:WORD;
    procedure CheckPos;
    procedure SetClip(aValue:TLMDClip);
  public
    property TestClip:TLMDClip read FClip write SetClip;
  end;

  {-----------------------------------------------------------------------}
  TLMDClipProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  {-----------------------------------------------------------------------}
  TLMDClipEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

uses SysUtils, ExtDlgs,
     pLMDPeCst, LMDStrings;

{$R *.DFM}
{$R plmdpeclt.DFM}

{********************* Class TClipEditorDlg ***********************************}
{------------------------- Private---------------------------------------------}
procedure TlmdClipEditorDlg.cmbChange(Sender: TObject);
begin
  if sender=rows then
    FClip.Rows:=strtoint(rows.items[rows.itemindex])
  else
    FClip.Columns:=strtoint(cols.items[cols.itemindex]);
end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.FormCreate(Sender: TObject);
begin
  FClip := TLMDClip.Create;
  load.caption:=IDS_LOAD;
  save.caption:=IDS_SAVE;
  clear.caption:=IDS_CLEAR;
  Label2.caption:='ClipWidth:';
  Label1.Caption:='ClipHeight:';
  label3.caption:='Rows:';
  label5.caption:='Cols:';
  lbitmap.caption:='Loa&d Bmp';
  sbitmap.caption:='Sa&ve Bmp';
end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.FormDestroy(Sender: TObject);
begin
  FClip.Free;
end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.LoadClick(Sender: TObject);
var
  ImageEditor: TOpenPictureDialog;
begin
  ImageEditor := TOpenPictureDialog.Create(nil);
  with ImageEditor do
    try
      DefaultExt := GraphicExtension(TBitmap);
      FileName:='*.'+DefaultExt;
      Filter := GraphicFilter(TBitmap);
      if Execute then
        begin
          FClip.Bitmap.LoadFromFile(Filename);
          FClip.Rows:=1;
          FClip.Columns:=1;
          SetLabels;
          Invalidate;
        end;
    finally
      ImageEditor.Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.SaveClick(Sender: TObject);
begin
  if not FClip.Empty then
    with SaveDialog do
     begin
       filename:='*.bmp';
       defaultext:='bmp';
       filter:=GraphicFilter(TBitmap);
       title:=IDS_SAVEBMPAS;
       if Execute then FClip.Bitmap.SaveToFile(Filename);
     end;
end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.FormPaint(Sender: TObject);
var
  DrawRect: TRect;

begin

  Canvas.Brush.Color := Color;
  with Shape1 do
    DrawRect := Rect(Left, Top, Left + Width, Top + Height);

  if not FClip.Empty then
    begin
      with DrawRect, FClip do
        if (Bitmap.Width > shape1.width) or (Bitmap.Height > shape1.height) then
          begin
            if Bitmap.Width > Bitmap.Height then
              Bottom := Top + MulDiv(Bitmap.Height, Right - Left, Bitmap.Width)
            else
              Right := Left + MulDiv(Bitmap.Width, Bottom - Top, Bitmap.Height);
            if bottom>shape1.top+shape1.height then bottom:=shape1.top+shape1.height;
            if right>shape1.left+shape1.width then right:=shape1.left+shape1.width;
            Canvas.StretchDraw(DrawRect, Bitmap);
          end
        else
          with DrawRect do
            Canvas.Draw(Left + (Right - Left - Bitmap.Width) div 2, Top + (Bottom - Top -
              Bitmap.Height) div 2, Bitmap);
    end
  else
    with DrawRect, Canvas do
      TextOut(Left + (Right - Left - TextWidth('W')) div 2, Top + (Bottom -
              Top - TextHeight('W')) div 2, 'Empty'{LoadStr(srNone)});
end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.ClearClick(Sender: TObject);
begin
  FClip.FreeClip;
  Invalidate;
  SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.LoadPClick(Sender: TObject);
begin

  with fileDialog do
   begin
     filename:='*.pcp';
     defaultext:='pcp';
     filter:='PicClip-Files (*.pcp)|*.pcp';
     title:='Load PicClip-File';
     if Execute then
       begin
         FClip.LoadFromFile(filename);
         SetLabels;
         Invalidate;
       end;
   end;

end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.SavePClick(Sender: TObject);
begin
  if not FClip.Empty then
    with SaveDialog do
     begin
       filename:='*.pcp';
       defaultext:='pcp';
       filter:='PicClip-Files (*.pcp)|*.pcp';
       title:= 'Save PicClip-File as...';
       if Execute then FClip.SaveToFile(Filename);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDClipEditorDlg.testClick(Sender: TObject);
var
  tester:TTester;
begin
  Tester:=TTester.Create(nil);
  try
    tester.testclip:=FClip;
    tester.showmodal;
  finally
    tester.free;
  end;
end;

{------------------------------------------------------------------------------}
Procedure TlmdClipEditorDlg.SetLabels;
var s:TStringList;

begin

  Save.Enabled := not FClip.Empty;
  Clear.Enabled := save.enabled;
  test.enabled:= save.enabled;
  sBitmap.Enabled:=save.enabled;
  cols.enabled:=save.enabled;
  rows.enabled:=save.enabled;

  If FClip.Empty then
    begin
      breite.Caption:='---';
      hoehe.Caption:='---';
      if rows.items.count>0 then rows.Clear;
      if cols.items.count>0 then cols.clear;
    end
  else
    begin
      breite.caption:=inttostr(FClip.Bitmap.Width);
      hoehe.caption:=inttostr(FClip.Bitmap.Height);
      s:=TStringList.Create;
      try
        LMDAnsiGetDivider(s, FClip.Bitmap.Height);
        rows.items:=s;
        LMDAnsiGetDivider(s, FClip.Bitmap.Width);
        cols.items:=s;
      finally
        s.free;
      end;
      rows.itemindex:=rows.items.indexof(inttostr(FClip.Rows));
      cols.itemindex:=cols.items.indexof(inttostr(FClip.Columns));
    end
end;

{------------------------------------------------------------------------------}
procedure TlmdClipEditorDlg.SetClip(aValue:TLMDClip);
begin
  FClip.Assign(aValue);
end;

{********************* ClipTester-Form ****************************************}
{------------------------------------------------------------------------------}
procedure Ttester.CheckPos;
begin
  Pos.Caption:=Format('%d/%d', [fpos, FAll]);
  if fpos=1 then spul.enabled:=false else spul.enabled:=true;
  if fpos=Fall then spul1.enabled:=false else spul1.enabled:=True;
  pic.Picture.Bitmap:=testclip.GetCell(Fpos-1);

end;
{------------------------------------------------------------------------------}
procedure Ttester.SetClip(aValue:TLMDClip);
begin
  FClip.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure Ttester.FormCreate(Sender: TObject);
begin
  FShow:=false;
  FClip:=TLMDClip.Create;
end;

{------------------------------------------------------------------------------}
procedure Ttester.FormActivate(Sender: TObject);
begin

  if not FShow then
    begin
      FPOS:=1;FAll:=TestClip.Rows*TestClip.Columns;
      CheckPos;
      FShow:=True;
    end;
end;

{------------------------------------------------------------------------------}
procedure Ttester.spulClick(Sender: TObject);
begin
  if sender=spul then
    dec(FPos)
  else
    inc(FPos);
  CheckPos;
end;
{------------------------------------------------------------------------------}
procedure Ttester.FormDestroy(Sender: TObject);
begin
  Fclip.Free;
end;

{********************* Class TClipProperty ************************************}
{------------------------------------------------------------------------------}
procedure TLMDClipProperty.Edit;
var
  ClipEditor: TLMDClipEditorDlg;

begin
  ClipEditor := TLMDClipEditorDlg.Create(nil);
  try
    ClipEditor.Clip:=TLMDClip(Pointer(GetOrdValue));
    ClipEditor.SetLabels;
    if ClipEditor.Showmodal=mrOK then
      SetOrdValue(Longint(Pointer(ClipEditor.Clip)));
  finally
    ClipEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDClipProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{------------------------------------------------------------------------------}
function TLMDClipProperty.GetValue: string;
var
  uClip: TLMDClip;

begin

  uClip:=TLMDClip(GetOrdValue);
  if uClip.Empty then
    Result := 'Empty' {LoadStr(srNone)}
  else
    Result := '(TLMDClip)';

end;

{********************* Class TClipEditor **************************************}
{------------------------------------------------------------------------------}
procedure TLMDClipEditor.ExecuteVerb(Index: Integer);
var
  ClipEditor: TLMDClipEditorDlg;

begin
  ClipEditor := TLMDClipEditorDlg.Create(nil);
  try
    ClipEditor.Clip:=(Component as TLMDPicClip).Clip;
    ClipEditor.SetLabels;
    if ClipEditor.Showmodal=mrOK then
      begin
        (Component as TLMDPicClip).Clip:=ClipEditor.Clip;
        Designer.Modified;
      end;
  finally
    ClipEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDClipEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Specify Clip' ;
end;

{------------------------------------------------------------------------------}
function TLMDClipEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.
