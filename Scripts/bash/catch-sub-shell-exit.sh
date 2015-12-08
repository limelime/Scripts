#!/bin/bash
set -e

echo hello > /dev/null
echo "echo exit code = $?"

(echo "Run sub-shell commands with no error.")
echo "Run sub-shell commands with no error: exit code = $?"

(echo "Run sub-shell commands with error."; exit 22)
echo "Run sub-shell commands with error: exit code = $?"

echo "The end."