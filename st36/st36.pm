package ST36;
use strict;

my @list;

my %menu = (
	1 => \&add,
	2 => \&edit,
	3 => \&delete_object,
	4 => \&show_list,
	5 => \&export_file,
	6 => \&import_file
);

sub f
{
	my $func = undef;
	while (1) 
		{
		$func = <STDIN>;
		chomp($func);
		$func =~ /^$/ ? next: last;
		}
	return $func;
}


sub add
{
	my ($a) = @_;
	print "Enter name :";
	my $name = f;
	print "Enter surname :";
	my $surname = f;
	print "Enter squad: ";
	my $squad = f;
	my $add = {"Name", $name, "Surname", $surname, "Squad", $squad};
	push @$a,$add;
}


sub edit
{
	my ($a) = @_;
	print "Enter the number ";
	my $n = f;
	print "\n";
	
	if (!(%$a[$n-1]))
	{
		print "Not Found $n\n";
		return ;
	}
	my $num = $n-1;
	
	print "Enter new name\n";
	for my $k (sort keys %$a[$num])
	{
		my $v = $$a[$num]{$k};
		print "$k new  -> ";
		$v = f;
		$$a[$num]{$k} = $v ;
	}	
	print "Done!\n";
}


sub delete_object
{
	my ($a) = @_;
	
	print "Enter the number ";
	my $n = f;
	print "\n";
	
	if (!(%$a[$n-1]))
	{
		print "Not Found $n\n";
		return ;
	}
	
	my $num = $n-1;
	splice(@$a,$num,1);
	print "Done!\n";
}


sub show_list
{
	my ($a) = @_;
	my $a1 = @$a;
	
	if (@$a!= ())
	{
		for (my $i=0; $i<$a1; $i++)
		{
		print (($i+1).'. ');
		print "\n";
			foreach my $k (sort keys %$a[$i])
			{print "$k -> $$a[$i]{$k}\n";}
		}
	}
	else
	{
		print "Nothing Found\n";
	}
}


sub export_file
{
	my ($a) = @_;
	my $a1 = @$a;
	
	dbmopen(my %hash,"mylist",0666) or die "Can't open dbm-file !\n";
	%hash = ();
	for (my $i=0; $i<$a1; $i++)
	{
		$hash{$i} = join("::",
		$$a[$i]{Name},
		$$a[$i]{Surname}, 
		$$a[$i]{squad});
	}
	dbmclose (%hash);
	print "Save file 'mylist'\n";
	
}


sub import_file
{
		my ($a) = @_;
	@$a = ();	
	
	dbmopen(my %hash,"mylist",0666) or die "Can't open dbm-file !\n";
	my $i = 0;
	while ( (my $k,my $v) = each %hash) 
	{
		my @val = split(/::/,$hash{$k});
		
		$$a[$i]{Name}=$val[0];
		$$a[$i]{Surname}=$val[1];
		$$a[$i]{Squad}=$val[2];
		$i++;
			
	}
	dbmclose (%hash);
	print "File 'mylist' read\n";
}


sub st36 
 {
 

print "Main menu:\n\n";
print"1--add\n";
print"2--edit\n";
print"3--delete object\n";
print"4--show list\n";
print"5--export in file\n";
print"6--import file\n";
 my $b;
 
 while (1)
 {
	
	print "Enter the number of menu or another key to exit\n";
	$b = f;
	print "\n";
	if ($menu{$b}) 
	{
		$menu{$b}->(\@list);
	} 
	
	else
	{
		last;
	}
 }
 
 }

 
 
return 1;
