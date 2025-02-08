type
  TLMDPackageID = (
    pi_LMD_BAR,
    pi_LMD_CHART,
    pi_LMD_CORE,
    pi_LMD_DESIGN,
    pi_LMD_DIALOG,
    pi_LMD_DOCKING,
    pi_LMD_ELCORE,
    pi_LMD_ELPRO,
    pi_LMD_FX,
    pi_LMD_GRID,
    pi_LMD_IDE,
    pi_LMD_INSPECTOR,
    pi_LMD_LEGACY,
    pi_LMD_LOG,
    pi_LMD_PLUGIN,
    pi_LMD_PRINT,
    pi_LMD_RTF,
    pi_LMD_RTL,
    pi_LMD_RTLX,
    pi_LMD_SCRIPT,
    pi_LMD_SEARCH,
    pi_LMD_SHELL,
    pi_LMD_STORAGE,
    pi_LMD_SYNTAX,
    pi_LMD_SYS,
    pi_LMD_THEMES,
    pi_LMD_TOOLS,
    pi_LMD_TXT,
    pi_LMD_WEB
  );

const
  LMDPackageInfo: array[Low(TLMDPackageID)..High(TLMDPackageID)] of
    record
      Name:        string;  // Name of product.
      Version:     string;  // Version number as string.
      ReleaseDate: string;  // Release date.
    end = (
      (Name: 'LMD BarPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD ChartPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD-Tools'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD DesignPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD DialogPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD DockingPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD ElPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD ElPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD FxPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD GridPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD IDE-Tools'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD InspectorPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD-Tools'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD Logging'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD Plug-In'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD PrintPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD RichPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD-Tools'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD-Tools'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD ScriptPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD SearchPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD ShellPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD StoragePack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD SyntaxEdit'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD SysPack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD Themes'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD-Tools'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD ParsePack'; Version: '2016.5'; ReleaseDate: '20-04-2016'),
      (Name: 'LMD WebPack'; Version: '2016.5'; ReleaseDate: '20-04-2016')
  );
