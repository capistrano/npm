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

  desc <<-DESC
        Remove extraneous packages via npm. This command is executed within \
        the same context as npm install using the npm_roles and npm_target_path \
        variables.

        By default prune will be executed with the --production flag.  You can \
        override this default by setting the variable shown below.

          set :npm_prune_flags, '--production'

        This task is strictly opt-in.  If you want to run it on every deployment \
        before you run npm install, add the following to your deploy.rb.

          before 'npm:install', 'npm:prune'
    DESC
  task :prune do
    on roles fetch(:npm_roles) do
      within fetch(:npm_target_path, release_path) do
        execute :npm, 'prune', fetch(:npm_prune_flags)
      end
    end
  end
end

namespace :load do
  task :defaults do
    set :npm_flags, '--production --silent'
    set :npm_prune_flags, '--production'
    set :npm_roles, :all
  end
end
