class BookmarkManager < Sinatra::Base

  get '/users' do
    erb :'../views/signup'
  end

  post '/users' do
    user = User.create(name: params[:name],
                       email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    if user.valid?
      redirect '/links'
    else
      flash[:notice] = user.errors.full_messages
      redirect '/users'
    end
  end

end
