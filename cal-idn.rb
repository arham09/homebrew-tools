class CalIdn < Formula
    desc "Indonesian Calendar CLI"
    homepage "https://github.com/arham09/cal-idn"
    url "https://github.com/arham09/cal-idn/archive/refs/tags/v1.0.0.tar.gz"
    head "https://github.com/arham09/cal-idn"
    revision 1
    sha256 "1de9667512f8f48a8438f6a0d39d8a9c1b0737ecbb7f1d7b4fa2a8450233e2e1"
  
    depends_on "go" => :build
  
    def install
        ENV["GOPATH"] = buildpath
        path = buildpath/"src/github.com/arham09/cal-idn"
        system "go", "get", "-u", "github.com/arham09/cal-idn"
        cd path do
          system "go", "build", "-o", "#{bin}/cal-idn"
        end
    end
  
    test do
        system "true"
    end
end