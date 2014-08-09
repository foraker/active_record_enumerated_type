module EnumeratedType
  def serialize
    name
  end

  def human
    I18n.translate!(name, scope: [:enumerated_type, :status])
  rescue I18n::MissingTranslationData
    to_s.titleize
  end
end