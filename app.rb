#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'


configure do
	@db = SQLite3::Database.new 'barbershop.db'
	@db.execute 'CREATE TABLE IF NOT EXISTS 
		"Users" 
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
			"username" VARCHAR, 
			"phone" VARCHAR, 
			"datestamp" VARCHAR, 
			"barber" VARCHAR, 
			"color" VARCHAR
		)'
end


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	@error = 'something wrong'
	erb :about			
end

get '/visit' do
	@tittle = "Записаться"                                                      
	@message = "Здесь вы можете записаться"
	erb :visit			
end

post '/visit' do                                                                        
   	@username = params[:username]                                            
	@phone = params[:phone]                                                    
	@datetime = params[:datetime] 
	@master = params[:master]                                           
         
    hh = { :username => 'Введите имя', 
    	:phone => 'Введите телефон', 
    	:datetime => 'Введите дату и время' }  
	
	hh.each do |key, value|
		if params[key] == ''
			@error = hh[key]

			return erb :visit	
		end 
		
		@tittle = "Спасибо!"                                                      
		@message = "Дорогой #{@username},мы ждем тебя в #{@datetime}"
			 

		f = File.open('./public/contacts.txt','a')                                    
		f.write "Имя: #{@username}, Телефон: #{@phone}, Дата и время: #{@datetime}, Мастер: #{@master}"
		f.close   
		     
	end     
	erb :message                                                                              
end 




get '/contacts' do
	erb :contacts			
end
get '/login' do
	erb :login
end
post '/login' do                                      
	@login = params[:user]                    
	@pass = params[:password]                     
		if @login == "admin" && @pass == "secret"
			@sss = "Добро пожаловать #{@login}"
			erb :welcome                     
		else                                     
			@sss="Доступ запрещен!"             
			erb :welcome                       
		end 

	end                                                                                     
@sss = '' 


