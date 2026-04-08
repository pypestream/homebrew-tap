class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.1.0"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.1.0/localdev-darwin-arm64"
    sha256 "5b40ef7dd184efa2e9f5ea7a18221b8bd8f6c626ffadbb643e81a8e133abc62d"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.1.0/localdev-darwin-amd64"
    sha256 "d5b9c3d97a3b2f0a3c918c84ea0f2114de8197cfd5f534c6527c8b187fb2c6e0"
  end

  def pre_install
    # Check VPN connectivity before installation
    system "curl", "-f", "--connect-timeout", "3", "https://fs.gcp.pype.tech/health"
    if $?.exitstatus != 0
      puts "Error: Unable to reach internal network. Please connect to VPN first."
      puts "Installation aborted."
      exit 1
    end
  end

  def pre_upgrade
    # Check VPN connectivity before upgrade
    system "curl", "-f", "--connect-timeout", "3", "https://fs.gcp.pype.tech/health"
    if $?.exitstatus != 0
      puts "Warning: Unable to reach internal network. Skipping localdev upgrade."
      puts "Please connect to VPN and run 'brew upgrade localdev' manually."
      exit 0
    end
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
