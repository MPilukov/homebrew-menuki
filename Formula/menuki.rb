class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.16"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.16/menuki-osx-arm64.tar.gz"
      sha256 "68c62ce407120a8fdfda993272f920c501372bd5c63c53f3559502186ea2eec7"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.16/menuki-osx-x64.tar.gz"
      sha256 "d3bfc2627dd81145fe211b0c1520a92cf6450becd750e350183e90e82d556723"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.16/menuki-linux-arm64.tar.gz"
      sha256 "5562292b6418d5de394534efe1a858f213cb98c053925d44e66b9a54a940d592"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.16/menuki-linux-x64.tar.gz"
      sha256 "216acad9719619edd17fedf4c1ad6e3e04e3c50a927791211ee2dece24a2f6b2"
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
