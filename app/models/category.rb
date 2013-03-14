class Category < ActiveRecord::Base
  attr_accessible :name,
                  :display

  has_many :deals

  validates :name,
            presence: true,
            length: { maximum: 25 },
            uniqueness: { case_sensitive: false }


  default_scope where(display: true).order(:name)

  def to_param
    name.to_param.downcase.parameterize
  end

  def self.from_param(param)
    Category.where("lower(name) = ?", param.downcase).first!
  end
end
