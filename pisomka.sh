#!/bin/bash

ZOZ="out"
while IFS= read LINE
do
  OUTPUT=$(

   if echo "$LINE" | grep -q "^$" 
   then 
     echo "$LINE" | sed 's/^$/<p>/' 
     continue 
   elif echo "$LINE" | grep -q "^#\{2\}[[:space:]]*" 
   then 
     echo "$LINE" | sed 's/^##[[:space:]]*\(.*\)$/<h2>\1<\/h2>/'
     continue
   elif echo "$LINE" | grep -q "^#\{1\}[[:space:]]*"
   then 
     echo "$LINE" | sed 's/^#[[:space:]]*\(.*\)$/<h1>\1<\/h1>/'
     continue   

  elif echo "$LINE" | grep -q "__[^_]\+__" 
  then 
    echo "$LINE" | sed 's/__\([^_][^_]*\)__/<strong>\1<\/strong>/g' 

  elif echo "$LINE" | grep -q "_[^_]\+_"
  then  
    echo "$LINE" | sed 's/_\([^_][^_]*\)_/<em>\1<\/em>/g' 

  elif echo "$LINE" | grep -q "<https\?://"
  then
    echo "$LINE" | sed 's|<\(https\?:\/\/[^>][^>]*\)>|<a href="\1">\1<\/a>|g'


  else 

    if echo "$LINE" | grep -q "^[[:space:]]-[[:space:]]" 
    then
       if [ "$ZOZ" = "out" ];
        then
          echo "<ol>"
          ZOZ="in" 
      fi

       echo "$LINE" | sed 's/^[[:space:]]-[[:space:]]\(.*\)$/<li>\1<\/li>/'
   

    else
      if [ "$ZOZ" = "in" ];
      then
      echo "</ol>"
      fi

      echo "$LINE" | sed 's/__\([^_][^_]*\)__/<strong>\1<\/strong>/g' | 
                      sed 's/_\([^_][^_]*\)_/<em>\1<\/em>/g' 
    fi
  fi
   )
   echo "$OUTPUT"
done

