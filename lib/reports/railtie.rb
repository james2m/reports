require 'reports'
require 'rails'

module Reports

  class Railtie < Rails::Railtie

    initializer "reports.load", :after => "action_dispatch.configure" do |app|
      if ActionDispatch::Reloader.respond_to?(:to_prepare)
        ActionDispatch::Reloader.to_prepare { Reports.reload }
      else
        ActionDispatch::Reloader.before { Reports.reload }
      end
    end

  end

end