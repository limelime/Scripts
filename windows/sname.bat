:: Description: Clean song name from an input file to <Title>-<Year>-<Artists>
:: Require: sed.exe
:: Author: Xuan Ngo
:: Version: 1.0

@ECHO OFF

SET filename=%1

sed -e 's/ /./g' %filename% | ^
sed -e 's/\t/./g' | ^
sed -e 's/,\././g' | ^
sed -e 's/\.\././g' | ^
sed -e 's/\.-\./-/g' | ^
sed -e 's/\'\./\'/g' | ^
sed -e 's/\.(/(/g' | ^
sed -e 's/\.\([1-2][0-9][0-9][0-9]\)\./-\1-/g'
