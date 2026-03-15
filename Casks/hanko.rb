cask "hanko" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.1.1"
  sha256 arm:   "be14e6b885ebe5710a5100d32b08fc4ffb8da2f3a9dcc7eea83ea07057825cc7",
         intel: "9a41af8311472348e52633ade92ba4d268703270834430e610b2f28545e25f97"

  url "https://github.com/SRv6d/hanko/releases/download/v#{version}/hanko-#{version}-#{arch}-apple-darwin.tar.gz"
  name "hanko"
  desc "Keeps your allowed signers file up to date"
  homepage "https://github.com/SRv6d/hanko"

  binary "hanko"

  postflight do
    # Remove the quarantine attribute from the binary
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{staged_path}/hanko"]
  end
end
