class Ban < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :role
  belongs_to :group
  belongs_to :banner, class_name: 'User', foreign_key: 'banner_id'

  validates :user, :banner, presence: true
  validates :reason, length: { maximum: 1024 }

  # At least one needs to be filled.
  validates :role, presence: true, unless: ->(ban){ban.group_role.present?}
  validates :group_role, presence: true, unless: ->(ban){ban.role.present?}
end
