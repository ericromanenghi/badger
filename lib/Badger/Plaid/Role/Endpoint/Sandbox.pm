package Badger::Plaid::Role::Endpoint::Sandbox;

use Moose::Role;
use JSON;

use Badger::Utils::Request;

sub sandbox_public_token_create {
    my ($self, $args) = @_;

    if (!$self->is_sandbox) {
        warn "Only sandbox environment is supported";
        return;
    }

    if (!$args->{institution_id}) {
        warn "institution_id is required";
        return;
    }

    if (!$args->{initial_products}) {
        warn "initial_products is required";
        return;
    }

    my $response = Badger::Utils::Request::post($self->uri, '/sandbox/public_token/create', {
        client_id        => $self->client_id,
        secret           => $self->secret,
        institution_id   => $args->{institution_id},
        initial_products => $args->{initial_products},
    });

    if($response->code != 200) {
        warn "Request to /sandbox/public_token/create failed: " . $response->message;
        return;
    }

    $response = decode_json($response->decoded_content());

    return $response;
}

1;
