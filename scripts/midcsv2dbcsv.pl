#!/usr/bin/perl
#	"35", 36, # BD2
#	"36", 36, # BD2
#	"38", 38, #Snare
#	"40", 38, #Snare
#         "41", 65, #Tom Low
#         "42", 51, #Hihat
#         "43", 69, #Tom Mid#        
# "44", 51, #Hihat pedal
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

%note = (
       "35", 36,
       "36", 36,
       "38", 38,
       "40", 38,
         "41", 65,
         "42", 51,
         "43", 69,
         "44", 51,
         "45", 65,
         "46", 55,
        "47", 65,
         "48", 69,
         "49", 77,
         "50", 71,
         "51", 79,
         "52", 81,
         "53", 79,
         "55", 81,
         "57", 77,
         "59", 79);

$drums = 0;
$newtempo = 0;
$tempo = 0;

while(<>){
	@line = split('\, ', $_);
	$track = $line[0];
	$name = $line[4];
	$time = $line[1];
	$cmd = $line[2];
	$channel = $line[3];
	$velocity = $line[5];
	if($_ =~ "Note_" && $channel == 9){
	if($name == "35" ||
	 $name == "36" ||
	 $name == "38" ||
	 $name == "40" ||
	 $name == "41" ||
	 $name == "42" ||
	 $name == "43" ||
	 $name == "44" ||
	 $name == "45" ||
	 $name == "46" ||
	 $name == "47" ||
	 $name == "48" ||
	 $name == "49" ||
	 $name == "50" ||
	 $name == "51" ||
	 $name == "52" ||
	 $name == "53" ||
	 $name == "55" ||
	 $name == "57" ||
	 $name == "59")
	{ #IGNORE WOODBLOCK ETC.
		print "$track, $time, $cmd, $channel, $note{$name}, $velocity";
	}
	}
	elsif ($_ !~ "Note_"){
		if($_ =~ " Header,"){
		@line1 = split('\, ', $_);
		  if($line1[5] =~ 120){
			$line1[5] = "100\n";
			$newtempo = 1;
			$div = 120;
		  }
		  if($line1[5] =~ 192){
			$line1[5] = "192\n";
			$newtempo = 1;
			$div = 192;
		  }
		 if($line1[5] =~ 480){
			$line1[5] = "480\n";
			$newtempo = 1;
			$div = 480;
		  }
		 if($line1[5] =~ 960){
			$line1[5] = "960\n";
			$newtempo = 1;
			$div = 960;
		  }
		 if($line1[5] =~ 1024){
			$line1[5] = "1024\n";
			$newtempo = 1;
			$div = 1024;
		  }
			print "$line1[0], $line1[1], $line1[2], $line1[3], $line1[4], $line1[5]";
		}
		elsif($_ =~ " Tempo,"){
                        @line2 = split('\, ', $_);
			if($newtempo == 1 && $div == 120 && $line2[3] != 1234567 && $line2[3] < 700000){
			  $tempo = 400000;
			  print "$line2[0], $line2[1], $line2[2], $tempo\n";
			}			
                        elsif($newtempo == 1 && $div == 192 && $line2[3] != 1234567 && $line2[3] < 700000){
			  $tempo = 500000;
			  print "$line2[0], $line2[1], $line2[2], $tempo\n";
			}			
                        elsif($newtempo == 1 && $div == 480 && $line2[3] != 1234567 && $line2[3] < 800000){
			  $tempo = 600000;
			  print "$line2[0], $line2[1], $line2[2], $tempo\n";
			}
                        elsif($newtempo == 1 && $div == 960 && $line2[3] == 227272 && $line2[3] < 1000000){
			  $tempo = 300000;
			  print "$line2[0], $line2[1], $line2[2], $tempo\n";
			}
                        elsif($newtempo == 1 && $div == 1024 && $line2[3] < 1000000){
			  $tempo = 600000;
			  print "$line2[0], $line2[1], $line2[2], $tempo\n";
			}
			else{
				print $_;
			}
		}
		else{
		print $_;
		}
	}
        }
