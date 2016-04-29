module Tools
  class Packer
    def initialize(configurator, linux_version)
      @configurator  = configurator
      @linux_version = linux_version
    end

    def build_command
      "packer build --force=true --only=#{configurator.packer} -var-file=#{var_file} -var #{var_hostname} -var #{var_ssh_public_key} packer/template.json"
    end

    private

    attr_reader :configurator, :linux_version

    def var_hostname
      "'hostname=#{configurator.hostname}'"
    end

    def var_ssh_public_key
      "'ssh_public_key=#{configurator.ssh_public_key}'"
    end

    def var_file
      "packer/linux_versions/#{linux_version}.json"
    end
  end
end
