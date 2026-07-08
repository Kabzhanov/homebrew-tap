class Aisentinel < Formula
  desc "Security, control, and observability layer for AI agents (MCP server + sidecar)"
  homepage "https://github.com/Kabzhanov/AISentinel"
  url "https://github.com/Kabzhanov/AISentinel/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "c0220f81449dd8825e68a80038f406e89f4c54e904fbcb2bc72a5f4e809d8f61"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"aisentinel", "./cmd/aisentinel"
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"aisentinel-sidecar", "./cmd/aisentinel-sidecar"
  end

  test do
    assert_match "aisentinel", shell_output("#{bin}/aisentinel version")
  end
end
