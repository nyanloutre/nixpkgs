import ./make-test.nix ({ lib, ...}:

{
  name = "bitcoin";
  meta.maintainers = with lib.maintainers; [ nyanloutre ];

  nodes = let
    bitcoin = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.bitcoin ];
      networking.firewall.allowedTCPPorts = [ 18444 ];
    };
  in {
    machine1 = bitcoin;
    machine2 = bitcoin;
  };

  testScript = ''
    startAll;
    $machine1->waitForUnit("multi-user.target");
    $machine2->waitForUnit("multi-user.target");
    
    $machine1->succeed("bitcoind -regtest -daemon");
    $machine1->waitForOpenPort('18444');

    $machine2->succeed("bitcoind -regtest -daemon -addnode=machine1");
    $machine2->waitForOpenPort('18444');

    $machine1->succeed("bitcoin-cli -regtest generate 101");

    my $info1 = $machine1->succeed("bitcoin-cli -regtest getblockchaininfo");
    my $info2 = $machine2->succeed("bitcoin-cli -regtest getblockchaininfo");
    die if $info1 ne $info2;

    my $adress = $machine2->succeed("bitcoin-cli -regtest getnewaddress");
    chomp $adress;

    $machine1->succeed("bitcoin-cli -regtest sendtoaddress $adress 20");
    $machine1->succeed("bitcoin-cli -regtest generate 10");
    my $balance = $machine2->succeed("bitcoin-cli -regtest getbalance");
    die if $balance < 20;
  '';
})
