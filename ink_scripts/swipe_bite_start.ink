INCLUDE INK FUNCTION LIBRARY/FUNC_essentials.ink


VAR hunger = 0
VAR humanity = 10
VAR heat = 0
VAR health = 10

VAR sanity = 5
VAR security = 5

VAR nights_lasted = 0

-> start

== start ==
GAME OPENING SCREEN etc.

+ Play Game
-
Memories of that night twist like sweat-soaked sheets. Flashes of acid clarity clashing with impossible visions. Shuddering under a scalding shower desperate to get warm. Bolting down raw meat, insatiably hungry.
+ [continue]
-
And the teeth.
+ [continue]
-
Standing in front of the mirror horrified and holding the tooth that had fallen past your lips, pushed by a curious tongue.
And your curious tongue pricked by the thorn that pushed through the gape.
+ [continue]
-
That's when you knew you weren't human anymore.
+ [continue]
-

->stat_display

--> card_assembler

->DONE


== card_assembler ==


-> random_encounter



=== random_encounter ===
~ temp x = RANDOM(1, 8)
~ temp who = "nonone"

{ x:
    - 1:
        TASTY CIVILIAN #HEADER #IMAGE:SPIKY_HAIR
        A total normie. #FLAVOR
        ~ who = "TASTY CIVILIAN"
    - 2:
        HUNTER #HEADER
        Buff but his eyes are haunted. He's not looking for a date, he's looking for revenge. #FLAVOR
        ~ who = "HUNTER"
    - 3:
        MEGA DOUCHE #HEADER
        His first message is a dick. #FLAVOR
        ~ who = "MEGA DOUCHE"
    - 4:
        PURE HEART #HEADER
        They have kind eyes. Too kind to survive in a world this cruel. Would it be kindness to spare them?
        ~ who = "PURE HEART"
    - 5:
        USEFUL THRALL #HEADER
        Handy with powertools. Capable of walking in sunlight. If he didn't have a service kink, he will soon. #FLAVOR
        ~ who = "USEFUL THRALL"
        
    - 6:
        GYM BRO #HEADER
        Those thick arms are nices. Especially the engorged veins wrapping them. #FLAVOR
        ~ who = "GYM BRO"
    - 7:
        FELLOW CRYPTID #HEADER
        Its smile is too feral. Its glittering skin too moist. That's not make up. #FLAVOR
        ~ who = "FELLOW CRYPTID"        
    - 8:
        FORMER FLAME #HEADER
        You've crossed paths before. Had a little fun before it fizzled. One of you ghosted the other. Now one is going to become a ghost. #FLAVOR
        ~ who = "FORMER FLAME"   
    - 20:
        ENCOUNTER
        ~ who = "ENCOUNTER"
}

-> yes_no(who)



== yes_no(who) ==
~ nights_lasted ++
{who == "ENCOUNTER": -> encounters}

+ FEED / FACE: {who} //RETURN TRUE
    ~ alter_stat(who,true)
+ SPARE / AVOID: {who} //RETURN FALSE
    ~ alter_stat(who,false)
-

->stat_display

== stat_display ==

NIGHT: {nights_lasted} ... HUNGER = {hunger} ... HEAT = {heat} ... HUMANITY = {humanity} #DN_print

CHECK WIN/LOSE CON / IF NONE LOOP #DN_print

-> card_assembler

== encounters ==

YOU HAVE AN ENCOUNTER.
-> stat_display

== EndDemo ==
YOU WIN!
->END

=== function alter_stat(character, feed) ===
    { character:
        -"TASTY CIVILIAN":
            {feed:
                ~ alter(hunger,-1)
                ~ alter(heat,1)
            - else:
                ~ alter(hunger,1)
                ~ alter(humanity,1)
                }
        -"PURE HEART":
            {feed:
                ~ alter(hunger,-1)
                ~ alter(humanity,-2)
            - else:
                ~ alter(hunger,1)
                ~ alter(humanity,2)
                }
        -"HUNTER":
            {feed:
                ~ alter(hunger,2)
                ~ alter(heat,-3)
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,2)
                }            
        -"USEFUL THRALL":
            {feed:
                ~ alter(heat,-1)
                ~ alter(hunger,-1)
                ~ alter(humanity,-2)
            - else:
                ~ alter(hunger,1)
                }       
        -"MEGA DOUCHE":
            {feed:
                ~ alter(heat,2)
                ~ alter(hunger,-2)
            - else:
                //~ alter(humanity,1)
                ~ alter(hunger,1)
                }  
        - "GYM BRO": // MORE JUICE!
            {feed:
                ~ alter(heat,2)
                ~ alter(hunger,-2)
            - else:
                //~ alter(humanity,1)
                ~ alter(hunger,1)
                }
        - "FELLOW CRYPTID":
            {feed:
                ~ alter(heat,2)
                ~ alter(hunger,-2)
            - else:
                //~ alter(humanity,1)
                ~ alter(hunger,1)
                }
        - "FORMER FLAME":
            {feed:
                ~ alter(heat,2)
                ~ alter(hunger,-2)
            - else:
                //~ alter(humanity,1)
                ~ alter(hunger,1)
                }   
    }


