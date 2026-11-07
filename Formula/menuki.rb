class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.19"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.19/menuki-osx-arm64.tar.gz"
      sha256 "e9b84882ead433e0b36be5671fa62dbe756532863c541732c37fc8aa856f4d6b"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.19/menuki-osx-x64.tar.gz"
      sha256 "ec59e1a9da3e766397413a0f3618045af21f2e562405082e208c7fd551ee6ec1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.19/menuki-linux-arm64.tar.gz"
      sha256 "ab6e18a28e4442e492d9fd6c7fbf29d3b1c371268a3bb97f485183f5174d1c2f"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.19/menuki-linux-x64.tar.gz"
      sha256 "be04b70eedcc4bfe38b8aa14e03c8924984c89599a9ad74a2b932fe5cc93cac5"
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
