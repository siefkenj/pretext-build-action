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

ABSOLUTE_PROJECT_ROOT="$PWD/$PROJECT_ROOT"
ABSOLUTE_OUTPUT_DIR="$PWD/$OUTPUT_DIR"

echo -e "${GREEN}Using project root $PROJECT_ROOT${NC}"
pushd "$PROJECT_ROOT"

echo -e "${GREEN}Pretext version infomration${GRAY}"
pretext support
echo -e "${NC}"


echo -e "${GREEN}Running pretext command 'pretext $PRETEXT_COMMAND'${NC}"
pretext $PRETEXT_COMMAND

echo -e "${GREEN}Moving output/ to $OUTPUT_DIR${NC}"
mv output "$ABSOLUTE_OUTPUT_DIR"

popd

echo -e "${GREEN}Listing files in $OUTPUT_DIR${NC}"
ls "$OUTPUT_DIR/output"
