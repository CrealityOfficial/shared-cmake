#ifndef CCGLOBAL_SERIAL_DRILL_H
#define CCGLOBAL_SERIAL_DRILL_H
#include "ccglobal/serial/serialtrimesh.h"

struct CCDrillParam
{
	int count;
	float radius;
	float depth;
	trimesh::vec3 position;
	trimesh::vec3 normal;
	bool onlyOneLayer;
};

void cc_load_drill(const std::string& file, trimesh::fxform& xf, trimesh::TriMesh& mesh, std::vector<CCDrillParam>& params)
{
	auto f = [&xf, &mesh, &params](std::fstream& in) {
		loadFXform(in, xf);
		loadTrimesh(in, mesh);
		loadVectorT(in, params);
	};
	serialLoad(file, f);
}

void cc_save_drill(const std::string& file, trimesh::fxform& xf, trimesh::TriMesh& mesh, std::vector<CCDrillParam>& params)
{
	auto f = [&xf, &mesh, &params](std::fstream& out) {
		saveFXform(out, xf);
		saveTrimesh(out, mesh);
		saveVectorT(out, params);
	};
	serialSave(file, f);
}
#endif // CCGLOBAL_SERIAL_DRILL_H