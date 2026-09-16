class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.12/menuki-osx-arm64.tar.gz"
      sha256 "4964d6ac9a3b66b1aea7cc03e6b66bc84765315bb7fb1500aacd01d5fdbbd8f8"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.12/menuki-osx-x64.tar.gz"
      sha256 "bc15236829d7ea33ba24953220871e4c169fcdbfcc14a7ba61cf666ff5a1e8dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.12/menuki-linux-arm64.tar.gz"
      sha256 "40824f1d2c3dd178612bd6321091d270f36f24149d24c6f9680d942ba97d0cc5"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.12/menuki-linux-x64.tar.gz"
      sha256 "23b3d62f4bb2de49a589128633c9ed7e37fbf12160f90e6d1abc9b4b15957fc4"
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
