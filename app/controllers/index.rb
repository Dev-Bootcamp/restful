get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/new' do
  erb :new_note
end

get '/note/:id' do
  @note = Note.find(params[:id])
  @user = User.find(@note.user_id)
  erb :note
end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :user
end

get '/delete/:id' do
  p params
  Note.destroy(params[:id])
  redirect '/'
end

post '/new' do
  user = User.find_or_create_by_name(params[:name])
  Note.create(user_id: user.id, title: params[:title], content: params[:content])
  redirect '/'
end

post '/update' do
  user = User.find_or_create_by_name(params[:name])
  note = Note.find(params[:note_id])
  note.update_attributes(user_id: user.id, title: params[:title], content: params[:content])
  redirect '/'
end
