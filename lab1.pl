#!/usr/bin/perl

use strict;

use st00::st00;
use st02::st02;
use st04::st04;
use st07::st07;
use st09::st09;
use st18::st18;
use st24::st24;
use st26::st26;
use st28::st28;
use st29::st29;
use st30::st30;
use st45::st45;
use st47::st47;


my @MODULES =
(
	\&ST00::st00,
	\&ST02::st02,
	\&ST04::st04,
	\&ST07::st07,	
	\&ST09::st09,
	\&ST18::st18,
	\&ST24::st24,
	\&ST26::st26,
	\&ST28::st28,
	\&ST29::st29,
	\&ST30::st30,
	\&ST45::st45,
	\&ST47::st47,
	
	
);

my @NAMES =
(
	"00. Sample",
	"02. Badrudinova",
	"04. Borisenko",
	"07. Gorinov",
	"09. Greznev",
	"18. Klykov",
	"24. Mamedov",
	"26. Mikaelian",
	"28. Nikolaeva",
	"29. Novozhentsev",
	"30. Pereverzev",
	"45. Yazkov",
	"47. Utenov",
	
	
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
