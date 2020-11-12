require 'socket' 

def container_creation(name, port, root_password)
    `docker run -p #{port}:3306 --name #{name}  -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=#{root_password} -v $(pwd)/conf.d/my-custom.cnf:/etc/mysql/conf.d -d mysql/mysql-server`
    puts "Database container created successfully"
    `docker run -p 8000:80 --name #{name}-phpmyadmin -e PMA_PORTS=#{port} --link #{name}:db -d phpmyadmin/phpmyadmin`
end 

container_name = ARGV[0] 
container_port = ARGV[1] 
container_root_password = ARGV[2] 

container_creation(container_name, container_port, container_root_password)