{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Alexandre Rocha Lima e Marcondes -  arlm@users.sourceforge.net               }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 20/05/2004: Primeira Versao
|*    Alexandre Rocha Lima e Marcondes
|*    Cria�ao e Distribui�ao da Primeira Versao
|* 06/04/2005: Atualiza��o
|*    Alexandre Rocha Lima e Marcondes
|*    Suporte para o Kylix 1, 2 e 3; Delphi 8 e 9; identifica��o da VisualCLX
******************************************************************************}

{-----------------------------------------------------------------------------
 *** Extraido de jedi.inc  - Project JEDI Code Library (JCL) ***
 ---------------------------------------------------------------------------- }

(*

- Diretivas de ambiente de compila��o

  Este arquivo define duas diretivas para indicar em qual ambiente de
  desenvolvimento a biblioteca est� sendo compilada.

  Diretiva     Descri��o
  ------------------------------------------------------------------------------
  DELPHI           Defined if compiled with Delphi
  KYLIX            Defined if compiled with Kylix
  DELPHICOMPILER   Defined if compiled with Delphi or Kylix/Delphi
  BCB              Defined if compiled with C++ Builder
  CPPBUILDER       Defined if compiled with C++ Builder (alias for BCB)
  BCBCOMPILER      Defined if compiled with C++ Builder or Kylix/C++
  DELPHILANGUAGE   Defined if compiled with Delphi, Kylix or C++ Builder
  BORLAND          Defined if compiled with Delphi, Kylix or C++ Builder
  FPC              Defined if compiled with FPC
  
- Diretivas de plataforma

  Diretivas de plataforma n�o s�o definidas explicitamente neste arquivo, mas
  s�o definidas pelo compilador. Est�o listadas aqui para a documenta��o ficar
  completa.

  Diretiva     Descri��o
  ------------------------------------------------------------------------------
  WIN32        Defined when target platform is 32 bit Windows
  MSWINDOWS    Defined when target platform is 32 bit Windows
  LINUX        Defined when target platform is Linux
  UNIX         Defined when target platform is Linux or Unix

- Diretivas da biblioteca Visual

  The following directives indicate for a visual library. In a Delphi
  application you need to define VisualCLX in the project options, if you want
  to use the VisualCLX. Alternative you can use the IDE expert, which is distributed
  with the JCL to do this automatically.

  Directive    Description
  ------------------------------------------------------------------------------
  COMPLIB_VCL  Defined when application do not define VisualCLX, obsolete, use VCL
  COMPLIB_CLX  Defined when application use the VisualCLX, obsolete, use VisualCLX
  VCL          Defined when application do not define VisualCLX
  VisualCLX    Defined when application use the VisualCLX

- Vers�es do Delphi

  As diretivas a seguir s�o resultado de um mapeamento direto das diretivas
  VERXXX para um nome mais amigavel. Essas diretivas ser�o apenas definidas se
  o compilador for DELPHI (isto �, a diretiva DELPHI estiver definida).

  Diretiva     Descri��o
  ------------------------------------------------------------------------------
  DELPHI1      Definida quando compilado com Delphi 1
  DELPHI2      Definida quando compilado com Delphi 2
  DELPHI3      Definida quando compilado com Delphi 3
  DELPHI4      Definida quando compilado com Delphi 4
  DELPHI5      Definida quando compilado com Delphi 5
  DELPHI6      Definida quando compilado com Delphi 6
  DELPHI7      Definida quando compilado com Delphi 7
  DELPHI8      Defined when compiling with Delphi 8
  DELPHI9      Defined when compiling with Delphi 9
  DELPHI1_UP   Definida quando compilado com Delphi 1 ou superior
  DELPHI2_UP   Definida quando compilado com Delphi 2 ou superior
  DELPHI3_UP   Definida quando compilado com Delphi 3 ou superior
  DELPHI4_UP   Definida quando compilado com Delphi 4 ou superior
  DELPHI5_UP   Definida quando compilado com Delphi 5 ou superior
  DELPHI6_UP   Definida quando compilado com Delphi 6 ou superior
  DELPHI7_UP   Definida quando compilado com Delphi 7 ou superior
  DELPHI8_UP   Defined when compiling with Delphi 8 or higher
  DELPHI9_UP   Defined when compiling with Delphi 9 or higher

- Cers�es do Kylix

  The following directives are direct mappings from the VERXXX directives to a
  friendly name of the associated compiler. These directives are only defined if
  the compiler is Kylix (ie KYLIX is defined).

  Directive    Description
  ------------------------------------------------------------------------------
  KYLIX1       Defined when compiling with Kylix 1
  KYLIX2       Defined when compiling with Kylix 2
  KYLIX3       Defined when compiling with Kylix 3
  KYLIX1_UP    Defined when compiling with Kylix 1 or higher
  KYLIX2_UP    Defined when compiling with Kylix 2 or higher
  KYLIX3_UP    Defined when compiling with Kylix 3 or higher

- Vers�es do compilador Delphi (Delphi / Kylix, n�o no modo BCB)

  Directive           Description
  ------------------------------------------------------------------------------
  DELPHICOMPILER1     Defined when compiling with Delphi 1
  DELPHICOMPILER2     Defined when compiling with Delphi 2
  DELPHICOMPILER3     Defined when compiling with Delphi 3
  DELPHICOMPILER4     Defined when compiling with Delphi 4
  DELPHICOMPILER5     Defined when compiling with Delphi 5
  DELPHICOMPILER6     Defined when compiling with Delphi 6 or Kylix 1, 2 or 3
  DELPHICOMPILER7     Defined when compiling with Delphi 7
  DELPHICOMPILER8     Defined when compiling with Delphi 8
  DELPHICOMPILER9     Defined when compiling with Delphi 9
  DELPHICOMPILER1_UP  Defined when compiling with Delphi 1 or higher
  DELPHICOMPILER2_UP  Defined when compiling with Delphi 2 or higher
  DELPHICOMPILER3_UP  Defined when compiling with Delphi 3 or higher
  DELPHICOMPILER4_UP  Defined when compiling with Delphi 4 or higher
  DELPHICOMPILER5_UP  Defined when compiling with Delphi 5 or higher
  DELPHICOMPILER6_UP  Defined when compiling with Delphi 6 or Kylix 1, 2 or 3 or higher
  DELPHICOMPILER7_UP  Defined when compiling with Delphi 7 or higher
  DELPHICOMPILER8_UP  Defined when compiling with Delphi 8 or higher
  DELPHICOMPILER9_UP  Defined when compiling with Delphi 9 or higher

- Vers�es do C++ Builder

  As diretivas a seguir s�o resultado de um mapeamento direto das diretivas
  VERXXX para um nome mais amigavel. Essas diretivas ser�o apenas definidas se
  o compilador for C++ Builder (isto �, a diretiva BCB estiver definida).

  Diretiva     Descri��o
  ------------------------------------------------------------------------------
  BCB1         Definida quando compilado com C++ Builder 1
  BCB3         Definida quando compilado com C++ Builder 3
  BCB4         Definida quando compilado com C++ Builder 4
  BCB5         Definida quando compilado com C++ Builder 5
  BCB6         Definida quando compilado com C++ Builder 6
  BCB7         Definida quando compilado com C++ Builder 7
  BCB1_UP      Definida quando compilado com C++ Builder 1 ou superior
  BCB3_UP      Definida quando compilado com C++ Builder 3 ou superior
  BCB4_UP      Definida quando compilado com C++ Builder 4 ou superior
  BCB5_UP      Definida quando compilado com C++ Builder 5 ou superior
  BCB6_UP      Definida quando compilado com C++ Builder 6 ou superior
  BCB7_UP      Definida quando compilado com C++ Builder 7 ou superior

- Vers�es do Compilador

  As diretivas a seguir s�o resultado de um mapeamento direto das diretivas
  VERXXX para um nome mais amigavel. Diferentemente das diretivas DELPHI_X e
  BCB_X, estas diretivas s�o independentes do ambiente de desenvolvimento.
  O que quer dizer que s�o definidas independente de ser compilado usando Delphi
  ou C++ Builder.

  Diretiva     Descri��o
  ------------------------------------------------------------------------------
  COMPILER1    Definida quando compilado com Delphi 1
  COMPILER2    Definida quando compilado com Delphi 2 ou C++ Builder 1
  COMPILER3    Definida quando compilado com Delphi 3
  COMPILER35   Definida quando compilado com C++ Builder 3
  COMPILER4    Definida quando compilado com Delphi 4 ou C++ Builder 4
  COMPILER5    Definida quando compilado com Delphi 5 ou C++ Builder 5
  COMPILER6    Definida quando compilado com Delphi 6 ou C++ Builder 6
  COMPILER7    Definida quando compilado com Delphi 7 ou C++ Builder 7
  COMPILER8     Defined when compiling with Delphi 8
  COMPILER9     Defined when compiling with Delphi 9
  COMPILER1_UP Definida quando compilado com Delphi 1 ou superior
  COMPILER2_UP Definida quando compilado com Delphi 2, C++ Builder 1 ou superior
  COMPILER3_UP Definida quando compilado com Delphi 3 ou superior
  COMPILER35UP Definida quando compilado com C++ Builder 3 ou superior
  COMPILER4_UP Definida quando compilado com Delphi 4, C++ Builder 4 ou superior
  COMPILER5_UP Definida quando compilado com Delphi 5, C++ Builder 5 ou superior
  COMPILER6_UP Definida quando compilado com Delphi 6, C++ Builder 6 ou superior
  COMPILER7_UP Definida quando compilado com Delphi 7, C++ Builder 6 ou superior
  COMPILER8_UP  Defined when compiling with Delphi 8
  COMPILER9_UP  Defined when compiling with Delphi 9

- Vers�es da RTL

  Por exemplo, use o seguinte c�digo para determinar a vers�o exata da RTL,
  desde a vers�o 14.0:
    {$IFDEF CONDITIONALEXPRESSIONS}
      {$IF Declared(RTLVersion) and (RTLVersion >= 14.2)}
        // c�digo para o Delphi 6.02 ou superior, Kylix 2 ou superior, C++ Builder 6 ou superior
        ...
      {$IFEND}
    {$ENDIF}

  Diretiva      Descri��o
  ------------------------------------------------------------------------------
  RTL80_UP      Defined when compiling with Delphi 1 or later
  RTL90_UP      Defined when compiling with Delphi 2 or later
  RTL93_UP      Defined when compiling with C++ Builder 1 or later
  RTL100_UP     Defined when compiling with Delphi 3 or later
  RTL110_UP     Defined when compiling with C++ Builder 3 or later
  RTL120_UP     Defined when compiling with Delphi 4 or later
  RTL125_UP     Defined when compiling with C++ Builder 4 or later
  RTL130_UP     Defined when compiling with Delphi 5 or C++ Builder 5 or later
  RTL140_UP     Defined when compiling with Delphi 6, Kylix 1, 2 or 3 or C++ Builder 6 or later
  RTL150_UP     Defined when compiling with Delphi 7 or later
  RTL160_UP     Defined when compiling with Delphi 8 or later
  RTL170_UP     Defined when compiling with Delphi 9 or later

- Diretivas de Recursos

  As diretivas de recuso s�o usadas para testar se o compilador suporta recursos
  espec�ficos, como overload de m�todos, e ajusta os fontes de acordo. O uso
  dessas diretivas � preferido ao inv�s das diretivas DELPHI e COMPILER.

  Diretiva                      Descri��o
  ------------------------------------------------------------------------------
  SUPPORTS_CONSTPARAMS          Compiler supports const parameters (D1+)
  SUPPORTS_SINGLE               Compiler supports the Single type (D1+)
  SUPPORTS_DOUBLE               Compiler supports the Double type (D1+)
  SUPPORTS_EXTENDED             Compiler supports the Extended type (D1+)
  SUPPORTS_CURRENCY             Compiler supports the Currency type (D2+)
  SUPPORTS_THREADVAR            Compiler supports threadvar declarations (D2+)
  SUPPORTS_OUTPARAMS            Compiler supports out parameters (D3+)
  SUPPORTS_VARIANT              Compiler supports variant (D2+)
  SUPPORTS_WIDECHAR             Compiler supports the WideChar type (D2+)
  SUPPORTS_WIDESTRING           Compiler supports the WideString type (D3+/BCB3+)
  SUPPORTS_INTERFACE            Compiler supports interfaces (D3+/BCB3+)
  SUPPORTS_DISPINTERFACE        Compiler supports dispinterfaces (D3+/BCB3+)
  SUPPORTS_EXTSYM               Compiler supports the $EXTERNALSYM directive (D4+/BCB3+)
  SUPPORTS_NODEFINE             Compiler supports the $NODEFINE directive (D4+/BCB3+)
  SUPPORTS_LONGWORD             Compiler supports the LongWord type (unsigned 32 bit) (D4+/BCB4+)
  SUPPORTS_INT64                Compiler supports the Int64 type (D4+/BCB4+)
  SUPPORTS_DYNAMICARRAYS        Compiler supports dynamic arrays (D4+/BCB4+)
  SUPPORTS_DEFAULTPARAMS        Compiler supports default parameters (D4+/BCB4+)
  SUPPORTS_OVERLOAD             Compiler supports overloading (D4+/BCB4+)
  SUPPORTS_IMPLEMENTS           Compiler supports implements (D4+/BCB4+)
  SUPPORTS_DEPRECATED           Compiler supports the deprecated directive (D6+/BCB6+)
  SUPPORTS_PLATFORM             Compiler supports the platform directive (D6+/BCB6+)
  SUPPORTS_LIBRARY              Compiler supports the library directive (D6+/BCB6+)
  SUPPORTS_LOCAL                Compiler supports the local directive (D6+/BCB6+)
  SUPPORTS_INLINE               Compiler supports the inline directive (D9+)
  ACCEPT_DEPRECATED             Compiler supports or ignore the deprecated directive (D6/BCB6/FPC)
  ACCEPT_PLATFORM               Compiler supports or ignore the platform directive (D6+/BCB6+)
  ACCEPT_LIBRARY                Compiler supports or ignore the library directive (D6+/BCB6+)
  SUPPORTS_CUSTOMVARIANTS       Compiler supports custom variants (D6+/BCB6+)
  SUPPORTS_VARARGS              Compiler supports varargs (D6+/BCB6+)
  SUPPORTS_ENUMVALUE            Compiler supports values for enums (D6+/BCB6+)
  SUPPORTS_DEPRECATED_WARNINGS  Compiler supports deprecated warnings (D6+/BCB6+)
  SUPPORTS_LIBRARY_WARNINGS     Compiler supports library warnings (D6+/BCB6+)
  SUPPORTS_PLATFORM_WARNINGS    Compiler supports platform warnings (D6+/BCB6+)
  SUPPORTS_UNSAFE_WARNINGS      Compiler supports unsafe warnings (D7)
  SUPPORTS_WEAKPACKAGEUNIT      Compiler supports the WEAKPACKAGEUNIT directive
  SUPPORTS_COMPILETIME_MESSAGES Compiler supports the MESSAGE directive
  HAS_UNIT_LIBC                 The unit Libc exists (Kylix, FPC on Linux)
  HAS_UNIT_RTLCONSTS            The unit RTLConsts exists (D6+/BCB6+)
  HAS_UNIT_TYPES                The unit Types exists (D6+/BCB6+)
  HAS_UNIT_VARIANTS             The unit Variants exists (D6+/BCB6+)
  HAS_UNIT_STRUTILS             The unit StrUtils exists (D6+/BCB6+)
  XPLATFORM_RTL                 The RTL supports crossplatform function names (e.g. RaiseLastOSError) (D6+/BCB6+/FPC)

- Configura��es de compila��o

  As diretivas de configura��o de compila��o indicam que uma configura��o
  espec�fica de compila��o est� habilitada. Isto facilita a altera��o local das
  configura��es de um modo mais compacto e de leitura mais f�cil.

  Diretiva              Descri��o
  ------------------------------------------------------------------------------
  ALIGN_ON              Compilando com o estado A+ (no alignment)
  BOOLEVAL_ON           Compilando com o estado B+ (complete boolean evaluation)
  ASSERTIONS_ON         Compilando com o estado C+ (assertions on)
  DEBUGINFO_ON          Compilando com o estado D+ (debug info generation on)
  IMPORTEDDATA_ON       Compilando com o estado G+ (creation of imported data references)
  LONGSTRINGS_ON        Compilando com o estado H+ (string defined as AnsiString)
  IOCHECKS_ON           Compilando com o estado I+ (I/O checking enabled)
  WRITEABLECONST_ON     Compilando com o estado J+ (typed constants can be modified)
  LOCALSYMBOLS          Compilando com o estado L+ (local symbol generation)
  TYPEINFO_ON           Compilando com o estado M+ (RTTI generation on)
  OPTIMIZATION_ON       Compilando com o estado O+ (code optimization on)
  OPENSTRINGS_ON        Compilando com o estado P+ (variable string parameters are openstrings)
  OVERFLOWCHECKS_ON     Compilando com o estado Q+ (overflow checing on)
  RANGECHECKS_ON        Compilando com o estado R+ (range checking on)
  TYPEDADDRESS_ON       Compilando com o estado T+ (pointers obtained using the @ operator are typed)
  SAFEDIVIDE_ON         Compilando com o estado U+ (save FDIV instruction through RTL emulation)
  VARSTRINGCHECKS_ON    Compilando com o estado V+ (type checking of shortstrings)
  STACKFRAMES_ON        Compilando com o estado W+ (generation of stack frames)
  EXTENDEDSYNTAX_ON     Compilando com o estado X+ (Delphi extended syntax enabled)
*)

{$DEFINE BORLAND}

{ Ajusta FreePascal para o modo Delphi }
{$IFDEF FPC}
  {$MODE DELPHI}
  {$ASMMODE Intel}
  {$UNDEF BORLAND}
{$ENDIF}

{$IFDEF BORLAND}
  {$IFDEF LINUX}
    {$DEFINE KYLIX}
  {$ENDIF LINUX}
{$ENDIF BORLAND}

//------------------------------------------------------------------------------
// Mapeamento de VERXXX para nomes COMPILERX, DELPHIX e BCBX
//------------------------------------------------------------------------------

{$IFDEF BORLAND}
  {$IFDEF KYLIX}
    {$I ACBr_kylix.inc} // FPC incompatible stuff
  {$ELSE ~KYLIX}

    {$IFDEF VER170}
      {$DEFINE COMPILER9}
      {$DEFINE DELPHI9}
      {$DEFINE DELPHICOMPILER9}
      {$DEFINE RTL170_UP}
    {$ENDIF}

    {$IFDEF VER160}
      {$DEFINE COMPILER8}
      {$DEFINE DELPHI8}
      {$DEFINE DELPHICOMPILER8}
      {$DEFINE RTL160_UP}
    {$ENDIF}

    {$IFDEF VER150}
      {$DEFINE COMPILER7}
      {$IFDEF BCB}
        {$DEFINE BCB7}
      {$ELSE}
        {$DEFINE DELPHI7}
        {$DEFINE DELPHICOMPILER7}
      {$ENDIF}
      {$DEFINE RTL150_UP}
    {$ENDIF}

    {$IFDEF VER140}
      {$DEFINE COMPILER6}
      {$IFDEF BCB}
        {$DEFINE BCB6}
      {$ELSE}
        {$DEFINE DELPHI6}
        {$DEFINE DELPHICOMPILER6}
      {$ENDIF}
      {$DEFINE RTL140_UP}
    {$ENDIF}

    {$IFDEF VER130}
      {$DEFINE COMPILER5}
      {$IFDEF BCB}
        {$DEFINE BCB5}
      {$ELSE}
        {$DEFINE DELPHI5}
        {$DEFINE DELPHICOMPILER5}
      {$ENDIF}
      {$DEFINE RTL130_UP}
    {$ENDIF}

    {$IFDEF VER125}
      {$DEFINE COMPILER4}
      {$DEFINE BCB4}
      {$DEFINE BCB}
      {$DEFINE RTL125_UP}
    {$ENDIF}

    {$IFDEF VER120}
      {$DEFINE COMPILER4}
      {$DEFINE DELPHI4}
      {$DEFINE DELPHICOMPILER4}
      {$DEFINE RTL120_UP}
    {$ENDIF}

    {$IFDEF VER110}
      {$DEFINE COMPILER35}
      {$DEFINE BCB3}
      {$DEFINE RTL110_UP}
    {$ENDIF}

    {$IFDEF VER100}
      {$DEFINE COMPILER3}
      {$DEFINE DELPHI3}
      {$DEFINE DELPHICOMPILER3}
      {$DEFINE RTL100_UP}
    {$ENDIF}

    {$IFDEF VER93}
      {$DEFINE COMPILER2}
      {$DEFINE BCB1}
      {$DEFINE BCB}
      {$DEFINE RTL93_UP}
    {$ENDIF}

    {$IFDEF VER90}
      {$DEFINE COMPILER2}
      {$DEFINE DELPHI2}
      {$DEFINE DELPHICOMPILER2}
      {$DEFINE RTL90_UP}
    {$ENDIF}

    {$IFDEF VER80}
      {$DEFINE COMPILER1}
      {$DEFINE DELPHI1}
      {$DEFINE DELPHICOMPILER1}
      {$DEFINE RTL80_UP}
    {$ENDIF}

  {$ENDIF ~KYLIX}

  {$IFDEF BCB}
    {$DEFINE CPPBUILDER}
    {$DEFINE BCBCOMPILER}
  {$ELSE ~BCB}
    {$DEFINE DELPHI}
    {$DEFINE DELPHICOMPILER}
  {$ENDIF ~BCB}

{$ENDIF BORLAND}

//------------------------------------------------------------------------------
// DELPHIX_UP � partir dos mapeamentos DELPHIX
//------------------------------------------------------------------------------

{$IFDEF DELPHI9}
  {$DEFINE DELPHI9_UP}
  {$DEFINE DELPHI8_UP}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI8}
  {$DEFINE DELPHI8_UP}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI7}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI6}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI5}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI4}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI3}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI2}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI1}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

//------------------------------------------------------------------------------
// KYLIXX_UP � partir dos mapeamentos KYLIXX
//------------------------------------------------------------------------------

{$IFDEF KYLIX3}
  {$DEFINE KYLIX3_UP}
  {$DEFINE KYLIX2_UP}
  {$DEFINE KYLIX1_UP}
{$ENDIF}

{$IFDEF KYLIX2}
  {$DEFINE KYLIX2_UP}
  {$DEFINE KYLIX1_UP}
{$ENDIF}

{$IFDEF KYLIX1}
  {$DEFINE KYLIX1_UP}
{$ENDIF}

//------------------------------------------------------------------------------
// BCBX_UP � partir dos mapeamentos BCBX
//------------------------------------------------------------------------------

{$IFDEF BCB7}
  {$DEFINE BCB7_UP}
  {$DEFINE BCB6_UP}
  {$DEFINE BCB5_UP}
  {$DEFINE BCB4_UP}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB6}
  {$DEFINE BCB6_UP}
  {$DEFINE BCB5_UP}
  {$DEFINE BCB4_UP}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB5}
  {$DEFINE BCB5_UP}
  {$DEFINE BCB4_UP}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB4}
  {$DEFINE BCB4_UP}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB3}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB1}
  {$DEFINE BCB1_UP}
{$ENDIF}

//------------------------------------------------------------------------------
// DELPHICOMPILERX_UP � partir dos mapeamentos DELPHICOMPILERX
//------------------------------------------------------------------------------

{$IFDEF DELPHICOMPILER9}
  {$DEFINE DELPHICOMPILER9_UP}
  {$DEFINE DELPHICOMPILER8_UP}
  {$DEFINE DELPHICOMPILER7_UP}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER8}
  {$DEFINE DELPHICOMPILER8_UP}
  {$DEFINE DELPHICOMPILER7_UP}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER7}
  {$DEFINE DELPHICOMPILER7_UP}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER6}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER5}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER4}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER3}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER2}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER1}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

//------------------------------------------------------------------------------
// COMPILERX_UP � partir do mapeamento de nomes COMPILERX
//------------------------------------------------------------------------------

{$IFDEF COMPILER9}
  {$DEFINE COMPILER9_UP}
  {$DEFINE COMPILER8_UP}
  {$DEFINE COMPILER7_UP}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER8}
  {$DEFINE COMPILER8_UP}
  {$DEFINE COMPILER7_UP}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER7}
  {$DEFINE COMPILER7_UP}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER6}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER5}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER4}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER35}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER3}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER2}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER1}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{------------------------------------------------------------------------------}

{$IFDEF DELPHICOMPILER}
  {$DEFINE DELPHILANGUAGE}
{$ENDIF}

{$IFDEF BCBCOMPILER}
  {$DEFINE DELPHILANGUAGE}
{$ENDIF}

//------------------------------------------------------------------------------
// RTLX_UP � partir dos mapeamentos RTLX_UP
//------------------------------------------------------------------------------

{$IFDEF RTL170_UP}
  {$DEFINE RTL160_UP}
{$ENDIF}

{$IFDEF RTL160_UP}
  {$DEFINE RTL150_UP}
{$ENDIF}

{$IFDEF RTL150_UP}
  {$DEFINE RTL145_UP}
{$ENDIF}

{$IFDEF RTL145_UP}
  {$DEFINE RTL142_UP}
{$ENDIF}

{$IFDEF RTL142_UP}
  {$DEFINE RTL140_UP}
{$ENDIF}

{$IFDEF RTL140_UP}
  {$DEFINE RTL130_UP}
{$ENDIF}

{$IFDEF RTL130_UP}
  {$DEFINE RTL125_UP}
{$ENDIF}

{$IFDEF RTL125_UP}
  {$DEFINE RTL120_UP}
{$ENDIF}

{$IFDEF RTL120_UP}
  {$DEFINE RTL110_UP}
{$ENDIF}

{$IFDEF RTL110_UP}
  {$DEFINE RTL100_UP}
{$ENDIF}

{$IFDEF RTL100_UP}
  {$DEFINE RTL93_UP}
{$ENDIF}

{$IFDEF RTL93_UP}
  {$DEFINE RTL90_UP}
{$ENDIF}

{$IFDEF RTL90_UP}
  {$DEFINE RTL80_UP}
{$ENDIF}

//------------------------------------------------------------------------------
// Define recursos usando nomes COMPILERX_UP
//------------------------------------------------------------------------------

{$IFDEF COMPILER3_UP}
  {$DEFINE SUPPORTS_WIDESTRING}
  {$DEFINE SUPPORTS_INTERFACE}
{$ENDIF}

{$IFDEF COMPILER35_UP}
  {$DEFINE SUPPORTS_EXTSYM}
  {$DEFINE SUPPORTS_NODEFINE}
{$ENDIF}

{$IFDEF COMPILER4_UP}
  {$DEFINE SUPPORTS_INT64}
  {$DEFINE SUPPORTS_DYNAMICARRAYS}
  {$DEFINE SUPPORTS_DEFAULTPARAMS}
  {$DEFINE SUPPORTS_OVERLOAD}
{$ENDIF}

{$IFDEF COMPILER6_UP}
  {$DEFINE SUPPORTS_DEPRECATED}
  {$DEFINE SUPPORTS_LIBRARY}
  {$DEFINE SUPPORTS_PLATFORM}
  {$DEFINE SUPPORTS_CUSTOMVARIANTS}
  {$DEFINE HAS_UNIT_RTLCONSTS}
  {$DEFINE HAS_UNIT_STRUTILS}
  {$DEFINE HAS_UNIT_TYPES}
  {$DEFINE HAS_UNIT_VARIANTS}
{$ENDIF COMPILER6_UP}



//------------------------------------------------------------------------------
// Mapeia COMPILERX_UP para nomes mais amig�veis
//------------------------------------------------------------------------------

{$IFDEF FPC}
  {$IFDEF  VER1_0}
     Por favor use FPC 1.1 ou superior para compilar.
  {$ELSE}
    {$DEFINE SUPPORTS_OUTPARAMS}
    {$DEFINE SUPPORTS_WIDECHAR}
    {$DEFINE SUPPORTS_WIDESTRING}
    {$IFDEF HASINTF}
      {$DEFINE SUPPORTS_INTERFACE}
    {$ENDIF}
    {$IFDEF HASVARIANT}
      {$DEFINE SUPPORTS_VARIANT}
    {$ENDIF}
    {$IFDEF FPC_HAS_TYPE_SINGLE}
      {$DEFINE SUPPORTS_SINGLE}
    {$ENDIF}
    {$IFDEF FPC_HAS_TYPE_DOUBLE}
      {$DEFINE SUPPORTS_DOUBLE}
    {$ENDIF}
    {$IFDEF FPC_HAS_TYPE_EXTENDED}
      {$DEFINE SUPPORTS_EXTENDED}
    {$ENDIF}
    {$IFDEF HASCURRENCY}
      {$DEFINE SUPPORTS_CURRENCY}
    {$ENDIF}
    {$DEFINE SUPPORTS_THREADVAR}
    {$DEFINE SUPPORTS_CONSTPARAMS}
    {$DEFINE SUPPORTS_LONGWORD}
    {$DEFINE SUPPORTS_INT64}
    {$DEFINE SUPPORTS_DYNAMICARRAYS}
    {$DEFINE SUPPORTS_DEFAULTPARAMS}
    {$DEFINE SUPPORTS_OVERLOAD}
    {$DEFINE ACCEPT_DEPRECATED}
    {$DEFINE ACCEPT_PLATFORM}
    {$DEFINE ACCEPT_LIBRARY}
    {$DEFINE SUPPORTS_EXTSYM}
    {$DEFINE SUPPORTS_NODEFINE}

    {$DEFINE SUPPORTS_CUSTOMVARIANTS}
    {$DEFINE SUPPORTS_VARARGS}
    {$DEFINE SUPPORTS_ENUMVALUE}
    {$IFDEF LINUX}
      {$DEFINE HAS_UNIT_LIBC}
    {$ENDIF LINUX}
    {$DEFINE HAS_UNIT_TYPES}
    {$DEFINE HAS_UNIT_VARIANTS}
    {$DEFINE HAS_UNIT_STRUTILS}
    {$DEFINE HAS_UNIT_RTLCONST}

    {$DEFINE XPLATFORM_RTL}

    {$UNDEF SUPPORTS_DISPINTERFACE}
    {$UNDEF SUPPORTS_IMPLEMENTS}
    {$UNDEF SUPPORTS_UNSAFE_WARNINGS}
  {$ENDIF}
{$ENDIF FPC}

{$IFDEF COMPILER1_UP}
  {$DEFINE SUPPORTS_CONSTPARAMS}
  {$DEFINE SUPPORTS_SINGLE}
  {$DEFINE SUPPORTS_DOUBLE}
  {$DEFINE SUPPORTS_EXTENDED}
{$ENDIF COMPILER1_UP}

{$IFDEF COMPILER2_UP}
  {$DEFINE SUPPORTS_CURRENCY}
  {$DEFINE SUPPORTS_THREADVAR}
  {$DEFINE SUPPORTS_VARIANT}
  {$DEFINE SUPPORTS_WIDECHAR}
{$ENDIF COMPILER2_UP}

{$IFDEF COMPILER3_UP}
  {$DEFINE SUPPORTS_OUTPARAMS}
  {$DEFINE SUPPORTS_WIDESTRING}
  {$DEFINE SUPPORTS_INTERFACE}
  {$DEFINE SUPPORTS_DISPINTERFACE}
  {$DEFINE SUPPORTS_WEAKPACKAGEUNIT}
{$ENDIF COMPILER3_UP}

{$IFDEF COMPILER35_UP}
  {$DEFINE SUPPORTS_EXTSYM}
  {$DEFINE SUPPORTS_NODEFINE}
{$ENDIF COMPILER35_UP}

{$IFDEF COMPILER4_UP}
  {$DEFINE SUPPORTS_LONGWORD}
  {$DEFINE SUPPORTS_INT64}
  {$DEFINE SUPPORTS_DYNAMICARRAYS}
  {$DEFINE SUPPORTS_DEFAULTPARAMS}
  {$DEFINE SUPPORTS_OVERLOAD}
  {$DEFINE SUPPORTS_IMPLEMENTS}
{$ENDIF COMPILER4_UP}

{$IFDEF COMPILER6_UP}
  {$DEFINE SUPPORTS_DEPRECATED}
  {$DEFINE SUPPORTS_LIBRARY}
  {$DEFINE SUPPORTS_PLATFORM}
  {$DEFINE SUPPORTS_LOCAL}
  {$DEFINE ACCEPT_DEPRECATED}
  {$DEFINE ACCEPT_PLATFORM}
  {$DEFINE ACCEPT_LIBRARY}
  {$DEFINE SUPPORTS_DEPRECATED_WARNINGS}
  {$DEFINE SUPPORTS_LIBRARY_WARNINGS}
  {$DEFINE SUPPORTS_PLATFORM_WARNINGS}
  {$DEFINE SUPPORTS_CUSTOMVARIANTS}
  {$DEFINE SUPPORTS_VARARGS}
  {$DEFINE SUPPORTS_ENUMVALUE}
  {$DEFINE SUPPORTS_COMPILETIME_MESSAGES}
{$ENDIF COMPILER6_UP}

{$IFDEF COMPILER7_UP}
  {$DEFINE SUPPORTS_UNSAFE_WARNINGS}
{$ENDIF COMPILER7_UP}

{$IFDEF COMPILER9_UP}
  {$DEFINE SUPPORTS_INLINE}
{$ENDIF COMPILER9_UP}

{$IFDEF RTL140_UP}
  {$IFDEF LINUX}
    {$DEFINE HAS_UNIT_LIBC}
  {$ENDIF LINUX}
  {$DEFINE HAS_UNIT_RTLCONSTS}
  {$DEFINE HAS_UNIT_TYPES}
  {$DEFINE HAS_UNIT_VARIANTS}
  {$DEFINE HAS_UNIT_STRUTILS}
  {$DEFINE XPLATFORM_RTL}
{$ENDIF RTL140_UP}

//------------------------------------------------------------------------------
// Defini��es multi-plataforma
//------------------------------------------------------------------------------

{$IFDEF WIN32}
  {$DEFINE MSWINDOWS}
{$ENDIF}

{$IFDEF DELPHILANGUAGE}
  {$IFDEF LINUX}
    {$DEFINE UNIX}
    {$DEFINE VisualCLX}
  {$ENDIF}

  {$IFDEF CLX}
    {$DEFINE VisualCLX}
  {$ENDIF}

  {$IFDEF CONDITIONALEXPRESSIONS}
    {$IF Declared(QEventType_CMQuit) or Declared(Key_Word_Lower)}
        {$DEFINE VisualCLX}
    {$IFEND}
  {$ENDIF}

  {$IFNDEF VisualCLX}
    {$DEFINE VCL}
  {$ENDIF}

  {$IFDEF VisualCLX}
    {$DEFINE COMPLIB_CLX} { kept for backward compatibility, use VisualCLX instead }
  {$ENDIF}

  {$IFDEF QUnit}
    {$UNDEF VCL}
    {$DEFINE VisualCLX}
  {$ENDIF}

  {$IFDEF VCL}
    {$DEFINE COMPLIB_VCL} { kept for backward compatibility, use VCL instead }
  {$ENDIF}
{$ENDIF DELPHILANGUAGE}

//------------------------------------------------------------------------------
// Defini��es autom�ticas para tipos de licen�a:
//------------------------------------------------------------------------------

{$IFDEF D5Standard}
 {$DEFINE DelphiPersonalEdition}
{$ENDIF}

{$IFDEF D6PersonalEdition}
 {$DEFINE DelphiPersonalEdition}
{$ENDIF}

{$IFDEF D7PersonalEdition}
 {$DEFINE DelphiPersonalEdition}
{$ENDIF}

//------------------------------------------------------------------------------
// Par�metros de compila��o
//------------------------------------------------------------------------------

{$IFOPT A+} {$DEFINE ALIGN_ON} {$ENDIF}
{$IFOPT B+} {$DEFINE BOOLEVAL_ON} {$ENDIF}
{$IFDEF COMPILER2_UP}
  {$IFOPT C+} {$DEFINE ASSERTIONS_ON} {$ENDIF}
{$ENDIF}
{$IFOPT D+} {$DEFINE DEBUGINFO_ON} {$ENDIF}
{$IFOPT G+} {$DEFINE IMPORTEDDATA_ON} {$ENDIF}
{$IFDEF COMPILER2_UP}
  {$IFOPT H+} {$DEFINE LONGSTRINGS_ON} {$ENDIF}
{$ENDIF}
{ Hints }
{$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF}
{$IFDEF COMPILER2_UP}
  {$IFOPT J+} {$DEFINE WRITEABLECONST_ON} {$ENDIF}
{$ENDIF}
{$IFOPT L+} {$DEFINE LOCALSYMBOLS} {$ENDIF}
{$IFOPT M+} {$DEFINE TYPEINFO_ON} {$ENDIF}
{$IFOPT O+} {$DEFINE OPTIMIZATION_ON} {$ENDIF}
{$IFOPT P+} {$DEFINE OPENSTRINGS_ON} {$ENDIF}
{$IFOPT Q+} {$DEFINE OVERFLOWCHECKS_ON} {$ENDIF}
{$IFOPT R+} {$DEFINE RANGECHECKS_ON} {$ENDIF}
{ Compatibilidade }
{$IFOPT T+} {$DEFINE TYPEDADDRESS_ON} {$ENDIF}
{$IFOPT U+} {$DEFINE SAFEDIVIDE_ON} {$ENDIF}
{$IFOPT V+} {$DEFINE VARSTRINGCHECKS_ON} {$ENDIF}
{$IFOPT W+} {$DEFINE STACKFRAMES_ON} {$ENDIF}
{ Warnings }
{$IFOPT X+} {$DEFINE EXTENDEDSYNTAX_ON} {$ENDIF}

//------------------------------------------------------------------------------
// Reduz warnings no D7:
//------------------------------------------------------------------------------

{$IFDEF COMPILER7_UP}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}

