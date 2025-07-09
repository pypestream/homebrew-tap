class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.9"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.0.9/localdev-darwin-arm64"
    sha256 "71eb197f07302565ff72978445b286cfdaef000086a9adf5db1efe4fc002ee8f"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.0.9/localdev-darwin-amd64"
    sha256 "6b3e70bc0b262b84a2106a0a24cac4b52531f8f5d036cf1292897765a0b08712"
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
