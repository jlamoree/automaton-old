<cfsilent>
	<cfset pageTitle = event.getValue("pageTitle", "")/>
	<cfif len(pageTitle)>
		<cfset pageTitle = getSetting("site").title & " : " & pageTitle/>
	<cfelse>
		<cfset pageTitle = getSetting("site").title/>
	</cfif>	
	<cfset release = getSetting("release")/>
	<cfset version = getSetting("version")/>
</cfsilent><cfcontent reset="true"/><!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta name="viewport" content="width=device-width"/>

	<cfoutput>
	<title>#pageTitle#</title>
	<link rel="stylesheet" media="screen" href="/css/style.css?v=#release#"/>
	<script src="/js/app.js?v=#release#"></script>
	</cfoutput>
</head>
<body>
	<cfoutput>
	<header>The Automaton</header>
	#renderView()#
	<footer>
		#getSetting("site").title# #getSetting("version")# r#release#
		<cfif structKeyExists(server, "railo")>
			on Railo #server.railo.version#
		<cfelseif structKeyExists(server, "bluedragon")>
			on Open BlueDragon #replace(server.bluedragon.productversion, ",", ".", "all")#
		<cfelseif structKeyExists(server, "coldfusion")>
			on Adobe ColdFusion #replace(server.coldfusion.productversion, ",", ".", "all")#
		</cfif>
	</footer>
	</cfoutput>
</body>
</html>