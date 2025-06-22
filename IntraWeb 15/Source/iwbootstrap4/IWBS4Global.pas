unit IWBS4Global;

interface

uses
  Classes, SysUtils, IWBS4LayoutMgr;

// ATENTION!!!!, Global files should only be modified in TIWServerController.OnConfig event, they are not Thread Safe.
// only Boolean vars (for enable/disable plugins) could be changed anytime, because boleans vars work with attomic read/write
var
  // paths to framework JS and CSS files
  gIWBS4LibPath: string = '/iwbs/';

  // path for JQuery library (required)
  gIWBS4LibJQueryJs: string = '/<iwbspath>/jquery.min.js';     // current version is 3.6.4, same as IW

  // path for Popper (required)
  gIWBS4LibPopperJs: string = '/<iwbspath>/popper.min.js';

  // path for bootstrap library (required)
  gIWBS4LibBootstrapCss: string = '/<iwbspath>/bootstrap-4.3.1/css/bootstrap.min.css';
  gIWBS4LibBootstrapJs: string = '/<iwbspath>/bootstrap-4.3.1/js/bootstrap.min.js';
  gIWBS4FontAwesomeCss: string = '/<iwbspath>/font-awesome/4.7.0/css/font-awesome.min.css';

  // would like to include Google Material Icons
//gIWBS4GoogleMaterialCss: string = '<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">'
  gIWBS4GoogleMaterialCss: string;

  // path for iwbs support files (required) -- we're going to try to get away without them (mostly styles for wells, which do not exist in BS4)
  gIWBS4LibIWBSCss: string = '/<iwbspath>/iwbs.css';
  gIWBS4LibIWBSJs: string = '/<iwbspath>/iwbs.js';

  // path for Polyfiller library, it provides full support for html5 to older browsers (optional)
  gIWBS4LibPolyFiller: Boolean = True;
  gIWBS4LibPolyFillerJs: string = '/<iwbspath>/webshim-1.15.10/js-webshim/minified/polyfiller.js';

  // path for Dynamic Tabs plugin (optional)
  gIWBS4LibDynamicTabs: Boolean = True;
  gIWBS4LibDynamicTabsCss: string = '/<iwbspath>/dyntabs/bootstrap-dynamic-tabs.css';
  gIWBS4LibDynamicTabsJs: string = '/<iwbspath>/dyntabs/bootstrap-dynamic-tabs.js';

  // path for Summernote plugin (optional)
  gIWBSLibSummerNote: Boolean = False;
  gIWBSLibSummerNoteCss: string = '/<iwbspath>/summernote/dist/summernote.css';
  gIWBSLibSummerNoteJs: string = '/<iwbspath>/summernote/dist/summernote.js';

  // configurations for design time grid
  gIWBS4RenderingSortMethod: TIWBS4RenderingSortMethod = bs4rmSortYX;
  gIWBS4RenderingGridPrecision: Integer = 12;

  // server start timestamp value in format string, it is usefull to force client refresh cache browsers of included files
  gIWBS4RefreshCacheParam: string = '';

  // occurs for each control, after component is changed on an Asyn call, it doesn't occurs if the control is fully rendered
  // useful for execute a refresh on third party plugins that need it
  gIWBS4OnAfterAsyncChange: procedure(AControl: TComponent; const AHTMLName);

  // occurs for each control, after control is rendered
  gIWBS4OnAfterRender: procedure(AControl: TComponent);

  // occurs for each control, before control is rendered
  // useful for set common properties to certain components, for examplë: to enable third party plugins
  gIWBS4OnRender: procedure(AControl: TComponent);

  // global link files to include in every page
  gIWBS4LinkFiles: TStringList = nil;

  // render a custom attribute on every control with the component name as value
  // this help to easy find controls in javascript
  gIWBS4AttributeCmpName: string = '';  // for example: data-cmp-name

procedure IWBS4AddGlobalLinkFile(const AFile: string);

procedure IWBS4LibSetCDNS;

implementation

// to add global files should be done in any place before server start working, it's not thread safe
// in initialization section
// IWServerController.OnConfig
// IWServerController.OnCreate
// etc...

procedure IWBS4AddGlobalLinkFile(const AFile: string);
begin
  if gIWBS4LinkFiles = nil then
  begin
    gIWBS4LinkFiles := TStringList.Create;
  end;

  if gIWBS4LinkFiles.IndexOf(AFile) = -1 then
  begin
    gIWBS4LinkFiles.Add(AFile);
  end;
end;

procedure IWBS4LibSetCDNS;
begin
  gIWBS4LibJQueryJS := 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js';

  gIWBS4LibPopperJs := 'https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js';

  gIWBS4LibBootstrapCss := 'https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css';
  gIWBS4LibBootstrapJs := 'https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js';

  gIWBS4FontAwesomeCss := 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css';
  gIWBS4GoogleMaterialCss := 'https://fonts.googleapis.com/icon?family=Material+Icons';

  gIWBS4LibPolyFillerJs := 'https://cdnjs.cloudflare.com/ajax/libs/webshim/1.15.10/dev/polyfiller.js';

  //gIWBS4LibSummerNoteCss := 'https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.css';
  //gIWBS4LibSummerNoteJs := 'https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js';

  // Content kept in Github/Atozed repo, delivered via cdn.jsdelivr.net
  gIWBS4LibIWBSCss := 'https://cdn.jsdelivr.net/gh/Atozed/iwbs@v1.1/iwbs.min.css';
  gIWBS4LibIWBSJs := 'https://cdn.jsdelivr.net/gh/Atozed/iwbs@v1.1/iwbs.min.js';

  gIWBS4LibDynamicTabsCss := 'https://cdn.jsdelivr.net/gh/Atozed/iwbs@v1.1/dyntabs/bootstrap-dynamic-tabs.min.css';
  gIWBS4LibDynamicTabsJs := 'https://cdn.jsdelivr.net/gh/Atozed/iwbs@v1.1/dyntabs/bootstrap-dynamic-tabs.min.js';
end;

initialization
  gIWBS4RefreshCacheParam := FormatDateTime('yyyymmddhhnnsszzz', now);


finalization
  FreeAndNil(gIWBS4LinkFiles);

end.

