package ST47;

use strict;

my @MainList = ();

sub show_man {
	my $man = $_[0];
	print "  CompanyName: ".$man->{'cname'}."\n  CompanyTown: ".$man->{'ctown'}."\n";
};
sub get_data {
	my @str = $_[0];
	my $null = $_[1]; 
	print @str;
	my $get;
	while ( 1 ){
		$get = <STDIN>;
		chomp $get;	
		if (!$null || ( $get ne "" ) ){
			last;
		} else {
			print "Field can't be empty \n";
			print @str;
		}
	};
	return $get;
};

sub add {
	my $cname = ( get_data "Enter the name of company: " );	
	my $ctown = ( get_data "Enter the city where the company is located: " );	
	if ( ( $cname ne "" ) && ( $ctown ne "") ){
		push @MainList, { cname => $cname, ctown => $ctown };
	}
};
sub edit {
	my $number = ( get_data "Enter the number of element: " );	
	if ($number > 0 && $number <= @MainList.length) {
		$number --;
		show_man $MainList[$number];
		my $val = ( get_data "Press \"Enter\" or enter new company name: " );	
		if ($val){
			$MainList[$number]{'cname'} = $val;
		};
		my $val = ( get_data "Press \"Enter\" or enter new company town: " );	
		if ($val){
			$MainList[$number]{'ctown'} = $val;
		};
	} else {
		printf "Element does not exist \n";		
	}
};
sub delete {
	my $number = ( get_data "Enter the number of element: " );	
	if ($number > 0 && $number <= @MainList.length) {
		$number --;
		show_man $MainList[$number];
		splice(@MainList, $number, 1);
	} else {
		printf "Element does not exist \n";		
	}
};
sub show {
	if (@MainList.length == 0){
		printf "List is empty \n";	
	} else {
		while ((my $key, my $value) = each @MainList){
			my $num = $key+1;
			print $num.") \n";
			show_man $value;
		};
	}
};
sub save {
	my $file = ( get_data "Enter the filename: " );	
	if ( $file ne "" ){
		my %h;
		dbmopen(%h, $file, 0644);
		my $i = 0;
		while ((my $key, my $value) = each @MainList){
			$h{$i} = $value->{'cname'};
			$h{$i+1} = $value->{'ctown'};
			$i+=2;
		};
		dbmclose(%h);
	}
};
sub load {
	my $file = ( get_data "Enter the filename: " );	
	if ( $file ne "" ){
		my %h;
		dbmopen(%h, $file, 0644);
		@MainList = ();
		for ( my $i = 0 ; ; $i += 2 ){
			if (exists($h{$i})){
				push @MainList, {cname => $h{$i}, ctown => $h{$i+1}};
			} else {
				last;
			}
		}
		dbmclose(%h);
	}
};
sub exit {
	last;
};
my @functions = (
	\&add,
	\&edit,
	\&delete,
	\&show,
	\&save,
	\&load,
	\&exit
);

my $menu = "Choose option: \n 
			1 - add element \n 
			2 - edit element \n 
			3 - delete element \n 
			4 - show list \n 
			5 - save list to file \n 
			6 - load list from file \n 
			7 - exit \n";

sub st47 {
	my $n;
	while ( 1 )  {
		$n = ( get_data $menu, 1 ); 
		if ($n < 8 && $n > 0) {
			$functions[$n-1]();
		} else {
			print "Invalid command \n";
		}
	}
};

return 1;