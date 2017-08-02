case node['platform_family']
  when 'debian'
    execute 'apt-get update -y'
  when 'rhel'
    execute 'yum update -y'
  else
    puts "platform not supported"
end
