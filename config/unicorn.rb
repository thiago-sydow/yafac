worker_processes (ENV['WORKER_PROCESSES'] || 3).to_i
timeout (ENV['WEB_TIMEOUT'] || 6000).to_i
preload_app true
