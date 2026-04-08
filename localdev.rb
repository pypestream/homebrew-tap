class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v2.1.0"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v2.1.0/localdev-darwin-arm64"
    sha256 "e32089f2fda80cbbae3f34caf3659e8bad877e49635cfe4821b6207a52d1c9cd"
  else
    url "https://fs.gcp.pype.tech/releases/download/v2.1.0/localdev-darwin-amd64"
    sha256 "4e0d440d1d76f4b8d27c5759e066a14e04b103b3b773589839a798ab24ba7465"
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
