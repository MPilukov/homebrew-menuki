class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.1/menuki-osx-arm64.tar.gz"
      sha256 "dd1dfdc83e0cb984b6221ec9f9dda24cdb2d798afb10aba371c01aebecccbdac"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.1/menuki-osx-x64.tar.gz"
      sha256 "f121b3c405c582cb9b08bd1c4f39e17d89bff8621251c4f3888a5be854b32d8d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.1/menuki-linux-arm64.tar.gz"
      sha256 "8ab77fd5651f1abf5d59d763e8b801f2aa688c18e4bcc436be80af0e98f4073b"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.1/menuki-linux-x64.tar.gz"
      sha256 "c951eeffcb3b061ab50e95eb47c047cd121a98651974aeea91beb295bb9337f4"
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
