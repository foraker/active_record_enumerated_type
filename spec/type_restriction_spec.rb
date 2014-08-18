require "spec_helper"

class TestRecord
  include ActiveRecord::TypeRestriction

  def write_attribute(attribute, value)
    instance_variable_set("@#{attribute}", value)
  end

  def read_attribute(attribute)
    instance_variable_get("@#{attribute}")
  end

  def raw_status
    @status
  end

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

  describe "custom serialization" do
    let(:instance) { SerializingTestRecord.new }

    class SerializableStatus
      include EnumeratedType

      declare :started, id: 1
      declare :finished, id: 2

      def self.deserialize(value)
        detect { |type| type.id == value.to_i }
      end

      def serialize
        id
      end
    end

    class SerializingTestRecord < TestRecord
      restrict_type_of :status, to: SerializableStatus
    end

    it "serializes" do
      instance.status = SerializableStatus[:started]
      expect(instance.raw_status).to eq(1)
    end

    it "deserializes" do
      instance.status = SerializableStatus[:started]
      expect(instance.status).to eq(SerializableStatus[:started])
    end
  end
end