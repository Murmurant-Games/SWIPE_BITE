INCLUDE INK FUNCTION LIBRARY/FUNC_essentials.ink
INCLUDE swipe_bite_syn.ink



VAR hunger = 5
VAR humanity = 10
VAR heat = 0
VAR health = 10

VAR sanity = 5
VAR security = 5

VAR nights_lasted = 0

VAR random_upper = 10
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
~ temp x = RANDOM(1, random_upper)
~ temp who = "nonone"

{ x:
    - 1:
        TASTY CIVILIAN #HEADER
        ~ normie_bio()
        <> #FLAVOR
        ~ who = "TASTY CIVILIAN"
    - 2:
        HUNTER #HEADER
        ~ hunter_bio()
        <> #FLAVOR
        ~ who = "HUNTER"
    - 3:
        MEGA DOUCHE #HEADER
        ~ douche_bio()
        <> #FLAVOR
        ~ who = "MEGA DOUCHE"
    - 4:
        PURE HEART #HEADER
        ~ innocent_bio()
        ~ who = "PURE HEART"
    - 5:
        USEFUL THRALL #HEADER
        ~ thrall_bio()
        <> #FLAVOR
        ~ who = "USEFUL THRALL"
        
    - 6:
        GYM BRO #HEADER
        ~ gym_bro_bio()
        <> #FLAVOR
        ~ who = "GYM BRO"
    - 7:
        FELLOW CRYPTID #HEADER
        ~ cryptid_bio()
        <> #FLAVOR
        ~ who = "FELLOW CRYPTID"        
    - 8:
        FORMER FLAME #HEADER
        
        <> #FLAVOR
        ~ who = "FORMER FLAME"   
    - 9:
        GOTH SCENESTER #HEADER
        
        <> #FLAVOR
        ~ who = "GOTH SCENESTER" 
    - 10:
        CHEATER #HEADER
        
        <> #FLAVOR
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

-> stat_adjust


== stat_adjust
    {hunger < 0:
        ~ hunger = 0
        }
    {humanity > 10:
        ~ humanity = 10
        }
    {heat < 0:
        ~ heat = 0
        }
    {health > 10:
        ~ health = 10
        }

->stat_display
        
== stat_display ==
NIGHT: {nights_lasted} ... HUNGER = {hunger} ... HEAT = {heat} ... HUMANITY = {humanity} #DN_print

-> win_lose_check

== win_lose_check
    {hunger > 10:
        -> hunger_ending
        }
    {humanity < 0:
        -> humanity_ending
        }
    {heat > 10:
        -> heat_ending
        }
    {health < 0:
        -> death_ending
        }
    {nights_lasted >= 20:
        -> survival_ending
        }

-> card_assembler


== encounters ==
YOU HAVE AN ENCOUNTER.
-> stat_display


== heat_ending
You have drawn too much attention. Hunters gather, the police investigate.
But it's the other vampires that get to you first.

-> EndDemo

== humanity_ending
You have lost all humanity.

-> EndDemo

== death_ending
What is dead cannot die. But it can stop moving. Except for when the wind stirs the ash of its remains.

-> EndDemo

== hunger_ending
The cold closes in and you start to tremble, something you haven't done since you turned. Perhaps this is a kind of victory, holding on to your humanity to the end.

-> EndDemo

== survival_ending

You lasted 10 days... survival is all that matters and you are a survivor.

-> EndDemo


== EndDemo ==


->END

=== function alter_stat(character, feed) ===
    { character:
        -"TASTY CIVILIAN":
            {feed:
                ~ alter(hunger,-1)
                ~ alter(heat,1)
                ~ alter(humanity,-1)
            - else:
                ~ alter(hunger,1)
                }
        -"PURE HEART":
            {feed:
                ~ alter(hunger,-1)
                ~ alter(humanity,-3)
                ~ alter(heat,1)
            - else:
                ~ alter(hunger,1)
                ~ alter(humanity,1)
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
                ~ alter(heat,0)
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
                ~ alter(hunger,-3)
                ~ alter(humanity,-1)
            - else:
                //~ alter(humanity,1)
                ~ alter(hunger,1)
                }
        - "FELLOW CRYPTID":
            {feed:
                ~ alter(heat,-1)
                ~ alter(hunger,0)
            - else:
                ~ alter(humanity,2)
                ~ alter(hunger,1)
                }
        - "FORMER FLAME":
            {feed:
                ~ alter(humanity,-3)
                ~ alter(hunger,-2)
                ~ alter(heat,2)
            - else:
                ~ alter(humanity,2)
                ~ alter(hunger,1)
                }   
        - "GOTH SCENESTER":
            {feed:
                ~ alter(humanity,1)
                ~ alter(hunger,-1)
                ~ alter(heat,0)
            - else:
                ~ alter(humanity,2)
                ~ alter(hunger,1)
                } 
        - "CHEATER":
            {feed:
                ~ alter(hunger,-2)
                ~ alter(heat,0)
            - else:
                ~ alter(hunger,2)
                }
                
    }
    



