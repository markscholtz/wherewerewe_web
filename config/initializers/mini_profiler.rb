if Rails.env != 'production'
  puts '----> Setting up MiniProfiler'
  Rack::MiniProfiler.config.position    = :right
  Rack::MiniProfiler.config.auto_inject = false
end
