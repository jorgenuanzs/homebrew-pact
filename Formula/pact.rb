class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.16.5.tar.gz"
  sha256 "6404ed1e4ea8e3ab8c6456bf42f35180dec77665494008dcc5cdc394109e6996"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.15.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "57b7ae7c108f6519fc90dd16b531d429ad3cf7eff1209c969448fd80cc90f096"
    sha256 cellar: :any,                 x86_64_linux: "4ead061e6c2b15ab25635cae238b35a4162d9ca84d51d955e74051178c51f048"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=f315efee5f14fb3e4670674ec5cb9171235ad98a
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-20T17:38:13Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
