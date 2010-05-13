namespace :pyrite do
  namespace :sphinx do
    desc "Call Thinking Sphinx's rebuild task at start up"
    task :start do
      Rake::Task['ts:rebuild'].invoke
      Rake::Task['pyrite:start'].invoke
    end

    desc "Call Thinking Sphinx's stop task after test"
    task :stop do
      Rake::Task['ts:stop'].invoke
      Rake::Task['pyrite:stop'].invoke
    end
  end
end