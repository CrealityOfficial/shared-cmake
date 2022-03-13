#ifndef CCGLOBAL_SERIAL_DRILL_H
#define CCGLOBAL_SERIAL_DRILL_H
#include "ccglobal/serial/serialtrimesh.h"

void cc_load_drill(const std::string& file, trimesh::fxform& xf, trimesh::TriMesh& mesh)
{
	auto f = [&xf, &mesh](std::fstream& in) {
		loadFXform(in, xf);
		loadTrimesh(in, mesh);
	};
	serialLoad(file, f);
}

void cc_save_drill(const std::string& file, trimesh::fxform& xf, trimesh::TriMesh& mesh)
{
	auto f = [&xf, &mesh](std::fstream& out) {
		saveFXform(out, xf);
		saveTrimesh(out, mesh);
	};
	serialSave(file, f);
}
#endif // CCGLOBAL_SERIAL_DRILL_H