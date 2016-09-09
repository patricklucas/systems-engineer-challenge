workers Integer(ENV["WEB_CONCURRENCY"] || 1)
worker_timeout Integer(ENV["WORKER_TIMEOUT"] || 60)
threads_count = Integer(ENV["MAX_THREADS"] || 16)
threads threads_count, threads_count

preload_app!

rackup DefaultRackup
port ENV["PORT"] || 3000
environment ENV["RACK_ENV"] || "development"
