class Percli < Formula
  desc 'Command line client for the CNCF sandbox for observability visualisation'
  homepage 'https://perses.dev'
  version '0.53.0'
  license 'Apache-2.0'

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_linux_arm64.tar.gz"
      sha256 '796b7f0f0f4bd80f830d382146b18a416024dd3d6113757dcefe378879d58bbe'
    else
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_linux_amd64.tar.gz"
      sha256 '4c1a07c05c306cf3b009a8ef62b092aaac9b444d02d6e7366d7487f6f6899bb7'
    end
  else
    if Hardware::CPU.arm?
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_darwin_arm64.tar.gz"
      sha256 '9323792108434ed3d9a87edf4a2cc409923aa330a5f16d78b376e092ccdc4098'
    else
      url "https://github.com/perses/perses/releases/download/v#{version}/perses_#{version}_darwin_amd64.tar.gz"
      sha256 '81b710a11a4db60173aa45eb1d0f40d661a055bb83d0ac1359da67b9cf5695ea'
    end
  end

  def install
    bin.install 'percli'
  end

  test do
    assert_match "version: #{version}", shell_output("#{bin}/percli version")
  end
end
