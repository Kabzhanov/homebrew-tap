class Aisentinel < Formula
  desc "Security, control, and observability layer for AI agents (MCP server + sidecar)"
  homepage "https://github.com/Kabzhanov/AISentinel"
  url "https://github.com/Kabzhanov/AISentinel/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "b78f1c5ddc7848e8863ab32b5921e3dfcd53aa2654e6b1660cbc4ba98bc57ec9"
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
