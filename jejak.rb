class Jejak < Formula
  desc "Repository intelligence and change-impact CLI for Go codebases"
  homepage "https://github.com/arham09/jejak"
  url "https://github.com/arham09/jejak/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "8a04957e9e4ace181890fdf9a7fcd890c2b2fefdf9c9e55b117ab9caa0afc482"
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
