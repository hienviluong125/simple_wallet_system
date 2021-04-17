class Transaction < ApplicationRecord
  belongs_to :user
  STATUSES = %w(pending handled cancelled)
  TYPES = %w(deposit withdraw)

  scope :with_status, ->(status){ where(status: status) }
  scope :with_type, ->(type){ where(transaction_type: type) }

  validates :status, inclusion: { in: STATUSES }
  validates :transaction_type, inclusion: { in: TYPES }
  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :user, presence: true

  before_create :generate_uid

  private

  def generate_uid
    self.uid = SecureRandom.uuid
  end
end
