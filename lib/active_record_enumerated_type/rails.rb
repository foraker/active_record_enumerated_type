if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send(:include, ActiveRecord::TypeRestriction)
end