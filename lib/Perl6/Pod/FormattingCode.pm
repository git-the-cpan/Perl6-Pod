package Perl6::Pod::FormattingCode;

#$Id: FormattingCode.pm 572 2009-07-07 17:46:25Z zag $

=pod

=head1 NAME

Perl6::Pod::FormattingCode - base class for formatting code

=head1 SYNOPSIS


=head1 DESCRIPTION

Perl6::Pod::FormattingCode - base class for formatting code

=cut

use warnings;
use strict;
use Perl6::Pod::Block;
use base 'Perl6::Pod::Block';
=head2 get_attr [code_name]

Return formatting code  attributes splited with pre-configured via =config.
Unless provided <code_name> return attributes for current .

=cut

sub get_attr {
    my $self = shift;
    my $name =  shift || $self->local_name;
    $self->SUPER::get_attr($name.'<>')
 
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

