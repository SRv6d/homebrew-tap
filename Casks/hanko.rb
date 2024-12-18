cask "hanko" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.5.2"
  sha256 arm:   "0e428c457ccbac4ecdf42256fb8073bb238ab84eaac34b3a2cbe8f440a5537c2",
         intel: "3d4831c1b3b09c372bce1a7ae8d0f9136f719ffe9540df89e8b262c53b39dbd1"

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
