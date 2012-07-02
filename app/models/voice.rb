class Voice < ActiveRecord::Base
  belongs_to :user
  belongs_to :commit

  validates_presence_of :comment
  validates_presence_of :tone

  after_save :notify_submitter

  def notify_submitter
    return if Rails.env.test? || user == commit.user
    MrMcFeely.speedy_delivery(self).deliver
  end

  def self.tones
    ["comment", "concern", "approval"]
  end
end
