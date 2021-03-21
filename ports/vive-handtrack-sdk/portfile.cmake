vcpkg_download_distfile(ARCHIVE
    URLS "https://dl.vive.com/SDK/HandTracking/ViveHandTracking_0.10.0.zip"
    FILENAME "ViveHandTracking_0.10.0.zip"
    SHA512 fc7a1e6ca1aa95c84238f112e239bcd4022377e21678a7ac5c58c767b814360eb9f483162251613186eb95fbc29646b526b94e0e496570051092c702bc71d125
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
