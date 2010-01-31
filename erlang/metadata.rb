maintainer       "Trengine"
maintainer_email "bbrowning@trengine.com"
license          "Apache 2.0"
description      "Installs/Configures erlang"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

%w{ ubuntu debian }.each do |os|
  supports os
end

%w{ build-essential }.each do |cb|
  depends cb
end
