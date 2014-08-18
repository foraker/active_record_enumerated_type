module EnumeratedType
  def serialize
    name
  end

  def human
    I18n.translate!(name, scope: [:enumerated_type, :status])
  rescue I18n::MissingTranslationData
    to_s.titleize
  end

  module ClassMethods
    def deserialize(value)
      self[value.to_sym]
    end
  end
end