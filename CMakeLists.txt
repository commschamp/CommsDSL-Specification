cmake_minimum_required (VERSION 3.5)
project ("commsdsl_spec" NONE)

find_program (ASCIIDOCTOR_EXE asciidoctor)
if (NOT ASCIIDOCTOR_EXE)
    message(FATAL_ERROR "asciidoctor is not found")
endif ()

find_program (ASCIIDOCTOR_PDF_EXE asciidoctor-pdf)
if (NOT ASCIIDOCTOR_PDF_EXE)
    message(FATAL_ERROR "asciidoctor-pdf is not found")
endif ()

set (VERSION "v3.1.2")
set (MAIN_FILE "${PROJECT_SOURCE_DIR}/commsdsl_spec.adoc")

add_custom_target("pdf" ALL
    COMMAND ${ASCIIDOCTOR_PDF_EXE} ${MAIN_FILE}
    COMMAND ${CMAKE_COMMAND} -E rename "${PROJECT_SOURCE_DIR}/commsdsl_spec.pdf" "${CMAKE_CURRENT_BINARY_DIR}/commsdsl_spec_${VERSION}.pdf"
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

add_custom_target("site" ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR}/site
    COMMAND ${ASCIIDOCTOR_EXE} -D ${CMAKE_CURRENT_BINARY_DIR}/site -o index.html ${MAIN_FILE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

file(INSTALL images DESTINATION site)
file(INSTALL README.md DESTINATION site)
