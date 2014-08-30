class CreateContactCenterCalls < ActiveRecord::Migration
  def change
    create_table :contact_center_calls do |t|
      t.string      :sid, index: true
      t.string      :from
      t.string      :to
      t.integer     :direction
      t.string      :provider_status
      t.integer     :state, default: 0
      t.datetime    :connected_at
      t.datetime    :disconnected_at
      t.references  :agent, index: true

      t.timestamps null: false
    end
  end
end
