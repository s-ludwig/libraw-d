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
	int libraw_unpack_thumb_ex(libraw_data_t *,int);
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
	void libraw_set_exifparser_handler(libraw_data_t *, exif_parser_callback cb, void *datap);
	void libraw_set_makernotes_handler(libraw_data_t *, exif_parser_callback cb, void *datap);
	void libraw_set_dataerror_handler(libraw_data_t *, data_callback func, void *datap);
	void libraw_set_progress_handler(libraw_data_t *, progress_callback cb, void *datap);
	const(char)* libraw_unpack_function_name(libraw_data_t *lr);
	int libraw_get_decoder_info(libraw_data_t *lr, libraw_decoder_info_t *d);
	int libraw_COLOR(libraw_data_t *, int row, int col);
	uint libraw_capabilities();
	int libraw_adjust_to_raw_inset_crop(libraw_data_t *lr, uint mask, float maxcrop);

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
	void libraw_set_output_tif(libraw_data_t* lr, int value);
	libraw_iparams_t *libraw_get_iparams(libraw_data_t *lr);
	libraw_lensinfo_t *libraw_get_lensinfo(libraw_data_t *lr);
	libraw_imgother_t *libraw_get_imgother(libraw_data_t *lr);
}
