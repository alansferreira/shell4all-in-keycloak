#!/bin/bash
rm -rf bin || true
mkdir -p bin
cp src/.env bin/.env

GLOBIGNORE="*/kc-client-*"; cp src/* bin/; unset GLOBIGNORE

cat src/kc-token > bin/kc-client
# tail -n +2 src/cecho | awk '{print}' ORS='\n' >> bin/kc-client
# echo "#!/bin/bash" > bin/kc-client
# echo "source kc-token" >> bin/kc-client
# echo "source ./.env" >> bin/kc-client
# echo "source ./cecho" >> bin/kc-client

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
echo -e "  echo \"$(cat .semver)\"" >> bin/kc-client
echo -e "}\n" >> bin/kc-client


echo "COMMAND=\$1" >> bin/kc-client
echo "shift" >> bin/kc-client
echo "\$COMMAND \$*" >> bin/kc-client

chmod +x bin/kc-client

unset GLOBIGNORE