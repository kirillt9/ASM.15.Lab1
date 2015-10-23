package ST34;
use strict;
no warnings qw( experimental::autoderef ); 


sub get_input
{
	my $input = undef;
	while (1) 
		{
		$input = <STDIN>;
		chomp($input);
		$input =~ /^$/ ? next: last;
		}
	return $input;
}

sub add
{
	my ($ref) = @_;
	print "Enter the name of the shoes...";
	my $name = get_input;
	print "Enter the size...";
	my $mysize = get_input;
	print "Enter the color...";
	my $mycolor	= get_input;
	my $new_record = {Shoes => $name, Size => $mysize, Color => $mycolor};
	push @$ref,$new_record;
}


sub show
{
	my ($ref) = @_;
	my $n_records = @$ref;
	
	if (@$ref != ())
	{
		for (my $i=0; $i<$n_records; $i++)
		{
		print (($i+1).'. ');
			for my $k (sort keys %$ref[$i])
			{
				my $v = $$ref[$i]{$k};
				print "$k: $v\n";
			}
			print "\n";
	
		}
	}
	else
	{
		print "List is empty!\n";
	}
}

sub choose
{
	my ($ref) = @_;
	print "Enter the number of the shoes in list...";
	my $record = get_input;
	print "\n";
	
	if (!(%$ref[$record-1]))
	{
		print "No such record number: $record\n";
		return -1;
	}
	return $record-1;
}

sub edit
{
	my ($ref) = @_;
	my $record = choose($ref);
	return if ($record == -1);
	
	print "Write new field value or '-' if value remains unchanged:\n";
	for my $k (sort keys %$ref[$record])
	{
		my $v = $$ref[$record]{$k};
		print "$k (current value '$v')...";
		$v = get_input;
		$v ne "-" ? $$ref[$record]{$k} = $v : next;
	}	
	print "Success!\n";
}

sub delete
{
	my ($ref) = @_;
	my $record = choose($ref);
	return if ($record == -1);
	splice(@$ref,$record,1);
	print "shoes has been deleted from list.\n";
}

sub to_file
{
	my ($ref) = @_;
	my $n_records = @$ref;
	do {print "List is empty!\n"; return;} if ($n_records == 0);
	
	print "Enter the name of file: ";
	my $file = get_input;
	dbmopen(my %dbm_hash,$file,0666) || die "Can't open dbm-file for writing!\n";
	%dbm_hash = ();
	for (my $i=0; $i<$n_records; $i++)
	{
		$dbm_hash{$i} = join("::",$$ref[$i]{Shoes},$$ref[$i]{Size}, $$ref[$i]{Color});
	}
	dbmclose (%dbm_hash);
	print "List has been written to the file.\n";
	
}

sub from_file
{
	my ($ref) = @_;
	@$ref = ();	
	print "Enter the name of file: ";
	my $file = get_input;
	if (!(-e "$file.pag"))
	{
		print "No such file: $file\n";
		return;
	}
	dbmopen(my %dbm_hash,$file,0666) || die "Can't open dbm-file for reading!\n";
	my $i = 0;
	while ( (my $k,my $v) = each %dbm_hash) 
	{
		my @values = split(/::/,$v);
		$$ref[$i]{Shoes}=$values[0];
		$$ref[$i]{Size}=$values[1];
		$$ref[$i]{Color}=$values[2];
		$i++;
	}

	dbmclose (%dbm_hash);
	print "List has been read from the file.\n";
}

my @list;

my %select = (
	1 => \&add,
	2 => \&edit,
	3 => \&delete,
	4 => \&show,
	5 => \&to_file,
	6 => \&from_file
);

my $selection = "
Selection :
 1.Add shoes to list
 2.Change record about shoes
 3.Delete record about shoes
 4.Show list
 5.Save list to file
 6.Read list from file
 7.Exit
";


 sub st34 
 {
 my $option;
 
 print $selection;
 while (1)
 {
	
	print "Write the number of chosen action or 's' to see the selection...";
	$option = get_input;
	print "\n";
	if ($select{$option}) 
	{
		$select{$option}->(\@list);
	} 
	elsif ($option == 7)
	{
		last;
	}
	elsif ($option == "s")
	{
		print $selection;
	}
	else
	{
		print "No such option: $option\n";
	}
 }
 
 }
 
return 1;
