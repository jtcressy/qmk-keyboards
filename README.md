# qmk-keyboards
Configs for my QMK-based keyboards, with flashable binaries built by github-actions

## Adding a new keyboard/layout

The `keyboards/` directory is intended to mirror the structure of qmk/qmk_firmware:

```
keyboards/<keyboard-name[/revision]>/keymaps/<keymap-name>/<keymap-specific-files>
```

The build pipeline automatically discovers configured keyboard/keymap combinations and spawns a build job for each keymap. 

Assuming the build is triggered by a git tag, a release is generated with the firmware files for easy download.

There are 3 ways to configure a keymap to be built by the github actions pipeline:
1. populate a keymap.c file with layer data
2. populate a keymap.json file with json-formatted layer data for use with qmk cli or qmk configurator website
3. place a .gitkeep in an empty keymap folder that shadows an upstream keymap to build a premade keymap without changes

Note: for each of the above methods you can add other supporting files like a rules.mk to enable certain QMK feature flags

## Triggering Releases

Releases are simply triggered from pushing new tags. The tags should follow a datetime format of `YYYYmmdd-HHMM` and not semantic versioning.

Example command: `git tag $(date +%Y%m%d-%H%M)` followed by a `git push --tags`