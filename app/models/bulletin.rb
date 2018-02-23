class Bulletin < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :title, presence: true, length: {maximum: 50}
  validates :body, presence: true

  # Callbacks
  after_commit :clear_cache

  # Default Scope
  default_scope { order(updated_at: :desc) }

  
  # Cached list of bulletins for the front page
  def self.all_cached
    Rails.cache.fetch('bulletins') {Bulletin.includes(:user).last(30)}
  end

  private

  def clear_cache
    Rails.cache.delete('bulletins')
  end

end
