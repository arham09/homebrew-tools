class CalIdn < Formula
    desc "Indonesian Calendar CLI"
    go_resource "github.com/arham09/cal-idn" do
        url "https://github.com/arham09/cal-idn.git",
            :revision => "03633db83450b4a695e57c7f0632ca6a1304c152"  # Replace with the specific commit or version
      end
  
    depends_on "go" => :build
  
    def install
        system "go", "build", "-o", "#{bin}/cal-idn", "main.go"
      end
  
    test do
      # Test your Golang program
      assert_match "version #{version}", shell_output("#{bin}/cal-idn --version")
    end
end