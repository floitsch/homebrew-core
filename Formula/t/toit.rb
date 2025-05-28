class Toit < Formula
  desc "The Toit language SDK"
  homepage "https://toitlang.org"
  url "https://github.com/toitlang/toit/releases/download/v2.0.0-alpha.180/toit-v2.0.0-alpha.180-with-submodules.tar.gz"
  sha256 "ca6dbaf1da00baddc5257b51a7155f7ae15dea8722795e024d463bcda0efaf1e"
  license "LGPL-2.1"

  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "pkgconf" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "--preset=default", *std_cmake_args
  end

  test do
    assert_match "Version:\t v#{version}", shell_output(bin/"toit version")

    (testpath/"hello.toit").write <<~TOIT
      main:
        print "Hello, world!"
    TOIT

    assert_match "Hello, world!", shell_output(bin/"toit run #{testpath}/hello.toit 2>&1", 1)
  end
end
