class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "deb89b6ff5fe679755dcfb31871449954754c9b42c35bb747451c3cc34a0ca2f"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.9.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5af81dfaafb4a6466e6080010cc3ef28fc22f5a090a0e394fbbff1a5051e656c"
    sha256 cellar: :any,                 x86_64_linux: "375b72d312f0cf42969b18c239752cb978b769fbec097bb4045707a5a74aeea7"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=5e7f64dc6ca58e4e818b8ef3e400a6a8f28c2961
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-14T13:07:19Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
