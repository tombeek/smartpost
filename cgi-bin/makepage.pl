#!/usr/bin/perl
use strict;
use CGI;

my $cgi = new CGI;
my $jobs = ls '../htdocs/smartpost/jobs';
open (MYFILE, '>> index.html');
print MYFILE $cgi->start_html( -title => $tree->{ title }, -meta => { 'keywords' => 'jobs, job descriptions', 'description' => 'job descriptions'}, -style => { -src => '/css/main.css'} ) .  . $cgi->end_html . "\n";

print "Content-type:text/html\n\n";
chmod(0755, '../htdocs/smartpost/jobs/index.html') || print $!;

print "Done<br><br>";
print "New jobs posted at: <a href=\"http://02e8a4f.netsolhost.com/smartpost/jobs/index.html\"" . ">Job Descriptions</a><br><br>"; 