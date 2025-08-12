class Localdev < Formula
  desc "Local development tool for Kubernetes environments"
  homepage "https://github.com/pypestream/homebrew-tap"
  version "v1.0.19"

  if Hardware::CPU.arm?
    url "https://fs.gcp.pype.tech/releases/download/v1.0.19/localdev-darwin-arm64"
    sha256 "808109956b4c797dd058e17239f7fe87748dc983ea1493c8dedbc3e3dc37d404"
  else
    url "https://fs.gcp.pype.tech/releases/download/v1.0.19/localdev-darwin-amd64"
    sha256 "795a169774d94e6387a8f31059037df952bfc24525c60fc7e2ebc57503b93bd6"
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
