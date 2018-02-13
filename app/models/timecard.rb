class Timecard < ApplicationRecord
  include ActiveModel::Validations

  # There's no easy rails way to split up dates & times in form fields, so the web forms are wired to
  # virtual attributes, and those values get parsed and combined for the actual database entries in a
  # before_validation callback. Clock out date is calculated based on the clock in date and common sense. 
  # Read values for these fields (so the form default values reflect database values) have custom methods.
  attribute :field_clock_in_date, :string, default: Time.zone.now.strftime("%Y-%m-%d") 
  attribute :field_clock_in_time, :datetime   
  attribute :field_clock_out_time, :datetime 
  
  # Relationships:
  belongs_to :user
  
  # Validations
  validates :description, presence: true, length: {maximum: 1000}
  validates :clock_in, presence: true 
  validates :clock_out, presence: true
  validates :user, presence: true
  validates_with TimecardValidator #Defined in concerns/timecard_validator.rb

  # Callbacks

  # Custom attributes:

  # This is a workaround until I can get activerecord to realize that these params are datetimes
  def params_to_datetime(params)
     DateTime.new(params[1],
                  params[2],
                  params[3],
                  params[4],
                  params[5],
                  0)
  end
  # Custom setters:
  def field_clock_in_date=(value)
    new = Time.zone.parse(super(value))
    self.clock_in = self.clock_in.change(year: new.year, month: new.month, day: new.day)
  end

  def field_clock_in_time=(value)
    new = params_to_datetime(super(value))
    self.clock_in = self.clock_in.change(hour: new.hour, min: new.minute)
  end

  def field_clock_out_time=(value)
    new = params_to_datetime(super(value))
    self.clock_out = self.clock_out.change(hour: new.hour, min: new.minute)
  end

  # Custom getters: 

  def field_clock_in_date
     self.clock_in ? self.clock_in.strftime("%Y-%m-%d") : super
  end

  def field_clock_in_time
    self.clock_in ? self.clock_in : super
  end

  def field_clock_out_time
    self.clock_out ? self.clock_out : super
  end

  # Length of workday 
  def duration
    self.clock_out - self.clock_in  
  end
  
  # Length of workday, in hours rounded to the nearest decimal place.
  def duration_hours(l=2)
   ( self.duration / 1.hour ).round(l)
  end
    
  # Allows viewing of deactivated users' timecards.
  def user
    User.unscoped{ super }
  end

end

