#!perl

# Perl code to generate registration key for WAK Productions TRegware Delphi component
# Version 1.00
# © 2001 - WAK Productions
# Programmed by Winston Kotzan

# Please modify this program any way necessary to suit your needs.  This is
# meant as a base to save you time in programming the algorithm to generate
# the registration code.
# By the way, this Perl program uses CGI_LIB.pm (included) to parse the POST input



use Math::BigInt;
use CGI_LIB;

my($cgi) = new CGI_LIB;

  # Process Input
  $license = $cgi->{"licensename"};
  $registrationcode = &CalculateCode($license);


  # Print out HTML response with registration code
  # This is the part of the program you would most likely want to change
  print &htmlpage_begin("Product Registration Code"),
        "<H1>Registration Code for Product</H1>\n",
        "<BR>\n<BR>\n",
        "Your User name is: $license\n<BR>\n",
        "Your Registration Code is: ",
        $registrationcode,
        &htmlpage_end;



sub CalculateCode {
  my($LicenseName)= @_;

  # Create error is LicenseName was greater than MaxChars (25),
  # or shorter than MinChars (3)
  if ((length($LicenseName) > 25) or (length($LicenseName) < 3)) {
    # Make HTML response for failure
    print "Content-type: text/html\n\n",
          "Incorrect Size\n";
    exit;
  }
  # Takes the last 6 characters (going backwards), converting each
  # character to ASCII and taking the remainder of dividing it into Seed
  $i = 0;
  $Seed = 4133185345; # Set to whatever your seed property is set to
  $RegCodeSize = 12; # Same as property in component
  $CodeStr = "";
  $ReversedName = reverse $LicenseName;
  while (($i <= 6) and ($i < length($ReversedName))) {
    $CodeStr = $CodeStr . ($Seed % ord(substr($ReversedName, $i, 1)));
    $i++;
  }

  # Convert to Hex
  $BigCodeStr = Math::BigInt->new($CodeStr);
  @hexnums=qw( 0 1 2 3 4 5 6 7 8 9 A B C D E F );
  while($BigCodeStr)
  {
    unshift @RegCode,$hexnums[$BigCodeStr%16];
    $BigCodeStr=$BigCodeStr/16;
  }
  $RegCode=join("", @RegCode);

  if (($RegCodeSize > 0) and (length($RegCode) < $RegCodeSize)) {
    # If RegCode is not big enough then fill the front of it with 0's
    $RegCode = reverse $RegCode;
    for ($diff = $RegCodeSize - length($RegCode); $diff > 0; $diff--) {
      $RegCode = $RegCode . "0";
    }
    $RegCode = reverse $RegCode;
  } elsif (($RegCodeSize > 0) and (length($RegCode) > $RegCodeSize)) {
    # Chop off the ending characters if reg code is bigger than RegCodeSize
    $diff = length($RegCode) - $RegCodeSize;
    while ($diff > 0) {
      chop $RegCode;
      $diff--;
    }
  }
  return $RegCode;
}

sub htmlpage_begin {
  my($Title)= @_;
  return "Content-type: text/html\n\n",
         "<HTML>\n<HEAD>\n<TITLE>$Title</TITLE>\n</HEAD>\n\n<BODY>\n\n";
}

sub htmlpage_end {
    return "\n</BODY>\n</HTML>";
}