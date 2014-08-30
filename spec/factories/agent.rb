FactoryGirl.define do
  factory :agent, aliases: [:offline_agent], class: ContactCenter::Agent do
    sequence(:username) { |n| "agent#{n}" }
    name                "Agent Smith"

    factory :available_agent do
      status ContactCenter::Agent::AVAILABLE
    end

    factory :on_a_call_agent do
      status ContactCenter::Agent::ON_A_CALL
    end

    factory :not_available_agent do
      status ContactCenter::Agent::NOT_AVAILABLE
    end
  end
end
