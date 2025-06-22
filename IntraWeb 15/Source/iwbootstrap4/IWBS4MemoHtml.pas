unit IWBS4MemoHtml;

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, StrUtils, IWRenderContext, IWApplication, IWBaseHTMLControl,
  IWBS4Input;

type
  {$include IWPlatformAttrib.inc}
  TIWBS4MemoHtml = class(TIWBS4Memo)
  protected
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
  end;

implementation

uses
  IWBS4Global, IWBS4Utils;

procedure TIWBS4MemoHtml.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
//var
//lTextChang, lEnabChang: Boolean;
begin
 {lTextChang := FText <> FOldText;
  lEnabChang := (IsDisabled <> FOldDisabled) or (IsReadOnly <> FOldReadOnly);}

  inherited;

  // Bring back summernote later if there is time
 {if lTextChang then
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + AHTMLName + '").summernote("code", "' + TIWBaseHTMLControl.TextToJSStringLiteral(Text) + '");', True, True);
  if lEnabChang then
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + AHTMLName + '").summernote("' + IfThen(IsReadOnly or IsDisabled, 'disable', 'enable')+'");', False, True);}
end;

procedure TIWBS4MemoHtml.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
//var
//s: string;
begin
  inherited;

  // Bring back summernote later if there is time
(*s := '$("#' + AHTMLName + '").summernote({ callbacks: { onChange: function(contents, $editable) { $("#' + AHTMLName+'").change(); } } })';
  if IsReadOnly or IsDisabled then
    s := s + '.summernote("disable")';
  s := s + ';';
  AScript.Add(s);*)
end;

initialization
//gIWBS4LibSummerNote := True;



end.

