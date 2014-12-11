class BoxConfigurator
  DEFAULT_SSH_PUBLIC_KEY = 'packer/keys/vm.pub'

  def initialize(provider, ssh_public_key=nil)
    @provider       = provider
    @ssh_public_key = ssh_public_key
  end

  def packer
    options[:packer]
  end

  def vagrant
    options[:vagrant]
  end

  def vagrant_box
    options[:vagrant_box]
  end

  def vagrant_provider
    options[:vagrant_provider]
  end

  def ssh_public_key
    @ssh_public_key || default_ssh_public_key
  end

  private

  attr_reader :provider

  def options
    @options ||= (
      case provider
      when :virtualbox
        {
          packer:           'virtualbox-iso',
          vagrant:          'virtualbox',
          vagrant_box:      'virtualbox',
          vagrant_provider: 'virtualbox'
        }
      when :vmware
        {
          packer:           'vmware-iso',
          vagrant:          'vmware',
          vagrant_box:      'vmware_desktop',
          vagrant_provider: 'vmware_fusion'
        }
      end
    )
  end

  def default_ssh_public_key
    File.read(DEFAULT_SSH_PUBLIC_KEY).strip
  end
end
