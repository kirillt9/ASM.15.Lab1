#!/usr/bin/perl

use strict;

use st00::st00;
use st04::st04;
use st07::st07;
use st26::st26;
my @MODULES =
(
	\&ST00::st00,
	\&ST04::st04,
	\&ST07::st07,
	\&ST26::st26,
);

my @NAMES =
(
	"00. Sample",
	"04. Borisenko",
	"07. Gorinov",
	"26. Mikaelian",
);

sub menu
{
	my $i = 0;
	print "\n------------------------------\n";
	foreach my $s(@NAMES)
	{
		print "$i. $s\n";
		$i++;
	}
	print "------------------------------\n";
	my $ch = <STDIN>;
	return ($ch);
}

while(1)
{
	my $ch = menu();
	if(defined $MODULES[$ch])
	{
		print $NAMES[$ch]." launching...\n\n";
		$MODULES[$ch]->();
	}
	else
	{
		exit();
	}
}
