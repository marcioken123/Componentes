{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclResources.pas.                                                           }
{                                                                                                  }
{ The Initial Developer of the Original Code is Marcel van Brakel.                                 }
{ Portions created by Marcel van Brakel are Copyright (C) Marcel van Brakel. All rights reserved.  }
{                                                                                                  }
{ Contributors:                                                                                    }
{   Alexei Koudinov                                                                                }
{   Barry Kelly                                                                                    }
{   Flier Lu (flier)                                                                               }
{   Florent Ouchet (outchy)                                                                        }
{   Jean-Fabien Connault (cycocrew)                                                                }
{   Marcel Bestebroer                                                                              }
{   Marcel van Brakel                                                                              }
{   Matthias Thoma (mthoma)                                                                        }
{   Peter Friese                                                                                   }
{   Petr Vones (pvones)                                                                            }
{   Raymond Alexander (rayspostbox3)                                                               }
{   Robert Marquardt (marquardt)                                                                   }
{   Robert Rossmair (rrossmair)                                                                    }
{   Scott Price (scottprice)                                                                       }
{   Uwe Schuster (uschuster)                                                                       }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Unit which provides a central place for all resource strings used in the JCL                     }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date:: 2012-08-28 16:44:17 +0200 (mar. 28 août 2012)                          $ }
{ Revision:      $Rev:: 3850                                                                     $ }
{ Author:        $Author:: outchy                                                                $ }
{                                                                                                  }
{**************************************************************************************************}

unit IWJclResources;

{$I IWJcl.inc}

interface

//=== IWJclBase ================================================================
resourcestring
  RsCantConvertAddr64  = 'The address %s%.16x cannot be converted to 32 bit';
  RsEReplacementChar   = 'Failed to get ANSI replacement character';
  RsEUnexpectedEOSeq          = 'Unexpected end of sequence';
  RsDateConversion = 'Error illegal date or time format';

//=== IWJclDebug ===============================================================
resourcestring
  RsUnknownFunctionAt     = 'Unknown function at %s';

//=== IWJclFileUtils ===========================================================
resourcestring
  // Path manipulation
  RsPathInvalidDrive = '%s is not a valid drive';

  // Files and directories
  RsFileUtilsAttrUnavailable = 'Unable to retrieve attributes of %s';

  RsCannotCreateDir = 'Unable to create directory';
  RsDelTreePathIsEmpty = 'DelTree: Path is empty';
  RsFileSearchAttrInconsistency = 'Some file search attributes are required AND rejected!';
  RsEWindowsVersionNotSupported = 'This windows version is not supported';
  RsEWindowNotValid = 'The window with handle %d is not valid';
  RsEProcessNotValid = 'The process with ID %d is not valid';
  RsEModuleNotValid = 'The Module with handle %d is not valid';

  // TJclFileStream
  RsFileStreamCreate         = 'Unable to create temporary file stream';

  // TJclFileMapping
  RsCreateFileMapping        = 'Failed to create FileMapping';
  RsCreateFileMappingView    = 'Failed to create FileMappingView';
  RsLoadFromStreamSize       = 'Not enough space in View in procedure LoadFromStream';
  RsFileMappingInvalidHandle = 'Invalid file handle';
  RsViewNeedsMapping         = 'FileMap argument of TJclFileMappingView constructor cannot be nil';
  RsFailedToObtainSize       = 'Failed to obtain size of file';

  // TJclFileMapping.Create
  RsFileMappingOpenFile = 'Unable to open the file';

  // TJclMappedTextReader
  RsFileIndexOutOfRange = 'Index of out range';

  // FileGetTypeName()
  RsDefaultFileTypeName = ' File';

//=== IWJclPeImage =============================================================
resourcestring
  RsPeReadOnlyStream = 'Stream is read-only';

  // TJclPeImage
  RsPeCantOpen                = 'Cannot open file "%s"';
  RsPeNotPE                   = 'This is not a PE format';
  RsPeUnknownTarget           = 'Unknown PE target';
  RsPeNotResDir               = 'Not a resource directory';
  RsPeNotAvailableForAttached = 'Feature is not available for attached images';
  RsPeSectionNotFound         = 'Section "%s" not found';

  // PE directory names
  RsPeImg_00 = 'Exports';
  RsPeImg_01 = 'Imports';
  RsPeImg_02 = 'Resources';
  RsPeImg_03 = 'Exceptions';
  RsPeImg_04 = 'Security';
  RsPeImg_05 = 'Base Relocations';
  RsPeImg_06 = 'Debug';
  RsPeImg_07 = 'Description';
  RsPeImg_08 = 'Machine Value';
  RsPeImg_09 = 'TLS';
  RsPeImg_10 = 'Load configuration';
  RsPeImg_11 = 'Bound Import';
  RsPeImg_12 = 'IAT';
  RsPeImg_13 = 'Delay load import';
  RsPeImg_14 = 'COM run-time';
  RsPeImg_Reserved = 'reserved [%.2d]';

  // NT Header names
  RsPeSignature               = 'Signature';
  RsPeMachine                 = 'Machine';
  RsPeNumberOfSections        = 'Number of Sections';
  RsPeTimeDateStamp           = 'Time Date Stamp';
  RsPePointerToSymbolTable    = 'Symbols Pointer';
  RsPeNumberOfSymbols         = 'Number of Symbols';
  RsPeSizeOfOptionalHeader    = 'Size of Optional Header';
  RsPeCharacteristics         = 'Characteristics';
  RsPeMagic                   = 'Magic';
  RsPeLinkerVersion           = 'Linker Version';
  RsPeSizeOfCode              = 'Size of Code';
  RsPeSizeOfInitializedData   = 'Size of Initialized Data';
  RsPeSizeOfUninitializedData = 'Size of Uninitialized Data';
  RsPeAddressOfEntryPoint     = 'Address of Entry Point';
  RsPeBaseOfCode              = 'Base of Code';
  RsPeBaseOfData              = 'Base of Data';
  RsPeImageBase               = 'Image Base';
  RsPeSectionAlignment        = 'Section Alignment';
  RsPeFileAlignment           = 'File Alignment';
  RsPeOperatingSystemVersion  = 'Operating System Version';
  RsPeImageVersion            = 'Image Version';
  RsPeSubsystemVersion        = 'Subsystem Version';
  RsPeWin32VersionValue       = 'Win32 Version';
  RsPeSizeOfImage             = 'Size of Image';
  RsPeSizeOfHeaders           = 'Size of Headers';
  RsPeCheckSum                = 'CheckSum';
  RsPeSubsystem               = 'Subsystem';
  RsPeDllCharacteristics      = 'Dll Characteristics';
  RsPeSizeOfStackReserve      = 'Size of Stack Reserve';
  RsPeSizeOfStackCommit       = 'Size of Stack Commit';
  RsPeSizeOfHeapReserve       = 'Size of Heap Reserve';
  RsPeSizeOfHeapCommit        = 'Size of Heap Commit';
  RsPeLoaderFlags             = 'Loader Flags';
  RsPeNumberOfRvaAndSizes     = 'Number of RVA';

  // Load config names
  RsPeVersion                       = 'Version';
  RsPeGlobalFlagsClear              = 'GlobalFlagsClear';
  RsPeGlobalFlagsSet                = 'GlobalFlagsSet';
  RsPeCriticalSectionDefaultTimeout = 'CriticalSectionDefaultTimeout';
  RsPeDeCommitFreeBlockThreshold    = 'DeCommitFreeBlockThreshold';
  RsPeDeCommitTotalFreeThreshold    = 'DeCommitTotalFreeThreshold';
  RsPeLockPrefixTable               = 'LockPrefixTable';
  RsPeMaximumAllocationSize         = 'MaximumAllocationSize';
  RsPeVirtualMemoryThreshold        = 'VirtualMemoryThreshold';
  RsPeProcessHeapFlags              = 'ProcessHeapFlags';
  RsPeProcessAffinityMask           = 'ProcessAffinityMask';
  RsPeCSDVersion                    = 'CSDVersion';
  RsPeReserved                      = 'Reserved';
  RsPeEditList                      = 'EditList';

  // Machine names
  RsPeMACHINE_UNKNOWN   = 'Unknown';
  RsPeMACHINE_I386      = 'Intel 386';
  RsPeMACHINE_R3000     = 'MIPS little-endian R3000';
  RsPeMACHINE_R4000     = 'MIPS little-endian R4000';
  RsPeMACHINE_R10000    = 'MIPS little-endian R10000';
  RsPeMACHINE_WCEMIPSV2 = 'MIPS little-endian WCE v2';
  RsPeMACHINE_ALPHA     = 'Alpha_AXP';
  RsPeMACHINE_SH3       = 'SH3 little-endian';
  RsPeMACHINE_SH3DSP    = 'SH3 DSP';
  RsPeMACHINE_SH3E      = 'SH3E little-endian';
  RsPeMACHINE_SH4       = 'SH4 little-endian';
  RsPeMACHINE_SH5       = 'SH5';
  RsPeMACHINE_ARM       = 'ARM Little-Endian';
  RsPeMACHINE_THUMB     = 'THUMB';
  RsPeMACHINE_AM33      = 'AM33';
  RsPeMACHINE_POWERPC   = 'IBM PowerPC Little-Endian';
  RsPeMACHINE_POWERPCFP = 'IBM PowerPC FP';
  RsPeMACHINE_IA64      = 'Intel 64';
  RsPeMACHINE_MIPS16    = 'MIPS16';
  RsPeMACHINE_AMPHA64   = 'ALPHA64';
  RsPeMACHINE_MIPSFPU   = 'MIPSFPU';
  RsPeMACHINE_MIPSFPU16 = 'MIPSFPU16';
  RsPeMACHINE_TRICORE   = 'Infineon';
  RsPeMACHINE_CEF       = 'CEF';
  RsPeMACHINE_EBC       = 'EFI Byte Code';
  RsPeMACHINE_AMD64     = 'AMD64 (K8)';
  RsPeMACHINE_M32R      = 'M32R little-endian';
  RsPeMACHINE_CEE       = 'CEE';

  // Subsystem names
  RsPeSUBSYSTEM_UNKNOWN     = 'Unknown';
  RsPeSUBSYSTEM_NATIVE      = 'Native';
  RsPeSUBSYSTEM_WINDOWS_GUI = 'GUI';
  RsPeSUBSYSTEM_WINDOWS_CUI = 'Console';
  RsPeSUBSYSTEM_OS2_CUI     = 'OS/2';
  RsPeSUBSYSTEM_POSIX_CUI   = 'Posix';
  RsPeSUBSYSTEM_RESERVED8   = 'Reserved 8';

  // Debug symbol type names
  RsPeDEBUG_UNKNOWN       = 'UNKNOWN';
  RsPeDEBUG_COFF          = 'COFF';
  RsPeDEBUG_CODEVIEW      = 'CODEVIEW';
  RsPeDEBUG_FPO           = 'FPO';
  RsPeDEBUG_MISC          = 'MISC';
  RsPeDEBUG_EXCEPTION     = 'EXCEPTION';
  RsPeDEBUG_FIXUP         = 'FIXUP';
  RsPeDEBUG_OMAP_TO_SRC   = 'OMAP_TO_SRC';
  RsPeDEBUG_OMAP_FROM_SRC = 'OMAP_FROM_SRC';
  RsPeDEBUG_BORLAND       = 'BORLAND';

  // TJclPePackageInfo.PackageModuleTypeToString
  RsPePkgExecutable = 'Executable';
  RsPePkgPackage    = 'Package';
  PsPePkgLibrary    = 'Library';

  // TJclPePackageInfo.PackageOptionsToString
  RsPePkgNeverBuild     = 'NeverBuild';
  RsPePkgDesignOnly     = 'DesignOnly';
  RsPePkgRunOnly        = 'RunOnly';
  RsPePkgIgnoreDupUnits = 'IgnoreDupUnits';

  // TJclPePackageInfo.ProducerToString
  RsPePkgV3Produced        = 'Delphi 3 or C++ Builder 3';
  RsPePkgProducerUndefined = 'Undefined';
  RsPePkgBCB4Produced      = 'C++ Builder 4 or later';
  RsPePkgDelphi4Produced   = 'Delphi 4 or later';

  // TJclPePackageInfo.UnitInfoFlagsToString
  RsPePkgMain     = 'Main';
  RsPePkgWeak     = 'Weak';
  RsPePkgOrgWeak  = 'OrgWeak';
  RsPePkgImplicit = 'Implicit';

//=== IWJclSecurity ============================================================
resourcestring
  RsInvalidSID = 'Invalid SID';
  RsSIDBufferTooSmall = 'SID buffer too small.';
  RsLsaError = 'LSA Error: NT Status = %.8x, message: %s'; 

//=== IWJclStreams =============================================================
resourcestring
  RsStreamsCreateError = 'Cannot create file %s';
  RsStreamsOpenError = 'Cannot open file %s';
  RsStreamsSetSizeError = 'Error setting stream size';
  RsStreamsSeekError = 'Error seeking stream';
  RsStreamsCRCError = 'Cyclic Redundency Check (CRC) error: data are damaged';

//=== IWJclStrings =============================================================
resourcestring
  RsBlankSearchString       = 'Search string cannot be blank';
  RsInvalidEmptyStringItem  = 'String list passed to StringsToMultiSz cannot contain empty strings.';
  RsNumericConstantTooLarge = 'Numeric constant too large (%d) at position %d.';
  RsFormatException         = 'Format exception';
  RsDotNetFormatNullFormat  = 'Format string is null';
  RsArgumentIsNull          = 'Argument %d is null';
  RsDotNetFormatArgumentNotSupported = 'Argument type of %d is not supported';
  RsArgumentOutOfRange      = 'Argument out of range';
  RsTabs_DuplicatesNotAllowed = 'Duplicate tab stops are not allowed.';
  RsTabs_StopExpected = 'A tab stop was expected but not found.';
  RsTabs_CloseBracketExpected = 'Closing bracket expected.';
  RsTabs_TabWidthExpected = 'Tab width expected.';
  // Default text for the NullReferenceException in .NET
  RsArg_NullReferenceException = 'Object reference not set to an instance of an object.';

//=== IWJclSynch ===============================================================
resourcestring
  RsSynchAttachWin32Handle    = 'Invalid handle to TJclWin32HandleObject.Attach';
  RsSynchDuplicateWin32Handle = 'Invalid handle to TJclWin32HandleObject.Duplicate';
  RsSynchInitCriticalSection  = 'Failed to initalize critical section';
  RsSynchAttachDispatcher     = 'Invalid handle to TJclDispatcherObject.Attach';
  RsSynchCreateEvent          = 'Failed to create event';
  RsSynchOpenEvent            = 'Failed to open event';
  RsSynchCreateWaitableTimer  = 'Failed to create waitable timer';
  RsSynchOpenWaitableTimer    = 'Failed to open waitable timer';
  RsSynchCreateSemaphore      = 'Failed to create semaphore';
  RsSynchOpenSemaphore        = 'Failed to open semaphore';
  RsSynchCreateMutex          = 'Failed to create mutex';
  RsSynchOpenMutex            = 'Failed to open mutex';
  RsMetSectInvalidParameter   = 'An invalid parameter was passed to the constructor.';
  RsMetSectInitialize         = 'Failed to initialize the metered section.';
  RsMetSectNameEmpty          = 'Name cannot be empty when using the Open constructor.';

//=== IWJclSysInfo =============================================================
resourcestring
  RsSystemProcess     = 'System Process';
  RsSystemIdleProcess = 'System Idle Process';

  {$IFDEF MSWINDOWS}
  RsSPInfo = 'SP%u';
  {$ENDIF MSWINDOWS}

//=== IWJclSysUtils ============================================================
resourcestring
  RsVMTMemoryWriteError  = 'Error writing VMT memory (%s)';
  RsCannotWriteRefStream = 'Can not write to a read-only memory stream';
  RsStringToBoolean      = 'Unable to convert the string "%s" to a boolean';
  RsInvalidDigit         = 'Invalid base %d digit ''%s'' encountered.';
  RsInvalidDigitValue    = 'There is no valid base %d digit for decimal value %d';

  {$IFDEF UNIX}
  RsReadKeyError         = 'ReadKey: Problem waiting on stdin';
  {$ENDIF UNIX}

  RsInvalidGUIDString    = 'Invalid conversion from string to GUID (%s).';

  RsInvalidMMFName = 'Invalid MMF name "%s"';
  RsInvalidMMFEmpty = 'The MMF named "%s" cannot be created empty';

//=== IWJclTD32 ================================================================
resourcestring
  RsHasNotTD32Info = 'File [%s] has not TD32 debug information!';

//=== IWJclWin32 ===============================================================
resourcestring
  RsWin32Error        = 'Win32 error: %s (%u)%s%s';
  RsELibraryNotFound  = 'Library not found: %s';
  RsEFunctionNotFound = 'Function not found: %s.%s';

implementation

end.
