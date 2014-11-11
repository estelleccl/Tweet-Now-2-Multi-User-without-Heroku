def login?
  if session[:username].nil?
    return false
  else
    return true
  end
end

def username
  return session[:username]
end

helpers do
  def admin?
    session[:admin]
  end
end

def job_is_complete(jid)
  waiting = Sidekiq::Queue.new
  workers = Sidekiq::Workers.new
  pending = Sidekiq::ScheduledSet.new
  return false if pending.find { |job| job.jid == jid }
  return false if waiting.find { |job| job.jid == jid }
  return false if workers.find { |process_id, thread_id, work| work["payload"]["jid"] == jid }
  true 
end