namespace :setup do
    desc 'Create user for devise'
    task :create_user, [:email, :password] => :environment do |t, args|
        email = args[:email] 
        password = args[:password]
        user = User.create!(email: email, password: password, password_confirmation: password)
    end
end