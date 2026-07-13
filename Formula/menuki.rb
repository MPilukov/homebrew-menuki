class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.5/menuki-osx-arm64.tar.gz"
      sha256 "4788a1c2d6f9a2d7fbab564d23121c423856e29527badee9d695907a8421a11d"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.5/menuki-osx-x64.tar.gz"
      sha256 "e442c2c2631fb2c5b14cc64ef7222c3f4785c8a067cd61ad4d88b825b635ffc9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.5/menuki-linux-arm64.tar.gz"
      sha256 "df5fbf2c60db1b46eb2edb331e10013c6e327df39eb8e2d8c98f8b634ccfe549"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.5/menuki-linux-x64.tar.gz"
      sha256 "e249131849ffb66629bd9137528d4e3ba6485e4a44c550704a2cf651c0582480"
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
