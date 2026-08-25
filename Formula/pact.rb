class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.16.9.tar.gz"
  sha256 "9ae7fb534c5ffec70c012a65e549715ee2dd92aa5338e6370deca2a94c5ab56b"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.16.9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ed09edadd7ad8a03ebb80376c6df92d82666c7a9ec96949de9e0e57a6560b80d"
    sha256 cellar: :any,                 x86_64_linux: "168e38247a9f0a10d710438c5f7b31dc443d1ea046a2761c0eec5447fa528cd1"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=400b1f49d7a113dde5eae0db9aac0e43287d7d1d
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-25T09:35:41Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
