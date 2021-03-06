module ContactCenter
  module Concerns::AgentStateMachine
    extend ActiveSupport::Concern

    included do
      state_machine :status, initial: :offline do
        event :available do
          transition any => :available
        end

        event :came_online do
          transition offline: :available
        end

        event :offline do
          transition all - [:offline] => :offline
        end

        event :on_a_call do
          transition available:     :on_a_call
          transition not_available: :on_a_call
        end

        event :not_available do
          transition [:offline, :available] => :not_available
        end

        event :call_ended do
          transition on_a_call: :not_available
        end

        event :toggle_available do
          transition available:     :not_available
          transition not_available: :available
        end

        after_transition do |agent, transition|
          unless transition.loopback?
            ActiveSupport::Notifications.instrument(
              "contact_center.agent_status_change",
              agent_id:  agent.id,
              username:  agent.username,
              status:    transition.to,
              timestamp: Time.now.to_i
            )
          end
        end
      end
    end
  end
end
