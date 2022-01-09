class AccountsSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_owner

  def is_owner
    object.owner == current_api_user
  end
end
