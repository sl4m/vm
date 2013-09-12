module Tools
  class Vagrant
    def initialize(configurator)
      @configurator = configurator
    end

    def add_command(box_name)
      "vagrant box add #{box_name} #{box_name}-#{configurator.vagrant}.box"
    end

    def destroy_command
      "vagrant destroy"
    end

    def down_command
      "vagrant halt"
    end

    def remove_command(box_name)
      "vagrant box remove #{box_name} #{configurator.vagrant_box}"
    end

    def status_command
      "vagrant status | grep #{configurator.vagrant_provider}"
    end

    def up_command
      "vagrant up #{provider_flag}"
    end

    def up_with_provision_command
      "#{up_command} --provision"
    end

    private

    def provider_flag
      "--provider=#{configurator.vagrant_provider}"
    end

    attr_reader :configurator
  end
end
