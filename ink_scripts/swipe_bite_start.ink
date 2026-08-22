INCLUDE INK FUNCTION LIBRARY/FUNC_essentials.ink
INCLUDE swipe_bite_syn.ink
INCLUDE swipe_bite_variables.ink
INCLUDE swipe_bite_card_effects.ink


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

-> start

== start ==
GAME OPENING SCREEN etc.

{endings_reached:->choose_character->}


+ Play Game
-
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
+ [continue]
-
-> random_encounter


=== random_encounter ===

{LIST_COUNT(cards) == 0: -> dawn_comes}

~ temp who = ()

~ deal(who, cards)



->print_bio(who)->

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
NIGHT: {nights_lasted} ... HUNGER = {hunger} ... HEAT = {heat} ... HUMANITY = {humanity} #DN_print

-> random_encounter


== dawn_comes

~ nights_lasted ++
INCREASE COUNTER, RESET DECK # DN_print

~ endings_reached ++

~ cards += (douche, normie, cheater, hunter, innocent,gym_bro)

{hunters_avoided:
    - 1:
        ~ cards += (another_hunter)
    - 2:
        ~ cards += (another_hunter, experienced_hunter)
}

//, cryptid, vampire, (goth), former_flame, ghost, your_sire, detective, mortal_lover

-> win_lose_check

== encounter_happens ==
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

THE END

->END

== choose_character 
Choose Vampire:
    + Basic
    + Ancient One
    + Unavailable
    -
->->

