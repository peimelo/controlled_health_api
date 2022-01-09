class PopulateAccounts < ActiveRecord::Migration[6.1]
  def up
    User.all.each do |user|
      account_name = user.name && user.name.length > 2 ? user.name : user.email
      account = Account.create!(id: user.id, name: account_name, owner_id: user.id)

      account.users << user
    end
  end

  def down
    Account.all.map(&:destroy)
  end
end
