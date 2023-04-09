# namespace :ridgepole do
#   desc "Apply ridgepole schemafile"
#   task apply: :environment do
#     ridgepole('--apply')
#   end

#   desc "Export ridgepole schemafile"
#   task export: :environment do
#     ridgepole('--export')
#   end

#   private
#   def config_file
#     if Rails.env.development?
#       'config/database.yml'
#     elsif Rails.env.staging?
#       'config/database.staging.yml'
#     elsif Rails.env.production?
#       'config/database.production.yml'
#     else
#       raise 'no configuration specified'
#     end
#   end

#   def ridgepole(*options)
#     command = ['bundle exec ridgepole --file db/schemas/Schemafile', "-c #{config_file}", "-E #{Rails.env}"]
#     system (command + options).join(' ')
#   end
# end