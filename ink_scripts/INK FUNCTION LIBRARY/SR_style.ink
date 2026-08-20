===function Cass_(text)
    ~ talk_("npc04",text)

===function Jojo_(text)
    ~ talk_("npc02",text)
    
===function Vish_(text)
    ~ talk_("npc03",text)

===function Baracuda_(text)
    ~ talk_("npc01",text)
    
===function Chen_(text)
    ~ talk_("npc05",text)


===function talk_(npc,text)
    [block width=25%]
        <>[picture width=70%]{portrait_(npc)}[/picture]
    <>[/block]
    <>[block width=70% valign=top]
        <>[info side={colour_(npc)}]<b>{name_(npc)}</b><br>"{text}"
        <>[/info]
    <>[/block]

== function hover_(display_text,hover_text)
<span class="hovertext" data-hover="{imgNPC03}{hover_text}">{display_text}</span>




===function colour_(var)
{
-var == "npc01":
    ~ return "yellow"
-var == "npc02":
    ~ return "yellow"
-var == "npc03":
    ~ return "yellow"
-var == "npc04":
    ~ return "yellow"
-var == "npc05":
    ~ return "yellow"
-else:
    ~ return "white"
}    
    
===function name_(var)
{
-var == "npc01":
    ~ return "Baracuda"
-var == "npc02":
    ~ return "Jojo"
-var == "npc03":
    ~ return "Vish"
-var == "npc04":
    ~ return "Cassandra"
-var == "npc05":
    ~ return "Chenwick"
-else:
    ~ return "Anonymous"
} 

