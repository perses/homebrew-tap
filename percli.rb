class Percli < Formula
  desc 'Command line client for the CNCF sandbox for observability visualisation'
  homepage 'https://perses.dev'
  version '0.52.0'
  sha256 '0a584c627b7c76b36883e77506359ccde52ed5e04592be4b8415ae85cd136061'
  license 'Apache-2.0'

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_linux_arm64.tar.gz"
      sha256 '4a9c0fb2abc6338a21a7753747566a3a7f505a822d6517e054ebd2245afb380e'
    else
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_linux_amd64.tar.gz"
      sha256 'cbfd4c12069762b9e1d66d5658339cac09ae0856f5d1683603e59a90f605078e'
    end
  else
    if Hardware::CPU.arm?
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_darwin_arm64.tar.gz"
      sha256 '206faf009bd419955d9bc633226cd0f24807408d45eae10c40a148c78ee17f26'
    else
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_darwin_amd64.tar.gz"
      sha256 'afb68bc8d99c6d31ae7367f5b452c7ef9334cb73ea919335a3243eaac4c3804b'
    end
  end

  def install
    bin.install 'percli'
  end

  test do
    assert_match "version: #{version}", shell_output("#{bin}/percli version")
  end
end
