#!/bin/bash
# -- lambda-build.sh ------------------------------------------------------------------
#
# Lambdaで使用するソースコード・実行ファイルを生成するスクリプト
#
# ------------------------------------------------------------------------------

set -uo pipefail

readonly LAMBDA_PATH='./lambda-functions/consumer-sqs'

main() {
    pushd "${LAMBDA_PATH}" || exit \
        && npm install \
        && popd || exit
}

main "$@"

exit 0

