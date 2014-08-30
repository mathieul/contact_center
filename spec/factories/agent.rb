FactoryGirl.define do
  factory :agent, class: ContactCenterBackend::Agent do
    sequence(:username) { |n| "agent#{n}" }
    name                "Agent Smith"

    factory :available_agent do
      status ContactCenterBackend::Agent::AVAILABLE
    end

    factory :on_a_call_agent do
      status ContactCenterBackend::Agent::ON_A_CALL
    end

    factory :not_available_agent do
      status ContactCenterBackend::Agent::NOT_AVAILABLE
    end
  end
end
