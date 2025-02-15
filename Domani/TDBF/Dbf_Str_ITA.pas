unit Dbf_Str;

{fix CR/LF}

interface

{$I Dbf_Common.inc}

var
  STRING_FILE_NOT_FOUND: string;
  STRING_VERSION: string;

  STRING_RECORD_LOCKED: string;

  STRING_INVALID_DBF_FILE: string;
  STRING_FIELD_TOO_LONG: string;
  STRING_INVALID_FIELD_COUNT: string;

  STRING_INDEX_BASED_ON_UNKNOWN_FIELD: string;
  STRING_INDEX_BASED_ON_INVALID_FIELD: string;
  STRING_INVALID_INDEX_TYPE: string;
  STRING_CANNOT_OPEN_INDEX: string;
  STRING_TOO_MANY_INDEXES: string;
  STRING_INDEX_NOT_EXIST: string;
  STRING_NEED_EXCLUSIVE_ACCESS: string;

implementation

initialization

  STRING_FILE_NOT_FOUND               := 'Apertura: file non trovato: "%s"';
  STRING_VERSION                      := 'TDbf V%d.%d';

  STRING_RECORD_LOCKED                := 'Record gi� in uso.';

  STRING_INVALID_DBF_FILE             := 'File DBF non valido.';
  STRING_FIELD_TOO_LONG               := 'Valore troppo elevato: %d caratteri (esso non pu� essere pi� di %d).';
  STRING_INVALID_FIELD_COUNT          := 'Campo non valido (count): %d (deve essere tra 1 e 4095).';

  STRING_INDEX_BASED_ON_UNKNOWN_FIELD := 'Indice basato su un campo sconosciuto "%s"';
  STRING_INDEX_BASED_ON_INVALID_FIELD := 'Campo "%s" � di tipo non valido per un indice';
  STRING_INVALID_INDEX_TYPE           := 'Tipo indice non valido: Pu� essere solo string o float';
  STRING_CANNOT_OPEN_INDEX            := 'Non � possibile aprire indice : "%s"';
  STRING_TOO_MANY_INDEXES             := 'Non � possibile creare indice: Troppi indici aperti.';
  STRING_INDEX_NOT_EXIST              := 'Indice "%s" non esiste.';
  STRING_NEED_EXCLUSIVE_ACCESS        := 'L''Accesso in esclusiva � richiesto per questa operazione.';
end.
