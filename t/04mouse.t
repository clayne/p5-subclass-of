=pod

=encoding utf-8

=head1 PURPOSE

Basic test in Mouse.

=head1 DEPENDENCIES

Test requires Mouse 1.00 or will be skipped.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

use lib "t/lib";
use lib "lib";

use strict;
use warnings;
use Test::More;
use Test::Requires { "Mouse" => "1.00" };

{
	use Subclass::Of "Local::Mouse::Class",
		-with     => ["Local::Mouse::Role"],
		-methods  => [
			foo => sub { uc(::SUPER()) },
			bar => sub { "BAR" },
			baz => sub { "BAZ" },
		];
	
	my $object = Class->new;
	
	isa_ok($object, 'Local::Mouse::Class');
	isa_ok($object, 'Mouse::Object');
	ok($object->DOES('Local::Mouse::Role'), q[$object->DOES('Local::Mouse::Role')]);
	can_ok($object, qw[foo bar baz]);
	is($object->foo, 'FOO', q[$object->foo]);
	is($object->bar, 'BAR', q[$object->bar]);
	is($object->baz, 'BAZ', q[$object->baz]);
}

ok(!eval "Class; 1", 'namespace::clean worked');

done_testing;