if status --is-interactive
  set EDITOR /usr/local/bin/vim

  set PYTHONPATH $PYTHONPATH /usr/local/lib/python2.7/site-packages
  set NODE_BIN /usr/local/share/npm/bin
  set MYSQL_BIN /usr/local/mysql/bin

  set GOOGLE_CLOUD_SDK $HOME/google-cloud-sdk
  set GOROOT /usr/local/bhojo-go
  set GOBIN $GOROOT/bin

  # Mac OS X - Homebrew installs here.
  # set PATH /usr/local/opt/go/libexec/bin $PATH
  set LOCAL_VAR_BIN $HOME/var/bin

  set PATH /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /sbin /bin $PATH
  set PATH $LOCAL_VAR_BIN $GOBIN $GOOGLE_CLOUD_SDK/bin $MYSQL_BIN $NODE_BIN $PATH
end
