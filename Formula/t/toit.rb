class Toit < Formula
  desc "The Toit language SDK"
  homepage "https://toitlang.org"
  url "https://github.com/toitlang/toit/releases/download/v2.0.0-alpha.183/toit-v2.0.0-alpha.183-with-submodules.tar.gz"
  sha256 "2bb38edb4f8d06a7642edda40448f0fe39caf883ececf86aaeb53a4a2fb064c4"
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
