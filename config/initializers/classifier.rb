require 'stuff-classifier'

@storage_path = File.dirname(__FILE__) + '/../stuff_classifier.bin'

# global setting
StuffClassifier::Base.storage = StuffClassifier::FileStorage.new(@storage_path)