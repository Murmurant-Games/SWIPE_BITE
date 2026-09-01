/*
- [X] douche
- [X] normie
- [X] normie2
- [X] cheater
- [X] hunter
- [X] innocent
- [X] thrall
- [X] gym_bro
- [X] cryptid
- [ ] vampire
- [X] goth
- [X] former_flame
- [ ] ghost
- [ ] your_sire
- [ ] detective
- [ ] your_mortal_lover
- [X] another_hunter
- [X] experienced_hunter
- [ ] bookworm
- [ ] nice_guy
- [ ] sleaze
- [ ] stalker
- [ ] priest
*/


== print_bio(character)
    
    { character:
        -normie:
            ~ normie_bio()
        -normie2:
            ~ normie_bio()
           
        -innocent:
            ~ innocent_bio()
            
        -hunter:
            ~ hunter_bio()
                      
        -another_hunter:
            ~ hunter_bio()
        
        -experienced_hunter:
            ~ hunter_bio()    
            
        -thrall:
            ~ thrall_bio()
        -handy_andy:
            ~ handy_andy_bio()                 
        -douche:
            ~ douche_bio()
            
        - gym_bro: // MORE JUICE!
            ~ gym_bro_bio()
           
        - cryptid:
            ~ cryptid_bio()
           
        - former_flame:
            ~ former_flame_bio()
        - mortal_lover:
            ~ mortal_lover_bio()  
        - goth:
            ~ goth_bio()
        
        - ghost:
            ~ ghost_bio()
            
        - cheater:
            ~ cheater_bio()
            
        - vampire:
            ~ vampire_bio()
        
        - else:
            MISSING           
    }
    <> [bio]
    ->->

    
=== function douche_bio()
{~ Mister Fuck-a-Round. Wanna find out!?|DTF y/n|Bros before Hos.[br][br]Except Fridays & Saturdays.|Call me Big Daddy if you a real Baddie.|Deb this is a fake profile.[br][br]if youre not deb hmu|High net worth investor. No gold diggers!|Relationship anarchist in the streets - also in the sheets.|No femi-nastys[br]No ------[br]No -----[br]No ----[br]Esp NO -----}

=== function normie_bio()
{~ I don't know what to write lol. Profiles are so hard, right?|Up for hikes, beers, deep chats.|Get to know me.[br][br]Please?|Just your average crypto investor looking for his "one".|Let's get coffee and talk about our medium to long-term goals.|Only swipe if you're looking for a long term relationship and you're a no-makeup 8 (minimum obviously)|Just out of a long term relationship. Looking for something casual but deep and committed.|More to me than football. But not a lot more.}

=== function cheater_bio()
{~ In town for one night only.|Discrete and worth it.|No face pic, no problem.|Straight to the hotel and I will blow your mind.|Luxury ladies only.|COD but the D stands for... DISCRETE! lol hmu if your mind went there.} 

=== function hunter_bio()
{~ Looking for something dangerous.|You can't hide from me.|I know what you are.|You're getting desperate. I'm getting closer.|You're the one I'm looking for.}

=== function innocent_bio()
{~ I like nice people.|I want to live a gentle life surrounded by love.|Make me a family recipe, I'll bake dessert.|Love animals, stars, unironically the beach.|Love: kindness, big brown eyes, exploring forests[br][br]Dislike: ...|Come with me to the gallery, the planetarium, the library.[br][br]Take me somewhere you love.|Controversial opinion: Sunrises are better than sunsets!}

=== function handy_andy_bio()
{~ Will put up your shelves in return for dinner.|Handy with tools. All kinds lol - no seriously I'm like a parody of a straight guy.[br][br]Except for the pegging.|Nothing hotter for me than doing YOUR chores.}

=== function thrall_bio()
{~ Anything. Anything. Anything.|Use me. Please.[br][br]I'm begging.|I need you. You are my everything. My moon. My stars. My life.}

=== function mortal_lover_bio()
{~ Only here for you, my love.|Only here for you, my love.}

=== function gym_bro_bio()
{~ Into squats deadlifts and paleo|My body is a temple and gym is my church and the workout is my bible and the protein shake is my priest|Every problem can be solved by sweat.[br][br]disclaimer: not a doctor|Looking for a lover who can deadlift me.|Let's hit the promenade circuit and see who has the lowest resting heart rate.|I've got big muscles but also a big heart and big brain.[br]Into workouts, bjj, wildlife rehabilitation and rogan.} 

=== function cryptid_bio()
{~ Human who loves human things.|Not a cryptid.|Hmu if u r into tentacles.|The only way to get over someone is to get them under a curse.[br][br]Service offered.}

=== function vampire_bio()
{~ Dead but delicious.|True beauty is eternal.|Night dates only.|Lover of dead languages. Among other things.|May I come over to your place?|Do you like hickeys?|Royal lineage only. NO SERFS!}

=== function goth_bio()
{~ Dark velvet and dark thoughts.|Reincarnated Mary Shelley if you must know.|I'm Carmilla, if she had a tumblr.|Former cat-girl. Current fixation. Future exquisite corpse.|I'm the opposite of "no-frills attached"|My relationship goals are Nick Cave. That's it. Only Nick Cave.}

=== function former_flame_bio()
{~ Feels like everyone has dated everyone already.|Still looking for the one. How about you?|People change.[br][br]It's me, I'm people.}

=== function ghost_bio()
{~ [pulse freq=1.0 color=red ease=-2.0]You killed me. You killed me. You killed me. You killed me.[pulse]|I can't leave.|[shake rate=10.0 level=5]Why did you choose me? Why did you why why why me why you me[/shake]}
