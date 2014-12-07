if status --is-interactive
  set EDITOR /usr/local/bin/vim

  # Google Cloud SDK installation directory.
  set GOOGLE_CLOUD_SDK $HOME/google-cloud-sdk

  # Google Go installation directory.
  set -x GOROOT /usr/local/bhojo/go
  set -x GOPATH /usr/local/bhojo/golib

  # Google Dart installation directory.
  set DART_SDK $HOME/dart-sdk
  
  # Now set the correct PATH environment variable.
  set -x PATH \
    $HOME/var/bin \
    $GOOGLE_CLOUD_SDK/bin \
    $DART_SDK/bin \
    $GOPATH/bin \
    $GOROOT/bin \
    /usr/local/bin \
    /usr/bin \
    /bin \
    /usr/local/sbin \
    /usr/sbin \
    /sbin \
    $PATH
end
