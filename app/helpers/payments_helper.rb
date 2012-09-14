module PaymentsHelper
  def to_datepicker(datetime)
    datetime.to_date.to_formatted_s(:default_ru) unless datetime.blank?
  end

  def collection_of_months
    [[1, t(:for_1_month)], [3, t(:for_3_months)], [6, t(:for_6_months)], [12, t(:for_12_months)]]
  end
end
