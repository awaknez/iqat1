
class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true
  validates :title, presence: true
  validates :agree_to_privacy_policy, acceptance: true
end

