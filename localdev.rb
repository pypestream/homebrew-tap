class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.11"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.0.11/localdev-darwin-arm64"
    sha256 "d794778794674a1adc83f507194a164e8e3d99d1153996b36c4668d8af8d5e50"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.0.11/localdev-darwin-amd64"
    sha256 "5fc85de0a6c007851dc8ed855e94271d0f73ee79b561fd4b8fac79211c8b267b"
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
