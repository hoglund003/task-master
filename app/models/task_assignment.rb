class TaskAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def slack_block
    [
      {
        "type": "section",
        "text": {
          "type": "plain_text",
          "text": "You have been assigned a task:",
          "emoji": true
        }
      },
      {
        "type": "header",
        "text": {
          "type": "plain_text",
          "text": "#{task.name}"
        }
      },
      {
        "type": "actions",
        "block_id": "#{id}",
        "elements": [
          {
            "type": "button",
            "text": {
              "type": "plain_text",
              "emoji": true,
              "text": "I can do it!"
            },
            "style": "primary",
            "value": "accepted"
          },
          {
            "type": "button",
            "text": {
              "type": "plain_text",
              "emoji": true,
              "text": "I can't do it"
            },
            "style": "danger",
            "value": "denied"
          }
        ]
      }
    ]
  end

  def slack_accept_block
    {"replace_original": "true","text": "Great, you accepted! Please do the task: #{task.name}"}
  end

  def slack_deny_block
    {"replace_original": "true","text": "That's ok. I'll assign you a task another time. ;)"}
  end
end
