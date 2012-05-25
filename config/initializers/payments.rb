#require 'payments_pl/rails'
PaymentsPl.init(File.join(Rails.root, 'config', 'payments.yml'))
ActionView::Base.send(:include, PaymentsPl::ViewHelpers)
