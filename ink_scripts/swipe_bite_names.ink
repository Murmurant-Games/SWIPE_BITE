/*
- [X] douche
- [X] normie
- [X] normie2
- [X] cheater
- [X] hunter
- [X] innocent
- [X] handy_andy
- [X] thrall
- [X] gym_bro
- [X] cryptid
- [X] vampire
- [X] goth
- [X] former_flame
- [X] ghost
- [ ] your_sire
- [ ] detective
- [X] mortal_lover
- [X] another_hunter
- [X] experienced_hunter
- [ ] bookworm
- [ ] nice_guy
- [ ] sleaze
- [ ] stalker
- [ ] priest
*/
== print_name(character)

    { character:
        -normie:
            ~ normie_name()
        -normie2:
            ~ normie_name()   
            
        -innocent:
            ~ innocent_name()
            
        -hunter:
            ~ hunter_name()
            
        -another_hunter:
            ~ hunter_name()
        
        -experienced_hunter:
            ~ hunter_name()
                      
        -handy_andy:
            ~ handy_andy_name()
            
        -thrall:
            ~ thrall_name() 
            
        -douche:
            ~ douche_name()
            
        - gym_bro: // MORE JUICE!
            ~ gym_bro_name()
           
        - cryptid:
            ~ cryptid_name()
           
        - former_flame:
            ~ former_flame_name()
          
        - goth:
            ~ goth_name()
        - ghost:
            ~ ghost_name()
            
        - mortal_lover:
            ~ mortal_lover_name()
            
        - cheater:
            ~ cheater_name()
        
        - vampire:
            ~ vampire_name()
        
        - else:
            MISSING
           
    }
    <> [title]
    
    // GENDER
    { character:
        -normie:
            m
            
        -normie2:
            m
            
        -innocent:
            f
            
        -hunter:
            m
                      
        -thrall:
            m
                 
        -douche:
            m
            
        - gym_bro: // MORE JUICE!
            m
            
        - cheater:
            m
        
        - else:
            nb
           
    }    
    <> [pronoun]
    ->->

    
=== function douche_name()
{~ Milf Hunter|Chad|Maxxx|Stubbie|Mike the Stud|Jimmy Bones|Hog Dog|The One|Fred|Mr D|Tongue Twister}

=== function normie_name()
{~ Martin |Jeff |Paul B| Mike|James M|James L|Marty|Tom|Thom|Tommy|Siv|Marlon|Khanya}

=== function cheater_name()
{~ Mystery Man|John Doe|Obvious Alias|Mr Bigshot|The Don}

=== function hunter_name()
{~ Hunter|Ranger|Van|Helsing|Snipes|Wesley|Blade|Buffy|Belmont}

=== function ghost_name()
{~ Echo|Spectre|Guilt|Furie}

=== function innocent_name()
{~ Gemma|Lily|Sunny|Wynona}

=== function handy_andy_name()
{~ Guy|Handy Andy|Fixit Fred|Wes|The Hammer}

=== function thrall_name()
{~ Yours|Only Yours|Slave|Thrall|Worthless|lowly worm}

=== function gym_bro_name()
{~ Big Boy|Buff n Bronze|Jordan|Jett|Django|Joe|Spotter} 

=== function cryptid_name()
{~ Fisher|Frog Friend|Slime Time|Human Person}

=== function vampire_name()
{~ Exekiel|Sinestra|Mordechai|Moloch|Master|Dark Mistress|The Impaler|Bat Man}

=== function goth_name()
{~ Esmerelda|Vampire Girl|Dark Poet|Shadowheart|Starlit Eyes|Nyx|Jewel|Ruby}

=== function mortal_lover_name()
The Lover

=== function former_flame_name()
{~ Mal|Sam|Jem|Sy}
