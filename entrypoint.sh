#!/bin/bash

PROJECT_ROOT=$1
PRETEXT_COMMAND=$2
OUTPUT_DIR=$3

ABSOLUTE_PROJECT_ROOT="$PWD/$PROJECT_ROOT"
ABSOLUTE_OUTPUT_DIR="$PWD/$OUTPUT_DIR"

echo "Using project root $PROJECT_ROOT"
pushd "$PROJECT_ROOT"

echo "Running pretext command 'pretext $PRETEXT_COMMAND'"
pretext $PRETEXT_COMMAND

echo "Moving output/ to $OUTPUT_DIR"
mv output/ "$ABSOLUTE_OUTPUT_DIR"

popd

echo "Listing files in $OUTPUT_DIR"
ls "$OUTPUT_DIR"
