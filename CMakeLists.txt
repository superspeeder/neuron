cmake_minimum_required(VERSION 3.29)
project(neuron VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

find_package(Vulkan REQUIRED)

message("Vulkan SDK Version: ${Vulkan_VERSION}")
message("Vulkan found glslc: ${Vulkan_glslc_FOUND} (${Vulkan_GLSLC_EXECUTABLE})") 
message("Vulkan found glslang: ${Vulkan_glslang_FOUND} (${Vulkan_glslang_LIBRARY})") 
message("Vulkan found glslangValidator: ${Vulkan_glslangValidator_FOUND} (${Vulkan_GLSLANG_VALIDATOR_EXECUTABLE})")
message("Vulkan found SPIRV-Tools: ${Vulkan_SPIRV-Tools_FOUND} (${Vulkan_SPIRV-Tools_LIBRARY})") 
message("Vulkan found shaderc_combined: ${Vulkan_shaderc_combined_FOUND} (${Vulkan_shaderc_combined_LIBRARY})")
message("Vulkan found dxc_lib: ${Vulkan_dxc_lib_FOUND} (${Vulkan_dxc_LIBRARY})")
message("Vulkan found dxc_exe: ${Vulkan_dxc_exe_FOUND} (${Vulkan_dxc_EXECUTABLE})")
message("Vulkan found volk: ${Vulkan_volk_FOUND} (${Vulkan_volk_LIBRARY})")


add_library(neuron src/neuron/neuron.cpp src/neuron/neuron.hpp)
target_include_directories(neuron PUBLIC src/)
target_include_directories(neuron PRIVATE libs/stb/)
target_link_libraries(neuron PUBLIC Vulkan::Vulkan spdlog::spdlog glm::glm)


if (UNIX)
    target_link_libraries(neuron PUBLIC X11 Xcursor Xext Xi Xinerama Xrandr Xss)
elseif(WIN32)
    target_link_libraries(neuron PUBLIC Dwmapi.lib)
endif()

add_library(neuron::neuron ALIAS neuron)

add_subdirectory(example)
