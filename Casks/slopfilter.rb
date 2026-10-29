cask "slopfilter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.0"
  sha256 arm:   "f12cbdcbea65c94ecd778fa61644e269f41d2078fdc0f5f832676dfe3de64cb4",
         intel: "1a175bb71b69ab1a7e4e4cd8b95a35e85ecd6ed6d814f0bfe853cfa0ea9ed4fa"

  url "https://github.com/marvinvogt/slopfilter/releases/download/v#{version}/slopfilter-v#{version}-#{arch}-apple-darwin.tar.gz"
  name "slopfilter"
  desc "Scores text for likely AI authorship"
  homepage "https://github.com/marvinvogt/slopfilter"

  depends_on :macos

  binary "slopfilter"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}/slopfilter"]
  end
end
