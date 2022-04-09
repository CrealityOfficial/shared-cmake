#ifndef CXSLICE_TESTHELPER_1622639863964_H
#define CXSLICE_TESTHELPER_1622639863964_H
#include "gtest/common_gtest.h"

#include "trimesh2/TriMesh.h"

void test_trimesh_valid(trimesh::TriMesh* mesh)
{
	ASSERT_TRUE(mesh);
	if (mesh)
	{
		GTEST_ASSERT_GT(mesh->vertices.size(), 0);
		GTEST_ASSERT_GT(mesh->faces.size(), 0);
	}
}



#endif // CXSLICE_TESTHELPER_1622639863964_H