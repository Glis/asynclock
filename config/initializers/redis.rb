if Rails.env.development? || Rails.env.test?
  $redis = Redis::Namespace.new("asynclock_#{Rails.env}", redis: Redis.new(url: ENV.fetch("REDIS_URL") { "redis://localhost:6379" }))
else
  $redis = Redis::Namespace.new("asynclock_#{Rails.env}", redis: Redis.new(url: ENV["REDIS_URL"]))
end
