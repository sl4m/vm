apt_package 'python-software-properties'

bash 'sudo apt-get update' do
  code 'sudo apt-get update'
end

class ::Helper
  def self.home(path='')
    File.join("/home/#{user}", path)
  end

  def self.user
    'vagrant'
  end

  def self.display
    ':99.0'
  end

  def self.apt_key(trusted_key_url)
    <<-EOH
    wget --quiet -O - '#{trusted_key_url}' | sudo apt-key add -
    sudo apt-get update
    EOH
  end
end

ENV['HOME'] = Helper.home

class ::Chef
  class Resource
    class UserBash < Bash
      def initialize(name, run_context=nil)
        super(name, run_context)
	      user(Helper.user)
      end
    end

    class UserFile < File
      def initialize(name, run_context=nil)
        super(name, run_context)
        owner(Helper.user)
      end
    end

    class HomeFile < UserFile
      def initialize(name, run_context=nil)
        super(Helper.home(name), run_context)
      end
    end

    class UserRemoteFile < RemoteFile
      def initialize(name, run_context=nil)
        super(name, run_context)
        owner(Helper.user)
      end
    end

    class UserCookbookFile < CookbookFile
      def initialize(name, run_context=nil)
        super(Helper.home(name), run_context)
        owner(Helper.user)
      end
    end

    class UserTemplate < Template
      def initialize(name, run_context=nil)
        super(Helper.home(name), run_context)
        owner(Helper.user)
      end
    end

    class UserDirectory < Directory
      def initialize(name, run_context=nil)
        super(name, run_context)
        owner(Helper.user)
      end
    end

    class UserRemoteDirectory < RemoteDirectory
      def initialize(name, run_context=nil)
        super(name, run_context)
        owner(Helper.user)
      end
    end

    class HomeDirectory < UserDirectory
      def initialize(name, run_context=nil)
        super(Helper.home(name), run_context)
      end
    end

    class AptSourcesListFile < CookbookFile
      def initialize(name, run_context=nil)
        super("/etc/apt/sources.list.d/#{name}", run_context)
      end
    end

    class ZshFile < UserCookbookFile
      def initialize(name, run_context=nil)
        super(::File.join('.zsh', "#{name}.zsh"), run_context)
      end
    end

    class ZshTemplate < UserTemplate
      def initialize(name, run_context=nil)
        super(::File.join('.zsh', "#{name}.zsh"), run_context)
        owner(Helper.user)
      end
    end
  end
end

