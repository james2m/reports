require 'reports'
require 'rails'

module Reports

  class Railtie < Rails::Railtie

    initializer "reports.load", :after => "action_dispatch.configure" do |app|
      reloader = rails5? ? ActiveSupport::Reloader : ActionDispatch::Reloader
      if reloader.respond_to?(:to_prepare)
        reloader.to_prepare { Reports.reload }
      elsif reloader.respond_to?(:before)
        reloader.before { Reports.reload }
      end
    end

    private

    def rails5?
      ActionPack::VERSION::MAJOR == 5
    end
  end
end