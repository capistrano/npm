Capistrano::Configuration.instance(true).load do
  set :npm_path,    'npm'
  set :npm_options, '--production --silent'

  depend :remote, :command, npm_path

  namespace :npm do
    desc 'Runs npm install.'
    task :install, :roles => :app, :except => { :no_release => true } do
      try_sudo "cd #{latest_release} && #{npm_path} #{npm_options} install"
    end
  end
end
