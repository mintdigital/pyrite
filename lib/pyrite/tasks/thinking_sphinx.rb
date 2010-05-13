namespace :pyrite do
  namespace :sphinx do
    task :start do
      Rake::Task['ts:rebuild'].invoke
    end

    task :stop do
      Rake::Task['ts:stop'].invoke
    end
  end

  task :start => 'sphinx:start'
  task :stop  => 'sphinx:stop'
end