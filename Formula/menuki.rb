class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.18"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.18/menuki-osx-arm64.tar.gz"
      sha256 "d7657c89060d27dda2c5e154bc6586140751e6fbcfc924fa37fb30ee6e5db9e5"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.18/menuki-osx-x64.tar.gz"
      sha256 "0288c82370f660f06baf04a0038f74925ab995190e2b956485af79f9ec45d2bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.18/menuki-linux-arm64.tar.gz"
      sha256 "d7333e4c9540df0831534b952c2f5e61f17abcf9aef679ee6f805a67352b2327"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.18/menuki-linux-x64.tar.gz"
      sha256 "be5e8ff962e502df4dec5cb1c9376fff5580642d6a8dcaf90cc96875f40cf27e"
    end
  end

  def install
    bin.install "menuki"
    generate_completions_from_executable(bin/"menuki", "completions",
      shells: [:bash, :zsh, :fish])
    (buildpath/"menuki.1").write Utils.safe_popen_read(bin/"menuki", "man")
    man1.install "menuki.1"
  end

  def caveats
    <<~EOS
      menuki stores your theme and settings in ~/.menuki (created on first run).
      Get started:
        menuki tour        Guided, hands-on feature tour
        menuki examples    Bundled example packs
    EOS
  end

  test do
    (testpath/"m.json").write <<~JSON
      {"title":"t","start_menu":"main","menus":{"main":{"items":[
        {"name":"x","action":{"type":"shell","command":"echo hi"}}]}}}
    JSON
    assert_match "\"ok\": true", shell_output("#{bin}/menuki validate --config #{testpath}/m.json")
  end
end
