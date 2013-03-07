#!/usr/bin/perl -wT

use strict;
use CGI;
use CGI qw/:standard/;
use lib "Perl-modules";
use XML::Simple;
use HTML::TreeBuilder;

my $simple = XML::Simple->new( );  # initialize objects
my $cgi = new CGI;
my $xmldirectory = "../htdocs/smartpost/xml_files/";
my $files = dirlist($xmldirectory);
my @jobs = '';	#hyperlink array
my $baseurl = "http://02e8a4f.netsolhost.com/smartpost/jobs/";

## render job postings web page
open (LISTING, '../htdocs/smartpost/jobs/index.html');
print LISTING $cgi->start_html( -title => 'Job Postings',
								-meta => { 'keywords' => 'employment opportunities, jobs',
											'description' => 'job descriptions'},
								-style => { -src => '../css/main.css'}, ) . 
								'<div id="main">' .
									'<div id="top" onclick="parent.location=\'http://www.hiretellers.com\'">' . '</div>' . 
									'<div id="help"></div>' .
									'<div class="head">' . 'Active job postings:' . '</div>' .
									'<div id="links">' . "@sorted" . '</div>' .
									'<div id="valid">
										<p>
										    <a href="http://validator.w3.org/check?uri=referer"><img
										        src="http://www.w3.org/Icons/valid-xhtml10"
										        alt="Valid XHTML 1.0 Strict" height="31" width="88" /></a>
										</p>
									</div>' .
								'</div>' . 
								$cgi->end_html . "\n";