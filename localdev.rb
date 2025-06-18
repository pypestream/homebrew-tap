class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.8"

  if Hardware::CPU.arm?
    url "https://github.com/pypestream/homebrew-tap/releases/download/v1.0.8/localdev-darwin-arm64"
    sha256 "33d723eb3b02f72b42f1e2ff6962ae80747be458d8fa1b0a9c0ea3952c705973"
  else
    url "https://github.com/pypestream/homebrew-tap/releases/download/v1.0.8/localdev-darwin-amd64"
    sha256 "876373c7f06e078402d30da218b8ae03b0d32115384923807e11a2b79683963b"
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
