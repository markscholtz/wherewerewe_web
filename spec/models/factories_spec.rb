require 'spec_helper'

describe Factory do
  FactoryGirl.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      subject { FactoryGirl.build(factory.name) }

      it "is valid" do
        expect(subject).to be_valid, "#{subject.class}: #{subject.errors.full_messages}"
      end
    end
  end
end
