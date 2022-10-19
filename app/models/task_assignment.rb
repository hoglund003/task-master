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
end
