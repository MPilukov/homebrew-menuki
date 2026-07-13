class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.9/menuki-osx-arm64.tar.gz"
      sha256 "b8318787da7326aed7b7804df3911f01a63cd32f953c8ab14962a05076f3e3d9"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.9/menuki-osx-x64.tar.gz"
      sha256 "a4f2af8d89e8f4ef64f5a05461db28c93274f882ca3e352d87c3579444037689"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.9/menuki-linux-arm64.tar.gz"
      sha256 "1bbd77e0b01f3bae02cc4bcd91c6cc7431f4dd6fc53899324f50e8e68048c52c"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.9/menuki-linux-x64.tar.gz"
      sha256 "54cb0cc2a16d9a0797921d1dfa6594108daa7589919d892d7cab2fac23b0f891"
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
