class ServiceSerializer < ActiveModel::Serializer
  attributes :name, :url, :login_button_identifier, :login_field_identifier
end
