class Document < ApplicationRecord
  MAXIMUM_FILE_SIZE = 100.megabytes
  has_one_attached :file

  before_save :set_name

  validates :name, length: { maximum: 1000 }
  validates :description, length: { maximum: 50_000 }
  validates :file, presence: true
  validate :acceptable_file_size

  def ext
    file.filename.extension
  end

  private

  # If the custom name field is blank, use the filename.
  def set_name
    self.name = file.filename if name.blank?
  end

  def acceptable_file_size
    return unless file.attached? && file.byte_size > MAXIMUM_FILE_SIZE

    errors.add(:file, 'cannot be larger than 100 megabytes.')
  end
end
