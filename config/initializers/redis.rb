$redis = Redis::Namespace.new("asynclock_#{Rails.env}", redis: Redis.new(url: ENV.fetch("REDIS_URL") { "redis://localhost:6379" }))
