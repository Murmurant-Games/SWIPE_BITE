
=== print_bio(character) ===
    { character:
        -normie:
            ~ normie_bio()
            
        -innocent:
            ~ innocent_bio()
            
        -hunter:
            ~ hunter_bio()
                      
        -thrall:
            ~ thrall_bio()
                 
        -douche:
            ~ douche_bio()
            
        - gym_bro: // MORE JUICE!
            ~ gym_bro_bio()
           
        - cryptid:
            ~ cryptid_bio()
           
        - former_flame:
            ~ former_flame_bio()
          
        - goth:
            ~ goth_bio()
            
        - cheater:
            ~ cheater_bio()
           
    }
    ->->


=== print_outcome(character, feed) ===
{ character:
        -normie:
            {feed:
                He's as bland as expected.
            - else:
                Let him live, ignorant of the excitement that would have killed him.
                }
        -innocent:
            {feed:
                She's enchanting. Immune to your glamour, she unmasks your pain.
            - else:
                Spare her. She doesn't need to know how monstrous the world is.
                }
        -hunter:

            {feed:
                He wasn't ready for your speed. But his holy water melted the skin from your arm.
            - else:
                You avoided the hunter... but he won't give up the trail.
                }
                
        -another_hunter:

            {feed:
                He wasn't ready for your speed. But his holy water melted the skin from your arm.
            - else:
                You avoided the hunter... but he won't give up the trail.
                }  
        -experienced_hunter:

            {feed:
                He wasn't ready for your speed. But his holy water melted the skin from your arm.
            - else:
                You avoided the hunter... but he won't give up the trail.
                }  
        -thrall:

            {feed:
                A little blood to bind them to your will. Now you have a servant.
            - else:
                The idea of making a slave repels your fraying humanity.
                }       
        -douche:

            {feed:
                You should feel guilt. Even for him. Even for him. Even for him. But you don't.
                
            - else:
                You let him pass by but your hunger is growing.
                }  
                
        - gym_bro: // MORE JUICE!

            {feed:
                Oh blooood - the STRENGTH you feel. The vitality!
            - else:
                You abstain, cautious.
                }
        - cryptid:
            {feed:
                Its blood is bitter, but dazzling. You spend the rest of the night tripping under the rippling refractions of its skin.
            - else:
                You avoid it, uneasy about what an encounter might entail.
                }
        - former_flame:
            {feed:
                Love and lust turned into frenzy. This was a mistake.
            - else:
                You don't want to feed on anyone you know. A rule you create.
                }   
        - goth:
            {feed:
                ~ alter(humanity,1)
                ~ alter(hunger,-1)
                ~ alter(heat,0)
            - else:
                ~ alter(humanity,2)
                ~ alter(hunger,1)
                } 
        - cheater:
            {feed:
                ~ alter(hunger,-2)
                ~ alter(heat,0)
            - else:
                ~ alter(hunger,2)
                }
                
    }
    ->->
    
=== function douche_bio()
{~ He's wearing a trucker cap backwards.|His fingers are knotted in a parody handsign.}
<> {~ An arm draped over a very drunk woman.|The fish he's holding has bulging, mad eyes.}
<> {~ His first message is a dick. Presumably his.|He sends you the eggplant emoji followed by several sprays of water.} #Douche

=== function normie_bio()
{~ Golf shirt and chinos.|Lite beer set in front of a mediocre sunset.}
<> {~ A photo of him mid-golf swing.|Smiling awkwardly in a badly cropped group shot.}
<> A total normie. #Normie

=== function cheater_bio()
{~ No face pics and he doesn't want to meet in public. That suits you fine.|Only in town for a few days. He texts the address of a hotel.} #Cheater


=== function hunter_bio()
{~ Buff but his eyes are haunted.| He's not looking for a date, he's looking for revenge.}
<> {~ The red flags you can't ignore.| } #Hunter

=== function another_hunter_bio()
{~ Buff but his eyes are haunted.| He's not looking for a date, he's looking for revenge.}
<> {~ The red flags you can't ignore.| } #Another Hunter

=== function experienced_hunter_bio()
{~ Buff but his eyes are haunted.| He's not looking for a date, he's looking for revenge.}
<> {~ The red flags you can't ignore.| } #Experienced Hunter

=== function innocent_bio()
{~ They have kind eyes.Too kind to survive in a world this cruel. Would it be kindness to spare them?|In one photo a bird is perched on her finger, she's smiling in pure delight.} #Innocent

=== function thrall_bio()
{~ Handy with powertools. |Capable of walking in sunlight.| If he didn't have a service kink, he will soon.} #Thrall


=== function gym_bro_bio()
{~ Those thick arms are nice. Especially the engorged veins wrapping them.|He'll taste like whey powder and sweat.} #Gym Bro


=== function cryptid_bio()
{~ Its smile is too feral. |Its glittering skin too moist. That's not make up.} #Cryptid

=== function vampire_bio()
{~ A glint of sharp teeth.|Silver skin and sipping red wine. Oh... not wine.} #Vampire

=== function goth_bio()
{~ They're excited to get bitten. You're not sure if they believe it's real or a kink thing.|A skinny body armored with black lace.} #Goth

=== function former_flame_bio()
{~ You've crossed paths before.|You two had a little fun before it fizzled.}
<> One of you ghosted the other. Now one of you is really going to become a ghost. #Former Flame
