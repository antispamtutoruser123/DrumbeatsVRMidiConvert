#!/usr/bin/perl

$newtempo = 0;
$tempo = 0;
$div = 0;
while(<>){
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
			$div = 480
		  }		  
		  if($line1[5] =~ 960){
			$line1[5] = "960\n";
			$newtempo = 1;
			$div = 960
		  }
		  if($line1[5] =~ 1024){
			$line1[5] = "1024\n";
			$newtempo = 1;
			$div = 1024
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

