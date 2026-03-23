cask "hanko" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.1.2"
  sha256 arm:   "499ce8397f2602fa32c1f066c98f36af27fc67cb992e3f493277c8a54f39140e",
         intel: "f08b84d976ac71be5c4e15b63b290d895b652434bd22c2be29624c629e79dc38"

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
