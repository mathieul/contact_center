# C.f.: https://github.com/pluginaweek/state_machine/issues/251

require_dependency 'state_machine'

module StateMachine::Integrations::ActiveModel
  public :around_validation
end
