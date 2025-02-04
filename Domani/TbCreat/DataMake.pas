unit datamake;

interface
uses Windows, SysUtils, Classes, db, dbTables, Dialogs, Controls;

procedure RecreateTable(aStrings: TStrings; aTable: TTable);
procedure SaveTableStruct(aStrings: TStrings; aTable: TTable);
{procedure AddIndexDefs(aStrings: TStrings; aTable: TTable);
procedure AddFieldDefs(aStrings: TStrings; aTable: TTable);}

implementation

function StrToFieldType(aFieldType: String): TFieldType;
begin
	if aFieldType = 'FTUNKNOWN' then
		result := ftUnknown
	else if aFieldType = 'FTSTRING' then
		result := ftString
	else if aFieldType = 'FTSMALLINT' then
		result := ftSmallint
	else if aFieldType = 'FTINTEGER' then
		result := ftInteger
	else if aFieldType = 'FTWORD' then
		result := ftWord
	else if aFieldType = 'FTBOOLEAN' then
		result := ftBoolean
	else if aFieldType = 'FTFLOAT' then
		result := ftFloat
	else if aFieldType = 'FTCURRENCY' then
		result := ftCurrency
	else if aFieldType = 'FTBCD' then
		result := ftBCD
	else if aFieldType = 'FTDATE' then
		result := ftDate
	else if aFieldType = 'FTTIME' then
		result := ftTime
	else if aFieldType = 'FTDATETIME' then
		result := ftDateTime
	else if aFieldType = 'FTBYTES' then
		result := ftBytes
	else if aFieldType = 'FTBLOB' then
		result := ftBlob
	else if aFieldType = 'FTMEMO' then
		result := ftMemo
	else if aFieldType = 'FTGRAPHIC' then
		result := ftGraphic
	else
		result := ftUnknown;
end;

procedure RecreateTable(aStrings: TStrings; aTable: TTable);
var
	s, q,
	aFieldName, aFieldType, aSize, aRequired: string;
	nSize,
	i, j, k: integer;
	//nFieldType: TFieldType;
	mIndexOptions: TIndexOptions;
begin
	aTable.Active := False;
	aTable.DatabaseName := aStrings.Values['DatabaseName'];
	aTable.TableName := aStrings.Values['TableName'];

	s := UpperCase(aStrings.Values['TableType']);
	if s = 'TTDEFAULT' then
		aTable.TableType := ttDefault
	else if s = 'TTDBASE' then
		aTable.TableType := ttDBase
	else if s = 'TTPARADOX' then
		aTable.TableType := ttParadox
	else if s = 'TTASCII' then
		aTable.TableType := ttAscii
	else
		raise Exception.Create('Invalid TableType for ' + aTable.TableName);

	with aTable.FieldDefs do
	begin
		Clear;
		s := aStrings.Values['FieldCount'];
		j := StrToInt(s);
		for i := 0 to j-1 do
		begin
			s := 'FIELD'+Trim(IntToStr(i));
			q := aStrings.Values[s];

			k := Pos(',', q);
			aFieldName := Trim(copy(q, 1, k-1));
			System.Delete(q, 1, k);

			k := Pos(',', q);
			aFieldType := Trim(UpperCase(copy(q, 1, k-1)));
			System.Delete(q, 1, k);

			k := Pos(',', q);
			aSize := Copy(q, 1, k-1);
			System.Delete(q, 1, k);

			aRequired := Trim(UpperCase(q));

			nSize := StrToInt(aSize);

			Add(aFieldName, StrToFieldType(aFieldType), nSize, aRequired='TRUE');
		end;
	end;

	with aTable.IndexDefs do
	begin
		Clear;
		s := aStrings.Values['IndexCount'];
		j := StrToInt(s);
		for i := 0 to j-1 do
		begin
			s := 'INDEX'+Trim(IntToStr(i));
			q := aStrings.Values[s];

			{get index name}
			k := Pos(',', q);
			aFieldName := Trim(Copy(q, 1, k-1));
			System.Delete(q, 1, k);

			{get fields of index}
			k := Pos(',', q);
			aFieldType := Trim(Copy(q, 1, k-1));
			System.Delete(q, 1, k);

			{get index options}
			aRequired := UpperCase(q);

			mIndexOptions := [];
			if Pos('IXPRIMARY', aRequired)<>0 then
				mIndexOptions := mIndexOptions + [ixPrimary];
			if Pos('IXUNIQUE', aRequired)<>0 then
				mIndexOptions := mIndexOptions + [ixUnique];
			if Pos('IXDESCENDING', aRequired)<>0 then
				mIndexOptions := mIndexOptions + [ixDescending];
			if Pos('IXCASEINSENSITIVE', aRequired)<>0 then
				mIndexOptions := mIndexOptions + [ixCaseInsensitive];
			if Pos('IXEXPRESSION', aRequired)<>0 then
				mIndexOptions := mIndexOptions + [ixExpression];

			with AddIndexDef do
			begin
				Name := aFieldName;
				Fields := aFieldType;
				Options := mIndexOptions;
			end;
		end;
		if aTable.Exists then
		begin
			if MessageDlg('The table your are trying to create exists.'+#13+#10+'If you should choose to continue, ALL'+#13+#10+'data in the existing table will be erased.'+#13+#10+'Continue?', mtWarning, [mbYes, mbNo], 0)=mrNo then
				Abort;
		end;
		aTable.CreateTable;
	end;
end;

procedure AddFieldDefs(aStrings: TStrings; aTable: TTable);
var
	tops, i: integer;
	s: string;
	d: TFieldDef;
begin
	with aTable do
	begin
		FieldDefs.Update;
		tops := FieldDefs.count;
		for i:=0 to tops-1 do
		begin
			D := FieldDefs.items[i];
			s := D.name + ', ';
			case D.DataType of
				ftUnknown: s := s + 'ftUnknown';
                                ftAutoInc: s := s + 'ftAutoInc';
				ftString: s := s + 'ftString';
				ftSmallint: s := s + 'ftSmallInt';
				ftInteger: s := s + 'ftInteger';
				ftWord: s := s + 'ftWord';
				ftBoolean:s := s + 'ftBoolean';
				ftFloat: s := s + 'ftFloat';
				ftCurrency:s := s + 'ftCurrency';
				ftBCD: s := s + 'ftBCD';
				ftDate: s := s + 'ftDate';
				ftTime: s := s + 'ftTime';
				ftDateTime: s := s + 'ftDateTime';
				ftBytes: s := s + 'ftBytes';
				{ftVarBytes: D := ''; }
				ftBlob:s := s + 'ftBLOB';
				ftMemo: s := s + 'ftMemo';
				ftGraphic: s := s + 'ftGraphic';
			end;
			s := s + ', ' + IntToStr(D.Size) + ', ';
			if D.Required then
				s := s + 'True'
			else
				s := s + 'False';

			s := 'FIELD' + Trim(IntToStr(i)) + '=' + s;
			aStrings.Add(s);
		end;
	end;
end;

procedure AddIndexDefs(aStrings: TStrings; aTable: TTable);
var
	s: string;
	i, tops: integer;
begin
	with aTable do
	begin
	IndexDefs.Update;
	tops := IndexDefs.Count;
	for i := 0 to tops-1 do
	begin
		s := IndexDefs.Items[i].Name;
		s := s + ',' + INdexDefs.Items[i].Fields+IndexDefs.items[i].Expression;


		s := s + ', [';

		if ixPrimary in IndexDefs.items[i].Options then
			s := s + 'ixPrimary, ';
		if ixUnique in IndexDefs.items[i].Options then
			s := s + 'ixUnique, ';
		if ixDescending in IndexDefs.items[i].Options then
			s := s + 'ixDescending, ';
		if ixCaseInsensitive in IndexDefs.items[i].Options then
			s := s + 'ixCaseInsensitive, ';
		if ixExpression in IndexDefs.items[i].Options then
			s := s + 'ixExpression, ';
		{Get rid of trailing ", "}
		 S := Copy(S, 1, length(s)-2);

		 s := 'INDEX' + Trim(IntToStr(i)) + '=' + s + ']';

		 aStrings.Add(s);
		end;
	end;
end;

procedure SaveTableStruct(aStrings: TStrings; aTable: TTable);
var
	s: string;
begin
	aStrings.Add(Format('DatabaseName=%s',[aTable.DatabaseName]));
	aStrings.Add(Format('TableName=%s',[aTable.TableName]));
	case aTable.TableType of
		ttDefault: s := 'ttDefault';
		ttDBase: s := 'ttDBase';
		ttParadox: s := 'ttParadox';
		ttAscii: s := 'ttASCII';
	end;
	aStrings.Add(Format('TableType=%s',[s]));

	aTable.FieldDefs.Update;
	aStrings.Add('FieldCount='+Trim(IntToStr(aTable.FieldDefs.Count)));
	aTable.IndexDefs.Update;
	aStrings.Add('IndexCount='+Trim(IntToStr(aTable.IndexDefs.Count)));
	AddFieldDefs(aStrings, aTable);
	AddIndexDefs(aStrings, aTable);
end;

end.
