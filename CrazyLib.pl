#!/usr/bin/perl -w

#Select Input File
if( $ARGV[0] ) { $madlibf = $ARGV[0]; }
else {
    print "Enter madlib filename: ";
    $madlibf = <STDIN>;
    chomp $madlibf;
}#end else
open( INFILE, $madlibf ) || die "Opening $madlibf: $!\n";
@madlib = <INFILE>;
close(INFILE);

#Fill In Select Words
foreach( @madlib ) {
    while( m/<([^<]+)>/g ) {#     while( ($what) = m/<([^<]+)>/ ) {
        print "Enter a $1: ";#         print "Enter a $what: ";
        $input = <STDIN>;
        chomp $input;
        s/<([^<]+)>/$input/;
    }
}

#Display Result
print "\n@madlib\n";

#Save Result if Disired
#print "Save the result? ";
