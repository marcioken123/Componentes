 // GLCgShader
{: Base Cg shader classes.<p>

   <b>History :</b><font size=-1><ul>
      <li>07/09/04 - NelC - Added profiles VP40, FP40 from Cg 1.3 beta 2,
                            Added option OutputCompilerWarnings
      <li>23/04/04 - NelC - Now ManageTexture is false by default (Cg 1.2.1)
      <li>24/03/04 - NelC - Added GetLatestProfile
      <li>21/03/04 - NelC - Added TCgFragmentProgram.ManageTexture (Cg 1.2)
                            Added TCustomCgShader.IsProfileSupported
      <li>16/02/04 - NelC - Added TCgParameter.SetParameterPointer
      <li>13/02/04 - NelC - Replaced two overloaded TCgProgram.SetParam's with
                            SetStateMatrix and SetTexture
      <li>05/02/04 - NelC - Fixed type checking for Half and Fixed,
                            Added TCgParameter.SetToTextureOf
      <li>01/02/04 - NelC - Now reports source CgProgram or CgParameter of errors
      <li>20/01/04 - NelC - Updated shader event handlers with Sender object,
                            Fixed dynamic array passing bug in CheckValueType
      <li>03/01/04 - NelC - Shortened event handler names using 'VP' and 'FP',
                            Added TCustomCgShader.LoadShaderPrograms, TCgProgram.SetParam,
                            Minor change in texture type checking
      <li>01/08/03 - NelC - Simplified type checking in SetAsStateMatrix
      <li>04/07/03 - NelC - Added TCustomCgShader.OnInitialize,
                            Moved VertexProgram & FragmentProgram of TCustomCgShader
                            to published for easy acccess from OnInitialize
      <li>02/07/03 - NelC - Added more value-setting methods
      <li>01/07/03 - NelC - TCgProgram.ListCompilation now outputs line breaks
      <li>27/06/03 - NelC - Added value-setting functions for TCgParameter,
                            TCgProgram.DirectParamByName & DirectProfile, and
                            Profile property for TCgVertexProgram & TCgFragmentProgram
      <li>24/06/03 - NelC - Initial adoptation to Cg 1.1 Final. Now automatically
                            uses latest hardware-supported profile and use callback
                            to show error message
      <li>29/05/03 - RoC - Cg 1.1 Depreciated_api compatible
      <li>25/09/02 - EG - Cg Beta 2/2.1 compatible, now uses ARBVP
      <li>19/06/02 - EG - Improved OO wrapper
      <li>18/06/02 - EG - Creation
   </ul></font>
}
unit GLCgShader;

interface

uses
  Classes, VectorGeometry, VectorLists, VectorTypes, GLTexture, GLMisc, Cg, CgGL;

{$Include GLScene.inc}

{.$DEFINE OutputCompilerWarnings}
{ Define OutputCompilerWarnings to output Cg compiler warnings to a file. Edit
  the string WarningFilename for the output filename. Useful for detecting bugs
  caused by using uninitialized value, implicit type cast, etc. }
  
{$IFDEF OutputCompilerWarnings}
const WarningFilename = 'C:\CG_Warnings.txt';
{$ENDIF}

type
  TCustomCgShader = class;
  TCgProgram = class;
  TCgParameter = class;

  TCgApplyEvent = procedure (CgProgram : TCgProgram; Sender : TObject) of object;
  TCgUnApplyEvent = procedure (CgProgram : TCgProgram) of object;
  TCgShaderEvent = procedure (CgShader : TCustomCgShader) of object;

  TcgProgramType = (ptVertex, ptFragment);

  // Available vertex program profile
  TCgVPProfile = (vpDetectLatest, vp20, vp30, vp40, arbvp1);

  // Available fragment program profile
  TCgFPProfile = (fpDetectLatest, fp20, fp30, fp40, arbfp1);

  // TCgProgram
  //
  {: Wrapper around a Cg program. }
  TCgProgram = class (TGLUpdateAbleObject)
  private
    { Private Declarations }
    FCgContext : PcgContext;
    FCode : TStrings; // the Cg program itself
    FProgramName : String;
    FHandle : PCGprogram;
    FParams : TList;

    FOnApply : TCgApplyEvent;
    FOnUnApply : TCgUnApplyEvent;
    FOnProgramChanged : TNotifyEvent;

    FEnabled : boolean;
    FDetectProfile : boolean;

  protected
    { Protected Declarations }
    FProgramType : TcgProgramType;
    FProfile : TcgProfile;

    procedure SetCode(const val : TStrings);
    procedure SetProgramName(const val : String);
    function GetParam(index : String) : TCgParameter;

    procedure AddParamsItem(const Param : PCGParameter);
    {: Build a list of parameters used in the shader code.<p>
       Iteratively queries all parameters so that we can manage and access them
       easily. Currently only collects leaf parameters i.e. data structure is
       not retrieved. }
    procedure BuildParamsList;
    procedure ClearParamsList;

  public
    { Public Declarations }
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    function GetLatestProfile: TcgProfile; virtual; abstract;

    procedure Initialize; dynamic;
    procedure Finalize;
    procedure Apply(var rci : TRenderContextInfo; Sender : TObject);
    procedure UnApply(var rci : TRenderContextInfo);

    {: ParamByName returns CgParameter; returns nil if not found. }
    function ParamByName(const name : String) : TCgParameter;
    {: Use Param instead of ParamByName if you want implicit check for the
       existence of your requested parameter. }
    property Param[index : String] : TCgParameter read GetParam;
    property Params : TList read FParams;

    // Returns a handle to a Cg parameter
    function DirectParamByName(const name : String) : PCGparameter;

    function ParamCount : Integer;
    function GetProfileString : string;

    procedure LoadFromFile(const fileName : String);

    procedure ListCompilation(Output : TStrings);
    procedure ListParameters(Output : TStrings);

    // shorthands for accessing parameters
    procedure SetParam(ParamName: string; SingleVal : Single); overload;
    procedure SetParam(ParamName: string; const Vector2fVal : TVector2f); overload;
    procedure SetParam(ParamName: string; const Vector3fVal : TVector3f); overload;
    procedure SetParam(ParamName: string; const Vector4fVal : TVector4f); overload;
    procedure SetStateMatrix(ParamName: string; matrix, Transform: Cardinal);
    procedure SetTexture(ParamName: string; TextureID : Cardinal);

    // retruns ShaderName.[program type].ProgramName
    function LongName : string;

    {: Direct access to the profile. <p>
       Set Profile of the sub-classes to any but DetectLatest if you want to
       specify the profile directly. }
    property DirectProfile : TcgProfile read FProfile write FProfile;

    property OnProgramChanged : TNotifyEvent read FOnProgramChanged write FOnProgramChanged;

  published
    { Published Declarations }
    property Code : TStrings read FCode write SetCode;
    property ProgramName : String read FProgramName write SetProgramName;
    property Enabled : boolean read FEnabled write FEnabled default True;
    property OnApply : TCgApplyEvent read FOnApply write FOnApply;
    property OnUnApply : TCgUnApplyEvent read FOnUnApply write FOnUnApply;
  end;

  // TCgParameter
  //
  {: Wrapper around a Cg parameter of the main program. }
  TCgParameter = class (TObject)
  private
    { Private Declarations }
    FOwner : TCgProgram;
    FName : String;
    FHandle      : PCGparameter;
    FValueType   : TCGtype; // e.g. CG_FLOAT
    FDirection   : TCGenum; // e.g. CG_INOUT
    FVariability : TCGenum; // e.g. CG_UNIFORM
  protected
    { Protected Declarations }
    function TypeMismatchMessage : string;
    procedure CheckValueType(aType : TCGtype); overload;
    procedure CheckValueType(const types : array of TCGtype); overload;

    procedure SetAsVector2f(const val : TVector2f);
    procedure SetAsVector3f(const val : TVector3f);
    procedure SetAsVector4f(const val : TVector4f);
  public
    { Public Declarations }
    constructor Create; virtual;
    destructor Destroy; override;

    {: Procedures for setting uniform pamareters.<p>
       Implicitly check for data type. }
    procedure SetAsScalar(const val : Single);
    procedure SetAsVector(const val : TVector2f); overload;
    procedure SetAsVector(const val : TVector3f); overload;
    procedure SetAsVector(const val : TVector4f); overload;

    procedure SetAsStateMatrix(matrix, Transform: Cardinal);

    {: Procedures for dealing with texture pamareters.}
    // SetAsTexture checks for all texture types
    procedure SetAsTexture(TextureID : Cardinal);
    // SetAsTexture* check for specific type
    procedure SetAsTexture1D(TextureID : Cardinal);
    procedure SetAsTexture2D(TextureID : Cardinal);
    procedure SetAsTexture3D(TextureID : Cardinal);
    procedure SetAsTextureCUBE(TextureID : Cardinal);
    procedure SetAsTextureRECT(TextureID : Cardinal);
    {: SetToTextureOf determines texture type on-the-fly.}
    procedure SetToTextureOf(LibMaterial  : TGLLibMaterial);

    procedure EnableTexture;
    procedure DisableTexture;

    {: Procedures for setting varying parameters with an array of values.}
    procedure SetParameterPointer(Values : TVectorList); overload;
    procedure SetParameterPointer(Values : TAffineVectorList); overload;

    procedure EnableClientState;
    procedure DisableClientState;

    {: LongName retruns ShaderName.[program type].ProgramName.ParamName. }
    function LongName : string;

    property Owner : TCgProgram read FOwner;
    property Name : String read FName;
    property ValueType : TCGtype read FValueType;
    property Handle : PCGparameter read FHandle write FHandle;
    property Direction : TCGenum read FDirection write FDirection;
    property Variability : TCGenum read FVariability write FVariability;

    // GLScene-friendly properties
    property AsVector : TVector write SetAsVector4f; // position f.i.
    property AsAffineVector : TAffineVector write SetAsVector3f; // normal f.i.
    property AsVector2f : TVector2f write SetAsVector2f; // texCoord f.i.
  end;

  // TCgVertexProgram
  //
  TCgVertexProgram = class (TCgProgram)
  private
    FVPProfile : TCgVPProfile;
    procedure SetVPProfile(v : TCgVPProfile);
  public
    { Public Declarations }
    constructor Create(AOwner: TPersistent); override;
    function GetLatestProfile: TcgProfile;  override;
  published
    property Profile : TCgVPProfile read FVPProfile write SetVPProfile default vpDetectLatest;
  end;

  // TCgFragmentProgram
  //
  TCgFragmentProgram = class (TCgProgram)
  private
    FFPProfile : TCgFPProfile;
    FManageTexture : boolean;
    procedure SetFPProfile(v : TCgFPProfile);
    procedure SetManageTexture(const Value: boolean);

  public
    { Public Declarations }
    constructor Create(AOwner: TPersistent); override;
    procedure Initialize; override;
    function GetLatestProfile: TcgProfile; override;

  published
    property Profile : TCgFPProfile read FFPProfile write SetFPProfile default fpDetectLatest;
    // Switch for auto enabling of texture parameters (Cg 1.2 feature)
    // With Cg 1.2.1, default is OFF
    property ManageTexture : boolean read FManageTexture write SetManageTexture default false;
  end;

  // TCustomCgShader
  //
  TCustomCgShader = class (TGLShader)
  private
    { Private Declarations }
    FVertexProgram : TCgVertexProgram;
    FFragmentProgram : TCgFragmentProgram;

    FOnInitialize : TCgShaderEvent;

    FDesignEnable : Boolean;

  protected
    { Protected Declarations }
    // Vertex Program
    procedure SetVertexProgram(const val : TCgVertexProgram);
    procedure SetOnApplyVertexProgram(const val : TCgApplyEvent);
    function GetOnApplyVertexProgram : TCgApplyEvent;
    procedure SetOnUnApplyVertexProgram(const val : TCgUnApplyEvent);
    function GetOnUnApplyVertexProgram : TCgUnApplyEvent;

    // Fragment Program
    procedure SetFragmentProgram(const val : TCgFragmentProgram);
    procedure SetOnApplyFragmentProgram(const val : TCgApplyEvent);
    function GetOnApplyFragmentProgram : TCgApplyEvent;
    procedure SetOnUnApplyFragmentProgram(const val : TCgUnApplyEvent);
    function GetOnUnApplyFragmentProgram : TCgUnApplyEvent;

    // OnInitialize
    function GetOnInitialize : TCgShaderEvent;
    procedure SetOnInitialize(const val : TCgShaderEvent);

    procedure DoInitialize; override;
    procedure DoFinalize; override;
    procedure DoApply(var rci : TRenderContextInfo; Sender : TObject); override;
    function  DoUnApply(var rci : TRenderContextInfo) : Boolean; override;

  public
    { Public Declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsProfileSupported(Profile: TcgProfile): boolean;

    procedure LoadShaderPrograms(VPFilename, FPFilename : string);

    property OnApplyVP : TCgApplyEvent read GetOnApplyVertexProgram write SetOnApplyVertexProgram;
    property OnApplyFP : TCgApplyEvent read GetOnApplyFragmentProgram write SetOnApplyFragmentProgram;

    property OnUnApplyVP : TCgUnApplyEvent read GetOnUnApplyVertexProgram write SetOnUnApplyVertexProgram;
    property OnUnApplyFP : TCgUnApplyEvent read GetOnUnApplyFragmentProgram write SetOnUnApplyFragmentProgram;

    {: OnInitialize can be use to set parameters that need to be set once only. See demo "Cg Texture" for example.}
    property OnInitialize : TCgShaderEvent read GetOnInitialize write SetOnInitialize;

  published
    { Published Declarations }
    property DesignEnable : Boolean read FDesignEnable write FDesignEnable default False;
    property VertexProgram : TCgVertexProgram read FVertexProgram write SetVertexProgram;
    property FragmentProgram : TCgFragmentProgram read FFragmentProgram write SetFragmentProgram;
  end;

  // TCgShader
  //
  TCgShader = class (TCustomCgShader)
  published
    { Published Declarations }
    property VertexProgram;
    property FragmentProgram;

    property OnApplyVP;
    property OnApplyFP;

    property OnUnApplyVP;
    property OnUnApplyFP;

    property OnInitialize;
  end;

procedure Register;

// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------
implementation
// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------

uses SysUtils, OpenGL1x, Dialogs;

const
  // For checking data type
  AllTextureTypes : array[0..4] of TCGtype =
     (CG_SAMPLER2D, CG_SAMPLER1D, CG_SAMPLERRECT, CG_SAMPLERCUBE, CG_SAMPLER3D);

  CgBoolean : array[false..true] of TCGbool = (CG_FALSE, CG_TRUE);

var
  vCgContextCount : Integer;
  CurCgProgram    : TCgProgram;  // for reporting error
{$IFDEF OutputCompilerWarnings}
  CompilerMsg     : TStringList; // useful for seeing compiler warnings
{$ENDIF}

procedure Register;
begin
  RegisterComponents('GLScene Shaders', [TCgShader]);
end;

{$IFDEF OutputCompilerWarnings}
procedure RecordWarnings;
begin
  with CurCgProgram do
    CompilerMsg.Add('[' + LongName + '] ' + cgGetErrorString(cgGetError) + #10 + cgGetLastListing(FCgContext));
end;
{$ENDIF}

procedure ErrorCallBack; cdecl;
var  Msg : string;
begin
  with CurCgProgram do
    Msg:='[' + LongName + '] ' + cgGetErrorString(cgGetError) + #10 + cgGetLastListing(FCgContext);
  raise Exception.Create(Msg);
end;

// ------------------
// ------------------ TCgProgram ------------------
// ------------------

// Create
//
constructor TCgProgram.Create(AOwner: TPersistent);
begin
  inherited;
  FCode := TStringList.Create;
  TStringList(FCode).OnChange := NotifyChange;
  FParams := TList.Create;
  FEnabled := true;
  FDetectProfile := true;
end;

// Destroy
//
destructor TCgProgram.Destroy;
begin
  inherited Destroy;
  Assert(FParams.Count=0, '[' + LongName + ']: bug! params unbound!');
  FParams.Free;
  FCode.Free;
end;

// SetCode
//
procedure TCgProgram.SetCode(const val : TStrings);
begin
  FCode.Assign(val);
end;

// LoadFromFile
//
procedure TCgProgram.LoadFromFile(const fileName : String);
begin
  Code.LoadFromFile(fileName);
end;

// SetProgramName
//
procedure TCgProgram.SetProgramName(const val : String);
begin
  if val<>FProgramName then
  begin
    FProgramName:=val;
    NotifyChange(Self);
  end;
end;

// AddParamsItem
//
procedure TCgProgram.AddParamsItem(const Param: PCGParameter);
var
  newParamObj : TCgParameter;
begin
  newParamObj := TCgParameter.Create;
  with newParamObj do begin
    FOwner := Self;
    FName  := StrPas(cgGetParameterName(Param));
    FHandle := Param;
    FValueType := cgGetParameterType(Param); 
    FDirection := cgGetParameterDirection(Param); 
    FVariability := cgGetParameterVariability(Param);
  end;
  FParams.Add(newParamObj);
end;

// BuildParamsList
//
procedure TCgProgram.BuildParamsList;
var
  CurParam : PCGParameter;
begin
  ClearParamsList;
  CurParam:=cgGetFirstLeafParameter(FHandle, CG_PROGRAM);

  // build params list
  while Assigned(CurParam) do begin
    AddParamsItem(CurParam);
    CurParam:=cgGetNextLeafParameter(CurParam);
  end;
end;

// ClearParamsList
//
procedure TCgProgram.ClearParamsList;
var
  i : Integer;
begin
  for i:=FParams.Count-1 downto 0 do
    TCgParameter(FParams[i]).Free;
  FParams.Clear;
end;

// GetParam
//
function TCgProgram.GetParam(index : String) : TCgParameter;
begin
  Result := ParamByName(index);
  Assert(Result<>nil, '['+LongName+']: Parameter "'+index+'" not found.');
end;

// ParamByName
//
function TCgProgram.ParamByName(const name : String) : TCgParameter;
var
  i : Integer;
  list : PPointerList;
begin
  Result := nil;
  list := FParams.List;
  for i:=0 to FParams.Count-1 do begin
    if TCgParameter(list[i]).Name=name then begin
      Result := TCgParameter(list[i]);
      Exit;
    end;
  end;
end;

// DirectParamByName
//
function TCgProgram.DirectParamByName(const name: String): PCGparameter;
begin
  result:=cgGetNamedParameter(FHandle, PChar(name));
end;

// ParamCount
//
function TCgProgram.ParamCount : Integer;
begin
  Result:=FParams.Count;
end;

// Initialize
//
procedure TCgProgram.Initialize;
var
  buf : String;
begin
  Assert(FCgContext=nil);
  
  buf := Trim(Code.Text);
  if buf='' then exit;
  // get a new context
  FCgContext := cgCreateContext;
  Inc(vCgContextCount);
  CurCgProgram:=self;
  try
    if FDetectProfile then FProfile:=GetLatestProfile;
    cgGLSetOptimalOptions(FProfile);
    if FProgramName='' then FProgramName:='main'; // default program name
    FHandle := cgCreateProgram( FCgContext, CG_SOURCE, PChar(buf), FProfile,
                                PChar(FProgramName), nil);
    cgGLLoadProgram(FHandle);
    // build parameter list for the selected program
    BuildParamsList;
{$IFDEF OutputCompilerWarnings}
    RecordWarnings;
{$ENDIF}
  except
    cgDestroyContext(FCgContext);
    FCgContext := nil;
    Dec(vCgContextCount);
  raise;
  end;
end;

// Finalize
//
procedure TCgProgram.Finalize;
begin
  if not Assigned(FCgContext) then exit;

  FProgramName := '';
  ClearParamsList;
  cgDestroyContext(FCgContext);
  FCgContext := nil;
  Dec(vCgContextCount);
end;

// Apply
//
procedure TCgProgram.Apply(var rci : TRenderContextInfo; Sender : TObject);
begin
  if not Assigned(FHandle) then exit;
  if not FEnabled then exit;

  CurCgProgram:=self;

  cgGLBindProgram(FHandle);
  cgGLEnableProfile(FProfile);

  if Assigned(FOnApply) then FOnApply(Self, Sender);
end;

// UnApply
//
procedure TCgProgram.UnApply(var rci : TRenderContextInfo);
begin
  if not Assigned(FHandle) then exit;
  if not FEnabled then exit;

  if Assigned(FOnUnApply) then FOnUnApply(Self);

  cgGLDisableProfile(FProfile);
end;

// GetProfileString
//
function TCgProgram.GetProfileString: string;
begin
  result:=StrPas(cgGetProfileString(FProfile));
end;

// ListParameters
//
procedure TCgProgram.ListParameters(Output: TStrings);
var i : integer;
begin
  Output.clear;
  for i:=0 to ParamCount-1 do
    output.add(TCgParameter(FParams[i]).Name);
end;

// ListCompilation
//
procedure TCgProgram.ListCompilation(Output: TStrings);

  procedure OutputAsTStrings(s : String);
  var i : integer;
  begin
    while Length(s) > 0 do begin
      I:=Pos(#10, s);
      if I = 0 then I:=255;
      Output.Add(Copy(s, 1, I-1));
      Delete(s, 1, I);
    end;
  end;

begin
  Output.BeginUpdate;
  Output.Clear;
  OutputAsTStrings(cgGetProgramString(FHandle, CG_COMPILED_PROGRAM));
  Output.EndUpdate;
end;

// SetParam(*)
//
procedure TCgProgram.SetParam(ParamName: string; const Vector3fVal: TVector3f);
begin
  ParamByName(ParamName).SetAsVector3f(Vector3fVal);
end;

procedure TCgProgram.SetParam(ParamName: string; const Vector2fVal: TVector2f);
begin
  ParamByName(ParamName).SetAsVector2f(Vector2fVal);
end;

procedure TCgProgram.SetParam(ParamName: string; SingleVal: Single);
begin
  Param[ParamName].SetAsScalar(SingleVal);
end;

procedure TCgProgram.SetParam(ParamName: string; const Vector4fVal: TVector4f);
begin
  ParamByName(ParamName).SetAsVector4f(Vector4fVal);
end;

// SetStateMatrix
//
procedure TCgProgram.SetStateMatrix(ParamName: string; matrix, Transform: Cardinal);
begin
  ParamByName(ParamName).SetAsStateMatrix(matrix, Transform);
end;

// SetTexture
//
procedure TCgProgram.SetTexture(ParamName: string; TextureID: Cardinal);
begin
  ParamByName(ParamName).SetAsTexture(TextureID);
end;

// LongName
//
function TCgProgram.LongName: string;
const ProTypeStr : array[ptVertex..ptFragment] of string = ('VP', 'FP');
begin
 result:=(Owner as TCgShader).Name + '.' + ProTypeStr[FProgramType] + '.' + ProgramName;
end;

// ------------------
// ------------------ TCgParameter ------------------
// ------------------

// Create
//
constructor TCgParameter.Create;
begin
   inherited;
end;

// Destroy
//
destructor TCgParameter.Destroy;
begin
   inherited;
end;

// LongName
//
function TCgParameter.LongName: string;
begin
  result:=Owner.LongName + '.' + FName;
end;

// TypeMismatchMessage
//
function TCgParameter.TypeMismatchMessage: string;
begin
  result:='[' + LongName + ']: Parameter type mismatch.';
end;

// CheckValueType
//
procedure TCgParameter.CheckValueType(aType : TCGtype);
begin
  Assert(aType=FValueType, TypeMismatchMessage);
end;

// CheckValueType
//
procedure TCgParameter.CheckValueType(const types : array of TCGtype);
  function DoCheck : Boolean;
  var
    i : Integer;
  begin
    Result := False;
    for i:=Low(types) to High(types) do
      if FValueType=types[i] then
      begin
        Result := True;
        Break;
      end;
  end;
begin
  Assert(DoCheck, TypeMismatchMessage);
end;

// SetAsScalar
//
procedure TCgParameter.SetAsScalar(const val : Single);
begin
  CheckValueType([CG_FLOAT, CG_HALF, CG_FIXED{$ifdef GLS_DELPHI_6_UP}, CG_BOOL{$endif}]);
  cgGLSetParameter1f(FHandle, val);
end;

// SetAsVector*
//
procedure TCgParameter.SetAsVector2f(const val: TVector2f);
begin
  CheckValueType([CG_FLOAT2, CG_HALF2, CG_FIXED2]);
  cgGLSetParameter2fv(FHandle, @val);
end;

procedure TCgParameter.SetAsVector3f(const val: TVector3f);
begin
  CheckValueType([CG_FLOAT3, CG_HALF3, CG_FIXED3]);
  cgGLSetParameter3fv(FHandle, @val);
end;

procedure TCgParameter.SetAsVector4f(const val: TVector4f);
begin
  CheckValueType([CG_FLOAT4, CG_HALF4, CG_FIXED4]);
  cgGLSetParameter4fv(FHandle, @val);
end;

procedure TCgParameter.SetAsVector(const val: TVector2f);
begin
  SetAsVector2f(val);
end;

procedure TCgParameter.SetAsVector(const val: TVector3f);
begin
  SetAsVector3f(val);
end;

procedure TCgParameter.SetAsVector(const val: TVector4f);
begin
  SetAsVector4f(val);
end;

// SetAsTexture*
//
procedure TCgParameter.SetAsTexture(TextureID: Cardinal);
begin
  CheckValueType(AllTextureTypes);
  cgGLSetTextureParameter(FHandle, TextureID);
end;

procedure TCgParameter.SetAsTexture1D(TextureID: Cardinal);
begin
  CheckValueType(CG_SAMPLER1D);
  cgGLSetTextureParameter(FHandle, TextureID);
end;

procedure TCgParameter.SetAsTexture2D(TextureID: Cardinal);
begin
  CheckValueType(CG_SAMPLER2D);
  cgGLSetTextureParameter(FHandle, TextureID);
end;

procedure TCgParameter.SetAsTexture3D(TextureID: Cardinal);
begin
  CheckValueType(CG_SAMPLER3D);
  cgGLSetTextureParameter(FHandle, TextureID);
end;

procedure TCgParameter.SetAsTextureRECT(TextureID: Cardinal);
begin
  CheckValueType(CG_SAMPLERRECT);
  cgGLSetTextureParameter(FHandle, TextureID);
end;

procedure TCgParameter.SetAsTextureCUBE(TextureID: Cardinal);
begin
  CheckValueType(CG_SAMPLERCUBE);
  cgGLSetTextureParameter(FHandle, TextureID);
end;

// SetToTextureOf
//
procedure TCgParameter.SetToTextureOf(LibMaterial: TGLLibMaterial);
var TexType : TCGtype;
begin
  case LibMaterial.Material.Texture.Image.NativeTextureTarget of
    GL_TEXTURE_2D : TexType:=CG_SAMPLER2D;
    GL_TEXTURE_CUBE_MAP_ARB : TexType:=CG_SAMPLER2D;
    GL_TEXTURE_RECTANGLE_NV : TexType:=CG_SAMPLERRECT;
    GL_TEXTURE_1D : TexType:=CG_SAMPLER1D;
    GL_TEXTURE_3D : TexType:=CG_SAMPLER3D;
  else begin
      assert(false, 'Unknown texture target');
      TexType:=CG_SAMPLER2D; // to subpress compilation warning
    end;
  end;

  CheckValueType(TexType);

  cgGLSetTextureParameter(FHandle, LibMaterial.Material.Texture.Handle);
end;

// DisableTexture
//
procedure TCgParameter.DisableTexture;
begin
  CheckValueType(AllTextureTypes);
  cgGLDisableTextureParameter(FHandle);
end;

// EnableTexture
//
procedure TCgParameter.EnableTexture;
begin
  CheckValueType(AllTextureTypes);
  cgGLEnableTextureParameter(FHandle);
end;

// SetAsStateMatrix
//
procedure TCgParameter.SetAsStateMatrix(matrix, Transform : Cardinal);
// Assuming values of matrix types are contiguous to simplify the type checking
const
  MinFloatA = CG_FLOAT1x1; MaxFloatA = CG_FLOAT4x4;
  MinHalfA  = CG_HALF1x1;  MaxHalfA  = CG_HALF4x4;
  MinFixedA = CG_FIXED1x1; MaxFixedA = CG_FIXED4x4;
begin
  Assert( ( (FValueType>=MinFloatA) and (FValueType<=MaxFloatA) or
            (FValueType>=MinHalfA) and (FValueType<=MaxHalfA) or
            (FValueType>=MinFixedA) and (FValueType<=MaxFixedA) ), TypeMismatchMessage);
  cgGLSetStateMatrixParameter( Fhandle, matrix, Transform);
end;

// DisableClientState
//
procedure TCgParameter.DisableClientState;
begin
  assert(FVariability = CG_VARYING);
  cgGLDisableClientState(FHandle);
end;

// EnableClientState
//
procedure TCgParameter.EnableClientState;
begin
  assert(FVariability = CG_VARYING);
  cgGLEnableClientState(FHandle);
end;

// SetParameterPointer
//
procedure TCgParameter.SetParameterPointer(Values: TAffineVectorList);
begin
  assert(FVariability = CG_VARYING);
  cgGLSetParameterPointer(FHandle, 3, GL_FLOAT, 0, Values.List);
end;

procedure TCgParameter.SetParameterPointer(Values: TVectorList);
begin
  assert(FVariability = CG_VARYING);
  cgGLSetParameterPointer(FHandle, 4, GL_FLOAT, 0, Values.List);
end;

// ------------------
// ------------------ TCgVertexProgram ------------------
// ------------------

// Create
//
constructor TCgVertexProgram.Create;
begin
  inherited;
  FProgramType := ptVertex;
  FVPProfile:=vpDetectLatest;
end;

// GetLatestProfile
//
function TCgVertexProgram.GetLatestProfile: TcgProfile;
begin
  result:=cgGLGetLatestProfile(CG_GL_VERTEX);
end;

procedure TCgVertexProgram.SetVPProfile(v: TCgVPProfile);
begin
  if FVPProfile=v then exit;
  FVPProfile:=v;
  case v of
    vp20   : FProfile := CG_PROFILE_VP20;
    vp30   : FProfile := CG_PROFILE_VP30;
    vp40   : FProfile := CG_PROFILE_VP40;    
    arbvp1 : FProfile := CG_PROFILE_ARBVP1;
  end;

  FDetectProfile:=v=vpDetectLatest;
end;

// ------------------
// ------------------ TCgFragmentProgram ------------------
// ------------------

// Create
//
constructor TCgFragmentProgram.Create;
begin
  inherited;
  FProgramType := ptFragment;
  FFPProfile:=fpDetectLatest;
  FManageTexture:=false;
end;

// SetManageTexture
//
procedure TCgFragmentProgram.SetManageTexture(const Value: boolean);
begin
  FManageTexture:=Value;
  if FCgContext<>nil then
    cgGLSetManageTextureParameters(@FCgContext, CgBoolean[FManageTexture]);
// If FCgContext = nil (i.e. program not yet initialized), set it in
// TCgFragmentProgram.Initialize
end;

// Initialize
//
procedure TCgFragmentProgram.Initialize;
begin
  inherited;
  if FManageTexture then // ManageTexture is off by default
    cgGLSetManageTextureParameters(@FCgContext, CgBoolean[FManageTexture]);
end;

// GetLatestProfile
//
function TCgFragmentProgram.GetLatestProfile: TcgProfile;
begin
  result:=cgGLGetLatestProfile(CG_GL_FRAGMENT);
end;

// SetFPProfile
//
procedure TCgFragmentProgram.SetFPProfile(v: TCgFPProfile);
begin
  if FFPProfile=v then exit;
  FFPProfile:=v;
  case v of
    fp20   : FProfile := CG_PROFILE_FP20;
    fp30   : FProfile := CG_PROFILE_FP30;
    fp40   : FProfile := CG_PROFILE_FP40;
    arbfp1 : FProfile := CG_PROFILE_ARBFP1;
  end;
  FDetectProfile:= v=fpDetectLatest;
end;

// ------------------
// ------------------ TCustomCgShader ------------------
// ------------------

// Create
//
constructor TCustomCgShader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVertexProgram := TCgVertexProgram.Create(Self);
  FFragmentProgram := TCgFragmentProgram.Create(Self);
end;

// Destroy
//
destructor TCustomCgShader.Destroy;
begin
  inherited Destroy;
  FVertexProgram.Free;
  FFragmentProgram.Free;
end;

// IsProfileSupported
//
function TCustomCgShader.IsProfileSupported(Profile: TcgProfile): boolean;
begin
  result:=cgGLIsProfileSupported(Profile)=CG_TRUE;
end;

// SetVertexProgram
//
procedure TCustomCgShader.SetVertexProgram(const val : TCgVertexProgram);
begin
  FVertexProgram.Code := val.Code;
end;

// SetFragmentProgram
//
procedure TCustomCgShader.SetFragmentProgram(const val : TCgFragmentProgram);
begin
  FFragmentProgram.Code := val.Code;
end;

// SetOnApplyVertexProgram
//
procedure TCustomCgShader.SetOnApplyVertexProgram(const val : TCgApplyEvent);
begin
  FVertexProgram.OnApply := val;
end;

// GetOnApplyVertexProgram
//
function TCustomCgShader.GetOnApplyVertexProgram : TCgApplyEvent;
begin
  Result:=FVertexProgram.OnApply;
end;

// SetOnApplyFragmentProgram
//
procedure TCustomCgShader.SetOnApplyFragmentProgram(const val : TCgApplyEvent);
begin
  FFragmentProgram.OnApply:=val;
end;

// GetOnApplyFragmentProgram
//
function TCustomCgShader.GetOnApplyFragmentProgram : TCgApplyEvent;
begin
  Result:=FFragmentProgram.OnApply;
end;

// SetOnUnApplyVertexProgram
//
procedure TCustomCgShader.SetOnUnApplyVertexProgram(const val : TCgUnApplyEvent);
begin
  FVertexProgram.OnUnApply := val;
end;

// GetOnUnApplyVertexProgram
//
function TCustomCgShader.GetOnUnApplyVertexProgram : TCgUnApplyEvent;
begin
  Result:=FVertexProgram.OnUnApply;
end;

// SetOnUnApplyFragmentProgram
//
procedure TCustomCgShader.SetOnUnApplyFragmentProgram(const val : TCgUnApplyEvent);
begin
  FFragmentProgram.OnUnApply:=val;
end;

// GetOnUnApplyFragmentProgram
//
function TCustomCgShader.GetOnUnApplyFragmentProgram : TCgUnApplyEvent;
begin
  Result:=FFragmentProgram.OnUnApply;
end;

// GetOnInitialize
//
function TCustomCgShader.GetOnInitialize: TCgShaderEvent;
begin
  Result:=FOnInitialize;
end;

// SetOnInitialize
//
procedure TCustomCgShader.SetOnInitialize(const val: TCgShaderEvent);
begin
  FOnInitialize:=val;
end;

// DoInitialize
//
procedure TCustomCgShader.DoInitialize;
begin
  if (csDesigning in ComponentState) and (not FDesignEnable) then
    Exit;
  FVertexProgram.Initialize;
  FFragmentProgram.Initialize;

  if assigned(FOnInitialize) then FOnInitialize(self);
end;

// DoApply
//
procedure TCustomCgShader.DoApply(var rci : TRenderContextInfo; Sender : TObject);
begin
  if (csDesigning in ComponentState) and (not FDesignEnable) then
    Exit;
  FVertexProgram.Apply(rci, Sender);
  FFragmentProgram.Apply(rci, Sender);
end;

// DoUnApply
//
function TCustomCgShader.DoUnApply(var rci : TRenderContextInfo) : Boolean;
begin
  if (not (csDesigning in ComponentState)) or FDesignEnable then
  begin
    FVertexProgram.UnApply(rci);
    FFragmentProgram.UnApply(rci);
  end;
  Result := False;
end;

// DoFinalize
//
procedure TCustomCgShader.DoFinalize;
begin
  FVertexProgram.Finalize;
  FFragmentProgram.Finalize;
end;

// LoadShaderPrograms
//
procedure TCustomCgShader.LoadShaderPrograms(VPFilename,
  FPFilename: string);
begin
  VertexProgram.LoadFromFile(VPFilename);
  FragmentProgram.LoadFromFile(FPFilename);
end;

// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------
initialization
// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------

  // class registrations
  RegisterClass(TCustomCgShader);

  cgSetErrorCallBack(ErrorCallBack);

{$IFDEF OutputCompilerWarnings}
  CompilerMsg:=TStringList.Create;
{$ENDIF}

finalization
{$IFDEF OutputCompilerWarnings}
  CompilerMsg.SaveToFile(WarningFilename);
  CompilerMsg.free;
{$ENDIF}

end.

