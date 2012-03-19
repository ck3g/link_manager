module ApplicationHelper
  def to_currency(number)
    number_to_currency number, :unit => ""
  end

  def active(name)
    condition = params[:controller] == name || (params[:controller] == "payments" && name == "links")
    "active" if condition
  end
end
