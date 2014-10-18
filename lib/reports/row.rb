module Reports

  class Row

    def initialize(row)
      @row = row
    end

    def to_columns
      @columns ||= columns.map { |column| send(column) }
    end

    def columns
      raise NotImplementedError
    end

  end

end