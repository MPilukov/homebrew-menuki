class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.17"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.17/menuki-osx-arm64.tar.gz"
      sha256 "9a5b8a163bb0023ad47e1fa9d5f303ddaaf941cf43ad5c411d570e759919e076"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.17/menuki-osx-x64.tar.gz"
      sha256 "6bbd8135a6dc9efa8c29922cad9a2e34e73999fc596a900f755d832ee3344568"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.17/menuki-linux-arm64.tar.gz"
      sha256 "bb38760a153bebac1e018a0e5f01724f5e21def7a9696657a466c328f49d3ee4"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.17/menuki-linux-x64.tar.gz"
      sha256 "eb2359a8356f6be5964b0b86eb5e1296fa7ed0b851def98eab724bd349c9cb1b"
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
