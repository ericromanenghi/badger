#! perl

use strict;
use warnings;

use Test::More;

use Badger::Plaid::Client;

subtest 'sandbox_public_token_create' => sub {
    my $plaid_client = Badger::Plaid::Client->new(
        config_file => 'config/plaid/client_sandbox.yaml'
    );

    my $response = $plaid_client->sandbox_public_token_create({
       institution_id   => 'ins_122899',
       initial_products => ['auth', 'transactions'],
    });

    ok(defined $response, "Request didn't failed");
    ok(defined $response->{public_token}, "public_token is defined");
    ok(defined $response->{request_id}, "request_id is defined");
};

done_testing();
