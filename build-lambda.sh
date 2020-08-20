#!/bin/bash
# -- lambda-build.sh ------------------------------------------------------------------
#
# Lambdaで使用するソースコード・実行ファイルを生成するスクリプト
#
# ------------------------------------------------------------------------------

set -uo pipefail

readonly LAMBDA_PATHS=('./lambda-functions/consumer-sqs' './lambda-functions/dead-letter-sqs')

main() {
    local function_dir
    for function_dir in ${LAMBDA_PATHS[@]}; do
        echo "now: ${function_dir}"
        pushd "${function_dir}" || exit \
            && npm install \
            && popd || exit
    done
}

main "$@"

exit 0

