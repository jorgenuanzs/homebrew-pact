class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "59f34beb2b4186547bd7e3f700bba821e9c167863670053ec1280ac111055206"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.10.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6ffe0924967d6dda9f48e7c0384c2c8dad87c5ec949dfa4f0989ac0489407a65"
    sha256 cellar: :any,                 x86_64_linux: "59a82c57416f82ded15c645a7ad5226c53fc73bbdfa4a96412a117340017dc7e"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=78df5790dbbeafc850fc5f11877e1eb2c5b61c66
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-14T14:31:21Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
