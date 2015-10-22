#!/usr/bin/perl

use strict;

use st00::st00;
use st01::st01;
use st02::st02;
use st03::st03;
use st04::st04;
use st07::st07;
use st08::st08;
use st09::st09;
use st17::st17;
use st18::st18;
use st19::st19;
use st24::st24;
use st26::st26;
use st27::st27;
use st28::st28;
use st29::st29;
use st30::st30;
use st31::st31;
use st32::st32;
use st38::st38;
use st39::st39;
use st43::st43;
use st45::st45;
use st46::st46;


my @MODULES =
(
	\&ST00::st00,
	\&ST01::st01,
	\&ST02::st02,
	\&ST03::st03,
	\&ST04::st04,
	\&ST07::st07,	
	\&ST08::st08,
	\&ST09::st09,
	\&ST17::st17,
	\&ST18::st18,
	\&ST19::st19,	
	\&ST24::st24,
	\&ST26::st26,
	\&ST27::st27,
	\&ST28::st28,
	\&ST29::st29,
	\&ST30::st30,
	\&ST31::st31,
	\&ST32::st32,
	\&ST38::st38,
	\&ST39::st39,
	\&ST43::st43,
	\&ST45::st45,
	\&ST46::st46,	
	
);

my @NAMES =
(
	"00. Sample",
	"01. Baglikova",
	"02. Badrudinova",
	"03. Baranov",
	"04. Borisenko",
	"07. Gorinov",
	"08. Gracheva",
	"09. Greznev",
	"17. Kirichenko",
	"18. Klykov",
	"19. Konstantinova",
	"24. Mamedov",
	"26. Mikaelian",
	"27. Nikishaev",
	"28. Nikolaeva",
	"29. Novozhentsev",
	"30. Pereverzev",
	"31. Podkolzin",
	"32. Pyatakhina",
	"38. Stepenko",
	"39. Stupin",
	"43. Frolov",
	"45. Yazkov",
	"46. Bushmakin",	
	
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
