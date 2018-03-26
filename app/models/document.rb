class Document < ApplicationRecord
  # This is used for both newsletters and the document library. 

  # Associations:

  # These are the parameters required by the paperclip gem. 
  has_attached_file :file,          # Name of the attachment. Could be more original I suppose
    storage: :s3,                   # Uses AWS s3 for storage
    s3_credentials: s3_credentials, # Defined below.
    s3_permissions: :private,       # Files uploaded will be accessible only with this access ID & key
    s3_region: 'us-east-2',         # Paperclip needs to know which region the bucket is kept in.
    s3_protocol: 'https'            # Use HTTPS to upload files

  # Validations:
  validates :file, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :file

  validates_with AttachmentPresenceValidator
  validates_with AttachmentContentTypeValidator
  validates_with AttachmentSizeValidator, attributes: :file, less_than: 100.megabytes

  # Callbacks:

  # Scopes:

  # Custom Methods:
  private

  def s3_credentials
    {
      bucket:  Rails.application.secrets.aws_bucket, 
      access_key_id: Rails.application.secrets.aws_acces_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_key 
    }
  end

end
