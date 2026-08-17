class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "f4fc0baf1c45422d8a3f24b91c0c84b3cf3dce851f24900dc12b31318faffb75"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.13.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1feb8a3722fecb4237e103c53aac11852ba652cc423c33e682ca6e9f6fca067a"
    sha256 cellar: :any,                 x86_64_linux: "b08d578d36d5191fc1a39730ee955bf039d09a4a221bcaf110b81c3dbb34e21a"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=b11a063354bb8092cf9831f628c606cb2051f5f6
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-17T10:22:51Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
