package ST26;

use strict;
use warnings;
use Person;

my @group;  
my $res = 1;

my $check_input = sub { 
    while( my $choice = <STDIN> ) {
            chomp $choice;
            if ( $choice =~ m/\d+/ && $choice <= @group && $choice>0 ) {
              	return $choice;
            }

            print "\nInvalid input\n\nYour choice: ";
       }	
};

#menu function 
sub menu {
    my @items = @_;
    my $count = 0;
    for my $item( @items ) {
        printf "%d: %s\n", ++$count, $item->{text};
    }

    print "\nYour choice: ";

    while( my $line = <STDIN> ) {
        chomp $line;
        if ( $line =~ m/\d+/ && $line <= @items && $line>0 ) {
            return $items[ $line - 1 ]{code}();
        }

        print "\nInvalid input\n\nYour choice: ";
    }
};



#print student's function 
my $print_students = sub { 
    print "\n######### Print Group ########\n" ;
    my $count = 0;
    for my $item( @group ) {
        printf "%d: FName:%s LName:%s id:%d \n", ++$count, $item->getFirstName(),$item->getLastName(),$item->getID();
    }
    print "\n";
};

#add student function 
my $add_student = sub { 
    print "\n########## Add Student  #########\n" ;
    print "First Name :\n";
    chomp (my $f_name = <STDIN>);
    print "Last Name :\n";
    chomp (my $l_name = <STDIN>);
    print "ID: \n";
    chomp (my $id = <STDIN>);
    push(@group,new Person( $f_name, $l_name, $id));
    &$print_students(); 
};

#edit student function 
my $edit_student = sub { 
    if(@group >0)
    {
        print "\n########## Edit Student  #########\n" ;
        &$print_students(); 
        print "Enter student number:\n";
        while( my $choice = <STDIN> ) {
            chomp $choice;
            if ( $choice =~ m/\d+/ && $choice <= @group && $choice>0 ) {
                print "First Name :\n";
                chomp (my $f_name = <STDIN>);
                $group[$choice-1]->setFirstName($f_name); 
                print "Last Name :\n";
                chomp (my $l_name = <STDIN>);;
                $group[$choice-1]->setLastName($l_name); 
                print "ID: \n";
                chomp (my $id = <STDIN>);
                $group[$choice-1]->setID($id); 
                &$print_students();
                last;
            }
            print "\nInvalid input\n\nYour choice: ";
        }
        
    }
    else{
         print "\n######### Group is empty ########\n" ;
    }

};



#delete_student function 
my $del_student = sub { 
    if(@group >0)
    {
        print "\n######### Delete Student ########\n" ;
        &$print_students(); 
        print "Enter student number:\n";
        my $choice = &$check_input();
        splice @group,$choice-1,1;
        &$print_students();
        #while( my $choice = <STDIN> ) {
         #   chomp $choice;
          #  if ( $choice =~ m/\d+/ && $choice <= @group && $choice>0 ) {
               
           #     last;
            #}

           # print "\nInvalid input\n\nYour choice: ";
        #}
    }
    else{
         print "\n######### Group is empty ########\n" ;
    }
    
};


#save students to dbm file function 
my $save_students = sub { 
     print "\n######### Save Group ########\n" ;
};

#load students from dbm file function 
my $load_students = sub { 
    print "\n######### Load Group ########\n" ;
 
};





# menu 
my @menu_choices = (
    { text  => 'add student',
      code  =>  $add_student},
    { text  => 'edit student',
      code  =>  $edit_student},
    { text  => 'delete student',
      code  => $del_student },
    { text  => 'print group',
      code  => $print_students },
    { text  => 'save',
      code  => $save_students },
    { text  => 'load',
      code  => $load_students },
    { text  => 'exit',
      code  =>  sub { $res = 0;}  }
);





sub st26
{
	while($res)
	{
	    menu( @menu_choices );
	}
}

return 1;