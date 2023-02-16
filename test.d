/+ dub.sdl:
	name "test"
	dependency "libraw" path="."
+/
module test;

import libraw;

void main()
{
	auto lr = libraw_init(LibRaw_constructor_flags.NONE);
	assert(lr !is null);
	libraw_close(lr);
}
