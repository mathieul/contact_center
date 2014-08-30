module ContactCenter
  class Call < ActiveRecord::Base
    include Concerns::CallStateMachine

    PROVIDER_STATUSES = %w[pending ringing in_progress queued completed busy
                           failed no_answer canceled]

    enum state: %i[not_initiated connecting terminated in_progress
                   in_conference in_progress_hold]

    validates :provider_status, inclusion: {in: PROVIDER_STATUSES, allow_blank: true}

    belongs_to :agent
  end
end
