class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.13/menuki-osx-arm64.tar.gz"
      sha256 "26d41336fced3912ced0a409932eec8b8f4e2b7f3f489fd8a596f4db9a750499"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.13/menuki-osx-x64.tar.gz"
      sha256 "157ee85d8372e84eebfe55f97550d8d68cdd5705837376b7557545104249dbb6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.13/menuki-linux-arm64.tar.gz"
      sha256 "d6be134f9b335a3e6aa1860b97c524c1ffee0da95147f5ec1d8078b41bf882c3"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.13/menuki-linux-x64.tar.gz"
      sha256 "8b1ec8a39c9c69b67756736887b40eded0a33f0451ebaff5255d26e739390efd"
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
