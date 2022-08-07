#!/bin/bash

for ((i = 0; i < 10; i++)); do
  curl --fail --silent http://localhost:8000 --output /dev/null;
	if [ $? -eq 0 ]; then
    echo "casdoor is up";
		exit 0;
	fi
  echo "[$i] casdoor is not up, sleeping for 5 seconds";
	sleep 5;
done
