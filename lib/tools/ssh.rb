class SshKeyGenerator
  def initialize(ssh_key_path)
    @ssh_key_path = ssh_key_path
  end

  def execute
    `mkdir -p #{ssh_key_path}/`
    `ssh-keygen -t rsa -b 4096 -C "vm public key" -N '' -f #{ssh_key_path}/vm`
  end

  private

  attr_reader :ssh_key_path
end
