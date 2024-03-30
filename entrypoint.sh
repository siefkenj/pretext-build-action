#!/bin/bash

# Some color variables for pretty echoing
RED="\\033[0;31m"
GREEN="\\033[0;32m"
BLUE="\\033[0;34m"
GRAY="\\033[0;37m"
NC="\\033[0m" # No Color

PROJECT_ROOT=$1
PRETEXT_COMMAND=$2
OUTPUT_DIR=$3
PRETEXT_LOCATION=$4
PRETEXT_COMMIT=$5

ABSOLUTE_PROJECT_ROOT="$PWD/$PROJECT_ROOT"
ABSOLUTE_OUTPUT_DIR="$PWD/$OUTPUT_DIR"

echo -e "${GREEN}Using project root $PROJECT_ROOT${NC}"
pushd "$PROJECT_ROOT"

echo -e "${GREEN}Pretext version infomration${GRAY}"
pretext support
echo -e "${NC}"

# If $PRETEXT_LOCATION is non-empty, we copy the files at that location to `~/.ptx/`
if [ -n "$PRETEXT_LOCATION" ]; then
    popd > /dev/null
    
    echo -e "${RED}Using custom pretext/pretext${NC}"
    echo -e "${GREEN}Copying files from $PRETEXT_LOCATION to ~/.ptx/${NC}"
    cp -r "$PRETEXT_LOCATION" ~/.ptx/

    pushd "$PROJECT_ROOT"
fi

# If $PRETEXT_COMMIT is non-empty, fetch that commit and extract it to `~/.ptx/`
if [ -n "$PRETEXT_COMMIT" ]; then
    popd > /dev/null

    echo -e "${RED}Using custom pretext/pretext commit $PRETEXT_COMMIT${NC}"
    echo -e "${GREEN}Fetching pretext/pretext commit $PRETEXT_COMMIT${NC}"
    curl -L "https://github.com/PreTextBook/pretext/archive/$PRETEXT_COMMIT.tar.gz" -o pretext.tar.gz
    ls pretext.tar.gz

    pushd "$PROJECT_ROOT"
fi


echo -e "${GREEN}Running pretext command 'pretext $PRETEXT_COMMAND'${NC}"
pretext $PRETEXT_COMMAND

echo -e "${GREEN}Moving output/ to $OUTPUT_DIR${NC}"
mv output "$ABSOLUTE_OUTPUT_DIR"

popd > /dev/null

echo -e "${GREEN}Listing files in $OUTPUT_DIR${NC}"
ls "$OUTPUT_DIR/output"
