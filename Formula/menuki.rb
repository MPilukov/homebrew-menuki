class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.11/menuki-osx-arm64.tar.gz"
      sha256 "9f96c59628a1d75d30b725afc517ebdcffac7372dcc16be95d177e93e6b18d5d"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.11/menuki-osx-x64.tar.gz"
      sha256 "adf815bf1f3cc33575c61d6967d6227b25a018e1fe0d789847c000b2b8aee213"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.11/menuki-linux-arm64.tar.gz"
      sha256 "6f3a4784698ffade8c1c8bf40f182fb0b29c8559cabe736eb57359af7dfe42b5"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.11/menuki-linux-x64.tar.gz"
      sha256 "a5aebdb50547428170f5ecfc89696b864ee6e3afd24b81bd52620108a0349db4"
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
