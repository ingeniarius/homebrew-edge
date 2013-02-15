require 'formula'

class Haproxy < Formula
  homepage 'http://haproxy.1wt.eu'
  head 'http://haproxy.1wt.eu/download/1.5/src/snapshot/haproxy-ss-LATEST.tar.gz'

  depends_on 'pcre'
  depends_on 'openssl'

  def install
    args = [
      "TARGET=generic",
      "USE_KQUEUE=1",
      "USE_POLL=1",
      "USE_PCRE=1",
      "USE_ZLIB=1",
      "USE_OPENSSL=1",
      "ADDLIB=-L#{prefix}/opt/openssl/lib",
      "ADDINC=-I#{prefix}/opt/openssl/include"
    ]

    # We build generic since the Makefile.osx doesn't appear to work
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}", "LDFLAGS=#{ENV.ldflags}", *args
    man1.install "doc/haproxy.1"
    bin.install "haproxy"
  end
end
