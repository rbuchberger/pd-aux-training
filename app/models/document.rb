class Document < ApplicationRecord
  ALLOWED_FILE_TYPES =
    [
      # PDF
      %r{\Aapplication/pdf},

      # Text Files
      %r{\Atext/plain},

      # Images
      %r{\Aimage/jpeg},
      %r{\Aimage/png},

      # Word Documents
      %r{\Aapplication/msword},
      %r{\Aapplication/vnd.openxmlformats-officedocument.wordprocessingml.document},

      # Excel files
      %r{\Aapplication/vnd.ms-excel},
      %r{\Aapplication/vnd.openxmlformats-officedocument.spreadsheetml.sheet},

      # Powerpoint presentations
      %r{\Aapplication/vnd.ms-powerpoint},
      %r{\Aapplication/vnd.openxmlformats-officedocument.presentationml.presentation}
    ].freeze

    MAXIMUM_FILE_SIZE = 100.megabytes

  validates :name, length: { maximum: 1000 }
  validates :description, length: { maximum: 50_000 }

  before_save :set_name

  def s3_credentials
    {
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_KEY"],
      bucket: ENV["AWS_BUCKET"]
    }
  end

  # If the custom name field is blank, use the filename.
  def set_name
    # self.name = file_file_name if name.blank?
  end
end
