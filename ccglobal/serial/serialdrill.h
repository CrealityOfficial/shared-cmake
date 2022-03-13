#ifndef CCGLOBAL_SERIAL_DRILL_H
#define CCGLOBAL_SERIAL_DRILL_H
#include "ccglobal/serial/serialtrimesh.h"

void cc_load_drill(const std::string& file, trimesh::fxform& xf)
{
	auto f = [&xf](std::fstream& in) {
		loadFXform(in, xf);
	};
	serialLoad(file, f);
}

void cc_save_drill(const std::string& file, trimesh::fxform& xf)
{
	auto f = [&xf](std::fstream& out) {
		saveFXform(out, xf);
	};
	serialSave(file, f);
}
#endif // CCGLOBAL_SERIAL_DRILL_H