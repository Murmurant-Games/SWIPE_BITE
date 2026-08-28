

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
    //{health < 0:
        //-> death_ending
        //}
    {nights_lasted >= 20:
        -> survival_ending
        }
/*
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
*/
-> random_encounter

== begin_end_cycle

~ nights_lasted ++
//NIGHT ENDS. INCREASE COUNTER, RESET DECK #DN_print

//A night ends.
//+ [Another begins]
-

{  nights_lasted:
    - 1:
        ~ cards += (douche, normie, cheater, gym_bro)
    
    -2:
        ~ cards += (douche, normie, cheater, hunter, innocent, gym_bro, cryptid, former_flame)
    
        {hunters_avoided:
            - 1:
                ~ cards += (another_hunter)
            }
            
    -3:
        ~ cards += (douche, normie, cheater, hunter, innocent, goth, gym_bro, cryptid, former_flame)
    
        {hunters_avoided:
            - 1:
                ~ cards += (another_hunter)
            - 2:
                ~ cards += (another_hunter,experienced_hunter)
            }
    -else:
        ~ cards += (douche, normie, cheater, hunter, innocent, goth, gym_bro, cryptid, former_flame)
    
        {hunters_avoided:
            - 1:
                ~ cards += (another_hunter)
            - 2:
                ~ cards += (another_hunter,experienced_hunter)
            }
    }

//, cryptid, vampire, (goth), former_flame, ghost, your_sire, detective, mortal_lover

A night ends with an orange bruise.[br][br]You sleep until the horrid eye of the sun closes and the silver, blind moon's is open.
+ [HUNT]
+ [HUNT]
-
-> win_lose_check

//== encounter_happens ==
//YOU HAVE AN ENCOUNTER. # DN_print
//-> stat_display
