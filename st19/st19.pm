#!/usr/bin/perl
package ST19;

use strict;
sub st19{
while(1)
{print " \nChoose:\n
1. Add
2. Redact
3. Delete
4. Show
5. Save
6. Download
7. Exit\n ";

my %MENU = (1=>\&add, 2=>\&red, 3=>\&del, 4=>\&show, 5=>\&save, 6=>\&load);
chomp(my $in = <STDIN>);
if (($in > 0)&&($in < 7))
{$MENU{$in}->();}
elsif ($in == 7) {last;}
else {print "Error\n";}
}
my @library;
sub add{
print "\nEnter book title\n";
chomp(my $title = <STDIN>);
print "Enter book year\n";
my $year = <STDIN>;
my $book = {title => $title, year => $year};
push @library, $book;}

sub redact{
	print "\nSelect element to edit (enter book title):\n";
	chomp(my $edit_title = <STDIN>);
	my $f = 0; 
	
	for (my $i = 0; $i < @library; $i++)
	{if (($library[$i]->{title}) eq $edit_title)
	 {print "\nDo you want to change book title(0)/year(1)?:\n";
		chomp(my $select = <STDIN>);
	if ($select)
	{print "\nEnter new book year:\n";
	my $year = <STDIN>;
	$library[$i]->{year} = $year;$f = 1;}
	else
	{print "\nEnter new book title:\n";
	chomp(my $title = <STDIN>);
	$library[$i]->{title} = $title;$f = 1;}
	last;}}
	if (!$f){print "\nThere is no such element\n";}}

sub del{
	print "\nSelect item to delete (enter book title):\n";
	chomp(my $del_title = <STDIN>);
	my $f = 0; 
	
	for (my $i = 0; $i < @library; $i++)
	{if (($library[$i]->{title}) eq $del_title)
		{delete ($library[$i]);$f = 1;last;}}
	if (!$f){print "\nThere is no such element\n";}} 

sub show{
	if (@library)
	{for (my $i = 0; $i < @library; $i++)
	{print "\ntitle: ".$library[$i]->{title}."\nyear: ".$library[$i]->{year}."//////////////////";}}
	else {print "\nThe list is empty\n";}}

sub save{
	dbmopen(my %HASH,"1.txt",0666)or die "Can't open file: $!\n";
	%HASH = ();
	for (my $i = 0; $i < @library; $i++)
	{$HASH{$i} = join("##",$library[$i]->{title},$library[$i]->{year});}
	dbmclose %HASH;
	print "\nList loaded in the file\n";}

sub load{
	for (my $i = 0; $i < @library; $i++)
	{delete ($library[$i]);}
	dbmopen(my %HASH,"1.txt",0666)or die "Can't open file: $!\n";
	foreach my $key (keys %HASH)
	{my @a = split(/##/,$HASH{$key});
	my $title = @a[0];
	my $year = @a[1];
	my $book = {title => $title, year => $year};
	push @library, $book;}
	dbmclose %HASH;
	print "\nThe list is loaded from a file\n";}}
