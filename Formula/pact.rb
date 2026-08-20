class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "903d6de9205ee1accbb63b844c3739bfdf999d32b84c66fb8b1e9a605160307e"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/jorgenuanzs/homebrew-pact/releases/download/pact-0.14.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "29539aa80bbc46f12a529a64b6b56d983f7b711ef683cb7e2f63c620eeca86f8"
    sha256 cellar: :any,                 x86_64_linux: "0106b0b57cf847f528bfdb3dad2113359fa417c37f9ca7a56132705aaff6370c"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=4bd8c2536037c1eec5171f35734053be038dfa69
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-20T16:00:50Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
