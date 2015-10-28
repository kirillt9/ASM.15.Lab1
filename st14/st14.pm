package ST14;
use  strict;

my @list;

my @MainScreen =
( 
	  "1. Add employee",  
	  "2. Edit list",
	  "3. Delete",
	  "4. Show list ",
	  "5. Save to file",
	  "6. Load from file",
	  "7. Exit"
 );

sub st14 {
my @MENU =
(
	\&add,\&ed,\&del,\&show,\&save,\&load,
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
}

 sub MainPrint {
 my $i = 1;
 print "\n";
 print "Choose number:\n"; 
	foreach my $s(@MainScreen)
	{
		print "$s\n";
	} 
 print "\n";
 my $ch = <STDIN>;
 return ($ch-1)
 }


sub add {

print "Name and Surname\n";
my $name = <STDIN>;
print "Age\n";
my $age = <STDIN>;
print "Post\n";
my $post = <STDIN>;
print "Salary\n";
my $salary = <STDIN>;
my $man=
{
	Name => $name,
	Age => $age,
	Post => $post,
	Salary => $salary};
push(@list,$man);
print "New employee has been added!\n";
}

sub ed {
	print "Enter the number to edit\n";
	show();
	my $n = <STDIN>;
	if (defined $list[$n-1])
	{ 
		print "Name and Surname\n";
		my $new = <STDIN>;
		$list[$n-1]->{Name}=$new;

		print "Age\n";
		$new = <STDIN>;
		$list[$n-1]->{Age}=$new;

		print "Post\n";
		$new = <STDIN>;
		$list[$n-1]->{Post}=$new;

		print "Salary\n";
		$new = <STDIN>;
		$list[$n-1]->{Salary}=$new;
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
			print "$i. $arg->{Name}   $arg->{Age}   $arg->{Post}   $arg->{Salary}\n";
		
		 }
	if ($i==0) {print "List is empty\n";}
		
 }

sub del {
print "Enter the number to delete\n";
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
		$hash{$j}= join(":", $i->{Name},$i->{Age},$i->{Post},$i->{Salary});
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
		 my $man={
		  Name => "$arg[0]",
		  Age => "$arg[1]",
		  Post => "$arg[2]",
		  Salary => "$arg[3]"};
		 $list[$key]=$man;
	}
	
	dbmclose(%hash);
	
print "loaded!\n";
 }
  return 1; 
