#ifndef EXPORT_INTERFACE_1604911737496_H
#define EXPORT_INTERFACE_1604911737496_H

#ifdef WIN32
	#ifdef SLICE_SERVICE_DLL
		#define SLICE_SERVICE_API __declspec(dllexport)
	#else
		#define SLICE_SERVICE_API __declspec(dllimport)
	#endif
#else
	#ifdef SLICE_SERVICE_DLL
		#define SLICE_SERVICE_API __attribute__((visibility("default")))
	#else
		#define SLICE_SERVICE_API
	#endif
#endif
#endif // EXPORT_INTERFACE_1604911737496_H