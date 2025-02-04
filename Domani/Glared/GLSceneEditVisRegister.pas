unit GLSceneEditVisRegister;

interface
{$i GLScene.inc}
uses Windows, Forms,GLScene, GLTexture, Controls, Classes,Dialogs,UsceneIO;

procedure Register;

implementation

Uses
    GLSceneEdit,GLSceneEditVis,
{$ifdef GLS_DELPHI_6_UP}
   DesignIntf, DesignEditors, VCLEditors
{$else}
   DsgnIntf
{$endif};


type
   // TGLSceneEditorFormVis
   //
   TGLSceneEditorFormVisEditor = class(TComponentEditor)
      public
            { Public Declarations }
            procedure ExecuteVerb(Index: Integer); override;
            function GetVerb(Index: Integer): String; override;
            function GetVerbCount: Integer; override;
      end;

   TGLMaterialLibraryEditor = class(TComponentEditor)
      public
            { Public Declarations }
            procedure ExecuteVerb(Index: Integer); override;
            function GetVerb(Index: Integer): String; override;
            function GetVerbCount: Integer; override;
      end;



//----------------- TGLAredEditor ---------------------------------------

// ExecuteVerb
//
procedure TGLSceneEditorFormVisEditor.ExecuteVerb(Index : Integer);
var
   source : TGLScene;
begin
   source:=Component as TGLScene;
   case Index of
             0 : begin
                      with GLSceneEditorForm do begin
                         SetScene(source, Self.Designer);
                         Show;
                      end;
                 end;

             1 : begin
                      with GLSceneEditorFormVis do begin
                         SetScene(source, Self.Designer);
                         Show;
                      end;
                 end;
   end;
end;

// GetVerb
//
function TGLSceneEditorFormVisEditor.GetVerb(Index : Integer) : String;
begin
   case Index of
      0 : Result:='Edit';
      1 : Result:='Glared Express';
   end;
end;

// GetVerbCount
//
function TGLSceneEditorFormVisEditor.GetVerbCount: Integer;
begin
   Result:=2;
end;

//------------------------------------------------------------------------

procedure Register;
begin
   RegisterComponentEditor(TGLScene, TGLSceneEditorFormVisEditor);
   RegisterComponentEditor(TGLMaterialLibrary, TGLMaterialLibraryEditor);
end;





{ TGLMaterialLibraryEditor }


procedure TGLMaterialLibraryEditor.ExecuteVerb(Index: Integer);
var
   OpenD: TOpenDialog;
   SaveD: TSaveDialog;
   source : TGLMaterialLibrary;
   st: string;
begin
   source:=Component as TGLMaterialLibrary;
   case Index of
             0 : begin
                      OpenD := TOpenDialog.Create(Application);
                      try
                         OpenD.Filter := '*.ml|*.ml';
                         if OpenD.Execute then
                         begin
                              st := source.name;
                              TGLMaterialLibrary_LoadFromFile(source,OpenD.FileName);
                              source.Name := st;
                         end;
                      finally
                             OpenD.Free;
                      end;
                 end;

             1 : begin
                      SaveD := TSaveDialog.Create(Application);
                      try
                         SaveD.Filter := '*.ml|*.ml';
                         if SaveD.Execute then
                         begin
                              st := source.name;
                              source.Name := '';
                              TGLMaterialLibrary_SaveToFIle(source,SaveD.FileName);
                              source.Name := st;
                         end;
                      finally
                             SaveD.Free;
                      end;
                 end;
   end;
end;

function TGLMaterialLibraryEditor.GetVerb(Index: Integer): String;
begin
   case Index of
      0 : Result:='Load From File...';
      1 : Result:='Save To File...';
   end;
end;

function TGLMaterialLibraryEditor.GetVerbCount: Integer;
begin
   Result:=2;
end;





















end.
