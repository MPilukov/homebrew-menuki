class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.4/menuki-osx-arm64.tar.gz"
      sha256 "8e8bac175579576e1f3ce0277778e7b6c38cab8f51e8deb012e42b7efa0d7b44"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.4/menuki-osx-x64.tar.gz"
      sha256 "5ac4be1932442350633b122c354930c484c2e0245c6e30ff41afa961b0981f0c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.4/menuki-linux-arm64.tar.gz"
      sha256 "deba8fbf0efa05bb913899c958c8dd63b967b770a72f3b5387dcfdceb826da46"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.4/menuki-linux-x64.tar.gz"
      sha256 "28b1f4ef8b281da12d04af4ca8a961dafc54175efd7f539fd25326b82ba201dc"
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
