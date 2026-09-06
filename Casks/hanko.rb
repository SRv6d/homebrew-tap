cask "hanko" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.1.3"
  sha256 arm:   "309f55716c2db24008d24413ab487d0ad008e128cb2cbc1d0541f43168a1672d",
         intel: "cbfa1b3072918a101440c9b34b912e500d053fb8ea39c71859f78d9942f26d67"

  url "https://github.com/SRv6d/hanko/releases/download/v#{version}/hanko-#{version}-#{arch}-apple-darwin.tar.gz"
  name "hanko"
  desc "Keeps your allowed signers file up to date"
  homepage "https://github.com/SRv6d/hanko"

  depends_on :macos

  binary "hanko"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}/hanko"]
  end
end
