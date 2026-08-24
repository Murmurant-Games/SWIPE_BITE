
=== alter_stat(character, feed) ===
    { character:
        -normie:
            {feed:
                ~ alter(hunger,-1)
                ~ alter(heat,1)
                ~ alter(humanity,-1)
            - else:
                ~ alter(hunger,1)
                }
            
        -innocent:
            {feed:
                ~ alter(hunger,-1)
                ~ alter(humanity,-3)
                ~ alter(heat,1)
            - else:
                ~ alter(hunger,1)
                ~ alter(humanity,1)
                }
        -hunter:

            {feed:
                ~ alter(hunger,2)
                ~ alter(heat,-3)
                ~ hunters_avoided --
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,2)
                ~ hunters_avoided ++
                }
                
        -another_hunter:

            {feed:
                ~ alter(hunger,2)
                ~ alter(heat,-2)
                ~ hunters_avoided --
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,2)
                ~ hunters_avoided ++
                }  
        -experienced_hunter:

            {feed:
                ~ alter(hunger,2)
                ~ alter(heat,-2)
                ~ hunters_avoided --
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,2)
                //~ hunters_avoided ++
                }  
        -thrall:

            {feed:
                ~ alter(heat,0)
                ~ alter(hunger,-1)
                ~ alter(humanity,-2)
            - else:
                ~ alter(hunger,1)
                }       
        -douche:

            {feed:
                ~ alter(heat,2)
                ~ alter(hunger,-2)
                
            - else:
                //~ alter(humanity,1)
                ~ alter(hunger,1)
                }  
                
        - gym_bro: // MORE JUICE!

            {feed:
                ~ alter(heat,2)
                ~ alter(hunger,-3)
                ~ alter(humanity,-1)
            - else:
                //~ alter(humanity,1)
                ~ alter(hunger,1)
                }
        - cryptid:
            {feed:
                ~ alter(heat,-1)
                ~ alter(hunger,0)
            - else:
                ~ alter(humanity,2)
                ~ alter(hunger,1)
                }
        - former_flame:
            {feed:
                ~ alter(humanity,-3)
                ~ alter(hunger,-2)
                ~ alter(heat,2)
            - else:
                ~ alter(humanity,2)
                ~ alter(hunger,1)
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
    ->print_outcome(character, feed)->
    ->->
