module libraw.const_;

enum LIBRAW_DEFAULT_ADJUST_MAXIMUM_THRESHOLD = 0.75;
enum LIBRAW_DEFAULT_AUTO_BRIGHTNESS_THRESHOLD = 0.01;

static if (!is(typeof(LIBRAW_MAX_ALLOC_MB))) {
	enum LIBRAW_MAX_ALLOC_MB = 2048L;
}

static if (!is(typeof(LIBRAW_METADATA_LOOP_PREVENTION))) {
	enum LIBRAW_METADATA_LOOP_PREVENTION = 0;
}

version (LIBRAW_NO_IOSPACE_CHECK) {}
else version = LIBRAW_IOSPACE_CHECK;

version (LIBRAW_NO_MEMPOOL_CHECK) {}
else version = LIBRAW_MEMPOOL_CHECK;

enum LIBRAW_MAX_METADATA_BLOCKS = 1024;
enum LIBRAW_CBLACK_SIZE = 4104;
enum LIBRAW_IFD_MAXCOUNT = 10;
enum LIBRAW_CRXTRACKS_MAXCOUNT = 16;

enum LIBRAW_AHD_TILE = 512;

enum LibRaw_openbayer_patterns {
	RGGB = 0x94,
	BGGR = 0x16,
	GRBG = 0x61,
	GBRG = 0x49
}

enum LibRaw_dngfields_marks {
	FORWARDMATRIX = 1,
	ILLUMINANT = 1 << 1,
	COLORMATRIX = 1 << 2,
	CALIBRATION = 1 << 3,
	ANALOGBALANCE = 1 << 4,
	BLACK = 1 << 5,
	WHITE = 1 << 6,
	OPCODE2 = 1 << 7,
	LINTABLE = 1 << 8,
	CROPORIGIN = 1 << 9,
	CROPSIZE = 1 << 10,
	PREVIEWCS = 1 << 11,
	ASSHOTNEUTRAL = 1 << 12,
	BASELINEEXPOSURE = 1 << 13,
	LINEARRESPONSELIMIT = 1 << 14
}

enum LibRaw_As_Shot_WB_Applied_codes
{
	APPLIED = 1,
	CANON = 2,
	NIKON = 4,
	NIKON_SRAW = 8,
	PENTAX = 16
}

enum LibRaw_whitebalance_code {
	Unknown = 0,
	Daylight = 1,
	Fluorescent = 2,
	Tungsten = 3,
	Flash = 4,
	FineWeather = 9,
	Cloudy = 10,
	Shade = 11,
	FL_D = 12,
	FL_N = 13,
	FL_W = 14,
	FL_WW = 15,
	FL_L = 16,
	Ill_A = 17,
	Ill_B = 18,
	Ill_C = 19,
	D55 = 20,
	D65 = 21,
	D75 = 22,
	D50 = 23,
	StudioTungsten = 24,
	Sunset = 64,
	LIBRAW_WBI_HT_Mercury = 67,
	Auto = 82,
	Custom = 83,
	Auto1 = 85,
	Auto2 = 86,
	Auto3 = 87,
	Auto4 = 88,
	Custom1 = 90,
	Custom2 = 91,
	Custom3 = 92,
	Custom4 = 93,
	Custom5 = 94,
	Custom6 = 95,
	Measured = 100,
	Underwater = 120,
	Kelvin = 254,
	Other = 255,
	None = 0xffff
}

enum LibRaw_MultiExposure_related {
	NONE = 0,
	SIMPLE = 1,
	OVERLAY = 2,
	HDR = 3
}

enum LibRaw_dng_processing {
	NONE = 0,
	FLOAT = 1,
	LINEAR = 2,
	DEFLATE = 4,
	XTRANS = 8,
	OTHER = 16,
	_8BIT = 32,
	/*LARGERANGE=64,*/ /* more than 16 bit integer */
	ALL = FLOAT | LINEAR | XTRANS | _8BIT | OTHER /* |LARGERANGE */,
	DEFAULT = FLOAT | LINEAR | DEFLATE | _8BIT
}

enum LibRaw_runtime_capabilities {
	RAWSPEED = 1,
	DNGSDK = 2,
	GPRSDK = 4,
	UNICODEPATHS = 8
}

enum LibRaw_cameramaker_index {
	Unknown = 0,
	Agfa,
	Alcatel,
	Apple,
	Aptina,
	AVT,
	Baumer,
	Broadcom,
	Canon,
	Casio,
	CINE,
	Clauss,
	Contax,
	Creative,
	DJI,
	DXO,
	Epson,
	Foculus,
	Fujifilm,
	Generic,
	Gione,
	GITUP,
	Google,
	GoPro,
	Hasselblad,
	HTC,
	I_Mobile,
	Imacon,
	Kodak,
	Konica,
	Leaf,
	Leica,
	Lenovo,
	LG,
	Mamiya,
	Matrix,
	Meizu,
	Micron,
	Minolta,
	Motorola,
	NGM,
	Nikon,
	Nokia,
	Olympus,
	OmniVison,
	Panasonic,
	Parrot,
	Pentax,
	PhaseOne,
	PhotoControl,
	Photron,
	Pixelink,
	Polaroid,
	RED,
	Ricoh,
	Rollei,
	RoverShot,
	Samsung,
	Sigma,
	Sinar,
	SMaL,
	Sony,
	ST_Micro,
	THL,
	Xiaomi,
	XIAOYI,
	YI,
	Yuneec,
	TheLastOne,
}

enum LibRaw_camera_mounts {
	Unknown = 0,
	Minolta_A = 1,
	Sony_E = 2,
	Canon_EF = 3,
	Canon_EF_S = 4,
	Canon_EF_M = 5,
	Nikon_F = 6,
	Nikon_CX = 7, /* used in Nikon 1 series */
	FT = 8,       /* original 4/3 */
	mFT = 9,      /* micro 4/3 */
	Pentax_K = 10,
	Pentax_Q = 11,
	Pentax_645 = 12,
	Fuji_X = 13,
	Leica_M = 14,
	Leica_R = 15,
	Leica_S = 16,
	Samsung_NX = 17,
	RicohModule = 18,
	Samsung_NX_M = 19,
	Leica_L = 20,
	Contax_N = 21,
	Sigma_X3F = 22,
	Leica_TL = 23, /* lens, mounts on 'L' throat, APS-C */
	Leica_SL = 24, /* lens, mounts on 'L' throat, FF */
	Nikon_Z = 25,
	Canon_RF = 26,
	C = 27,              /* C-mount */
	Fuji_GF = 50,        /* Fujifilm GFX cameras, G mount */
	Hasselblad_H = 51,   /* Hasselblad Hn cameras, HC & HCD lenses */
	Hasselblad_XCD = 52, /* Hasselblad Xn cameras, XCD lenses */
	Hasselblad_V = 53,
	Contax645 = 54,
	Mamiya645 = 55,
	Rollei_bayonet = 56, /* Rollei Hy-6: Leaf AFi, Sinar Hy6- models */
	Alpa = 57,
	Mamiya67 = 58, /* Mamiya RB67, RZ67 */
	Fuji_GX = 59,  /* Fujifilm GX680 */
	LF = 97,
	DigitalBack = 98,
	FixedLens = 99,
	IL_UM = 100 /* Interchangeable lens, mount unknown */
}

enum LibRaw_camera_formats {
	Unknown = 0,
	APSC = 1,
	FF = 2,
	MF = 3,
	APSH = 4,
	_1INCH = 5,
	_1div2p3INCH = 6, /* 1/2.3" */
	_1div1p7INCH = 7, /* 1/1.7" */
	FT = 8,          /* sensor size in FT & mFT cameras */
	CROP645 = 9,     /* 44x33mm */
	LeicaS = 10,     /* 'MF' Leicas */
	_645 = 11,
	_66 = 12,
	_69 = 13,
	LF = 14,
	Leica_DMR = 15,
	_67 = 16,
	SigmaAPSC = 17, /* DP1, DP2, SD15, SD14, SD10, SD9 */
	SigmaMerrill = 18, /* SD1,  'SD1 Merrill',  'DP1 Merrill',  'DP2 Merrill' */
	SigmaAPSH = 19, /* 'sd Quattro H' */
	_3648 = 20,      /* DALSA FTF4052C (Mamiya ZD) */
	_68 = 21         /* Fujifilm GX680 */
}

enum LibRawImageAspects {
	UNKNOWN = 0,
	_3to2 = 1,
	_1to1 = 2,
	_4to3 = 3,
	_16to9 = 4,
	_5to4 = 5,
	OTHER = 6
}

enum LibRaw_lens_focal_types {
	UNDEFINED = 0,
	PRIME_LENS = 1,
	ZOOM_LENS = 2,
	ZOOM_LENS_CONSTANT_APERTURE = 3,
	ZOOM_LENS_VARIABLE_APERTURE = 4
}

enum LibRaw_sony_cameratypes {
	DSC = 1,
	DSLR = 2,
	NEX = 3,
	SLT = 4,
	ILCE = 5,
	ILCA = 6
}

enum LibRaw_KodakSensors
{
  LIBRAW_Kodak_UnknownSensor = 0,
  LIBRAW_Kodak_M1 = 1,
  LIBRAW_Kodak_M15 = 2,
  LIBRAW_Kodak_M16 = 3,
  LIBRAW_Kodak_M17 = 4,
  LIBRAW_Kodak_M2 = 5,
  LIBRAW_Kodak_M23 = 6,
  LIBRAW_Kodak_M24 = 7,
  LIBRAW_Kodak_M3 = 8,
  LIBRAW_Kodak_M5 = 9,
  LIBRAW_Kodak_M6 = 10,
  LIBRAW_Kodak_C14 = 11,
  LIBRAW_Kodak_X14 = 12,
  LIBRAW_Kodak_M11 = 13
};

enum LibRaw_HasselbladFormatCodes {
  LIBRAW_HF_Unknown = 0,
  LIBRAW_HF_3FR,
  LIBRAW_HF_FFF,
  LIBRAW_HF_Imacon,
  LIBRAW_HF_HasselbladDNG,
  LIBRAW_HF_AdobeDNG,
  LIBRAW_HF_AdobeDNG_fromPhocusDNG
};

enum LibRaw_processing_options {
	SONYARW2_NONE = 0,
	SONYARW2_BASEONLY = 1,
	SONYARW2_DELTAONLY = 1 << 1,
	SONYARW2_DELTAZEROBASE = 1 << 2,
	SONYARW2_DELTATOVALUE = 1 << 3,
	SONYARW2_ALLFLAGS = SONYARW2_BASEONLY + SONYARW2_DELTAONLY +
		SONYARW2_DELTAZEROBASE + SONYARW2_DELTATOVALUE,
	DP2Q_INTERPOLATERG = 1 << 4,
	DP2Q_INTERPOLATEAF = 1 << 5,
	PENTAX_PS_ALLFRAMES = 1 << 6,
	CONVERTFLOAT_TO_INT = 1 << 7,
	SRAW_NO_RGB = 1 << 8,
	SRAW_NO_INTERPOLATE = 1 << 9,
	NO_ROTATE_FOR_KODAK_THUMBNAILS = 1 << 11,
	USE_DNG_DEFAULT_CROP = 1 << 12,
	USE_PPM16_THUMBS = 1 << 13,
	SKIP_MAKERNOTES = 1 << 14,
	DONT_CHECK_DNG_ILLUMINANT = 1 << 15,
	DNGSDK_ZEROCOPY = 1 << 16,
	ZEROFILTERS_FOR_MONOCHROMETIFFS = 1 << 17,
	DNG_ADD_ENHANCED = 1 << 18,
	DNG_ADD_PREVIEWS = 1 << 19,
	DNG_PREFER_LARGEST_IMAGE = 1 << 20
}

enum LibRaw_decoder_flags {
	HASCURVE = 1 << 4,
	SONYARW2 = 1 << 5,
	TRYRAWSPEED = 1 << 6,
	OWNALLOC = 1 << 7,
	FIXEDMAXC = 1 << 8,
	ADOBECOPYPIXEL = 1 << 9,
	LEGACY_WITH_MARGINS = 1 << 10,
	_3CHANNEL = 1 << 11,
	SINAR4SHOT = 1 << 11,
	FLATDATA = 1 << 12,
	FLAT_BG2_SWAPPED = 1<<13,
	NOTSET = 1 << 15
}

enum LIBRAW_XTRANS = 9;

enum LibRaw_constructor_flags {
	NONE = 0,
	NO_MEMERR_CALLBACK = 1,
	NO_DATAERR_CALLBACK = 1 << 1
}

enum LibRaw_warnings {
	NONE = 0,
	BAD_CAMERA_WB = 1 << 2,
	NO_METADATA = 1 << 3,
	NO_JPEGLIB = 1 << 4,
	NO_EMBEDDED_PROFILE = 1 << 5,
	NO_INPUT_PROFILE = 1 << 6,
	BAD_OUTPUT_PROFILE = 1 << 7,
	NO_BADPIXELMAP = 1 << 8,
	BAD_DARKFRAME_FILE = 1 << 9,
	BAD_DARKFRAME_DIM = 1 << 10,
	NO_JASPER = 1 << 11,
	RAWSPEED_PROBLEM = 1 << 12,
	RAWSPEED_UNSUPPORTED = 1 << 13,
	RAWSPEED_PROCESSED = 1 << 14,
	FALLBACK_TO_AHD = 1 << 15,
	PARSEFUJI_PROCESSED = 1 << 16,
	DNGSDK_PROCESSED = 1 << 17,
	DNG_IMAGES_REORDERED = 1 << 18
}

enum LibRaw_exceptions {
	NONE = 0,
	ALLOC = 1,
	DECODE_RAW = 2,
	DECODE_JPEG = 3,
	IO_EOF = 4,
	IO_CORRUPT = 5,
	CANCELLED_BY_CALLBACK = 6,
	BAD_CROP = 7,
	IO_BADFILE = 8,
	DECODE_JPEG2000 = 9,
	TOOBIG = 10,
	MEMPOOL = 11
}

enum LibRaw_progress {
	START = 0,
	OPEN = 1,
	IDENTIFY = 1 << 1,
	SIZE_ADJUST = 1 << 2,
	LOAD_RAW = 1 << 3,
	RAW2_IMAGE = 1 << 4,
	REMOVE_ZEROES = 1 << 5,
	BAD_PIXELS = 1 << 6,
	DARK_FRAME = 1 << 7,
	FOVEON_INTERPOLATE = 1 << 8,
	SCALE_COLORS = 1 << 9,
	PRE_INTERPOLATE = 1 << 10,
	INTERPOLATE = 1 << 11,
	MIX_GREEN = 1 << 12,
	MEDIAN_FILTER = 1 << 13,
	HIGHLIGHTS = 1 << 14,
	FUJI_ROTATE = 1 << 15,
	FLIP = 1 << 16,
	APPLY_PROFILE = 1 << 17,
	CONVERT_RGB = 1 << 18,
	STRETCH = 1 << 19,
	/* reserved */
	STAGE20 = 1 << 20,
	STAGE21 = 1 << 21,
	STAGE22 = 1 << 22,
	STAGE23 = 1 << 23,
	STAGE24 = 1 << 24,
	STAGE25 = 1 << 25,
	STAGE26 = 1 << 26,
	STAGE27 = 1 << 27,

	THUMB_LOAD = 1 << 28,
	TRESERVED1 = 1 << 29,
	TRESERVED2 = 1 << 30,
	TRESERVED3 = 1 << 31
}
enum LIBRAW_PROGRESS_THUMB_MASK = 0x0fffffff;

enum LibRaw_errors {
	SUCCESS = 0,
	UNSPECIFIED_ERROR = -1,
	FILE_UNSUPPORTED = -2,
	REQUEST_FOR_NONEXISTENT_IMAGE = -3,
	OUT_OF_ORDER_CALL = -4,
	NO_THUMBNAIL = -5,
	UNSUPPORTED_THUMBNAIL = -6,
	INPUT_CLOSED = -7,
	NOT_IMPLEMENTED = -8,
	UNSUFFICIENT_MEMORY = -100007,
	DATA_ERROR = -100008,
	IO_ERROR = -100009,
	CANCELLED_BY_CALLBACK = -100010,
	BAD_CROP = -100011,
	TOO_BIG = -100012,
	MEMPOOL_OVERFLOW = -100013
}

auto LIBRAW_FATAL_ERROR(E)(E ec) { return ec < -100000; }

enum LibRaw_thumbnail_formats {
	UNKNOWN = 0,
	JPEG = 1,
	BITMAP = 2,
	BITMAP16 = 3,
	LAYER = 4,
	ROLLEI = 5
}

enum LibRaw_image_formats {
	JPEG = 1,
	BITMAP = 2
}
