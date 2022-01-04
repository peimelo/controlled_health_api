class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :account, null: false, foreign_key: true
      t.datetime :accepted_at

      t.timestamps
    end

    add_index :invitations, %i[email account_id], unique: true
  end
end
