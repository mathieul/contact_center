module ContactCenter
  class Call < ActiveRecord::Base
    enum call_status: [:pending, :ringing, :in_progress, :queued, :completed,
                       :busy, :failed, :no_answer, :canceled]
    belongs_to :agent
  end
end
