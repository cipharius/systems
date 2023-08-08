#!/bin/sh

task +ACTIVE export rc.hooks=0 2>/dev/null | jq -rc '.[0].description // ""' > $HOME/CURRENT_TASK
