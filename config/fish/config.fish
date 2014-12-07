if status --is-interactive
  set EDITOR /usr/local/bin/vim

  #set PYTHONPATH $PYTHONPATH /usr/local/lib/python2.7/site-packages
  #set NODE_BIN /usr/local/share/npm/bin
  #set MYSQL_BIN /usr/local/mysql/bin

  # Google Cloud SDK installation directory.
  set GOOGLE_CLOUD_SDK $HOME/google-cloud-sdk

  # Google Go installation directory.
  # The location where go is built is not the same as where it is installed.
  # Since $GOROOT is compiled into the binary, we need a way to override it in
  # the shell. According to the documentation, setting $GOROOT_FINAL does this
  # for us. -x to export.
  set -x GOROOT /usr/local/bhojo/go
  set -x GOPATH /usr/local/bhojo/golib

  # Disabled.
  # Mac OS X - Homebrew installs here.
  # set PATH /usr/local/opt/go/libexec/bin $PATH

  # Google Dart installation directory.
  set DART_SDK $HOME/dart-sdk

  set LOCAL_VAR_BIN $HOME/var/bin
  
  # Now set the correct PATH environment variable.
  set PATH /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /sbin /bin $PATH
  # set PATH $MYSQL_BIN $NODE_BIN $PATH
  set PATH $DART_SDK/bin $GOPATH/bin $GOROOT/bin $GOOGLE_CLOUD_SDK/bin $PATH
  set PATH $LOCAL_VAR_BIN $PATH
end
