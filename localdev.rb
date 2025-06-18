class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-localdev"
  version "v1.0.6"

  if Hardware::CPU.arm?
    url "https://github.com/pypestream/homebrew-localdev/releases/download/v1.0.6/localdev-darwin-arm64"
    sha256 "cdd2f5e18d6e8fc8d3450beb77b07653b119d6840a28256270622bd9302fccae"
  else
    url "https://github.com/pypestream/homebrew-localdev/releases/download/v1.0.6/localdev-darwin-amd64"
    sha256 "c9302e8f7f995790da6856c05f9b531e5f9806652d76a4bfe936028876279f0c"
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "localdev-darwin-#{arch}" => "localdev"
  end

  test do
    system "#{bin}/localdev", "--version"
  end
end
