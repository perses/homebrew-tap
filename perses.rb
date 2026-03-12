class Perses < Formula
  desc 'Server and web UI for the CNCF sandbox for observability visualisation'
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
    bin.install 'perses'
    share.install 'plugins-archive'
    unless (pkgetc/'config.yml').exist?
      (pkgetc/'config.yml').write <<~CFG
        plugin:
          archive_path: #{opt_share}/plugins-archive
        database:
          file:
            folder: #{var}/perses
      CFG
    end
    Dir.mkdir(var/'perses') unless Dir.exist?(var/'perses')
  end

  service do
    run [opt_bin/'perses', "--config", etc/"perses/config.yml"]
    keep_alive true
    log_path var/"log/perses.log"
    error_log_path var/"log/perses.log"
    working_dir var/"perses"
  end

  test do
    port = free_port
    pid = fork do
      exec bin/'perses', "-config", etc/"perses/config.yml", "-web.listen-address", "localhost:#{port}"
    end
    sleep 5
    assert_match "Perses", shell_output("curl -s localhost:#{port}")
  ensure
    Process.kill('TERM', pid)
    Process.wait(pid)
  end
end
