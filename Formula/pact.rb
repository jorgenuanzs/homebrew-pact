class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.16.8.tar.gz"
  sha256 "c870ca4e10fd0aacbc3e33266076d6d34655149910412a8a0e3a56d3be3b5614"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.16.8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "18e0c4c1ab879f54a646087fe72105a39bd8a638910b3a7e53d06190d960cc50"
    sha256 cellar: :any,                 x86_64_linux: "276239966d0ca53bfe54bd7b77ea66d61df89abeb8944011bd3e455957f30107"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=0f2d48e04f029133bf275fcfa11de87aa27b40d2
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-24T13:06:36Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
