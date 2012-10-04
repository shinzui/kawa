redis_url = configatron.redis.queue.url
redis_namespace = configatron.redis.queue.namespace

raise "Redis is misonfigured. url: #{redis_url} namespace: #{redis_namespace}" if !redis_url.present? || !redis_namespace.present?

Sidekiq.configure_server do |config|
  config.redis = { :url => redis_url, :namespace => redis_namespace, :size => 25 }
  config.server_middleware do |chain|
    chain.add Kiqstand::Middleware
  end
end

Sidekiq.configure_client do |config|
  config.redis = { :url => redis_url, :namespace => redis_namespace, :size => 1 }
end
