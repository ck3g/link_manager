require "spec_helper"

shared_examples "don't finds anything" do
  it "" do
    VCR.use_cassette "find_domains" do
      DomainsFinder.new(page, domains).find.should == { page: page, domains: [] }
    end
  end
end

shared_examples "finds the domains" do
  it "" do
    VCR.use_cassette "find_domains" do
      finder = DomainsFinder.new(page, domains)
      finder.find.should == {
        page: finder.page,
        domains: ["weblog.rubyonrails.org", "www.37signals.com"]
      }
    end
  end
end

describe DomainsFinder do
  describe ".find" do
    context "when page is valid" do
      let(:page) { "http://rubyonrails.org/" }

      context "when domain present" do
        context "when domains are on the page" do
          let(:domains) do
            ["weblog.rubyonrails.org", "www.37signals.com", "my-domain.com"]
          end

          it_behaves_like "finds the domains"

          context "when page without protocol" do
            let(:page) { "rubyonrails.org" }
            it_behaves_like "finds the domains"
          end
        end

        context "when domains aren't on the page" do
          let(:domains) { ["unexistend-domain.coma"] }
          it_behaves_like "don't finds anything"
        end
      end

      context "when domains is empty" do
        let(:domains) { [] }
        it_behaves_like "don't finds anything"
      end
    end
  end

  describe "#page" do
    context "when pass http://google.com" do
      it { DomainsFinder.new("http://google.com", []).page.should == "http://google.com" }
    end

    context "when pass https://google.com" do
      it { DomainsFinder.new("https://google.com", []).page.should == "https://google.com" }
    end

    context "when pass google.com" do
      it { DomainsFinder.new("google.com", []).page.should == "http://google.com" }
    end

  end
end
