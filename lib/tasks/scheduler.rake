desc "This task is called by the Heroku scheduler add-on"
task :fetch_all_recommendations_from_intigi => :environment do
    puts "Fetching recommendations from Intigi for all rivers..."
    River.fetch_all_recommendations_from_intigi(true)
    puts "done."
end
