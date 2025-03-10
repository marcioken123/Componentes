unit checkboxu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, ComCtrls, wwriched, wwcheckbox,
  wwSpeedButton, wwDBNavigator, wwclearpanel, Db, DBTables, ImgList;

type
  TCheckBoxDemo = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    wwCheckBox1: TwwCheckBox;
    DBCheckBox1: TDBCheckBox;
    Image1: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    Label2: TLabel;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    Label3: TLabel;
    wwCheckBox4: TwwCheckBox;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    Bevel3: TBevel;
    Label4: TLabel;
    wwCheckBox7: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    wwCheckBox9: TwwCheckBox;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label5: TLabel;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Image2: TImage;
    Bevel7: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel8: TBevel;
    Label9: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label10: TLabel;
    Bevel6: TBevel;
    Label6: TLabel;
    TabSheet3: TTabSheet;
    Panel3: TPanel;
    Image3: TImage;
    Label11: TLabel;
    Bevel11: TBevel;
    Label12: TLabel;
    wwCheckBox10: TwwCheckBox;
    wwCheckBox11: TwwCheckBox;
    wwCheckBox12: TwwCheckBox;
    wwCheckBox13: TwwCheckBox;
    wwCheckBox14: TwwCheckBox;
    wwCheckBox18: TwwCheckBox;
    wwCheckBox17: TwwCheckBox;
    wwCheckBox16: TwwCheckBox;
    wwCheckBox19: TwwCheckBox;
    wwCheckBox20: TwwCheckBox;
    wwCheckBox21: TwwCheckBox;
    wwCheckBox23: TwwCheckBox;
    wwCheckBox22: TwwCheckBox;
    wwDBRichEdit1: TwwDBRichEdit;
    wwDBRichEdit2: TwwDBRichEdit;
    wwDBRichEdit3: TwwDBRichEdit;
    Label13: TLabel;
    DataSource1: TDataSource;
    Table1: TTable;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Delete: TwwNavButton;
    wwDBNavigator1Edit: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDBNavigator1Refresh: TwwNavButton;
    wwDBNavigator1SaveBookmark: TwwNavButton;
    wwDBNavigator1RestoreBookmark: TwwNavButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ImageList4: TImageList;
    ImageList5: TImageList;
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CheckBoxDemo: TCheckBoxDemo;

implementation

{$R *.DFM}

procedure TCheckBoxDemo.TabSheet2Show(Sender: TObject);
begin
if Image2.Picture.Bitmap.Empty then
   Image2.Picture.Assign(Image1.Picture);
end;

procedure TCheckBoxDemo.TabSheet3Show(Sender: TObject);
begin
if Image3.Picture.Bitmap.Empty then
   Image3.Picture.Assign(Image1.Picture);
end;

end.
