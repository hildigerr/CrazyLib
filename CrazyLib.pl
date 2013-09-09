#!/usr/bin/perl -w

use strict;
use Time::Piece;

sub get_input_word {
    my ($what) = @_;
    my ($ch0) = split( //, $what );
    if( $ch0 =~ m/[aeiou]/i ) { print "Enter an $what: "; }
    else { print "Enter a $what: "; }
    my $input = <STDIN>;
    chomp $input;
}

#Select Input File
my( $madlibf );
if( $ARGV[0] ) { $madlibf = $ARGV[0]; }
else {
    print "Enter madlib filename: ";
    $madlibf = <STDIN>;
    chomp $madlibf;
}#end else
open( INFILE, $madlibf ) || die "Opening $madlibf: $!\n";
my @madlib = <INFILE>;
close(INFILE);

#Fill In Select Words
foreach( @madlib ) {
    while( my ($what) = m/<([^<]+)>/ ) {
        my $input = get_input_word($what);
        s/<[^<]+>/$input/;
    }
}

#Display Result
print "\n@madlib\n";

#Save Result if Disired
print "Save the result? ";
if( <STDIN> =~ m/^y/i ) {
    my $savefile = "$madlibf-".localtime->epoch;
    open( SAVEM, ">$savefile" ) || die "Cannot save $savefile: $!\n";
    print "Saving as $savefile\n";
    print SAVEM @madlib;
    close(SAVEM);
}
