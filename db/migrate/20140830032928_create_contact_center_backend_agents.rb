class CreateContactCenterBackendAgents < ActiveRecord::Migration
  def change
    create_table :contact_center_backend_agents do |t|
      t.string :username,     null: false
      t.string :status,       default: 'offline'
      t.string :name,         null: false
      t.string :phone_type,   default: 'twilio_client'
      t.string :phone_number
      t.string :phone_ext
      t.string :sip_uri

      t.timestamps null: false
    end

    add_index :contact_center_backend_agents, :username
  end
end
