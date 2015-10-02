package ST04;
#Реализовать на Perl консольное приложение, позволяющее добавлять, редактировать, выводить на экран, сохранять в файл список однотипных объектов (студентов группы, служащих фирмы, жителей дома и т.п.), каждый из которых обладает несколькими атрибутами (имя, фамилия, возраст и т.п.).

use strict;
#use Data::Dumper; #debug purpose
#############Global Variables#############
my $count=0;
my $run=1;
my $cache={};
my $currentkeys={"Name"=>1};
#############Subroutines###############
sub shortshow #get list with existed items
{
    print "\n=======\n";
    while (my ($key,$val)= each (%$cache)){
	print "\t$key:$val->{'Name'}\n";
    }
    print "=======\n";
}
sub itemPrint{
    print "\n=======\n";
    my ($aim)=@_;
    while (my ($key,$val)=each(%$aim)){
	print "\t$key:$val\n";
    }
    print "=======\n";
}
#############
# getUID - generate unique number for store in $cashe
# INPUT: none
# OUTPUT: NUMBER uid
#############
sub getUID{
    my $UID=0;
    for (keys %$cache) {
	$UID=$_ if $UID<$_;
    }
    return $UID+1;
}
#############
# add - call menu for interactively add new item in the $cashe'
# INPUT: none
# OUTPUT: none
# return in st04
############
sub add{
    
    my $menu="\n\nTo add new item type in format:\nAttribute:Value\nBe careful 'Name' attribute must be present!\ntype 'end' to finish definition and insert item to current data\nTo cancel adding type 'abort'\n";
    my @temp=();
   
    print "Currently $count items\n";
    if (!$count){
	print $menu;
	my $save=0;
	my $namedefined=0;
	do{
	    my $line=<STDIN>;
	    chomp $line;
	    if ($line=~ m/(\w+)\s*:\s*(.+)/){
		@temp=(@temp,$1,$2);
		$currentkeys->{$1}=1;
		$namedefined=$1 eq "Name" unless $namedefined;
	    }
	    $save=$line=~m/^end$/i;
	    return if ($line=~m/^abort$/i);
	    if ($save and (not $namedefined)){
		print "'Name' attribute must be defined!\n";
		$save=0;
	    }
	}while (!$save);
    }else{
	print "\nCurrent table contains:\n";
	print join ("\n",keys %$currentkeys);
	print "\n column. Now you can add new row by order.\n To cancel type 'abort'\n";
	while (my ($key,$rs)=each(%$currentkeys)) {
	    print "$key:";
	    my $val=<STDIN>;
	    chomp $val;
	    return if ($val=~/^abort$/);
	    @temp=(@temp,$key,$val);
	}
    }
    my $uid = getUID();
    $cache->{$uid}={@temp};
    $count++;
	
}

#############
# correct - call menu for interactively correct existed item in the $cache
# INPUT: none
# OUTPUT: none
# return in st04
############
sub correct{
    my $menu="\n\nType 'shortshow' to get item's list.\n Type 'correct <UID>'  to get item for correction.\n Return to main menu type 'abort'\n";
    my $correcting=1;
    while ($correcting){
	print $menu;
	my $line=<STDIN>;
	chomp $line;
	if ($line=~ m/shortshow/i){
	    shortshow();
	}
	if ($line=~m/correct ([0-9]+)/i){
	    my $UID=$1;
	    if (defined $cache->{$UID}){	    
		my $aim=$cache->{$UID};
		itemPrint($aim);
		print "To correct type:\nAttribute:Value\n Type 'end' to finish correction.\n";
		my $act=1;	   
		while($act){ 
		    my $row=<STDIN>;
		    chomp $row;
		    if ($row=~ m/(\w+)\s*:\s*(.+)/){
			$aim->{$1}=$2 if (defined $aim->{$1});
		    }
		    $act=!($row=~m/^end$/i);
		}
	    }else{
		print "Item with UID=$UID not exist.\n"
	    }
	}
	$correcting=!($line=~m/^abort$/i);
    }
}

#############
# delete - call menu for interactively delete existed item in the $cache
# INPUT: none
# OUTPUT: none
# return in st04
############
sub delete{
    my $menu="\n\nType 'shortshow' to get item's list.\n Type 'delete  <UID>'  to get item away from table.\n Return to main menu type 'abort'\n";
   
    my $deleting=1;
    do{
	print $menu;
	my $line=<STDIN>;
	chomp $line;
	if ($line=~ m/shortshow/i){
	    shortshow();
	}
	if ($line=~m/delete ([0-9]+)/i){
	    my $UID=$1;
	    if (defined $cache->{$UID}){
		print "Item with UID=$UID will be deleted, proceed?(y/n)";
		my $answ=<STDIN>;	    
		delete $cache->{$UID} if ($answ=~m/y|yes/i);
		$count--;
		print "Done deletion $UID\n";}
	    else{
		print "Item with UID=$UID, not exist.\nChoose existed item.\n";
	    }
	}
	$deleting=!($line=~m/^abort$/i);
    }while ($deleting);
}

#############
# show - call menu for interactively show items in the $cache
# INPUT: none
# OUTPUT: none
# return in st04
############

sub show{
    my $menu="\n\nType 'shortshow' to get item in short format\nUID:First field\n. Type 'watch <UID>'  to get item with all filed in format\nUID\n\tfirst field\n\tsecond ...\n\tetc.\nto cancel and return to main menu type 'abort'\n";
   
    my $showmustgoon=1;
    do {
	print $menu;
	my $line=<STDIN>;
	chomp $line;
	if ($line=~ m/shortshow/i){
	    shortshow();
	}
	if ($line=~m/watch ([0-9]+)/i){
	    print "UID:$1\n";
	    my $aim=$cache->{$1};
	    itemPrint($aim);
	}
	$showmustgoon=!($line=~m/^abort$/i);
    }while ($showmustgoon);
}

#############
# save - call menu for interactively save $cache to dbm file
# INPUT: none
# OUTPUT: none
# return in st04
############
sub save{
    my $menu="\n\nType 'save filename' to save current data to file.Be aware that existed file will be overwritten.\nTo cancel and return to main menu type 'abort'\n";
    
    my $saving=1;
    do {
	print $menu;
	my $line=<STDIN>;
	chomp $line;
	if ($line=~ m/save (\w+)/i){
	    my $filename="st04/". $1;
	    $filename.="\.dbm" unless ($1=~m/\w+.dbm/);
	    my %localdbm;
	    dbmopen(%localdbm,"$filename",0777) or print "Can't create $filename";
	    for (keys %{$cache}) {	
		my @data=();
		while (my ($key,$val)=each %{$cache->{$_}}){
		    push @data, ($key. ':::' .$val);
		}
		$localdbm{$_}=join (':::',@data);
	    }
	    dbmclose(%localdbm);
	    $saving=0;
	}
	else{
	    $saving=!($line=~m/^abort$/i);
	}
    }while ($saving);
}

#############
# load - call menu for interactively load data from dbm file and put it to $cache
# INPUT: none
# OUTPUT: none
# return in st04
############
sub load{
    my $menu="\n\nType 'open filename' to load data from file.File must be present in module folder.\nTo cancel and return to main menu type 'abort'\n";
    
    my $loading=1;
    while ($loading){
	print $menu;
	my $line=<STDIN>;
	chomp $line;
	if ($line=~ m/open (\w+)/i){
	    if (keys %{$cache}){
		print "Current table will be droped! Proceed?(y/n)\n";
		my $ans=<STDIN>;
		unless ($ans=~m/y|yes/i){
		    continue;
		}
	    }
	    $cache={};
	    my $filename="st04/". $1 unless ($1=~m|st04/\w+|);
	    $filename.="\.dbm" unless ($1=~m/\w+.dbm/);
	    my %localdbm;
	    dbmopen(%localdbm,"$filename",0) or print "Can't open $filename";
	    while (my ($key,$val) = each %localdbm) {
		my @data=split ':::', $val;
		my %dataconv=@data;
		$currentkeys=map{$_=>1}keys %dataconv;
		my $de=defined $cache->{$key};
		$count++ unless (defined $cache->{$key});
		$cache->{$key} =\%dataconv;
	    }
	    dbmclose(%localdbm);
	    $loading=0;
	}
	else{
	    $loading=!($line=~m/^abort$/i);
	}
    }
}

#############
# quit - exit point from st04
# INPUT: none
# OUTPUT: none
# return in st04
############
sub quit{
    $run=0;
}

my $menuEntry={
    1=>\&add,
    2=>\&correct,
    3=>\&delete,
    4=>\&show,
    5=>\&save,
    6=>\&load,
    0=>\&quit
};

sub st04
{
    my $Menu="Menu:\nAdd(1),Corect(2),Delete(3),Show list(4),Save to file(5),Load from file(6),Qiut(0)\n";
    while ($run) {    
	print "$Menu"."There are $count items in a table\n";
	my $choice=<STDIN>;
	chomp $choice;
	$menuEntry->{$choice}->() if defined $menuEntry->{$choice};
    }
    
}

return 1;
