add_library(ifx_obj OBJECT)
add_library(IFX::ILLD ALIAS ifx_obj)

set_target_properties(ifx_obj PROPERTIES
	C_STANDARD		17
	C_STANDARD_REQUIRED	ON
	C_EXTENSIONS		ON
)

target_sources(ifx_obj PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}/Configurations/Ifx_Cfg_Ssw.c
	${CMAKE_CURRENT_SOURCE_DIR}/iLLD/TC3xx/Tricore/Pms/Std/IfxPmsEvr.c
	${CMAKE_CURRENT_SOURCE_DIR}/iLLD/TC3xx/Tricore/Scu/Std/IfxScuCcu.c
	${CMAKE_CURRENT_SOURCE_DIR}/iLLD/TC3xx/Tricore/Scu/Std/IfxScuWdt.c
	${CMAKE_CURRENT_SOURCE_DIR}/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c
	${CMAKE_CURRENT_SOURCE_DIR}/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Infra.c
)

target_include_directories(ifx_obj PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}/Configurations
	${CMAKE_CURRENT_SOURCE_DIR}/iLLD/TC3xx/Tricore
	${CMAKE_CURRENT_SOURCE_DIR}/iLLD/TC3xx/Tricore/_PinMap
	${CMAKE_CURRENT_SOURCE_DIR}/iLLD/TC3xx/Tricore/_PinMap/TC37x
	${CMAKE_CURRENT_SOURCE_DIR}/iLLD/TC3xx/Tricore/Pms/Std
	${CMAKE_CURRENT_SOURCE_DIR}/iLLD/TC3xx/Tricore/Scu/Std
	${CMAKE_CURRENT_SOURCE_DIR}/Infra/Platform
	${CMAKE_CURRENT_SOURCE_DIR}/Infra/Sfr/TC37x
	${CMAKE_CURRENT_SOURCE_DIR}/Infra/Ssw/TC3xx/Tricore
	${CMAKE_CURRENT_SOURCE_DIR}/Service/CpuGeneric
)

target_compile_options(ifx_obj PRIVATE
	-Wno-conversion
	-Wno-sign-conversion
	-Wno-unused-parameter
)
