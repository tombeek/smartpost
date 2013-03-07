#!/usr/bin/perl -w

# ensure all fatals go to browser during debugging and set-up
# comment this BEGIN block out on production code for security
BEGIN {
    $|=1;
    print "Content-type: text/html\n\n";
    use CGI::Carp('fatalsToBrowser');
}
use strict;
use XML::Simple;
use Data::Dumper;
use CGI;
use CGI qw/:standard/;
use lib "Perl-modules";

# my $reqlist = XMLin('../htdocs/smartpost/xml_files/multireqs.xml');
# print Dumper($reqlist);

my $reqlist = XMLin('../htdocs/smartpost/xml_files/multireqs.xml');
# print Dumper($reqlist);


# 
# foreach my $book (@{$reqlist->{req}}) {
# 	if ($book->{job} eq 'Teller') {
# 		print $book->{type} . "\n";
# 	}
# }

# my $booklist = XMLin('../htdocs/smartpost/xml_files/multireqs.xml', KeyAttr => {req => 'id'});
# 
# print $booklist->{req}-> . "\n";