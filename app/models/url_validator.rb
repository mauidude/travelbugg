class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^(?:(?:https?)\:\/\/|www\.)(?:\([-A-Z0-9\+\&\@\#\/\%\=\~\_\|\$\?\!\:\,\.]*\)|[-A-Z0-9\+\&\@\#\/\%\=\~\_\|\$\?\!\:\,\.])*(?:\([-A-Z0-9\+\&\@\#\/\%\=\~\_\|\$\?\!\:\,\.]*\)|[A-Z0-9\+\&\@\#\/\%\=\~\_\|\$])$/i
      record.errors[attribute] << (options[:message] || "is not a URL")
    end
  end
end