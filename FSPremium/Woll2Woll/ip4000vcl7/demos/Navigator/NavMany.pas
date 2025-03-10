unit NavMany;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwdblook, Db, DBTables, Wwtable, Wwdatsrc, wwSpeedButton,
  wwDBNavigator, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, ComCtrls, wwriched,
  ImgList, wwclearpanel;

type
  TNavigatorForm1 = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    wwDBRichEdit1: TwwDBRichEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    wwDBNavigator8: TwwDBNavigator;
    wwDBNavigator8Edit: TwwNavButton;
    wwDBNavigator8Post: TwwNavButton;
    wwDBNavigator8Cancel: TwwNavButton;
    wwDBNavigator8Refresh: TwwNavButton;
    wwDBNavigator8SaveBookmark: TwwNavButton;
    wwDBNavigator8RestoreBookmark: TwwNavButton;
    wwDBNavigator5: TwwDBNavigator;
    wwDBNavigator5First: TwwNavButton;
    wwDBNavigator5PriorPage: TwwNavButton;
    wwDBNavigator5Prior: TwwNavButton;
    wwDBNavigator5Last: TwwNavButton;
    wwDBNavigator5NextPage: TwwNavButton;
    wwDBNavigator5Next: TwwNavButton;
    wwDBNavigator7: TwwDBNavigator;
    wwDBNavigator7Delete: TwwNavButton;
    wwDBNavigator7Post: TwwNavButton;
    wwDBNavigator7Refresh: TwwNavButton;
    wwDBNavigator7RestoreBookmark: TwwNavButton;
    wwDBNavigator6: TwwDBNavigator;
    wwNavButton7: TwwNavButton;
    wwNavButton9: TwwNavButton;
    wwNavButton11: TwwNavButton;
    wwNavButton13: TwwNavButton;
    Label2: TLabel;
    Label3: TLabel;
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
    wwDBNavigator1Button: TwwNavButton;
    wwDBNavigator1Button1: TwwNavButton;
    wwDBNavigator1Button2: TwwNavButton;
    wwDBNavigator1Button3: TwwNavButton;
    wwDBNavigator3: TwwDBNavigator;
    wwDBNavigator3First: TwwNavButton;
    wwDBNavigator3PriorPage: TwwNavButton;
    wwDBNavigator3Prior: TwwNavButton;
    wwDBNavigator3Next: TwwNavButton;
    wwDBNavigator3NextPage: TwwNavButton;
    wwDBNavigator3Last: TwwNavButton;
    wwDBNavigator3Insert: TwwNavButton;
    wwDBNavigator3Delete: TwwNavButton;
    wwDBNavigator3Edit: TwwNavButton;
    wwDBNavigator3Post: TwwNavButton;
    wwDBNavigator3Cancel: TwwNavButton;
    wwDBNavigator3Refresh: TwwNavButton;
    wwDBNavigator3SaveBookmark: TwwNavButton;
    wwDBNavigator3RestoreBookmark: TwwNavButton;
    wwDBNavigator2: TwwDBNavigator;
    wwDBNavigator2First: TwwNavButton;
    wwDBNavigator2PriorPage: TwwNavButton;
    wwDBNavigator2Prior: TwwNavButton;
    wwDBNavigator2Next: TwwNavButton;
    wwDBNavigator2NextPage: TwwNavButton;
    wwDBNavigator2Last: TwwNavButton;
    wwDBNavigator2Insert: TwwNavButton;
    wwDBNavigator2Delete: TwwNavButton;
    wwDBNavigator2Edit: TwwNavButton;
    wwDBNavigator2Post: TwwNavButton;
    wwDBNavigator2Cancel: TwwNavButton;
    wwDBNavigator2Refresh: TwwNavButton;
    wwDBNavigator2SaveBookmark: TwwNavButton;
    wwDBNavigator2RestoreBookmark: TwwNavButton;
    Label4: TLabel;
    wwDBGrid1: TwwDBGrid;
    wwDBGrid2: TwwDBGrid;
    wwDBNavigator4: TwwDBNavigator;
    wwDBNavigator4First: TwwNavButton;
    wwDBNavigator4PriorPage: TwwNavButton;
    wwDBNavigator4Prior: TwwNavButton;
    wwDBNavigator4Next: TwwNavButton;
    wwDBNavigator4NextPage: TwwNavButton;
    wwDBNavigator4Last: TwwNavButton;
    wwDBNavigator4Insert: TwwNavButton;
    wwDBNavigator4Delete: TwwNavButton;
    ImageList1: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NavigatorForm1: TNavigatorForm1;

implementation

{$R *.DFM}



end.
