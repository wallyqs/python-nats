#!/bin/bash

#!/bin/sh
set -e
# check to see if gnatsd folder is empty
if [ ! "$(ls -A $HOME/gnatsd)" ]; then
    (
	mkdir -p $HOME/gnatsd;
	cd $HOME/gnatsd
	wget https://github.com/nats-io/gnatsd/releases/download/v0.7.2/gnatsd-v0.7.2-linux-amd64.tar.gz -O gnatsd.tar.gz;
	tar -xvf gnatsd.tar.gz;
	export PATH=$HOME/gnatsd:$PATH
    )
else
  echo 'Using cached directory.';
fi

pip install --upgrade pip

python --version | grep 2.6 && {
    pip install unittest2    
}
pip install -r requirements.txt

export PYTHONPATH=$HOME/gnatsd:$PATH
python tests/client_test.py
python tests/protocol_test.py
