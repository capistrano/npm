namespace :npm do
  desc <<-DESC
        Install the project dependencies via npm. By default, devDependencies \
        will not be installed. The install command is executed \
        with the --production, --silent and --no-spin flags.

        You can override any of these defaults by setting the variables shown below.

          set :npm_target_path, nil
          set :npm_flags, '--production --silent --no-spin'
          set :npm_roles, :all
          set :npm_env_variables, {}
    DESC
  task :install do
    on roles fetch(:npm_roles) do
      within fetch(:npm_target_path, release_path) do
        with fetch(:npm_env_variables, {}) do
          execute :npm, 'install', fetch(:npm_flags)
        end
      end
    end
  end

  before 'deploy:updated', 'npm:install'

  desc <<-DESC
        Runs the build command. Completely optional. opt in with `after 'npm:instal', 'npm:build'`

    DESC
  task :build do
    on roles fetch(:npm_roles) do
      within fetch(:npm_target_path, release_path) do
        with fetch(:npm_env_variables, {}) do
          execute :npm, 'build'
        end
      end
    end
  end
  
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

  desc <<-DESC
        Rebuild via npm. This command is executed within the same context \
        as npm install using the npm_roles and npm_target_path \
        variables.

        This task is strictly opt-in. The main reason you'll want to run this \
        would be after changing npm versions on the server.
    DESC
  task :rebuild do
    on roles fetch(:npm_roles) do
      within fetch(:npm_target_path, release_path) do
        with fetch(:npm_env_variables, {}) do
          execute :npm, 'rebuild'
        end
      end
    end
  end
end

namespace :load do
  task :defaults do
    set :npm_flags, %w(--production --silent --no-progress)
    set :npm_prune_flags, '--production'
    set :npm_roles, :all
  end
end
