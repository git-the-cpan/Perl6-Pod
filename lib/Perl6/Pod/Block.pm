package Perl6::Pod::Block;

#$Id: Block.pm 547 2009-05-25 18:01:48Z zag $

=pod

=head1 NAME

Perl6::Pod::Block - base class for Perldoc blocks

=head1 SYNOPSIS


=head1 DESCRIPTION

Perl6::Pod::Block - base class for Perldoc blocks

=cut

use strict;
use warnings;
use Data::Dumper;
use XML::ExtOn::Element;
use XML::ExtOn::Context;
use base 'XML::ExtOn::Element';

sub new {
    my ( $class, %args ) = @_;
    my $doc_context = new XML::ExtOn::Context::;
    my $self =
      $class->SUPER::new( context => $doc_context, name => $args{name} );
    #save orig context
    $self->{__context}     = $args{context} || die 'need context !';
    $self->{_pod_options} = $args{options} || '';
    $self;
}

sub context {
    $_[0]->{__context};
}

=head2 mk_block <BLOCK_NAME>, <POD_OPTIONS>

Create block element.

=cut

sub mk_block {
    my $self = shift;
    my ( $name, $pod_opt ) = @_;
    my $mod_name = $self->context->use->{$name} || 'Perl6::Pod::Block';# or die "Unknown block_type $name. Try =use ...";
    #get prop
    my $block = $mod_name->new(
      name    => $name,
      context => $self->context,
      options => $pod_opt);
    return $block;

}

sub start {
    my ( $self, $attr ) = @_;
}

sub end {
    my ( $self, $attr ) = @_;
}

sub get_attr {
    my $self           = shift;
    my $context        = $self->context;
    #warn $context->config;
    my $pre_config_opt = $context->config->{ $self->local_name } || '';
    my $opt            = $self->{_pod_options};
    my $hash           = $context->_opt2hash( $pre_config_opt . " " . $opt );
    my %res            = ();
    while ( my ( $key, $val ) = each %$hash ) {
        $res{$key} = $val->{value};
    }
    \%res;
}

#default export methods

sub to_xml {
    my $self  = shift;
    my $parser = shift;
    my $ln = $self->local_name;
    my $attr = $self->get_attr;
    my $attr_str = '';
    while ( my ( $key, $val ) = each %$attr ) {
        $attr_str .= qq/$key = "$val"/
    }
    return qq"<$ln $attr_str >@_</$ln>"
}


1;
__END__


=head1 SEE ALSO

L<http://perlcabal.org/syn/S26.html>

=head1 AUTHOR

Zahatski Aliaksandr, <zag@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Zahatski Aliaksandr

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
