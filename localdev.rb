class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.7"

  if Hardware::CPU.arm?
    url "https://github.com/pypestream/homebrew-tap/releases/download/v1.0.7/localdev-darwin-arm64"
    sha256 "77b48c903ae97f28376f247a223038ee723fceeb7f7b893787956559635971c4"
  else
    url "https://github.com/pypestream/homebrew-tap/releases/download/v1.0.7/localdev-darwin-amd64"
    sha256 "f0493938766e4ca3dd216d1eb12e8cf4bc6920f31bf4da3071a47b7c98b80bb4"
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "localdev-darwin-\#{arch}" => "localdev"
  end

  test do
    system "\#{bin}/localdev", "--version"
  end
end
