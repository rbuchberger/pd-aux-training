class Timecard < ApplicationRecord
  include ActiveModel::Validations

  # Use custom attributes to split datetimes into dates and times
  attr_writer :field_clock_in_date, :field_clock_in_time, :field_clock_out_date, :field_clock_out_time
  
  # Relationships:
  belongs_to :user
  
  # Validations
  validates :description, presence: true, length: {maximum: 250}
  validates :clock_in, presence: true 
  validates :clock_out, presence: true
  validates :user, presence: true
  validates_with TimecardValidator #Defined in concerns/timecard_validator.rb

  # Callbacks
  before_validation :combine_fields

  def combine_fields
    puts "Field clock in date and time: "
    puts @field_clock_in_date
    puts @field_clock_in_time
    self.clock_in = Time.zone.parse("#{@field_clock_in_date} #{@field_clock_in_time[4]}:#{@field_clock_in_time[5]}") 
    self.clock_out = Time.zone.parse("#{@field_clock_in_date} #{@field_clock_out_time[4]}:#{@field_clock_out_time[5]}") 
    self.clock_out += 1.day if self.clock_in > self.clock_out
    puts "results: "
    puts self.clock_in
    puts self.clock_out
  end

  # Custom attributes:

  def field_clock_in_date
    self.clock_in ? self.clock_in.strftime("%Y-%m-%d") : Time.zone.now.strftime("%Y-%m-%d")
  end

  def field_clock_in_time
    # TODO: make these round to the nearest 15 minutes. 
    self.clock_in ? self.clock_in : Time.zone.now
  end

  def field_clock_out_date
    self.clock_out ? self.clock_out.strftime("%Y-%m-%d") : Time.zone.now.strftime("%Y-%m-%d")
  end

  def field_clock_out_time
    self.clock_out ? self.clock_out : Time.zone.now
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

