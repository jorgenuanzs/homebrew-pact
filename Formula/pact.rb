class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "d20764467bcab36936987888533bc42253bd675f536dc7e34483212dd64df0a7"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.12.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6c510f2c495ab70dfb3253e7c80fb55c4e3e529990f93ab2c096fc6c128d07ca"
    sha256 cellar: :any,                 x86_64_linux: "0f0f9b084e4720be9b99f1fbdf5acdc072fb4fd2d4d466277f47e80da060b32f"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=9e6596515a3d8d8cce9ab7997357cf21a22eaa0b
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-15T00:09:42Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
