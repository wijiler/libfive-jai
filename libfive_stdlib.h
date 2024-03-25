#pragma once
#include "libfive.h"

// These are all markers used by the parser
#define LIBFIVE_STDLIB libfive_tree
#define LIBFIVE_SECTION(a)
#define LIBFIVE_ALIAS(a, b)

#ifdef __cplusplus
extern "C" {
#endif

// We accept trees for every argument, even those that would normally be
// floats, so that we can pass in free variables to parameterize shapes.
struct tvec2 {
    libfive_tree x, y;
};
struct tvec3 {
    libfive_tree x, y, z;
};
typedef libfive_tree tfloat;
typedef struct tvec2 tvec2;
typedef struct tvec3 tvec3;

////////////////////////////////////////////////////////////////////////////////
LIBFIVE_SECTION(csg)

LIBFIVE_STDLIB _union(
    // Returns the union of two shapes
    libfive_tree a, libfive_tree b);
LIBFIVE_STDLIB intersection(
    // Returns the intersection of two shapes
    libfive_tree a, libfive_tree b);
LIBFIVE_STDLIB inverse(
    // Returns a shape that's the inverse of the input shape
    libfive_tree a);
LIBFIVE_STDLIB difference(
    // Subtracts the second shape from the first
    libfive_tree a, libfive_tree b);
LIBFIVE_STDLIB offset(
    // Expand or contract a given shape by an offset
    // Positive offsets expand the shape; negative offsets shrink it
    libfive_tree a, tfloat o);
LIBFIVE_STDLIB clearance(
    // Expands shape b by the given offset then subtracts it from shape a
    libfive_tree a, libfive_tree b, tfloat offset);
LIBFIVE_STDLIB shell(
    // Returns a shell of a shape with the given offset
    libfive_tree a, tfloat offset);
LIBFIVE_STDLIB blend_expt(
    // Blends two shapes by the given amount using exponents
    libfive_tree a, libfive_tree b, tfloat m);
LIBFIVE_STDLIB blend_expt_unit(
    // Blends two shapes by the given amount using exponents,
    // with the blend term adjusted to produce results approximately
    // resembling blend_rough for values between 0 and 1.
    libfive_tree a, libfive_tree b, tfloat m);
LIBFIVE_STDLIB blend_rough(
    // Blends two shapes by the given amount, using a fast-but-rough
    // CSG approximation that may not preserve gradients
    libfive_tree a, libfive_tree b, tfloat m);
LIBFIVE_ALIAS(blend, blend_expt_unit)
LIBFIVE_STDLIB blend_difference(
    // Blends the subtraction of b, with optional offset o,
    // from a, with smoothness m
    libfive_tree a, libfive_tree b,
    tfloat m, tfloat o__0);
LIBFIVE_STDLIB morph(
    // Morphs between two shapes.
    // m = 0 produces a, m = 1 produces b
    libfive_tree a, libfive_tree b, tfloat m);
LIBFIVE_STDLIB loft(
    // Produces a blended loft between a (at zmin) and b (at zmax)
    // a and b should be 2D shapes (i.e. invariant along the z axis)
    libfive_tree a, libfive_tree b, tfloat zmin, tfloat zmax);
LIBFIVE_STDLIB loft_between(
    // Produces a blended loft between a (at lower.z) and b (at upper.z),
    // with XY coordinates remapped to slide between lower.xy and upper.xy.
    // a and b should be 2D shapes (i.e. invariant along the z axis)
    libfive_tree a, libfive_tree b, tvec3 lower, tvec3 upper);

////////////////////////////////////////////////////////////////////////////////
LIBFIVE_SECTION(shapes)

LIBFIVE_STDLIB circle(
    // A 2D circle with the given radius and optional center
    tfloat r, tvec2 center__0);
LIBFIVE_STDLIB ring(
    // A 2D ring with the given outer/inner radii and optional center
    tfloat ro, tfloat ri, tvec2 center__0);
LIBFIVE_STDLIB polygon(
    // A polygon with center-to-vertex distance r and n sides
    tfloat r, int n, tvec2 center__0);
LIBFIVE_STDLIB rectangle(
    // A rectangle with the given bounding corners
    tvec2 a, tvec2 b);
LIBFIVE_STDLIB rounded_rectangle(
    // A rectangle with rounded corners
    tvec2 a, tvec2 b, tfloat r);
LIBFIVE_STDLIB rectangle_exact(
    // A rectangle from an exact distance field
    tvec2 a, tvec2 b);
LIBFIVE_STDLIB rectangle_centered_exact(
    // An exact-field rectangle at the (optional) center
    tvec2 size, tvec2 center__0);
LIBFIVE_STDLIB triangle(
    // A 2D triangle
    tvec2 a, tvec2 b, tvec2 c);

LIBFIVE_STDLIB box_mitered(
    // A box with the given bounds, which will stay creased if offset
    tvec3 a, tvec3 b);
LIBFIVE_ALIAS(cube, box_mitered)
LIBFIVE_ALIAS(cube_centered, box_mitered_centered)
LIBFIVE_ALIAS(box, box_mitered)

LIBFIVE_STDLIB box_mitered_centered(
    // A box with the given size and (optional) center, with edges that
    // will stay sharp if offset.
    tvec3 size, tvec3 center__0);
LIBFIVE_ALIAS(box_centered, box_mitered_centered)
LIBFIVE_STDLIB box_exact_centered(
    // A box with the given size, centered around the given point,
    // with a Euclidean distance metric
    tvec3 size, tvec3 center__0);
LIBFIVE_STDLIB box_exact(
    // A box with the given bounds with a Euclidean distance metric
    tvec3 a, tvec3 b);
LIBFIVE_STDLIB rounded_box(
    // Rounded box with the given bounds and radius (as a 0-1 fraction)
    tvec3 a, tvec3 b, tfloat r);
LIBFIVE_ALIAS(rounded_cube, rounded_box)
LIBFIVE_STDLIB sphere(
    // A sphere with the given radius and (optional) center
    tfloat radius, tvec3 center__0);
LIBFIVE_STDLIB half_space(
    // A plane which divides the world into inside and outside, defined by its
    // normal and a single point on the plane
    tvec3 norm, tvec3 point__0);
LIBFIVE_STDLIB cylinder_z(
    // A cylinder with the given radius and height, extruded from the
    // (optional) base position.
    tfloat r, tfloat h, tvec3 base__0);
LIBFIVE_ALIAS(cylinder, cylinder_z)
LIBFIVE_STDLIB cone_ang_z(
    // A cone defined by its slope angle, height, and (optional) base location
    tfloat angle, tfloat height, tvec3 base__0);
LIBFIVE_ALIAS(cone_ang, cone_ang_z)
LIBFIVE_STDLIB cone_z(
    // A cone defined by its radius, height, and (optional) base location
    tfloat radius, tfloat height, tvec3 base__0);
LIBFIVE_ALIAS(cone, cone_z)
LIBFIVE_STDLIB pyramid_z(
    // A pyramid defined by its base rectangle, lower Z value, and height
    tvec2 a, tvec2 b, tfloat zmin, tfloat height);
LIBFIVE_STDLIB torus_z(
    // A torus with the given outer radius, inner radius, and (optional) center
    tfloat ro, tfloat ri, tvec3 center__0);
LIBFIVE_ALIAS(torus, torus_z)
LIBFIVE_STDLIB gyroid(
    // A volume-filling gyroid with the given periods and thickness
    tvec3 period, tfloat thickness);
LIBFIVE_STDLIB emptiness(
    // A value which is empty everywhere
    );

LIBFIVE_STDLIB array_x(
    // Iterates a part in a 1D array
    libfive_tree shape, int nx, tfloat dx);
LIBFIVE_STDLIB array_xy(
    // Iterates a part in a 2D array
    libfive_tree shape, int nx, int ny, tvec2 delta);
LIBFIVE_STDLIB array_xyz(
    // Iterates a part in a 3D array
    libfive_tree shape, int nx, int ny, int nz, tvec3 delta);
LIBFIVE_STDLIB array_polar_z(
    // Iterates a shape about an optional center position
    libfive_tree shape, int n, tvec2 center__0);
LIBFIVE_ALIAS(array_polar, array_polar_z)
LIBFIVE_STDLIB extrude_z(
    // Extrudes a 2D shape between zmin and zmax
    libfive_tree t, tfloat zmin, tfloat zmax);

////////////////////////////////////////////////////////////////////////////////
LIBFIVE_SECTION(transforms)

LIBFIVE_STDLIB move(
    // Moves the given shape in 2D or 3D space
    libfive_tree t, tvec3 offset);
LIBFIVE_STDLIB reflect_x(
    // Reflects a shape about the x origin or an optional offset
    libfive_tree t, tfloat x0__0);
LIBFIVE_STDLIB reflect_y(
    // Reflects a shape about the y origin or an optional offset
    libfive_tree t, tfloat y0__0);
LIBFIVE_STDLIB reflect_z(
    // Reflects a shape about the z origin or an optional offset
    libfive_tree t, tfloat z0__0);
LIBFIVE_STDLIB reflect_xy(
    // Reflects a shape about the plane X=Y
    libfive_tree t);
LIBFIVE_STDLIB reflect_yz(
    // Reflects a shape about the plane Y=Z
    libfive_tree t);
LIBFIVE_STDLIB reflect_xz(
    // Reflects a shape about the plane X=Z
    libfive_tree t);
LIBFIVE_STDLIB symmetric_x(
    // Clips the given shape at the x origin, then duplicates the remaining
    // shape reflected on the other side of the origin
    libfive_tree t);
LIBFIVE_STDLIB symmetric_y(
    // Clips the given shape at the y origin, then duplicates the remaining
    // shape reflected on the other side of the origin
    libfive_tree t);
LIBFIVE_STDLIB symmetric_z(
    // Clips the given shape at the z origin, then duplicates the remaining
    // shape reflected on the other side of the origin
    libfive_tree t);
LIBFIVE_STDLIB scale_x(
    // Scales a shape by sx on the x axis about 0 or an optional offset
    libfive_tree t, tfloat sx, tfloat x0__0);
LIBFIVE_STDLIB scale_y(
    // Scales a shape by sx on the x axis about 0 or an optional offset
    libfive_tree t, tfloat sy, tfloat y0__0);
LIBFIVE_STDLIB scale_z(
    // Scales a shape by sx on the x axis about 0 or an optional offset
    libfive_tree t, tfloat sz, tfloat z0__0);
LIBFIVE_STDLIB scale_xyz(
    // Scales a shape on all three axes, about 0 or an optional offset
    libfive_tree t, tvec3 s, tvec3 center__0);
LIBFIVE_STDLIB rotate_x(
    // Rotate the given shape by an angle in radians
    // The center of rotation is [0 0 0] or specified by the optional argument
    libfive_tree t, tfloat angle, tvec3 center__0);
LIBFIVE_STDLIB rotate_y(
    // Rotate the given shape by an angle in radians
    // The center of rotation is [0 0 0] or specified by the optional argument
    libfive_tree t, tfloat angle, tvec3 center__0);
LIBFIVE_STDLIB rotate_z(
    // Rotate the given shape by an angle in radians
    // The center of rotation is [0 0 0] or specified by the optional argument
    libfive_tree t, tfloat angle, tvec3 center__0);
LIBFIVE_ALIAS(rotate, rotate_z)
LIBFIVE_STDLIB taper_x_y(
    // Tapers a shape along the x axis as a function of y
    // width = base-scale at base
    // width = scale at base + [0 h]
    libfive_tree shape, tvec2 base, tfloat h,
    tfloat scale, tfloat base_scale__1);
LIBFIVE_STDLIB taper_xy_z(
    // Tapers a shape in the xy plane as a function of z
    // width = base-scale at base
    // width = scale at base + [0 0 height]
    libfive_tree shape, tvec3 base, tfloat height,
    tfloat scale, tfloat base_scale__1);
LIBFIVE_STDLIB shear_x_y(
    // Shears a shape on the x axis as a function of y
    // offset = base-offset at base.y
    // offset = offset = base.y + h
    libfive_tree t, tvec2 base, tfloat height, tfloat offset,
    tfloat base_offset__0);
LIBFIVE_STDLIB repel(
    // Repels the shape away from a point based upon a radius r,
    // with optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB repel_x(
    // Repels the shape away from a YZ plane based upon a radius r,
    // with optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB repel_y(
    // Repels the shape away from a XZ plane based upon a radius r,
    // with optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB repel_z(
    // Repels the shape away from a XY plane based upon a radius r,
    // with optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB repel_xy(
    // Repels the shape away from line parallel to the Z axis,
    // with a particular radius and optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB repel_yz(
    // Repels the shape away from line parallel to the X axis,
    // with a particular radius and optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB repel_xz(
    // Repels the shape away from line parallel to the Y axis,
    // with a particular radius and optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB attract(
    // Attracts the shape away from a point based upon a radius r,
    // with optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB attract_x(
    // Attracts the shape away from a YZ plane based upon a radius r,
    // with optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB attract_y(
    // Attracts the shape away from a XZ plane based upon a radius r,
    // with optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB attract_z(
    // Attracts the shape away from a XY plane based upon a radius r,
    // with optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB attract_xy(
    // Attracts the shape away from line parallel to the Z axis,
    // with a particular radius and optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB attract_yz(
    // Attracts the shape away from line parallel to the X axis,
    // with a particular radius and optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB attract_xz(
    // Attracts the shape away from line parallel to the Y axis,
    // with a particular radius and optional exaggeration
    libfive_tree shape, tvec3 locus,
    tfloat radius, tfloat exaggerate__1);
LIBFIVE_STDLIB revolve_y(
    // Revolves a 2D (XY) shape about a line parallel to the Y axis with the
    // given x value
    libfive_tree shape, tfloat x0__0);
LIBFIVE_STDLIB twirl_x(
    // Twirls the shape in the x axis about the (optional) center point
    libfive_tree shape, tfloat amount, tfloat radius,
    tvec3 center__0);
LIBFIVE_STDLIB twirl_axis_x(
    // Twirls the shape in the x axis about the line extending from the
    // (optional) center point
    libfive_tree shape, tfloat amount, tfloat radius,
    tvec3 center__0);
LIBFIVE_STDLIB twirl_y(
    // Twirls the shape in the y axis about the (optional) center point
    libfive_tree shape, tfloat amount, tfloat radius,
    tvec3 center__0);
LIBFIVE_STDLIB twirl_axis_y(
    // Twirls the shape in the y axis about the line extending from the
    // (optional) center point
    libfive_tree shape, tfloat amount, tfloat radius,
    tvec3 center__0);
LIBFIVE_STDLIB twirl_z(
    // Twirls the shape in the z axis about the (optional) center point
    libfive_tree shape, tfloat amount, tfloat radius,
    tvec3 center__0);
LIBFIVE_STDLIB twirl_axis_z(
    // Twirls the shape in the z axis about the line extending from the
    // (optional) center point
    libfive_tree shape, tfloat amount, tfloat radius,
    tvec3 center__0);

////////////////////////////////////////////////////////////////////////////////
LIBFIVE_SECTION(text)

LIBFIVE_STDLIB text(
    // Returns the given text, rendered in a custom f-rep font
    // (with a character height of 1)
    const char* txt, tvec2 pos__0);

#ifdef __cplusplus
}
#endif
