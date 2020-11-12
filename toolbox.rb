require 'socket' 

def container_creation(name, port, root_password)
    `docker run -p #{port}:3306 --name #{name}  -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=#{root_password} -v $(pwd)/conf.d/my-custom.cnf:/etc/mysql/conf.d -d mysql/mysql-server`
end 

container_name = ARGV[0] 
container_port = ARGV[1] 
container_root_password = ARGV[2] 

container_creation(container_name, container_port, container_root_password)