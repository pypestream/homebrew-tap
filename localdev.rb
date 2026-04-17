class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.1.2"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.1.2/localdev-darwin-arm64"
    sha256 "09adf8be110a572e222db0aaa788afb51ae835a3f406af1a3ef713ee9490b406"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.1.2/localdev-darwin-amd64"
    sha256 "47ba81f7e388f819eb3749fcedac0bc9e7c5ddf8dceda2216a601843a480ed34"
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
