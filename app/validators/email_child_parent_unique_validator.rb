class EmailChildParentUniqueValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    other_model_class = object.class == Parent ? Child : Parent
    other_emails = other_model_class.all.map { |user| user.email }
    if other_emails.include?(value)
      object.errors[attribute] << (options[:message] || "is already taken") 
    end
  end
end