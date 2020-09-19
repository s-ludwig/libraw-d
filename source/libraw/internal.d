module libraw.internal;

import libraw.datastream;
import libraw.types;

import core.stdc.stdio;

//extern(C++) class LibRaw_TLS;
//extern(C++) class LibRaw_constants;

/+#ifdef __cplusplus

#ifdef LIBRAW_LIBRARY_BUILD
#ifndef CLASS
#define CLASS LibRaw::
#endif
#endif

#else
#ifndef CLASS
#define CLASS
#endif
#endif

#ifdef __cplusplus

class LibRaw_TLS
{
public:
	struct
	{
		unsigned bitbuf;
		int vbits, reset;
	} getbits;
	struct
	{
		UINT64 bitbuf;
		int vbits;

	} ph1_bits;
	struct
	{
		unsigned pad[128], p;
	} sony_decrypt;
	struct
	{
		uchar buf[0x4002];
		int vpos, padding;
	} pana_data;
	uchar jpeg_buffer[4096];
	struct
	{
		float cbrt[0x10000], xyz_cam[3][4];
	} ahd_data;
	void init()
	{
		getbits.bitbuf = 0;
		getbits.vbits = getbits.reset = 0;
		ph1_bits.bitbuf = 0;
		ph1_bits.vbits = 0;
		pana_data.vpos = 0;
		ahd_data.cbrt[0] = -2.0f;
	}
};

class LibRaw_constants
{
public:
	static const float d65_white[3];
	static const double xyz_rgb[3][3];
};
#endif /* __cplusplus */

struct internal_data_t {
	LibRaw_abstract_datastream *input;
	FILE *output;
	int input_internal;
	char *meta_data;
	long profile_offset;
	long toffset;
	uint[4] pana_black;
}

enum LIBRAW_HISTOGRAM_SIZE = 0x2000;
struct output_data_t {
	int[LIBRAW_HISTOGRAM_SIZE]* histogram;
	uint* oprof;
}

struct identify_data_t {
	uint olympus_exif_cfa;
	uint unique_id;
	ulong OlyID;
	uint tiff_nifds;
	int tiff_flip;
}

struct unpacker_data_t {
	short order;
	ushort[4] sraw_mul;
	ushort[3] cr2_slice;
	uint kodak_cbpp;
	long strip_offset, data_offset;
	long meta_offset;
	uint data_size;
	uint meta_length;
	uint thumb_misc;
	uint fuji_layout;
	uint tiff_samples;
	uint tiff_bps;
	uint tiff_compress;
	uint zero_after_ff;
	uint tile_width, tile_length, load_flags;
	uint data_error;
	int hasselblad_parser_flag;
	long posRAFData;
	uint lenRAFData;
	int fuji_total_lines, fuji_total_blocks, fuji_block_width, fuji_bits, fuji_raw_type;
	int pana_encoding, pana_bpp;
}

struct libraw_internal_data_t {
	internal_data_t internal_data;
	libraw_internal_output_params_t internal_output_params;
	output_data_t output_data;
	identify_data_t identify_data;
	unpacker_data_t unpacker_data;
}

struct decode
{
	decode*[2] branch;
	int leaf;
}

struct tiff_ifd_t
{
	int t_width, t_height, bps, comp, phint, offset, t_flip, samples, bytes;
	int t_tile_width, t_tile_length, sample_format, predictor;
	int rows_per_strip;
	int *strip_offsets, strip_offsets_count;
	int *strip_byte_counts, strip_byte_counts_count;
	float t_shutter;
	/* Per-IFD DNG fields */
	long opcode2_offset;
	long lineartable_offset;
	int lineartable_len;
	libraw_dng_color_t[2] dng_color;
	libraw_dng_levels_t dng_levels;
}

struct jhead
{
	int algo, bits, high, wide, clrs, sraw, psv, restart;
	int[6] vpred;
	ushort[64] quant;
	ushort[64] idct;
	ushort[20]* huff;
	ushort[20]* free;
	ushort* row;
}

struct libraw_tiff_tag
{
	ushort tag, type;
	int count;
	union {
		char[4] c;
		short[2] s;
		int i;
	}
}

struct tiff_hdr
{
	ushort t_order, magic;
	int ifd;
	ushort pad, ntag;
	libraw_tiff_tag[23] tag;
	int nextifd;
	ushort pad2, nexif;
	libraw_tiff_tag[4] exif;
	ushort pad3, ngps;
	libraw_tiff_tag[10] gpst;
	short[4] bps;
	int[10] rat;
	uint[26] gps;
	char[512] t_desc;
	char[64] t_make;
	char[64] t_model;
	char[32] soft;
	char[20] date;
	char[64] t_artist;
}

#ifdef DEBUG_STAGE_CHECKS
#define CHECK_ORDER_HIGH(expected_stage)                                                                               \
	do                                                                                                                   \
	{                                                                                                                    \
		if ((imgdata.progress_flags & LIBRAW_PROGRESS_THUMB_MASK) >= expected_stage)                                       \
		{                                                                                                                  \
			fprintf(stderr, "CHECK_HIGH: check %d >=  %d\n", imgdata.progress_flags &LIBRAW_PROGRESS_THUMB_MASK,             \
							expected_stage);                                                                                         \
			return LIBRAW_OUT_OF_ORDER_CALL;                                                                                 \
		}                                                                                                                  \
	} while (0)

#define CHECK_ORDER_LOW(expected_stage)                                                                                \
	do                                                                                                                   \
	{                                                                                                                    \
		printf("Checking LOW %d/%d : %d\n", imgdata.progress_flags, expected_stage,                                        \
					 imgdata.progress_flags < expected_stage);                                                                   \
		if ((imgdata.progress_flags & LIBRAW_PROGRESS_THUMB_MASK) < expected_stage)                                        \
		{                                                                                                                  \
			printf("failed!\n");                                                                                             \
			return LIBRAW_OUT_OF_ORDER_CALL;                                                                                 \
		}                                                                                                                  \
	} while (0)
#define CHECK_ORDER_BIT(expected_stage)                                                                                \
	do                                                                                                                   \
	{                                                                                                                    \
		if (imgdata.progress_flags & expected_stage)                                                                       \
			return LIBRAW_OUT_OF_ORDER_CALL;                                                                                 \
	} while (0)

#define SET_PROC_FLAG(stage)                                                                                           \
	do                                                                                                                   \
	{                                                                                                                    \
		imgdata.progress_flags |= stage;                                                                                   \
		fprintf(stderr, "SET_FLAG: %d\n", stage);                                                                          \
	} while (0)

#else

#define CHECK_ORDER_HIGH(expected_stage)                                                                               \
	do                                                                                                                   \
	{                                                                                                                    \
		if ((imgdata.progress_flags & LIBRAW_PROGRESS_THUMB_MASK) >= expected_stage)                                       \
		{                                                                                                                  \
			return LIBRAW_OUT_OF_ORDER_CALL;                                                                                 \
		}                                                                                                                  \
	} while (0)

#define CHECK_ORDER_LOW(expected_stage)                                                                                \
	do                                                                                                                   \
	{                                                                                                                    \
		if ((imgdata.progress_flags & LIBRAW_PROGRESS_THUMB_MASK) < expected_stage)                                        \
			return LIBRAW_OUT_OF_ORDER_CALL;                                                                                 \
	} while (0)

#define CHECK_ORDER_BIT(expected_stage)                                                                                \
	do                                                                                                                   \
	{                                                                                                                    \
		if (imgdata.progress_flags & expected_stage)                                                                       \
			return LIBRAW_OUT_OF_ORDER_CALL;                                                                                 \
	} while (0)

#define SET_PROC_FLAG(stage)                                                                                           \
	do                                                                                                                   \
	{                                                                                                                    \
		imgdata.progress_flags |= stage;                                                                                   \
	} while (0)

#endif+/

