module Tools
  class Packer
    def initialize(configurator)
      @configurator = configurator
    end

    def build_command
      "packer build --force=true --only=#{configurator.packer} -var 'ssh_public_key=#{configurator.ssh_public_key}' packer/template.json"
    end

    private

    attr_reader :configurator
  end
end
