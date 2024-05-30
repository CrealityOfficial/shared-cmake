#ifndef CCGLOBAL_RENDER_DEBUGGER_1684896500824_H
#define CCGLOBAL_RENDER_DEBUGGER_1684896500824_H
#include "trimesh2/TriMesh.h"
#include "trimesh2/XForm.h"

namespace ccglobal
{
	typedef std::vector<trimesh::vec3> Polygon;
	
	class VisualDebugger
	{
	public:
		virtual ~VisualDebugger() {}

		virtual void visual_polygon(const Polygon& polygon, const trimesh::vec3& color, float width) = 0;
	};
}

#endif 