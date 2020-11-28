{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "geth";
  version = "1.9.23";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "go-ethereum";
    rev = "v${version}";
    sha256 = "0w65sln5l3sxwzxwjvyaial0m1kxhivhw8xwl5faxxxlk50rs4wm";
  };

  vendorSha256 = "1qbg44cryiv9kvcak6qjrbmkc9bxyk5fybj62vdkskqfjvv86068";
  runVend = true;

  subPackages = [
    "cmd/geth"
    "cmd/abigen"
    "cmd/bootnode"
    "cmd/evm"
    "cmd/rlpdump"
    "cmd/puppeth"
  ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/ledgerwatch/turbo-geth/";
    description = "Ethereum node and geth fork focused on scalability and modularity";
    license = with licenses; [ lgpl3 gpl3 ];
    maintainers = with maintainers; [ xwvvvvwx ];
  };
}
