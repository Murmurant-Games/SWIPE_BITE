//=== images_sorted
VAR akanaka_planet = "IMAGES/BANNERS/akanaka_pixel.png"



VAR imgNPC01 = "IMAGES/SPRITES/npc01sq.png"
VAR imgNPC02 = "IMAGES/SPRITES/npc02sq.png"
VAR imgNPC03 = "IMAGES/SPRITES/npc03sq.png"
VAR imgNPC04 = "IMAGES/SPRITES/npc04sq.png"
VAR imgNPC05 = "IMAGES/SPRITES/npc05sq.png"

VAR imgCHENW = "IMAGES/SPRITES/npc05sq.png"

// >>>>>>>> UNSORTED ICONS <<<<<<<<<<<
//=== icons_sorted
LIST image_index = img_hydroponics, img_soap, img_solar_system, img_tools

VAR imgFLAG = "IMAGES/ICONS/finish_flag_location.png"
VAR imgHYDROPONICS = "IMAGES/ICONS/agriculture_hand_plant_grow_nature.png"
VAR imgSOAP = "IMAGES/ICONS/bubble_bubbles_washing_cleaning_soap.png"
VAR imgSOLARSYSTEM = "IMAGES/ICONS/solar_system.png"
VAR imgSOLARSYSTEM_w ="IMAGES/ICONS/solar_system_white.png"
VAR imgTOOLS = "IMAGES/ICONS/wrench_screwdriver_tool_options.png"
VAR imgHUMAN = "IMAGES/ICONS/user_application_identity_authentication_login.png"
VAR imgINVEN = "IMAGES/ICONS/augmented_reality_vr_ar.png"
VAR imgTIME = "IMAGES/ICONS/app_wait_loading_sand_time.png"

//= "[img]IMAGES/ICONS/user_application_identity_authentication_login.png[/img]"

=== function portrait_(var)
{
-var == "npc01":
    ~ return imgNPC01
-var == "npc02":
    ~ return imgNPC02
-var == "npc03":
    ~ return imgNPC03
-var == "npc04":
    ~ return imgNPC04
-var == "npc05":
    ~ return imgNPC05
-else:
    ~ return "no image found"
}

=== function pic_(var,percent)
[picture width={percent}%]{var}[/picture]

/*
=== function inline_icon_sorter(var)
[img]<>
{
-var ? img_hydroponics:
    {imgHYDROPONICS}
-var ? img_soap:
    {imgSOAP}
-var ? img_solar_system:
    {imgSOLARSYSTEM}
-var ? img_tools:
    {imgTOOLS}
-else:
    no image found
}
<>[/img]
*/
