unit pLMDPeAcp;
{$I lmdcmps.inc}
interface

uses
  Windows, Classes, Graphics, Forms, Controls, Dialogs, Buttons,
  StdCtrls, ExtCtrls, Tabs, DesignIntf, DesignEditors, VCLEditors,
  LMDConst, LMDClass, pLMDPeClp, LMDObj;

type
  TLMDAniClipEditorDlg = class(TForm)
    Cancel: TBitBtn;
    OK: TBitBtn;
    book: TNotebook;
    tab: TTabSet;
    bt2: TButton;
    ScrollBox1: TScrollBox;
    img: TImage;
    Label3: TLabel;
    Label4: TLabel;
    name: TEdit;
    index: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    start: TLabel;
    ende: TLabel;
    bt: TButton;
    bt1: TButton;
    header: THeader;
    lb: TListBox;
    bt3: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    SaveDialog: TSaveDialog;
    FileDialog: TOpenDialog;
    Load: TButton;
    Save: TButton;
    loadclip: TButton;
    clear: TButton;
    Label2: TLabel;
    breite: TLabel;
    Label1: TLabel;
    hoehe: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    row: TLabel;
    cols: TLabel;
    info: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure tabChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure btClick(Sender: TObject);
    procedure headerSized(Sender: TObject; ASection, AWidth: Integer);
    procedure lbDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure OKClick(Sender: TObject);
    procedure loadclipClick(Sender: TObject);
    procedure clearClick(Sender: TObject);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure bookMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    FAniClip: TLMDAniClip;
    FS:TStringList;
    FShow:Boolean;
    Cell:Word;
    procedure SetAniClip(aValue:TLMDAniClip);
    procedure FillLB;
    procedure FillList;
  public
    Procedure SetLabels;
    property AniClip:TLMDAniClip read FAniClip write SetAniClip;
  end;

  {-----------------------------------------------------------------------}
  TLMDAniClipProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  {-----------------------------------------------------------------------}
  TLMDAniClipEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {-----------------------------------------------------------------------}
  TLMDAniEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation
uses
  {TypInfo,} SysUtils, {LibConst, LibHelp,} lmdprocs, lmdutils, plmdpecst,
  LMDStrings;

{$R *.DFM}
{********************* Class TClipEditorDlg ***********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDAniClipEditorDlg.bookMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not FAniClip.Clip.Empty then info.caption:='';
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.btClick(Sender: TObject);
var f1, f2, i, ind:WORD;

begin

  if sender=bt then
    begin
      if FAniClip.Clip.Empty then
        begin
          name.Text:='';
          index.text:='';
        end
      else
        begin
          name.Text:='Frame'+inttostr(lb.items.count);
          index.text:=inttostr(lb.items.count);
        end;
      SetLabels;
      exit;
    end
  else if sender=bt1 then
    begin
      if LMDAnsiEmpty(name.text) or LMDAnsiEmpty(index.text) then
        messagedlg( 'Not all Values are specified...', mtError, [mbOK],0)
      else
        begin
          {check for duplicate values}
          ind:=strtoint(index.text);
          if lb.items.count>0 then
            for i:=0 to lb.items.count-1 do
              begin
                LMDAnsiParseToStrList(lb.items[i], '|', FS);
                if (name.text=FS[3]) or (inttostr(ind)=FS[0]) then
                  begin
                    messagedlg('Index-number or name already exists.', mtError, [mbOK],0);
                    exit;
                  end;
              end;

          {adding values to listbox}
          f1:=strtoint(start.caption);
          f2:=strtoint(ende.caption);
          lb.items.add(inttostr(ind)+'|'+inttostr(LMDMin([f1,f2]))+'|'+
                       inttostr(LMDMax([f1,f2]))+'|'+ name.text);
        end
    end
  else if sender=bt2 then
    lb.Clear
  else if sender=bt3 then
    if lb.selcount<>-1 then
      for i:=lb.items.count-1 downto 0 do
        begin
          if lb.selected[i] then lb.items.delete(i);
          if lb.selcount=0 then break;
        end;
  btclick(bt);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.clearClick(Sender: TObject);
begin
  FAniClip.FreeAniClip;
  btclick(bt2);
  img.picture.Bitmap:=FAniClip.Clip.Bitmap;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.FillLB;
var i:WORD;
begin
  lb.clear;
  if FAniClip.List.Count>0 then
    begin
      for i:=0 to FAniClip.List.Count-1 do
        with TLMDAniFrame(FAniClip.List.Frame[i]^) do
          lb.items.add(LMDAnsiCodeString([inttostr(IndexNr),inttostr(pos.StartPic),
                                  inttostr(pos.EndPic), {$IFDEF LMDCOMP12}String{$ENDIF}(name)], '|'));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.FillList;
var i:Word;
begin
  FAniClip.List.Clear;
  if lb.items.count>0 then
    for i:=0 to lb.items.count-1 do
      begin
        LMDAnsiParseToStrList(lb.items[i], '|', FS);
        FAniClip.list.addvalue(FS[3], strtoint(FS[0]), strtoint(FS[1]), strtoint(FS[2]));
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.FormActivate(Sender: TObject);
begin

  if not FShow then
    begin
      FillLB;
      btclick(bt);
      FSHow:=True;
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.FormCreate(Sender: TObject);
begin
  FShow:=False;
  FAniClip := TLMDAniClip.Create;
  FS:=TStringList.Create;
  book.pageindex:=0;
  img.Hint:='Left mousebutton for Start-\nRight mousebutton for End-Picture';
  label5.caption:='StartPicture (LBT):';
  label6.caption:='EndPicture (RBT):';
  loadclip.caption:='&Specify Clip';
  load.caption:='Load AniClip-File';
  save.caption:='Save AniClip-File';
  clear.caption:='Clear &AniClip';
  bt.caption:=IDS_CLEAR;
  bt1.caption:=IDS_ADD;
  bt2.caption:=IDS_CLEAR;
  bt3.caption:=IDS_REMOVE;
  label8.caption:='Rows:';
  label7.caption:='Cols:';
  label2.caption:='ClipWidth:';
  label1.caption:='ClipHeight:';
  savedialog.title:='&Save AniClip';
  savedialog.filter:='AniClip-Files (*.pcl)|*.pcl';
  FileDialog.title:='&Load AniClip';
  FileDialog.Filter:='AniClip-Files (*.pcl)|*.pcl';
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.FormDestroy(Sender: TObject);
begin
  FS.Free;
  FAniClip.Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.headerSized(Sender: TObject; ASection,
  AWidth: Integer);
begin
  lb.refresh;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.imgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  Case Button of
    mbRight:ende.caption:=inttostr(cell);
    mbLeft:start.Caption:=inttostr(cell);
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.imgMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not FAniClip.Clip.Empty then
    begin
      with FAniClip.Clip do
        cell:=(X div CellX)+((Y div CellY)*Columns);
      info.caption:=format('Cell: %d', [Cell]);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.lbDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var x,i:integer;

begin
  with (Control as TListbox), (Control as TListbox).canvas do
    begin
      x :=3;
      FillRect(Rect);
      LMDAnsiParseToStrList(items[index], '|', FS);
      for i:=0 to 3 do
        begin
          TextOut(x,Rect.Top, FS[i] );
          if i<3 then inc(x,Header.SectionWidth[i]);
        end;
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.LoadClick(Sender: TObject);
begin

  if FileDialog.Execute then
  begin
    FAniClip.LoadFromFile(FileDialog.Filename);
    img.picture.Bitmap:=FAniClip.Clip.Bitmap;
    FillLB;
    btclick(bt);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.loadclipClick(Sender: TObject);
var Editor: TLMDClipEditorDlg;

begin
  Editor := TLMDClipEditorDlg.Create(nil);
  try
    Editor.Clip:=FAniClip.Clip;
    Editor.SetLabels;
    if Editor.Showmodal=mrOK then
      begin
        if (FAniclip.Clip.Count<>Editor.Clip.Count) and (FAniClip.List.Count>0) then
          if messagedlg('You changed the Clip-Data.\nFrameList-Data will be cleared. Continue?', mtConfirmation, [MBYES, MBNO], 0)=mrNO then Exit;
        lb.clear;
        FAniClip.Clip:=Editor.Clip;
        img.picture.Bitmap:=FAniClip.Clip.Bitmap;
        btClick(bt);
      end;
  finally
    Editor.Free;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.OKClick(Sender: TObject);
begin
  FillList;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.SaveClick(Sender: TObject);
begin
  FillList;
  if not FAniClip.Empty then
    with SaveDialog do
     if Execute then FAniClip.saveToFile(Filename);
end;

{------------------------------------------------------------------------------}
Procedure TLMDAniClipEditorDlg.SetLabels;
begin

  If FAniClip.Clip.Empty then
    begin
      breite.Caption:='---';
      hoehe.Caption:='---';
      row.caption:='----';
      cols.caption:='----';
      info.caption:='No Clip specified';
    end
  else
    with FAniClip.Clip do
      begin
        breite.caption:=inttostr(Bitmap.Width);
        hoehe.caption:=inttostr(Bitmap.Height);
        row.caption:=inttostr(Rows);
        cols.caption:=inttostr(Columns);
        info.caption:='';
      end;

   start.caption:='0';
   ende.caption:='0';
   bt3.enabled:=lb.items.count>0;
   bt2.enabled:=lb.items.count>0;
   bt.enabled:=not FAniClip.Clip.Empty;
   bt1.enabled:=bt.enabled;
   save.enabled:=bt.enabled;
   clear.enabled:=bt.enabled;
   name.enabled:=bt.enabled;
   index.enabled:=bt.enabled;

end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.tabChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  book.Pageindex:=NewTab;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClipEditorDlg.SetAniClip(aValue:TLMDAniClip);
begin
  FAniClip.Assign(aValue);
end;

{********************* Class TAniClipProperty *********************************}
{------------------------------------------------------------------------------}
procedure TLMDAniClipProperty.Edit;
var
  ClipEditor: TLMDAniClipEditorDlg;

begin

  ClipEditor := TLMDAniClipEditorDlg.Create(nil);
  try
    with clipeditor do
      begin
       AniClip:=TLMDAniClip(Pointer(GetOrdValue));
       img.picture.Bitmap:=Aniclip.clip.Bitmap;
       if Showmodal=mrOK then
         SetOrdValue(Longint(Pointer(ClipEditor.AniClip)));
      end;
  finally
    ClipEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDAniClipProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end;

{------------------------------------------------------------------------------}
function TLMDAniClipProperty.GetValue: string;
var uClip: TLMDAniClip;

begin

  uClip:=TLMDAniClip(Pointer(GetOrdValue));
  if uClip.Empty then
    Result:='Empty' {LoadStr(srNone)}
  else
    Result:='(TLMDAniClip)';

end;

{********************* Class TAniClipEditor ***********************************}
{------------------------------------------------------------------------------}
procedure TLMDAniClipEditor.ExecuteVerb(Index: Integer);
var
  ClipEditor: TLMDAniClipEditorDlg;

begin
  ClipEditor := TLMDAniClipEditorDlg.Create(nil);
  try
    ClipEditor.AniClip:=(Component as TLMDAniPicClip).AniClip;
    ClipEditor.img.picture.Bitmap:=ClipEditor.Aniclip.clip.Bitmap;
    if ClipEditor.Showmodal=mrOK then
      begin
        (Component as TLMDAniPicClip).AniClip:=ClipEditor.AniClip;
        Designer.Modified;
      end;
  finally
    ClipEditor.Free;
  end;
end;

{-----------------------------------------------------------------------}
function TLMDAniClipEditor.GetVerb(Index: Integer): string;
begin
  Result :='Specify AniClip';
end;

{-----------------------------------------------------------------------}
function TLMDAniClipEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TAniEditor ****************************}
{-----------------------------------------------------------------------}
procedure TLMDAniEditor.ExecuteVerb(Index: Integer);

begin
  case index of
    0: TLMDAniImage(Component).Play;
    1: TLMDAniImage(Component).Stop;
  end;
end;

{-----------------------------------------------------------------------}
function TLMDAniEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Play Frame';
    1: result:='Stop playing Frame';
  end;
end;

{-----------------------------------------------------------------------}
function TLMDAniEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

end.
