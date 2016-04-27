require 'erb'

class GitConfigurator
  def initialize
  end

  def execute
    create_git_config_file unless git_configured?
  end

  private

  def git_configured?
    File.exists?(git_config_file)
  end

  def create_git_config_file
    puts 'Creating .gitconfig file for the virtual machine'
    print 'Please enter your full name: '
    @full_name = STDIN.gets.strip
    print 'Please enter your email: '
    @email = STDIN.gets.strip
    print 'Please enter your GitHub username: '
    @username = STDIN.gets.strip
    template_contents = File.open(git_config_template).read
    git_config_contents = ERB.new(template_contents).result(binding)
    FileUtils.mkpath(git_config_dir)
    File.open(git_config_file, 'w') {|f| f.write(git_config_contents)}
  end

  def git_cookbook
    File.expand_path(File.join('..', '..', 'cookbooks', 'default', 'git'), __FILE__)
  end

  def git_config_dir
    File.join(git_cookbook, 'files', 'default')
  end

  def git_config_file
    File.join(git_config_dir, '.gitconfig')
  end

  def git_config_template
    File.join(git_cookbook, 'templates', 'default', '.gitconfig.erb')
  end
end
