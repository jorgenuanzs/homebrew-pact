class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "de68cc0107e4c880e80f9ba825f8755abdbbb412587a29f95c2ae27f0d986181"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1a914cf89c7dabce1752e906777abc67ba82d2ce254ef7490af1908054c5bcb3"
    sha256 cellar: :any,                 x86_64_linux: "99d4d0766b7f8aa418cd033c74d1ad79232c49db30599926f654ebd46e0b16d5"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=0e41d3de6975c5ab5b1c52b59758c92204c845a2
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-14T09:07:54Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
