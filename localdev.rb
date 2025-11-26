class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.24"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.0.24/localdev-darwin-arm64"
    sha256 "bc8d7b2b5832e84532882be63402ae9eceef4badff4d0166148dea4b500067eb"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.0.24/localdev-darwin-amd64"
    sha256 "210d41c2524059792785bd1b4af7d315e6765000f64f1e1434643517ec2504e1"
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
