class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.28"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.0.28/localdev-darwin-arm64"
    sha256 "8ac48cd7551fc46dd218c1543d9c238e46bd128fceb48f9d0b1f773b9e2e3c37"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.0.28/localdev-darwin-amd64"
    sha256 "eff23c7f238a23039c2c1941f6e2474450e909946d97b3b036508ee48ec6da2e"
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
