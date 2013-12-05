namespace :npm do
  desc <<-DESC
        Install the project dependencies via npm. By default, devDependencies \
        will not be installed. The install command is executed \
        with the --production and --silent flags.

        You can override any of these defaults by setting the variables shown below.

          set :npm_target_path, nil
          set :npm_flags, '--production --silent'
          set :npm_roles, :all
    DESC
  task :install do
    on roles fetch(:npm_roles) do
      within fetch(:npm_target_path, release_path) do
        execute :npm, 'install', fetch(:npm_flags)
      end
    end
  end

  before 'deploy:updated', 'npm:install'
end

namespace :load do
  task :defaults do
    set :npm_flags, '--production --silent'
    set :npm_roles, :all
  end
end
