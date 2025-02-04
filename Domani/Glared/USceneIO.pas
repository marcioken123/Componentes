//	Additional Scene Loading/Saving stuff
//	by Mrqzzz

unit USceneIO;

interface

Uses
    Classes,SysUtils,GLWin32Viewer, GLScene, GLObjects,GLVectorFileObjects,GLTexture,Dialogs,Controls,ApplicationFileIO;

procedure LoadScene(FileName: string; TheScene: TGLSCene; SceneViewers : array of TGLSCeneViewer);
procedure SaveScene(FileName: string; TheScene: TGLSCene);
procedure FreeAllChildren(O: TGLBaseSCeneObject);
procedure LoadFreeFormFilesFromHint(O: TGLBaseSCeneObject;FilesPath : string; DoBuildOctree : boolean; DoLoadTRMFile : boolean);

procedure TGLMaterialLibrary_SaveToStream(MatLib : TGLMaterialLibrary; aStream : TStream);
procedure TGLMaterialLibrary_LoadFromStream(MatLib : TGLMaterialLibrary; aStream : TStream);
procedure TGLMaterialLibrary_SaveToFile(MatLib : TGLMaterialLibrary; const fileName : String);
procedure TGLMaterialLibrary_LoadFromFile(MatLib : TGLMaterialLibrary; const fileName : String);

procedure LoadTRMFile(SelectedFreeForm : TGLFreeForm; FilesPath : string; OptionalFileName : string); // MESHES+TRIANGLECOUNT+MATERIAL INFO FILE
procedure SaveTRMFile(SelectedFreeForm : TGLFreeForm; OptionalFileName : string); // MESHES+TRIANGLECOUNT+MATERIAL INFO FILE

function stringAfter(mainst,sep: string): string;

implementation


function stringAfter(mainst,sep: string): string;
begin
     Result := copy(mainst,pos(sep,mainst)+length(sep),length(mainst));
end;

procedure SaveTRMFile(SelectedFreeForm : TGLFreeForm; OptionalFileName : string);
var
   t,u: integer;
   stl: TStringList;
   fname: string;
begin
     stl := TStringList.create;
     for t := 0 to SelectedFreeForm.MeshObjects.Count-1 do
     begin
          stl.Add('MESH:'+SelectedFreeForm.MeshObjects[t].Name);
          for u := 0 to SelectedFreeForm.MeshObjects[t].FaceGroups.Count-1 do
          begin
               stl.Add('TRIAN:'+inttostr(SelectedFreeForm.MeshObjects[t].FaceGroups[u].TriangleCount));
               stl.Add('MATER:'+SelectedFreeForm.MeshObjects[t].FaceGroups[u].MaterialName);
          end;
     end;
     if OptionalFileName='' then
        fname := ChangeFileExt(SelectedFreeForm.Hint,'.TRM')
     else
         fname := OptionalFileName;
     Stl.SaveToFile(fname);
     stl.free;
end;



procedure LoadTRMFile(SelectedFreeForm : TGLFreeForm; FilesPath : string; OptionalFileName : string);
var
   t,u,i: integer;
   st: string;
   stl: TStringList;
   fname: string;
   cnt : integer;
   TriTot,TriIdx: integer;
   MatName : string;
begin
     if OptionalFileName='' then
        fname := ChangeFileExt(SelectedFreeForm.Hint,'.TRM')
     else
         fname := OptionalFileName;

     if FilesPath<>'' then
        fname := FilesPath + ExtractFileName(fname);

     if FileExists(fname) then
     begin
          cnt :=0;
          stl := TStringList.create;
          stl.LoadFromFile(fname);
          TriTot :=0;
          TriIdx :=0;
          try
             // First, try loading the TRM using MESH names (this allows using the same .TRM file for modified .3DS file)
             if (SelectedFreeForm.MeshObjects[0].Name<>'') and (stl.IndexOf('MESH:'+SelectedFreeForm.MeshObjects[0].Name)>-1) then
             begin
                  for t := 0 to SelectedFreeForm.MeshObjects.Count-1 do
                  begin
                       i := stl.IndexOf('MESH:'+SelectedFreeForm.MeshObjects[t].Name);
                       if i >-1 then
                       begin
                            cnt := 2;
                            for u := 0 to SelectedFreeForm.MeshObjects[t].FaceGroups.Count-1 do
                            begin
                                 st := stl[i+cnt];
                                 if pos('MATER:',st)=1 then
                                 begin
                                      SelectedFreeForm.MeshObjects[t].FaceGroups[u].MaterialName := stringAfter(st,':');
                                 end
                                 else
                                     break;
                                 inc(cnt,2);
                                 if i+cnt > stl.count-1 then
                                    break;
                            end;
                       end;
                  end
             end
             else
             // else use triangles count
             begin
                  cnt :=1;
                  for t := 0 to SelectedFreeForm.MeshObjects.Count-1 do
                  begin
                       for u := 0 to SelectedFreeForm.MeshObjects[t].FaceGroups.Count-1 do
                       begin
                            if cnt<stl.Count then
                            begin
                                 while (TriIdx>=TriTot) or (TriTot=0) do
                                 begin
                                      // ignore the "MESH:" line
                                      if pos('MESH:',stl[cnt])=1 then
                                         inc(cnt);

                                      TriTot := StrToInt(stringAfter(stl[cnt],':'));
                                      MatName := stringAfter(stl[cnt+1],':');

                                      inc(cnt,2);
                                      if cnt>stl.Count-1 then
                                         break;


                                      if cnt>0 then
                                         if pos('TRIAN:',stl[cnt-1])=1 then
                                            dec(cnt); // another facegroup

                                      TriIdx :=0;
                                 end;
                            end;

                            SelectedFreeForm.MeshObjects[t].FaceGroups[u].MaterialName := MatName;
                            inc(TriIdx,SelectedFreeForm.MeshObjects[t].FaceGroups[u].TriangleCount);
                       end;
                  end;
             end;
          finally
                 stl.free;
                 SelectedFreeForm.StructureChanged;
          end;
     end
     else
     begin
          ShowMessage('File does not exist : '+fname);
     end;
end;



procedure LoadFreeFormFilesFromHint(O: TGLBaseSCeneObject;FilesPath : string; DoBuildOctree : boolean; DoLoadTRMFile : boolean);
var
   t: integer;
   st: string;
   OldPath : string;
begin
     for t := O.Count-1 downto 0 do
     begin
          LoadFreeFormFilesFromHint(o[t],FilesPath,DoBuildOctree,DoLoadTRMFile);
          if o[t] is TGLFreeForm then
          begin
               if TGLFreeForm(o[t]).Hint<>'' then
               begin
                    st := TGLFreeForm(o[t]).Hint;
                    if FilesPath<>'' then
                       st := FilesPath + ExtractFilename(St);
                    OldPath := GetCurrentDir;
                    SetCurrentDir(ExtractFilePath(st));
                    try
                       TGLFreeForm(o[t]).LoadFromFile(st);

                       // Load TRM file For OCT files
                       if (Uppercase(ExtractFileExt(st))='.OCT') and (DoLoadTRMFile) then
                       begin
                            LoadTRMFile(TGLFreeForm(o[t]),FilesPath,'');
                       end;
                    except
                          on E: Exception do
                          begin
                               if MessageDlg('Error loading FreeForm File.'+#13+'Error:'+E.Message,mtError,mbAbortIgnore,0) = mrAbort then
                               SetCurrentDir(OldPath);
                               Abort;
                          end;
                    end;
                    if DoBuildOctree then
                       TGLFreeForm(o[t]).BuildOctree;
               end;
          end;
     end;
end;


procedure FreeAllChildren(O: TGLBaseSCeneObject);
var
   t: integer;
   ob : TGLBaseSCeneObject;
begin
     for t := O.Count-1 downto 0 do
     begin
          FreeAllChildren(o[t]);
          ob := o[t];
          O.Remove(ob,False);
          ob.Free;
     end;
end;



procedure SaveScene(FileName: string; TheScene: TGLSCene);
begin
     TheScene.SaveToFile(FileName);
end;


procedure LoadScene(FileName: string; TheScene: TGLSCene; SceneViewers : array of TGLSCeneViewer);
var
   t: integer;
   CameraNames : Array of String;
begin
     // Store Viewer's Cameras Names and Disable Viewers
     SetLength(CameraNames,high(SceneViewers)+1);
     for t := low(SceneViewers) to high(SceneViewers) do
     begin
          CameraNames[t] := SceneViewers[t].Camera.Name;
          SceneViewers[t].Camera := nil;
     end;


     // Destroy Cameras
     for t := TheScene.Cameras.Count-1 downto 0 do
     begin
          FreeAllChildren(TheScene.Cameras);
     end;

     // Destroy Objects
     for t := TheScene.Objects.Count-1 downto 0 do
     begin
          FreeAllChildren(TheScene.Objects);
     end;

     TheScene.LoadFromFile(FileName);


     // Restore the cameras to the viewers if they exist in the new scene (if they have the old name)
     for t := low(SceneViewers) to high(SceneViewers) do
     begin
          SceneViewers[t].Camera := TGLCamera(TheScene.FindSceneObject(CameraNames[t]));
     end;
end;




// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// MRQZZZ
// FIX for GLScene v. > 0.910 : The TGLMaterialLibrary.SaveToStream / LoadFromStream
// Are being modified to use a "WriteToFiler" procedure.
// This "WriteToFiler" is not ready yet and causes incomplete MaterialLibrary storage.
// So here i write the good old working SaveTo.. stuff.
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

procedure TGLMaterialLibrary_SaveToStream(MatLib : TGLMaterialLibrary; aStream : TStream);
var
   wr : TWriter;
begin
   wr:=TWriter.Create(aStream, 16384);
   try
      wr.WriteComponent(MatLib);
   finally
      wr.Free;
   end;
end;

// LoadFromStream
//
procedure TGLMaterialLibrary_LoadFromStream(MatLib : TGLMaterialLibrary; aStream : TStream);
var
   rd : TReader;
begin
   rd:=TReader.Create(aStream, 16384);
   try
      rd.BeginReferences;      // creates the loaded and fixup lists
      rd.ReadComponent(MatLib);
      rd.FixupReferences;
      rd.EndReferences;        // frees fixups and both lists
   finally
      rd.Free;
   end;
end;

// SaveToFile
//
procedure TGLMaterialLibrary_SaveToFile(MatLib : TGLMaterialLibrary; const fileName : String);
var
   fs : TStream;
begin
   fs:=CreateFileStream(fileName, fmCreate);
   try
      TGLMaterialLibrary_SaveToStream(MatLib,fs);
   finally
      fs.Free;
   end;
end;

// LoadFromFile
//
procedure TGLMaterialLibrary_LoadFromFile(MatLib : TGLMaterialLibrary; const fileName : String);
var
   fs : TStream;
begin
   fs:=CreateFileStream(fileName, fmOpenRead+fmShareDenyNone);
   try
      TGLMaterialLibrary_LoadFromStream(MatLib,fs);
   finally
      fs.Free;
   end;
end;

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------




end.
