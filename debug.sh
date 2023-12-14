#!/bin/bash

set -e -x

# set up certificate to sign macos app, based on:
# - https://localazy.com/blog/how-to-automatically-sign-macos-apps-using-github-actions
# - https://federicoterzi.com/blog/automatic-code-signing-and-notarization-for-macos-apps-using-github-actions/
# - https://docs.github.com/en/actions/deployment/deploying-xcode-applications/installing-an-apple-certificate-on-macos-runners-for-xcode-development
echo -n "$MACOS_CERTIFICATE" | base64 --decode -o certificate.p12
security create-keychain -p "$KEYCHAIN_PWD" build.keychain
security default-keychain -s build.keychain
security unlock-keychain -p "$KEYCHAIN_PWD" build.keychain
security import certificate.p12 -k build.keychain -P "$MACOS_CERTIFICATE_PWD" -T /usr/bin/codesign
security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k "$KEYCHAIN_PWD" build.keychain
security list-keychain -d user -s build.keychain
security find-identity -v -p codesigning
xcrun notarytool store-credentials "notarytool-profile" --apple-id "$MACOS_NOTARIZATION_APPLE_ID" --team-id "$MACOS_NOTARIZATION_TEAM_ID" --password "$MACOS_NOTARIZATION_PWD"

# debug
xcrun notarytool log "946d90d4-965c-4f77-a4ba-5932a229307f" --keychain-profile "notarytool-profile"
