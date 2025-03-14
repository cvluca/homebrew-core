class Pnpm < Formula
  require "language/node"

  desc "📦🚀 Fast, disk space efficient package manager"
  homepage "https://pnpm.io/"
  url "https://registry.npmjs.org/pnpm/-/pnpm-6.32.11.tgz"
  sha256 "38f9d94a8151ac80c429000d02ba7a0573e07e45eaeffc59ff0ab70c4b2a7da8"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/pnpm/latest"
    regex(/["']version["']:\s*?["']([^"']+)["']/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f12db0a8c2b087bf20c5564d6c722ca00a5ef43c9daf59ba3444060a25b4b2bb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f12db0a8c2b087bf20c5564d6c722ca00a5ef43c9daf59ba3444060a25b4b2bb"
    sha256 cellar: :any_skip_relocation, monterey:       "d8e313dca52300488ce1cba31f341b108ca46020625a4322d71eabfeac1055ba"
    sha256 cellar: :any_skip_relocation, big_sur:        "d9f507b4fe9f99368d5e001ea56585ee9f28592505ffc9d5feab502d0b01c8fc"
    sha256 cellar: :any_skip_relocation, catalina:       "d9f507b4fe9f99368d5e001ea56585ee9f28592505ffc9d5feab502d0b01c8fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f12db0a8c2b087bf20c5564d6c722ca00a5ef43c9daf59ba3444060a25b4b2bb"
  end

  depends_on "node"

  conflicts_with "corepack", because: "both installs `pnpm` and `pnpx` binaries"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/pnpm", "init", "-y"
    assert_predicate testpath/"package.json", :exist?, "package.json must exist"
  end
end
