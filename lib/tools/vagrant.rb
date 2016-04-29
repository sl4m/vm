module Tools
  class Vagrant
    def initialize(configurator, linux_version)
      @configurator  = configurator
      @linux_version = linux_version
    end

    def add_command(box_name)
      "vagrant box add #{box_name} #{linux_version}-#{configurator.vagrant}.box"
    end

    def destroy_command
      'vagrant destroy'
    end

    def down_command
      'vagrant halt'
    end

    def reload_command
      'vagrant reload'
    end

    def remove_command(box_name)
      "vagrant box remove #{box_name} --provider=#{configurator.vagrant_box}"
    end

    def status_command
      "vagrant status | grep #{configurator.vagrant_provider} | grep -v 'not created'"
    end

    def up_command
      "vagrant up --provider=#{configurator.vagrant_provider}"
    end

    def up_with_provision_command
      "#{up_command} --provision"
    end

    private

    attr_reader :configurator, :linux_version
  end
end
