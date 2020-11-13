require 'json' 
require 'sinatra' 

def container_creation(name, username, password)

    port_blacklist = [3000, 3306, 4567, 8000, 8080]

    port = Random.rand(2000...65000)
    
    if !port_blacklist.include?port 
        begin 
            socket = TCPSocket.new('localhost', port)
            puts "#{port} is already taken"
        rescue 
            `docker run -p #{port}:3306 --name #{name}  -e MYSQL_ROOT_HOST=%  -e MYSQL_DATABASE=#{name} -e MYSQL_USER=#{username} -e MYSQL_PASSWORD=#{password} -v $(pwd)/conf.d/my-custom.cnf:/etc/mysql/conf.d -d mysql/mysql-server`
            puts "Database container created successfully on #{port}. "
            `docker run -p #{port + 1}:80 --name #{name}-phpmyadmin -e PMA_PORTS=#{port} --link #{name}:db -d phpmyadmin/phpmyadmin`
            puts "Now you can access your DB from the port #{port + 1}!"
        end 
    else 
        puts "Try again later."
    end
    
    return port 

end 

before do 
    @req_data = request.body.read 
end 

get '/' do 
    'Please use the correct endpoint' 
end 

post '/dbaas' do 
    push = @req_data 
    push = JSON.parse(push) 
    db_port = container_creation(push['database'], push['username'], push['password'])
    final_result = {"database" => push['database'], "port" => db_port, "phpmyadmin_port" => db_port + 1}

    final_result.to_json 
end 