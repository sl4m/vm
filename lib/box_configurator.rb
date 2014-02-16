class BoxConfigurator
  attr_reader :packer, :vagrant, :vagrant_box, :vagrant_provider

  def initialize(provider)
    setup_provider(provider)
  end

  private

  def setup_provider(provider)
    case provider
    when :virtualbox
      @packer           = 'virtualbox-iso'
      @vagrant          = 'virtualbox'
      @vagrant_box      = 'virtualbox'
      @vagrant_provider = 'virtualbox'
    when :vmware
      @packer           = 'vmware-iso'
      @vagrant          = 'vmware'
      @vagrant_box      = 'vmware_desktop'
      @vagrant_provider = 'vmware_fusion'
    end
  end
end
