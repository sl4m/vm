class LinuxChooser
  def initialize(linux_version_path)
    @linux_version_path = linux_version_path
  end

  def execute
    puts "Which Linux version do you want to install?"
    display_linux_versions_options
    user_choice = nil
    begin
      user_choice = STDIN.gets.strip
    end while invalid_choice?(user_choice)
    linux_versions_options[user_choice.to_i]
  end

  private

  attr_reader :linux_version_path

  def display_linux_versions_options
    linux_versions_options.each do |option, linux_version|
      puts "#{option}. #{linux_version}"
    end
  end

  def linux_versions_options
    @linux_versions_options ||= (
      linux_versions.each_with_index.reduce({}) do |memo, (linux_version, option)|
        memo[option + 1] = linux_version
        memo
      end
    )
  end

  def linux_versions
    @linux_versions ||= (
      Dir.glob("#{linux_version_path}/*.json").map do |file|
        File.basename(file, '.*')
      end
    )
  end

  def invalid_choice?(user_choice)
    linux_versions_options[Integer(user_choice)].to_s.strip == ''
  rescue ArgumentError
    true
  end
end
