class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.1.4"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.1.4/localdev-darwin-arm64"
    sha256 "35b096a57aa48a9240007003699490f9931d223150ed3c535478a18e0ee1f05d"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.1.4/localdev-darwin-amd64"
    sha256 "aec2ec5a99f8ae1f624accc88b8c6827187c506f4f2377a92cd10a5380172199"
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
