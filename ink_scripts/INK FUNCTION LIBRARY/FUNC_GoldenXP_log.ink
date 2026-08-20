VAR log_entries = ""

=== day_start
Another day begins. What to do? -> choice1

=choice1
+ Go to work
    I took the bus to the office.
    ~ log("I went to work.")
+ Stay at home
    I called in sick.
    ~ log("I stayed at home.")
+ Go to the park
    Life is short; I walked to the park.
    ~ log("I visited the park. Felt good.")
+ [Player: Open Log]
    ~ showLOG()
- The day has ended.
-> day_start // loop back to a new day

=== function showLOG()
[title]LOG[/title]
{log_entries} // Displays the string with all the log entries

=== function log(text)
~ log_entries = "[info side=highlight]{text}[/info]<br>" + log_entries