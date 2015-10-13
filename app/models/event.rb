class Event < ActiveRecord::Base
  belongs_to :group
  has_many :attendances
  has_many :users, through: :attendances

  after_create :create_attendances

  def create_attendances
    self.group.nonadmins.each do |user|
      user.attendances.create(event_id: self.id, required: self.required?)
    end
  end

end
