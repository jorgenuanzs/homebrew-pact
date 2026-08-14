class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "831827c407b6a46dcba18f958e5c84c5e53d8dddfddadb3150741a540f95c394"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.11.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e0e52b636d0ead83019ea2f881aea78463a1324a35810e70ee3c5c9d6ca5e54c"
    sha256 cellar: :any,                 x86_64_linux: "d9de5e5ba320faab8f6ff9fb78b024be86b9b46cb0619b4c719104673548a452"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=86e0da88e829c706f131be2773668221b7accd3b
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-14T16:10:49Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
