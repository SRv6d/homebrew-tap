cask "hanko" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.5.3"
  sha256 arm:   "91958ab11f4c9200ac1655b294fb613fa83ca6911a47dc66a439ee54a80d8cec",
         intel: "481a5121c2a3514aedcbf4d6d0c93179503c0f660c43c5350232e81b534d266b"

  url "https://github.com/SRv6d/hanko/releases/download/v#{version}/hanko-v#{version}-#{arch}-apple-darwin.tar.gz"
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
