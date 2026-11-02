class Percli < Formula
  desc 'Command line client for the CNCF sandbox for observability visualisation'
  homepage 'https://perses.dev'
  version '0.55.1'
  license 'Apache-2.0'

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_linux_arm64.tar.gz"
      sha256 'bd777b183622e2eaeda6645748be47d65afb67eb91aa8d8d726a7c10efd8a1c5'
    else
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_linux_amd64.tar.gz"
      sha256 '7c38ace5ce665e22d7d4f823b8bc0c8e91f9bcef381f218d8c564e0fe62ba750'
    end
  else
    if Hardware::CPU.arm?
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_darwin_arm64.tar.gz"
      sha256 'fa8424c68b0d1acce07869dec8967d102dd9d926f6a7e8ebaebd5ba292a97dcf'
    else
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_darwin_amd64.tar.gz"
      sha256 '0a6192711428d094f9e95ea5aafc06b166f7637e11ca42aa2cc4665b0ff01df8'
    end
  end

  def install
    bin.install 'percli'
  end

  test do
    assert_match "version: #{version}", shell_output("#{bin}/percli version")
  end
end
