class Aisentinel < Formula
  desc "AI governance CLI and MCP server (ATI collector, policy validator)"
  homepage "https://github.com/Kabzhanov/AISentinel"
  url "https://github.com/Kabzhanov/AISentinel/archive/refs/tags/v1.0.7.tar.gz"
  sha256 "75213fe4149282773be83faf262fdabf82bb0d8cca289c54846e70ea379fe1b7"
  license "Apache-2.0"
  head "https://github.com/Kabzhanov/AISentinel.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest_tag
  end

  depends_on "go" => :build

  def install
    # brew's Version class is not a Ruby String, so build a custom flag set.
    ver = build.head? ? "HEAD" : version.to_s
    ldflags = %W[
      -s -w
      -X main.version=#{ver}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/aisentinel"
  end

  test do
    # The Go binary hard-codes "1.0.6" in its banner, so check that literal
    # rather than `version.to_s` (which differs between stable and HEAD).
    assert_match "1.0.6", shell_output("#{bin}/aisentinel version")
  end
end
