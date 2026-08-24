INCLUDE INK FUNCTION LIBRARY/FUNC_essentials.ink
INCLUDE swipe_bite_syn.ink
INCLUDE swipe_bite_variables.ink
INCLUDE swipe_bite_card_effects.ink
INCLUDE swipe_bite_endings.ink



VAR hunger = 5
VAR humanity = 10
VAR heat = 0
VAR health = 10

VAR sanity = 5
VAR security = 5

VAR nights_lasted = 0

VAR random_upper = 10

VAR next_card = ()

VAR endings_reached = 0

VAR hunters_avoided = 0

VAR cards_seen = 0

-> start

== start ==
GAME OPENING SCREEN etc.
 //❀ ⚸  👁 ❣🩸 ⚗ ⚱ N
->intro->
->play_menu

== play_menu
Play throughs: {endings_reached}

{endings_reached:->choose_character->}


+ Play Game
+ LOCK RANDOMISER
    ~ SEED_RANDOM(235)
-

~ hunger = 5
~ humanity = 10
~ heat = 0


The Night Begins... Your first...
    -> random_encounter

== intro
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
What are you?
+ Human
+ Vampire
-
->->


=== random_encounter ===

{LIST_COUNT(cards) == 0: -> dawn_comes}

~ temp who = ()

~ deal(who, cards)


NEXT:
->print_bio(who)->
~ cards_seen ++
+ FEED / FACE: {who} //RETURN TRUE
    -> alter_stat(who,true)->
+ SPARE / AVOID: {who} //RETURN FALSE
    -> alter_stat(who,false)->
-
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
NIGHT: {nights_lasted} CARDS SEEN: {cards_seen} #DN_print
... HUNGER: {hunger} HEAT: {heat} HUMANITY: {humanity} #DN_print

-> random_encounter


== dawn_comes

~ nights_lasted ++
NIGHT ENDS. INCREASE COUNTER, RESET DECK #DN_print

{  nights_lasted:
    - 1:
        ~ cards += (douche, normie, cheater, gym_bro)
    
    -2:
        ~ cards += (douche, normie, cheater, hunter, innocent, gym_bro, cryptid, former_flame)
    
        {hunters_avoided:
            - 1:
                ~ cards += (another_hunter)
            }
    }

//, cryptid, vampire, (goth), former_flame, ghost, your_sire, detective, mortal_lover

-> win_lose_check

== encounter_happens ==
YOU HAVE AN ENCOUNTER. # DN_print
-> stat_display


== choose_character 
Choose Vampire:
    + Basic
    + {heat_ending}Fatal Siren //(+1 Feed / +1 Heat)
    + {hunger_ending}Damned Searcher
    + {survival_ending}Young Sire
    + {humanity_ending}Ancient Horror
    -
->->
