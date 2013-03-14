namespace :deals do
  desc 'imports new deals'
  task import: :environment do
    Feed.all.each do |feed|
        feed.fetch!
      end
  end

  desc 'reclassify deals'
  task reclassify: :environment do
    Deal.reclassify!
  end

  desc 'classify unclassified deals'
  task classify: :environment do
    Deal.classify!
  end
end