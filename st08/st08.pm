
#!/usr/bin/perl 
package ST08;
use strict;
sub st08
{
our  $end=0;  # флаг завершения программы
my @list_user=(); # Список людей
 sub add_user
 	{
	 my $user= {
		 	family => "",
	 		name =>"",
	 		office_number => ""
	 	};
		print "Введите фамилию ";
		chomp(my $family=<STDIN>);
		print "Введите имя ";
		chomp(my $name=<STDIN>);
		print "Введите номер кабинета ";
		chomp(my $office_number=<STDIN>);
		$user->{family}=$family;
		$user->{name}=$name;
		$user->{office_number}=$office_number;
	 push(@list_user ,\$user);
	 print "Сотрудник добавлен";	 
	 
	 }
 sub print_one_user
 	{
 	print $_[0]->{family}." ".$_[0]->{name}." ".$_[0]->{office_number}."\n";
 	
 	}
 sub print_user_list
 	{ my $userid=0;
 	 print "Фамили  Имя  Номер комнаты\n";
 	for my $user (@list_user)
	{	print ++$userid."  ";
		print_one_user($$user);	
	}
 	}
sub print_user
	{
		print "Введите №";
		chomp(my $nomber=<STDIN>);
		my $user=@list_user[$nomber-1];
		print_one_user($$user);
		
	}
sub edit_user
		{
			print "Введите № сотрудника, которого хотите изменить ";
			chomp(my $nomber=<STDIN>);
			my $user=@list_user[$nomber-1];
			print "Сотрудник: ";
			print_one_user($$user);
	   	 	my $new_user= {
	   		 	family => "",
	   	 		name =>"",
	   	 		office_number => ""
	   	 	};
	   		print "Введите фамилию ";
	   		chomp(my $family=<STDIN>);
	   		print "Введите имя ";
	   		chomp(my $name=<STDIN>);
	   		print "Введите номер кабинета ";
	   		chomp(my $office_number=<STDIN>);
	   		$new_user->{family}=$family;
	   		$new_user->{name}=$name;
	   		$new_user->{office_number}=$office_number;
			@list_user[$nomber-1]=\$new_user;
			
		
		}
		sub delite_user
				{
					print "Введите № сотрудника, которого хотите удалить ";
					chomp(my $nomber=<STDIN>);
					my $user=@list_user[$nomber-1];
					print "Сотрудник: ";
					print_one_user($$user);
					splice (@list_user,$nomber-1,1);
					print "Сотрудник удален\n";
		
				}		
	
sub create_file
{ 
	
	
	my %hash=();
		dbmopen( %hash, "file", 0644);
		my $j=0;
		foreach my $uesr(@list_user)
		{	
			$hash{$j}= join(":", $$uesr->{family},$$uesr->{name},$$uesr->{office_number});
			$j++;
		}
		dbmclose(%hash);
		print "Файл сохранен!\n";
}

sub load_file
 {  
	@list_user=(); 
	
	dbmopen(my %hash, "file", 0644);
	
		while (( my $key,my $value) = each(%hash))
	{
		 my @arg=split(/:/,$hash{$key});
		 my $user={
		  family => "$arg[0]",
		  name => "$arg[1]",
		  office_number => "$arg[2]"
		  };
		  push(@list_user ,\$user);
	}
	
	dbmclose(%hash);
	
  print "Файл загружен!\n";
 }

 my $menu_titel = "
  1- Выход
  2- Создание пользователя
  3- Вывод пользователей
  4- Вывод пользователя по id
  5- Изменить информацию по сотруднику
  6- Удаление пользователя
  7 - запись в файл
  8 - Загрузить из файла
  Выберете операцию:";
my @MENU = (\&add_user,\&print_user_list,\&print_user,\&edit_user,\&delite_user,\&create_file,\&load_file);

while ($end!='1')
{
	print $menu_titel;
	my $param =  <STDIN>; # Прочитать следующую строку
	chomp $param; # Удалить завершитель
	$end=$param;
		if ($param > 1 &&  $param < 9 )
		{
			@MENU[$param-2]->();
		}
		else 
		{
			print "Некорректный параметр";
		}
			
	
} 
print "выполнение завершено\n";

}
return 1;