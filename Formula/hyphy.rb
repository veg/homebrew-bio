class Hyphy < Formula
  desc "Hypothesis testing with phylogenies"
  homepage "http://www.hyphy.org/"
  url "https://github.com/veg/hyphy/archive/2.3.14.tar.gz"
  sha256 "9e6c817cb649986e3fe944bcaf88be3533e7e62968b9a486c719e951e5ed1cf6"
  head "https://github.com/veg/hyphy.git"
  # tag "bioinformatics"

  deprecated_option "with-mpi" => "with-open-mpi"

  depends_on "openssl"
  depends_on "cmake" => :build
  depends_on "open-mpi" => :optional

  def install
    system "cmake", "-DINSTALL_PREFIX=#{prefix}", ".", *std_cmake_args
    system "make", "MP"
    system "make", "MPI" if build.with? "open-mpi"
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
