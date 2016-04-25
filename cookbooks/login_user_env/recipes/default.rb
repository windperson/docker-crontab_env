template "/home/#{node[:login_user_env][:user_name]}/server_env" do
    source "server_env.erb"
    owner "#{node[:login_user_env][:user_name]}"
    group "#{node[:login_user_env][:user_name]}"
    mode "0644"
    variables({ 
        :env_hash => node[:login_user_env][:env_list] 
        })
    action :create
end

ruby_block "include-bashrc-user" do
  block do
    file = Chef::Util::FileEdit.new("/home/#{node[:login_user_env][:user_name]}/.bashrc")
    file.insert_line_if_no_match(
      "# Include user specific settings",
      "\n# Include user specific settings\nif [ -f ~/server_env ]; then . ~/server_env; fi"
    )
    file.write_file
  end
end