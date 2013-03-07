#!/usr/bin/perl
BEGIN {
    $|=1;
    print "Content-type: text/html\n\n";
    use CGI::Carp('fatalsToBrowser');
}
use CGI;

my $cgi = new CGI;
my $name = 'ptest.html';
open (LISTING, '>>' . $name);                         
print LISTING $cgi->start_html(  -title => 'Whoa Doggie - nuther test',
								-meta => {  'keywords' => 'test',
											'description' => 'test'},
								-style => { -src => '/css/main.css'} ) . 
								'<strong>' . 'Hi dudes' . '</strong>' .
								$cgi->end_html . "\n";
								
# move files from cgi-bin to jobs folder and enable execute permissions # <-- uncomment for production
rename($name, '../htdocs/smartpost/jobs/' . $name) || print "Lack permission to rename " . $name . " or file does not exist.<br><br>";
chmod(0755, '../htdocs/smartpost/jobs/' . $name) || print $!;

# message to user upon execution of this file
print "Done<br><br>";
print "New file(s) posted: <a href=\"http://02e8a4f.netsolhost.com/smartpost/jobs/ptest.html\">here</a><br><br>";
print "Jobs added:<br />";
### end of script