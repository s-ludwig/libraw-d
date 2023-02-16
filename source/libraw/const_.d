module libraw.const_;

enum LIBRAW_DEFAULT_ADJUST_MAXIMUM_THRESHOLD = 0.75f;
enum LIBRAW_DEFAULT_AUTO_BRIGHTNESS_THRESHOLD = 0.01f;

static if (!is(typeof(LIBRAW_MAX_ALLOC_MB_DEFAULT))) {
	enum LIBRAW_MAX_ALLOC_MB_DEFAULT = 2048L;
}


static if (!is(typeof(LIBRAW_MAX_NONDNG_RAW_FILE_SIZE))) {
	enum LIBRAW_MAX_NONDNG_RAW_FILE_SIZE = 2147483647UL;
}

static if (!is(typeof(LIBRAW_MAX_DNG_RAW_FILE_SIZE))) {
version (USE_DNGSDK)
	enum LIBRAW_MAX_DNG_RAW_FILE_SIZE = 4294967295UL;
else
	enum LIBRAW_MAX_DNG_RAW_FILE_SIZE = 2147483647UL;
}

static if (!is(typeof(LIBRAW_MAX_THUMBNAIL_MB_DEFAULT))) {
	enum LIBRAW_MAX_THUMBNAIL_MB_DEFAULT = 512L;
}

static if (!is(typeof(LIBRAW_METADATA_LOOP_PREVENTION))) {
	enum LIBRAW_METADATA_LOOP_PREVENTION = 0;
}

version (LIBRAW_NO_IOSPACE_CHECK) {}
else version = LIBRAW_IOSPACE_CHECK;

version (LIBRAW_NO_CR3_MEMPOOL) {}
else version = LIBRAW_CR3_MEMPOOL;

version (LIBRAW_NO_MEMPOOL_CHECK) {}
else version = LIBRAW_MEMPOOL_CHECK;

enum LIBRAW_MAX_METADATA_BLOCKS = 1024;
enum LIBRAW_CBLACK_SIZE = 4104;
enum LIBRAW_IFD_MAXCOUNT = 10;
enum LIBRAW_THUMBNAIL_MAXCOUNT = 8;
enum LIBRAW_CRXTRACKS_MAXCOUNT = 16;
enum LIBRAW_AFDATA_MAXCOUNT = 4;

enum LIBRAW_AHD_TILE = 512;

version (LIBRAW_NO_IOSTREAMS_DATASTREAM) {}
else {
	enum LibRaw_open_flags {
		LIBRAW_OPEN_BIGFILE = 1,
		LIBRAW_OPEN_FILE = 1<<1
	}
}


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
	LINEARRESPONSELIMIT = 1 << 14,
	USERCROP = 1 << 15,
	OPCODE1 = 1 << 16,
	OPCODE3 = 1 << 17,
}

enum LibRaw_As_Shot_WB_Applied_codes
{
	APPLIED = 1,
	CANON = 2,
	NIKON = 4,
	NIKON_SRAW = 8,
	PENTAX = 16
}

//#define tagtypeIs(typex) (type == typex)
enum LibRaw_ExifTagTypes {
  LIBRAW_EXIFTAG_TYPE_UNKNOWN   =  0,
  LIBRAW_EXIFTAG_TYPE_BYTE      =  1,
  LIBRAW_EXIFTAG_TYPE_ASCII     =  2,
  LIBRAW_EXIFTAG_TYPE_SHORT     =  3,
  LIBRAW_EXIFTAG_TYPE_LONG      =  4,
  LIBRAW_EXIFTAG_TYPE_RATIONAL  =  5,
  LIBRAW_EXIFTAG_TYPE_SBYTE     =  6,
  LIBRAW_EXIFTAG_TYPE_UNDEFINED =  7,
  LIBRAW_EXIFTAG_TYPE_SSHORT    =  8,
  LIBRAW_EXIFTAG_TYPE_SLONG     =  9,
  LIBRAW_EXIFTAG_TYPE_SRATIONAL = 10,
  LIBRAW_EXIFTAG_TYPE_FLOAT     = 11,
  LIBRAW_EXIFTAG_TYPE_DOUBLE    = 12,
  LIBRAW_EXIFTAG_TYPE_IFD       = 13,
  LIBRAW_EXIFTAG_TYPE_UNICODE   = 14,
  LIBRAW_EXIFTAG_TYPE_COMPLEX   = 15,
  LIBRAW_EXIFTAG_TYPE_LONG8     = 16,
  LIBRAW_EXIFTAG_TYPE_SLONG8    = 17,
  LIBRAW_EXIFTAG_TYPE_IFD8      = 18
}

enum LIBRAW_EXIFTOOLTAGTYPE_int8u =       LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_BYTE;
enum LIBRAW_EXIFTOOLTAGTYPE_string =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_ASCII;
enum LIBRAW_EXIFTOOLTAGTYPE_int16u =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_SHORT;
enum LIBRAW_EXIFTOOLTAGTYPE_int32u =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_LONG;
enum LIBRAW_EXIFTOOLTAGTYPE_rational64u = LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_RATIONAL;
enum LIBRAW_EXIFTOOLTAGTYPE_int8s =       LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_SBYTE;
enum LIBRAW_EXIFTOOLTAGTYPE_undef =       LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_UNDEFINED;
enum LIBRAW_EXIFTOOLTAGTYPE_binary =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_UNDEFINED;
enum LIBRAW_EXIFTOOLTAGTYPE_int16s =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_SSHORT;
enum LIBRAW_EXIFTOOLTAGTYPE_int32s =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_SLONG;
enum LIBRAW_EXIFTOOLTAGTYPE_rational64s = LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_SRATIONAL;
enum LIBRAW_EXIFTOOLTAGTYPE_float =       LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_FLOAT;
enum LIBRAW_EXIFTOOLTAGTYPE_double =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_DOUBLE;
enum LIBRAW_EXIFTOOLTAGTYPE_ifd =         LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_IFD;
enum LIBRAW_EXIFTOOLTAGTYPE_unicode =     LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_UNICODE;
enum LIBRAW_EXIFTOOLTAGTYPE_complex =     LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_COMPLEX;
enum LIBRAW_EXIFTOOLTAGTYPE_int64u =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_LONG8;
enum LIBRAW_EXIFTOOLTAGTYPE_int64s =      LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_SLONG8;
enum LIBRAW_EXIFTOOLTAGTYPE_ifd64 =       LibRaw_ExifTagTypes.LIBRAW_EXIFTAG_TYPE_IFD8;

enum LIBRAW_LENS_NOT_SET = 0xffffffffffffffffUL;

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
	Underwater = 65,
	FluorescentHigh = 66,
	HT_Mercury = 67,
	AsShot = 81,
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
	PC_Set1 = 96,
	PC_Set2 = 97,
	PC_Set3 = 98,
	PC_Set4 = 99,
	PC_Set5 = 100,
	Measured = 110,
	BW = 120,
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
	ALL = FLOAT | LINEAR | DEFLATE | XTRANS | _8BIT | OTHER /* |LARGERANGE */,
	DEFAULT = FLOAT | LINEAR | DEFLATE | _8BIT
}

enum LibRaw_output_flags {
    LIBRAW_OUTPUT_FLAGS_NONE = 0,
    LIBRAW_OUTPUT_FLAGS_PPMMETA = 1
}

enum LibRaw_runtime_capabilities {
	RAWSPEED = 1,
	DNGSDK = 1<<1,
	GPRSDK = 1<<2,
	UNICODEPATHS = 1<<3,
	X3FTOOLS = 1<<4,
	RPI6BY9 = 1<<5,
	ZLIB = 1<<6,
	JPEG = 1<<7,
	RAWSPEED3 = 1<<8,
	RAWSPEED_BITS = 1<<9,
}

enum LibRaw_colorspace {
	NotFound = 0,
	sRGB,
	AdobeRGB,
	WideGamutRGB,
	ProPhotoRGB,
	ICC,
	Uncalibrated, // Tag 0x0001 InteropIndex containing "R03" + LIBRAW_COLORSPACE_Uncalibrated = Adobe RGB
	CameraLinearUniWB,
	CameraLinear,
	CameraGammaUniWB,
	CameraGamma,
	MonochromeLinear,
	MonochromeGamma,
	Unknown = 255
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
	JK_Imaging,
	Kodak,
	Konica,
	Leaf,
	Leica,
	Lenovo,
	LG,
	Logitech,
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
	VLUU,
	Xiaomi,
	XIAOYI,
	YI,
	Yuneec,
	Zeiss,
  OnePlus,
  ISG,
  VIVO,
  HMD_Global,
  HUAWEI,
  RaspberryPi,
  OmDigital,
	TheLastOne
}

enum LibRaw_camera_mounts {
	Alpa,
	C,              /* C-mount */
	Canon_EF_M,
	Canon_EF_S,
	Canon_EF,
	Canon_RF,
	Contax_N,
	Contax645,
	FT,             /* original 4/3 */
	mFT,            /* micro 4/3 */
	Fuji_GF,        /* Fujifilm GFX cameras, G mount */
	Fuji_GX,        /* Fujifilm GX680 */
	Fuji_X,
	Hasselblad_H,   /* Hasselblad Hn cameras, HC & HCD lenses */
	Hasselblad_V,
	Hasselblad_XCD, /* Hasselblad Xn cameras, XCD lenses */
	Leica_M,        /* Leica rangefinder bayonet */
	Leica_R,        /* Leica SLRs, 'R' for reflex */
	Leica_S,        /* LIBRAW_FORMAT_LeicaS 'MF' */
	Leica_SL,       /* lens, mounts on 'L' throat, FF */
	Leica_TL,       /* lens, mounts on 'L' throat, APS-C */
	LPS_L,          /* Leica/Panasonic/Sigma camera mount, takes L, SL and TL lenses */
	Mamiya67,       /* Mamiya RB67, RZ67 */
	Mamiya645,
	Minolta_A,
	Nikon_CX,       /* used in 'Nikon 1' series */
	Nikon_F,
	Nikon_Z,
  PhaseOne_iXM_MV,
  PhaseOne_iXM_RS,
  PhaseOne_iXM,
	Pentax_645,
	Pentax_K,
	Pentax_Q,
	RicohModule,
	Rollei_bayonet, /* Rollei Hy-6: Leaf AFi, Sinar Hy6- models */
	Samsung_NX_M,
	Samsung_NX,
	Sigma_X3F,
	Sony_E,
	LF,
	DigitalBack,
	FixedLens,
	IL_UM,          /* Interchangeable lens, mount unknown */
	TheLastOne
}

enum LibRaw_camera_formats {
	APSC,
	FF,
	MF,
	APSH,
	_1INCH,
	_1div2p3INCH,  /* 1/2.3" */
	_1div1p7INCH,  /* 1/1.7" */
	FT,           /* sensor size in FT & mFT cameras */
	CROP645,      /* 44x33mm */
	LeicaS,       /* 'MF' Leicas */
	_645,
	_66,
	_69,
	LF,
	Leica_DMR,
	_67,
	SigmaAPSC,    /* DP1, DP2, SD15, SD14, SD10, SD9 */
	SigmaMerrill, /* SD1,  'SD1 Merrill',  'DP1 Merrill',  'DP2 Merrill' */
	SigmaAPSH,    /* 'sd Quattro H' */
	_3648,         /* DALSA FTF4052C (Mamiya ZD) */
	_68,           /* Fujifilm GX680 */
	TheLastOne
}

enum LibRawImageAspects {
	UNKNOWN = 0,
  OTHER = 1,
  MINIMAL_REAL_ASPECT_VALUE = 99, /* 1:10*/
  MAXIMAL_REAL_ASPECT_VALUE = 10000, /* 10: 1*/
  // Value:  width / height * 1000
  _3to2 =  (1000 * 3)/2,
  _1to1 =  1000,
  _4to3 =  (1000 * 4)/ 3,
  _16to9 = (1000 * 16) / 9,
  //6to6, // what is the difference with 1:1 ?
  _5to4 = (1000 * 5) / 4,
  _7to6 = (1000 * 7) / 6,
  _6to5 = (1000 * 6) / 5,
  _7to5 = (1000 * 7) / 5
}

enum LibRaw_lens_focal_types {
	UNDEFINED = 0,
	PRIME_LENS = 1,
	ZOOM_LENS = 2,
	ZOOM_LENS_CONSTANT_APERTURE = 3,
	ZOOM_LENS_VARIABLE_APERTURE = 4
}

enum LibRaw_Canon_RecordModes {
	UNDEFINED = 0,
	JPEG,
	CRW_THM,
	AVI_THM,
	TIF,
	TIF_JPEG,
	CR2,
	CR2_JPEG,
	UNKNOWN,
	MOV,
	MP4,
	CRM,
	CR3,
	CR3_JPEG,
	HEIF,
	CR3_HEIF,
	TheLastOne
}

enum LibRaw_minolta_storagemethods
{
  UNPACKED = 0x52,
  PACKED   = 0x59
}

enum LibRaw_minolta_bayerpatterns
{
  RGGB   = 0x01,
  G2BRG1 = 0x04
}

enum LibRaw_sony_cameratypes {
	DSC = 1,
	DSLR = 2,
	NEX = 3,
	SLT = 4,
	ILCE = 5,
	ILCA = 6,
	UNKNOWN = 0xffff
}

enum LibRaw_Sony_0x2010_Type {
  Tag2010None = 0,
  Tag2010a,
  Tag2010b,
  Tag2010c,
  Tag2010d,
  Tag2010e,
  Tag2010f,
  Tag2010g,
  Tag2010h,
  Tag2010i
}

enum LibRaw_Sony_0x9050_Type {
  Tag9050None = 0,
  Tag9050a,
  Tag9050b,
  Tag9050c
}

enum LIBRAW_SONY_FOCUSMODEmodes
{
  MF     = 0,
  AF_S   = 2,
  AF_C   = 3,
  AF_A   = 4,
  DMF    = 6,
  AF_D   = 7,
  AF           = 101,
  PERMANENT_AF = 104,
  SEMI_MF      = 105,
  UNKNOWN      = -1
}

enum LibRaw_KodakSensors
{
	UnknownSensor = 0,
	M1 = 1,
	M15 = 2,
	M16 = 3,
	M17 = 4,
	M2 = 5,
	M23 = 6,
	M24 = 7,
	M3 = 8,
	M5 = 9,
	M6 = 10,
	C14 = 11,
	X14 = 12,
	M11 = 13
}

enum LibRaw_HasselbladFormatCodes {
	Unknown = 0,
	_3FR,
	FFF,
	Imacon,
	HasselbladDNG,
	AdobeDNG,
	AdobeDNG_fromPhocusDNG
}

enum LibRaw_rawspecial_t
{
    SONYARW2_NONE = 0,
    SONYARW2_BASEONLY = 1,
    SONYARW2_DELTAONLY = 1 << 1,
    SONYARW2_DELTAZEROBASE = 1 << 2,
    SONYARW2_DELTATOVALUE = 1 << 3,
    SONYARW2_ALLFLAGS =
    SONYARW2_BASEONLY +
    SONYARW2_DELTAONLY +
    SONYARW2_DELTAZEROBASE +
    SONYARW2_DELTATOVALUE,
    NODP2Q_INTERPOLATERG = 1<<4,
    NODP2Q_INTERPOLATEAF = 1 << 5,
    SRAW_NO_RGB = 1 << 6,
    SRAW_NO_INTERPOLATE = 1 << 7
};

enum LibRaw_rawspeed_bits_t
{
    V1_USE = 1,
    V1_FAILONUNKNOWN = 1 << 1,
    V1_IGNOREERRORS = 1 << 2,
    /*  bits 3-7 are reserved*/
    V3_USE = 1 << 8,
    V3_FAILONUNKNOWN = 1 << 9,
    V3_IGNOREERRORS = 1 << 10,
}

enum LibRaw_processing_options {
  PENTAX_PS_ALLFRAMES = 1,
  CONVERTFLOAT_TO_INT = 1 << 1,
  ARQ_SKIP_CHANNEL_SWAP = 1 << 2,
  NO_ROTATE_FOR_KODAK_THUMBNAILS = 1 << 3,
// USE_DNG_DEFAULT_CROP = 1 << 4,
  USE_PPM16_THUMBS = 1 << 5,
  DONT_CHECK_DNG_ILLUMINANT = 1 << 6,
  DNGSDK_ZEROCOPY = 1 << 7,
  ZEROFILTERS_FOR_MONOCHROMETIFFS = 1 << 8,
  DNG_ADD_ENHANCED = 1 << 9,
  DNG_ADD_PREVIEWS = 1 << 10,
  DNG_PREFER_LARGEST_IMAGE = 1 << 11,
  DNG_STAGE2 = 1 << 12,
  DNG_STAGE3 = 1 << 13,
  DNG_ALLOWSIZECHANGE = 1 << 14,
  DNG_DISABLEWBADJUST = 1 << 15,
  PROVIDE_NONSTANDARD_WB = 1 << 16,
  CAMERAWB_FALLBACK_TO_DAYLIGHT = 1 << 17,
  CHECK_THUMBNAILS_KNOWN_VENDORS = 1 << 18,
  CHECK_THUMBNAILS_ALL_VENDORS = 1 << 19,
  DNG_STAGE2_IFPRESENT = 1 << 20,
  DNG_STAGE3_IFPRESENT = 1 << 21,
  DNG_ADD_MASKS = 1 << 22,
  CANON_IGNORE_MAKERNOTES_ROTATION = 1 << 23
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
	UNSUPPORTED_FORMAT = 1 << 14,
	NOTSET = 1 << 15,
	TRYRAWSPEED3 = 1 << 16
}

enum LIBRAW_XTRANS = 9;

enum LibRaw_constructor_flags {
	NONE = 0,
	NO_DATAERR_CALLBACK = 1 << 1,
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
	DNG_IMAGES_REORDERED = 1 << 18,
	DNG_STAGE2_APPLIED = 1 << 19,
	DNG_STAGE3_APPLIED = 1 << 20,
	RAWSPEED3_PROBLEM = 1 << 21,
	RAWSPEED3_UNSUPPORTED = 1 << 22,
	RAWSPEED3_PROCESSED = 1 << 23,
	RAWSPEED3_NOTLISTED = 1 << 24
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
	MEMPOOL = 11,
	UNSUPPORTED_FORMAT = 12
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
	TRESERVED2 = 1 << 30
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
	REQUEST_FOR_NONEXISTENT_THUMBNAIL = -9,
	UNSUFFICIENT_MEMORY = -100007,
	DATA_ERROR = -100008,
	IO_ERROR = -100009,
	CANCELLED_BY_CALLBACK = -100010,
	BAD_CROP = -100011,
	TOO_BIG = -100012,
	MEMPOOL_OVERFLOW = -100013
}

auto LIBRAW_FATAL_ERROR(E)(E ec) { return ec < -100000; }

enum LibRaw_internal_thumbnail_formats
{
	UNKNOWN = 0,
	KODAK_THUMB = 1,
	KODAK_YCBCR = 2,
	KODAK_RGB = 3,
	JPEG = 4,
	LAYER,
	ROLLEI,
	PPM,
	PPM16,
	X3F,
}

enum LibRaw_thumbnail_formats {
	UNKNOWN = 0,
	JPEG = 1,
	BITMAP = 2,
	BITMAP16 = 3,
	LAYER = 4,
	ROLLEI = 5,
	H265 = 6
}

enum LibRaw_image_formats {
	JPEG = 1,
	BITMAP = 2
}
