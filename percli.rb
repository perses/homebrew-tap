class Percli < Formula
  desc 'Command line client for the CNCF sandbox for observability visualisation'
  homepage 'https://perses.dev'
  version '0.53.1'
  license 'Apache-2.0'

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_linux_arm64.tar.gz"
      sha256 'b962955dde928613506a12b0c2ea21be25fd868bf2e1cacba5bc24e5e7e00bfa'
    else
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_linux_amd64.tar.gz"
      sha256 '126aec7cad521abf1536d125790e0542f5a4fbc3770b5de6f1c32e922cec1456'
    end
  else
    if Hardware::CPU.arm?
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_darwin_arm64.tar.gz"
      sha256 'f748a8466a01f3f5964f20b3de6e3b124288d8d703945975518e0dccd36a1eb9'
    else
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_darwin_amd64.tar.gz"
      sha256 '816a3ad724591c9fb946445587f637a287aabb17196a5caeb9779e1b90c81c09'
    end
  end

  def install
    bin.install 'percli'
  end

  test do
    assert_match "version: #{version}", shell_output("#{bin}/percli version")
  end
end
