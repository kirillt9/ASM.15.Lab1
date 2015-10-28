package ST22;
use  strict;

my @list;


my @menu =
( 
	"1.Add object.",
	"2.Change.",
	"3.Delete.",
	"4.Print all elements.",
	"5.Save as file.",
	"6.Read file.",
	"7.Exit."
 );


my @option_func =
(
\&add,
\&change,
\&delete,
\&printall,
\&tofile,
\&fromfile,
);

sub st22 {
while(1)
{
	my $ch = Print();
	if(defined $option_func[$ch])
	{ 
		$option_func[$ch]->();
	}
	else
	{
		return;
	}
}
}

 sub Print {
 my $i = 1;
 print "\n";
 print "Menu:\n"; 
	foreach my $s(@menu)
	{
		print "$s\n";
	} 
 print "\n";
 my $ch = <STDIN>;
 return ($ch-1)
 }


sub add {

print "press name\n";
my $name = <STDIN>;
print "press age\n";
my $age = <STDIN>;
print "press group\n";
my $group = <STDIN>;
print "press mail\n";
my $mail = <STDIN>;
my $students=
{
	Name => $name,
	Age => $age,
	Group => $group,
	Mail => $mail};
push(@list,$students);

}

sub change {
	print "press number of changed object\n";
	printall();
	my $n = <STDIN>;
	if (defined $list[$n-1])
	{ 
		print "press name\n";
		my $new = <STDIN>;
		$list[$n-1]->{Name}=$new;

		print "press age\n";
		$new = <STDIN>;
		$list[$n-1]->{Age}=$new;

		print "press group\n";
		$new = <STDIN>;
		$list[$n-1]->{Group}=$new;

		print "press mail\n";
		$new = <STDIN>;
		$list[$n-1]->{Mail}=$new;
		print "object changed\n";
		} 
		else {
		print "no object with this number!\n";
	}

}

sub printall {
 my $i=0;
print "the list of students:\n";
	 foreach my $st(@list)
		 {
			$i++; 
			print "$i. $st->{Name}   $st->{Age}   $st->{Group}   $st->{Mail}\n";
		
		 }
	if ($i==0) {print "list is empty\n";}
		
 }

sub del {
print "press number of deleted object\n";
printall();
my $n = <STDIN>;
if (defined $list[$n-1])
{ 
	splice(@list,$n-1,1);
	print "object deleted\n";
	} else 
{
print "object is undefed\n";
}
}


 sub tofile
 {
	my %hash=();
	dbmopen( %hash, "Data", 0644);
	my $j=0;
	foreach my $i(@list)
	{	
		$hash{$j}= join(":", $i->{Name},$i->{Age},$i->{Group},$i->{Mail});
		$j++;
	}
	dbmclose(%hash);
	print "file saved\n";
 }

 sub fromfile
 {
	
	dbmopen(my %hash, "Data", 0644);
	@list=();
		while (( my $key,my $value) = each(%hash))
	{
		 my @st=split(/:/,$hash{$key});
		 my $students={
		  Name => "$st[0]",
		  Age => "$st[1]",
		  Group => "$st[2]",
		  Mail => "$st[3]"};
		 $list[$key]=$students;
	}
	
	dbmclose(%hash);
	
print "file loaded\n";
 }
  return 1; 
