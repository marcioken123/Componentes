*-------------------------------------------------------------------------------
*GrFinger Sample
*(c) 2005 Griaule Tecnologia Ltda.
*http://www.griaule.com
*-------------------------------------------------------------------------------
*
*This sample is provided for use with "GrFinger Fingerprint Recognition Library"
*and can't run without it. It's provided just as an example of using GrFinger
*Fingerprint Recognition Library and should not be used as basis for any
*commercial product.
*
*Griaule Tecnologia makes no representations concerning either the merchantability
*of this software or the suitability of this sample for any particular purpose.
*
*THIS SAMPLE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
*IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
*OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
*IN NO EVENT SHALL GRIAULE BE LIABLE FOR ANY DIRECT, INDIRECT,
*INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
*NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
*DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
*THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
*(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
*THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*You can download the free version of GrFinger directly from Griaule website.
*
*These notices must be retained in any copies of any part of this
*documentation and/or sample.
*
*-------------------------------------------------------------------------------

* -----------------------------------------------------------------------------------
* GrFinger constants
* -----------------------------------------------------------------------------------

#DEFINE GR_OK                                         0
#DEFINE GR_BAD_QUALITY                                0
#DEFINE GR_MEDIUM_QUALITY                             1
#DEFINE GR_HIGH_QUALITY                               2
#DEFINE GR_MATCH                                      1
#DEFINE GR_NOT_MATCH                                  0
#DEFINE GR_DEFAULT_USED                               3
* initialization errors codes
#DEFINE GR_ERROR_INITIALIZE_FAIL                     -1
#DEFINE GR_ERROR_NOT_INITIALIZED                     -2
#DEFINE GR_ERROR_FAIL_LICENSE_READ                   -3
#DEFINE GR_ERROR_NO_VALID_LICENSE                    -4
#DEFINE GR_ERROR_NULL_ARGUMENT                       -5
#DEFINE GR_ERROR_FAIL                                -6
#DEFINE GR_ERROR_ALLOC                               -7
#DEFINE GR_ERROR_PARAMETERS                          -8
*extract and match errors codes
#DEFINE GR_ERROR_WRONG_USE                         -107
#DEFINE GR_ERROR_EXTRACT                           -108
#DEFINE GR_ERROR_SIZE_OFF_RANGE                    -109
#DEFINE GR_ERROR_RES_OFF_RANGE                     -110
#DEFINE GR_ERROR_CONTEXT_NOT_CREATED               -111
#DEFINE GR_ERROR_INVALID_CONTEXT                   -112
#DEFINE GR_ERROR_ERROR                             -113
#DEFINE GR_ERROR_NOT_ENOUGH_SPACE                  -114
*capture error codes
#DEFINE GR_ERROR_CONNECT_SENSOR                    -201
#DEFINE GR_ERROR_CAPTURING                         -202
#DEFINE GR_ERROR_CANCEL_CAPTURING                  -203
#DEFINE GR_ERROR_INVALID_ID_SENSOR                 -204
#DEFINE GR_ERROR_SENSOR_NOT_CAPTURING              -205
#DEFINE GR_ERROR_INVALID_EXT                       -206
#DEFINE GR_ERROR_INVALID_FILENAME                  -207
#DEFINE GR_ERROR_INVALID_FILETYPE                  -208
#DEFINE GR_ERROR_SENSOR                            -209
*file format codes
#DEFINE GRCAP_IMAGE_FORMAT_BMP                      501
#DEFINE GRCAP_IMAGE_FORMAT_TIFF                     502
#DEFINE GRCAP_IMAGE_FORMAT_RAW                      503
*image consts 
#DEFINE GR_DEFAULT_RES                              500
#DEFINE GR_DEFAULT_DIM                              500
#DEFINE GR_MAX_SIZE_TEMPLATE                      10000
#DEFINE GR_MAX_IMAGE_WIDTH                         1280
#DEFINE GR_MAX_IMAGE_HEIGHT                        1280
#DEFINE GR_MAX_RESOLUTION                          1000 && DPI
#DEFINE GR_MIN_IMAGE_WIDTH                           50
#DEFINE GR_MIN_IMAGE_HEIGHT                          50
#DEFINE GR_MIN_RESOLUTION                           125 && DPI
*match const
#DEFINE GR_MAX_THRESHOLD                            200
#DEFINE GR_MIN_THRESHOLD                             10
#DEFINE GR_VERYLOW_FRR                               30 && FAR 1 IN 1000
#DEFINE GR_LOW_FRR                                   45 && FAR 1 IN 10000
#DEFINE GR_LOW_FAR                                   60 && FAR 1 IN 30000
#DEFINE GR_VERYLOW_FAR                               80 && FAR 1 IN 300000
#DEFINE GR_ROT_MIN                                    0
#DEFINE GR_ROT_MAX                                  180
*context const
#DEFINE GR_DEFAULT_CONTEXT                            0
#DEFINE GR_NO_CONTEXT                                -1
*colors for BiometricDisplay
#DEFINE GR_IMAGE_NO_COLOR                     536870911
*version constants
#DEFINE GRFINGER_FULL                                 1
#DEFINE GRFINGER_LIGHT                                2
#DEFINE GRFINGER_FREE                                 3

* -----------------------------------------------------------------------------------
* Sample constants
* -----------------------------------------------------------------------------------

#DEFINE ERR_CANT_OPEN_BD							-999
#DEFINE ERR_INVALID_ID								-998
#DEFINE ERR_INVALID_TEMPLATE						-997
#DEFINE adStateOpen									1
#DEFINE adOpenDynamic								2
#DEFINE adOpenStatic								3
#DEFINE adLockReadOnly								1
#DEFINE adLockOptimistic							3
