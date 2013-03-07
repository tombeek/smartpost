#!/usr/bin/perl

# ensure all fatals go to browser during debugging and set-up
# comment this BEGIN block out on production code for security
BEGIN {
    $|=1;
    print "Content-type: text/html\n\n";
    use CGI::Carp('fatalsToBrowser');
}
use strict;
use CGI;
use CGI qw/:standard/;
use lib "Perl-modules";
use XML::Simple;
use Data::Dumper;
use HTML::TreeBuilder;

my $simple = XML::Simple->new( );  # initialize objects
my $cgi = new CGI;
my $xmldirectory = "../htdocs/smartpost/xml_files/";
my $files = dirlist($xmldirectory);
my @jobs;
my $baseurl = "http://02e8a4f.netsolhost.com/smartpost/jobs/";

## create job postings from xml files
foreach my $fileInDirectory (@$files) {
	my $tree = $simple->XMLin( $xmldirectory . $fileInDirectory );   # read, store document
	
	# print Dumper($tree);
	
# 	foreach my $req (@{$reqlist->{ id }}) {
# 		if ($book->{type} eq 'technical') {
# 			print $book->{title} . "\n";
# 		}

	
# 	# dereference hash ref
# 	# access <req> array
# 	foreach my $e ($tree->{req})
# 	{
# 		my $jobs .= $e->{ job };
# 	 	my $name = $e->{ id } . '.html';
# 	 	## add to global hyperlink array, @jobs: Company + ID + Title
# 		push(@jobs, a({-href=>"$baseurl$name"},"$e->{ company } - $e->{ id } - $e->{ title }") . '<br />');
# 		open (MYFILE, '>>' . $name);
# 		print MYFILE $cgi->start_html(  -title => $e->{ id } . ' - ' . $e->{ company } . ' - ' . $e->{ title },
# 									-meta => {  'keywords' => $e->{ job } . ', job',
# 												'description' => 'job description'},
# 									-style => { -src => '/css/main.css'} ) . 
# 									'<strong>' . $e->{ title } . '</strong>' .
# 									$e->{ description } . 
# 									a({-href=>"$e->{ url }"},"$e->{url}") . 
# 									$cgi->end_html . "\n";							
# 		print $e->{ company }, "\n";
# 		print "Position: ", $e->{ title }, "/",  $e->{ type }, "\n"; 
# 		print "Description: ", $e->{ job }, "\n"; 
# 		print "\n";
# 	}
	
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
