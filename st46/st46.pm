
package ST46;
use  strict;

my %flat;

my @func =
(
	\&add,
	\&edit,
	\&delete,
	\&show,
	\&write,
	\&read,
);

sub st46 {
while(1)
{
print "\nEnter the num:\n";
print 
"1.Add  
2.Edit 
3.Delete  
4.Show
5.Write to file
6.Read from file 
7.Exit\n";

	my $ch = <STDIN>;
	if(defined $func[$ch-1])
	{ 
		$func[$ch-1]->();
	}
	else
	{
		return;
		
	}
}
}


sub add {
	print "Enter apartment number\n";
	chomp(my $num = <STDIN>);
	if (!exists $flat{$num}) 
	{
		print "Enter number of people\n";
		chomp(my $men = <STDIN>);
		print "Enter number of rooms\n";
		chomp(my $room = <STDIN>);
		print "Enter surname family\n";
		chomp(my $surname = <STDIN>);
		$flat{$num}={Men => $men, Room => $room, Surname => $surname};
		print "added\n";
		} 
		else {
		print "!Flat with this number already exists!\n";
	}
}

sub edit {
	show();
	print "Enter apartment number\n";
	chomp(my $num = <STDIN>);
	if (exists $flat{$num})
	{ 
		foreach my $val (sort keys %{$flat{$num}} )
		{
		print "$val: ";
		chomp(my $i=<STDIN>);
		$flat{$num}->{$val}=$i;
		}
		print "changed\n";
		} 
		else {
		print "No apartment with this number\n";
	}
}

 sub show {
	foreach my $num (sort {$a<=>$b} keys %flat )
	{ 
		print "\napartment number: $num \n";
		foreach my $val (sort keys %{$flat{$num}})
		{
		print "$val: $flat{$num}->{$val}\n";
		}
	}
 }

sub delete {
	show();
	print "Enter apartment number\n";
	chomp(my $n = <STDIN>);
	if (exists $flat{$n})
	{
		delete $flat{$n};
		print "Deleted\n";
		}else {
		print "No apartment with this number\n";
	}
}


 sub write
 {
	dbmopen(my %hash, "dbm", 0644);
	%hash=();
	foreach my $num(keys %flat)
	{	
		$hash{$num}=join("<>", $flat{$num}->{Men},$flat{$num}->{Room},$flat{$num}->{Surname});
	}
	dbmclose(%hash);
	print "written\n";
 }

 sub read
 {
	dbmopen(my %hash, "dbm", 0644);
	%flat=();
	while ((my $num,my $value) = each(%hash))
	{
	my @val=split(/<>/,$hash{$num});
	$flat{$num}={Men => "$val[0]", Room => "$val[1]",Surname => "$val[2]"};
	}
	dbmclose(%hash);
	print "read\n";
 }
 
 return 1;