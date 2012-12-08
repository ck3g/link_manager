require 'open-uri'

class DomainsFinder
  attr_reader :page, :domains

  def initialize(page, domains)
    @page = page =~ /(http|https):\/\// ? page : "http://#{page}"
    @domains = domains
  end

  def find
    finding = { page: page, domains: [] }

    if domains.present?
      begin
        content = open(page).read
      rescue
        finding[:error] = I18n.t(:invalid_url)
        return finding
      end

      domains.each do |domain|
        finding[:domains] << domain if content =~ %r{#{domain}}i
      end
    end

    finding
  end
end
