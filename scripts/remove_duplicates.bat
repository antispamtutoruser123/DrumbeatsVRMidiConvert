:: remove hihat from drumbeatsvr midi file whenever there are too many notes at one time
:: Requires perl (strawberryperl.com) 
:: Uses csv2midi (https://www.fourmilab.ch/webtools/midicsv/) 
:: Usage: remove_duplicates.bat <drumbeatsvr>.mid (supports wildcard)

@echo off

IF %1.==. GOTO No1


for %%a in ("%~1") do (
.\Midicsv\Midicsv.exe %%a > temp.csv
perl .\scripts\remove_duplicates.pl temp.csv > temp.out.csv

echo Writing file: .\output\%%~na.mid
.\Midicsv\Csvmidi.exe temp.out.csv > .\output\%%~na.mid
del temp.csv temp.out.csv
)


GOTO End1

:No1
  echo ERROR Usage: remove_duplicates.bat <drumbeatsvr>.mid (supports wildcard)
GOTO End1
:End1