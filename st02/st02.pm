#!/usr/bin/perl
package ST02;
use strict;

sub st02
{
	print "st02:st02\n";
	my @group;

sub add{
	print "\nEnter student name\n";
	chomp(my $name = <STDIN>);
	print "Enter student age\n";
	my $age = <STDIN>;
	my $student = {NAME => $name, AGE => $age};
	push @group, $student;
}

sub edit{
	print "\nSelect item to edit (enter student name):\n";
	chomp(my $edit_name = <STDIN>);
	my $flag = 0; 
	
	for (my $i = 0; $i < @group; $i++)
	{
		if (($group[$i]->{NAME}) eq $edit_name)
		{
			print "\nDo you want to change student name(0)/age(1)?:\n";
			chomp(my $select = <STDIN>);
			if ($select)
			{
				print "\nEnter new student age:\n";
				my $age = <STDIN>;
				$group[$i]->{AGE} = $age;
				$flag = 1;
				print "\nStudent age successfully changed!\n";
			}
			else
			{
				print "\nEnter new student name:\n";
				chomp(my $name = <STDIN>);
				$group[$i]->{NAME} = $name;
				$flag = 1;
				print "\nStudent name successfully changed!\n";
			}
			last;
		}
	}
	if (!$flag){print "\nNo such element in the list\n";}
}

sub delete{
	print "\nSelect item to delete (enter student name):\n";
	chomp(my $del_name = <STDIN>);
	my $flag = 0; 
	
	for (my $i = 0; $i < @group; $i++)
	{
		if (($group[$i]->{NAME}) eq $del_name)
		{
			delete ($group[$i]);
			$flag = 1;
			print "\nElement deleted\n";
			last;
		}
	}
	if (!$flag){print "\nNo such element in the list\n";}
} 

sub display{
	if (@group)
	{
		for (my $i = 0; $i < @group; $i++)
		{
			print "\nName: ".$group[$i]->{NAME}."\nAge: ".$group[$i]->{AGE}."---------";
		}
	}
	else {print "\nThe list is empty\n";}
}

sub save{
	dbmopen(my %HASH,"data.txt",0666)or die "Can't open file: $!\n";
	%HASH = ();
	for (my $i = 0; $i < @group; $i++)
	{
		$HASH{$i} = join("##",$group[$i]->{NAME},$group[$i]->{AGE});
	}
	dbmclose %HASH;
	print "\nThe list is successfully saved in a file!\n";
}

sub load{
	for (my $i = 0; $i < @group; $i++)
	{
		delete ($group[$i]);
	}
	dbmopen(my %HASH,"data.txt",0666)or die "Can't open file: $!\n";
	foreach my $key (keys %HASH)
	{
		my @a = split(/##/,$HASH{$key});
		my $name = @a[0];
		my $age = @a[1];
		my $student = {NAME => $name, AGE => $age};
		push @group, $student;
	}
	dbmclose %HASH;
	print "\nThe data is successfully loaded from a file!\n";
}

while(1)
{
	print "
\nChoose:\n
1. Add item
2. Edit
3. Delete
4. Display list
5. Save to file
6. Download file
7. Exit

Your choice: ";

	my @MENU = (\&add, \&edit, \&delete, \&display, \&save, \&load);

	my $in = <STDIN>;

	if (($in > 0)&&($in < 7))
	{
		$MENU[$in-1]->();
	}
	elsif ($in == 7)
	{
		last;
	}
	else
	{
		print "Incorrect command\n";
	}
}
}
return 1;


