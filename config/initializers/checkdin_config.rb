class CheckdinConfig
	def self.[](key)
		config[key] or raise ArgumentError.new("No CheckdinConfig[#{key}] setting found")
	end

	def self.reload!
		@config = nil
	end

	private

	def self.config
		@config ||= begin
			raw_config = File.read("#{Rails.root}/config/checkdin_config.yml")
			YAML.load(raw_config)[Rails.env] or raise "No configuration found for environment #{Rails.env}"
		end
	end
end