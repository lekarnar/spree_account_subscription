class Spree::AccountSubscription < ActiveRecord::Base
  ENDING_THRESHOLD = 30.days
  SUBSCRIPTION_LENGTH = 1.year

  with_options required: true do
    belongs_to :product, class_name: 'Spree::Product'
    belongs_to :user, class_name: Spree.user_class
  end

  validates :start_datetime, :end_datetime, presence: true

  before_save :set_user_by_email, if: -> { email_changed? && user_id.nil? }

  scope :ended, -> { where('end_datetime <= NOW()') }
  scope :ending, -> { where(end_datetime: Time.now.utc..(Time.now.utc + ENDING_THRESHOLD)) }
  scope :canceled, -> { where(state: :canceled) }

  state_machine :state, initial: :active do
    event :cancel do
      transition to: :canceled, unless: :canceled?
    end
  end

  def ended?
    Time.now.utc >= end_datetime
  end

  def ending?
    !ended? && Time.now.utc - ENDING_THRESHOLD >= end_datetime
  end

  def renew!
    increment(:end_datetime, SUBSCRIPTION_LENGTH)
    save!
  end

  def self.subscribe!(opts)
    opts.to_options!.assert_valid_keys(:email, :user, :product)

    find_or_initialize_by(opts.slice(:email, :user, :product)) do |s|
      s.start_datetime = Time.now.utc
      s.end_datetime = Time.now.utc
    end.renew!
  end

  private

  def set_user_by_email
    self.user = Spree::User.find_by(email: email)
  end
end
