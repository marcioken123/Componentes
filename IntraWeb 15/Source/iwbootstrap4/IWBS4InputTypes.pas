unit IWBS4InputTypes;

interface

uses
  Classes, IW.HTTP.Request, IW.HTTP.Reply;

type
  TIWBS4FormType = (bs4ftStacked, bs4ftInline);

  TIWBS4FormEncType = (bs4feDefault, bs4feMultipart, bs4feText);

  TIWBS4InputFormSubmitEvent = procedure(ARequest: THttpRequest; AParams: TStrings) of object;

  TIWBS4InputSize = (bs4isDefault, bs4isSmall, bs4isNormal, bs4isLarge);

const
  aIWBS4InputSize: array[bs4isDefault..bs4isLarge] of string = ('', 'form-control-sm', '', 'form-control-lg');

type
  // We'll leave out "file" to be able to handle it separately
  TIWBS4InputType = (bs4itText, bs4itPassword, bs4itDate, bs4itDateTimeLocal, bs4itMonth, bs4itTime, bs4itWeek, bs4itNumber, bs4itEmail, bs4itUrl, bs4itSearch, bs4itTel, bs4itColor, bs4itHidden);

const
  aIWBS4InputType: array[bs4itText..bs4itHidden] of string = ('text', 'password', 'date', 'datetime-local', 'month', 'time', 'week', 'number', 'email', 'url', 'search', 'tel', 'color', 'hidden');

implementation

end.

