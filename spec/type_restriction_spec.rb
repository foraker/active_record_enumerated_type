require "spec_helper"

class TestRecord
  include ActiveRecord::TypeRestriction

  module InheritedAttributes
    def status
      @status
    end

    def status=(value)
      @status = value
    end
  end
  include InheritedAttributes

  restrict_type_of :status, to: Status
end

describe TestRecord do
  describe "setting attributes" do
    let(:instance) { described_class.new }

    it "accepts a formal type" do
      instance.status = Status[:started]
      expect(instance.status).to eq Status[:started]
    end

    it "accepts a symbolic type" do
      instance.status = :started
      expect(instance.status).to eq Status[:started]
    end

    it "accepts a string type" do
      instance.status = 'started'
      expect(instance.status).to eq Status[:started]
    end

    it "allows type resetting" do
      instance.status = Status[:started]
      instance.status = Status[:finished]
      expect(instance.status).to eq Status[:finished]
    end

    it "allows nil" do
      instance.status = nil
      expect(instance.status).to be_nil
    end

    it "raises an exception when types are invalid" do
      error_message = "'pending' is not a valid type for status. Valid types include 'started' and 'finished'."

      expect {
        instance.status = :pending
      }.to raise_error(TypeError, error_message)
    end
  end
end