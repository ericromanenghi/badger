package Badger::Plaid::Client;

use Moose;

use Badger::Plaid::Config;

has 'client_id' => (
    is       => 'ro',
    isa      => 'Str',
    lazy     => 1,
    builder  => '_build_client_id',
    required => 1,
);

has 'secret' => (
    is       => 'ro',
    isa      => 'Str',
    lazy     => 1,
    builder  => '_build_secret',
    required => 1,
);

has 'config_file' => (
    is       => 'ro',
    isa      => 'Str',
    predicate => 'has_config_file',
);

has 'config' => (
    is       => 'ro',
    isa      => 'Badger::Plaid::Config',
    lazy     => 1,
    builder  => '_build_config',
    predicate => 'has_config',
);

with 'Badger::Plaid::Role::Endpoint::Sandbox';
with 'Badger::Plaid::Role::Environment';

sub _build_client_id {
    my ($self) = @_;

    return $self->config->get('client_id');
}

sub _build_secret {
    my ($self) = @_;

    return $self->config->get('secret');
}

sub _build_config {
    my ($self) = @_;

    die 'No config file provided' unless $self->has_config_file;

    die 'Provided config file does not exists' unless -e $self->config_file;

    return Badger::Plaid::Config->new(config_file => $self->config_file);
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
