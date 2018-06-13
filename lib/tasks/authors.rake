namespace :authors do
  task :explode => :environment do
    Author.transaction do
      Author.all.to_a.select { |a| a.name[/(,|\sand\s)/] }.each do |compound|
        puts "Exploding #{compound.name}"

        unique_names = compound.name.
          split(/(,|\sand\s)/).
          reject { |n| n == " and " || n == "," }.
          map(&:strip)

        authors = unique_names.map do |name|
          Author.where(name: name).first || Author.create!(name: name)
        end

        puts "\t- into => #{unique_names}"

        Document.joins(:authors).where(authors: { id: compound.id }).uniq.each do |document|
          puts "\t- fixing document ##{document.id}"
          document.authors.delete(compound)
          document.authors << authors
        end

        compound.delete
        puts "\t- compound author deleted"
      end
    end
  end

  task :link => :environment do
    Author.transaction do
      Author.where(user_id: nil).each do |author|
        puts "Trying to find a user for #{author.name}"
        user = User.where("first_name || ' ' || last_name = ?", author.name).first

        if user
          author.update_attributes!(user_id: user.id)
          puts "\t- FOUND and updated"
        end
      end
    end
  end
end
