class DafnyAT197 < Formula
  desc "Verification-aware programming language"
  homepage "https://www.microsoft.com/en-us/research/project/dafny-a-language-and-program-verifier-for-functional-correctness"
  url "https://github.com/dafny-lang/dafny/releases/download/v1.9.7/Dafny.1.9.7.for.Mac.OSX.zip"
  sha256 "10af132e1173db4aadf0e5dc4615d56118a54d826bf2d8fb7268d71c0d7ea856"

  bottle :unneeded

  depends_on "mono"
  depends_on "z3"

  def install
    rm_rf Dir["z3/bin/*"]
    ln_s which("z3"), "z3/bin/z3"
    libexec.install Dir["*"]
    (bin/"dafny1.9.7").write <<~EOS
      #!/bin/bash
      mono #{libexec}/dafny.exe "$@"
    EOS
  end

  test do
    (testpath/"test.dfy").write <<~EOS
      method Main() {
        print "hello, Dafny\\n";
      }
    EOS
    system "#{bin}/dafny", testpath/"test.dfy"
  end
end
