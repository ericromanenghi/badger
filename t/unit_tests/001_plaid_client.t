#! perl

use strict;
use warnings;

use Test::More;

require_ok('Badger::Plaid::Client');

subtest 'uri, sandbox' => sub {
    my $client = Badger::Plaid::Client->new(
        environment => 'sandbox',
    );

    is($client->uri, 'https://sandbox.plaid.com', 'sandbox uri, expected case');
};

subtest 'uri, development' => sub {
    my $client = Badger::Plaid::Client->new(
        environment => 'development',
    );

    is($client->uri, 'https://development.plaid.com', 'dev uri, expected case');
};

subtest 'uri, production' => sub {
    my $client = Badger::Plaid::Client->new(
        environment => 'production',
    );

    is($client->uri, 'https://production.plaid.com', 'production uri, expected case');
};

done_testing();
