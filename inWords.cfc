
<cfcomponent output="false" mixin="controller">

	<cffunction name="init">
		<cfset this.version = "1.1.3">
		<cfreturn this>
	</cffunction>

	<cffunction name="timeAgoInWords" returntype="string" access="public" output="false">
		<cfargument name="fromTime" type="date" required="true" hint="See documentation for Date to compare from.">
		<cfargument name="lang" required="false" default="en" hint="Translate in that language. Using the ISO 639-1 language code.  See index.cfm for listing">

		<cfreturn inWordsTranslator(lang="#arguments.lang#", text="#core.timeAgoInWords(argumentCollection=arguments)#")>

	</cffunction>

	<cffunction name="timeUntilInWords" returntype="string" access="public" output="false">
		<cfargument name="toTime" type="date" required="true" hint="See documentation for Date to compare from.">
		<cfargument name="lang" required="false" default="en" hint="Translate in that language. Using the ISO 639-1 language code.  See index.cfm for listing">

		<cfreturn inWordsTranslator(lang="#arguments.lang#", text="#core.timeAgoInWords(argumentCollection=arguments)#")>

	</cffunction>

	<cffunction name="inWordsTranslator" returntype="string" access="public">

		<cfargument name="lang" required="false" default="en" hint="Translate in that language. Using the ISO 639-1 language code.  See index.cfm for listing">
		<cfargument name="text" required="true" hint="Text to translate">

		<cfset var loc = {}>

		<cfset loc.lang = "1"><!--- Default its english --->

		<cfif arguments.lang EQ "en">
			<cfreturn arguments.text>
		<cfelseif arguments.lang EQ "fr"><!--- French --->
			<cfset loc.lang = "1">
		<cfelseif arguments.lang EQ "nl"><!--- Dutch --->
			<cfset loc.lang = "2">				
		<cfelseif arguments.lang EQ "de"><!--- German --->
			<cfset loc.lang = "3">				
		</cfif>

		<cfset loc.value = arguments.text>

		<cfif ArrayIsEmpty(reMatch("\d+", loc.value))>
			<cfset loc.number[1] = "0">
		<cfelse>
			<cfset loc.number = reMatch("\d+", loc.value)>
		</cfif>

		<cfset loc.words = "less than a minute,1 minute,less than 5 seconds,less than 10 seconds,less than 20 seconds,half a minute,#loc.number[1]# minutes,about 1 hour,about #loc.number[1]# hours,1 day,#loc.number[1]# days,about 1 month,#loc.number[1]# months,about 1 year,over 1 year,almost 2 years,over #loc.number[1]# years">

		<cfset translations = ArrayNew(2)>

		<!--- translations[position of word in list][language] --->

		<cfset translations[1][1] = "moins d'une minute">
		<cfset translations[1][2] = "minder dan &eacute;&eacute;n minuut">
		<cfset translations[1][3] = "weniger als einer Minute">		

		<cfset translations[2][1] = "1 minute">
		<cfset translations[2][2] = "1 minuut">
		<cfset translations[2][3] = "1 Minute">		

		<cfset translations[3][1] = "moins de 5 secondes">
		<cfset translations[3][2] = "minder dan 5 seconden">
		<cfset translations[3][3] = "weniger als 5 Sekunden">		

		<cfset translations[4][1] = "moins de 10 secondes">
		<cfset translations[4][2] = "minder dan 10 seconden">
		<cfset translations[4][3] = "weniger als 10 Sekunden">		

		<cfset translations[5][1] = "moins de 20 secondes">
		<cfset translations[5][2] = "minder dan 20 seconden">
		<cfset translations[5][3] = "weniger als 20 Sekunden">		

		<cfset translations[6][1] = "30 secondes">
		<cfset translations[6][2] = "30 seconden">
		<cfset translations[6][3] = "einer halben Minute">		

		<cfset translations[7][1] = "#loc.number[1]# minutes">
		<cfset translations[7][2] = "#loc.number[1]# minuten">
		<cfset translations[7][3] = "#loc.number[1]# Minuten">		

		<cfset translations[8][1] = "environ 1 heure">
		<cfset translations[8][2] = "ongeveer 1 uur">
		<cfset translations[8][3] = "1 Stunde">		

		<cfset translations[9][1] = "environ #loc.number[1]# heures">
		<cfset translations[9][2] = "ongeveer #loc.number[1]# uren">
		<cfset translations[9][3] = "#loc.number[1]# Stunden">		

		<cfset translations[10][1] = "1 jour">
		<cfset translations[10][2] = "1 dag">
		<cfset translations[10][3] = "1 Tag">		

		<cfset translations[11][1] = "#loc.number[1]# jours">
		<cfset translations[11][2] = "#loc.number[1]# dagen">
		<cfset translations[11][3] = "#loc.number[1]# Tagen">		

		<cfset translations[12][1] = "environ 1 mois">
		<cfset translations[12][2] = "ongeveer 1 maand">
		<cfset translations[12][3] = "1 Monat">		

		<cfset translations[13][1] = "#loc.number[1]# mois">
		<cfset translations[13][2] = "#loc.number[1]# maanden">
		<cfset translations[13][3] = "#loc.number[1]# Monaten">		

		<cfset translations[14][1] = "environ 1 an">
		<cfset translations[14][2] = "ongeveer 1 jaar">
		<cfset translations[14][3] = "1 Jahr">		

		<cfset translations[15][1] = "plus d'un an">
		<cfset translations[15][2] = "meer dan &eacute;&eacute;n jaar">
		<cfset translations[15][3] = "&uuml;ber 1 Jahr">		

		<cfset translations[16][1] = "presque 2 ans">
		<cfset translations[16][2] = "bijna 2 jaar">
		<cfset translations[16][3] = "2 Jahren">		

		<cfset translations[17][1] = "plus de #loc.number[1]# ans">
		<cfset translations[17][2] = "meer dan #loc.number[1]# jaren">
		<cfset translations[17][3] = "mehr als #loc.number[1]# Jahren">		

		<cfset loc.returnValue = translations[listFind(loc.words,loc.value)][loc.lang]>

	<cfreturn loc.returnValue>

	</cffunction>

</cfcomponent>