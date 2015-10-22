#!/usr/local/bin/perl
package ST43;
use strict;
use v5.10.1;

my $menu="\n1.Add book\n2.Show all books\n3.Delete book\n4.Edit book\n5.Save file\n6.Read file\n7.Exit\n";
my @functions = (\&add, \&show, \&delete, \&edit, \&save, \&read, \&exit);
my @books;

sub st43 {
	print "st43:st43\n";
	while (1){
		
		print "$menu";
		chomp (my $selection=<STDIN>); 
		if (($selection>0)&&($selection<8))
		{
			$functions[$selection-1]->();
		}
		else
		{
			print "Try another selection\n"
		}
	}
}

sub add{
	print "Enter book name\n";
	chomp (my $bookname=<STDIN>);
	print "Enter publishing year\n";
	chomp (my $publishYear=<STDIN>);
	print "Enter publishing house\n";
	chomp (my $publishHouse=<STDIN>);
	my %Tem=(BOOKNAME => $bookname,PUBLISHYEAR => $publishYear,PUBLISHHOUSE => $publishHouse);
	push (@books, \%Tem);
	#print $books[0];
	
}

sub show{
	if (@books){
		my $arrayBooks=@books;
		for (my $i=0; $i<$arrayBooks; $i++)
		{
			my $k=$i+1;
			print $k.". ".$books[$i]->{BOOKNAME}."; ".$books[$i]->{PUBLISHYEAR}."; ".$books[$i]->{PUBLISHHOUSE}.".\n";
		}
	}
	else 
	{
		print "There isn't books yet\n";
	}
}

sub delete{
	if (@books){
		print "\nSelect number of book, that you need to delete\n";
		$functions[1]->();
		chomp (my $num = <STDIN>); 
		splice(@books,$num-1,1);
		print "\nNow your list is:\n";
		$functions[1]->();
		}
	else 
	{
		print "Nothing to delete";
	}
}

sub edit{
	if (@books){
		print "\nSelect number of book, that you need to edit\n";
		$functions[1]->();
		chomp (my $num1 = <STDIN>); 
		print "\nSelect property, that you need to edit\n1. Book name\n2. Publishing year\n3. Publishing house\n";
		chomp (my $num2 = <STDIN>);
		given ($num2){
			when (1){
				print "Print new book name\n";
				chomp (my $prop = <STDIN>);
				$books[$num1-1]->{BOOKNAME}=$prop;
			}
			when (2){
				print "Print new publishing year\n";
				chomp (my $prop = <STDIN>);
				$books[$num1-1]->{PUBLISHYEAR}=$prop;
			}
			when (3){
				print "Print new publishing house\n";
				chomp (my $prop = <STDIN>);
				$books[$num1-1]->{PUBLISHHOUSE}=$prop;
			}
		}
		print "\nNow your list is:\n";
		$functions[1]->();
		}
	else 
	{
		print "Nothing to edit";
	}
}

sub save{
	my %dbhash=();
	dbmopen(%dbhash, "file", 0666);
	my $arrayBooks=@books;
		for (my $i=0; $i<$arrayBooks; $i++)
		{
			$dbhash{$i}= join (";",$books[$i]->{BOOKNAME},$books[$i]->{PUBLISHYEAR},$books[$i]->{PUBLISHHOUSE});
		}
		dbmclose %dbhash;
	print "\nDone\n";
}

sub read{
	@books=();
	my %dbhash=();
	dbmopen(%dbhash,"file",0666);
	foreach my $key (keys %dbhash)
	{
		my @a = split(/;/,$dbhash{$key});
		my $bookname = $a[0];
		my $publishYear = $a[1];
		my $publishHouse=$a[2];
		my %Tem=(BOOKNAME => $bookname,PUBLISHYEAR => $publishYear,PUBLISHHOUSE => $publishHouse);
		push (@books, \%Tem);
	}
	dbmclose %dbhash;
	print "\nDone\n";
}
sub exit{
	last;
}
return 1;