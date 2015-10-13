class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  belongs_to :admin, class_name: "User"

  before_save :set_default_value

  def set_default_value
    if !self.status
      self.status = 0
    end
  end

  def due_date
    self.assignment.due_date.strftime("%a, %m/%d/%y")
  end

  def submit_date
    self.created_at
  end

  def status_english
    case self.status
    when 0
      "Missing"
    when 1
      "Incomplete"
    when 2
      "Complete"
    end
  end
end
