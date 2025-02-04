{LMD-TOOLS V6.X - © 2002 by LMD Innovative}
{******************************************************************************}

{***************** LMD Tools or package ***************************************}
{$DEFINE LMD_TOOLS}

{***************** Windows NT3.51 compatibility *******************************}
{.$DEFINE WINNT351}
{to achive full NT 3.51 compatability activate compiler switch}

{*************** Determine Delphi/CBuilder Version ****************************}
{$IFDEF VER130}
  {$DEFINE LMDCOMP5}
  {$IFDEF BCB}
    {$DEFINE CPPBUILDER}
    {$DEFINE CBUILDER5}
  {$ELSE}
    {$DEFINE DELPHI5}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER140}
  {$DEFINE LMDCOMP5}
  {$DEFINE LMDCOMP6}
  {$IFDEF BCB}
    {$DEFINE CPPBUILDER}
    {$DEFINE CBUILDER6}
  {$ELSE}
    {$DEFINE DELPHI6}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER150}
  {$DEFINE LMDCOMP5}
  {$DEFINE LMDCOMP6}
  {$DEFINE LMDCOMP7}
  {$IFDEF BCB}
    {$DEFINE CPPBUILDER}
    {$DEFINE CBUILDER7}
  {$ELSE}
    {$DEFINE DELPHI7}
  {$ENDIF}
{$ENDIF}
