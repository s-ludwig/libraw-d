module libraw.types;

import libraw.const_;
import libraw.version_;

import core.sys.posix.sys.types;
version (Windows) alias time_t = ulong;
else import core.sys.posix.sys.time;
import core.stdc.stdio;
import core.stdc.stdint;
import core.stdc.config;

/*#if defined(USE_LCMS)
#include <lcms.h>
#elif defined(USE_LCMS2)
#include <lcms2.h>
#else
#define NO_LCMS
#endif*/
version = NO_LCMS;

extern (C)
{
	struct libraw_decoder_info_t {
		const char *decoder_name;
		uint decoder_flags;
	}

	struct libraw_internal_output_params_t {
		uint mix_green;
		uint raw_color;
		uint zero_is_bad;
		ushort shrink;
		ushort fuji_width;
	}

	alias memory_callback = void function(void *data, const char *file, const char *where);
	alias exif_parser_callback = void function(void *context, int tag, int type, int len, uint ord, void *ifp, long base);

	alias data_callback = void function(void *data, const char *file, const int offset);

	void default_data_callback(void *data, const char *file, const int offset);

	alias progress_callback = int function(void *data, LibRaw_progress stage, int iteration, int expected);
	alias pre_identify_callback = int function(void *ctx);
	alias post_identify_callback = void function(void *ctx);
	alias process_step_callback = void function(void *ctx);

	struct libraw_callbacks_t {
		data_callback data_cb;
		void *datacb_data;

		progress_callback progress_cb;
		void *progresscb_data;

		exif_parser_callback exif_cb;
		void *exifparser_data;
		pre_identify_callback pre_identify_cb;
		post_identify_callback post_identify_cb;
		process_step_callback pre_subtractblack_cb, pre_scalecolors_cb, pre_preinterpolate_cb, pre_interpolate_cb,
				interpolate_bayer_cb, interpolate_xtrans_cb,
					post_interpolate_cb, pre_converttorgb_cb, post_converttorgb_cb;
	}

	struct libraw_abstract_datastream_t {
		int function(void *userptr) valid;
		int function(void *, size_t, size_t, void *userptr) read;
		int function(long, int, void *userptr) seek;
		long function(void *userptr) tell;
		long function(void *userptr) size;
		int function(void *userptr) get_char;
		char *function(char *, int, void *userptr) gets;
		int function(const(char)*, void*, void *userptr) scanf_one;
		int function(void *userptr) eof;
		void *function(void *userptr) make_jas_stream;

		void* userptr;
	}

	struct libraw_processed_image_t {
		LibRaw_image_formats type;
		ushort height, width, colors, bits;
		uint data_size;
		ubyte[1] data;
	}

	struct libraw_iparams_t {
		char[4] guard;
		char[64] make;
		char[64] model;
		char[64] software;
		char[64] normalized_make;
		char[64] normalized_model;
		uint maker_index;
		uint raw_count;
		uint dng_version;
		uint is_foveon;
		int colors;
		uint filters;
		char[6][6] xtrans;
		char[6][6] xtrans_abs;
		char[5] cdesc;
		uint xmplen;
		char *xmpdata;

	}

	struct libraw_raw_inset_crop_t {
		ushort cleft, ctop, cwidth, cheight;
	}

	struct libraw_image_sizes_t {
		ushort raw_height, raw_width, height, width, top_margin, left_margin;
		ushort iheight, iwidth;
		uint raw_pitch;
		double pixel_aspect;
		int flip;
		int[4][8] mask;
    	ushort raw_aspect;
    	libraw_raw_inset_crop_t[2] raw_inset_crops;
	}

	struct libraw_area_t {
		short t,l,b,r; // top, left, bottom, right pixel coordinates, (0,0) is top left pixel;
	}

	struct ph1_t
	{
		int format, key_off, tag_21a;
		int t_black, split_col, black_col, split_row, black_row;
		float tag_210;
	}

	struct libraw_dng_color_t {
		uint parsedfields;
		ushort illuminant;
		float[4][4] calibration;
		float[3][4] colormatrix;
		float[4][3] forwardmatrix;
	}

	struct libraw_dng_levels_t {
		uint parsedfields;
		uint[LIBRAW_CBLACK_SIZE] dng_cblack;
		uint dng_black;
		float[LIBRAW_CBLACK_SIZE] dng_fcblack;
		float dng_fblack;
		uint[4] dng_whitelevel;
		ushort[4] default_crop; /* Origin and size */
		float[4] user_crop; // top-left-bottom-right relative to default_crop
		uint preview_colorspace;
		float[4] analogbalance;
		float[4] asshotneutral;
		float baseline_exposure;
		float LinearResponseLimit;
	}

	struct libraw_P1_color_t {
		float[9] romm_cam;
	}

	struct libraw_canon_makernotes_t {
		int ColorDataVer;
		int ColorDataSubVer;
		int SpecularWhiteLevel;
		int NormalWhiteLevel;
		int[4] ChannelBlackLevel;
		int AverageBlackLevel;
		/* multishot */
		uint[4] multishot;
		/* metering */
		short MeteringMode;
		short SpotMeteringMode;
		ubyte FlashMeteringMode;
		short FlashExposureLock;
		short ExposureMode;
		short AESetting;
		/* stabilization */
		short ImageStabilization;
		/* flash */
		short FlashMode;
		short FlashActivity;
		short FlashBits;
		short ManualFlashOutput;
		short FlashOutput;
		short FlashGuideNumber;
		/* drive */
		short ContinuousDrive;
		/* sensor */
		short SensorWidth;
		short SensorHeight;

		int   AFMicroAdjMode;
		float AFMicroAdjValue;
		short MakernotesFlip;
		short RecordMode;
		short SRAWQuality;
		uint wbi;
		short RF_lensID;
		int AutoLightingOptimizer;
		int HighlightTonePriority;

		/* -1 = n/a            1 = Economy
		    2 = Normal         3 = Fine
		    4 = RAW            5 = Superfine
		    7 = CRAW         130 = Normal Movie, CRM LightRaw
		  131 = CRM  StandardRaw */
		short Quality;
		/* data compression curve
		    0 = OFF  1 = CLogV1 2 = CLogV2? 3 = CLogV3 */
		int CanonLog;

		libraw_area_t DefaultCropAbsolute;
		libraw_area_t RecommendedImageArea;   // contains the image in proper aspect ratio?
		libraw_area_t LeftOpticalBlack;       // use this, when present, to estimate black levels?
		libraw_area_t UpperOpticalBlack;
		libraw_area_t ActiveArea;

		short[2] ISOgain; // AutoISO & BaseISO per ExifTool
	}

	struct libraw_hasselblad_makernotes_t {
		int    BaseISO;
		double Gain;
		char[8]   Sensor;
		char[64]   SensorUnit; // SU
		char[64]   HostBody;   // HB
		int    SensorCode;
		int    SensorSubCode;
		int    CoatingCode;
		int    uncropped;

/* CaptureSequenceInitiator is based on the content of the 'model' tag
	- values like 'Pinhole', 'Flash Sync', '500 Mech.' etc in .3FR 'model' tag
		come from MAIN MENU > SETTINGS > Camera;
	- otherwise 'model' contains:
		1. if CF/CFV/CFH, SU enclosure, can be with SU type if '-' is present
		2. else if '-' is present, HB + SU type;
		3. HB;
*/
		char[32] CaptureSequenceInitiator;

/* SensorUnitConnector, makernotes 0x0015 tag:
 - in .3FR - SU side
 - in .FFF - HB side
*/
		char[64] SensorUnitConnector;

		int format; // 3FR, FFF, Imacon (H3D-39 and maybe others), Hasselblad/Phocus DNG, Adobe DNG
		int[2] nIFD_CM; // number of IFD containing CM
		int[2] RecommendedCrop;

/* mnColorMatrix is in makernotes tag 0x002a;
	not present in .3FR files and Imacon/H3D-39 .FFF files;
	when present in .FFF and Phocus .DNG files, it is a copy of CM1 from .3FR;
	available samples contain all '1's in the first 3 elements
*/
		double[3][4] mnColorMatrix;

	}

	struct libraw_fuji_info_t {
		float  ExpoMidPointShift;
		ushort DynamicRange;
		ushort FilmMode;
		ushort DynamicRangeSetting;
		ushort DevelopmentDynamicRange;
		ushort AutoDynamicRange;
		ushort DRangePriority;
		ushort DRangePriorityAuto;
		ushort DRangePriorityFixed;
		char[32 + 1] FujiModel;
		char[32 + 1] FujiModel2;

		/*
		tag 0x9200, converted to BrightnessCompensation
		F700, S3Pro, S5Pro, S20Pro, S200EXR
		E550, E900, F810, S5600, S6500fd, S9000, S9500, S100FS
		*/
		float BrightnessCompensation; /* in EV, if =4, raw data * 2^4 */

		ushort FocusMode;
		ushort AFMode;
		ushort[2] FocusPixel;
		ushort PrioritySettings;
		uint FocusSettings;
		uint AF_C_Settings;
		ushort FocusWarning;
		ushort[3] ImageStabilization;
		ushort FlashMode;
		ushort WB_Preset;

		/* ShutterType:
			 0 - mechanical
			 1 = electronic
			 2 = electronic, long shutter speed
			 3 = electronic, front curtain
		*/
		ushort ShutterType;
		ushort ExrMode;
		ushort Macro;
		uint Rating;

		/* CropMode:
			 1 - FF on GFX,
			 2 - sports finder (mechanical shutter),
			 4 - 1.25x crop (electronic shutter, continuous high)
		*/
		ushort CropMode;
		char[0x0c + 1]   SerialSignature;
		char[4 + 1]   SensorID;
		char[4 + 1]   RAFVersion;
		int    RAFDataGeneration; // 0 (none), 1..4, 4096
		ushort RAFDataVersion;
		int    isTSNERDTS;

		/* DriveMode:
			 0 - single frame
			 1 - continuous low
			 2 - continuous high
		*/
		short DriveMode;

		/*
		tag 0x4000 BlackLevel:
		S9100, S9000, S7000, S6000fd, S5200, S5100, S5000,
		S5Pro, S3Pro, S2Pro, S20Pro,
		S200EXR, S100FS,
		F810, F700,
		E900, E550,
		DBP, and aliases for all of the above
		*/
		ushort[9] BlackLevel;
		uint[32] RAFData_ImageSizeTable;
		int AutoBracketing;
		int SequenceNumber;
		int SeriesLength;
		float[2] PixelShiftOffset;
		int ImageCount;
	}

	struct libraw_sensor_highspeed_crop_t {
		ushort cleft, ctop, cwidth, cheight;
	}

	struct libraw_nikon_makernotes_t {
		double ExposureBracketValue;
		ushort ActiveDLighting;
		ushort ShootingMode;
		/* stabilization */
		ubyte[7] ImageStabilization;
		ubyte VibrationReduction;
		ubyte VRMode;
		/* flash */
		char[13] FlashSetting;
		char[20] FlashType;
		ubyte[4] FlashExposureCompensation;
		ubyte[4] ExternalFlashExposureComp;
		ubyte[4] FlashExposureBracketValue;
		ubyte FlashMode;
		byte FlashExposureCompensation2;
		byte FlashExposureCompensation3;
		byte FlashExposureCompensation4;
		ubyte FlashSource;
		ubyte[2] FlashFirmware;
		ubyte ExternalFlashFlags;
		ubyte FlashControlCommanderMode;
		ubyte FlashOutputAndCompensation;
		ubyte FlashFocalLength;
		ubyte FlashGNDistance;
		ubyte[4] FlashGroupControlMode;
		ubyte[4] FlashGroupOutputAndCompensation;
		ubyte FlashColorFilter;

/* NEF compression, comments follow those for ExifTool tag 0x0093:
	 1: Lossy (type 1)
	 2: Uncompressed
	 3: Lossless
	 4: Lossy (type 2)
	 5: Striped packed 12-bit
	 6: Uncompressed (14-bit reduced to 12-bit)
	 7: Unpacked 12-bit
	 8: Small raw
	 9: Packed 12-bit
	10: Packed 14-bit
	13: High Efficiency  (HE)
	14: High Efficiency* (HE*)
*/
		ushort NEFCompression;

		int    ExposureMode;
		int    ExposureProgram;
		int    nMEshots;
		int    MEgainOn;
		double[4] ME_WB;
		ubyte AFFineTune;
		ubyte AFFineTuneIndex;
		int8_t AFFineTuneAdj;
		uint LensDataVersion;
		uint FlashInfoVersion;
		uint ColorBalanceVersion;
		ubyte key;
		ushort[4] NEFBitDepth;
		ushort HighSpeedCropFormat; /* 1 -> 1.3x; 2 -> DX; 3 -> 5:4; 4 -> 3:2; 6 ->
																	 16:9; 11 -> FX uncropped; 12 -> DX uncropped;
																	 17 -> 1:1 */
		libraw_sensor_highspeed_crop_t SensorHighSpeedCrop;
		ushort SensorWidth;
		ushort SensorHeight;
		ushort Active_D_Lighting;
		uint PictureControlVersion;
		char[20] PictureControlName;
		char[20] PictureControlBase;
		uint ShotInfoVersion;
		short MakernotesFlip;
		double RollAngle;  // positive is clockwise, CW
		double PitchAngle; // positive is upwords
		double YawAngle;   // positive is to the right
	}

	struct libraw_olympus_makernotes_t {
		char[6]  CameraType2;
		ushort   ValidBits;
		int[2]   SensorCalibration;
		ushort[5] DriveMode;
		ushort   ColorSpace;
		ushort[2] FocusMode;
		ushort   AutoFocus;
		ushort   AFPoint;
		uint[64] AFAreas;
		double[5] AFPointSelected;
		ushort   AFResult;
		ubyte    AFFineTune;
		short[3] AFFineTuneAdj;
		uint[3]  SpecialMode;
		ushort   ZoomStepCount;
		ushort   FocusStepCount;
		ushort   FocusStepInfinity;
		ushort   FocusStepNear;
		double   FocusDistance;
		ushort[4] AspectFrame; // left, top, width, height
		uint[2]  StackedImage;
		ubyte    isLiveND;
		uint     LiveNDfactor;
		ushort   Panorama_mode;
		ushort   Panorama_frameNum;
	}

	struct libraw_panasonic_makernotes_t {
		/* Compression:
		 34826 (Panasonic RAW 2): LEICA DIGILUX 2;
		 34828 (Panasonic RAW 3): LEICA D-LUX 3; LEICA V-LUX 1; Panasonic DMC-LX1;
		 Panasonic DMC-LX2; Panasonic DMC-FZ30; Panasonic DMC-FZ50; 34830 (not in
		 exiftool): LEICA DIGILUX 3; Panasonic DMC-L1; 34316 (Panasonic RAW 1):
		 others (LEICA, Panasonic, YUNEEC);
		*/
		ushort   Compression;
		ushort   BlackLevelDim;
		float[8] BlackLevel;
		uint     Multishot; /* 0 is Off, 65536 is Pixel Shift */
		float    gamma;
		int[3]   HighISOMultiplier; /* 0->R, 1->G, 2->B */
		short    FocusStepNear;
		short    FocusStepCount;
		uint     ZoomPosition;
		uint     LensManufacturer;
	}

	struct libraw_pentax_makernotes_t {
		ubyte[4] DriveMode;
		ushort[2] FocusMode;
		ushort[2] AFPointSelected;
		ushort   AFPointSelected_Area;
		int      AFPointsInFocus_version;
		uint     AFPointsInFocus;
		ushort   FocusPosition;
		short    AFAdjustment;
		ubyte    AFPointMode;
		ubyte    MultiExposure; /* last bit is not "1" if ME is not used */
		ushort   Quality; /* 4 is raw, 7 is raw w/ pixel shift, 8 is raw w/ dynamic
											 pixel shift */
	}

	struct libraw_ricoh_makernotes_t {
		ushort   AFStatus;
		uint[2]  AFAreaXPosition;
		uint[2]  AFAreaYPosition;
		ushort   AFAreaMode;
		uint     SensorWidth;
		uint     SensorHeight;
		uint     CroppedImageWidth;
		uint     CroppedImageHeight;
		ushort   WideAdapter;
		ushort   CropMode;
		ushort   NDFilter;
		ushort   AutoBracketing;
		ushort   MacroMode;
		ushort   FlashMode;
		double   FlashExposureComp;
		double   ManualFlashOutput;
	}

	struct libraw_samsung_makernotes_t {
		uint[4]  ImageSizeFull;
		uint[4]  ImageSizeCrop;
		int[2]   ColorSpace;
		uint[11] key;
		double   DigitalGain; /* PostAEGain, digital stretch */
		int      DeviceType;
		char[32] LensFirmware;
	}

	struct libraw_kodak_makernotes_t {
		ushort BlackLevelTop;
		ushort BlackLevelBottom;
		short offset_left, offset_top; /* KDC files, negative values or zeros */
		ushort clipBlack, clipWhite;   /* valid for P712, P850, P880 */
		float[3][3] romm_camDaylight;
		float[3][3] romm_camTungsten;
		float[3][3] romm_camFluorescent;
		float[3][3] romm_camFlash;
		float[3][3] romm_camCustom;
		float[3][3] romm_camAuto;
		ushort val018percent, val100percent, val170percent;
		short MakerNoteKodak8a;
		float ISOCalibrationGain;
		float AnalogISO;
	}

	struct libraw_p1_makernotes_t {
		char[64] Software;        // tag 0x0203
		char[64] SystemType;      // tag 0x0204
		char[256] FirmwareString; // tag 0x0301
		char[64] SystemModel;
	}

	struct libraw_sony_info_t {
		/* afdata:
		  0x0010 CameraInfo
		  0x2020 AFPointsUsed
		  0x2022 FocalPlaneAFPointsUsed
		  0x202a Tag202a
		  0x940e AFInfo
		*/
		ushort   CameraType;                      // init in 0xffff
		ubyte    Sony0x9400_version; /* 0 if not found/deciphered,
		                            0xa, 0xb, 0xc following exiftool convention */
		ubyte    Sony0x9400_ReleaseMode2;
		uint     Sony0x9400_SequenceImageNumber;
		ubyte    Sony0x9400_SequenceLength1;
		uint     Sony0x9400_SequenceFileNumber;
		ubyte    Sony0x9400_SequenceLength2;
		uint8_t  AFAreaModeSetting;               // init in 0xff; +
		uint16_t AFAreaMode;                      // init in 0xffff; +
		ushort[2] FlexibleSpotPosition;           // init in (0xffff, 0xffff)
		uint8_t  AFPointSelected;                 // init in 0xff
		uint8_t  AFPointSelected_0x201e;          // init in 0xff
	    short    nAFPointsUsed;
		uint8_t[10] AFPointsUsed;
		uint8_t  AFTracking;                      // init in 0xff
		uint8_t  AFType;
		ushort[4] FocusLocation;
		ushort   FocusPosition;                    // init in 0xffff
		int8_t   AFMicroAdjValue;                  // init in 0x7f
		int8_t   AFMicroAdjOn;                     // init in -1
		ubyte    AFMicroAdjRegisteredLenses;       // init in 0xff
		ushort   VariableLowPassFilter;
		uint     LongExposureNoiseReduction;      // init in 0xffffffff
		ushort   HighISONoiseReduction;           // init in 0xffff
		ushort[2] HDR;
		ushort   group2010;
		ushort   group9050;

		ushort   len_group9050; // currently, for debugging only

		ushort   real_iso_offset;                 // init in 0xffff
		ushort   MeteringMode_offset;
		ushort   ExposureProgram_offset;
		ushort   ReleaseMode2_offset;
	    uint     MinoltaCamID;                    // init in 0xffffffff
		float    firmware;
		ushort   ImageCount3_offset;              // init in 0xffff
		uint     ImageCount3;
		uint     ElectronicFrontCurtainShutter;   // init in 0xffffffff
		ushort   MeteringMode2;
		char[20] SonyDateTime;
		uint     ShotNumberSincePowerUp;
		ushort   PixelShiftGroupPrefix;
		uint     PixelShiftGroupID;
		char     nShotsInPixelShiftGroup;
		char     numInPixelShiftGroup; /* '0' if ARQ, first shot in the group has '1'
																	here */
		ushort   prd_ImageHeight, prd_ImageWidth;
		ushort   prd_Total_bps;
		ushort   prd_Active_bps;
		ushort   prd_StorageMethod; /* 82 -> Padded; 89 -> Linear */
		ushort   prd_BayerPattern;  /* 0 -> not valid; 1 -> RGGB; 4 -> GBRG */

		ushort   SonyRawFileType; /* init in 0xffff
		                           valid for ARW 2.0 and up (FileFormat >= 3000)
		                           takes precedence over RAWFileType and Quality:
		                           0  for uncompressed 14-bit raw
		                           1  for uncompressed 12-bit raw
		                           2  for compressed raw (lossy)
		                           3  for lossless compressed raw
		                           4  for lossless compressed raw v.2 (ILCE-1)
		                        */
		ushort RAWFileType;     /* init in 0xffff
		                           takes precedence over Quality
		                           0 for compressed raw,
		                           1 for uncompressed;
		                           2 lossless compressed raw v.2
		                        */
		ushort RawSizeType;     /* init in 0xffff
		                           1 - large,
		                           2 - small,
		                           3 - medium
		                        */
		uint Quality;           /* init in 0xffffffff
		                           0 or 6 for raw, 7 or 8 for compressed raw */
		ushort FileFormat;      /*  1000 SR2
		                            2000 ARW 1.0
		                            3000 ARW 2.0
		                            3100 ARW 2.1
		                            3200 ARW 2.2
		                            3300 ARW 2.3
		                            3310 ARW 2.3.1
		                            3320 ARW 2.3.2
		                            3330 ARW 2.3.3
		                            3350 ARW 2.3.5
		                            4000 ARW 4.0
	                                4010 ARW 4.0.1
		                         */
		char[16] MetaVersion;
		float AspectRatio;
	}

	struct libraw_colordata_t {
		ushort[0x10000] curve;
		uint[LIBRAW_CBLACK_SIZE] cblack;
		uint black;
		uint data_maximum;
		uint maximum;

// Canon (SpecularWhiteLevel)
// Kodak (14N, 14nx, SLR/c/n, DCS720X, DCS760C, DCS760M, ProBack, ProBack645, P712, P880, P850)
// Olympus, except:
//	C5050Z, C5060WZ, C7070WZ, C8080WZ
//	SP350, SP500UZ, SP510UZ, SP565UZ
//	E-10, E-20
//	E-300, E-330, E-400, E-410, E-420, E-450, E-500, E-510, E-520
//	E-1, E-3
//	XZ-1
// Panasonic
// Pentax
// Sony
// and aliases of the above
// DNG
		c_long[4] linear_max;

		float fmaximum;
		float fnorm;
		ushort[8][8] white;
		float[4] cam_mul;
		float[4] pre_mul;
		float[4][3] cmatrix;
		float[4][3] ccm;
		float[4][3] rgb_cam;
		float[3][4] cam_xyz;
		ph1_t phase_one_data;
		float flash_used;
		float canon_ev;
		char[64] model2;
		char[64] UniqueCameraModel;
		char[64] LocalizedCameraModel;
		char[64] ImageUniqueID;
		char[17] RawDataUniqueID;
		char[64] OriginalRawFileName;
		void *profile;
		uint profile_length;
		uint[8] black_stat;
		libraw_dng_color_t[2] dng_color;
		libraw_dng_levels_t dng_levels;
		int[4][256] WB_Coeffs;    /* R, G1, B, G2 coeffs */
		float[5][64] WBCT_Coeffs; /* CCT, than R, G1, B, G2 coeffs */
		int as_shot_wb_applied;
		libraw_P1_color_t[2] P1_color;
		uint raw_bps; /* for Phase One: raw format; For other cameras: bits per pixel (copy of tiff_bps in most cases) */
											/* Phase One raw format values, makernotes tag 0x010e:
											0    Name unknown
											1    "RAW 1"
											2    "RAW 2"
											3    "IIQ L" (IIQ L14)
											4    Never seen
											5    "IIQ S"
											6    "IIQ Sv2" (S14 / S14+)
											7    Never seen
											8    "IIQ L16" (IIQ L16EX / IIQ L16)
											*/
		int ExifColorSpace;
	}

	struct libraw_thumbnail_t {
		LibRaw_thumbnail_formats tformat;
		ushort twidth, theight;
		uint tlength;
		int tcolors;
		char *thumb;
	}

	struct libraw_thumbnail_item_t {
		LibRaw_internal_thumbnail_formats tformat;
		ushort twidth, theight, tflip;
		uint tlength;
		uint tmisc;
		long toffset;
	}

	struct libraw_thumbnail_list_t {
		int thumbcount;
		libraw_thumbnail_item_t[LIBRAW_THUMBNAIL_MAXCOUNT] thumblist;
	}

	struct libraw_gps_info_t {
		float[3] latitude;     /* Deg,min,sec */
		float[3] longitude;    /* Deg,min,sec */
		float[3] gpstimestamp; /* Deg,min,sec */
		float altitude;
		char altref, latref, longref, gpsstatus;
		char gpsparsed;
	}

	struct libraw_imgother_t {
		float iso_speed;
		float shutter;
		float aperture;
		float focal_len;
		time_t timestamp;
		uint shot_order;
		uint[32] gpsdata;
		libraw_gps_info_t parsed_gps;
		char[512] desc;
		char[64] artist;
		float[4] analogbalance;
	}

	struct libraw_afinfo_item_t {
		uint     AFInfoData_tag;
		short    AFInfoData_order;
		uint     AFInfoData_version;
		uint     AFInfoData_length;
		ubyte*   AFInfoData;
	}

	struct libraw_metadata_common_t {
		float FlashEC;
		float FlashGN;
		float CameraTemperature;
		float SensorTemperature;
		float SensorTemperature2;
		float LensTemperature;
		float AmbientTemperature;
		float BatteryTemperature;
		float exifAmbientTemperature;
		float exifHumidity;
		float exifPressure;
		float exifWaterDepth;
		float exifAcceleration;
		float exifCameraElevationAngle;
		float real_ISO;
		float exifExposureIndex;
		ushort ColorSpace;
		char[128] firmware;
	    float ExposureCalibrationShift;
		libraw_afinfo_item_t[LIBRAW_AFDATA_MAXCOUNT] afdata;
		int afcount;
}

	struct libraw_output_params_t {
		uint[4] greybox;       /* -A  x1 y1 x2 y2 */
		uint[4] cropbox;       /* -B x1 y1 x2 y2 */
		double[4] aber;        /* -C */
		double[6] gamm;        /* -g */
		float[4] user_mul;     /* -r mul0 mul1 mul2 mul3 */
		float bright;          /* -b */
		float threshold;       /* -n */
		int half_size;         /* -h */
		int four_color_rgb;    /* -f */
		int highlight;         /* -H */
		int use_auto_wb;       /* -a */
		int use_camera_wb;     /* -w */
		int use_camera_matrix; /* +M/-M */
		int output_color;      /* -o */
		char *output_profile;  /* -o */
		char *camera_profile;  /* -p */
		char *bad_pixels;      /* -P */
		char *dark_frame;      /* -K */
		int output_bps;        /* -4 */
		int output_tiff;       /* -T */
		int output_flags;
		int user_flip;         /* -t */
		int user_qual;         /* -q */
		int user_black;        /* -k */
		int[4] user_cblack;
		int user_sat;          /* -S */
		int med_passes;        /* -m */
		float auto_bright_thr;
		float adjust_maximum_thr;
		int no_auto_bright;    /* -W */
		int use_fuji_rotate;   /* -j */
		int use_p1_correction;
		int green_matching;
		/* DCB parameters */
		int dcb_iterations;
		int dcb_enhance_fl;
		int fbdd_noiserd;
		int exp_correc;
		float exp_shift;
		float exp_preser;
		/* Disable Auto-scale */
		int no_auto_scale;
		/* Disable interpolation */
		int no_interpolation;
	}

	struct libraw_raw_unpack_params_t {
		/* Raw speed */
		int use_rawspeed;
		/* DNG SDK */
		int use_dngsdk;
		uint options;
		uint shot_select;  /* -s */
		uint specials;
		uint max_raw_memory_mb;
		int sony_arw2_posterization_thr;
		/* Nikon Coolscan */
		float coolscan_nef_gamma;
		char[5] p4shot_order;
		/* Custom camera list */
		char** custom_camera_strings;
	}

	struct libraw_rawdata_t {
		/* really allocated bitmap */
		void *raw_alloc;
		/* alias to single_channel variant */
		ushort *raw_image;
		/* alias to 4-channel variant */
		ushort[4]* color4_image;
		/* alias to 3-color variand decoded by RawSpeed */
		ushort[3]* color3_image;
		/* float bayer */
		float *float_image;
		/* float 3-component */
		float[3]* float3_image;
		/* float 4-component */
		float[4]* float4_image;

		/* Phase One black level data; */
		short[2]* ph1_cblack;
		short[2]* ph1_rblack;
		/* save color and sizes here, too.... */
		libraw_iparams_t iparams;
		libraw_image_sizes_t sizes;
		libraw_internal_output_params_t ioparams;
		libraw_colordata_t color;
	}

	struct libraw_makernotes_lens_t {
		ulong LensID;
		char[128] Lens;
		ushort LensFormat; /* to characterize the image circle the lens covers */
		ushort LensMount;  /* 'male', lens itself */
		ulong CamID;
		ushort CameraFormat; /* some of the sensor formats */
		ushort CameraMount;  /* 'female', body throat */
		char[64] body;
		short FocalType; /* -1/0 is unknown; 1 is fixed focal; 2 is zoom */
		char[16] LensFeatures_pre, LensFeatures_suf;
		float MinFocal, MaxFocal;
		float MaxAp4MinFocal, MaxAp4MaxFocal, MinAp4MinFocal, MinAp4MaxFocal;
		float MaxAp, MinAp;
		float CurFocal, CurAp;
		float MaxAp4CurFocal, MinAp4CurFocal;
		float MinFocusDistance;
		float FocusRangeIndex;
		float LensFStops;
		ulong TeleconverterID;
		char[128] Teleconverter;
		ulong AdapterID;
		char[128] Adapter;
		ulong AttachmentID;
		char[128] Attachment;
		ushort FocalUnits;
		float FocalLengthIn35mmFormat;
	}

	struct libraw_nikonlens_t {
		float EffectiveMaxAp;
		ubyte LensIDNumber, LensFStops, MCUVersion, LensType;
	}

	struct libraw_dnglens_t {
		float MinFocal, MaxFocal, MaxAp4MinFocal, MaxAp4MaxFocal;
	}

	struct libraw_lensinfo_t {
		float MinFocal, MaxFocal, MaxAp4MinFocal, MaxAp4MaxFocal, EXIF_MaxAp;
		char[128] LensMake, Lens, LensSerial, InternalLensSerial;
		ushort FocalLengthIn35mmFormat;
		libraw_nikonlens_t nikon;
		libraw_dnglens_t dng;
		libraw_makernotes_lens_t makernotes;
	}

	struct libraw_makernotes_t {
		libraw_canon_makernotes_t canon;
		libraw_nikon_makernotes_t nikon;
		libraw_hasselblad_makernotes_t hasselblad;
		libraw_fuji_info_t fuji;
		libraw_olympus_makernotes_t olympus;
		libraw_sony_info_t sony;
		libraw_kodak_makernotes_t kodak;
		libraw_panasonic_makernotes_t panasonic;
		libraw_pentax_makernotes_t pentax;
		libraw_p1_makernotes_t phaseone;
		libraw_ricoh_makernotes_t ricoh;
		libraw_samsung_makernotes_t samsung;
		libraw_metadata_common_t common;
	}

	struct libraw_shootinginfo_t {
		short DriveMode;
		short FocusMode;
		short MeteringMode;
		short AFPoint;
		short ExposureMode;
		short ExposureProgram;
		short ImageStabilization;
		char[64] BodySerial;
		char[64] InternalBodySerial; /* this may be PCB or sensor serial, depends on make/model*/
	}

	struct libraw_custom_camera_t {
		uint fsize;
		ushort rw, rh;
		ubyte lm, tm, rm, bm;
		ushort lf;
		ubyte cf, max, flags;
		char[10] t_make;
		char[20] t_model;
		ushort offset;
	}

	struct libraw_data_t {
		ushort[4]* image;
		libraw_image_sizes_t sizes;
		libraw_iparams_t idata;
		libraw_lensinfo_t lens;
		libraw_makernotes_t makernotes;
		libraw_shootinginfo_t shootinginfo;
		libraw_output_params_t params;
		libraw_raw_unpack_params_t rawparams;
		uint progress_flags;
		uint process_warnings;
		libraw_colordata_t color;
		libraw_imgother_t other;
		libraw_thumbnail_t thumbnail;
		libraw_thumbnail_list_t thumbs_list;
		libraw_rawdata_t rawdata;
		void *parent_class;
	}

	struct fuji_q_table {
		int8_t* q_table; /* quantization table */
		int raw_bits;
		int total_values;
		int max_grad;    // sdp val
		int q_grad_mult; // quant_gradient multiplier
		int q_base;
	}

	struct fuji_compressed_params {
		fuji_q_table[4] qt;
		void* buf;
		int max_bits;
		int min_value;
		int max_value;   // q_point[4]
		ushort line_width;
	}

	struct libraw_static_table_t
	{
		this(const(int)* a, const(uint) s) {
			data = a;
			_size = s;
		}
		this(ref const(libraw_static_table_t) s) {
			data = s.data;
			_size = s._size;
		}
		uint size() const { return _size; }
		int opIndex(uint idx) const
		{
			if (idx < _size) return data[idx];
			if(_size>0 && data) return data[0];
			return 0;
		}
	private:
		const(int)* data;
		uint _size;
	}
}

static import std.system;
enum LibRawBigEndian = std.system.endian == std.system.Endian.bigEndian;


// sanity check struct sizes to match the C/C++ side
version (Win64) {
	static assert(libraw_decoder_info_t.sizeof == 16);
	static assert(libraw_internal_output_params_t.sizeof == 16);
	static assert(libraw_callbacks_t.sizeof == 136);
	static assert(libraw_abstract_datastream_t.sizeof == 88);
	static assert(libraw_processed_image_t.sizeof == 20);
	static assert(libraw_iparams_t.sizeof == 440);
	static assert(libraw_raw_inset_crop_t.sizeof == 8);
	static assert(libraw_image_sizes_t.sizeof == 184);
	static assert(libraw_area_t.sizeof == 8);
	static assert(ph1_t.sizeof == 36);
	static assert(libraw_dng_color_t.sizeof == 168);
	static assert(libraw_dng_levels_t.sizeof == 32928);
	static assert(libraw_P1_color_t.sizeof == 36);
	static assert(libraw_canon_makernotes_t.sizeof == 168);
	static assert(libraw_hasselblad_makernotes_t.sizeof == 384);
	static assert(libraw_fuji_info_t.sizeof == 348);
	static assert(libraw_sensor_highspeed_crop_t.sizeof == 8);
	static assert(libraw_nikon_makernotes_t.sizeof == 264);
	static assert(libraw_olympus_makernotes_t.sizeof == 408);
	static assert(libraw_panasonic_makernotes_t.sizeof == 68);
	static assert(libraw_pentax_makernotes_t.sizeof == 32);
	static assert(libraw_ricoh_makernotes_t.sizeof == 72);
	static assert(libraw_samsung_makernotes_t.sizeof == 136);
	static assert(libraw_kodak_makernotes_t.sizeof == 244);
	static assert(libraw_p1_makernotes_t.sizeof == 448);
	static assert(libraw_sony_info_t.sizeof == 184);
	static assert(libraw_colordata_t.sizeof == 187032);
	static assert(libraw_thumbnail_t.sizeof == 24);
	static assert(libraw_gps_info_t.sizeof == 48);
	static assert(libraw_imgother_t.sizeof == 800);
	static assert(libraw_afinfo_item_t.sizeof == 24);
	static assert(libraw_metadata_common_t.sizeof == 304);
	static assert(libraw_output_params_t.sizeof == 304);
	static assert(libraw_raw_unpack_params_t.sizeof == 48);
	static assert(libraw_rawdata_t.sizeof == 187744);
	static assert(libraw_makernotes_lens_t.sizeof == 736);
	static assert(libraw_nikonlens_t.sizeof == 8);
	static assert(libraw_dnglens_t.sizeof == 16);
	static assert(libraw_lensinfo_t.sizeof == 1296);
	static assert(libraw_makernotes_t.sizeof == 3064);
	static assert(libraw_shootinginfo_t.sizeof == 142);
	static assert(libraw_custom_camera_t.sizeof == 52);
	static assert(libraw_data_t.sizeof == 381368);
	static assert(fuji_q_table.sizeof == 32);
	static assert(fuji_compressed_params.sizeof == 152);
}
