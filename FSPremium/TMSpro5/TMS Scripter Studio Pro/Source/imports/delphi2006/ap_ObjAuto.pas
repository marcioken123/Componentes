{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright � 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_ObjAuto;

interface

uses
  TypInfo,
  ObjAuto,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatObjAutoLibrary = class(TatScripterLibrary)
    procedure __ReleaseMethodPointer(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TMethodInfoHeaderWrapper = class(TatRecordWrapper)
  private
    FLen: Word;
    FName: ShortString;
  public
    constructor Create(ARecord: TMethodInfoHeader);
    function ObjToRec: TMethodInfoHeader;
  published
    property Len: Word read FLen write FLen;
    property Name: ShortString read FName write FName;
  end;
  
  TReturnInfoWrapper = class(TatRecordWrapper)
  private
    FVersion: Byte;
    FCallingConvention: TCallingConvention;
    FParamSize: Word;
  public
    constructor Create(ARecord: TReturnInfo);
    function ObjToRec: TReturnInfo;
  published
    property Version: Byte read FVersion write FVersion;
    property CallingConvention: TCallingConvention read FCallingConvention write FCallingConvention;
    property ParamSize: Word read FParamSize write FParamSize;
  end;
  
  TParamInfoWrapper = class(TatRecordWrapper)
  private
    FFlags: TParamFlags;
    FAccess: Word;
    FName: ShortString;
  public
    constructor Create(ARecord: TParamInfo);
    function ObjToRec: TParamInfo;
  published
    property Flags: TParamFlags read FFlags write FFlags;
    property Access: Word read FAccess write FAccess;
    property Name: ShortString read FName write FName;
  end;
  

implementation

constructor TMethodInfoHeaderWrapper.Create(ARecord: TMethodInfoHeader);
begin
  inherited Create;
  FLen := ARecord.Len;
  FName := ARecord.Name;
end;

function TMethodInfoHeaderWrapper.ObjToRec: TMethodInfoHeader;
begin
  result.Len := FLen;
  result.Name := FName;
end;

constructor TReturnInfoWrapper.Create(ARecord: TReturnInfo);
begin
  inherited Create;
  FVersion := ARecord.Version;
  FCallingConvention := ARecord.CallingConvention;
  FParamSize := ARecord.ParamSize;
end;

function TReturnInfoWrapper.ObjToRec: TReturnInfo;
begin
  result.Version := FVersion;
  result.CallingConvention := FCallingConvention;
  result.ParamSize := FParamSize;
end;

constructor TParamInfoWrapper.Create(ARecord: TParamInfo);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FAccess := ARecord.Access;
  FName := ARecord.Name;
end;

function TParamInfoWrapper.ObjToRec: TParamInfo;
begin
  result.Flags := FFlags;
  result.Access := FAccess;
  result.Name := FName;
end;



procedure TatObjAutoLibrary.__ReleaseMethodPointer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ObjAuto.ReleaseMethodPointer(TMethodWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatObjAutoLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ReleaseMethodPointer',1,tkNone,nil,__ReleaseMethodPointer,false,0);
    AddConstant('ccRegister',ccRegister);
    AddConstant('ccCdecl',ccCdecl);
    AddConstant('ccPascal',ccPascal);
    AddConstant('ccStdCall',ccStdCall);
    AddConstant('ccSafeCall',ccSafeCall);
    AddConstant('paEAX',paEAX);
    AddConstant('paEDX',paEDX);
    AddConstant('paECX',paECX);
    AddConstant('paStack',paStack);
  end;
end;

class function TatObjAutoLibrary.LibraryName: string;
begin
  result := 'ObjAuto';
end;

initialization
  RegisterScripterLibrary(TatObjAutoLibrary, True);

{$WARNINGS ON}

end.

