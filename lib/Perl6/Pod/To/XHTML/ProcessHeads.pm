package Perl6::Pod::To::XHTML::ProcessHeads;

#$Id: ProcessHeads.pm 582 2009-07-26 09:04:44Z zag $

=pod

=head1 NAME

Perl6::Pod::To::XHTML::ProcessHeads - convert heads to sections

=head1 SYNOPSIS

    use Perl6::Pod::To::XHTML::ProcessHeads;
    $self->{out_put} =
    create_pipe( 'Perl6::Pod::To::XHTML::ProcessHeads', $self->{out_put});


=head1 DESCRIPTION

Perl6::Pod::To::XHTML::ProcessHeads - convert heads to sections

=cut

use warnings;
use strict;
use XML::ExtOn;
use base 'XML::ExtOn';

sub on_start_element {
    my ($self, $el ) = @_;
    my $lname = $el->local_name;
    return $el if exists $el->{XHTML_HEAD};
    if ($lname eq 'headlevel') {
        #save current level
        $self->{CURRENT_LEVEL} = $el->attrs_by_name->{level};
        %{ $el->attrs_by_name  } = ();
        $el->delete_element;
    } elsif ($lname =~ /^head/) {
        #set h to current level
        $el->local_name('h'.$self->{CURRENT_LEVEL});
    }
    $el;
}
1;