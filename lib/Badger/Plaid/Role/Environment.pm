package Badger::Plaid::Role::Environment;

use Moose::Role;
use Moose::Util::TypeConstraints;

has 'environment' => (
    is      => 'ro',
    isa     => enum([qw(sandbox development production)]),
    lazy    => 1,
    builder => '_build_environment',
);

has 'uri' => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_uri',
);

sub is_sandbox {
    my ($self) = @_;

    return $self->environment eq 'sandbox';
}

sub is_development {
    my ($self) = @_;

    return $self->environment eq 'development';
}

sub is_production {
    my ($self) = @_;

    return $self->environment eq 'production';
}

sub _build_uri {
    my ($self) = @_;

    my %env_to_uri = (
        sandbox     => 'https://sandbox.plaid.com',
        development => 'https://development.plaid.com',
        production  => 'https://production.plaid.com',
    );

    return $env_to_uri{$self->environment};
}

sub _build_environment {
    my ($self) = @_;

    return $self->config->get('environment');
}

1;
