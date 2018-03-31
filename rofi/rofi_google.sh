#!/bin/bash

#!/bin/bash

if [ -z $@ ]
then
    echo ""
else
    xdg-open  https://www.google.com/search\?q\="$@" >> /dev/null
fi
