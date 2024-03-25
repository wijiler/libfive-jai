//
// This file was auto-generated using the following command:
//
// jai gen.jai
//



LIBFIVE_STDLIB :: libfive_tree;

/*
*  libfive_interval is a range used in interval arithmetic
*  It usually represents either a spatial region (along a single axis)
*  or a range that is guaranteed to contain a value.
*/
libfive_interval :: struct {
    lower: float;
    upper: float;
}

/*
*  libfive_region2:  A 2D region
*/
libfive_region2 :: struct {
    X: libfive_interval;
    Y: libfive_interval;
}

/*
*  libfive_region3:  A 3D region
*/
libfive_region3 :: struct {
    X: libfive_interval;
    Y: libfive_interval;
    Z: libfive_interval;
}

/*
*  libfive_vec2:  A 2D point or vector
*/
libfive_vec2 :: struct {
    x: float;
    y: float;
}

/*
*  libfive_vec3:  A 3D point or vector
*/
libfive_vec3 :: struct {
    x: float;
    y: float;
    z: float;
}

/*
*  libfive_vec4:  A 4D point or vector
*/
libfive_vec4 :: struct {
    x: float;
    y: float;
    z: float;
    w: float;
}

/*
*  libfive_tri:    A triangle, with corners stored as indices
*  into a separate vertex array
*/
libfive_tri :: struct {
    a: u32;
    b: u32;
    c: u32;
}

/*
*  libfive_contour is a single 2D contour, consisting of a sequence of
*  2D points plus a count of how many points are stored
*/
libfive_contour :: struct {
    pts:   *libfive_vec2;
    count: u32;
}

/*
*  libfive_contour is a set of 2D contours, consisting of multiple
*  libfive_contour objects and a count of how many are stored
*/
libfive_contours :: struct {
    cs:    *libfive_contour;
    count: u32;
}

/*
*  libfive_contour3 is a single 2D contour, consisting of a sequence of
*  3D points plus a count of how many points are stored
*/
libfive_contour3 :: struct {
    pts:   *libfive_vec3;
    count: u32;
}

/*
*  libfive_contours3 is a set of 2D contours, consisting of multiple
*  libfive_contour3 objects and a count of how many are stored
*/
libfive_contours3 :: struct {
    cs:    *libfive_contour3;
    count: u32;
}

/*
*  libfive_mesh is an indexed 3D mesh.
*  There are vert_count vertices, and tri_count triangles.
*/
libfive_mesh :: struct {
    verts:      *libfive_vec3;
    tris:       *libfive_tri;
    tri_count:  u32;
    vert_count: u32;
}

/*
*  libfive_mesh_coords is an indexed 3D mesh, similar to
*  libfive_mesh, with sets of vertex indices separated by -1 instead
*  of using triangle structs. There are vert_count vertices, and
*  coord_index_count coordinate indices (including the -1s), for
*  coord_index_count / 4 total triangles.
*/
libfive_mesh_coords :: struct {
    verts:             *libfive_vec3;
    vert_count:        u32;
    coord_indices:     *s32;
    coord_index_count: u32;
}

/*
*  libfive_pixels is a bitmap representing occupancy
*  There are width * height pixels, in row-major order
*/
libfive_pixels :: struct {
    pixels: *bool;
    width:  u32;
    height: u32;
}

/*
*  Frees an libfive_contours data structure
*/
libfive_contours_delete :: (cs: *libfive_contours) -> void #foreign libfive;

/*
*  Frees an libfive_contours data structure
*/
libfive_contours3_delete :: (cs: *libfive_contours3) -> void #foreign libfive;

/*
*  Frees an libfive_mesh data structure
*/
libfive_mesh_delete :: (m: *libfive_mesh) -> void #foreign libfive;

/*
*  Frees an libfive_mesh_coords data structure
*/
libfive_mesh_coords_delete :: (m: *libfive_mesh_coords) -> void #foreign libfive;

/*
*  Frees an libfive_pixels data structure
*/
libfive_pixels_delete :: (ps: *libfive_pixels) -> void #foreign libfive;

/*
*  Takes a string description of an op-code ('min', 'max', etc) and
*  returns the libfive::Opcode value, or -1 if no such value exists.
*/
libfive_opcode_enum :: (op: *u8) -> s32 #foreign libfive;

/*
*  Returns the number of arguments for the given opcode
*  (either 0, 1, 2, or -1 if the opcode is invalid)
*/
libfive_opcode_args :: (op: s32) -> s32 #foreign libfive;

/*  libfive_vars is a general-purpose struct for mapping a set of
*  free variables to their values.  The variables are opaque
*  pointers, i.e. values returned with libfive_tree_id. */
libfive_vars :: struct {
    vars:   **void;
    values: *float;
    size:   u32;
}

libfive_vars_delete :: (j: *libfive_vars) -> void #foreign libfive;

libfive_tree_ :: struct {}
libfive_tree :: *libfive_tree_;

libfive_evaluator_ :: struct {}
libfive_evaluator :: *libfive_evaluator_;

/*
*  Constructs a new tree that returns the X coordinate
*/
libfive_tree_x :: (__args: ..Any) -> libfive_tree #foreign libfive;

/*
*  Constructs a new tree that returns the Y coordinate
*/
libfive_tree_y :: (__args: ..Any) -> libfive_tree #foreign libfive;

/*
*  Constructs a new tree that returns the Z coordinate
*/
libfive_tree_z :: (__args: ..Any) -> libfive_tree #foreign libfive;

/*
*  Constructs a new tree that contains a free variable
*/
libfive_tree_var :: (__args: ..Any) -> libfive_tree #foreign libfive;

/*
*  Returns true if the given tree is a free variable
*/
libfive_tree_is_var :: (t: libfive_tree) -> bool #foreign libfive;

/*
*  Constructs a new tree that contains the given constant value
*/
libfive_tree_const :: (f: float) -> libfive_tree #foreign libfive;

/*
*  If t is a constant value, returns that value and sets *success to true.
*  Otherwise, sets success to false and returns 0.
*/
libfive_tree_get_const :: (t: libfive_tree, success: *bool) -> float #foreign libfive;

/*
*  Constructs a tree with the given no-argument opcode
*  Returns NULL if the opcode is invalid.
*/
libfive_tree_nullary :: (op: s32) -> libfive_tree #foreign libfive;

/*
*  Constructs a tree with the given one-argument opcode
*  Returns NULL if the opcode or argument is invalid
*/
libfive_tree_unary :: (op: s32, a: libfive_tree) -> libfive_tree #foreign libfive;

/*
*  Constructs a tree with the given two-argument opcode
*  Returns NULL if the opcode or arguments are invalid
*/
libfive_tree_binary :: (op: s32, a: libfive_tree, b: libfive_tree) -> libfive_tree #foreign libfive;

/*
*  Returns a unique ID for the given tree.  There is no global deduplication;
*  e.g. multiple calls to libfive_tree_const(1.0) will return trees with
*  different IDs.
*
*  This is primarily used to uniquely identify free variables, i.e. trees
*  returned from libfive_tree_var().
*/
libfive_tree_id :: (t: libfive_tree) -> *void #foreign libfive;

/*
*  Evaluates the given math tree at the given position.
*  TODO:  Free variables are treated as zero
*/
libfive_tree_eval_f :: (t: libfive_tree, p: libfive_vec3) -> float #foreign libfive;

/*
*  Evaluates the given math tree over a spatial region, returning an interval
*  that is guaranteed to contain the result
*  TODO:  Free variables are treated as zero
*/
libfive_tree_eval_r :: (t: libfive_tree, r: libfive_region3) -> libfive_interval #foreign libfive;

/*
*  Evaluates the partial derivatives of a math tree at a specific point,
*  with respect to x, y, z.
*/
libfive_tree_eval_d :: (t: libfive_tree, p: libfive_vec3) -> libfive_vec3 #foreign libfive;

/*
*  Deletes a tree.  If binding in a higher-level language, call this in
*  a destructor / finalizer to avoid leaking memory
*/
libfive_tree_delete :: (ptr: libfive_tree) -> void #foreign libfive;

/*  Serializes the given tree to a file, return true on success.
*  The file format is not archival, and may change without notice */
libfive_tree_save :: (ptr: libfive_tree, filename: *u8) -> bool #foreign libfive;

/*  Deserializes a tree from a file. */
libfive_tree_load :: (filename: *u8) -> libfive_tree #foreign libfive;

/*  Executes the remapping operation returning a tree
*  q(x, y, z) = p(x'(x, y, z), y'(x, y, z), z'(x, y, z)) */
libfive_tree_remap :: (p: libfive_tree, x: libfive_tree, y: libfive_tree, z: libfive_tree) -> libfive_tree #foreign libfive;

/*
*  Returns an optimized version of the given tree
*/
libfive_tree_optimized :: (t: libfive_tree) -> libfive_tree #foreign libfive;

/*
*  Returns a C string representing the tree in Scheme style
*  (e.g. "(+ 1 2 x y)" )
*
*  The caller is responsible for freeing the string with libfive_free()
*/
libfive_tree_print :: (t: libfive_tree) -> *u8 #foreign libfive;

/*
*  Frees a string allocated by libfive (probably by libfive_tree_print
*/
libfive_free_str :: (ptr: *u8) -> void #foreign libfive;

/*
*  Renders a tree to a set of contours
*
*  R is a region that will be subdivided into an octree.  For clean
*  triangles, it should be near-cubical, but that isn't a hard requirement
*
*  res should be approximately half the model's smallest feature size;
*  subdivision halts when all sides of the region are below it.
*
*  The returned struct must be freed with libfive_contours_delete
*/
libfive_tree_render_slice :: (tree: libfive_tree, R: libfive_region2, z: float, res: float) -> *libfive_contours #foreign libfive;

/*
*  Renders a tree to a set of contours, similar to libfive_tree_render_slice,
*  except the contours are 3D points (see the libfive_contour3 struct) above.
*/
libfive_tree_render_slice3 :: (tree: libfive_tree, R: libfive_region2, z: float, res: float) -> *libfive_contours3 #foreign libfive;

/*
*  Renders and saves a slice to a file
*
*  See argument details in libfive_tree_render_slice
*/
libfive_tree_save_slice :: (tree: libfive_tree, R: libfive_region2, z: float, res: float, f: *u8) -> void #foreign libfive;

/*
*  Renders a tree to a set of triangles
*
*  R is a region that will be subdivided into an octree.  For clean
*  triangles, it should be near-cubical, but that isn't a hard requirement
*
*  res should be approximately half the model's smallest feature size;
*  subdivision halts when all sides of the region are below it.
*
*  The returned struct must be freed with libfive_mesh_delete
*/
libfive_tree_render_mesh :: (tree: libfive_tree, R: libfive_region3, res: float) -> *libfive_mesh #foreign libfive;

/*
* Same as libfive_tree_render_mesh, but forces single-threaded meshing to
* play nicely with FFI.
*/
libfive_tree_render_mesh_st :: (tree: libfive_tree, R: libfive_region3, res: float) -> *libfive_mesh #foreign libfive;

/*
*  Renders to an alternate mesh format, see description of
*  libfive_mesh_coords above.  The returned struct must be freed with
*  libfive_mesh_coords_delete.
*/
libfive_tree_render_mesh_coords :: (tree: libfive_tree, R: libfive_region3, res: float) -> *libfive_mesh_coords #foreign libfive;

/*
*  Renders and saves a mesh to a file
*
*  Returns true on success, false otherwise
*  See argument details in libfive_tree_render_mesh
*/
libfive_tree_save_mesh :: (tree: libfive_tree, R: libfive_region3, res: float, f: *u8) -> bool #foreign libfive;

/*
*  Renders and saves a mesh to a file
*
*  Returns true on success, false otherwise
*  Second argument is an evaluator
*  See other argument details in libfive_tree_render_mesh
*/
libfive_evaluator_save_mesh :: (evaluator: libfive_evaluator, R: libfive_region3, f: *u8) -> bool #foreign libfive;

/*
*  Renders and saves multiple meshes mesh to a file
*
*  Returns true on success, false otherwise
*
*  Arguments are equivalent to Studio's resolution and quality
*  settings.  In particular quality is a value q such that we
*  collapse cells when the QEF error is below 10**(-q)
*
*  trees is a null-terminated list (since libfive_tree is a pointer
*  under the hood).
*/
libfive_tree_save_meshes :: (trees: *libfive_tree, R: libfive_region3, res: float, quality: float, f: *u8) -> bool #foreign libfive;

/*
*  Renders a 2D slice of pixels at the given Z height
*
*  The returned struct must be freed with libfive_pixels_delete
*/
libfive_tree_render_pixels :: (tree: libfive_tree, R: libfive_region2, z: float, res: float) -> *libfive_pixels #foreign libfive;

/*
*  Constructs a new evaluator
*/
libfive_tree_evaluator :: (tree: libfive_tree, vars: libfive_vars) -> libfive_evaluator #foreign libfive;

/*
*  Updates the variables of the evaluator
*/
libfive_evaluator_update_vars :: (eval_tree: libfive_evaluator, vars: libfive_vars) -> bool #foreign libfive;

/*
*  Deletes (first) evaluator.  TODO: if settings.workers > 1
*/
libfive_evaluator_delete :: (ptr: libfive_evaluator) -> void #foreign libfive;

/*
*  Returns the human-readable tag associated with this build,
*  or the empty string if there is no such tag
*/
libfive_git_version :: () -> *u8 #foreign libfive;

/*
*  Returns the 7-character git hash associated with this build,
*  with a trailing '+' if there are local (uncommitted) modifications
*/
libfive_git_revision :: () -> *u8 #foreign libfive;

/*
*  Returns the name of the branch associated with this build
*/
libfive_git_branch :: () -> *u8 #foreign libfive;

// We accept trees for every argument, even those that would normally be
// floats, so that we can pass in free variables to parameterize shapes.
tvec2 :: struct {
    x: libfive_tree;
    y: libfive_tree;
}

tvec3 :: struct {
    x: libfive_tree;
    y: libfive_tree;
    z: libfive_tree;
}

tfloat :: libfive_tree;

////////////////////////////////////////////////////////////////////////////////
_union :: (a: libfive_tree, b: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

intersection :: (a: libfive_tree, b: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

inverse :: (a: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

difference :: (a: libfive_tree, b: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

offset :: (a: libfive_tree, o: tfloat) -> libfive_tree #foreign libfive_stdlib;

clearance :: (a: libfive_tree, b: libfive_tree, offset: tfloat) -> libfive_tree #foreign libfive_stdlib;

shell :: (a: libfive_tree, offset: tfloat) -> libfive_tree #foreign libfive_stdlib;

blend_expt :: (a: libfive_tree, b: libfive_tree, m: tfloat) -> libfive_tree #foreign libfive_stdlib;

blend_expt_unit :: (a: libfive_tree, b: libfive_tree, m: tfloat) -> libfive_tree #foreign libfive_stdlib;

blend_rough :: (a: libfive_tree, b: libfive_tree, m: tfloat) -> libfive_tree #foreign libfive_stdlib;

blend_difference :: (a: libfive_tree, b: libfive_tree, m: tfloat, o__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

morph :: (a: libfive_tree, b: libfive_tree, m: tfloat) -> libfive_tree #foreign libfive_stdlib;

loft :: (a: libfive_tree, b: libfive_tree, zmin: tfloat, zmax: tfloat) -> libfive_tree #foreign libfive_stdlib;

loft_between :: (a: libfive_tree, b: libfive_tree, lower: tvec3, upper: tvec3) -> libfive_tree #foreign libfive_stdlib;

////////////////////////////////////////////////////////////////////////////////
circle :: (r: tfloat, center__0: tvec2) -> libfive_tree #foreign libfive_stdlib;

ring :: (ro: tfloat, ri: tfloat, center__0: tvec2) -> libfive_tree #foreign libfive_stdlib;

polygon :: (r: tfloat, n: s32, center__0: tvec2) -> libfive_tree #foreign libfive_stdlib;

rectangle :: (a: tvec2, b: tvec2) -> libfive_tree #foreign libfive_stdlib;

rounded_rectangle :: (a: tvec2, b: tvec2, r: tfloat) -> libfive_tree #foreign libfive_stdlib;

rectangle_exact :: (a: tvec2, b: tvec2) -> libfive_tree #foreign libfive_stdlib;

rectangle_centered_exact :: (size: tvec2, center__0: tvec2) -> libfive_tree #foreign libfive_stdlib;

triangle :: (a: tvec2, b: tvec2, c: tvec2) -> libfive_tree #foreign libfive_stdlib;

box_mitered :: (a: tvec3, b: tvec3) -> libfive_tree #foreign libfive_stdlib;

box_mitered_centered :: (size: tvec3, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

box_exact_centered :: (size: tvec3, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

box_exact :: (a: tvec3, b: tvec3) -> libfive_tree #foreign libfive_stdlib;

rounded_box :: (a: tvec3, b: tvec3, r: tfloat) -> libfive_tree #foreign libfive_stdlib;

sphere :: (radius: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

half_space :: (norm: tvec3, point__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

cylinder_z :: (r: tfloat, h: tfloat, base__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

cone_ang_z :: (angle: tfloat, height: tfloat, base__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

cone_z :: (radius: tfloat, height: tfloat, base__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

pyramid_z :: (a: tvec2, b: tvec2, zmin: tfloat, height: tfloat) -> libfive_tree #foreign libfive_stdlib;

torus_z :: (ro: tfloat, ri: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

gyroid :: (period: tvec3, thickness: tfloat) -> libfive_tree #foreign libfive_stdlib;

emptiness :: (__args: ..Any) -> libfive_tree #foreign libfive_stdlib;

array_x :: (shape: libfive_tree, nx: s32, dx: tfloat) -> libfive_tree #foreign libfive_stdlib;

array_xy :: (shape: libfive_tree, nx: s32, ny: s32, delta: tvec2) -> libfive_tree #foreign libfive_stdlib;

array_xyz :: (shape: libfive_tree, nx: s32, ny: s32, nz: s32, delta: tvec3) -> libfive_tree #foreign libfive_stdlib;

array_polar_z :: (shape: libfive_tree, n: s32, center__0: tvec2) -> libfive_tree #foreign libfive_stdlib;

extrude_z :: (t: libfive_tree, zmin: tfloat, zmax: tfloat) -> libfive_tree #foreign libfive_stdlib;

////////////////////////////////////////////////////////////////////////////////
move :: (t: libfive_tree, offset: tvec3) -> libfive_tree #foreign libfive_stdlib;

reflect_x :: (t: libfive_tree, x0__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

reflect_y :: (t: libfive_tree, y0__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

reflect_z :: (t: libfive_tree, z0__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

reflect_xy :: (t: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

reflect_yz :: (t: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

reflect_xz :: (t: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

symmetric_x :: (t: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

symmetric_y :: (t: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

symmetric_z :: (t: libfive_tree) -> libfive_tree #foreign libfive_stdlib;

scale_x :: (t: libfive_tree, sx: tfloat, x0__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

scale_y :: (t: libfive_tree, sy: tfloat, y0__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

scale_z :: (t: libfive_tree, sz: tfloat, z0__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

scale_xyz :: (t: libfive_tree, s: tvec3, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

rotate_x :: (t: libfive_tree, angle: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

rotate_y :: (t: libfive_tree, angle: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

rotate_z :: (t: libfive_tree, angle: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

taper_x_y :: (shape: libfive_tree, base: tvec2, h: tfloat, scale: tfloat, base_scale__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

taper_xy_z :: (shape: libfive_tree, base: tvec3, height: tfloat, scale: tfloat, base_scale__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

shear_x_y :: (t: libfive_tree, base: tvec2, height: tfloat, offset: tfloat, base_offset__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

repel :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

repel_x :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

repel_y :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

repel_z :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

repel_xy :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

repel_yz :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

repel_xz :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

attract :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

attract_x :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

attract_y :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

attract_z :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

attract_xy :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

attract_yz :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

attract_xz :: (shape: libfive_tree, locus: tvec3, radius: tfloat, exaggerate__1: tfloat) -> libfive_tree #foreign libfive_stdlib;

revolve_y :: (shape: libfive_tree, x0__0: tfloat) -> libfive_tree #foreign libfive_stdlib;

twirl_x :: (shape: libfive_tree, amount: tfloat, radius: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

twirl_axis_x :: (shape: libfive_tree, amount: tfloat, radius: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

twirl_y :: (shape: libfive_tree, amount: tfloat, radius: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

twirl_axis_y :: (shape: libfive_tree, amount: tfloat, radius: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

twirl_z :: (shape: libfive_tree, amount: tfloat, radius: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

twirl_axis_z :: (shape: libfive_tree, amount: tfloat, radius: tfloat, center__0: tvec3) -> libfive_tree #foreign libfive_stdlib;

////////////////////////////////////////////////////////////////////////////////
text :: (txt: *u8, pos__0: tvec2) -> libfive_tree #foreign libfive_stdlib;

#scope_file

#import "Basic"; // For assert

libfive :: #library,no_dll "./libfive";
libfive_stdlib :: #library,no_dll "./libfive-stdlib";

#run {
    {
        instance: libfive_interval;
        assert(((cast(*void)(*instance.lower)) - cast(*void)(*instance)) == 0, "libfive_interval.lower has unexpected offset % instead of 0", ((cast(*void)(*instance.lower)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_interval.lower)) == 4, "libfive_interval.lower has unexpected size % instead of 4", size_of(type_of(libfive_interval.lower)));
        assert(((cast(*void)(*instance.upper)) - cast(*void)(*instance)) == 4, "libfive_interval.upper has unexpected offset % instead of 4", ((cast(*void)(*instance.upper)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_interval.upper)) == 4, "libfive_interval.upper has unexpected size % instead of 4", size_of(type_of(libfive_interval.upper)));
        assert(size_of(libfive_interval) == 8, "libfive_interval has size % instead of 8", size_of(libfive_interval));
    }

    {
        instance: libfive_region2;
        assert(((cast(*void)(*instance.X)) - cast(*void)(*instance)) == 0, "libfive_region2.X has unexpected offset % instead of 0", ((cast(*void)(*instance.X)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_region2.X)) == 8, "libfive_region2.X has unexpected size % instead of 8", size_of(type_of(libfive_region2.X)));
        assert(((cast(*void)(*instance.Y)) - cast(*void)(*instance)) == 8, "libfive_region2.Y has unexpected offset % instead of 8", ((cast(*void)(*instance.Y)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_region2.Y)) == 8, "libfive_region2.Y has unexpected size % instead of 8", size_of(type_of(libfive_region2.Y)));
        assert(size_of(libfive_region2) == 16, "libfive_region2 has size % instead of 16", size_of(libfive_region2));
    }

    {
        instance: libfive_region3;
        assert(((cast(*void)(*instance.X)) - cast(*void)(*instance)) == 0, "libfive_region3.X has unexpected offset % instead of 0", ((cast(*void)(*instance.X)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_region3.X)) == 8, "libfive_region3.X has unexpected size % instead of 8", size_of(type_of(libfive_region3.X)));
        assert(((cast(*void)(*instance.Y)) - cast(*void)(*instance)) == 8, "libfive_region3.Y has unexpected offset % instead of 8", ((cast(*void)(*instance.Y)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_region3.Y)) == 8, "libfive_region3.Y has unexpected size % instead of 8", size_of(type_of(libfive_region3.Y)));
        assert(((cast(*void)(*instance.Z)) - cast(*void)(*instance)) == 16, "libfive_region3.Z has unexpected offset % instead of 16", ((cast(*void)(*instance.Z)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_region3.Z)) == 8, "libfive_region3.Z has unexpected size % instead of 8", size_of(type_of(libfive_region3.Z)));
        assert(size_of(libfive_region3) == 24, "libfive_region3 has size % instead of 24", size_of(libfive_region3));
    }

    {
        instance: libfive_vec2;
        assert(((cast(*void)(*instance.x)) - cast(*void)(*instance)) == 0, "libfive_vec2.x has unexpected offset % instead of 0", ((cast(*void)(*instance.x)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec2.x)) == 4, "libfive_vec2.x has unexpected size % instead of 4", size_of(type_of(libfive_vec2.x)));
        assert(((cast(*void)(*instance.y)) - cast(*void)(*instance)) == 4, "libfive_vec2.y has unexpected offset % instead of 4", ((cast(*void)(*instance.y)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec2.y)) == 4, "libfive_vec2.y has unexpected size % instead of 4", size_of(type_of(libfive_vec2.y)));
        assert(size_of(libfive_vec2) == 8, "libfive_vec2 has size % instead of 8", size_of(libfive_vec2));
    }

    {
        instance: libfive_vec3;
        assert(((cast(*void)(*instance.x)) - cast(*void)(*instance)) == 0, "libfive_vec3.x has unexpected offset % instead of 0", ((cast(*void)(*instance.x)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec3.x)) == 4, "libfive_vec3.x has unexpected size % instead of 4", size_of(type_of(libfive_vec3.x)));
        assert(((cast(*void)(*instance.y)) - cast(*void)(*instance)) == 4, "libfive_vec3.y has unexpected offset % instead of 4", ((cast(*void)(*instance.y)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec3.y)) == 4, "libfive_vec3.y has unexpected size % instead of 4", size_of(type_of(libfive_vec3.y)));
        assert(((cast(*void)(*instance.z)) - cast(*void)(*instance)) == 8, "libfive_vec3.z has unexpected offset % instead of 8", ((cast(*void)(*instance.z)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec3.z)) == 4, "libfive_vec3.z has unexpected size % instead of 4", size_of(type_of(libfive_vec3.z)));
        assert(size_of(libfive_vec3) == 12, "libfive_vec3 has size % instead of 12", size_of(libfive_vec3));
    }

    {
        instance: libfive_vec4;
        assert(((cast(*void)(*instance.x)) - cast(*void)(*instance)) == 0, "libfive_vec4.x has unexpected offset % instead of 0", ((cast(*void)(*instance.x)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec4.x)) == 4, "libfive_vec4.x has unexpected size % instead of 4", size_of(type_of(libfive_vec4.x)));
        assert(((cast(*void)(*instance.y)) - cast(*void)(*instance)) == 4, "libfive_vec4.y has unexpected offset % instead of 4", ((cast(*void)(*instance.y)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec4.y)) == 4, "libfive_vec4.y has unexpected size % instead of 4", size_of(type_of(libfive_vec4.y)));
        assert(((cast(*void)(*instance.z)) - cast(*void)(*instance)) == 8, "libfive_vec4.z has unexpected offset % instead of 8", ((cast(*void)(*instance.z)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec4.z)) == 4, "libfive_vec4.z has unexpected size % instead of 4", size_of(type_of(libfive_vec4.z)));
        assert(((cast(*void)(*instance.w)) - cast(*void)(*instance)) == 12, "libfive_vec4.w has unexpected offset % instead of 12", ((cast(*void)(*instance.w)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vec4.w)) == 4, "libfive_vec4.w has unexpected size % instead of 4", size_of(type_of(libfive_vec4.w)));
        assert(size_of(libfive_vec4) == 16, "libfive_vec4 has size % instead of 16", size_of(libfive_vec4));
    }

    {
        instance: libfive_tri;
        assert(((cast(*void)(*instance.a)) - cast(*void)(*instance)) == 0, "libfive_tri.a has unexpected offset % instead of 0", ((cast(*void)(*instance.a)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_tri.a)) == 4, "libfive_tri.a has unexpected size % instead of 4", size_of(type_of(libfive_tri.a)));
        assert(((cast(*void)(*instance.b)) - cast(*void)(*instance)) == 4, "libfive_tri.b has unexpected offset % instead of 4", ((cast(*void)(*instance.b)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_tri.b)) == 4, "libfive_tri.b has unexpected size % instead of 4", size_of(type_of(libfive_tri.b)));
        assert(((cast(*void)(*instance.c)) - cast(*void)(*instance)) == 8, "libfive_tri.c has unexpected offset % instead of 8", ((cast(*void)(*instance.c)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_tri.c)) == 4, "libfive_tri.c has unexpected size % instead of 4", size_of(type_of(libfive_tri.c)));
        assert(size_of(libfive_tri) == 12, "libfive_tri has size % instead of 12", size_of(libfive_tri));
    }

    {
        instance: libfive_contour;
        assert(((cast(*void)(*instance.pts)) - cast(*void)(*instance)) == 0, "libfive_contour.pts has unexpected offset % instead of 0", ((cast(*void)(*instance.pts)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_contour.pts)) == 8, "libfive_contour.pts has unexpected size % instead of 8", size_of(type_of(libfive_contour.pts)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 8, "libfive_contour.count has unexpected offset % instead of 8", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_contour.count)) == 4, "libfive_contour.count has unexpected size % instead of 4", size_of(type_of(libfive_contour.count)));
        assert(size_of(libfive_contour) == 16, "libfive_contour has size % instead of 16", size_of(libfive_contour));
    }

    {
        instance: libfive_contours;
        assert(((cast(*void)(*instance.cs)) - cast(*void)(*instance)) == 0, "libfive_contours.cs has unexpected offset % instead of 0", ((cast(*void)(*instance.cs)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_contours.cs)) == 8, "libfive_contours.cs has unexpected size % instead of 8", size_of(type_of(libfive_contours.cs)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 8, "libfive_contours.count has unexpected offset % instead of 8", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_contours.count)) == 4, "libfive_contours.count has unexpected size % instead of 4", size_of(type_of(libfive_contours.count)));
        assert(size_of(libfive_contours) == 16, "libfive_contours has size % instead of 16", size_of(libfive_contours));
    }

    {
        instance: libfive_contour3;
        assert(((cast(*void)(*instance.pts)) - cast(*void)(*instance)) == 0, "libfive_contour3.pts has unexpected offset % instead of 0", ((cast(*void)(*instance.pts)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_contour3.pts)) == 8, "libfive_contour3.pts has unexpected size % instead of 8", size_of(type_of(libfive_contour3.pts)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 8, "libfive_contour3.count has unexpected offset % instead of 8", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_contour3.count)) == 4, "libfive_contour3.count has unexpected size % instead of 4", size_of(type_of(libfive_contour3.count)));
        assert(size_of(libfive_contour3) == 16, "libfive_contour3 has size % instead of 16", size_of(libfive_contour3));
    }

    {
        instance: libfive_contours3;
        assert(((cast(*void)(*instance.cs)) - cast(*void)(*instance)) == 0, "libfive_contours3.cs has unexpected offset % instead of 0", ((cast(*void)(*instance.cs)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_contours3.cs)) == 8, "libfive_contours3.cs has unexpected size % instead of 8", size_of(type_of(libfive_contours3.cs)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 8, "libfive_contours3.count has unexpected offset % instead of 8", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_contours3.count)) == 4, "libfive_contours3.count has unexpected size % instead of 4", size_of(type_of(libfive_contours3.count)));
        assert(size_of(libfive_contours3) == 16, "libfive_contours3 has size % instead of 16", size_of(libfive_contours3));
    }

    {
        instance: libfive_mesh;
        assert(((cast(*void)(*instance.verts)) - cast(*void)(*instance)) == 0, "libfive_mesh.verts has unexpected offset % instead of 0", ((cast(*void)(*instance.verts)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_mesh.verts)) == 8, "libfive_mesh.verts has unexpected size % instead of 8", size_of(type_of(libfive_mesh.verts)));
        assert(((cast(*void)(*instance.tris)) - cast(*void)(*instance)) == 8, "libfive_mesh.tris has unexpected offset % instead of 8", ((cast(*void)(*instance.tris)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_mesh.tris)) == 8, "libfive_mesh.tris has unexpected size % instead of 8", size_of(type_of(libfive_mesh.tris)));
        assert(((cast(*void)(*instance.tri_count)) - cast(*void)(*instance)) == 16, "libfive_mesh.tri_count has unexpected offset % instead of 16", ((cast(*void)(*instance.tri_count)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_mesh.tri_count)) == 4, "libfive_mesh.tri_count has unexpected size % instead of 4", size_of(type_of(libfive_mesh.tri_count)));
        assert(((cast(*void)(*instance.vert_count)) - cast(*void)(*instance)) == 20, "libfive_mesh.vert_count has unexpected offset % instead of 20", ((cast(*void)(*instance.vert_count)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_mesh.vert_count)) == 4, "libfive_mesh.vert_count has unexpected size % instead of 4", size_of(type_of(libfive_mesh.vert_count)));
        assert(size_of(libfive_mesh) == 24, "libfive_mesh has size % instead of 24", size_of(libfive_mesh));
    }

    {
        instance: libfive_mesh_coords;
        assert(((cast(*void)(*instance.verts)) - cast(*void)(*instance)) == 0, "libfive_mesh_coords.verts has unexpected offset % instead of 0", ((cast(*void)(*instance.verts)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_mesh_coords.verts)) == 8, "libfive_mesh_coords.verts has unexpected size % instead of 8", size_of(type_of(libfive_mesh_coords.verts)));
        assert(((cast(*void)(*instance.vert_count)) - cast(*void)(*instance)) == 8, "libfive_mesh_coords.vert_count has unexpected offset % instead of 8", ((cast(*void)(*instance.vert_count)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_mesh_coords.vert_count)) == 4, "libfive_mesh_coords.vert_count has unexpected size % instead of 4", size_of(type_of(libfive_mesh_coords.vert_count)));
        assert(((cast(*void)(*instance.coord_indices)) - cast(*void)(*instance)) == 16, "libfive_mesh_coords.coord_indices has unexpected offset % instead of 16", ((cast(*void)(*instance.coord_indices)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_mesh_coords.coord_indices)) == 8, "libfive_mesh_coords.coord_indices has unexpected size % instead of 8", size_of(type_of(libfive_mesh_coords.coord_indices)));
        assert(((cast(*void)(*instance.coord_index_count)) - cast(*void)(*instance)) == 24, "libfive_mesh_coords.coord_index_count has unexpected offset % instead of 24", ((cast(*void)(*instance.coord_index_count)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_mesh_coords.coord_index_count)) == 4, "libfive_mesh_coords.coord_index_count has unexpected size % instead of 4", size_of(type_of(libfive_mesh_coords.coord_index_count)));
        assert(size_of(libfive_mesh_coords) == 32, "libfive_mesh_coords has size % instead of 32", size_of(libfive_mesh_coords));
    }

    {
        instance: libfive_pixels;
        assert(((cast(*void)(*instance.pixels)) - cast(*void)(*instance)) == 0, "libfive_pixels.pixels has unexpected offset % instead of 0", ((cast(*void)(*instance.pixels)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_pixels.pixels)) == 8, "libfive_pixels.pixels has unexpected size % instead of 8", size_of(type_of(libfive_pixels.pixels)));
        assert(((cast(*void)(*instance.width)) - cast(*void)(*instance)) == 8, "libfive_pixels.width has unexpected offset % instead of 8", ((cast(*void)(*instance.width)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_pixels.width)) == 4, "libfive_pixels.width has unexpected size % instead of 4", size_of(type_of(libfive_pixels.width)));
        assert(((cast(*void)(*instance.height)) - cast(*void)(*instance)) == 12, "libfive_pixels.height has unexpected offset % instead of 12", ((cast(*void)(*instance.height)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_pixels.height)) == 4, "libfive_pixels.height has unexpected size % instead of 4", size_of(type_of(libfive_pixels.height)));
        assert(size_of(libfive_pixels) == 16, "libfive_pixels has size % instead of 16", size_of(libfive_pixels));
    }

    {
        instance: libfive_vars;
        assert(((cast(*void)(*instance.vars)) - cast(*void)(*instance)) == 0, "libfive_vars.vars has unexpected offset % instead of 0", ((cast(*void)(*instance.vars)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vars.vars)) == 8, "libfive_vars.vars has unexpected size % instead of 8", size_of(type_of(libfive_vars.vars)));
        assert(((cast(*void)(*instance.values)) - cast(*void)(*instance)) == 8, "libfive_vars.values has unexpected offset % instead of 8", ((cast(*void)(*instance.values)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vars.values)) == 8, "libfive_vars.values has unexpected size % instead of 8", size_of(type_of(libfive_vars.values)));
        assert(((cast(*void)(*instance.size)) - cast(*void)(*instance)) == 16, "libfive_vars.size has unexpected offset % instead of 16", ((cast(*void)(*instance.size)) - cast(*void)(*instance)));
        assert(size_of(type_of(libfive_vars.size)) == 4, "libfive_vars.size has unexpected size % instead of 4", size_of(type_of(libfive_vars.size)));
        assert(size_of(libfive_vars) == 24, "libfive_vars has size % instead of 24", size_of(libfive_vars));
    }

    {
        instance: tvec2;
        assert(((cast(*void)(*instance.x)) - cast(*void)(*instance)) == 0, "tvec2.x has unexpected offset % instead of 0", ((cast(*void)(*instance.x)) - cast(*void)(*instance)));
        assert(size_of(type_of(tvec2.x)) == 8, "tvec2.x has unexpected size % instead of 8", size_of(type_of(tvec2.x)));
        assert(((cast(*void)(*instance.y)) - cast(*void)(*instance)) == 8, "tvec2.y has unexpected offset % instead of 8", ((cast(*void)(*instance.y)) - cast(*void)(*instance)));
        assert(size_of(type_of(tvec2.y)) == 8, "tvec2.y has unexpected size % instead of 8", size_of(type_of(tvec2.y)));
        assert(size_of(tvec2) == 16, "tvec2 has size % instead of 16", size_of(tvec2));
    }

    {
        instance: tvec3;
        assert(((cast(*void)(*instance.x)) - cast(*void)(*instance)) == 0, "tvec3.x has unexpected offset % instead of 0", ((cast(*void)(*instance.x)) - cast(*void)(*instance)));
        assert(size_of(type_of(tvec3.x)) == 8, "tvec3.x has unexpected size % instead of 8", size_of(type_of(tvec3.x)));
        assert(((cast(*void)(*instance.y)) - cast(*void)(*instance)) == 8, "tvec3.y has unexpected offset % instead of 8", ((cast(*void)(*instance.y)) - cast(*void)(*instance)));
        assert(size_of(type_of(tvec3.y)) == 8, "tvec3.y has unexpected size % instead of 8", size_of(type_of(tvec3.y)));
        assert(((cast(*void)(*instance.z)) - cast(*void)(*instance)) == 16, "tvec3.z has unexpected offset % instead of 16", ((cast(*void)(*instance.z)) - cast(*void)(*instance)));
        assert(size_of(type_of(tvec3.z)) == 8, "tvec3.z has unexpected size % instead of 8", size_of(type_of(tvec3.z)));
        assert(size_of(tvec3) == 24, "tvec3 has size % instead of 24", size_of(tvec3));
    }
}

