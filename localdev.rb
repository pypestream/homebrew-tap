class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.27"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.0.27/localdev-darwin-arm64"
    sha256 "d09a5b508612d30fda4b5b8f1d102a3de4dda157ab64d68870f24277dbd8e075"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.0.27/localdev-darwin-amd64"
    sha256 "59aa42c77ef073cd54a8cc423324694e4f3756607fafd1b4c416d6cc666728c3"
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
