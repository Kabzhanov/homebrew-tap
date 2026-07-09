class Aisentinel < Formula
  desc "AI governance CLI and MCP server: ATI collector, policy validator, audit log tailer"
  homepage "https://github.com/Kabzhanov/AISentinel"
  url "https://github.com/Kabzhanov/AISentinel/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "bf9b2b13e53bb5340f8e3a55435a1337d5479624f75ef0bc551d20905bf9bb4c"
  license "Apache-2.0"
  head "https://github.com/Kabzhanov/AISentinel.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest_tag
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version.is_a?(String) ? version : "HEAD"}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/aisentinel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aisentinel version")
    assert_match "validate-policy", shell_output("#{bin}/aisentinel 2>&1", 1)
  end
end
