#run gen();

gen :: () {
    set_build_options_dc(.{do_output=false});


    output_filename: string;
    opts: Generate_Bindings_Options;
    {
        using opts;

        #if OS == .WINDOWS {
            output_filename          = "windows.jai";
            strip_flags = 0;
        } else #if OS == .LINUX {
            output_filename          = "linux.jai";
            strip_flags = .INLINED_FUNCTIONS; // Inlined constructor doesn't exist in the library
        } else #if OS == .MACOS {
            output_filename          = "macos.jai";
            strip_flags = .INLINED_FUNCTIONS; // Inlined constructor doesn't exist in the library
        } else {
            assert(false);
        }

        array_add(*libpaths,       ".");
        array_add(*libnames,      "libfive");
        array_add(*libnames,      "libfive-stdlib");
        array_add(*source_files,  "libfive.h");
        array_add(*source_files,  "libfive_stdlib.h");

        array_add(*extra_clang_arguments, "-x", "c");

        // strip_flags &= ~(Strip_Flags.CONSTRUCTORS | .DESTRUCTORS);
    }

    generate_bindings(opts, output_filename);
}


#import "Bindings_Generator";
#import "Basic";
#import "Compiler";