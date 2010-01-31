set_unless[:erlang][:version]      = "R13B03"
set_unless[:erlang][:install_path] = "/opt/erlang-#{erlang[:version]}"
set_unless[:erlang][:src_binary]   = "#{erlang[:install_path]}/bin/erl"

set_unless[:erlang][:configure_flags] =
  [
   "--prefix=#{erlang[:install_path]}"
  ]
