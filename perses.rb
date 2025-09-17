class Perses < Formula
  desc 'Server and web UI for the CNCF sandbox for observability visualisation'
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
