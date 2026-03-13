extends Node

var scene_line = 0

# Goals

var goal_0 = ""

var goal_1 = "Go to the convenience store."

var goal_2 = "Speak to the convenience store clerk."

var goal_3 = "Look for something to help you communicate with the clerk."

var goal_4 = "Show the newspaper to the clerk."

var goal_5 = "Go to the bookstore."

var goal_6 = "Speak to Tanaka-sama."

var goal_7 = "Go to Vintage."

var goal_8 = "Look at the newspaper."

var goal_9 = "Compare your maps to figure out where Vintage is."

var goal_10 = "Go to the stationary store."

var goal_11 = "Speak to the stationary store clerk."

var goal_12 = "Fill out your notebook using items in the area to translate the note."

var goal_13 = "Find the person fitting the given description."

var goal_14 = "Speak to the police officer."

#var goals = [goal_0,goal_1,goal_2,goal_3,goal_4,goal_5,goal_6,goal_7,goal_8,goal_9,goal_10,goal_11,goal_12,goal_13,goal_14]

# Goals

# Speech type

var n = "narrator"

var t = "thought"

var s = "speech"

# Speech type

# Script

var speech_0 = [
	[n,"After a long flight you have finally arrived in Japan!",""],
	[n,"Since you’re here for a business meeting you don’t have much luggage with you, but you can use the luggage delivery service to get your bags delivered to your hotel!",""],
	[n,"Dropping off your luggage, you ensure you keep the essentials on you, including your notebook for notes during the work meeting and your passport.",""],
	[n,"Stepping out of the airport, you are greeted with a small shopping area. While flying into a rural airport was cheaper for your company, it does mean you are on a tight schedule. With your business meeting happening soon in Osaka you better not miss the train!",""],
	[n,"With a pep in your step, you take off towards the train station while excitedly taking in the sites.",""],
	[t,"Wow, this is such a cute little shopping area! I wish I had more time to explore.",""],
	[n,"On your way to the train, you spot a police officer asking other travelers to see their passports.",""],
	[t,"Okay! Good thing I remembered that you need to carry your passport around in Japan. Otherwise, I could be delayed or even detained.",""],
	[n,"Walking up slowly to the police officer, you start reaching for your passport.",""],
	[t,"My passport should be in my front pocket! …",""],
	[t,"Maybe it's in my back pocket?? …",""],
	[t,"Maybe it’s in my bag?!",""],
	[n,"You start frantically looking around for your passport.",""],
	[t,"I must have dropped it somewhere right? I know I grabbed it out of my luggage…",""],
	[s,"すみません。I saw something fall from your pocket earlier and I think someone else picked it up. Maybe you can check the convenience store? They could’ve dropped it off there.","Stranger"],
	[s,"Ah! Thank you!","You"],
	[n,"Crap, you need to get your passport back so you can get by the police officer before you miss your train!!",""]
	]

# Script
