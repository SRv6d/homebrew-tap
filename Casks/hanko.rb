cask "hanko" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.0.0"
  sha256 arm:   "ea918e2efd37f329f18ee7b7dc097ef6fe9dc9a5f0a5437e2a4900501160bcc1",
         intel: "438218a5ad1739f96b27551c8c97fcfb912aa63799d7baea52bf18bd8ed7e361"

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
