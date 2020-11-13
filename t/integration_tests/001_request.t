#! perl

use strict;
use warnings;

use Test::More;
use JSON;

use Badger::Utils::Request;

subtest 'get' => sub {
    my $some_array = ['something', 'something else'];
    my $response = Badger::Utils::Request::get('https://httpbin.org', '/get', {
        test_scalar => 'something',
        test_array  => $some_array,
    });

    ok($response->is_success, 'Successful GET call');
    is($response->code, 200, 'Expected response status');

    $response = decode_json($response->decoded_content());

    is($response->{args}->{test_scalar}, 'something', 'Scalar parameter sent correctly');
    is_deeply($response->{args}->{test_array}, $some_array, 'Arrayref parameter sent correctly');
};

subtest 'post' => sub {
    my $some_array = ['something', 'something else'];
    my $some_hash = { foo => 'bar' };
    my $response = Badger::Utils::Request::post('https://httpbin.org', '/post', {
        test_scalar => 'something',
        test_array  => $some_array,
        test_hash   => $some_hash
    });

    ok($response->is_success, 'Successful POST call');
    is($response->code, 200, 'Expected response status');

    $response = decode_json($response->decoded_content());

    is($response->{json}->{test_scalar}, 'something', 'Scalar parameter sent correctly');
    is_deeply($response->{json}->{test_array}, $some_array, 'Arrayref parameter sent correctly');
    is_deeply($response->{json}->{test_hash}, $some_hash, 'Hashref parameter sent correctly');
};

done_testing();
