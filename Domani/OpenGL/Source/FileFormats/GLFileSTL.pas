//
// This unit is part of the GLScene Project, http://glscene.org
//
{: GLFileSTL<p>

    Support-code to load STL Files into TGLFreeForm-Components in GLScene.<p>
    Note that you must manually add this unit to one of your project's uses
    to enable support for STL files at run-time.<p>

	<b>History : </b><font size=-1><ul>
      <li>22/11/02 - EG - Write capability now properly declared
      <li>17/10/02 - EG - Created from split of GLVectorFileObjects,
                          ASCII STL support (Adem)
   </ul><p>
}
unit GLFileSTL;

interface

uses Classes, GLVectorFileObjects, GLMisc, ApplicationFileIO;

type

   // TGLSTLVectorFile
   //
   {: The STL vector file (stereolithography format).<p>
      It is a list of the triangular surfaces that describe a computer generated
      solid model. This is the standard input for most rapid prototyping machines.<p>
      There are two flavors of STL, the "text" and the "binary", this class
      reads both, but exports only the "binary" version.<p>
      Original Binary importer code by Paul M. Bearne, Text importer by Adem. }
   TGLSTLVectorFile = class(TVectorFile)
      public
         { Public Declarations }
         class function Capabilities : TDataFileCapabilities; override;

         procedure LoadFromStream(aStream: TStream); override;
         procedure SaveToStream(aStream: TStream); override;
   end;

// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------
implementation
// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------

uses TypesSTL, VectorGeometry, VectorLists, SysUtils;

const
  cSOLID_LABEL       = 'SOLID';
  cFACETNORMAL_LABEL = 'FACET NORMAL ';
  cOUTERLOOP_LABEL   = 'OUTER LOOP';
  cVERTEX_LABEL      = 'VERTEX';
  cENDLOOP_LABEL     = 'ENDLOOP';
  cENDFACET_LABEL    = 'ENDFACET';
  cENDSOLID_LABEL    = 'ENDSOLID';
  cFULL_HEADER_LEN   = 84;

// ------------------
// ------------------ TGLSTLVectorFile ------------------
// ------------------

// Capabilities
//
class function TGLSTLVectorFile.Capabilities : TDataFileCapabilities;
begin
   Result:=[dfcRead, dfcWrite];
end;

// LoadFromStream
//
procedure TGLSTLVectorFile.LoadFromStream(aStream : TStream);
var
   sl : TStringList;

   procedure DecodeSTLNormals(const aString : String; var aNormal : TSTLVertex);
   begin
      sl.CommaText:=aString;
      if sl.Count<>5 then
         raise Exception.Create('Invalid Normal')
      else begin
         aNormal[0]:=StrToFloatDef(sl[2], 0);
         aNormal[1]:=StrToFloatDef(sl[3], 0);
         aNormal[2]:=StrToFloatDef(sl[4], 0);
      end;
   end;

   procedure DecodeSTLVertex(const aString : String; var aVertex : TSTLVertex);
   begin
      sl.CommaText:=aString;
      if (sl.Count<>4) or (CompareText(sl[0], cVERTEX_LABEL)<>0) then
         raise Exception.Create('Invalid Vertex')
      else begin
         aVertex[0]:=StrToFloatDef(sl[1], 0);
         aVertex[1]:=StrToFloatDef(sl[2], 0);
         aVertex[2]:=StrToFloatDef(sl[3], 0);
      end;
   end;

var
   isBinary : Boolean;
   headerBuf : array [0..cFULL_HEADER_LEN-1] of Char;
   positionBackup : Integer;
   fileContent : TStringList;
   curLine : String;
   i : Integer;
   mesh : TMeshObject;
   header : TSTLHeader;
   dataFace : TSTLFace;
   calcNormal : TAffineVector;
begin
   positionBackup:=aStream.Position;
   aStream.Read(headerBuf[0], cFULL_HEADER_LEN);
   aStream.Position:=positionBackup;

   isBinary:=True;
   i:=0;
   while i<80 do begin
     if (headerBuf[i]<#32) and (headerBuf[i]<>#0) then begin
         isBinary:=False;
         Break;
     end;
     Inc(i);
   end;

   mesh:=TMeshObject.CreateOwned(Owner.MeshObjects);
   try

      mesh.Mode:=momTriangles;

      if isBinary then begin

         aStream.Read(header, SizeOf(TSTLHeader));
         for i:=0 to header.nbFaces-1 do begin
            aStream.Read(dataFace, SizeOf(TSTLFace));
            with dataFace, mesh do begin
               // STL faces have a normal, but do not necessarily follow the winding rule,
               // so we must first determine if the triangle is properly oriented
               // and rewind it properly if not...
               calcNormal:=CalcPlaneNormal(v1, v2, v3);
               if VectorDotProduct(calcNormal, normal)>0 then
                  Vertices.Add(v1, v2, v3)
               else Vertices.Add(v3, v2, v1);
               Normals.Add(normal, normal, normal);
            end;
         end;

      end else begin

         fileContent:=TStringList.Create;
         sl:=TStringList.Create;
         try
            fileContent.LoadFromStream(aStream);
            i:=0;
            curLine:=Trim(UpperCase(fileContent[i]));
            if Pos(cSOLID_LABEL, curLine)=1 then begin
               mesh.Vertices.Capacity:=(fileContent.Count-2) div 7;
               mesh.Normals.Capacity:=(fileContent.Count-2) div 7;

               Inc(i);
               curLine:=Trim(UpperCase(fileContent[i]));
               while i<fileContent.Count do begin
                  if Pos(cFACETNORMAL_LABEL, curLine)=1 then begin
                     DecodeSTLNormals(curLine, dataFace.normal);
                     Inc(i);
                     curLine:=Trim(UpperCase(fileContent[i]));
                     if Pos(cOUTERLOOP_LABEL, curLine)=1 then begin
                        Inc(i);
                        curLine:=Trim(fileContent[i]);
                        DecodeSTLVertex(curLine, dataFace.v1);

                        Inc(i);
                        curLine:=Trim(fileContent[i]);
                        DecodeSTLVertex(curLine, dataFace.v2);

                        Inc(i);
                        curLine:=Trim(fileContent[i]);
                        DecodeSTLVertex(curLine, dataFace.v3);
                     end;
                     Inc(i);
                     curLine:=Trim(UpperCase(fileContent[i]));
                     if Pos(cENDLOOP_LABEL, curLine)<>1 then
                        raise Exception.Create('End of Loop Not Found')
                     else begin
                        calcNormal:=CalcPlaneNormal(dataFace.v1, dataFace.v2, dataFace.v3);
                        if VectorDotProduct(calcNormal, dataFace.normal)>0 then
                          mesh.Vertices.Add(dataFace.v1, dataFace.v2, dataFace.v3)
                        else mesh.Vertices.Add(dataFace.v3, dataFace.v2, dataFace.v1);
                        mesh.Normals.Add(dataFace.normal, dataFace.normal, dataFace.normal);
                     end;
                  end;
                  Inc(i);
                  curLine:=Trim(UpperCase(fileContent[i]));
                  if Pos(cENDFACET_LABEL, curLine)<>1 then
                     raise Exception.Create('End of Facet Not found');
                  Inc(i);
                  curLine:=Trim(UpperCase(fileContent[i]));
                  if Pos(cENDSOLID_LABEL, curLine)=1 then Break;
               end;
            end;
         finally
            sl.Free;
            fileContent.Free;
         end;

      end;
   except
      on E : Exception do begin
         mesh.Free;
      end;
   end;
end;

// SaveToStream
//
procedure TGLSTLVectorFile.SaveToStream(aStream: TStream);
var
   i : Integer;
   header : TSTLHeader;
   dataFace : TSTLFace;
   list : TAffineVectorList;
const
   cHeaderTag = 'GLScene STL export';
begin
   list:=Owner.MeshObjects.ExtractTriangles;
   try
      FillChar(header.dummy[0], SizeOf(header.dummy), 0);
      Move(cHeaderTag, header.dummy[0], Length(cHeaderTag));
      header.nbFaces:=list.Count div 3;
      aStream.Write(header, SizeOf(header));
      i:=0; while i<list.Count do begin
         dataFace.normal:=CalcPlaneNormal(list[i], list[i+1], list[i+2]);
         dataFace.v1:=list[i];
         dataFace.v2:=list[i+1];
         dataFace.v3:=list[i+2];
         aStream.Write(dataFace, SizeOf(dataFace));
         Inc(i, 3);
      end;
   finally
      list.Free;
   end;
end;

// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------
initialization
// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------

   RegisterVectorFileFormat('stl', 'Stereolithography files', TGLSTLVectorFile);

end.
