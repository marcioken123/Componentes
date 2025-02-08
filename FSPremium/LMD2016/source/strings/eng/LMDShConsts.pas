unit LMDShConsts;
{###############################################################################

LMDShConsts unit (DS)
------------------------
Contains ShellPack constants


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  // error messages
  IDSHELL_ErrShVersion                 = 'Operation not supported in this version of the shell';
  IDSHELL_ErrInvalidFolder             = 'Invalid folder';


  IDSHELL_ABOUT                 = 'About...';
  IDSHELL_OK                    = 'Ok';
  IDSHELL_CANCEL                = 'Cancel';

  IDSHELL_ColumnName            = 'Name';
  IDSHELL_ColumnSize            = 'Size';
  IDSHELL_ColumnType            = 'Type';
  IDSHELL_ColumnAttr            = 'Attr';
  IDSHELL_ColumnCreateDate      = 'Create Date';
  IDSHELL_ColumnCreateTime      = 'Create Time';
  IDSHELL_ColumnAccessDate      = 'Last Access Date';
  IDSHELL_ColumnAccessTime      = 'Last Access Time';
  IDSHELL_ColumnWriteDate       = 'Date Modified';
  IDSHELL_ColumnWriteTime       = 'Time Modified';
  IDSHELL_ColumnModified        = 'Modified';

  sBrowseForFolder              = 'Browse for Folder';
  sBrowseInstruction            = 'Please choose a Folder';
  sDeleteFolderHint             = 'Delete selected Folder.';
  sCreateFolderHint             = 'Create new Folder.';
  sEmpty                        = '(Empty)';
  sNewFolderName                = 'New Folder';
  sDuplicatedPath               = 'Path already exists in List!';
  sPickRootPath                 = 'Please select a root path';
  sEditRoot                     = 'E&dit Root';
  sPathCaption                  = 'Directories';

  // LMDSHListDlg
  IDSHELL_SELECTDETAILS         = 'Select details';
  IDSHELL_DEFAULTCOLUMNS        = 'Use default columns';
  IDSHELL_BUTTONUP              = 'Move up';
  IDSHELL_BUTTONDOWN            = 'Move down';
  IDSHELL_WIDTHCAPTION          = 'Width of selected column (in pixel):';
  IDSHELL_COLINSTRUCTION        = 'Select the detail columns from list below which should be shown for file folders';
  IDSHELL_HIDE                  = 'Hide';
  IDSHELL_DISPLAY               = 'Display';

  // Filter Dialog
  IDSHELL_SpecifyFilter         = 'Specify Filter...';
  IDSHELL_FilterInstruction     = 'Filter Items are separated by semi-colons.';
  IDSHELL_FilterOptions         = 'Disable Filter'#13#10'Files only'#13#10'Files and Folders';
  IDSHELL_Filters               = 'Filters';
  IDSHELL_ApplyFilter           = 'Apply Filter to...';

  IDSHELL_COPYTO                = 'Copy to...';
  IDSHELL_COPYTOINST            = 'Click on folder where item(s) should be copied to.';
  IDSHELL_MOVETO                = 'Move to...';
  IDSHELL_MOVETOINST            = 'Click on folder where item(s) should be moved to.';
  IDSHELL_SHOWPROPERTIES        = 'Properties';
  IDSHELL_RENAME                = 'Rename';
  IDSHELL_OPENWITH              = 'Open With...';
  IDSHELL_OPEN                  = 'Open';
  IDSHELL_CREATEFOLDER          = 'Create Folder';
  IDSHELL_RUN                   = 'Run';
  IDSHELL_MAILTO                = 'Mail To...';
  IDSHELL_BACKWARD              = 'Backward';
  IDSHELL_FORWARD               = 'Forward';
  IDSHELL_UPLEVEL               = 'Level up';
  IDSHELL_CUT                   = 'Cut';
  IDSHELL_COPY                  = 'Copy';
  IDSHELL_PASTE                 = 'Paste';
  IDSHELL_DELETE                = 'Delete';
  IDSHELL_SELECTALL             = 'Select All';
  IDSHELL_INVERTSELECTION       = 'Invert Selection';
  IDSHELL_OPENDOSWINDOW         = 'Open Dos Window';
  IDSHELL_FINDFILES             = 'Find Files...';
  IDSHELL_FINDCOMPUTER          = 'Find Computer...';
  IDSHELL_FORMATDISK            = 'Format Disk...';
  IDSHELL_SELECTDISKFORMAT      = 'Select disk to format';
  IDSHELL_COPYDISK              = 'Copy Disk...';
  IDSHELL_MAPDRIVE              = 'Map Drive...';
  IDSHELL_UNMAPDRIVE            = 'UnMap Drive...';
  IDSHELL_EDITDISKLABEL         = 'Label Disk ...';
  IDSHELL_SELECTDISKLABEL       = 'Select disk to label';
  IDSHELL_FILTER                = 'Filter...';
  IDSHELL_COPYFILENAMEASTEXT    = 'Copy FileName as Text';
  IDSHELL_COPYPATHNAMEASTEXT    = 'Copy FilePath as Text';
  IDSHELL_VIEW                  = 'View';

implementation


end.
