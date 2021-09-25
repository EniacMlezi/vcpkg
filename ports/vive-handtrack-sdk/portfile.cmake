vcpkg_download_distfile(ARCHIVE
    URLS "https://dl.vive.com/SDK/vive/ViveHandTracking_1.0.0.zip"
    FILENAME "ViveHandTracking_1.0.0.zip"
    SHA512 d0433dc2dd09af5c38d42b6e4529b2ffe36a06f7e116e0b8a3db6e55943b6d09d683fca40943ea35c3c17aa2df77ff7a26be435362f4f5d746d06457d0f60923
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SDK_EXTRACTED
    ARCHIVE ${ARCHIVE}
	NO_REMOVE_ONE_LEVEL
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH CPP_EXTRACTED
    ARCHIVE "${SDK_EXTRACTED}/C++/Native Binary for C++.zip"
	NO_REMOVE_ONE_LEVEL
)

if(VCPKG_TARGET_IS_WINDOWS)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
        set(ARCH_PATH "Windows64")
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
        set(ARCH_PATH "Windows32")
    else()
        message(FATAL_ERROR "Package only supports x64 and x86 Windows.")
    endif()
else()
    message(FATAL_ERROR "Package only supports Windows and Linux.")
endif()

file(GLOB CPP_LIB "${CPP_EXTRACTED}/ViveHandTracking/libs/${ARCH_PATH}/*.lib")
file(COPY ${CPP_LIB} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${CPP_LIB} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(GLOB CPP_BIN "${CPP_EXTRACTED}/ViveHandTracking/libs/${ARCH_PATH}/*.dll")
file(COPY ${CPP_BIN} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(COPY ${CPP_BIN} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

file(INSTALL ${CPP_EXTRACTED}/ViveHandTracking/include DESTINATION ${CURRENT_PACKAGES_DIR} RENAME include)

# # Handle copyright
file(INSTALL "${SDK_EXTRACTED}/PLEASE READ DOCUMENTATION FIRST" DESTINATION ${CURRENT_PACKAGES_DIR}/share/vive-handtrack-sdk RENAME copyright)
