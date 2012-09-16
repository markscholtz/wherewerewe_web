if Rails.env != 'production'
  Rack::MiniProfiler.config.position    = :left
  Rack::MiniProfiler.config.auto_inject = true
end
