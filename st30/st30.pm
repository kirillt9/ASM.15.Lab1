package ST30;

use strict;
use Data::Dump qw(dump);

my @data;

sub setval 
{
	my ($string) = @_;
  	print $string;
  	my $result = <STDIN>;
  	chomp($result);
  	return $result;
}

sub if_list_is_not_empty 
{
	my ($sub) = @_;
	if(@data > 0)
	{
  		$sub->();
  	}
  	else
  	{
  		print "Phone book is empty\n";
  	}
}

my @commands = (
	sub 
	{
    	last;
    },
    sub 
    {
    	my $file = setval("Insert filename:\n"),
		my %buffer;
		dbmopen(%buffer, $file, 0644);
		@data = ();
		while ( my ($key, $value) = each %buffer )
		{
			my ($name, $phone) = split(/--/, $value);
			my %record = (
				name => $name,
				phone => $phone,
			);
			push(@data, \%record);
		}
		dbmclose(%buffer);
    },
    sub 
    {
    	if_list_is_not_empty(
    		sub {
		    	my $file = setval("Insert filename:\n"),
				my %buffer;
				dbmopen(%buffer, $file, 0644);
				my $i = 0;
				foreach my $record(@data) 
				{
					$buffer{$i} = join('--', $record->{name}, $record->{phone});
					++$i;
				}
				dbmclose(%buffer);
			}
		);
    },
    sub 
    {
    	if_list_is_not_empty(
    		sub {
    			my $i = 0;
	    		print "Phone book:\n";
		    	foreach my $record(@data) 
		    	{
		    		++$i;
		    		print "$i. ".$record->{name}." ".$record->{phone}."\n";
		    	}
    		}
    	);
    },
	sub 
	{
		my %record = (
			name => setval("Insert person name:\n"),
			phone => setval("Insert person phone number:\n"),
		);
    	push(@data, \%record);
    },
    sub 
    {
    	if_list_is_not_empty(
    		sub {
		    	my $num = setval("Insert record number:\n");
		    	if($num > 0 && $num <= @data)
		    	{
		    		splice @data, $num - 1, 1;
		    	}
		    }
	  	);
    },	
    sub 
    {
    	if_list_is_not_empty( 
    		sub {
		    	my $num = setval("Insert record number:\n");
		    	if($num > 0 && $num <= @data)
		    	{
		    		my $record = $data[$num - 1];
		    		my $value = setval("Insert new person name (current name: ".$record->{name}.") or just press \"Enter\":\n");
		    		if($value)
		    		{
		    			$record->{name} = $value;
		    		}
		    		$value = setval("Insert new phone number (current phone: ".$record->{phone}.") or just press \"Enter\":\n");
		    		if($value)
		    		{
		    			$record->{phone} = $value;
		    		}
		    	}  
		    }
		);      		
    }
);

sub st30
{
	while(1) 
	{
		my $command = setval(
			"\n".
			"Choose action:\n".
			"1. Load list from file\n".
			"2. Save list to file\n".
			"3. Show list\n".
			"4. Add record\n".
			"5. Delete record\n".
			"6. Edit record\n".
			"0. Exit from menu\n"
		);
		print "\n";
		if (defined $commands[$command]) 
		{
			$commands[$command]->();
		} 
		else 
		{
		    print "No such command: $command\n";
		}
	}
}

return 1;