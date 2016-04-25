OS_name=node['platform']
OS_family=node['platform_family']
OS_ver=node['platform_version'].to_f
log 'print OS info' do
  message "OS_name=#{OS_name}, OS_family=#{OS_family} ver=#{OS_ver}"
  level :info
end

IsCentOS7orAbove = ( %w{centos}.include?(OS_name) and %w{rhel}.include?(OS_family) and 7 <= OS_ver )
IsCentOS6 = ( %w{centos}.include?(OS_name) and  %w{rhel}.include?(OS_family) and 7 > OS_ver )
IsUbuntu = ( %w{ubuntu}.include?(OS_name) and %w{debian}.include?(OS_family) )

if IsCentOS7orAbove
  bash 'set_time_zone' do
  	code "timedatectl set-timezone #{node[:set_time_zone][:timezone]}"
  end
end
