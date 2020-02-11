module libraw;

public import libraw.datastream;
public import libraw.types;
public import libraw.const_;
public import libraw.internal;
public import libraw.alloc;

import core.stdc.limits;
//import core.stdc.memory;
import core.stdc.stdio;
import core.stdc.stdlib;
import core.stdc.config;


version (linux) {
	enum _FILE_OFFSET_BITS = 64;
}

enum LIBRAW_USE_STREAMS_DATASTREAM_MAXSIZE = 250 * 1024L * 1024L;


extern (C) {
	const(char)* libraw_strerror(int errorcode);
	const(char)* libraw_strprogress(LibRaw_progress);
	/* LibRaw C API */
	libraw_data_t *libraw_init(LibRaw_constructor_flags flags);
	int libraw_open_file(libraw_data_t *, const(char)*);
	int libraw_open_file_ex(libraw_data_t *, const(char)*, long max_buff_sz);
	version (Windows) {
		int libraw_open_wfile(libraw_data_t *, const(wchar_t)*);
		int libraw_open_wfile_ex(libraw_data_t *, const(wchar_t)*, long max_buff_sz);
	}
	int libraw_open_buffer(libraw_data_t *, void *buffer, size_t size);
	int libraw_open_datastream(libraw_data_t *lr, libraw_abstract_datastream_t *stream);
	void libraw_wrap_ifp_stream(void *ifp, libraw_abstract_datastream_t *dst);
	int libraw_unpack(libraw_data_t *);
	int libraw_unpack_thumb(libraw_data_t *);
	void libraw_recycle_datastream(libraw_data_t *);
	void libraw_recycle(libraw_data_t *);
	void libraw_close(libraw_data_t *);
	void libraw_subtract_black(libraw_data_t *);
	int libraw_raw2image(libraw_data_t *);
	void libraw_free_image(libraw_data_t *);
	/* version helpers */
	const(char)* libraw_version();
	int libraw_versionNumber();
	/* Camera list */
	const(char)** libraw_cameraList();
	int libraw_cameraCount();

	/* helpers */
	void libraw_set_memerror_handler(libraw_data_t *, memory_callback cb, void *datap);
	void libraw_set_exifparser_handler(libraw_data_t *, exif_parser_callback cb, void *datap);
	void libraw_set_dataerror_handler(libraw_data_t *, data_callback func, void *datap);
	void libraw_set_progress_handler(libraw_data_t *, progress_callback cb, void *datap);
	const(char)* libraw_unpack_function_name(libraw_data_t *lr);
	int libraw_get_decoder_info(libraw_data_t *lr, libraw_decoder_info_t *d);
	int libraw_COLOR(libraw_data_t *, int row, int col);
	uint libraw_capabilities();

	/* DCRAW compatibility */
	int libraw_adjust_sizes_info_only(libraw_data_t *);
	int libraw_dcraw_ppm_tiff_writer(libraw_data_t *lr, const(char)* filename);
	int libraw_dcraw_thumb_writer(libraw_data_t *lr, const(char)* fname);
	int libraw_dcraw_process(libraw_data_t *lr);
	libraw_processed_image_t *libraw_dcraw_make_mem_image(libraw_data_t *lr, int *errc);
	libraw_processed_image_t *libraw_dcraw_make_mem_thumb(libraw_data_t *lr, int *errc);
	void libraw_dcraw_clear_mem(libraw_processed_image_t *);
	/* getters/setters used by 3DLut Creator */
	void libraw_set_demosaic(libraw_data_t *lr, int value);
	void libraw_set_output_color(libraw_data_t *lr, int value);
	void libraw_set_user_mul(libraw_data_t *lr, int index, float val);
	void libraw_set_output_bps(libraw_data_t *lr, int value);
	void libraw_set_gamma(libraw_data_t *lr, int index, float value);
	void libraw_set_no_auto_bright(libraw_data_t *lr, int value);
	void libraw_set_bright(libraw_data_t *lr, float value);
	void libraw_set_highlight(libraw_data_t *lr, int value);
	void libraw_set_fbdd_noiserd(libraw_data_t *lr, int value);
	int libraw_get_raw_height(libraw_data_t *lr);
	int libraw_get_raw_width(libraw_data_t *lr);
	int libraw_get_iheight(libraw_data_t *lr);
	int libraw_get_iwidth(libraw_data_t *lr);
	float libraw_get_cam_mul(libraw_data_t *lr, int index);
	float libraw_get_pre_mul(libraw_data_t *lr, int index);
	float libraw_get_rgb_cam(libraw_data_t *lr, int index1, int index2);
	int libraw_get_color_maximum(libraw_data_t *lr);

	libraw_iparams_t *libraw_get_iparams(libraw_data_t *lr);
	libraw_lensinfo_t *libraw_get_lensinfo(libraw_data_t *lr);
	libraw_imgother_t *libraw_get_imgother(libraw_data_t *lr);
}


/+extern (C++) {
	class LibRaw
	{
		libraw_data_t imgdata;
		int verbose;

		this(uint flags = LibRaw_constructor_flags.NONE);
		final libraw_output_params_t *output_params_ptr() { return &imgdata.params; }
		final int open_file(const(char)* fname, long max_buffered_sz = LIBRAW_USE_STREAMS_DATASTREAM_MAXSIZE);
		version (Windows) {
			final int open_file(const wchar_t *fname, long max_buffered_sz = LIBRAW_USE_STREAMS_DATASTREAM_MAXSIZE);
		}
		final int open_buffer(void *buffer, size_t size);
		int open_datastream(LibRaw_abstract_datastream);
		int open_bayer(ubyte *data, uint datalen, ushort _raw_width, ushort _raw_height,
													 ushort _left_margin, ushort _top_margin, ushort _right_margin, ushort _bottom_margin,
													 ubyte procflags, ubyte bayer_pattern, uint unused_bits,
													 uint otherflags, uint black_level);
		final int error_count() { return libraw_internal_data.unpacker_data.data_error; }
		final void recycle_datastream();
		final int unpack();
		final int unpack_thumb();
		final int thumbOK(long maxsz = -1);
		final int adjust_sizes_info_only();
		final int subtract_black();
		final int subtract_black_internal();
		final int raw2image();
		final int raw2image_ex(int do_subtract_black);
		final void raw2image_start();
		final void free_image();
		final int adjust_maximum();
		final void set_exifparser_handler(exif_parser_callback cb, void *data)
		{
			callbacks.exifparser_data = data;
			callbacks.exif_cb = cb;
		}
		final void set_memerror_handler(memory_callback cb, void *data)
		{
			callbacks.memcb_data = data;
			callbacks.mem_cb = cb;
		}
		final void set_dataerror_handler(data_callback func, void *data)
		{
			callbacks.datacb_data = data;
			callbacks.data_cb = func;
		}
		final void set_progress_handler(progress_callback pcb, void *data)
		{
			callbacks.progresscb_data = data;
			callbacks.progress_cb = pcb;
		}

		final void convertFloatToInt(float dmin = 4096.0f, float dmax = 32767.0f, float dtarget = 16383.0f);
		/* helpers */
		static uint capabilities();
		static const(char)* version_();
		static int versionNumber();
		static const(char)** cameraList();
		static int cameraCount();
		static const(char)* strprogress(LibRaw_progress);
		static const(char)* strerror(int p);
		/* dcraw emulation */
		final int dcraw_ppm_tiff_writer(const(char)* filename);
		final int dcraw_thumb_writer(const(char)* fname);
		final int dcraw_process();
		/* information calls */
		final int is_fuji_rotated() { return libraw_internal_data.internal_output_params.fuji_width; }
		final int is_sraw();
		final int sraw_midpoint();
		final int is_nikon_sraw();
		final int is_coolscan_nef();
		final int is_jpeg_thumb();
		final int is_floating_point();
		final int have_fpdata();
		/* memory writers */
		libraw_processed_image_t *dcraw_make_mem_image(int *errcode = null);
		libraw_processed_image_t *dcraw_make_mem_thumb(int *errcode = null);
		static void dcraw_clear_mem(libraw_processed_image_t *);

		/* Additional calls for make_mem_image */
		final void get_mem_image_format(int *width, int *height, int *colors, int *bps) const;
		final int copy_mem_image(void *scan0, int stride, int bgr);

		/* free all internal data structures */
		final void recycle();
		~this() {}

		final int COLOR(int row, int col)
		{
			if (!imgdata.idata.filters)
				return 6; /* Special value 0+1+2+3 */
			if (imgdata.idata.filters < 1000)
				return fcol(row, col);
			return libraw_internal_data.internal_output_params.fuji_width ? FCF(row, col) : FC(row, col);
		}

		final int FC(int row, int col) { return (imgdata.idata.filters >> (((row << 1 & 14) | (col & 1)) << 1) & 3); }
		final int fcol(int row, int col);

		final const(char)* unpack_function_name();
		int get_decoder_info(libraw_decoder_info_t *d_info);
		final libraw_internal_data_t *get_internal_data_pointer() { return &libraw_internal_data; }

		/* Debanding filter */
		final int wf_remove_banding();

		/* Phase one correction/subtractBL calls */
		/* Returns libraw error code */

		final int phase_one_subtract_black(ushort *src, ushort *dest);
		final int phase_one_correct();

		final int set_rawspeed_camerafile(char *filename);
		void setCancelFlag();
		void clearCancelFlag();
		void adobe_coeff(const(char)* , const(char)* , int internal_only = 0);

		final void set_dng_host(void *);

	protected:
		final int is_curve_linear();
		final void checkCancel();
		final void cam_xyz_coeff(float[4]/*[3]*/* _rgb_cam, double[3]/*[4]*/* cam_xyz);
		final void phase_one_allocate_tempbuffer();
		final void phase_one_free_tempbuffer();
		int is_phaseone_compressed();
		int is_canon_600();

		// NOTE: Static array parameters cannot currently be mapped to D properly,
		//       so all virtual methods starting from here are commented out
		/+void copy_fuji_uncropped(ushort/*[4]*/* cblack, ushort *dmaxp);
		void copy_bayer(ushort/*[4]*/* cblack, ushort *dmaxp);
		void fuji_rotate();
		void convert_to_rgb_loop(float[4]/*[3]*/* out_cam);
		void lin_interpolate_loop(int[32][16]/*[16]*/* code, int size);
		void scale_colors_loop(float/*[4]*/* scale_mul);
		void fuji_decode_loop(const(fuji_compressed_params)* common_info, int count, long *offsets,
																	uint *sizes);+/
		final void fuji_decode_strip(const(fuji_compressed_params)* info_common, int cur_block, long raw_offset,
													 uint size);

		final int FCF(int row, int col)
		{
			int rr, cc;
			if (libraw_internal_data.unpacker_data.fuji_layout)
			{
				rr = libraw_internal_data.internal_output_params.fuji_width - 1 - col + (row >> 1);
				cc = col + ((row + 1) >> 1);
			}
			else
			{
				rr = libraw_internal_data.internal_output_params.fuji_width - 1 + row - (col >> 1);
				cc = row + ((col + 1) >> 1);
			}
			return FC(rr, cc);
		}

		final void adjust_bl();
		final void *malloc(size_t t);
		final void *calloc(size_t n, size_t t);
		final void *realloc(void *p, size_t s);
		final void free(void *p);
		final void merror(void *ptr, const(char)* where);
		final void derror();

		LibRaw_TLS tls;
		libraw_internal_data_t libraw_internal_data;
		decode[2048] first_decode;
		decode* second_decode, free_decode;
		tiff_ifd_t[LIBRAW_IFD_MAXCOUNT] tiff_ifd;
		libraw_memmgr memmgr;
		libraw_callbacks_t callbacks;

		LibRaw_constants rgb_constants;

		void function(LibRaw) write_thumb;
		void function(LibRaw) write_fun;
		void function(LibRaw) load_raw;
		void function(LibRaw) thumb_load_raw;
		void function(LibRaw) pentax_component_load_raw;

		final void kodak_thumb_loader();
		final void write_thumb_ppm_tiff(/*FILE*/void *);
		final void x3f_thumb_loader();
		final long x3f_thumb_size();

		final int own_filtering_supported() { return 0; }
		final void identify();
		final void initdata();
		final uint parse_custom_cameras(uint limit, libraw_custom_camera_t/*[]*/* table, char **list);
		final void write_ppm_tiff();
		final void convert_to_rgb();
		final void remove_zeroes();
		final void crop_masked_pixels();
		version (NO_LCMS) {}
		else {
			final void apply_profile(const(char)* , const(char)* );
		}
		final void pre_interpolate();
		final void border_interpolate(int border);
		final void lin_interpolate();
		final void vng_interpolate();
		final void ppg_interpolate();
		final void cielab(ushort/*[3]*/* rgb, short/*[3]*/* lab);
		final void xtrans_interpolate(int);
		final void ahd_interpolate();
		final void dht_interpolate();
		final void aahd_interpolate();

		final void dcb(int iterations, int dcb_enhance);
		final void fbdd(int noiserd);
		final void exp_bef(float expos, float preser);

		final void bad_pixels(const(char)* );
		final void subtract(const(char)* );
		final void hat_transform(float *temp, float *base, int st, int size, int sc);
		final void wavelet_denoise();
		final void scale_colors();
		final void median_filter();
		final void blend_highlights();
		final void recover_highlights();
		final void green_matching();

		final void stretch();

		final void jpeg_thumb_writer(/*FILE*/void *tfp, char *thumb, int thumb_length);
		final void jpeg_thumb();
		final void ppm_thumb();
		final void ppm16_thumb();
		final void layer_thumb();
		final void rollei_thumb();
		final void kodak_thumb_load_raw();

		final uint get4();

		final int flip_index(int row, int col);
		final void gamma_curve(double pwr, double ts, int mode, int imax);
		final void cubic_spline(const(int)*x_, const(int)*y_, const int len);

		/* RawSpeed data */
		void *_rawspeed_camerameta;
		void *_rawspeed_decoder;
		final void fix_after_rawspeed(int bl);
		final int try_rawspeed(); /* returns LIBRAW_SUCCESS on success */
		/* Fast cancel flag */
		c_long _exitflag;

		/* DNG SDK data */
		void *dnghost;
		final int valid_for_dngsdk();
		final int try_dngsdk();
		/* X3F data */
		void *_x3f_data;

		final int raw_was_read()
		{
			return imgdata.rawdata.raw_image || imgdata.rawdata.color4_image || imgdata.rawdata.color3_image ||
						 imgdata.rawdata.float_image || imgdata.rawdata.float3_image || imgdata.rawdata.float4_image;
		}

	/+#ifdef LIBRAW_LIBRARY_BUILD
	#include "internal/libraw_internal_funcs.h"
	#endif
	#if LIBRAW_METADATA_LOOP_PREVENTION
		uint metadata_blocks; /* This changes ABI, but offsets to prev.defined variables has not changed */
	#endif+/
	}

	/+#ifdef LIBRAW_LIBRARY_BUILD
	#define RUN_CALLBACK(stage, iter, expect)                                                                              \
		if (callbacks.progress_cb)                                                                                           \
		{                                                                                                                    \
			int rr = (*callbacks.progress_cb)(callbacks.progresscb_data, stage, iter, expect);                                 \
			if (rr != 0)                                                                                                       \
				throw LIBRAW_EXCEPTION_CANCELLED_BY_CALLBACK;                                                                    \
		}
	#endif+/
}+/
