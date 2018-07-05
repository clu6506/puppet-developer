#!/bin/bash
source_dir=$1;
find "$1" -type f -name "*.pdf" -print0|while read -d $'\0' file;
do
if [ `strings "$file"|grep -c "www.it-ebooks.info"` -gt 0 ];
then
echo "$file";
cp "$file" /tmp/1.pdf;
script=$(cat <<'EOF'
use strict;
use warnings;
open(my $in, '<', '/tmp/1.pdf')
or die "Cannot open input.txt: $!";
open(my $out, '>', '/tmp/2.pdf')
or die "Cannot open output.txt: $!";
while (<$in>) {
print $out $_ unless /www.it-ebooks.info/;
}
close($in);
close($out);
EOF
)
/usr/bin/perl -e "$script"
mv -v /tmp/2.pdf "$file";
rm /tmp/1.pdf
fi;
done

# Usage:
# chmod +x rm-ite.sh
# ./rm-ite.sh ~/pdf-dir
