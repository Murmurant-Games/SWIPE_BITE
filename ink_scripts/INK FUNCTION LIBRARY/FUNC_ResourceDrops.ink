// Resource drops
// [ ] - resources
// [ ] - containers
// [ ] - tiers

LIST interactables = (crate), (control_panel), (window), (survey_scanner)

VAR box = (item_name.exit)
VAR box_stuffer = (sardine, sword, trout)

// SUNRUNNER VARS
VAR box_tut = (multitool, sealant, vac_pump, emergency_kit, industrial_lubricant)


=== resourceGather
Gather Resources

+ Gather
    
-->DONE

=== openContainer(receiver_name)

+ [Take from {receiver_name}]
    <-scavengeWhat
+ [Add to {receiver_name}]    
    <- transferWhat
-->DONE

== scavengeWhat
    {not box:Nothing left to take. ->come_back_here}
    Take?
    <- PopulateOptions(-> scavenge, box)
    //<- PopulateOptions(-> Examine, BedroomExaminables)
    //->come_back_here

== scavenge(x)
    {x ? item_name.exit: ->come_back_here}
    You take {x}.
    ~ box -= x
    ~ inventory += x
    -> scavengeWhat
    --> come_back_here
    
=== function fill_box(ref container, source)
    ~ box = ()
    ~ box +=  source
    ~ box += item_name.exit

== transferWhat
    {not inventory:Nothing left to transfer. ->come_back_here}
    Transfer?
    <- PopulateOptions(-> transfer_to, inventory)
    //<- PopulateOptions(-> Examine, BedroomExaminables)
    //->come_back_here

== transfer_to(x)
    {x ? item_name.exit: ->come_back_here}
    You transfer {x}.
    ~ box += x
    ~ inventory -= x
    -> transferWhat
    --> come_back_here

