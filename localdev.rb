class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.34"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.0.34/localdev-darwin-arm64"
    sha256 "f6d7620c394b07218d35de4b720396342eff28f4f4affaad2212ebd9f209ab98"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.0.34/localdev-darwin-amd64"
    sha256 "a52421427980e28b73b556cd937861e815ced852c200678b177ec6c06de00dcb"
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
