class CalIdn < Formula
    desc "Indonesian Calendar CLI"
    homepage "https://github.com/arham09/cal-idn"
    url "https://github.com/arham09/cal-idn/archive/refs/tags/v1.0.1.tar.gz"
    head "https://github.com/arham09/cal-idn"
    revision 1
    sha256 "a596026c29c8aec81bb4e4011c84f0c07a5c55c6afba9b0217590ec310199dd9"
  
    depends_on "go" => :build
  
    def install
        ENV["GOPATH"] = buildpath
        path = buildpath/"src/github.com/arham09/cal-idn"
        path.install Dir["*"]
        cd path do
          system "go", "build", "-o", "#{bin}/cal-idn"
        end
    end
  
    test do
        system "true"
    end
end