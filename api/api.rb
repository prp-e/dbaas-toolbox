require 'json' 
require 'sinatra' 


before do 
    @req_data = request.body.read 
end 

get '/' do 
    'Please use the correct endpoint' 
end 

post '/dbaas' do 
    push = @req_data 
    push.inspect 
end 