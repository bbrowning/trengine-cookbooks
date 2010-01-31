set_unless[:riak][:version]      = "0.7.1"
set_unless[:riak][:install_path] = "/opt/riak-#{riak[:version]}"
set_unless[:riak][:src_binary]   = "#{riak[:install_path]}/bin/riak"
