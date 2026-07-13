class Menuki < Formula
  desc "Interactive terminal menus and runbooks from a single JSON file"
  homepage "https://github.com/MPilukov/menuki"
  version "0.1.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.7/menuki-osx-arm64.tar.gz"
      sha256 "87661dba2e3999b6c7fe04d2674084a36cba1c995af43417d9b8417ce2b27685"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.7/menuki-osx-x64.tar.gz"
      sha256 "18270899cc13c17ee93442cdc0032ad5403e50bff1fe47f43bf18d2f3a6e07db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.7/menuki-linux-arm64.tar.gz"
      sha256 "e3f8fbb9db6ec3f3c3985def2b20599104766c9bff96e35ef01ff8957a3fa1b2"
    end
    on_intel do
      url "https://github.com/MPilukov/menuki/releases/download/v0.1.7/menuki-linux-x64.tar.gz"
      sha256 "2b97a2ad9c5ac2119a39cd4ebc70e39d4acebd70309c5196a0a034eda1928de3"
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
