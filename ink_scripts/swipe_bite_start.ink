INCLUDE INK FUNCTION LIBRARY/FUNC_essentials.ink


VAR hunger = 5
VAR humanity = 10
VAR heat = 0

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
        DOUCHE
        ~ who = "DOUCHE"
    - 4:
        PURE HEART
        ~ who = "PURE HEART"
    - 5:
        USEFUL THRALL
        ~ who = "USEFUL THRALL"
    - 6:
        ENCOUNTER
        ~ who = "ENCOUNTER"
}

-> yes_no(who)



== yes_no(who) ==
~ nights_lasted ++
{who == "ENCOUNTER": -> encounters}

+ YES to {who} //RETURN TRUE
    ~ alter_stat(who,true)
+ NO to {who} //RETURN FALSE
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

=== function alter_stat(character, bool) ===
    { character:
        -"TASTY CIVILIAN":
            {bool:
                ~ alter(hunger,-1)
                ~ alter(heat,1)
            - else:
                ~ alter(hunger,1)
                ~ alter(humanity,1)
                }
        -"PURE HEART":
            {bool:
                ~ alter(hunger,-1)
                ~ alter(humanity,-2)
            - else:
                ~ alter(hunger,1)
                ~ alter(humanity,2)
                }
        -"HUNTER":
            {bool:
                ~ alter(hunger,2)
                ~ alter(humanity,-1)
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,-2)
                }            
        -"USEFUL THRALL":
            {bool:
                ~ alter(heat,-1)
                ~ alter(hunger,-1)
                ~ alter(humanity,-2)
            - else:
                ~ alter(hunger,1)
                }       
        -"DOUCHE":
            {bool:
                ~ alter(heat,2)
                ~ alter(hunger,-2)
            - else:
                //~ alter(humanity,1)
                ~ alter(hunger,1)
                }  
    }


