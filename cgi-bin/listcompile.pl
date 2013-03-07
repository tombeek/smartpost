#!/usr/bin/perl -wT

# ensure all fatals go to browser during debugging and set-up
# comment this BEGIN block out on production code for security
BEGIN {
    $|=1;
    print "Content-type: text/html\n\n";
    use CGI::Carp('fatalsToBrowser');
}
use CGI;
use CGI qw/:standard/;

my $cgi = new CGI;
my $input = shift;

print $cgi->start_html(	-title => 'This is a test script', 
						-meta => {  'keywords' => $tree->{ job } . ', job',
									'description' => 'job description'},
						-style => { -src => '/css/main.css'} ) . 
						a({-href=>"http://02e8a4f.netsolhost.com/smartpost/jobs", -target=>'blank'}, $input);
# print $input;
print $cgi->end_html . "\n";
