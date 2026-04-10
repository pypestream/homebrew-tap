class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.1.1"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.1.1/localdev-darwin-arm64"
    sha256 "8de5b80b67cc3b32af1d9e719bb2f1681b68bb6bfdb8ceee833329727c432f08"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.1.1/localdev-darwin-amd64"
    sha256 "a31ba98c2b149b08c72fb0a1b2ed6bea30be7b08ac7c3bbbb71096fb870de50e"
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
