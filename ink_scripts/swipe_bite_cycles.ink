

== win_lose_check
    {hunger > hunger_end_trigger:
        -> hunger_ending
        }
    {hunger > hunger_end_trigger - hhh_warning_threshold:
        {once:
            - You are growing hungrier, maddeningly hungry. [warning]
                ->continue->
        }
        }
    {humanity < humanity_end_trigger:
        -> humanity_ending
        }
    {humanity < humanity_end_trigger + hhh_warning_threshold:
        {once:
            - You are losing touch with you humanity. [warning]
        ->continue->
        }
        }
    {heat > heat_end_trigger:
        -> heat_ending
        }
    {heat > heat_end_trigger - hhh_warning_threshold:
        {once:
            - You are drawing too much attention. [warning]
        ->continue->
        }
        }
    {nights_lasted >= survial_end_trigger:
        -> survival_ending
        }

-> random_encounter


== begin_end_cycle

~ nights_lasted ++

-

{  nights_lasted:
    - 1:
    
        You have opportunities tonight...
        ~ cards += (douche, normie, normie2, cheater, gym_bro)
        ->hunt
    -2:
        Your first night...
        ~ cards += (douche, normie, cheater, normie2, innocent, gym_bro, goth, former_flame)
            
    -3:
        Your second night...
        ~ cards += (douche, normie, cheater, hunter, handy_andy, innocent, goth, normie2)

    -else:
        You survived another night.
        ~ cards += (douche, normie, cheater, hunter, innocent, goth, gym_bro, cryptid, former_flame)
    
    }

    ~ cards += tomorrow_night
//, cryptid, vampire, (goth), former_flame, ghost, your_sire, detective, mortal_lover
    {hunger<1:
        ~ hunger = 1
    }

<> It ends with {~an orange bruise of sunrise|an overcast sky|pouring rain soaking the streets|the smell of blood|pain|horror|hunger|exhaustion|a muffled scream}.[br][br]You sleep until {~the horrid eye of the sun closes and the silver, blind moon's is open|hunger wakes you|nightmares drive you from your bed|the pings of your phone can no longer be ignored|the howl of a cat wakes you}.[br][br]You are hungry again. [night]
-(hunt)
    ~ tomorrow_night = ()
+ [HUNT]
+ [HUNT]
-
-> win_lose_check

//== encounter_happens ==
//YOU HAVE AN ENCOUNTER. # DN_print
//-> stat_display
