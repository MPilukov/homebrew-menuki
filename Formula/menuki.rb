class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.10/menuki-osx-arm64.tar.gz"
      sha256 "c63c51e83f43b48062e1899ee94ebcb447849e187e41add9f8736852bc8832bd"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.10/menuki-osx-x64.tar.gz"
      sha256 "5489aca2c51d3f824beff0d0e071ec3a6c60f9bb1cccd3e823472950da04f3a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.10/menuki-linux-arm64.tar.gz"
      sha256 "c90adc8a7707ca5653b128b21586f69126e11c5a4bd072f0602bf5d6209a46dc"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.10/menuki-linux-x64.tar.gz"
      sha256 "32d1fb1f71f0904b6ae44dccb8f7b177e3fba0fe8c61c6569cf689d7788815ba"
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
