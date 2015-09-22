#!/bin/sh
# Used from Gist: (https://gist.github.com/pkuczynski/8665367)
#
# Loads all config.yml variables into re-usable environment variables.
#
# Accessing Variables:
#
# The command will get run as:
#   eval $(parse_yaml config.yml "config_")
# where "config_" is the prefix(filename) and the path will go down the trail
# as follows "echo $config_development_database"

parseYaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/4;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}