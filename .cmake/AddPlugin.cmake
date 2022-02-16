macro(add_plugin plugin_dir plugin_name)
    message(STATUS "[add-plugin] adding '${plugin_name}' at path '${plugin_dir}")
    add_subdirectory(${plugin_dir})
    add_dependencies(musikcube ${plugin_name})
    add_dependencies(musikcubed ${plugin_name})
    add_dependencies(core_c_demo ${plugin_name})
endmacro(add_plugin)