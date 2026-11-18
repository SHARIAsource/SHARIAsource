# The ALB's health check target. Plain ActionController::Base so nothing in
# ApplicationController (sessions, impressions) runs for it.
class HealthController < ActionController::Base
  def show
    ActiveRecord::Base.connection.select_value('SELECT 1')
    render plain: 'ok'
  rescue ActiveRecord::ActiveRecordError, PG::Error
    render plain: 'database unavailable', status: :service_unavailable
  end
end
