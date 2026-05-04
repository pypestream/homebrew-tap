class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.1.9"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.1.9/localdev-darwin-arm64"
    sha256 "bb14333c2bf4ceb2b91431f58443041d559e6bf0a307b8be1484b86bec7f517a"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.1.9/localdev-darwin-amd64"
    sha256 "b8d3cd5ffb97a779c2fcf060fa4282bdba5c80547ac14cd2ddedc75b1bb7648d"
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
