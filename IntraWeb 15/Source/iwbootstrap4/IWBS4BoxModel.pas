unit IWBS4BoxModel;

(**
     Bootstrap Box Model (Spacing) Abbreviations
     ===========================================

     m = margin
     p = padding

     l = left
     r = right
     x = left and right
     t = top
     b = bottom
     y = top and bottom

     m or p without a side modifier = all sides

     0 = remove margin or padding
     1
     2
     3
     4
     5

     // Width Ratios
     w-25 = 25%
     w-50
     w-75
     w-100
     w-auto (default)

     h-25
     h-50
     h-75
     h-100
     h-auto (default)

     // Borders
     border = give it the basic Bootstrap border
     border-left
     border-right
     border-top
     border-bottom

     // Border colors
     border-primary
     border-secondary
     border-success
     border-warning
     border-info
     border-danger
     border-light
     border-dark
     border-white

     // Border roundedness
     rounded
     rounded-left
     rounded-right
     rounded-top
     rounded-bottom
     rounded-circle (ellipse)
     rounded-0 (takes it away, square)

**)

interface

type
  TIWBS4MarginBottom = (mbDefault, mb0, mb1, mb2, mb3, mb4, mb5);

const
  aIWBS4MarginBottom: array[mbDefault..mb5] of string = ('', 'mb0', 'mb1', 'mb2', 'mb3', 'mb4', 'mb5');

type
  TIWBS4MarginTop = (mtDefault, mt0, mt1, mt2, mt3, mt4, mt5);

const
  aIWBS4MarginTop: array[mtDefault..mt5] of string = ('', 'mt0', 'mt1', 'mt2', 'mt3', 'mt4', 'mt5');

implementation

end.

