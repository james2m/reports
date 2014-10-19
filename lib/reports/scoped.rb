module Reports
  class Scoped < Base

    def initialize(options = {})
      @scopes = Array(options['scopes'])
      super
    end

    private

    def base_relation
      @base_relation ||= base_class
    end

    def scoped_rows
      @scoped_rows ||= @scopes.inject(base_relation) do |relation, scope|
        relation.send(*scope)
      end
    end

    def rows
      @rows ||= scoped_rows.map { |row| new_row(row) }
    end

  end
  # Scoped
end
# Reports
