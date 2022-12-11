# dir_name = '~/workspace/runteq/'
# ruby_version = '3.1.3'

# run "asdf local #{ruby_version}"
# run "cp #{dir_name}/Gemfile ./Gemfile"
# run "cp #{dir_name}/Procfile" # HEROKU用
# run "cp #{dir_name}/Dockerfile ./Dockerfile"
# run "cp #{dir_name}/docker-composer.yml ./docker-composer.yml"
# run "rm -r test"
gem 'sorcery'
gem 'rails-i18n', '~> 7.0.0'
gem 'draper'


# application do
#   %Q{
#     config.generators do |g|
#       g.skip_routes true
#       g.assets false
#       g.helper false
#       g.test_framework :rspec, fixture: true
#     end
#   }
# end

run_bundle

# generate(":bullet:install")
# generate("draper:install")
# generate("rspec:install")
# generate("sorcery:install")
# generate(:controller, "users index")
rails_command("db:create")
rails_command("db:migrate")
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }

# route "root to: 'users#index'"