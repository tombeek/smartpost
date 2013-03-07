#!/usr/bin/perl -w

use strict;
use constant WHATS_RELATED_URL => "http://www-rl.netscape.com/wtgn?";
use vars qw( @RECORDS $RELATED_RECORDS );

use CGI;
use CGI::Carp qw( fatalsToBrowser );
use XML::Parser;
use LWP::Simple;

my $q = new CGI(  );

if ( $q->param( "url" ) ) {
    display_whats_related_to_whats_related( $q );
} else {
    print $q->redirect( "/quiz.html" );
}


sub display_whats_related_to_whats_related {
    my $q = shift;
    my $url = $q->param( "url" );
    my $scriptname = $q->script_name;
    
    print $q->header( "text/html" ),
          $q->start_html( "What's Related To What's Related Query" ),
          $q->h1( "What's Related To What's Related Query" ),
          $q->hr,
          $q->start_ul;
    
    my @related = get_whats_related_to_whats_related( $url );
    
    foreach ( @related ) {
        print $q->a( { -href => "$scriptname?url=$_->[0]" }, "[*]" ),
              $q->a( { -href => "$_->[0]" }, $_->[1] );
        
        my @subrelated = @{$_->[2]};
        
        if ( @subrelated ) {
            print $q->start_ul;
            foreach ( @subrelated ) {
                print $q->a( { -href => "$scriptname?url=$_->[0]" }, "[*]" ),
                      $q->a( { -href => "$_->[0]" }, $_->[1] );
            }
            print $q->end_ul;
        } else {
            print $q->p( "No Related Items Were Found" );
        }
    }
    
    if ( ! @related ) {
        print $q->p( "No Related Items Were Found. Sorry." );
    } 
    
    print $q->end_ul,
          $q->p( "[*] = Go to What's Related To That URL." ),
          $q->hr,
          $q->start_form( -method => "GET" ),
            $q->p( "Enter Another URL To Search:",
              $q->text_field( -name => "url", -size => 30 ),
              $q->submit( -name => "submit_query", -value => "Submit Query" )
            ),
          $q->end_form,
          $q->end_html;
}


sub get_whats_related_to_whats_related {
    my $url = shift;

    my @related = get_whats_related( $url ); 
    my $record;
    foreach $record ( @related ) {
        $record->[2] = [ get_whats_related( $record->[0] ) ];
    }
    return @related;
}


sub get_whats_related {
    my $url = shift;
    my $parser = new XML::Parser( Handlers => { Start => \&handle_start } );
    my $data = get( WHATS_RELATED_URL . $url );
    
    $data =~ s/&/&amp;/g;
    while ( $data =~ s|(=\"[^"]*)\"([^/ ])|$1'$2|g ) { };
    while ( $data =~ s|(=\"[^"]*)<[^"]*>|$1|g ) { };
    while ( $data =~ s|(=\"[^"]*)<|$1|g ) { };
    while ( $data =~ s|(=\"[^"]*)>|$1|g ) { };
    $data =~ s/[\x80-\xFF]//g;
    
    local @RECORDS = (  );
    local $RELATED_RECORDS = 1;
    
    $parser->parse( $data );
    
    sub handle_start {
        my $expat = shift;
        my $element = shift;
        my %attributes = @_;

        if ( $element eq "child" ) {
            my $href = $attributes{"href"};
            $href =~ s/http.*http(.*)/http$1/;

            if ( $attributes{"name"} &&
                 $attributes{"name"} !~ /smart browsing/i &&
                 $RELATED_RECORDS ) {
                if ( $attributes{"name"} =~ /no related/i ) {
                    $RELATED_RECORDS = 0;
                } else {
                    my $fields = [ $href, $attributes{"name"} ];
                    push @RECORDS, $fields;
                }
            }
        }
    }
    return @RECORDS;
}