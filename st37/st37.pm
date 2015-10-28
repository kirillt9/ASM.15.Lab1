#!/usr/bin/perl

package ST37;
use strict;
no warnings qw( experimental::autoderef ); 

sub get_input
{
	my $input = undef;
	while (1) 
		{
		chomp($input= <STDIN>);
		$input =~ /^$/ ? next: last;
		}
	return $input;
}

sub add
{
	my ($phones) = @_;
	print "vvedite telefon";
	my $phone = get_input;
	print "...vvedite model";
	my $model = get_input;
	print "vvedite god vipyska";
	my $year = get_input;
	my $new_record = {Phone => $phone, Model => $model, Year => $year};
	push @$phones,$new_record;
}


sub edit
{
	my ($phones) = @_;
	my $record = choose($phones);
	return if ($record == -1);
	
	print "vvedite poridkovii nomer telefona dlia izmenenia:\n";
	for my $k (sort keys %$phones[$record])
	{
		my $v = $$phones[$record]{$k};
		print "$k (novoe znachenie '$v')...";
		$v = get_input;
		$v ne "-" ? $$phones[$record]{$k} = $v : next;
	}	
	print "yspeshno!\n";
}


sub choose
{
	my ($phones) = @_;
	print "vvedite poridkovii nomer telefona";
	my $record = get_input;
	print "\n";
	
	if (!(%$phones[$record-1]))
	{
		print "Net vibiraemoi zapisi: $record\n";
		return -1;
	}
	return $record-1;
}


sub to_screen
{
	my ($phones) = @_;
	my $n_records = @$phones;
	
	if (@$phones != ())
	{
		for (my $i=0; $i<$n_records; $i++)
		{
		print (($i+1).'. ');
			for my $k (sort keys %$phones[$i])
			{
				my $v = $$phones[$i]{$k};
				print "$k: $v\n";
			}
			print "\n";
	
		}
	}
	else
	{
		print "spisok pystoi\n";
	}
}


sub delete
{
	my ($phones) = @_;
	my $record = choose($phones);
	return if ($record == -1);
	splice(@$phones,$record,1);
	print "Zapis ydalena.\n";
}

sub to_file
{
	my ($phones) = @_;
	my $n_records = @$phones;
	do {print "pystoi spisok!\n"; return;} if ($n_records == 0);
	
	print "vvedite nazvanie faila: ";
	my $file = get_input;
	dbmopen(my %dbm_hash,$file,0666) || die "Ne ydaetsia otkrit' fail!\n";
	%dbm_hash = ();
	for (my $i=0; $i<$n_records; $i++)
	{
		$dbm_hash{$i} = join("::",$$phones[$i]{Phone},$$phones[$i]{Model}, $$phones[$i]{Year});
	}
	dbmclose (%dbm_hash);
	print "Zapis proshla yspechno.\n";
	
}

sub from_file
{
	my ($phones) = @_;
	@$phones = ();	
	print "Vvedite imia faila: ";
	my $file = get_input;
	if (!(-e "$file.pag"))
	{
		print "Fail ne naiden: $file\n";
		return;
	}
	dbmopen(my %dbm_hash,$file,0666) || die "Ne ydalos' prochitat'!\n";
	my $i = 0;
	while ( (my $k,my $v) = each %dbm_hash) 
	{
		my @values = split(/::/,$v);
		$$phones[$i]{Phone}=$values[0];
		$$phones[$i]{Model}=$values[1];
		$$phones[$i]{Year}=$values[2];
		$i++;
	}

	dbmclose (%dbm_hash);
	print "Yspescho.\n";
}

my @telephones;

my %menu = (
	1 => \&add,
	2 => \&edit,
	3 => \&delete,
	4 => \&to_screen,
	5 => \&to_file,
	6 => \&from_file
);

my $menu_text = "
Vibrat' :
 1 - dobavit'
 2 - redaktirovat'
 3 - ydalit'
 4 - vivesti
 5 - zapisat'
 6 - schitat'
 7 - vihod
";


 sub st37
 {
 my $choice;
 
 print $menu_text;
 while (1)
 {
	
	print "Nazmite ot 1 do 7";
	$choice = get_input;
	print "\n";
	if ($menu{$choice}) 
	{
		$menu{$choice}->(\@telephones);
	} 
	elsif ($choice == 7)
	{
		last;
	}
	elsif ($choice == "m")
	{
		print $menu_text;
	}
	else
	{
		print "ot 1 do 7: $choice \n";
	}
 }
 
 }
 
return 1;
