Capistrano::Configuration.instance(true).load do
  set :npm_path,    'npm'
  set :npm_options, '--production --silent'

  depend :remote, :command, npm_path

  namespace :npm do
    desc 'Runs npm install.'
    task :install, :roles => :app, :except => { :no_release => true } do
      run "cd #{latest_release} && #{try_sudo} #{npm_path} #{npm_options} install"
    end
  end
end
