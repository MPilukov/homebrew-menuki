class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.8/menuki-osx-arm64.tar.gz"
      sha256 "2f0d20f66ee1dbd20a01233b5d8aeae0cec94f131dcb98f9a4f11006d04f4dfa"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.8/menuki-osx-x64.tar.gz"
      sha256 "22d7eaab5f573c8b6dc22fd57122d693cf1bf960fa978ce21061c2d37ec60b4b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.8/menuki-linux-arm64.tar.gz"
      sha256 "e4a42017de41d81e307c343b539d88b51e1b7f5580611e2349814cd2401f3825"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.8/menuki-linux-x64.tar.gz"
      sha256 "cf740b2ad25bf4fb60b851b9f86de114b2cd706c1c9b48a76fe2d1cc3ec96f99"
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
