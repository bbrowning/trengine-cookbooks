maintainer       "Trengine"
maintainer_email "bbrowning@trengine.com"
license          "Apache 2.0"
description      "Installs/Configures riak"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

%w{ build-essential erlang runit }.each do |cb|
  depends cb
end
