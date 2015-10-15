
package ST18;
use strict;
use warnings;
use 5.010;


my %DbmFileHash =();
my @data;
my $i;

my %MenuHash =
				(
					"1" =>  \& LoadList,
					"2" =>  \& ShowList,
					"3" =>	\&AddElement,
					"4" =>	\&DelElement,
					"5" =>	\&EditRecord,
					"6" =>	\&SavetoDbm
				);



sub LoadList
{
	    dbmopen (%DbmFileHash, "dbmfile_18",0666);
		@data = ();
		while (my ($key, $value) = each(%DbmFileHash))
		{

			my ($name, $mail) = split(/--/, $value);
			my %record = (
				name => $name,
				mail => $mail,
			);
			push(@data, \%record);
		}
		dbmclose %DbmFileHash;
		
}

sub ShowList
{
	$i=0;
    if(@data)
    {
        print "\nGroup\n" ;
		foreach my $record(@data) 
		    	{
		    		++$i;
		    		print "$i. "."name: ".$record->{name}." mail: ".$record->{mail}."\n";
		    	}
    }
    else
    {
    	print "No elements or list is not loaded\n";
    }
}

sub AddElement
{
	print "Insert person name:\n";
	my $tmpName = <STDIN>;
	chomp $tmpName;

	print "Insert person mail:\n";
	my $tmpmail = <STDIN>;
	chomp $tmpmail;

	my %record =
	(
			name => $tmpName,
			mail => $tmpmail
	);
    	push(@data, \%record);
 }

sub DelElement
{
	my $tmpdel;
	print "Insert number:\n";
	$tmpdel = <STDIN>;
	chomp $tmpdel;
	while($tmpdel < 0 || $tmpdel > @data)
	{
			print "Enter right number of element \n";
			$tmpdel = <STDIN>;
			chomp $tmpdel;
	}
	splice @data, $tmpdel - 1, 1;
}


sub EditRecord
{
	my $tmpedit;
	print "Insert record number:\n";
	$tmpedit = <STDIN>;
	chomp $tmpedit;
	while($tmpedit < 0 || $tmpedit > @data)
	{
			print "Enter right number of element \n";
			$tmpedit = <STDIN>;
			chomp $tmpedit;
	}
	my $record = $data[$tmpedit - 1];
	print "Insert new person name (current name: ".$record->{name}.") or press \"Enter\":\n";
	my $value = <STDIN>;
	if($value)
	{
	 	$record->{name} = $value;
	}
	print "Insert new mail (current mail: ".$record->{mail}.") or just press \"Enter\":\n";
	$value = <STDIN>;
	if($value)
	{
		$record->{mail} = $value;
	}  

}

sub SavetoDbm
{
	my %buffer =();
	dbmopen (%buffer, "dbmfile_18",0666);
	$i = 0;
	foreach my $record(@data) 
	{
		$buffer{$i} = join('--', $record->{name}, $record->{mail});
		++$i;
	}
	dbmclose(%buffer);

}

sub st18
{
	
	#until(0)
	print "\n"."Action:\n"."1)Load list\n"."2)Show list\n"."3)Add record\n"."4)Delete record\n"."5)Edit record\n"."6)Save list\n"."7)Exit\n";
	while (my $line=<STDIN>)
	{ 

		chomp $line;
		last if $line eq "7";
		
		given($line){
			when (1) {$MenuHash{"1"}->();}
			when (2) {$MenuHash{"2"}->();}
			when (3) {$MenuHash{"3"}->();}
			when (4) {$MenuHash{"4"}->();}
			when (5) {$MenuHash{"5"}->();}
			when (6) {$MenuHash{"6"}->();}
			when (7) {last;}
			default {print "No such command";}
		}
		

		
		
	}

	#}
}



return 1;