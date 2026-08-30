INCLUDE INK FUNCTION LIBRARY/FUNC_essentials.ink
INCLUDE swipe_bite_syn.ink
INCLUDE swipe_bite_variables.ink
INCLUDE swipe_bite_card_effects.ink
INCLUDE swipe_bite_endings.ink
INCLUDE swipe_bite_outcomes.ink
INCLUDE swipe_bite_cycles.ink
INCLUDE INK FUNCTION LIBRARY/FUNC_NameGenerator.ink


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
//GAME OPENING SCREEN etc. #DN_print
 //❀ ⚸  👁 ❣🩸 ⚗ ⚱ N
->intro->

->play_menu

== play_menu
//Play throughs: {endings_reached} #DN_print

{endings_reached:->choose_character->}


+ [Play Game]
//+ [LOCK RANDOMISER]
    //~ SEED_RANDOM(235)
-

~ hunger = 5
~ humanity = 10
~ heat = 0
~ nights_lasted = 0


    -> begin_end_cycle

== intro
Memories of that night twist like sweat-soaked sheets. Flashes of acid clarity clashing with impossible visions.

+ [The cold]
    Shuddering under a scalding shower desperate to get warm. 
+ [The hunger]
    Bolting down raw meat, insatiably hungry.
-
    <> [br][br]The horror of yourself in the mirror.
+ [Your teeth]
    Standing, holding the unrooted tooth that had fallen past your lips, pushed by a curious tongue that was then pricked by the gleaming fang that pushed through the gape.
+ [Your eyes]
    Standing, holding the unrooted tooth that had fallen past your lips, pushed by a curious tongue that was then pricked by the gleaming fang that pushed through the gape.
-

->continue->

-
That's when you knew you weren't human anymore. [br][br]What are you?
+ [I'm human] #+1 Hunger +1 Humanity
+ [I'm a vampire] #-1 Hunger -1 Humanity
-
->->


=== random_encounter ===
//The Night Begins.

{LIST_COUNT(cards) == 0: -> begin_end_cycle}

~ temp who = ()

~ deal(who, cards)


->print_lore(who)->

~ cards_seen ++

+ [FEED / FACE:] //RETURN TRUE
    -> alter_stat(who,true)->
    
    //-> outcomes(who,true)->
+ [SPARE / AVOID:] //RETURN FALSE
    -> alter_stat(who,false)->
    
    //-> outcomes(who,false)->
-
-> win_lose_check


== choose_character 
What are you?
    + [Newly Turned]
    + {heat_ending}[Fatal Siren]
    
    //(+1 Feed / +1 Heat) More Heat = More Power
    //+ {hunger_ending}[Damned Searcher] // Find a Cure
    //+ {survival_ending}[Young Sire] // Rise in Vampire Society
    //+ {humanity_ending}[Ancient Horror] // FEED & SLUMBER
    //+ {hunter_ending}[Apex Predator] 
        // Hunter of Hunters
    -
->->
