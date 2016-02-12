class BookmarkManager < Sinatra::Base

  delete '/logout' do
    flash[:notice] = "Goodbye #{current_user.name}"
    session.clear
    redirect '/links'
  end

  get '/users/login' do
    erb :login
  end

  post '/users/login' do
    user = User.first(email: params[:email])
    session[:user_id] = user.authenticate(params[:password]) if user
    if session[:user_id]
      redirect('/links')
    else
      flash[:notice] = "Wrong email/password"
      redirect('/users/login')
    end
  end

  get '/users/reset-password' do
    erb :reset_password
  end

  get '/users/token' do
    erb :token
  end

  get '/users/new-password' do
    erb :new_password
  end

  post '/users/reset-password' do
    user = User.first(email: params[:email])
    user.forgot_password
    flash[:notice] = "Your password has been sent"
    redirect '/users/login'
  end

  post '/users/token' do
    session[:user] = User.first(password_token: params[:token])
    if session[:user] && !session[:user].expired_token?
      redirect '/users/new-password'
    else
      flash[:notice] = "Wrong token"
      redirect '/users/token'
    end
  end

  post '/users/new-password' do
    user = User.first(email: session[:user].email)
    p user.password_digest
    p user.password_digest
    user.update_password(params[:password], params[:password_confirmation])
    p user.password_digest
    redirect '/users/login'
  end

end
