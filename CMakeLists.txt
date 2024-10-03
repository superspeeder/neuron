cmake_minimum_required(VERSION 3.30)
project(neuron VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

include(FetchContent)

find_package(Vulkan REQUIRED)

message("Vulkan Found At: ${Vulkan_LIBRARY}")
message("Vulkan SDK Version: ${Vulkan_VERSION}")
message("Vulkan found glslc: ${Vulkan_glslc_FOUND} (${Vulkan_GLSLC_EXECUTABLE})") 
message("Vulkan found glslangValidator: ${Vulkan_glslangValidator_FOUND} (${Vulkan_GLSLANG_VALIDATOR_EXECUTABLE})")

if (Vulkan_shaderc_combined_FOUND)
    add_library(shaderc_imp ALIAS Vulkan::shaderc_combined)
else()
    find_library(SHADERC_COMBINED_LIB shaderc_combined)
    find_path(SHADERC_INCLUDE_DIR "shaderc/shaderc.hpp")
    message("ShaderC Library: ${SHADERC_COMBINED_LIB}")
    message("ShaderC Include: ${SHADERC_INCLUDE_DIR}")

    add_library(shaderc_imp UNKNOWN IMPORTED)
    set_target_properties(shaderc_imp PROPERTIES IMPORTED_LOCATION "${SHADERC_COMBINED_LIB}")
    target_include_directories(shaderc_imp INTERFACE "${SHADERC_INCLUDE_DIR}")
endif()

FetchContent_Declare(stb
    GIT_REPOSITORY    https://github.com/nothings/stb.git
    GIT_TAG           master
    CONFIGURE_COMMAND ""
    BUILD_COMMAND     ""
)

FetchContent_Declare(spdlog
    GIT_REPOSITORY    https://github.com/gabime/spdlog.git
    GIT_TAG           v1.x
)

FetchContent_Declare(glm
    GIT_REPOSITORY    https://github.com/g-truc/glm.git
    GIT_TAG           master
)

FetchContent_MakeAvailable(stb spdlog glm)

add_library(neuron src/neuron/neuron.cpp src/neuron/neuron.hpp)
target_include_directories(neuron PUBLIC src/)
target_include_directories(neuron PRIVATE ${stb_SOURCE_DIR}/)
target_link_libraries(neuron PUBLIC Vulkan::Vulkan spdlog::spdlog glm::glm shaderc_imp)


if (UNIX)
    target_link_libraries(neuron PUBLIC X11 Xcursor Xext Xi Xinerama Xrandr Xss)
elseif(WIN32)
    target_link_libraries(neuron PUBLIC Dwmapi.lib)
endif()

add_library(neuron::neuron ALIAS neuron)

add_subdirectory(example)
