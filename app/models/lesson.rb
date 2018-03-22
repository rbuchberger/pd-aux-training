class Lesson < ApplicationRecord
  # Master class, defines one training requirement. Various resources can belong
  # to it. 

  # Associations:
  has_many :completions, dependent: :destroy
  has_many :users, through: :completions
  has_one :video, dependent: :destroy, autosave: true, inverse_of: :lesson 
  accepts_nested_attributes_for :video

  # Validations:
  validates :title, presence: true, length: {maximum: 50}
  validates :description, length: {maximum: 1000}

  # Scopes:
  default_scope {order( :title )} 

end
