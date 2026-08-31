extends Node

var portraits_fem = [
[preload("res://art/portraits/FA_1.png"),
preload("res://art/portraits/FA_2.png"),
preload("res://art/portraits/FA_3.png"),
preload("res://art/portraits/FA_4.png"),
preload("res://art/portraits/FA_5.png")],

[preload("res://art/portraits/FB_1.png"),
preload("res://art/portraits/FB_2.png"),
preload("res://art/portraits/FB_3.png"),
preload("res://art/portraits/FB_4.png"),
preload("res://art/portraits/FB_5.png")],

[preload("res://art/portraits/FC_1.png"),
preload("res://art/portraits/FC_2.png"),
preload("res://art/portraits/FC_3.png"),
preload("res://art/portraits/FC_4.png"),
preload("res://art/portraits/FC_5.png")],

[preload("res://art/portraits/FD_1.png"),
preload("res://art/portraits/FD_2.png"),
preload("res://art/portraits/FD_3.png"),
preload("res://art/portraits/FD_4.png"),
preload("res://art/portraits/FD_5.png")],

[preload("res://art/portraits/FE_1.png"),
preload("res://art/portraits/FE_2.png"),
preload("res://art/portraits/FE_3.png"),
preload("res://art/portraits/FE_4.png"),
preload("res://art/portraits/FE_5.png")],

[preload("res://art/portraits/FF_1.png"),
preload("res://art/portraits/FF_2.png"),
preload("res://art/portraits/FF_3.png"),
preload("res://art/portraits/FF_4.png"),
preload("res://art/portraits/FF_5.png")],

[preload("res://art/portraits/FG_1.png"),
preload("res://art/portraits/FG_2.png"),
preload("res://art/portraits/FG_3.png"),
preload("res://art/portraits/FG_4.png"),
preload("res://art/portraits/FG_5.png")],

[preload("res://art/portraits/FH_1.png"),
preload("res://art/portraits/FH_2.png"),
preload("res://art/portraits/FH_3.png"),
preload("res://art/portraits/FH_4.png"),
preload("res://art/portraits/FH_5.png")],

[preload("res://art/portraits/FI_1.png"),
preload("res://art/portraits/FI_2.png"),
preload("res://art/portraits/FI_3.png"),
preload("res://art/portraits/FI_4.png"),
preload("res://art/portraits/FI_5.png")],

[preload("res://art/portraits/FJ_1.png"),
preload("res://art/portraits/FJ_2.png"),
preload("res://art/portraits/FJ_3.png"),
preload("res://art/portraits/FJ_4.png"),
preload("res://art/portraits/FJ_5.png")],

[preload("res://art/portraits/FK_1.png"),
preload("res://art/portraits/FK_2.png"),
preload("res://art/portraits/FK_3.png"),
preload("res://art/portraits/FK_4.png"),
preload("res://art/portraits/FK_5.png")],

[preload("res://art/portraits/FL_1.png"),
preload("res://art/portraits/FL_2.png"),
preload("res://art/portraits/FL_3.png"),
preload("res://art/portraits/FL_4.png"),
preload("res://art/portraits/FL_5.png")],

[preload("res://art/portraits/FM_1.png"),
preload("res://art/portraits/FM_2.png"),
preload("res://art/portraits/FM_3.png"),
preload("res://art/portraits/FM_4.png"),
preload("res://art/portraits/FM_5.png")],

[preload("res://art/portraits/FN_1.png"),
preload("res://art/portraits/FN_2.png"),
preload("res://art/portraits/FN_3.png"),
preload("res://art/portraits/FN_4.png"),
preload("res://art/portraits/FN_5.png")],

[preload("res://art/portraits/FO_1.png"),
preload("res://art/portraits/FO_2.png"),
preload("res://art/portraits/FO_3.png"),
preload("res://art/portraits/FO_4.png"),
preload("res://art/portraits/FO_5.png")],

[preload("res://art/portraits/FP_1.png"),
preload("res://art/portraits/FP_2.png"),
preload("res://art/portraits/FP_3.png"),
preload("res://art/portraits/FP_4.png"),
preload("res://art/portraits/FP_5.png")],
	
	
]
var portraits_masc = [
	
		[preload("res://art/portraits/MA_1.png"),
	preload("res://art/portraits/MA_2.png"),
	preload("res://art/portraits/MA_3.png"),
	preload("res://art/portraits/MA_4.png"),
	preload("res://art/portraits/MA_5.png")],

	[preload("res://art/portraits/MB_1.png"),
	preload("res://art/portraits/MB_2.png"),
	preload("res://art/portraits/MB_3.png"),
	preload("res://art/portraits/MB_4.png"),
	preload("res://art/portraits/MB_5.png")],

	[preload("res://art/portraits/MC_1.png"),
	preload("res://art/portraits/MC_2.png"),
	preload("res://art/portraits/MC_3.png"),
	preload("res://art/portraits/MC_4.png"),
	preload("res://art/portraits/MC_5.png")],

	[preload("res://art/portraits/MD_1.png"),
	preload("res://art/portraits/MD_2.png"),
	preload("res://art/portraits/MD_3.png"),
	preload("res://art/portraits/MD_4.png"),
	preload("res://art/portraits/MD_5.png")],

	[preload("res://art/portraits/ME_1.png"),
	preload("res://art/portraits/ME_2.png"),
	preload("res://art/portraits/ME_3.png"),
	preload("res://art/portraits/ME_4.png"),
	preload("res://art/portraits/ME_5.png")],

	[preload("res://art/portraits/MF_1.png"),
	preload("res://art/portraits/MF_2.png"),
	preload("res://art/portraits/MF_3.png"),
	preload("res://art/portraits/MF_4.png"),
	preload("res://art/portraits/MF_5.png")],

	[preload("res://art/portraits/MG_1.png"),
	preload("res://art/portraits/MG_2.png"),
	preload("res://art/portraits/MG_3.png"),
	preload("res://art/portraits/MG_4.png"),
	preload("res://art/portraits/MG_5.png")],

	[preload("res://art/portraits/MH_1.png"),
	preload("res://art/portraits/MH_2.png"),
	preload("res://art/portraits/MH_3.png"),
	preload("res://art/portraits/MH_4.png"),
	preload("res://art/portraits/MH_5.png")],

	[preload("res://art/portraits/MI_1.png"),
	preload("res://art/portraits/MI_2.png"),
	preload("res://art/portraits/MI_3.png"),
	preload("res://art/portraits/MI_4.png"),
	preload("res://art/portraits/MI_5.png")],

	[preload("res://art/portraits/MJ_1.png"),
	preload("res://art/portraits/MJ_2.png"),
	preload("res://art/portraits/MJ_3.png"),
	preload("res://art/portraits/MJ_4.png"),
	preload("res://art/portraits/MJ_5.png")],

	[preload("res://art/portraits/MK_1.png"),
	preload("res://art/portraits/MK_2.png"),
	preload("res://art/portraits/MK_3.png"),
	preload("res://art/portraits/MK_4.png"),
	preload("res://art/portraits/MK_5.png")],

	[preload("res://art/portraits/ML_1.png"),
	preload("res://art/portraits/ML_2.png"),
	preload("res://art/portraits/ML_3.png"),
	preload("res://art/portraits/ML_4.png"),
	preload("res://art/portraits/ML_5.png")],

	[preload("res://art/portraits/MM_1.png"),
	preload("res://art/portraits/MM_2.png"),
	preload("res://art/portraits/MM_3.png"),
	preload("res://art/portraits/MM_4.png"),
	preload("res://art/portraits/MM_5.png")],

	[preload("res://art/portraits/MN_1.png"),
	preload("res://art/portraits/MN_2.png"),
	preload("res://art/portraits/MN_3.png"),
	preload("res://art/portraits/MN_4.png"),
	preload("res://art/portraits/MN_5.png")],

	[preload("res://art/portraits/MO_1.png"),
	preload("res://art/portraits/MO_2.png"),
	preload("res://art/portraits/MO_3.png"),
	preload("res://art/portraits/MO_4.png"),
	preload("res://art/portraits/MO_5.png")],

	[preload("res://art/portraits/MP_1.png"),
	preload("res://art/portraits/MP_2.png"),
	preload("res://art/portraits/MP_3.png"),
	preload("res://art/portraits/MP_4.png"),
	preload("res://art/portraits/MP_5.png")],

	[preload("res://art/portraits/MQ_1.png"),
	preload("res://art/portraits/MQ_2.png"),
	preload("res://art/portraits/MQ_3.png"),
	preload("res://art/portraits/MQ_4.png"),
	preload("res://art/portraits/MQ_5.png")],

	[preload("res://art/portraits/MR_1.png"),
	preload("res://art/portraits/MR_2.png"),
	preload("res://art/portraits/MR_3.png"),
	preload("res://art/portraits/MR_4.png"),
	preload("res://art/portraits/MR_5.png")],

	[preload("res://art/portraits/MS_1.png"),
	preload("res://art/portraits/MS_2.png"),
	preload("res://art/portraits/MS_3.png"),
	preload("res://art/portraits/MS_4.png"),
	preload("res://art/portraits/MS_5.png")],

	[preload("res://art/portraits/MT_1.png"),
	preload("res://art/portraits/MT_2.png"),
	preload("res://art/portraits/MT_3.png"),
	preload("res://art/portraits/MT_4.png"),
	preload("res://art/portraits/MT_5.png")],

	[preload("res://art/portraits/MU_1.png"),
	preload("res://art/portraits/MU_2.png"),
	preload("res://art/portraits/MU_3.png"),
	preload("res://art/portraits/MU_4.png"),
	preload("res://art/portraits/MU_5.png")],

	[preload("res://art/portraits/MV_1.png"),
	preload("res://art/portraits/MV_2.png"),
	preload("res://art/portraits/MV_3.png"),
	preload("res://art/portraits/MV_4.png"),
	preload("res://art/portraits/MV_5.png")],

	[preload("res://art/portraits/MW_1.png"),
	preload("res://art/portraits/MW_2.png"),
	preload("res://art/portraits/MW_3.png"),
	preload("res://art/portraits/MW_4.png"),
	preload("res://art/portraits/MW_5.png")]
	
]

func get_portrait(pronoun : String = "nb"):
	pronoun = pronoun.to_lower()
	var portrait
	if pronoun.begins_with("m"):
		portrait = portraits_masc.pick_random()
	elif pronoun.begins_with("f"):
		portrait = portraits_fem.pick_random()
	else:
		if randf() > 0.5:
			portrait = portraits_masc.pick_random()
		else:
			portrait = portraits_fem.pick_random()
			
	var humanity_delta = Global.main.get_humanity_delta()
	var portrait_index = clamp(int((1.0 - humanity_delta) * 10 / 2), 0, 4)
	return portrait[portrait_index]
