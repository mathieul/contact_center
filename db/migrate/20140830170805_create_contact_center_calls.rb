class CreateContactCenterCalls < ActiveRecord::Migration
  def change
    create_table :contact_center_calls do |t|
      t.string      :sid, index: true
      t.string      :from
      t.string      :to
      t.integer     :direction
      t.integer     :call_status, default: 0
      t.string      :state, null: false
      t.datetime    :connected_at
      t.datetime    :disconnected_at
      t.references  :agent, index: true

      t.timestamps null: false
    end
  end
end
