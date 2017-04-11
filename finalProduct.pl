#!/usr/bin/perl
#
#   Packages and modules
#
use strict;
use warnings;
use version;   our $VERSION = qv('5.16.0');
use Text::CSV  1.32;
use Text::Table;


my $EMPTY = q{};
my $SPACE = q{ };
my $COMMA = q{,};

my $filename = $EMPTY;
my $category_resp;
my $question_resp;
my @records;
my @Ref_Date;
my @GEO;
my @Violations;
my @STA;
my @Vector;
my @Coordinate;
my @Value;
my $crime_count = -1;
my $csv = Text::CSV->new({ sep_char => $COMMA });

if ( $#ARGV != 0 ) {
    
    print("No file\n" or die"Load Error\n");
    exit;
    
}else {
    
    $filename = $ARGV[0];
}

open my $crime_data, '<', $filename or die "Unable to open names file: $filename\n";    #Opens and reads in file contents into array.

@records = <$crime_data>;

close $crime_data or die "Unable to close $ARGV[0]\n";


print("\n                   * * * * * * * * * * * * * * * * * * * * *\n");
print("                   * Welcome to Team Barrie's Team Project *\n");
print("                   * * * * * * * * * * * * * * * * * * * * *\n\n");

print("This is a perl script that gives quick answers and information about crime data!\n\nLoading your file:    ");




foreach my $crime_record ( @records ) {         #Parses data from crime file into the appropriate array.
    if( $csv->parse( $crime_record ) ) {
        my @crime_labels = $csv->fields();
        $crime_count++;
        
        $Ref_Date[$crime_count] = $crime_labels[0];
        $GEO[$crime_count] = $crime_labels[1];
        $Violations[$crime_count]= $crime_labels[2];
        $STA[$crime_count]= $crime_labels[3];
        $Vector[$crime_count] = $crime_labels[4];
        $Coordinate[$crime_count]= $crime_labels[5];
        $Value[$crime_count] = $crime_labels[6];
        
        
        print "\b\b\b";                                 #Percentage gauge.
        printf "%2d%%", ($crime_count/736468) *100;
        
    }else {
       
        warn "Line/record crime_data data could not be parsed: $records[$crime_count] \n";
    }
}


print("\n\nDone! Now, to get a question answered please select one of the following categories:\n\n");

print("1: Location Related Questions, Ex: Murder capial of Canada?\n");
print("2: Value Related Question, Ex: Percentage of crimes commited by youth?\n");
print("3: Crime Related Question, Ex: Most common crime in a particular province?\n");


do {

    print("\nWhich category would you like to choose?(1, 2, 3) Type 'x' to exit: ");

    $category_resp = <STDIN>;
    chomp $category_resp;
    
} while( $category_resp ne '1' && $category_resp ne '2' && $category_resp ne '3' && $category_resp ne 'x' );

if( $category_resp eq 'x' ) {
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\n                                       Good Day!\n\n");

}else {

    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
}

while( $category_resp ne 'x' ) {

    if( $category_resp eq '1' ) {
    
        print("\nLocation Related Questions:\n");
        print("1: Murder capital of Canada in ( year )?\n");
        print("2: Safest place in Canada in ( year )?\n");
        print("3: What province has shown the greatest increase in crime from ( year ) to ( year )?\n\n");
        
        do {
            
            print("Which question above would you like answered?(1, 2, 3): ");
            
            $question_resp = <STDIN>;           #User input here.
            chomp $question_resp;
       
            if( $question_resp eq '1' ) {
                
                cOne_qOne();                    #A called subroutine.
                
            }elsif( $question_resp eq '2' ) {
            
                cOne_qTwo();
            
            }elsif( $question_resp eq '3' ) {
            
                cOne_qThree();
            }
            
        } while( $question_resp ne '1' && $question_resp ne '2' && $question_resp ne '3' );
        
    }elsif( $category_resp eq '2' ) {
    
        print("\nValue Related Questions:\n");
        print("1: Percentage of crimes commited by youth in ( year )?\n");
        print("2: Amount of adults charged with a crime in ( year )?\n");
        print("3: What year did ( location ) have the most reported crimes?\n\n");
        
        do {
            
            print("Which question above would you like answered?(1, 2, 3): ");
            
            $question_resp = <STDIN>;
            chomp $question_resp;
            
            if( $question_resp eq '1' ) {
                
                cTwo_qOne();
                
            }elsif( $question_resp eq '2' ) {
                
                cTwo_qTwo();
                
            }elsif( $question_resp eq '3' ) {
                
                cTwo_qThree();
            }
            
        } while( $question_resp ne '1' && $question_resp ne '2' && $question_resp ne '3' );

    
    }elsif( $category_resp eq '3' ) {
     
        print("\nCrime Related Questions:\n");
        print("1: Top 10 common crime in ( location ) in ( year )?\n");
        print("2: Top 10 common crime commited by youth in ( location ) in ( year )?\n");
        print("3: Top 10 least common crime commited in ( location ) in ( year )?\n\n");
        
        do {
            
            print("Which question above would you like answered?(1, 2, 3): ");
            
            $question_resp = <STDIN>;
            chomp $question_resp;
            
            if( $question_resp eq '1' ) {
                
                crime_location();
                
            }elsif( $question_resp eq '2' ) {
                
                crime_location2();
                
            }elsif( $question_resp eq '3' ) {
                
                crime_location3();
            }
            
        } while( $question_resp ne '1' && $question_resp ne '2' && $question_resp ne '3' );

    }else {
        
        print("Invalid entry!\n");
    }
    print("\n-------------------------------------------------------------------------------------\n");
    print("\nQuestion Categories:\n");
    print("1: Location Related Questions, Ex: Murder capital of Canada?\n");
    print("2: Value Related Question, Ex: Percentage of crimes commited by youth?\n");
    print("3: Crime Related Question, Ex: Most common crime in a particular province?\n");
    
    do {
    
        print("\nWould you like another question answered?(1, 2, 3) Type 'x' to exit: ");

        $category_resp = <STDIN>;
        chomp $category_resp;
    
    } while( $category_resp ne '1' && $category_resp ne '2' && $category_resp ne '3' && $category_resp ne 'x' );
    
    if( $category_resp eq 'x' ) {
    
        print("\033[2J");    #Clears terminal window.
        print("\033[0;0H");
        
        print("\n                                       Good Day!\n\n");
    }
    
}


sub cOne_qOne {
    
    my $date_resp = 0;
    my @year;
    my $greatest_val = 0;
    my $temp_val = 0;
    my $location = $EMPTY;
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nYears:\n");
    
    for( my $j = 1; $j < 19; $j++ ) {
        
        $year[$j] = $Ref_Date[$j];

        print("$j: $year[$j]\n");
    }
    
    do {
    
        print("\nPlease choose a year based on the number to the left of it: ");
        
        $date_resp = <STDIN>;
        chomp $date_resp;
        
    } while( $date_resp < 1 || $date_resp > 18 );
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    for( my $i = 0; $i < $#Ref_Date; $i++ ) {
        
        if( $year[$date_resp] eq $Ref_Date[$i] && $Violations[$i] eq "Murder, first degree" && $STA[$i] eq "Actual incidents" && $GEO[$i] ne "Canada" ) {
            
            if( $Value[$i] ne ".." ) {
            
                $temp_val = $Value[$i];
            }
            
            if( $temp_val > $greatest_val ) {
                
                $greatest_val = $temp_val;
                $location = $GEO[$i];
            }
        }
    }
    $greatest_val = sprintf("%.f", $greatest_val);          #Rounds to no decimal point.
    
    print("\nThe murder capital of Canada in $year[$date_resp] was $location with a total\nof $greatest_val murders, based on known first degree murder incidents.\n");
}


sub cOne_qTwo {
    
    my $date_resp = 0;
    my @year;
    my $lowest_val = 0;
    my $temp_val = 0;
    my $location = $EMPTY;
    my $inCount = 0;
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nYears:\n");
    
    for( my $j = 1; $j < 19; $j++ ) {
        
        $year[$j] = $Ref_Date[$j];
        
        print("$j: $year[$j]\n");
    }
    
    do {
        
        print("\nPlease choose a year based on the number to the left of it: ");
        
        $date_resp = <STDIN>;
        chomp $date_resp;
        
    } while( $date_resp < 1 || $date_resp > 18 );
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    for( my $i = 0; $i < $#Ref_Date; $i++ ) {
        
        if( $year[$date_resp] eq $Ref_Date[$i] && $Violations[$i] eq "Total, all violations" && $STA[$i] eq "Actual incidents" && $GEO[$i] ne "Canada" ) {
            
            $inCount++;
            
            if( $Value[$i] ne ".." ) {
                
                $temp_val = $Value[$i];
            }
            
            if( $inCount == 1 ) {
                
                $lowest_val = $temp_val;
            }
            
            if( $temp_val < $lowest_val ) {
                
                $lowest_val = $temp_val;
                $location = $GEO[$i];
            }
        }
    }
    
    $lowest_val = sprintf("%.f", $lowest_val);
    
    print("\nThe safest place in Canada in $year[$date_resp] was $location with a total of $lowest_val crimes,\n");
    print("based on the least amount of total violations from all listed locations.\n");
}

sub cOne_qThree {
    
    my $date_resp1 = 0;
    my $date_resp2 = 0;
    my @year;
    my $date1_val = 0;
    my $date2_val = 0;
    my $location = $EMPTY;
    my $temp_diff = 0;
    my $greatest_diff = 0;
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nYears:\n");
    
    for( my $j = 1; $j < 19; $j++ ) {
        
        $year[$j] = $Ref_Date[$j];
        
        print("$j: $year[$j]\n");
    }
    
    do {
        
        print("\nPlease choose the starting year based on the number to the left of it: ");
        
        $date_resp1 = <STDIN>;
        chomp $date_resp1;
        
    } while( $date_resp1 < 1 || $date_resp1 > 18 );
    
    do {
        
        print("\nPlease choose the ending year based on the number to the left of it: ");
        
        $date_resp2 = <STDIN>;
        chomp $date_resp2;
        
    } while( $date_resp2 < 1 || $date_resp2 > 18 );
    
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    for( my $i = 0; $i < $#Ref_Date; $i++ ) {
        
        if( $year[$date_resp1] eq $Ref_Date[$i] && $Violations[$i] eq "Total, all violations" && $STA[$i] eq "Actual incidents" && $GEO[$i] ne "Canada" ) {
            
            if( $Value[$i] ne ".." ) {
                
                $date1_val = $Value[$i];
            }
            
            for( my $k = 0; $k < $#Ref_Date; $k++ ) {
                
                if( $year[$date_resp2] eq $Ref_Date[$k] && $Violations[$k] eq "Total, all violations" && $STA[$k] eq "Actual incidents" && $GEO[$k] eq $GEO[$i] ) {
                    
                    if( $Value[$k] ne ".." ) {
                        
                        $date2_val = $Value[$k];
                    }
                    
                    $temp_diff = $date2_val - $date1_val;
                    
                    if( $temp_diff > $greatest_diff ) {
                        
                        $greatest_diff = $temp_diff;
                        $location = $GEO[$k];
                    }
                }
            }
        }
    }
    
    $greatest_diff = sprintf("%.f", $greatest_diff);
    
    print("\n$location has shown the greatest increase in crime from $year[$date_resp1] to $year[$date_resp2],\n");
    print("with an increase of $greatest_diff total violations in comparison between the two years.\n");
}

sub cTwo_qOne {
    
    my $date_resp = 0;
    my @year;
    my $youth_val = 0;
    my $total_val = 0;
    my $percentage = 0;
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nYears:\n");
    
    for( my $j = 1; $j < 19; $j++ ) {
        
        $year[$j] = $Ref_Date[$j];
        
        print("$j: $year[$j]\n");
    }
    
    do {
        
        print("\nPlease choose a year based on the number to the left of it: ");
        
        $date_resp = <STDIN>;
        chomp $date_resp;
        
    } while( $date_resp < 1 || $date_resp > 18 );
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    for( my $i = 0; $i < $#Ref_Date; $i++ ) {
        
        if( $year[$date_resp] eq $Ref_Date[$i] && $Violations[$i] eq "Total, all violations" && $STA[$i] eq "Total, persons charged" && $GEO[$i] eq "Canada" ) {
            
            if( $Value[$i] ne ".." ) {
                
                $total_val = $Value[$i];
            }
            
            for( my $k = 0; $k < $#Ref_Date; $k++ ) {
                
                if( $year[$date_resp] eq $Ref_Date[$k] && $Violations[$k] eq "Total, all violations" && $STA[$k] eq "Total, youth charged" && $GEO[$k] eq "Canada" ) {
                    
                    if( $Value[$k] ne ".." ) {
                        
                        $youth_val = $Value[$k];
                    }
                }
                
            }
        }
    }
    
    $percentage = ( $youth_val / $total_val ) * 100;
    $percentage = sprintf("%.f", $percentage);
    
    print("\nThe percentage of all crimes commited by youth in Canada in $year[$date_resp] was $percentage%.\n");
}


sub cTwo_qTwo {
    
    my $date_resp = 0;
    my @year;
    my $total_val = 0;
    my $percentage = 0;
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nYears:\n");
    
    for( my $j = 1; $j < 19; $j++ ) {
        
        $year[$j] = $Ref_Date[$j];
        
        print("$j: $year[$j]\n");
    }
    
    do {
        
        print("\nPlease choose a year based on the number to the left of it: ");
        
        $date_resp = <STDIN>;
        chomp $date_resp;
        
    } while( $date_resp < 1 || $date_resp > 18 );
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    for( my $i = 0; $i < $#Ref_Date; $i++ ) {
        
        if( $year[$date_resp] eq $Ref_Date[$i] && $Violations[$i] eq "Total, all violations" && $STA[$i] eq "Total, adult charged" && $GEO[$i] eq "Canada" ) {
            
            if( $Value[$i] ne ".." ) {
                
                $total_val = $Value[$i];
            }
            
        }
        
    }
    
    $total_val = sprintf("%.f", $total_val);
    
    print("\nIn the year $year[$date_resp], a total of $total_val adults were charged\nwith a crime in Canada, based on all total violations.\n");
}


sub cTwo_qThree {
    
    my $location_resp = 0;
    my @location;
    my $greatest_val = 0;
    my $temp_val = 0;
    my $year = $EMPTY;
    my $count = 0;
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nLocations:\n");
    
    for( my $j = 1; $j < $#GEO; $j++ ) {
        
        if( $GEO[$j] ne $GEO[$j-1] ) {
        
            $location[$count] = $GEO[$j];
            $count++;
        
            print("$count: $location[$count - 1]\n");
        }
    }
    
    do {
        
        print("\nPlease choose a location based on the number to the left of it: ");
        
        $location_resp = <STDIN>;
        chomp $location_resp;
        
    } while( $location_resp < 1 || $location_resp > 18 );
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    for( my $i = 0; $i < $#Ref_Date; $i++ ) {
        
        if( $location[$location_resp - 1] eq $GEO[$i] && $Violations[$i] eq "Total, all violations" && $STA[$i] eq "Actual incidents" ) {
            
            if( $Value[$i] ne ".." ) {
                
                $temp_val = $Value[$i];
            }
            
            if( $temp_val > $greatest_val ) {
                
                $greatest_val = $temp_val;
                $year = $Ref_Date[$i];
            }
        }
    }
    
    $greatest_val = sprintf("%.f", $greatest_val);
    
    print("\n$location[$location_resp - 1] in $year had the most reported crime with a total\nof $greatest_val violations, based on known actual incidents.\n");
}

sub crime_location {
    
    my $count = 0;
    my $date_resp = 0;
    my $location_resp = 0;
    my @location = ("Canada", "Newfoundland and Labrador", "Prince Edward Island", "Nova Socia", "New Brunswick", "Quebec", "Ontario", "Manitoba", "Saskatchwean", "Alberta", "British Columbia", "Yukon", "Northwest Terrirtories", "Nunavut" );
    my $greatest_val1 = 0;
    my $greatest_val2 = 0;
    my $greatest_val3 = 0;
    my @temp_val1;
    my @temp_val2;
    my @temp_val3;
    my $temp_val4;
    my $temp_val5;
    my $swap2;
    my $swap;
    my @temp_array1;
    my @temp_array2;
    my $tb;
    my $dot = ".";
    my @year;
    
    
    
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nLocation:\n");
    
    for( my $j = 0; $j < 14; $j++ ) {
        
        print("$j: $location[$j]\n");
    }
    
    do {
        
        print("\nPlease choose a location based on the number to the left of it: ");
        $location_resp = <STDIN>;
        chomp $location_resp;
        
    } while ( $date_resp < 0 || $date_resp > 15 );
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nYears:\n");
    
    for( my $p = 1; $p < 19; $p++ ) {
        
        $year[$p] = $Ref_Date[$p];
        
        print("$p: $year[$p]\n");
    }
    do {
        
        print("\nPlease choose a year based on the number to the left of it: ");
        $date_resp = <STDIN>;
        chomp $date_resp;
        
    } while ( $date_resp < 1 || $date_resp > 18 );
    
    
    
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    $tb = Text::Table->new(
    "\nTop 10 Violations in $year[$date_resp], $location[$location_resp] \n--------------------------------------------", "\nStatistic\n----------"
    );
    
    my $j = 0;
    
    for (my $i = 0; $i <= $crime_count; $i++) {
        
        if ($STA[$i] eq "Actual incidents" && $GEO[$i] eq $location[$location_resp] && $Ref_Date[$i] eq $year[$date_resp] && $Value[$i] ne ".." && $Value[$i] != 0.00) {
            if ($Violations[$i] ne "Total, all violations" &&
                $Violations[$i] ne "Total, all Criminal Code violations (including traffic)" &&
                $Violations[$i] ne "Total, all Criminal Code violations (excluding traffic)" &&
                $Violations[$i] ne "Total violent Criminal Code violations" &&
                $Violations[$i] ne "Total property crime violations" &&
                $Violations[$i] ne "Total theft under \$5,000 (non-motor vehicle)" &&
                $Violations[$i] ne "Total other Criminal Code Violations" &&
                $Violations[$i] ne "Total mischief" &&
                $Violations[$i] ne "Total breaking and entering" &&
                $Violations[$i] ne "Total administration of justice violations" &&
                $Violations[$i] ne "Total other Criminal Code violations" &&
                $Violations[$i] ne "Total theft of motor vehicle" &&
                $Violations[$i] ne "Total Criminal Code Traffic violations" &&
                $Violations[$i] ne "Total Federal Statute violations" &&
                $Violations[$i] ne "Total Criminal Code traffic violations" &&
                $Violations[$i] ne "Total impaired driving" &&
                $Violations[$i] ne "Total other violations" &&
                $Violations[$i] ne "Total drug violations"
                ) {
                    
                    $temp_val1[$j] = $Ref_Date[$i];
                    $temp_val2[$j] = $Violations[$i];
                    $temp_val3[$j] = $Value[$i];
                    $j++;
                    
                    
            }

            
        }
        

    }
    
    for (my $c = 0 ; $c < $#temp_val3; $c++)
    {
        for (my $d = 0 ; $d < $c ; $d++)
        {
            if ($temp_val3[$c] > $temp_val3[$d]) {
                $swap       = $temp_val3[$c];
                $temp_val3[$c]   = $temp_val3[$d];
                $temp_val3[$d] = $swap;
                
                
                $swap2       = $temp_val2[$c];
                $temp_val2[$c]   = $temp_val2[$d];
                $temp_val2[$d] = $swap2;
            }
        }
    }
    
    for (my $k = 0 ; $k < 10; $k++) {
        $tb->load(
        [ $temp_val2[$k], $temp_val3[$k]]
        );
    }

    print $tb;
    
}

sub crime_location3 {
    
    my $count = 0;
    my $date_resp = 0;
    my $location_resp = 0;
    my @location = ("Canada", "Newfoundland and Labrador", "Prince Edward Island", "Nova Socia", "New Brunswick", "Quebec", "Ontario", "Manitoba", "Saskatchwean", "Alberta", "British Columbia", "Yukon", "Northwest Terrirtories", "Nunavut" );
    my $greatest_val1 = 0;
    my $greatest_val2 = 0;
    my $greatest_val3 = 0;
    my @temp_val1;
    my @temp_val2;
    my @temp_val3;
    my $temp_val4;
    my $temp_val5;
    my $swap2;
    my $swap;
    my @temp_array1;
    my @temp_array2;
    my $tb;
    my $dot = ".";
    my @year;
    
    
    
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nLocation:\n");
    
    for( my $j = 0; $j < 14; $j++ ) {
        
        print("$j: $location[$j]\n");
    }
    
    do {
        
        print("\nPlease choose a location based on the number to the left of it: ");
        $location_resp = <STDIN>;
        chomp $location_resp;
        
    } while ( $date_resp < 0 || $date_resp > 15 );
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nYears:\n");
    
    for( my $p = 1; $p < 19; $p++ ) {
        
        $year[$p] = $Ref_Date[$p];
        
        print("$p: $year[$p]\n");
    }
    do {
        
        print("\nPlease choose a year based on the number to the left of it: ");
        $date_resp = <STDIN>;
        chomp $date_resp;
        
    } while ( $date_resp < 1 || $date_resp > 18 );
    
    
    
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    $tb = Text::Table->new(
    "\nTop 10 of The Least Violations in $year[$date_resp], $location[$location_resp] \n--------------------------------------------", "\nStatistic\n----------"
    );
    
    my $j = 0;
    
    for (my $i = 0; $i <= $crime_count; $i++) {
        
        if ($STA[$i] eq "Actual incidents" && $GEO[$i] eq $location[$location_resp] && $Ref_Date[$i] eq $year[$date_resp] && $Value[$i] ne ".." && $Value[$i] != 0.00) {
            if ($Violations[$i] ne "Total, all violations" &&
                $Violations[$i] ne "Total, all Criminal Code violations (including traffic)" &&
                $Violations[$i] ne "Total, all Criminal Code violations (excluding traffic)" &&
                $Violations[$i] ne "Total violent Criminal Code violations" &&
                $Violations[$i] ne "Total property crime violations" &&
                $Violations[$i] ne "Total theft under \$5,000 (non-motor vehicle)") {
                
                $temp_val1[$j] = $Ref_Date[$i];
                $temp_val2[$j] = $Violations[$i];
                $temp_val3[$j] = $Value[$i];
                $j++;
                
                
            }
            
            }
        
        
        #print ("\nsome piece of shit output: $temp_val\n");
    }
    
    for (my $c = 0 ; $c < $#temp_val3; $c++)
    {
        for (my $d = 0 ; $d < $c ; $d++)
        {
            if ($temp_val3[$c] < $temp_val3[$d]) {
                $swap       = $temp_val3[$c];
                $temp_val3[$c]   = $temp_val3[$d];
                $temp_val3[$d] = $swap;
                
                
                $swap2       = $temp_val2[$c];
                $temp_val2[$c]   = $temp_val2[$d];
                $temp_val2[$d] = $swap2;
            }
        }
    }
    
    for (my $k = 0 ; $k < 10; $k++) {
        $tb->load(
        [ $temp_val2[$k], $temp_val3[$k]]
        );
    }
    #    print @temp_val2;
    #    print @temp_val3;
    print $tb;
    
}

sub crime_location2 {
    
    my $count = 0;
    my $date_resp = 0;
    my $location_resp = 0;
    my @location = ("Canada", "Newfoundland and Labrador", "Prince Edward Island", "Nova Socia", "New Brunswick", "Quebec", "Ontario", "Manitoba", "Saskatchewan", "Alberta", "British Columbia", "Yukon", "Northwest Terrirtories", "Nunavut" );
    my $greatest_val1 = 0;
    my $greatest_val2 = 0;
    my $greatest_val3 = 0;
    my @temp_val1;
    my @temp_val2;
    my @temp_val3;
    my $temp_val4;
    my $temp_val5;
    my $swap2;
    my $swap;
    my @temp_array1;
    my @temp_array2;
    my $tb;
    my $dot = ".";
    my @year;
    
    
    
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nLocation:\n");
    
    for( my $j = 0; $j < 14; $j++ ) {
        
        print("$j: $location[$j]\n");
    }
    
    do {
        
        print("\nPlease choose a location based on the number to the left of it: ");
        $location_resp = <STDIN>;
        chomp $location_resp;
        
    } while ( $date_resp < 0 || $date_resp > 15 );
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    print("\nYears:\n");
    
    for( my $p = 1; $p < 19; $p++ ) {
        
        $year[$p] = $Ref_Date[$p];
        
        print("$p: $year[$p]\n");
    }
    do {
        
        print("\nPlease choose a year based on the number to the left of it: ");
        $date_resp = <STDIN>;
        chomp $date_resp;
        
    } while ( $date_resp < 1 || $date_resp > 18 );
    
    
    
    
    print("\033[2J");    #Clears terminal window.
    print("\033[0;0H");
    
    $tb = Text::Table->new(
    "\nTop 10 Violations of Youth in $year[$date_resp], $location[$location_resp] \n--------------------------------------------", "\nStatistic\n----------"
    );
    
    my $j = 0;
    
    for (my $i = 0; $i <= $crime_count; $i++) {
        
        if ($STA[$i] eq "Total, youth charged" && $GEO[$i] eq $location[$location_resp] && $Ref_Date[$i] eq $year[$date_resp] && $Value[$i] ne ".." && $Value[$i] != 0.00) {
            if ($Violations[$i] ne "Total, all violations" &&
                $Violations[$i] ne "Total, all Criminal Code violations (including traffic)" &&
                $Violations[$i] ne "Total, all Criminal Code violations (excluding traffic)" &&
                $Violations[$i] ne "Total violent Criminal Code violations" &&
                $Violations[$i] ne "Total property crime violations" &&
                $Violations[$i] ne "Total theft under \$5,000 (non-motor vehicle)" &&
                $Violations[$i] ne "Total other Criminal Code Violations" &&
                $Violations[$i] ne "Total mischief" &&
                $Violations[$i] ne "Total breaking and entering" &&
                $Violations[$i] ne "Total administration of justice violations" &&
                $Violations[$i] ne "Total other Criminal Code violations" &&
                $Violations[$i] ne "Total theft of motor vehicle" &&
                $Violations[$i] ne "Total Criminal Code Traffic violations" &&
                $Violations[$i] ne "Total Federal Statute violations" &&
                $Violations[$i] ne "Total Criminal Code traffic violations" &&
                $Violations[$i] ne "Total impaired driving" &&
                $Violations[$i] ne "Total other violations" &&
                $Violations[$i] ne "Total drug violations"
                ) {
                    
                    $temp_val1[$j] = $Ref_Date[$i];
                    $temp_val2[$j] = $Violations[$i];
                    $temp_val3[$j] = $Value[$i];
                    $j++;
 
                }
        }
        
    }
    
    for (my $c = 0 ; $c < $#temp_val3; $c++)
    {
        for (my $d = 0 ; $d < $c ; $d++)
        {
            if ($temp_val3[$c] > $temp_val3[$d]) {
                $swap       = $temp_val3[$c];
                $temp_val3[$c]   = $temp_val3[$d];
                $temp_val3[$d] = $swap;
                
                
                $swap2       = $temp_val2[$c];
                $temp_val2[$c]   = $temp_val2[$d];
                $temp_val2[$d] = $swap2;
            }
        }
    }
    
    for (my $k = 0 ; $k < 10; $k++) {
        $tb->load(
        [ $temp_val2[$k], $temp_val3[$k]]
        );
    }
    
    print $tb;
    
}
    




