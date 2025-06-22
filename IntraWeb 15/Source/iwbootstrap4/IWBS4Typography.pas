unit IWBS4Typography;

interface

// Font Weight

type
  TIWBS4FontWeight = (bs4fwNone, bs4fwNormal, bs4fwBold, bs4fwLight);

const
  aIWBS4FontWeight: array[bs4fwNone..bs4fwLight] of string = ('', 'font-weight-normal', 'font-weight-bold', 'font-weight-light');

// Text Alignment
type
  TIWBS4TextAlignment = (bs4taNone, bs4taLeft, bs4taRight, bs4taCenter, bs4taJustify);

const
  aIWBS4TextAlignment: array[bs4taNone..bs4taJustify] of string = ('', 'text-left', 'text-right', 'text-center', 'text-justify');

// Text Transform
type
  TIWBS4TextTransform = (bs4xfNone, bs4xfLowercase, bs4xfUppercase, bs4xfCapitalized);

const
  aIWBS4TextTransform: array[bs4xfNone..bs4xfCapitalized] of string = ('', 'text-lowercase', 'text-uppercase', 'text-capitalize');

// Header classes
type
  TIWBS4HeaderClass = (bs4hcNone, bs4hcH1, bs4hcH2, bs4hcH3, bs4hcH4, bs4hcH5, bs4hcH6);

const
  aIWBS4HeaderClass: array[bs4hcNone..bs4hcH6] of string = ('', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6');

// Display 1-4
type
  TIWBS4HeaderDisplay = (bs4hdNone, bs4hdDisplay1, bs4hdDisplay2, bs4hdDisplay3, bs4hdDisplay4);

const
  aIWBS4HeaderDisplay: array[bs4hdNone..bs4hdDisplay4] of string = ('', 'display-1', 'display-2', 'display-3', 'display-4');

// Text Options
type
  TIWBS4TextOption = (bs4toFontItalic, bs4toMonospace, bs4toNoWrap, bs4toTruncate);

  TIWBS4TextOptions = set of TIWBS4TextOption;

const
  aIWBS4TextOptions: array[bs4toFontItalic..bs4toTruncate] of string = ('font-italic', 'text-monospace', 'text-nowrap', 'text-truncate');

implementation

end.

