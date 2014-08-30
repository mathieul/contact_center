FactoryGirl.define do
  factory :call, class: ContactCenter::Call do
    sequence(:sid, 1_000_000) { |n| n.to_s(16) }

    factory :terminated_call do
      state 'terminated'
      disconnected_at { 5.minutes.ago }
    end

    factory :not_initiated_call do
      state 'not_initiated'
    end

    factory :connecting_call do
      state 'connecting'
    end

    factory :in_progress_call do
      state 'in_progress'
    end

    factory :in_progress_hold_call do
      state 'in_progress_hold'
    end

    factory :in_conference_call do
      state 'in_conference'
    end

    factory :failed_call do
      sid nil
      state 'in_progress'
    end

    factory :no_answer_call do
      state 'terminated'
    end

    factory :connecting_agent_leg do
      agent
      state :connecting
    end

    factory :active_agent_leg do
      agent
      state :in_progress
    end

    factory :customer_leg do
      agent nil
      state :in_progress
    end

    factory :inactive_agent_leg do
      agent
      state :terminated
    end
  end
end
