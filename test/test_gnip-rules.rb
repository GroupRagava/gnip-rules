require 'helper'

class TestGnipRules < Test::Unit::TestCase
  context 'GnipRules::' do
    setup do
      @gnip = GnipRules::RulesConnection.new
    end

    should "allow creation of rules" do
      response = @gnip.add([GnipRules::Rule.new( '"new spyro"' )])
      assert{ response.response.class == Net::HTTPCreated }
    end

    should 'allow removal of rules' do
     response = @gnip.remove([GnipRules::Rule.new( '"new spyro"' )])
     assert{ response.response.class == Net::HTTPOK }
    end

    should 'allow creation of tagged rules' do
      response = @gnip.add([ GnipRules::Rule.new('#skylanders -skylanders -spyro', 'Skylanders')])
      assert{ response.response.class == Net::HTTPCreated }
    end

    should 'list all rules' do
      response = @gnip.list
      assert{ response.response.class == Net::HTTPOK }
    end

    should 'delete all rules' do
      response = @gnip.delete_all!
      assert{ response.response.class == Net::HTTPOK }
      assert{ @gnip.list["rules"].empty? }
    end

  end
end
