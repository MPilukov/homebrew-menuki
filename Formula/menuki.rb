class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.15"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.15/menuki-osx-arm64.tar.gz"
      sha256 "63f13f3aaef358a05790e94a99329b91fefc05a0373f9daa6bc9268976282151"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.15/menuki-osx-x64.tar.gz"
      sha256 "889ca09dca1e4b6d8cb61271582fa84ad5db937f2fcb5490a44a7036440e4d9a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.15/menuki-linux-arm64.tar.gz"
      sha256 "733b5c49ba5623aae163c16b0dad7174dea54c3a613870a8f9962cd24df810a1"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.15/menuki-linux-x64.tar.gz"
      sha256 "74b09685a0d360989953f095ddff7d79bebd8054b6c2b2ee9e9e65b129ecdb72"
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
