
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
        -normie2:
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
                ~ alter(heat,-2)
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,1)
                ~ tomorrow_night += another_hunter
                }
                
        -another_hunter:

            {feed:
                ~ alter(hunger,2)
                ~ alter(heat,-2)
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,1)
                ~ tomorrow_night += experienced_hunter
                }  
        -experienced_hunter:

            {feed:
                ~ alter(hunger,2)
                ~ alter(heat,-3)
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,2)
                } 
                
        -handy_andy:

            {feed:
                ~ alter(hunger,-1)
                ~ alter(humanity,-2)
                ~ tomorrow_night += thrall
            - else:
                ~ alter(hunger,1)
                ~ tomorrow_night += handy_andy
                } 
                
        -thrall:

            {feed:
                ~ alter(hunger,-1)
                
            - else:
                ~ alter(hunger,1)
                ~ alter(heat,-1)
                ~ alter(humanity,-1)
                ~ tomorrow_night += thrall
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
                ~ tomorrow_night += ghost
            - else:
                ~ alter(humanity,2)
                ~ alter(hunger,1)
                ~ tomorrow_night += former_flame
                }   
        - goth:
            {feed:
                ~ alter(humanity,1)
                ~ alter(hunger,-1)
                ~ tomorrow_night += mortal_lover
            - else:
                ~ alter(humanity,-1)
                ~ alter(hunger,1)
                }
        - mortal_lover:
            {feed:
                ~ alter(humanity,1)
                ~ alter(hunger,-1)
                ~ tomorrow_night += mortal_lover
            - else:
                ~ alter(humanity,2)
                ~ alter(hunger,2)
                } 

                
        - ghost:
            {feed:
                ~ alter(humanity,2)
                ~ alter(hunger,0)
                ~ alter(heat,0)
            - else:
                ~ alter(humanity,-2)
                ~ alter(hunger,0)
                ~ tomorrow_night += ghost
                }
        - cheater:
            {feed:
                ~ alter(hunger,-2)
                ~ alter(heat,0)
            - else:
                ~ alter(hunger,2)
                }
        - else:
            NO EFFECT CODED
    }
    
    ->->
