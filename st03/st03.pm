package ST03;
use strict;
my @list;

sub emptyList
{
	if(@list>0)
	{
		return 1;
	}
	else
	{
		print"List is empty\n";
		return 0;
	}
}

sub add
{
	print"Enter student name\n";
	chomp (my $name = <STDIN>);
	print"Enter diploma's theme\n";
	chomp (my $diplom = <STDIN>);
	my $elem = {Name => $name, Diplom => $diplom};
	push @list,$elem;
}

sub edit
{
	if (emptyList)
	{
		print"Chose element's number to edit(numbers start at 1)\n";
		chomp (my $num = <STDIN>);
		if ($num>=1 && $num <=@list+1 && $num !="")
		{
			print"Enter new name\n";
			chomp (my $name = <STDIN>);
			$list[$num-1]->{Name}=$name;
			print"Enter new diploma's theme\n";
			chomp (my $diplom = <STDIN>);
			$list[$num-1]->{Diplom}=$diplom;
			print"Edit was successful\n";
		}
		else
		{
			print"Enter currect number\n";
		}
	}
	
}

sub delete
{
	if (emptyList)
	{
		print"Chose element's number to delete(numbers start at 1)\n";
		my $num =();
		print 	$num;	
		chomp ( $num = <STDIN>);
		if ($num>=1 && $num<=@list+1 && $num !='' )
		{	
			delete $list[$num-1];
		}
		else
		{
			print"Enter currect number\n";
		}
	}
	
}

sub show
{
	if (emptyList)
	{
		print"  ===LIST===\n";
		foreach my $elem(@list)
		{
			print"Student's name: '".$elem->{Name}."'; diploma's theme: '".$elem->{Diplom}."'\n";
		}
	}
}

sub save
{
	if(emptyList)
	{
		dbmopen(my %hash,"dbm_03",0666);
		%hash = ();
		my $i =0;
		foreach my $elem(@list)
		{
			$hash{$i} = join ('--', $elem->{Name}, $elem->{Diplom}); 
			 $i ++;
		}
		dbmclose %hash;		
	}
}

sub load
{
	dbmopen (my %hash, "dbm_03",0666)	or die "Can't open netscape history file: $!";
	@list = ();
	while (my ($key, $value) = each(%hash))
	{
		my ($name, $diplom) = split(/--/, $value);
		my %elem = (
			Name => $name,
			Diplom => $diplom,
		);
		push(@list, \%elem);
	}
	dbmclose %hash;
}

sub st03
{
	while(1)
	{
		print "\n  ===MENU===\n1) Add object\n2) Edit object\n3) Delete object\n4) Show list\n5) Save\n6) Load\n7) Exit\nEnter command\n";
			
		my @menu = (\&add, \&edit, \&delete, \&show, \&save, \&load);
		my $com = <STDIN>;
		if($com>=1 && $com<=6)
		{	
			@menu[$com-1]->();
		}
		elsif ($com == 7)
		{
			last;
		}
		else
		{
			print"False command\n";
		}
		system "pause";
		system "cls";
	}
}
return 1;