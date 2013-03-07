#!/usr/bin/perl

# ensure all fatals go to browser during debugging and set-up
# comment this BEGIN block out on production code for security
BEGIN {
    $|=1;
    print "Content-type: text/html\n\n";
    use CGI::Carp('fatalsToBrowser');
}
use strict;
use warnings;
use diagnostics;
use CGI;	# using CGI mod for HTML boilerplate
use CGI qw/:standard/;
use lib "Perl-modules"; # access en masse
use XML::Simple;
use XML::Simple qw(:strict);
# use Data::Dumper;
# use HTML::TreeBuilder;

my $simple = XML::Simple->new( );  # initialize objects
my $cgi = new CGI;
my $xmldirectory = "../htdocs/smartpost/xml_files/";
my $files = dirlist($xmldirectory);
my @jobs;
my $baseurl = "http://02e8a4f.netsolhost.com/smartpost/jobs/";

# print "Content-type:text/html\n\n";	# required header for web output

## extract data from xml files into 
foreach my $fileInDirectory (@$files) {
	my $tree = $simple->XMLin( $xmldirectory . $fileInDirectory, 
									KeyAttr => {item => 'req'}, 
									ForceArray => 1
						);   # read, store document
	
	
	# dereference hash ref
	# access <req> array(s)
	foreach my $e (@{$tree->{ req }}) {
		my $jobs .= $e->{ job };
	 	my $name = $e->{ id } . '.html';
	 	## add to global hyperlink array, @jobs: Company + ID + Title
		push(@jobs, a({-href=>"$baseurl$name"},"$e->{ company } - $e->{ id } - $e->{ title }") . '<br />');
		open (MYFILE, '>>' . $name);
		print MYFILE $cgi->start_html(  -title => $e->{ id } . ' - ' . $e->{ company } . ' - ' . $e->{ title },
									-meta => {  'keywords' => $e->{ job } . ', job',
												'description' => 'job description'},
									-style => { -src => '/css/main.css'} ) . 
									'<strong>' . $e->{ title } . '</strong>' .
									$e->{ description } . 
									a({-href=>"$e->{ url }"},"$e->{url}") . 
									$cgi->end_html . "\n";							
		print $e->{ company }, "\n";
		print "Position: ", $e->{ title }, "/",  $e->{ type }, "\n"; 
		print "Description: ", $e->{ job }, "\n"; 
		print "\n";
	}
	
	## now that we have a copy of the XML file we can determine how many jobs it contains,
	## creating postings based on unique req_id
	

	# move files from cgi-bin to jobs folder and enable execute permissions # <-- uncomment for production
# 	rename($name, '../htdocs/smartpost/jobs/' . $name) || print "Lack permission to rename " . $name . " or file does not exist.<br><br>";
# 	chmod(0755, '../htdocs/smartpost/jobs/' . $name) || print $!;
# 	rename('../htdocs/smartpost/xml_files/' . $fileInDirectory, '../htdocs/smartpost/xml_files/processed/' . $fileInDirectory); #move xml file
}

# create array of newly created hyperlinks and add to exisitng ones on index.html
my $oldlinks = '';

## sort the list of hyperlinks
my @sorted = sort { $a cmp $b } @jobs;   # ASCII-betical sort

# creates an array of xml filenames
sub dirlist {
        my $dir = shift;
        my @filelist ='';
        opendir(DIR, $dir) or die "can't opendir $dir: $!";
        while (defined(my $file = readdir(DIR))) {

                # We only want files
		        next unless (-f "$dir/$file");

		        # Use a regular expression to find files ending in .xml
		        next unless ($file =~ m/\.xml$/);
                push(@filelist, $file);
        }
        closedir(DIR);
        return \@filelist;
}

# create array of job posting filenames
sub joblist {
        my $dir = shift;
        my @filelist;
        opendir(DIR, $dir) or die "can't opendir $dir: $!";
        while (defined(my $file = readdir(DIR))) {

                # We only want files
		        next unless (-f "$dir/$file");

		        # Use a regular expression to find files starting with SP
		        next unless ($file =~ m/SP*.html/);
                push(@filelist, $file);
        }
        closedir(DIR);
        my @sorted = sort { $a cmp $b } @filelist;   # ASCII-betical sort
        return \@sorted;
}

# # create list of formatted hyperlinks for job postings
# my $jobdirectory = "../htdocs/smartpost/jobs/";
# my $linklist = joblist($jobdirectory);
# my $joblinks = '';
# foreach my $jobInDirectory (@$linklist) {
# 	next unless ($jobInDirectory =~ m/\.html$/);
# 	$joblinks .= '<a href="http://02e8a4f.netsolhost.com/smartpost/jobs/' . $jobInDirectory . '">' . $jobInDirectory . '</a>' . '<br />';
# }


### end of script

