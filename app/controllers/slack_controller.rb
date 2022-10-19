class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token # Unsafe workaround for CSRF

  def slack
    # This JSON decoding works for the CURRENT interaction layout!
    payload = params[:payload]
    data = JSON.parse payload.gsub('=>', ':') # Convert response to JSON
    slack_id = data["user"]["id"]
    assignment_id = data["message"]["blocks"][2]["block_id"] # Interaction is using "block_id" to track "task_assignment_id"
    reply = data["actions"][0]["value"]

    user = SlackAccount.where(slack_id: slack_id).first.user
    assignment = TaskAssignment.where(id: assignment_id.to_i).first
    task = assignment.task

    assignment.update(reply: reply)
    response_url = data["response_url"] # Slack provides URL for responding to interactions

    # Custom API call (slack api gem does not include this function)
    uri = URI(response_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })

    # Select type of response
    if reply == "accepted"
      request.body = assignment.slack_accept_block.to_json
    elsif reply == "denied"
      request.body = assignment.slack_deny_block.to_json
    end
  end
end
