# Homebrew Tap for Localdev

This repository provides a public Homebrew tap for installing the `localdev` binary.

## Installation

1. Tap the repository:

```sh
brew tap pypestream/tap
```

2. Install Localdev:

```sh
brew install pypestream/tap/localdev
```

This will install the latest release of `localdev`.

3. Verify the installation:

```sh
localdev --version
```

You should see the installed version of `localdev` printed in your terminal.

## Updating

To update to the latest version:

```sh
brew update
brew upgrade pypestream/tap/localdev
```

## Troubleshooting
- If you encounter any issues, ensure you are using the latest version of Homebrew.
- For support, open an issue in this repository.

## Formula Maintenance
- The formula is updated to track the latest release (currently v1.0.5). For new releases, update the `localdev.rb` formula with new release URLs and SHA256 checksums. 