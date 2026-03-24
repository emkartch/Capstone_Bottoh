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

var goal_7 = "Look around for Vintage."

var goal_8 = "Look at the newspaper."

var goal_9 = "Compare your maps to figure out where Vintage is."

var goal_10 = "Go to the stationary store."

var goal_11 = "Speak to the stationary store clerk."

var goal_12 = "Fill out your notebook using items in the area to translate the note."

var goal_13 = "Find the person fitting the given description."

var goal_14 = "Speak to the police officer."

var goal_15 = "Show the police officer your passport."

#var goals = [goal_0,goal_1,goal_2,goal_3,goal_4,goal_5,goal_6,goal_7,goal_8,goal_9,goal_10,goal_11,goal_12,goal_13,goal_14]

# Goals

# Speech type

var n = "narrator"

var t = "thought"

var s = "speech"

var q = "question"

var f = "followup"

var c = "check"

# Speech type

# Areas (Quest text first)

var speech_ClS = [
	[t,"The shop is closed, but maybe there is something on the promotion posters that can help me with translation?",""],[t,"Huh, it seems like the shop is closed. Maybe I should look somewhere else? Or I could look around outside…",""]
]

var speech_HS = [
	[t,"The shop is closed, but maybe that big poster about colors can help me with translation?",""],[t,"Huh, it seems like the shop is closed. Maybe I should look somewhere else? Or I could look around outside…",""]
]

var speech_BS = [
	[t,"The shop is closed, but maybe there is something on the posters about the haircuts they offer that can help me with translation?",""],[t,"Huh, it seems like the shop is closed. Maybe I should look somewhere else? Or I could look around outside…",""]
]

# Areas (Quest text first)

# Script

#	dialog.display_line(true,false,"question",["question",[[false,"Answer 1","Response 1"],[true,"Answer 2","Response 2"],[false,"Answer 3","Response 3"]]],"")

var speech_0 = [
	[n,"After a long flight you have finally arrived in Japan!",""],
	[n,"Since you’re here for a business meeting you don’t have much luggage with you, but you can use the luggage delivery service to get your bags delivered to your hotel!",""],
	[n,"Dropping off your luggage, you ensure you keep the essentials on you, including your passport and your notebook for notes during the work meeting.",""],
	null,
	[n,"Stepping out of the airport, you are greeted with a small shopping area.",""],
	[n,"While flying into a rural airport was cheaper for your company, it does mean you are on a tight schedule. With your business meeting happening soon in Osaka you better not miss the train!",""],
	[n,"With a pep in your step, you take off towards the train station while excitedly taking in the sites.",""],
	[t,"Wow, this is such a cute little shopping area! I wish I had more time to explore.",""],
	null,
	[n,"On your way to the train, you spot a police officer asking other travelers to see their passports.",""],
	[t,"Okay! Good thing I remembered that you need to carry your passport around in Japan. Otherwise, I could be delayed or even detained.",""],
	[n,"Walking up slowly to the police officer, you start reaching for your passport.",""],
	[t,"My passport should be in my front pocket! …",""],
	[t,"...",""],
	[t,"Maybe it's in my back pocket?? …",""],
	[t,"...",""],
	[t,"Maybe it’s in my bag?!",""],
	[n,"You start frantically looking around for your passport.",""],
	[t,"I must have dropped it somewhere right? I know I grabbed it out of my luggage…",""],
	null,
	[s,"すみません。I saw something fall from your pocket earlier and I think someone else picked it up. Maybe you can check the convenience store? They could’ve dropped it off there.","Stranger"],
	[s,"Ah! Thank you!","You"],
	[n,"Crap, you need to get your passport back so you can get by the police officer before you miss your train!!",""],
	null
]

var speech_1 = [
	[n,"Walking into the convenience store, you look around and notice no one else here aside from the clerk.",""],
	[t,"I supposed I should just talk to the clerk.",""],
	null
]

var speech_2 = [
	
	[s,"Excuse me? Has anyone come in with an American passport they found on the street?","You"],
	[s,"申し訳ありませんが、英語があまり話せません。","Convenience Store Clerk"],
	[t,"Hmm… Maybe there is something around here I can use to convey my question?",""],
	null
]

var speech_3 = [
	
	[t,"Ah-ha! There is a picture of a passport on the front. Maybe I can show this to the clerk?",""],
	null
]

var speech_4 = [
	
	[n,"Walking up to the clerk, you place the newspaper in front of them.",""],
	[s,"パスポートですか。","Convenience Store Clerk"],
	[q,["They still seem to be confused…",[[true,n,"Point at the photo of the passport and shrug.","You point at the photo of the passport, point at yourself, then look around like you lost something while shrugging."],[true,n,"Point at the photo of the passport, then mimic dropping it.","You point at the photo of the passport, point at yourself, then drop the newspaper on the floor."],[true,n,"Try to spell it out in writing.","You pull out your notebook, write down ‘dropped passport’, rip the piece of paper out, then place it on the counter in front of the clerk."]]],""],
	[n,"The clerk remains confused.",""],
	[f,[[t,"Maybe shrugging isn’t really a thing in Japan?","You point at the photo of the passport, point at yourself, then look around like you lost something while shrugging.",""],[n,"You pick the newspaper back up with a sigh.","You point at the photo of the passport, point at yourself, then drop the newspaper on the floor.",""],[t,"If they don’t understand spoken English, why would writing it be any different?","You pull out your notebook, write down ‘dropped passport’, rip the piece of paper out, then place it on the counter in front of the clerk.",""]],""],
	[n,"Out of ideas, you give it one last attempt.",""],
	[s,"My passport, I dropped it.","You"],
	[s,"Ah! Dropped passport?","Convenience Store Clerk"],
	[t,"Oh thank god…",""],
	[s,"Yes! Yes.","You"],
	[n,"The clerk turns around, picks up a piece of paper, and hands it over to you while gesturing at a location with an open palm.",""],
	[t,"Is pointing rude in Japan? Maybe I should also be gesturing with an open hand instead…",""],
	null,
	[t,"This seems to be a map of the nearby shops. Maybe they are saying they saw the person with my passport go to that bookstore?",""],
	[s,"Ask Tanaka-sama 野球帽をかぶっている人を見かけましたか。","Convenience Store Clerk"],
	[s,"野球帽をかぶっている人を見かけましたか。","You"],
	[n,"The convenience store clerk nods.",""],
	[t,"Okay, remember that, 野球帽をかぶっている人を見かけましたか。",""],
	[s,"Thank you!","You"],
	[t,"Wait, that’s one of the phrases I actually know in Japanese!",""],
	[s,"Uh..  I mean… ありがとうございます！","You"],
	null
]

var speech_5 = [
	[n,"Repeating the phrase from the convenience store clerk to yourself over and over, hoping you don’t get it wrong, you walk into the bookstore.",""],
	null
]

var speech_6 = [
	[t,"I should also be using the Japanese translation for excuse me, shouldn’t I?",""],
	[s,"Tanaka-sama? すみません...","You"],
	[q,["Wait, what did that clerk tell me to say?",[[true,s,"野球帽をかぶっている人を見かけましたか。","I think that’s it!"],[false,s,"ビーニーをかぶっている人を見かけましたか。","Wait… I don’t think that’s right…"],[false,s,"バケットハットをかぶっている人を見かけましたか。","Wait… I don’t think that’s right…"]]],""],
	[s,"ああ！あなたの日本語、すごく上手ですね！","Tanaka-sama"],
	[s,"Oh! No, no, I’m sorry, I don’t speak Japanese well…","You"],
	[s,"そうですね。","Tanaka-sama"],
	[n,"Tanaka-sama turns around, picks up a piece of paper, and hands it over to you. It looks similar to the map the convenience store clerk handed you earlier.",""],
	null,
	[t,"Is this the same map that the other clerk gave me? It looks older…",""],
	[s,"野球帽をかぶった人がVintageの方へ歩いていくのを見かけでした。","Tanaka-sama"],
	[n,"Tanaka-sama starts gesturing out to the right end of the street.",""],
	[s,"Vintage?","You"],
	[n,"Tanaka-sama nods her head.",""],
	[t,"Thankfully some Japanese stores have English names…",""],
	[s,"ありがとうございます！","You"],
	null
]

var speech_7 = [
	[t,"… wait. I don’t see a store named Vintage here…",""],
	[t,"Wasn’t something like it mentioned in that newspaper I picked up earlier?",""],
	null
]

var speech_8 = [
	[t,"It looks like that store was recently replaced with a different one, maybe the maps will have more information?",""],
	null
]

var speech_9 = [
	[t,"It seems like there is a brand new stationary store there!",""],
	null
]

var speech_10 = [
	[n,"Walking into the store, you try to remember the phrase the convenience store clerk helped you with earlier, maybe it can still help here?",""],
	null
]

var speech_11 = [
	[s,"すみません。野球帽をかぶっている人を見かけましたか。","You"],
	[n,"The clerk starts nodding their head.",""],
	[s,"はい、彼はちょうど出て行ったところです。","Stationary Store Clerk"],
	[s,"Um...","You"],
	[s,"Ah! Left.","Stationary Store Clerk"],
	[s,"Oh, they left??","You"],
	[s,"はい。彼らは背が高く、髪は短かったです。また、青いTシャツと野球帽を着ていました。","Stationary Store Clerk"],
	[s,"Uh...","You"],
	[n,"The stationary store clerk thinks for a moment, then turns around to write something down.",""],
	[n,"They hand a note to you.",""],
	[n,"The clerk gestures to the note, then to their eyes with their fingers.",""],
	[s,"This is what they look like?","You"],
	[s,"Yes! Look like.","Stationary Store Clerk"],
	[t,"Okay… well the note seems small enough.",""],
	[c,[[t,"Maybe I can use the information in my notebook to translate this note!",""],[t,"I’ve already found some basic Japanese translations from items around here, maybe there are more I can find?",""],[t,"I think I saw a children’s translation book at the bookstore earlier, maybe I can find translations for the rest of the words around here?",""]],""],
	[s,"ありがとうございます。","You"],
	null
]

var speech_12 = [speech_ClS,speech_HS,speech_BS]

var speech_13 = [
	[s,"すみません。Did you happen to pick up an American passport near the airport exit?","You"],
	[s,"What?","Baseball Cap Guy"],
	[n,"Hand going into his pocket, the guy produces two passports from his pocket.",""],
	[s,"Oh! My bad, I thought my own had fallen when I saw a passport on the floor. Here!","Baseball Cap Guy"],
	[s,"Thank you! I've been all over trying to find you. I didn't realize how hard it would be to communicate with people who don't speak the same language as me.","You"],
	[s,"It is hard to know how hard a language barrier can be when you've never had that problem.","Baseball Cap Guy"],
	[s,"You can't expect everyone you interact with to know English, but it's okay that you don't know Japanese very well. You are in the right place to learn, not only the language, but the culture too!","Baseball Cap Guy"],
	[s,"Yeah. Hopefully I can get better at this over time. Anyway, thank you! Uh... I mean… ありがとうございます！","You"],
	[n,"The guy bows and parts ways with you.",""],
	[t,"Maybe I should also bow after parting ways with strangers…",""],
	null
]

var speech_14 = [
	[s,"Passport please.","Police Officer"],
	null
]

var speech_15 = [
	[n,"After showing the police officer your passport, you take off to the train station to make the train to Osaka.",""],
	null
]

# Script

var fade_to_black_text = "Immersion is a big part of going to another country. There aren’t enough people that talk about the experience of full immersion in a country where you don’t speak the language. Many Americans expect visitors to communicate with English, but we want them to think about how that might be from another point of view. 

Next time you end up communicating with someone who may not speak the same language as you, remember, we are all humans. We can work together to communicate better than ever."

var credits = [
	[]
]
