require 'test_helper'

describe Reports::Base do

  before do
  end

  describe "new" do

    describe "type" do

      let(:user) { nil }
      subject { SimpleReport.new }

      it "assign the type to the report" do
        subject.type.must_equal 'simple'
      end

    end

  end

end
