package ST15;
use strict;

my @list;

sub st15 {

my $menu = "1. Add\n2. Edit\n3. Delete\n4. Show\n5. Save\n6. Open\n7. Exit\n";
while(1) {

print $menu;
chomp(my $a = <STDIN>);
$a = $a - 1;
if ($a==6) 
{return;}
my @func = (
\&add, 
\&change, 
\&delete, 
\&show, 
\&save, 
\&open,
);

@func[$a]->();

}
}

sub add {
	
	print "Name:";
	my $name = <STDIN>;
	print "\nMail:";
	my $mail = <STDIN>;
	print "\nPhone:";
	my $phone = <STDIN>;
	
	my $element = {
		Name => $name, 
		Mail => $mail, 
		Phone => $phone
		};
	 
	push (@list, $element);
	

}
	
sub delete {
	
	print "Number: ";
	my $a = <STDIN>;
	
	if (defined(@list[$a-1])) {
	
	splice(@list, $a-1, 1);
	print "Deleted \n";
}
	
	else { print "Not deleted]n";
	
	}
}

sub change {
	
	print "Number: ";
	my $a = <STDIN>;
	
	if (defined(@list[$a-1])) {
	
	print "Name:";
	@list[$a-1]->{Name} = <STDIN>;	
	print "\n Mail:";
	@list[$a-1]->{Mail} = <STDIN>;
	print "\n Phone:";
	@list[$a-1]->{Phine} = <STDIN>;
	
	
	}
	else { print "No element \n";
	
	}
}
	
sub show {
	
	
	my $i = 1;
	while (defined(@list[$i-1])) {
	print "\n" . $i . ". " . @list[$i-1]->{Name} . @list[$i-1]->{Mail} . @list[$i-1]->{Phone} . "\n";
	$i+=$i;
	}	
	
	
	}
	
sub save {
	
	print "Enter name of the file: ";

	chomp (my $file = <STDIN>);

	dbmopen(my %hash, $file, 0666);

	
	my $id = 0;
	
	while (defined(@list[$id])) {
	$hash{$id} = join('--', @list[$id]->{Name}, @list[$id]->{Mail}, @list[$id]->{Phone});
	$id = $id +1;
	}
	dbmclose (%hash);
	
	}
	
sub open {
	
	print "Enter name of file to open: ";
	
	chomp(my $file = <STDIN>);
	
	dbmopen (my %hash, $file ,0666) or die "Can't load file!\n";
		@list = ();
		while (my ($key, $value) = each(%hash))
		{
			my ($name, $mail, $phone) = split(/--/, $value);
			my %record = (
				'Name' => $name,
				'Mail' => $mail,
				'Phone' => $phone
			);
			push(@list, \%record);
		}
		dbmclose (%hash);
	
}
	return 1;