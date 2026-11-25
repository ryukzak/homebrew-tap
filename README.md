# ryukzak/tap

Homebrew packages by ryukzak.

    brew install --cask ryukzak/tap/wtf

| Cask | What |
| ---- | ---- |
| `wtf` | [wtf](https://github.com/ryukzak/wtf), a Git client for reviewing what AI agents did. Built on your Mac from source. |
| `wtf@<line>` | The last release of an older line, such as `wtf@0.1` for 0.1.x. Lines are minors before 1.0, majors after. |

To stay on a line, instead of the latest release:

    brew uninstall --cask wtf
    brew install --cask ryukzak/tap/wtf@0.1

The release workflow in ryukzak/wtf updates `Casks/wtf.rb` on each `v*` tag, and keeps the old line's cask as `Casks/wtf@<line>.rb` when a release starts a new one.
