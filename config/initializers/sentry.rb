Sentry.init do |config|
  config.dsn = "https://b834e55bbeb2a75dc8146cf593813d73@o4509643388682240.ingest.us.sentry.io/4509643398840320"
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
end
