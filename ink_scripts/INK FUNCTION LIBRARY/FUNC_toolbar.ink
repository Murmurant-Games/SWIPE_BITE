// BAND MANAGER GAME
=== function game_toolbar()
  //{DEBUG:[button=showDEBUG]🦗DEBUG[/button]}
  //{showToolbar:
    [button=showCrew]Crew[/button]
    [button=showInventory]Inventory[/button]
    [button=showTask]Tasks in Progress[/button]
    [button=showLOG]Activity Log[/button]

/*
  [button=showBand]🎸BAND[/button]
  [button=showCash]💸{printTourFund()}[/button]
  [button=showHeat]🔥HEAT[/button]
  [button=showDay]☀ DAY {days_sofar}[/button]
  [button=showActionPoints]🗲ACTIONS {action_points}[/button]
*/

=== function showTask()
[title]Tasks in Progress[/title]
{printPROGRESS(remove_insulation)}


=== function showInventory()
[title]Inventory[/title]
{narrate_list(inventory,"Nothing")}


=== function showCrew()
  [title]CREW[/title]
  Your crew is {narrate_list(crew, "only you.")}.

    
/*
  
=== function showBand()
  [title]🎸BAND[/title]
  //{band_name} is you and {listWithCommas(name(band), "no one else. Not really a band then")}.
    You sound {bandsound}.
    Your drive is {band_spirits}.

=== function showCash()
  [title]💸{printTourFund()}[/title]
  You have {printTourFund()} in your tour fund.
  
=== function showHeat()
    [title]🔥HEAT[/title]
    {band_name} sounds {bandsound}. Since this game is in development I haven't made a HEAT system. So there's just your band sound. You better not suck when you get to ShitFire Fest.
    [progress value={LIST_VALUE(bandsound)} min=1 max=5]Heat Progress {heat}/5[/progress]
    
=== function showDay()
[title]DAY {days_sofar}[/title]
It's been {days_sofar} days since you started the tour.

=== function showActionPoints()
[title]Action points remaining: {action_points}[/title]
You have {action_points} left for the day. {action_points>0: Spend them wisely.|Go to sleep.}

=== function showDEBUG
[title]🦗DEBUG[/title]
[button=addCurrency]Add {currency}1000[/button]
[button=addTestNPC]Add Test NPC[/button]

=== function addCurrency
    ~ tour_fund += 1000
*/