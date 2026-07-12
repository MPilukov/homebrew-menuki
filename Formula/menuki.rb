class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.3/menuki-osx-arm64.tar.gz"
      sha256 "857506e0c5992476face16f57f5b3321453f31cfb82cfe3183c53a55646ae625"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.3/menuki-osx-x64.tar.gz"
      sha256 "91f78010acb4766f7b05d1da17e8d721df19bc9f39cc1388fa68dde86286b58f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.3/menuki-linux-arm64.tar.gz"
      sha256 "db37335753e1bc3c8d366a3055eff3953bc2d060ab81a3e49f8775c5a332dfe5"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.3/menuki-linux-x64.tar.gz"
      sha256 "a9a55901b47c2726923601a9002ada8cdd523b1947ddcb377c1d7850b907cda2"
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
