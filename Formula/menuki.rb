class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.14/menuki-osx-arm64.tar.gz"
      sha256 "cdf0e33f501d2fdbf072c6cf162270cebe8a6baa084d61bb4b0b4e12866e8dab"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.14/menuki-osx-x64.tar.gz"
      sha256 "02f65db75b6cc990a8c5b81779a199f3fd2c6c6a3fb00317724dce76651222e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.14/menuki-linux-arm64.tar.gz"
      sha256 "6c85b99416d58f828fbb066b3b94df376dfaea516a3fb9f61c25b40ab6e4b9f1"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.14/menuki-linux-x64.tar.gz"
      sha256 "5e165d3224ab49a5cf4a92357cbd358d7a498559a500526608d639d8bdd11fb7"
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
