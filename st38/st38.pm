#!/usr/bin/perl
package ST38;
use strict; 
my %spisok;
my $id=1;
sub st38 {
	print "st38:st38\n";
	while (1)
		{menu();}


}
	sub menu
	{
		print "\n\n=====List of tenants.=====\n";
		my $a;
		print "1) Add tenant.\n2) Edit tenant.\n3) Delete tenant.\n4) Display.\n5) Save to file.\n6) Load from file.\n7) Menu.\n===========================\n\nNumber: ";
		my %t=(1=>\&Add,2=>\&Edit,3=>\&Delete,4=>\&Display,5=>\&Save,6=>\&Load,7=>\&menu);
		while($a=<STDIN>)
		{chomp($a);
		$t{$a}->();
		print "================================";
		print "\n"."Number: ";}
	}
	sub Add
	{
		my $people;
		my $Sname=undef;
		my $Name=undef;
		my $NumFlat=undef;
		my $NumTel=undef;
		
		print "Surname: ";
		my $Sname=<STDIN>;
		chomp($Sname);
 
       	print "Name: ";
		my $Name=<STDIN>;
		chomp($Name);  
 			
     	print "No. flat: ";
		my $NumFlat=<STDIN>;
		chomp($NumFlat);

       	print "No.Telephone: ";
		my $NumTel=<STDIN>;
		chomp($NumTel); 

        $people={SNAME=>$Sname,NAME=>$Name,NFLAT=>$NumFlat,NTEL=>$NumTel};
		$spisok{$id}=$people;
		$id=++$id;
	 }
	
	sub Edit
	{   
		Display();
		print "ID edit:";
		my $y=<STDIN>;
		chomp($y);
		my $people = $spisok{$y};
		print "No.".$y."Surname: ".$people->{SNAME}."|Name: ".$people->{NAME}.";
		#|No.Flat: ".$people->{NFLAT}."|No.Tel: ".$people->{NTEL}."\n";
		print "What your edit?"."\n";
		print "1 - Surname;\n2 - Name;\n3 - No. Flat;\n4 - No. Telephone\n";
		my %t=(1=>'SNAME',2=>'NAME',3=>'NFLAT',4=>'NTEL');
		my $u=<STDIN>;
        chomp($u);
		if($u==1){print "\nSurname: ";};
		if($u==2){print "\nName: ";};
		if($u==3){print "\nNo. Flat: ";};
		if($u==4){print "\nNo. Telephone: ";};
		my $r=<STDIN>;
		chomp($r);
	    $people->{$t{$u}}=$r;
	}

	sub Delete
	{
		print "ID delete:";
		my $y=<STDIN>;
		chomp($y);
		for(my $i=$y;$i<$id;++$i){$spisok{$i}=$spisok{$i+1};}
		delete($spisok{$id});
		$id=$id-1;
	}

    sub Display
	{
		for(my $i=1;$i<$id;++$i)
		{   my $people = $spisok{$i};
			print "No."."$i"."|Surname: ".$people->{SNAME}."|Name: ".$people->{NAME}."|No.Flat: ".$people->{NFLAT}."|No.Tel: ".$people->{NTEL}."\n";}
	}
      

	sub Save
	{
		my %FILE;
		my $t;  
		print "\nSave as...:";
		my $file=<STDIN>;
		chomp($file);	
		dbmopen(%FILE,$file,0644);
		%FILE=();
	    foreach my $i(keys %spisok)
		{
			my $people=$spisok{$i};   
			$t=$people->{SNAME}."::".$people->{NAME}."::".$people->{NFLAT}."::".$people->{NTEL};
			print $t;
			$FILE{$i}=$t;        
		}           
	 	dbmclose(%FILE);
	}

    sub Load
	{
		%spisok=();
		my %FILE=();
		$id=1;
		print "Open file: ";
		my $file=<STDIN>;
		chomp($file);
		dbmopen(%FILE,$file,0644);
		foreach my $i(keys %FILE)
		{   		       
			my $p=$FILE{$i};
			my @ap=split(/::/,$p);
			my $people = {SNAME=>$ap[0],NAME=>$ap[1],NFLAT=>$ap[2],NTEL=>$ap[3]};
			$spisok{$i}=$people;
			$id=++$id;  
		}                                            		
		dbmclose(%FILE);
	}
	                                                           
	
return 1;