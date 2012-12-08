module LinksHelper
  def link_row_class(link)
    if link[:error].present?
      "error"
    elsif link[:domains].present?
      "success"
    else
      "warning"
    end
  end
end
