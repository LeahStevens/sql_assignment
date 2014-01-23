require 'optparse'

class ParseArguments
  def self.parse
    options = { environment: "production" }
    OptionParser.new do |opts|
      opts.banner = "Usage: exportsImports [command] [options]"

      opts.on("--year [YEAR]", "The year") do |year|
        options[:year] = year
      end

      opts.on("--month [MONTH]", "The month") do |month|
        options[:month] = month
      end

      opts.on("--type [TYPE]", "The type") do |type|
        options[:type] = type
      end

      opts.on("--amount [AMOUNT]", "The amount") do |amount|
        options[:amount] = amount
      end

      opts.on("--environment [ENV]", "The database environment") do |env|
        options[:environment] = env
      end
    end.parse!
    options
  end

  def self.validate options
    errors = []
    if options[:name].nil? or options[:name].empty?
      errors << "You must provide the name of the country you are adding.\n"
    end

    missing_things = []
    missing_things << "year" unless options[:year]
    missing_things << "month" unless options[:month]
    missing_things << "type" unless options[:type]
    missing_things << "amount" unless options[:amount]
    unless missing_things.empty?
      errors << "You must provide the #{missing_things.join(" and ")} of the country you are adding.\n"
    end
    errors
  end
end