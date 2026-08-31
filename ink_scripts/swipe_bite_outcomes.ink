/*

=== outcomes(character, feed) ===
{ character:
        -normie:
            {feed:
                He's as bland as expected.
            - else:
                Let him live ignorant of the excitement that would have killed him.
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
                You avoided the hunter... but he won't give up your trail.
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
                Proud of the marks you've left. You hope others will dismiss them as make-up.
            - else:
                You would disappoint a true fan.
                } 
        - cheater:
            {feed:
                No one knows he's here. He boasts he checked in under a fake name.
            - else:
                You're not hungry enoough for him. Yet.
                }
        
    }
    
    ->continue->
    ->->
    


== react_to_outcome(who)

+ [FEED / FACE:] //RETURN TRUE
    //-> alter_stat(who,true)->
    
+ [SPARE / AVOID:] //RETURN FALSE
    //-> alter_stat(who,false)->
-    
->->

== create_thrall

+ [ENTHRALL] //RETURN TRUE
    
    
+ [FEED] //RETURN FALSE
    //-> alter_stat(who,false)->
-    
->->
*/