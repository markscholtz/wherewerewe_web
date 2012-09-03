if Rails.env != 'production'
  Rack::MiniProfiler.config.position    = :right
  Rack::MiniProfiler.config.auto_inject = true
end
