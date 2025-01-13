# Bump casks to their latest version
bump-version cask="hanko":
    #!/usr/bin/env bash
    set -euxo pipefail

    FILE=Casks/{{ cask }}.rb
    CURRENT_VERSION=v$(grep 'version "' $FILE | sed -E 's/.*version "([^"]*)".*/\1/')
    LATEST_VERSION=$(gh release view --repo SRv6d/{{ cask }} --json name --jq '.[]')

    if [ $CURRENT_VERSION == $LATEST_VERSION ]; then
        echo Cask {{ cask }} is up to date
        exit 0
    fi

    test -z "$(git status --porcelain)" || (echo "The working directory is not clean"; exit 1)

    NEW_SHA256_ARM=$(gh release download --repo SRv6d/{{ cask }} $LATEST_VERSION --pattern "*aarch64-apple-darwin.tar.gz" --output - | shasum -a 256 | awk '{print $1}')
    NEW_SHA256_INTEL=$(gh release download --repo SRv6d/{{ cask }} $LATEST_VERSION --pattern "*x86_64-apple-darwin.tar.gz" --output - | shasum -a 256 | awk '{print $1}')

    # Update the cask version
    sed -i '' "s/version \"[^\"]*\"/version \"${LATEST_VERSION:1}\"/" $FILE

    # Update the checksums
    sed -i '' \
      -e "s/\(sha256[[:space:]]*arm:[[:space:]]*\"\)[a-fA-F0-9]\{64\}\(\",[[:space:]]*\)/\1${NEW_SHA256_ARM}\2/" \
      -e "s/\(intel:[[:space:]]*\"\)[a-fA-F0-9]\{64\}\(\"\)/\1${NEW_SHA256_INTEL}\2/" \
      $FILE

    git add $FILE
    git commit -m "Bump cask {{ cask }} to $LATEST_VERSION"
