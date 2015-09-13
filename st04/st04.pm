package ST04;
#Реализовать на Perl консольное приложение, позволяющее добавлять, редактировать, выводить на экран, сохранять в файл список однотипных объектов (студентов группы, служащих фирмы, жителей дома и т.п.), каждый из которых обладает несколькими атрибутами (имя, фамилия, возраст и т.п.).

#Требования к реализации:
#- использовать директиву use strict;
#- взаимодействие с пользователем осуществляется через простое текстовое меню, выбор действия - ввод цифры;
#- меню включает в себя следующие пункты: добавить, редактировать, удалить объект, вывести на экран весь список, сохранить в файл, загрузить из файла;
#- реализовать обработку меню с помощью хэша/массива ссылок на функции;
#- данные сохраняются в dbm-файл;
#- при загрузке в память каждый объект хранится в виде ссылки на анонимный хэш, вся картотека хранится в виде массива (либо хэша) ссылок.
use strict;
use DB_File;
use warnings;
use Data::Dumper; #debug purpose
#############Global Variables#############
my $count=0;
my $run=1;
my $cashe={};
#############Subroutines###############
#############
# getUID - generate unique number for store in $cashe
# INPUT: none
# OUTPUT: NUMBER uid
#############
sub getUID{
    my $UID=0;
    for (keys %$cashe) {
	$UID=$_ if $UID<$_;
    }
    return $UID+1;
}
#############
# add - call menu for interactively add new item in the $cashe
# INPUT: none
# OUTPUT: none
# return in st04
############
sub add{
    my $menu="To add new item type in format:\nAttribute:Value\ntype 'end' to finish definition and insert item to current data\n";
    my @temp=();
    print "Currently $count items\n";
    print $menu;
    my $save=0;
    do{
	my $line=<STDIN>;
	chomp $line;
	if ($line=~ m/^(\w+):(\w+)\b/){
	    @temp=(@temp,$1,$2);
	}
	$save=$line=~m/^end/;
    }while (!$save);
    my $uid = getUID();
    $cashe->{$uid}={@temp};
    #print Dumper $cashe; debug purpose
}

#############
# correct - call menu for interactively correct existed item in the $cashe
# INPUT: none
# OUTPUT: none
# return in st04
############
sub correct{
    print "correct";
}

#############
# delete - call menu for interactively delete existed item in the $cashe
# INPUT: none
# OUTPUT: none
# return in st04
############
sub delete{
    print "delete";
}

#############
# add - call menu for interactively add new item in the $cashe
# INPUT: none
# OUTPUT: none
# return in st04
############
sub show{
    print "show";
}

#############
# save - call menu for interactively save $cashe to dbm file
# INPUT: none
# OUTPUT: none
# return in st04
############
sub save{
    print "save";
}

#############
# load - call menu for interactively load data from dbm file and put it to $cashe
# INPUT: none
# OUTPUT: none
# return in st04
############
sub load{
    print "load";
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
	print "$Menu";
	my $choice=<STDIN>;
	chomp $choice;
	$menuEntry->{$choice}->() if defined $menuEntry->{$choice};
    }
    
}

return 1;
