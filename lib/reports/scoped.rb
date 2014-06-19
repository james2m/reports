module Reports
  class Scoped < Base

    def initialize(options = {})
      @scopes = Array(options['scopes'])
      super
    end

    private

    def base_relation
      @base_relation ||= type.classify.constantize
    end

    def rows
      @rows ||= @scopes.inject(base_relation) do |relation, scope|
        relation.send(*scope)
      end
    end

  end
  # Scoped
end
# Reports
