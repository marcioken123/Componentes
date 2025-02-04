unit TableCreator;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	IniFiles, DB, DBtables;

type
	ETableCreatorError = class(Exception);

	TTableCreator = class(TComponent)
	private
		FIniFile: TMemIniFile;
		FActive: boolean;
		FINIFileName: TFileName;
		FTable: TTable;
		aStringList: TStringList;

		procedure SetActive(const Value: boolean);
		procedure SetINIFileName(const Value: TFileName);
		procedure SetTable(const Value: TTable);
		{ Private declarations }
	protected
		{ Protected declarations }
		procedure Notification(AComponent: TComponent; Operation: TOperation); override;
	public
		{ Public declarations }
		constructor Create(aOwner: TComponent); override;
		destructor Destroy; override;
		procedure GetTables(aStrings: TStrings);
		procedure MakeTable(aTableName: string);
		procedure MakeAllTables;
		procedure AddTable(aTable: TTable);
		procedure AddTableData;
		procedure GetStrings(aStrings: TStrings);
		procedure Open;
		procedure Close;
		procedure Loaded; override;
	published
		{ Published declarations }
		property Active: boolean read FActive write SetActive;
		property INIFileName: TFileName read FINIFileName write SetINIFileName;
		property Table: TTable read FTable write SetTable;
	end;

procedure Register;

implementation
uses DataMake;

procedure Register;
begin
  RegisterComponents('Domani', [TTableCreator]);
end;

{ TTableCreator }

procedure TTableCreator.AddTable(aTable: TTable);
var
	aSection: string;
	i: integer;
	s: string;
begin
	aStringList.Clear;
	SaveTableStruct(aStringList, aTable);
	aSection := aTable.TableName;
	for i := 0 to aStringList.Count-1 do
	begin
		s := aStringList.Names[i];
		FINIFile.WriteString(aSection, s, aStringList.Values[s]);
	end;
end;

procedure TTableCreator.AddTableData;
var
	aSection: string;
	i: integer;
	s: string;
begin
	if Assigned(FTable) then
	begin
		aStringList.Clear;
		SaveTableStruct(aStringList, FTable);
		aSection := FTable.TableName;
		for i := 0 to aStringList.Count-1 do
		begin
			s := aStringList.Names[i];
			FINIFile.WriteString(aSection, s, aStringList.Values[s]);
		end;
	end
	else
		raise ETableCreatorError.Create('Can not add table.'#13'Table not Assigned.');
end;

procedure TTableCreator.Close;
begin
	if FActive then
	begin
		FActive := False;
		FINIFile.UpdateFile;
		FINIFile.Free;
	end;
end;

constructor TTableCreator.Create(aOwner: TComponent);
begin
	inherited Create(aOwner);
	aStringList := TStringList.Create;
end;

destructor TTableCreator.Destroy;
begin
	aStringList.Free;
	Close;
	inherited Destroy;
end;

procedure TTableCreator.GetStrings(aStrings: TStrings);
begin
  FINIFile.GetStrings(aStrings);
end;

procedure TTableCreator.GetTables(aStrings: TStrings);
begin
  FINIFile.ReadSections(aStrings);
end;

procedure TTableCreator.Loaded;
begin
	inherited Loaded;
	if Active then
	begin
		Open;
	end;
end;

procedure TTableCreator.MakeAllTables;
var
	aList: TStringList;
	i: integer;
begin
	if Assigned(FTable) then
	begin
		aList := TStringList.Create;
		try
			for i := 0 to aList.Count-1 do
			begin
				FINIFile.ReadSection(aList[i], aStringList);
				RecreateTable(aStringList, FTable);
			end;
		finally
			aList.Free;
		end;
	end
	else
		raise ETableCreatorError.Create('Can not create table.'#13'Table not Assigned.');
end;

procedure TTableCreator.MakeTable(aTableName: string);
begin
	if Assigned(FTable) then
	begin
		FINIFile.ReadSection(aTableName, aStringList);
		RecreateTable(aStringList, FTable);
	end
	else
		raise ETableCreatorError.Create('Can not create table.'#13'Table not Assigned.');
end;

procedure TTableCreator.Notification(AComponent: TComponent;
	Operation: TOperation);
begin
	inherited;
	if (Operation=opRemove) and (AComponent=FTable) then
		FTable := Nil;
end;

procedure TTableCreator.Open;
begin
	if not (csLoading in ComponentState) then
	begin
		if FINIFileName<>'' then
		begin
			FIniFile := TMemIniFile.Create(FINIFileName);
		end
		else
		begin
			FActive := False;
			raise ETableCreatorError.Create('Filename not assigned.');
		end;
	end;
end;

procedure TTableCreator.SetActive(const Value: boolean);
begin
	if FActive<>Value then
	begin
		FActive := Value;
		if FActive then
			Open
		else
			Close;
	end;
end;

procedure TTableCreator.SetINIFileName(const Value: TFileName);
begin
	FINIFileName := Value;
end;

procedure TTableCreator.SetTable(const Value: TTable);
begin
	FTable := Value;
end;

end.
