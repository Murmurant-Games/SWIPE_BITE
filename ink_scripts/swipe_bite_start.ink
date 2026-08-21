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

->stat_display

--> card_assembler

->DONE


== card_assembler ==


-> random_encounter



=== random_encounter ===
~ temp x = RANDOM(1, 5)
~ temp who = "nonone"

{ x:
    - 1:
        TASTY CIVILIAN
        ~ who = "TASTY CIVILIAN"
    - 2:
        HUNTER
        ~ who = "HUNTER"
    - 3:
        MEGA DOUCHE
        ~ who = "MEGA DOUCHE"
    - 4:
        PURE HEART
        ~ who = "PURE HEART"
    - 5:
        USEFUL THRALL
        ~ who = "USEFUL THRALL"
        
    - 6:
        GYM BRO // MORE JUICE!
        ~ who = "GYM BRO"
    - 7:
        FELLOW CRYPTID
        ~ who = "FELLOW CRYPTID"        
    - 8:
        FORMER FLAME
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

NIGHT: {nights_lasted}
HUNGER = {hunger} ... HEAT = {heat} ... HUMANITY = {humanity}

CHECK WIN/LOSE CON / IF NONE LOOP//-> END

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
    }


