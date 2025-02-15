{LMD-TOOLS V6.X - � 2001 by LMD Innovative}
{******************************************************************************}

{ Specifies various compiler settings }
{ Which parts of LMD-Tools should be installed? These compiler switches help you
  to turn off installation of complete component groups. You may finetune these
  settings by changing registration source files manually.
}
{$DEFINE LMDDEFAULTCP}     {default components, do not deactivate! -> lmdregst.pas}
{$DEFINE LMDCONTAINERCP}   {LMD-Tools Container Controls, lmdregcont.pas}
{$DEFINE LMDEDITCP}        {Edit controls -> lmdregec.pas}
{$DEFINE LMDLABELEDEDITCP} {Edit control with bounded labels -> lmreglec.pas}
{$DEFINE LMDLISTCP}        {List-/Combobox controls -> lmdreglc.pas}
{$DEFINE LMDLABELEDLISTCP} {List-/Combobox controls with bounded labels -> -> lmreglec.pas}
{$DEFINE LMDEXTENDEDCP}    {extended components -> lmdregex.pas}
{$DEFINE LMDDIALOGCP}      {extended components -> lmdregdg.pas}
{$DEFINE LMDFORM}          {components concerning with forms}
{$DEFINE LMDSYSTEMCP}      {extended components -> lmdregsy.pas}
{$DEFINE LMDMMCP}          {multimedia components -> lmdregmm.pas}
{$DEFINE LMDDBCP}          {datansensitive components -> lmdregdb.pas}
{$DEFINE LMDDBEDCP}        {datansensitive components -> lmdregdbed.pas}
{$DEFINE LMDDBLC}          {datasensitive components -> lmdregdblc.pas}
{$DEFINE LMDSHELLCP}       {datansensitive components -> lmdregshell.pas}
{$DEFINE LMDCUSTOMEDITORS} {custom property editors (e.g. TBrush) -> lmdreged.pas}

//old controls
{$DEFINE LMDV3CP}          {obsolete LMD V3.x components}



{Specifies descriptions for components in Delphi IDE}
{------------------------------------------------------------------------------}
const
  CTRL_CONTAINER:String='LMD Cont';
  CTRL_DATABASE:String='LMD DB';
  CTRL_DATABASE_EDIT:String='LMD DB Edit';
  CTRL_DATABASE_LIST:String='LMD DB List';
  CTRL_DATABASE_EDIT_LABELED:String='LMD DB Edit Labeled';
  CTRL_DIALOG:String='LMD Dlg';
  CTRL_EXTENDED:String='LMD Ext';
  CTRL_MULTIMEDIA:String='LMD MM';
  CTRL_STANDARD:String='LMD Std';
  CTRL_EDIT:String='LMD Edit';
  CTRL_EDIT_LABELED:String='LMD Labeled Edit';
  CTRL_LIST_LABELED:String='LMD Labeled List';
  CTRL_LIST:String='LMD List';
  CTRL_SYSTEM:String='LMD Sys';
  CTRL_FORM:String='LMD Form';
  CTRL_SHELL:String='LMD Shell';
  CTRL_V3COMP:String='LMD 3.X';

  CTRL_WEB20:String='LMD Web';


