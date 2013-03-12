#!/usr/bin/perl

# use module
use XML::Simple;
use Data::Dumper;
use CGI;
use CGI qw/:standard/;
use lib "Perl-modules";
#use HTML::TreeBuilder;

my $cgi = new CGI;

# create array
@arr = [ 
        {'country'=>'england', 'capital'=>'london'},
        {'country'=>'norway', 'capital'=>'oslo'},
        {'country'=>'india', 'capital'=>'new delhi'} ];

# create object
$xml = new XML::Simple (NoAttr=>1, RootName=>'data');

# convert Perl array ref into XML document
$data = $xml->XMLout(\@arr);

# access XML data
print Dumper($data);