require 'socket' 

def container_creation(name, username, password)

    port_blacklist = [3000, 3306, 4567, 8000, 8080]

    port = Random.rand(2000...65000)
    
    if !port_blacklist.include?port 
        begin 
            socket = TCPSocket.new('localhost', port)
            `docker run -p #{port}:3306 --name #{name}  -e MYSQL_ROOT_HOST=%  -e MYSQL_DATABASE=#{name} -e MYSQL_USER=#{username} -e MYSQL_PASSWORD=#{password} -v $(pwd)/conf.d/my-custom.cnf:/etc/mysql/conf.d -d mysql/mysql-server`
            puts "Database container created successfully on #{port}. "
            `docker run -p #{port + 1}:80 --name #{name}-phpmyadmin -e PMA_PORTS=#{port} --link #{name}:db -d phpmyadmin/phpmyadmin`
            puts "Now you can access your DB from the port #{port + 1}!"
        rescue 
            puts "#{port} is already taken"
        end 
    else 
        puts "Try again later."
    end 
end 

container_name = ARGV[0]  
container_user_name = ARGV[1] 
container_password = ARGV[2]

container_creation(container_name, container_user_name, container_password)