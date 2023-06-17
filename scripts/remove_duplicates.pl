#!/usr/bin/perl
#	"35", 36, # BD2
#	"36", 36, # BD2
#	"38", 38, #Snare
#	"40", 38, #Snare
#         "41", 65, #Tom Low
#         "42", 51, #Hihat
#         "43", 69, #Tom Mid
#         "44", 51, #Hihat
#         "45", 65, #Tom Low
#         "46", 55, #OpenHihat
#         "47", 65, #Tom Low
#         "48", 69, #Tom Mid
#         "49", 77, #Crash
#         "50", 71, #Tom Hi
#         "51", 79, #Ride
#         "52", 81, #Splash
#         "53", 79, #Ride
#         "55", 81, #Splash
#         "57", 77, #Crash
#         "59", 79); #Ride

%note = ();
%sorted = ();

$prevtime = 0;
while(<>){
	@line = split('\, ', $_);
	$track = $line[0];
	$name = $line[4];
	$time = $line[1];
	$cmd = $line[2];
	$channel = $line[3];
	$velocity = $line[5];

	if($_ =~ "Note_" && $channel == 9){
		if($_ =~ "Note_on_c" && $time - $prevtime <= 10){
			if($velocity == 0){
			#print STDERR "velocity = 0: $_";
			#	print $_;
			}
			else{
			$note{$name} = $_;
			}
			
		}	
		elsif($time-$prevtime > 10){
			$size = keys %note;
			foreach $key (values %note){
				@line3 = split('\, ', $key);
				$sorted{$key} = $line3[1];
			}

		  	if(($size == 3 && $note{"36"} == null) || $size > 3){
		print STDERR "removing hi-hat at time $prevtime\n";
			foreach my $key (sort {$sorted{$a} <=> $sorted{$b}} keys %sorted){
				#print STDERR "line: $key";
				@line2 = split('\, ', $key);
				if($line2[4] != "51" && $line2[4] != "55"){
					print "$key" 
				}
			}
			}
			else{
				foreach my $key (sort {$sorted{$a} <=> $sorted{$b}} keys %sorted){
					print "$key";
				}
				%note = ();
			}
		
			foreach my $key (keys %sorted){
					@line = split('\, ', $key);
					$noteoff = $prevtime+1;
					print "$line[0], $noteoff, Note_off_c, $line[3], $line[4], $line[5]";
			}
			

			# new time
			%note = ();
			%sorted = ();
			if($_ =~ "Note_on_c"){
			if($velocity == 0){
				#print $_;
			}
			else{
			$note{$name} = $_;
			}
			}
			
		}

	
	}
	elsif ($_ !~ "Note_" && $_ !~ "Sequencer_specific,"){
		$size = keys %note;
		foreach $key (values %note){
				@line3 = split('\, ', $key);
				$sorted{$key} = $line3[1];
		}

		if(($size == 3 && $note{"36"} == null) || $size > 3){
		print STDERR "removing hi-hat at time $prevtime\n";
			foreach my $key (sort {$sorted{$a} <=> $sorted{$b}} keys %sorted){
				#print STDERR "line: $key";
				@line2 = split('\, ', $key);
				if($line2[4] != "51" && $line2[4] != "55"){
					print "$key";
				}
			}
			}
		else{
		foreach my $key (sort {$sorted{$a} <=> $sorted{$b}} keys %sorted){
					print "$key";
		}
		
		foreach my $key (sort {$sorted{$a} <=> $sorted{$b}} keys %sorted){
					@line = split('\, ', $key);
					$noteoff = $prevtime+1;
					print "$line[0], $noteoff, Note_off_c, $line[3], $line[4], $line[5]";
		}

		}
		%note = ();
		%sorted = ();
                if($_ =~ "End_track"){
                @line = split('\, ', $_);
                $noteoff = $line[1]+1;
                print "$line[0], $noteoff, $line[2]"
                }
                else{
		print $_;
                }
	}
	
	if($velocity != 0 && $_ !~ "Sequencer_specific,"){
	$prevtime = $time;
	}
        }
