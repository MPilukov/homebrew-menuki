class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.20"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.20/menuki-osx-arm64.tar.gz"
      sha256 "2b2ee04e62a88fdad356aea4fec1e319de9147ed619ecf3cd2031bb450c291ef"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.20/menuki-osx-x64.tar.gz"
      sha256 "e6f7767678acc4deb756e72fbba1c25ef0462662837bffeb04e2b37d5b82a61e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.20/menuki-linux-arm64.tar.gz"
      sha256 "25e583338c5d783838d6baa9dd7113a0bb3be935ed1f417596b3a215ca6b6c37"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.20/menuki-linux-x64.tar.gz"
      sha256 "bc5afdf5ad9b8ff329a5e4bfe278eeeb0743cdb234b116c827b243378b2f1552"
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
