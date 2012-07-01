module UsersHelper
  def collection_of_roles
    I18n.t("activerecord.values.user.roles").invert.to_a
  end
end
