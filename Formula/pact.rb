class Pact < Formula
  desc "Live coordination and shared context for people and AI coding agents"
  homepage "https://github.com/jorgenuanzs/the-pact"
  url "https://github.com/jorgenuanzs/the-pact/archive/refs/tags/v0.16.7.tar.gz"
  sha256 "aba7c3f919bf2e2f17fe09b8d0a9621f2c800ebf3ea5c05202585428db07cf0a"
  license "Apache-2.0"
  head "https://github.com/jorgenuanzs/the-pact.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Version=v#{version}
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Commit=77754a54267ff08bef475bcd5fcb6363a66f317a
      -X github.com/jorgenuanzs/the-pact/internal/buildinfo.Date=2026-08-21T13:55:19Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pact"
  end

  test do
    assert_match %Q("version":"v#{version}"), shell_output("#{bin}/pact version")
    assert_match "pact mcp serve", shell_output("#{bin}/pact help")
  end
end
