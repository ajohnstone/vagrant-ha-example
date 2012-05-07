
Vagrant::Config.run do |config|

  # Execute file servers first
  config.vm.define :file1 do |file1_config|
    file1_config.vm.box = "debian-squeeze-64-rvm"
    file1_config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/rosstimson-vagrant-boxes/debian-squeeze-64-rvm.box"
    file1_config.vm.host_name = "file1"
    file1_config.vm.forward_port 80, 8183
    file1_config.vm.network :hostonly, "10.20.10.5"
    file1_config.vm.provision :shell, :path => "scripts/file.sh"
  end

  config.vm.define :file2 do |file2_config|
    file2_config.vm.box = "debian-squeeze-64-rvm"
    file2_config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/rosstimson-vagrant-boxes/debian-squeeze-64-rvm.box"
    file2_config.vm.host_name = "file2"
    file2_config.vm.forward_port 80, 8184
    file2_config.vm.network :hostonly, "10.20.10.6"
    file2_config.vm.provision :shell, :path => "scripts/file.sh"
  end

  config.vm.define :web1 do |web1_config|
    web1_config.vm.box = "debian-squeeze-64-rvm"
    web1_config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/rosstimson-vagrant-boxes/debian-squeeze-64-rvm.box"
    web1_config.vm.host_name = "web1"
    web1_config.vm.forward_port 80, 8180
    web1_config.vm.network :hostonly, "10.20.10.2"
    web1_config.vm.provision :shell, :path => "scripts/lb.sh"
  end

  config.vm.define :web2 do |web2_config|
    web2_config.vm.box = "debian-squeeze-64-rvm"
    web2_config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/rosstimson-vagrant-boxes/debian-squeeze-64-rvm.box"
    web2_config.vm.host_name = "web2"
    web2_config.vm.forward_port 80, 8181
    web2_config.vm.network :hostonly, "10.20.10.3"
    web2_config.vm.provision :shell, :path => "scripts/lb.sh"
  end

  config.vm.define :failsafe do |failsafe_config|
    failsafe_config.vm.box = "debian-squeeze-64-rvm"
    failsafe_config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/rosstimson-vagrant-boxes/debian-squeeze-64-rvm.box"
    failsafe_config.vm.host_name = "failsafe"
    failsafe_config.vm.forward_port 80, 8182
    failsafe_config.vm.network :hostonly, "10.20.10.4"
    failsafe_config.vm.provision :shell, :path => "scripts/lb.sh"
  end

  config.vm.define :clean do |clean_config|
    clean_config.vm.box = "debian-squeeze-64-rvm"
    clean_config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/rosstimson-vagrant-boxes/debian-squeeze-64-rvm.box"
    clean_config.vm.host_name = "clean"
    clean_config.vm.network :hostonly, "10.20.10.8"
  end

end

