unit IWBS4Color;

interface

// These are really Contextual Classes

type
  TIWBS4Background = (bs4bgNone, bs4bgSuccess, bs4bgInfo, bs4bgWarning, bs4bgDanger, bs4bgPrimary, bs4bgSecondary, bs4bgDark, bs4bgLight);

const
  aIWBS4Background: array[bs4bgNone..bs4bgLight] of string = ('default', 'success', 'info', 'warning', 'danger', 'primary', 'secondary', 'dark', 'light');
// Need Contextual Class enumeration that does not include the option for "none"

type
  TIWBS4ContextualClass = (bs4cxSuccess, bs4cxInfo, bs4cxWarning, bs4cxDanger, bs4cxPrimary, bs4cxSecondary, bs4cxDark, bs4cxLight);

const
  aIWBS4ContextualClass: array[bs4cxSuccess..bs4cxLight] of string = ('success', 'info', 'warning', 'danger', 'primary', 'secondary', 'dark', 'light');
// Dark Light -- only two options plus nothing

type
  TIWBS4DarkLight = (bs4dlNone, bs4dlDark, bs4dlLight);

const
  aIWBS4DarkLight: array[bs4dlNone..bs4dlLight] of string = ('', 'dark', 'light');
// Border Contextual Classes

type
  TIWBS4Border = (bs4bdNone, bs4bdSuccess, bs4bdInfo, bs4bdWarning, bs4bdDanger, bs4bdPrimary, bs4bdSecondary, bs4bdDark, bs4bdLight);

const
  aIWBS4Border: array[bs4bdNone..bs4bdLight] of string = ('', 'success', 'info', 'warning', 'danger', 'primary', 'secondary', 'dark', 'light');
// Text Color

type
  TIWBS4TextColor = (bs4tcNone, bs4tcMuted, bs4tcPrimary, bs4tcSuccess, bs4tcInfo, bs4tcWarning, bs4tcDanger, bs4tcSecondary, bs4tcWhite, bs4tcDark, bs4tcBody, bs4tcLight);

const
  aIWBS4TextColor: array[bs4tcNone..bs4tcLight] of string = ('', 'text-muted', 'text-primary', 'text-success', 'text-info', 'text-warning', 'text-danger', 'text-secondary', 'text-white', 'text-dark', 'text-body', 'text-light');

implementation

end.

