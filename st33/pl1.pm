package ST32;
use  strict;

my @list;

my @MainMenu =
( 
	  "1. Add element",  
	  "2. Edit element",
	  "3. Delete element",
	  "4. Save to file ",
	  "5. Show element ",
	  "6. Load from file ",
	  "7. Exit "
 );


my @MENU =
(
          \&add,\&edit,\&delete,\&save,\&show,\&load,
);


while(1)
{
	my $ch = MainPrint();
	if(defined $MENU[$ch])
	{ 
		$MENU[$ch]->();
	}
	else
	{
		return;
	}
}


 sub MainPrint {
 my $i = 1;
 print "\n";
 print "Choose number:\n"; 
	foreach my $s(@MainMenu)
	{
		print "$s\n";
	} 
 print "\n";
 my $ch = <STDIN>;
 return ($ch-1)
 }


sub add {

print " Name\n";
my $name = <STDIN>;
print " Group\n";
my $group = <STDIN>;
print " TelefonNumber\n";
my $TelefonNumber = <STDIN>;

my $people=
{
	Name => $name,
	Group => $group,
	TelefonNumber => $TelefonNumber};
	
push(@list,$people);
print "New employee has been added!\n";
}

sub edit {
	print "\n Enter the number to edit\n";
	show();
	my $n = <STDIN>;
	if (defined $list[$n-1])
	{ 
		print "Name\n";
		my $new = <STDIN>;
		$list[$n-1]->{Name}=$new;

		print "Group\n";
		$new = <STDIN>;
		$list[$n-1]->{Group}=$new;

		print "TelefonNumber\n";
		$new = <STDIN>;
		$list[$n-1]->{TelefonNumber}=$new;

		
		print "You have made changes!\n";
		} 
		else {
		print "No object with this number!\n";
	}

}

  sub show {
  my $i=0;
  print "The list of employees:\n";
	 foreach my $arg(@list)
		 {
			$i++; 
			print "$i. $arg->{Name}   $arg->{Group}   $arg->{TelefonNumber}  \n";
		
		 }
	if ($i==0) {print "List is empty\n";}
		
 }

sub delete {
print " \Enter the number to delete\n";
show();
my $n = <STDIN>;
if (defined $list[$n-1])
{ 
	splice(@list,$n-1,1);
	print "The employee has been deleted!\n";
	} else 
{
print "No object with this number!\n";
}
}


 sub save
{
	my %hash=();
	dbmopen( %hash, "dbmfile", 0644);
	my $j=0;
	foreach my $i(@list)
	{	
		$hash{$j}= join(":", $i->{Name},$i->{Group},$i->{TelefonNumber});
		$j++;
	}
	dbmclose(%hash);
	print "saved!\n";
 }

sub load
{
	
	dbmopen(my %hash, "dbmfile", 0644);
	@list=();
		
         while (( my $key,my $value) = each(%hash))

	{       

		 my @arg=split(/:/,$hash{$key});
		 my $people={
		  Name => "$arg[0]",
		  Group => "$arg[1]",
		  TelefonNumber => "$arg[2]"};
		  
		 $list[$key]=$people;
	}
	
	dbmclose(%hash);	
        print "loaded!\n";
 }
 
 return 1; 
