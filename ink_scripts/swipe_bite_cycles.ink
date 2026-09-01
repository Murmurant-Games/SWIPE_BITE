

== win_lose_check
    {hunger > 10:
        -> hunger_ending
        }
    {hunger > 8:
        {once:
            - You are growing hungrier, maddeningly hungry. [warning]
                ->continue->
        }
        }
    {humanity < 0:
        -> humanity_ending
        }
    {humanity < 2:
        {once:
            - You are losing touch with you humanity. [warning]
        ->continue->
        }
        }
    {heat > 10:
        -> heat_ending
        }
    {heat > 8:
        {once:
            - You are drawing too much attention. [warning]
        ->continue->
        }
        }
    {nights_lasted >= 5:
        -> survival_ending
        }

-> random_encounter


== begin_end_cycle

~ nights_lasted ++

-

{  nights_lasted:
    - 1:
    
        Your first night hunting...
        ~ cards += (douche, normie, normie2, cheater, gym_bro)
        ->hunt
    -2:
        Your second night...
        ~ cards += (douche, normie, cheater, normie2, innocent, gym_bro, goth, former_flame)
            
    -3:
        Three nights...
        ~ cards += (douche, normie, cheater, hunter, handy_andy, innocent, goth, normie2)

    -else:
        You survive another night.
        ~ cards += (douche, normie, cheater, hunter, innocent, goth, gym_bro, cryptid, former_flame)
    
    }

    ~ cards += tomorrow_night
//, cryptid, vampire, (goth), former_flame, ghost, your_sire, detective, mortal_lover


<> It ends with {~an orange bruise of sunrise|an overcast sky|pouring rain soaking the streets|the smell of blood|pain|horror|hunger|exhaustion|a muffled scream}.[br][br]You sleep until {~the horrid eye of the sun closes and the silver, blind moon's is open|hunger wakes you|nightmares drive you from your bed|the pings of your phone can no longer be ignored|the howl of a cat wakes you}. [night]
-(hunt)
    ~ tomorrow_night = ()
+ [HUNT]
+ [HUNT]
-
-> win_lose_check

//== encounter_happens ==
//YOU HAVE AN ENCOUNTER. # DN_print
//-> stat_display
