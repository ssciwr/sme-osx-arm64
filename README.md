# sme-osx-arm64 [![Release Builds](https://github.com/ssciwr/sme-osx-arm64/actions/workflows/release.yml/badge.svg)](https://github.com/ssciwr/sme-osx-arm64/actions/workflows/release.yml)

Compilation of Arm64 macOS [spatial-model-editor](https://github.com/spatial-model-editor/spatial-model-editor) binaries, using statically compiled libraries from [ssciwr/sme-deps-osx-arm64](https://github.com/ssciwr/sme-deps-osx-arm64).

## Updating this repo

Update the version numbers in [release.yml](https://github.com/ssciwr/sme-osx-arm64/blob/main/.github/workflows/release.yml#L6) (and the build script [build.sh](https://github.com/ssciwr/sme-osx-arm64/blob/main/build.sh) if necessary), then commit the changes:

```
git commit -am "revision update"
git push
```

This will trigger GitHub Action builds which will compile the binaries. If the builds are sucessful, tag this commit with the spatial-model-editor version and push the tag to github:

```
git tag YYYY.MM.DD
git push origin YYYY.MM.DD
```

The tagged commit will trigger the builds again, but this time they will each upload the resulting binaries and wheels to the corresponding release on https://github.com/ssciwr/sme-osx-arm64/releases. When a release build is triggered in spatial-model-editor it will download these files from here and add them to the release.
