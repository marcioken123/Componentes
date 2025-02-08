{$IFNDEF VER90}
  {$IFNDEF VER100}
    {$IFNDEF VER120}
      {$IFNDEF VER130}
        {$IFNDEF VER140}
          {$IFDEF VER110}
            {$ObjExportAll On}
            {$Define ver100}
          {$ELSE}
            {$IFDEF VER125}
              {$Define ver120}
            {$ELSE}
              {$Define ver90}
            {$ENDIF}
          {$ENDIF}
        {$ELSE}
          {$IFNDEF BCB}
            {$Define Delphi}
          {$ENDIF}
          {$Define ver120}
          {$Define ver130}
        {$ENDIF}
      {$ELSE}
        {$IFNDEF BCB}
          {$Define Delphi}
        {$ENDIF}
        {$Define ver120}
      {$ENDIF}
    {$ELSE}
      {$Define Delphi}
    {$ENDIF}
  {$ELSE}
    {$Define Delphi}
  {$ENDIF}
{$ELSE}
  {$Define Delphi}
{$ENDIF}
unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CoolCtrls, CoolUtils, ExtCtrls, CoolTools;

type
  TForm9 = class(TForm)
    CoolListBox1: TCoolListBox;
    Memo1: TCoolMemo;
    WindowsInformant1: TCoolWindowsInformant;
    CoolListBox2: TCoolListBox;
    Memo2: TCoolMemo;
    WindowsInformant2: TCoolWindowsInformant;
    CoolLabel1: TCoolLabel;
    CoolLabel2: TCoolLabel;
    CoolLabel3: TCoolLabel;
    CoolLabel4: TCoolLabel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Capture1: TCoolCapture;
    CoolFormHook1: TCoolFormHook;
    CoolBtn9: TCoolBtn;
    CoolCaptionEffects1: TCoolCaptionEffects;
    procedure CoolListBox1Click(Sender: TObject);
    procedure CoolListBox2Click(Sender: TObject);
    procedure CoolListBox1Enter(Sender: TObject);
    procedure CoolListBox2Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.DFM}

uses
  Unit11;
   
procedure TForm9.CoolListBox1Click(Sender: TObject);
var
  I: Integer;
begin
  Memo1.Lines.Clear;
  CoolListBox2.Items.Clear;

  if Assigned(WindowsInformant1.Window[CoolListBox1.ItemIndex]) then
  begin
    WindowsInformant2.ParentHandle := WindowsInformant1.Window[CoolListBox1.ItemIndex]^.wHandle;
    WindowsInformant2.UpdateWindows;

    for I := 0 to Pred(WindowsInformant2.Count) do
      CoolListBox2.Items.Add(WindowsInformant2.Window[I]^.wClassName);
  end;

  with Memo1, WindowsInformant1.Window[CoolListBox1.ItemIndex]^ do
  begin
    Lines.Add('Handle: ' + IntToStr(wHandle));
    Lines.Add('Title: ' + wTitle);
    Lines.Add('ClassName: ' + wClassName);
    Lines.Add('Coordinates: ' + IntToStr(wWindowRect.Left) + ',' + IntToStr(wWindowRect.Top) + ',' + IntToStr(wWindowRect.Right) + ',' + IntToStr(wWindowRect.Bottom));
    Lines.Add('Client Coordinates: ' + IntToStr(wClientRect.Left) + ',' + IntToStr(wClientRect.Top) + ',' + IntToStr(wClientRect.Right) + ',' + IntToStr(wClientRect.Bottom));
    Lines.Add('Visible: ' + BoolToStr(wVisible));
    Lines.Add('Enabled: ' + BoolToStr(wEnabled));
    Lines.Add('Maximized: ' + BoolToStr(wMaximized));
    Lines.Add('Minimized: ' + BoolToStr(wMinimized));
    Lines.Add('Style:');
    if wStyle and WS_OVERLAPPED <> 0 then
      Lines.Add(' WS_OVERLAPPED');
    if wStyle and WS_POPUP <> 0 then
      Lines.Add(' WS_POPUP');
    if wStyle and WS_CHILD <> 0 then
      Lines.Add(' WS_CHILD');
    if wStyle and WS_MINIMIZE <> 0 then
      Lines.Add(' WS_MINIMIZE');
    if wStyle and WS_VISIBLE <> 0 then
      Lines.Add(' WS_VISIBLE');
    if wStyle and WS_DISABLED <> 0 then
      Lines.Add(' WS_DISABLED');
    if wStyle and WS_CLIPSIBLINGS <> 0 then
      Lines.Add(' WS_CLIPSIBLINGS');
    if wStyle and WS_CLIPCHILDREN <> 0 then
      Lines.Add(' WS_CLIPCHILDREN');
    if wStyle and WS_MAXIMIZE <> 0 then
      Lines.Add(' WS_MAXIMIZE');
    if wStyle and WS_CAPTION <> 0 then
      Lines.Add(' WS_CAPTION');
    if wStyle and WS_BORDER <> 0 then
      Lines.Add(' WS_BORDER');
    if wStyle and WS_DLGFRAME <> 0 then
      Lines.Add(' WS_DLGFRAME');
    if wStyle and WS_VSCROLL <> 0 then
      Lines.Add(' WS_VSCROLL');
    if wStyle and WS_HSCROLL <> 0 then
      Lines.Add(' WS_HSCROLL');
    if wStyle and WS_SYSMENU <> 0 then
      Lines.Add(' WS_SYSMENU');
    if wStyle and WS_THICKFRAME <> 0 then
      Lines.Add(' WS_THICKFRAME');
    if wStyle and WS_GROUP <> 0 then
      Lines.Add(' WS_GROUP');
    if wStyle and WS_TABSTOP <> 0 then
      Lines.Add(' WS_TABSTOP');
    if wStyle and WS_MINIMIZEBOX <> 0 then
      Lines.Add(' WS_MINIMIZEBOX');
    if wStyle and WS_MAXIMIZEBOX <> 0 then
      Lines.Add(' WS_MAXIMIZEBOX');
    if wStyle and WS_TILED <> 0 then
      Lines.Add(' WS_TILED');
    if wStyle and WS_ICONIC <> 0 then
      Lines.Add(' WS_ICONIC');
    if wStyle and WS_SIZEBOX <> 0 then
      Lines.Add(' WS_SIZEBOX');

    Lines.Add('ExStyle:');
    if wExStyle and WS_EX_DLGMODALFRAME <> 0 then
      Lines.Add(' WS_EX_DLGMODALFRAME');
    if wExStyle and WS_EX_NOPARENTNOTIFY <> 0 then
      Lines.Add(' WS_EX_NOPARENTNOTIFY');
    if wExStyle and WS_EX_TOPMOST <> 0 then
      Lines.Add(' WS_EX_TOPMOST');
    if wExStyle and WS_EX_ACCEPTFILES <> 0 then
      Lines.Add(' WS_EX_ACCEPTFILES');
    if wExStyle and WS_EX_TRANSPARENT <> 0 then
      Lines.Add(' WS_EX_TRANSPARENT');
    if wExStyle and WS_EX_MDICHILD <> 0 then
      Lines.Add(' WS_EX_MDICHILD');
    if wExStyle and WS_EX_TOOLWINDOW <> 0 then
      Lines.Add(' WS_EX_TOOLWINDOW');
    if wExStyle and WS_EX_WINDOWEDGE <> 0 then
      Lines.Add(' WS_EX_WINDOWEDGE');
    if wExStyle and WS_EX_CLIENTEDGE <> 0 then
      Lines.Add(' WS_EX_CLIENTEDGE');
    if wExStyle and WS_EX_CONTEXTHELP <> 0 then
      Lines.Add(' WS_EX_CONTEXTHELP');
    if wExStyle and WS_EX_RIGHT <> 0 then
      Lines.Add(' WS_EX_RIGHT');
    if wExStyle and WS_EX_LEFT <> 0 then
      Lines.Add(' WS_EX_LEFT');
    if wExStyle and WS_EX_RTLREADING <> 0 then
      Lines.Add(' WS_EX_RTLREADING');
    if wExStyle and WS_EX_LTRREADING <> 0 then
      Lines.Add(' WS_EX_LTRREADING');
    if wExStyle and WS_EX_LEFTSCROLLBAR <> 0 then
      Lines.Add(' WS_EX_LEFTSCROLLBAR');
    if wExStyle and WS_EX_RIGHTSCROLLBAR <> 0 then
      Lines.Add(' WS_EX_RIGHTSCROLLBAR');
    if wExStyle and WS_EX_CONTROLPARENT <> 0 then
      Lines.Add(' WS_EX_CONTROLPARENT');
    if wExStyle and WS_EX_STATICEDGE <> 0 then
      Lines.Add(' WS_EX_STATICEDGE');
    if wExStyle and WS_EX_APPWINDOW <> 0 then
      Lines.Add(' WS_EX_APPWINDOW');
    if wExStyle and WS_EX_OVERLAPPEDWINDOW <> 0 then
      Lines.Add(' WS_EX_OVERLAPPEDWINDOW');
    if wExStyle and WS_EX_PALETTEWINDOW <> 0 then
      Lines.Add(' WS_EX_PALETTEWINDOW');


    if Image1.Picture.Bitmap.Width <> 1 then
      Image1.Picture.Bitmap.Width := 1;

    if Image1.Picture.Bitmap.Height <> 1 then
      Image1.Picture.Bitmap.Height := 1;

    if wVisible then
      with Capture1 do
      begin
        WindowHandle := wHandle;

        SetForegroundWindow(wHandle);
        Delay(1000);
        ZoomRatio := 25;
        Capture;
        SetForegroundWindow(Self.Handle);

        if Assigned(Buffer) then
          Image1.Picture.Bitmap.Assign(Buffer);
      end;
  end;
end;

procedure TForm9.CoolListBox2Click(Sender: TObject);
begin
  with  CoolListbox2, Memo2, WindowsInformant2.Window[CoolListBox2.ItemIndex]^ do
  begin
    Lines.Clear;
    Lines.Add('Handle: ' + IntToStr(wHandle));
    Lines.Add('Title: ' + wTitle);
    Lines.Add('ClassName: ' + wClassName);
    Lines.Add('Coordinates: ' + IntToStr(wWindowRect.Left) + ',' + IntToStr(wWindowRect.Top) + ',' + IntToStr(wWindowRect.Right) + ',' + IntToStr(wWindowRect.Bottom));
    Lines.Add('Client Coordinates: ' + IntToStr(wClientRect.Left) + ',' + IntToStr(wClientRect.Top) + ',' + IntToStr(wClientRect.Right) + ',' + IntToStr(wClientRect.Bottom));
    Lines.Add('Visible: ' + BoolToStr(wVisible));
    Lines.Add('Enabled: ' + BoolToStr(wEnabled));
    Lines.Add('Maximized: ' + BoolToStr(wMaximized));
    Lines.Add('Minimized: ' + BoolToStr(wMinimized));    
    Lines.Add('Style:');
    if wStyle and WS_OVERLAPPED <> 0 then
      Lines.Add(' WS_OVERLAPPED');
    if wStyle and WS_POPUP <> 0 then
      Lines.Add(' WS_POPUP');
    if wStyle and WS_CHILD <> 0 then
      Lines.Add(' WS_CHILD');
    if wStyle and WS_MINIMIZE <> 0 then
      Lines.Add(' WS_MINIMIZE');
    if wStyle and WS_VISIBLE <> 0 then
      Lines.Add(' WS_VISIBLE');
    if wStyle and WS_DISABLED <> 0 then
      Lines.Add(' WS_DISABLED');
    if wStyle and WS_CLIPSIBLINGS <> 0 then
      Lines.Add(' WS_CLIPSIBLINGS');
    if wStyle and WS_CLIPCHILDREN <> 0 then
      Lines.Add(' WS_CLIPCHILDREN');
    if wStyle and WS_MAXIMIZE <> 0 then
      Lines.Add(' WS_MAXIMIZE');
    if wStyle and WS_CAPTION <> 0 then
      Lines.Add(' WS_CAPTION');
    if wStyle and WS_BORDER <> 0 then
      Lines.Add(' WS_BORDER');
    if wStyle and WS_DLGFRAME <> 0 then
      Lines.Add(' WS_DLGFRAME');
    if wStyle and WS_VSCROLL <> 0 then
      Lines.Add(' WS_VSCROLL');
    if wStyle and WS_HSCROLL <> 0 then
      Lines.Add(' WS_HSCROLL');
    if wStyle and WS_SYSMENU <> 0 then
      Lines.Add(' WS_SYSMENU');
    if wStyle and WS_THICKFRAME <> 0 then
      Lines.Add(' WS_THICKFRAME');
    if wStyle and WS_GROUP <> 0 then
      Lines.Add(' WS_GROUP');
    if wStyle and WS_TABSTOP <> 0 then
      Lines.Add(' WS_TABSTOP');
    if wStyle and WS_MINIMIZEBOX <> 0 then
      Lines.Add(' WS_MINIMIZEBOX');
    if wStyle and WS_MAXIMIZEBOX <> 0 then
      Lines.Add(' WS_MAXIMIZEBOX');
    if wStyle and WS_TILED <> 0 then
      Lines.Add(' WS_TILED');
    if wStyle and WS_ICONIC <> 0 then
      Lines.Add(' WS_ICONIC');
    if wStyle and WS_SIZEBOX <> 0 then
      Lines.Add(' WS_SIZEBOX');

    Lines.Add('ExStyle:');
    if wExStyle and WS_EX_DLGMODALFRAME <> 0 then
      Lines.Add(' WS_EX_DLGMODALFRAME');
    if wExStyle and WS_EX_NOPARENTNOTIFY <> 0 then
      Lines.Add(' WS_EX_NOPARENTNOTIFY');
    if wExStyle and WS_EX_TOPMOST <> 0 then
      Lines.Add(' WS_EX_TOPMOST');
    if wExStyle and WS_EX_ACCEPTFILES <> 0 then
      Lines.Add(' WS_EX_ACCEPTFILES');
    if wExStyle and WS_EX_TRANSPARENT <> 0 then
      Lines.Add(' WS_EX_TRANSPARENT');
    if wExStyle and WS_EX_MDICHILD <> 0 then
      Lines.Add(' WS_EX_MDICHILD');
    if wExStyle and WS_EX_TOOLWINDOW <> 0 then
      Lines.Add(' WS_EX_TOOLWINDOW');
    if wExStyle and WS_EX_WINDOWEDGE <> 0 then
      Lines.Add(' WS_EX_WINDOWEDGE');
    if wExStyle and WS_EX_CLIENTEDGE <> 0 then
      Lines.Add(' WS_EX_CLIENTEDGE');
    if wExStyle and WS_EX_CONTEXTHELP <> 0 then
      Lines.Add(' WS_EX_CONTEXTHELP');
    if wExStyle and WS_EX_RIGHT <> 0 then
      Lines.Add(' WS_EX_RIGHT');
    if wExStyle and WS_EX_LEFT <> 0 then
      Lines.Add(' WS_EX_LEFT');
    if wExStyle and WS_EX_RTLREADING <> 0 then
      Lines.Add(' WS_EX_RTLREADING');
    if wExStyle and WS_EX_LTRREADING <> 0 then
      Lines.Add(' WS_EX_LTRREADING');
    if wExStyle and WS_EX_LEFTSCROLLBAR <> 0 then
      Lines.Add(' WS_EX_LEFTSCROLLBAR');
    if wExStyle and WS_EX_RIGHTSCROLLBAR <> 0 then
      Lines.Add(' WS_EX_RIGHTSCROLLBAR');
    if wExStyle and WS_EX_CONTROLPARENT <> 0 then
      Lines.Add(' WS_EX_CONTROLPARENT');
    if wExStyle and WS_EX_STATICEDGE <> 0 then
      Lines.Add(' WS_EX_STATICEDGE');
    if wExStyle and WS_EX_APPWINDOW <> 0 then
      Lines.Add(' WS_EX_APPWINDOW');
    if wExStyle and WS_EX_OVERLAPPEDWINDOW <> 0 then
      Lines.Add(' WS_EX_OVERLAPPEDWINDOW');
    if wExStyle and WS_EX_PALETTEWINDOW <> 0 then
      Lines.Add(' WS_EX_PALETTEWINDOW');


    if Image1.Picture.Bitmap.Width <> 1 then
      Image1.Picture.Bitmap.Width := 1;

    if Image1.Picture.Bitmap.Height <> 1 then
      Image1.Picture.Bitmap.Height := 1;

    if wVisible then
      with Capture1 do
      begin
        WindowHandle := wHandle;
        
        SetForegroundWindow(GetParent(wHandle));
        Delay(1000);
        ZoomRatio := 100;
        Capture;
        SetForegroundWindow(Handle);

        if Assigned(Buffer) then
          Image1.Picture.Bitmap.Assign(Buffer);
      end;
  end;
end;

procedure TForm9.CoolListBox1Enter(Sender: TObject);
begin
  Memo2.Lines.Clear;
end;

procedure TForm9.CoolListBox2Enter(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TForm9.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  CoolListBox1.Items.Clear;
  with WindowsInformant1 do
  begin
    ParentHandle := 0;
    UpdateWindows;
    for I := 0 to Pred(Count) do
      CoolListBox1.Items.Add(Window[I]^.wClassName);
  end;
end;

end.
