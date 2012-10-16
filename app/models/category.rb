class Category < ActiveRecord::Base
  attr_accessible :name,
                  :display

  validates :name,
            :presence => true,
            :length => { :maximum => 25 },
            :uniqueness => { :case_sensitive =>  false }

  def to_param
    name.to_param
  end

  def self.from_param!(param)
    Category.where("lower(name) = ?", param.downcase).first!
  end
end
