package ST17;
use strict;

my @List = ();

sub get_data {
	my $str = $_[0];
	print $str;
	my $get;
	while ( 1 ){
		$get = <STDIN>;
		chomp $get;	
		if ( $get ne "" ) {
			last;
		} 
	}
	return $get;
};

sub add {
	my $name = get_data("Enter the name of song: " );	
	my $author = get_data("Enter the author name: " );	
	if ( ( $name ne "" ) && ( $author ne "") ) {
		push @List, { name => $name, author => $author };
	}
};
sub edit {
	my $number = get_data("Enter the number of element: " );	
	if ($number > 0 && $number <= @List.length) {
		$number --;
		print "  Name: ".$List[$number]->{'name'}."\n  author: ".$List[$number]->{'author'}."\n";
		my $val = get_data("Press \"Enter\" or enter new name: " );	
		if ($val){
			$List[$number]{'name'} = $val;
		};
		my $val = get_data("Press \"Enter\" or enter new author: " );	
		if ($val){
			$List[$number]{'author'} = $val;
		};
	} else {
		print "Element does not exist \n";		
	}
};
sub delete {
	my $number = get_data("Enter the number of element: " );	
	if ($number > 0 && $number <= @List) {
		$number --;
		print "  Name: ".$List[$number]->{'name'}."\n  author: ".$List[$number]->{'author'}."\n";
		splice(@List, $number, 1);
	} else {
		print "Element does not exist \n";		
	}
};
sub show {
	if (@List == 0){
		printf "List is empty \n";	
	} else {
		while ((my $key, my $value) = each @List){
			my $num = $key+1;
			print "$num. Name: ".$value->{name}."\n   author: ".$value->{author}."\n";
		};
	}
};
sub save {
	my $file = get_data("Enter the filename: " );	
	if ( $file ne "" ){
		my %h = ();
		dbmopen(%h, $file, 0644);
		my $i = 0;
		while ((my $key, my $value) = each @List){
			$h{$i} = join('-%%-', $value->{name}, $value->{author});
			++$i;
		};
		dbmclose(%h);
	}
};
sub load {
	my $file = get_data("Enter the filename: " );	
	if ( $file ne "" ){
		my %h;
		dbmopen(%h, $file, 0644);
		@List = ();
		while ( my ($key, $value) = each %h )
		{
			my ($name, $author) = split(/-%%-/, $value);
			my %record = (
				name => $name,
				phone => $author,
			);
			push(@List, \%record);
		}
		dbmclose(%h);
	}
};
sub exit {
	last;
};
my @command_functions = (
	\&exit,
	\&add,
	\&edit,
	\&delete,
	\&show,
	\&save,
	\&load
);

my $commands = "Choose action: \n 1) add element \n 2) edit element \n 3) delete element \n 4) show list \n 5) save list to file \n 6) load list from file \n 0) exit \n";

sub st17 {
	my $command;
	while ( 1 )  {
		$command = get_data($commands); 
		if (defined $command_functions[$command]) {
			$command_functions[$command]();
		} else {
			print "Command is undefined\n";
		}
	}
};

return 1;