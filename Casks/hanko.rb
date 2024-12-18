cask "hanko" do
    version "0.5.2"

    name "hanko"
    desc "Keeps your allowed signers file up to date"
    homepage "https://github.com/SRv6d/hanko"
  
    on_intel do
      url "https://github.com/SRv6d/hanko/releases/download/v#{version}/hanko-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "3d4831c1b3b09c372bce1a7ae8d0f9136f719ffe9540df89e8b262c53b39dbd1"
    end
  
    on_arm do
      url "https://github.com/SRv6d/hanko/releases/download/v#{version}/hanko-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "0e428c457ccbac4ecdf42256fb8073bb238ab84eaac34b3a2cbe8f440a5537c2"
    end
  
    binary "hanko"
  end
