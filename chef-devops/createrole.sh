#!/bin/bash
#création de variable

for roles in WEB DB APP ; do



#verifié si le role est present et créer le role (web bd,tomcat... etc)
  knife role list | grep "^$roles$" > /dev/null 2>&1

  if [ $? -ne 0 ]; then
    knife role from file roles/$roles.json
  fi
  for nodes in `knife node list | grep -i "^devops-$roles-"`; do
    knife node run_list add $nodes "role[$roles]"
  done
done

#rechercher et associer les roles au nodes
