module ActiveRecord
  module TypeRestriction
    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def restrict_type_of(attribute, options)
        type_class = options.fetch(:to)

        define_method(attribute) do
          read_attribute(attribute) && type_class.deserialize(read_attribute(attribute))
        end

        define_method(:"#{attribute}=") do |value|
          begin
            write_attribute(attribute, value.presence && type_class.coerce(value).serialize)
          rescue ArgumentError
            valid_types = type_class.map { |type| "'#{type}'" }.to_sentence
            raise TypeError, "'#{value}' is not a valid type for #{attribute}. Valid types include #{valid_types}."
          end
        end
      end
    end
  end
end