#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	db = SQLite3::Database.new 'barbershop.db' 
	db.results_as_hash = true
	return db

end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS 
		"Users" 
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
			"username" TEXT, 
			"phone" TEXT, 
			"datestamp" TEXT,
			"barber" TEXT, 
			"color" TEXT
		)'
end

get '/showusers' do
	erb 'hello'
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
	@color = params[:color]              
         
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
	end     

	db = get_db
		db.execute 'insert into
		Users
		(
			username,
			phone,
			datestamp,
			barber,
			color
		)
		values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @master, @color]
	
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


