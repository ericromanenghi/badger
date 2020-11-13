#! perl

use strict;
use warnings;

use Test::More;

use Badger::Plaid::Client;

subtest 'config, expected case' => sub {
    my $plaid_client = Badger::Plaid::Client->new(config_file => 't/resources/plaid_config.yaml');

    is('some_client_id', $plaid_client->client_id, 'Client id was properly set');
    is('some_secret', $plaid_client->secret, 'Secret was properly set');
};

done_testing();
