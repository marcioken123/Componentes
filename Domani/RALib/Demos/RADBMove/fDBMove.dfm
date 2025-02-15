�
 TFORM1 0}  TPF0TForm1Form1Left� Top`BorderIconsbiSystemMenu
biMinimize BorderStylebsSingleCaptionTRADBMove DemoClientHeight�ClientWidth7
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OnCreate
FormCreatePixelsPerInch`
TextHeight TPageControlPageControl1LeftTopWidth)Heighta
ActivePage	TabSheet1TabOrder  	TTabSheet	TabSheet1CaptionSource (DBDEMOS) TLabelLabel1LeftTop WidthOHeightCaptionCUSTOMER.DB  TLabelLabel2LeftTop� Width@HeightCaption	ORDERS.DB  TLabelLabel3LeftTop,Width�HeightAutoSizeCaptionCUSTOMER.CustNo ->ORDERS.CustNo
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontWordWrap	  TLabelLabel4Left�TopWidthqHeightAutoSizeCaptionOThis is Source Database. It contains two tables and one reference between them.Color��� ParentColorWordWrap	  TDBGridDBGrid1LeftTopWidth�Heighty
DataSource	dsSource1TabOrder TitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style   TDBGridDBGrid2LeftTop� Width�Heightx
DataSource	dsSource2TabOrderTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style    	TTabSheet	TabSheet2Caption   -> TLabelLabel9LeftTopWidthHeight!AutoSizeCaptionThis demo includes steps:
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TBitBtnBitBtn1LeftTop8Width�HeightCaption1. Create destination tables
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder OnClickBitBtn1ClickMargin  TBitBtnBitBtn2LeftTop`Width�HeightCaption2. Batch moving
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderOnClickBitBtn2ClickMargin  	TGroupBox	GroupBox1LeftTop� WidthHeight� Caption Key properties TabOrder TLabelLabel11LeftTopWidthbHeightCaptionRADBMove1.Tables  TLabelLabel12Left� TopWidthyHeightCaptionRADBMove1.References  TLabelLabel13LeftXTopWidthpHeightCaptionRADBMove1.Mappings  TMemoMemo1LeftTop(Width� HeightdLines.StringsMemo1 ReadOnly	
ScrollBarsssBothTabOrder WordWrap  TMemoMemo2Left� Top(Width� HeightdLines.StringsMemo2 ReadOnly	
ScrollBarsssBothTabOrderWordWrap  TMemoMemo3LeftYTop(Width� HeightdLines.StringsMemo3 ReadOnly	
ScrollBarsssBothTabOrderWordWrap    	TTabSheet	TabSheet3CaptionDestination (WINDOWS TEMP DIR) TLabelLabel7Left�TopWidthqHeightAutoSizeCaptionO  This is Destination Database. You can see that all references fixups correctly.
Fields CustNo in CUSTOMER.DB and OrderNo in ORDERS.DB are changed because they are primary keys which are generated unique.
Field CustNo (now called MyCustNo) in ORDERS.DB (now called MYORDERS) also changed, so it can correctly refer to new CUSTOMER.DB.Color��� ParentColorWordWrap	  TLabelLabel5LeftTop WidthOHeightCaptionCUSTOMER.DB  TLabelLabel6LeftTop� WidthPHeightCaptionMYORDERS.DB  TLabelLabel8LeftTop,Width�HeightAutoSizeCaption#CUSTOMER.CustNo ->MYORDERS.MyCustNo
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontWordWrap	  TDBGridDBGrid3LeftTopWidth�Heighty
DataSourcedsDestination1TabOrder TitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style   TDBGridDBGrid4LeftTop� Width�Heightx
DataSourcedsDestination2TabOrderTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style    	TTabSheet	TabSheet4CaptionClean up TBitBtnBitBtn3LeftTop� Width�HeightCaption&3. Remove temporary destination tables
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder OnClickBitBtn3ClickMargin  TBitBtnBitBtn4LeftTop� Width�HeightCaptionExit
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderOnClickBitBtn4ClickMargin    TButtonButton1Left�ToppWidthKHeightCaptionNext >>TabOrderOnClickButton1Click  TPanelPanel1Left� TopPWidthHeightICaptionPanel1TabOrderVisible TLabelLabel10LeftTopWidth� HeightCaptionDon't run from Delphi IDE!
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont   TTabletSource1DatabaseNameDBDemos	TableNameCUSTOMER.DBLeftHTop�   TDataSource	dsSource1DataSettSource1Left� Top�   TTabletSource2DatabaseNameDBDemos	IndexNameCustNoMasterFieldsCustNoMasterSource	dsSource1	TableName	ORDERS.DBLeft� Top�   TDataSource	dsSource2DataSettSource2Left Top�   	TRADBMove	RADBMove1SourceDBDemosDestinationDestBaseTables.StringsCUSTOMERORDERS 	TempTable_RATMP1_.DBReferences.StringsORDERS.CustNo = CUSTOMER.CustNo Mappings.StringsORDERS=MYORDERSORDERS.CustNo=MyCustNo OnMoveRecordRADBMove1MoveRecordProgress	Left� Top�   TRASQLScriptRASQLScript1Script.Strings%/* Creating two destination tables */ create table "CUSTOMER.DB"((  CustNo     integer,       /* CustNo */)  Company    char(30),      /* Company */'  Addr1      char(30),      /* Addr1 */  primary key (CustNo)); create table "MYORDERS.DB"(  OrderNo     integer,  MyCustNo      integer,  SaleDate    timestamp,  ShipDate    timestamp,  EmpNo       integer,  primary key (OrderNo)); *create index CustNo on MYORDERS(MyCustNo);   CommitctNoneDatabaseDestinationDatabaseLeft�Top�   	TDatabaseDestinationDatabase	Connected	DatabaseNameDestBase
DriverNameSTANDARDParams.StringsPATH=C:\Temp SessionNameDefaultTransIsolationtiDirtyReadLeft4Top�   TTabletDestination1DatabaseNameDestBase	TableNameCUSTOMER.DBLeftHTop   TDataSourcedsDestination1DataSettDestination1Left� Top   TTabletDestination2DatabaseNameDestBase	IndexNameCustNoMasterFieldsCustNoMasterSourcedsDestination1	TableNameMYORDERS.DBLeft� Top   TDataSourcedsDestination2DataSettDestination2Left Top   TRAProgressFormRAProgressForm1CaptionTRADBMove in progressProgressMin ProgressMax ProgressStepProgressPosition OnShowRAProgressForm1ShowLeft�Top�    