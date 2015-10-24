package ST12;
use strict;

my @wellList;

sub add
{
	my $wellName;
	my $wellDepth;
	my $well;
	print "Enter name of well\n";
	$wellName = <STDIN>;
	chomp ($wellName);
	print "Enter depth of well\n";
	$wellDepth = <STDIN>;
	chomp ($wellDepth);
	while ($wellDepth !~ /\d/){
		print "Enter number\n";	
		$wellDepth = <STDIN>;
		chomp ($wellDepth);		
	}
	$well = {Name => $wellName, Depth => $wellDepth};
	push @wellList,$well;	
}

sub edit
{
	my $wellName;
	my $well;
	my $number;
	my $param;
	print "Enter number of well for editing\n";
	$number = <STDIN>;
	chomp ($number);
	if(($number>=1) && ($number<=@wellList)  && ($number !="") && (@wellList>0)){
		print "Choose parametr for editing\n1 - Well name;\n2 - Well depth\n";
		$param = <STDIN>;
		chomp($param);
		while($param < 0 || $param > 2){
			print "Enter 1 or 2\n";
			$param = <STDIN>;
			chomp($param);
		}
		if ($param== 1){
			print"Enter new name:\n";
			my $new_name = <STDIN>;
			chomp($new_name);
			$wellList[$number-1]->{Name}=$new_name;
		}
		else {
			print"Enter new depth:\n";
			my $new_depth = <STDIN>;
			chomp($new_depth);
			while ($new_depth !~ /\d/){
				print "Enter number\n";	
				$new_depth = <STDIN>;
				chomp ($new_depth);		
			}
			$wellList[$number-1]->{Depth}=$new_depth;
		}		
	}
	else{
		print"Element not found\n";
	}
}	
sub show
{
	my $i = 0;
	my $well;
	print "Well list:\n";
	if (@wellList<0){
		print "No wells in list";
	}
	else{
		foreach $well(@wellList) 
		{
			$i++;
			print "$i) Well name: ".$well->{Name}."; Well depth: ".$well->{Depth}."\n";
		}
	}
}
sub delete
{
	my $wellName;
	my $wellDepth;
	my $well;
	my $number;
	my $param;
	print "Enter number of well for deleting\n";
	$number = <STDIN>;
	chomp ($number);
	if($number>=1 && $number<=@wellList ){
			delete ($wellList[$number-1]);
	}		
	else{
		print"Element not found\n";
	}
}
sub save
{
	my %hash;
	dbmopen(%hash, "Spisok_well", 0644) ;
	%hash = ();	
	my $i =0;
	foreach my $well(@wellList)
		{
			$hash{$i} = join ('##', $well->{Name}, $well->{Depth}); 
		}
	dbmclose %hash;		
}
sub load
{
	my %hash;
	dbmopen(%hash, "Spisok_well", 0644) ;	
	@wellList = ();
	foreach my $key (keys %hash)
	{
		my @buffer = split(/##/,$hash{$key});
		my $name = $buffer[0];
		my $depth = $buffer[1];
		my $well = {Name => $name, Depth => $depth};
		push @wellList, $well;
	}
	dbmclose %hash;
}
sub exit
{
	last;
}

sub st12
{
	my @functions = (\&add, 
					\&edit, 
					\&delete, 
					\&show,
					\&save,
					\&load,
					\&exit
					);
	while(1)
	{
		print "\nField list:\n1)Add well\n2)Edit well params\n3)Delete well\n4)Show list of wells\n5)Save list to file\n6)Load list of wells from file\n7)Exit\n";
		my $number = <STDIN>;
		chomp ($number);
		if ($number <1 || $number>7){
			print "Please enter currect number(1-7)\n";}
		else{
			$functions[$number-1]->();
		}
	}
}

return 1;