add_library(ifx_obj OBJECT)
add_library(IFX::ILLD ALIAS ifx_obj)

set_target_properties(ifx_obj PROPERTIES
	C_STANDARD		17
	C_STANDARD_REQUIRED	ON
	C_EXTENSIONS		ON
)

target_sources(ifx_obj PRIVATE
	Configurations/Ifx_Cfg_Ssw.c
	iLLD/TC3xx/Tricore/Pms/Std/IfxPmsEvr.c
	iLLD/TC3xx/Tricore/Scu/Std/IfxScuCcu.c
	iLLD/TC3xx/Tricore/Scu/Std/IfxScuWdt.c
	Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c
	Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Infra.c
)

target_include_directories(ifx_obj PUBLIC
	Configurations
	iLLD/TC3xx/Tricore
	iLLD/TC3xx/Tricore/_PinMap
	iLLD/TC3xx/Tricore/_PinMap/TC37x
	iLLD/TC3xx/Tricore/Pms/Std
	iLLD/TC3xx/Tricore/Scu/Std
	Infra/Platform
	Infra/Sfr/TC37x
	Infra/Ssw/TC3xx/Tricore
	Service/CpuGeneric
)

target_compile_options(ifx_obj PRIVATE
	-Wno-conversion
	-Wno-sign-conversion
	-Wno-unused-parameter
)
