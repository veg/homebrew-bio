class Hyphy < Formula
  desc "Hypothesis testing with phylogenies"
  homepage "http://www.hyphy.org/"
  url "https://github.com/veg/hyphy/archive/2.3.14.tar.gz"
  sha256 "9e6c817cb649986e3fe944bcaf88be3533e7e62968b9a486c719e951e5ed1cf6"
  head "https://github.com/veg/hyphy.git"
  # tag "bioinformatics"

  bottle do
    sha256 "b19ac75cbe0ce6ca2eb4ebcfbe8cf9cda8f65fb230beb57eef2c8d77d75655ec" => :sierra
    sha256 "74b0628be9dddccc04b1a33c80ac25512fcc27e5f713eb51c7175a4a1a65096f" => :el_capitan
    sha256 "7a1525ce1e42fc359320dec513d9397b7d02190b9ce8bc0f892796494ca58db3" => :yosemite
  end

  option "with-opencl", "Build a version with OpenCL GPU/CPU acceleration"
  option "without-multi-threaded", "Don't build a multi-threaded version"
  option "without-single-threaded", "Don't build a single-threaded version"
  deprecated_option "with-mpi" => "with-open-mpi"

  depends_on "openssl"
  depends_on "cmake" => :build
  depends_on "open-mpi" => :optional

  def install
    system "cmake", "-DINSTALL_PREFIX=#{prefix}", ".", *std_cmake_args
    system "make", "MP"
    system "make", "MPI" if build.with? "open-mpi"
    system "make", "OCL" if build.with? "opencl"
    system "make", "GTEST"

    system "make", "install"
    libexec.install "HYPHYGTEST"
    doc.install("help")
  end

  def caveats; <<~EOS
    The help has been installed to #{doc}/hyphy.
    EOS
  end

  test do
    system libexec/"HYPHYGTEST"
  end
end

__END__
