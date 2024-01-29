class CalIdn < Formula
    desc "Indonesian Calendar CLI"
    homepage "https://github.com/arham09/cal-idn"
    url "https://github.com/arham09/cal-idn/archive/refs/tags/v1.0.0.tar.gz"
    sha256 "f366b6be9f43f5e166c698e6805c47e0868d2eb1"
  
    depends_on "go" => :build
  
    def install
      ENV["GOPATH"] = buildpath
      (buildpath/"src/github.com/arham09/cal-idn").install Dir["*"]
      system "go", "build", "-o", "#{bin}/cal-idn", "-v", "github.com/arham09/cal-idn"
    end
  
    test do
      # Test your Golang program
      assert_match "version #{version}", shell_output("#{bin}/cal-idn --version")
    end
end