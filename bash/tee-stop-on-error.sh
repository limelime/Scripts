#!/bin/bash
set -e
# Description: Use 'set -o pipefail' to ensure script stop if anything fail through the pipe

set -o pipefail
echo 'hello error'; exit 1 2>&1 | tee some.log

echo 'Continue on error: This line should not be displayed.'