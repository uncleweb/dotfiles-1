if status --is-interactive
  set -x LC_ALL en_US.UTF-8
  set -x LANG en_US.UTF-8

  set EDITOR /usr/local/bin/vim

  # Google Android SDK Path.
  # Buck requires this to be exported to avoid hardcoding in the repository.
  set -x ANDROID_SDK $HOME/Library/Android/sdk

  # Google Cloud SDK installation directory.
  set -x GOOGLE_CLOUD_SDK $HOME/google-cloud-sdk

  # Google Go installation directory.
  set -x GOROOT /usr/local/bhojo/go
  set -x GOPATH /usr/local/bhojo/golib

  # Google Dart installation directory.
  set -x DART_SDK $HOME/dart-sdk

  # Now set the correct PATH environment variable.
  set -x PATH \
    $HOME/var/bin \
    $ANDROID_SDK/platform-tools \
    $ANDROID_SDK/tools \
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


  # for f in $HOME/.ssh/*.pub
  #     eval (keychain --eval (basename -s .pub $f))
  # end
  # keychain --nogui --clear ~/.ssh/id_rsa

  function gtop
    set top_dir (git rev-parse --show-toplevel)
    printf "%s" $top_dir
  end
end


setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end
