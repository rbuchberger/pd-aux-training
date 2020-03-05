module ApplicationHelper
  # Hash of bootstrap message types vs rails message types.
  BOOTSTRAP_FLASH_MSG = {
    success: 'success',
    error: 'warning',
    alert: 'danger',
    notice: 'info'
  }.freeze

  # Converts rails flash messages to names that bootstrap expects, for proper styling
  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym, flash_type)
  end

  # Instantiates redcarpet to render markdown
  def markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
  end

  # Validation fails
  def validation_fails(record)
    if record.errors.any?
      render partial: 'application/validation_fails.html.erb', locals: { record: record }
    end
  end
end
