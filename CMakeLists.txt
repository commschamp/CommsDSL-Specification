cmake_minimum_required (VERSION 3.5)
project ("commsdsl_spec" NONE)

find_program (A2X_EXECUTABLE a2x)
if (NOT A2X_EXECUTABLE)
    message(FATAL_ERROR "a2x is not found")
endif ()

set (VERSION "v3.1.2")
set (MAIN_FILE "${PROJECT_SOURCE_DIR}/commsdsl_spec.txt")

add_custom_target("pdf" ALL
    COMMAND ${A2X_EXECUTABLE} -v -f pdf --dblatex-opts "-P toc.section.depth=2"
        ${MAIN_FILE}
    COMMAND ${CMAKE_COMMAND} -E rename "${PROJECT_SOURCE_DIR}/commsdsl_spec.pdf" "${CMAKE_CURRENT_BINARY_DIR}/commsdsl_spec_${VERSION}.pdf"
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

add_custom_target("site" ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR}/site
    COMMAND ${A2X_EXECUTABLE} -v -f xhtml -D ${CMAKE_CURRENT_BINARY_DIR}/site ${MAIN_FILE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})


