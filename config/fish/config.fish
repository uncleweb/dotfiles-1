if status --is-interactive 
  set PYTHONPATH $PYTHONPATH /usr/local/lib/python2.7/site-packages
  set GOROOT /usr/local/go
  set GOBIN /usr/local/go/bin
  set NODE_BIN /usr/local/share/npm/bin
  set MYSQL_BIN /usr/local/mysql/bin
  set EDITOR /usr/local/bin/vim
  set PATH $GOBIN $MYSQL_BIN $NODE_BIN /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /sbin /bin $PATH
end

