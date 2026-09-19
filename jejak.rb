class Jejak < Formula
  desc "Repository intelligence and change-impact CLI for Go codebases"
  homepage "https://github.com/arham09/jejak"
  url "https://github.com/arham09/jejak/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "9f8612efc7a9deecaa4595616b52d37eac373a811d7ccf1e64171b32070a8213"
  head "https://github.com/arham09/jejak.git", branch: "main"

  depends_on "go" => :build
  depends_on "git"

  def install
    # Homebrew already supplies -s -w; only the release version is added.
    ldflags = "-X github.com/arham09/jejak/internal/cli.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/jejak"
  end

  test do
    # The linker stamps the release version, so the binary must report it.
    assert_match version.to_s, shell_output("#{bin}/jejak version")

    # The usage text lists the commands the agent workflow depends on.
    usage = shell_output("#{bin}/jejak --help")
    assert_match "Usage:", usage
    %w[init status impact context doctor].each do |command|
      assert_match command, usage
    end

    # Outside a Git repository the CLI must fail with a single clear error
    # instead of panicking or creating state.
    output = shell_output("#{bin}/jejak status 2>&1", 1)
    assert_match "jejak:", output
  end
end
