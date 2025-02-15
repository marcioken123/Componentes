//
// This unit is part of the GLScene Project, http://glscene.org
//
{: GLFileOBJ<p>

    Support-Code to load Wavefront OBJ Files into TGLFreeForm-Components
    in GLScene.<p>
    Note that you must manually add this unit to one of your project's uses
    to enable support for OBJ & OBJF at run-time.<p>

	<b>History : </b><font size=-1><ul>
      <li>09/09/03 - Jaj - Added TriangleStrip and TriangleFan support to save..
      <li>10/07/03 - Egg - Improved robustness of material loading
      <li>02/06/03 - Egg - Undone Jaj changes, they broke standard OBJ support
      <li>30/01/03 - Egg - Normals extraction
      <li>29/01/03 - Jaj - Fixed to allow load of simple triangle meshes... ('V','VN','VT')
      <li>23/01/03 - Egg - Can now export TFGIndexTexCoordList (untextured)
      <li>25/11/02 - Egg - Improved mtl import (d and illum commands)
      <li>22/11/02 - Egg - Supports OBJ files using #9 in place of #32,
                           fixed leak, some code cleanup/rearrangements,
                           support for mtllib and usemtl commands
      <li>18/08/01 - Egg - '$' now allowed as alternate comment,
                           AddToTriangles override 
      <li>03/10/00 - Egg - Fixed TGLOBJVectorFile.LoadFromStream.ReadFace
      <li>08/10/00 - Egg - Added standard header, basic htmlification of old header,
                           removed specific trim funcs,
                           renamed TMBAGLOBJVectorFile to TGLOBJVectorFile
   </ul><p>

   (c) 2000 Marian Aldenh�vel<br>
       Hainstra�e 8<br>
       53121 Bonn<br>
       info@MBA-Software.de<p>

  License:<br>

    Contributed to Eric Grange and GLScene,
    same licensing, batteries not included.<p>

  History:<p>

    26.9.2000:  - OBJF-Support (t- and q-lines) see
                  http://www.cs.sunysb.edu/~stripe/<br>
    18.9.2000:  - Bugfixing.
                - SaveTo-Methods.<br>
    14.9.2000:  - Calculate normals where missing in the file.
                - Collect Facegroups by Name and do not start a new
      				  one for every 'g'-line in the file.
                - Relative indexing in 'f'-lines.<br>
    13.9.2000:  - Start of this project as an exercise to get familiar with<br>
                    a) the OBJ-Format and<br>
                    b) GLScene internals<br>
                  Midterm-goal: Import what Poser 4 exports and display it
                                correctly in an GLScene.<br>
}
unit GLFileObj;

{.$DEFINE STATS} { Define to display statistics after loading. }

interface

uses {$IFDEF STATS}Dialogs, {$ENDIF} Classes, SysUtils, GLScene, ApplicationFileIO,
     VectorGeometry, GLMisc, GLVectorFileObjects, VectorLists, GLTexture;

const
   BufSize = 10240; { Load input data in chunks of BufSize Bytes. }
   LineLen = 100;   { Allocate memory for the current line in chunks
                      of LineLen Bytes. }

type

   // TGLOBJVectorFile
   //
   TGLOBJVectorFile = class (TVectorFile)
      private
         FSourceStream : TStream;     { Load from this stream }
         FBuffer, FLine : String;     { Buffer and current line }
         FLineNo : Integer;           { current Line number - for error messages }
         FEof : Boolean;              { Stream done? }
         FBufPos : Integer;           { Position in the buffer }

      protected
         // Read a single line of text from the source stream, set FEof to true when done.
         procedure ReadLine;
         // Raise a class-specific exception
         procedure Error(const msg : String);

         procedure CalcMissingOBJNormals(mesh : TMeshObject);

      public
         class function Capabilities : TDataFileCapabilities; override;

         procedure LoadFromStream(aStream:TStream); override;
         procedure SaveToStream(aStream:TStream); override;
   end;

   // EGLOBJFileError
   //
   EGLOBJFileError = class (Exception)
      private
         FLineNo : Integer;

      public
         property LineNo : Integer read FLineNo;

   end;

   // TGLMTLFile
   //
   {: A simple class that know how to extract infos from a mtl file.<p>
      mtl files are companion files of the obj, they store material
      information. Guessed content (imported ones denoted with a '*',
      please help if you know more):<ul>
      <li>materials begin with a 'newmtl' command followed by material name
      <li>*Kd command defines the diffuse color
      <li>*map_Kd command defines the diffuse texture image
      <li>*Ka/map_Ka define the ambient color and texmap
      <li>*Ks/map_Ks define the specular color and texmap
      <li>map_Bump specifies the bump map
      <li>*d specifies transparency (alpha-channel, range [0; 1])
      <li>map_d specifies the opcaity texture map
      <li>Ns defines the specular exponent or shininess or phong specular (?)
      <li>Ni is the refraction index (greater than 1)
      <li>*illum defines the illumination model (0 for no lighting, 1 for
           ambient and diffuse, 2 for full lighting)
      </ul> }
   TGLMTLFile = class (TStringList)
      public
         procedure Prepare;

         function MaterialStringProperty(const materialName, propertyName : String) : String;
         function MaterialVectorProperty(const materialName, propertyName : String;
                                         const defaultValue : TVector) : TVector;
   end;

// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------
implementation
// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------

uses OpenGL1x, MeshUtils, XOpenGL, GLUtils;

// StreamEOF
//
function StreamEOF(S : TStream) : Boolean;
begin
   { Is the stream at its end? }
   Result:=(S.Position>=S.Size);
end;

function Rest(const s:string;Count:integer):string;
{ Return the right part of s including s[Count]. }
begin
  Result:=copy(s,Count,Length(s)-Count+1);
end;

// NextToken
//
function NextToken(var s : String; delimiter : Char) : String;
{ Return the next Delimiter-delimited Token from the string s and
  remove it from s }
var
   p : Integer;
begin
   p:=Pos(Delimiter, s);
   if p=0 then begin
      Result:=s;
      s:='';
   end else begin
      Result:=copy(s, 1, p-1);
      s:=TrimLeft(Rest(s, p+1));
   end;
end;

{ ** TOBJFGVertexNormalTexIndexList ****************************************** }
{ - based on TFGVertexNormalTexIndexList (GLVectorFileObjects.pas)
  - adds support for polygons and for "missing" normals and
    texture-coordinates. Pass -1 to Add for the index of a missing object.
  - Polygons are defined by counting off the number of vertices added to the
    PolygonVertices-property. So a PolygonVertices-List of

      [3,4,6]

    says "Vertex indices 0,1 and 2 make up a triangle, 3,4,5 and 6 a quad and
    7,8,9,10,11 and 12 a hexagon".

}
type
   TOBJFGMode=(objfgmmPolygons,objfgmmTriangleStrip);

   TOBJFGVertexNormalTexIndexList = class (TFGVertexNormalTexIndexList)
       private
         FMode:TOBJFGMode;
         FName:string;
         FPolygonVertices:TIntegerList;
         FCurrentVertexCount:integer;
         FShowNormals:boolean;
         procedure PolygonComplete; { Current polygon completed. Adds FCurrentVertexCount
                                      to FPolygonVertices and sets the variable to 0 }

         procedure SetMode(aMode:TOBJFGMode);

       public
         constructor CreateOwned(aOwner : TFaceGroups); override;
         destructor Destroy; override;

         procedure Add(VertexIdx,NormalIdx,TexCoordIdx:Integer);
         procedure BuildList(var mrci : TRenderContextInfo); override;
         procedure AddToTriangles(aList : TAffineVectorList;
                                  aTexCoords : TAffineVectorList = nil;
                                  aNormals : TAffineVectorList = nil); override;
         function TriangleCount : Integer; override;

         property Mode:TOBJFGMode read FMode write SetMode;
         property Name:string read FName write FName;
         property PolygonVertices:TIntegerList read FPolygonVertices;
         property ShowNormals:boolean read FShowNormals write FShowNormals;
       end;

constructor TOBJFGVertexNormalTexIndexList.CreateOwned(aOwner:TFaceGroups);
begin
  inherited CreateOwned(aOwner);
  FMode:=objfgmmTriangleStrip;
  //FShowNormals:=True;
end;

destructor TOBJFGVertexNormalTexIndexList.Destroy;
begin
  FPolygonVertices.Free;
  inherited Destroy;
end;

procedure TOBJFGVertexNormalTexIndexList.Add(VertexIdx,NormalIdx,TexCoordIdx:Integer);
begin
  inherited Add(VertexIdx,NormalIdx,TexCoordIdx);
  inc(FCurrentVertexCount);
end;

procedure TOBJFGVertexNormalTexIndexList.PolygonComplete;
begin
  Assert(FMode=objfgmmPolygons,'PolygonComplete may only be called for Facegroups with Mode=objfgmmPolygons.');
  FPolygonVertices.Add(FCurrentVertexCount);
  FCurrentVertexCount:=0;
end;

procedure TOBJFGVertexNormalTexIndexList.SetMode(aMode:TOBJFGMode);
begin
  if aMode=FMode then exit;
  Assert(VertexIndices.Count=0,'Decide on the mode before adding vertices.');
  FMode:=aMode;
  if FMode=objfgmmPolygons
    then FPolygonVertices:=TIntegerList.Create
    else
      begin
        FPolygonVertices.Free;
        FPolygonVertices:=NIL;
      end;
end;

procedure TOBJFGVertexNormalTexIndexList.BuildList(var mrci : TRenderContextInfo);
var
   VertexPool:PAffineVectorArray;
   NormalPool:PAffineVectorArray;
   TexCoordPool:PAffineVectorArray;

  procedure BuildPolygons;
  var Polygon,Index,j,idx:Integer;
      N:TAffineVector;
  begin
    { Build it. Ignoring texture-coordinates and normals that are missing. }
    Index:=0; { Current index into the Index-Lists. }
    { For every Polygon }
    for Polygon:=0 to FPolygonVertices.Count-1 do
      begin
        glBegin(GL_POLYGON);
        try
          { For every Vertex in the current Polygon }
          for j:=0 to FPolygonVertices[Polygon]-1 do begin
              idx:=NormalIndices.List[Index];
              if idx>=0 then glNormal3fv(@NormalPool[idx]);

              if Assigned(TexCoordPool) then begin
                 idx:=TexCoordIndices.List[Index];
                 if idx>=0 then glTexCoord2fv(@TexCoordPool[idx]);
              end;

              glVertex3fv(@VertexPool[VertexIndices.List[Index]]);
              Inc(Index);
          end;
        finally
          glEnd;
        end;
      end;

    { Visible normals, rather moronic and mainly for debugging. }
    if FShowNormals then
      begin
        Index:=0;
        for Polygon:=0 to FPolygonVertices.Count-1 do
          begin
            { For every Vertex in the current Polygon }
            for j:=0 to FPolygonVertices[Polygon]-1 do
              begin
                idx:=NormalIndices.List[Index];
                if idx<>-1 then
                  begin
                    glBegin(GL_LINES);
                    try
                      glVertex3fv(@VertexPool[VertexIndices.List[Index]]);
                      N:=VectorAdd(VertexPool[VertexIndices.List[Index]],VectorScale(NormalPool[idx],0.1));
                      glVertex3fv(@N);
                    finally
                      glEnd;
                    end;
                  end;
                inc(Index);
              end;
          end;
      end;
  end;

  procedure BuildTriangleStrip;
  (*
  begin
    Owner.Owner.DeclareArraysToOpenGL(False);
    glDrawElements(GL_TRIANGLE_STRIP,VertexIndices.Count,
                   GL_UNSIGNED_INT,VertexIndices.List);
  end;
  *)
  var Index,idx:Integer;
  begin
    { Build it. Ignoring texture-coordinates and normals that are missing. }
    glBegin(GL_TRIANGLE_STRIP);
    try
      for Index:=0 to VertexIndices.Count-1 do
        begin
          idx:=NormalIndices.List[Index];
          if idx<>-1 then glNormal3fv(@NormalPool[idx]);

          if Assigned(TexCoordPool) then begin
             idx:=TexCoordIndices.List[Index];
             if idx<>-1 then xglTexCoord2fv(@TexCoordPool[idx]);
          end;

          glVertex3fv(@VertexPool[VertexIndices.List[Index]]);
        end;
    finally
      glEnd;
    end;
  end;

begin
  Assert(    ((TexCoordIndices.Count=0) or (VertexIndices.Count<=TexCoordIndices.Count))
         and (VertexIndices.Count<=NormalIndices.Count),
         'Number of Vertices does not match number of Normals or Texture coordinates.');

  { Shorthand notations. }
  VertexPool:=Owner.Owner.Vertices.List;
  NormalPool:=Owner.Owner.Normals.List;
  if TexCoordIndices.Count=0 then
     TexCoordPool:=nil
  else TexCoordPool:=Owner.Owner.TexCoords.List;

  case FMode of
    objfgmmPolygons :      BuildPolygons;
    objfgmmTriangleStrip : BuildTriangleStrip;
  end;
end;

// AddToTriangles
//
procedure TOBJFGVertexNormalTexIndexList.AddToTriangles(aList : TAffineVectorList;
                                                        aTexCoords : TAffineVectorList = nil;
                                                        aNormals : TAffineVectorList = nil);
var
   i, j, n, n0 : Integer;
   vertexList, texCoordList, normalsList : TAffineVectorList;
begin
   vertexList:=Owner.Owner.Vertices;
   texCoordList:=Owner.Owner.TexCoords;
   normalsList:=Owner.Owner.Normals;
   case FMode of
      objfgmmPolygons : begin
         n:=0;
         for i:=0 to FPolygonVertices.Count-1 do begin
            n0:=n;
            for j:=0 to FPolygonVertices[i]-1 do begin
               if j>1 then begin
                  aList.Add(vertexList[VertexIndices[n0]],
                            vertexList[VertexIndices[n-1]],
                            vertexList[VertexIndices[n]]);
                  if Assigned(aTexCoords) then begin
                     if texCoordList.Count>0 then
                        aTexCoords.Add(texCoordList[VertexIndices[n0]],
                                       texCoordList[VertexIndices[n-1]],
                                       texCoordList[VertexIndices[n]])
                     else aTexCoords.AddNulls(3);
                  end;
                  if Assigned(aNormals) then begin
                     if normalsList.Count>0 then
                        aNormals.Add(normalsList[VertexIndices[n0]],
                                     normalsList[VertexIndices[n-1]],
                                     normalsList[VertexIndices[n]])
                     else aNormals.AddNulls(3);
                  end;
               end;
               Inc(n);
            end;
         end;
      end;
      objfgmmTriangleStrip : begin
         ConvertStripToList(vertexList, VertexIndices, aList);
         n:=(VertexIndices.Count-2)*3;
         if Assigned(aTexCoords) then begin
            if texCoordList.Count>0 then
               ConvertStripToList(texCoordList, VertexIndices, aTexCoords)
            else aTexCoords.AddNulls(n);
         end;
         if Assigned(aNormals) then begin
            if normalsList.Count>0 then
               ConvertStripToList(normalsList, VertexIndices, aNormals)
            else aNormals.AddNulls(n);
         end;
      end;
   else
      Assert(False);
   end;
end;

// TriangleCount
//
function TOBJFGVertexNormalTexIndexList.TriangleCount : Integer;
var
   i : Integer;
begin
   case FMode of
      objfgmmPolygons : begin
         Result:=0;
         for i:=0 to FPolygonVertices.Count-1 do begin
            Result:=Result+FPolygonVertices[i]-2;
         end;
      end;
      objfgmmTriangleStrip : begin
         Result:=VertexIndices.Count-2;
         if Result<0 then Result:=0;
      end;
   else
      Result:=0;
      Assert(False);
   end;
end;

// ------------------
// ------------------ TGLOBJVectorFile ------------------
// ------------------

// ReadLine
//
procedure TGLOBJVectorFile.ReadLine;
var
   j : Integer;

   procedure FillBuffer;
   var
      l : Integer;
   begin
      l:=FSourceStream.Size-FSourceStream.Position;
      if l>BufSize then
         l:=BufSize;
      SetLength(FBuffer, l);
      FSourceStream.Read(FBuffer[1], l);
      FBufPos:=1;
   end;

begin
   Inc(FLineNo);

   if FBufPos<1 then FillBuffer;

   j:=1;
   while True do begin
      if FBufPos>Length(FBuffer) then begin
         if StreamEof(FSourceStream) then begin
            FEof:=True;
            break;
         end else FillBuffer
      end else begin
         case FBuffer[FBufPos] of
            #10, #13 : begin
               Inc(FBufPos);
               if FBufPos>Length(FBuffer) then
                  if StreamEof(FSourceStream) then
                     break
                  else FillBuffer;
               if (FBuffer[FBufPos]=#10) or (FBuffer[FBufPos]=#13) then
                  Inc(FBufPos);
               break;
            end;
         else
            if j>Length(FLine) then
               SetLength(FLine, Length(FLine)+LineLen);
            if FBuffer[FBufPos]=#9 then
               FLine[j]:=#32
            else FLine[j]:=FBuffer[FBufPos];
            Inc(FBufPos);
            Inc(j);
         end;
      end;
   end;

   SetLength(FLine,j-1);
end;

// Error
//
procedure TGLOBJVectorFile.Error(const msg : String);
var
   E : EGLOBJFileError;
begin
   E:=EGLOBJFileError.Create(Msg);
   E.FLineNo:=FLineNo;
   raise E;
end;

// Capabilities
//
class function TGLOBJVectorFile.Capabilities : TDataFileCapabilities;
begin
   Result:=[dfcRead, dfcWrite];
end;
                   
// CalcMissingOBJNormals
//
procedure TGLOBJVectorFile.CalcMissingOBJNormals(mesh : TMeshObject);
var
   vertexPool : PAffineVectorArray;
   n : TAffineVector;
   p : array [1..3] of PAffineVector;
   face, index : Integer;
   fg : TOBJFGVertexNormalTexIndexList;

   procedure DoCalcNormal;
   var
      idx : Integer;
   begin
      idx:=TOBJFGVertexNormalTexIndexList(Mesh.FaceGroups[Face]).NormalIndices.List[Index];
      if idx<0 then begin
         n:=CalcPlaneNormal(p[1]^, p[2]^, p[3]^);
         idx:=Mesh.Normals.Add(n);
         TOBJFGVertexNormalTexIndexList(Mesh.FaceGroups[Face]).NormalIndices.List[Index]:=idx;
      end;
   end;

   procedure CalcForPolygons;
   var
      polygon, firstVertexIndex, j : Integer;
   begin
      with FG do begin
         { Walk the polygons and calculate normals for those vertices that
           are missing. }
         Index:=0; { Current index into the Index-List of this Facegroup. }

         { For every Polygon }
         for Polygon:=0 to FPolygonVertices.Count-1 do begin
            { Init }
            FirstVertexIndex:=Index;
            FillChar(p,SizeOf(p),0);
            { Last Vertex in this polygon }
            p[2]:=@VertexPool[VertexIndices.List[Index+FPolygonVertices[Polygon]-1]];
            { First Vertex in this polygon }
            p[3]:=@VertexPool[VertexIndices.List[Index]];
            { For every Vertex in the current Polygon but the last. }
            for j:=0 to FPolygonVertices[Polygon]-2 do begin
               Move(p[2],p[1],2*SizeOf(PAffineVector));
               p[3]:=@VertexPool[VertexIndices.List[Index+1]];
               DoCalcNormal;
               Inc(Index);
            end;

            { For the last vertex use the first as partner to span the plane. }
            Move(p[2],p[1],2*SizeOf(PAffineVector));
            p[3]:=@VertexPool[VertexIndices.List[FirstVertexIndex]];
            DoCalcNormal;
            inc(Index);
         end; { of for FPolygonVertices }
      end; { of with Facegroup }
   end;

   procedure CalcForTriangleStrip;
   begin
   end;

begin
   { Shorthand notations. }
   VertexPool:=Mesh.Vertices.List;

   for Face:=0 to Mesh.FaceGroups.Count-1 do begin
      FG:=TOBJFGVertexNormalTexIndexList(Mesh.FaceGroups[Face]);
      case FG.Mode of
         objfgmmPolygons :      CalcForPolygons;
         objfgmmTriangleStrip : CalcForTriangleStrip;
      end;
   end;
end;

// LoadFromStream
//
procedure TGLOBJVectorFile.LoadFromStream(aStream:TStream);
var
   hv : THomogeneousVector;
   av : TAffineVector;
   mesh : TMeshObject;
   faceGroup : TOBJFGVertexNormalTexIndexList;
   faceGroupNames : TStringList;

   procedure ReadHomogeneousVector;
   { Read a vector with a maximum of 4 elements from the current line. }
   var
      i, c : Integer;
      f : String;
   begin
      FillChar(hv, SizeOf(hv), 0);
      i:=0;
      while (FLine<>'') and (i<4) do begin
         f:=NextToken(FLine, ' ');
         Val(f, hv[i], c);
         if c<>0 then
            Error(Format('''%s'' is not a valid floating-point constant.', [f]));
         Inc(i);
      end;
   end;

   procedure ReadAffineVector;
   { Read a vector with a maximum of 3 elements from the current line. }
   var
      i, c : integer;
      f : String;
   begin
      FillChar(av,SizeOf(av),0);
      i:=0;
      while (FLine<>'') and (i<3) do begin
         f:=NextToken(FLine, ' ');
         Val(f, av[i], c);
         if c<>0 then
            Error(Format('''%s'' is not a valid floating-point constant.',[f]));
         inc(i);
      end;
   end;

   procedure SetCurrentFaceGroup(aName : String; const matlName : String);
   var
      i : Integer;
   begin
      i:=faceGroupNames.IndexOf(aName);
      if i>=0 then begin
         faceGroup:=TOBJFGVertexNormalTexIndexList(faceGroupNames.Objects[i]);
         if faceGroup.MaterialName<>matlName then begin
            aName:=aName+'-'+matlName;
            i:=faceGroupNames.IndexOf(aName);
            if i>=0 then begin
               faceGroup:=TOBJFGVertexNormalTexIndexList(faceGroupNames.Objects[i]);
               if faceGroup.MaterialName<>matlName then
                  faceGroup:=nil;
            end;
         end;
      end;

      if (faceGroup=nil) or (faceGroup.Name<>aName)
            or (faceGroup.PolygonVertices.Count>0)
            or (faceGroup.MaterialName<>matlName) then begin
         faceGroup:=TOBJFGVertexNormalTexIndexList.CreateOwned(Mesh.FaceGroups);
         faceGroup.FName:=aName;
         faceGroup.Mode:=objfgmmPolygons;
         faceGroup.MaterialName:=matlName;
         faceGroupNames.AddObject(aName, faceGroup);
      end;
   end;

   procedure AddFaceVertex(faceVertices : String);
   var
      s : String;
      vIdx, tIdx, nIdx : Integer;

      function GetIndex(Count : Integer) : Integer;
      begin
         s:=NextToken(FaceVertices, '/');
         Result:=StrToIntDef(s, 0);
         if Result=0 then
            Result:=-1 // Missing
         else if Result<0 then begin
            { Relative, make absolute. "-1" means last, "-2" second last. }
            Result:=Count+Result
         end else begin
            { Absolute, correct for zero-base. }
            Dec(Result);
         end;
      end;

   begin
      vIdx:=GetIndex(mesh.Vertices.Count);
      tIdx:=GetIndex(mesh.TexCoords.Count);
      nIdx:=GetIndex(mesh.Normals.Count);

      faceGroup.Add(vIdx, nIdx, tIdx);
   end;

   procedure ReadFace(const curMtlName : String);
   var
      faceVertices : String;
   begin
      if FLine<>'' then begin
         if not Assigned(FaceGroup) then
            SetCurrentFaceGroup('', curMtlName);
         try
            while FLine<>'' do begin
               faceVertices:=NextToken(FLine, ' ');
               AddFaceVertex(faceVertices);
            end;
         finally
            FaceGroup.PolygonComplete;
         end;
      end;
   end;

   procedure ReadTriangleStripContinued;
   var
      faceVertices : String;
   begin
      if faceGroup=nil then
         Error('q-line without preceding t-line.');
      while FLine<>'' do begin
         FaceVertices:=NextToken(FLine, ' ');
         AddFaceVertex(FaceVertices);
      end;
   end;

   procedure ReadTriangleStrip;
   begin
      { Start a new Facegroup, mode=triangle strip }
      faceGroup:=TOBJFGVertexNormalTexIndexList.CreateOwned(Mesh.FaceGroups);
      faceGroup.Mode:=objfgmmTriangleStrip;
      { The rest is the same as for continuation of a strip. }
      ReadTriangleStripContinued;
   end;

   function GetOrAllocateMaterial(const libName, matName : String) : String;
   var
      fs : TStream;
      objMtl : TGLMTLFile;
      matLib : TGLMaterialLibrary;
      libMat : TGLLibMaterial;
      texName : String;
   begin
      if GetOwner is TGLBaseMesh then begin
         // got a linked material library?
         matLib:=TGLBaseMesh(GetOwner).MaterialLibrary;
         if Assigned(matLib) then begin
            Result:=matName;
            libMat:=matLib.Materials.GetLibMaterialByName(matName);
            if not Assigned(libMat) then begin
               // spawn a new material
               libMat:=matLib.Materials.Add;
               libMat.Name:=matName;
               try
                  fs:=CreateFileStream(libName);
               except
                  fs:=nil;
               end;
               if Assigned(fs) then begin
                  objMtl:=TGLMTLFile.Create;
                  try
                     objMtl.LoadFromStream(fs);
                     objMtl.Prepare;
                     // setup material colors
                     with libMat.Material.FrontProperties do begin
                        Ambient.Color:=objMtl.MaterialVectorProperty(matName, 'Ka', clrGray20);
                        Diffuse.Color:=objMtl.MaterialVectorProperty(matName, 'Kd', clrGray80);
                        Diffuse.Alpha:=StrToFloatDef(objMtl.MaterialStringProperty(matName, 'd'), 1);
                        if Diffuse.Alpha<1 then
                           libMat.Material.BlendingMode:=bmTransparency;
                        case StrToIntDef(objMtl.MaterialStringProperty(matName, 'illum'), 1) of
                           0 : begin // non-lit material
                              libMat.Material.MaterialOptions:=[moNoLighting];
                           end;
                           1 : ; // flat, non-shiny material
                           2 : begin // specular material
                              Specular.Color:=objMtl.MaterialVectorProperty(matName, 'Ks', clrTransparent);
                           end;
                        else
                           // unknown, assume unlit
                           libMat.Material.MaterialOptions:=[moNoLighting];
                           Diffuse.Color:=clrGray80;
                        end;
                        Shininess:=StrToIntDef(objMtl.MaterialStringProperty(matName, 'Ns'), 1);
                     end;
                     // setup texture
                     texName:=objMtl.MaterialStringProperty(matName, 'map_Kd');
                     if texName<>'' then begin
                        try
                           with libMat.Material.Texture do begin
                              Image.LoadFromFile(texName);
                              Disabled:=False;
                              TextureMode:=tmModulate;
                           end;
                        except
                           on E: ETexture do begin
                              if not Owner.IgnoreMissingTextures then
                                 raise;
                           end;
                        end;
                     end;
                  finally
                     objMtl.Free;
                     fs.Free;
                  end;
               end;
            end else Result:=matName;
         end else Result:='';
      end;
   end;

var
   command, objMtlFileName, curMtlName : String;
{$IFDEF STATS}
   t0, t1, t2 : Integer;
{$ENDIF}
begin
   {$IFDEF STATS}
   t0:=GetTickCount;
   {$ENDIF}

   FEof:=False;
   FSourceStream:=aStream;
   FLineNo:=0;
   objMtlFileName:='';
   curMtlName:='';

   mesh:=TMeshObject.CreateOwned(Owner.MeshObjects);
   mesh.Mode:=momFaceGroups;

   faceGroupNames:=TStringList.Create;
   faceGroupNames.Duplicates:=dupAccept;
   faceGroupNames.Sorted:=True;
   try

      faceGroup:=nil;

      while not FEof do begin
         ReadLine;
         if FLine='' then
            Continue; { Skip blank line }
         if FLine[1] in ['#', '$'] then
            Continue; { Skip comment and alternate comment }

         command:=AnsiUpperCase(NextToken(FLine, ' '));

         if command='V' then begin
            ReadHomogeneousVector;
            Mesh.Vertices.Add(hv[0], hv[1], hv[2]);
         end else if command='VT' then begin
            ReadAffineVector;
            Mesh.TexCoords.Add(av[0], av[1], 0);
         end else if command='VN' then begin
            ReadAffineVector;
            Mesh.Normals.Add(av[0], av[1], av[2]);
         end else if command='VP' then begin
            { Parameter Space Vertex: Ignore }
         end else if command='G' then begin
            { Only the first name on the line, multiple groups not supported. }
            SetCurrentFaceGroup(NextToken(FLine, ' '), curMtlName);
         end else if command='F' then begin
            ReadFace(curMtlName);
         end else if command='O' then begin
            { Object Name:  Ignore }
         end else if command='MTLLIB' then begin
            objMtlFileName:=NextToken(FLine, ' ');
         end else if command='USEMTL' then begin
            curMtlName:=GetOrAllocateMaterial(objMtlFileName, NextToken(FLine, ' '));
            if faceGroup=nil then
               SetCurrentFaceGroup('', curMtlName)
            else SetCurrentFaceGroup(faceGroup.FName, curMtlName);
         end else if command='S' then begin
            { Smooth Group: Ignore }
         end else if command='T' then begin
            ReadTriangleStrip;
         end else if command='Q' then begin
            ReadTriangleStripContinued;
         end else Error('Unsupported Command '''+command+'''');
      end;

      mesh.FaceGroups.SortByMaterial;

      {$IFDEF STATS}
      t1:=GetTickCount;
      {$ENDIF}

      CalcMissingOBJNormals(mesh);

      {$IFDEF STATS}
      t2:=GetTickCount;
      ShowMessage(Format('TGLOBJVectorFile Loaded in %dms'#13+
                         #13+
                         '    %dms spent reading'#13+
                         '    %dms spent calculating normals'#13+
                         '    %d Geometric Vertices'#13+
                         '    %d Texture Vertices'#13+
                         '    %d Normals'#13+
                         '    %d FaceGroups/Strips',
                         [t2-t0,
                          t1-t0,
                          t2-t1,
                          Mesh.Vertices.Count,
                          Mesh.TexCoords.Count,
                          Mesh.Normals.Count,
                          Mesh.FaceGroups.Count]));
      {$ENDIF}
   finally
      faceGroupNames.Free;
   end;
end;

procedure TGLOBJVectorFile.SaveToStream(aStream:TStream);
var Mesh:TMeshObject;
    OldDecimalSeparator:char;
    
  procedure Write(s:string);
  begin
    if s<>'' then aStream.Write(s[1],Length(s));
  end;

  procedure WriteLn(s:string);
  begin
    Write(s);
    Write(#13#10);
  end;

  procedure WriteHeader;
  begin
    WriteLn('# OBJ-File exported by GLScene');
    WriteLn('');
  end;

  procedure WriteVertices;
  var s:string;
      i:integer;
  begin
    WriteLn(Format('# %d Vertices:',[Mesh.Vertices.Count]));
    with Mesh.Vertices do
      for i:=0 to Count-1 do
        begin
          s:=Format('v %g %g %g',[List[i][0],List[i][1],List[i][2]]);
          Writeln(s);
        end;
    WriteLn('');
  end;

  procedure WriteNormals;
  var s:string;
      i:integer;
  begin
    WriteLn(Format('# %d Normals:',[Mesh.Normals.Count]));
    with Mesh.Normals do
      for i:=0 to Count-1 do
        begin
          s:=Format('vn %g %g %g',[List[i][0],List[i][1],List[i][2]]);
          Writeln(s);
        end;
    WriteLn('');
  end;

  procedure WriteTexCoords;
  var s:string;
      i:integer;
  begin
    WriteLn(Format('# %d Texture-Coordinates:',[Mesh.TexCoords.Count]));
    with Mesh.TexCoords do
      for i:=0 to Count-1 do
        begin
          s:=Format('vt %g %g',[List[i][0],List[i][1]]);
          Writeln(s);
        end;
    WriteLn('');
  end;

  procedure WriteOBJFaceGroup(aFaceGroup:TOBJFGVertexNormalTexIndexList);
  var vIdx,nIdx,tIdx:integer;
      i,Index,Polygon:integer;
      Line,t:string;
  begin
    with aFaceGroup do
      begin
        if Name=''
          then Writeln('g')
          else WriteLn('g '+Name);
        Index:=0;
        for Polygon:=0 to PolygonVertices.Count-1 do
          begin
            Line:='f ';
            for i:=1 to PolygonVertices[Polygon] do
              begin
                vIdx:=VertexIndices[Index]+1;
                nIdx:=NormalIndices[Index]+1;
                tIdx:=TexCoordIndices[Index]+1;
                t:=IntToStr(vIdx)+'/';
                if tIdx=-1 then t:=t+'/' else t:=t+IntToStr(tIdx)+'/';
                if nIdx=-1 then t:=t+'/' else t:=t+IntToStr(nIdx)+'/';
                Line:=Line+Copy(t,1,length(t)-1)+' ';
                inc(Index);
              end;
            Writeln(Line);
          end;
      end;
    Writeln('');
  end;

   procedure WriteIndexTexCoordList(fg : TFGIndexTexCoordList);
   var
      i, n : Integer;
   begin
      case fg.Mode of
        fgmmTriangles :
        Begin
          Writeln('g');
          n:=fg.VertexIndices.Count-3;
          i:=0; while i<=n do begin
             Writeln(Format('f %d/%0:d %d/%1:d %d/%2:d',
                            [fg.VertexIndices[i]+1,
                             fg.VertexIndices[i+1]+1,
                             fg.VertexIndices[i+2]+1]));
             Inc(i, 3);
          End;
        End;
        fgmmTriangleFan :
        Begin
          Writeln('g');
          Write('f ');
          n:=fg.VertexIndices.Count-1;
          i:=0; while i<=n do begin
             If i<n then
               Write(Format('%d/%0:d ',[fg.VertexIndices[i]+1]))
             else
               Writeln(Format('%d/%0:d',[fg.VertexIndices[i]+1]));
             Inc(i);
          End;
        End;
        fgmmTriangleStrip :
        Begin
          Writeln('g');
          n:=fg.VertexIndices.Count-3;
          i:=0; while i<=n do begin
             Writeln(Format('f %d/%0:d %d/%1:d %d/%2:d',
                            [fg.VertexIndices[i]+1,
                             fg.VertexIndices[i+1]+1,
                             fg.VertexIndices[i+2]+1]));

             Inc(i);
          End;
        End;
      end;
   end;

   procedure WriteFaceGroups;
   var
      i : Integer;
      fg : TFaceGroup;
   begin
      for i:=0 to Mesh.FaceGroups.Count-1 do begin
         fg:=Mesh.FaceGroups[i];
         if fg is TOBJFGVertexNormalTexIndexList then
            WriteOBJFaceGroup(TOBJFGVertexNormalTexIndexList(fg))
         else if fg is TFGIndexTexCoordList then
            WriteIndexTexCoordList(TFGIndexTexCoordList(fg));
      end;
   end;

begin
  Assert(Owner is TGLFreeForm,'Can only save FreeForms.');
  Assert(Owner.MeshObjects.Count<=1,'Only single meshes supported.');

  OldDecimalSeparator:=DecimalSeparator;
  DecimalSeparator:='.';
  { Better not call anything that wants the system-locale intact
    from this block }
  try
    WriteHeader;

    if Owner.MeshObjects.Count>0 then
      begin
        Mesh:=Owner.MeshObjects[0];

        WriteVertices;
        WriteNormals;
        WriteTexCoords;

        WriteFaceGroups;
      end;
  finally
    DecimalSeparator:=OldDecimalSeparator;
  end;
end;

// ------------------
// ------------------ TGLMTLFile ------------------
// ------------------

// Prepare
//
procedure TGLMTLFile.Prepare;
var
   i : Integer;
   buf : String;
begin
   // "standardize" the mtl file lines
   for i:=Count-1 downto 0 do begin
      buf:=UpperCase(Trim(Strings[i]));
      if (buf='') or (buf[1] in ['#', '$']) then
         Delete(i)
      else begin
         Strings[i]:=StringReplace(buf, #9, #32, [rfIgnoreCase]);
      end;
   end;
end;

// MaterialStringProperty
//
function TGLMTLFile.MaterialStringProperty(const materialName, propertyName : String) : String;
var
   i, n : Integer;
   buf, line : String;
begin
   buf:='NEWMTL '+UpperCase(materialName);
   i:=IndexOf(buf);
   if i>=0 then begin
      buf:=UpperCase(propertyName)+' ';
      n:=Length(buf);
      Inc(i);
      while i<Count do begin
         line:=Strings[i];
         if Copy(line, 1, 7)='NEWMTL ' then Break;
         if Copy(line, 1, n)=buf then begin
            Result:=Copy(Strings[i], n+1, MaxInt);
            Exit;
         end;
         Inc(i);
      end;
   end;
   Result:='';
end;

// MaterialVectorProperty
//
function TGLMTLFile.MaterialVectorProperty(const materialName, propertyName : String;
                                           const defaultValue : TVector) : TVector;
var
   i : Integer;
   sl : TStringList;
begin
   sl:=TStringList.Create;
   try
      sl.CommaText:=MaterialStringProperty(materialName, propertyName);
      if sl.Count>0 then begin
         Result:=NullHmgVector;
         for i:=0 to 3 do
            if sl.Count>i then
               Result[i]:=GLUtils.StrToFloatDef(sl[i])
            else Break;
      end else Result:=defaultValue;
   finally
      sl.Free;
   end;
end;

initialization

   { Register this Fileformat-Handler with GLScene }
   RegisterVectorFileFormat('obj','WaveFront model file',TGLOBJVectorFile);
   RegisterVectorFileFormat('objf','Stripe model file',  TGLOBJVectorFile);

end.

