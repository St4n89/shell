#!/bin/bash
SORTDIR=$1
WORKDIR=$2
oldIFS=$IFS
IFS=$'\n'

filesort() {
files=$(find $SORTDIR -type f)
for file in $files
do
  MODYEAR=$(date -r $file +%Y)
  MODMONTH=$(date -r $file +%m)
  MODDAY=$(date -r $file +%d)
  DIRNAM="$MODYEAR-$MODMONTH-$MODDAY"
  FILENAM=$(basename "$file")

  if [[ ! -d "$WORKDIR/$DIRNAM" ]]; then
    mkdir "$WORKDIR/$DIRNAM"
    echo "$DIRNAM created"
  fi

  cp $file "$WORKDIR/$DIRNAM/$FILENAM"
  echo "$file copied to $WORKDIR/$DIRNAM/$FILENAM"
done
}

if [[ -z "$SORTDIR" || -z "$WORKDIR" ]]; then
  echo "Sorting and working directories need to be specified!"
else
  filesort
fi

IFS=$oldIFS
