module libraw.version_;

import libraw : libraw_versionNumber;

enum LIBRAW_MAJOR_VERSION = 0;
enum LIBRAW_MINOR_VERSION = 20;
enum LIBRAW_PATCH_VERSION = 0;
enum LIBRAW_VERSION_TAIL = "WorkInProgress";

enum LIBRAW_SHLIB_CURRENT = 19;
enum LIBRAW_SHLIB_REVISION = 0;
enum LIBRAW_SHLIB_AGE = 0;

string LIBRAW_VERSION_MAKE(A, B, C, D)(A a, B b, C c, D d)
{
	import std.format : format;
	return format("%s.%s.%s-%s", a, b, c, d);
}

enum LIBRAW_VERSION_STR =
	LIBRAW_VERSION_MAKE(LIBRAW_MAJOR_VERSION, LIBRAW_MINOR_VERSION, LIBRAW_PATCH_VERSION, LIBRAW_VERSION_TAIL);

auto LIBRAW_MAKE_VERSION(A, B, C)(A major, B minor, C patch) { return (major << 16) | (minor << 8) | patch; }

enum LIBRAW_VERSION = LIBRAW_MAKE_VERSION(LIBRAW_MAJOR_VERSION, LIBRAW_MINOR_VERSION, LIBRAW_PATCH_VERSION);

auto LIBRAW_CHECK_VERSION(A, B, C)(A major, B minor, C patch) { return libraw_versionNumber() >= LIBRAW_MAKE_VERSION(major, minor, patch); }

auto LIBRAW_RUNTIME_CHECK_VERSION_EXACT()()
{
	return (libraw_versionNumber() & 0xffff00) == LIBRAW_MAKE_VERSION(LIBRAW_MAJOR_VERSION, LIBRAW_MINOR_VERSION, 0);
}

auto LIBRAW_RUNTIME_CHECK_VERSION_NOTLESS()()
{
	return (libraw_versionNumber() & 0xffff00) >= LIBRAW_MAKE_VERSION(LIBRAW_MAJOR_VERSION, LIBRAW_MINOR_VERSION, 0);
}

auto LIBRAW_COMPILE_CHECK_VERSION(A, B)(A major, B minor) { return LIBRAW_MAKE_VERSION(major, minor, 0) == (LIBRAW_VERSION & 0xffff00); }

auto LIBRAW_COMPILE_CHECK_VERSION_NOTLESS(A, B)(A major, B minor) {
	return LIBRAW_MAKE_VERSION(major, minor, 0) <= (LIBRAW_VERSION & 0xffff00);
}
