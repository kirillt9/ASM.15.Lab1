package ST31;
use strict;

my %DbmFileHash =();
my @list;
my @Menu =(\& Add, \& Delete,\&Edit,\&Show,\&Save,\&Load);
				
sub Add
{
	    print"Name: ";
		chomp (my $name = <STDIN>);
		print"Club: ";
		chomp (my $club = <STDIN>);
		my $player = {name => $name, club => $club};
		push @list,$player;
}
sub Delete
{
	if(@list>0)
	{	
		print "Enter player name to delete:  ";
		chomp(my $del_name = <STDIN>);	
		for (my $i = 0; $i < @list; $i++)
		{
			if (($list[$i]->{name}) eq $del_name)
			{
				delete ($list[$i]);
				last;
			}
			else
			{
				print"No player with this name \n";
			}
		}
	}
	else
	{
		print"No elements in list\n";
		
	}

}

sub Edit
{
	if(@list>0)
	{	
		print "Enter player name to edit:  ";
		chomp(my $ed_name = <STDIN>);	
		for (my $i = 0; $i < @list; $i++)
		{
			if (($list[$i]->{name}) eq $ed_name)
			{
				print"New name: ";
				chomp(my $new_name = <STDIN>);
				$list[$i]->{name}=$new_name;
				print"New club: ";
				chomp(my $new_club = <STDIN>);				
				$list[$i]->{club}=$new_club;				
				last;
			}
			else
			{
				print"No player with this name\n ";
			}
		}
	}
	else
	{
		print"No elements in list\n";
		
	}
}

sub Show
{	
	if(@list>0)
	{	
		print"LIST\n";
		foreach my $player(@list)
		{
			print"Name: ".$player->{name}." Club: ".$player->{club}."\n";
		}
	}
	else
	{
		print"No elements in list\n";
		
	}
}

sub Save
{
	if(@list>0)
	{	
		dbmopen(my %hashfile,"Podkolzindbm",0666);
		%hashfile = ();
		my $i =0;
		foreach my $player(@list)
		{
			$hashfile{$i} = join ('--', $player->{name}, $player->{club}); 
		}
		dbmclose %hashfile;	
	}
	else
	{
		print"No elements in list\n";
		
	}
}


sub Load
{
	dbmopen (my %hashfile, "Podkolzindbm",0666);
	@list = ();
	while (my ($key, $value) = each(%hashfile))
	{
		my ($name, $club) = split(/--/, $value);
		my %player = (name => $name,club => $club,);
		push (@list, \%player);
	}
	dbmclose %hashfile;	
	
	
}



sub st31
{

	while (1)
	{ 
	
			print "MENU
1. Add
2. Delete
3. Edit
4. Show list
5. Save file
6. Load file
7. Exit\n";
		my $vvod=<STDIN>;
		chomp $vvod;		
		
		if($vvod>=1 && $vvod<=6)
		{	
			@Menu[$vvod-1]->();
		}
		elsif ($vvod == 7)
		{
			last;
		}
		else
		{
			print"Enter number from 1 to 7\n";
		}
		
		
		
		
	}
}



return 1;