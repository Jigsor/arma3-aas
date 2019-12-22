#define MAP_DESCRIPTION "aas_IL_015_020_Revolution by"

#define OVERVIEWTEXT $STR_AAS_HISTORY

#define AAS_SMALL_MISSION

#define AAS_DEFAULT_WEATHER 0			//Погода по умолчанию - 0 -чисто. 1 - штормовая (ваврьируется от 0 до 1)
#define AAS_DEFAULT_FOG 0				//Туман по умолчанию 0 чисто, 1 - сильнейший туман
#define AAS_DEFAULT_TIME_HOUR 12		//Время по умолчанию
#define AAS_DEFAULT_TIME_MINUTE 00		//Минуты по умолчанию
#define dst 600 						// Дистанция обзора в метрах
#define mzl 0.08							//Размер карты HUD  для примера - малые карты 0.1, средние - 0.2, большие 0.3 и больше

//Оставляем один из пунктов
//1_боты зеленка
/*
#define awu ["rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman_m590","rhsusf_usmc_marpat_wd_rifleman_law","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman_m4","rhsusf_usmc_marpat_wd_rifleman_m4","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman"]
#define aeu ["rhs_msv_emr_rifleman","rhs_msv_emr_efreitor","rhs_msv_emr_junior_sergeant","rhs_msv_emr_machinegunner","rhs_msv_emr_officer","rhs_msv_emr_arifleman","rhs_msv_emr_marksman","rhs_msv_emr_sergeant","rhs_msv_emr_RShG2","rhs_msv_emr_grenadier"]
*/
/*
//2_боты пески
#define awu ["rhsusf_usmc_recon_marpat_d_officer","rhsusf_usmc_recon_marpat_d_rifleman_fast","rhsusf_usmc_recon_marpat_d_marksman","rhsusf_usmc_marpat_d_grenadier","rhsusf_usmc_marpat_d_autorifleman","rhsusf_usmc_marpat_d_gunner","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_squadleader","rhsusf_usmc_marpat_d_fso","rhsusf_usmc_marpat_d_riflemanat"]
#define aeu ["rhs_vmf_recon_sergeant","rhs_vmf_recon_efreitor","rhs_vmf_recon_medic","rhs_vmf_recon_arifleman","rhs_vmf_recon_marksman","rhs_vmf_recon_rifleman_akms","rhs_vmf_recon_grenadier","rhs_vmf_recon_marksman_vss","rhs_vmf_rifleman_scout_akm","rhs_vmf_recon_rifleman_lat"]
*/

//3_боты партизаны GAL
#define awu ["rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman_m590","rhsusf_usmc_marpat_wd_rifleman_law","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman_m4","rhsusf_usmc_marpat_wd_rifleman_m4","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman"]
#define aeu ["rhsgref_nat_commander","rhsgref_nat_saboteur","rhsgref_nat_machinegunner","rhsgref_nat_medic","rhsgref_nat_rifleman_aks74","rhsgref_nat_rifleman_akms","rhsgref_nat_grinadier_rpg","rhsgref_nat_scout","rhsgref_nat_hunter","rhsgref_nat_grinadier"]

//Один из четырех наборов
//1_Набор правил "зеленка" (Черноруссия и подобнные) RULES_ZEL.sqf
//#define Rulchoice SETUP_ZEL
//2_Набор правил "пески" (Такистан и подобнные) RULES_PES.sqf
//#define Rulchoice SETUP_PES 
//3_Набор правил специально для Gunslingers RULES_GUNS.sqf
//#define Rulchoice SETUP_GUNS
//4_Набор правил специально для карт by [HA]Galactic RULES_GAL.sqf
#define Rulchoice SETUP_GAL 

#define boecgp true		// 1 рюкзак не положен (0 - боец)
#define macpso true		// 2
#define machgn true		// 3
#define sanit  true		// 4
#define remont true	    // 5
#define rshg   true		// 6
#define rpg7   false		// 7
#define ptrk1  false		// 8
#define tpod   true		// 9
#define agsm   false		// 10
#define Jav    false		// 11
#define pzrk1  false		// 12
#define snip   true		// 13
#define spez   true		// 14
#define saper  true		// 15
#define zavdv  true		// 16
#define opbpla false	 	// 17

//Кому рюкзак не положен. Если выключаем класс, соответственно надо изменить цифру

#define bpb ((playerClass==0) or (playerClass==1))






