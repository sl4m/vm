shared_dir = '/vagrant'
user = 'vagrant'
home = "/home/#{user}"

ENV['HOME'] = home
ENV['USER'] = user
ENV['DISPLAY'] = ':99.0'
