#
# CGI_LIB package.
#
package CGI_LIB;

#===============================================================================
#
# Constructor:
#     $obj = new CGI_LIB;
#
# Methods:
#    $obj->getFormMethod();
#    $obj->getSubmittedData();
#    $obj->processData();
#    $obj->processURLEncodedData();
#    $obj->processMultiPartData();
#
# *p/s: For more details, please refer to the description below.
#
#===============================================================================

use strict;
use vars qw($FormMethod $VERSION);

$VERSION = '1.01';

#===============================================================================
#
# CONSTRUCTOR:  $obj = new CGI_LIB;
#
# DESCRIPTION:  This is the constructor of the CGI_LIB object.
#        The constructor will process the data according to the form
#        method used, and set the data into the object.
#
#===============================================================================
sub new {
    my($pkg) = shift;
    my($self) = {};

    bless $self, $pkg;

    $FormMethod = $self->getFormMethod();
    $self->processData();
    return $self;
}

#===============================================================================
#
# METHOD:       $obj->getFormMethod();
#
# DESCRIPTION:  This method will return the form method that has been used.
#
#===============================================================================
sub getFormMethod {
    my($self) = shift;

    return $ENV{'REQUEST_METHOD'};
}

#===============================================================================
#
# METHOD:       $obj->getSubmittedData();
#
# DESCRIPTION:  This method will return the submitted form data.
#
#===============================================================================
sub getSubmittedData {
    my($self) = shift;

    if ($FormMethod eq "POST") {
      my($buffer);
      read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
      return $buffer;
    }
    elsif ($FormMethod eq "GET") {
      return $ENV{'QUERY_STRING'};
    }
    else {
      return $ENV{'QUERY_STRING'};
    }
}

#===============================================================================
#
# METHOD:       $obj->processData();
#
# DESCRIPTION:  According to different type of submitted data, this method will
#        call different subroutine to process the data and set them into
#        the object.
#
#===============================================================================
sub processData {
    my($self) = shift;

    if ($ENV{'CONTENT_TYPE'} =~ /^multipart\/form-data;/) {
      $self->processMultiPartData();
    }
    elsif ($ENV{'CONTENT_TYPE'} =~ /^application\/x-www-form-urlencoded$/) {
      $self->processURLEncodedData();
    }
    else {
      $self->processURLEncodedData();
    }
    if ($FormMethod ne "GET" && $ENV{'QUERY_STRING'} ne "") {
      $FormMethod = "GET";
      $self->processURLEncodedData();
    }
}

#===============================================================================
#
# METHOD:       $obj->processURLEncodedData();
#
# DESCRIPTION:  The submitted data is in application/x-www-form-urlencoded
#        format.
#
#===============================================================================
sub processURLEncodedData {
    my($self) = shift;

    my($submittedData) = $self->getSubmittedData();

    my(@fields) = split('&', $submittedData);

    for (@fields) {
      tr/+/ /;

      my($fieldName, $fieldValue) = split('=', $_, 2);

      # The %xx hex numbers are converted to alphanumeric.
      $fieldName   =~ s/%(..)/pack("C", hex($1))/eg;
      $fieldValue  =~ s/%(..)/pack("C", hex($1))/eg;

      if (exists $self->{$fieldName}) {
    if (ref($self->{$fieldName}) eq "ARRAY") {
          push(@{$self->{$fieldName}}, $fieldValue);
    }
    else {
      my($tempValue) = $self->{$fieldName};
      delete $self->{$fieldName};
      push(@{$self->{$fieldName}}, $tempValue);
      push(@{$self->{$fieldName}}, $fieldValue);
    }
      }
      else {
    $self->{$fieldName} = $fieldValue;
      }
    }
}

#===============================================================================
#
# METHOD:       $obj->processMultiPartData();
#
# DESCRIPTION:  The submitted data is in multipart/form-data format.
#        We only using this format when we want to do HTTP file upload.
#
#===============================================================================
sub processMultiPartData {
    my($self) = shift;
    my($submittedData) = $self->getSubmittedData();

    my($boundary) = $ENV{'CONTENT_TYPE'} =~ /^.*boundary=(.*)$/;

    my(@partsArray) = split(/--$boundary/, $submittedData);

    @partsArray = splice(@partsArray, 1, (scalar(@partsArray) - 2));

    my($aPart);
    foreach $aPart (@partsArray) {
      $aPart =~ s/(\r|)\n$//g;
      my($dump, $firstline, $fieldValue) = split(/[\r]\n/, $aPart, 3);
      next if $firstline =~ /filename=\"\"/;
      $firstline =~ s/^Content-Disposition: form-data; //;
      my(@columns) = split(/;\s+/, $firstline);
      my($fieldName) = $columns[0] =~ /^name=\"([^\"]+)\"$/;
      my(%dataHash);
      if (scalar(@columns) > 1) {
        my($contentType, $blankline);
        ($contentType, $blankline, $fieldValue) = split(/[\r]\n/, $fieldValue, 3);
    ($dataHash{'content-type'}) = $contentType =~ /^Content-Type: ([^\s]+)$/;
      }
      else {
    my($blankline);
    ($blankline, $fieldValue) = split(/[\r]\n/, $fieldValue, 2);
    if (exists $self->{$fieldName}) {
      if (ref($self->{$fieldName}) eq "ARRAY") {
        push(@{$self->{$fieldName}}, $fieldValue);
          }
          else {
        my($tempValue) = $self->{$fieldName};
        delete $self->{$fieldName};
        push(@{$self->{$fieldName}}, $tempValue);
        push(@{$self->{$fieldName}}, $fieldValue);
      }
    }
    else {
      next if $fieldValue =~ /^\s*$/;
          $self->{$fieldName} = $fieldValue;
        }
    next;
      }
      my($currentColumn);
      for $currentColumn (@columns) {
        my($currentHeader, $currentValue) = $currentColumn =~ /^([^=]+)="([^"]+)"$/;
        $dataHash{"$currentHeader"} = $currentValue;
      }
      $dataHash{'contents'} = $fieldValue;
      $dataHash{'size'} = length($fieldValue);
      $self->{$fieldName} = \%dataHash;
    }
}

1;
__END__

=head1 NAME

CGI_LIB -- This is a perl module which will help you to manipulate the CGI input.

=head1 SYNOPSIS

  use CGI_LIB;
  $obj = new CGI_LIB();

=head1 DESCRIPTION

For more details about this module, please visit to
    http://www.tneoh.zoneit.com/perl/CGI_LIB/

=head1 AUTHOR

Simon Tneoh Chee-Boon   tneohcb@pc.jaring.my

Copyright (c) 1998 Simon Tneoh Chee-Boon. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 VERSION

Version 1.01    21 August 1999