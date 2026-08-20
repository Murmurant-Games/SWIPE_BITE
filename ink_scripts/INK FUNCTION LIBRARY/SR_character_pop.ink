LIST crew = (npc01), (npc02), npc03, (npc04), npc05, player


//mechanic, chemist, brawler, medic, programmer, systems

VAR varNPC01 = (npc01, mechanic)
VAR varNPC02 = (npc02, medic)
VAR varNPC03 = (npc03, chemist, brawler)
VAR varNPC04 = (npc04, systems)
VAR varNPC05 = (npc05, programmer)

//VAR crew = (npc01, npc02, npc03, npc04)

VAR Cass_pop = "Cass says..."
VAR Baracuda_pop = "Baracuda says..."
VAR Jojo_pop = "Jojo says..."
VAR Vish_pop = "Vish says..."
VAR Chen_pop = "Chenwick says..."

=== character_pop_gallery
[button=baracuda_overlay bordered=false]
    <>[img]
        <>{imgNPC01}
    <>[/img]
<>[/button]
<>[button=jojo_overlay bordered=false]
    <>[img]
        <>{imgNPC02}
    <>[/img]
<>[/button]
<>[button=Vish_overlay bordered=false]
    <>[img]
        <>{imgNPC03}
    <>[/img]
<>[/button]
<>[button=cass_overlay bordered=false]
    <>[img]
        <>{imgNPC04}
    <>[/img]
<>[/button]
{crew ? npc05:
<>[button=chen_overlay bordered=false]
    <>[img]
        <>{imgNPC05}
    <>[/img]
<>[/button]
}
<><pre></pre>#CLASS: biggest center
->->

=== function cass_overlay
[title]CASSANDRA[/title]
[picture width=40%]{imgNPC04}[/picture]#CLASS: center

[info]
    <>"{Cass_pop}"
<>[/info]



=== function Vish_overlay
[title]Vish[/title]
[picture width=40%]{imgNPC03}[/picture]#CLASS: center

[info]
    <>"{Vish_pop}"
<>[/info]

=== function jojo_overlay
[title]JOJO[/title]
[picture width=40%]{imgNPC02}[/picture]#CLASS: center

[info]
    <>"{Jojo_pop}"
<>[/info]

=== function baracuda_overlay
[title]BARACUDA[/title]
[picture width=40%]{imgNPC01}[/picture]#CLASS: center

[info]
    <>"{Baracuda_pop}"
<>[/info]

=== function chen_overlay
[title]CHENWICK[/title]
[picture width=40%]{imgNPC05}[/picture]#CLASS: center

[info]
    <>"{Chen_pop}"
<>[/info]

=== function magawa_overlay
[title]MAGAWA[/title]
[picture width=40%][/picture]#CLASS: center


Squeak squeak squeak sqeaaaaaaak!

=== function crate_overlay
[title]CRATE JUST CRATE[/title]
[picture width=40%][/picture]#CLASS: center


Beeep beep beep BEEP!
    
=== CHARACTER_REF
NPC 04  Cassandra, Hot Shot, femme, comms and electronics, selfish, 17
You may not like her at first, but she's got guts and that's impressive. She's got a few scars and some fresh injuries. But that just adds to her primal energy. Why does being wounded make her seem invulnerable? It's the absence of fear.

 NPC 02 Jojo, Himbo, masc, medic, dim, 20
 Every thought shows clear on his face. He's an open book, not that he's read any himself. He likes hearing ideas though, he listens rapt and smiling, happy to have the words going over his head. Also... those shoulders. Dayum.
 Sniffer rat.
 
NPC 03 Vish, Tomboy Mystery, non-binary, brawler, chemist,  18
 They've got something to prove, even though they've proved it again and again. Competent and in control, there's an edge there that says their life is an act of revenge for something. You want to know what, so you can join them.
 
NPC 01 Baracuda, Loner, masc, mech-eng, idealistic, 19
They do their part. No one ever sees them doing it - but it gets done. When you see them they're staring out across the barrens, usually somewhere up in the sail rigging. Impossible to reach. That's probably the point.

NPC 05 Chenwick, Non-binary, earth-born, programmer

-> DONE