namespace :security do
  # desc "TODO"
  # task brakeman: :environment do
  #   brakeman -o output.html
  # end

  desc 'TODO'
  task rbp: :environment do
    puts `rails_best_practices -f html .`
  end
end
