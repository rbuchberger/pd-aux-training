require 'test_helper'

class TrainingRecordTest < ActiveSupport::TestCase
  
  # Shouldn't save without a user
  test "save without user" do
    t = TrainingRecord.new(valid_training_record_params)
    t.user_id = ""
    assert_not t.save
  end
  
  # Shouldn't save without a requirement
  test "save without requirement" do
    t = TrainingRecord.new(valid_training_record_params)
    t.training_requirement_id = ""
    
    assert_not t.save
  end
  
  # Should be deleted when associated requirement is deleted
  test "delete with requirement" do
    requirement = training_requirements(:one)
    user = users(:admin)
    user.training_records.create({
      training_requirement_id: requirement.id
    })
    
    t = TrainingRecord.count 
    requirement.destroy
    assert t > TrainingRecord.count
    
  end
  
  # Should be deleted when associated user is deleted
  test "delete with user" do
    requirement = training_requirements(:one)
    user = users(:admin)
    user.training_records.create({
      training_requirement_id: requirement.id
    })
    
    t = TrainingRecord.count 
    user.destroy
    assert t > TrainingRecord.count
    
  end
end
