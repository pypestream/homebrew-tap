class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.10"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.0.10/localdev-darwin-arm64"
    sha256 "871926d90c6d3c882f0cd79a6f026069133ebb486c28bf99e7240ac05bc46e28"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.0.10/localdev-darwin-amd64"
    sha256 "7377151a677cf8d7dfed1309b93455a97c329177d237a2d896470f0f41acd27b"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "localdev-darwin-arm64" => "localdev"
    else
      bin.install "localdev-darwin-amd64" => "localdev"
    end
  end

  test do
    system "#{bin}/localdev", "--version"
  end
end
