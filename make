#!/bin/bash

mkdir -p bin

cat src/kc-token > bin/kc-client

# shopt -s extglob
GLOBIGNORE="**/*-test";
for i in src/kc-client-*
do
  BNAME=$(basename $i)
  echo -e "\n${BNAME: 10} () {" >> bin/kc-client
  echo "  # $BNAME" >> bin/kc-client
  # sed -n '4, 1000 p' $i | xargs -I '{}' echo "  "'{}' >> bin/kc-client
  tail -n +3 $i | awk '{print}' ORS='\n  ' >> bin/kc-client
  echo "# $BNAME" >> bin/kc-client
  echo -e "}\n" >> bin/kc-client

done

echo -e "\nversion () {" >> bin/kc-client
echo "  # kc-version" >> bin/kc-client
# sed -n '4, 1000 p' $i | xargs -I '{}' echo "  "'{}' >> bin/kc-client
tail -n +3 src/kc-version | awk '{print}' ORS='\n  ' >> bin/kc-client
echo "# kc-version" >> bin/kc-client
echo -e "}\n" >> bin/kc-client


echo "COMMAND=\$1" >> bin/kc-client
echo "shift" >> bin/kc-client
echo "\$COMMAND \$*" >> bin/kc-client

chmod +x bin/kc-client
cp src/.env .env

unset GLOBIGNORE