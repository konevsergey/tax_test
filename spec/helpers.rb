module Helpers
  # extend with module that holds class methods
  def self.included(base)
    base.extend ClassMethods
    base.include ClassMethods
  end

  module ClassMethods
    def data_from_file(name)
      JSON.parse(read_file(name))
    end

    def export_to(value, file_name)
      File.write("export/#{file_name}", value)
    end

    private

    # read data for spec examples from file
    def read_file(name)
      File.read("#{File.dirname(__FILE__)}/support/#{name}.json")
    end
  end
end
