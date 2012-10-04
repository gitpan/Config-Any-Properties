#  COPYRIGHT: © 2012 Peter Hallam

package Config::Any::Properties;
BEGIN {
  $Config::Any::Properties::AUTHORITY = 'cpan:PRAGMATIC';
}

#   ABSTRACT: Config::Any loader for Java-style property files
#    CREATED: Thu, 4 Oct 2012 05:03:25 UTC
#     AUTHOR: Peter Hallam <pragmatic@cpan.org>

use strict;
use warnings;
use v5.10;

our $VERSION = '0.001000'; # VERSION

use parent 'Config::Any::Base';

sub extensions {
    return qw{ properties props };
}

sub load {
    my ( $class, $file, $opts ) = @_;

    $opts = {} unless ref $opts eq 'HASH';

    eval {
        require Config::Properties;
    };
    unless ( $@ ) {
        my $decoder = Config::Properties->new(
            file => $file,
            %$opts,
        );

        return $decoder->splitToTree;
    }
}

sub requires_any_of {
    return qw{ Config::Properties };
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Config::Any::Properties - Config::Any loader for Java-style property files

=head1 VERSION

C<0.001000>

Released on Thursday, 4 October 2012.

=head1 SYNOPSIS

 use Config::Any;

 my $config = Config::Any->load_files({
     files       => \@files,
     use_ext     => 1,
 });

=head1 DESCRIPTION

Loads L<Config::Properties> property files.

=head1 METHODS

=head2 extensions

Return an array of valid extensions (C<properties>, C<props>).

=head2 load

Attempts to load C<$file> as a L<Config::Properties> file.

=head2 requires_any_of

Specifies that this module requires L<Config::Properties> in order to work.

=begin Pod::Coverage




=end Pod::Coverage

=head1 SEE ALSO

=over 4

=item *

L<Config::Properties>

=item *

L<Log::Any>

=item *

L<".properties" on Wikipedia|http://en.wikipedia.org/wiki/.properties>

=item *

L<Official Oracle java.util.Properties API|http://docs.oracle.com/javase/1.5.0/docs/api/java/util/Properties.html>

=back

=head1 AUTHOR

Peter Hallam <pragmatic@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright © 2012 Peter Hallam.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
