class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.0/menuki-osx-arm64.tar.gz"
      sha256 "8a5874246496df5dfa5a0d1324eb125a909c07ff677bb6cc8966a336fb014d80"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.0/menuki-osx-x64.tar.gz"
      sha256 "81af1ae899799330e9dde6dd303f643fd4e49fae6a49f6dfc312d64b00dfc5c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.0/menuki-linux-arm64.tar.gz"
      sha256 "728c3632133a5a4fd8ea0491172ed4864dd73ad4ddf189cc57fb0673af28afca"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.0/menuki-linux-x64.tar.gz"
      sha256 "9452ff69e9a6a21600e2d4b66bb02ce74566be3742a7d4cd8f4ec266ebf219e3"
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
