cask "hanko" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.5.4"
  sha256 arm:   "dc9be0434761e64285ae75b9e2159b4da5a20fee5b01a9a0c661693f12113832",
         intel: "93a9baf2469cde7b9e1cfa23b1ad077e316f5e13a3365efa3a270545b3af7d33"

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
