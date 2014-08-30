module ContactCenterBackend
  class Agent < ActiveRecord::Base
    include Concerns::AgentStateMachine

    OFFLINE = "offline"
    AVAILABLE = "available"
    NOT_AVAILABLE = "not_available"
    ON_A_CALL = "on_a_call"

    module PhoneType
      PHONE         = "phone"
      TWILIO_CLIENT = "twilio_client"
      SIP           = "sip"
      ALL           = [PHONE, TWILIO_CLIENT, SIP]
    end

    PhoneType::ALL.each do |type|
      define_method "uses_#{type}?" do
        phone_type == type
      end
    end

    validates :username,      presence: true
    validates :name,          presence: true
    validates :sip_uri,       presence: {if: :uses_sip?}
    validates :phone_number,  presence: {if: :uses_phone?}

    def transferrable?
      available?
    end
  end
end
