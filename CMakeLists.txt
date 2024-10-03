cmake_minimum_required(VERSION 3.26)
project(neuron VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

find_package(Vulkan REQUIRED)

add_subdirectory(libs/spdlog)
add_subdirectory(libs/glm)

add_library(neuron src/neuron/neuron.cpp src/neuron/neuron.hpp)
target_include_directories(neuron PUBLIC src/)
target_include_directories(neuron PRIVATE libs/stb/)
target_link_libraries(neuron PUBLIC Vulkan::Vulkan spdog::spdlog glm::glm)

if (UNIX)
    target_link_libraries(neuron PUBLIC X11 Xcursor Xext Xi Xinerama Xrandr Xss)
elseif(WIN32)
    target_link_libraries(neuron PUBLIC Dwmapi.lib)
endif()

add_subdirectory(example)
