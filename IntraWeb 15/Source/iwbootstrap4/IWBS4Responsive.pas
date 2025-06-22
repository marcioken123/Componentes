unit IWBS4Responsive;

(**
    Bootstrap Responsive Trigger Points and Media Queries

    <<<<<<< MIN >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    @media (min-width: 576px) {
      h1  {
        background: cornflower;
      }
    }

    @media (min-width: 768px) {
      h1 {
        background: coral;
      }
    }

    @media (min-width: 992px) {
      h1 {
        background: lightpink;
      }
    }

    @media (min-width: 1200px) {
      h1 {
        background: dodgerblue;
      }
    }


    <<<<<<< MAX >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    @media (max-width: 575px) {
      h1  {
        background: cornflower;
      }
    }

    @media (max-width: 767px) {
      h1  {
        background: coral;
      }
    }

    @media (max-width: 991px) {
      h1  {
        background: coral;
      }
    }

    @media (max-width: 1199px) {
      h1  {
        background: coral;
      }
    }

**)

interface

type
  TIWBS4Breakpoint = (bs4bpNone, bs4bpExtraSmall, bs4bpSmall, bs4bpMedium, bs4bpLarge, bs4bpExtraLarge);

const
  aIWBS4Breakpoint: array[bs4bpNone..bs4bpExtraLarge] of string = ('', '-', 'sm', 'md', 'lg', 'xl');

implementation

end.
