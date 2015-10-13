#!/usr/bin/perl

use strict;

use st00::st00;
use st04::st04;
use st07::st07;
use st09::st09;
use st18::st18;
use st26::st26;
use st28::st28;
use st30::st30;


my @MODULES =
(
	\&ST00::st00,
	\&ST04::st04,
	\&ST07::st07,	
	\&ST09::st09,
	\&ST18::st18,
	\&ST26::st26,
	\&ST28::st28,
	\&ST30::st30,
	
);

my @NAMES =
(
	"00. Sample",
	"04. Borisenko",
	"07. Gorinov",
	"09. Greznev",
	"18. Klykov",
	"26. Mikaelian",
	"28. Nikolaeva",
	"30. Pereverzev",
	
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
