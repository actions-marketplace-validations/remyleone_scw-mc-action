#!/bin/sh

set -e

: "${SCW_ACCESS_KEY?SCW_ACCESS_KEY environment variable must be set}"
: "${SCW_SECRET_KEY?SCW_SECRET_KEY environment variable must be set}"
: "${SCW_REGION?SCW_REGION environment variable must be set}"

cat <<EOF > ~/.config/rclone/rclone.conf
{
    "version":"9",
    "hosts": {
      "scaleway": {
          "url": "https://s3.{SCW_REGION}.scw.cloud",
          "accessKey":"${SCW_ACCESS_KEY}",
          "secretKey":"${SCW_SECRET_KEY}",
          "api":"S3v4"
      }
    }
}
EOF

# Run and preserve output for consumption by downstream actions
rclone "$@" >"${GITHUB_WORKSPACE}/mc.output"

# Write output to STDOUT
cat "${GITHUB_WORKSPACE}/mc.output"
