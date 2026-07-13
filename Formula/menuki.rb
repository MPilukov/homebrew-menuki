class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.6/menuki-osx-arm64.tar.gz"
      sha256 "fe23ee9148585ea9b73b83e569ada301986df21917c089f83115609d3cbcab1a"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.6/menuki-osx-x64.tar.gz"
      sha256 "3b3c6b7cd08a0006f9279634d471ace245d7fc3d79f567d43eb83d7de1695d31"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.6/menuki-linux-arm64.tar.gz"
      sha256 "b034d629edad1908afc03bbe97c4d9b5b6a4549e5ebc4177ed9d5757b632c0d4"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.6/menuki-linux-x64.tar.gz"
      sha256 "b6c4ad0ce96dc94c7b079e6b99993c5e12fdc7030213afc711f93222fda54abe"
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
