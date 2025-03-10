class Cranecloud < Formula
    include Language::Python::Virtualenv

    desc "CraneCloud CLI tool"
    homepage "https://github.com/crane-cloud/cranecloud-cli"
    url "https://files.pythonhosted.org/packages/source/c/cranecloud/cranecloud-0.0.5.tar.gz"
    sha256 "f7242445a3c9f1452b37f762363d2f23af4c4fc06177595187f12372074b123a"
    license "MIT"

    depends_on "python@3.11"
  
    def install
        virtualenv_install_with_resources

        # Create a wrapper script that sets the environment variable
        (bin/"cranecloud-with-env").write <<~EOS
        #!/bin/bash
        export API_BASE_URL="https://api.cranecloud.io"
        exec "#{bin}/cranecloud" "$@"
        EOS
        chmod 0755, bin/"cranecloud-with-env"
    end
  
    test do
      system "#{bin}/cranecloud", "--help"
    end
  end
  