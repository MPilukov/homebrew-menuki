class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.2/menuki-osx-arm64.tar.gz"
      sha256 "435dbee0272016e68de072421f1178b61fd0d5213681b27b87aed26ec0f6dc86"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.2/menuki-osx-x64.tar.gz"
      sha256 "954d9f4aa8acc8b028a660b9a3c35115faaf19492d5ebd15c4ab29852d6ec044"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.2/menuki-linux-arm64.tar.gz"
      sha256 "1bfb193714547af89eef9089ecc9b37114271db291d6926c6aecd807b42d074f"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.2/menuki-linux-x64.tar.gz"
      sha256 "8e7fdaab9d8306dc6fda04f6f00ab40d733804fa3e229f70a17acec1968e4ac3"
    end
  end

  def install
    bin.install "menuki"
  end

  test do
    (testpath/"m.json").write <<~JSON
      {"title":"t","start_menu":"main","menus":{"main":{"items":[
        {"name":"x","action":{"type":"shell","command":"echo hi"}}]}}}
    JSON
    assert_match "\"ok\": true", shell_output("#{bin}/menuki validate --config #{testpath}/m.json")
  end
end
