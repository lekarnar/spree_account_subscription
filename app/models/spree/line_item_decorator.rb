Spree::LineItem.class_eval do
  validates_numericality_of :quantity, less_than_or_equal_to: 1, if: :subscribable?

  delegate :subscribable?, to: :variant

  scope :subscribable, -> { joins(:variant).merge(Spree::Variant.subscribable) }
  scope :unsubscribable, -> { joins(:variant).merge(Spree::Variant.unsubscribable) }
end
