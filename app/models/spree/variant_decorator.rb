Spree::Variant.class_eval do
  delegate :subscribable?, to: :product

  scope :subscribable, -> { joins(:product).merge(Spree::Product.subscribable) }
  scope :unsubscribable, -> { joins(:product).merge(Spree::Product.unsubscribable) }
end
