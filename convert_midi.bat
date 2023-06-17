:: V1.38
:: Converts general midi file to drumbeats VR midi
:: Requires perl (strawberryperl.com) 
:: Uses csv2midi (https://www.fourmilab.ch/webtools/midicsv/) 
:: Usage: drag midi file onto this script.  output files will be in output directory.  copy output files to Drumbeatsvr Songs directory.
@echo off
set PATH=%PATH%;C:\"Program Files (X86)"\VideoLAN\VLC

IF %1.==. GOTO No1
:: IF %2.==. GOTO No1

for %%a in ("%~1") do (
.\Midicsv\Midicsv.exe %%a > temp.csv

perl .\scripts\newtempo.pl temp.csv > newtempo.csv
.\Midicsv\Csvmidi.exe newtempo.csv > .\output\%%~na.tmp.mid
del newtempo.csv 

perl .\scripts\midcsv2dbcsv.pl temp.csv > temp.out.csv
echo Writing file: .\output\%%~na.mid
.\Midicsv\Csvmidi.exe temp.out.csv > .\output\%%~na.mid
del temp.csv temp.out.csv
)


echo Generating MP3 files...
for %%a in ("%~1") do (
echo Writing file: .\output\%%~na.mp3
vlc.exe .\output\%%~na.tmp.mid --sout "#transcode{acodec=mp3,ab=128}:std{access=file,mux=dummy,dst=.\output\%%~na.mp3} vlc://quit"
del .\output\%%~na.tmp.mid
)


echo Removing duplicate hi-hats...
for %%a in ("%~1") do (
call .\scripts\remove_duplicates.bat .\output\%%~na.mid
)

GOTO End1

:No1
  echo ERROR Usage: convert_midi.bat *.mid
GOTO End1

:End1
  echo Done!